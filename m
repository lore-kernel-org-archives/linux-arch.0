From: Johannes Weiner <hannes@saeurebad.de>
Subject: Re: [PATCH 02/20] lib: generic show_mem()
Date: Sat, 05 Jul 2008 11:29:29 +0000
Message-ID: <87hcb44lie.fsf@saeurebad.de>
References: <20080704160737.750988999@saeurebad.de>
	<20080704161452.730548249@saeurebad.de>
	<20080705083445.GA5454@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from saeurebad.de ([85.214.36.134]:47181 "EHLO saeurebad.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751496AbYGELbG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 5 Jul 2008 07:31:06 -0400
In-Reply-To: <20080705083445.GA5454@osiris.boeblingen.de.ibm.com> (Heiko
	Carstens's message of "Sat, 5 Jul 2008 10:34:45 +0200")
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

Hi,

Heiko Carstens <heiko.carstens@de.ibm.com> writes:

> On Fri, Jul 04, 2008 at 06:07:39PM +0200, Johannes Weiner wrote:
>> This implements a platform-independent version of show_mem().
>> 
>> Signed-off-by: Johannes Weiner <hannes@saeurebad.de>
>> ---
>>  lib/Makefile   |    2 -
>>  lib/show_mem.c |   63 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 64 insertions(+), 1 deletion(-)
>> 
>> --- a/lib/Makefile
>> +++ b/lib/Makefile
>> @@ -6,7 +6,7 @@ lib-y := ctype.o string.o vsprintf.o cmd
>>  	 rbtree.o radix-tree.o dump_stack.o \
>>  	 idr.o int_sqrt.o extable.o prio_tree.o \
>>  	 sha1.o irq_regs.o reciprocal_div.o argv_split.o \
>> -	 proportions.o prio_heap.o ratelimit.o
>> +	 proportions.o prio_heap.o ratelimit.o show_mem.o
>> 
>>  ifdef CONFIG_FTRACE
>>  # Do not profile string.o, since it may be used in early boot or vdso
>> --- /dev/null
>> +++ b/lib/show_mem.c
>> @@ -0,0 +1,63 @@
>> +/*
>> + * Generic show_mem() implementation
>> + *
>> + * Copyright (C) 2008 Johannes Weiner <hannes@saeurebad.de>
>> + * All code subject to the GPL version 2.
>> + */
>> +
>> +#include <linux/mm.h>
>> +#include <linux/nmi.h>
>> +#include <linux/quicklist.h>
>> +
>> +void show_mem(void)
>> +{
>
> Umh.. I think your 4th patch set was the way to go. This set is not
> bisectable anymore and those architectures which you didn't convert
> to the generic implementation won't build anymore. show_mem is present
> twice there...

hannes@skyscraper:/tmp/test$ gcc -o prog prog.c lib1.a lib2.a && ./prog
lib1
hannes@skyscraper:/tmp/test$ gcc -o prog prog.c lib2.a lib1.a && ./prog
lib2

Both lib1 and lib2 define foo() which prog calls.

I tested this with x86 and it built before and after removal of the
x86-specific show_mem() (and it did the right thing as the arch code has
higher priority than lib code).

But why is it no more bisectable?  You have one point where your kernel
uses the arch-specific show_mem() and in the next commit, you use the
generic version.  If something breaks, you can compare the old arch
version with the generic version.

> You might solve this by adding an __attribute__((weak)) but I'm sure
> people will complain again, because it produces dead code for all
> architectures which got converted.

Yeah, lib/show_mem.c is built in any case, which sucks a bit.

What do others think?  Would you prefer conditional code generation
about linking magic here?

	Hannes
