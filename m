Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59135 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755311AbcJUL7U (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 21 Oct 2016 07:59:20 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id u9LBwX7Q085177
        for <linux-arch@vger.kernel.org>; Fri, 21 Oct 2016 07:59:19 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 267dd3xb2f-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Fri, 21 Oct 2016 07:59:19 -0400
Received: from localhost
        by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Fri, 21 Oct 2016 12:59:18 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 3/5] s390: make cpu_relax a barrier again
Date: Fri, 21 Oct 2016 13:58:56 +0200
In-Reply-To: <1477051138-1610-1-git-send-email-borntraeger@de.ibm.com>
References: <1477051138-1610-1-git-send-email-borntraeger@de.ibm.com>
Message-ID: <1477051138-1610-4-git-send-email-borntraeger@de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org, linux-s390 <linux-s390@vger.kernel.org>, linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Noam Camus <noamc@ezchip.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <20161021115856.fJKLRK_13OMXzEawNQaQ7sk3xv0j7th66yLzxw5_m0Q@z>

stop_machine seems to be the only important place for yielding during
cpu_relax. This was fixed by using cpu_relax_yield. Therefore, we can
now redefine cpu_relax to be a barrier instead. (With the option to do
some SMT tuning later on)

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/processor.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/processor.h b/arch/s390/include/asm/processor.h
index d05965b..5d262cf 100644
--- a/arch/s390/include/asm/processor.h
+++ b/arch/s390/include/asm/processor.h
@@ -236,7 +236,7 @@ static inline unsigned short stap(void)
  */
 void cpu_relax_yield(void);
 
-#define cpu_relax() cpu_relax_yield()
+#define cpu_relax() barrier()
 #define cpu_relax_lowlatency()  barrier()
 
 #define ECAG_CACHE_ATTRIBUTE	0
-- 
2.5.5

