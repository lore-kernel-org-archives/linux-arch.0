From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [PATCH 1/2] OF: clean coding style - prom_parse.c
Date: Sun, 04 May 2008 17:51:53 +0200
Message-ID: <481DDB99.2090209@gmail.com>
References: <monstr@seznam.cz>	 <1209827626-8562-1-git-send-email-monstr@seznam.cz>	 <c382f7ff87d1502c20423742ad738e50a118cf62.1209827449.git.monstr@monstr.eu> <1209835583.16966.10.camel@localhost> <481D711E.6000003@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.189]:43643 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752229AbYEDPwI (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 4 May 2008 11:52:08 -0400
Received: by fk-out-0910.google.com with SMTP id 18so334500fkq.5
        for <linux-arch@vger.kernel.org>; Sun, 04 May 2008 08:52:06 -0700 (PDT)
In-Reply-To: <481D711E.6000003@seznam.cz>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: monstr@seznam.cz
Cc: Joe Perches <joe@perches.com>, paulus@samba.org, arnd@arndb.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On 05/04/2008 10:17 AM, Michal Simek wrote:
> Hi All,
> 
> I fixed only part of coding style violation. Not all of them.

Actually, you introduced a bug. See:
http://lkml.org/lkml/2008/5/3/141

You should have used KERN_CONT, or even better sprintf and friends to be atomic 
in logs.

> But you are right KERN_<level> is necessary.
> 
> For me is especially important to move these files from arch/powerpc to drivers/of.
> 
> M
> 
>>>  /* Debug utility */
>>>  #ifdef DEBUG
>>>  static void of_dump_addr(const char *s, const u32 *addr, int na)
>>>  {
>>> -	printk("%s", s);
>>> -	while(na--)
>>> -		printk(" %08x", *(addr++));
>>> -	printk("\n");
>>> +	printk(KERN_INFO "%s", s);
>>> +	while (na--)
>>> +		printk(KERN_INFO " %08x", *(addr++));
>>> +	printk(KERN_INFO "\n");
>>>  }
>> You've prefixed KERN_INFO before every address block.
>>
>> How about:
>>
>> print_hex_dump(KERN_<level>, s, DUMP_PREFIX_NONE, 4, addr, na, false);
