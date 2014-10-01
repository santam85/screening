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
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.support.SessionStatus;

import javax.validation.Valid;
import java.util.LinkedList;
import java.util.List;
import java.util.Locale;

@Controller
@RequestMapping(value = "/paziente")
@SessionAttributes(types = Paziente.class)
public class PazienteController {

    @Autowired
    private PazienteRepository pazienti;

    @Autowired
    private MessageSource messages;

    @ModelAttribute("title")
    private String title(Locale locale){
        return WordUtils.capitalizeFully(messages.getMessage("message.patients",null,locale));
    }

    @ModelAttribute("allGenders")
    private List<String> populateGender(){
        LinkedList<String> strings = new LinkedList<>();
        strings.add("M");
        strings.add("F");
        return strings;
    }

    @RequestMapping(value = "")
    public String getAllPatientsView(@PageableDefault(size = 10) Pageable p, PagedResourcesAssembler<Paziente> assembler, Model model){
        PagedResources<Resource<Paziente>> pr = assembler.toResource(pazienti.findAll(p));
        model.addAttribute(pr);

        model.addAttribute("prevLink",pr.getPreviousLink()!=null?pr.getPreviousLink().getHref():"");
        model.addAttribute("nextLink",pr.getNextLink()!=null?pr.getNextLink().getHref():"");

        return "paziente/list";
    }

    @RequestMapping(value = "/{id}")
    String getPazienteView(@PathVariable Integer id, Model model) {
        model.addAttribute("paziente", pazienti.findOne(id));
        return "paziente/detail";
    }

    @RequestMapping(value = "/{id}/edit")
    String showPazienteForm(@PathVariable Integer id, Model model) {
        model.addAttribute("paziente", pazienti.findOne(id));
        return "paziente/edit";
    }

    @RequestMapping(value = "/{id}/edit", method = RequestMethod.POST)
    String editPaziente(@Valid Paziente paziente, BindingResult bindingResult, SessionStatus status) {
        if(bindingResult.hasErrors()){
            return "paziente/edit";
        }

        pazienti.save(paziente);
        status.setComplete();

        return "redirect:/paziente/{id}";
    }

    @RequestMapping(value = "/{id}/esami")
    String showPazienteEsami(@PathVariable Integer id) {
        return "redirect:/esame/search/searchByPaziente?paziente={id}";
    }
}
