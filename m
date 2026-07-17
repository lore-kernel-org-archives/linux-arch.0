Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E66642A16D;
	Fri, 17 Jul 2026 14:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784299347; cv=none; b=WuQ28Kg0PSJEhd1Z46UdOqijGT6keU1WYaz1jeKC6xwc2vo7LhjyHaoqeBN4XX1uemLQN3nXIHiMIxXdafJc9uzGj/lH701U+7fUQWFdO4YVBXGw4cEdMOSMib4F9YxuewHtbwihKjOvIKayLV+ft6D0rXH8ECZ7odC1ni2Zm08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784299347; c=relaxed/simple;
	bh=Ok8scRFNC4BH8n/tQyCorhWIR52PDfXWlasll1jIQLA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cN9khIQsciZUX+UNe024g6pjvi2FP8aBSAjKL9BOj7JW65Fmmf7efOCYcFbYwsVb8xnVKvnDGIcprJFCGtbe3C7gKHBaX62YHwP8bcdGYmhxm3GYLbLXnlE5GQ12dyMcWjBM3KnEYTqf8aefxdqeQYJUXpyBOWyN2e0K+l1GkEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Io0QB4j7; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Io0QB4j7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From:From:Reply-To;
	bh=nuK31S4gq27Mks8f20NLgIktLP66pVVP2bHto/DeWDg=; b=Io0QB4j77cumHnt3LfLpwJzdoj
	6VLaFoRCJZswr+vTOJILby7Aj83fNSk9KZP46Uor+po9vLkGFDrDdrxdxSWGQzrQ3WFVFrM7PK8ep
	GNQuRD0iD/SCBhlgBEjaf+lrUl+KXKx5SKpMilGeF18QXPapA7klv6lg1BXxi/n9HM3NMY1uklOsz
	3ckkgC/Z6hleNmRdZRFFSfr0FWnFUttXY7mWE7IeAXurGyWzZb4pVdg3yzsUFCMK8J5stno3MOacR
	XeOBw8cNHd2X6NhNQ3cwLAdFnc0A35bNort5Er32A2othOdfXI/bdnZ8oyobGKajb+Z18DuOruXF8
	3WyPPWfg==;
Received: from [179.118.191.219] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wkjlD-00GdLF-KH; Fri, 17 Jul 2026 16:41:55 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v5 0/4] arm64: vdso: Implement
 __vdso_futex_robust_try_unlock()
Date: Fri, 17 Jul 2026 11:41:39 -0300
Message-Id: <20260717-tonyk-robust_arm-v5-0-ffd1ad318d17@igalia.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23OQU7DMBAF0KtUXmPkTMY2ZcU9qgo59kxroDGy0
 4iqyt1xilBByfJLf96fqyiUIxXxvLmKTGMsMfU16IeN8EfXH0jGULMABUZhY+SQ+su7zKk7l+H
 V5ZPUyGxtAI+Eop59ZuL4dSN3+59czt0b+WF25sYxliHly21zbObeL2+X/NhIJVXrnEEC5sa9x
 IP7iO7Rp5OY/RH+CIArAlQhdPU9w1aD54XQ3gUN2xWhrYIzXAtPGJBpIeBdsEqvCFgFUhwUO9D
 b0P4Tpmn6BnIecgWJAQAA
X-Change-ID: 20260416-tonyk-robust_arm-54ff77d2c4e4
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

Hi folks,

This is my take on implementing the new vDSO for unlocking a robust futex in
arm64. If you don't know what's that, Thomas wrote a good summary,
including the motivation for this work and the x86 implementation:

   https://lore.kernel.org/lkml/878qb89g7b.ffs@tglx/

* Testing

There's one selftest proposed [1] that tests precisely if the task is
interrupted during the critical section, if the kernel will clear op_pending
pointer. I've adapted to arm64 [2] and it works as expected. This test is not
being upstreamed right now because it depends on a better way to expose
vdso.so.dbg [3].

I also used gdb to manually check if the address is cleared when the kernel
interrupts the critical section.

* The patchset

As explained in the Testing section above, we developed a test that puts
breakpoints in the code to test if a user code being interrupted really clears
the op_pending pointer. This test wasn't initially working because of this check
at futex_fixup_robust_unlock():

        /*
         * Avoid dereferencing current->mm if not returning from interrupt.
         * current->rseq.event is going to be used subsequently, so bringing the
         * cache line in is not a big deal.
         */
        if (!current->rseq.event.user_irq)
		return;

rseq.event.user_irq was always false during my tests, and it prevents the fixup
to happen. I figured out that arm64_syscall_enter_from_user_mode() was the
issue because it doesn't set user_irq to true when the task comes from a
syscall. I dropped arm64_syscall_enter_from_user_mode() and replaced with
arm64_enter_from_user_mode() and the test now works fine. I honestly don't know
if this solution is the correct one here, so I would like to hear from the arm64
folks what's the best approach here.

Thanks!
	André

[1] https://lore.kernel.org/lkml/20260404093939.7XgeW_54@linutronix.de/
[2] https://lore.kernel.org/lkml/20260529-tonyk-robust_arm-v3-3-a6f02684d4fe@igalia.com/
[3] https://lore.kernel.org/lkml/20260602090536.045586688@kernel.org/

Changes in v5:
 - Drop unneeded commit "arm64/entry: Unify user mode handling"
 - Replace "_success" with "_start" labels in vdso_futex_robust_unlock_update_ips
 - Added "cc" to the asm clobberlist
v4: https://patch.msgid.link/20260705-tonyk-robust_arm-v4-0-e0fd0fa259d3@igalia.com

Changes in v4:
 - Added commit "arm64/entry: Unify user mode handling"
 - Added missing ifdef FUTEX_ROBUST_UNLOCK guards
 - Fixed the position of _start and _success labels in the critical section
 - Instead of checking the zero flag, check the result register to decide if the
 op_pending needs to be cleared
v3: https://patch.msgid.link/20260529-tonyk-robust_arm-v3-0-a6f02684d4fe@igalia.com

Changes in v3:
 - Change asm to always use x2 to store *pop
 - Fix clang asm errors
 - Moved 32 bit entry point to vdso32/ and use littlearm asm
 - Adapted Sebastians test for arm
v2: https://patch.msgid.link/20260424-tonyk-robust_arm-v2-0-db4e46f752cf@igalia.com

Changes in v2:
 - s/CONFIG_COMPAT/CONFIG_COMPAT_VDSO (Thomas Weißschuh)
 - Fixed linker not finding the symbols (Thomas Weißschuh)
v1: https://patch.msgid.link/20260417-tonyk-robust_arm-v1-0-03aa64e2ff1a@igalia.com

---
André Almeida (4):
      arm64: vdso: Prepare for robust futex unlock support
      arm64: vdso: Implement __vdso_futex_robust_try_unlock()
      arm64: vdso32: Bring vdso32-offsets.h back
      arm64: vdso32: Implement __vdso_futex_robust_try_unlock()

 arch/arm64/Kconfig                    |  1 +
 arch/arm64/Makefile                   |  2 +-
 arch/arm64/include/asm/futex_robust.h | 19 +++++++++++++++
 arch/arm64/include/asm/vdso.h         |  3 +++
 arch/arm64/kernel/vdso.c              | 44 ++++++++++++++++++++++++++++++++++-
 arch/arm64/kernel/vdso/Makefile       | 10 ++++++++
 arch/arm64/kernel/vdso/vdso.lds.S     |  9 +++++++
 arch/arm64/kernel/vdso/vfutex.c       | 35 ++++++++++++++++++++++++++++
 arch/arm64/kernel/vdso32/Makefile     | 12 ++++++++++
 arch/arm64/kernel/vdso32/vdso.lds.S   |  9 +++++++
 arch/arm64/kernel/vdso32/vfutex.c     | 33 ++++++++++++++++++++++++++
 11 files changed, 175 insertions(+), 2 deletions(-)
---
base-commit: fce2dfa773ced15f27dd27cd0b482a7473cdcf2a
change-id: 20260416-tonyk-robust_arm-54ff77d2c4e4

Best regards,
--  
André Almeida <andrealmeid@igalia.com>

