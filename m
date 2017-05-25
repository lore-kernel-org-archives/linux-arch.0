From: Ian Abbott <abbotti@mev.co.uk>
Subject: [PATCH v5 0/6] kernel.h: container_of() pointer checking
Date: Thu, 25 May 2017 13:03:10 +0100
Message-ID: <20170525120316.24473-1-abbotti@mev.co.uk>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp120.ord1c.emailsrvr.com ([108.166.43.120]:51680 "EHLO
        smtp120.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1423959AbdEYMDn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 25 May 2017 08:03:43 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Alexander Potapenko <glider@google.com>, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@suse.de>, Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>, Ian Abbott <abbotti@mev.co.uk>, Jakub Kicinski <jakub.kicinski@netronome.com>, Johannes Berg <johannes.berg@intel.com>, Kees Cook <keescook@chromium.org>, Michal Nazarewicz <mina86@mina86.com>, Peter Zijlstra <peterz@infradead.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Steven Rostedt <rostedt@goodmis.org>

TL;DR: This series of patches splits BUILD_BUG related macros out of
"include/linux/bug.h" into new file "include/linux/build_bug.h" (patch
5), and changes the pointer type checking in the `container_of()` macro
to deal with pointers of array type better (patch 6).  Patches 1 to 4
are prerequisites.

Patches 2, 3, 4, and 5 have been inserted since the previous version of
this patch series.  Patch 6 here corresponds to v3 and v4's patch 2.

Patch 1 was a prerequisite in v3 of this series to avoid a lot of
warnings when <linux/bug.h> was included by <linux/kernel.h>.  That is
no longer relevant for v5 of the series, but I left it in because it was
acked by a Arnd Bergmann and Michal Nazarewicz.

Patches 2, 3, and 4 are some checkpatch clean-ups on
"include/linux/bug.h" before splitting out the BUILD_BUG stuff in patch
5.

Patch 5 splits the BUILD_BUG related macros out of
"include/linux/bug.h" into new file "include/linux/build_bug.h" because
including <linux/bug.h> in "include/linux/kernel.h" would result in
build failures due to circular dependencies.

Patch 6 changes the pointer type checking by `container_of()` to avoid
some incompatible pointer warnings when the dereferenced pointer has
array type.

1) asm-generic/bug.h: declare struct pt_regs; before function prototype
2) linux/bug.h: correct formatting of block comment
3) linux/bug.h: correct "(foo*)" should be "(foo *)"
4) linux/bug.h: correct "space required before that '-'"
5) bug: split BUILD_BUG stuff out into <linux/build_bug.h>
6) kernel.h: handle pointers to arrays better in container_of()

 include/asm-generic/bug.h |  1 +
 include/linux/bug.h       | 72 +---------------------------------------
 include/linux/build_bug.h | 84 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/kernel.h    |  9 +++--
 4 files changed, 92 insertions(+), 74 deletions(-)
