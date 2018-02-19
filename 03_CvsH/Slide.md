# Container vs Hypervisor

## le due facce della stessa medaglia: pro, contro ed esempi d'uso

---

## VM e Container a confronto

![Vm vs Container](03_CvsH/img/containers-vms-together@2x.png)
<!-- .element height="90%" width="90%" -->

---

## Quando uso le VM

* Hardware da simulare<br>Es. <i>MAME is a multi-purpose emulation framework.</i>

* Software monolitico e fortemente interconnesso<br>Es. <i>GUI unita alla Business logic</i>

* Software GUI e Console esclusi quelli Web-based

* Software non scalabile

* Quando lo sforzo di Automazione delle Ops<br>produce un ROI negativo

Note: ROI = [Return on investment](https://it.wikipedia.org/wiki/Return_on_investment)

---

## Quando uso i Container

* Bounderies dei domini ben definiti

* Software cli-based su OS Linux o Windows

* Software su architettura Client/Server connessi attraverso Network TCP/IP

* Alta scalabilità e automazione dei processi Op

* Assenza di stato nei Container Applicativi, gli stati sono persistiti da altri elementi architetturali

---

## Deploy automatizzato di infrastrutture a VM

* Definizione di una _GoldenImage_ o _Template_ come iso base d'installazione

* Deploy automatico e personalizzazioni

<table>
  <tbody>
    <tr>
      <td style="center; vertical-align: middle;">
        <ul>
          <li>scripting</li>
          <li>juju</li>
          <li>Vagrant</li>
          <li>Ansible</li>
        </ul>
      </td>
      <td style="center; vertical-align: middle; width:500px;">
        <ul>
          <li>Puppet</li>
          <li>Chef</li>
          <li>Mesosphere DC/OS</li>
          <li>Kubernetes</li>
        </ul>
      </td>
    </tr>
  </tbody>
</table>

---

## Deploy automatizzato di infrastrutture a Container

### Scrivo un _docker-compose.yml_ 

Docker, _out-of-the-box_ si occupa di implementarlo.

---

## da _VM_ a _Container_ 
### richiede un po' di esercizio ed<br>un diverso approccio mentale.

* No Gestione Manuale!!! -> Lavoro che andrà perso!
* No Gestione Network!!! -> L'infrastruttura è autonoma in questo!
* No Configurazioni Arlecchino!!! -> Creano<br>_Single-Point-Of-Failure_!
* No Know-how Silos!!! -> Quando serve il<br>_Master-of-Know-how_ non si trova!

---