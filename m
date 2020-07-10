Return-Path: <SRS0=GDSS=AV=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mailgate-2.ics.forth.gr ([139.91.1.5]:51344 "EHLO
        mailgate-2.ics.forth.gr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbgGJHUs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 10 Jul 2020 03:20:48 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date: Fri, 10 Jul 2020 08:48:17 +0300
From: Nick Kossifidis <mick@ics.forth.gr>
Subject: Re: [PATCH 1/5] lib: Add a generic version of devmem_is_allowed()
In-Reply-To: <20200710053850.GA27019@infradead.org>
References: <20200709200552.1910298-1-palmer@dabbelt.com>
 <20200709200552.1910298-2-palmer@dabbelt.com>
 <20200709204921.GJ781326@linux.ibm.com>
 <20200710053850.GA27019@infradead.org>
Message-ID: <a037dac961c989d027eab293a0280643@mailhost.ics.forth.gr>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Mike Rapoport <rppt@linux.ibm.com>, mark.rutland@arm.com, steve@sk2.org, gregory.0xf0@gmail.com, catalin.marinas@arm.com, linus.walleij@linaro.org, Palmer Dabbelt <palmerdabbelt@google.com>, zaslonko@linux.ibm.com, glider@google.com, krzk@kernel.org, zong.li@sifive.com, mchehab+samsung@kernel.org, linux-riscv@lists.infradead.org, alex.shi@linux.alibaba.com, will@kernel.org, ardb@kernel.org, linux-arch@vger.kernel.org, paulmck@kernel.org, alex@ghiti.fr, bgolaszewski@baylibre.com, masahiroy@kernel.org, linux@armlinux.org.uk, willy@infradead.org, takahiro.akashi@linaro.org, james.morse@arm.com, kernel-team@android.com, Arnd Bergmann <arnd@arndb.de>, pmladek@suse.com, elver@google.com, aou@eecs.berkeley.edu, keescook@chromium.org, uwe@kleine-koenig.org, rostedt@goodmis.org, broonie@kernel.org, davidgow@google.com, Paul Walmsley <paul.walmsley@sifive.com>, dan.j.williams@intel.com, andriy.shevchenko@linux.intel.com, gxt@pku.edu.cn, linux-arm-kernel@lists.infradead.org, Nick Desaulniers <ndesaulniers@google.com>, tglx@linutronix.de, rdunlap@infradead.org, matti.vaittinen@fi.rohmeurope.com, linux-kernel@vger.kernel.org, mcgrof@kernel.org, Palmer Dabbelt <palmer@dabbelt.com>, mhiramat@kernel.org, akpm@linux-foundation.org, davem@davemloft.net
Message-ID: <20200710054817.YL03ebyRHBwblHIQXMDXW13wb5pDZVtD8mzzLTA55Zw@z>

Στις 2020-07-10 08:38, Christoph Hellwig έγραψε:
> On Thu, Jul 09, 2020 at 11:49:21PM +0300, Mike Rapoport wrote:
>> > +#ifndef CONFIG_GENERIC_DEVMEM_IS_ALLOWED
>> > +extern int devmem_is_allowed(unsigned long pfn);
>> > +#endif
> 
> Nit: no need for the extern here.
> 
>> > +config GENERIC_LIB_DEVMEM_IS_ALLOWED
>> > +	bool
>> > +	select ARCH_HAS_DEVMEM_IS_ALLOWED
>> 
>> This seems to work the other way around from the usual Kconfig chains.
>> In the most cases ARCH_HAS_SOMETHING selects GENERIC_SOMETHING.
>> 
>> I believe nicer way would be to make
>> 
>> config STRICT_DEVMEM
>> 	bool "Filter access to /dev/mem"
>> 	depends on MMU && DEVMEM
>> 	depends on ARCH_HAS_DEVMEM_IS_ALLOWED || 
>> GENERIC_LIB_DEVMEM_IS_ALLOWED
>> 
>> config GENERIC_LIB_DEVMEM_IS_ALLOWED
>> 	bool
>> 
>> and then s/select ARCH_HAS_DEVMEM_IS_ALLOWED/select 
>> GENERIC_LIB_DEVMEM_IS_ALLOWED/
>> in the arch Kconfigs and drop ARCH_HAS_DEVMEM_IS_ALLOWED in the end.
> 
> To take a step back:  Is there any reason to not just always
> STRICT_DEVMEM? Maybe for a few architectures that don't currently
> support a strict /dev/mem the generic version isn't quite correct, but
> someone selecting the option and finding the issue is the best way to
> figure that out..
> 

During prototyping / testing having full access to all physical memory 
through /dev/mem is very useful. We should have it enabled by default 
but leave the config option there so that users / developers can disable 
it if needed IMHO.
