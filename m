Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C870EED8
	for <linux-arch@vger.kernel.org>; Sun,  3 May 2026 00:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777766759; cv=none; b=bHcd4egsz//ofPNQuxZ3QY1xIX+ZydAFKKzPRwOR5ScqNw2WAPjvE45Ua/mNCDNX8WeI8SYIV0disFLIIPyMt3ADLuSgy7/Ec4Md6zrtJDA6LcUWShuTiKUjrc47GM7DyoJuLuRXPER4WpTJwf45OaZ1y3Wq/rv47wcX8ECV7UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777766759; c=relaxed/simple;
	bh=WCo4IngWd7T+cDO/VH26BhNsjTRcrHFIF+C77YDtGX0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JTgZgsUo58TNd+tmrfqlAv5aayxyB5G4JjwdaOXUnTIG+XXtHZnob+OE1p6p+QRajTTyPJZk/SkleGDMvU5Y9E6DWBDncUfyEwDfF4AJp2jqF7Pscg2HWXi6FYnJjxGfGX4Pr7FKzu671dhnRFyUhXn/WNRAAwa7v0LyswzByhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oilHwTjx; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oilHwTjx"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7de7dc85b74so2851603a34.2
        for <linux-arch@vger.kernel.org>; Sat, 02 May 2026 17:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777766749; x=1778371549; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hi2XkQAfIYbnsnMWknwKW3P0EwWvqlKqATEGqIBom3w=;
        b=oilHwTjxcwEv/t+DbLpUfAvRhrGOkLlkopVDpt8F+3jmufxgyHyGAqCKjf7afdqq7i
         5/fRDtaHuumV6Z9X/zrFXN8OppvVkxiYVw1Bbu2+EiVH8gwpmns/TfqNl6aXGtrA7Y3H
         Qdiwo47LBpuzGBbOZbbqBblIkG56Ncwckfl6jigkAPK3DzvvwVlXCE8Q5bImjYJx3AlM
         nBXxFA7JG8SEsPhZDj5UPJDoGPs4GeqaF/LMCUIo4Swl5HR2rf5wTy+8aIhT3S8fLgo4
         Fnr2hUXb4PLj3U7cAmNcVQAKJVOQqTmdB4bg4HdJAEXMnS/wppHx15Sy3B9nEl813/BD
         baEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777766749; x=1778371549;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hi2XkQAfIYbnsnMWknwKW3P0EwWvqlKqATEGqIBom3w=;
        b=UiQtshz9+LoCP1gbrgiFge9KGYV0QO+cPAQfnoD8aHTXYMIZ2h5skHvdZj7W/9qjhF
         vkBemWKVe3/Hz6ebJfp+pKrYXKkP+aXZLzLWO5wVyrj16jZfTQ7fKWr0xsV7Y9wvtqlg
         FEjBjME8AcY7C2K3Qq5iSMCH9ahropIUyyLf4MA0XWgByGEwiNSUjd5eTHfk/lKMhbWh
         e/Ml7W5XD7N1dw9TwAAqz4HTPHH6jYlXKS2oNMyvHISjzO/B3arCsKa8pt9nmqAY/6Mh
         QKrdqNBx3hJ7/R0Gbb7NSW+TJgcyfY3Hlk39VYgu49JSijubNeVILsEtclHYQGeQH4pZ
         9CDA==
X-Gm-Message-State: AOJu0YwMJGWFq3SX69kqQuf+lBquK5tTI1kVtOWUz+Gl4f0R/0TvNHSl
	Q7LcZbfkpzEuyq8n9H/otkWkudVTYaxmMovlBsU6X3D4hElLGkjynwdE
X-Gm-Gg: AeBDiev4/tMK0GCXE/TFQmdK6t3WNafoYeEWGRkGs1me3t1JsYNF/0M1NS2bPtuOcOu
	2xkJZ4cr/SC6Q3P2C6Q0uBGS/dXRU8AHtyxBL/857E94K+MdIroCdRgJdoklcC9c51N5sceKIb1
	BduF+9pfp8DBjmANC3hHyZHuOLYY/9VID7SbSEGnI2NbwR/tKBLcZKqGOQfYAZjdUY3cetEsbyC
	UuukFmrGwiaQFpUU+obZRA61d97hifNZaXcKPWEB0dFiTbRRn+giY8KBYrRnk8UBK7aSQvfoZn1
	h3GRvjsMHTvxrp0CyueL+C3C4/UET1z4F+qIrFuv+bGU8NS6m2P0ktM10wmm69Uvlq6HlEdYUlE
	1CDvBQqDOwnIdT28e27I/F9dyMfDNtPzukFK1t66/jR15rW6dNKu6hhVkDVJT00BfUHgIWxyy3s
	muS6T6puVDagiz6go1/dH+736cDvmtsXG0D3X84CVcM+fc2YbgnXsvrR3PfXwoDXyew4Pi45cF
X-Received: by 2002:a05:6830:6401:b0:7d7:f13a:761c with SMTP id 46e09a7af769-7dee14371b8mr2524196a34.23.1777766749001;
        Sat, 02 May 2026 17:05:49 -0700 (PDT)
Received: from [100.82.231.29] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-7decae2b090sm5379676a34.24.2026.05.02.17.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 17:05:48 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Sat, 02 May 2026 18:05:36 -0600
Subject: [PATCH 5/5] dyndbg.lds.S: fix lost dyndbg sections in modules
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260502-asm-generic-1-v1-5-1103ee0152df@gmail.com>
References: <20260502-asm-generic-1-v1-0-1103ee0152df@gmail.com>
In-Reply-To: <20260502-asm-generic-1-v1-0-1103ee0152df@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>, Jason Baron <jbaron@akamai.com>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
 Aaron Tomlin <atomlin@atomlin.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-modules@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777766741; l=3739;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=WCo4IngWd7T+cDO/VH26BhNsjTRcrHFIF+C77YDtGX0=;
 b=MsxKRcJINzBKfgiZDoIH1qONFugHmNLzQUcfOGghBMScsKxNkgzec9MtG5jAsiiLe9m+rcTUV
 5sfTrj25FmZCpkyMojb71FU6WQXFERQyTQ+FEdOpzVG0bJ2mUveh2qu
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

Several build configs had problems with __dyndbg* sections getting
lost in drm drivers.  Fix this by following the model demonstrated in
codetag.lds.h.

Introduce include/asm-generic/dyndbg.lds.h, to bundle dynamic-debug's
multiple sections together, into 2 macros:

vmlinux.lds.h DATA_DATA: move the 2 BOUNDED_SECTION_BY(__dyndbg*)
calls into dyndbg.lds.h DYNDBG_SECTIONS(). vmlinux.lds.h now includes
the new file and calls the new macro.

MOD_DYNDBG_SECTIONS declares the 2 BOUNDED_SECTION_BY calls, but wraps
them with output section syntax to keep them as known and separate ELF
sections in the module.ko.  The KEEP fixes the lost section.

dyndbg.lds.h includes (reuses) bounded-section.lds.h

scripts/module.lds.S: now calls MOD_DYNDBG_SECTIONS right before the
CODETAG macro (consistent with their placements in vmlinux.lds.h), and
also includes dyndbg.lds.h

This isolates vmlinux.lds.h from further __dyndbg section additions.

CC: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 MAINTAINERS                       |  1 +
 include/asm-generic/dyndbg.lds.h  | 19 +++++++++++++++++++
 include/asm-generic/vmlinux.lds.h |  6 ++----
 scripts/module.lds.S              |  2 ++
 4 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2fb1c75afd16..182e50b0fad9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9070,6 +9070,7 @@ DYNAMIC DEBUG
 M:	Jason Baron <jbaron@akamai.com>
 M:	Jim Cromie <jim.cromie@gmail.com>
 S:	Maintained
+F:	include/asm-generic/dyndbg.lds.h
 F:	include/linux/dynamic_debug.h
 F:	lib/dynamic_debug.c
 F:	lib/test_dynamic_debug.c
diff --git a/include/asm-generic/dyndbg.lds.h b/include/asm-generic/dyndbg.lds.h
new file mode 100644
index 000000000000..f95683aa16b6
--- /dev/null
+++ b/include/asm-generic/dyndbg.lds.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __ASM_GENERIC_DYNDBG_LDS_H
+#define __ASM_GENERIC_DYNDBG_LDS_H
+
+#include <asm-generic/bounded_sections.lds.h>
+#define DYNDBG_SECTIONS()					\
+	. = ALIGN(8);						\
+	BOUNDED_SECTION_BY(__dyndbg, ___dyndbg)			\
+	BOUNDED_SECTION_BY(__dyndbg_classes, ___dyndbg_classes)
+
+#define MOD_DYNDBG_SECTIONS()                                           \
+	__dyndbg : {							\
+		BOUNDED_SECTION_BY(__dyndbg, ___dyndbg)			\
+	}								\
+	__dyndbg_classes : {						\
+		BOUNDED_SECTION_BY(__dyndbg_classes, ___dyndbg_classes)	\
+	}
+
+#endif /* __ASM_GENERIC_DYNDBG_LDS_H */
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index d9d2eb708355..54897d742c6c 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -332,6 +332,7 @@
 /*
  * .data section
  */
+#include <asm-generic/dyndbg.lds.h>
 #define DATA_DATA							\
 	*(.xiptext)							\
 	*(DATA_MAIN)							\
@@ -345,10 +346,7 @@
 	*(.data..do_once)						\
 	STRUCT_ALIGN();							\
 	*(__tracepoints)						\
-	/* implement dynamic printk debug */				\
-	. = ALIGN(8);							\
-	BOUNDED_SECTION_BY(__dyndbg_classes, ___dyndbg_classes)		\
-	BOUNDED_SECTION_BY(__dyndbg, ___dyndbg)				\
+	DYNDBG_SECTIONS()						\
 	CODETAG_SECTIONS()						\
 	LIKELY_PROFILE()		       				\
 	BRANCH_PROFILE()						\
diff --git a/scripts/module.lds.S b/scripts/module.lds.S
index b62683061d79..2e62dc5bd5d4 100644
--- a/scripts/module.lds.S
+++ b/scripts/module.lds.S
@@ -10,6 +10,7 @@
 #endif
 
 #include <asm-generic/codetag.lds.h>
+#include <asm-generic/dyndbg.lds.h>
 
 SECTIONS {
 	/DISCARD/ : {
@@ -61,6 +62,7 @@ SECTIONS {
 		*(.rodata..L*)
 	}
 
+	MOD_DYNDBG_SECTIONS()
 	MOD_SEPARATE_CODETAG_SECTIONS()
 }
 

-- 
2.54.0

