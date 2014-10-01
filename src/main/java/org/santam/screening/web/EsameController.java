package org.santam.screening.web;

import org.santam.screening.model.Esame;
import org.santam.screening.model.Paziente;
import org.santam.screening.model.repositories.EsameRepository;
import org.santam.screening.model.repositories.PazienteRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.data.web.PagedResourcesAssembler;
import org.springframework.hateoas.PagedResources;
import org.springframework.hateoas.Resource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.support.SessionStatus;

import javax.validation.Valid;

@Controller
@RequestMapping(value = "/esame")
public class EsameController {

    @Autowired
    private EsameRepository esami;
    @Autowired
    private PazienteRepository pazienti;

    @RequestMapping(value = "")
    public String getAllEsamiView(@PageableDefault(size = 10) Pageable p, PagedResourcesAssembler<Esame> assembler, Model model){
        PagedResources<Resource<Esame>> pr = assembler.toResource(esami.findAll(p));
        model.addAttribute(pr);

        model.addAttribute("prevLink",pr.getPreviousLink()!=null?pr.getPreviousLink().getHref():"");
        model.addAttribute("nextLink",pr.getNextLink()!=null?pr.getNextLink().getHref():"");

        return "esame/list";
    }

    @RequestMapping(value = "/{id}")
    String getEsameView(@PathVariable Integer id, Model model) {
        model.addAttribute("paziente", esami.findOne(id));
        return "esame/detail";
    }

    @RequestMapping(value = "/{id}/edit")
    String showEsameForm(@PathVariable Integer id, Model model) {
        model.addAttribute("paziente", esami.findOne(id));
        return "esame/edit";
    }

    @RequestMapping(value = "/{id}/edit", method = RequestMethod.POST)
    String editEsame(@Valid Esame esame, BindingResult bindingResult, SessionStatus status) {
        if(bindingResult.hasErrors()){
            return "esame/edit";
        }

        esami.save(esame);
        status.setComplete();

        return "redirect:/esame/{id}";
    }

    @RequestMapping(value = "/search/searchByPaziente")
    String showEsamiForPaziente(@RequestParam("paziente") Paziente id, @PageableDefault(size = 10) Pageable p, PagedResourcesAssembler<Esame> assembler,  Model model) {
        PagedResources<Resource<Esame>> pr = assembler.toResource(esami.findByPaziente(id, p));
        model.addAttribute(pr);

        model.addAttribute("paziente",pazienti.findOne(id.getId()));

        model.addAttribute("prevLink",pr.getPreviousLink()!=null?pr.getPreviousLink().getHref():"");
        model.addAttribute("nextLink",pr.getNextLink()!=null?pr.getNextLink().getHref():"");

        return "esame/list";
    }
}
