From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] asm-generic: add EMAXERRNO
Date: Mon, 15 Jun 2009 15:30:09 +0200
Message-ID: <200906151530.10299.arnd@arndb.de>
References: <OF48364F7F.ED6F93C7-ON482575D6.0042A7E0-482575D6.0043654D@sunplusct.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="gb2312"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.188]:51604 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752235AbZFONaP (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 15 Jun 2009 09:30:15 -0400
In-Reply-To: <OF48364F7F.ED6F93C7-ON482575D6.0042A7E0-482575D6.0043654D@sunplusct.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: liqin.chen@sunplusct.com
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org

Some architectures want to flag error returns from a syscall based on
the return value. The range from zero to -511 is for errors that
we can return to user space, so add a #define for this to
include/asm-generic/errno.h.

Reported-by: Chen Liquin <liqin.chen@sunplusct.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/asm-generic/errno.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

On Monday 15 June 2009, liqin.chen@sunplusct.com wrote:

> Maybe I can don't use EMAXERRNO in score code. But I think define a 
> maximum error number in asm-generic/errno.h is better.
> 

How about this one?

diff --git a/include/asm-generic/errno.h b/include/asm-generic/errno.h
index e8852c0..16bb31d 100644
--- a/include/asm-generic/errno.h
+++ b/include/asm-generic/errno.h
@@ -106,4 +106,8 @@
 #define	EOWNERDEAD	130	/* Owner died */
 #define	ENOTRECOVERABLE	131	/* State not recoverable */
 
+#ifdef __KERNEL__
+#define	EMAXERRNO	511	/* maximum errno value we return to user */
+#endif
+
 #endif
-- 
1.6.3.1

 
