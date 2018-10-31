# ds-security-Stemcell-Dashboard
Datadog Dashboard - PCF Stemcells

To Update the vulnerabilities update the vulnerabilities.json file.

Example:
```
{
  "tent-sla": {
    "sla": "SLA ≤ 7 Days",
    "color": "MediumSeaGreen"
  },
  "tent": {
    "vul1": "No known vulnerabilities"
  },
  "gdc-sla": {
    "sla": "SLA ≤ 7 Days",
    "color": "MediumSeaGreen"
  },
  "gdc": {
    "vul1": "USN-3522-2: Linux (Xenial HWE) vulnerability (This flaw is known as Meltdown.)",
    "vul2": "USN-3392-2: Linux kernel (Xenial HWE) regression",
    "vul3": "USN-3434-1: Libidn vulnerability",
    "vul4": "USN-3432-1: ca-certificates update",
    "vul5": "USN-3424-1: libxml2 vulnerabilities"
  },
  "pdc-sla": {
    "sla": "SLA ≤ 7 Days",
    "color": "MediumSeaGreen"
  },
  "pdc": {
    "vul1": "USN-3434-1: Libidn vulnerability",
    "vul2": "USN-3432-1: ca-certificates update",
    "vul3": "USN-3424-1: libxml2 vulnerabilities"
  }
}
```
***Modify the vul# list for each environment along with the SLA values ( ≤ update color value to MediumSeaGreen,  ≥ update color value to red)
