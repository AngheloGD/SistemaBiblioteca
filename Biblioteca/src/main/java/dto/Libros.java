/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dto;

import java.io.Serializable;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author ANGHELO
 */
@Entity
@Table(name = "libros")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Libros.findAll", query = "SELECT l FROM Libros l"),
    @NamedQuery(name = "Libros.findByCodiLib", query = "SELECT l FROM Libros l WHERE l.codiLib = :codiLib"),
    @NamedQuery(name = "Libros.findByTituLib", query = "SELECT l FROM Libros l WHERE l.tituLib = :tituLib"),
    @NamedQuery(name = "Libros.findByAutoLib", query = "SELECT l FROM Libros l WHERE l.autoLib = :autoLib"),
    @NamedQuery(name = "Libros.findByGeneLib", query = "SELECT l FROM Libros l WHERE l.geneLib = :geneLib"),
    @NamedQuery(name = "Libros.findByNumCopiasDispo", query = "SELECT l FROM Libros l WHERE l.numCopiasDispo = :numCopiasDispo"),
    @NamedQuery(name = "Libros.findByNumCopiasPres", query = "SELECT l FROM Libros l WHERE l.numCopiasPres = :numCopiasPres")})
public class Libros implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "CodiLib")
    private Integer codiLib;
    @Size(max = 255)
    @Column(name = "tituLib")
    private String tituLib;
    @Size(max = 255)
    @Column(name = "autoLib")
    private String autoLib;
    @Size(max = 255)
    @Column(name = "geneLib")
    private String geneLib;
    @Column(name = "NumCopiasDispo")
    private Integer numCopiasDispo;
    @Column(name = "numCopiasPres")
    private Integer numCopiasPres;
    @OneToMany(mappedBy = "codiLib")
    private List<Prestamos> prestamosList;

    public Libros() {
    }

    public Libros(Integer codiLib) {
        this.codiLib = codiLib;
    }

    public Integer getCodiLib() {
        return codiLib;
    }

    public void setCodiLib(Integer codiLib) {
        this.codiLib = codiLib;
    }

    public String getTituLib() {
        return tituLib;
    }

    public void setTituLib(String tituLib) {
        this.tituLib = tituLib;
    }

    public String getAutoLib() {
        return autoLib;
    }

    public void setAutoLib(String autoLib) {
        this.autoLib = autoLib;
    }

    public String getGeneLib() {
        return geneLib;
    }

    public void setGeneLib(String geneLib) {
        this.geneLib = geneLib;
    }

    public Integer getNumCopiasDispo() {
        return numCopiasDispo;
    }

    public void setNumCopiasDispo(Integer numCopiasDispo) {
        this.numCopiasDispo = numCopiasDispo;
    }

    public Integer getNumCopiasPres() {
        return numCopiasPres;
    }

    public void setNumCopiasPres(Integer numCopiasPres) {
        this.numCopiasPres = numCopiasPres;
    }

    @XmlTransient
    public List<Prestamos> getPrestamosList() {
        return prestamosList;
    }

    public void setPrestamosList(List<Prestamos> prestamosList) {
        this.prestamosList = prestamosList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (codiLib != null ? codiLib.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Libros)) {
            return false;
        }
        Libros other = (Libros) object;
        if ((this.codiLib == null && other.codiLib != null) || (this.codiLib != null && !this.codiLib.equals(other.codiLib))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "dto.Libros[ codiLib=" + codiLib + " ]";
    }
    
}
