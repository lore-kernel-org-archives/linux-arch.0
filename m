Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7A447607A;
	Wed, 22 Jul 2026 07:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784706852; cv=none; b=DbmiT2x4Zg96+CuTj0fy9Im88wiHKitWV0nvKY4qhgofzKFJgRGsFmKV748y29LLqbrckMAUi1foUMmc/ppr9/wA0zeNq8G1S6QmaFbS+j9DjkO8z8JB/muKWCQvt1L9PAOY+IuD2qU7Z2EKWQpWAFL6OYfYAKG+p2ZJRHvdjXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784706852; c=relaxed/simple;
	bh=6yZi1E2ORWX3erxZ2iLgMw+pOXO/qHsB3RdbekGUNbY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PQJSSd13tSditF3yR7CHDFnU79H3bLNsIcR3+cQ7pZb0lTdasjvhUFtEE4rPGBSkzvpDvxbkljRQ5ei54qbDijUmuNWDzmHbhoCinDLeuI1SqMP7paPEd+eIlmgoSy/Zyc32oCeilgEF2sJzPwUyXklE36IqRDO6DYZKsdqWKFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZCBbJxE3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DztDMZiB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZCBbJxE3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DztDMZiB"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784706846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wb2SX77zyxaYXrQzUmclJ/k81+yHIaZBLWgIqd5QYek=;
	b=ZCBbJxE3//P0uRFzQdyh4Tk8RAFRJ0pFNAPajAbypuEOfdaAwoQfqlRO4hoXX8WLDTvNLw
	RKVKUXhH4VLrFGEO6FT9KB+r59rxBK93bY9F3IkFKzQF6YX1M1O8kHcYuNLSrnmvHtY/c5
	KP8KzN6jGQmGkqN3Gpg14x2hl3wB1/NBz7rrQ3If/cvIoDHINfOrKz0QqFOGMGzYXPFGZl
	eLd9pSn3RwWgPPMx44oGODy8r3CkZZ+QIrF6pkFp9RSPIVIfvTCRyR4JBTUyYMTnvePHRQ
	0+KMGVAMvlz1E2VqvZDLe6ZyYtdT+5+NKgNSmwwTg64MBCLiRjlOhzoV7+JLzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784706846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wb2SX77zyxaYXrQzUmclJ/k81+yHIaZBLWgIqd5QYek=;
	b=DztDMZiBvtlkUKsi3537Br2VZM+T/cUdgoiTSf2nFbsp+V/enzkjjTL7RdgOtZRfV2cr02
	Sk2b6uTHaZl//+Cg==
Date: Wed, 22 Jul 2026 09:53:32 +0200
Subject: [PATCH v3 6/7] clocksource/drivers/timer-riscv: Remove
 CONFIG_GENERIC_GETTIMEOFDAY ifdeffery
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260722-vdso-arch-clockmodes-v3-6-4c5753191cc4@linutronix.de>
References: <20260722-vdso-arch-clockmodes-v3-0-4c5753191cc4@linutronix.de>
In-Reply-To: <20260722-vdso-arch-clockmodes-v3-0-4c5753191cc4@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784706840; l=898;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=6yZi1E2ORWX3erxZ2iLgMw+pOXO/qHsB3RdbekGUNbY=;
 b=OGxNmRewbphCOeeEqi4jJWvqSgWZHS+7S8nITbTNvq2sjy66pfRkWG5/Eed//9dwpW/qsqmcf
 WZU0U94MfAOCuMaOVGEFxs42C1e4YdH9XZ5GMMfNHRGGi2GzJFbPoHL
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

