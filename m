Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C983AB29A;
	Fri, 17 Jul 2026 06:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784268904; cv=none; b=UhRDteQM1DbRrGjXTiFybhf125y0PHGiXM4u/Z7xTETYKc2+O12upPMr1YzvlHkhqwV5AerBefKhVdJ391cPbG4/bpw1UzY9WotyvIhm/eUtt5SytVqOlc8FHfPIEEm1EHX/i5OBrwWzeuRHuXlh/LbH0gV8Yot8I2SKxxsO3W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784268904; c=relaxed/simple;
	bh=iYdmmwYnitqCJzJDOgChDbBElLI/0ThiAUZVrCungs4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ObJOwcpvqfjnALsaAlkKjFlrxA9p1QOZyGinEUkLaJ684jETXXEyOHAiw/ga93ZEQxgx16E2ovJiJd1olpb4eTWwmrSpeZKNkxYZ43eKlUHFxG5ZvenGqlkWVLQxN530zeIQYiA2oa8twiDpASzb3X085C9mwTxYrqzUj61BKW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=P3SX6syH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jSwIUk6v; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P3SX6syH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jSwIUk6v"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784268901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wy4A5Bpkj2zzKdn6eNsWOzDqtG3uGM/7aAgamplxzrs=;
	b=P3SX6syH0JPq+BSR8L/gxIQXPwFFAE1o3/ph72Jp32jnjpxe38j3E7hjV4F1gTP2WgTwoX
	ddZ91PW3NOhqQNsORIGBeh00/kVAuX9mpGes7V7A7uV5apMInBM/3qvHupwtjYo2FIHoEv
	6X2nBf6kkBntHAsfm8NY14cfoErnb9FkM94LqODtMEcPSPDp3E6hqxVhGc8Phzd8gOsVyH
	J9D4IP8GbsIa/Ofz1ykBl/1AQPH57q14h/1Sl8dfWELEfww7E0l02mrj/KowFPbcrDqf00
	sekRqUJjtROJBEhIuQWnarqJK0yNhKAoUw2IeErUi/17vT3L2dIDVgHmhO3CAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784268901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wy4A5Bpkj2zzKdn6eNsWOzDqtG3uGM/7aAgamplxzrs=;
	b=jSwIUk6v3+SYazZJ8ekQtG0on+6D+EFv408GtpL3sHwiYVbYBQ+5W/q83dsQg/4vpWev3r
	904VBVIAQUebi+Ag==
Date: Fri, 17 Jul 2026 08:14:48 +0200
Subject: [PATCH v2 4/7] clocksource/drivers/mips-gic-timer: Remove
 CONFIG_GENERIC_GETTIMEOFDAY ifdeffery
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260717-vdso-arch-clockmodes-v2-4-756f5a5d1467@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784268894; l=811;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=iYdmmwYnitqCJzJDOgChDbBElLI/0ThiAUZVrCungs4=;
 b=BFHrzLnVuye2tr+e2SIbjrPgLrJp7uaBwOS9ADqw3d0W/ptiTxietvQ/GYUtcy6TC11wLvy6x
 s4V0okkKzhyBxX091qQRCW+pdzTXMAeayl0oyQpbQAksL41O4o1wJc0
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

