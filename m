From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: [RFC][PATCHSET] allowing exports in *.S
Date: Fri, 29 Jan 2016 19:17:44 +0000
Message-ID: <20160129191744.GB17997@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kbuild-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kbuild-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

	The policy wrt exports right now is "put it next to the definition
of object being exported, unless it's in assembler".  The reasons for having
an export near the definition are obvious - it's easier to keep things
in sync that way, the fact that function can be called by modules is
obvious without grepping through the entire tree, etc.

	The major exception is for things defined in assembler - exports
of those are kept in arch/*/*/*ksyms*.c.  The reason is that EXPORT_SYMBOL
and friends can't be used from assembler; all the reasons to keep them
with definitions still apply, but we simply can't do that.

	Another unpleasant issue is that lib-y objects need to be careful
about their exports - it *is* done in quite a few places, but it's only
legitimate as long as any .config either doesn't include any modules
using a symbol in question _or_ has built-in users of something from the
same object.  For something like ctype.c the latter is a safe bet, but
something more subtle can suddenly get into trouble years later when
such a config becomes possible - the lack of built-in users ends up with
linker not picking the object at all, which leads to missing export.
As the result, we have things like "here's a long series of lib-y,
with that object in the middle going into obj-y" with no indication of the
reasons why *and* nothing to guarantee that we won't need the same treatment
for other objects there.

	It is connected to the former, since quite a few *.S that contain
exported functions happen to be in lib-y.

	This series (available in vfs.git#work.asm-exports) introduces
a new header (asm/export.h), to be included from *.S and defining variants
of EXPORT_SYMBOL and EXPORT_SYMBOL_GPL usable there.  It also allows
safe exports from lib-* - any object that contains an export after it's
been compiled gets automatically pulled into vmlinux.

	The only real restriction left is that if you have a weak symbol,
exporting it from the same object file will forcibly peek _that_ definition,
even if the symbol itself is overridden by another alternative at link time.

The first patch allows to export safely from lib-*, the second one adds
asm-generic/export.h, usable as-is for almost all architectures.  The only
exceptions are 64bit x86, which wants unusually strong alignment for
struct kernel_symbol and m68k, which wants only 16bit alignements for pointers
(and for struct kernel_symbol as well).  Such an architecture can add
asm/export.h that defines a couple of macros (KSYM_ALIGN and KCRC_ALIGN)
and includes <asm-generic/export.h>.  Normally you only need to add
generic-y += export.h to asm/Kbuild; of course, if you don't put any exports
into asm files, you don't need to do anything at all.

The rest of that series is mostly proof-of-concept "let's take exports on
<architecture> to the matching definitions" for a bunch of architectures;
it's more of a demonstration that it can be done - any given architecture
might prefer to add convenience macros, etc.  This is just adding includes
of asm/export.h and moves EXPORT_SYMBOL/EXPORT_SYMBOL_GPL to *.S.  Usually
it ends up with arch/*/*/*ksym*.c gone.

A bunch of detritus had been found and removed in process - e.g. exports of
static inline, functions that had lost both in-tree callers and export, but
forgotten and left behind, etc.  I'm fairly sure that more junk like that
is out there; that's one of the reasons why exports really ought to be near
the definitions...

Of course, we don't have to move all exports at once (or move them at all);
it's not a flagday conversion.  The whole series so far can be picked at
git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.asm-exports;
I'll post individual patches in followups.

Please, review and comment.

Shortlog:
Al Viro (12):
      [kbuild] handle exports in lib-y objects reliably
      EXPORT_SYMBOL() for asm
      x86: move exports to actual definitions
      alpha: move exports to actual definitions
      m68k: move exports to definitions
      s390: move exports to definitions
      arm: move exports to definitions
      ppc: move exports to definitions
      sparc: move exports to definitions
      ia64: move exports to definitions
      [sparc] unify 32bit and 64bit string.h
      sparc32: debride memcpy.S a bit

Diffstat:
 arch/alpha/include/asm/Kbuild         |   1 +
 arch/alpha/kernel/Makefile            |   2 +-
 arch/alpha/kernel/alpha_ksyms.c       | 102 -------------------
 arch/alpha/kernel/machvec_impl.h      |   6 +-
 arch/alpha/kernel/setup.c             |   1 +
 arch/alpha/lib/callback_srm.S         |   5 +
 arch/alpha/lib/checksum.c             |   3 +
 arch/alpha/lib/clear_page.S           |   3 +-
 arch/alpha/lib/clear_user.S           |   2 +
 arch/alpha/lib/copy_page.S            |   3 +-
 arch/alpha/lib/copy_user.S            |   3 +
 arch/alpha/lib/csum_ipv6_magic.S      |   2 +
 arch/alpha/lib/csum_partial_copy.c    |   2 +
 arch/alpha/lib/dec_and_lock.c         |   2 +
 arch/alpha/lib/divide.S               |   3 +
 arch/alpha/lib/ev6-clear_page.S       |   3 +-
 arch/alpha/lib/ev6-clear_user.S       |   3 +-
 arch/alpha/lib/ev6-copy_page.S        |   3 +-
 arch/alpha/lib/ev6-copy_user.S        |   3 +-
 arch/alpha/lib/ev6-csum_ipv6_magic.S  |   2 +
 arch/alpha/lib/ev6-divide.S           |   3 +
 arch/alpha/lib/ev6-memchr.S           |   3 +-
 arch/alpha/lib/ev6-memcpy.S           |   3 +-
 arch/alpha/lib/ev6-memset.S           |   7 +-
 arch/alpha/lib/ev67-strcat.S          |   3 +-
 arch/alpha/lib/ev67-strchr.S          |   3 +-
 arch/alpha/lib/ev67-strlen.S          |   3 +-
 arch/alpha/lib/ev67-strncat.S         |   3 +-
 arch/alpha/lib/ev67-strrchr.S         |   3 +-
 arch/alpha/lib/fpreg.c                |   7 ++
 arch/alpha/lib/memchr.S               |   3 +-
 arch/alpha/lib/memcpy.c               |   5 +-
 arch/alpha/lib/memmove.S              |   3 +-
 arch/alpha/lib/memset.S               |   7 +-
 arch/alpha/lib/strcat.S               |   2 +
 arch/alpha/lib/strchr.S               |   3 +-
 arch/alpha/lib/strcpy.S               |   3 +-
 arch/alpha/lib/strlen.S               |   3 +-
 arch/alpha/lib/strncat.S              |   3 +-
 arch/alpha/lib/strncpy.S              |   3 +-
 arch/alpha/lib/strrchr.S              |   3 +-
 arch/arm/include/asm/Kbuild           |   1 +
 arch/arm/kernel/Makefile              |   2 +-
 arch/arm/kernel/armksyms.c            | 183 ----------------------------------
 arch/arm/kernel/entry-ftrace.S        |   3 +
 arch/arm/kernel/head.S                |   3 +
 arch/arm/kernel/smccc-call.S          |   3 +
 arch/arm/lib/ashldi3.S                |   3 +
 arch/arm/lib/ashrdi3.S                |   3 +
 arch/arm/lib/bitops.h                 |   5 +
 arch/arm/lib/bswapsdi2.S              |   3 +
 arch/arm/lib/clear_user.S             |   4 +
 arch/arm/lib/copy_from_user.S         |   2 +
 arch/arm/lib/copy_page.S              |   2 +
 arch/arm/lib/copy_to_user.S           |   4 +
 arch/arm/lib/csumipv6.S               |   3 +-
 arch/arm/lib/csumpartial.S            |   2 +
 arch/arm/lib/csumpartialcopy.S        |   1 +
 arch/arm/lib/csumpartialcopygeneric.S |   2 +
 arch/arm/lib/csumpartialcopyuser.S    |   1 +
 arch/arm/lib/delay.c                  |   2 +
 arch/arm/lib/div64.S                  |   2 +
 arch/arm/lib/findbit.S                |   9 ++
 arch/arm/lib/getuser.S                |   9 ++
 arch/arm/lib/io-readsb.S              |   2 +
 arch/arm/lib/io-readsl.S              |   2 +
 arch/arm/lib/io-readsw-armv3.S        |   3 +-
 arch/arm/lib/io-readsw-armv4.S        |   2 +
 arch/arm/lib/io-writesb.S             |   2 +
 arch/arm/lib/io-writesl.S             |   2 +
 arch/arm/lib/io-writesw-armv3.S       |   2 +
 arch/arm/lib/io-writesw-armv4.S       |   2 +
 arch/arm/lib/lib1funcs.S              |   9 ++
 arch/arm/lib/lshrdi3.S                |   3 +
 arch/arm/lib/memchr.S                 |   2 +
 arch/arm/lib/memcpy.S                 |   3 +
 arch/arm/lib/memmove.S                |   2 +
 arch/arm/lib/memset.S                 |   3 +
 arch/arm/lib/memzero.S                |   2 +
 arch/arm/lib/muldi3.S                 |   3 +
 arch/arm/lib/putuser.S                |   5 +
 arch/arm/lib/strchr.S                 |   2 +
 arch/arm/lib/strrchr.S                |   2 +
 arch/arm/lib/uaccess_with_memcpy.c    |   3 +
 arch/arm/lib/ucmpdi2.S                |   3 +
 arch/arm/mach-imx/Makefile            |   1 -
 arch/arm/mach-imx/ssi-fiq-ksym.c      |  20 ----
 arch/arm/mach-imx/ssi-fiq.S           |   7 +-
 arch/ia64/include/asm/Kbuild          |   1 +
 arch/ia64/kernel/entry.S              |   3 +
 arch/ia64/kernel/esi_stub.S           |   2 +
 arch/ia64/kernel/head.S               |   3 +
 arch/ia64/kernel/ia64_ksyms.c         |  94 +----------------
 arch/ia64/kernel/ivt.S                |   2 +
 arch/ia64/kernel/pal.S                |   7 ++
 arch/ia64/kernel/setup.c              |   4 +
 arch/ia64/lib/clear_page.S            |   2 +
 arch/ia64/lib/clear_user.S            |   2 +
 arch/ia64/lib/copy_page.S             |   2 +
 arch/ia64/lib/copy_page_mck.S         |   2 +
 arch/ia64/lib/copy_user.S             |   2 +
 arch/ia64/lib/flush.S                 |   2 +
 arch/ia64/lib/idiv32.S                |   2 +
 arch/ia64/lib/idiv64.S                |   2 +
 arch/ia64/lib/ip_fast_csum.S          |   3 +
 arch/ia64/lib/memcpy.S                |   2 +
 arch/ia64/lib/memcpy_mck.S            |   3 +
 arch/ia64/lib/memset.S                |   2 +
 arch/ia64/lib/strlen.S                |   2 +
 arch/ia64/lib/strlen_user.S           |   2 +
 arch/ia64/lib/strncpy_from_user.S     |   2 +
 arch/ia64/lib/strnlen_user.S          |   2 +
 arch/ia64/lib/xor.S                   |   5 +
 arch/m68k/include/asm/export.h        |   3 +
 arch/m68k/kernel/Makefile             |   2 +-
 arch/m68k/kernel/m68k_ksyms.c         |  32 ------
 arch/m68k/lib/ashldi3.c               |   4 +
 arch/m68k/lib/ashrdi3.c               |   4 +
 arch/m68k/lib/divsi3.S                |   3 +
 arch/m68k/lib/lshrdi3.c               |   4 +
 arch/m68k/lib/modsi3.S                |   3 +
 arch/m68k/lib/muldi3.c                |   4 +
 arch/m68k/lib/mulsi3.S                |   4 +-
 arch/m68k/lib/udivsi3.S               |   4 +-
 arch/m68k/lib/umodsi3.S               |   4 +-
 arch/powerpc/include/asm/Kbuild       |   1 +
 arch/powerpc/kernel/Makefile          |   4 -
 arch/powerpc/kernel/entry_32.S        |   2 +
 arch/powerpc/kernel/entry_64.S        |   3 +
 arch/powerpc/kernel/epapr_hcalls.S    |   2 +
 arch/powerpc/kernel/fpu.S             |   3 +
 arch/powerpc/kernel/head_32.S         |   5 +
 arch/powerpc/kernel/head_40x.S        |   2 +
 arch/powerpc/kernel/head_44x.S        |   2 +
 arch/powerpc/kernel/head_64.S         |   2 +
 arch/powerpc/kernel/head_8xx.S        |   2 +
 arch/powerpc/kernel/head_fsl_booke.S  |   2 +
 arch/powerpc/kernel/misc.S            |   2 +
 arch/powerpc/kernel/misc_32.S         |  12 +++
 arch/powerpc/kernel/misc_64.S         |   4 +
 arch/powerpc/kernel/pci-common.c      |   1 +
 arch/powerpc/kernel/pci_32.c          |   2 +
 arch/powerpc/kernel/ppc_ksyms.c       |  39 --------
 arch/powerpc/kernel/ppc_ksyms_32.c    |  61 ------------
 arch/powerpc/kernel/setup_32.c        |   6 ++
 arch/powerpc/kernel/time.c            |   1 +
 arch/powerpc/kernel/vector.S          |   4 +
 arch/powerpc/lib/Makefile             |   2 +-
 arch/powerpc/lib/checksum_32.S        |   4 +
 arch/powerpc/lib/checksum_64.S        |   4 +
 arch/powerpc/lib/copy_32.S            |   5 +
 arch/powerpc/lib/copypage_64.S        |   2 +
 arch/powerpc/lib/copyuser_64.S        |   2 +
 arch/powerpc/lib/hweight_64.S         |   5 +
 arch/powerpc/lib/mem_64.S             |   3 +
 arch/powerpc/lib/memcmp_64.S          |   2 +
 arch/powerpc/lib/memcpy_64.S          |   2 +
 arch/powerpc/lib/ppc_ksyms.c          |  35 -------
 arch/powerpc/lib/string.S             |  10 ++
 arch/powerpc/lib/string_64.S          |   2 +
 arch/powerpc/mm/hash_low_32.S         |   3 +
 arch/powerpc/sysdev/dcr-low.S         |   3 +
 arch/s390/include/asm/Kbuild          |   1 +
 arch/s390/kernel/Makefile             |   2 +-
 arch/s390/kernel/entry.S              |   6 ++
 arch/s390/kernel/mcount.S             |   3 +
 arch/s390/kernel/s390_ksyms.c         |  15 ---
 arch/s390/lib/mem.S                   |   3 +
 arch/sparc/include/asm/Kbuild         |   1 +
 arch/sparc/include/asm/string.h       |  34 +++++++
 arch/sparc/include/asm/string_32.h    |  56 -----------
 arch/sparc/include/asm/string_64.h    |  44 --------
 arch/sparc/kernel/Makefile            |   2 +-
 arch/sparc/kernel/entry.S             |   3 +
 arch/sparc/kernel/head_32.S           |   3 +
 arch/sparc/kernel/head_64.S           |   7 +-
 arch/sparc/kernel/helpers.S           |   2 +
 arch/sparc/kernel/hvcalls.S           |   4 +
 arch/sparc/kernel/sparc_ksyms.c       |  12 +++
 arch/sparc/kernel/sparc_ksyms_32.c    |  31 ------
 arch/sparc/kernel/sparc_ksyms_64.c    |  52 ----------
 arch/sparc/lib/Makefile               |   1 -
 arch/sparc/lib/U1memcpy.S             |   2 +
 arch/sparc/lib/VISsave.S              |   2 +
 arch/sparc/lib/ashldi3.S              |   2 +
 arch/sparc/lib/ashrdi3.S              |   2 +
 arch/sparc/lib/atomic_64.S            |  10 +-
 arch/sparc/lib/bitops.S               |   7 ++
 arch/sparc/lib/blockops.S             |   3 +
 arch/sparc/lib/bzero.S                |   4 +
 arch/sparc/lib/checksum_32.S          |   3 +
 arch/sparc/lib/checksum_64.S          |   2 +
 arch/sparc/lib/clear_page.S           |   3 +
 arch/sparc/lib/copy_in_user.S         |   2 +
 arch/sparc/lib/copy_page.S            |   2 +
 arch/sparc/lib/copy_user.S            |   2 +
 arch/sparc/lib/csum_copy.S            |   3 +
 arch/sparc/lib/divdi3.S               |   2 +
 arch/sparc/lib/ffs.S                  |   3 +
 arch/sparc/lib/hweight.S              |   5 +
 arch/sparc/lib/ipcsum.S               |   2 +
 arch/sparc/lib/ksyms.c                | 165 ------------------------------
 arch/sparc/lib/locks.S                |   5 +
 arch/sparc/lib/lshrdi3.S              |   2 +
 arch/sparc/lib/mcount.S               |   2 +
 arch/sparc/lib/memcmp.S               |   2 +
 arch/sparc/lib/memcpy.S               |  86 +---------------
 arch/sparc/lib/memmove.S              |   2 +
 arch/sparc/lib/memscan_32.S           |   4 +
 arch/sparc/lib/memscan_64.S           |   4 +
 arch/sparc/lib/memset.S               |   3 +
 arch/sparc/lib/muldi3.S               |   2 +
 arch/sparc/lib/strlen.S               |   2 +
 arch/sparc/lib/strncmp_32.S           |   2 +
 arch/sparc/lib/strncmp_64.S           |   2 +
 arch/sparc/lib/xor.S                  |   9 ++
 arch/x86/entry/entry_32.S             |   2 +
 arch/x86/entry/entry_64.S             |   2 +
 arch/x86/entry/thunk_32.S             |   3 +
 arch/x86/entry/thunk_64.S             |   3 +
 arch/x86/include/asm/export.h         |   4 +
 arch/x86/kernel/Makefile              |   4 +-
 arch/x86/kernel/head_32.S             |   2 +
 arch/x86/kernel/head_64.S             |   3 +
 arch/x86/kernel/i386_ksyms_32.c       |  44 --------
 arch/x86/kernel/mcount_64.S           |   2 +
 arch/x86/kernel/x8664_ksyms_64.c      |  79 ---------------
 arch/x86/lib/checksum_32.S            |   3 +
 arch/x86/lib/clear_page_64.S          |   2 +
 arch/x86/lib/cmpxchg8b_emu.S          |   2 +
 arch/x86/lib/copy_page_64.S           |   2 +
 arch/x86/lib/copy_user_64.S           |   8 ++
 arch/x86/lib/csum-partial_64.c        |   1 +
 arch/x86/lib/getuser.S                |   5 +
 arch/x86/lib/memcpy_64.S              |   3 +
 arch/x86/lib/memmove_64.S             |   3 +
 arch/x86/lib/memset_64.S              |   3 +
 arch/x86/lib/putuser.S                |   5 +
 arch/x86/lib/strstr_32.c              |   3 +-
 arch/x86/um/Makefile                  |   2 +-
 arch/x86/um/checksum_32.S             |   2 +
 arch/x86/um/ksyms.c                   |  13 ---
 include/asm-generic/export.h          |  61 ++++++++++++
 scripts/Makefile.build                |  20 ++++
 244 files changed, 759 insertions(+), 1203 deletions(-)
 delete mode 100644 arch/alpha/kernel/alpha_ksyms.c
 delete mode 100644 arch/arm/kernel/armksyms.c
 delete mode 100644 arch/arm/mach-imx/ssi-fiq-ksym.c
 create mode 100644 arch/m68k/include/asm/export.h
 delete mode 100644 arch/m68k/kernel/m68k_ksyms.c
 delete mode 100644 arch/powerpc/kernel/ppc_ksyms.c
 delete mode 100644 arch/powerpc/kernel/ppc_ksyms_32.c
 delete mode 100644 arch/powerpc/lib/ppc_ksyms.c
 delete mode 100644 arch/s390/kernel/s390_ksyms.c
 create mode 100644 arch/sparc/kernel/sparc_ksyms.c
 delete mode 100644 arch/sparc/kernel/sparc_ksyms_32.c
 delete mode 100644 arch/sparc/kernel/sparc_ksyms_64.c
 delete mode 100644 arch/sparc/lib/ksyms.c
 create mode 100644 arch/x86/include/asm/export.h
 delete mode 100644 arch/x86/kernel/i386_ksyms_32.c
 delete mode 100644 arch/x86/kernel/x8664_ksyms_64.c
 delete mode 100644 arch/x86/um/ksyms.c
 create mode 100644 include/asm-generic/export.h
