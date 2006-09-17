Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:42663 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750840AbWIQHkC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 17 Sep 2006 03:40:02 -0400
Subject: Re: All arch maintainers: 'make headers_check' fails on most
	architectures.
From: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1158079495.9189.125.camel@hades.cambridge.redhat.com>
References: <1158079495.9189.125.camel@hades.cambridge.redhat.com>
Content-Type: text/plain
Date: Sun, 17 Sep 2006 08:39:39 +0100
Message-Id: <1158478779.24527.209.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: spyro@f2s.com, starvik@axis.com, ysato@users.sourceforge.jp, takata@linux-m32r.org, geert@linux-m68k.org, lethal@linux-sh.org, davem@davemloft.net, wli@holomorphy.com, jdike@karaya.com, uclinux-v850@lsi.nec.co.jp, chris@zankel.net, rmk@arm.linux.org.uk, dhowells <dhowells@redhat.com>, ralf@linux-mips.org, kyle@parisc-linux.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, 2006-09-12 at 17:44 +0100, David Woodhouse wrote:
> Basically all but PowerPC and i386 have problems; and the latter works
> only if you apply the patches I sent to Linus a few days ago.
> 
> This is just a basic check that the headers which _are_ exported don't
> try to include other headers which aren't. This can happen either
> because the former should not, or the latter _should_ be exported.
> Mostly, however, the solution is just to make sure the latter is
> included only within #ifdef __KERNEL__, because it's only needed within
> that ifdef anyway.

As of today, a number of other architectures are fixed and we're left
with a few stragglers whose headers may not be clean in the
linux-kernel-headers tarball I intend to make based on the 2.6.18
release.

These have been fixed in patches which the architecture maintainer has
already sent to Linus:

asm-mips/posix_types.h requires asm/sgidefs.h, which does not exist in exported headers
asm-mips/ptrace.h requires asm/isadep.h, which does not exist in exported headers
asm-mips/sigcontext.h requires asm/sgidefs.h, which does not exist in exported headers
asm-mips/statfs.h requires asm/sgidefs.h, which does not exist in exported headers
asm-mips/stat.h requires asm/sgidefs.h, which does not exist in exported headers
asm-mips/unistd.h requires asm/sgidefs.h, which does not exist in exported headers
asm-mips/user.h requires asm/reg.h, which does not exist in exported headers

asm-parisc/page.h requires asm-generic/memory_model.h, which does not exist in exported headers

asm-frv/page.h requires asm-generic/memory_model.h, which does not exist in exported headers
asm-frv/ptrace.h requires asm/registers.h, which does not exist in exported headers
asm-frv/sigcontext.h requires asm/registers.h, which does not exist in exported headers
asm-frv/termios.h requires asm-generic/termios.h, which does not exist in exported headers
asm-frv/user.h requires asm/registers.h, which does not exist in exported headers


These have patches which have been sent to the arch maintainer but which
I believe have not yet been forwarded to Linus:

asm-arm/elf.h requires asm/procinfo.h, which does not exist in exported headers
asm-arm/page.h requires asm-generic/page.h, which does not exist in exported headers


And these remain broken with no word from the maintainer. I've directly
Cc'd some arch maintainers this time in case they're not subscribed to
linux-arch:

asm-arm26/elf.h requires asm/procinfo.h, which does not exist in exported headers
asm-arm26/page.h requires asm-generic/page.h, which does not exist in exported headers
asm-cris/byteorder.h requires asm/arch/byteorder.h, which does not exist in exported headers
asm-cris/elf.h requires asm/arch/elf.h, which does not exist in exported headers
asm-cris/page.h requires asm/arch/page.h, which does not exist in exported headers
asm-cris/posix_types.h requires asm/bitops.h, which does not exist in exported headers
asm-cris/ptrace.h requires asm/arch/ptrace.h, which does not exist in exported headers
asm-cris/termios.h requires asm/rs485.h, which does not exist in exported headers
asm-cris/unistd.h requires asm/arch/unistd.h, which does not exist in exported headers
asm-cris/user.h requires asm/arch/user.h, which does not exist in exported headers
asm-h8300/page.h requires asm-generic/memory_model.h, which does not exist in exported headers
asm-m32r/page.h requires asm-generic/memory_model.h, which does not exist in exported headers
asm-m32r/ptrace.h requires asm/m32r.h, which does not exist in exported headers
asm-m32r/signal.h requires linux/linkage.h, which does not exist in exported headers
asm-m32r/unistd.h requires asm/syscall.h, which does not exist in exported headers
asm-m32r/user.h requires asm/processor.h, which does not exist in exported headers
asm-m68k/page.h requires asm-generic/page.h, which does not exist in exported headers
asm-m68knommu/page.h requires asm-generic/page.h, which does not exist in exported headers
asm-sh/page.h requires asm-generic/memory_model.h, which does not exist in exported headers
asm-sh/ptrace.h requires asm/ubc.h, which does not exist in exported headers
asm-sh64/page.h requires asm-generic/memory_model.h, which does not exist in exported headers
asm-sh64/shmparam.h requires asm/cache.h, which does not exist in exported headers
asm-sh64/signal.h requires asm/processor.h, which does not exist in exported headers
asm-sh64/user.h requires asm/processor.h, which does not exist in exported headers
asm-sparc/auxio.h requires asm/system.h, which does not exist in exported headers
asm-sparc/page.h requires asm-generic/memory_model.h, which does not exist in exported headers
asm-sparc/pbm.h requires asm/oplib.h, which does not exist in exported headers
asm-sparc/pgtsun4.h requires asm/contregs.h, which does not exist in exported headers
asm-sparc/turbosparc.h requires asm/pgtsrmmu.h, which does not exist in exported headers
asm-sparc64/floppy.h requires linux/init.h, which does not exist in exported headers
asm-sparc64/kdebug.h requires linux/notifier.h, which does not exist in exported headers
asm-sparc64/mostek.h requires asm/idprom.h, which does not exist in exported headers
asm-sparc64/page.h requires asm/const.h, which does not exist in exported headers
asm-sparc64/parport.h requires asm/ebus.h, which does not exist in exported headers
asm-sparc64/pstate.h requires asm/const.h, which does not exist in exported headers
asm-sparc64/shmparam.h requires asm/spitfire.h, which does not exist in exported headers
asm-um/page.h requires asm/vm-flags.h, which does not exist in exported headers
asm-um/unistd.h requires linux/syscalls.h, which does not exist in exported headers
asm-v850/page.h requires asm/machdep.h, which does not exist in exported headers
asm-v850/param.h requires asm/machdep.h, which does not exist in exported headers
asm-xtensa/byteorder.h requires asm/processor.h, which does not exist in exported headers
asm-xtensa/elf.h requires asm/coprocessor.h, which does not exist in exported headers
asm-xtensa/page.h requires asm-generic/memory_model.h, which does not exist in exported headers
asm-xtensa/shmparam.h requires asm/processor.h, which does not exist in exported headers
asm-xtensa/sigcontext.h requires asm/processor.h, which does not exist in exported headers


It may be that UM and ARM26 don't need to be exporting headers, because
they can use headers from the host architecture and from ARM32,
respectively. If that's the case, we should just remove the Kbuild files
from those architectures' include directories.

-- 
dwmw2

