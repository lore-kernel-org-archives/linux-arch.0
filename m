From: Nick Kossifidis <mick@ics.forth.gr>
Subject: Re: [PATCH 1/5] lib: Add a generic version of devmem_is_allowed()
Date: Fri, 10 Jul 2020 08:48:17 +0300
Message-ID: <a037dac961c989d027eab293a0280643@mailhost.ics.forth.gr>
References: <20200709200552.1910298-1-palmer@dabbelt.com>
 <20200709200552.1910298-2-palmer@dabbelt.com>
 <20200709204921.GJ781326@linux.ibm.com>
 <20200710053850.GA27019@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200710053850.GA27019@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Mike Rapoport <rppt@linux.ibm.com>, mark.rutland@arm.com, steve@sk2.org, gregory.0xf0@gmail.com, catalin.marinas@arm.com, linus.walleij@linaro.org, Palmer Dabbelt <palmerdabbelt@google.com>, zaslonko@linux.ibm.com, glider@google.com, krzk@kernel.org, zong.li@sifive.com, mchehab+samsung@kernel.org, linux-riscv@lists.infradead.org, alex.shi@linux.alibaba.com, will@kernel.org, ardb@kernel.org, linux-arch@vger.kernel.org, paulmck@kernel.org, alex@ghiti.fr, bgolaszewski@baylibre.com, masahiroy@kernel.org, linux@armlinux.org.uk, willy@infradead.org, takahiro.akashi@linaro.org, james.morse@arm.com, kernel-team@android.com, Arnd Bergmann <arnd@arndb.de>, pmladek@suse.com, elver@google.com, aou@eecs.berkeley.edu, keescook@chromium.org, uwe@kleine-koenig.org, rostedt@goodmis.org, bro
List-Id: linux-arch.vger.kernel.org

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
