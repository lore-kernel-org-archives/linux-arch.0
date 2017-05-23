Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp96.iad3a.emailsrvr.com ([173.203.187.96]:55785 "EHLO
        smtp96.iad3a.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1758308AbdEWQCy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 23 May 2017 12:02:54 -0400
From: Ian Abbott <abbotti@mev.co.uk>
Subject: [PATCH v3 1/2] asm-generic/bug.h: declare struct pt_regs; before function prototype
Date: Tue, 23 May 2017 16:53:41 +0100
Message-ID: <20170523155342.3244-2-abbotti@mev.co.uk>
In-Reply-To: <20170523155342.3244-1-abbotti@mev.co.uk>
References: <20170523155342.3244-1-abbotti@mev.co.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, Michal Nazarewicz <mina86@mina86.com>, Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>, Borislav Petkov <bp@suse.de>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Johannes Berg <johannes.berg@intel.com>, Peter Zijlstra <peterz@infradead.org>, Alexander Potapenko <glider@google.com>, Ian Abbott <abbotti@mev.co.uk>
Message-ID: <20170523155341.9YDkR-fbtKqOGh4VKbvNyjd1tli0NRQE8KJcs5N0ldQ@z>

The declaration of `__warn()` has `struct pt_regs *regs` as one of its
parameters.  This can result in compiler warnings if `struct regs` is
not already declared.  Add an empty declaration of `struct pt_regs` to
avoid the warnings.

Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
Acked-by: Acked-by: Arnd Bergmann <arnd@arndb.de>
---
v3: Actually, there was no v1 or v2.  I called this v3 to match the
series.
---
 include/asm-generic/bug.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index d6f4aed479a1..87191357d303 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -97,6 +97,7 @@ extern void warn_slowpath_null(const char *file, const int line);
 
 /* used internally by panic.c */
 struct warn_args;
+struct pt_regs;
 
 void __warn(const char *file, int line, void *caller, unsigned taint,
 	    struct pt_regs *regs, struct warn_args *args);
-- 
2.11.0
