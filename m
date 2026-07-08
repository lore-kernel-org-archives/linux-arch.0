Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB963AE1A8
	for <linux-arch@vger.kernel.org>; Wed,  8 Jul 2026 02:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783477109; cv=none; b=K4QeJ7y3kb+bCnkvD+V0mVpOaEj4k+aeSa67d3wK9DcF94jzFqkTPIDblHfGEZh0na1GKiNJHHn75B29kzhCrRYdkCTRXuOjuyrhSBmOOQlFFwrDPe5WJEjtex4MVsEdc0QGsk8sIIbeAzNmvJB4LJcDG89SP8b5FZj9mBpYCxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783477109; c=relaxed/simple;
	bh=0NmENmK0/2sRvdDIHaL4q/g343CMSJD/KWi2ZY5I1ss=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CoMxTapURNUTjFQANPGdvgM48bPeb/PA7IaqWELbwbTB1mUv5B12lwFcF7y+RaFhOpWbJvWocOH/jqEvB0KMhF4GLbNpE5AcMUoVHVGsH/K15gYMgBOPlTuL4GRPLFZC1SWqHWERwqYPLmNkhRaxV5tpQLlu35XwUOMSv4mEJ1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=chb653We; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="chb653We"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-48d6c621a67so105109b6e.3
        for <linux-arch@vger.kernel.org>; Tue, 07 Jul 2026 19:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783477106; x=1784081906; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y4NFPrNHM8NGh27YAZAj6cHMKoI1eI/0WdJe3lAHUCg=;
        b=chb653WeF7ERtPfV88c89axP55atVFNMNC5YeBw0ediRZaLF494Q6mSoentWIFtk7F
         ONpJ+HA/DhnWo0TXH8HqHgnCR/+OD908Biybo41xfMomdtF5TzJOb2yLyklO+8GEkCCf
         MmPl7tSm/cCE0tJ2RB2NkQH3EA8yPcnu90IYn5exq9xVZs0i1WdOo66kougbfxHVTjh0
         aqbwqGqpetmTHuAk87BAbJIYpzeIsxVq40CFea1jZmYPbfE1hhmZHNas+cMmbL+HRJPd
         aU4eZbchvotSMA3pNGVVXXVfvFw6WZnQzB7riuOZKsDpX1gzcWwH9fz7Sss51wa7Vro2
         hhNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783477106; x=1784081906;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=y4NFPrNHM8NGh27YAZAj6cHMKoI1eI/0WdJe3lAHUCg=;
        b=qNUnqvIcgEwTWbTGojOasYRX/Cc573aCRPzJ1/2687pKfvuM/laRL5SchX1Kd/qwl8
         EV2UG2BbZNEm9+rTkUS3MmbIXuGIUzvkvT3VvDFTBFedXfrOTsdEC7I0FqqaCm0q+58k
         tV5pMt5FSPCFsP28rQmNpJQ6RjH3s47bmpIANrjsp4CbWjYe++mgVeNgOI2y08lFG85B
         4992OQhsjA1HPisw8JRlzKOK1zuyDeHr2n3Mdmc1te991SHsnq/ORJVe55CkroEnkN4w
         WPguac5az6t/FZGVu6DjyDUB+hrWcohh6gyCJNV1iRYMoK+o0qRYL1SkJXL+O4y7vMA0
         b5Gw==
X-Forwarded-Encrypted: i=1; AFNElJ9LkcytLPKG5AlCq0MO3vEWFgAVh5zfaZjbrQmuUy43nbyfmzqk6Di4TypWQ1VY7hO1I1vcdEz+zmqJ@vger.kernel.org
X-Gm-Message-State: AOJu0YyLO6MJxlIUBEtwR670okkZHLxDodfGvuXgK8ibv99TaaSZEfTS
	GAI5/ezR/KyYybEbswEIfO/ori3zU8uEVzpecH5gm27yxOeKnBB5Mc7S
X-Gm-Gg: AfdE7clgsBjqRxil/vfohgSDcc7hcmqlsJKSq7LsdvjQ44RyKJWEgouVRWIyjcoQk8f
	oD3W0C/vpfAYEiKX3N1++AmJ391Syz55OJfwkKkHXBZJCVN9GREOCf5MG+69l0n9dkXLR08gPFg
	OEfwxmHnqHZD6fAzY430Xa5+lEvKvg9Uorq1rmxHJmcdeibCLx068e6/fRXHRrZ7aAlwmAyxfvp
	LeCGiNRuBVbpk076h2Sx8nK3dqNQlO/0hxPWxLEjij2FmH7knJHGd9NFlca/cwqE04dkpMD5/Jt
	Gy1YiXWljr6LzqyHWPA6TeUBlccG8IWstJjwNDh1tdjCTe+4L5epHAytueL4CtJhgPZ9qRJYfyc
	KZG4ejp4AMVDTFE3Xn6iepVljgIt4EBkb/PZK5XhHuLAnglpumFe6ZfGUXtRr16J1jPbXptt2J2
	N0vTTaqolFQ6bQ0lPhVFc++XkKXm8v7AWHkkcexx30XRZhgar6FS4=
X-Received: by 2002:a05:6808:d52:b0:497:e39e:a002 with SMTP id 5614622812f47-4a204ce54bemr328581b6e.30.1783477106446;
        Tue, 07 Jul 2026 19:18:26 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-4a1aa006f74sm799975b6e.0.2026.07.07.19.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 19:18:25 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 07 Jul 2026 20:18:01 -0600
Subject: [PATCH v6 01/24] vmlinux.lds.h: refactor BOUNDED_SECTION_* macros
 into bounded_sections.lds.h
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-dd-maint-2-v6-1-381f3edb0045@gmail.com>
References: <20260707-dd-maint-2-v6-0-381f3edb0045@gmail.com>
In-Reply-To: <20260707-dd-maint-2-v6-0-381f3edb0045@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Jason Baron <jbaron@akamai.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783477102; l=4249;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=0NmENmK0/2sRvdDIHaL4q/g343CMSJD/KWi2ZY5I1ss=;
 b=J5qh+4g10P6PxlYU4nAckTFiyCYyWy8E12UFb35F97Nw7iIf6MPXOCAEx5iDTUw+fHx2cU5pf
 cf9ZNbHSrxBDC+PzcTD/aLHqo1Ed7y4Hj6FhQAs+Z0+HxpF1ROodkbk
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
index 5659f4b5a125..f5ddf31b7f26 100644
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

