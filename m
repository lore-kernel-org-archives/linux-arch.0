From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH] mtd: only use __xipram annotation when XIP_KERNEL is set
Date: Fri, 4 Mar 2016 16:10:57 -0800
Message-ID: <20160305001057.GC55664@google.com>
References: <1453736525-1959191-2-git-send-email-arnd@arndb.de>
 <20160305000225.GB55664@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160305000225.GB55664@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, Robert Jarzmik <robert.jarzmik@free.fr>, Haojian Zhuang <haojian.zhuang@gmail.com>, Daniel Mack <daniel@zonque.org>
List-Id: linux-arch.vger.kernel.org

+ others

On Fri, Mar 04, 2016 at 04:02:25PM -0800, Brian Norris wrote:
> Hi Arnd,
>=20
> I know you're travelling, but...
>=20
> On Mon, Jan 25, 2016 at 04:41:50PM +0100, Arnd Bergmann wrote:
> > When XIP_KERNEL is enabled, some functions are defined in the .data
> > ELF section because we require them to be in RAM whenever we commun=
icate
> > with the flash chip. However this causes problems when FTRACE is
> > enabled and gcc emits calls to __gnu_mcount_nc in the function
> > prolog:
> >=20
> > drivers/built-in.o: In function `cfi_chip_setup':
> > :(.data+0x272fc): relocation truncated to fit: R_ARM_CALL against s=
ymbol `__gnu_mcount_nc' defined in .text section in arch/arm/kernel/bui=
lt-in.o
> > drivers/built-in.o: In function `cfi_probe_chip':
> > :(.data+0x27de8): relocation truncated to fit: R_ARM_CALL against s=
ymbol `__gnu_mcount_nc' defined in .text section in arch/arm/kernel/bui=
lt-in.o
> > /tmp/ccY172rP.s: Assembler messages:
> > /tmp/ccY172rP.s:70: Warning: ignoring changed section attributes fo=
r .data
> > /tmp/ccY172rP.s: Error: 1 warning, treating warnings as errors
> > make[5]: *** [drivers/mtd/chips/cfi_probe.o] Error 1
> > /tmp/ccK4rjeO.s: Assembler messages:
> > /tmp/ccK4rjeO.s:421: Warning: ignoring changed section attributes f=
or .data
> > /tmp/ccK4rjeO.s: Error: 1 warning, treating warnings as errors
> > make[5]: *** [drivers/mtd/chips/cfi_util.o] Error 1
> > /tmp/ccUvhCYR.s: Assembler messages:
> > /tmp/ccUvhCYR.s:1895: Warning: ignoring changed section attributes =
for .data
> > /tmp/ccUvhCYR.s: Error: 1 warning, treating warnings as errors
>=20
> Can you provide a sample .config that DOES build correctly with
> XIP_KERNEL enabled + this patch? My first attempt yields some other
> failures I don't care to fixup right now...

Particularly, mach-pxa MTD_XIP looks like it's broken, at least since
here:

  5d284e353eb1 ARM: pxa: avoid accessing interrupt registers directly

  CC      drivers/mtd/chips/cfi_cmdset_0002.o
drivers/mtd/chips/cfi_cmdset_0002.c: In function =E2=80=98xip_udelay=E2=
=80=99:
drivers/mtd/chips/cfi_cmdset_0002.c:962:35: warning: initialization mak=
es integer from pointer without a cast [enabled by default]
drivers/mtd/chips/cfi_cmdset_0002.c:967:8: error: =E2=80=98ICIP=E2=80=99=
 undeclared (first use in this function)
drivers/mtd/chips/cfi_cmdset_0002.c:967:8: note: each undeclared identi=
fier is reported only once for each function it appears in
drivers/mtd/chips/cfi_cmdset_0002.c:967:15: error: =E2=80=98ICMR=E2=80=99=
 undeclared (first use in this function)
drivers/mtd/chips/cfi_cmdset_0002.c:981:123: error: invalid operands to=
 binary / (have =E2=80=98void *=E2=80=99 and =E2=80=98int=E2=80=99)
drivers/mtd/chips/cfi_cmdset_0002.c:982:14: warning: assignment makes i=
nteger from pointer without a cast [enabled by default]
drivers/mtd/chips/cfi_cmdset_0002.c:984:124: error: invalid operands to=
 binary / (have =E2=80=98void *=E2=80=99 and =E2=80=98int=E2=80=99)
drivers/mtd/chips/cfi_cmdset_0002.c:1034:10: warning: assignment makes =
integer from pointer without a cast [enabled by default]
drivers/mtd/chips/cfi_cmdset_0002.c:1045:118: error: invalid operands t=
o binary / (have =E2=80=98void *=E2=80=99 and =E2=80=98int=E2=80=99)

Looks like arch/arm/mach-pxa/include/mach/mtd-xip.h can't find ICIP or =
ICMR...

> Anyway, I don't doubt you have a good fix here, so I can probably tak=
e
> it. Any review from others would be welcome though.
>=20
> > Specifically, this does not work because the .data section is not
> > marked executable, which leads LD to not generate trampolines for
> > long calls.
> >=20
> > This moves the __xipram functions into their own .xiptext section i=
nstead.
> > The section is still placed next to .data and located in RAM but is=
 marked
> > executable, which avoids the build errors.
> >=20
> > Also, we only need to place the XIP functions into a separate secti=
on
> > if both CONFIG_XIP_KERNEL and CONFIG_MTD_XIP are set: When only MTD=
_XIP
> > is used, the whole kernel is still in RAM and we do not need to wor=
ry
> > about pulling out the rug under it. When only XIP_KERNEL but not MT=
D_XIP
> > is set, the kernel is in some form of ROM, but we never write to it=
=2E
> >=20
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Brian
