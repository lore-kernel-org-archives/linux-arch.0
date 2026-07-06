Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022084.outbound.protection.outlook.com [52.101.101.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929322459C5;
	Mon,  6 Jul 2026 05:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783314226; cv=fail; b=cpOEwWB4n/eYt5Q69aZUJvKJp7+U6SkY/Q3WFauHehInTii+yt+naJxooSJl5QFn1ywmnuyntZzRAMXUZJ1vqGvyVHQ3eneJzcixeGlIQCLpKiOTkpt93WyeEOiIagdcGyEcNBtsa5yoLnlTdngkU9PoZzGzrs62JV5ScS9coPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783314226; c=relaxed/simple;
	bh=bylSEdSMcG3OpvnN7K0m+bY0XzeW4wEkIPrQNyIyEU0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=kEcO8NzCWw49ebxxAV9hWRk2jWK+oWJXBczmb3hFLZ4z9UuBQrFpdkjDJuKk3ZhZRGPqMZRuoAbZz/IBoVahBp4J6qDD7opctzsxVponOSdwLJzyvZdjm2RWluDE8ASI62FujM4SNjXA8+f0aM+YX6bxo4IWRbzImSStzODgiBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oYkA/Ocz1CDJBqFnxv7GvTx4AZDV3FcSDmYZW4y3zNNUiURP9HJ3Nnk82sR0H0YY0I2mU0a+NsshgDVgCJPHK1NElf9OgPphZ0LY3MBCvp2jmCd1KPRxB7euQpDY+JX8uIiCZ/sq9w6rmEp7VKZIjcCyemRA7TWvV6gfVhMRw6a6IcRlJaMKse0QQb0Oofc4KrpFvLj76iwrjgzKASfO75Ur0rHwK7lXLxa2BRMUepZ7eBz8kPpHvNygth0x0jCp4XEEq6bwQP6bDgef8+ghXqp4S+9zkh7N5ADr42s+ncODZYtA+CoVQiStYrKF8eOzrMF4LbvIAFWdwdwajLPSzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=qR4qUBKJDrQMJg93xbpmSB0cL5GxXfdkA8UTqs2TwFY=;
 b=qgnQGvmtold0IEDw7XIW/Th/QTQr+QcIBEUXTy4x4iqOomeX9x4rC1e5erQnUOGXWlsNCy4YWXUV61VG/MmWybiwgEoBklN+q3PYMf2UonSoVnBTcMuIN5FWY0SzXRxxdDVL4xrLUGTsDsHplBwArhPDHd09YpSr4Lz+21VHdV82nH799SmovdquYhRrwVvW+9PVFGL+9tP9+PWZOiU7sXgLNmMhFfN9QIqaTnPEQkd1yrXTGjei7S9k+ysPIneE9I6tGRF427BlSwu8eiWqlFYcGLiVzQulb6/uV8zJ7/qcJ/bRrscyBqiSFj639uRhmnRG56FYr7xatSMRcYRBEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CWLP123MB3347.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:61::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Mon, 6 Jul
 2026 05:03:41 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0181.010; Mon, 6 Jul 2026
 05:03:40 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: arnd@arndb.de,
	mcgrof@kernel.org,
	petr.pavlu@suse.com,
	da.gomez@kernel.org,
	samitolvanen@google.com,
	peterz@infradead.org
Cc: akpm@linux-foundation.org,
	mhiramat@kernel.org,
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] module: Extend module_blacklist parameter to built-in modules
Date: Mon,  6 Jul 2026 01:03:37 -0400
Message-ID: <20260706050337.7613-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9P222CA0008.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:408:10c::13) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CWLP123MB3347:EE_
X-MS-Office365-Filtering-Correlation-Id: bb1b2e2e-d05d-4aa9-4358-08dedb1bf231
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|18002099003|5023799004|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	xLv5K/Sp4JJnFq8yVEYrU4Yhy97tkK2bE5ElDW61k+JS+Yl8AcyzjaaNxYazw1Ek3wG+wgWDWYKy6qSnzb0/+ZpayqeMnljnwgymUSco8Xb95Tp57mvO4o3LIIsyLHWEe5+za80DKoWia2aJiPoIK/wigk5gfsUhUe4TN+/jVwjCz5xM3KC1cJa2LVvcI7SSelLm5JFsPGFnk4HSzYuy+jiCKkZKonlvrbw0EhE3KcUa6PsvX8k7i+3BwDrZL8gwwCLig/PbY/HAY6Vck1kZjX/rb3RdhTBhkvxvVf6o5fbByC0K0SWVESK9uDmjmkEnQjoBXzrj0pl6uDnyvpEvmC39O+4dezIohuYZQQAhyf3WLTeNQzs+69qCqHl42watFC3uk6MY/AYWF8D4EmRlFXvgKEgD0TytRfhSDh7GpeekzZysMx476hOSkDyf7SZQxMbqhrl8G0QudeliT+yNUbtVAN2Eyb5RsDGWY0/3VNkTpaOam6K0Jj8DC7RETTmb708P0nJhu0Y/UEw/yKhk8KMYY1WZdrMQaYwiGfUpgRZzjKKIvjOin137SguD20b1vPdZXNapskJ3VuRwkj54lCmHriJ5MRQDy9wrxCfilPb8Ul2BceNGsTMsRcqqbCWkr9LKh2V/1Fg1Y2Ddex7LS6tUo1/o1y1ykNVMGibXnCs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(18002099003)(5023799004)(56012099006)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HSEzlx6xlfBoLAknxIpEhKBZcYLekavmStMHhSZzCr3ixKKWoDa8ttyV/3CU?=
 =?us-ascii?Q?bRZq1gw919DGG9QMC0mGRxYYnU067vG19Q0U+6T2a6KglBrPNesNXyFF705O?=
 =?us-ascii?Q?4GbSXQf3zq3VBmF4m9ulcFgM4mjEqJstgdzUlnsDVpIKieXOcD7+aXYfZoqI?=
 =?us-ascii?Q?xLRTDQZ6d8rBVpAR4vHcT0LyI+T/81vkeo0E4CYO9FRiVHTfkJY+po+EjQa5?=
 =?us-ascii?Q?2hKek7EJPz1xNnlpyHjZqhMjdtPDlWnQpxVPx8KohSuLzTpt7O1jfTxiALSR?=
 =?us-ascii?Q?kgkQ9j4ZKY+/hFJdYzFWCeW6hcUkvbqQJGFpNkRfX0pGzTDWIW4WWpyqUIhw?=
 =?us-ascii?Q?IJeM351EeJ9+k7LYUB2NpTul8UaMqrDJ1fY5xEGLfKNNXOv9NvcBg+n73rhZ?=
 =?us-ascii?Q?D0GiXUPVANyYVYnLeL/Oofd+oaHpHo5asBI99Vpr8W6enVhOrHaXKzUpvSZC?=
 =?us-ascii?Q?3IH6IV4QtU9dz/e+j82CA4m4S1mPhp453R+iSqMfFznSjJPuK0AGytHLcoJy?=
 =?us-ascii?Q?p+edrbQg5V/QB5ABe/tlht13cjdhlVptCYgAMTH9iTP1NVOF5iBjZSkLbZvn?=
 =?us-ascii?Q?sD6zAlV2XLh6exi8DZ+CtUpyoo6cCzgNRYY5ebSTWSbvPXh1OlCHUlQURmbZ?=
 =?us-ascii?Q?zIxANqjV3fxgbSO5IFWCEvo4bTy3M6pN/BFRkewPS9vyobzMWA1YiRtqERp4?=
 =?us-ascii?Q?nuElyfkYG6okTDtjXcNJ+wDDLvOQRn/6O0VSpB9gceQR//IvfKnOfWSiAMwT?=
 =?us-ascii?Q?yKQB4lKJpTCnyH7BD3bFSvbGKSgLeJWT0s5D7dZQKZtvF5L68AIpv+XwVYoG?=
 =?us-ascii?Q?rf4XlWRWURjAILjLFOYqFFGRdSLKnpR5sGLacmaWrwl3DrFyxNXVDsz/CwV4?=
 =?us-ascii?Q?mqtLIj6c/FPoGyY1KlaIvxuetFTDT7LzQ9HRyusI25qQRZwKbh+rW0pk5gRn?=
 =?us-ascii?Q?ZIW42kbvjSLlUA5hbm8AZ/c/j8IodDdiMwxf92A+LpNZTw02aAPWLnmTDu8O?=
 =?us-ascii?Q?VJrJZo5axSbVmarvwtSJBhugyswLPJ2pX2SzOZwKwj14nr4ntLZN0wGnfV6N?=
 =?us-ascii?Q?TFkHenhoYicQYtmaiOtVXu1+HTiSlY0Iib8+a0mlLOZPg14ZS43mEHMfoHzS?=
 =?us-ascii?Q?+Q3KUi7hQYTYAwwMExihuhbOLXfWs7w2DmhCMQNelqJDBHnwloA1wRfesiSX?=
 =?us-ascii?Q?YVNgzaH2vvu6gqpoCzkShPwWLFpf6Rj8zulXUlmVGNvW8HCISSjL4JZEnLw+?=
 =?us-ascii?Q?uGXwkE1+kU8f+WFLWEfed70uxvz6J5i8qg+cUlzRY0hToDqiIFke7lWKoeBe?=
 =?us-ascii?Q?Hd2QQcPAxhJEhxiOvIe/0nG85NgM9+yEWHbCWA/cNsWNvEo4sdjll6eNw3k5?=
 =?us-ascii?Q?fwpLpfmG0na8tY/Trj5MkpNC/AHotFzYws/Ai92ZxrmvM/N783GWoz8l8QlA?=
 =?us-ascii?Q?hWwAi7w38EqTpqCT/qHwUh/XLcvp3/bwUI+psFJryBU3WDlpkPapmpnfrk1x?=
 =?us-ascii?Q?exJ2bDutxyvTc9pHBUTig1fDw3bgJTZfgVhHvOdyHuZKd5jjZmg9s8KvsCrG?=
 =?us-ascii?Q?HtFRvPwm4MxpVmGBYDemRc+SuHC4SvoPHCJp3QpmKuXnGsuwzVIBY2rli3cv?=
 =?us-ascii?Q?yYHCFTT9yPG11Jo9fCsJJ6Kq7ptx1lDnVYOYZ0QyNh/ZiCnCm3CinwKAYJPA?=
 =?us-ascii?Q?GTUqC/992MIDoOLudQTx1qNPLUu8ElJ1Vw5jnSpsHtgH8i/D7WhAoVj+3LOS?=
 =?us-ascii?Q?I8LxWWqaSg=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb1b2e2e-d05d-4aa9-4358-08dedb1bf231
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 05:03:40.8458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: memnEsk8jZ/PNtAo6tIoMuBNE3HcGzJfN0gcD/SQ0y1aqbJ5kXUmZkAmL+VDVsDJ+s8V67hc1G92bu0AUin38g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB3347

Currently, the "module_blacklist=" command-line parameter only applies to
loadable modules. If a module is built-in, the parameter is silently
ignored. This patch extends the blacklisting functionality to built-in
modules by intercepting their initialization routines during early boot.

To achieve this, we introduce a new ".initcall.modnames" memory section.
For each built-in module, we use a standard C structure (i.e., struct
initcall_modname) to map its initcall function pointer to its associated
KBUILD_MODNAME string.

During boot, do_one_initcall() cross-references the initcall function
pointer against this table. If a match is found and the module is
present in the blacklist, the initcall is skipped.

Design Considerations and Trade-offs:

    1.  LTO and CFI Compatibility vs. PREL32

        Previous iterations of this patch attempted to use top-level
        inline assembly to generate 32-bit relative offsets (PREL32) to
        save memory. However, raw inline assembly operates blindly
        outside of the C compiler's visibility. When compiled with
        CONFIG_LTO_CLANG or CONFIG_CFI_CLANG, the compiler applies
        symbol renaming and generates Control Flow Integrity stubs.
        The raw assembly string-matching fails to track these changes,
        resulting in undefined references or runtime address mismatches.

        To resolve this, we strictly use standard C structures to hold
        the function pointers. This natively allows the compiler to
        resolve LTO renaming and map CFI stubs correctly. We trade the
        minor spatial optimization of PREL32 (using absolute 64-bit
        pointers instead) to guarantee architectural safety under modern
        compiler protections. Because this metadata is placed in an
        ".init" section and freed entirely after boot, the temporary
        memory overhead is negligible.

    2.  Prevention of UAF (Use-After-Free):

        Because do_one_initcall() is a shared path invoked by both the
        early boot process and runtime module loading (i.e.,
        do_init_module()), we must prevent loadable modules from
        attempting to scan the ".initcall.modnames" section after it has
        been reclaimed by free_initmem(). We introduce a strictly
        serialised 'initmem_freed' flag, locked by '__ro_after_init', to
        safely bypass the built-in lookup for loadable modules. Loadable
        modules are instead checked against the blacklist directly
        inside do_init_module() before their initcalls are invoked.

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
Changes since v2:

 - Avoided relative 32-bit offsets (PREL32) with inline assembly, opting
   instead for standard C structures with absolute pointers. This fixes LTO
   and CFI compatibility issues (e.g., under Clang) where raw inline assembly
   fails to track compiler-generated symbols and CFI stubs

 - Placed module name strings into the ".init.rodata" section via a dedicated
   static array to ensure they are freed from memory after boot

 - Avoided Use-After-Free (UAF) bugs post-boot when loading dynamic modules:
   - Added an 'initmem_freed' flag, marked as '__ro_after_init', set after
     free_initmem() to skip table lookups for dynamically loaded modules
   - Added a blacklist check in do_init_module() for dynamic modules

 - Simplified the linker script using the BOUNDED_SECTION_PRE_LABEL() macro
   to define the ".initcall.modnames" section boundary

 - Added a dummy/stub implementation of module_is_blacklisted() when
   CONFIG_MODULES is disabled to avoid build errors

 - Linked to v2: https://lore.kernel.org/lkml/20260622140259.2974-1-atomlin@atomlin.com/

Changes since v1:

 - Pivoted entirely from exposing built-in initcalls and their blacklist
   status via a debugfs interface to directly extending the existing
   "module_blacklist=" to intercept built-in modules at boot (Petr Pavlu)

 - Implemented 32-bit relative offsets (CONFIG_HAVE_ARCH_PREL32_RELOCATIONS)
   to store the mappings, preventing binary bloat and preserving KASLR
   efficacy

 - Linked to v1: https://lore.kernel.org/lkml/20260510061301.41341-1-atomlin@atomlin.com/
---
 include/asm-generic/vmlinux.lds.h |  4 +++-
 include/linux/init.h              | 14 +++++++++++++-
 include/linux/module.h            |  9 +++++++++
 init/main.c                       | 28 ++++++++++++++++++++++++++++
 kernel/module/main.c              |  8 ++++++--
 5 files changed, 59 insertions(+), 4 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 5659f4b5a125..fc863595743e 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -734,7 +734,9 @@
 	EARLYCON_TABLE()						\
 	LSM_TABLE()							\
 	EARLY_LSM_TABLE()						\
-	KUNIT_INIT_TABLE()
+	KUNIT_INIT_TABLE()						\
+	. = ALIGN(8);							\
+	BOUNDED_SECTION_PRE_LABEL(.initcall.modnames, initcall_modnames, __start_, __stop_)
 
 #define INIT_TEXT							\
 	*(.init.text .init.text.*)					\
diff --git a/include/linux/init.h b/include/linux/init.h
index 40331923b9f4..c0db1a6a0191 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -271,8 +271,20 @@ extern struct module __this_module;
 		__initcall_name(initcall, __iid, id),		\
 		__initcall_section(__sec, __iid))
 
+struct initcall_modname {
+	initcall_t initcall_fn;
+	const char *modname;
+};
+
 #define ___define_initcall(fn, id, __sec)			\
-	__unique_initcall(fn, id, __sec, __initcall_id(fn))
+	__unique_initcall(fn, id, __sec, __initcall_id(fn))		\
+	static const char __initstr_##fn[] __used __aligned(1)		\
+		__section(".init.rodata") = KBUILD_MODNAME;		\
+	static const struct initcall_modname __modname_##fn __used	\
+		__section(".initcall.modnames") = {			\
+			.initcall_fn = fn,				\
+			.modname = __initstr_##fn			\
+		};
 
 #define __define_initcall(fn, id) ___define_initcall(fn, id, .initcall##id)
 
diff --git a/include/linux/module.h b/include/linux/module.h
index 7566815fabbe..b9b0dc419aee 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -756,6 +756,15 @@ void *dereference_module_function_descriptor(struct module *mod, void *ptr);
 int register_module_notifier(struct notifier_block *nb);
 int unregister_module_notifier(struct notifier_block *nb);
 
+#ifdef CONFIG_MODULES
+extern bool module_is_blacklisted(const char *module_name);
+#else
+static inline bool module_is_blacklisted(const char *module_name)
+{
+	return false;
+}
+#endif
+
 extern void print_modules(void);
 
 static inline bool module_requested_async_probing(struct module *module)
diff --git a/init/main.c b/init/main.c
index e363232b428b..918e6e9442a8 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1334,12 +1334,39 @@ static inline void do_trace_initcall_level(const char *level)
 }
 #endif /* !TRACEPOINTS_ENABLED */
 
+extern struct initcall_modname __start_initcall_modnames[];
+extern struct initcall_modname __stop_initcall_modnames[];
+
+static bool initmem_freed __ro_after_init = false;
+
+static const char *initcall_get_modname(initcall_t fn)
+{
+	struct initcall_modname *p;
+
+	if (initmem_freed)
+		return NULL;
+
+	for (p = __start_initcall_modnames; p < __stop_initcall_modnames; p++) {
+		if (p->initcall_fn == fn)
+			return p->modname;
+	}
+	return NULL;
+}
+
 int __init_or_module do_one_initcall(initcall_t fn)
 {
 	int count = preempt_count();
 	char msgbuf[64];
+	const char *modname;
 	int ret;
 
+	modname = initcall_get_modname(fn);
+	if (modname && module_is_blacklisted(modname)) {
+		pr_info("Skipping initcall for blacklisted built-in module %s\n",
+			modname);
+		return 0;
+	}
+
 	if (initcall_blacklisted(fn))
 		return -EPERM;
 
@@ -1555,6 +1582,7 @@ static int __ref kernel_init(void *unused)
 	kgdb_free_init_mem();
 	exit_boot_config();
 	free_initmem();
+	initmem_freed = true;
 	mark_readonly();
 
 	/*
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 46dd8d25a605..2a467a8ee551 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2921,7 +2921,7 @@ int __weak module_frob_arch_sections(Elf_Ehdr *hdr,
 
 /* module_blacklist is a comma-separated list of module names */
 static char *module_blacklist;
-static bool blacklisted(const char *module_name)
+bool module_is_blacklisted(const char *module_name)
 {
 	const char *p;
 	size_t len;
@@ -3090,6 +3090,10 @@ static noinline int do_init_module(struct module *mod)
 		}
 	}
 #endif
+	if (module_is_blacklisted(mod->name)) {
+		pr_info("Module %s is blacklisted\n", mod->name);
+		return -EPERM;
+	}
 
 	freeinit = kmalloc_obj(*freeinit);
 	if (!freeinit) {
@@ -3391,7 +3395,7 @@ static int early_mod_check(struct load_info *info, int flags)
 	 * Now that we know we have the correct module name, check
 	 * if it's blacklisted.
 	 */
-	if (blacklisted(info->name)) {
+	if (module_is_blacklisted(info->name)) {
 		pr_err("Module %s is blacklisted\n", info->name);
 		return -EPERM;
 	}
-- 
2.54.0

