Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795301379;
	b=dsWoOLjTwij7S5p9x0LPn3vgbAi2SldOQJFGy5idU7Nc/QZ4BeI7OF+oMUSiOczlkX14
	 fz5s16I5puZ0SDUUF7Q9mjELFtBn12OchgpdXXsxJfEU+ncaI/ibSFr423Nr3Z6pAA4db
	 sveMGlBMTcAqfCLOzQvQvYzGJxbDXV0WTdhZ4GaIMCobdIfMPTBBA8m0AbQ7DGE7C2A+F
	 FDXr6Gol9GVVG8AjssMxgvnp8ND55SMDdEOSl3xmxMjRDkBzazEF4pOQKuli81RgAsASb
	 SCZ4r9uENIr9NG2FLdjjPgdOA/Zqj3ZP20T1NB/ILhu6JFCBGvb2CNXrJQa/yeFZoxw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795301379;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=pHvKmumx2Ed0BG6w1Bq5YISlwOugJcfwFVdApwnQ3to=;
	b=ckpJX3UEnLHil0S585HRnskfu3ufUuL6+Y32dT8Dc3IoUAz+a/zpWkFUeeV+QHZJDhbD
	 HiQA2UfNgOhgfRljbRD0nL4c2LGdfI/7Q4uw1nMloZt3MxVRI0OWUJAXlPBeUBkBI5mej
	 WcuiqYSlYZkaARvvAqSFJU1fEFAakYh4ddXUCBAWme1WwRqnBYtUj0h2FljMeTX79lLjN
	 rXlm8v2Lqf1jhPQr8tN+yKapiBc/NyZUkm6T2Sik3XzT2U0ORjZ5tQfkoY3/MJRVnATRw
	 RGTh0Yk7naGozbxrvlEGZ9g2ay4vZypgEKHIBCWG2PtUX+N0WZywtVJjyaE7i2bN7KQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XQncDsDy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFF7606A68A;
	Sat, 21 Nov 2026 22:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XQncDsDy
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795301379;
	b=Mi4i1v99psbnULE8oIOyuu8SZckwBAwc+ZTBXNXzU4RVP9eGrtSK/lNkgAMmqxUshlcT
	 BgTkd7gaMpv25XLZhX5t1PP1D2pA0YFY5Jjib7PrjgnAdLNh9LnpV20TItUs5XM0yxlih
	 8LC2B1+Suhh0UQ41JL4d2L6OslPWRha2fahpIkMM/F61mxhIvsV5EFhgBCMLTTJu20ULn
	 NuIejg6wDLWn26WTMboENMAIu+eL4uFAkLV0bjbIeVEW2+LOJ+Q/gWQ29GkddJAHpZ/Mc
	 Wv6cY1Rv8vk8xYaaYD8f2JI9vNH+iObwYKa1F1c30a/CzgeaeifW6DkuJilFY2oZ86g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795301379;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=pHvKmumx2Ed0BG6w1Bq5YISlwOugJcfwFVdApwnQ3to=;
	b=e0IML5ffNADA/izS7UUxFTGA5afAJjuDzEi8r9JzjkD89Ih4U3bfkkhdNjVy4T0g2UFl
	 D3SMhjJsmpICiUBUlzJL80o76EJ+3Bm20vVhkHmp5fpLB3BOekHVoaF2Gq4bIhDVc3Uem
	 6V3M1botl13w4tdGUgumZgfPlnoWjSI1Smt3QitD9aQ6mQZ70uj+52ZPmD9bam7pOs2QM
	 N2DGgvEdqBbXAg+H3J12ahcfMSGfoQAYtypvq4XvZaOOA/fKIx5uYXeTsMANQl/WcIx0e
	 z9drD9Yzxkl9an6xOzfwpybUiU+pGACv1e3yLcheNeTranvzm9Jkia2ZHUJeMpXZRfg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 0E5771F000C4;
	Sat, 21 Nov 2026 22:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795301379;
	bh=pHvKmumx2Ed0BG6w1Bq5YISlwOugJcfwFVdApwnQ3to=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=XQncDsDyos9KyYQdCy7ZZedYoxhmg3VVpl/Qm2EeI1BgXgX9tcwgaY2vuZMh/xuDG
	 2/A3NeMVaxi+facrIYKHmiASh6F1pnqtYatPja+ATXia4YhOzfa/e2hhVnK03W2TPd
	 7//r83YgAE7tjJ61d3tlF40tvCkm8JQHjlyrqE//cnKCbFBvS2vCs08p9/mYqVwhXd
	 OMpEs1Phlc+075o2xLCw9qFiPimfYBjZ9oAZ3OMdMVsyGvUS4+FIJoiYWquTNZc5WG
	 U9jQPhFlwdzJqmrXGnUlyrljqrmjOUuz/ZBPmfmRq3WTyF6OTqydoKWlr+jq5X1ILp
	 HsVaYiqXDVMDw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 871AC4BE52;
	Sat, 21 Nov 2026 22:49:36 +0000 (UTC)
From: Jim Cromie via B4 Relay <devnull+jim.cromie.gmail.com@kernel.org>
Date: Sat, 21 Nov 2026 15:49:19 -0700
Subject: [PATCH 1/6] vmlinux.lds.h: refactor BOUNDED_SECTION_* macros into
 bounded_sections.lds.h
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
Message-Id: <20261121-vmlinux-lds-v1-1-49818f3f5cc0@gmail.com>
References: <20261121-vmlinux-lds-v1-0-49818f3f5cc0@gmail.com>
In-Reply-To: <20261121-vmlinux-lds-v1-0-49818f3f5cc0@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>, Jason Baron <jbaron@akamai.com>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
 Aaron Tomlin <atomlin@atomlin.com>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795301375; l=4249;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=QfwV+7B9vW313W0NIzlE0FrPMVDG/3xJRQVA8/rQh7Y=;
 b=oLQ+RzrEt0IqT4TGsfBORZ3T52lAR2ndF00hCsv5QFp+agJcJg/Vf9yXhMoBMKv1wtFnObUOU
 Fw3gA9gr91vArCpHc26wI72f/SesPbgBmRMnyxYeOz/dLQTJ5Bk6PhT
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
index 3eb732942d69..5fed4194983c 100644
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
2.56.1


