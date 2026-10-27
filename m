Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793132537;
	b=IFizyEh0SlNj1uc6BCGJsYdfTbZENM0D8pOpNlHNF+ra6X/CXrOgdOr3kHNSZM1lY954
	 vHCW+b1qQEnGZ8jeOOVbC05xyErI8yx9tpUpzEWJh3der9nV69JrFiJM8RYSGvVyK0WP2
	 nVdGMC2DHHj0C6L1lxBS/eovzZ0ZtNwSm68RWoKIxbYLsabqGuhtSE8zPllgE63tV6sBJ
	 cN7J60DHz3E77HaTzjzxP5SF+x9i5Sov0rIOos+As0ttdU8JQkrrv6o8xHF00m/8iJtmy
	 8/zV1a5mL8x8Eyzs7eTB/U2ll3AojG+6oMRXqTmQDbT7fFF2smhbUhdWOMIBrM96TFQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793132537;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=VREWUN8AJAKPAW/PnLTB+3AyrdUA3Tp3MbNPAyF7VCQ=;
	b=c0gztnA7sQ9M+EYfCU9l0Uo/aKFOXETFL1tKBoHqhe0Cdyy/5l9a87WyrWjNkzmjKrt1
	 38TnKJnoCUGheMc6WULKO7eYo3Ag20db9Q2STpCesebRtGvb4gcS/rDpypYRgCSxWoovq
	 RGgFdhTUFVxH18YjDrNEIxuPYfcfqJwYBBauuXAtMlu/OOV1obODWqLJmZVYHURxn7VMn
	 scr4zwCjGa6wB1GjJ4JSe7I981JgVrKqs7iM7F4ptiIqwmyOza7xZCoGa1ZZVDWwxmsEP
	 ALdryJo6tGoZMslHUN59D73bgQY/QSHmwIe8/f6+QBXEKhFw/NySf/dujOHd6YfuSVg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NbJ2Gdtt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9246606A31D;
	Tue, 27 Oct 2026 20:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NbJ2Gdtt
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793132531;
	b=Pa4IBJawAp1KbDVw9780Y4zlob+LaiB3nIB+fUJ9zAHZ3BPjugFbGWVI/HU5p8nMmGu/
	 KW+arMEHuQl77mE5mslf8cFl0k6Ppe8ExBFLVOWmYbQlqSY/YBiPJOrPMZ8DOjiOHPbjF
	 17SJrYY2xre30fDhr8mCrR7lWgSn3dqpAJfu+SV1FCviCdJXjhzINainFEfO9vOdkEpAb
	 LY9I87zKvliGLpL0K1G/Vvic816wv2sIxNJQYXUBtUlJ1SVV3OQNaf4FyMTWinniChxry
	 pkEYbjM1Cxy/xOLRqDY1pWd5OejuFG00S860us9xAcLJ6LePwu+47/rdcS+/Ni/382A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793132531;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=VREWUN8AJAKPAW/PnLTB+3AyrdUA3Tp3MbNPAyF7VCQ=;
	b=ve+9T4sywEgs6x7Zg3/vVL2iqtYyDlU+t1cpnX74vIUnMobGqoIgvC57hAXKrxbSQ22b
	 IldyoAf/16x/RY3tk3Ke5hNZGKTI1fZQ9nB8KfBZUzW+4ORtbbFdRhEkNozXLZnITne7z
	 g/ghLDXP2pClNRIt7pvt5F8pdCB3E5LvUpbyW76hwc7crAbRbTwLzKrcLs1PLC2kURqQc
	 MwBla9Bkk8LgczWRAPKoYE0i1hzulUJ1CzDC3BYmZ4rhPqj8F8Wz7d7/3PdYy/PsFUAMR
	 IoYhbR5fVARso8/oris1nn/IZE1DuaSbrqo1uSBmIPhoPFUcpVTvRBsv5MORGE+4iJg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 319211F031E0;
	Tue, 27 Oct 2026 20:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793132531;
	bh=VREWUN8AJAKPAW/PnLTB+3AyrdUA3Tp3MbNPAyF7VCQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=NbJ2Gdtt+lOeO1ifDsEbtpPS83ECI7A+LgmN9TKOTK7qhqulaa9D0RQh5TD/U15vQ
	 9yDB9BuSIm9S/7WoSls6YiFiLkVYU5JhEjPiYUlJ+qOfxV+tUdhYAUOxMROo4ekd4P
	 n0fb9qmnIWeJCXwAq5rDrPcRCY8vuEos5Fx/+M7SqvYjTWMg5SP+a9uE+XQb6uqkB7
	 qWdwzw11MvgV2rknaALWlPNKvf7mEHS4wEdowklrf40IUFFnaAUlgt+1LuyAI1E4MU
	 OS98PguGIad+NyQPJEFPna1WMSFS7Wy2EfDz3MSeIVpcN9w2SD9sHLGYGubazj6Ccr
	 Wwd5hvMv6mjXA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 9E34A451F9;
	Tue, 27 Oct 2026 20:22:09 +0000 (UTC)
From: Jim Cromie via B4 Relay <devnull+jim.cromie.gmail.com@kernel.org>
Date: Tue, 27 Oct 2026 14:22:02 -0600
Subject: [PATCH v13 02/39] vmlinux.lds.h: refactor BOUNDED_SECTION_* macros
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
Message-Id: <20261027-dd-cmap-part2-clean-v13-2-9267923be612@gmail.com>
References: <20261027-dd-cmap-part2-clean-v13-0-9267923be612@gmail.com>
In-Reply-To: <20261027-dd-cmap-part2-clean-v13-0-9267923be612@gmail.com>
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
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, linux-pm@vger.kernel.org, 
 Jason Baron <jbaron@redhat.com>, Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793132527; l=4249;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=IfyJDb7+5IpRdexBxlsmGvn/hmtnbKQYugc2kC3D/aw=;
 b=KHNS94dyrwfUat3rUowp1hXeRfJ9tQHVm49+4mt1JUQ+Ulw1bpwgpZJfujitxyqWgrTJ3hc8w
 5Efbg3SSImBCMnWdZv+nV2yl8DL4IQcndfox2Jen4LrML51uBm9g+Di
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
index b2988aa12f66..b4ece391f7b1 100644
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
2.56.0


