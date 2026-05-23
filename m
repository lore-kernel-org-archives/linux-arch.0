Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D619345CA8
	for <linux-arch@vger.kernel.org>; Sat, 23 May 2026 07:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779520498; cv=none; b=aRxEKhJdmJfH8dS5X0HeNSIg2HB7VcqRg69l5ceAksoJa/swKk3MwXsNUS5zzBGWq5pqzwSjqi1hQq2URWKzG3mwpRleDnIP0oiXWiS8VFiEzhThteb/iJL3P2GX+WWgmMNJRO4AYk42vWStmib5vUC/oKjCIe8a7CI6dEupxOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779520498; c=relaxed/simple;
	bh=pg9cpl0bo1AtFElQETrwEKQ1mUnu0drU6Mzj79jx4XY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jZfY6slKbflEs5Q/AVDsXoaZr9SUDdq1IeeAzD5vosZ/Gtg1O+naNtcntgsOjGZ1DNk4YQ/X8yd+1dBPvEQ5XL/gPn/q905ralYBjpjl2n9ruYvoOK3IYTjflfeopCYPqcHiN14tVfPWW6E5xC8we2rTxlsOflYCXahR+6yth2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LQ70nyeE; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQ70nyeE"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43d7645adbdso5395394f8f.1
        for <linux-arch@vger.kernel.org>; Sat, 23 May 2026 00:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779520494; x=1780125294; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AgjU2Qt2uFal6066puOiKcG/bH5c3F/sQ7Yrgz0f2yo=;
        b=LQ70nyeEQ9O9F82G1YgfUf9f5MUMyZpCheu50vPLj6PxAsCr8NVFw0g4yZBpyEUmtg
         qP7TwIjl+ayxSyCMUKKpX0BW/hIzXqjOI+bvYmcqRD+YwyTJwzVP9MJ2ZHT+sMqfaVgK
         wyxujpfFLlhnYeYAEkJftsEAiLUgmMJ9DH+n3+u0t8wBYf9cwzlxEkAMOihoLIOIfYtV
         Zy0m2o03SmS3ICfW0wcNfTOcKvG8b80A6Vs2Q9rhgSeT247bkHvvH6zBK6+HLQjf1ORr
         O960bbSjVmT5Oi4d/GeI29jZFJO8GbqBKli0rXFJzHfOEbfLUoKHPTXEEcr8WbclTb6Z
         MHlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779520494; x=1780125294;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AgjU2Qt2uFal6066puOiKcG/bH5c3F/sQ7Yrgz0f2yo=;
        b=m3tx6jrhZDqwEpd1r0OaeNf+uHPRHIQQKiFZjQ4c+zSmZtIro/vA6J1e9sEcfdW7Yb
         uM8etu88rFv9e5fAsItrVHSWJ/B4yidYWCpYiZr42AHRJlnPL4bcuZE+IELZiAvVQj+u
         Bc9d/w1DtAXID4FJl5mMLOCgo/YpcK8bm7wzNnDLy81kdNbv0hIdl4M41EttzBgQtUFE
         TU0LHWHd42Rrr+gXgRU+vkdmlZJxN4Srl4YGI/a1EVRrGFQLQcK5n9FRDSshqVYnnQbC
         E22AUjnNPe7X9zTyfYkKFvEe98NNsCGlEyXI2j/cIXZF3WgZYZkdiUzetJ5h0FlPDCv+
         mKQw==
X-Forwarded-Encrypted: i=1; AFNElJ9eR9B3C7tzuXB//RfmTVuwclDSY40NFhvvgfePq9pEtVq28fMzSG3C+JeMcKBtQUhRBfdwM3MOjpku@vger.kernel.org
X-Gm-Message-State: AOJu0YxCroGSk+2CeAtuDIyehw/p5RnOm14iOAHT1EakH0MVj0UQoBAE
	0DyV9MQ7B4Ju+SgxJVd/IhEEOE0QG6q0+Z/Nmfe3TRuMUhDSRaD0GpYk
X-Gm-Gg: Acq92OGeWg1NCHtpt1KLPZsmUH7xi482O7YnYb6lhW1bxcOGMB7vvJHM1Qx3/m616uy
	K5ys9WG1mYWqLvFqBvGqD0Q2uMEtbPzeHaABH1vacqZ0Y8YSsMjl9203ktp/RoswJA2lYtCofjI
	5kWFHAJBWga70bilNmX6c13+rNb+6iXf/sKfT80/Uh0QfNRlcnEawzvCObqhMlAZvGlUOZpGUkX
	vU3WR9X0Aof2eM4Vo8RxYgtzdYMintm9YufVhUPrAfk7purKtUwhmquOP/hYzUC71ylKR+cD7OP
	RXxcVILvQLHHbQoFl/5Ey6wZ7bFVQLfyT5n2lY74NmTZ5+uncHXV5rGIYiWkns6e95yV+AWGBEL
	cNn+niewSSXQJ68KHZGJAQtPufH2SwUeDPzuF+tqDqE158ejZHL2fVZB/bw6OD8+DrHfmmpkOvq
	t+kVyYD7OyanSI12Y5/RciFmUQmRkmnlMxMdNwVMA=
X-Received: by 2002:a05:6000:1acb:b0:45d:b14b:2409 with SMTP id ffacd0b85a97d-45eb38a798dmr11656676f8f.2.1779520494334;
        Sat, 23 May 2026 00:14:54 -0700 (PDT)
Received: from [192.168.0.174] ([31.96.183.250])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-45eb6d5cb76sm8639838f8f.25.2026.05.23.00.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 00:14:53 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Sat, 23 May 2026 01:14:36 -0600
Subject: [PATCH v2 03/24] vmlinux.lds.h: refactor BOUNDED_SECTION_* macros
 into bounded_sections.lds.h
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260523-dd-maint-2-v2-3-b937312aa083@gmail.com>
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
 linux-kselftest@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779520485; l=4249;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=pg9cpl0bo1AtFElQETrwEKQ1mUnu0drU6Mzj79jx4XY=;
 b=WH0AntNe0OhurMiZGrWISX5Fi7F6HIZcFImYCZSWocR9Qe6r0AlL6iFIRm3OL+X7tRT5goYjE
 MWDUptwuglbBoUvOh8OP12aNyTgi93qwFSo+z6wgggVg7aRGBQ5Wo4b
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

