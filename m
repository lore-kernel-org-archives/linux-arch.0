From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: [RFC][PATCHES] termios.h cleanups
Date: Mon, 10 Sep 2018 05:49:37 +0100
Message-ID: <20180910044937.GJ19965@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

	asm/termios.h has tons of duplication and rather
convoluted logics re includes.

	First of all, while everyone has uapi asm/termios.h,
some architectures have asm/termios.h and some do not.  So
include of <asm/termios.h> can go either to arch asm/termios.h,
or to uapi/asm/termios.h.
	In the former case asm/termios.h defines a bunch of
helpers (used in just one file) and a constant (3 more users)
and includes uapi/asm/termios.h
	In the latter... uapi/asm/termios.h is in generated-y
or equivalent to it.  Which is to say, it ends up doing
#include <asm-generic/termios.h>.  Userland-side that would
refer to uapi/asm-generic/termios.h, but kernel-side we end
up with plain asm-generic/termios.h.  Which defines the same
set of helpers and a constant and pulls uapi/asm-generic/termios.h

	Helpers in question are heavily shared; there is an attempt
to put them into a common header (termios-base.h), but not all
instances use it.  Another unpleasant thing is that said helpers
tend to be macros, with very little typechecking.  And all of that
is pulled in by a lot more places than those that are actually
interested - 500-odd instead of 4.

	Below is an attempt to untangle that; the branch is vfs.git#work.termios,
patches in followups.  FWIW, diffstat is

 arch/Kconfig                                       |   3 +
 arch/alpha/Kconfig                                 |   1 +
 arch/alpha/include/asm/termios.h                   |  81 ------------
 arch/alpha/include/asm/termios_internal.h          |  72 ++++++++++
 arch/ia64/include/asm/termios.h                    |  58 --------
 arch/mips/include/asm/termios.h                    | 105 ---------------
 arch/parisc/include/asm/termios.h                  |  52 --------
 arch/powerpc/Kconfig                               |   1 +
 .../include/asm/{termios.h => termios_internal.h}  |   7 +-
 arch/riscv/include/asm/Kbuild                      |   1 -
 arch/s390/include/asm/termios.h                    |  26 ----
 arch/sparc/Kconfig                                 |   1 +
 arch/sparc/include/asm/termios.h                   | 147 ---------------------
 arch/sparc/include/asm/termios_internal.h          | 134 +++++++++++++++++++
 arch/x86/include/uapi/asm/Kbuild                   |   1 +
 arch/x86/include/uapi/asm/termios.h                |   1 -
 drivers/tty/hvc/hvcs.c                             |   1 +
 drivers/tty/n_hdlc.c                               |   1 -
 drivers/tty/tty_io.c                               |   1 +
 drivers/tty/tty_ioctl.c                            |   1 +
 drivers/tty/vcc.c                                  |   1 +
 include/asm-generic/termios-base.h                 |  78 -----------
 include/asm-generic/termios.h                      | 108 ---------------
 include/linux/termios_internal.h                   | 137 +++++++++++++++++++
 24 files changed, 355 insertions(+), 664 deletions(-)
 delete mode 100644 arch/alpha/include/asm/termios.h
 create mode 100644 arch/alpha/include/asm/termios_internal.h
 delete mode 100644 arch/ia64/include/asm/termios.h
 delete mode 100644 arch/mips/include/asm/termios.h
 delete mode 100644 arch/parisc/include/asm/termios.h
 rename arch/powerpc/include/asm/{termios.h => termios_internal.h} (70%)
 delete mode 100644 arch/s390/include/asm/termios.h
 delete mode 100644 arch/sparc/include/asm/termios.h
 create mode 100644 arch/sparc/include/asm/termios_internal.h
 delete mode 100644 arch/x86/include/uapi/asm/termios.h
 delete mode 100644 include/asm-generic/termios-base.h
 delete mode 100644 include/asm-generic/termios.h
 create mode 100644 include/linux/termios_internal.h
