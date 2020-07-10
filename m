Return-Path: <SRS0=GDSS=AV=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbgGJFjT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 10 Jul 2020 01:39:19 -0400
Date: Fri, 10 Jul 2020 06:38:50 +0100
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/5] lib: Add a generic version of devmem_is_allowed()
Message-ID: <20200710053850.GA27019@infradead.org>
References: <20200709200552.1910298-1-palmer@dabbelt.com>
 <20200709200552.1910298-2-palmer@dabbelt.com>
 <20200709204921.GJ781326@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709204921.GJ781326@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mike Rapoport <rppt@linux.ibm.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, mark.rutland@arm.com, steve@sk2.org, davidgow@google.com, catalin.marinas@arm.com, linus.walleij@linaro.org, Palmer Dabbelt <palmerdabbelt@google.com>, elver@google.com, glider@google.com, willy@infradead.org, zong.li@sifive.com, mchehab+samsung@kernel.org, linux-riscv@lists.infradead.org, alex.shi@linux.alibaba.com, will@kernel.org, dan.j.williams@intel.com, linux-arch@vger.kernel.org, uwe@kleine-koenig.org, alex@ghiti.fr, takahiro.akashi@linaro.org, paulmck@kernel.org, masahiroy@kernel.org, linux@armlinux.org.uk, krzk@kernel.org, ardb@kernel.org, bgolaszewski@baylibre.com, kernel-team@android.com, pmladek@suse.com, zaslonko@linux.ibm.com, aou@eecs.berkeley.edu, keescook@chromium.org, Arnd Bergmann <arnd@arndb.de>, rostedt@goodmis.org, broonie@kernel.org, matti.vaittinen@fi.rohmeurope.com, gregory.0xf0@gmail.com, Paul Walmsley <paul.walmsley@sifive.com>, tglx@linutronix.de, andriy.shevchenko@linux.intel.com, gxt@pku.edu.cn, linux-arm-kernel@lists.infradead.org, rdunlap@infradead.org, Nick Desaulniers <ndesaulniers@google.com>, linux-kernel@vger.kernel.org, mcgrof@kernel.org, james.morse@arm.com, mhiramat@kernel.org, akpm@linux-foundation.org, davem@davemloft.net
Message-ID: <20200710053850.LX7yZROi_DvKaGazVhouqtC3dL7r-FydZ48GtodmvBM@z>

On Thu, Jul 09, 2020 at 11:49:21PM +0300, Mike Rapoport wrote:
> > +#ifndef CONFIG_GENERIC_DEVMEM_IS_ALLOWED
> > +extern int devmem_is_allowed(unsigned long pfn);
> > +#endif

Nit: no need for the extern here.

> > +config GENERIC_LIB_DEVMEM_IS_ALLOWED
> > +	bool
> > +	select ARCH_HAS_DEVMEM_IS_ALLOWED
> 
> This seems to work the other way around from the usual Kconfig chains.
> In the most cases ARCH_HAS_SOMETHING selects GENERIC_SOMETHING.
> 
> I believe nicer way would be to make 
> 
> config STRICT_DEVMEM
> 	bool "Filter access to /dev/mem"
> 	depends on MMU && DEVMEM
> 	depends on ARCH_HAS_DEVMEM_IS_ALLOWED || GENERIC_LIB_DEVMEM_IS_ALLOWED
> 
> config GENERIC_LIB_DEVMEM_IS_ALLOWED
> 	bool
> 
> and then s/select ARCH_HAS_DEVMEM_IS_ALLOWED/select GENERIC_LIB_DEVMEM_IS_ALLOWED/
> in the arch Kconfigs and drop ARCH_HAS_DEVMEM_IS_ALLOWED in the end.

To take a step back:  Is there any reason to not just always
STRICT_DEVMEM? Maybe for a few architectures that don't currently
support a strict /dev/mem the generic version isn't quite correct, but
someone selecting the option and finding the issue is the best way to
figure that out..
