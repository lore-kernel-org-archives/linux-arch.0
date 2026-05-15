Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD42426EBE
	for <linux-arch@vger.kernel.org>; Fri, 15 May 2026 08:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778835509; cv=none; b=Jj0WcFXOX9tj3atXsoFgw0aVQ2m4HypYT5BN5o+mN2uT8iNnk0y/XzlOQVeMTXKHKgfGBEqOZhzGB842ynhBqU4b9OEXPbc5CZyMewxGaDyRRODapFFxZaYXtHOh91DTvp237zpZ2C7gyf3Vi+SP9w66zLimV4Sq//qYh8FJXvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778835509; c=relaxed/simple;
	bh=pg9cpl0bo1AtFElQETrwEKQ1mUnu0drU6Mzj79jx4XY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MdwgLZtB/w0lAXcMDHeqYccbNtSEvRvdcbyBSMio9k9/R0XduuScWkoyeEnp1QDOm4UDjjdMYcWVIcviSkErVQP3/G8P4beLAvp2yp2PuJypG92FbuWzy9EeBd90GMAefsdSGRRupp/LEL8hT7lojQPaQ8VfmTAUWJr0d+ySJTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L6tKe9od; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6tKe9od"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43eb05b1875so5293345f8f.3
        for <linux-arch@vger.kernel.org>; Fri, 15 May 2026 01:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778835506; x=1779440306; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AgjU2Qt2uFal6066puOiKcG/bH5c3F/sQ7Yrgz0f2yo=;
        b=L6tKe9odUYOe12UFe5Z3atpqr+ybXcHgoHcMBRF1L/sD38/3KOzhCu/8P2WMyieZEo
         UTfGMQzPgWwmybeuxP8WWJY930PQZtEeyuyfr3lfGxY98WEw7qKeQOV4YA7lCIkEZmgn
         djWNCDJwYLU9gp5/v/dVzq4GuPw6UZI6W/brmYCle8jYcPBKri/jml0iV5N4yTE3osQA
         KgcdTHXnE4QY3lB1AtEdm4AzVh1Q6qIAxCnXL5tjGZbkNZ1JVvxsymA8F3ieO0YXiJQK
         4Fk46XibwP72XsE4u5/R7sHCl0Nx1F6rAAmgG6OIHj0KDQJeEJQxmi77fW+dolZJZ0Es
         n80w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778835506; x=1779440306;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AgjU2Qt2uFal6066puOiKcG/bH5c3F/sQ7Yrgz0f2yo=;
        b=bxYdpKcP+Z5zUkm3FFdX1sAv77CMxHT5dfG2ClGLTcr3V/HyFEeo5OKFilR/RRNIeW
         QagLb6nMXmU4J49IDK06aHxRdwzktsC6ao34Q8lqJYcsM3pwN7TFqMM9onaVp1DqQuyl
         4SBBp+aiCrhMnCmPHpqS5pDZaOH/42goYnzf4e2pVFB5e6ZDqJ9izI+gv4wDU/4Sgqqz
         1Z13VUbj9r7kdsmX83AhNo1MC7vmu1MOBSKoUnBq3cvuMKJxZUV13SbqhsKddK8k1KD+
         vloZqwezSWScswmvOtmeMHPuZ0jxMup8vfK+8YZWucz4MX+CA7s9GrWy2m0ggUMa7KMY
         qclA==
X-Gm-Message-State: AOJu0YwuBv4uWvN4g6t1Uszr6vIRxz5/RgVGFWQ3OY9RLspHAihZdo8b
	YMKHlK52dXXA043IfQ9PG5HXNuTEBWaci8RdcB3Ic4VtUDQHAi22rCFc
X-Gm-Gg: Acq92OGdEnGI3WZvvO7KNlGyxxENuRn9XadpcsDIy0aUgQFZ1UPTTpZsPb/9yOOZpzk
	8Zho/Vmqz3SBtvzgnLmY+Xqp8J0Sjeg3PMKI5VTdilYa/yWYp4ofUewWTAsM+KYiHrudbgu07Gu
	p3g0ozCnTJSynABrxkwz74fvBRM0KLI7fdClcEv3HHcgV9clCoycBLYGC8sKp8vujlZJwasfoCI
	AvDmVj6nG115Os2uvwCoMBeNh1PT7w6EgGEEv03RwRWw8TqNIcHeUiI/sZQWWagChRpIDXV+jbF
	VOyDEB3x3a/j5quIW4vmKhYCJ7TnxAlhCbmm00rVrhEiy+fhBwQR+Oc62HeuQvQu20aVeqPH+kv
	cZM9f5lJRrf2GtaNrWrZ7EgSUZ+x9S2Qd6gJ8U0zKQeny/H/DRCBFcEUdTwrlyIAmI8p7BYtHuN
	1PbHAh5LAl6FOTK2CcMGVF+bhlnXRio0ds
X-Received: by 2002:a5d:5889:0:b0:45e:5b92:1e45 with SMTP id ffacd0b85a97d-45e5c60d55dmr3656820f8f.40.1778835505710;
        Fri, 15 May 2026 01:58:25 -0700 (PDT)
Received: from [192.168.1.210] ([2a00:23c8:33b9:3b01:f7b1:b7a0:6254:c325])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-45d9e768c4fsm13142610f8f.8.2026.05.15.01.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 01:58:24 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Fri, 15 May 2026 02:58:10 -0600
Subject: [PATCH v3 1/5] vmlinux.lds.h: refactor BOUNDED_SECTION_* macros
 into bounded_sections.lds.h
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-asm-generic-1-v3-1-680b273666d4@gmail.com>
References: <20260515-asm-generic-1-v3-0-680b273666d4@gmail.com>
In-Reply-To: <20260515-asm-generic-1-v3-0-680b273666d4@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>, Jason Baron <jbaron@akamai.com>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
 Aaron Tomlin <atomlin@atomlin.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-modules@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778835503; l=4249;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=pg9cpl0bo1AtFElQETrwEKQ1mUnu0drU6Mzj79jx4XY=;
 b=UDcB0IA+uJ7wRttA1XdEmqAlGqtAr/TYTORh8uXa/ljuE9kcGbu/8l+g4/1/jRM3kY4vjLwSw
 c7LctSEq/n2DMZO9tKi+XB61IRdc9hFqaSOqyA4G5H31nLX6al8Rt29
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
index 60c8c22fd3e4..9c61dd083f26 100644
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
2.54.0

