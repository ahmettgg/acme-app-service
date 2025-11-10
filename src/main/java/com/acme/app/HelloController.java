package com.acme.app;

import com.acme.shared.ClientUtil;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloController {

    @GetMapping("/hello")
    public String hello() {
        return ClientUtil.sayHello("ACME App Service");
    }
}
