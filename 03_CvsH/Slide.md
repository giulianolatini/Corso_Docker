# Container vs Hypervisor

## le due facce della stessa medaglia: pro, contro ed esempi d'uso

---

## Quando uso le VM

* Hardware da simulare<br>Es. <i>MAME is a multi-purpose emulation framework.</i>

* Software monolitico e fortemente interconnesso<br>Es. <i>GUI unita alla Business logic</i>

* Software GUI e Console esclusi quelli Web-based

* Software non scalabile

* Quando lo sforzo di Automazione delle Op.<br>produce un ROI negativo

Note: ROI = [Return on investment](https://it.wikipedia.org/wiki/Return_on_investment)

---

## Quando uso i Container

* Bounderies dei domini ben definiti

* Software cli-based su OS Linux o Windows

* Software su architettura Client/Server connessi attraverso Network TCP/IP

* Alta scalabilità e automazione dei processi Op

* Assenza di stato nei worker applicativi, gli stati sono persistiti da altri elementi architetturali