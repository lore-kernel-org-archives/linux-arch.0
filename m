Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-eopbgr720060.outbound.protection.outlook.com ([40.107.72.60]:12648
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753098AbeFIHmq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 9 Jun 2018 03:42:46 -0400
Date: Sat, 9 Jun 2018 10:42:27 +0300
From: Yury Norov <ynorov@caviumnetworks.com>
Subject: Re: [PATCH 04/24] 32-bit userspace ABI: introduce ARCH_32BIT_OFF_T
 config option
Message-ID: <20180609074227.GA6810@yury-thinkpad>
References: <20180516081910.10067-1-ynorov@caviumnetworks.com>
 <20180516081910.10067-5-ynorov@caviumnetworks.com>
 <20180608173207.nwoi25jee52gpdwy@armageddon.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180608173207.nwoi25jee52gpdwy@armageddon.cambridge.arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Szabolcs Nagy <szabolcs.nagy@arm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Philipp Tomsich <philipp.tomsich@theobroma-systems.com>, Joseph Myers <joseph@codesourcery.com>, Steve Ellcey <sellcey@caviumnetworks.com>, Prasun Kapoor <Prasun.Kapoor@caviumnetworks.com>, Andreas Schwab <schwab@suse.de>, Alexander Graf <agraf@suse.de>, Bamvor Zhangjian <bamv2005@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Dave Martin <Dave.Martin@arm.com>, Adam Borowski <kilobyte@angband.pl>, Manuel Montezelo <manuel.montezelo@gmail.com>, James Hogan <james.hogan@imgtec.com>, Chris Metcalf <cmetcalf@mellanox.com>, Andrew Pinski <pinskia@gmail.com>, Lin Yongting <linyongting@huawei.com>, Alexey Klimov <klimov.linux@gmail.com>, Mark Brown <broonie@kernel.org>, Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>, Florian Weimer <fweimer@redhat.com>, Nathan_Lynch <Nathan_Lynch@mentor.com>, James Morse <james.morse@arm.com>, Ramana Radhakrishnan <ramana.gcc@googlemail.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, "David S . Miller" <davem@davemloft.net>, Christoph Muellner <christoph.muellner@theobroma-systems.com>
Message-ID: <20180609074227.ZMvsPnXO8A4IVLPHoqAe7L72AcloT53YHOGSzxGSzKY@z>

On Fri, Jun 08, 2018 at 06:32:07PM +0100, Catalin Marinas wrote:
> On Wed, May 16, 2018 at 11:18:49AM +0300, Yury Norov wrote:
> > diff --git a/arch/Kconfig b/arch/Kconfig
> > index 76c0b54443b1..ee079244dc3c 100644
> > --- a/arch/Kconfig
> > +++ b/arch/Kconfig
> > @@ -264,6 +264,21 @@ config ARCH_THREAD_STACK_ALLOCATOR
> >  config ARCH_WANTS_DYNAMIC_TASK_STRUCT
> >  	bool
> >  
> > +config ARCH_32BIT_OFF_T
> > +	bool
> > +	depends on !64BIT
> > +	help
> > +	  All new 32-bit architectures should have 64-bit off_t type on
> > +	  userspace side which corresponds to the loff_t kernel type. This
> > +	  is the requirement for modern ABIs. Some existing architectures
> > +	  already have 32-bit off_t. This option is enabled for all such
> > +	  architectures explicitly. Namely: arc, arm, blackfin, cris, frv,
> > +	  h8300, hexagon, m32r, m68k, metag, microblaze, mips32, mn10300,
> > +	  nios2, openrisc, parisc32, powerpc32, score, sh, sparc, tile32,
> > +	  unicore32, x86_32 and xtensa. This is the complete list. Any
> > +	  new 32-bit architecture should declare 64-bit off_t type on user
> > +	  side and so should not enable this option.
> 
> Do you know if this is the case for riscv and nds32, merged in the
> meantime? If not, I suggest you drop this patch altogether and just
> define force_o_largefile() for arm64/ilp32 as we don't seem to stick to
> "all new 32-bit architectures should have 64-bit off_t".

I wrote this patch at request of Arnd Bergmann. This is actually his
words that all new 32-bit architectures should have 64-bit off_t. So
I was surprized when riscv was merged with 32-bit off_t (and I didn't
follow nds32).

If this rule is still in force, we'd better add new exceptions to this
patch. Otherwise, we can drop it.

Arnd, could you please comment it?

Yury
