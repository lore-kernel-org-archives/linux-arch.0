Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC77320CCF;
	Fri, 20 Feb 2026 09:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771579685; cv=none; b=p355v7iV25JSs0MOWx+xiE0OmtT8xWRkt6lMdHlFMxV4sPsyAgX2Y+E2dPT8ZL+TTHFt+KtlPQF5i0D2JPWv4mhPNGGor0f1piRYBbYSvrqvGXDHCo+i79tWDZqzw5AHLaziO6UubD21a9k3q7KkAt3+kKoRA4Co+eEBlJBXfM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771579685; c=relaxed/simple;
	bh=htfspmM2c2lNeKPl/xvf7/POAscvMhM4d53l5UdNqHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EmfF3TbPm+KaM8NgjiyFKxCbhH8n/3otxkENOtKbE7cwQBWy4sUqL1N3UM9t9apZfU9RlaGmAiXdU4i5OObYiWuV1YF6k3sjZAROrNsUA/okxlKpp7U6XEWNiyFAyZBGrll2dAnFtMQIqcWbvUXc0QPcRfRWy9cIHW5M00uYpFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uYglDSix; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uYglDSix"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D62EEC2BC86;
	Fri, 20 Feb 2026 09:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771579685;
	bh=htfspmM2c2lNeKPl/xvf7/POAscvMhM4d53l5UdNqHY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uYglDSixsNUrAmuwCgveh4mBOgWjV3rCGsvEgcAo2JG6cWg5ST0cMdR+Y5OpzFpRr
	 Xzk4bBmQjUML2gaVx8vx8YaRUHecU26WL5il+lNeN2Hh6b2GYZ+nu6RX1qM691GZx5
	 8U9i9oRaZIhogxn0kbVZAVm3ds+Rpd0EAlL5RaaGjszPlKzu+CHMfrgyT2WrtawJp1
	 806WlvtV4K8r2u3cEReoDaJnSonYmwOB5grfTr8tq16mIhno4jKefmRAhaASEYp8eh
	 U0EuzBHBSFF//URpHX8b1V0N0wBs3FbN3Ie0kGXHF55yVCzS7TmgQtSADxYhpY/aPY
	 noCuvd/dn+UXA==
From: Jisheng Zhang <jszhang@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Thomas Gleixner <tglx@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Guo Ren <guoren@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-csky@vger.kernel.org
Subject: [PATCH 3/3] arm64: use runtime constant to optimize handle_arch_irq access
Date: Fri, 20 Feb 2026 17:09:22 +0800
Message-ID: <20260220090922.1506-4-jszhang@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260220090922.1506-1-jszhang@kernel.org>
References: <20260220090922.1506-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, on arm64 platforms, the handle_arch_irq is a pointer which
is set during booting, and every irq processing needs to access it,
so it sits in hot code path. We can use the runtime constant mechanism
which was introduced by Linus to speed up its accessing.

Tested on Quad CA55 platform, the perf sched benchmark is improved
by ~6.5%

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/arm64/kernel/entry-common.c | 4 +++-
 arch/arm64/kernel/irq.c          | 9 ++++++---
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index 3625797e9ee8..46a4c012e15f 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -25,6 +25,7 @@
 #include <asm/kprobes.h>
 #include <asm/mmu.h>
 #include <asm/processor.h>
+#include <asm/runtime-const.h>
 #include <asm/sdei.h>
 #include <asm/stacktrace.h>
 #include <asm/sysreg.h>
@@ -139,7 +140,8 @@ static void do_interrupt_handler(struct pt_regs *regs,
 	set_irq_regs(old_regs);
 }
 
-extern void (*handle_arch_irq)(struct pt_regs *);
+extern void (*_handle_arch_irq)(struct pt_regs *);
+#define handle_arch_irq runtime_const_ptr(_handle_arch_irq)
 extern void (*handle_arch_fiq)(struct pt_regs *);
 
 static void noinstr __panic_unhandled(struct pt_regs *regs, const char *vector,
diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
index 15dedb385b9e..30629c183606 100644
--- a/arch/arm64/kernel/irq.c
+++ b/arch/arm64/kernel/irq.c
@@ -23,6 +23,7 @@
 #include <asm/daifflags.h>
 #include <asm/exception.h>
 #include <asm/numa.h>
+#include <asm/runtime-const.h>
 #include <asm/softirq_stack.h>
 #include <asm/stacktrace.h>
 #include <asm/vmap_stack.h>
@@ -84,15 +85,17 @@ static void default_handle_fiq(struct pt_regs *regs)
 	panic("FIQ taken without a root FIQ handler\n");
 }
 
-void (*handle_arch_irq)(struct pt_regs *) __ro_after_init = default_handle_irq;
+void (*_handle_arch_irq)(struct pt_regs *) __ro_after_init = default_handle_irq;
+#define handle_arch_irq runtime_const_ptr(_handle_arch_irq)
 void (*handle_arch_fiq)(struct pt_regs *) __ro_after_init = default_handle_fiq;
 
 int __init set_handle_irq(void (*handle_irq)(struct pt_regs *))
 {
-	if (handle_arch_irq != default_handle_irq)
+	if (_handle_arch_irq != default_handle_irq)
 		return -EBUSY;
 
-	handle_arch_irq = handle_irq;
+	_handle_arch_irq = handle_irq;
+	runtime_const_init(ptr, _handle_arch_irq);
 	pr_info("Root IRQ handler: %ps\n", handle_irq);
 	return 0;
 }
-- 
2.51.0

