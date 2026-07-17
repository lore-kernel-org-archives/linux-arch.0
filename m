Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F19236E48D;
	Fri, 17 Jul 2026 06:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784268903; cv=none; b=ajc2kPAlR/QMQiuWf+pRQThk0fXBjPWl1gImNkv1snw3w0tt+KlnkYJb4dEmzR0UReC690IU+L0rKFtR6Jt1Ttqu0FroMR7/Nwyltj45FErnmKDTEoPrEipG5zgyWLI5/WF1IzZu5U2NUSC4XQ21kGHbBBm8dbO9vqCJBLL44ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784268903; c=relaxed/simple;
	bh=p9rZWKtD6/YfP8onrdLafhoNLyPoeTcrsrG5G4dPJoE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Eiq1thNzg40QVeqb3SkIua9DyDqFsjdsQrXI5HQLfk/F650VTZ7Z9qvJHf4pPq02UYdMigGdlJRpN7iif3pW+P8rjtmPy8Y9yFpVQzkzM1KH5eFbx/LtwCSvc4mqIMwhn/Fb8zAN1H5OxmW2b+I8iTH/Evt5S1+sIs9Pg8eZ3Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=17HRzV4Z; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3yRzgF+E; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="17HRzV4Z";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3yRzgF+E"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784268900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=itu6k/7LjVC4xl50fE8uK9psTIOXzEDbu436igm+MQo=;
	b=17HRzV4Z0zlFiD4PG/2rWK1+7U7sk2iNELCWctH6MBXHjK2ETGdyaAoYCDTGJ3LrDrFvro
	wV16qiQ5nojRN3PcU8BRBo/4Br54fUZ+uvByQqQAJ3ATnWj3jVFIJ9r4Z9Cd2K9jROAzwx
	3TTkDkfSXLIEH6BVBrclGo4ilXSE4QvO+qxZN+v3HIvPor3fkAOn3a+rkl+hmOpBbWYwYh
	p+kUVZGCOmDqaWfGERQjDQtWA3sxAGzIt1+9W+K2/dFTvoYpJmLOst3y/V2JqvsbKqDyr+
	3sqSY3sRea6JwKgYKvyAtqIccNkdKLHRN2TlVLioucRWRYCNPGOLvpeYIVpMzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784268900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=itu6k/7LjVC4xl50fE8uK9psTIOXzEDbu436igm+MQo=;
	b=3yRzgF+EmD5sj4Dx06hxldC/keHbN8d+rP0Sdm3QquL3zoaK85M7hsoDRJT/bWsR6NOyHZ
	5RmG/Bme8ZCvrUDw==
Date: Fri, 17 Jul 2026 08:14:46 +0200
Subject: [PATCH v2 2/7] vDSO: Make clockmode constants available without
 CONFIG_GENERIC_GETTIMEOFDAY
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260717-vdso-arch-clockmodes-v2-2-756f5a5d1467@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784268894; l=1814;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=p9rZWKtD6/YfP8onrdLafhoNLyPoeTcrsrG5G4dPJoE=;
 b=udpLwy9jwLglOQZMDRkLQ+0ay9CxwhEU9AUOW0opBLf8VjiBjnYIcthAPCsMXPCGNmjqmBrF1
 Wc3RBEpM/TLAmmUd4/wBA4QiNO/5mDrOoBQ10HU1Y7P+0ELeuNkD+6b
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Some code, for example clocksource drivers, may want to use the vDSO
clockmode constants even when CONFIG_GENERIC_GETTIMEOFDAY=n.
But the symbols are completely hidden in that case, making ugly
ifdeffery necessary.

Provide unlinkable dummy definitions. These can be used with
IS_ENABLED(CONFIG_GENERIC_GETTIMEOFDAY).

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

