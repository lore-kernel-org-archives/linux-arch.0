Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:44446 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730009AbfH0NSl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 27 Aug 2019 09:18:41 -0400
From: Will Deacon <will@kernel.org>
Subject: [PATCH 4/6] arm64: sysreg: Add some field definitions for PAR_EL1
Date: Tue, 27 Aug 2019 14:18:16 +0100
Message-ID: <20190827131818.14724-5-will@kernel.org>
In-Reply-To: <20190827131818.14724-1-will@kernel.org>
References: <20190827131818.14724-1-will@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Message-ID: <20190827131816.sLfWD4rW7AM7dqXShOdFzberZCCmNxhcw-hDJ0DsZaA@z>

PAR_EL1 is a mysterious creature, but sometimes it's necessary to read
it when translating addresses in situations where we cannot walk the
page table directly.

Add a couple of system register definitions for the fault indication
field ('F') and the fault status code ('FST').

Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/sysreg.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 06ebcfef73df..2b229c23f3c1 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -212,6 +212,9 @@
 #define SYS_FAR_EL1			sys_reg(3, 0, 6, 0, 0)
 #define SYS_PAR_EL1			sys_reg(3, 0, 7, 4, 0)
 
+#define SYS_PAR_EL1_F			BIT(1)
+#define SYS_PAR_EL1_FST			GENMASK(6, 1)
+
 /*** Statistical Profiling Extension ***/
 /* ID registers */
 #define SYS_PMSIDR_EL1			sys_reg(3, 0, 9, 9, 7)
-- 
2.11.0
