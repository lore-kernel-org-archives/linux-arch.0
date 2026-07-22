Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9454446F4B0;
	Wed, 22 Jul 2026 07:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784706846; cv=none; b=mA2W1glX3m36wLJrciTTx4GJpnOisXhU39fO10Yliozek0caK5hFRrzoXOfc0QOGX7ikxas7IzORNlHS0Bq2/+e0+QyBmUg9did6ohbWCiMgQftZ0bQzHS4wvLdbfs7O2r/xyEsWXeXprXs13KE2du2fxI2Ki8dsEuudmuNsWCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784706846; c=relaxed/simple;
	bh=sXLjsimGUSXXUsc2qCiD2uC+XdCfB1PERWY6JkUJ0UM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cvifXeE3I008pH9IDpnjT6dXuQcRBgNvK2fGni8agURSnqJCn6Qbg3Q5WS3ylCkdjB5q8WhbMf7ZdLzCn7BvkAUENfrXY8+rCsntDCrh663c95fg0vq/YoYz/UwSc7zi6VLPvE04bPljrZ9fWzSxDc8fT1gdQPpsMZubVD4mhGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F61HdFym; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Zrn6X7yw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F61HdFym";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Zrn6X7yw"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784706843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DETzi99iW5LSyN+yHRyHD/USkiX0xstftPX39RhkXRQ=;
	b=F61HdFymViC3ukVd01nJrWkuHvyUyfEkTyjXYwQdSGa1VcGUAFtLgIFQDyzo/SlZQjhdOz
	hcr748HWnqQ2iNyQh2fh946cCB/vpvqtvBN5Two2EEPARvAz4b9/xVIz5UDT9k6GwTU1oe
	JInpKgTPCXngYDyOhmzz5scEvHI21UV263HuHudO4phGg30NvbXax2uxnAS0CLN+V9qZke
	Hx63wFpY7+uAbjHWvTMYMrMtDlXZoRhoFc3+kEhLYcWOjYAIQEYnaCwO1B1oq2DqyUeZfZ
	m9JGaBHLbFQOID65bbBGeTOSf7kOK5Lw3iJLixldcujkODCcf//cbZ2bwf0dEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784706843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DETzi99iW5LSyN+yHRyHD/USkiX0xstftPX39RhkXRQ=;
	b=Zrn6X7ywEQ2VhnWDfmjyo8A17SuZSw/fMV4ucdja337+xN6fnXGR7tpU66i/wAvLLNWEVw
	ATyakOMGiXGIuqBA==
Date: Wed, 22 Jul 2026 09:53:28 +0200
Subject: [PATCH v3 2/7] vDSO: Make clockmode constants available without
 CONFIG_GENERIC_GETTIMEOFDAY
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260722-vdso-arch-clockmodes-v3-2-4c5753191cc4@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784706840; l=1748;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=sXLjsimGUSXXUsc2qCiD2uC+XdCfB1PERWY6JkUJ0UM=;
 b=cXaFIgcYiUB2wwrHHfBslBD7y0L62mFnT4tLN0nF30Bff5jzXmwM85Ect4R6/BWgWEyjN6qvd
 VxIt+W4M/+6AfjXy4eatdZbv3Fs/PhuGkcZr60JIA/xjb/L4ldzmP4R
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Some code, for example clocksource drivers, may want to use the vDSO
clockmode constants even when CONFIG_GENERIC_GETTIMEOFDAY=n.
But the symbols are completely hidden in that case, making ugly
ifdeffery necessary.

Always provide the enum definitions.

As not all architectures provide asm/vdso/clocksource.h,
provide an empty stub in asm-generic for it.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 include/asm-generic/Kbuild             | 1 +
 include/asm-generic/vdso/clocksource.h | 0
 include/vdso/clocksource.h             | 4 +---
 3 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/asm-generic/Kbuild b/include/asm-generic/Kbuild
index 15df9dcb42a5..2bc00c67dc54 100644
--- a/include/asm-generic/Kbuild
+++ b/include/asm-generic/Kbuild
@@ -62,6 +62,7 @@ mandatory-y += topology.h
 mandatory-y += trace_clock.h
 mandatory-y += uaccess.h
 mandatory-y += unwind_user.h
+mandatory-y += vdso/clocksource.h
 mandatory-y += vermagic.h
 mandatory-y += vga.h
 mandatory-y += video.h
diff --git a/include/asm-generic/vdso/clocksource.h b/include/asm-generic/vdso/clocksource.h
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/include/vdso/clocksource.h b/include/vdso/clocksource.h
index c682e7c60273..bce81c02a7c6 100644
--- a/include/vdso/clocksource.h
+++ b/include/vdso/clocksource.h
@@ -4,13 +4,11 @@
 
 #include <vdso/limits.h>
 
-#ifdef CONFIG_GENERIC_GETTIMEOFDAY
 #include <asm/vdso/clocksource.h>
-#endif /* CONFIG_GENERIC_GETTIMEOFDAY */
 
 enum vdso_clock_mode {
 	VDSO_CLOCKMODE_NONE,
-#ifdef CONFIG_GENERIC_GETTIMEOFDAY
+#ifdef VDSO_ARCH_CLOCKMODES
 	VDSO_ARCH_CLOCKMODES,
 #endif
 	VDSO_CLOCKMODE_MAX,

-- 
2.55.0

