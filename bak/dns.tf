provider "dnsimple" {
  token = "39fjie8fjdie8dcksuckdkdkdkmyslslslballs"
  account = "trumpie"
}

resource "dnsimple_record" "www" {
  domain = "proton.com" 
  type = "A"
  name = "mydomain"
  #value = "${aws_instance.web.0.public_ip}" 
  #value = "${element(aws_instance.web.*.public_ip, 0)}" 
  value = "${element(aws_instance.web.*.public_ip, count.index)}" 

}

