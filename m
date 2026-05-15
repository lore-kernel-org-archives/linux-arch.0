Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AD6427A0C
	for <linux-arch@vger.kernel.org>; Fri, 15 May 2026 08:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778835513; cv=none; b=e00jalSYd5TdSg6y+lw6MFL+FmtEjcf+7Snw2bZS3fqFBjBsvgBas/9Qu8inEDpEvDX93mpfPUxyK5QxrK5exgnWatiyjRkQjukPb9+EG59kDjBs77ZE4B3qOIv3oD82Eroz4FfBm5LNGFXCeCKEyh9dVhWVApTRkDrBdfNNoFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778835513; c=relaxed/simple;
	bh=NSY+wy4a9um1N1lW6bfsaEQo0J9IZ0qw+K4qR7XW5p0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZWAEohP7gRZjVnHbQZiGjV7nLE0oGCS8f+ip5Adj7Sj61rlzgVR0zH0TxOonCzMomFr6VPY+cBX+1QsFOWKlcRO+fOMKfpnm31uupRfCBoavK/CafUB8Y38/8iNa4jF9uz47myXFDqDkaG/LNTFgqwmXIFZ2N9b87mE0UB9l95Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BGxeZVJO; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BGxeZVJO"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488b0046078so72145315e9.1
        for <linux-arch@vger.kernel.org>; Fri, 15 May 2026 01:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778835510; x=1779440310; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zeHLaAh47MPke7rCXxz6cz21C0/tHZ4OetnIzHSea3A=;
        b=BGxeZVJOst0uJxl7qzwFEi8QmH/rGDuPCV0Kq/WCENjY+DKZaqT6eN1DqQfgICSLbw
         zqXPj1d8PkGDHt7BATKn3y9uCMc9NUcaGdfApF7cQx0Dn90DhmhhnD+GfAbKigbBYS0c
         38+XfDWPwEOuVuKH42Iu0AlHzsjvdSOwQccq2sfEIqKxz3VNm2eNYBN8V1iqlbtGSQpE
         BTvEznOVjL6cebOl8rAnjFlZbCAMNWMHhDl1X0Kv9X473EzJ6qNa7Vh+tPeD0+m/pEQe
         GIgv1DCToN1L2feVvvT1O+e0s7zfBG+59A13Bgt/5gY7H+047c4mhhWBUCVD90itVGBe
         WcfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778835510; x=1779440310;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zeHLaAh47MPke7rCXxz6cz21C0/tHZ4OetnIzHSea3A=;
        b=qnF6UhScSIrQzVb8pW9URdJPqGrSD1mM8tg8OZoi4yE4WuA5QYgKPm1Twdz5pvVtEH
         UBbpx3Fkz8fJnhoE6f0MdvcUbHM0xen81hExFi3xkXYFuiAlzV/pu52qRk+YqNHMW7wj
         2ft906sbZgA3RsVLgsj8+vGCJZbSppaw8Agw+jyEXc+Hc2hLCOK7SDNuSUZg6o/wrd+t
         ASgZTgjTCesuEt6ZxAMXSYGCQDSqB8tyPLfibS1Zjl9Inqu04fBnNvzfflo91rnKdtmj
         lsVDT/dOunevh18a+GGlOiBR4pdQOlnIXna9pCcwj3qTSuZysnayEAB+ZLUvV4NzDPkc
         /8oQ==
X-Gm-Message-State: AOJu0YwLhzV7cX7uewqexBca4o81flFkVHuLVi/cuFA3w3g3ANb++fG6
	eSmy3enOIWD0UHYG08kPErHOTxaeu4ypT/pTyGGjP1XGqWU2fcUXhLfC
X-Gm-Gg: Acq92OEfdO1pudB107mlDBXlN9OXspgwOK3j5QGJJo06NceRNc+Ubue9SRN++r7+ofT
	V0uknebavJsmMVqS03ZVN/MIajU2POcdtjdRH7YfbKtnrDuFaUD9yNZXsd8m81a6CkJKm8sU1ZU
	10V95MkLYVoDNzWyWbdU6SuFlX6bnPrZamErLJilJnV6NOxw9qB2ucaR6umRfniPJNW4Mr6ecth
	mN4vqUxag4IHR+v1ccs1725hRinViwbxefUKAb4ZJ7J2Nw2CC8mOkOdhTudePPqx9ASeKm/xH+e
	K31O8tmlTpEqKGDHPyVvwKVIqc95/YyV2AA1ZqpQGzG/RsPZ7pz/Aw/Ku/xLLqe0sKChU+PQ/Pt
	uIxUpA6UTAVCYKMZqaNAYSowxtFqg9dAKTx1LSig+uRUpkl7+iDWg47QaZAMxoE9emj25Gjs8PP
	xwKzDdBosQtrsFhbAJ0CVQA/T7CGcy7Pzr
X-Received: by 2002:a05:600c:c10b:b0:489:1c2d:211e with SMTP id 5b1f17b1804b1-48fe5fcdedemr32339345e9.5.1778835509725;
        Fri, 15 May 2026 01:58:29 -0700 (PDT)
Received: from [192.168.1.210] ([2a00:23c8:33b9:3b01:f7b1:b7a0:6254:c325])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-45d9e768c4fsm13142610f8f.8.2026.05.15.01.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 01:58:28 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Fri, 15 May 2026 02:58:13 -0600
Subject: [PATCH v3 4/5] vmlinux.lds.h: remove redundant ALIGN(8) directives
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-asm-generic-1-v3-4-680b273666d4@gmail.com>
References: <20260515-asm-generic-1-v3-0-680b273666d4@gmail.com>
In-Reply-To: <20260515-asm-generic-1-v3-0-680b273666d4@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>, Jason Baron <jbaron@akamai.com>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
 Aaron Tomlin <atomlin@atomlin.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-modules@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778835503; l=3579;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=NSY+wy4a9um1N1lW6bfsaEQo0J9IZ0qw+K4qR7XW5p0=;
 b=T5nINbZ1a7L72QdYwZrsP6UKr71Z+kVDeZOQlclBvGfVo2BEfioYXOO1wowxHm0J00KlJeTCO
 s4nXq6z3FrEBomuKcdWxLSPamCzWMamz+PX2PlbmxwS0deHZAyYWUQv
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

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
index 6892cbec0554..9fa11baf27d3 100644
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
@@ -946,12 +935,10 @@
 
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
2.54.0

