Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:50237 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758764Ab2DYL0k (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 25 Apr 2012 07:26:40 -0400
Subject: [PATCH 4/4] bug: mark disabled BUG() as unreachable() code
From: Konstantin Khlebnikov <khlebnikov@openvz.org>
Date: Wed, 25 Apr 2012 15:26:36 +0400
Message-ID: <20120425112636.26927.27124.stgit@zurg>
In-Reply-To: <20120425112623.26927.43229.stgit@zurg>
References: <20120425112623.26927.43229.stgit@zurg>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Message-ID: <20120425112636.yWlNRMZrbC3aZMJ3F6RYN_nZhPGwiHjL3FS34xqEelw@z>

This patch suppress some compiler warnings (if CONFIG_BUG=n)
"warning: control reaches end of non-void function"

Plus now gcc can throw out some dead code.
bloat-o-meter: add/remove: 1/1 grow/shrink: 68/173 up/down: 1569/-5607 (-4038)

Signed-off-by: Konstantin Khlebnikov <khlebnikov@openvz.org>
---
 include/asm-generic/bug.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index aadb6fc..0b08199 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -108,7 +108,7 @@ extern void warn_slowpath_null(const char *file, const int line);
 
 #else /* !CONFIG_BUG */
 #ifndef HAVE_ARCH_BUG
-#define BUG() do {} while(0)
+#define BUG() unreachable()
 #endif
 
 #ifndef HAVE_ARCH_BUG_ON

