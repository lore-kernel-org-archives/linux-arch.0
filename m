Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BAD3D8107;
	Fri, 21 Aug 2026 21:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787349092; cv=none; b=Sr+6p4eN6CDqdOzkiSP5JkHvx+OAsKRknpHQofYBSKj0GeySPdNpeg8Xvkj46xe/yrMmudef2D+FfPlLAmJF9sFJs20S+PCd0lM4f98WfSFxa03B+8vsTbgkJ52o5Plp7fffGyBNJBHtBS6tY+/ryUg2TzTXp9vhZH10eDLAK10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787349092; c=relaxed/simple;
	bh=8Ou8LhvvTScnDdBYkcatW2RTrk7QpwC+bXa3oqtlaVs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dZ2+/7tBF57g1YUgGr5VbNN0M2eRASc/t/mVyHZtJlCbId1EgKZ10P8wDquhzm5H+Ls4nvLvs2OSj1wPwmb/vJpTTqakCsIvDAaYEA8FrUknD9UVegmkjgfuHeZiEDfA3OKv6UPwRhKARN6mpIg02kBZUt1Z1u2DytQ6U2PKR54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=n8E99bd7; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="n8E99bd7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From:From:Reply-To;
	bh=15fjazPRvSvaA7URiMn07pGWly5niSSXQ7XgQ6d2NSo=; b=n8E99bd7F7NKQgcQFTJWH0faq1
	3IRCjbKccBt8pZ/8FCC76Fko622r0wTmwD9VpQ3aNMmtEI6Q4B0e+IeCxbCHy/k2a2NuaxM3A8zQA
	F1hPICQeiAss1gTXzEYOGnVmUE6nMgqn7xQwXY8XhOqbzukZS7f5YxxbgKdntBvSJdSBX3MEroGw+
	JE/FeeN2j8kuN2gNgoaGCMKxvnCdsmjfjQ9zEnbXgyYGo24lCsvKzwyujvGu6Q02ifShvqJ18QDo5
	hyyHIIKpWXwgAu/0hdleYhzVFTDHXOkmt4uEsqxhoq78XtrKjZInyy1BmE3L6cFog5VzIPsOQiDVz
	WQYWpi/w==;
Received: from [177.139.22.20] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wxX8U-007ErF-RK; Fri, 21 Aug 2026 23:50:51 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v8 0/4] arm64: vdso: Implement
 __vdso_futex_robust_try_unlock()
Date: Fri, 21 Aug 2026 18:50:41 -0300
Message-Id: <20260821-tonyk-robust_arm-v8-0-077707b6f1c7@igalia.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23QTU7DMBAF4KtUXmNkj38mZcU9EEKO7WkNNEF2G
 lFVuTtOEWpQsnzSm88zvrISc4qFPe2uLMcxldR3NTQPO+aPrjtEnkLNDARYoaXlQ99dPnju23M
 Z3lw+caOJEAN4HTWrY185Uvq+kS+vv7mc2/foh9mZG8dUhj5fbm+Ocu798bjmR8kFF8o5qyMQS
 fecDu4zuUffn9jsj7AQQG8IUIXQ1vUsoQFPK0HdBQP7DUFVwVmqhUYHTXEl6LuAwmwIugpRUBD
 kwOyDWglmIWz+g6kCUZAuKNkEiSvBLgQQG4KtAkbbeAkgNK6vwKXQbAhYBS0aVF4hevv/immaf
 gCGK0wLTwIAAA==
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
André Almeida (4):
      arm64: vdso: Prepare for robust futex unlock support
      arm64: vdso: Implement __vdso_futex_robust_try_unlock()
      arm64: vdso32: Bring vdso32-offsets.h back
      arm64: vdso32: Implement __vdso_futex_robust_try_unlock()

 arch/arm64/Kconfig                    |  1 +
 arch/arm64/Makefile                   |  2 +-
 arch/arm64/include/asm/futex_robust.h | 19 +++++++++++++
 arch/arm64/include/asm/vdso.h         |  3 ++
 arch/arm64/kernel/vdso.c              | 53 ++++++++++++++++++++++++++++++++++-
 arch/arm64/kernel/vdso/Makefile       | 10 +++++++
 arch/arm64/kernel/vdso/vdso.lds.S     |  9 ++++++
 arch/arm64/kernel/vdso/vfutex.c       | 35 +++++++++++++++++++++++
 arch/arm64/kernel/vdso32/Makefile     | 12 ++++++++
 arch/arm64/kernel/vdso32/vdso.lds.S   |  9 ++++++
 arch/arm64/kernel/vdso32/vfutex.c     | 34 ++++++++++++++++++++++
 11 files changed, 185 insertions(+), 2 deletions(-)
---
base-commit: 2be02a7c996aa733bb36e29e07715621b0de9736
change-id: 20260416-tonyk-robust_arm-54ff77d2c4e4

Best regards,
--  
André Almeida <andrealmeid@igalia.com>

