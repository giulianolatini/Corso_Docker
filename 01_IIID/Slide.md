# I.I.I.D.

## Infrastruttura, Isolamento, Idempotenza e DevOps

### i vantaggi e i vincoli della definizione formale di un'infrastruttura

---

## Infrastruttura

Insieme di materiale ed elementi singoli che collaborano a sostenere, produrre ed erogare beni e servizi. Nel mondo ICT sono hardware e/o artefatti software che collaborano per risolvere problemi complessi.

---

## Isolamento

Il concetto di <i style="color:Tomato;">Isolamento</i> dipende dalla definizione di due domini che chiameremo per convenzione <i style="color:MediumSeaGreen;">Interno</i> ed <i style="color:DodgerBlue;">Esterno</i> e dalla definizione di una superficie di separazione tra Interno ed Esterno chiamata per convenzione <i style="color:Orange;">Confine</i>. L'<i style="color:Tomato;">Isolamento</i> si applica sul <i style="color:Orange;">Confine</i> e condiziona lo scambio tra <i style="color:MediumSeaGreen;">Interno</i> ed <i style="color:DodgerBlue;">Esterno</i>.

---

## Idempotenza

<p style="color:DodgerBlue;">È la proprietà di un'operazione che applicata molteplici volte produce gli stessi risultati generati della sua singola applicazione.</p><p style="color:MediumSeaGreen;">L'applicazione multipla ed asincrona della funzione con questa proprietà non introduce collisioni o comportamenti non deterministici.</p>

Note: la copia di un file, se non modifico il sorgente quello che otterò sulla destinazione sarà lo stesso file o un fallimento dell'operazione.

---

## DevOps

<table>
  <tbody>
    <tr>
      <td style="center; vertical-align: middle;">
        <img src="01_IIID/img/Devops.svg"
             style="height:800px; width:400px; max-width: 300%; max-height: 300%;"
             alt="Graphics DevOps Origin">
      </td>
      <td style="center; vertical-align: middle; width:500px;">
        <blockquote>
          <p>Una completa automazione assicura la facile ripetibilità dei rilasci e riduce gli errori nell’operazione.</p>
        </blockquote>
      </td>
    </tr>
  </tbody>
</table>

---

## Le origini del termine _DevOps_

![Graphics DevOps Origin](01_Teoria/img/Devops.svg)
<!-- .element height="50%" width="50%" -->

---

## Definizione di _DevOps_

è un insieme di pratiche e tools in continua evoluzione che codificano i processi alla base delle<br>IT Operation, coprendo il service strategy,<br>il design e il supporto

---

## Definizione completa di _DevOps_

Il termine “DevOps” deriva dalla fusione di Developer e Operation, ed è una metodologia che sostiene intrinsecamente il rapporto di collaborazione che deve esistere tra il team di sviluppo e di IT operations. Lo scopo è realizzare un unico flusso di lavoro, che deve essere sia pianificato inizialmente, che rapido in ogni momento seguente.

---

## Formalizzare l'Infrastruttura

Uno dei impieghi degli strumenti _DevOps_ e focus per il team di Operation è costruire una rappresentazione formale dell'infrastruttura su cui poggerà il lavoro del team di Sviluppo. I vantaggi offerti dalla descrizione formale dell'infrastruttura sono:

* Conoscenza, Confidenza, Resilienza e Replicabilità;

* Definizione dei protocolli operativi e loro delega;

* Documentazione della fase di startup e delle fasi evolutive.

---

## Definizione di _Stato Desiderato_

Per _Stato Desiderato_ s'intende come obiettivo da raggiungere, ad esempio:

* la presenza di pacchetto software

* lo stato di esecuzione di un servizio

* l'esistenza di differenze tra una configurazione proposta e quella d'esercizio

---

## Caratteristiche del singolo automatismo

Le caratteristiche dell'operazione da eseguire sono:

* Idempotente => operazione che, se applicata una o più volte produce sempre lo stesso risultato (Es. 2+2=4)
* Atomica => l'operazione interviene su elementi unici e consistenti (Es. File di configurazione)
