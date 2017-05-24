From: Ian Abbott <abbotti@mev.co.uk>
Subject: [PATCH 0/1] bug: fix problem including <linux.bug.h> from linux/kernel.h
Date: Wed, 24 May 2017 14:21:06 +0100
Message-ID: <20170524132107.6919-1-abbotti@mev.co.uk>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp88.iad3a.emailsrvr.com ([173.203.187.88]:36450 "EHLO
        smtp88.iad3a.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935988AbdEXNVT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 24 May 2017 09:21:19 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, Michal Nazarewicz <mina86@mina86.com>, Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>, Borislav Petkov <bp@suse.de>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Johannes Berg <johannes.berg@intel.com>, Peter Zijlstra <peterz@infradead.org>, Alexander Potapenko <glider@google.com>

PATCH 1 is a follow-up patch to my previous patch "[PATCH v4 2/2]
kernel.h: handle pointers to arrays better in container_of()":
<https://lkml.org/lkml/2017/5/23/641>.  The previous patch introduced a
build failure:
<https://lists.01.org/pipermail/kbuild-all/2017-May/034127.html>.  The
build failure was due to a circular dependency introduced by the
previous patch and occurs when <asm-generic/bug.h> is included before
<linux/kernel.h> for architectures that select `CONFIG_GENERIC_BUG`.
PATCH 1 fixes this circular dependency.  Ideally, it should be applied
before my previous patch to avoid breakage during git bisect builds, but
can be applied after if that is not a concern.

1) bug: fix problem including <linux.bug.h> from linux/kernel.h

 include/asm-generic/bug.h | 1 -
 include/linux/bug.h       | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)
