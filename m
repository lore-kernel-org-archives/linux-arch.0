Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022129.outbound.protection.outlook.com [52.101.96.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA7C2F8BEE;
	Tue,  8 Sep 2026 20:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788899567; cv=fail; b=h2jOIfnegLqzPVngoGhPA7YhsbQpUxoEXBBZtK+wgCt5sIP3e/wCrPI2KMM57U3EpEPjmihNW8Ex+Zlj2UnQGU9m71lP8XPhwzNZWwHhvbHSL1/O82mpSOiayfj6V9PliP/sqfVJ7U7Dhmr4MXyI4E1CRNYn+8Ou5z9mkJh2a/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788899567; c=relaxed/simple;
	bh=ydfbNqN7kU2FRD7XMtSdE0sdgJn/wbnSbBLSy6G2p2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QimlKNYSs5KxKxN2fhooKrUTPCswP5tENM8ADnJBJUZtHiI59LhELZE1RI3f85smCz+hWOYLUe4a5QiHOCOng4np3s8Kd7+lNPLgDgrcs9mIvPkBLNE7n8v/6kftD1XNtKsuzxCuYlXpREgUtdKh047xWsMposBFi8ZTuQ2QsgM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.96.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bkh3u30IrF6bj1DSdhQ8nQiWL/VvNfuiBPZJByfZJvfstsx/bqyYCSpuYmQ6T6PoUrIeQXXvoGsvFDEfNBmGfLibJeov6I5KbCKWOCRhYwADjYAOFqQX07dErhmlhq0kGKT0XPobOiaADgQDfhoUnlB8L/hGG8SsV6+cGZA61bl86+jQG4hxVsL+/Qtj0eZ56BA9pEX2sHJrxzkKGDaGHKPn2zcEB7SBiXtvszB27s4vv68yzSSpy9xzBqAWm3B+mRV5gGDNwomW2VH5Ta4iSWsb3rCRT57V37ct10xYzj8GEjeHjbqGmUcQn4lSkaGGFm5cUpML6ShaMn5i6tMiJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=5PO4qLHobCw6nN3YVqZCmpDmVcscqE+mIlJ6gNAWdWQ=;
 b=J2y9yiZTqsLfLylRLqqg+AU6x8hDPBsZMpG0f7wzmm87rvuUxsJdLtrJXXMWpNbHwWRyiZsg1Adp9j0faCx1K3wfvAAvaoWgaxr4AmNc3DmeMgEF8ychqGTn/bd4/ZP42C2dftT0c1SoDiICG/d5SpcgVlCAKFNibf0fVdIfLu2WQAEDeWsulnPY3oDszrX5PJXnfnTeGIDEWWTCe4GvHtO/Q1kSHioMZy+qCfPNAKmSF3mQxD8eZZdvxjPGxJYbkfcF1D8qeWmsFh4EKK3P9Am9EtezcQikIHzJ1fqbSs26Lo7XGfGfVwVDknaz/hdvVDkmpuLcKn29kckqQpULyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO6P123MB7126.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:341::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 20:32:43 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0406.005; Tue, 8 Sep 2026
 20:32:43 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: arnd@arndb.de,
	mcgrof@kernel.org,
	petr.pavlu@suse.com,
	da.gomez@kernel.org,
	samitolvanen@google.com,
	peterz@infradead.org,
	ojeda@kernel.org
Cc: akpm@linux-foundation.org,
	gregkh@linuxfoundation.org,
	mhiramat@kernel.org,
	boqun@kernel.org,
	atomlin@atomlin.com,
	neelx@suse.com,
	da.anzani@gmail.com,
	sean@ashe.io,
	chjohnst@mail.com,
	steve@abita.co,
	mproche@mail.com,
	nick.lane@mail.com,
	linux-arch@vger.kernel.org,
	linux-modules@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v11 2/3] module: Extend module_blacklist parameter to built-in modules
Date: Tue,  8 Sep 2026 16:32:29 -0400
Message-ID: <20260908203230.401020-3-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260908203230.401020-1-atomlin@atomlin.com>
References: <20260908203230.401020-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:208:32b::7) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO6P123MB7126:EE_
X-MS-Office365-Filtering-Correlation-Id: 0eecaf46-f7bc-4fc5-c363-08df0de85594
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|6133799003|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	zIxhHtshcFFf2GEFZRoAJ9fLzqOFtC2LTKOx2TUJe7AX1gfntmpUUrjVQju5eCJcP3VeJ9OMIPMiQucXHburMFm7L76faspXP9fYCKIDzQAZ8iEza6bu7afZ6swqqlviB/4GQZpR48mmKUlBZR/YExb8bItIITvC4IUDzDstX9y2QW1vzBl8kEgce0fZ4/tGEga0xpNzgpEQsNdQ1+8IV2hUFQBaAEz04G07cr4ZYQ3FgqUU9QicpaussZauMfJsHz9duc5wUKgi4LuCiFnWm4dPCQuqiDTAgU/hgmrxacb6j8ea0IjU2IDTLog4jSQLZHtc4vziWn/SqFoBDcJ+hHgFYUa4BMTXML7iOiSBhOIrc7Zj0fGaL/kO4Ok4q5zOXvRPMxa+AYF6QiUpMAWuQkh5ZIPxcR2USQ4mNNZuQM+stSw0OpsxXJyJ9WTbjDTME9MW6Z5kbpnyRyUIMuKDZcnWlNdoso0IxEDpk7wR6dS0yZttF0HZEYTKh7reaffWrvO2K6mGBOpPNapc+XU3XgBHDPXWQYborDJNKvM8+2zZnetDtwIhltA6yjvJHbPcailRH3eeBiPPsAPUyInzlt7CME7em+/jxXDbufRX5+9HCqsk3wFhB9awp7TwRJH7KYNawoNMu8isrbjMwDqCcRK63YU4yCDYT0c2J8MPutA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(6133799003)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ef/4ttV1tK7HVMj79rkAn1lcv6puMp9QLrZKLymEjDtzENJsZGpVHNBfy9Go?=
 =?us-ascii?Q?BvBGMg4e4jGgUn4BSDODRzkupklDHOIdIrTiqI62/SVi+/fYI9ot9gXtVJLe?=
 =?us-ascii?Q?KYKv8WrUVldKRsYTbbyUUII2PpZCcTX3F4LmOq/dHe2u7nDi3Uk9fqR1bqbE?=
 =?us-ascii?Q?6UgYLPayenmTGmZ4/zdLh6goSEeo6V+JtBHx/FCvNhqZpnHaLo7/P+5395FA?=
 =?us-ascii?Q?E/4VLWVWZjXFesLIOuAgfgluv4QMn6WuAhPWtWyXk7MJZmuOkjLBVFN11ojd?=
 =?us-ascii?Q?KUjhp1sqq/vOF4hHKQV3H0+uW5Oz62+VGVTN4gqse4snBEdczItynYWCMlqF?=
 =?us-ascii?Q?y0BjzCCB92LhNi0XQB4VB4O/Ic1vBpN7X0sBSSuByxLRc347EyPum793ncmD?=
 =?us-ascii?Q?zV+RKpJcQiXruRE8kWmVgcGie9gJdUIFDlg1YCE7F/fQBbBufYjIqiCwROa5?=
 =?us-ascii?Q?E2jZblaqHq8YBk+B9Q17M+/u8vVqCEqO8NtU0MYW7Q9wrKFBbKtuVZNzIsab?=
 =?us-ascii?Q?wq3qhdKrBGcRGkguBX1hYeHPz8tnwMGE/rxjwnALx00QDGlus5EFmRcf+z6m?=
 =?us-ascii?Q?HvmyUjGknJfcOnp7s6S4yJu3unDOkKngQXibCtafKOZGKt6Vvc6R/lfrp+th?=
 =?us-ascii?Q?9ambS4kU2dyCSCsASM9JaKJpHbKvthPT1XGbHb1K4Z1SY8mioKaY5riLZky4?=
 =?us-ascii?Q?J0Rup7CFCsf2N9yaSY/50uUPsupUsWesNbCJ3svAyCtKP7iKvSrZNNcbRnxd?=
 =?us-ascii?Q?RPKmPHPNtwJSMr+SheF78jPhUQUTjwZ9DSg1tLItWopQiivx4k+c/HPmO187?=
 =?us-ascii?Q?mi0Y5Wzv10uzNbda16xOU0LSxvA66UMEeY5jQsbfYdVLAFWYVHGbaU6/LO3k?=
 =?us-ascii?Q?Rrqm9Z7mbVMeAk9i9DMWfgnW9+Khc6uimlIRFWX0JyOagV2JWLG/nh3amsYL?=
 =?us-ascii?Q?C9y7/9VJbQ2MyCH5x7OPJmwZWHT7pqaIB7dTGf10k5Aelm9z7O/Rn2/BoYUt?=
 =?us-ascii?Q?MqO2higbAzSosGvMFbKk3fX2q8iyevQNxIAjHAZuqH8C/fQKndlX+wweJRIV?=
 =?us-ascii?Q?U0SXNYHAJln+Hsn2/FR0QeKFgPB7GoT+IR7CYG4STgANgiO/NWx07S0s2OVS?=
 =?us-ascii?Q?VXqcjsPo0Zg8W3hpApGYnjCHRzE5YmCYIPI/vYVtl2uVJg0tlwxc+C/xi8eM?=
 =?us-ascii?Q?4VPlFlSFJEE1LPG05D6OnpbEPa5r7QnkZuEoClKjk2pIrWeQ3VMk0z/EabG0?=
 =?us-ascii?Q?rYt9SFEarRq7+J/Q+O4j9Nf+noPmUbWqUUHVvANavGxfTQ3PTHfXb35FRQVM?=
 =?us-ascii?Q?jY3vmumApHL8tKgyGdJzGW2ZIGIGRrxAqW4/PGGc/owsG8eHXRHmfYL9lIWg?=
 =?us-ascii?Q?+Qa7+RwcR1UHn8OURFQ6JK/HiXvNi1fw0XRqBX979RoXlKUfgZbBWCk+D6pj?=
 =?us-ascii?Q?miuMRm4s1hqSEhhRXQJq0m6YcUkT3a2nICFUW4OyuppzrDL9YFeMGDlVbxur?=
 =?us-ascii?Q?KfkgtgHKiY37hbqWiYPQCYTsDloRW2hOPX/L9UPFmgFCuRLvPs5xtNE5HSSQ?=
 =?us-ascii?Q?GCTmNjQIxjgp3ztESrpRcsdsOFiSQ9oPeR+t5bGuuMO2I/L4LIeemVDxZVim?=
 =?us-ascii?Q?w5jRmMi8/H6vv3RYNYlhS6+fko/ui9fjF4sRTUf3ehKsQ6zcBveKWYKVZgPW?=
 =?us-ascii?Q?92jKtrziADk9uYQ5gPyBOauizqCKsgnKkFGNYPEqz0KBLW2tfC3vYJYbBaU0?=
 =?us-ascii?Q?QEgsjJDqCQ=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eecaf46-f7bc-4fc5-c363-08df0de85594
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 20:32:43.2025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n0XnkDppK7d5IW6UaM09MwOG/g534TDSYkulQT9tP0fATYCsZZRIAZ25N/GYY+98JxKp4VI99ISqauWC8Lc49Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P123MB7126

Currently, the "module_blacklist=" command-line parameter only applies
to loadable modules. If a module is built-in, the parameter is silently
ignored. This patch extends the blacklisting functionality to built-in
modules by intercepting their initialisation routines during early boot.

To achieve this, we introduce a new ".initcall.modnames" memory section.
For each built-in module, we use a standard C structure (i.e., struct
initcall_modname) to map its initcall function pointer to its associated
KBUILD_MODNAME string. This mapping is restricted only to files implementing
built-in modules via module_init() to avoid mapping core kernel subsystems
and save memory.

During boot, built-in initcalls are executed sequentially via
do_initcall_level() and do_pre_smp_initcalls(). We introduce a new
wrapper function, do_one_initcall_builtin(), to cross-reference the
initcall function pointer against the ".initcall.modnames" table. If
a match is found and the module is present in the blacklist, the
initcall is skipped.

To make the blacklist functional on monolithic kernels, the command-line
parameter parsing and the module_is_blacklisted() lookup function are
decoupled from the loadable module subsystem and moved to init/main.c.
This enables "module_blacklist=" to intercept built-in modules even on
kernels built with CONFIG_MODULES=n.

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 include/asm-generic/vmlinux.lds.h |  4 ++-
 include/linux/init.h              | 25 +++++++++++++-
 include/linux/module.h            |  4 ++-
 init/main.c                       | 54 +++++++++++++++++++++++++++++--
 kernel/module/main.c              | 22 +------------
 rust/bindings/bindings_helper.h   |  1 +
 rust/macros/module.rs             | 19 +++++++++++
 7 files changed, 103 insertions(+), 26 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index b2988aa12f66..2187fb463de6 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -734,7 +734,9 @@
 	EARLYCON_TABLE()						\
 	LSM_TABLE()							\
 	EARLY_LSM_TABLE()						\
-	KUNIT_INIT_TABLE()
+	KUNIT_INIT_TABLE()						\
+	. = ALIGN(8);							\
+	BOUNDED_SECTION_BY(.initcall.modnames, _initcall_modnames)
 
 #define INIT_TEXT							\
 	*(.init.text .init.text.*)					\
diff --git a/include/linux/init.h b/include/linux/init.h
index 6326c61e2332..833b837ce11d 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -252,6 +252,7 @@ extern struct module __this_module;
 #endif
 
 #ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
+#define __initcall_fn_ptr(fn, __iid, id)	__initcall_stub(fn, __iid, id)
 #define ____define_initcall(fn, __stub, __name, __sec)		\
 	__define_initcall_stub(__stub, fn)			\
 	asm(".section	\"" __sec "\", \"a\"		\n"	\
@@ -260,6 +261,7 @@ extern struct module __this_module;
 	    ".previous					\n");	\
 	static_assert(__same_type(initcall_t, &fn));
 #else
+#define __initcall_fn_ptr(fn, __iid, id)	fn
 #define ____define_initcall(fn, __unused, __name, __sec)	\
 	static initcall_t __name __used 			\
 		__attribute__((__section__(__sec))) = fn;
@@ -271,7 +273,28 @@ extern struct module __this_module;
 		__initcall_name(initcall, __iid, id),		\
 		__initcall_section(__sec, __iid))
 
-#define ___define_initcall(fn, id, __sec)			\
+struct initcall_modname {
+	initcall_t initcall_fn;
+	const char *modname;
+};
+
+#define ____define_initcall_modname(fn, id, __sec, __iid)		\
+	__unique_initcall(fn, id, __sec, __iid)				\
+	static const char __initstr_##fn[] __used __aligned(1)		\
+		__section(".init.rodata") = KBUILD_MODNAME;		\
+	static const struct initcall_modname __modname_##fn __used	\
+		__section(".initcall.modnames")				\
+		__aligned(__alignof__(struct initcall_modname)) = {	\
+			.initcall_fn = __initcall_fn_ptr(fn, __iid, id),\
+			.modname = __initstr_##fn			\
+		};
+
+#define __define_initcall_modname(fn, id)				\
+	____define_initcall_modname(fn, id, .initcall##id, __initcall_id(fn))
+
+#define __builtin_module_initcall(fn)	__define_initcall_modname(fn, 6)
+
+#define ___define_initcall(fn, id, __sec)				\
 	__unique_initcall(fn, id, __sec, __initcall_id(fn))
 
 #define __define_initcall(fn, id) ___define_initcall(fn, id, .initcall##id)
diff --git a/include/linux/module.h b/include/linux/module.h
index 96cc98568eea..bcc54edbde7d 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -86,7 +86,7 @@ extern void cleanup_module(void);
  * builtin) or at module insertion time (if a module).  There can only
  * be one per module.
  */
-#define module_init(x)	__initcall(x);
+#define module_init(x)	__builtin_module_initcall(x);
 
 /**
  * module_exit() - driver exit entry point
@@ -879,6 +879,8 @@ static inline void module_for_each_mod(int(*func)(struct module *mod, void *data
 }
 #endif /* CONFIG_MODULES */
 
+bool module_is_blacklisted(const char *module_name);
+
 #ifdef CONFIG_SYSFS
 extern struct kset *module_kset;
 extern const struct kobj_type module_ktype;
diff --git a/init/main.c b/init/main.c
index 2613d3f9b3ce..accaa8418aa5 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1344,6 +1344,56 @@ static inline void do_trace_initcall_level(const char *level)
 }
 #endif /* !TRACEPOINTS_ENABLED */
 
+extern struct initcall_modname __start_initcall_modnames[];
+extern struct initcall_modname __stop_initcall_modnames[];
+
+/* module_blacklist is a comma-separated list of module names */
+static char *module_blacklist;
+bool __init_or_module module_is_blacklisted(const char *module_name)
+{
+	const char *p;
+	size_t len;
+
+	if (!module_blacklist)
+		return false;
+
+	for (p = module_blacklist; *p; p += len) {
+		len = strcspn(p, ",");
+		if (strlen(module_name) == len && parameqn(module_name, p, len))
+			return true;
+		if (p[len] == ',')
+			len++;
+	}
+	return false;
+}
+core_param(module_blacklist, module_blacklist, charp, 0400);
+
+static const char *__init get_builtin_modname(initcall_t fn)
+{
+	struct initcall_modname *p;
+
+	for (p = __start_initcall_modnames; p < __stop_initcall_modnames; p++) {
+		if (p->initcall_fn == fn)
+			return p->modname;
+	}
+	return NULL;
+}
+
+static void __init do_one_initcall_builtin(initcall_t fn)
+{
+	const char *modname;
+
+	if (module_blacklist) {
+		modname = get_builtin_modname(fn);
+		if (modname && module_is_blacklisted(modname)) {
+			pr_info("Skipping initcall for blacklisted built-in module %s\n",
+				modname);
+			return;
+		}
+	}
+	do_one_initcall(fn);
+}
+
 int __init_or_module do_one_initcall(initcall_t fn)
 {
 	int count = preempt_count();
@@ -1416,7 +1466,7 @@ static void __init do_initcall_level(int level, char *command_line)
 
 	do_trace_initcall_level(initcall_level_names[level]);
 	for (fn = initcall_levels[level]; fn < initcall_levels[level+1]; fn++)
-		do_one_initcall(initcall_from_entry(fn));
+		do_one_initcall_builtin(initcall_from_entry(fn));
 }
 
 static void __init do_initcalls(void)
@@ -1461,7 +1511,7 @@ static void __init do_pre_smp_initcalls(void)
 
 	do_trace_initcall_level("early");
 	for (fn = __initcall_start; fn < __initcall0_start; fn++)
-		do_one_initcall(initcall_from_entry(fn));
+		do_one_initcall_builtin(initcall_from_entry(fn));
 }
 
 static int run_init_process(const char *init_filename)
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 2b708c59f0f1..0eb5700f9f73 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2930,26 +2930,6 @@ int __weak module_frob_arch_sections(Elf_Ehdr *hdr,
 	return 0;
 }
 
-/* module_blacklist is a comma-separated list of module names */
-static char *module_blacklist;
-static bool blacklisted(const char *module_name)
-{
-	const char *p;
-	size_t len;
-
-	if (!module_blacklist)
-		return false;
-
-	for (p = module_blacklist; *p; p += len) {
-		len = strcspn(p, ",");
-		if (strlen(module_name) == len && parameqn(module_name, p, len))
-			return true;
-		if (p[len] == ',')
-			len++;
-	}
-	return false;
-}
-core_param(module_blacklist, module_blacklist, charp, 0400);
 
 static struct module *layout_and_allocate(struct load_info *info, int flags)
 {
@@ -3402,7 +3382,7 @@ static int early_mod_check(struct load_info *info, int flags)
 	 * Now that we know we have the correct module name, check
 	 * if it's blacklisted.
 	 */
-	if (blacklisted(info->name)) {
+	if (module_is_blacklisted(info->name)) {
 		pr_err("Module %s is blacklisted\n", info->name);
 		return -EPERM;
 	}
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 4b31aa7f432f..1075b26e53ac 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -63,6 +63,7 @@
 #include <linux/fwctl.h>
 #include <linux/fs.h>
 #include <linux/i2c.h>
+#include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/io-pgtable.h>
 #include <linux/ioport.h>
diff --git a/rust/macros/module.rs b/rust/macros/module.rs
index bc7027f8dbb2..87908233a654 100644
--- a/rust/macros/module.rs
+++ b/rust/macros/module.rs
@@ -480,6 +480,8 @@ pub(crate) fn module(info: ModuleInfo) -> Result<TokenStream> {
     let ident_init = format_ident!("__{ident}_init");
     let ident_exit = format_ident!("__{ident}_exit");
     let ident_initcall = format_ident!("__{ident}_initcall");
+    let ident_modname = format_ident!("__{ident}_modname");
+    let ident_modname_str = format_ident!("__{ident}_modname_str");
     let initcall_section = ".initcall6.init";
 
     let global_asm = format!(
@@ -491,6 +493,9 @@ pub(crate) fn module(info: ModuleInfo) -> Result<TokenStream> {
     );
 
     let name_cstr = CString::new(name.value()).expect("name contains NUL-terminator");
+    let name_bytes = name_cstr.to_bytes_with_nul();
+    let name_len = name_bytes.len();
+    let name_byte_literal = Literal::byte_string(name_bytes);
 
     Ok(quote! {
         /// The module name.
@@ -591,6 +596,20 @@ pub extern "C" fn cleanup_module() {
                 #[cfg(CONFIG_HAVE_ARCH_PREL32_RELOCATIONS)]
                 ::core::arch::global_asm!(#global_asm);
 
+                #[cfg(not(MODULE))]
+                #[used(compiler)]
+                #[link_section = ".init.rodata"]
+                static #ident_modname_str: [u8; #name_len] = *#name_byte_literal;
+
+                #[cfg(not(MODULE))]
+                #[used(compiler)]
+                #[link_section = ".initcall.modnames"]
+                static #ident_modname: ::kernel::bindings::initcall_modname =
+                    ::kernel::bindings::initcall_modname {
+                        initcall_fn: Some(#ident_init),
+                        modname: #ident_modname_str.as_ptr().cast(),
+                    };
+
                 #[cfg(not(MODULE))]
                 #[no_mangle]
                 pub extern "C" fn #ident_init() -> ::kernel::ffi::c_int {
-- 
2.55.0

