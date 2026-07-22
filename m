Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415CC473C7E;
	Wed, 22 Jul 2026 07:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784706849; cv=none; b=ECCFepOT5CJAXP0CdnvDERmmqCAVQAgjDl+fJ4yf9A8b5bMbQEjfJ90QlFRXw+K63dWYnxnA91Kq0zfQnoLK9Y87nVbT/qfkXI+hCzP2zeIbbDqrRXgYw89xu+9NDffNZKdozm5gRyDz/GITws2jTF3Ld8p9+9jGVA3wnZs3IWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784706849; c=relaxed/simple;
	bh=lW6xuPaawuRjNMiAq3NjJ0vYClBA5grQp8KXYE1QcYY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ek0v65KmgiCjVEqorxWZHEmrdbQnaWSqbtW3blHfD3uS5U7WAZkPsMjWWjumlXe6YfkjRPJBNuS9fU/DHI4Yzsn4lK9eGecOBSRi0dubeHJLZqDzoVYmObcRp0lHEpAMfIhpIbn+gLFKyf7N/7JABMtAZF1fxgcaSAiLioOgdCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=twHNINz4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lB1XSUsj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="twHNINz4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lB1XSUsj"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784706845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HNMoDfSuSxJw6SemBX4XpeIAZF6FAMIZenhTrRJVbbc=;
	b=twHNINz4A2SgJbaSpIoLpDzTN7YT8azPLRBbltI/J5f5JMFChDr8oKpgh4SphRI5q0chFt
	mIPt+MQ2aRzIz07nxSovXnyMXPg1KvtHBtf4JmSzpQfnA04J1OjCyPeWCo8P5hajJ2WY+E
	Thci06srHo7uC+ZeBH0kZyOb5GpxJUuMxCk8aFYNGUNAYFFOhp3eQVvY7quO9bhPE7bk7j
	/eyh5hftII79ZkBHyq3Er3e8v4JqrrXkDg97jlTR82zs9vf7rnReVoqyVVzecVDyyZyhtu
	EIb6A5EgWn6Saho2Fr9g3YE2lWq7KZq0PnQkaRxWjP6SkiT+w9bSY3EkPSYH+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784706845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HNMoDfSuSxJw6SemBX4XpeIAZF6FAMIZenhTrRJVbbc=;
	b=lB1XSUsjBnCXqApB7W0QcRzaNLHwWXJ95tO/El8sb5mxMywWYDiELO2wOTmTzx2LdDsz8i
	VxPjEIma+g3/LRDw==
Date: Wed, 22 Jul 2026 09:53:31 +0200
Subject: [PATCH v3 5/7] clocksource/drivers/arm_arch_timer: Remove
 CONFIG_GENERIC_GETTIMEOFDAY ifdeffery
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260722-vdso-arch-clockmodes-v3-5-4c5753191cc4@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784706840; l=1164;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=lW6xuPaawuRjNMiAq3NjJ0vYClBA5grQp8KXYE1QcYY=;
 b=NRifUvpmMshkko5XZJtE/zr5zJOM6EqTDxL7DRbDbjNzbeJRv7QVDtCV+e1/53nNIfaD2atG2
 wBt65asPzndDT9QEKpNeCrDUgSOjQCMFhMZAk9SKEfv5di8/SfedsSz
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

