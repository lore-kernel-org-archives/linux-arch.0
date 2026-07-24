Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9984D30C617;
	Fri, 24 Jul 2026 13:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784900290; cv=none; b=NSrdFysmLkQBo9gudcSDcw32JdGcfrBooAptGzi3oUVnBMClijz12uawrKFNGMIU3sWMyIezULyH0RkhZT+z9zGwUw+G3qMOPrfypx8woIqWVr4ILcAlEV4H6pJQnjRg1W1rfpMesaTd8+CzYY+vq3s0B/GjyOGvpPl4lmRn/GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784900290; c=relaxed/simple;
	bh=Zev+SfOmyEH9fuyzl0FmsV9VVq9RYb3UzolE/5lna3k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o6rXqEhNZrnfzOr1mB0d9GENbdxlir0AYXOxb6FcMYP4jtPx2cOOj5QUfje23bnupx2bkhrD41yuLC3cmez5rXsTmpGJATjIZOkWuOiumS5IBFTmhrOASZSvY1QfkkAnJAQzMviTZaLPibn2AORodXLnEtoh2Hgyte+ALO9ROmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BrLLO1tj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F1iGaQnC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BrLLO1tj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F1iGaQnC"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784900288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k84lHI02AeLCB93IudPhY7UADh7YGZV8FCgpA+ZF7P0=;
	b=BrLLO1tjYhSGwyDAWasIuyNQDXJsuyGklSui5fMZONsKkP1m5sXLh5TEhyFkEwKd5+m3y2
	fzQAc+LlO7nGtNN0ss6VDCzqr3zg0hJjr2Pb7w/keysNILWib9LWJ+eidE8UnlW9VpDnX1
	Qlo7ri+aLG1aKgl6IngIkvzrqz5IFXwm2KRokPKWktQh8+PtJvPs9uzn9+YtK/0Ft/hZpU
	WfOxgGgAxQ1IT4euvdi9YJl9dB4bTtaD/+Z0FkT8cWxd5I2pKlHu1+YsXYRViVO0av0TZI
	P7XUKIxnKoTfjDHLRTJqeanyw4JJw9dunvC8WU2/02aGdPKYQwDeBBCuaV/3nw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784900288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k84lHI02AeLCB93IudPhY7UADh7YGZV8FCgpA+ZF7P0=;
	b=F1iGaQnCRfR4UqHuVk9ZmdTRJMF80i+Fz/zJGdx/+NAq/m/Y/2SFARDiSyIpBG4x5Ncxup
	Uxil6gsiEIbWfyDA==
Date: Fri, 24 Jul 2026 15:36:18 +0200
Subject: [PATCH v4 1/7] kbuild: support generated asm-headers in
 subdirectories
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260724-vdso-arch-clockmodes-v4-1-ddbe447be860@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784900286; l=1603;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=Zev+SfOmyEH9fuyzl0FmsV9VVq9RYb3UzolE/5lna3k=;
 b=7LSqC528B3expK5DAr0ccLIPXQLZl0CZ+lRD0g98zRXGLp+iYu3EIKcskmML7CJrbWN3Eagwj
 y/hRMY88MKYAQn0vWRro12snAVO4gtR1Q/2LpUB8ZTb256tJSvFdE/x
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Extend the asm-header stub generation to also handle subdirectories.
An upcoming vdso/ header refactoring requires this.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 scripts/Makefile.asm-headers | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/scripts/Makefile.asm-headers b/scripts/Makefile.asm-headers
index 8a4856e74180..b38931314ad7 100644
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
+      cmd_remove = rm -f $(unwanted); find $(obj) -type d -empty -delete
 
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

