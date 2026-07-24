Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82201434E30;
	Fri, 24 Jul 2026 13:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784900294; cv=none; b=Ap8gbdiod6zEuD3JA/wQwWNU0mxmkOtgCMBiOHa+C2gMqBp84riFDl5p12hJeF9yQ/MFPipewfWjm5cSSwirZGQcbYhMb2ZPf3DWEW5Cs7iROl+FyFBlLBqjpmQonO/xDoyira3/xz02BVLY613nAVPFlBeEg0i/E5GFqVEg2L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784900294; c=relaxed/simple;
	bh=6njepM9aoRoFusxbCJ2Ptn3ocLjwqPODCMiHZfeqmAQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=itvkO8Hzyw+3gY3lAeqTr3rfVZ8Dz4sZ6gL/51XncdTZwIOo+OXfkaxLuXC8yglbQMHwwyfd2VKnjX+PMwZ+Jyr4EJ54V2P09atGOKIqdoa7knNTueeCa9fpFUr6jc73mPAE4LMImDxnW95olVAw8zWVSwtauYK0BstACuIfDMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uqUzV0NY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QdpEAYG5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uqUzV0NY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QdpEAYG5"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784900290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XQMLx+20gZIPhu6fhJcix+G46/n6BMZRZhFfen7tOCo=;
	b=uqUzV0NYFb7ieencYml2faMhFQzti7121pHxXW9cmMkJRXRbna9CO2POLwIjHKLsM1H4xK
	Dd+sjptgKWWJd6EX+F9KhC/hpNGJ0/GO9+4oJzoxqiGxR0DK7cW0wjEYKWjC2balVEEKc6
	e2rVK+ayx0idQ7Sl6p5ptYgn6hmKFQ/Ta9AhmHnlW9+BH4ADrGPR071uSVSDDFADEWAB0f
	NY4ws6fqfIjtqUDPOpP9BsAZyPdeOhrc2WikDFnliqMoY4uOUt4GWRsM0PHHLgGJ2RA6HF
	+BWuJ1FIgDdlpFf1S6CXSkfIpc3FdehXz5UsqnlJu1e2VLFIXwAamCl1mGKyKA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784900290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XQMLx+20gZIPhu6fhJcix+G46/n6BMZRZhFfen7tOCo=;
	b=QdpEAYG5R2YSM0ionPd/7GINsEOmj9QnFSv5exEX+24Cp6+grLf8aMdPl8z4sH7AibE+E3
	8QTPGdJjY08s/lBQ==
Date: Fri, 24 Jul 2026 15:36:22 +0200
Subject: [PATCH v4 5/7] clocksource/drivers/arm_arch_timer: Remove
 CONFIG_GENERIC_GETTIMEOFDAY ifdeffery
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260724-vdso-arch-clockmodes-v4-5-ddbe447be860@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784900286; l=1205;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=6njepM9aoRoFusxbCJ2Ptn3ocLjwqPODCMiHZfeqmAQ=;
 b=YJHIR6wb3YNPF73ed+3uprMQgLye4yx87dQoWXQ018PvGabImJT4D4l3VYkwXmofSixRkGii1
 OkSo794dInuAtIcjhdqMoxSjVlGQJ9s9KPkzCm00ye2yWwqDYaX18XD
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Now that there is a definition of VDSO_CLOCKMODE_ARCHTIMER
even if no vDSO is built, the ugly ifdeffery can be removed.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Acked-by: Marc Zyngier <maz@kernel.org>
---
 drivers/clocksource/arm_arch_timer.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 4adf756423de..a5157d8a8a13 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -56,11 +56,7 @@ static struct clock_event_device __percpu *arch_timer_evt;
 static enum arch_timer_ppi_nr arch_timer_uses_ppi __ro_after_init = ARCH_TIMER_VIRT_PPI;
 static bool arch_timer_c3stop __ro_after_init;
 static bool arch_counter_suspend_stop __ro_after_init;
-#ifdef CONFIG_GENERIC_GETTIMEOFDAY
 static enum vdso_clock_mode vdso_default = VDSO_CLOCKMODE_ARCHTIMER;
-#else
-static enum vdso_clock_mode vdso_default = VDSO_CLOCKMODE_NONE;
-#endif /* CONFIG_GENERIC_GETTIMEOFDAY */
 
 static cpumask_t evtstrm_available = CPU_MASK_NONE;
 static bool evtstrm_enable __ro_after_init = IS_ENABLED(CONFIG_ARM_ARCH_TIMER_EVTSTREAM);

-- 
2.55.0

