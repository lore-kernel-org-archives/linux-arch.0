Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BFC3EA95A;
	Fri, 29 May 2026 16:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780072485; cv=none; b=muCiy2gajVsclFa0LW1AFtqwoQSI9FqzVchunm3oJ6lNOhzF/VC7rzCQHZEZ7OYTJ3PFjXrfGV7BRyvSeTQVQY4LX42gNX6Cg7EpeB5grQKRLB1k5GvovDD2QVPidC4KZ9Ddux8zTOtefoRBbh9iGUgXHkcVd07jHbZoH94AxNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780072485; c=relaxed/simple;
	bh=Xx/B3blN0ezhnlwePDTERGZkH7WkdmD/5kul/QrLH24=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MHr0yTvv4RAxVCkJ8vG0neZ/jsrw/eoZeFeKK7WwemKhzGCsfEXRrbmF/3iL2cgRjEwsB3jOU4ogJOFj+6bGfxctfFzJmfTOg1V+TgcU316INkYNBDsh+aTm4j4WjCzs8JFN6WKD/sp/uakjXkHHnwbWgIZox2FQ3G4xQQTgOh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=K00Gh6qG; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="K00Gh6qG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=JLkyHFYC4EoXRqoOpftxW/9hntSQYUBfchvNpjZqZcg=; b=K00Gh6qGDQONRsTBVdIDcKzTPU
	cq0GiSB+joLO3s7iTn7Hqr42H5nYIbp0qV+hqkdhUc6rut4ZREzsPlmuiyBd2MQF/yN+9118IMAm1
	ovV4eyAXyEZHpsFXUsku/hXDFbapTbSvlpRBvBZOPEPhDHs6cXwlquNWlu4SI3Mxg3HJ2TRWPDTIw
	ffspB0yBF05fIukTEe5NNY4wPCDgJrq2jVwf9CZ8jXBhsbkd0XeOyxyy/ZdLvdg4VWshvy3b9b2ZD
	fEZZlekjYTnu4HSR93+NFTpCmgSWp6sKX3QGpOjvuTeZnq6WRfZkqcJaRXx/dsL/dZDn/bhwZj5CV
	4qHdjRQQ==;
Received: from [179.118.191.12] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wT0AQ-009wov-Tk; Fri, 29 May 2026 18:34:39 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Fri, 29 May 2026 13:33:56 -0300
Subject: [PATCH v3 4/5] arm64: vdso32: Bring vdso32-offsets.h back
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260529-tonyk-robust_arm-v3-4-a6f02684d4fe@igalia.com>
References: <20260529-tonyk-robust_arm-v3-0-a6f02684d4fe@igalia.com>
In-Reply-To: <20260529-tonyk-robust_arm-v3-0-a6f02684d4fe@igalia.com>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Carlos O'Donell <carlos@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Florian Weimer <fweimer@redhat.com>, Rich Felker <dalias@aerifal.cx>, 
 Torvald Riegel <triegel@redhat.com>, Darren Hart <dvhart@infradead.org>, 
 Ingo Molnar <mingo@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, 
 Arnd Bergmann <arnd@arndb.de>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
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
index 73a10f65ce8b..6164d905d402 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -208,7 +208,7 @@ vdso_prepare: prepare0
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
index 9d0efed91414..2775843e53cd 100644
--- a/arch/arm64/kernel/vdso32/Makefile
+++ b/arch/arm64/kernel/vdso32/Makefile
@@ -136,6 +136,14 @@ $(c-obj-vdso-gettimeofday): %.o: %.c FORCE
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
2.54.0

