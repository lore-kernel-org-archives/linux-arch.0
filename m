Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793931835;
	b=haDOtwr/HboXGWFaNXIeCIDc1v5Yg0K2USlI6F1IlsXrIQwFVzhmOOFW5n7Wcr9+5JYt
	 GL4dG9SyFJPUs2OjsxpruNkH+wG7JATQqqg96buUh0qB5L7mbmpBxILXYA+7W76KgAu+9
	 q7vQ8RSXGYGK1CH4R5X6zV0YEsKuWdS/3RsN0TrMSFOwP0sSDd7EDiQTHbmSBKrjFwv/S
	 1Yp3jCJ+nVx3GcB+TOiJ9Ffx9IYX8Q+UtH/UBgbNAJjqC/5rodu7jt+J8hVPq8+tYqUKx
	 zbHBX7HtAzlVSSyoo91aGuutJrBgwdtgPYwzXO5Gh/OTrLOo7N6Vd55jqoI7VjAftEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793931835;
	h=DMARC-Filter:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer;
	bh=mu9ahmsvD2vM/2MuVCitn+kVEcmnrs1DHn2+gosEv5Y=;
	b=k88cB84T4pFAcA5DoXj8ucvplSW57ZL9cQhUYz5Wdq96PL5nFmHSWZvknbcpvU8dHifM
	 BDhLOHBk+f2+JK5HU3tIkVGd2vGZGTqx/gt0vrdGu+REljr5m4Yx2G0uTCHpSbTYSEuHI
	 WoKBE+LM+GgOyQtYwk+pIXG9W9pasAtvchAXswWJ/eAv8PLHxUi42u4D6oMer4RLORfuW
	 OIuliZDFwwg9uOUSMXxSn58i63hG/G3pIt6ifMJ2MybBbefRJcZIVEjFLH38QCdLqM3N6
	 otracEKSaYcsIs/6FLQRsfL4CnY4NgCCoA2oD33JVvDJVTk+eqOhMTcN7CkGDnNnaVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292CC606A32C;
	Fri,  6 Nov 2026 02:23:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 292CC606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From:From:Reply-To;
	bh=mu9ahmsvD2vM/2MuVCitn+kVEcmnrs1DHn2+gosEv5Y=; t=1793931832; x=2109291832; 
	b=kaQie8SUcMkYvgpP+srwM0dw5ksSkaqn7GO01SYSJHWFCAGlMuNlNtdsZEpALuUp8ECTVNRTqMq
	I4g7QWM2lcYBqFQRENWYWsIrroc9cxPWqquzyRISRes+fejooxvcD7CeiGo8GMxsV1TTzOOzteIqV
	IhxtwlVTHf98j02wo1sVVVR7zqPiKyNimQiZ04sdLYfH+Qde8VOnCTdk5DIulDqOHX+EFkrYioQFP
	A1KbK2SAPrYFRHcQI9SNQRChSLAfkJP/5h39CO9sT5NC7s35YgVMvzOR5r6Ld97FsIx0TM3nLOXX7
	YP4QwPEXRSWSLNhWPH5r3M62Titt4pfw4sFg==;
Received: from [177.172.122.137] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1xP9cA-003xm9-Cw; Fri, 06 Nov 2026 03:23:38 +0100
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v10 0/3] arm64: vdso: Implement
 __vdso_futex_robust_try_unlock()
Date: Thu, 05 Nov 2026 23:23:41 -0300
Message-Id: <20261105-tonyk-robust_arm-v10-0-366ed4a3435b@igalia.com>
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23R207DMAwG4FeZck1R4iZxyhXvgRDKyVuArajtK
 qZp7046hFqUXDpyvuS3r2yMQ4oje9pd2RDnNKb+lAvBH3bMH+xpH5sU8gEDDppLoZupP10+mqF
 353F6s8OxUZIIMYCXUbJ87WuIlL7v5svrbz2e3Xv00+IsHYc0Tv1wuT86i6Xvj8eSn0XDG95aq
 2UEImGf095+Jvvo+yNb/Bk2AsiKAFkILn9PEyrwVAjtKijoKkKbBaspNxgZJMVCkKuAXFUEmYX
 IKXCyoLrQFoLaCNU5qCwQBWFDK0wQWAh6IwCvCDoLGLXxAoBLLFPgVjAVAbMgucHWt4helynMK
 hgQFcEs20REjk6T8GWKbhW66hy6ZRcu80446aX7J9xutx8pDJtj1AIAAA==
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

Changes in v10:
- Rebased on top of 7.4-rc1
- Link to v9: https://patch.msgid.link/20260917-tonyk-robust_arm-v9-0-ab082b1b4c4b@igalia.com

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
base-commit: eedaa7d61f1ec8ae053a9ece0d553785350ac486
change-id: 20260416-tonyk-robust_arm-54ff77d2c4e4

Best regards,
--  
André Almeida <andrealmeid@igalia.com>

