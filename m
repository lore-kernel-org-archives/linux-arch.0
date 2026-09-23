Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com [74.125.231.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98585483BF4
	for <linux-arch@vger.kernel.org>; Wed, 23 Sep 2026 22:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790202889; cv=none; b=t/1qvK4V/Gkq8C8zEfRM2mXLt2I9D6e6fSPaYY86uoHpG4n+knwblSmW87RpwXpE853vDgAeY+3ommThKAFwlNjSQ56yreYgt7s5zMc63Dz+MlKguuk7KEBjrqbmPYc+mxluoAq9I35sXg/Pe1SzAW/fWfMHLkgJVBG+wLAJxdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790202889; c=relaxed/simple;
	bh=KafV4Ai050cNwyxUNFExAF+ZpbeZ3M0y4ugVhMxmCII=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ElQR125l/FXuGTmA8HUJrP/LQgiUiEyrMelkRVJ6+zj3SSzKmk974av0MYx3IKEldzc5GXmXylniPJ9asoWrHfWPAfe6ZTSLkimR97/0DidNeDccjq6J8DbweaHPV5Pj7GYaZMD5zPT3elFtJ0CYOs8JwMz18TIYfx7sWmwMZc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mj3ymEOs; arc=none smtp.client-ip=74.125.231.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mj3ymEOs"
Received: by mail-oi2-f13.google.com with SMTP id 5614622812f47-4c6ed1de994so995328b6e.0
        for <linux-arch@vger.kernel.org>; Wed, 23 Sep 2026 15:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790202886; x=1790807686; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X1uGbOIzIyWw0k5unFoP8BUkOpwCAhzQ9m2N8luGZ8E=;
        b=mj3ymEOs7RsfSWOeNfMmFBSk3DLRSLGKpqtctn/i+EK1qFFVk51j7VOGoRNzgBbWp8
         la2QakfoLD5iL2LR3YeGN/N6bwMKqhpTZ5T2M5gybvTDQ7yLZLvIISA91ZVk4aKbC2cr
         8QoEnAZBgdeiksHNFxFDiA1s4i9dg6XYgnMSFe+5onwqz5akUt9nnbin0QF+cX4m455n
         rOOsTXYeZbvnhtUVunMKhqn+ZPyeXCo6q0KuWmRx+ME/WSatxx0w5S7LjDMLgs8n/TEA
         Y2KQwlSR+vT09wITQIwdRcX9YwfEM+eIhkYhZ7w4HeRJTrzSQxXq2XLxRLYgWRfptukz
         +Xag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790202886; x=1790807686;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X1uGbOIzIyWw0k5unFoP8BUkOpwCAhzQ9m2N8luGZ8E=;
        b=nxbfdHcOOovNflTk15R9r7fmWmp+AovjeglovlkY00jzTdBbLe7+srg7ul8S/kkKrW
         DSMKoo0FUbHkLiiWSd1uoCH4KptwJmx6o18AqJu4J1oWQAsVUhBaMJZo4mA25yFLB40q
         5QhWPRffQ5VEmo90hBrZ+zUFqFzlLY1GBKVzJw1YKrM58iVvrM2dhsgLFRTGNios9afp
         Hjdr1MRluW+al9RdQqznYnRTX8eUvKrae0OOyNferd8l7V3/qtOiU+Vqw4bftw9A6Cz0
         DDzEWifNwMukkCHGjl9QM6O9rbR5VjDT6t/ceWTukS45h/o5fOuKJxKaszUeX+Ss71/z
         hCsw==
X-Forwarded-Encrypted: i=1; AKwUvBzjIitrG4Juk4Zbb4hBIaesRKFaF6R5QN+vZ031Uzn77EugcvvHrOn3mCOAmUXDSGZnN3gYmVjV4OOy@vger.kernel.org
X-Gm-Message-State: AFuF++nJmy6i2snWaFPjTn3+us4KVZnqm1maxYsXu9aBnq/W9vI+F86V
	iYvjC/4ScV5bsL2Rv1apaAt4g+r6R/ayhuevipKmBhXA9F9tDqV+9qd7RF6dtLco
X-Gm-Gg: AYBFou2LRwdV1wxtj1zqE7rMb6SMn0w5stDfZU0lRMzTS4NFujMJLnGeDK5pwHdAdvi
	/PXLzPrJQennPMwn6TkiDceJ1UqqWDdTmSoBcLp2arYcuc/ijSzQXTMa/h3CggYcvJ/8ftR1cvc
	dBGeakGcYOMGEi5kiv5XD5orR01MP1AUbKx2OpcLn+qClpf85mb+B874wq365ZlyG7Z+nYbwjzp
	EvDsckepnp2128j65s/U7oEEEnHu6powmLxcLzo72iGzzvJqEuQL/LNQDFhnz9IyCehtbVp8oGf
	UAqBKL6XnimY0pSTtccGtIgX74xx3utwT6qSc1PGQVqAoawe07mcMByhFQMnVN2KoJK/YnNOuGM
	8wCwN7u+LpoaLqCPt7GjjRasMLYKIlJo1elvzxpOBv4kPkREbBCO0i3z1/8a2SJVsbf5ryUFoaY
	aXeBys6clxohjG/fbhZhfW+v6DgCCEX/D7WizbjY45Msg6ssw2qihNqlsxc0O+rEU1y4CGWI0lx
	vpfTGaDHNoKfU2sOkwXuM9zdNXMnTgWZa4Fe9UQUCqO9b3D5WkjRf/0HfJMaGkuWgfILu7GquDs
	k0S1IuY/LDzrdDURgxc=
X-Received: by 2002:a05:6808:4f6c:b0:4c4:d8a0:2773 with SMTP id 5614622812f47-4d72df6d951mr659351b6e.32.1790202886518;
        Wed, 23 Sep 2026 15:34:46 -0700 (PDT)
Received: from [100.82.231.29] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-491ee1ac486sm559401fac.16.2026.09.23.15.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 15:34:45 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Wed, 23 Sep 2026 16:34:28 -0600
Subject: [PATCH v11 04/38] vmlinux.lds.h: Fix ALIGN(8) omission causing
 NULL ptr on i386
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-dd-cmap-part2-clean-v11-4-9b6c217fdf2f@gmail.com>
References: <20260923-dd-cmap-part2-clean-v11-0-9b6c217fdf2f@gmail.com>
In-Reply-To: <20260923-dd-cmap-part2-clean-v11-0-9b6c217fdf2f@gmail.com>
To: Jason Baron <jbaron@akamai.com>, Shuah Khan <shuah@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
 Jonathan Corbet <corbet@net.net>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Len Brown <lenb@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
 John Ogness <john.ogness@linutronix.de>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, linux-pm@vger.kernel.org, 
 Jim Cromie <jim.cromie@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790202874; l=6221;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=KafV4Ai050cNwyxUNFExAF+ZpbeZ3M0y4ugVhMxmCII=;
 b=max867D2x5WnedlXC8Xh7KRH7w+xDMU16hhtAfusSKWn2//sTylUayWziSo5V8k/X2EU7YocO
 X4wQg6/urptCHhEJgHfL+RVoCPVPNK6nj+dAfldy7sGiLNwU+hIZvQ2
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
index 019072d3d391..b77a1bec38fc 100644
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
@@ -842,16 +842,17 @@
 
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
@@ -879,7 +880,7 @@
 #define TRACEDATA							\
 	. = ALIGN(4);							\
 	.tracedata : AT(ADDR(.tracedata) - LOAD_OFFSET) {		\
-		BOUNDED_SECTION_POST_LABEL(.tracedata, __tracedata, _start, _end) \
+		BOUNDED_SECTION_POST_LABEL_ALIGNED(.tracedata, __tracedata, _start, _end, 4) \
 	}
 #else
 #define TRACEDATA
@@ -908,13 +909,14 @@
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
2.55.0

