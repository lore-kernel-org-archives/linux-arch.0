From: =?us-ascii?Q?Michal=20Simek?= <Monstr@seznam.cz>
Subject: =?us-ascii?Q?Re=3A=20=5BPATCH=201=2F2=5D=20OF=3A=20clean=20coding=20style=20=2D=20prom=5Fparse=2Ec?=
Date: Sun, 04 May 2008 18:18:36 +0200 (CEST)
Message-ID: <4947.7670-30939-1615027563-1209917916@seznam.cz>
References: <481DDB99.2090209@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii";
	format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mxl.seznam.cz ([77.75.72.44]:44474 "EHLO mxl.seznam.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753021AbYEDQTS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 4 May 2008 12:19:18 -0400
In-Reply-To: <481DDB99.2090209@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: =?us-ascii?Q?Jiri=20Slaby?= <jirislaby@gmail.com>
Cc: =?us-ascii?Q?Joe=20Perches?= <joe@perches.com>, paulus@samba.org, arnd@arndb.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

Hi Jiri,

you are right. But the bugs comes from this patch http://lkml.org/lkml/2008/5/3/110.

For Paulus: Can you move these files? 

As wrote Joe. The best way will be to fix these files after moving.

Thanks,
Michal

> Hi All,
> 
> I fixed only part of coding style violation. Not all of them.

Actually, you introduced a bug. See:
http://lkml.org/lkml/2008/5/3/141

You should have used KERN_CONT, or even better sprintf and friends to be atomic

in logs.

> But you are right KERN_<level> is necessary.
> 
> For me is especially important to move these files from arch/powerpc to
drivers/of.
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
