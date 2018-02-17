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

<p style="color:DodgerBlue;">È la proprietà di un'operazione che applicata una o più volte non cambia il risultato prodotto.</p><p style="color:MediumSeaGreen;">L'applicazione multipla ed asincrona della funzione con questa proprietà non introduce collisioni o comportamenti non deterministici.</p>

Note: la copia di un file, se non modifico il sorgente quello che otterò sulla destinazione sarà lo stesso file o un fallimento dell'operazione.

---

## DevOps

<table>
  <tbody>
    <tr>
      <td style="center; vertical-align: middle;">
        <img src="01_IIID/img/Devops.svg"
             style="height:400px; width:400px; max-width: 300%; max-height: 300%;"
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

## Stato

Contenuto informativo temporaneo o persistente nell'artefatto che annulli la proprietà di <i style="color:DodgerBlue;">idempotenza</i>.
Per ripristinare la proprietà di <i style="color:DodgerBlue;">idempotenza</i>, l'artefatto delega ad elementi esterni la gestione dei propri stati.

---


