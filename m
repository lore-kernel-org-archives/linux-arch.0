From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: Unify the various copies of libgcc into lib v2
Date: Tue,  6 Jun 2017 12:10:16 -0700
Message-ID: <20170606191023.24581-1-palmer__43450.7413687699$1496776275$gmane$org@dabbelt.com>
References: <20170523220546.16758-1-palmer@dabbelt.com>
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <20170523220546.16758-1-palmer@dabbelt.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: monstr@monstr.eu, ralf@linux-mips.org, liqin.linux@gmail.com, lennox.wu@gmail.com, ysato@users.sourceforge.jp, dalias@libc.org, davem@davemloft.net, linux-mips@linux-mips.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, geert@linux-m68k.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

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
