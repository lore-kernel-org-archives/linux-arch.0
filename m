From: Ian Abbott <abbotti@mev.co.uk>
Subject: [PATCH v4 0/2] kernel.h: container_of() pointer checking
Date: Tue, 23 May 2017 17:01:10 +0100
Message-ID: <20170523160112.3446-1-abbotti@mev.co.uk>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp64.iad3a.emailsrvr.com ([173.203.187.64]:40152 "EHLO
        smtp64.iad3a.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1758024AbdEWQBX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 23 May 2017 12:01:23 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, Michal Nazarewicz <mina86@mina86.com>, Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>, Borislav Petkov <bp@suse.de>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Johannes Berg <johannes.berg@intel.com>, Peter Zijlstra <peterz@infradead.org>, Alexander Potapenko <glider@google.com>

[I screwed up an 'Acked-by:' line on v3.]

Patch 2 changes the container_of() macro to improve the compatibility
checking when the member has array type.  As a bonus (?), if the pointer
neither points to a type compatible with the member nor points to a type
compatible with void, compiler errors are produced instead of warnings.

Patch 1 is a prerequisite to avoid a lot of warnings when <linux/bug.h>
is included by <linux/kernel.h>.

1) asm-generic/bug.h: declare struct pt_regs; before function prototype
2) kernel.h: handle pointers to arrays better in container_of()

 include/asm-generic/bug.h | 1 +
 include/linux/kernel.h    | 9 ++++++---
 2 files changed, 7 insertions(+), 3 deletions(-)
