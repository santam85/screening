package org.santam.screening.web;

import org.apache.commons.lang3.text.WordUtils;
import org.santam.screening.model.Paziente;
import org.santam.screening.model.repositories.PazienteRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.data.web.PagedResourcesAssembler;
import org.springframework.hateoas.PagedResources;
import org.springframework.hateoas.Resource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.LinkedList;
import java.util.List;
import java.util.Locale;

@Controller
public class PazienteController {

    @Autowired
    private PazienteRepository pazienti;

    @Autowired
    private MessageSource messages;

    @ModelAttribute("title")
    private String title(Locale locale){
        return WordUtils.capitalizeFully(messages.getMessage("message.patients",null,locale));
    }

    @ModelAttribute
    private List<String> populateFoo(){
        LinkedList<String> strings = new LinkedList<>();
        strings.add("Oin");
        strings.add("Gloin");
        strings.add("Dori");
        strings.add("Nori");
        return strings;
    }

    @RequestMapping(value = "/paziente")
    public String getAllPatientsView(@PageableDefault(size = 10) Pageable p, PagedResourcesAssembler<Paziente> assembler, Model model){
        PagedResources<Resource<Paziente>> pr = assembler.toResource(pazienti.findAll(p));
        model.addAttribute(pr);

        model.addAttribute("prevLink",pr.getPreviousLink()!=null?pr.getPreviousLink().getHref():"");
        model.addAttribute("nextLink",pr.getNextLink()!=null?pr.getNextLink().getHref():"");

        return "paziente/list";
    }

    @RequestMapping(value = "/paziente/{id}")
    String getPazienteView(@PathVariable Integer id, Model model) {
        model.addAttribute("paziente", pazienti.findOne(id));
        return "paziente/detail";
    }
}
