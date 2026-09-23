Received: from mail-oo2-f41.google.com (mail-oo2-f41.google.com [74.125.231.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A1C3EC804
	for <linux-arch@vger.kernel.org>; Wed, 23 Sep 2026 22:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790202888; cv=none; b=OHmFUpCTvjsq+iiZvUweSdtfB9V9k9cLjVKcZAp36D3/WE5A9K+VkTlO1bsyrM4L5HLE/SnXKaNw3TBa7cH115k4CRebRaWbydQwHusVsjd2l5L/AVR4vUT7jUQHGLGxlk7He+CEdJuaaTq4L+3IBsF4hrOKODIfno1/wAn5LG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790202888; c=relaxed/simple;
	bh=6qxe0gy40UPEdl0jWeVq5+K3tVsIJlZLuSqprPmS8d0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kGaQBmjodUPmMfxk48NiRHdeYa4rIaqKmUzRLpfJdjPKvG4A21G6K8tk9Ga7oeES5bSCbPSSn7KyBMWyAhPM9GnxoDjga0Re9z755PLkHNG8p+WkjTNMHqMBdi3jC0P0RTP6jm0NnFipnevt33FVAbiIBKNX3F2NoaPRlnOVkLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U7UypNpx; arc=none smtp.client-ip=74.125.231.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U7UypNpx"
Received: by mail-oo2-f41.google.com with SMTP id 006d021491bc7-6d13d47b7caso775087eaf.0
        for <linux-arch@vger.kernel.org>; Wed, 23 Sep 2026 15:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790202882; x=1790807682; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gnMlaIiyV9uCkDgs9M5hIDK+zz/c3R7cHWP4ep9lWHU=;
        b=U7UypNpxlVShj9rYNOoyccV1Co6CKM3+LNrIgKc9y0bTqUx217TeKWbyMw0aFLEr1n
         E4JvoK8BPyKj+fbWol5KfeLjYTkcYY4v1hf0hy1nbDdPxoRh+ChMJY1fmjwdINqk/u7p
         tjVw+NlYmOzgajW/mABVFGZadsgUTyeRvwFLD1liR1CNOCEpn4jh1MpfmD5/tD4v8st5
         8APDqD0xt6C6ChvyzadUsB2MHKFCA2+Ve9lD7o8xeSWd1QgtT+fVw+fPWvPHCoEw/ybS
         eaQGvUlclJf+OLtH0Np5zGoXXO5o9YmZWVYe03TcpPE9Kwd2OIBh8FqqaaJP2G4Rvg/w
         hHhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790202882; x=1790807682;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gnMlaIiyV9uCkDgs9M5hIDK+zz/c3R7cHWP4ep9lWHU=;
        b=U8xptbaZpYiSaJ4dNdrP1UrFB4Pzjx9ZXEnuZwGbH+MC8zeDTXbF72dW73FIc/Hlpt
         ADwy0YsKYCff6Pkt3UhNe1SzTZ0ZQIZb+7IoVcwlrlq5yTIA4Ee7Bb5gYLzdk5dVUYHD
         GaY7Wx6a73XqTyrglNS4JynJA2vA0yuJkRqyBsGjiGlWrbjGG8nJmbibeV6Vcg23Nze3
         g3vmMt+rRd0lRaREPK5LuIGIJO93EGDq1dA2GGfMl0BHFU5VMYw31QBAPLTx61xGBqWD
         85o82kXjXlhpgCQ4vQF0bUwPEVsJVDSDgbE93FztusTBym3ctn+wNN9z6wRD/+a08Hbz
         TAXg==
X-Forwarded-Encrypted: i=1; AKwUvBwdhrgsC3vBQeskc56XdNtZQrgmfqmp+L89GAW4qY08VbLmQTbU+YL6cghSV8388hoTjO63u4qOselH@vger.kernel.org
X-Gm-Message-State: AFuF++mu6Juqn4gIlc+YCgkhlTK0IFv5iwbbhTdAMt1aG68mnd2l5qB3
	fts07IwGZYjnXfN2rdybvRi2EtVmO2b8PLadx/BFgbMYadCAxt8NjDdRSH51wvGx
X-Gm-Gg: AYBFou1/HEygBz0VRXUETxbBCyVyU6q03MR4wbhxHmPvRcTvj3OZ6KP4RChz46KjyX+
	9+BTZE8uzwYRTfS0ux6ncxTSqSaa2anKNr6BXNgRM8dx2kgPx9/Kcs2FUqMtS+sqhwz1OOlXqTK
	gpXYma7rFhzgFimiGzAsd4XZik9UajeCs562gPg8A6dkoN6twq6oo3o83n4+ba6TyW4oi/X1iI9
	HUhkisMyOLm30tQh2at9jV/gX9Fk5eZZVckl4cJseR7OEsUAU8hR5v3Bf9uwgme9O5eUdQVcdsR
	xz4vNswEG6m9073dqbrMyf4n0VUp0RTB+FIwsK8nWRT0laqNjiFrBdA7k7YZwakuyfv8/JFIu5P
	L5zNkc9AT0vt5d9oAMAHQBNLJbLwkW3OXPfl8WvUiJ2y93Aki+NezB0e42/w3R5sQGatGEwR2HN
	CV/4txTlaOLoPB5LNF7DJPqDLioHlfEs73fa6Jur8SDJlgI1ywBCPcOJsDndCT1HW8x4uuhFhKc
	J8qgd6L3W5ncWe8FmAYwbgj/v0BzQHnTzvMfGT0IXapD5wWhmaXhIyWynL10+ahobziQWMmrPYU
	olouRVS/FFS+lEwtA+0=
X-Received: by 2002:a05:6820:f02f:b0:6cd:3fec:de73 with SMTP id 006d021491bc7-6d441b81d40mr645833eaf.73.1790202881675;
        Wed, 23 Sep 2026 15:34:41 -0700 (PDT)
Received: from [100.82.231.29] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-491ee1ac486sm559401fac.16.2026.09.23.15.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 15:34:40 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Wed, 23 Sep 2026 16:34:26 -0600
Subject: [PATCH v11 02/38] vmlinux.lds.h: refactor BOUNDED_SECTION_* macros
 into bounded_sections.lds.h
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-dd-cmap-part2-clean-v11-2-9b6c217fdf2f@gmail.com>
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
 Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790202874; l=4249;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=6qxe0gy40UPEdl0jWeVq5+K3tVsIJlZLuSqprPmS8d0=;
 b=SbE6VLJkKQA4ZmuNShacCQ41GeiHEqiikvRAmn7Y/poA+1ah98T6vCjhM8agKA4SSUV1iLPsi
 lAjSmEq3yPPDEM+C7k7FjZCi5nPx+bOkRUPxtSyMlpAUpaE+b8snz3X
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

Move BOUNDED_SECTION_* macros to a new helper file:
include/asm-generic/bounded_sections.lds.h and include it back into
vmlinux.lds.h.  This allows its reuse later to fix a failure to keep
dyndbg sections in some circumstances.

NOTES:

These macros are only for use in vmlinux.lds.h, where the _start &
_end symbols are needed.  Modules keep sections separate in ELF
sections, with their boundaries known, so the _start and _end are not
useful, and may confuse tools not expecting them.

This patch ignores a checkpatch warning, because new file is covered
by "GENERIC INCLUDE/ASM HEADER FILES" in MAINTAINERS

CC: Arnd Bergmann <arnd@arndb.de>
CC: linux-arch@vger.kernel.org
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
v3: move include to top
---
 include/asm-generic/bounded_sections.lds.h | 36 ++++++++++++++++++++++++++++++
 include/asm-generic/vmlinux.lds.h          | 31 +------------------------
 2 files changed, 37 insertions(+), 30 deletions(-)

diff --git a/include/asm-generic/bounded_sections.lds.h b/include/asm-generic/bounded_sections.lds.h
new file mode 100644
index 000000000000..8c29293ca7fb
--- /dev/null
+++ b/include/asm-generic/bounded_sections.lds.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef _ASM_GENERIC_BOUNDED_SECTIONS_H
+#define _ASM_GENERIC_BOUNDED_SECTIONS_H
+
+#define BOUNDED_SECTION_PRE_LABEL(_sec_, _label_, _BEGIN_, _END_)	\
+	_BEGIN_##_label_ = .;						\
+	KEEP(*(_sec_))							\
+	_END_##_label_ = .;
+
+#define BOUNDED_SECTION_POST_LABEL(_sec_, _label_, _BEGIN_, _END_)	\
+	_label_##_BEGIN_ = .;						\
+	KEEP(*(_sec_))							\
+	_label_##_END_ = .;
+
+#define BOUNDED_SECTION_BY(_sec_, _label_)				\
+	BOUNDED_SECTION_PRE_LABEL(_sec_, _label_, __start, __stop)
+
+#define BOUNDED_SECTION(_sec)	 BOUNDED_SECTION_BY(_sec, _sec)
+
+#define HEADERED_SECTION_PRE_LABEL(_sec_, _label_, _BEGIN_, _END_, _HDR_) \
+	_HDR_##_label_	= .;						\
+	KEEP(*(.gnu.linkonce.##_sec_))					\
+	BOUNDED_SECTION_PRE_LABEL(_sec_, _label_, _BEGIN_, _END_)
+
+#define HEADERED_SECTION_POST_LABEL(_sec_, _label_, _BEGIN_, _END_, _HDR_) \
+	_label_##_HDR_ = .;						\
+	KEEP(*(.gnu.linkonce.##_sec_))					\
+	BOUNDED_SECTION_POST_LABEL(_sec_, _label_, _BEGIN_, _END_)
+
+#define HEADERED_SECTION_BY(_sec_, _label_)				\
+	HEADERED_SECTION_PRE_LABEL(_sec_, _label_, __start, __stop)
+
+#define HEADERED_SECTION(_sec)	 HEADERED_SECTION_BY(_sec, _sec)
+
+#endif /* _ASM_GENERIC_BOUNDED_SECTIONS_H */
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 2187fb463de6..019072d3d391 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -50,6 +50,7 @@
  *               [__nosave_begin, __nosave_end] for the nosave data
  */
 
+#include <asm-generic/bounded_sections.lds.h>
 #include <asm-generic/codetag.lds.h>
 
 #ifndef LOAD_OFFSET
@@ -211,36 +212,6 @@
 # endif
 #endif
 
-#define BOUNDED_SECTION_PRE_LABEL(_sec_, _label_, _BEGIN_, _END_)	\
-	_BEGIN_##_label_ = .;						\
-	KEEP(*(_sec_))							\
-	_END_##_label_ = .;
-
-#define BOUNDED_SECTION_POST_LABEL(_sec_, _label_, _BEGIN_, _END_)	\
-	_label_##_BEGIN_ = .;						\
-	KEEP(*(_sec_))							\
-	_label_##_END_ = .;
-
-#define BOUNDED_SECTION_BY(_sec_, _label_)				\
-	BOUNDED_SECTION_PRE_LABEL(_sec_, _label_, __start, __stop)
-
-#define BOUNDED_SECTION(_sec)	 BOUNDED_SECTION_BY(_sec, _sec)
-
-#define HEADERED_SECTION_PRE_LABEL(_sec_, _label_, _BEGIN_, _END_, _HDR_) \
-	_HDR_##_label_	= .;						\
-	KEEP(*(.gnu.linkonce.##_sec_))					\
-	BOUNDED_SECTION_PRE_LABEL(_sec_, _label_, _BEGIN_, _END_)
-
-#define HEADERED_SECTION_POST_LABEL(_sec_, _label_, _BEGIN_, _END_, _HDR_) \
-	_label_##_HDR_ = .;						\
-	KEEP(*(.gnu.linkonce.##_sec_))					\
-	BOUNDED_SECTION_POST_LABEL(_sec_, _label_, _BEGIN_, _END_)
-
-#define HEADERED_SECTION_BY(_sec_, _label_)				\
-	HEADERED_SECTION_PRE_LABEL(_sec_, _label_, __start, __stop)
-
-#define HEADERED_SECTION(_sec)	 HEADERED_SECTION_BY(_sec, _sec)
-
 #ifdef CONFIG_TRACE_BRANCH_PROFILING
 #define LIKELY_PROFILE()						\
 	BOUNDED_SECTION_BY(_ftrace_annotated_branch, _annotated_branch_profile)

-- 
2.55.0

