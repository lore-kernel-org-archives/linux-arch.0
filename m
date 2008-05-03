From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 1/2] OF: clean coding style - prom_parse.c
Date: Sat, 03 May 2008 10:26:22 -0700
Message-ID: <1209835583.16966.10.camel@localhost>
References: <monstr@seznam.cz>
	 <1209827626-8562-1-git-send-email-monstr@seznam.cz>
	 <c382f7ff87d1502c20423742ad738e50a118cf62.1209827449.git.monstr@monstr.eu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from 136-022.dsl.labridge.com ([206.117.136.22]:1167 "EHLO
	mail.perches.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1761868AbYECR1X (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 3 May 2008 13:27:23 -0400
In-Reply-To: <c382f7ff87d1502c20423742ad738e50a118cf62.1209827449.git.monstr@monstr.eu>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: monstr@seznam.cz
Cc: paulus@samba.org, arnd@arndb.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Michal Simek <monstr@monstr.eu>

On Sat, 2008-05-03 at 17:13 +0200, monstr@seznam.cz wrote:
>  /* Debug utility */
>  #ifdef DEBUG
>  static void of_dump_addr(const char *s, const u32 *addr, int na)
>  {
> -	printk("%s", s);
> -	while(na--)
> -		printk(" %08x", *(addr++));
> -	printk("\n");
> +	printk(KERN_INFO "%s", s);
> +	while (na--)
> +		printk(KERN_INFO " %08x", *(addr++));
> +	printk(KERN_INFO "\n");
>  }

You've prefixed KERN_INFO before every address block.

How about:

print_hex_dump(KERN_<level>, s, DUMP_PREFIX_NONE, 4, addr, na, false);
