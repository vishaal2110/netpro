/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Beans;

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
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Vishal
 */
@Entity
@Table(name = "option")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Option.findAll", query = "SELECT o FROM Option o")
    , @NamedQuery(name = "Option.findByOId", query = "SELECT o FROM Option o WHERE o.oId = :oId")
    , @NamedQuery(name = "Option.findByOptions", query = "SELECT o FROM Option o WHERE o.options = :options")})
public class Option implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "o_id")
    private Integer oId;
    @Basic(optional = false)
    @Column(name = "options")
    private String options;
    @JoinColumn(name = "question_id", referencedColumnName = "q_id")
    @ManyToOne(optional = false)
    private Question questionId;

    public Option() {
    }

    public Option(Integer oId) {
        this.oId = oId;
    }

    public Option(Integer oId, String options) {
        this.oId = oId;
        this.options = options;
    }

    public Integer getOId() {
        return oId;
    }

    public void setOId(Integer oId) {
        this.oId = oId;
    }

    public String getOptions() {
        return options;
    }

    public void setOptions(String options) {
        this.options = options;
    }

    public Question getQuestionId() {
        return questionId;
    }

    public void setQuestionId(Question questionId) {
        this.questionId = questionId;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (oId != null ? oId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Option)) {
            return false;
        }
        Option other = (Option) object;
        if ((this.oId == null && other.oId != null) || (this.oId != null && !this.oId.equals(other.oId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "Beans.Option[ oId=" + oId + " ]";
    }
    
}
