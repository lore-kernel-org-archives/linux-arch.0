Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795483849;
	b=hin1N4oETcjUPWzFjB0XJGwIInW2x+z3T9OeeIOJCs9VqhRvvGePus8fGy+L8wD6MLmc
	 RYG2EXRaPb4wH78wU2uDPNCrMJVKYXDlJckO0LSiuoTd9AufMWwX+sxyr7P2Zxnl85gpG
	 UDIVEDR/hV/yHFlKEn4SvYanM8YUzYV8EjKM+/6/b3bYQgNVylX50H++KqM9sOlcPzxPq
	 u0SexpD14UUI5aGJKvwkrAxsDJ4K9lHcsJEjw3qazxQwLbtW3t61WSBK5TqH/nqJblwuO
	 1N3nmbI/YAB29qkwxquNU2lM0LWFnaC8Jk+iGTjPGcuxElrUIBXvlZDFXXqxXJiIOCA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795483849;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=RkIhV0WdCzbkfu+HI2l2iN6aT4pZr4Bv83ASJ116Gls=;
	b=TbXJksAyRWZBBsCD9lGNYzaKuwpu/H1ebx6ws6gpKtZ1hXBFU66oVlj2bWLkv2ftgOZU
	 miD0m9SzpykfHtjHniSXkkiiStXUJoN7VTHtnzWhp2ueeh6QHDVhdoDtemcVlot4x07L0
	 8+5uK+HHVbYS5dgpl7Q26oCxvh+sDgZbvmNNYhzfoFschhFE2zqdMmjXIjB2xs2PLD72V
	 7QwoxyxUqwNr8WG6dlJjrsuSMvUUNrvCOB6KRJL/qh6R7RArd/2z5MVPcwYN+UwjnmxjY
	 N6nyeHUE8MGVHdWvq34Wny10WCg+M8XgH/z/Mp0Jij5JgDBU/9sr0o+lr+3brZYLAXg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GiA0HH0j;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3587A606A33A;
	Tue, 24 Nov 2026 01:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GiA0HH0j
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795483848;
	b=jEWCsTb7/ozofFpm2KKkdbpmqVXhOnSTYVtGBasOZDDZvBUdT69+9h67X5Uexx0qvdZt
	 1ZKfk4YQ0LbTPoBCYhFspGB2hpK3lyIcqg9Ap9g7LrD5JqOvWUlsQRvRFejtlvaE5ZLX9
	 LKsJey/wzTUCdsaUQKy8cRMFuR37skl/B1JmlyuRELUKvkGC1jEHMv+aq2rgHWG8QL3B2
	 AbxXOR0BmycZpJRHaphCzuafKCsZsOHCiAOS73DOA9T4p7BB+ispE2abI37jvwo4ADbBR
	 1kHDBVVZ0/jbgmZh26yxCNJXvLhgxslYCUwHWSlcon0ujomfWbkygbHnxfqfIJIDckw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795483848;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=RkIhV0WdCzbkfu+HI2l2iN6aT4pZr4Bv83ASJ116Gls=;
	b=sQMQ+urIuZ9oKhw0xkilQT7qwaNqfGTyeyKq/HOdkEci2bzAbfqCQWMOY1pXFTCmIkXJ
	 LuLBnnicwCabAlkg0AfcXB9l2WYBDqZ1FpAlVvsPXLgsyKyggZChSMHPz+jWAhzOugOvP
	 MRZBU95BR5M6TiRajd0NQqTvOvdyGn6GyFA0rAQNsViRdyV6Hqus94lIxrukswqVTCAX4
	 9Jhf6to+mpMxZwJev267IOKyUWEofVAFd6RpvecVq+pSOqpbDQ+0B7w60vpKegaM6dsI8
	 5KNGWt6LV3vvwu2WzPbwrT4Cnz21kKeS3yMCbyO/isg9pNAUGGZt8feSY11bJcXRs2w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 27DCD1F000D2;
	Tue, 24 Nov 2026 01:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795483848;
	bh=RkIhV0WdCzbkfu+HI2l2iN6aT4pZr4Bv83ASJ116Gls=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=GiA0HH0jHxFiWa7+wN0jXzAbE3wB0Z5t58jVDVAqJ1OeF8OOHlQmkZu3R8bZNTUuT
	 YWZMkPw5t8pSb9MpetS71NkqnS+/A8VLh/Zx1uMdE551Z05ylrmcOcYZaQfY70WdO6
	 XP784kabvea7ZfEmg+DhI7OAMXYUy+6Xcz4GAeSrD+O2DaDtovnIwIswuVR84+r8Xd
	 0YvqUomR51ZQvfTuAC/If2lX68pPOGChsqr91C3qfXfhPuuVdyFSysQbB9sI94WLzb
	 v5q1OspQ7GoUovZ+pVzDPIAtb8RxOOFenZ7Z7rGkBND0+OWJNdnLwIAWhqKpbyk25o
	 j3glMbJAPmGdQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id A45C14C822;
	Tue, 24 Nov 2026 01:30:35 +0000 (UTC)
From: Jim Cromie via B4 Relay <devnull+jim.cromie.gmail.com@kernel.org>
Date: Mon, 23 Nov 2026 18:30:35 -0700
Subject: [PATCH v2 3/6] vmlinux.lds.h: fix ALIGN(8) omission causing NULL
 ptr on i386
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261123-vmlinux-lds-v2-3-6f608abfa042@gmail.com>
References: <20261123-vmlinux-lds-v2-0-6f608abfa042@gmail.com>
In-Reply-To: <20261123-vmlinux-lds-v2-0-6f608abfa042@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>, Jason Baron <jbaron@akamai.com>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
 Aaron Tomlin <atomlin@atomlin.com>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795483834; l=5920;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=ajwR8GziHDJU3wwF2tW8BE+gPTAdCOMMAGzEqf/lWjU=;
 b=bArdh5uWuWRCuPcUBjl/PAUW2sjsRiMBibLHykBQmygJXMIC2238hSwuVTeYDWHtM/2dytwEw
 lUwRxuzjymKBZMykd+fPPlk9s2VpYwMZxpElXSq3fNFy6l+lMmE0r8l
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=
X-Endpoint-Received: by B4 Relay for jim.cromie@gmail.com/20260203 with
 auth_id=958
X-Original-From: Jim Cromie <jim.cromie@gmail.com>
Reply-To: jim.cromie@gmail.com
Content-Transfer-Encoding: 7bit

From: Jim Cromie <jim.cromie@gmail.com>

Almost all uses of the BOUNDED_SECTION macros are ALIGN(8), either
explicitly, or by being below an aligned section containing x*8 byte
objects.  The noteworthy exception is BOUNDED_SECTION(__dyndbg), which
immediately follows BOUNDED_SECTION(__dyndbg_classes).

On i386, struct _ddebug_classmap is 28 bytes, so without an explicit
ALIGN(8) in the macro, the following __dyndbg section gets misaligned,
causing a NULL ptr deref in dynamic_debug_init().

Fix this with an explicit ALIGN(8) in the existing BOUNDED_SECTION
macros, and introduce _ALIGNED variants (suggested by Louis Chauvet)
to handle the cases with an explicit . = ALIGN(x).

Also add explicit alignments for: EXCEPTION_TABLE, ORC_UNWIND_TABLE,
TRACEDATA, INIT_SETUP, and NOTES.

Update BOUNDED_SECTION uses inside . = ALIGN(x) stanzas to use
_ALIGNED variants, while keeping the outer ALIGNs so the symbols
between them are not "re-aligned".  In particular, scripts/sorttable.c
does not tolerate sloppy padding.

At the top of ORC_UNWIND_TABLE, add . = ALIGN(4) to match the struct
orc_header alignment added in commit b9f174c811e3 ("x86/unwind/orc:
Add ELF section with ORC version identifier").

Suggested-by: Louis Chauvet <louis.chauvet@bootlin.com>
Link: https://lore.kernel.org/lkml/177402491426.6181.12855763650074831089.b4-review@b4/
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
Note: ELF notes (Elf32_Nhdr / Elf64_Nhdr) are natively 4-byte aligned;
.BTF_ids does not use BOUNDED_SECTION* since start/end symbols are not
needed.
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
index 5fed4194983c..c570495d8de5 100644
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
@@ -679,7 +679,7 @@
 #define BTF								\
 	. = ALIGN(PAGE_SIZE);						\
 	.BTF : AT(ADDR(.BTF) - LOAD_OFFSET) {				\
-		BOUNDED_SECTION_BY(.BTF, _BTF)				\
+		BOUNDED_SECTION_BY_ALIGNED(.BTF, _BTF, PAGE_SIZE)	\
 	}								\
 	BTF_INLINE							\
 	BTF_INLINE_LINK						\
@@ -871,16 +871,17 @@
 
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
@@ -908,7 +909,7 @@
 #define TRACEDATA							\
 	. = ALIGN(4);							\
 	.tracedata : AT(ADDR(.tracedata) - LOAD_OFFSET) {		\
-		BOUNDED_SECTION_POST_LABEL(.tracedata, __tracedata, _start, _end) \
+		BOUNDED_SECTION_POST_LABEL_ALIGNED(.tracedata, __tracedata, _start, _end, 4) \
 	}
 #else
 #define TRACEDATA
@@ -937,13 +938,14 @@
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
2.56.1


