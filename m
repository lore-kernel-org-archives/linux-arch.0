Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997D2309EF4;
	Fri, 24 Jul 2026 13:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784900291; cv=none; b=Aq/dkRtA3DsHXrOmCg6dUA2xlCoxSLXiVkyUhGMwFkVpNGrOgCMm63SmcBtoCU55+ipG4Ej79Tbetr8jU2RwBQaltE43i/ZYb6MOPM/RT3A5sqTesRLCGGPB4+vbCpTpLGbJ5alTa7I3UslY2E8t2Tv65eeYyx4unK7Ncmucgqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784900291; c=relaxed/simple;
	bh=MP2SkrhK4GMSu5UIhEImPDNR3U350uvYxSPXvYLkbUU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IqB2/EOz+KCzXK1mG6V4AKTVhIqY8Dbo3qodPz87u5XVpAD+WT4uvla8Gt4pAF7fVNHfcqDGGQYEUO5Lo6Z2Ti7pG6UFOw4Lh7GMeuEwDqEBLEVq7c8SxZnvW4YBGZa92o+MG8z1OJPpsVF6wOs/eAiFBVWB6KnSEFeqPzBmQZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rCPIxj/5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dhUeWzjm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rCPIxj/5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dhUeWzjm"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784900287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QM9Lp+UCHv2nA/JQ1VGCr81S6Dhpwf0SM7XAotFxf3U=;
	b=rCPIxj/5GrKq7vySuH0J27acfkdy45eS4OkunF7DqNmJWiyv5GotlWxcjvpMClILBS2LJ2
	cwK8pEcQwe9EjN2OWtWYG+ouAlI4ZI+fHxq+RzJc9kykL6QOxgww8Hsvfp9bftkP2Z5lUu
	HqeOighQaG/RVGk4BOuRmJkY6Dm4TD1YVVURPw5NzQTzXEAYopB3VCzhK6H1JjNDF9414J
	01WlY5G4SfJ5zhDBfKfyN2OsfqWY31CreFbs0X5BY1ROZ1JGQxP4mRbWuyavhODvXowIZl
	Q1RRjmSUH7KOL44M6ORH2GbGNm0wq0JmmnF8HYj5RPeib6+0zLk2iVjW5tWF1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784900287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QM9Lp+UCHv2nA/JQ1VGCr81S6Dhpwf0SM7XAotFxf3U=;
	b=dhUeWzjmjXdkv1lOF5bi3OznddEHnV+wyC2rPF3koqyn+0bYsfbAwM07wqFfK3y4pQCEE1
	JgmU+lO4hby65gAw==
Subject: [PATCH v4 0/7] vDSO: Remove CONFIG_GENERIC_GETTIMEOFDAY ifdeffery
Date: Fri, 24 Jul 2026 15:36:17 +0200
Message-Id: <20260724-vdso-arch-clockmodes-v4-0-ddbe447be860@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XN0Q6CIBTG8VdpXEcDBNGueo/WBR4gWSUNjNmc7
 x7ajWt2+f+28zsjiiY4E9FxN6JgkovOdzn4foegVd3VYKdzI0ZYSUoicNLRYxWgxXD3cHt4bSJ
 uLChbKwYVr1A+fQZj3bCw50vu1sXeh/fyJdF5/YKS1NtgopjgwmpZkaaxlaCnu+teffCdGw7ao
 BlNbAVR+QdiGZKitEIJTXkpt6BiBTH2ByoyxEFIUdCaAvBfaJqmD8nT4PtOAQAA
X-Change-ID: 20260605-vdso-arch-clockmodes-bfcaf9a2c848
To: Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, linux-mips@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
 loongarch@lists.linux.dev, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784900286; l=1982;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=MP2SkrhK4GMSu5UIhEImPDNR3U350uvYxSPXvYLkbUU=;
 b=NRJ2rvH1f+h/UNlgNbYSlgtGoD45GCI1EXeDV8NzMkGgeC27xjfKz8lFaet2Qpmfgw6n4nBSA
 SE/1fQ32nXjCwqcSE3UpnL6MQz8E955+FZjZq56PwFgaGej21vor2ut
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Always provide the definitions of the VDSO_CLOCKMODE_* constants and
remove some ifdeffery from the clocksource drivers.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Changes in v4:
- Pick up Ack from Mark Zyngier.
- Fix '-type d' argument to find.
- Link to v3: https://patch.msgid.link/20260722-vdso-arch-clockmodes-v3-0-4c5753191cc4@linutronix.de

Changes in v3:
- Update *all* commit messages to the latest logic.
- Link to v2: https://patch.msgid.link/20260717-vdso-arch-clockmodes-v2-0-756f5a5d1467@linutronix.de

Changes in v2:
- Also drop the IS_ENABLED() logic.
- Link to v1: https://patch.msgid.link/20260709-vdso-arch-clockmodes-v1-0-3fd780bbf851@linutronix.de

---
Thomas Weißschuh (7):
      kbuild: support generated asm-headers in subdirectories
      vDSO: Make clockmode constants available without CONFIG_GENERIC_GETTIMEOFDAY
      MIPS: csrc-r4k: Remove CONFIG_GENERIC_GETTIMEOFDAY ifdeffery
      clocksource/drivers/mips-gic-timer: Remove CONFIG_GENERIC_GETTIMEOFDAY ifdeffery
      clocksource/drivers/arm_arch_timer: Remove CONFIG_GENERIC_GETTIMEOFDAY ifdeffery
      clocksource/drivers/timer-riscv: Remove CONFIG_GENERIC_GETTIMEOFDAY ifdeffery
      LoongArch: Remove CONFIG_GENERIC_GETTIMEOFDAY ifdeffery

 arch/loongarch/kernel/time.c           |  2 --
 arch/mips/kernel/csrc-r4k.c            |  2 --
 drivers/clocksource/arm_arch_timer.c   |  4 ----
 drivers/clocksource/mips-gic-timer.c   |  2 --
 drivers/clocksource/timer-riscv.c      |  4 ----
 include/asm-generic/Kbuild             |  1 +
 include/asm-generic/vdso/clocksource.h |  0
 include/vdso/clocksource.h             |  4 +---
 scripts/Makefile.asm-headers           | 11 +++++------
 9 files changed, 7 insertions(+), 23 deletions(-)
---
base-commit: ecacc9c8d3ed0f63065f4a1e94bfd8bf65a3ffaf
change-id: 20260605-vdso-arch-clockmodes-bfcaf9a2c848

Best regards,
--  
Thomas Weißschuh <thomas.weissschuh@linutronix.de>

