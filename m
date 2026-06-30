Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5082F3DBD76
	for <linux-arch@vger.kernel.org>; Tue, 30 Jun 2026 18:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782844690; cv=none; b=GvpCNIRfviQmvqJJPGP5+g2AeBdB0eP6WIPF95ZnU4Me1c4oeEQ9kkeTKUl+4zb1D1yfypdKc+XRxIIxIXP9SwX2xHgt76dtFYZmaqXLlbfjjVdC1/9xzvtWFDo26atme/DCFzVhg1ZSDEDhB2boQMyjbUtrjbJO8VlQDVLxLRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782844690; c=relaxed/simple;
	bh=LvoWirZdCmBl+mgGu36/+NBSj8//WyLkfhZ/OzqZHgk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gm7nCgnxlojieUnYdFoycW/X3JwvPRO3z4iTI1teOMe7VHURE3+RI/EJ26k66Mf5E8iixOVpZgqOya/bGLQFtkTOWErFvslwLXNIqWtCz/H2bPbDsZKAQ7BCpu1IKFR0UDFk//tziPhJHzDpyQXyzMZLXNHvsXZeKQBgsymKYUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LEs6crLd; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LEs6crLd"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7e9483cd614so951868a34.1
        for <linux-arch@vger.kernel.org>; Tue, 30 Jun 2026 11:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782844684; x=1783449484; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aZK/LynIcwn7yRHjuRCG0kCR9Pq06Uz+ZGgAHlMq6hI=;
        b=LEs6crLdAeSsjo8dANypGEq/jBetWec+KmYAcRmNBvSc4cstU1IYcVmjqeQMskzn4C
         1HIEf5V/8jgdej1cHbGZQyjPCSnhN6GjviUOunMShyApvwP/nq+CrBk7yh7x+8Rfu0gq
         kzLHVM/b8F/Eex0xxdXtxMtzz9LpH/ESz2GnUsXnbpjE8eN1tlXMx1Il8DgdPGbvpmZD
         WYi2NpxOk1VE6Fp9+i1V3Vo0D9zAxt2V5S9hBnxAo+YZiFrU2jXcZC5cbGjXYzqKlqtz
         U1PYwndeyknYYiMKWRjI3uLa9fszbsV3uR0Fa2CfBSpC3s+oouRv42OrZt8u7sA1UxCk
         tLEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782844684; x=1783449484;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aZK/LynIcwn7yRHjuRCG0kCR9Pq06Uz+ZGgAHlMq6hI=;
        b=OLk9ZLo0lO2AbCRLSUR1pT1LO7Nk8SVnXB9jczt4a6eOK/IrVohH29OmdOk2Hq5IQn
         2goI7XXUXmqX0S3HPDm4/jrX6XXh04bCWbsOHOMYCdSesPrc6vJ3RHzvKr5Y+JgMWgtt
         U05ZyDDPI4FSqZ9YN4RRImrWuFGIWNwbrQvyOz491VIJQ9UufsxFQW2vXmsVvxhtVx2P
         9V3VvYqFiHqmKLhwawDE01Dse76JyoLDoOIBT9Iy5nmwIaPrTuhG51VnTg0oWrfFIzgn
         3TKteAty8Z1/a/nHICNUGYyFIslh+58J6qeP1tvRPUXhg9G4IeV+fTwSlMe3iqYrJDIp
         DW7g==
X-Forwarded-Encrypted: i=1; AFNElJ8DTArinOCdhezlBzWoykJcd/M4Yb9wHX43yplTu01sgx4iltMqAw3FK1KsKxur63CnHZOfhck73dQb@vger.kernel.org
X-Gm-Message-State: AOJu0YxNkQ6mvAPPFK5RlgVQggrLv+CKjCFYSCoP7sMdSP4g2KA303gP
	Kb9Z871nmd4weV65PJi0i+edgaxzH3+U/nFDGqS3slLsjqiI3zaF94Cf
X-Gm-Gg: AfdE7ckPyQwlczs79JxCF+sEX0bPsp8jUGkXW7qYAe4eqEEMXuJsnP1yJvF8/SWRUAF
	ANdsH4U3IeLHZsdPTj8+jW83hPNzOhDnG9biYe64KGK/IQJSATuqG/YZA5woaEv+OUmefXJkI69
	q52h+u1Qh42ZmgwQifWllOh727eIRkQ0y3HH5BXzuWtTO484ZvDRzsdnUknJm3fm+Dnpbp81WR7
	UCqtoJs3QUHwM67snUN2SZdd98qcYAicPB2YwPkcuzoNsbimQSOc6CPuLrPfUAP0AMCuLxZsaKi
	b1D8In/G1qWWF0gqxhaZl7xW8aYGnqVg38bUAilcq6llSow1Xh9dooSM7cSeBJS/7r5OevAk1W0
	ymD1sX9xyAND7uQuEbuA3KbqjO7XyhOSoxlvO7TzKlF9ziycTXxQc2sPZIeOCAyKOuUre61fxNl
	mAs5JuUurJsV2xuLu7+XgwV2w+G5dG+Nrjx9K7J8DtyPGtBmPiloI=
X-Received: by 2002:a9d:614e:0:b0:7e6:69f:d208 with SMTP id 46e09a7af769-7e9f5c404camr1598675a34.2.1782844684139;
        Tue, 30 Jun 2026 11:38:04 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-7e9ebfd6ccfsm2940025a34.11.2026.06.30.11.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 11:38:02 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 30 Jun 2026 12:37:52 -0600
Subject: [PATCH v4 3/5] vmlinux.lds.h: Fix ALIGN(8) omission causing NULL
 ptr on i386
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260630-fix-align-v4-3-42e6ec883342@gmail.com>
References: <20260630-fix-align-v4-0-42e6ec883342@gmail.com>
In-Reply-To: <20260630-fix-align-v4-0-42e6ec883342@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>, Jason Baron <jbaron@akamai.com>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
 Aaron Tomlin <atomlin@atomlin.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
 Jim Cromie <jim.cromie@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782844678; l=6221;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=LvoWirZdCmBl+mgGu36/+NBSj8//WyLkfhZ/OzqZHgk=;
 b=NfsG0gG9+RFvMjg/ISS+rorvIdG/Vb4NJLjpfY0EqzSjb1DePM8Vwa5PF8KEUR0f2CosBf9gx
 8a/luPJlRkEDRH8gQhjlL7MzU4EZ59/YAOLLmxdEjbQWDtXAwz99Usd
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

Also add explicit alignments for: EXCEPTION_TABLE, ORC_UNWIND_TABLE,
TRACEDATA, INIT_SETUP, and NOTES.

update BOUNDED_SECTION uses inside . = ALIGN(x) stanzas to use
_ALIGNED variants, but keep the outer ALIGNs so the symbols between
them are not "re-aligned".

In particular, scripts/sorttable.c does not tolerate sloppy padding.

At the top of ORC_UNWIND_TABLE, add . = ALIGN(4) to match the struct
orc_header __align() call in the code:

commit b9f174c811e3 ("x86/unwind/orc: Add ELF section with ORC version identifier")

Suggested-by: Louis Chauvet <louis.chauvet@bootlin.com>  # _ALIGNED variants.
Link: https://lore.kernel.org/lkml/177402491426.6181.12855763650074831089.b4-review@b4/
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
v3:

sashiko complained about NOTES and .BTF_ids.
gemini asserts that NOTES are natively 4-byte aligned, add comment repeating it.
.BTF_ids doesnt use BOUNDED_BY, since start/end isnt needed;
sashiko evidently got confused by immediately preceding usage.

v2:

sashiko picked up 2 cases, added to the explicit list above
https://sashiko.dev/#/patchset/20260515-asm-generic-1-v3-0-680b273666d4%40gmail.com
---
 include/asm-generic/bounded_sections.lds.h | 17 ++++++++++++++---
 include/asm-generic/vmlinux.lds.h          | 18 ++++++++++--------
 2 files changed, 24 insertions(+), 11 deletions(-)

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
index f5ddf31b7f26..f29fc079e37e 100644
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
@@ -650,7 +650,7 @@
 #define BTF								\
 	. = ALIGN(PAGE_SIZE);						\
 	.BTF : AT(ADDR(.BTF) - LOAD_OFFSET) {				\
-		BOUNDED_SECTION_BY(.BTF, _BTF)				\
+		BOUNDED_SECTION_BY_ALIGNED(.BTF, _BTF, PAGE_SIZE)	\
 	}								\
 	. = ALIGN(PAGE_SIZE);						\
 	.BTF_ids : AT(ADDR(.BTF_ids) - LOAD_OFFSET) {			\
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
@@ -869,7 +870,7 @@
 #define TRACEDATA							\
 	. = ALIGN(4);							\
 	.tracedata : AT(ADDR(.tracedata) - LOAD_OFFSET) {		\
-		BOUNDED_SECTION_POST_LABEL(.tracedata, __tracedata, _start, _end) \
+		BOUNDED_SECTION_POST_LABEL_ALIGNED(.tracedata, __tracedata, _start, _end, 4) \
 	}
 #else
 #define TRACEDATA
@@ -898,13 +899,14 @@
 		*(.note.gnu.property)					\
 	}								\
 	.notes : AT(ADDR(.notes) - LOAD_OFFSET) {			\
-		BOUNDED_SECTION_BY(.note.*, _notes)			\
+		/* *(.note.*) are natively 4-byte aligned */		\
+		BOUNDED_SECTION_BY_ALIGNED(.note.*, _notes, 4)		\
 	} NOTES_HEADERS							\
 	NOTES_HEADERS_RESTORE
 
 #define INIT_SETUP(initsetup_align)					\
 		. = ALIGN(initsetup_align);				\
-		BOUNDED_SECTION_POST_LABEL(.init.setup, __setup, _start, _end)
+		BOUNDED_SECTION_POST_LABEL_ALIGNED(.init.setup, __setup, _start, _end, initsetup_align)
 
 #define INIT_CALLS_LEVEL(level)						\
 		__initcall##level##_start = .;				\

-- 
2.54.0

