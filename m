Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37736 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725814AbfBULgk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 21 Feb 2019 06:36:40 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1LBYA1B004333
        for <linux-arch@vger.kernel.org>; Thu, 21 Feb 2019 06:36:39 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qss3anyb9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 21 Feb 2019 06:36:39 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <rppt@linux.ibm.com>;
        Thu, 21 Feb 2019 11:36:36 -0000
From: Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH] asm-generic/page.h: fix typo in #error text requiring a real asm/page.h
Date: Thu, 21 Feb 2019 13:36:31 +0200
Message-ID: <1550748991-14362-1-git-send-email-rppt@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>
Message-ID: <20190221113631.Q48_7QcCVS8gDtn6QWCoFLBMEBQ7KZtEyhbn7CFJgB0@z>

Replace "need to prove a real asm/page.h" with "need to provide a real
asm/page.h"

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 include/asm-generic/page.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/asm-generic/page.h b/include/asm-generic/page.h
index 27bf337..fe801f0 100644
--- a/include/asm-generic/page.h
+++ b/include/asm-generic/page.h
@@ -7,7 +7,7 @@
  */
 
 #ifdef CONFIG_MMU
-#error need to prove a real asm/page.h
+#error need to provide a real asm/page.h
 #endif
 
 
-- 
2.7.4
