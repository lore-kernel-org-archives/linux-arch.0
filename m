Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BC8320A22;
	Fri, 20 Feb 2026 09:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771579681; cv=none; b=PsTNAgMZKBGOOQrjzq+D+fUnbvg/5CR+1YHTIqxKkA9gwtneUi9pjhI48+Jpef/9B+jNb7rKLK/S6woa2lOhwK4cdjc8W2RvbVfWVNUF9p1rZ3MKGOANuYQ4GSrz1zVBUmXQcfZIRG42Nkv4UZ1K5//NEaKgZG8uIzi/xBhrsJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771579681; c=relaxed/simple;
	bh=nmlph+5TWjJa0sHPU1ah7ms/7375H0UUdoBhmRt0/vM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A2Ndp6ZWL/1AitHbby7WC285FXVfRMZk8LHMCVXWidbC27reNsTN4al/whYW/yrxF65LI3xIKj1ZJHL5V8TzZb1awbqnMcNK8dGF2KJQ7j1CgQvYxM0/70KoTgmnKN0G1UCYNyMTcXUzRvyyAn7VoOGzVHKjPpJG4CUHwGkaDGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EQEDWYJM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EQEDWYJM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29E53C116D0;
	Fri, 20 Feb 2026 09:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771579681;
	bh=nmlph+5TWjJa0sHPU1ah7ms/7375H0UUdoBhmRt0/vM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EQEDWYJM8jermjpwnybPt56VLRR5jNeGmSaE8MsYD5T8dczHcIXHts+owh9fueUGX
	 f6YMIT/Y4v1LoPI6Hmgy10ShyHpfEtFND57kJPWdK4NXBdODdqn2l2hLv1Akm0H6mY
	 lKTeOZSKQSI1gkacgnbRuduE58kevHFi+W2SNmDZq/VyGAhCmx4cvuK0EuVbPUr/ry
	 zIkuHWHmpbGvZDVaLGlbc+fo8+CbBxBLYg95xOTO4V0lraWNlaUXyJgSln7NAj36me
	 iBR48SFhwvwXd7VqSKX7HzHKkiF0/WmUQRTrskur/tnb8awG0Bgn/fY3WlvMrchY20
	 eWwHB6qqRMDXA==
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
Subject: [PATCH 2/3] genirq: use runtime constant to optimize handle_arch_irq access
Date: Fri, 20 Feb 2026 17:09:21 +0800
Message-ID: <20260220090922.1506-3-jszhang@kernel.org>
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

Currently, on GENERIC_IRQ_MULTI_HANDLER platforms, the handle_arch_irq
is a pointer which is set during booting, and every irq processing needs
to access it, so it sits in hot code path. We can use the
runtime constant mechanism which was introduced by Linus to speed up
its accessing.

Tested on Sipeed Lichee Pi 4A (riscv64) board, the perf sched benchmark is
improved by ~5.8%

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 include/linux/irq.h | 4 +++-
 kernel/irq/handle.c | 8 +++++---
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 951acbdb9f84..2ba4a8afb71e 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -1274,6 +1274,7 @@ void ipi_mux_process(void);
 int ipi_mux_create(unsigned int nr_ipi, void (*mux_send)(unsigned int cpu));
 
 #ifdef CONFIG_GENERIC_IRQ_MULTI_HANDLER
+#include <asm/runtime-const.h>
 /*
  * Registers a generic IRQ handling function as the top-level IRQ handler in
  * the system, which is generally the first C code called from an assembly
@@ -1288,7 +1289,8 @@ int __init set_handle_irq(void (*handle_irq)(struct pt_regs *));
  * Allows interrupt handlers to find the irqchip that's been registered as the
  * top-level IRQ handler.
  */
-extern void (*handle_arch_irq)(struct pt_regs *) __ro_after_init;
+extern void (*_handle_arch_irq)(struct pt_regs *) __ro_after_init;
+#define handle_arch_irq runtime_const_ptr(_handle_arch_irq)
 asmlinkage void generic_handle_arch_irq(struct pt_regs *regs);
 #else
 #ifndef set_handle_irq
diff --git a/kernel/irq/handle.c b/kernel/irq/handle.c
index b7d52821837b..aac9e7b1301e 100644
--- a/kernel/irq/handle.c
+++ b/kernel/irq/handle.c
@@ -15,13 +15,14 @@
 #include <linux/kernel_stat.h>
 
 #include <asm/irq_regs.h>
+#include <asm/runtime-const.h>
 
 #include <trace/events/irq.h>
 
 #include "internals.h"
 
 #ifdef CONFIG_GENERIC_IRQ_MULTI_HANDLER
-void (*handle_arch_irq)(struct pt_regs *) __ro_after_init;
+void (*_handle_arch_irq)(struct pt_regs *) __ro_after_init;
 #endif
 
 /**
@@ -270,10 +271,11 @@ irqreturn_t handle_irq_event(struct irq_desc *desc)
 #ifdef CONFIG_GENERIC_IRQ_MULTI_HANDLER
 int __init set_handle_irq(void (*handle_irq)(struct pt_regs *))
 {
-	if (handle_arch_irq)
+	if (_handle_arch_irq)
 		return -EBUSY;
 
-	handle_arch_irq = handle_irq;
+	_handle_arch_irq = handle_irq;
+	runtime_const_init(ptr, _handle_arch_irq);
 	return 0;
 }
 
-- 
2.51.0

