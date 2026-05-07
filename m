Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6928D311C01
	for <linux-arch@vger.kernel.org>; Thu,  7 May 2026 20:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778186415; cv=none; b=S4gixfp8yP/nh5lBuxbp1hmBbchThQtZxhe0qvmiL0/Gei4AYJBCi2MtC8+lUZYg/4l9Ji8eJl+fyRBMibssfILXtWasL2WHL1zqJ4KC/NX8pM31rg2buu3obLlEBVIj7iJ4A48yU6Df3Fs8wUDBpuScDIi62VW5rEPCn8lIDs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778186415; c=relaxed/simple;
	bh=Kdq5NNBpBmf2F409Meltod856ClN2TyEsVnqowPzBrg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B3RBrlakLTt436OIVQzVwhlJGv0erBYicPVvqq33UQMsr1qIc7nMTfkxXhiO20J/WnLfH5LwDTRhaKemhrJumBuQ06BbMQOYrp0CJrHk2kzSdabvp4S6A6/jLLL1vWrXUMbLbOd3N/9/Kg2CKz3xXqyK+ryOhf6cHIJJp/XXj8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hQfieDPd; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQfieDPd"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4896c22fcbaso12629155e9.0
        for <linux-arch@vger.kernel.org>; Thu, 07 May 2026 13:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778186412; x=1778791212; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X1CnkXYMofkVF0z0P6JiV9z7XyvR/dfwP1bUNpx9s2c=;
        b=hQfieDPdbO4+r+DGHJszVLwwQEgLLvsh6ZSUHkedKB+x1pqRLJUAiRdy84qmxxvRub
         HjpyZWdd/YeuSSLTLDxTMzx1ZoefQXRg87hJwMLEZ/3B348HAOCUoRjSex/fUBs93j6Z
         hbycDhGLi8k80AJNWFIp4ThbDHZqzT63pc8F01taPJjdaVWT7eRXbaz8ifN66cBKwzuP
         avAjs16wFRSK0eAK5sDrf6Vl119/IaNof156YclBiUBtdsFnqdSKWJy9U4JaMgZAnAHI
         841s+gyhfkTuCoWnlB33DrENDjJOM0LIDyvI7Nq+zMkU0bkt4Va3GS7J4boM9OPEz0kA
         u5Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778186412; x=1778791212;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=X1CnkXYMofkVF0z0P6JiV9z7XyvR/dfwP1bUNpx9s2c=;
        b=gj+X8dLgDqMDm/aNgX2XTORiCA9THlBlP1g4oloGOAzW1L4EZ9n/Ya38Ec6Z/C9gSi
         ej/nUVAcwOnBH1IuB7hQtbve7C0XKQYrthZCdzFKlX/sV4gKkJj0rH2NfqinHlVkTDC4
         n6ENPtDlAfcMT8M5MkKIpCVWq5g0rZRkidQP6tJXCq1U4rWEQ7jjxhlC3QMzdmrNKGtF
         gja3iVOZqdvAYVq3M0IPvuahNNiLYuUTKkDrKePHliDCM9HVIhN1DueGqtFRzjgS5XE4
         J8y6WqUnzO8yUK9rh020uYP1bUGIUwh11G7j9YRiAgPm6MUuPjyYwRLFG+ONI1TvYA1Y
         BzPA==
X-Gm-Message-State: AOJu0YxOfa8hxtBC1qf1Cz09zM6UoOnviwYdammQ/LuYA5aEOiv5bgLc
	5HtBTnIU7KhA3Xt3Kkox3NKq9AIRRJ2xLAJzkQvUkOGOqAhCdEsjfgcv
X-Gm-Gg: AeBDievQndU3PDu7TtMWDywodJ5O/MRKCQmcUBC/DyRRRpN9mwUGWaIOIUo8zYz0lcD
	J1JSgesp02LE0BCAInWjn7vL5nX6VOAGGXt9FOr9Da3cxcIN34L/YwJlmxZhim0HKAmAQh5i0fT
	LJW5vUS+5MTzByq/JFCPvhdmia10gPpWOqN/SAEv7b8OzbYJ4qQEgcdS/JeKX+HICN4t12U8Bl3
	sfvc4j8J/Mkqb8FyJhNksvORWxvDLCWJKqcjmBipGVJHzl7G8knn9n8M0elEw8ZJepr3+Jfc2Ww
	sFEQTCDpYRq7dtVgiI0Y1hS6GcmdtS0ejhO2nCN6DP9f+1nyOHNnbiZHERQb9TnKcvgKGSR4tls
	z2zhJ3Pv7rAIYWFEpnNsbn0i5baeaeeFLHtngk+vPAWTqmmjSrit1XUNhyZH4j3b4qszUfpeWQJ
	2i2ahJsAEkLv5oO7ov20g223KKYP4G
X-Received: by 2002:a05:600c:8485:b0:48a:76a3:2b9b with SMTP id 5b1f17b1804b1-48e51f32811mr160047405e9.17.1778186411702;
        Thu, 07 May 2026 13:40:11 -0700 (PDT)
Received: from [100.82.231.29] ([185.57.101.106])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-48e5382a327sm264367515e9.0.2026.05.07.13.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 13:40:11 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Thu, 07 May 2026 14:40:05 -0600
Subject: [PATCH v2 1/5] vmlinux.lds.h: refactor BOUNDED_SECTION_* macros
 into bounded_sections.lds.h
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-asm-generic-1-v2-1-47c52759d268@gmail.com>
References: <20260507-asm-generic-1-v2-0-47c52759d268@gmail.com>
In-Reply-To: <20260507-asm-generic-1-v2-0-47c52759d268@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>, Jason Baron <jbaron@akamai.com>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
 Aaron Tomlin <atomlin@atomlin.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-modules@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778186409; l=3982;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=Kdq5NNBpBmf2F409Meltod856ClN2TyEsVnqowPzBrg=;
 b=Uj4wWShFQLWZ/5Ma1qA7xa/YvM/ZvXLDNQsUAcG/2ldbzAxm0P1oRUXjNlAkvNYqlu1u/vqHt
 VXbqnLFNSEyDVQQ3CAtSuzcayN9LdymdEoQH429YjHj2kg2xBTTTpSE
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
 include/asm-generic/bounded_sections.lds.h | 36 ++++++++++++++++++++++++++++++
 include/asm-generic/vmlinux.lds.h          | 30 +------------------------
 2 files changed, 37 insertions(+), 29 deletions(-)

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
index 60c8c22fd3e4..f78300aea8f6 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -211,35 +211,7 @@
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
+#include <asm-generic/bounded_sections.lds.h>
 
 #ifdef CONFIG_TRACE_BRANCH_PROFILING
 #define LIKELY_PROFILE()						\

-- 
2.54.0

