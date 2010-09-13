From: "H. Peter Anvin" <hpa@linux.intel.com>
Subject: [RFC PATCH 0/5] Bump gcc minimum version to 3.4, 4.1 for x86
Date: Mon, 13 Sep 2010 13:14:35 -0700
Message-ID: <1284408880-14414-1-git-send-email-hpa@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Florian Mickler <florian@mickler.org>, Peter Zijlstra <peterz@infradead.org>, Russell King <linux@arm.linux.org.uk>, Mike Frysinger <vapier@gentoo.org>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>
List-Id: linux-arch.vger.kernel.org

This patchset bumps the minimum supported gcc version to 3.4 for the
general kernel, and to 4.1 for x86.

We have had a rash of bug reports related to these really old
compilers and their associated binutils version lately, and it is
clear that the support burden of these older compilers is getting to
be excessive.  If you really want to build a kernel on a system that
old you can build or obtain an updated gcc/binutils as well.

 Documentation/Changes             |    2 +-
 arch/x86/include/asm/bitops.h     |    7 -------
 arch/x86/include/asm/cpufeature.h |    7 -------
 arch/x86/include/asm/string_32.h  |   21 ---------------------
 arch/x86/kernel/Makefile          |    3 ++-
 arch/x86/kernel/compiler.c        |    5 +++++
 include/linux/compiler-gcc3.h     |   15 +--------------
 7 files changed, 9 insertions(+), 51 deletions(-)
