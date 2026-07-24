Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B86435509;
	Fri, 24 Jul 2026 13:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784900294; cv=none; b=CuXrTYIBH7y4W5MDCFHijOUN367AjIobS6h/Sil/3AvqbGxqq+hXLc6KWAOMflUSmgExN0PO3PLwtYUoEeTmk5oUF1voWn03wGOGn1wpb7QHVxnt0098ZF6wG8q7330TCcPaAr7gY1EXK+4sOhR3q/uNQQBpTbS7jIe4GdncoIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784900294; c=relaxed/simple;
	bh=/YNIeu5dDcZIdRrt5u3jACXGrJAGqwCKT4gDnUxNTGQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=THGWF2qNVOSM8J/lrue/urLiOfUXd286257MIeMXk3j3B7yOX6vFFOMGAn3R1X6nUom2IDtXWcey5RkcGJ6S1I5mTjQfQnb2N4Zollw/Q/gL4Da0/AynxeiQU59RazaXk5vpHwBzczNPfKnLqBunh6XeHFJKlBjQGJP0ifeT7WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=P6QsKIcO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X6D9RzhI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P6QsKIcO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X6D9RzhI"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784900290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cIw1nW13D3Q7KVGq3dxw/myoCljjqPSm8YvxUaQYWA0=;
	b=P6QsKIcOM3wbtosTcti1hgVEjlSxJo1mJTRJ9rQNUu9Gh67ntWPVBWiLjkc1UQq8W86rec
	mkoRaM7tWTvj7JlnFKEcQbBCK7Xu44s+GtpNnvPf3a5YIPhd19AKaNj2QG6cb8uJ6p2Ba0
	k9Y+fdhWXtTaIlCaRXYwAbbdB4Eh1xbgavilH8bkOkTuzQ81PFPpfzZQkIu1mnKS1lRd+t
	5w+FIFYIeIht/W3Bjjvpxi48l74/xDMmGY1XgDqkmMD4BI4AIjFS6J6oHbtjg/UT29GFPg
	Ttsqa41wmt4CDOJh3yk+Im3GmR342YQRe6emKn1B91Ucdbx7Mko+uCM7MNBshQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784900290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cIw1nW13D3Q7KVGq3dxw/myoCljjqPSm8YvxUaQYWA0=;
	b=X6D9RzhInEuUkkie6FUghkOkKZYRkjouvhaiCe6fHww+jTAT6fXLnus2NMw4hEdlj+5uAs
	dGRzbp/3bgB7qFBQ==
Date: Fri, 24 Jul 2026 15:36:24 +0200
Subject: [PATCH v4 7/7] LoongArch: Remove CONFIG_GENERIC_GETTIMEOFDAY
 ifdeffery
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260724-vdso-arch-clockmodes-v4-7-ddbe447be860@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784900286; l=780;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=/YNIeu5dDcZIdRrt5u3jACXGrJAGqwCKT4gDnUxNTGQ=;
 b=ezHXJP72IsCgQjW0X5M8lHPPXidInmHgcdYjAVig8SvM52XGjn7gGTMAJGL/lETzsPys9CJZg
 FdUROq9MD9nDvwQslmoauS+BqUFEbWJPpJvpup8MM2zgYCJObAmPucI
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Now that there is a definition of VDSO_CLOCKMODE_CPU even if no
vDSO is built, the ugly ifdeffery can be removed.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/loongarch/kernel/time.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/loongarch/kernel/time.c b/arch/loongarch/kernel/time.c
index dbaaabcaf6f0..5892f6da07a5 100644
--- a/arch/loongarch/kernel/time.c
+++ b/arch/loongarch/kernel/time.c
@@ -212,9 +212,7 @@ static struct clocksource clocksource_const = {
 	.read = read_const_counter,
 	.mask = CLOCKSOURCE_MASK(64),
 	.flags = CLOCK_SOURCE_IS_CONTINUOUS,
-#ifdef CONFIG_GENERIC_GETTIMEOFDAY
 	.vdso_clock_mode = VDSO_CLOCKMODE_CPU,
-#endif
 };
 
 int __init constant_clocksource_init(void)

-- 
2.55.0

