Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6613FD957;
	Mon, 20 Jul 2026 16:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784563424; cv=none; b=OOO9vU1tQQ8BFLp9aZBiWAhg4kEw6JajsdyUnvOIhGoG6XspoY8uLjoCsh2deWJVJrqCfgoLZBVmlRaeB9UF9rmpwtgETiZbgFhdxfIW8jDbaCubvaR7IphZfLdwEDF/zBTMpOYZYirkMsZv5NlobCoU+81F8q5ArnRzjRGIvcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784563424; c=relaxed/simple;
	bh=poYqrUsi500s0fQyhLYCsmsHf0i//77QFNaIOGes8ek=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bv/7NkBfxd/Fjw63i7EYMH4NjjTBtrUVtHThyvcQZ+0Qfks36yIFmckHGybeSYXH0pYOkGAsZACyfIBbZBhXkrbxED8PnIHisUN7QZ7cmSRWwFgq4bFaiudelChWNpIMP7zj9+HP4bwg0xbpn+FsUB4sN+K/tYj9o80tf6OAfqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=UcfDJoaR; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="UcfDJoaR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:From:Reply-To;
	bh=K8kjW1mgVYNAmXTDHsHgs1H1Tp7aKYu9ZJKgbwnVZzM=; b=UcfDJoaRMfInIUOXPJua32nzro
	TCUnBZXLISViJVj1RXkJixdDH5jwpPXdWaAhrLNaNO4fFg/FHYqc2a79uNPVPkzN15Qb/qNHQ6O6w
	LEw6AOZcKd9E1hst81YMGVx9azzH9Mnd+ARfCOd5kR3OA9//Qjf2dcJWtWZfinqIOa8Sz3Y2ASHoP
	0MZZrxXipDkbrpREof6vuUoYGmRRqIpnR+Rz+SROEqI6Gl9Vl0ipteleX3ini3MPGoE3CQ2vxqmEZ
	rvDmgLKqquAu5A59tj19sLRg7V/mY1nuH5cM+pF5X27S1OL6BORcDB3qgbUaFKfHGrw7evICBgCag
	ya7aJUjg==;
Received: from [179.118.191.219] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wlqSr-001CZ2-Pr; Mon, 20 Jul 2026 18:03:34 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Mon, 20 Jul 2026 13:03:03 -0300
Subject: [PATCH v6 3/4] arm64: vdso32: Bring vdso32-offsets.h back
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260720-tonyk-robust_arm-v6-3-7e68c122047e@igalia.com>
References: <20260720-tonyk-robust_arm-v6-0-7e68c122047e@igalia.com>
In-Reply-To: <20260720-tonyk-robust_arm-v6-0-7e68c122047e@igalia.com>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Peter Zijlstra <peterz@infradead.org>, Florian Weimer <fweimer@redhat.com>, 
 Darren Hart <dvhart@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
 Davidlohr Bueso <dave@stgolabs.net>, Arnd Bergmann <arnd@arndb.de>, 
 Uros Bizjak <ubizjak@gmail.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, kernel-dev@igalia.com, 
 LKML <linux-kernel@vger.kernel.org>, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
X-Mailer: b4 0.15.2

Commit c7767f5c43df ("arm64: vdso32: Remove unused vdso32-offsets.h")
removed vdso32-offsets.h because it was empty and therefore useless.

With the introduction of __vdso_futex_robust_try_unlock(), there is the
need to expose offsets again.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 arch/arm64/Makefile               | 2 +-
 arch/arm64/include/asm/vdso.h     | 3 +++
 arch/arm64/kernel/vdso32/Makefile | 8 ++++++++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 6b005c8fef70..265716644193 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -211,7 +211,7 @@ vdso_prepare: prepare0
 	include/generated/vdso-offsets.h arch/arm64/kernel/vdso/vdso.so
 ifdef CONFIG_COMPAT_VDSO
 	$(Q)$(MAKE) $(build)=arch/arm64/kernel/vdso32 \
-	arch/arm64/kernel/vdso32/vdso.so
+	include/generated/vdso32-offsets.h arch/arm64/kernel/vdso32/vdso.so
 endif
 endif
 
diff --git a/arch/arm64/include/asm/vdso.h b/arch/arm64/include/asm/vdso.h
index 232b46969088..43a214b93524 100644
--- a/arch/arm64/include/asm/vdso.h
+++ b/arch/arm64/include/asm/vdso.h
@@ -10,6 +10,9 @@
 #ifndef __ASSEMBLER__
 
 #include <generated/vdso-offsets.h>
+#ifdef CONFIG_COMPAT_VDSO
+#include <generated/vdso32-offsets.h>
+#endif
 
 #define VDSO_SYMBOL(base, name)						   \
 ({									   \
diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32/Makefile
index bea3675fa668..4bd60f059f4a 100644
--- a/arch/arm64/kernel/vdso32/Makefile
+++ b/arch/arm64/kernel/vdso32/Makefile
@@ -135,6 +135,14 @@ $(c-obj-vdso-gettimeofday): %.o: %.c FORCE
 $(asm-obj-vdso): %.o: %.S FORCE
 	$(call if_changed_dep,vdsoas)
 
+# Generate VDSO offsets using helper script
+gen-vdsosym := $(src)/../vdso/gen_vdso_offsets.sh
+quiet_cmd_vdsosym = VDSOSYM $@
+      cmd_vdsosym = $(NM) $< | $(gen-vdsosym) | LC_ALL=C sort > $@
+
+include/generated/vdso32-offsets.h: $(obj)/vdso32.so.dbg FORCE
+	$(call if_changed,vdsosym)
+
 # Actual build commands
 quiet_cmd_vdsold_and_vdso_check = LD32    $@
       cmd_vdsold_and_vdso_check = $(cmd_vdsold); $(cmd_vdso_check)

-- 
2.55.0

