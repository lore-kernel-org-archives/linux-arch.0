From: Richard Weinberger <richard@nod.at>
Subject: [RFC] Get rid of SUBARCH
Date: Wed, 21 Aug 2013 10:19:24 +0200
Message-ID: <1377073172-3662-1-git-send-email-richard@nod.at>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: mmarek@suse.cz, geert@linux-m68k.org, ralf@linux-mips.org, lethal@linux-sh.org, jdike@addtoit.com, gxt@mprc.pku.edu.cn, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@linux-mips.org, linux-sh@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
List-Id: linux-arch.vger.kernel.org

This series is an attempt to remove the SUBARCH make parameter.
It as introduced at the times of Linux 2.5 for UML to tell the UML
build system what the real architecture is.

But we actually don't need SUBARCH, we can store this information
in the .config file.
i386_defconfig will produce a kernel for x86, and x86_64_defconfig
for x86_64. There is no need to specify SUBARCH.
With this patchset applied you can build UML always with "make linux ARCH=um"
and it will produce the an image for the architecture specified in your .config.
Currenlty "make linux ARCH=um" will alter your .config to match the detected SUBARCH
whith sucks and causes problems on automated build systems.

The series touches also m68k, sh, mips and unicore32.
These architectures magically select a cross compiler if ARCH != SUBARCH.
Do really need that behavior?

[PATCH 1/8] um: Create defconfigs for i386 and x86_64
[PATCH 2/8] um: Do not use SUBARCH
[PATCH 3/8] um: Remove old defconfig
[PATCH 4/8] m68k: Do not use SUBARCH
[PATCH 5/8] sh: Do not use SUBARCH
[PATCH 6/8] mips: Do not use SUBARCH
[PATCH 7/8] unicore32: Do not use SUBARCH
[PATCH 8/8] Makefile: Remove SUBARCH

Thanks,
//richard
