Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795483848;
	b=i9UC7AtpfDx7LbrQwPcTFqFD/EVnTaZe+BbhAiJ0UJ8UScF73fn7qnrPJr0p1ff+z72H
	 yoLhuGSQeLc9dfQSoD7qZp6bI076oTI0J+KS6ZYXSp3CgHWr329f7/Brw2j9Uj1AqQv5T
	 ZRy/NixKnoALOxRivX4pRO9U9ykbLzFZW/sEOxDuVpYZaoTjrjXZpE6aCn/NYlc+OyedU
	 i6awOdzDEjgcZ9ueudQnwb4Emr9oU4d96kNzZzYurCiIXgJnA41AQuilh9MOJD71WmNAO
	 yqUQdyWr680imrRr3+h91a50lcvQ3ZwQT0bFpsHNquADFLUSgyDG8TtXzTU9BYHClUQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795483848;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=mUGfQiVZ+zg8GAAgUHGBxixYTFVuLvFKD86QKEROTKU=;
	b=oD9mnw2RAeouwudADXjJQQKMi7daHqC0DKsV8pLbx8+8lcOQKe3QSJYSFB4AJwufgJoG
	 6x5dcCw65PyZGpYcE9u/oC/8EW8tvV+YF00cef/rr3crnSRWfawxdgt+Z+Lorp8/63TVY
	 tF7d9wRPT7v4ciV0iJGx0xl8CSukR54yDIOACjZkRKmo44mAMScIC7tpQvZsUmDB4n3L+
	 A8WyurIn6qiFYHVzFeOmsvdaIaJbrflcReuOdup7qfM9kTtd0WGy+ShyQwSB8CRZ/p86d
	 aKKLPw169ZQFZC4SmRARpFj3ZFMvxgx/2BOocMSvMMOY8WDSjlTVBYArxsonR4nBEtA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GE4UNFZ4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E17606A330;
	Tue, 24 Nov 2026 01:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GE4UNFZ4
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795483847;
	b=pg/3aeINdAyaOLbbMRRQ9od31jUPjnr7IOpxDMJ2ZvXKwnuxQHpW66hxd1ZuB9eu63Kd
	 GFcZQWkigJqDmRtCvQBMXkH1RSDgApe4jgyRJH+DIZqjD2j7oolYnXAwBFrugbZXwuisi
	 4igKQ+XrS9EQXe8/mOrwAZI0ueDmoHJuul3lkjdj3tdh/IerMigU8yO/yYevzKvYVNHpU
	 B3ZUJgKDW+F9FIX+E3Qq1BKjv+seQ1IbZWZXSKsrD6122uUvZRfI5GlFJ3aFLaAz2v7uw
	 rOjPditnSJKp/d60So2KyJ3be/qYUi19AzAYyXNff++57CMxhedKiVHUYmb/CKxe5vA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795483847;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=mUGfQiVZ+zg8GAAgUHGBxixYTFVuLvFKD86QKEROTKU=;
	b=uLmAsEKWVmADxHC6Ct9GQrWk+APSbqp6XSwfh4NgRLqNEnDlpmQDiJStgejQP4zCpla8
	 07gqSFzzZZM5Uzj7b/i6RS7NFfjTzcBAXEEho3aFGzt5TBnJvdUMHPIKBzEqRWmklgBn/
	 ZpK5DHYgydxv7EStK4m0FEWT3XsEqxHU7WAr2bZmvqB++L6LZi/45OHOBYRikH2DseInC
	 Xs6EPrabc5J0od/MY/QieG89WI5ehcxDI1ndYFbp8xBoS6+fDvGMTOMZkcWgzCev4tsNo
	 3q+EF3u+g6Wag+0An4JzI68lSkrrBIR1wvTZxSk8nOhWEI8K6TYnH1CEGLyZT39eYOw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 095361F000D1;
	Tue, 24 Nov 2026 01:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795483847;
	bh=mUGfQiVZ+zg8GAAgUHGBxixYTFVuLvFKD86QKEROTKU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=GE4UNFZ4adl31UJUzioJj4SvyjyGtNRnQpCDpkR7ogNm9PNATWwKX7YFlQ2TxOUYt
	 MW7s96H4QnXZEzN8Qltz0R3qf+8/G56wUAmyBEeg6H9ro9+jWeAZiwaFKshDhrAwSS
	 +PPyR7nFrBhjzVZwoIM7hMc0vOyxTiOnuhByRQu+cvZtOws3uPfARREWOuzh9J4svn
	 JA0yfFDoR2B+KKWuRT3CwCLNgjNOHPzs4l1X5ObuHksVl5oPBD50a0SUz+mDsOxElV
	 M9gZrwiYMENikOU500aDVTh9moCKsV4+i25f8835i2LUXJBnw4XXv3lbkStNeGGoSF
	 NCTFWwCQLP7ZQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 869D74C81E;
	Tue, 24 Nov 2026 01:30:35 +0000 (UTC)
From: Jim Cromie via B4 Relay <devnull+jim.cromie.gmail.com@kernel.org>
Date: Mon, 23 Nov 2026 18:30:34 -0700
Subject: [PATCH v2 2/6] vmlinux.lds.h: refactor BOUNDED_SECTION_* macros
 into bounded_sections.lds.h
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
Message-Id: <20261123-vmlinux-lds-v2-2-6f608abfa042@gmail.com>
References: <20261123-vmlinux-lds-v2-0-6f608abfa042@gmail.com>
In-Reply-To: <20261123-vmlinux-lds-v2-0-6f608abfa042@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>, Jason Baron <jbaron@akamai.com>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
 Aaron Tomlin <atomlin@atomlin.com>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795483834; l=2985;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=P5CfdAC3ZtSJbUfhQIdZLIJk4LVUFBkSXUbGgsyz4Qw=;
 b=xfA/ZUYslcx9/fhkFTjT6aDdbfXt5QY7Dpc5AL73c3FZVXjU+3KCh4naiXvdEKLfRAJfXlURJ
 f6QJA18cBTHCDSQTDlz3pQC0u6C/eMgiy4DNyWAE7Y/3AqgNIkqXn65
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=
X-Endpoint-Received: by B4 Relay for jim.cromie@gmail.com/20260203 with
 auth_id=958
X-Original-From: Jim Cromie <jim.cromie@gmail.com>
Reply-To: jim.cromie@gmail.com
Content-Transfer-Encoding: 7bit

From: Jim Cromie <jim.cromie@gmail.com>

Move BOUNDED_SECTION_* macros to a new helper file:
include/asm-generic/bounded_sections.lds.h and include it back into
vmlinux.lds.h.  This allows its reuse later to fix a failure to keep
dyndbg sections in some circumstances.

NOTES:

These macros are only for use in vmlinux.lds.h, where the _start &
_end symbols are needed.  Modules keep sections separate in ELF
sections, with their boundaries known, so the _start and _end are not
useful, and may confuse tools not expecting them.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
This patch ignores a checkpatch warning, because the new file is
covered by "GENERIC INCLUDE/ASM HEADER FILES" in MAINTAINERS.
---
 include/asm-generic/bounded_sections.lds.h | 21 +++++++++++++++++++++
 include/asm-generic/vmlinux.lds.h          | 16 +---------------
 2 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/include/asm-generic/bounded_sections.lds.h b/include/asm-generic/bounded_sections.lds.h
new file mode 100644
index 000000000000..268cdc34389b
--- /dev/null
+++ b/include/asm-generic/bounded_sections.lds.h
@@ -0,0 +1,21 @@
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
+#endif /* _ASM_GENERIC_BOUNDED_SECTIONS_H */
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 67aa59f67442..5fed4194983c 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -50,6 +50,7 @@
  *               [__nosave_begin, __nosave_end] for the nosave data
  */
 
+#include <asm-generic/bounded_sections.lds.h>
 #include <asm-generic/codetag.lds.h>
 
 #ifndef LOAD_OFFSET
@@ -211,21 +212,6 @@
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
 #ifdef CONFIG_TRACE_BRANCH_PROFILING
 #define LIKELY_PROFILE()						\
 	BOUNDED_SECTION_BY(_ftrace_annotated_branch, _annotated_branch_profile)

-- 
2.56.1


