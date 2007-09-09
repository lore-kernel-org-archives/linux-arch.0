Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pasmtpb.tele.dk ([80.160.77.98]:57158 "EHLO pasmtpB.tele.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758066AbXIISBb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 9 Sep 2007 14:01:31 -0400
Date: Sun, 9 Sep 2007 20:02:54 +0200
From: Sam Ravnborg <sam@ravnborg.org>
Subject: kbuild: enable possibility to specify xFLAGS on commandline
Message-ID: <20070909180254.GA20086@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
To: linux arch <linux-arch@vger.kernel.org>, Andi Kleen <ak@suse.de>, kbuild devel <kbuild-devel@lists.sourceforge.net>, Tony Luck <tony.luck@intel.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
List-ID: <linux-arch.vger.kernel.org>

Following patchset enable the possibility to specify 
CFLAGS, AFLAGS or CPPFLAGS on the commandline to add
additional options while building the kernel.

The patch prefix all uses of CFLAGS, AFLAGS and CPPFLAGS
with KBUILD_ which touches all arch Makefiles.

Regression testing was very simple. Since this patch did not
change behaviour adding the patch should not cause any recompile
and this was tested with defconfig on several architectures.
To be more specific on:
alpha arm i386 mips sparc sparc64 x86_64 ia64 m68k s390

powerpc I dave a toolchain but defconfig seems not to be present.
blackfin and um did not build.

A small cleanup patch for ia64 sneaked in too - to allow the
above mentioned regression test.

The patchset will conflict with a patch from Andi Kleen.
If the patch for x86_64 will be pushed for -rc - no troubles.
If the patch await next mergewindow I could take it in my tree
to avoid the conflict.

The patch in question is:
ftp://ftp.firstfloor.org/pub/ak/x86_64/quilt/patches/cflags-probe


The purpose of this patch is to make it much simpler to try out
different gcc options.
The receipe is the following:

make CFLAGS=-fmuch-quicker-kernel mm/slub.o
make KBUILD_NOCMDDEP=1

The KBUILD_NOCMDDEP=1 tell kbuild not to check any commandline
arguments and can be used to change options AND compiler.
Without this kbuild would detech changes in commandline options
and rebuild mm/slub.o again.

Any objections to this change?

	Sam

