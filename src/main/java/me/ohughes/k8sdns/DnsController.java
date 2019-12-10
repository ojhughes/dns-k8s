package me.ohughes.k8sdns;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestAttribute;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class DnsController {

	@GetMapping(path = "/", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<?> dnsDetails(@RequestAttribute String serviceName) {

		Map<String, String> dnsDetails = lookupDnsDetails();
		return new ResponseEntity<>(dnsDetails, HttpStatus.OK);
	}

	private Map<String, String> lookupDnsDetails() {
		Map<String, String> details = new HashMap<>();
		details.put("host", "something.something");
		return  details;
	}

}
