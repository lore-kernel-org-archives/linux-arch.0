Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2A7471254;
	Wed, 22 Jul 2026 07:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784706844; cv=none; b=V6MhG8ahyXBE1VXxrpPOFkscUL4K9YWVQN3IlinUPlhnwIX4giFi+tA+euMrXg/nqBe7DbJ9P2ru/H7ZpoTGwu18kmHUalPG2m3rSDbrVEMz7YfWdTDGhLlUxgv4w5Rccf8ijPvW5Fqeq/CHtvdDMGmXSz9NM6TbFIKELWJpyTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784706844; c=relaxed/simple;
	bh=ODl0setkvj0uIlTGNGfxVZ2OpkxJixp7vvM45HUxSeU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LczOHVl5zWoXQsbLYZ2LQ90nsrgdVNWLkMzHQ9f/8mCWwL0DxPj8l8hhQiu1ADfz68Tp4AZFutqPUq2fF6FjAmkIGOd2X5hFbItJXfHguZZvmJeNqWWSXS9zGIfrRWmasdqDhJXPEQkMw+bZv/OQm41dhsSg0vbaNm30I3+dy7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=laWRibYA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=k4BoSx+0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="laWRibYA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="k4BoSx+0"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784706841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=esBiTzM0YMZJaHRPo8C9o8Uyx3hv3mWceMEfg8hR9K0=;
	b=laWRibYATJixqIxXMIs22ReJlQG/+C5LJskCMYxc6LfZOADlSy1GF5xLIiKqEXE+o0Rlb5
	lmTJNYmphv5jXmpPG2qGcHDLzMQh9QcGfG8rzh1jcmgebj/+vWX0T8euBRlDGjO3ZSqI33
	a/JDSRptXbpno6ugRI7ufT/lHkZRVRCXI//sxQgjGxnFjH6kYX4bFPEVVGKUvQnFiNmHEC
	7zkJFV9MBLht1ul/pa1jXQfYOcTxjBDn7Oz+iTPBTQNPRjw37r9FZUrAnHCI5AupawWl3+
	islAIV8p4h+IXfkJMuz6pXpf/TrlD3oFKVFS0D60+Xc0hFrwctAWQGf1+RbzFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784706841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=esBiTzM0YMZJaHRPo8C9o8Uyx3hv3mWceMEfg8hR9K0=;
	b=k4BoSx+0yhCqEVDg+FKrCfzUGO8KMuuSe4E+ZiXCPao/GSg7YPhN2Lh7o6IwAUACVgABXJ
	7W3b83mwwAIBfhCQ==
Subject: [PATCH v3 0/7] vDSO: Remove CONFIG_GENERIC_GETTIMEOFDAY ifdeffery
Date: Wed, 22 Jul 2026 09:53:26 +0200
Message-Id: <20260722-vdso-arch-clockmodes-v3-0-4c5753191cc4@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XNSw7CIBSF4a00jMUALY86ch/GAeVhiRUMVFLTd
 O/SOjFGh/9J7ndnkEx0JoFDNYNosksu+BL1rgKql/5ioNOlAUGEIYYozDoFKKPqoRqCut6CNgl
 2VknbSqJEI0A5vUdj3bSxp3Pp3qUxxOf2JeN1fYMctb/BjCGCtdVcoK6zguLj4PxjjMG7aa8NW
 NFMPiDM/0CkQJwySyXVuGH8G1qW5QUpzdRdBQEAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784706840; l=1793;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=ODl0setkvj0uIlTGNGfxVZ2OpkxJixp7vvM45HUxSeU=;
 b=EtnQPZl191QmxUTsRxjG3FvEAMh/Rvkn1+MohLuwUUauSHnpds2Gap6Jj0V0Jz9Jie/xZZSeQ
 RtJDfuahXveCBHPhZVs46xzomPnnkogB0uvir/fEXRiqs77WUzztZUL
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Always provide the definitions of the VDSO_CLOCKMODE_* constants and
remove some ifdeffery from the clocksource drivers.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
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

