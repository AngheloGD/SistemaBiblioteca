/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import dao.exceptions.NonexistentEntityException;
import java.io.Serializable;
import javax.persistence.Query;
import javax.persistence.EntityNotFoundException;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import dto.Prestamos;
import dto.Usuario;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

/**
 *
 * @author ANGHELO
 */
public class UsuarioJpaController implements Serializable {

    public UsuarioJpaController(EntityManagerFactory emf) {
        this.emf = emf;
    }

    public UsuarioJpaController() {
    }

    private EntityManagerFactory emf = Persistence.createEntityManagerFactory("com.mycompany_Biblioteca_war_1.0-SNAPSHOTPU");

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(Usuario usuario) {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            em.persist(usuario);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(Usuario usuario) throws NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Usuario persistentUsuario = em.find(Usuario.class, usuario.getCodiUsua());
            List<Prestamos> prestamosListOld = persistentUsuario.getPrestamosList();
            List<Prestamos> prestamosListNew = usuario.getPrestamosList();
            List<Prestamos> attachedPrestamosListNew = new ArrayList<Prestamos>();
            for (Prestamos prestamosListNewPrestamosToAttach : prestamosListNew) {
                prestamosListNewPrestamosToAttach = em.getReference(prestamosListNewPrestamosToAttach.getClass(), prestamosListNewPrestamosToAttach.getCodiPres());
                attachedPrestamosListNew.add(prestamosListNewPrestamosToAttach);
            }
            prestamosListNew = attachedPrestamosListNew;
            usuario.setPrestamosList(prestamosListNew);
            usuario = em.merge(usuario);
            for (Prestamos prestamosListOldPrestamos : prestamosListOld) {
                if (!prestamosListNew.contains(prestamosListOldPrestamos)) {
                    prestamosListOldPrestamos.setCodiUsua(null);
                    prestamosListOldPrestamos = em.merge(prestamosListOldPrestamos);
                }
            }
            for (Prestamos prestamosListNewPrestamos : prestamosListNew) {
                if (!prestamosListOld.contains(prestamosListNewPrestamos)) {
                    Usuario oldCodiUsuaOfPrestamosListNewPrestamos = prestamosListNewPrestamos.getCodiUsua();
                    prestamosListNewPrestamos.setCodiUsua(usuario);
                    prestamosListNewPrestamos = em.merge(prestamosListNewPrestamos);
                    if (oldCodiUsuaOfPrestamosListNewPrestamos != null && !oldCodiUsuaOfPrestamosListNewPrestamos.equals(usuario)) {
                        oldCodiUsuaOfPrestamosListNewPrestamos.getPrestamosList().remove(prestamosListNewPrestamos);
                        oldCodiUsuaOfPrestamosListNewPrestamos = em.merge(oldCodiUsuaOfPrestamosListNewPrestamos);
                    }
                }
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                Integer id = usuario.getCodiUsua();
                if (findUsuario(id) == null) {
                    throw new NonexistentEntityException("The usuario with id " + id + " no longer exists.");
                }
            }
            throw ex;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void destroy(Integer id) throws NonexistentEntityException {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Usuario usuario;
            try {
                usuario = em.getReference(Usuario.class, id);
                usuario.getCodiUsua();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The usuario with id " + id + " no longer exists.", enfe);
            }
            List<Prestamos> prestamosList = usuario.getPrestamosList();
            for (Prestamos prestamosListPrestamos : prestamosList) {
                prestamosListPrestamos.setCodiUsua(null);
                prestamosListPrestamos = em.merge(prestamosListPrestamos);
            }
            em.remove(usuario);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<Usuario> findUsuarioEntities() {
        return findUsuarioEntities(true, -1, -1);
    }

    public List<Usuario> findUsuarioEntities(int maxResults, int firstResult) {
        return findUsuarioEntities(false, maxResults, firstResult);
    }

    private List<Usuario> findUsuarioEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(Usuario.class));
            Query q = em.createQuery(cq);
            if (!all) {
                q.setMaxResults(maxResults);
                q.setFirstResult(firstResult);
            }
            return q.getResultList();
        } finally {
            em.close();
        }
    }

    public Usuario findUsuario(Integer id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Usuario.class, id);
        } finally {
            em.close();
        }
    }

    public int getUsuarioCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<Usuario> rt = cq.from(Usuario.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }

    public Usuario validar(String logiUsua, String passUsua, String roles) {
        EntityManager em = getEntityManager();
        try {
            Query q = em.createNamedQuery("Usuario.validar");
            q.setParameter("logiUsua", logiUsua);
            q.setParameter("passUsua", passUsua);
            q.setParameter("roles", roles);
            return (Usuario) q.getSingleResult();
        } catch (Exception e) {
            return null;
        } finally {
            em.close();
        }
    }

}
