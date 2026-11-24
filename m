Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795483842;
	b=2Y9pJFoSEa1AuBsXsQ4yt5QhydoZYcDGhn+HOtPTOC+b3glqjI0T2YFhvMJNW88VUuva
	 XVg/DliannG0vxZobVidXzYAnQQ/s6N+r4UeL+IWDlPUFI2wKG8BMlG6FJcuauUPnzDnt
	 2kgloeIpNDUyBa410h+KEEsBOrQIYF6Cx68iIgY6dJucZrpVcULZh8/o4HwRKGEzQBBVT
	 AL7MErLDuYaQpLJWOca14yEzyfd1xI4QnhTQjPB0Ut2GgisbK1z8vFwaH6bwbpp+OJwT9
	 iZFrnzj2gfCLXETLMyqJ7aPmC2nrPBcTFf4L3H518711K0jjPxcgHYVTJci1O+iqSog==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795483842;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=7cngz0iEHgI6gQiX1ez4K6v9rnp0unpcpd7/w6NVgOs=;
	b=Aniq3Q2mSd/b+a4M3HMhztM3DSnGi5KxCLGx9ILO5NfILgWwWLQHBLlEBgrAXT62xqfF
	 zF6+2ssLktszYu/y9116SgijZoMK95u/MA2JWiT0bK9vHA6qis9+eFPrs8LUfZcIgnN0b
	 GjUPkf1VKvS/LxnXDHgEijOZOM2uzIrQvOvx/CYaFV5rqzUucpLu5F/yUNjtVpNnMnaYC
	 mXjiYhSEtT2lIVv/j1YBAcuukssumf7pUnICZwgF48c7XoTDREPHQ7qLqkmsHVHd92Pe/
	 VFs4F7Cob3rvHFe83KcAEWfneq1Hd4r/f/HYawlStIiTZWCZov4Zt9gwQYNx2hI2YuQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iYZF4HuP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD944606A321;
	Tue, 24 Nov 2026 01:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iYZF4HuP
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795483842;
	b=Drool2AtB6aC7+jkISamLvOBYwMn7OKAeKmiHV13/4zrOBOdq9RPgo+F+Hm8VLGMs3aL
	 3M6pudrRquSsVl3fne5xJXULBxKAAgQ0npzGdMMsKNH00m/gbq1NvDdCKPO9h82iEfvxf
	 fA/v6/nMXEiVlDEZbMNJTyY9sK3pEp4o/l1H2v3COfbmn2++52UWqT66jQFvRRuVFtbzQ
	 MJelFjpDq5YwLg86V74qVfisQ1tGo9a3CMziZ3MXFUoMUOyB3t4/twJzpFwQZMkT5oYnn
	 0L+lfJczYk2gYpezNXkObXMpEKVLtpAE5AQO2MrLU2weEyWoYpLVWzrLyir0U0+5cyQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795483842;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=7cngz0iEHgI6gQiX1ez4K6v9rnp0unpcpd7/w6NVgOs=;
	b=vOLEMp0fApFznJ5iDZP2S5+Y146v/E/lvF4JmfdI4GBUo7uhYhBeQSPIlIiYfRWFOoKj
	 WiMlnblTCKj6+DJXc3+WqzJpBQaez5TfWxWjA/IALICWIYXoUniBkJ31LdLstjk1AsAXB
	 s2aCtlwth91MLBfceNz3igCQWPHkkFTpyKXSMsXiy699ZnuC2mw6YzHxVag8yQwmFzdZS
	 JzRHItj/IPmUhfqmFIHJf7qtLYWo5nEZX39pKwE8OLbf+MFfZ6f0ZWMjbYXV1Mk716mQQ
	 xP8Rj12yYl77JcSZxvht4VeEGzBpDZKjIGXnrClowuu9u1IO8hQxFe1lKUTANbeOlcw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 442E71F000D3;
	Tue, 24 Nov 2026 01:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795483842;
	bh=7cngz0iEHgI6gQiX1ez4K6v9rnp0unpcpd7/w6NVgOs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=iYZF4HuPPE7vepBmITfT729pDpYfBVKyQWcq/vwalyQUYORlOTS8Ht6caJbhpWEeJ
	 EypyElCm3sButKR7Ak8L+ur/FxMrze3cr1K0gQnkCZq33oOcdNBZeNzQL1iTBNvuZo
	 svlLxSd5MtywScPkvQc4Wh51O6y7Bmp4QkCypbwuos1qt2JFRpeUg2JXKcguJv7spn
	 0zCD0bwhgvajBwUeJJ+k5Hg82dEFEnaulZrxXhOu2XWlBri+JtFeuiWIUKTK4DkKgn
	 mMxrJKKa6rbbLWtSfNqiu58uiuT5+BFeu1TlpnEkdSBLApggXdHtZW7WJVOUMyOvgK
	 91vCWzZ8g7rjg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id C106F4C826;
	Tue, 24 Nov 2026 01:30:35 +0000 (UTC)
From: Jim Cromie via B4 Relay <devnull+jim.cromie.gmail.com@kernel.org>
Date: Mon, 23 Nov 2026 18:30:36 -0700
Subject: [PATCH v2 4/6] vmlinux.lds.h: remove redundant ALIGN(8) directives
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
Message-Id: <20261123-vmlinux-lds-v2-4-6f608abfa042@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795483834; l=3552;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=AbNPzUOKSNUfbPrWq45iSvFLEDHNnQt1W+xFgom14Lg=;
 b=9ugZp9aCiw0Ezm7UkePh7BZKKMhaTc+gBAYkrB4+UJH7JxGHPtqTqI3rqPeygKSYuoNr5luqJ
 R6gkL5urcLPAs2A+bJlpkXKgS45i5ZmhXLx4GaquvNgALUNP1hPNvwq
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=
X-Endpoint-Received: by B4 Relay for jim.cromie@gmail.com/20260203 with
 auth_id=958
X-Original-From: Jim Cromie <jim.cromie@gmail.com>
Reply-To: jim.cromie@gmail.com
Content-Transfer-Encoding: 7bit

From: Jim Cromie <jim.cromie@gmail.com>

The BOUNDED_SECTION_PRE_LABEL and BOUNDED_SECTION_POST_LABEL macros
now enforce 8-byte alignment directly.  This makes the explicit
'. = ALIGN(8);' statements preceding naked macro calls in
vmlinux.lds.h redundant.

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


