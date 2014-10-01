package org.santam.screening.web;

import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by marco on 23/08/14.
 */
public class HomeController {
    @RequestMapping(value = {"","/"})
    public String getHome(){
        return "redirect:paziente/list";
    }
}
