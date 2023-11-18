/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import dao.exceptions.NonexistentEntityException;
import dto.Libros;
import java.io.Serializable;
import javax.persistence.Query;
import javax.persistence.EntityNotFoundException;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import dto.Prestamos;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

/**
 *
 * @author ANGHELO
 */
public class LibrosJpaController implements Serializable {
    
    public LibrosJpaController(EntityManagerFactory emf) {
        this.emf = emf;
    }
    
    public LibrosJpaController() {
    }
    
    private EntityManagerFactory emf = Persistence.createEntityManagerFactory("com.mycompany_SistemaBiblioteca_war_1.0-SNAPSHOTPU");
    
    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }
    
    public void create(Libros libros) {
        if (libros.getPrestamosList() == null) {
            libros.setPrestamosList(new ArrayList<Prestamos>());
        }
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            List<Prestamos> attachedPrestamosList = new ArrayList<Prestamos>();
            for (Prestamos prestamosListPrestamosToAttach : libros.getPrestamosList()) {
                prestamosListPrestamosToAttach = em.getReference(prestamosListPrestamosToAttach.getClass(), prestamosListPrestamosToAttach.getCodiPres());
                attachedPrestamosList.add(prestamosListPrestamosToAttach);
            }
            libros.setPrestamosList(attachedPrestamosList);
            em.persist(libros);
            for (Prestamos prestamosListPrestamos : libros.getPrestamosList()) {
                Libros oldCodiLibOfPrestamosListPrestamos = prestamosListPrestamos.getCodiLib();
                prestamosListPrestamos.setCodiLib(libros);
                prestamosListPrestamos = em.merge(prestamosListPrestamos);
                if (oldCodiLibOfPrestamosListPrestamos != null) {
                    oldCodiLibOfPrestamosListPrestamos.getPrestamosList().remove(prestamosListPrestamos);
                    oldCodiLibOfPrestamosListPrestamos = em.merge(oldCodiLibOfPrestamosListPrestamos);
                }
            }
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }
    
    public void edit(Libros libros) throws NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Libros persistentLibros = em.find(Libros.class, libros.getCodiLib());
            List<Prestamos> prestamosListOld = persistentLibros.getPrestamosList();
            List<Prestamos> prestamosListNew = libros.getPrestamosList();
            List<Prestamos> attachedPrestamosListNew = new ArrayList<Prestamos>();
            for (Prestamos prestamosListNewPrestamosToAttach : prestamosListNew) {
                prestamosListNewPrestamosToAttach = em.getReference(prestamosListNewPrestamosToAttach.getClass(), prestamosListNewPrestamosToAttach.getCodiPres());
                attachedPrestamosListNew.add(prestamosListNewPrestamosToAttach);
            }
            prestamosListNew = attachedPrestamosListNew;
            libros.setPrestamosList(prestamosListNew);
            libros = em.merge(libros);
            for (Prestamos prestamosListOldPrestamos : prestamosListOld) {
                if (!prestamosListNew.contains(prestamosListOldPrestamos)) {
                    prestamosListOldPrestamos.setCodiLib(null);
                    prestamosListOldPrestamos = em.merge(prestamosListOldPrestamos);
                }
            }
            for (Prestamos prestamosListNewPrestamos : prestamosListNew) {
                if (!prestamosListOld.contains(prestamosListNewPrestamos)) {
                    Libros oldCodiLibOfPrestamosListNewPrestamos = prestamosListNewPrestamos.getCodiLib();
                    prestamosListNewPrestamos.setCodiLib(libros);
                    prestamosListNewPrestamos = em.merge(prestamosListNewPrestamos);
                    if (oldCodiLibOfPrestamosListNewPrestamos != null && !oldCodiLibOfPrestamosListNewPrestamos.equals(libros)) {
                        oldCodiLibOfPrestamosListNewPrestamos.getPrestamosList().remove(prestamosListNewPrestamos);
                        oldCodiLibOfPrestamosListNewPrestamos = em.merge(oldCodiLibOfPrestamosListNewPrestamos);
                    }
                }
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                Integer id = libros.getCodiLib();
                if (findLibros(id) == null) {
                    throw new NonexistentEntityException("The libros with id " + id + " no longer exists.");
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
            Libros libros;
            try {
                libros = em.getReference(Libros.class, id);
                libros.getCodiLib();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The libros with id " + id + " no longer exists.", enfe);
            }
            List<Prestamos> prestamosList = libros.getPrestamosList();
            for (Prestamos prestamosListPrestamos : prestamosList) {
                prestamosListPrestamos.setCodiLib(null);
                prestamosListPrestamos = em.merge(prestamosListPrestamos);
            }
            em.remove(libros);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }
    
    public List<Libros> findLibrosEntities() {
        return findLibrosEntities(true, -1, -1);
    }
    
    public List<Libros> findLibrosEntities(int maxResults, int firstResult) {
        return findLibrosEntities(false, maxResults, firstResult);
    }
    
    private List<Libros> findLibrosEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(Libros.class));
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
    
    public Libros findLibros(Integer id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Libros.class, id);
        } finally {
            em.close();
        }
    }
    
    public int getLibrosCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<Libros> rt = cq.from(Libros.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
    
}
