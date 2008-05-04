From: Michal Simek <monstr@seznam.cz>
Subject: Re: [PATCH 1/2] OF: clean coding style - prom_parse.c
Date: Sun, 04 May 2008 10:17:34 +0200
Message-ID: <481D711E.6000003@seznam.cz>
References: <monstr@seznam.cz>	 <1209827626-8562-1-git-send-email-monstr@seznam.cz>	 <c382f7ff87d1502c20423742ad738e50a118cf62.1209827449.git.monstr@monstr.eu> <1209835583.16966.10.camel@localhost>
Reply-To: monstr@seznam.cz
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.wifiinternet.cz ([89.31.47.1]:51100 "EHLO
	bor.wifiinternet.cz" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752515AbYEDIQg (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 4 May 2008 04:16:36 -0400
In-Reply-To: <1209835583.16966.10.camel@localhost>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Joe Perches <joe@perches.com>
Cc: monstr@seznam.cz, paulus@samba.org, arnd@arndb.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

Hi All,

I fixed only part of coding style violation. Not all of them.

But you are right KERN_<level> is necessary.

For me is especially important to move these files from arch/powerpc to drivers/of.

M

>>  /* Debug utility */
>>  #ifdef DEBUG
>>  static void of_dump_addr(const char *s, const u32 *addr, int na)
>>  {
>> -	printk("%s", s);
>> -	while(na--)
>> -		printk(" %08x", *(addr++));
>> -	printk("\n");
>> +	printk(KERN_INFO "%s", s);
>> +	while (na--)
>> +		printk(KERN_INFO " %08x", *(addr++));
>> +	printk(KERN_INFO "\n");
>>  }
> 
> You've prefixed KERN_INFO before every address block.
> 
> How about:
> 
> print_hex_dump(KERN_<level>, s, DUMP_PREFIX_NONE, 4, addr, na, false);
> 
> 
