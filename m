Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1079741D621;
	Fri, 24 Jul 2026 13:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784900292; cv=none; b=pnzhnJdsEDC+zE17vGCH2oICjjneuHyLky1zmuA/TLEQA4jcJ7wLR9evoVD087DaXtnyT1hECFIiykN95s+8aUP50WQ1qxxfrX2fpNmAKkssa1B/0xC5dX+4bCfzqblYHal63iSq3Ubxr/dTj/87QeBzrjRP71vukvzbf+xzrGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784900292; c=relaxed/simple;
	bh=iYdmmwYnitqCJzJDOgChDbBElLI/0ThiAUZVrCungs4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SVou/I9R2cEPochbuSd0ekBZKye+Tg5H0j+ibLA7v6NiTtCAF2ZjE4Y7C8sEd9YjmMUYwItofSRC1Pqm//WJ9fPcG0pW8xj3wSqneMfNhX0IfdxprbV5Xw5IZzqWm/9f09GknkSTcVuivQwMMF7ZCoR+hEEulq+ySmrxct8WxrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2U8jilIg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q1F31dVh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2U8jilIg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q1F31dVh"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784900289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wy4A5Bpkj2zzKdn6eNsWOzDqtG3uGM/7aAgamplxzrs=;
	b=2U8jilIgSOX2MesW1TqFhZVOcZum0yVR+Gd7Zq27fM1Y5Bl5046LD6QTN61G5WhM56lgDT
	cN3YkYdSKhGvl+Sn07+Viosz01xADZp6v79ssYcuxuSsQxOajv6G/Nx4Ww6sXfKQXSh8K6
	MxSZ9gi+ZI1RMgMESPFM3ar8injy3V1AKseq5y36/LW/mhTgFI/OX789GubXKnh+cvEstG
	RQT+XEDqpQvQKhqzQpwJjiMmBz2ATyB7r4xoCliD5SyUFRlWnUB+vumNCKNSHbuyhCgu0X
	VP3Sq5QTxIJ/aL45iaoMxxXhwSSdEql5B5GhbWoqyyh5A2IQ2GrgRpKvs+ttCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784900289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wy4A5Bpkj2zzKdn6eNsWOzDqtG3uGM/7aAgamplxzrs=;
	b=Q1F31dVhel6UUSlIPpjaopNSvozk4hIYscfNtC1KH/KwTte+yVAJaOSrOKmhQF3b9F4xR2
	sEAk5FUXN35py2CA==
Date: Fri, 24 Jul 2026 15:36:21 +0200
Subject: [PATCH v4 4/7] clocksource/drivers/mips-gic-timer: Remove
 CONFIG_GENERIC_GETTIMEOFDAY ifdeffery
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260724-vdso-arch-clockmodes-v4-4-ddbe447be860@linutronix.de>
References: <20260724-vdso-arch-clockmodes-v4-0-ddbe447be860@linutronix.de>
In-Reply-To: <20260724-vdso-arch-clockmodes-v4-0-ddbe447be860@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784900286; l=811;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=iYdmmwYnitqCJzJDOgChDbBElLI/0ThiAUZVrCungs4=;
 b=X7Y7/vKfKKbTG+YhMGCzch0cwqw4NfwBkOT+/8sZgEEsO4MMp/0iULjNfrCHGytfA0BAf9G/y
 h6kcR+C8LhjBIiKCio3Jdse0pQ2Y2+4iTSTPHZ3GR7STeAW5PDD3wYG
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

