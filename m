From: David Howells <dhowells@redhat.com>
Subject: [PATCH [ver #2] 13/39] UAPI: Remove the inclusion of linux/types.h
 from x86's asm/page.h
Date: Fri, 08 Jul 2011 15:25:03 +0100
Message-ID: <20110708142503.31344.66956.stgit@warthog.procyon.org.uk>
References: <20110708142244.31344.24941.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:1028 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752201Ab1GHOZt (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 8 Jul 2011 10:25:49 -0400
In-Reply-To: <20110708142244.31344.24941.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: rdunlap@xenotime.net, hpa@kernel.org, matthew@wil.cx, linux-arch@vger.kernel.org
Cc: dhowells@redhat.com, ralf@linux-mips.org

Remove the inclusion of linux/types.h from x86's asm/page.h as it's included
via asm/page_types.h.  Make asm/page_types.h's inclusion dependent on not being
in assembly.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 arch/x86/include/asm/page.h       |    2 --
 arch/x86/include/asm/page_types.h |    3 +++
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/page.h b/arch/x86/include/asm/page.h
index 8ca8283..d4ee8d8 100644
--- a/arch/x86/include/asm/page.h
+++ b/arch/x86/include/asm/page.h
@@ -1,8 +1,6 @@
 #ifndef _ASM_X86_PAGE_H
 #define _ASM_X86_PAGE_H
 
-#include <linux/types.h>
-
 #ifdef __KERNEL__
 
 #include <asm/page_types.h>
diff --git a/arch/x86/include/asm/page_types.h b/arch/x86/include/asm/page_types.h
index bce688d..eeff662 100644
--- a/arch/x86/include/asm/page_types.h
+++ b/arch/x86/include/asm/page_types.h
@@ -2,7 +2,10 @@
 #define _ASM_X86_PAGE_DEFS_H
 
 #include <linux/const.h>
+
+#ifndef __ASSEMBLY__
 #include <linux/types.h>
+#endif
 
 /* PAGE_SHIFT determines the page size */
 #define PAGE_SHIFT	12
