Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B775F2E413
	for <linux-arch@vger.kernel.org>; Sun,  3 May 2026 00:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777766750; cv=none; b=kaZv8DXvgehy4ba8Af2v7uz23rF/WVV1NWcLNA+M2fsxGsKhyrYO8IIYEfmqLScBAf775pygyrg8CIRR6am7oeIzSmyhoZFm6dQqNhxymN9CfwZOo63AY2cMn9e/EL9qCpPLDJIxpTRRJQ0db4OLtjpbRPD3QqWGhfZJWM2mBp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777766750; c=relaxed/simple;
	bh=jx+bBZ4Ea0N4OhMqfVeFfhxzER8rbH2ykIENWAaRjuk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F90H2vf7ZdyCCjiu/0hzT/GOoQOo4Dmv7s/JZ2YDTPAkE0powKidyCz0ncdOm2DT+wve7Yh/zjQd545q/WxJEkNbbpAbernnxV76LhtIC3i0ysLpppGICQMls/pOHNrYhM6OVxYbHp/8Ost+Wi1A1XG4B5dleGTEDMLzsdqcePc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kNJ5UQWW; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNJ5UQWW"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7d1872504cbso2555462a34.0
        for <linux-arch@vger.kernel.org>; Sat, 02 May 2026 17:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777766748; x=1778371548; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zsRoTlD3yayg24jIZYOgg3Ot8INI+rN2puwSkcqrIrc=;
        b=kNJ5UQWWkabQ30/abdU8LFnkhg0M22ISP9IqVnDmMvAimXOjbszMkKuRp+HxawozR1
         zudoMB3waKOeeZTx79MBvSAOxj/QUj9iO5btumQIF3D4I3YcpJAJZ3q9JqTfyhABqWV9
         LXsgC8BzbEhPBEGn/+Ipk+CBxdbkMRSXjYcOQiDs0UJFV7kclgYdX35op4uq14jocXyp
         MAMbRJHBbtVCWOJRAXHqp5MYL2tR53ZTTqoQRj8jS/4YBShROdUcxz/MLFTk7p8J9GHu
         PCYqCoWAiQvpNBKYC87BZc+kTQQh8mHeaN1wGWSfh+FoK4wad5uFBzx7hpb9X84RFbj2
         q/Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777766748; x=1778371548;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zsRoTlD3yayg24jIZYOgg3Ot8INI+rN2puwSkcqrIrc=;
        b=jSNsqgHLfY4jPuS8mYTkfoTOIjxWNwhh0/ow9n8oc7fF57+Lv8146XEeo4rFMjqlgs
         TRAQwf7nyhTCVFVa7JHHWPmi16Jg/etZ1fs2CvbYLW6S5tsiaddjsjMjJyN2YTfRMMrK
         4sVHL2e0BwOf9LPFoFsZ3JFB+6rUOUIB3ow1raNNG48uYbv9hdGwloJlxzTFFHbjv+98
         enbyVDuA1nuVDo98hbug7Owo0wYajthwc9LOwPNSPDUA4e2KPk19JE8Mohq2s/TWjFb+
         dA+aNT3ht4QwLIsCc25HL7aBfjXokJ3ntmjSM7oXw1QT+ZyoIjiw2rHCuDJcZbsDS5hd
         HBqw==
X-Gm-Message-State: AOJu0YxDasSbeTJQH3SeO38KdokRLtFEVKKI2634/qnxary8eaFxwESj
	yfz/Y+KW2CHiZ0oCyOLB+lbI6v/S1XUHGW8enaVQYRtxV3YpqToKmr/i
X-Gm-Gg: AeBDietyJ8+AwlThe6sFgewYrD5Yvdd4ciIRb92ehRAH93dLAH7xS5Byt7kQtYwchDV
	oXlzQE0LJDKEcuwSYzGknfwvQoeinA+6muVHRhujCoQHBpIQivJmjFHMHzWQcLBOEvhjgnKjDXP
	6nPRhnNniAyCc0k6cy05QtKhJyad2YBc5kj+FS2rLhztmAp+I0g0Mqk6tvY/6oQ0d9qfxc8SgY5
	89oJV+jDL1njDN+vpq/qqCfYD6Fmllwo1E4fonOIc8DCBYWRLd7aCK4PmmwphbNY+MU8qEjgkRQ
	zWNCDEZLj/Sgtpwzw0TdFKOcelFZdv+PlLCMZfB7hb/0wH+Kf5r2Nxua9rfldjCDz3+MgXS4/g7
	eRyEfgN3yO+KYI3tFR7DYjiI4VCON4tsP8doBuyusVl4k9viP72mZxSk5JF3ypxHzzA38yWSUyv
	IdTxFAER/DC1rmlXC3x44Uf7JH3Ob8mjBD+aUSiKr4pqcIZgfQwRjz84eEFTfHpbJO4i5pdEBd
X-Received: by 2002:a05:6830:6edb:b0:7db:a297:9e62 with SMTP id 46e09a7af769-7debe311362mr4677748a34.8.1777766747728;
        Sat, 02 May 2026 17:05:47 -0700 (PDT)
Received: from [100.82.231.29] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-7decae2b090sm5379676a34.24.2026.05.02.17.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 17:05:46 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Sat, 02 May 2026 18:05:35 -0600
Subject: [PATCH 4/5] vmlinux.lds.h: remove redundant ALIGN(8) directives
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260502-asm-generic-1-v1-4-1103ee0152df@gmail.com>
References: <20260502-asm-generic-1-v1-0-1103ee0152df@gmail.com>
In-Reply-To: <20260502-asm-generic-1-v1-0-1103ee0152df@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>, Jason Baron <jbaron@akamai.com>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
 Aaron Tomlin <atomlin@atomlin.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-modules@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777766741; l=3579;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=jx+bBZ4Ea0N4OhMqfVeFfhxzER8rbH2ykIENWAaRjuk=;
 b=SIcEjVBNyPi945YnFwtLqpMRiycq9NN0/ZNFFBbSslazq3QklTZ6cVnzFU0RU4ofAdzG2s0Ah
 fSjCMvxtqRZA7Jg0RyDeGcFk5s8i0Mx7JE+r9sVRf9Tt0DP6VAAhjua
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
index d3f20b411e16..d9d2eb708355 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -229,7 +229,6 @@
 
 #ifdef CONFIG_KPROBES
 #define KPROBE_BLACKLIST()				\
-	. = ALIGN(8);					\
 	BOUNDED_SECTION(_kprobe_blacklist)
 #else
 #define KPROBE_BLACKLIST()
@@ -245,7 +244,6 @@
 
 #ifdef CONFIG_EVENT_TRACING
 #define FTRACE_EVENTS()							\
-	. = ALIGN(8);							\
 	BOUNDED_SECTION(_ftrace_events)					\
 	BOUNDED_SECTION_BY(_ftrace_eval_map, _ftrace_eval_maps)
 #else
@@ -262,7 +260,6 @@
 
 #ifdef CONFIG_FTRACE_SYSCALLS
 #define TRACE_SYSCALLS()			\
-	. = ALIGN(8);				\
 	BOUNDED_SECTION_BY(__syscalls_metadata, _syscalls_metadata)
 #else
 #define TRACE_SYSCALLS()
@@ -277,7 +274,6 @@
 
 #ifdef CONFIG_SERIAL_EARLYCON
 #define EARLYCON_TABLE()						\
-	. = ALIGN(8);							\
 	BOUNDED_SECTION_POST_LABEL(__earlycon_table, __earlycon_table, , _end)
 #else
 #define EARLYCON_TABLE()
@@ -285,11 +281,9 @@
 
 #ifdef CONFIG_SECURITY
 #define LSM_TABLE()					\
-	. = ALIGN(8);					\
 	BOUNDED_SECTION_PRE_LABEL(.lsm_info.init, _lsm_info, __start, __end)
 
 #define EARLY_LSM_TABLE()						\
-	. = ALIGN(8);							\
 	BOUNDED_SECTION_PRE_LABEL(.early_lsm_info.init, _early_lsm_info, __start, __end)
 #else
 #define LSM_TABLE()
@@ -315,7 +309,6 @@
 
 #ifdef CONFIG_ACPI
 #define ACPI_PROBE_TABLE(name)						\
-	. = ALIGN(8);							\
 	BOUNDED_SECTION_POST_LABEL(__##name##_acpi_probe_table,		\
 				   __##name##_acpi_probe_table,, _end)
 #else
@@ -324,7 +317,6 @@
 
 #ifdef CONFIG_THERMAL
 #define THERMAL_TABLE(name)						\
-	. = ALIGN(8);							\
 	BOUNDED_SECTION_POST_LABEL(__##name##_thermal_table,		\
 				   __##name##_thermal_table,, _end)
 #else
@@ -404,12 +396,10 @@
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
@@ -454,7 +444,6 @@
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

