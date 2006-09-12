Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:214 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030280AbWILQpT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 12 Sep 2006 12:45:19 -0400
Received: from nat-pool-stn.redhat.com ([62.200.124.98] helo=hades.cambridge.redhat.com)
	by pentafluge.infradead.org with esmtpsa (Exim 4.62 #1 (Red Hat Linux))
	id 1GNBNZ-00034D-PX
	for linux-arch@vger.kernel.org; Tue, 12 Sep 2006 17:44:57 +0100
Subject: All arch maintainers: 'make headers_check' fails on most
	architectures.
From: David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain
Date: Tue, 12 Sep 2006 17:44:55 +0100
Message-Id: <1158079495.9189.125.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Basically all but PowerPC and i386 have problems; and the latter works
only if you apply the patches I sent to Linus a few days ago.

This is just a basic check that the headers which _are_ exported don't
try to include other headers which aren't. This can happen either
because the former should not, or the latter _should_ be exported.
Mostly, however, the solution is just to make sure the latter is
included only within #ifdef __KERNEL__, because it's only needed within
that ifdef anyway.

Admittedly, much of the time this is only seen in files like asm/page.h
or asm/elf.h which we really don't expect anyone in userspace to be
using anyway -- but it would be good to fix them anyway.

Omitting the headers for which I've already sent patches to Linus, these
are the remaining problems found by running the scripts/hdrcheck.sh over
the exported kernel headers (automatically exported from Linus' current
tree, and available from
git://git.kernel.org/pub/scm/linux/kernel/git/dwmw2/kernel-headers.git )

$ for ARCH in `ls -d asm* | cut -c5- | grep -v generic`; do rm -f asm ; ln -sf asm-$ARCH asm ; for FILE in asm-$ARCH/*.h ; do ../linux-2.6/scripts/hdrcheck.sh . $FILE  ; done ; done
asm-alpha/byteorder.h requires asm/compiler.h, which does not exist
asm-alpha/page.h requires asm-generic/memory_model.h, which does not exist
asm-arm/elf.h requires asm/procinfo.h, which does not exist
asm-arm/page.h requires asm-generic/page.h, which does not exist
asm-arm26/elf.h requires asm/procinfo.h, which does not exist
asm-arm26/page.h requires asm-generic/page.h, which does not exist
asm-cris/byteorder.h requires asm/arch/byteorder.h, which does not exist
asm-cris/elf.h requires asm/arch/elf.h, which does not exist
asm-cris/page.h requires asm/arch/page.h, which does not exist
asm-cris/posix_types.h requires asm/bitops.h, which does not exist
asm-cris/ptrace.h requires asm/arch/ptrace.h, which does not exist
asm-cris/termios.h requires asm/rs485.h, which does not exist
asm-cris/unistd.h requires asm/arch/unistd.h, which does not exist
asm-cris/user.h requires asm/arch/user.h, which does not exist
asm-frv/page.h requires asm-generic/memory_model.h, which does not exist
asm-frv/ptrace.h requires asm/registers.h, which does not exist
asm-frv/sigcontext.h requires asm/registers.h, which does not exist
asm-frv/termios.h requires asm-generic/termios.h, which does not exist
asm-frv/user.h requires asm/registers.h, which does not exist
asm-h8300/page.h requires asm-generic/memory_model.h, which does not exist
asm-ia64/ptrace.h requires asm/asm-offsets.h, which does not exist
asm-ia64/resource.h requires asm/ustack.h, which does not exist
asm-m32r/page.h requires asm-generic/memory_model.h, which does not exist
asm-m32r/ptrace.h requires asm/m32r.h, which does not exist
asm-m32r/signal.h requires linux/linkage.h, which does not exist
asm-m32r/unistd.h requires asm/syscall.h, which does not exist
asm-m32r/user.h requires asm/processor.h, which does not exist
asm-m68k/page.h requires asm-generic/page.h, which does not exist
asm-m68knommu/page.h requires asm-generic/page.h, which does not exist
asm-mips/page.h requires asm-generic/memory_model.h, which does not exist
asm-mips/posix_types.h requires asm/sgidefs.h, which does not exist
asm-mips/ptrace.h requires asm/isadep.h, which does not exist
asm-mips/sigcontext.h requires asm/sgidefs.h, which does not exist
asm-mips/statfs.h requires asm/sgidefs.h, which does not exist
asm-mips/stat.h requires asm/sgidefs.h, which does not exist
asm-mips/unistd.h requires asm/sgidefs.h, which does not exist
asm-mips/user.h requires asm/reg.h, which does not exist
asm-parisc/page.h requires asm-generic/memory_model.h, which does not exist
asm-s390/debug.h requires linux/string.h, which does not exist
asm-s390/elf.h requires asm/system.h, which does not exist
asm-sh/page.h requires asm-generic/memory_model.h, which does not exist
asm-sh/ptrace.h requires asm/ubc.h, which does not exist
asm-sh64/page.h requires asm-generic/memory_model.h, which does not exist
asm-sh64/shmparam.h requires asm/cache.h, which does not exist
asm-sh64/signal.h requires asm/processor.h, which does not exist
asm-sh64/user.h requires asm/processor.h, which does not exist
asm-sparc/auxio.h requires asm/system.h, which does not exist
asm-sparc/page.h requires asm-generic/memory_model.h, which does not exist
asm-sparc/pbm.h requires asm/oplib.h, which does not exist
asm-sparc/pgtsun4.h requires asm/contregs.h, which does not exist
asm-sparc/turbosparc.h requires asm/pgtsrmmu.h, which does not exist
asm-sparc64/floppy.h requires linux/init.h, which does not exist
asm-sparc64/kdebug.h requires linux/notifier.h, which does not exist
asm-sparc64/mostek.h requires asm/idprom.h, which does not exist
asm-sparc64/page.h requires asm/const.h, which does not exist
asm-sparc64/parport.h requires asm/ebus.h, which does not exist
asm-sparc64/pstate.h requires asm/const.h, which does not exist
asm-sparc64/shmparam.h requires asm/spitfire.h, which does not exist
asm-um/page.h requires asm/vm-flags.h, which does not exist
asm-um/unistd.h requires linux/syscalls.h, which does not exist
asm-v850/page.h requires asm/machdep.h, which does not exist
asm-v850/param.h requires asm/machdep.h, which does not exist
asm-x86_64/elf.h requires asm/processor.h, which does not exist
asm-x86_64/signal.h requires linux/linkage.h, which does not exist
asm-x86_64/unistd.h requires linux/linkage.h, which does not exist
asm-x86_64/vsyscall.h requires linux/seqlock.h, which does not exist
asm-xtensa/byteorder.h requires asm/processor.h, which does not exist
asm-xtensa/elf.h requires asm/coprocessor.h, which does not exist
asm-xtensa/page.h requires asm-generic/memory_model.h, which does not exist
asm-xtensa/shmparam.h requires asm/processor.h, which does not exist
asm-xtensa/sigcontext.h requires asm/processor.h, which does not exist


-- 
dwmw2

