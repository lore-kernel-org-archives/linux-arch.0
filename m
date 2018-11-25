Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtprz14.163.net ([106.3.154.247]:42649 "EHLO smtp.tom.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727008AbeKYUfE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 25 Nov 2018 15:35:04 -0500
Received: from antispam2.tom.com (unknown [172.25.16.56])
        by freemail02.tom.com (Postfix) with ESMTP id E238BB00D66
        for <linux-arch@vger.kernel.org>; Sun, 25 Nov 2018 17:30:49 +0800 (CST)
Received: from antispam2.tom.com (antispam2.tom.com [127.0.0.1])
        by antispam2.tom.com (Postfix) with ESMTP id E1CF781506
        for <linux-arch@vger.kernel.org>; Sun, 25 Nov 2018 17:30:49 +0800 (CST)
Received: from antispam2.tom.com ([127.0.0.1])
        by antispam2.tom.com (antispam2.tom.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id k9C-aU1v_ElC for <linux-arch@vger.kernel.org>;
        Sun, 25 Nov 2018 17:30:49 +0800 (CST)
From: Liu Xiang <liu.xiang6@zte.com.cn>
Subject: [PATCH] asm-generic: Add spaces around & operator
Date: Sun, 25 Nov 2018 17:30:45 +0800
Message-ID: <1543138245-3673-1-git-send-email-liu.xiang6@zte.com.cn>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org, liuxiang_1999@126.com, Liu Xiang <liu.xiang6@zte.com.cn>
Message-ID: <20181125093045.fDZqdLlv0n1Lu1pjbKeRJsnUbhixPEAhDFjJoP-MFt0@z>

Add spaces around '&' to follow kernel coding style.

Signed-off-by: Liu Xiang <liu.xiang6@zte.com.cn>
---
 include/asm-generic/fixmap.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/asm-generic/fixmap.h b/include/asm-generic/fixmap.h
index 827e4d3..d6e8da3 100644
--- a/include/asm-generic/fixmap.h
+++ b/include/asm-generic/fixmap.h
@@ -18,7 +18,7 @@
 #include <linux/bug.h>
 
 #define __fix_to_virt(x)	(FIXADDR_TOP - ((x) << PAGE_SHIFT))
-#define __virt_to_fix(x)	((FIXADDR_TOP - ((x)&PAGE_MASK)) >> PAGE_SHIFT)
+#define __virt_to_fix(x)	((FIXADDR_TOP - ((x) & PAGE_MASK)) >> PAGE_SHIFT)
 
 #ifndef __ASSEMBLY__
 /*
-- 
1.9.1
