/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dto;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author ANGHELO
 */
@Entity
@Table(name = "prestamos")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Prestamos.findAll", query = "SELECT p FROM Prestamos p"),
    @NamedQuery(name = "Prestamos.findByCodiPres", query = "SELECT p FROM Prestamos p WHERE p.codiPres = :codiPres"),
    @NamedQuery(name = "Prestamos.findByEstado", query = "SELECT p FROM Prestamos p WHERE p.estado = :estado")})
public class Prestamos implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "codiPres")
    private Integer codiPres;
    @Size(max = 255)
    @Column(name = "Estado")
    private String estado;
    @JoinColumn(name = "CodiUsua", referencedColumnName = "CodiUsua")
    @ManyToOne
    private Usuario codiUsua;
    @JoinColumn(name = "codiLib", referencedColumnName = "CodiLib")
    @ManyToOne
    private Libros codiLib;

    public Prestamos() {
    }

    public Prestamos(Integer codiPres) {
        this.codiPres = codiPres;
    }

    public Integer getCodiPres() {
        return codiPres;
    }

    public void setCodiPres(Integer codiPres) {
        this.codiPres = codiPres;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public Usuario getCodiUsua() {
        return codiUsua;
    }

    public void setCodiUsua(Usuario codiUsua) {
        this.codiUsua = codiUsua;
    }

    public Libros getCodiLib() {
        return codiLib;
    }

    public void setCodiLib(Libros codiLib) {
        this.codiLib = codiLib;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (codiPres != null ? codiPres.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Prestamos)) {
            return false;
        }
        Prestamos other = (Prestamos) object;
        if ((this.codiPres == null && other.codiPres != null) || (this.codiPres != null && !this.codiPres.equals(other.codiPres))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "dto.Prestamos[ codiPres=" + codiPres + " ]";
    }
    
}
