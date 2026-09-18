Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BC62DB794;
	Fri, 18 Sep 2026 00:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789691253; cv=none; b=LUzjW8TnPIbJmDPGe6x4ITMNcvT647xNrTBOKrYBz8dY/QC9CrsZyk24WC7qQyCANVv9lnyeaJKOGs2qXA0YkeeuHP1hiN7afUEYwxBVhklyxcgwxDAskZt3G9K7TF/3wT6Flpio9zH4av5Xm3zNrqQhbfL66hRrz05L5qfBE5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789691253; c=relaxed/simple;
	bh=YUhCTfwmLCJSOGUJt2QUCSdueuYAy48jKhGJqjal8t4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gfoqWxLzGMi3nnFPZDziXnojUpL9KKz1rLzxda9xd/c/Fc+JGlYFTJAq6FucXSUUrBf189rFgc2F5o+Mzed+K3h47P/pp06h7HuKbzZTELNRvV1i7pk3ykGqgRnVQ2Ot0nRwV2N4gUShMO3TuzQTfbCH+gdfQTlJvJyQ4XCg4RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=DxMJZpyi; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="DxMJZpyi"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From:From:Reply-To;
	bh=eCcAgXSpAoVpeW9rOvQUl6iJbV29w2PTGMHBmx6AqP0=; b=DxMJZpyizoAwzj183iRhjx5EoT
	Ll6EnbGPrttBtt/QX4TbuJTCwo7DxJqJCuup4tCwUIkbizOvPUtZtKcBRrynqPpFlb2gDun9U6NN3
	69YO+KXqsJXrYT0L+Tr6rrlmbShdqsQZZMp9T+rD1MkU30udJeM3lIPVAEU2Wq3zHLwcUJG301uOk
	sbmfGul1Yvzgc7NR3H7q4kzAinLcodwWuWD39wUT5QYb4QuBAXUn9w2o0w79qSy4M1dDoYiu47aKn
	ixNOQi7dyzGXzlMfK3o4K0i103OmM0EEhdolXMUrPV/l3EAhN37NpoQ5DlhlsrIHu3rGZIYZeYlOj
	bniavKag==;
Received: from [177.172.123.214] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1x7MRh-003iDv-4w; Fri, 18 Sep 2026 02:27:17 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v9 0/3] arm64: vdso: Implement
 __vdso_futex_robust_try_unlock()
Date: Thu, 17 Sep 2026 21:26:58 -0300
Message-Id: <20260917-tonyk-robust_arm-v9-0-ab082b1b4c4b@igalia.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23R307DIBQG8FdZuLYGDn8O88r3MMZQ4Gyoa03bN
 S5L3106Y1YDlyf5+MF3uLIxDimO7Gl3ZUOc05j6Lg/7hx3zR9cdYpNCnhlwMFwJ00x9d/lohr4
 9j9ObG06NVkSIAbyKiuVjX0Ok9H0jX15/5/Hcvkc/rc6aOKZx6ofL7c5ZrLk/Hkt+Fg1vuHTOq
 AhEwj2ng/tM7tH3J7b6M2wEUBUBshDa/DxDqMFTIci7oGFfEWQWnKEcsCooioWg7gJyXRFUFiK
 nwMmB3gdZCHojVPegs0AUhAtS2CCwEMxGAF4RTBYwGusFAFdYtsCtYCsCZkFxi9JLRG/KFvYuW
 BAVwa6/iYgcW0PC/2+xLMsPXUD6IpECAAA=
X-Change-ID: 20260416-tonyk-robust_arm-54ff77d2c4e4
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Peter Zijlstra <peterz@infradead.org>, Florian Weimer <fweimer@redhat.com>, 
 Darren Hart <dvhart@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
 Davidlohr Bueso <dave@stgolabs.net>, Arnd Bergmann <arnd@arndb.de>, 
 Uros Bizjak <ubizjak@gmail.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
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

Thanks!
	André

[1] https://lore.kernel.org/lkml/20260404093939.7XgeW_54@linutronix.de/
[2] https://lore.kernel.org/lkml/20260529-tonyk-robust_arm-v3-3-a6f02684d4fe@igalia.com/
[3] https://lore.kernel.org/lkml/20260602090536.045586688@kernel.org/

Changes in v9:
- Refactored asm code style
- Fix registers constrains, making sure that [pop_reg] uses the allocated
register and mark [lock] as read-write
- Simplified arm64_futex_robust_unlock_get_pop() with regs->regs[]
- Reduced the scope a bit, dropped the compat vdso32 bit entry for now. It needs
to first be added to arch/arm/, and later to arch/arm64/kernel/vdso32/ to ensure
that they are the same thing. I will add those bits in a next series, as
arch/arm needs a different toolchain, vm image, test and so on.
- v8: https://patch.msgid.link/20260821-tonyk-robust_arm-v8-0-077707b6f1c7@igalia.com

Changes in v8:
- Fix build when CONFIG_FUTEX is disabled
- v7: https://patch.msgid.link/20260728-tonyk-robust_arm-v7-0-40873c377c63@igalia.com

Changes in v7:
- vdso32: Use stlex instead of strex to ensure release semanthics
- vdso32: result reg should use "=&r" clobber
- both: pop_reg will be read afterwards so it was moved to be an input operand,
  with "+Q" clobber"
v6: https://patch.msgid.link/20260720-tonyk-robust_arm-v6-0-7e68c122047e@igalia.com

Changes in v6:
- Reorganized the patchset, better split for helpers functions vs aarch64 vs
arm32 code
- Use "full name" for labels instead of macros
- Completely reworded "Implement __vdso_futex_robust_try_unlock()" to make it
more obvious what's the bug and how does this fix it
v5: https://patch.msgid.link/20260717-tonyk-robust_arm-v5-0-ffd1ad318d17@igalia.com

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
André Almeida (2):
      arm64: vdso: Prepare for robust futex unlock support
      arm64: vdso: Implement __vdso_futex_robust_try_unlock()

Mark Rutland (1):
      arm64: vdso: Split native/compat mremap callbacks

 arch/arm64/Kconfig                    |  1 +
 arch/arm64/include/asm/futex_robust.h | 24 ++++++++++++++++++++
 arch/arm64/kernel/vdso.c              | 42 +++++++++++++++++++++++++++++++++--
 arch/arm64/kernel/vdso/Makefile       | 10 +++++++++
 arch/arm64/kernel/vdso/vdso.lds.S     |  9 ++++++++
 arch/arm64/kernel/vdso/vfutex.c       | 41 ++++++++++++++++++++++++++++++++++
 6 files changed, 125 insertions(+), 2 deletions(-)
---
base-commit: 238650ef6c7c7cca08e032527329424c9fbd70e5
change-id: 20260416-tonyk-robust_arm-54ff77d2c4e4

Best regards,
--  
André Almeida <andrealmeid@igalia.com>

