Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54882 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731225AbfBKRpx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 11 Feb 2019 12:45:53 -0500
From: Will Deacon <will.deacon@arm.com>
Subject: [PATCH 2/2] arm64: io: Hook up __io_par() for inX() ordering
Date: Mon, 11 Feb 2019 17:45:44 +0000
Message-ID: <20190211174544.4302-3-will.deacon@arm.com>
In-Reply-To: <20190211174544.4302-1-will.deacon@arm.com>
References: <20190211174544.4302-1-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, andrew.murray@arm.com, arnd@arndb.de, catalin.marinas@arm.com, Will Deacon <will.deacon@arm.com>
Message-ID: <20190211174544.a6_8LkZTkDcSJT776w5fppb3hJwn69vcE8g7pEAiK44@z>

Ensure that inX() provides the same ordering guarantees as readX()
by hooking up __io_par() so that it maps directly to __iormb().

Reported-by: Andrew Murray <andrew.murray@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/io.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
index ee723835c1f4..2985febe63ec 100644
--- a/arch/arm64/include/asm/io.h
+++ b/arch/arm64/include/asm/io.h
@@ -121,6 +121,7 @@ static inline u64 __raw_readq(const volatile void __iomem *addr)
 		     : "memory");					\
 })
 
+#define __io_par		__iormb
 #define __iowmb()		wmb()
 
 #define mmiowb()		do { } while (0)
-- 
2.11.0
