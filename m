Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB0439FD9
	for <linux-arch@vger.kernel.org>; Sun,  3 May 2026 00:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777766748; cv=none; b=HXFOykArWLZCv0Xw0CMJbQTqHa4TemNh4eCtt8wP++/i4QcpYdbdw6brgxPF+KQROTh+FWdQfCC85HHoen3tUTUDsyOOXodgQBwhbh87qmDH9D1TDmED5Aw+0Mp7NPjsMgplAtJzpzgUX4vGYj2wuwU16O9Zc5tBHAxEUWI13j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777766748; c=relaxed/simple;
	bh=XIgrbxGfBcI1a1vO4dXszCHdSe19TSDFODvG8fCABn8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gyz9GXGoQD+FWKvwZr0TL5xb75Pdy6Sdo8vHNIaHDOudlHV5vDyAsbSHkns0zEhJQApRdN6hvzkCaj14hzvOYaKqEVluaKaf16cezn3b2LLxbMnDYJa6E3whnwBipPvNy5X1A01gnyyQUS/wcE0mSWBlco/LV73ponLkhaj5lXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GivwvlBy; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GivwvlBy"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7de4ed0593fso1793635a34.1
        for <linux-arch@vger.kernel.org>; Sat, 02 May 2026 17:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777766746; x=1778371546; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZJy3pLduHUQEJsOIJ6mQFn4RDUX2xoMEEvvPtoEzxc4=;
        b=GivwvlByN1p9NqV3NI0jcoEEvGTmxj9t5IS46kZmrjS49q4xheA1FJ5NZHp94aIFD4
         W/2l5MUgHPp5NqNIkBt9W3XoHQ7/IB3HUIOJNpfJd0LTdmq1Z4uHYpfDuGwNMUtjIO6E
         9EbwLbvdkV533TrQOjxiAI33pqIUM3Q4YQonm0Q+WvwqAL1av7bfQyKAxIKfITFQJ3GG
         kX+jmmXZvoRzyM68Nnyb1zZBCqGCrOUyfPPsSUq3L8cbxkAMb/aJTmlbS/KksuFhDNpr
         +aviNW/EOU0Huxs2rj7AocXd+myqGdvHuxjNye4drvxnNU+JmQOtuOI4+O8Fyf+bEFIE
         N/Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777766746; x=1778371546;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZJy3pLduHUQEJsOIJ6mQFn4RDUX2xoMEEvvPtoEzxc4=;
        b=JfZacm53GebdiVasHj736XoErhmkD+O6mg4vcvk4YS0hH8UdJzejw4tfPA+rz3NLJc
         rU/OYxS+tPGdJa9yPtJPKaTWDCdu2sU59TFZ+HEXpJNfn/clApOz9zWrLr0Li7vi74WT
         1DPKiy09dLzQOFFwTCakT7u7xH7SzqmS31O1tyTcsZY4p0HEgZ3oVRepIczFjqG74wP/
         U4UMqIZFHXTVLgj1Bjqu8CeqIRdLRiPGQxcJFgEy5X2kVDrimuyqNIthwxh22AzrX3sh
         dXona/yUNatoVsMqs3E1i2XwuNkoARluBHaDTRz3YrE5aBjaxgWgOD27I+Lzb/yvsbAU
         Nu3g==
X-Gm-Message-State: AOJu0YxJkAUvNeAHu20AnqrtWxw31ftxvgjMlfgXRdN1Z1bCSwdbI8ON
	QPfqJu8N5BaFxP/iQM5soYYR00X3OmAfN47cfHQuG6DFwVbtWTCyKTJL
X-Gm-Gg: AeBDiesaUJa225UQrlGuimqJndy4lRdKoJK28vzNCSpDeImujZ4GPaUG5x8rib/6xHr
	KdDcnwvZ+15WIreIZzPp512NVaDGOxxKLuph/RUeyADroZFz1qhI0sKEmgG//Sxf1FxY6mSlFHC
	3x0G88JIxNC7d++srBn73TISlaaLm3O0W05AHy506zZlhGH8pnJpEg06ZIzPXO/GORrk958BctJ
	T5oGsRstRPQggB4nBcmj36Epc9PaA2TNmkA5sww9WPKYgoiUZqHfbNAS25JAs+crgOQyfZNdLKn
	VomHR9J+24RIc7Ud5PQ+ViEzhGtD2WsAAHiU3jxhwYMPSE20Qv4f2qbRJnrI3qMaf4hCM7u35BB
	L0/uVwfWtvK0vapFeXLwqd942/MRe3t+YhO+dIq0A3g/dkxOi0FiS2xQdoRwjFVE+KDfw73cQNZ
	JqkrvVLCxgkMqWZzTK0Q7NkhvoNWwZqxWOGnmBchkehOx4a7kdEjhs85BSHwOU/1gdxuHkGOvZ
X-Received: by 2002:a05:6830:2785:b0:7dc:d0e3:5bdd with SMTP id 46e09a7af769-7dee143b7f2mr2634196a34.19.1777766746228;
        Sat, 02 May 2026 17:05:46 -0700 (PDT)
Received: from [100.82.231.29] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-7decae2b090sm5379676a34.24.2026.05.02.17.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 17:05:45 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Sat, 02 May 2026 18:05:34 -0600
Subject: [PATCH 3/5] vmlinux.lds.h: Fix ALIGN(8) omission causing NULL ptr
 on i386
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260502-asm-generic-1-v1-3-1103ee0152df@gmail.com>
References: <20260502-asm-generic-1-v1-0-1103ee0152df@gmail.com>
In-Reply-To: <20260502-asm-generic-1-v1-0-1103ee0152df@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>, Jason Baron <jbaron@akamai.com>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
 Aaron Tomlin <atomlin@atomlin.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-modules@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777766741; l=4326;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=XIgrbxGfBcI1a1vO4dXszCHdSe19TSDFODvG8fCABn8=;
 b=go6hhL+GZg1MThN9GkA9ic1Z78uoIl9KSJI4Z5X2pyNkZNh0ik2MzyKvza1Afhw/pxKZTBqDx
 anyKKlk04nGDEyOuxGZCfj6ccvMp/3eL7VTpDsT8sKq0f/X4eVaeSLU
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

Almost all uses of the BOUNDED_SECTION macros are ALIGN(8), either
explicitly, or by being below an aligned section.  The noteworthy
exception is BOUNDED_SECTION(__dyndbg), which immediately follows
BOUNDED_SECTION(__dyndbg_classes).

On i386, struct _ddebug_classmap is 28 bytes, so without an explicit
ALIGN(8) in the macro, the following __dyndbg section gets misaligned,
causing a NULL ptr deref in dynamic_debug_init().

So fix this with an explicit ALIGN(8) in the existing macros, and
introduce _ALIGNED variants to handle the rare exceptions.

NOTES:

ORC_UNWIND_TABLE now uses _ALIGNED macros to match the explicit
. = ALIGN(x) instructions, but keeps the instructions so the symbols
between them are not "re-aligned"; scripts/sorttable.c does not
tolerate sloppy padding.

Also add . = ALIGN(4) and change BOUNDED_SECTION to _ALIGNED, to agree
with .orc_header, added here:

b9f174c811e3 ("x86/unwind/orc: Add ELF section with ORC version identifier")

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
index f78300aea8f6..d3f20b411e16 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -641,7 +641,7 @@
 #define EXCEPTION_TABLE(align)						\
 	. = ALIGN(align);						\
 	__ex_table : AT(ADDR(__ex_table) - LOAD_OFFSET) {		\
-		BOUNDED_SECTION_BY(__ex_table, ___ex_table)		\
+		BOUNDED_SECTION_BY_ALIGNED(__ex_table, ___ex_table, align) \
 	}
 
 /*
@@ -833,16 +833,17 @@
 
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

