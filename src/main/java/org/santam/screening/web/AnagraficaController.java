package org.santam.screening.web;

import org.santam.screening.AnagraficaRepository;
import org.santam.screening.model.AnagraficaEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.data.web.PagedResourcesAssembler;
import org.springframework.hateoas.PagedResources;
import org.springframework.hateoas.Resource;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class AnagraficaController {

    @Autowired
    private AnagraficaRepository pazienti;

    @RequestMapping(value = "/anagrafica", produces = {MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE})
    public @ResponseBody
    PagedResources<Resource<AnagraficaEntity>> getAllPatients(@PageableDefault(size = 10) Pageable p, PagedResourcesAssembler<AnagraficaEntity> assembler) {
        return assembler.toResource(pazienti.findAll(p));
    }

    @RequestMapping(value = "/anagrafica", produces = MediaType.TEXT_HTML_VALUE)
    public String getAllPatientsView(@PageableDefault(size = 10) Pageable p, PagedResourcesAssembler<AnagraficaEntity> assembler, Model model){
        PagedResources<Resource<AnagraficaEntity>> pr = getAllPatients(p, assembler);
        model.addAttribute(pr);
        model.addAttribute("prevLink",pr.getPreviousLink()!=null?pr.getPreviousLink().getHref():"");
        model.addAttribute("nextLink",pr.getNextLink()!=null?pr.getNextLink().getHref():"");
        return "index";
    }
}
