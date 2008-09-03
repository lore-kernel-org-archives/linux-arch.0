From: David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH 8/8] S390: Update comments about why we don't use
	<asm-generic/statfs.h>
Date: Wed, 03 Sep 2008 10:38:35 +0100
Message-ID: <1220434715.2985.68.camel@pmac.infradead.org>
References: <1220275314.2982.83.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:44252 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754859AbYICJii (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 3 Sep 2008 05:38:38 -0400
In-Reply-To: <1220275314.2982.83.camel@pmac.infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

Signed-off-by: David Woodhouse <David.Woodhouse@intel.com>
---
 arch/s390/include/asm/statfs.h |   11 ++++-------
 1 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/s390/include/asm/statfs.h b/arch/s390/include/asm/statfs.h
index 099a455..06cc703 100644
--- a/arch/s390/include/asm/statfs.h
+++ b/arch/s390/include/asm/statfs.h
@@ -12,19 +12,16 @@
 #ifndef __s390x__
 #include <asm-generic/statfs.h>
 #else
+/*
+ * We can't use <asm-generic/statfs.h> because in 64-bit mode
+ * we mix ints of different sizes in our struct statfs.
+ */
 
 #ifndef __KERNEL_STRICT_NAMES
-
 #include <linux/types.h>
-
 typedef __kernel_fsid_t	fsid_t;
-
 #endif
 
-/*
- * This is ugly -- we're already 64-bit clean, so just duplicate the 
- * definitions.
- */
 struct statfs {
 	int  f_type;
 	int  f_bsize;
-- 
1.5.5.1
-- 
David Woodhouse                            Open Source Technology Centre
David.Woodhouse@intel.com                              Intel Corporation
