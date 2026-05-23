Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEE5342C8B
	for <linux-arch@vger.kernel.org>; Sat, 23 May 2026 07:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779520503; cv=none; b=GjkY5UVQ+5PbcylLp3twf9fpYwID5/RLFAGKPdxeYdtAlAPgAN8up0BI8s4tGzAkwqkVbX3pDb9Ew+o1R4WcWr3WuuXQfHi26dtx783amlHyTYmcjgx0cyF0/gACLWQa0ysg9xYTazXUrWSejGaH9kMBjEIlMfSHWOwUN9aM6vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779520503; c=relaxed/simple;
	bh=+PxUnhBt80sstYpQetbEqjhIty9CFiNlWXfpNo966yQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HvWdhL+u2EyJoEhVJCPrjuyxi2f9CfJay4XNO+mxu5JqaJAQQtTunMZzD62dr+H1GoRLnlK5Pj+VMjNVwmZoiCnRPydN9kHyWijX3qhVI/gD69oW6pwpLps0P3pqudj0pzuYidHXHWAqvndUCsdrAkNkMFqjCRilC7stpUhA+/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZSFyqAEF; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZSFyqAEF"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-44a5174670eso4707926f8f.1
        for <linux-arch@vger.kernel.org>; Sat, 23 May 2026 00:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779520499; x=1780125299; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mwLoso54ujA9DNLWzx95js6fjvDLg/xvtPDuNrBoMCc=;
        b=ZSFyqAEFCVUzDLOIdbU9IS0XcB69KphXFvtZrbq8UpiB6SJcwbTM7Pb/yWXWUR38b4
         XX/b22JCJouz26gz4LbfemjtWwQg95Xmoi0fcppwO6fpDF4fBvjkh4asUQxwm6ZycIxm
         ruyF3znHEmaiVQ8SnCtSr0CvZFn3VZGDFCgnw4aKYhgmm/biqb2xXRfUqTsRUk/W+EGt
         Fax5gc6Hlsba+QMEj9tV1zo3xQBu8oKl/W6Ec7AmuivqKHXly69el/cqgr+XpMRd4BP8
         RNNOpqeM0lv2btbYe2olZ8bzxS6gw/qlN2b0/v0Fpjh6+22Vp6050LXDEekI+WW2bbqP
         JuJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779520499; x=1780125299;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mwLoso54ujA9DNLWzx95js6fjvDLg/xvtPDuNrBoMCc=;
        b=f/vDXhgHp+WINO2kI9v08Nb8eRdlpNja+/3GOWnc8i+JB8UPOwxpSf071gcLH6SlWA
         tuolIz1oY9soyNY45IlopJw5SyGkx7KLDWucdOmzvKBnHmk9ocGXxd9oLPd5qUbUI/YA
         i24CP9LIpd26Ofrna76r9Ye0VJ0O0UEAurU/YrJs+nITfbiB3WLCQF6BSB0yqsmPLnnI
         t/ejIt4ZwhoGn+1DkUj4aHneCuViqXs19anp0ZcioQHjuuWTRNjveij4Q87wRdO9OOew
         U2QC65quMpDC+HYLd2cnUbBTPnz60kDb/yToZUdb9tcaXcB94KBNEYc1zgj/4m1ajDkX
         sA7w==
X-Forwarded-Encrypted: i=1; AFNElJ+v8bqoc94l6O6YGgngHpoY4H4kyhuc19w4q+Q2CDYuNFY10Chq3/LF8EKraspm5vS0jtkFG0FLh34n@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2OnpbrwsNm558oOKnfQ0/SI+ztjiZGgyoRmKsssmuYTtZ5A8C
	fFUqrOV79+DhWOWL8L5RPLMKTzYYKJyMmIXaj2j1uh9RvQa3tB3igZMk
X-Gm-Gg: Acq92OGPNySJWftdTKMqHNZnQ3O/a2E2GAqjChHgnBAoCahwsABur8gpM1ZIsd82D5N
	CHvIVzCIwYMhXtpJi4adMUZuEXmgSLAbaQzx8Jd0uSqyxJddNuZQaqAlIhPtBGFwKZiOnPYA0eL
	mq57rXCDll5CWLpXmXJooVUTKKzxA8U27WA3qOujnZ+7iQisT8TvaezV4IhJKhf97ggeMdLTtTW
	gSU0KoPiV4dcGoXEAb4+23DaMzWphR1ASLJv8YqKamB4wzfISmcpSExqnT30Q9g849+c8QmPDff
	FiVCPz6H+2xWTP3oLv8Vpy8jWkjjs/rePHJIAfx0P8i15WpFs8Qo1D/Z1rHUAoS6uyyi9Ue4AlO
	H0Pm5m8Y7mhnQ6QKKo8DU5dit23EDM6O9KIH0J53EXVlfvZBQlSy6EMRo59uPjv3S9J77pI+8mR
	Ec3+eb9lsq+i69B79zbTS47DQkuU+4
X-Received: by 2002:a05:6000:41c9:b0:45d:4a00:b927 with SMTP id ffacd0b85a97d-45eb38a1840mr10734403f8f.31.1779520498673;
        Sat, 23 May 2026 00:14:58 -0700 (PDT)
Received: from [192.168.0.174] ([31.96.183.250])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-45eb6d5cb76sm8639838f8f.25.2026.05.23.00.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 00:14:58 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Sat, 23 May 2026 01:14:38 -0600
Subject: [PATCH v2 05/24] vmlinux.lds.h: Fix ALIGN(8) omission causing NULL
 ptr on i386
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260523-dd-maint-2-v2-5-b937312aa083@gmail.com>
References: <20260523-dd-maint-2-v2-0-b937312aa083@gmail.com>
In-Reply-To: <20260523-dd-maint-2-v2-0-b937312aa083@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
 Jason Baron <jbaron@akamai.com>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779520485; l=5646;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=+PxUnhBt80sstYpQetbEqjhIty9CFiNlWXfpNo966yQ=;
 b=LC+g3SA21No6OnlSoBIeD8nbOvdfbK53Yfv1CyUMhk171BK4tL0+Ei5yTuw4ygNutkSE3nxf1
 hnW3IqZv/xOA4i5ezOYhthXck6luafM78K/AYe49plfHWFl63MzFvLo
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
TRACEDATA, and INIT_SETUP.

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
v3: sashiko picked up 2 cases, added to the explicit list above
https://sashiko.dev/#/patchset/20260515-asm-generic-1-v3-0-680b273666d4%40gmail.com
---
 include/asm-generic/bounded_sections.lds.h | 17 ++++++++++++++---
 include/asm-generic/vmlinux.lds.h          | 15 ++++++++-------
 2 files changed, 22 insertions(+), 10 deletions(-)

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
index 9c61dd083f26..477333bdf3d3 100644
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
@@ -904,7 +905,7 @@
 
 #define INIT_SETUP(initsetup_align)					\
 		. = ALIGN(initsetup_align);				\
-		BOUNDED_SECTION_POST_LABEL(.init.setup, __setup, _start, _end)
+		BOUNDED_SECTION_POST_LABEL_ALIGNED(.init.setup, __setup, _start, _end, initsetup_align)
 
 #define INIT_CALLS_LEVEL(level)						\
 		__initcall##level##_start = .;				\

-- 
2.54.0

