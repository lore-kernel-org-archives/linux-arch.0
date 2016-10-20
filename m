From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH] kbuild: provide include/asm/asm-prototypes.h for ARM
Date: Thu, 20 Oct 2016 14:17:02 +0100
Message-ID: <20161020131702.GX1041@n2100.armlinux.org.uk>
References: <20161017065131.GA27863@angband.pl>
 <6556201.qTG4Pa4aHk@wuerfel>
 <fafba13a-c64c-2578-534c-c344f18d0fc5@suse.com>
 <3114442.xCAy34UQCk@wuerfel>
 <20161019153159.GQ1041@n2100.armlinux.org.uk>
 <20161020150814.42951f61@roar.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161020150814.42951f61@roar.ozlabs.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Michal Marek <mmarek@suse.com>, Adam Borowski <kilobyte@angband.pl>, Omar Sandoval <osandov@osandov.com>, Linus Torvalds <torvalds@linux-foundation.org>, adobriyan@gmail.com, sfr@canb.auug.org.au, viro@zeniv.linux.org.uk, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Thu, Oct 20, 2016 at 03:08:14PM +1100, Nicholas Piggin wrote:
> Fair point, what about leaving those as they are, and also adding
> them to asm-prototypes.h protected with GENKSYMS ifdef? It's not
> beautiful, but still better than armksyms.c before Al's patches (or
> at least no worse).

I disagree (also see below).  The armksyms way was understandable.
The new way... I've no idea yet, because I wasn't even copied on
any of the patches.  I've no idea how the exports are now handled.
I'm in a black hole with respect to that, and that's now a problem.

> > Now, it would have _ALSO_ been nice to have been at least COPIED on the
> > original set of changes that caused the need for this change.  I wasn't.
> > So I want to see the original set of changes reverted, because they're
> > clearly causing breakage.  Let's revert them and then go through the
> > proper process of maintainer review, rather than bypassing maintainers
> > and screwing up architectures in the process.  There really is no
> > excuse for this crap.
> 
> You may have a point about improvement of the process. I wasn't
> involved in the original patches, but we did cc linux-arch when the
> .S CRC issue became known.

Yes, but I'm not on linux-kernel-v2, and I've no desire to end up with
another list I've no hope of keeping up with to my mailbox - I'll just
ignore it.  99% of the messages on it at the time when vger kicked me
off the list was x86 related discussion, and not really cross-arch
issues.  As I say, it just became another linux-kernel list.

> However let's work on the assumption that they won't be reverted at this
> stage, and try to come up with something to fix it that you're happy with.

Well, there's more problems with this new KSYMS approach than just the
CRCs.  It forces a rebuild of the ksyms files every single time, which
then causes a relink of the kernel:

  CHK     include/config/kernel.release
  GEN     ./Makefile
  CHK     include/generated/uapi/linux/version.h
  CHK     include/generated/utsrelease.h
  Using /home/rmk/git/linux-rmk as source for kernel
  CHK     include/generated/timeconst.h
  CHK     include/generated/bounds.h
  CHK     include/generated/asm-offsets.h
  CALL    /home/rmk/git/linux-rmk/scripts/checksyscalls.sh - due to target missing
  CHK     include/generated/compile.h
  EXPORTS arch/arm/lib/lib-ksyms.o - due to lib-ksyms.o not in $(targets)
  LD      arch/arm/lib/built-in.o - due to: arch/arm/lib/lib-ksyms.o
  EXPORTS lib/lib-ksyms.o - due to lib-ksyms.o not in $(targets)
  LD      lib/built-in.o - due to: lib/lib-ksyms.o
  LD      vmlinux.o
  MODPOST vmlinux.o - due to vmlinux.o not in $(targets)
  GEN     .version
  CHK     include/generated/compile.h
  UPD     include/generated/compile.h
  CC      init/version.o - due to: include/generated/compile.h
  LD      init/built-in.o - due to: init/version.o
  KSYM    .tmp_kallsyms1.o
  KSYM    .tmp_kallsyms2.o
  LD      vmlinux
  SORTEX  vmlinux
  SYSMAP  System.map
  OBJCOPY arch/arm/boot/Image - due to: vmlinux
  Building modules, stage 2.
  Kernel: arch/arm/boot/Image is ready
  LZO     arch/arm/boot/compressed/piggy_data - due to: arch/arm/boot/compressed/../Image
  MODPOST 689 modules - due to target is PHONY
  AS      arch/arm/boot/compressed/piggy.o - due to: arch/arm/boot/compressed/piggy_data
  LD      arch/arm/boot/compressed/vmlinux - due to: arch/arm/boot/compressed/piggy.o
  OBJCOPY arch/arm/boot/zImage - due to: arch/arm/boot/compressed/vmlinux
  Kernel: arch/arm/boot/zImage is ready

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
