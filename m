From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: [RFC][CFT][PATCHSET v2] uaccess unification
Date: Fri, 7 Apr 2017 01:24:24 +0100
Message-ID: <20170407002423.GW29622@ZenIV.linux.org.uk>
References: <20170329055706.GH29622@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:60876 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751557AbdDGAYq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Apr 2017 20:24:46 -0400
Content-Disposition: inline
In-Reply-To: <20170329055706.GH29622@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Richard Henderson <rth@twiddle.net>, Russell King <linux@armlinux.org.uk>, Will Deacon <will.deacon@arm.com>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Vineet Gupta <vgupta@synopsys.com>, Steven Miao <realmz6@gmail.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Mark Salter <msalter@redhat.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Kuo <rkuo@codeaurora.org>, Tony Luck <tony.luck@intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, James Hogan <james.hogan@imgtec.com>, Michal Simek <monstr@monstr.eu>, David Howells <dhowells@redhat.com>, Ley Foon Tan <lftan@altera.com>, Jonas Bonn <jonas@southpole.se>, Helge Deller <deller@gmx.de>, Martin

Updates since v1:

	* metag conversion (based on fixes from James Hogan) added.  Result
tested by the aforementioned metag maintainer.
	* xtensa fix added, result tested.
	* arm, arm64, amd64 tested.
	* s390 fix folded, result tested.
	* arc fix added, result tested.
	* parisc fix replaced with backmerge of the variant in mainline,
result tested.
	* ia64 conversion for CONFIG_MCKINLEY added; appears to work.
CONFIG_ITANIUM *not* converted; the current mainline has all kinds
of bugs in that config, including a user-triggerable oops with one
hell of a DoS potential.  That one needs to be fixed in -stable, at least
to the point where it wouldn't allow any user to leave the box in a state
when any lookup in /tmp hangs unkillably, but as for the mainline...
Frankly, I suspect that we have fewer Merced boxen running mainline
kernels now than we had 386 and 486DLC ones doing the same five years ago,
when CONFIG_M386 finally got killed.  IOW, maybe it's time to put it
out of its misery.
	* backmerges of mainline fixes (on ia64, mips, powerpc and parisc
branches) added.
	* conversion made unconditional
	* HAVE_ARCH_HARDENED_USERCOPY removed (universally true now)
	* no object size checks remain in arch/*
	* ibmvnet bugs spotted and fixed; that'll get fed into net-next
ASAP.
	* balance is at -3KLoC now (OK, -2984LoC)
	* the thing is included into #for-next.

The series lives in git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git
in #work.uaccess.  It's still based at 4.11-rc1 and topology is unchanged,
except for backmerges into arch branches instead of cherry-picking the mainline
fixes into them + a couple of followup commits after the place where branches
converge (making stuff unconditional).  Infrastructure part hadn't been
rebased or modified in any way since the previous version; if you are OK
with your architecture branch (uaccess.<arch>) you can say so and it'll
be put into never-rebased mode as well, making it safe to pull into your
tree.  Alternatively, if you want to cherry-pick stuff from that branch,
just put it into never-rebased branch in your tree and tell me to pull
it.

As before, comments, review, testing, replacement patches, etc. are very
welcome.  Folks, if you don't yell, it will get pushed come next cycle.

I don't believe that 104-piece mailbomb with total size at 0.5 megabyte is
a good idea for public lists, but if somebody wants one, just say so.
Or just use git...

FWIW, the current stats are:

Al Viro (100):
      uaccess: move VERIFY_{READ,WRITE} definitions to linux/uaccess.h
      uaccess: drop duplicate includes from asm/uaccess.h
      uaccess: drop pointless ifdefs
      add asm-generic/extable.h
      new helper: uaccess_kernel()
      asm-generic/uaccess.h: don't mess with __copy_{to,from}_user
      asm-generic: zero in __get_user(), not __get_user_fn()
      generic ...copy_..._user primitives
      alpha: switch __copy_user() and __do_clean_user() to normal calling conventions
      alpha: add asm/extable.h
      alpha: get rid of 'segment' argument of __{get,put}_user_check()
      alpha: don't bother with __access_ok() in traps.c
      alpha: kill the 'segment' argument of __access_ok()
      alpha: add a helper for emitting exception table entries
      alpha: switch to RAW_COPY_USER
      arc: get rid of unused declaration
      arm: switch to generic extable.h
      arm: switch to RAW_COPY_USER
      arm64: add extable.h
      avr32: switch to generic extable.h
      arm64: switch to RAW_COPY_USER
      avr32: switch to RAW_COPY_USER
      blackfin: switch to generic extable.h
      bfin: switch to RAW_COPY_USER
      c6x: remove duplicate definition of __access_ok
      c6x: switch to RAW_COPY_USER
      cris: switch to generic extable.h
      cris: don't rely upon __copy_user_zeroing() zeroing the tail
      cris: get rid of zeroing in __asm_copy_from_user_N for N > 4
      cris: get rid of zeroing
      cris: rename __copy_user_zeroing to __copy_user_in
      cris: switch to RAW_COPY_USER
      frv: switch to use of fixup_exception()
      frv: switch to RAW_COPY_USER
      8300: switch to RAW_COPY_USER
      hexagon: switch to RAW_COPY_USER
      m32r: switch to generic extable.h
      m32r: get rid of zeroing
      m68k: switch to generic extable.h
      m68k: get rid of zeroing
      m68k: switch to RAW_COPY_USER
      metag: switch to generic extable.h
      metag: kill verify_area()
      microblaze: switch to generic extable.h
      microblaze: switch to RAW_COPY_USER
      mn10300: switch to generic extable.h
      mn10300: get rid of zeroing
      mn10300: switch to RAW_COPY_USER
      nios2: switch to generic extable.h
      nios2: switch to RAW_COPY_USER
      openrisc: switch to generic extable.h
      openrisc: switch to RAW_COPY_USER
      powerpc: switch to extable.h
      s390: switch to extable.h
      score: switch to generic extable.h
      score: it's "VERIFY_WRITE", not "VERFITY_WRITE"...
      score: switch to RAW_COPY_USER
      sh: switch to extable.h
      sh: switch to RAW_COPY_USER
      sparc32: kill __ret_efault()
      tile: switch to generic extable.h
      tile: get rid of zeroing, switch to RAW_COPY_USER
      um: switch to RAW_COPY_USER
      amd64: get rid of zeroing
      unicore32: get rid of zeroing and switch to RAW_COPY_USER
      kill __copy_from_user_nocache()
      xtensa: switch to generic extable.h
      xtensa: get rid of zeroing, use RAW_COPY_USER
      arc: switch to RAW_COPY_USER
      m32r: switch to RAW_COPY_USER
      x86: don't wank with magical size in __copy_in_user()
      x86: switch to RAW_COPY_USER
      s390: get rid of zeroing, switch to RAW_COPY_USER
      Merge branch 'parisc-4.11-3' of git://git.kernel.org/.../deller/parisc-linux into uaccess.parisc
      parisc: switch to RAW_COPY_USER
      sparc: switch to RAW_COPY_USER
      Merge branch 'fixes' of git://git.kernel.org/.../jhogan/metag into uaccess.metag
      Merge commit 'fc69910f329d' into uaccess.mips
      mips: sanitize __access_ok()
      mips: consolidate __invoke_... wrappers
      mips: clean and reorder the forest of macros...
      mips: make copy_from_user() zero tail explicitly
      mips: get rid of tail-zeroing in primitives
      mips: switch to RAW_COPY_USER
      don't open-code kernel_setsockopt()
      alpha: fix stack smashing in old_adjtimex(2)
      esas2r: don't open-code memdup_user()
      ibmvnic: fix kstrtoul, copy_from_user and copy_to_user misuse
      Merge commit 'a7d2475af7aedcb9b5c6343989a8bfadbf84429b' into uaccess.powerpc
      powerpc: get rid of zeroing, switch to RAW_COPY_USER
      Merge commit 'b4fb8f66f1ae2e167d06c12d018025a8d4d3ba7e' into uaccess.ia64
      ia64: add extable.h
      ia64: get rid of 'segment' argument of __{get,put}_user_check()
      ia64: get rid of 'segment' argument of __do_{get,put}_user()
      ia64: sanitize __access_ok()
      ia64: get rid of copy_in_user()
      get rid of padding, switch to RAW_COPY_USER
      Merge branches 'uaccess.alpha', 'uaccess.arc', 'uaccess.arm', 'uaccess.arm64', 'uaccess.avr32', 'uaccess.bfin', 'uaccess.c6x', 'uaccess.cris', 'uaccess.frv', 'uaccess.h8300', 'uaccess.hexagon', 'uaccess.ia64', 'uaccess.m32r', 'uaccess.m68k', 'uaccess.metag', 'uaccess.microblaze', 'uaccess.mips', 'uaccess.mn10300', 'uaccess.nios2', 'uaccess.openrisc', 'uaccess.parisc', 'uaccess.powerpc', 'uaccess.s390', 'uaccess.score', 'uaccess.sh', 'uaccess.sparc', 'uaccess.tile', 'uaccess.um', 'uaccess.unicore32', 'uaccess.x86' and 'uaccess.xtensa' into work.uaccess
      CONFIG_ARCH_HAS_RAW_COPY_USER is unconditional now
      HAVE_ARCH_HARDENED_USERCOPY is unconditional now

James Hogan (8):
      metag/usercopy: Drop unused macros
      metag/usercopy: Fix alignment error checking
      metag/usercopy: Add early abort to copy_to_user
      metag/usercopy: Zero rest of buffer from copy_from_user
      metag/usercopy: Set flags before ADDZ
      metag/usercopy: Fix src fixup in from user rapf loops
      metag/usercopy: Add missing fixups
      metag/usercopy: Switch to RAW_COPY_USER

Max Filippov (1):
      xtensa: fix prefetch in the raw_copy_to_user

Vineet Gupta (1):
      ARC: uaccess: enable INLINE_COPY_{TO,FROM}_USER ...

 arch/alpha/include/asm/extable.h          |  55 ++++
 arch/alpha/include/asm/futex.h            |  16 +-
 arch/alpha/include/asm/uaccess.h          | 305 +++++---------------
 arch/alpha/kernel/osf_sys.c               |   2 +-
 arch/alpha/kernel/traps.c                 | 152 +++-------
 arch/alpha/lib/clear_user.S               |  66 ++---
 arch/alpha/lib/copy_user.S                |  82 +++---
 arch/alpha/lib/csum_partial_copy.c        |  10 +-
 arch/alpha/lib/ev6-clear_user.S           |  84 +++---
 arch/alpha/lib/ev6-copy_user.S            | 104 +++----
 arch/arc/include/asm/Kbuild               |   1 +
 arch/arc/include/asm/uaccess.h            |  25 +-
 arch/arc/mm/extable.c                     |  14 -
 arch/arm/Kconfig                          |   1 -
 arch/arm/include/asm/Kbuild               |   1 +
 arch/arm/include/asm/uaccess.h            |  87 ++----
 arch/arm/lib/uaccess_with_memcpy.c        |   4 +-
 arch/arm64/Kconfig                        |   1 -
 arch/arm64/include/asm/extable.h          |  25 ++
 arch/arm64/include/asm/uaccess.h          |  83 +-----
 arch/arm64/kernel/arm64ksyms.c            |   2 +-
 arch/arm64/lib/copy_in_user.S             |   4 +-
 arch/avr32/include/asm/Kbuild             |   1 +
 arch/avr32/include/asm/uaccess.h          |  39 +--
 arch/avr32/kernel/avr32_ksyms.c           |   2 -
 arch/avr32/lib/copy_user.S                |  15 -
 arch/blackfin/include/asm/Kbuild          |   1 +
 arch/blackfin/include/asm/uaccess.h       |  47 +---
 arch/blackfin/kernel/process.c            |   2 +-
 arch/c6x/include/asm/Kbuild               |   1 +
 arch/c6x/include/asm/uaccess.h            |  19 +-
 arch/c6x/kernel/sys_c6x.c                 |   2 +-
 arch/cris/arch-v10/lib/usercopy.c         |  31 +--
 arch/cris/arch-v32/lib/usercopy.c         |  30 +-
 arch/cris/include/arch-v10/arch/uaccess.h |  46 ++-
 arch/cris/include/arch-v32/arch/uaccess.h |  54 ++--
 arch/cris/include/asm/Kbuild              |   1 +
 arch/cris/include/asm/uaccess.h           |  77 +----
 arch/frv/include/asm/Kbuild               |   1 +
 arch/frv/include/asm/uaccess.h            |  84 ++----
 arch/frv/kernel/traps.c                   |   7 +-
 arch/frv/mm/extable.c                     |  27 +-
 arch/frv/mm/fault.c                       |   6 +-
 arch/h8300/include/asm/Kbuild             |   2 +-
 arch/h8300/include/asm/uaccess.h          |  54 ++++
 arch/hexagon/include/asm/Kbuild           |   1 +
 arch/hexagon/include/asm/uaccess.h        |  18 +-
 arch/hexagon/kernel/hexagon_ksyms.c       |   4 +-
 arch/hexagon/mm/copy_from_user.S          |   2 +-
 arch/hexagon/mm/copy_to_user.S            |   2 +-
 arch/ia64/Kconfig                         |   1 -
 arch/ia64/include/asm/extable.h           |  11 +
 arch/ia64/include/asm/uaccess.h           | 102 ++-----
 arch/ia64/lib/memcpy_mck.S                |  13 +-
 arch/ia64/mm/extable.c                    |   5 +-
 arch/m32r/include/asm/Kbuild              |   1 +
 arch/m32r/include/asm/uaccess.h           | 189 +------------
 arch/m32r/kernel/m32r_ksyms.c             |   2 -
 arch/m32r/lib/usercopy.c                  |  21 --
 arch/m68k/include/asm/Kbuild              |   1 +
 arch/m68k/include/asm/processor.h         |  10 -
 arch/m68k/include/asm/uaccess.h           |   1 +
 arch/m68k/include/asm/uaccess_mm.h        | 103 ++++---
 arch/m68k/include/asm/uaccess_no.h        |  43 +--
 arch/m68k/kernel/signal.c                 |   2 +-
 arch/m68k/kernel/traps.c                  |   9 +-
 arch/m68k/lib/uaccess.c                   |  12 +-
 arch/m68k/mm/fault.c                      |   2 +-
 arch/metag/include/asm/Kbuild             |   1 +
 arch/metag/include/asm/uaccess.h          |  63 +----
 arch/metag/lib/usercopy.c                 | 318 ++++++++-------------
 arch/microblaze/include/asm/Kbuild        |   1 +
 arch/microblaze/include/asm/uaccess.h     |  62 +----
 arch/mips/Kconfig                         |   1 -
 arch/mips/cavium-octeon/octeon-memcpy.S   |  31 +--
 arch/mips/include/asm/checksum.h          |   4 +-
 arch/mips/include/asm/r4kcache.h          |   4 +-
 arch/mips/include/asm/uaccess.h           | 449 ++++--------------------------
 arch/mips/kernel/mips-r2-to-r6-emul.c     |  24 +-
 arch/mips/kernel/syscall.c                |   2 +-
 arch/mips/kernel/unaligned.c              |  10 +-
 arch/mips/lib/memcpy.S                    |  49 ----
 arch/mips/oprofile/backtrace.c            |   2 +-
 arch/mn10300/include/asm/Kbuild           |   1 +
 arch/mn10300/include/asm/uaccess.h        | 187 +------------
 arch/mn10300/kernel/mn10300_ksyms.c       |   2 -
 arch/mn10300/lib/usercopy.c               |  18 --
 arch/nios2/include/asm/Kbuild             |   1 +
 arch/nios2/include/asm/uaccess.h          |  55 +---
 arch/nios2/mm/uaccess.c                   |  16 +-
 arch/openrisc/include/asm/Kbuild          |   1 +
 arch/openrisc/include/asm/uaccess.h       |  53 +---
 arch/parisc/Kconfig                       |   1 -
 arch/parisc/include/asm/futex.h           |   2 +-
 arch/parisc/include/asm/uaccess.h         |  69 +----
 arch/parisc/lib/memcpy.c                  |  16 +-
 arch/powerpc/Kconfig                      |   1 -
 arch/powerpc/include/asm/extable.h        |  29 ++
 arch/powerpc/include/asm/uaccess.h        |  96 +------
 arch/powerpc/lib/Makefile                 |   2 +-
 arch/powerpc/lib/copy_32.S                |  14 -
 arch/powerpc/lib/copyuser_64.S            |  35 +--
 arch/powerpc/lib/usercopy_64.c            |  41 ---
 arch/s390/Kconfig                         |   1 -
 arch/s390/include/asm/extable.h           |  28 ++
 arch/s390/include/asm/uaccess.h           | 153 +---------
 arch/s390/lib/uaccess.c                   |  68 ++---
 arch/score/include/asm/Kbuild             |   1 +
 arch/score/include/asm/extable.h          |  11 -
 arch/score/include/asm/uaccess.h          |  59 +---
 arch/sh/include/asm/extable.h             |  10 +
 arch/sh/include/asm/uaccess.h             |  64 +----
 arch/sparc/Kconfig                        |   1 -
 arch/sparc/include/asm/uaccess.h          |   2 +-
 arch/sparc/include/asm/uaccess_32.h       |  44 +--
 arch/sparc/include/asm/uaccess_64.h       |  44 +--
 arch/sparc/kernel/head_32.S               |   7 -
 arch/sparc/lib/GENcopy_from_user.S        |   2 +-
 arch/sparc/lib/GENcopy_to_user.S          |   2 +-
 arch/sparc/lib/GENpatch.S                 |   4 +-
 arch/sparc/lib/NG2copy_from_user.S        |   2 +-
 arch/sparc/lib/NG2copy_to_user.S          |   2 +-
 arch/sparc/lib/NG2patch.S                 |   4 +-
 arch/sparc/lib/NG4copy_from_user.S        |   2 +-
 arch/sparc/lib/NG4copy_to_user.S          |   2 +-
 arch/sparc/lib/NG4patch.S                 |   4 +-
 arch/sparc/lib/NGcopy_from_user.S         |   2 +-
 arch/sparc/lib/NGcopy_to_user.S           |   2 +-
 arch/sparc/lib/NGpatch.S                  |   4 +-
 arch/sparc/lib/U1copy_from_user.S         |   4 +-
 arch/sparc/lib/U1copy_to_user.S           |   4 +-
 arch/sparc/lib/U3copy_to_user.S           |   2 +-
 arch/sparc/lib/U3patch.S                  |   4 +-
 arch/sparc/lib/copy_in_user.S             |   6 +-
 arch/sparc/lib/copy_user.S                |  16 +-
 arch/tile/include/asm/Kbuild              |   1 +
 arch/tile/include/asm/uaccess.h           | 166 +----------
 arch/tile/lib/exports.c                   |   7 +-
 arch/tile/lib/memcpy_32.S                 |  41 +--
 arch/tile/lib/memcpy_user_64.c            |  15 +-
 arch/um/include/asm/Kbuild                |   1 +
 arch/um/include/asm/uaccess.h             |  13 +-
 arch/um/kernel/skas/uaccess.c             |  18 +-
 arch/unicore32/include/asm/Kbuild         |   1 +
 arch/unicore32/include/asm/uaccess.h      |  15 +-
 arch/unicore32/kernel/ksyms.c             |   4 +-
 arch/unicore32/kernel/process.c           |   2 +-
 arch/unicore32/lib/copy_from_user.S       |  16 +-
 arch/unicore32/lib/copy_to_user.S         |   6 +-
 arch/x86/Kconfig                          |   1 -
 arch/x86/include/asm/uaccess.h            |  70 +----
 arch/x86/include/asm/uaccess_32.h         | 127 +--------
 arch/x86/include/asm/uaccess_64.h         | 128 +--------
 arch/x86/lib/usercopy.c                   |  54 +---
 arch/x86/lib/usercopy_32.c                | 288 +------------------
 arch/x86/lib/usercopy_64.c                |  13 -
 arch/xtensa/include/asm/Kbuild            |   1 +
 arch/xtensa/include/asm/asm-uaccess.h     |   3 -
 arch/xtensa/include/asm/uaccess.h         |  67 +----
 arch/xtensa/lib/usercopy.S                | 116 ++++----
 block/bsg.c                               |   2 +-
 drivers/net/ethernet/ibm/ibmvnic.c        | 100 +++----
 drivers/scsi/esas2r/esas2r_ioctl.c        |  25 +-
 drivers/scsi/sg.c                         |   2 +-
 fs/ocfs2/cluster/tcp.c                    |  25 +-
 include/asm-generic/extable.h             |  26 ++
 include/asm-generic/uaccess.h             | 135 +--------
 include/linux/uaccess.h                   | 197 ++++++++++++-
 include/rdma/ib.h                         |   2 +-
 kernel/trace/bpf_trace.c                  |   2 +-
 lib/Makefile                              |   2 +-
 lib/iov_iter.c                            |   6 +-
 lib/usercopy.c                            |  26 ++
 mm/memory.c                               |   2 +-
 net/rds/tcp.c                             |   5 +-
 net/rds/tcp_send.c                        |   8 +-
 security/Kconfig                          |   9 -
 security/tomoyo/network.c                 |   2 +-
 178 files changed, 1608 insertions(+), 4592 deletions(-)
 create mode 100644 arch/alpha/include/asm/extable.h
 create mode 100644 arch/arm64/include/asm/extable.h
 create mode 100644 arch/h8300/include/asm/uaccess.h
 create mode 100644 arch/ia64/include/asm/extable.h
 create mode 100644 arch/powerpc/include/asm/extable.h
 delete mode 100644 arch/powerpc/lib/usercopy_64.c
 create mode 100644 arch/s390/include/asm/extable.h
 delete mode 100644 arch/score/include/asm/extable.h
 create mode 100644 arch/sh/include/asm/extable.h
 create mode 100644 include/asm-generic/extable.h
 create mode 100644 lib/usercopy.c
