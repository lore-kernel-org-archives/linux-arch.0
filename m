From: Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: Add and use a generic version of devmem_is_allowed()
Date: Sun, 12 Jul 2020 09:09:31 +0300
Message-ID: <20200712060931.GM781326@linux.ibm.com>
References: <20200709211925.1926557-1-palmer@dabbelt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:14926 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728198AbgGLGLM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Sun, 12 Jul 2020 02:11:12 -0400
Content-Disposition: inline
In-Reply-To: <20200709211925.1926557-1-palmer@dabbelt.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: zong.li@sifive.com, linux-riscv@lists.infradead.org, linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu, gxt@pku.edu.cn, Arnd Bergmann <arnd@arndb.de>, linus.walleij@linaro.org, akpm@linux-foundation.org, mchehab+samsung@kernel.org, gregory.0xf0@gmail.com, masahiroy@kernel.org, Nick Desaulniers <ndesaulniers@google.com>, bgolaszewski@baylibre.com, steve@sk2.org, tglx@linutronix.de, keescook@chromium.org, alex@ghiti.fr, mcgrof@kernel.org, mark.rutland@arm.com, james.morse@arm.com, alex.shi@linux.alibaba.com, andriy.shevchenko@linux.intel.com, broonie@kernel.org, rdunlap@infradead.org, davem@davemloft.net, rostedt@goodmis.org, dan.j.williams@intel.com, mhiramat@kernel.org, krzk@kernel.org, zaslonko@

On Thu, Jul 09, 2020 at 02:19:20PM -0700, Palmer Dabbelt wrote:
> As part of adding STRICT_DEVMEM support to the RISC-V port, Zong provided an
> implementation of devmem_is_allowed() that's exactly the same as the version in
> a handful of other ports.  Rather than duplicate code, I've put a generic
> version of this in lib/ and used it for the RISC-V port.
> 
> I've put those first two patches on riscv/for-next, which I'm targeting for 5.9
> (though this is the first version, so they're unreviewed).  The other three
> obviously depend on the first one going on, but I'm not putting them in the
> RISC-V tree as I don't want to step on anyone's toes.  If you want me to take
> yours along with the others then please say something, as otherwise I'll
> probably forget.

For the series

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

> I've put the whole thing at
> ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/palmer/linux.git -b
> generic-devmem .
> 
> Changes since v1 [<20200709200552.1910298-1-palmer@dabbelt.com]:
> 
> * Don't have GENERIC_LIB_DEVMEM_IS_ALLOWED select ARCH_HAS_DEVMEM_IS_ALLOWED,
>   instead just adapt the users.
> * Remove ARCH_HAS_DEVMEM_IS_ALLOWED from the arch Kconfigs, as I forgot to do
>   so the first time.
> 
> 

-- 
Sincerely yours,
Mike.
