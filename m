Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E793ACA6F;
	Fri, 17 Jul 2026 06:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784268907; cv=none; b=DZyW7ovjzKJbZf4POF8umwvd8turWCUx+6PMGWuGlw7h5E0HQNQ47hKb6jsYkVsbZ10sIylpuRt8HNB20bWAn5dEfiujUAj1pIRNfzmz2mB0IayiP6lp1eCi33wCgT+1PswSH3sru0y3ADCR9M+cb4jvj0DuYK2ZN6jpgtdVIZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784268907; c=relaxed/simple;
	bh=lW6xuPaawuRjNMiAq3NjJ0vYClBA5grQp8KXYE1QcYY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WxuMCBW8JSnK/F+DNdIZX503S3ojGdlslTBxZ6kgv8f3VBIKNrLlZn3V8MwG1ZjvrrRNUfR7Ad1Vc6youq5aTxQ67ABZYvgGnYN0Lc8hxWRr0EQ9FyvXCF2dgpcnmSNnrVKu1ZGt64xUWNhmiU3h6bTwF2qFQxVTzHFBc/v27sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kwP+ZcbE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zjvF0lrK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kwP+ZcbE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zjvF0lrK"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784268902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HNMoDfSuSxJw6SemBX4XpeIAZF6FAMIZenhTrRJVbbc=;
	b=kwP+ZcbEqDHqXFtctAmbUthHdgfiiuFcN2xHVOYaUW7PDhIR6C289v7UXiK1eBtTmNxrMm
	rz8dTIO+98UVlTaDRsll2yY0JCSK1xmhZ8fcr/LSwUsPRvFjXdZx3BSQdpZcczfEDs59du
	ljx+O0aVL+oPKU/5/haP59Ds0Zhelsb8dYL8uQOqCPVlt2kjUEifhVhKVZqgti+d1LDZjW
	Yni/3nNOvYDSiJc3WCS8I1bvDfZqJxeK/QjSlWPkZVGeRqJ39ZRrVnnHjcYYtmTBNj8Q8y
	9kDdXJ8R+z70lvDEPB2ZcU5dZsoZyS9m7S80ob9ywiDoH2FPQ00pcdQOjYr6OA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784268902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HNMoDfSuSxJw6SemBX4XpeIAZF6FAMIZenhTrRJVbbc=;
	b=zjvF0lrKY5L8Q5gp78MHGd7S8u1KObPwa73KgVbSZReQycUp5yzr9zhhZcUqRJcMuSV3XD
	+41pq1V3hc4uGiDw==
Date: Fri, 17 Jul 2026 08:14:49 +0200
Subject: [PATCH v2 5/7] clocksource/drivers/arm_arch_timer: Remove
 CONFIG_GENERIC_GETTIMEOFDAY ifdeffery
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260717-vdso-arch-clockmodes-v2-5-756f5a5d1467@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784268894; l=1164;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=lW6xuPaawuRjNMiAq3NjJ0vYClBA5grQp8KXYE1QcYY=;
 b=eXGwaK8fUQKZ2qgKSwMeVNdT1BL4zzlDIrGbovIZgFnCvBWvLcRXwdi1C341Kpq1ckzLl7AP7
 MaEHx4ncMWxAJmsA/+HulnDegxAfFq0oPXuQT/WwGPJdnlJvdSM7+yr
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Now that there is a definition of VDSO_CLOCKMODE_ARCHTIMER
even if no vDSO is built, the ugly ifdeffery can be removed.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
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

