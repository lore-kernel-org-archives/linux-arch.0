Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682BE42188B;
	Thu,  9 Jul 2026 11:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783596768; cv=none; b=f49IWJ2vo33vcTz5l09hbF/q6gJ0x5jbSSyxeI4dbUGaNsl7a/Gmvb1yA3ET2JII3hhH4B0vTJXSL7f9RGT3/4zq6mw8lENhmDlTlooXnwQzVnvlWpzULvqlIiVH0LgLc2YxX6HdbnahCUQ++Lt75ZyKKb5q+0dTSqmgT2JDuGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783596768; c=relaxed/simple;
	bh=HBDbLxQ/mmLThuSCavhDFNuAv2+3px29VTHQ8QYWw1w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sZwUZ9dxpXyIKTJ6+yK3WRsmsGWW6EBYEkRY746C2LAEkZRkJWu1/VLGdZwW8yJoJTV4OMLkMNvUvjRkksN4RYSj1LUNI9twu5RGP3GjV6j45vGDoMgetdyGHRwm+7p4Zu8CztZyI3oQnZHuXFxISKOGbEbssdpt5RV2apIh+KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xLBBBBbh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OgMhKys2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xLBBBBbh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OgMhKys2"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1783596761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3ukFASTVcwJCA9KHs65XStV/NanPY9+t/aJWekQ6IKw=;
	b=xLBBBBbh4/VWO9XnxdBWWEUvqzn9mmxKtghNmN65V+Cf4har8MzUX9hyoH+gOUFNJ0QDZH
	mhrQzKul8EzypjUmmlpwnx86X/j6mp+M74+44prDPC5Lb8pQqlkpFANr1hPoiweBhjIMvL
	IJQ6MiL3Yuyh11sCsUB/qGlCV3fC2EXReRUTsEgy1o+ZC4hqFkeSEsi0TIZ4voWO+rfnY1
	Dv8Px5LpQHM/R1zjHRBtez08FAjNDJgYULJlhWKa/IrL6yP6/p/2kOaw2JHAzOmlqglsU6
	/03UR9MkVzy/rbOrYQVZ342ujoRW8Tk7nPvjQmW03SqWiWzVIxa6VuNOlviODw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1783596761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3ukFASTVcwJCA9KHs65XStV/NanPY9+t/aJWekQ6IKw=;
	b=OgMhKys2yLyiiIrzt/ebS8mgwv4WAKvLSUlGBZDOz+da0ok2x1dai57gPiCFIfoQeTZIiC
	uHk5AT5qmEA4l1Dg==
Date: Thu, 09 Jul 2026 13:32:41 +0200
Subject: [PATCH 5/7] clocksource/drivers/arm_arch_timer: Replace
 CONFIG_GENERIC_GETTIMEOFDAY ifdeffery with IS_ENABLED()
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260709-vdso-arch-clockmodes-v1-5-3fd780bbf851@linutronix.de>
References: <20260709-vdso-arch-clockmodes-v1-0-3fd780bbf851@linutronix.de>
In-Reply-To: <20260709-vdso-arch-clockmodes-v1-0-3fd780bbf851@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783596759; l=1366;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=HBDbLxQ/mmLThuSCavhDFNuAv2+3px29VTHQ8QYWw1w=;
 b=/EvHsm6ydzGcPsxrNvqkQUB75XQjGIMB3dJQHMvHaYcR1e6vOjowSLWMYmBC9iC39j5MyPR+r
 GKnBIHG7yBIC0ZzIDI8rObHsO7fQLB+a+bRP7h1extXlNquFlV9wR/m
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Now that there is a dummy declaration of VDSO_CLOCKMODE_ARCHTIMER,
even if no vDSO is built, the ugly ifdeffery can be replaced with
a cleaner IS_ENABLED() check.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 drivers/clocksource/arm_arch_timer.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 4adf756423de..d67125a8730a 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -56,11 +56,8 @@ static struct clock_event_device __percpu *arch_timer_evt;
 static enum arch_timer_ppi_nr arch_timer_uses_ppi __ro_after_init = ARCH_TIMER_VIRT_PPI;
 static bool arch_timer_c3stop __ro_after_init;
 static bool arch_counter_suspend_stop __ro_after_init;
-#ifdef CONFIG_GENERIC_GETTIMEOFDAY
-static enum vdso_clock_mode vdso_default = VDSO_CLOCKMODE_ARCHTIMER;
-#else
-static enum vdso_clock_mode vdso_default = VDSO_CLOCKMODE_NONE;
-#endif /* CONFIG_GENERIC_GETTIMEOFDAY */
+static enum vdso_clock_mode vdso_default = IS_ENABLED(CONFIG_GENERIC_GETTIMEOFDAY) ?
+	VDSO_CLOCKMODE_ARCHTIMER : VDSO_CLOCKMODE_NONE;
 
 static cpumask_t evtstrm_available = CPU_MASK_NONE;
 static bool evtstrm_enable __ro_after_init = IS_ENABLED(CONFIG_ARM_ARCH_TIMER_EVTSTREAM);

-- 
2.55.0

