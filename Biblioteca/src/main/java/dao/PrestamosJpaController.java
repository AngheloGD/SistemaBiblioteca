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
import dto.Usuario;
import dto.Libros;
import dto.Prestamos;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

/**
 *
 * @author ANGHELO
 */
public class PrestamosJpaController implements Serializable {
    
    public PrestamosJpaController(EntityManagerFactory emf) {
        this.emf = emf;
    }
    
    public PrestamosJpaController() {
    }
    
    private EntityManagerFactory emf = Persistence.createEntityManagerFactory("com.mycompany_Biblioteca_war_1.0-SNAPSHOTPU");
    
    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }
    
    public void create(Prestamos prestamos) {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Usuario codiUsua = prestamos.getCodiUsua();
            if (codiUsua != null) {
                codiUsua = em.getReference(codiUsua.getClass(), codiUsua.getCodiUsua());
                prestamos.setCodiUsua(codiUsua);
            }
            Libros codiLib = prestamos.getCodiLib();
            if (codiLib != null) {
                codiLib = em.getReference(codiLib.getClass(), codiLib.getCodiLib());
                prestamos.setCodiLib(codiLib);
            }
            em.persist(prestamos);
            if (codiUsua != null) {
                codiUsua.getPrestamosList().add(prestamos);
                codiUsua = em.merge(codiUsua);
            }
            if (codiLib != null) {
                codiLib.getPrestamosList().add(prestamos);
                codiLib = em.merge(codiLib);
            }
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }
    
    public void edit(Prestamos prestamos) throws NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Prestamos persistentPrestamos = em.find(Prestamos.class, prestamos.getCodiPres());
            Usuario codiUsuaOld = persistentPrestamos.getCodiUsua();
            Usuario codiUsuaNew = prestamos.getCodiUsua();
            Libros codiLibOld = persistentPrestamos.getCodiLib();
            Libros codiLibNew = prestamos.getCodiLib();
            if (codiUsuaNew != null) {
                codiUsuaNew = em.getReference(codiUsuaNew.getClass(), codiUsuaNew.getCodiUsua());
                prestamos.setCodiUsua(codiUsuaNew);
            }
            if (codiLibNew != null) {
                codiLibNew = em.getReference(codiLibNew.getClass(), codiLibNew.getCodiLib());
                prestamos.setCodiLib(codiLibNew);
            }
            prestamos = em.merge(prestamos);
            if (codiUsuaOld != null && !codiUsuaOld.equals(codiUsuaNew)) {
                codiUsuaOld.getPrestamosList().remove(prestamos);
                codiUsuaOld = em.merge(codiUsuaOld);
            }
            if (codiUsuaNew != null && !codiUsuaNew.equals(codiUsuaOld)) {
                codiUsuaNew.getPrestamosList().add(prestamos);
                codiUsuaNew = em.merge(codiUsuaNew);
            }
            if (codiLibOld != null && !codiLibOld.equals(codiLibNew)) {
                codiLibOld.getPrestamosList().remove(prestamos);
                codiLibOld = em.merge(codiLibOld);
            }
            if (codiLibNew != null && !codiLibNew.equals(codiLibOld)) {
                codiLibNew.getPrestamosList().add(prestamos);
                codiLibNew = em.merge(codiLibNew);
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                Integer id = prestamos.getCodiPres();
                if (findPrestamos(id) == null) {
                    throw new NonexistentEntityException("The prestamos with id " + id + " no longer exists.");
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
            Prestamos prestamos;
            try {
                prestamos = em.getReference(Prestamos.class, id);
                prestamos.getCodiPres();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The prestamos with id " + id + " no longer exists.", enfe);
            }
            Usuario codiUsua = prestamos.getCodiUsua();
            if (codiUsua != null) {
                codiUsua.getPrestamosList().remove(prestamos);
                codiUsua = em.merge(codiUsua);
            }
            Libros codiLib = prestamos.getCodiLib();
            if (codiLib != null) {
                codiLib.getPrestamosList().remove(prestamos);
                codiLib = em.merge(codiLib);
            }
            em.remove(prestamos);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }
    
    public List<Prestamos> findPrestamosEntities() {
        return findPrestamosEntities(true, -1, -1);
    }
    
    public List<Prestamos> findPrestamosEntities(int maxResults, int firstResult) {
        return findPrestamosEntities(false, maxResults, firstResult);
    }
    
    private List<Prestamos> findPrestamosEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(Prestamos.class));
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
    
    public Prestamos findPrestamos(Integer id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Prestamos.class, id);
        } finally {
            em.close();
        }
    }
    
    public int getPrestamosCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<Prestamos> rt = cq.from(Prestamos.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
    
    public void registrarPrestamo(int codiUsua, int codiLib, String estado) {
        // Crear una nueva instancia de Prestamos
        Prestamos prestamo = new Prestamos();

        // Obtener las referencias a Usuario y Libros a través de sus IDs
        EntityManager em = getEntityManager();
        Usuario usuario = em.find(Usuario.class, codiUsua);
        Libros libro = em.find(Libros.class, codiLib);
        
        if (usuario != null && libro != null) {
            // Establecer el usuario y el libro en el préstamo
            prestamo.setCodiUsua(usuario);
            prestamo.setCodiLib(libro);

            // Establecer el estado del préstamo
            prestamo.setEstado(estado);

            // Ahora, puedes persistir el nuevo préstamo en la base de datos
            em.getTransaction().begin();
            em.persist(prestamo);
            em.getTransaction().commit();
        }
    }
    
    public List<Prestamos> mostrarprestamos() {
        EntityManager em = getEntityManager();
        try {
            Query q = em.createNamedQuery("Prestamos.findAll");
            return q.getResultList();
        } finally {
            em.close();
        }
    }
    
    public void eliminarPrestamo(int codiPres) {
        Prestamos tmp = new Prestamos();
        EntityManager em = getEntityManager();
        tmp = em.getReference(Prestamos.class, codiPres);
        em.getTransaction().begin();
        em.remove(tmp);
        em.getTransaction().commit();
    }
    
}
