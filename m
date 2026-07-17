Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27F63ACF16;
	Fri, 17 Jul 2026 06:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784268907; cv=none; b=sTWDgJ/rNhSUtJc+TLoj03pweoHIRdGOUf/sQhk53W/hCSQRSdufQhT/erseRPb3lmeL93d+WZqRZ9he+o0lKmMukZeYcwS0mLIPopJDBXXnWostwa6Iqzr9OvLrVfd0FoXJNvJ5Pofje9HNyYagFuijkkvQyj6ReCfHjI/vWJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784268907; c=relaxed/simple;
	bh=6yZi1E2ORWX3erxZ2iLgMw+pOXO/qHsB3RdbekGUNbY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u8teN2fV0XN2wMu/uswTG4Rk5Q1+CvpRgAdk3N3wcnrgJ8Ak600YII0C4BgJVL42JRQJRTntOJB/itUMeYgITogLb8R4rzJHYPfFZVnciAVz2dTS3svRFuz3fhkkVT43+DAO48Lm7r5pRixe/Duqtgwtg3cF8C79RKcEnr0Uh60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=u4eNl9UU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rGP6vb6J; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u4eNl9UU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rGP6vb6J"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784268902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wb2SX77zyxaYXrQzUmclJ/k81+yHIaZBLWgIqd5QYek=;
	b=u4eNl9UUcvupBQzTRkd62Gu0i5e4taE85FUWmk/2jcLm9rp2S5n/GfHRkmR+4f8ngi5KAJ
	MtraBnPkgvXVZxTIMrynXKcN17bVph83CXMLuyexF//+Uqvlil1Taya0TAZI7Z5QHUaG26
	5F9I4Keypt2pkMjC6Gr/2eYpOVz5mAMsNEXFTYn68ZeVNTQp9Rf8eDGwcx1lvI+aWwzgkR
	vm5g+VcPXgE7npGpF5ONYgK8WmLrE1ImuT8cX+jDBN2T1DXUjB2iizF/l3ob03D+vq1bY0
	uKf9eKwKUO/IzEO0/Yj+Xyg5ZBTC5lELET7QPGdAZNR0TyUxza0fwfuUr/FMFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784268902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wb2SX77zyxaYXrQzUmclJ/k81+yHIaZBLWgIqd5QYek=;
	b=rGP6vb6JJmsFltlNED4hUaJ8a+h2yiSVYkGq/zIdu5++Fs8noFiqCMpoTCpb3SPHjdr84A
	L4PBLwGCTsOiDKCg==
Date: Fri, 17 Jul 2026 08:14:50 +0200
Subject: [PATCH v2 6/7] clocksource/drivers/timer-riscv: Remove
 CONFIG_GENERIC_GETTIMEOFDAY ifdeffery
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260717-vdso-arch-clockmodes-v2-6-756f5a5d1467@linutronix.de>
References: <20260717-vdso-arch-clockmodes-v2-0-756f5a5d1467@linutronix.de>
In-Reply-To: <20260717-vdso-arch-clockmodes-v2-0-756f5a5d1467@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784268894; l=898;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=6yZi1E2ORWX3erxZ2iLgMw+pOXO/qHsB3RdbekGUNbY=;
 b=rGhEvH4eB3yQp5VIIcgk0f5HSBovo4PTZyNAEZbeclqqk6dXhrkWD3CoKxYIoBOGuJgAsnYhP
 VCnQJqzmezKD+StMJTmIgFSq9ask+Vsf9Llxdphw8XKMcC+cV2EzgaT
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Now that there is a definition of VDSO_CLOCKMODE_ARCHTIMER
even if no vDSO is built, the ugly ifdeffery can be removed.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 drivers/clocksource/timer-riscv.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
index cfc4d83c42c0..b310e6721fac 100644
--- a/drivers/clocksource/timer-riscv.c
+++ b/drivers/clocksource/timer-riscv.c
@@ -98,11 +98,7 @@ static struct clocksource riscv_clocksource = {
 	.mask		= CLOCKSOURCE_MASK(64),
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 	.read		= riscv_clocksource_rdtime,
-#if IS_ENABLED(CONFIG_GENERIC_GETTIMEOFDAY)
 	.vdso_clock_mode = VDSO_CLOCKMODE_ARCHTIMER,
-#else
-	.vdso_clock_mode = VDSO_CLOCKMODE_NONE,
-#endif
 };
 
 static int riscv_timer_starting_cpu(unsigned int cpu)

-- 
2.55.0

