Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021073.outbound.protection.outlook.com [52.101.100.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAECB31AABF;
	Sun, 10 May 2026 06:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778393590; cv=fail; b=QB8TWmHkyaZsXeABtFajRShOzbsPXmm91o4pA5MYLoPl7LOW6nz01Gnh3WsFFuKfXGowPlzLmV61DO9xYQSuUteWkGstXtG0XWTnc9bitHHqg6g3ssaMRNBRYlKg0a2GRLSw1cMThpFU/bNWg26l6ESjXG689AE4YMMBXdIBygk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778393590; c=relaxed/simple;
	bh=iA/81VnbBfrGuzX/CKNMoJhXoOcxSpzqUOTjhdqTRCo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=cdxdm2CsuhlLa2LsWg2mGu79AQ3JSNWc+r3ziGBkP4TRKNCE+7Y7rpijhRpnPyO90/0BsAVIpfVKl49mEbyu1VBeCa88ZIjVkPNC5TvnE+WNtf5l4nd5xOmObuFSpM1ihzK1mbYmyNfwHm0x5YZdRKZBNqemFhkZyvlYzc1Aa2s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.100.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y03Ta4wVRZR6F6A90eqvbFflqQxApelArOvawvAjp43CIaoSzRy7+5GbR5234xWm8rCkSLNdgVkbF1V5J4CkLkqRT/n8KNvRcRNoaiUi5rLEa3iyfuVFl8Dq5eEaPT551Tm4QeK2K6yBj1wVXmBVzY/Izp9JoHcaGVEhSba2sgl3kzDRCCvoTHZ/IhfcUescQFLh37mxkjf/JExpibVPf07MDphQCusIxrza42EhTpQZPBnYtPGrC7H6Zz1krGpNCVhmVE0MCO/iysR8VH6c+cKZxbXm1ROSKNgIIJLYUsdsRV7txQqlG1fijNx+nKRfR7G6uM6nwSWNZPdAaNnZkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oKYBFa+BBawgmrxSx/HKXRSR6Ew0Lb+u7/h4OuEnVtQ=;
 b=kTODsSqrDTbxcLfE0Cr1tX+nI64cqkfDCJd92CeMvcmbJ1m56R/oNPvln1/KBs77I1aX1ehB16R7CEP75Q5HmAV+GZ9pfNKIKvFmk6DH6VmNdwrGf1lrJTwmX2vxU+EzpAxBvq7tECL1A3FnLg3+qmpqOGET/X88KEKKMCEA9RVNrtos4of/kdTE3Aiqn911O7sHovEx2vTmBZcN5d+mF4dFoaYGybNWXJRtTU+XoN8f8STQBr+QQPehQo1HRE0gj1W4exMyBYEPyKrBmjvEMPkkXBaKSXGxlA6uomn4+ErBdcR8sxfwdpaO5Zzl/lKAS4nJJTN3+65AR7EVY35Fog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by CWXP123MB3816.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:9a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Sun, 10 May
 2026 06:13:05 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9846.025; Sun, 10 May 2026
 06:13:05 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: arnd@arndb.de,
	mcgrof@kernel.org,
	petr.pavlu@suse.com,
	da.gomez@kernel.org,
	samitolvanen@google.com
Cc: atomlin@atomlin.com,
	neelx@suse.com,
	sean@ashe.io,
	chjohnst@mail.com,
	steve@abita.co,
	mproche@mail.com,
	nick.lane@mail.com,
	linux-arch@vger.kernel.org,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] init/main: Expose built-in initcalls and blacklist status via debugfs
Date: Sun, 10 May 2026 02:13:01 -0400
Message-ID: <20260510061301.41341-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9P222CA0006.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:408:10c::11) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|CWXP123MB3816:EE_
X-MS-Office365-Filtering-Correlation-Id: 826139f3-328c-4dde-8f56-08deae5b32cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|3023799003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	LiQONHvLhCA30PhYDt0GxR86Pn1HcpzhFr9K49wPvvfRViF+hQ3tOEa3BP3WmlSynYjZWP3Iwklcgiafhawv7zm9/hXqK/ZPjNUCamsDE2wylyCixiFKYgY7QrhwTFa4JblrIacpVLhFeteGf76+G9rIAsogDdbF1q6hbJ0iDFpzSGd71YBKFj9MLAGmEaeZEMr3rOTbi/VQvbpdoRLH97WcCSalmtPXAaNj06dLBFM3tOXtDVQJge9ATC1lJSB/w4KPPDmOC1T5VAb+jeBR3aIzr+7ROt4BYd6BGvgQGtUyJ3waOqQEDPubWKO+/yAi8dxQoxHmdZNjTn5fls1U6R1XNLVUuXfBeCdsPwrQkvcFOzzI6mibbtT+PiTXEkn0YfUFPIOYw15wdPjIPPvaYoyTh0AOlxUAOHaNvXCfMIe0O8lPQ2aGTeJgt7hLorAqxBwa8zT1jG67xiLz76+lV9q9nteGeXHVH4fUCbLh5Q89agb6gSg5RcPFV71SJL08xFNBmwziqvrxKrMmusJc598tFuL7y6MZ56bbshi8PJ+c/n+ZV/ULZwd2Yb3kFvKanHXcdKk3B7E2P+b0Y/cRu8VVnzBs1tf1QcTz3VfDspSwCR61ZNqf9hcSRBFLwK+xlwk1O4Y8oCBVhSsdKH8FdVeiQv3g7v3EjsWmPn1FX92O/4+YBScvYbqHSF7dYpEJ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(3023799003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TDXP0+CieuLb4A5sFq7RVQvCaTixHm7aaKNIYmt2P113F+1grvnf1OLXUNgN?=
 =?us-ascii?Q?bF8psS4D4H62/IuJ67zrpASof2eWszvpCUmlcioodBPeRvwqu1C2i9HOtJzL?=
 =?us-ascii?Q?lLQZdL0vc0Hx1lQpC+JPqYK75VcI65PqOGIK8pLdjwQ3QhuVBHguYA4bq94D?=
 =?us-ascii?Q?j0ZfYKEWwvxeNYGWXQN3Al9WqTBLEmLTnKyNe49dCEfxWHl1fqjfGT9Vbzm9?=
 =?us-ascii?Q?9Y5Kj5FGjB+iu5pAHh5MNiTCUb5HTehfoceWXJu2suZJdN8vdgVOjhZ4bWMi?=
 =?us-ascii?Q?NstMvdmNBmqYG077bpYSXc/k4rx1mbmq5roqqvEYwwsM5NIWxqzFiUBsEixM?=
 =?us-ascii?Q?+oSahSWOb57RPbCmoCfCtT31hUVtI+Ov9L+T7I7WZSAqUxKSPZyITGzU0v2c?=
 =?us-ascii?Q?ZxD833dZLFzmbHYtvUrzKHMDfnUIUcfq8aO7sFz9LUO9xHKgEKU94xa2+T//?=
 =?us-ascii?Q?Q6OuOSAOSbrw6XuR4dAYxCQ26C5Dt2ZEokx3V81ZBpvBDJagDlFYceRO1lNN?=
 =?us-ascii?Q?begRhAgQGZe0DH0M/SH11SfLZ3A7S0ONWT18n82ZcM5UxiNeM6Sv/rDExBhY?=
 =?us-ascii?Q?ZJs7v+NwXWsMKirHjzPstCSsVG9vtTMlopgh9BWNxnK/Lrtpkf5Qg/Ubwcm+?=
 =?us-ascii?Q?cy1K7O5ZGa5Vcc5M3PkjPTCWoL7E7phA0k8m+mwD+2FmTZ4zErXdTakWkja5?=
 =?us-ascii?Q?RqRulFo36jwZ9SgGYix4JDP0g7cnbEROQO24U8IYucSHyEpCN19cIG34N4y4?=
 =?us-ascii?Q?7SaNCLPq6+TAOEvXvmApyzZTbEnhMTmIHr257fWPq2Qf5EKKNiNLr+n7a9J0?=
 =?us-ascii?Q?11e65nOKH7sQnrosT8XiFz2zlMTv/ZKDZ7MXsp7Z6TLqnuPRDDRmFKl9/cvZ?=
 =?us-ascii?Q?yRNgNoNvJcSm+BeFsVkIa7J7HzumDjoaoZejDIK8wP3FJd3dj3R8jaM7msFA?=
 =?us-ascii?Q?UXPEPDMCd+IcnKwf46S7rfnWswm0XMCfcybItcR2RRyZ97gRYElem3WnsBL9?=
 =?us-ascii?Q?0Tzwdbvp01Xq9Mnq6+DWSAnbkX4erokYMUrdycz9bkhqm8mz+FAm6vX8E57I?=
 =?us-ascii?Q?m43kW1kCo7WZva/80M7RvOtafx6tHbBQiWVuebd8XZqXAzIeY8OgI7z3eGYZ?=
 =?us-ascii?Q?7qrv3Adb8zmbUJ+rWuuPOHPXafSi49uknr0tN4FqkCH/arWUtChJB2oJS7Ae?=
 =?us-ascii?Q?rxHvFBNAISkzGM3+AlNirBpOtj9/xeGzcuMxI2zGu5T1P66CGAMeMDPdx84Q?=
 =?us-ascii?Q?MmeYUiw/oFCwPOoEX4oRdqW9XuENMFWsla8WcR+GGjLyHiZb8nkjqP40bpn5?=
 =?us-ascii?Q?Ylb0Bdq4LDQqnV/r6tbdeTR1ATreXzDDBYntuHu9qaf7RnjHEes5DHyEI2Lq?=
 =?us-ascii?Q?60NC+HI25a5C52JBdENfMpuk2WfB5vOEulaZUh46S8ZCxTaXCB2ughKoFL4x?=
 =?us-ascii?Q?2xyNG2PwkWj2K65ezgv9SIOm9cfGmXzEXo4mMeWmTqGl0JknfV0HG4M9PZYm?=
 =?us-ascii?Q?rIBjjuv3h785Fi1uko2LCh3TW8B5S6ZSD3zxCVBaRiW8uIpoRH80JZIE9wz7?=
 =?us-ascii?Q?W3GxyOW8gqr7aEfHEjtW5Yg8vREKQZQsBhXpuZNmxPGyBdyGqX8Aa5Y0cqXK?=
 =?us-ascii?Q?oc73+mvWSsD5RwDxUAPpOVacmLH+/u/3VcHCrBFrx9SUgqGUOlyR7DQTr6Tg?=
 =?us-ascii?Q?Y0bmlB3OWRUc1WbAQG6TkDuzcqsdRH/YfI2SoWqLIsq5qBhydSxzmR4MsM+u?=
 =?us-ascii?Q?dklBZnYPpg=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 826139f3-328c-4dde-8f56-08deae5b32cc
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2026 06:13:05.2014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A1EEWqp39o7NDf3bH5nH5FkU/Da9SI8Vo4EH7cL2AYHSunhsK0ytdB1NK/jA7Ig2kSVumTv1RR7Y4qXxSTbCOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB3816

At present, identifying the correct function name to supply to the
"initcall_blacklist=" kernel command-line parameter requires manual
inspection of the source code or kernel symbol tables. Furthermore,
administrators lack a reliable runtime mechanism to verify whether a
specified built-in module has been successfully blacklisted.

To resolve this, introduce a new debugfs interface at
/sys/kernel/debug/modules/builtin_initcalls. This file enumerates all
built-in modules alongside their corresponding initialisation callbacks
(e.g., those specified by module_init()) in a simple format:
"module_name init_callback". If a built-in module has been actively
blacklisted, the entry is explicitly appended with a " [blacklisted]"
suffix.

To achieve this without incurring runtime overhead, the
___define_initcall macro is expanded to statically allocate a
builtin_initcall_record structure (containing the module and function
name strings) within a dedicated .rodata_builtin_initcall_records
section.

This implementation incorporates several critical architectural safety
measures:
  - The custom section name deliberately begins with ".rodata" to ensure
    KASLR (Kernel Address Space Layout Randomisation) relocation tools
    process and update the string pointers correctly during boot.
  - The structural alignment is explicitly forced to 8 bytes to prevent
    the compiler from inserting silent padding that would misalign the
    linker script boundaries.
  - The blacklisted_initcalls list head is stripped of its
    __initdata_or_module annotation, ensuring the list remains safely
    accessible in memory when queried from user space after early boot.

The creation of the debugfs file and the associated memory allocations
are strictly guarded by CONFIG_DEBUG_FS and CONFIG_KALLSYMS, as the
underlying initcall blacklisting mechanism is entirely dependent on
kallsyms being present.

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 include/asm-generic/vmlinux.lds.h |  4 +++
 include/linux/init.h              | 21 ++++++++++++
 init/main.c                       | 55 ++++++++++++++++++++++++++++++-
 3 files changed, 79 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 60c8c22fd3e4..d0fb971a8d5c 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -483,6 +483,10 @@
 		SCHED_DATA						\
 		RO_AFTER_INIT_DATA	/* Read only after init */	\
 		. = ALIGN(8);						\
+		__builtin_initcall_records_start = .;			\
+		KEEP(*(.rodata_builtin_initcall_records))		\
+		__builtin_initcall_records_end = .;			\
+		. = ALIGN(8);						\
 		BOUNDED_SECTION_BY(__tracepoints_ptrs, ___tracepoints_ptrs) \
 		*(__tracepoints_strings)/* Tracepoints: strings */	\
 	}								\
diff --git a/include/linux/init.h b/include/linux/init.h
index 40331923b9f4..d682fe0d6064 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -182,6 +182,16 @@ extern struct module __this_module;
 
 #ifndef __ASSEMBLY__
 
+#if defined(CONFIG_DEBUG_FS) && defined(CONFIG_KALLSYMS)
+#ifndef KBUILD_MODNAME
+#define KBUILD_MODNAME "unknown"
+#endif
+struct builtin_initcall_record {
+	const char *modname;
+	const char *fnname;
+};
+#endif
+
 /*
  * initcalls are now grouped by functionality into separate
  * subsections. Ordering inside the subsections is determined
@@ -271,8 +281,19 @@ extern struct module __this_module;
 		__initcall_name(initcall, __iid, id),		\
 		__initcall_section(__sec, __iid))
 
+#if defined(CONFIG_DEBUG_FS) && defined(CONFIG_KALLSYMS)
+#define ___define_initcall(fn, id, __sec)					\
+	__unique_initcall(fn, id, __sec, __initcall_id(fn));			\
+	static const struct builtin_initcall_record				\
+	__initcall_name(builtin_initcall_rec, __initcall_id(fn), id)		\
+	__used __aligned(8) __section(".rodata_builtin_initcall_records") = {	\
+		.modname = KBUILD_MODNAME,					\
+		.fnname = #fn,							\
+	};
+#else
 #define ___define_initcall(fn, id, __sec)			\
 	__unique_initcall(fn, id, __sec, __initcall_id(fn))
+#endif
 
 #define __define_initcall(fn, id) ___define_initcall(fn, id, .initcall##id)
 
diff --git a/init/main.c b/init/main.c
index 96f93bb06c49..4cdf97306bf6 100644
--- a/init/main.c
+++ b/init/main.c
@@ -104,6 +104,8 @@
 #include <linux/randomize_kstack.h>
 #include <linux/pidfs.h>
 #include <linux/ptdump.h>
+#include <linux/debugfs.h>
+#include <linux/seq_file.h>
 #include <linux/time_namespace.h>
 #include <linux/unaligned.h>
 #include <linux/vdso_datastore.h>
@@ -1251,7 +1253,7 @@ struct blacklist_entry {
 	char *buf;
 };
 
-static __initdata_or_module LIST_HEAD(blacklisted_initcalls);
+static LIST_HEAD(blacklisted_initcalls);
 
 static int __init initcall_blacklist(char *str)
 {
@@ -1316,6 +1318,57 @@ static bool __init_or_module initcall_blacklisted(initcall_t fn)
 #endif
 __setup("initcall_blacklist=", initcall_blacklist);
 
+#if defined(CONFIG_DEBUG_FS) && defined(CONFIG_KALLSYMS)
+extern struct builtin_initcall_record __builtin_initcall_records_start[];
+extern struct builtin_initcall_record __builtin_initcall_records_end[];
+
+static int builtin_initcalls_show(struct seq_file *m, void *v)
+{
+	struct builtin_initcall_record *rec;
+	bool blacklisted;
+	struct blacklist_entry *entry;
+
+	for (rec = __builtin_initcall_records_start; rec < __builtin_initcall_records_end; rec++) {
+		blacklisted = false;
+		list_for_each_entry(entry, &blacklisted_initcalls, next) {
+			if (!strcmp(rec->fnname, entry->buf)) {
+				blacklisted = true;
+				break;
+			}
+		}
+		seq_printf(m, "%s %s%s\n",
+			   rec->modname,
+			   rec->fnname,
+			   blacklisted ? " [blacklisted]" : "");
+	}
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(builtin_initcalls);
+
+static int __init builtin_initcalls_debugfs_init(void)
+{
+	struct dentry *modules_dir;
+
+	/* Attempt to safely grab a reference to the existing directory */
+	modules_dir = debugfs_lookup("modules", NULL);
+
+	/* * Use modules_dir if found, otherwise dynamically create and use
+	 * the fallback directory without.
+	 */
+	debugfs_create_file("builtin_initcalls", 0444,
+			    modules_dir ?: debugfs_create_dir("modules", NULL),
+			    NULL, &builtin_initcalls_fops);
+
+	/* dput() safely ignores NULL if the lookup failed */
+	dput(modules_dir);
+
+	return 0;
+}
+late_initcall(builtin_initcalls_debugfs_init);
+#endif /* CONFIG_DEBUG_FS && CONFIG_KALLSYMS */
+
+
 static __init_or_module void
 trace_initcall_start_cb(void *data, initcall_t fn)
 {
-- 
2.51.0

