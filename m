From: Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH] include/asm-generic/io.h: add 'UML' case just like 'no-MMU'
Date: Wed, 26 Jun 2013 08:54:06 +0200
Message-ID: <51CA900E.9020407@nod.at>
References: <51CA8AB8.7080504@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <51CA8AB8.7080504@asianux.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen Gang <gang.chen@asianux.com>
Cc: Jeff Dike <jdike@addtoit.com>, Arnd Bergmann <arnd@arndb.de>, dhsharp@google.com, Mark Brown <broonie@opensource.wolfsonmicro.com>, "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, uml-user <user-mode-linux-user@lists.sourceforge.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

Hi!

Am 26.06.2013 08:31, schrieb Chen Gang:
> For "User Mode Linux", it may enable 'MMU', but not need implement
> ioremap and iounmap, so "include/asm-generic/io.h" need notice this
> case to keep itself 'generic'.
>=20
> The related error (with allmodconfig, without pcap):
>=20
>     CC [M]  drivers/ptp/ptp_pch.o
>   drivers/ptp/ptp_pch.c: In function =91pch_remove=92:
>   drivers/ptp/ptp_pch.c:571:3: error: implicit declaration of functio=
n =91iounmap=92 [-Werror=3Dimplicit-function-declaration]
>   drivers/ptp/ptp_pch.c: In function =91pch_probe=92:
>   drivers/ptp/ptp_pch.c:621:2: error: implicit declaration of functio=
n =91ioremap=92 [-Werror=3Dimplicit-function-declaration]
>   drivers/ptp/ptp_pch.c:621:13: warning: assignment makes pointer fro=
m integer without a cast [enabled by default]
>   cc1: some warnings being treated as errors
>=20
>=20
> Signed-off-by: Chen Gang <gang.chen@asianux.com>
> ---
>  arch/um/include/asm/Kbuild |    1 +
>  include/asm-generic/io.h   |    6 +++---
>  2 files changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/um/include/asm/Kbuild b/arch/um/include/asm/Kbuild
> index b30f34a..a34ea5d 100644
> --- a/arch/um/include/asm/Kbuild
> +++ b/arch/um/include/asm/Kbuild
> @@ -3,3 +3,4 @@ generic-y +=3D hw_irq.h irq_regs.h kdebug.h percpu.h =
sections.h topology.h xor.h
>  generic-y +=3D ftrace.h pci.h io.h param.h delay.h mutex.h current.h=
 exec.h
>  generic-y +=3D switch_to.h clkdev.h
>  generic-y +=3D trace_clock.h
> +generic-y +=3D io.h

We include that file already. See three lines above.

> diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
> index d5afe96..e80331d 100644
> --- a/include/asm-generic/io.h
> +++ b/include/asm-generic/io.h
> @@ -303,10 +303,10 @@ static inline void *phys_to_virt(unsigned long =
address)
>  /*
>   * Change "struct page" to physical address.
>   *
> - * This implementation is for the no-MMU case only... if you have an=
 MMU
> + * This implementation is for the no-MMU or UML case only... if you =
have an MMU
>   * you'll need to provide your own definitions.
>   */
> -#ifndef CONFIG_MMU
> +#if !CONFIG_MMU || CONFIG_UML
>  static inline void __iomem *ioremap(phys_addr_t offset, unsigned lon=
g size)
>  {
>  	return (void __iomem*) (unsigned long)offset;
> @@ -325,7 +325,7 @@ static inline void __iomem *ioremap(phys_addr_t o=
ffset, unsigned long size)
>  static inline void iounmap(void __iomem *addr)
>  {
>  }
> -#endif /* CONFIG_MMU */
> +#endif /* !CONFIG_MMU || CONFIG_UML */
> =20
>  #ifdef CONFIG_HAS_IOPORT
>  #ifndef CONFIG_GENERIC_IOMAP
>=20

UML has no io memory but a MMU, so I'd argue that you better fix driver=
s/ptp/ptp_pch.c dependencies.
_If_ ptp_pch.c really works without real io memory, you can look what I=
 did in my GENERIC_IO series[1]
to make nandsim work on UML. Maybe this helps.

Thanks,
//richard

[1] http://lists.infradead.org/pipermail/linux-mtd/2012-February/039701=
=2Ehtml
