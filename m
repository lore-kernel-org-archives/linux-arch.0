Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919755328A8;
	Wed, 16 Sep 2026 15:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789572783; cv=none; b=ezTq5ptwpqh9pE9wbkb7KsJxU0pEqIQDZJwo5Nb2mCvn3WtqZuLuRp1p2qW8i69XqM8deAFKOlA1FHkvyesTtipHx9eitnaO5b19y1Zjd7gRJnovtk0Id7zY/Bhww7lUCGATnjzcKK6/5hQHB6yL//S4jxpSpR7BS5fa1UFvfH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789572783; c=relaxed/simple;
	bh=wg1tGDYh1lFd6dygIw9mLBo0c7CqBzrzb1ytYq9rmVQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AEjlXKSTyMyE8lYnRyoqYdMH2LYTBSptoV3qrTaF8lfY4lz+rSsn0avet3tx/iMcr7g5uNxPh+Uklhakn2zhKGy3BA783CIfQvp2YN8ecbgo2HrREvGJf01QQnI3LFCuOs8XBUoB+Y1z3a1FlHsci8XzcYR7W3B26Q5K4vmZsAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O2oNXmyO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O2oNXmyO"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0A088C2BCF5;
	Wed, 16 Sep 2026 15:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789572780;
	bh=wg1tGDYh1lFd6dygIw9mLBo0c7CqBzrzb1ytYq9rmVQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=O2oNXmyO7AgVKih2W/8bQhDf6/KEBtAZqEBjh8PTousbBSEBY3xwOAZDehPSa5GLv
	 pKniX+dxftgd7reWYw3A5iP8wQ0S2Twrm1sLHBFwvHn7TJKB0a4adDnwtAM4oX+RLH
	 bZv6B6exaBQiTsYHBKfSefvkefd1YnHBTOCwk2cCNOiz4Ss0W8pIiJsiuZuSOVlax7
	 J1O1RptWYzwnmlHqusPeAWUaJu6idEt02bDp06J/yBwMhTJ/On+Vg9v07xJMJQlNa2
	 cm1DlPedWKGH40JaAdkXWqtAnaOWh84B/5F7F5OdlTcT+biywXvtKx02rFrrrZ9nWg
	 7n3gg3A3qJ/qQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E51A1C982CA;
	Wed, 16 Sep 2026 15:32:59 +0000 (UTC)
From: Jim Cromie via B4 Relay <devnull+jim.cromie.gmail.com@kernel.org>
Date: Wed, 16 Sep 2026 09:32:57 -0600
Subject: [PATCH v10 05/38] vmlinux.lds.h: remove redundant ALIGN(8)
 directives
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-dd-cmap-part2-clean-v10-5-af4cf4767707@gmail.com>
References: <20260916-dd-cmap-part2-clean-v10-0-af4cf4767707@gmail.com>
In-Reply-To: <20260916-dd-cmap-part2-clean-v10-0-af4cf4767707@gmail.com>
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
 Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, linux-pm@vger.kernel.org, 
 Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789572777; l=3579;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=2FyYghk7+WtWximUwhZ9mLDdeXsyVuRl38mPARiNKV4=;
 b=bmMy2PhErUVFRXT3J+x7MDtjV47r4eAX6sDDZo2fbpfTBBM8bYhVXTrmk88zERdc4FaHw1k41
 6HnYMOF8BNmD+Ks2ii6D7Ntb7ktjOPXWMIzabcTZrwprDUDL4LhwmvE
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=
X-Endpoint-Received: by B4 Relay for jim.cromie@gmail.com/20260203 with
 auth_id=958
X-Original-From: Jim Cromie <jim.cromie@gmail.com>
Reply-To: jim.cromie@gmail.com

From: Jim Cromie <jim.cromie@gmail.com>

The BOUNDED_SECTION_PRE_LABEL and BOUNDED_SECTION_POST_LABEL macros
were recently updated to inherently enforce an 8-byte alignment. This
makes the explicit '. = ALIGN(8);' statements preceding 'naked' macro
calls in vmlinux.lds.h redundant.

Remove these redundant alignment directives to clean up the file and
clarify that the macros handle their own alignment padding.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/asm-generic/vmlinux.lds.h | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index b1a69f8af6d2..c3376665d027 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -228,7 +228,6 @@
 
 #ifdef CONFIG_KPROBES
 #define KPROBE_BLACKLIST()				\
-	. = ALIGN(8);					\
 	BOUNDED_SECTION(_kprobe_blacklist)
 #else
 #define KPROBE_BLACKLIST()
@@ -244,7 +243,6 @@
 
 #ifdef CONFIG_EVENT_TRACING
 #define FTRACE_EVENTS()							\
-	. = ALIGN(8);							\
 	BOUNDED_SECTION(_ftrace_events)					\
 	BOUNDED_SECTION_BY(_ftrace_eval_map, _ftrace_eval_maps)
 #else
@@ -261,7 +259,6 @@
 
 #ifdef CONFIG_FTRACE_SYSCALLS
 #define TRACE_SYSCALLS()			\
-	. = ALIGN(8);				\
 	BOUNDED_SECTION_BY(__syscalls_metadata, _syscalls_metadata)
 #else
 #define TRACE_SYSCALLS()
@@ -276,7 +273,6 @@
 
 #ifdef CONFIG_SERIAL_EARLYCON
 #define EARLYCON_TABLE()						\
-	. = ALIGN(8);							\
 	BOUNDED_SECTION_POST_LABEL(__earlycon_table, __earlycon_table, , _end)
 #else
 #define EARLYCON_TABLE()
@@ -284,11 +280,9 @@
 
 #ifdef CONFIG_SECURITY
 #define LSM_TABLE()					\
-	. = ALIGN(8);					\
 	BOUNDED_SECTION_PRE_LABEL(.lsm_info.init, _lsm_info, __start, __end)
 
 #define EARLY_LSM_TABLE()						\
-	. = ALIGN(8);							\
 	BOUNDED_SECTION_PRE_LABEL(.early_lsm_info.init, _early_lsm_info, __start, __end)
 #else
 #define LSM_TABLE()
@@ -314,7 +308,6 @@
 
 #ifdef CONFIG_ACPI
 #define ACPI_PROBE_TABLE(name)						\
-	. = ALIGN(8);							\
 	BOUNDED_SECTION_POST_LABEL(__##name##_acpi_probe_table,		\
 				   __##name##_acpi_probe_table,, _end)
 #else
@@ -323,7 +316,6 @@
 
 #ifdef CONFIG_THERMAL
 #define THERMAL_TABLE(name)						\
-	. = ALIGN(8);							\
 	BOUNDED_SECTION_POST_LABEL(__##name##_thermal_table,		\
 				   __##name##_thermal_table,, _end)
 #else
@@ -403,12 +395,10 @@
 	__end_init_stack = .;
 
 #define JUMP_TABLE_DATA							\
-	. = ALIGN(8);							\
 	BOUNDED_SECTION_BY(__jump_table, ___jump_table)
 
 #ifdef CONFIG_HAVE_STATIC_CALL_INLINE
 #define STATIC_CALL_DATA						\
-	. = ALIGN(8);							\
 	BOUNDED_SECTION_BY(.static_call_sites, _static_call_sites)	\
 	BOUNDED_SECTION_BY(.static_call_tramp_key, _static_call_tramp_key)
 #else
@@ -453,7 +443,6 @@
 		*(.rodata) *(.rodata.*) *(.data.rel.ro*)		\
 		SCHED_DATA						\
 		RO_AFTER_INIT_DATA	/* Read only after init */	\
-		. = ALIGN(8);						\
 		BOUNDED_SECTION_BY(__tracepoints_ptrs, ___tracepoints_ptrs) \
 		*(__tracepoints_strings)/* Tracepoints: strings */	\
 	}								\
@@ -958,12 +947,10 @@
 
 /* Alignment must be consistent with (kunit_suite *) in include/kunit/test.h */
 #define KUNIT_TABLE()							\
-		. = ALIGN(8);						\
 		BOUNDED_SECTION_POST_LABEL(.kunit_test_suites, __kunit_suites, _start, _end)
 
 /* Alignment must be consistent with (kunit_suite *) in include/kunit/test.h */
 #define KUNIT_INIT_TABLE()						\
-		. = ALIGN(8);						\
 		BOUNDED_SECTION_POST_LABEL(.kunit_init_test_suites, \
 				__kunit_init_suites, _start, _end)
 

-- 
2.55.0


