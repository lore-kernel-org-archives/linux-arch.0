From: "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 00/24] Unify integer type definitions, and add fixed type constructor macros
Date: Thu, 24 Apr 2008 16:05:07 -0700
Message-ID: <1209078352-7593-1-git-send-email-hpa@zytor.com>
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Arch Mailing List <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>


This patchset unifies the integer definitions across all the
<asm-*/types.h> files, replacing them with two asm-generic files, one
for the LL64 model (all 32-bit architectures plus x86-64) and one for
the L64 model (all other 64-bit architectures.)

The latter patches introduce constructor macros, similar to the C99
<inttypes.h> macros, e.g. U64_C(0x123456789abcdef), which produces the
same result as (u64)0x123456789abcdef but (a) is usable in the
preprocessor, (b) doesn't generate warnings, (c) is transparently
ignored for assembly.

The final patch uses said constructor macros to remove nuisance
warnings from kernel/time.c.

This patchset is also pullable as a git tree from:

     git://git.kernel.org/pub/scm/linux/kernel/git/hpa/linux-2.6-inttypes.git

 include/asm-alpha/types.h      |   36 +---------------
 include/asm-arm/types.h        |   33 +-------------
 include/asm-avr32/types.h      |   32 +------------
 include/asm-blackfin/types.h   |   34 +-------------
 include/asm-cris/types.h       |   33 +-------------
 include/asm-frv/types.h        |   34 +-------------
 include/asm-generic/Kbuild     |    2 +
 include/asm-generic/int-l64.h  |   71 +++++++++++++++++++++++++++++
 include/asm-generic/int-ll64.h |   76 ++++++++++++++++++++++++++++++++
 include/asm-h8300/types.h      |   33 +-------------
 include/asm-ia64/types.h       |   31 +------------
 include/asm-m32r/types.h       |   32 +------------
 include/asm-m68k/types.h       |   32 +-------------
 include/asm-mips/types.h       |   56 +++---------------------
 include/asm-mn10300/types.h    |   33 +-------------
 include/asm-parisc/types.h     |   33 +-------------
 include/asm-powerpc/types.h    |   48 +++-----------------
 include/asm-s390/types.h       |   48 +++-----------------
 include/asm-sh/types.h         |   34 +-------------
 include/asm-sparc/types.h      |   30 +------------
 include/asm-sparc64/types.h    |   30 +------------
 include/asm-v850/types.h       |   32 +-------------
 include/asm-x86/types.h        |   38 +---------------
 include/asm-xtensa/types.h     |   33 +-------------
 kernel/time.c                  |    8 ++--
 25 files changed, 201 insertions(+), 701 deletions(-)
