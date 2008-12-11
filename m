From: Kyle McMartin <kyle@mcmartin.ca>
Subject: [RFC PATCH 00/19] unify init_task
Date: Thu, 11 Dec 2008 03:52:38 +0000
Message-ID: <cover.1228966585.git.kyle@mcmartin.ca>
References: <cover.1228966585.git.kyle@mcmartin.ca>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:57593 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752500AbYLKDxB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 10 Dec 2008 22:53:01 -0500
In-Reply-To: <cover.1228966585.git.kyle@mcmartin.ca>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Kyle McMartin <kyle@mcmartin.ca>

Create a common kernel/init_task.c, and convert low hanging fruit to
use it. Architecture maintainers will need to ensure that I didn't
break anything before applying the init_task removal patch to their
arch.

A few architectures appear to possibly rely on link-ordering (with
an extra-y makefile rule) and may need additional linker script rules.

Unconverted architectures so far are m68k (because it doesn't use an explicit
init_task.c), ia64 (because it faffs about with init_thread_union), and
sparc{,64} (which appear to rely on some magic.)

The other open question is what to do about init_mm, which was supposed to be
removed in 2.6.26...

Kyle McMartin (19):
  add HAVE_ARCH_INIT_TASK
  add generic kernel/init_task.c
  x86: convert to generic init_task.c
  alpha: rename .data.init_thread to .data.init_task
  alpha: convert to generic init_task.c
  arm: convert to generic init_task.c
  avr32: convert to generic init_task.c
  blackfin: convert to generic init_task.c
  frv: convert to generic init_task.c
  h8300: convert to generic init_task.c
  m32r: convert to generic init_task.c
  m68knommu: convert to generic init_task.c
  mips: convert to generic init_task.c
  mn10300: convert to generic init_task.c
  parisc: convert to generic init_task.c
  powerpc: convert to generic init_task.c
  s390: convert to generic init_task.c
  sh: convert to generic init_task.c
  xtensa: convert to generic init_task.c

 arch/Kconfig                      |    9 +++++
 arch/alpha/kernel/Makefile        |    2 +-
 arch/alpha/kernel/init_task.c     |   22 -------------
 arch/alpha/kernel/vmlinux.lds.S   |    4 +-
 arch/arm/kernel/Makefile          |    2 +-
 arch/arm/kernel/init_task.c       |   43 --------------------------
 arch/avr32/kernel/Makefile        |    2 +-
 arch/avr32/kernel/init_task.c     |   37 ----------------------
 arch/blackfin/kernel/Makefile     |    2 +-
 arch/blackfin/kernel/init_task.c  |   60 -------------------------------------
 arch/cris/Kconfig                 |    1 +
 arch/frv/kernel/Makefile          |    2 +-
 arch/frv/kernel/init_task.c       |   38 -----------------------
 arch/h8300/kernel/Makefile        |    2 +-
 arch/h8300/kernel/init_task.c     |   42 --------------------------
 arch/ia64/Kconfig                 |    1 +
 arch/m32r/kernel/Makefile         |    2 +-
 arch/m32r/kernel/init_task.c      |   40 ------------------------
 arch/m68k/Kconfig                 |    1 +
 arch/m68knommu/kernel/Makefile    |    2 +-
 arch/m68knommu/kernel/init_task.c |   42 --------------------------
 arch/mips/kernel/Makefile         |    2 +-
 arch/mips/kernel/init_task.c      |   41 -------------------------
 arch/mn10300/kernel/Makefile      |    2 +-
 arch/mn10300/kernel/init_task.c   |   44 ---------------------------
 arch/parisc/kernel/init_task.c    |   28 -----------------
 arch/powerpc/kernel/Makefile      |    2 +-
 arch/powerpc/kernel/init_task.c   |   35 ---------------------
 arch/s390/kernel/Makefile         |    2 +-
 arch/s390/kernel/init_task.c      |   44 ---------------------------
 arch/sh/kernel/init_task.c        |   25 ---------------
 arch/sparc/Kconfig                |    1 +
 arch/sparc64/Kconfig              |    1 +
 arch/x86/kernel/init_task.c       |   25 ---------------
 arch/xtensa/kernel/Makefile       |    2 +-
 arch/xtensa/kernel/init_task.c    |   37 ----------------------
 kernel/Makefile                   |    4 ++
 kernel/init_task.c                |   36 ++++++++++++++++++++++
 38 files changed, 69 insertions(+), 618 deletions(-)
 delete mode 100644 arch/alpha/kernel/init_task.c
 delete mode 100644 arch/arm/kernel/init_task.c
 delete mode 100644 arch/avr32/kernel/init_task.c
 delete mode 100644 arch/blackfin/kernel/init_task.c
 delete mode 100644 arch/frv/kernel/init_task.c
 delete mode 100644 arch/h8300/kernel/init_task.c
 delete mode 100644 arch/m32r/kernel/init_task.c
 delete mode 100644 arch/m68knommu/kernel/init_task.c
 delete mode 100644 arch/mips/kernel/init_task.c
 delete mode 100644 arch/mn10300/kernel/init_task.c
 delete mode 100644 arch/powerpc/kernel/init_task.c
 delete mode 100644 arch/s390/kernel/init_task.c
 delete mode 100644 arch/xtensa/kernel/init_task.c
 create mode 100644 kernel/init_task.c
