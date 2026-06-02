Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CC93CA49C
	for <linux-arch@vger.kernel.org>; Tue,  2 Jun 2026 22:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780440513; cv=none; b=YVHM8IBDBMqZx7nyJHTlHjBjlB7ylylkznYVBIyZkkaStsxmTTDXInVp+SE/0PpA8H0Dz0r0F0YZXNQ35b+YRk4R1L4filaMMPb58XNxZBA5qlK+TrvE4syGDgzwIWeaC60QMsfIzWEGDnUy8gcAelVyO/DznYjqGgVeCymvaWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780440513; c=relaxed/simple;
	bh=+UeoPcUgk4vgSL6bIOBGSbmEMWJGj+kcMG3jKhNS13E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CesTZ+8GsnRPSheWVQK6UeA6niXK0I0iW/nwdjCjww9tvOlmULd6uOuCEuLSsmXb9wceBtIa1ZRjK+SE/H8RNO6WQ+8F71dyInSk5CyeNd6ZjgGBo6ZUEQdrehuot/ZKYrl3avv7J8nTHwBKGQoSAEaUyCFx06dz+1DM69wOSMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hytj/eK2; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hytj/eK2"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-45ef189aa1cso4078721f8f.0
        for <linux-arch@vger.kernel.org>; Tue, 02 Jun 2026 15:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780440508; x=1781045308; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n9btmEwYy4mA0lJ0Eq1DfE2LNHPtUWEmA56rbSRa3u8=;
        b=hytj/eK2esyu8IhuoWC8R10aNxnYG6uDsOhjwECdEynMeCWdBKb8MvD7Ng+B5VfRS4
         Zy0IGJlzWG2U8Re6CWbDvkBrdI6hL834RWcWlhQruujjcTNm/hwEummTdE6jyUM11Gqi
         EVcH5qdfkmDSzjdjW09DpCynsfaaE1UcawCQeQKoTJvPBVPFXMjYc2Drr9IR1pPu7mW1
         8KM9fkmycrt86aMjqV4X59jhJx1C5lNb1eOiYs8P5YYnNXIQx+Rz0KRX1ay0S5tECUnK
         b7gYREbYKq0lXcLCDk3EFGdnuk9nQvTaKqopBLb7RErK1YyCRzqRmdm2QA88inZB2MFf
         ZC6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780440508; x=1781045308;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=n9btmEwYy4mA0lJ0Eq1DfE2LNHPtUWEmA56rbSRa3u8=;
        b=rU5v7i0TnzFH1tqDSOyg51Fpjqv63wSs/Ug0FV+hdBsMeLydWhW2Apb/0PQi/FChzN
         MxF5Exa2tqX+1W3ZlHD/U5KuJGbIYjMKPbdd4/8pHx8hxfUOqKyEFh/PbgUphqPcugML
         3UnMkH5rYYxLCKMRNGz5ZiY9D7iEairFQ9d5mGfpkwqY2B5aQVwzFzLu/gC+IWEQYlI0
         RkI0QjT+TmHRtIkVTkCWaXvvPiWOYXqrWRlJSA5uxGc/Ei68GVWfPec6SYM2Ag03+gxL
         ZifJ6nxT6RtdQC8gdRvgWjwlkAOuk+He05Pr7k2o97mTVohWC/0m/63eLBQMf9cimz3c
         FJCA==
X-Forwarded-Encrypted: i=1; AFNElJ/fxuw4jkihFtLKuNuFSXtIpG8Wbv4d78F9idYQ29tysYRAcy4gDHSjOZzmZnnipY0esuCQn+Lnw8u5@vger.kernel.org
X-Gm-Message-State: AOJu0YyAVsTyXuZ+0Z9JSfmUN/fpBtoM/Hxh/6j4mlMkycX/HrlMNA2V
	dnP0aNo2JeBJEJ15r0r7DuW6oR6kK8pIYN6vnGf+BjdH6c2VxFxTlAVW
X-Gm-Gg: Acq92OFSLwa/DUrUd/kyBUgyFKViTerViOxNkeRTDIu2LIomPTWfsX7S+bH2y2bHID0
	0DP33ukKFQFJxwhKODmTZGxbv1Oys0vGDFuEnFgUFWw5poCANGpmj4GTIReIXzhIFF4/k5LSlfM
	uEw0SroCb7DNPF3vtrqpHeVj56D/cHbNQZIKuV+F1Rgn229DVLaGNfb/+dDSKAJRBcTm2GHafNY
	VpE1rXtL9OHfLKZM6uvL6nbTlEpIZEgiWNQs3yDDOFKahkkpCiXEBJtQrsxvK3fmxAO1k61N6Lp
	YB/Flfl0AStP4ZLZlzCT+UXKTTbbRQA5zImyOT9uKxM/pYmjUtkgpqb1pB78RUad7hCeeNL2w9o
	HVyDTBHRWZadMNgrQqMBN6sEdhkehOijAUbs0Lnd9hjLwXRvEqAtJuKW2lTC/Y5mblEESTeH4cX
	o5064AzmXw5E6FeZZm9DaARSM7B55q2UjV9lNODFTujA==
X-Received: by 2002:a05:6000:2081:b0:45e:ed7e:f900 with SMTP id ffacd0b85a97d-4602178ae06mr723209f8f.6.1780440508010;
        Tue, 02 Jun 2026 15:48:28 -0700 (PDT)
Received: from [172.16.188.153] ([213.181.114.83])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-4601f2f2710sm1999791f8f.14.2026.06.02.15.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 15:48:27 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 02 Jun 2026 22:48:03 +0000
Subject: [PATCH v4 06/25] vmlinux.lds.h: remove redundant ALIGN(8)
 directives
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-dd-maint-2-v4-6-19a1445585a8@gmail.com>
References: <20260602-dd-maint-2-v4-0-19a1445585a8@gmail.com>
In-Reply-To: <20260602-dd-maint-2-v4-0-19a1445585a8@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
 Jason Baron <jbaron@akamai.com>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780440488; l=3579;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=+UeoPcUgk4vgSL6bIOBGSbmEMWJGj+kcMG3jKhNS13E=;
 b=8YvEAPoW9Zb0SdA8n29Rq4/x+ymnjVU2aF9GW/hlp7J8X4pImXdIV61FGkChWr4t0qJXiM8yF
 7JUjhv70j7kA8WQegySLYFgP/s98yMXecJXL4zXvv+/zRUqWaGh7XSD
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
index 145beb14b94b..2b1becd809be 100644
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
@@ -947,12 +936,10 @@
 
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

