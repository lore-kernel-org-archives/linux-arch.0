Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795301379;
	b=WBT8i4uQNA0Kr9LunIb32x3UBc0CHjuoLMvFyzdzX3q1KY9wk83ohaydowlkFEvsBs4J
	 cvgVmUuvQux3E0RF6DFHuAU9EiBoMBoVjLw/9HUrE/ACrvzeBU1JoEvxnIa9Nefu7K+6/
	 fBXuxHQNsCd1rXLAr/D+qOWy8Nea3HsNgJ8CXnusZAq51RQukVcUI0hs4dssPbGWHwj6j
	 YQQwotpaMr25hK74J2EY4UDzY4ZnYKKTDo25SsXT7Zjwy/tPxb78KO340BvGPUODQaF/P
	 slma1fNsjzQbEGbF0U1USwarkLUKH5nnZJxJunykSxwm3zyZhqS/9ihT7CzYCrzu9Xg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795301379;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=uqv4XjV88HPVChZGFcN8mxBmgf4cgX5V2lhIBW54M2Y=;
	b=Vy3v4NAGV+KJFoKSWeTsdyo/UfWEZacuxr28wjzQV/9Mxif4yKD4D21o0XB95NrhgdSy
	 C0KYBDR1Z1TjmYIDhUgTSUeahWmuS7OWjRjAOl1CSYK2IRWXLXvkpm417BwAoyqQ6x0+5
	 rttA0Ov5T1ZbYzYhU5UXZrP6yzvi6tXQsEKDR/z1Lt/LRCscJq8gZzpdiHj2mR+DUFSb3
	 VWFcAjkBqv/aWHeVGBB6vC8DvSYWF6xMExOFyJ/JJC3F6OsTuq61uopp+G3L6cDYFFlM8
	 0t9BPjs3vx3Zf5dTSlYByXAaZ+ak1oXbDBr6xDT/weC8sKXZV2dXvPjbc6vc5uO3riw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="SKYCv/x4";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90478606A68F;
	Sat, 21 Nov 2026 22:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SKYCv/x4
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795301379;
	b=qK/2YJvTC7r+I927DHTt6dCy9CJ9bzs4rV05ZtlSqCBmGrfUgMCGlBwbBPSU2cGQgu2/
	 +eSyNnX2XX7cKacGrDJnGVOgm1AG8SiIIblTKaxQZgfFG8m4/l0EDRWqINvkQ27QyNJ4t
	 JVLpLUbwbxEMGx/W2BfIsI+6SSvQaOiNYSN0Mqwi7uC6fKZVykB9t7I3kgot4t/CCE7E4
	 ugClJxQ3wPbOlofI8cPlo5QztqPmtfHjJ2X2O19Gr9EX6WdzxDq9OZB/mHUqWNl5ILLtU
	 SMlXrRgvgPMFTFkLi1Qt/KjYSP0v1FgCBmhdnirdLkzhZn2OwaKmKFmPRbESQUJ2btQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795301379;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=uqv4XjV88HPVChZGFcN8mxBmgf4cgX5V2lhIBW54M2Y=;
	b=VFTC5NCI1yIm5RhRgrWH1bjbuvH7M2+/9q1EFMdzBnyw8JgjYb0BPqSJkBNJQwo1pShk
	 v2cxJbTzR72cuvde4KghtS/1ubya+7ZV+ZwAaU+iLomz/QdfMwnGVKigJlkl4HRRYPsMR
	 gz1c0/RBfVVUiyxIajAwK8/NpDVPMgjNOVpjZ8Xgqc9WjoIwLBhpDfbuIBGCalMnaTIEF
	 EVf0ZfcSveEPP0BWXyR48TFT4wd7joMcSKN555/a43IKlnJ5Fhr8emr1rqCL9E8K/e4rE
	 gZ/jrF3l3LakXXWwB+X1b6gnVW8RKspmMRAzJb2XmcUFS2cAubmH2uWw9d9FEdUPwEg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 565571F000D1;
	Sat, 21 Nov 2026 22:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795301379;
	bh=uqv4XjV88HPVChZGFcN8mxBmgf4cgX5V2lhIBW54M2Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=SKYCv/x42O+nT/6iZnT8NUAtCHFfwF4q1skL1UN3z7OP9j+AsJZ75Y8CuQRp75tPH
	 1E7jy5Lv7oJ05C4Ha0xqhEwbSVHIW6gsVKG0YiCiXJazph9ikgA1/9XlPz/dYpgGjo
	 V8M0uOHAXutKNZKJbn1F1GePPGDQ4jFwp5OopWJUNjd0w5FSjqouqj84F+kdx2lqVw
	 vbQb6G7KsmAvTw4D9fs2Xb1jjG6B6NAw2n0MOHnJOoS0AHAqX09+DEfJ3Tj8ClVhhq
	 U3v0nK2GrJXN8IAjJjsKV4P6PAzb0hjE2uvHPjabrMfenoiTw+w1jd0iTIGVlPt6Ev
	 zqQ1nJCZd/SHQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D8EB94BE5F;
	Sat, 21 Nov 2026 22:49:36 +0000 (UTC)
From: Jim Cromie via B4 Relay <devnull+jim.cromie.gmail.com@kernel.org>
Date: Sat, 21 Nov 2026 15:49:22 -0700
Subject: [PATCH 4/6] vmlinux.lds.h: remove redundant ALIGN(8) directives
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
Message-Id: <20261121-vmlinux-lds-v1-4-49818f3f5cc0@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795301375; l=3579;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=UWBsnPOKwEU86EF/7fgNh8+symPCuK2eZOcJxfRgLYY=;
 b=AOMDbzuug3CzJQNYnuVFHGSpbxkFu0YpomfJCOVSrE7QnZHOL85QAfkAwJDgtkocupTfy/Piq
 AQJCK/c1cu9CfUonuKqWzceIkr59BgNPwZCRSibpB3cy4FxtVjObrb5
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=
X-Endpoint-Received: by B4 Relay for jim.cromie@gmail.com/20260203 with
 auth_id=958
X-Original-From: Jim Cromie <jim.cromie@gmail.com>
Reply-To: jim.cromie@gmail.com
Content-Transfer-Encoding: 7bit

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
index c570495d8de5..20c49684d89d 100644
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
@@ -989,12 +978,10 @@
 
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
2.56.1


