Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33104 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbfDALa1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 1 Apr 2019 07:30:27 -0400
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH v2] arm64: compat: Reduce address limit
Date: Mon,  1 Apr 2019 12:30:14 +0100
Message-ID: <20190401113014.20866-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Jann Horn <jannh@google.com>, stable@vger.kernel.org
Message-ID: <20190401113014.1-kKq2XsrOg7R_Y9AzdEvuOU-0wG6k-XeAxXyuwpXMY@z>

Currently, compat tasks running on arm64 can allocate memory up to
TASK_SIZE_32 (UL(0x100000000)).

This means that mmap() allocations, if we treat them as returning an
array, are not compliant with the sections 6.5.8 of the C standard
(C99) which states that: "If the expression P points to an element of
an array object and the expression Q points to the last element of the
same array object, the pointer expression Q+1 compares greater than P".

Redefine TASK_SIZE_32 to address the issue.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Jann Horn <jannh@google.com>
Cc: <stable@vger.kernel.org>
Reported-by: Jann Horn <jannh@google.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/arm64/include/asm/processor.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 5d9ce62bdebd..9c831d9d3cd2 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -57,7 +57,15 @@
 #define TASK_SIZE_64		(UL(1) << vabits_user)
 
 #ifdef CONFIG_COMPAT
+#ifdef CONFIG_ARM64_64K_PAGES
+/*
+ * With CONFIG_ARM64_64K_PAGES enabled, the last page is occupied
+ * by the compact vectors page.
+ */
 #define TASK_SIZE_32		UL(0x100000000)
+#else
+#define TASK_SIZE_32		(UL(0x100000000) - PAGE_SIZE)
+#endif /* CONFIG_ARM64_64K_PAGES */
 #define TASK_SIZE		(test_thread_flag(TIF_32BIT) ? \
 				TASK_SIZE_32 : TASK_SIZE_64)
 #define TASK_SIZE_OF(tsk)	(test_tsk_thread_flag(tsk, TIF_32BIT) ? \
-- 
2.21.0
