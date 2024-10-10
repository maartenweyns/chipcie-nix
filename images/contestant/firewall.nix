{ pkgs, lib, ... }:
let
  domjudge_url = "dj.ch.tudelft.nl";
in
{
  networking.proxy.default = "http://127.0.0.1:3128";
  networking.proxy.noProxy = "localhost,127.0.0.1";

  boot.kernelParams = [ "net.ipv4.ip_forward=1" "net.ipv6.conf.all.forwarding=1" "net.ipv4.conf.all.send_redirects=0" ];


  networking.nftables = {
    enable = true;
    # preCheckRuleset = "sed 's/skuid contestant/skuid nouser/g' -i ruleset.conf";
    checkRuleset = false;
    ruleset = ''
      #!/usr/sbin/nft -f

      # Define table and chains
      # table inet filter {
      #     chain input {
      #         # type filter hook input priority 0; policy drop;
      #
      #         # Allow incoming SSH
      #         tcp dport 22 accept
      #     }
      #
      #     chain output {
      #         type filter hook output priority 0; policy accept;
      #
      #         # Allow localhost communication for IntelliJ/Eclipse
      #         ip saddr 127.0.0.1 ip daddr 127.0.0.1 accept
      #
      #         # Allow DNS communication to 127.0.0.53
      #         ip saddr 127.0.0.1 ip daddr 127.0.0.53 accept
      #     }
      # }
      
      table inet nat {
        chain output {
          type nat hook output priority 100;
          ip protocol tcp meta skuid contestant tcp dport 80 redirect to :3128
          ip protocol tcp meta skuid contestant tcp dport 443 redirect to :3128

          ip6 protocol tcp meta skuid contestant tcp dport 80 redirect to :3128
          ip6 protocol tcp meta skuid contestant tcp dport 443 redirect to :3128
        }
      }
      # Disable logging
      # table inet filter {
      #     chain input {
      #         log level off 
      #     }
      # }

    '';
  };

  services.squid = {
    enable = true;
    configText = ''
      http_port 3128
      
      pid_filename /run/squid.pid

      cache_log       syslog
      access_log      stdio:/var/log/squid/access.log
      cache_store_log stdio:/var/log/squid/store.log

      cache_effective_user squid squid

      acl SSL_ports port 443
      acl Safe_ports port 8080
      acl Safe_ports port 80          # http
      acl Safe_ports port 21          # ftp
      acl Safe_ports port 443         # https
      acl Safe_ports port 70          # gopher
      acl Safe_ports port 210         # wais
      acl Safe_ports port 1025-65535  # unregistered ports
      acl Safe_ports port 280         # http-mgmt
      acl Safe_ports port 488         # gss-http
      acl Safe_ports port 591         # filemaker
      acl Safe_ports port 777         # multiling http
      acl CONNECT method CONNECT

      http_access deny !Safe_ports
      http_access deny CONNECT !SSL_ports

      #
      http_access deny manager
      # http_access allow all
      
      shutdown_lifetime 1 second

      acl allowed_urls dstdomain .${domjudge_url}
      acl allowed_urls dstdomain .hostnames.chipcie.ch.tudelft.nl
      acl allowed_urls dstdomain .pdns.chipcie.ch.tudelft.nl
      acl allowed_urls dstdomain .bing.com
      acl allowed_urls dstdomain localhost

      http_access allow allowed_urls
      http_access deny all

      deny_info http://localhost:8080/block.html all
    '';
  };
}
