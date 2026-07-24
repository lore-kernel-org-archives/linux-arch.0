Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1613B71C4;
	Fri, 24 Jul 2026 13:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784900292; cv=none; b=EOatri2tdo3htJg0ZXNOsyd+4yJdtt8GBMOJHO+bcRZo+gFkjxSUsLNQidpHeTbFuzpioH9a3nBTiXhUlyjdhu2WXMLfY2A9Y0YaMQssouH0DVG/h0L2CkpVQ1QO0xie60izhcHv7G/YWsTBz6ZtPkNn50Lznmo6YxX8ERq95Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784900292; c=relaxed/simple;
	bh=t3APLy9t2SZVxR8iClS2KaGCf82ju0LDxr/0aH1HIvc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g7uAROzqPUPQbbPRNMPfiAqpkAbiYP46iAr4ysTOVZ5aSbXv3w6BUWhovui7fnrEpUiboX1nV83oWdok8RnoqBRm7qAdIUN1GBSOdJnx1nagnyEXefPFwM1mrIc+pGhz22ANUPSvfERxD6mIfU0DEsUMUCg3JU0rsLWRyiaLbDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=w08vNlN/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mICZxiNq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="w08vNlN/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mICZxiNq"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784900289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vQbno2WvTFVUJzsRinFLe6H6OiW8r6h0VjyMcplhKIo=;
	b=w08vNlN/1qP0TE/LEs3JpUNTMcs0fe5tTihU2b5AIsHLb1HS2DmwuvwNS+ZTtmsOdi54hp
	j79csgdIF9NYqEjvu+hvpCC0M0ZieIdbOft2NAhkWY8BH8N+54xCKnYsAHUUcomBiiQBGi
	ooF7WNOCftD2asHsJ08FwOcWE0f3Tfy9BlVe7XeP8luZ52oY/9gfGIUSVL1glTF2v5W1K7
	h6zmgAHkwVUXVn8OXzplJxv+XBa5Csh2IW502AQ96AxvY/I2Pg6XB1CImOq43mwXB6LJdj
	yGkzb5YTRH0S662RyTldlVm+eB5DhJbl4CWwYX3qUwzfl/wDU4naKFw7VAb2Lg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784900289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vQbno2WvTFVUJzsRinFLe6H6OiW8r6h0VjyMcplhKIo=;
	b=mICZxiNqacPfXk7IriXNrjH35mh19WZ8bYoPtldamZ94WReuMP7pfPY0H9svB0WbRiI01+
	RolmnmFovvUiUACQ==
Date: Fri, 24 Jul 2026 15:36:20 +0200
Subject: [PATCH v4 3/7] MIPS: csrc-r4k: Remove CONFIG_GENERIC_GETTIMEOFDAY
 ifdeffery
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260724-vdso-arch-clockmodes-v4-3-ddbe447be860@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784900286; l=1015;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=t3APLy9t2SZVxR8iClS2KaGCf82ju0LDxr/0aH1HIvc=;
 b=ZeqNGUZ8fvsgAE/k9e92r2SrvqOVJqmOU8TykTiEM3Ah7oL/sCvlUn+kXy3/j2iIKYkXoZkLu
 uiEZTPtRcB4CxctGflsRyedBFK6uyBO4RIB3heK52dAYfafL84lNPI9
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Now that there is a definition of VDSO_CLOCKMODE_R4K even if no
vDSO is built, the ugly ifdeffery can be removed.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/mips/kernel/csrc-r4k.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/mips/kernel/csrc-r4k.c b/arch/mips/kernel/csrc-r4k.c
index 241a934543a8..59eca397f297 100644
--- a/arch/mips/kernel/csrc-r4k.c
+++ b/arch/mips/kernel/csrc-r4k.c
@@ -126,14 +126,12 @@ int __init init_r4k_clocksource(void)
 	clocksource_mips.rating = 200;
 	clocksource_mips.rating += clamp(mips_hpt_frequency / 10000000, 0, 99);
 
-#ifdef CONFIG_GENERIC_GETTIMEOFDAY
 	/*
 	 * R2 onwards makes the count accessible to user mode so it can be used
 	 * by the VDSO (HWREna is configured by configure_hwrena()).
 	 */
 	if (cpu_has_mips_r2_r6 && rdhwr_count_usable())
 		clocksource_mips.vdso_clock_mode = VDSO_CLOCKMODE_R4K;
-#endif
 
 	clocksource_register_hz(&clocksource_mips, mips_hpt_frequency);
 

-- 
2.55.0

