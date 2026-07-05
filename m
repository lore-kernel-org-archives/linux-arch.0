Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5992C2FB969;
	Sun,  5 Jul 2026 17:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783274280; cv=none; b=Ij7YizAYELZVCCA+Dy+74W8DvzHjaAH/ef9hHtOcsx4Rj63incJRAHglQjRPVAUYeSKANarf7sMplEXxlOY5i/C41BL8SeuWfTVvyCmDOEuswBUhCVIxmZYcRIvgG5fhNdDtDbq36s9HLUH+Ef2bulE8g3i850jN2GiOc2Fh4JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783274280; c=relaxed/simple;
	bh=E3KRSpnz4BdV2/+ZkQMD5yBIHwkT4n5mnJ+4/nTKZfU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ALwIQGFAqBGbdgT72F8nm1pXIxU5QUdcPAc954qUl1egHLQvROV7trB3E7GA56PHCA2vhdtvYBS2BoYG/BMaSTpfvbOylVM4QZ4wBRBomMirknxHzrRKiyUOnQJ782Omn2YW1XdJu2cKaLkHRPbF2Gn8zvAbD3i0EXFH9cgtb4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=nEgOrksR; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="nEgOrksR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=rcVS3cHMbkHHKBbkrjwyVmtTsLiB6GhrifHpaP7dKxw=; b=nEgOrksRV8oAN86xBjspHkltBK
	/U6wqN/l07wZSvWLHNVlekIBjHZfLGY0001/W13AuJ9NxIC5e5/YvD5sYJflH/pXUt7yre5OZ8M7Z
	WZPF7JDMV9zlxQfCAPGEcPfb9ueKgrXTlQatsPRc9cC3MU9ikEeLsvfLSmuxPqgpMUIhx+L/0H3CI
	qEJBQVuDyLwXMji6Q2ZNmNlvuwrCHVz09wkd8YXyZ8d4C21FKnIQFTEl2UklPortOw77zvIFUcgbU
	X7dtIyeggbb9sE0wmG2tq4lC6bpiO2H93R4js/4bma6XJ7PaA35qBdXH2ovCD3A5f+L0ypSUzzsd/
	GjWY5PAQ==;
Received: from 201-69-111-23.dial-up.telesp.net.br ([201.69.111.23] helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wgR5i-009PnY-G9; Sun, 05 Jul 2026 19:57:18 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Sun, 05 Jul 2026 14:56:51 -0300
Subject: [PATCH v4 1/5] arm64/entry: Unify user mode handling
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260705-tonyk-robust_arm-v4-1-e0fd0fa259d3@igalia.com>
References: <20260705-tonyk-robust_arm-v4-0-e0fd0fa259d3@igalia.com>
In-Reply-To: <20260705-tonyk-robust_arm-v4-0-e0fd0fa259d3@igalia.com>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Carlos O'Donell <carlos@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Florian Weimer <fweimer@redhat.com>, Rich Felker <dalias@aerifal.cx>, 
 Torvald Riegel <triegel@redhat.com>, Darren Hart <dvhart@infradead.org>, 
 Ingo Molnar <mingo@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, 
 Arnd Bergmann <arnd@arndb.de>, Uros Bizjak <ubizjak@gmail.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 "Liam R. Howlett" <liam@infradead.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, kernel-dev@igalia.com, 
 LKML <linux-kernel@vger.kernel.org>, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
X-Mailer: b4 0.15.2

Currently, arm64 has two functions to prepare and handle context switches
from userspace: arm64_syscall_enter_from_user_mode() and
arm64_enter_from_user_mode(). The only difference is that the later calls
rseq_note_user_irq_entry() that sets rseq.event.user_irq as true.

To ensure that futex_fixup_robust_unlock() works correctly, unify the
handling from user mode functions into one that always calls
rseq_note_user_irq_entry().

Other architectures calls irqentry_enter_from_user_mode() for syscalls
and interruptions, that sets rseq.event.user_irq as well.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 arch/arm64/kernel/entry-common.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index ceb4eb11232a..fd62ee585b52 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -62,13 +62,6 @@ static void noinstr arm64_exit_to_kernel_mode(struct pt_regs *regs,
 	irqentry_exit_to_kernel_mode_after_preempt(regs, state);
 }
 
-static __always_inline void arm64_syscall_enter_from_user_mode(struct pt_regs *regs)
-{
-	enter_from_user_mode(regs);
-	mte_disable_tco_entry(current);
-	sme_enter_from_user_mode();
-}
-
 /*
  * Handle IRQ/context state management when entering from user mode.
  * Before this function is called it is not safe to call regular kernel code,
@@ -729,7 +722,7 @@ static void noinstr el0_brk64(struct pt_regs *regs, unsigned long esr)
 
 static void noinstr el0_svc(struct pt_regs *regs)
 {
-	arm64_syscall_enter_from_user_mode(regs);
+	arm64_enter_from_user_mode(regs);
 	cortex_a76_erratum_1463225_svc_handler();
 	fpsimd_syscall_enter();
 	local_daif_restore(DAIF_PROCCTX);
@@ -881,7 +874,7 @@ static void noinstr el0_cp15(struct pt_regs *regs, unsigned long esr)
 
 static void noinstr el0_svc_compat(struct pt_regs *regs)
 {
-	arm64_syscall_enter_from_user_mode(regs);
+	arm64_enter_from_user_mode(regs);
 	cortex_a76_erratum_1463225_svc_handler();
 	local_daif_restore(DAIF_PROCCTX);
 	do_el0_svc_compat(regs);

-- 
2.54.0

