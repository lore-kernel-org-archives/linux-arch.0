From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: Unify the various copies of libgcc into lib v2
Date: Tue,  6 Jun 2017 12:10:16 -0700
Message-ID: <20170606191023.24581-1-palmer@dabbelt.com>
References: <20170523220546.16758-1-palmer@dabbelt.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33582 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751730AbdFFTK2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Jun 2017 15:10:28 -0400
Received: by mail-pg0-f68.google.com with SMTP id a70so5499418pge.0
        for <linux-arch@vger.kernel.org>; Tue, 06 Jun 2017 12:10:28 -0700 (PDT)
In-Reply-To: <20170523220546.16758-1-palmer@dabbelt.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: monstr@monstr.eu, ralf@linux-mips.org, liqin.linux@gmail.com, lennox.wu@gmail.com, ysato@users.sourceforge.jp, dalias@libc.org, davem@davemloft.net, linux-mips@linux-mips.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, geert@linux-m68k.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

Thanks to everyone who responded to my original patch set.  I believe I've
responded to everyone's comments.  There have been a handful of changes since
the original patch set:

 * The Kconfig names for the routines are now GENERIC_* instead of LIB_*.  This
   matches the existing generic implementation Kconfig names.
 * Tracing is disabled, which matches the MIPS behavior and seems correct
   globally.
 * I've cross compiled this to make sure it builds, and fixed all the build
   errors I found.
 * The MIPS patches actually do what they say in the commit message.

I don't know of any remaining problems with this patch set, so hopefully it's
ready to get merged.  I'll be including patch 1 in our RISC-V submissions, but
as I'm somewhat new to this I don't have a tree that anyone pulls from yet.

If everyone is happy with this patch set then I'd be willing to use this as a
first attempt to get patches upstream myself.

[PATCH 1/7] lib: Add shared copies of some GCC library routines
[PATCH 2/7] m32r: Use lib/ucmpdi2.c
[PATCH 3/7] microblaze: Use libgcc files from lib/
[PATCH 4/7] score: Use lib/{ashldi3,ashrdi3,cmpdi2,lshrdi3,ucmpdi2}.c
[PATCH 5/7] sh: Use lib/ashldi3,ashrdi3,lshrdi3}.c
[PATCH 6/7] sparc: Use lib/{cmpdi2,ucmpdi2}.c
[PATCH 7/7] MIPS: Use generic libgcc intrinsics
