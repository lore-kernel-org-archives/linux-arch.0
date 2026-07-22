Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897CD47255F;
	Wed, 22 Jul 2026 07:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784706852; cv=none; b=GIck/gVqh0rnhmAiFW/jPuNF5UPvHLD9tyWsq9nnMCtEKf7hz8Gx/qXNO67QTArClxZAzn0bnF5+CRmFhVwv5CjaW5i9NF5vs/EErD8qjiE78WhZo8ZHBZezEgb7Jn/huqWVshz+Q1u9tZPkrBgRfNWyqcaqAsxVyHVtBlY2ToY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784706852; c=relaxed/simple;
	bh=iYdmmwYnitqCJzJDOgChDbBElLI/0ThiAUZVrCungs4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g4QPVeWsTTxznmphKA1TV6FngilA1K1ym7K/aOPdTDCkhe5ud89Uv4A1vIhtbVKhNwykVj6AhHloFHXk6New6VFJNLAsGlf9y99z3yrT8NytuWfkNpsHbSRQIwU8O1sRhu+VMFuQIqPNi8k+UQYOevD0zROfTuO0w88o6c08KcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=skRTAQ+a; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8AtRNNGI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="skRTAQ+a";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8AtRNNGI"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784706845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wy4A5Bpkj2zzKdn6eNsWOzDqtG3uGM/7aAgamplxzrs=;
	b=skRTAQ+a8QkdkqSL6xqu6N+jYG2V/9BTt/U29MOBwUwpB58zKwXDFacwgyzsv9PR/OhetJ
	AMBFz87o1iWRhHiM0AggqZXnBUXq6g5peqYAdEe4s6R1yoN8K4/ZmqnFGHR/unGR4npwhP
	JWcSxoa+h2GYIEGrPnaZ7Rwh8CdZxnuvhQ68UNVntkBmFmurkg5yGwh8kwBb2eRrEniOtj
	4aiyUgoRC1b9R8UdXHuN2b2zAcNEQv/X+gWm0g1uozCyNiPVZSHWHyl9bLVgmpmekt35uh
	NzIIuYghVZsZCNhbtfPbWlBIpEjs76T2U0ktXIizUhHTaqifUyFsFXOjC+UI3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784706845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wy4A5Bpkj2zzKdn6eNsWOzDqtG3uGM/7aAgamplxzrs=;
	b=8AtRNNGIfGgq400WNhL47QMz7+eYI9iW6miEUp5mJtZ3BphfmYuREg/ZmGBLZNWC1JZjXo
	fxzBl0/UCwOjKSBA==
Date: Wed, 22 Jul 2026 09:53:30 +0200
Subject: [PATCH v3 4/7] clocksource/drivers/mips-gic-timer: Remove
 CONFIG_GENERIC_GETTIMEOFDAY ifdeffery
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260722-vdso-arch-clockmodes-v3-4-4c5753191cc4@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784706840; l=811;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=iYdmmwYnitqCJzJDOgChDbBElLI/0ThiAUZVrCungs4=;
 b=ERed7CvjPkQB+1xB34BBcq2YhhyH5BFC82wAhQY2D11iV4dEU3WVmHHH6AE1BxKn7aJGwh1Eh
 Dojk58JDkaPB6GGxSmj/XKZ9QlXGjtLVgQE2uHLhUKznA+bhY3yCB7j
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Now that there is a definition of VDSO_CLOCKMODE_GIC even if no
vDSO is built, the ugly ifdeffery can be removed.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 drivers/clocksource/mips-gic-timer.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/clocksource/mips-gic-timer.c b/drivers/clocksource/mips-gic-timer.c
index a1669266c94d..1501c7db9a8e 100644
--- a/drivers/clocksource/mips-gic-timer.c
+++ b/drivers/clocksource/mips-gic-timer.c
@@ -198,9 +198,7 @@ static struct clocksource gic_clocksource = {
 	.name			= "GIC",
 	.read			= gic_hpt_read,
 	.flags			= CLOCK_SOURCE_IS_CONTINUOUS,
-#ifdef CONFIG_GENERIC_GETTIMEOFDAY
 	.vdso_clock_mode	= VDSO_CLOCKMODE_GIC,
-#endif
 };
 
 static void gic_clocksource_unstable(char *reason)

-- 
2.55.0

