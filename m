Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A95476CE7;
	Wed, 22 Jul 2026 07:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784706854; cv=none; b=spD5ESfXwd3z6VDoZkwkq+kN3LeqvcyiPFIOKcmp/GStn0uhUlX7mcd0ye5dnMH6ptOa5sc7YUttJaNAVGdc/qQh6kNK/dU3je3cSXuDXFQ6Lxze32czmd1vDR2Ut0H9+1//rfGVfwIl4B+eIwJoVOW0WxGX5vw/pkGwo9ooApM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784706854; c=relaxed/simple;
	bh=/YNIeu5dDcZIdRrt5u3jACXGrJAGqwCKT4gDnUxNTGQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tcnRaSqgrAFAbwiYZX1qLFUlRcpwZFQZuLy97OeZuHJhDOrrZ8lobIjH3/mywjzfjE0PXFfGHu77GFlFfz3u42ZtdoK1+iKaoxv1SikogkNi0v+x42qBDfKO2n7+dt7ohcdKftuEJq6R0HyQxkRQLFi+N91IZIkbILoX7Ru9K+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lj6BiwqY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pZ9riHf1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lj6BiwqY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pZ9riHf1"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784706847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cIw1nW13D3Q7KVGq3dxw/myoCljjqPSm8YvxUaQYWA0=;
	b=lj6BiwqYOrE0aDK2EFCLrYh5Af/utIViNCL2jpjzeuhVjQY2o7E0syWc3xaDMlXsmophVW
	vMt2uiv93KyIbRt7vixOBsrVneDYRipZK14F9VpCu+fpzjub1m/VWYsGQHhSoQX71uzNWC
	4lbdPT0NBdY0mDocXFy4QuPf9m3IoNH5gdfE2ZGwdwns9EUxDDUrQbHZI1ZJ/30erVO577
	ECLGCRDHiqOgj95JBz/0saAvAKtzknTaEYtXJEYcCzHqXYv08isH1DeEgyN0SfyDONbkEo
	lStk+Ha1FFp8PegCpYZuz8zXM4w9PjeaFdWHlO/j3s93+cKvsep/Q+DJj+r6Ug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784706847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cIw1nW13D3Q7KVGq3dxw/myoCljjqPSm8YvxUaQYWA0=;
	b=pZ9riHf1XBn+9Il8f07lihrpmD6LcwQuQjzR6UhCqua7uPaoroJ1pr0/k8yptxhrEorYbB
	2KA8S3Gcgs6D4PDQ==
Date: Wed, 22 Jul 2026 09:53:33 +0200
Subject: [PATCH v3 7/7] LoongArch: Remove CONFIG_GENERIC_GETTIMEOFDAY
 ifdeffery
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260722-vdso-arch-clockmodes-v3-7-4c5753191cc4@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784706840; l=780;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=/YNIeu5dDcZIdRrt5u3jACXGrJAGqwCKT4gDnUxNTGQ=;
 b=Twbp4yMRDwWEmhDfIOAFA28rWYRwAbqDc0G17Sn33XZK9XFt8oiKPwZa1+eguZlEquMr4FJPP
 MwusKRX/awmAQUdQzwVFaeuP/TuKXw+pg7+hNPizD1GzYkynl7tsPHw
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

