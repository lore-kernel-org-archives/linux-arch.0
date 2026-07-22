Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C872471429;
	Wed, 22 Jul 2026 07:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784706845; cv=none; b=RWhn42DEfq+AhKFEdcczaE2kmt8ccf569j7YRkfyG5SsUeZpfPcH4taYPqJLZgssFaWdLp8VHy/pUrMg3QLVi+kPKRKzlr3+X4TTtF1c7FY3gn38Such3YxjsazSQe2Dscm2jZxpHUtCayV8m41dJ9SFMnhWiWGw2xfQ6xvyRik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784706845; c=relaxed/simple;
	bh=KQ1WIDNBrUDk8ykSofgmkt90oehDLy0q9zMVnaVz/hY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LJBHGhXLF6a1ASeK0dAIgyc7aD8H7mwrZ2aPmikn9EbXVV2OczCcARRDaPDYMMQtexZPzBwBehnnxVw0fad/BQU6Qwz6cMQbkzOZFjjyRPG6dxI91r9RvBrowJ8MfuE4K8psonQERIDBzIS38kLwWizFVOpWyaFRsiW3lU2glAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=g2nG1VUD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UJwBHtI0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="g2nG1VUD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UJwBHtI0"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784706842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mzzp3V1NULRIcEaysPzAb8Zz8VZI2+Qui09INH6ftAA=;
	b=g2nG1VUDQ/YUv3S36y8SYF59i0yIpbzHC7ftklC+i7zZBT4eRMNNaj6XZXXAW9jEQWQ3HP
	2cdvg7rvUZGSwtcbf8ALdRLh+E5e6hd1Jry04eR5AA3iX/E4vkVLlSDor8V/iD9Z5kDbZe
	VUEmayb5vsI7QWoACDw+VKXr8TiiDlFgWzvqLUcRzd1aupaguAl5r96GvX/KxOsWuMv214
	0bqbxO005d/74RRGnSnD1wdVDcEjNTDM/Vx5Qq3RuguVESO2AM2AWINyCx3jI43KO88mov
	8qDH5y32PKEnne3kVDAqhTdPAd1BPKK0en6fBJLdox9EZZb6kHi2gdUp2YziRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784706842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mzzp3V1NULRIcEaysPzAb8Zz8VZI2+Qui09INH6ftAA=;
	b=UJwBHtI04+Zi6XonNItsTUX9pubhbs9SxZEPH19ZCNQxtzi5xqViipAMmyTlXS3NDzoMwK
	+C3Ikmn1UjQUBsCA==
Date: Wed, 22 Jul 2026 09:53:27 +0200
Subject: [PATCH v3 1/7] kbuild: support generated asm-headers in
 subdirectories
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260722-vdso-arch-clockmodes-v3-1-4c5753191cc4@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784706840; l=1604;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=KQ1WIDNBrUDk8ykSofgmkt90oehDLy0q9zMVnaVz/hY=;
 b=1x/MuKisB5TM072YN94rjvbdb2TJ42U6YURtDiybLXfdQydzkV2y2qPt60l1nojy0LO144bsz
 6pB5H5mktKLBKl9da755reHZVf17Fe9Y00BKndIGJY+Un+rxUelY4Sn
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Extend the asm-header stub generation to also handle subdirectories.
An upcoming vdso/ header refactoring requires this.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 scripts/Makefile.asm-headers | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/scripts/Makefile.asm-headers b/scripts/Makefile.asm-headers
index 8a4856e74180..772b53ffdeb4 100644
--- a/scripts/Makefile.asm-headers
+++ b/scripts/Makefile.asm-headers
@@ -48,14 +48,13 @@ syscall-y   := $(addprefix $(obj)/, $(syscall-y))
 generated-y := $(addprefix $(obj)/, $(generated-y))
 
 # Remove stale wrappers when the corresponding files are removed from generic-y
-old-headers := $(wildcard $(obj)/*.h)
+old-headers := $(shell test -d $(obj) && find $(obj) -name *.h)
 unwanted    := $(filter-out $(generic-y) $(generated-y) $(syscall-y),$(old-headers))
 
-quiet_cmd_wrap = WRAP    $@
-      cmd_wrap = echo "\#include <asm-generic/$*.h>" > $@
+filechk_wrap = echo "\#include <asm-generic/$*.h>"
 
 quiet_cmd_remove = REMOVE  $(unwanted)
-      cmd_remove = rm -f $(unwanted)
+      cmd_remove = rm -f $(unwanted); find $(obj) -type -d -empty -delete
 
 quiet_cmd_syshdr = SYSHDR  $@
       cmd_syshdr = $(CONFIG_SHELL) $(syshdr) \
@@ -74,8 +73,8 @@ all: $(generic-y) $(syscall-y)
 	$(if $(unwanted),$(call cmd,remove))
 	@:
 
-$(obj)/%.h: $(srctree)/$(generic)/%.h
-	$(call cmd,wrap)
+$(obj)/%.h: $(srctree)/$(generic)/%.h FORCE
+	$(call filechk,wrap)
 
 $(obj)/unistd_%.h: $(syscalltbl) $(syshdr) FORCE
 	$(call if_changed,syshdr)

-- 
2.55.0

