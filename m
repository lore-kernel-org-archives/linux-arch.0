From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH 2/3] sched/preempt: include asm/current.h
Date: Thu, 13 Oct 2016 13:57:11 +0200
Message-ID: <20161013115712.29517-3-heiko.carstens@de.ibm.com>
References: <20161013115712.29517-1-heiko.carstens@de.ibm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42410 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753978AbcJMMRP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 13 Oct 2016 08:17:15 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id u9DBrmEC018985
        for <linux-arch@vger.kernel.org>; Thu, 13 Oct 2016 07:57:21 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 26244a7r52-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 13 Oct 2016 07:57:20 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Thu, 13 Oct 2016 12:57:19 +0100
In-Reply-To: <20161013115712.29517-1-heiko.carstens@de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>

The generic preempt code needs to include <asm/current.h>. Otherwise
compilation fails if THREAD_INFO_IN_TASK is selected and the generic
preempt code is used:

./include/linux/thread_info.h:17:54: error: 'current' undeclared (first use in this function)
 #define current_thread_info() ((struct thread_info *)current)

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 include/asm-generic/preempt.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/asm-generic/preempt.h b/include/asm-generic/preempt.h
index c1cde3577551..66fcd6cd7fc6 100644
--- a/include/asm-generic/preempt.h
+++ b/include/asm-generic/preempt.h
@@ -2,6 +2,7 @@
 #define __ASM_PREEMPT_H
 
 #include <linux/thread_info.h>
+#include <asm/current.h>
 
 #define PREEMPT_ENABLED	(0)
 
-- 
2.8.4
