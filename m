Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531A542883B
	for <linux-arch@vger.kernel.org>; Fri, 15 May 2026 08:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778835512; cv=none; b=SuSn94ZcHQR4kG/pd1r5tLEiteNlI8VVAYEU5PvXvnHLQDojLSFY45QhFsC8EfScQ9Gqj2vCLXY/FHTlBO3XwOAtPXyalb3978ZeJ1gBAp/JaZtuVa80GYbkm6JEkao/Wn7GmVz2IobmYg48jzoIMNAS+CfrWM3iCiztDcqJWQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778835512; c=relaxed/simple;
	bh=5GFT8c6pS8ZPOp8E9e2DvTwZwRrYlvW21YT8WQ/gfj0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UoiJEqwJjng++6EChhqAaqCiuZ9Ih3t1dA5lpdi66H7JUwL+kULR/rnG5RWZ+htngu6xFQcMM49xRak4x79KQF1dmO5QY0MDtLL7jjY1HSJGZAE5sawp77Z/JmmPfK/uCW/RmHXiZ4RQYlzuwyeutr50OkGZOgB/13tDH4GeFcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JX4McymA; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JX4McymA"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-44a14580111so6430532f8f.0
        for <linux-arch@vger.kernel.org>; Fri, 15 May 2026 01:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778835509; x=1779440309; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vyDbCKNB7s28klaeaxcFwFyz+m8AFVwNSzp9KnR1vME=;
        b=JX4McymAgn46VrLR682iCMPePkKsDXIhHXKP8qBlR01LYyRTGREKSoyFhkt8BlF5UR
         SZA1Mqe3YD++M3XT8/GSbG/Ca0Fy0AHnmRKTDPNOX8oF1F0F4mq1WYe7TEBEd0ZFVxCG
         lMcb9vVMGX7e1vW4EhM69svEhl/wAD2PkMuO6+N8pXOOix5o4TJ0GqP4Afs0oTRtQEqS
         ZfmhLIE4M0Nz3CrxgGNRe9hynrfN1YIOQM1Uki2CHF6mtBRdYmZIrV0gPkmirOF4FLFJ
         cbmVF7nxresGc+7YVjeeAcDmgsH++dGg6AOlmSXQAY5e11f2NFH6YP1LICCrz6rA3wAZ
         AyLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778835509; x=1779440309;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vyDbCKNB7s28klaeaxcFwFyz+m8AFVwNSzp9KnR1vME=;
        b=kQ+hJZgD/oV4y6fbSRd5XLgdqF8VK/tiZFov267mKxVO20pK1wU2C8r0rHOOha5I2R
         CpQu5gVyfCJMD8S95z/ddm21+XfplZPcYJqhn+18ZHniAi1XOck9cB6DBBKG3/M5+3Hw
         LqAroDQNKuo1SnvyzGdxTY77DSWW6ZjvWmX18zlnG+bWpOSck8pOtkMXk3IRNG488qXW
         /PJXxkjaMtgc8K3I7DlYIOBboN829otYr7oqzA3n0+hOMXDerpigdxCw9J2zVTP5e5OJ
         xP5rTVyRD6t0iPnwaATiUQMaT3MBjQ7Fa+qgE0o7Y6miBt1DCHXmoa+usoxy/1Z6EEmD
         F0zA==
X-Gm-Message-State: AOJu0YzzAXMibecj5UPGXHNxLreD0eo9a8w54FkjEsFVT6Mj1Ssx+hYp
	EDjFpA/2TP5kEiHbCplGdEOSMIuPiZ5YrapWOioqP6WdZTSkAdIp9Idg
X-Gm-Gg: Acq92OFId8TjXpeZ2VwhgDMv3UkXNtenYw3Qnptwk/4iu8oAZDwlT/eg+6MVI2yZ/Ua
	AWI/arz2C48ffj+OiwKkrXJ/53EAujHOCV70WuQG0/KQHsvQEUx8YtOTkwOQ7WizXjL4/JA2W/Q
	J2CS00x+5tzFrfR0NoY+FQV/YBdwHLXeBDBG/pEL+25lpIw7CoMfbUxuA7ywrOcGhwc1cxQ2UA2
	I9p4lmd8pWBwMKxFzXV48Qqgk6pUINkrLGjQq5E/Hj+YqQHDyqxyLn4DYj0Ld0N12OJ8X1rBUU8
	h2FMeNxSknK+WpUxwZjCuXo5MSEk0+VybckEnK8bi+ITIvC9t9IG/b3oG5W+M9ZJG+FF6Xf4nUi
	vShpl7ivM4c54qZNy1/yT/chPUo49ZhoO6NylX4LqOquCCKJmE+d0SZtlf48/cb0Ca9KXtwDjEt
	do+Pk6niakJEtCntG1rS6eoyv/4FXfhX6d/kAeWrtO76M=
X-Received: by 2002:a05:6000:1acc:b0:43f:e721:76b8 with SMTP id ffacd0b85a97d-45e5c60a375mr3885216f8f.37.1778835508407;
        Fri, 15 May 2026 01:58:28 -0700 (PDT)
Received: from [192.168.1.210] ([2a00:23c8:33b9:3b01:f7b1:b7a0:6254:c325])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-45d9e768c4fsm13142610f8f.8.2026.05.15.01.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 01:58:27 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Fri, 15 May 2026 02:58:12 -0600
Subject: [PATCH v3 3/5] vmlinux.lds.h: Fix ALIGN(8) omission causing NULL
 ptr on i386
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-asm-generic-1-v3-3-680b273666d4@gmail.com>
References: <20260515-asm-generic-1-v3-0-680b273666d4@gmail.com>
In-Reply-To: <20260515-asm-generic-1-v3-0-680b273666d4@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>, Jason Baron <jbaron@akamai.com>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
 Aaron Tomlin <atomlin@atomlin.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-modules@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778835503; l=4451;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=5GFT8c6pS8ZPOp8E9e2DvTwZwRrYlvW21YT8WQ/gfj0=;
 b=5d2E+jRpUIih+m4j+0pG1oniOu01tH5wE30jvuG/P0BgKGNvfuzlCkDhurcRsCPf8NxMTHEkf
 xRbMptwL/L/CF5XKctmw6hO7cxCWz0Uid/aVRzu0knLxqy1DCIjhhft
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

Almost all uses of the BOUNDED_SECTION macros are ALIGN(8), either
explicitly, or by being below an aligned section containing x*8 byte
objects.  The noteworthy exception is BOUNDED_SECTION(__dyndbg), which
immediately follows BOUNDED_SECTION(__dyndbg_classes).

On i386, struct _ddebug_classmap is 28 bytes, so without an explicit
ALIGN(8) in the macro, the following __dyndbg section gets misaligned,
causing a NULL ptr deref in dynamic_debug_init().

So fix this with an explicit ALIGN(8) in the existing BOUNDED_SECTION
macros, and introduce _ALIGNED variants to handle the cases with an
explicit . = ALIGN(x)

Explicit alignments: EXCEPTION_TABLE, ORC_UNWIND_TABLE

update BOUNDED_SECTION uses inside . = ALIGN(x) to use _ALIGNED
variants, but keep the outer ALIGNs so the symbols between them are
not "re-aligned".

In particular, scripts/sorttable.c does not tolerate sloppy padding.

At the top of ORC_UNWIND_TABLE, add . = ALIGN(4) to match the struct
orc_header __align() call in the code:

commit b9f174c811e3 ("x86/unwind/orc: Add ELF section with ORC version identifier")

Suggested-by: Louis Chauvet <louis.chauvet@bootlin.com>  # _ALIGNED variants.
Link: https://lore.kernel.org/lkml/177402491426.6181.12855763650074831089.b4-review@b4/
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/asm-generic/bounded_sections.lds.h | 17 ++++++++++++++---
 include/asm-generic/vmlinux.lds.h          |  9 +++++----
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/include/asm-generic/bounded_sections.lds.h b/include/asm-generic/bounded_sections.lds.h
index 268cdc34389b..8ff3e3420f60 100644
--- a/include/asm-generic/bounded_sections.lds.h
+++ b/include/asm-generic/bounded_sections.lds.h
@@ -3,19 +3,30 @@
 #ifndef _ASM_GENERIC_BOUNDED_SECTIONS_H
 #define _ASM_GENERIC_BOUNDED_SECTIONS_H
 
-#define BOUNDED_SECTION_PRE_LABEL(_sec_, _label_, _BEGIN_, _END_)	\
+#define BOUNDED_SECTION_PRE_LABEL_ALIGNED(_sec_, _label_, _BEGIN_, _END_, _ALIGNED_) \
+	. = ALIGN(_ALIGNED_);						\
 	_BEGIN_##_label_ = .;						\
 	KEEP(*(_sec_))							\
 	_END_##_label_ = .;
 
-#define BOUNDED_SECTION_POST_LABEL(_sec_, _label_, _BEGIN_, _END_)	\
+#define BOUNDED_SECTION_PRE_LABEL(_sec_, _label_, _BEGIN_, _END_)	\
+	BOUNDED_SECTION_PRE_LABEL_ALIGNED(_sec_, _label_, _BEGIN_, _END_, 8)
+
+#define BOUNDED_SECTION_POST_LABEL_ALIGNED(_sec_, _label_, _BEGIN_, _END_, _ALIGNED_) \
+	. = ALIGN(_ALIGNED_);						\
 	_label_##_BEGIN_ = .;						\
 	KEEP(*(_sec_))							\
 	_label_##_END_ = .;
 
+#define BOUNDED_SECTION_POST_LABEL(_sec_, _label_, _BEGIN_, _END_)	\
+	BOUNDED_SECTION_POST_LABEL_ALIGNED(_sec_, _label_, _BEGIN_, _END_, 8)
+
 #define BOUNDED_SECTION_BY(_sec_, _label_)				\
 	BOUNDED_SECTION_PRE_LABEL(_sec_, _label_, __start, __stop)
 
-#define BOUNDED_SECTION(_sec)	 BOUNDED_SECTION_BY(_sec, _sec)
+#define BOUNDED_SECTION_BY_ALIGNED(_sec_, _label_, _ALIGNED_)		\
+	BOUNDED_SECTION_PRE_LABEL_ALIGNED(_sec_, _label_, __start, __stop, _ALIGNED_)
+
+#define BOUNDED_SECTION(_sec)   BOUNDED_SECTION_BY(_sec, _sec)
 
 #endif /* _ASM_GENERIC_BOUNDED_SECTIONS_H */
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 9c61dd083f26..6892cbec0554 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -640,7 +640,7 @@
 #define EXCEPTION_TABLE(align)						\
 	. = ALIGN(align);						\
 	__ex_table : AT(ADDR(__ex_table) - LOAD_OFFSET) {		\
-		BOUNDED_SECTION_BY(__ex_table, ___ex_table)		\
+		BOUNDED_SECTION_BY_ALIGNED(__ex_table, ___ex_table, align) \
 	}
 
 /*
@@ -832,16 +832,17 @@
 
 #ifdef CONFIG_UNWINDER_ORC
 #define ORC_UNWIND_TABLE						\
+	. = ALIGN(4);							\
 	.orc_header : AT(ADDR(.orc_header) - LOAD_OFFSET) {		\
-		BOUNDED_SECTION_BY(.orc_header, _orc_header)		\
+		BOUNDED_SECTION_BY_ALIGNED(.orc_header, _orc_header, 4)	\
 	}								\
 	. = ALIGN(4);							\
 	.orc_unwind_ip : AT(ADDR(.orc_unwind_ip) - LOAD_OFFSET) {	\
-		BOUNDED_SECTION_BY(.orc_unwind_ip, _orc_unwind_ip)	\
+		BOUNDED_SECTION_BY_ALIGNED(.orc_unwind_ip, _orc_unwind_ip, 4)\
 	}								\
 	. = ALIGN(2);							\
 	.orc_unwind : AT(ADDR(.orc_unwind) - LOAD_OFFSET) {		\
-		BOUNDED_SECTION_BY(.orc_unwind, _orc_unwind)		\
+		BOUNDED_SECTION_BY_ALIGNED(.orc_unwind, _orc_unwind, 2)	\
 	}								\
 	text_size = _etext - _stext;					\
 	. = ALIGN(4);							\

-- 
2.54.0

