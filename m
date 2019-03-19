Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53404 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726831AbfCSPQO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 19 Mar 2019 11:16:14 -0400
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH 5/5] arm64: compat: Reduce address limit
Date: Tue, 19 Mar 2019 15:15:42 +0000
Message-ID: <20190319151542.19557-6-vincenzo.frascino@arm.com>
In-Reply-To: <20190319151542.19557-1-vincenzo.frascino@arm.com>
References: <20190319151542.19557-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Jann Horn <jannh@google.com>, Mark Rutland <mark.rutland@arm.com>
Message-ID: <20190319151542.zxkGZ-DOiqg86LFH2luR7YEBBD0HuBQVFbgLF-wYNBc@z>

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
Reported-by: Jann Horn <jannh@google.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/arm64/include/asm/processor.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 07c873fce961..4c689740940d 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -57,7 +57,7 @@
 #define TASK_SIZE_64		(UL(1) << vabits_user)
 
 #ifdef CONFIG_COMPAT
-#define TASK_SIZE_32		UL(0x100000000)
+#define TASK_SIZE_32		(UL(0x100000000) - PAGE_SIZE)
 #define TASK_SIZE		(test_thread_flag(TIF_32BIT) ? \
 				TASK_SIZE_32 : TASK_SIZE_64)
 #define TASK_SIZE_OF(tsk)	(test_tsk_thread_flag(tsk, TIF_32BIT) ? \
-- 
2.21.0
