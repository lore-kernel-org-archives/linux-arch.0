Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020088.outbound.protection.outlook.com [52.101.196.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC233B3BEC;
	Wed,  8 Jul 2026 02:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783476019; cv=fail; b=uXVXdk87PWnL+O8DjvjvzAU+Etgmr9NZxnaWlusa3bpYNqJdxTQPPE0mThHHvgmw4V5FPV0qDdMslzYxJHEy8QHm+iJ9Avlu9XB+fXDhTYduFb3ai/bed+OBEqeCRHlpZxu+GLc1TuDr4OBtMYa1It0ZZrQiuxa6ThHLG6ec+b4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783476019; c=relaxed/simple;
	bh=HCoOSv4KiptCu8TLxhvs1+0mSsAz91UsRy7+alR+Ezk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=GayhBvkN+gniTk/tNRH69N3+QWK96o+gxMIpwArXIULccBWfD06GlE0PbxFpDkInQSsegpc4hNOfTLivoC10FKDfsQKB2C2q+hb4/gunMmTRgZTCqjWtT8sjjONNNVhwwJ36aZqUzixGb6ITe6J/v+Xwwv/dGeMfL1MtPzFCdcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.196.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gQJo+hpwkryBipsOuayn3Xq8A3MAq7BAdfZVCL9IQ8xlgW9d47SyuqLXuBLFfrnS1BgOfuIa63C8Eeglcza5TjZXTucvgcDpD8T2RYAzTz0MV4l7zG/AXABN/KNyYGk+V8J90T6twoFhgxKS2L3prO+QpAr9UsEtJ8Jx4je5RyacJs5jfSejIYhJl3DQupk6P46advRucAJ4NnbfReNGEbx8ZHEngwI/7hiSjSBZj1QT7NxronTFCsT/M9sCMBK02pw4IfV9IgwZh6CU69ImuZcnI77+L1rzYcNtVnQchtZ1MpdatevQCfoKsG0dc4TwRFiz0hoYvcjPuF+u23czXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=IAoxglqmEj2baHz6K5OFmCYhey/UQ4t1T5QJ/krHXBE=;
 b=rAnOn2vGKH3+rW8qeeF5q6tQLQ8rYa6SkJOtpGMPNkX/V8Q3HxwZhUUGS4dH/wj0ctlYzckPv1M2WIo6icuPcOXHb86CZTzXHcGQW/0dKAZ1GxkHE56OppUAnK1se1ufZzUEI+KuESM+oZ8rI+n7MXaGH2lbejVNizhgmwvJl4i3oes3TiRCL6ceCr6TQpa6VE+TXf5DZ8FSAehZilNK6Gj3vGQx3AHF0uXIimmqshesUy3kb08BMqtz2718B6lVQXbM+iWr/P/jhFgn7cjbORGMr9BjugYP5OX5mdFm+GGOiV41x+HSsJqTqyb+NwKQOhERTu6DexVPzOBUpdCQ6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO6P123MB6376.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:2a2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 02:00:11 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0181.010; Wed, 8 Jul 2026
 02:00:11 +0000
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
Subject: [PATCH v4] module: Extend module_blacklist parameter to built-in modules
Date: Tue,  7 Jul 2026 22:00:07 -0400
Message-ID: <20260708020007.55728-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN1PR10CA0020.namprd10.prod.outlook.com
 (2603:10b6:408:e0::25) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO6P123MB6376:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bfc1761-f2ef-4b0d-f02f-08dedc94a4d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|18002099003|5023799004|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	0nYMRA+uyAiZ0J9BK19xCy6tDF6rg9O49HmATByCDo79iutFSEiwH8af1DH0eLaBfCIc8WF+c1+ym8UJhkHw9rw8NAKuKWnpw7mwWvsRMNZ6xLtWOn7ZWkwOv/zE3TOwY8iY+MgjnJCXhGXy3gkHTvAWVApGdfp8kZpmbsm5PaDPJS33QoAG1VDw8vKOPGJa4bSwCNfc8s2cWh8A0v7UqFExceStyBRikNYnFg+ZojKE0aFRGRZuYM6oyse6WicSJ6rqcl1OMNK5bFJuJNISiE2wdQMXVKvw3AYYMp4meCYbi0snHteAaANF/TORr8ndy0UVHF/m/oxYAkMXT4+a2hFIPCDhdZbnzIReLoYCGIxdWTbUKgO/PHDGqolyNT3DZBmB1NLkatPh9vU59L7tr9GDSQpoJBrhyEle0KHzXJpHL7xo0IgxkDueQoXH0AeWjssLy89YcC5rWw1VcYN2BVyBfDP0ic45+eyydSYzuZx29xxr980TOAY+yRkhQfGMmblV/4OSm56LRIq/T0IKNFiHTqMWicSiiMmt31olYPEdLLsNHiUJZTw9lR0XHm2oFU9bLk4CI9iiNuadXww1bH1y9RGwhPfWUChFLpqbh+hUpomHc9UnKueg2XGfGb1HgnRl/Womb5qkSmk3RgI7SUqd9JKu4fcpWB3/yc9mOCk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(18002099003)(5023799004)(6133799003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ErQ3gSQu1yCJIQmNatie0euPEE2qdlH/tgBroY/UEbupUPS6Cum6sFJFzc/V?=
 =?us-ascii?Q?mcGLdhxs7sukbm1742EN09XbjjyG+Qzpk7A752APoluYiLNhk+30N1I0IT+5?=
 =?us-ascii?Q?VVFlNcMRr0uLK2Vh3L/aGcEAunNinmXw9jSd7+AodxRcfPpPN16IFf2ppXIj?=
 =?us-ascii?Q?hqFfWPaGClYywFKsMA/zF0IhLBlfIMKZAzdvLFxPGuGKK3bXMarTjHWyUNt3?=
 =?us-ascii?Q?mI8xbKlrqKQjR98DndtZYbrlfegrn/UwgCNBhWeu6pYXcVAocJpIv/Tl4sU1?=
 =?us-ascii?Q?BXM9cEWL6vp8HwWYsaR/MCBYU428CTKBWEBYOiDBOk688oodIQgcwLgTqEY0?=
 =?us-ascii?Q?PRfjqoK/BtFed3MaBMJDxFZ0ZOJupjn1ggfeHuG1edFlPNplSQ1FIX59u7Fz?=
 =?us-ascii?Q?nJkIQXiIcD2BPSZLAzmbXcsGzIwLmW+w64+aQr7BuMo0fUpi8XuLixIx4Syw?=
 =?us-ascii?Q?WWMaz3px3xWysIMTvoNWYjAq+q1wQ75a2Ox+M0Wto9qkcLYL9FG8Oe3cqCRX?=
 =?us-ascii?Q?sRJnA+P1AgrkUZTUPm7TfQQh1BLD5D50noIhzZyMnvqa635qGEVbVcsBZUnY?=
 =?us-ascii?Q?zc3U2UHQuE2m1eaN1N+mkKK2n8vL6PZbNuGGIQt/qszStm67dj+6qOlnvXn6?=
 =?us-ascii?Q?1Jp0hMm4Pb0hkxTBsjaN+rT6s6MQdnLj8CWroufzQ39IUISosqSMR41T+pTL?=
 =?us-ascii?Q?aYkxILy3SLHbhXvayGVlZqNchj7UWZNud8KulLURF4SKPSQiJaW13CiAeP5S?=
 =?us-ascii?Q?Oe1xib77OtWRuY7zQ36bEOftejwOuKFDeihaiP81W+xrY6c7Z6EfRIrjWQNR?=
 =?us-ascii?Q?Ekw5o0lER6PBN7Ut9gMDLSGt9Wxj/EmNO6TXWlfO5tujpzc7BvrfUnVKJrZ4?=
 =?us-ascii?Q?IUcYirsIFZ3KFqB3ui2AK+WDbeVlD+VbCcSpoNjM7Dzl6j21FFgq2o6LeVkB?=
 =?us-ascii?Q?XZA4VxthFXGgPxPwDtJhtC8l23CudllWOhXnJveQ8F+oBjzsegvrjUWTtGNO?=
 =?us-ascii?Q?acthJ0bfpyvD/ABs/jdo7FS4Os2DS2aAYcZLHZvTUH+U1FirNbbhynYH1fe9?=
 =?us-ascii?Q?UsuQGQmdDswf3HBu6cXEDPdkhXsOLDWkldhZdhXLG6JGUAIotuvxqjQ6Xvas?=
 =?us-ascii?Q?i0W585RarMmGavs+j2dOVWTaxipoKUtWtgbcVNG9ByhouyavHqULmsaNIHnz?=
 =?us-ascii?Q?LxlqQDQvO7QrDDLkmavXJLMNS522/i0v38mlAAfEBSz3v+o4PRDcpUUSezjh?=
 =?us-ascii?Q?GUILPGAiAu/fcebaen8QneeEPWayc82MR31siP5D/S/Ysq+RIqgZC6mXRXxW?=
 =?us-ascii?Q?1Cg7g4UAnPJ4vdsmve14iVedxdUzthP3DJJbNy6PfQGYHLRRXg1tfQmjgWvf?=
 =?us-ascii?Q?xaMTxtwexU6ugCCi2cywy+lLN5VnE9Bw8CmH/xKsPXvXT/CoeaCrFKT6oE6s?=
 =?us-ascii?Q?zcRZtj5SdEO46jpZi+yY39FIs73tUt8z2D0do3yHeYm7f8lqIz1AsZCPMJKM?=
 =?us-ascii?Q?T35AWvVU1SaQlEH0M+7cyQmWFAbwM6Ktk5ZTkIFgqEf4JyHbaXnUzlXxgXwA?=
 =?us-ascii?Q?wuTP0GRH6+hlQYwHQeJgRzQCWwxup01WkPhmqGh+Q33ftTjjRgKZ4Ocwd42Y?=
 =?us-ascii?Q?KBuSkkDPpiWE0h7dm0xnquRFIbYE5sTkJEUMEtlVJ8gWNROR2XqbhLIaA/3N?=
 =?us-ascii?Q?MDd9JAvPJUae6XpC8vnWCw/61HsklJQ66k2nCbibowKqdnc8AQYD02kMt7XX?=
 =?us-ascii?Q?8RvlzNaXlw=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bfc1761-f2ef-4b0d-f02f-08dedc94a4d6
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 02:00:11.3949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tL76rTxFMau1kI9csed2kCXzGQdrGQmWzYqAdFoIB+uyIQ9p2sNcCBVfwcca6jdKWgMWLau2ekTQXibjOVhABQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P123MB6376

Currently, the "module_blacklist=" command-line parameter only applies
to loadable modules. If a module is built-in, the parameter is silently
ignored. This patch extends the blacklisting functionality to built-in
modules by intercepting their initialisation routines during early boot.

To preserve the existing user-space ABI, "module_blacklist=" is kept
as a legacy alias pointing to the same module_denylist variable.

To achieve this, we introduce a new ".initcall.modnames" memory section.
For each built-in module, we use a standard C structure (i.e., struct
initcall_modname) to map its initcall function pointer to its associated
KBUILD_MODNAME string.

During boot, do_one_initcall() cross-references the initcall function
pointer against this table. If a match is found and the module is
present in the denylist, the initcall is skipped.

To make the denylist functional on monolithic kernels, the command-line
parameter parsing and the module_is_denylisted() lookup function are
decoupled from the loadable module subsystem and moved to init/main.c.
This enables "module_denylist=" and "module_blacklist=" to intercept
built-in modules even on kernels built with CONFIG_MODULES=n.

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
        minor spatial optimisation of PREL32 (using absolute 64-bit
        pointers instead) to guarantee architectural safety under modern
        compiler protections. Because this metadata is placed in an
        ".init" section and freed entirely after boot, the temporary
        memory overhead is negligible.

    2.  Prevention of UAF (Use-After-Free) via temporal and spatial
        boundaries:

        Because do_one_initcall() is a shared path invoked by both the
        early boot process and runtime module loading (i.e.,
        do_init_module()), we must prevent loadable modules from
        attempting to scan the ".initcall.modnames" section after it has
        been reclaimed by free_initmem().

        To ensure safety, we employ a two-fold validation check:
        - A temporal check using 'system_state >= SYSTEM_FREEING_INITMEM'
          to immediately return NULL once init memory is freed.
        - A spatial check using 'is_kernel_text()' and
          'is_kernel_inittext()' to confirm the function resides in core
          kernel text.

        Since dynamically loaded modules reside in separately allocated
        module memory outside these ranges, they bypass the table lookup
        entirely. This makes the lookup lockless, race-free, and safe
        from UAF vulnerabilities.

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
Changes since v3:

 - Renamed the external function prototype and internal helper to
   module_is_denylisted(), while updating the backing variable in
   main.c to module_denylist. To preserve user-space compatibility
   while adopting modern terminology, separate core_param entries have
   been introduced, allowing both the preferred module_denylist=
   parameter and the legacy module_blacklist= parameter to resolve to
   the same underlying variable (Andrew Morton)

 - I introduced the __initcall_fn_ptr() macro helper to dynamically
   resolve the initcall pointer configuration:
    - For architectures with relative 32-bit relocations
      (CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y), it resolves to the
      relocation stub pointer  __initcall_stub(fn, __iid, id)
    - For architectures without PREL32 relocations, it resolves
      directly to the function pointer fn

 - Decoupled the module_denylist parameter parsing and the
   module_is_denylisted() function from CONFIG_MODULES, moving the
   logic to init/main.c. This ensures the denylist works for built-in
   modules even on monolithic kernels built without loadable module
   support (CONFIG_MODULES=n)

 - Removed the conditional stub implementation of
   module_is_denylisted() in module.h and replaced it with a single,
   unconditional declaration outside of the #ifdef CONFIG_MODULES block.
   This prevents compiler warnings about missing prototypes and ensures
   visibility under a monolithic configuration

 - Replaced the initmem_freed state variable and its synchronisation
   logic in kernel_init() with race-free spatial boundary checks using
   is_kernel_text() and is_kernel_inittext() in initcall_get_modname()

 - Aligned the .initcall_modnames table with relocations by assigning
   .initcall_fn using the __initcall_stub() helper in
   ___define_initcall(). This ensures the lookup matches the actual stub
   pointer passed to do_one_initcall() when
   CONFIG_HAVE_ARCH_PREL32_RELOCATIONS is enabled. Passed the preprocessor
   __iid argument to ____define_initcall_modname once to avoid double
   evaluation of __COUNTER__ (which caused build failures with LTO)

 - Updated initcall_get_modname() in main.c to resolve the function
   pointer fn using dereference_function_descriptor(fn) prior to
   checking the .text and .init.text boundaries, and dereference both
   fn and p->initcall_fn in the comparison loop to support descriptor-based
   architectures (e.g., PPC64)

 - Linked to v3: https://lore.kernel.org/lkml/20260706050337.7613-1-atomlin@atomlin.com/

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
   "module_blacklist=" and new "module_blacklist=" to intercept built-in
   modules at boot (Petr Pavlu)

 - Implemented 32-bit relative offsets (CONFIG_HAVE_ARCH_PREL32_RELOCATIONS)
   to store the mappings, preventing binary bloat and preserving KASLR
   efficacy

 - Linked to v1: https://lore.kernel.org/lkml/20260510061301.41341-1-atomlin@atomlin.com/
---
 include/asm-generic/vmlinux.lds.h |  4 ++-
 include/linux/init.h              | 26 +++++++++++++--
 include/linux/module.h            |  2 ++
 init/main.c                       | 53 +++++++++++++++++++++++++++++++
 kernel/module/main.c              | 24 ++------------
 5 files changed, 84 insertions(+), 25 deletions(-)

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
index 40331923b9f4..9c78b6c30361 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -271,8 +271,30 @@ extern struct module __this_module;
 		__initcall_name(initcall, __iid, id),		\
 		__initcall_section(__sec, __iid))
 
-#define ___define_initcall(fn, id, __sec)			\
-	__unique_initcall(fn, id, __sec, __initcall_id(fn))
+#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
+#define __initcall_fn_ptr(fn, __iid, id)	__initcall_stub(fn, __iid, id)
+#else
+#define __initcall_fn_ptr(fn, __iid, id)	fn
+#endif
+
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
+		__section(".initcall.modnames") = {			\
+			.initcall_fn = __initcall_fn_ptr(fn, __iid, id), \
+			.modname = __initstr_##fn			\
+		};
+
+#define ___define_initcall(fn, id, __sec)				\
+	____define_initcall_modname(fn, id, __sec, __initcall_id(fn))
+
 
 #define __define_initcall(fn, id) ___define_initcall(fn, id, .initcall##id)
 
diff --git a/include/linux/module.h b/include/linux/module.h
index 7566815fabbe..bc2968c225e1 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -883,6 +883,8 @@ static inline void module_for_each_mod(int(*func)(struct module *mod, void *data
 }
 #endif /* CONFIG_MODULES */
 
+extern bool module_is_denylisted(const char *module_name);
+
 #ifdef CONFIG_SYSFS
 extern struct kset *module_kset;
 extern const struct kobj_type module_ktype;
diff --git a/init/main.c b/init/main.c
index e363232b428b..af71811d24e3 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1334,12 +1334,65 @@ static inline void do_trace_initcall_level(const char *level)
 }
 #endif /* !TRACEPOINTS_ENABLED */
 
+extern struct initcall_modname __start_initcall_modnames[];
+extern struct initcall_modname __stop_initcall_modnames[];
+
+/* module_denylist is a comma-separated list of module names */
+static char *module_denylist;
+bool module_is_denylisted(const char *module_name)
+{
+	const char *p;
+	size_t len;
+
+	if (!module_denylist)
+		return false;
+
+	for (p = module_denylist; *p; p += len) {
+		len = strcspn(p, ",");
+		if (strlen(module_name) == len && !memcmp(module_name, p, len))
+			return true;
+		if (p[len] == ',')
+			len++;
+	}
+	return false;
+}
+core_param(module_denylist, module_denylist, charp, 0400);
+core_param(module_blacklist, module_denylist, charp, 0400);
+
+static const char *initcall_get_modname(initcall_t fn)
+{
+	struct initcall_modname *p;
+	unsigned long addr = (unsigned long)dereference_function_descriptor(fn);
+
+	if (system_state >= SYSTEM_FREEING_INITMEM)
+		return NULL;
+
+	if (!is_kernel_text(addr) &&
+	    !is_kernel_inittext(addr))
+		return NULL;
+
+	for (p = __start_initcall_modnames; p < __stop_initcall_modnames; p++) {
+		if (dereference_function_descriptor(p->initcall_fn) ==
+		    dereference_function_descriptor(fn))
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
+	if (modname && module_is_denylisted(modname)) {
+		pr_info("Skipping initcall for blacklisted built-in module %s\n",
+			modname);
+		return 0;
+	}
+
 	if (initcall_blacklisted(fn))
 		return -EPERM;
 
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 46dd8d25a605..e6d9c52b9786 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2919,26 +2919,6 @@ int __weak module_frob_arch_sections(Elf_Ehdr *hdr,
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
-		if (strlen(module_name) == len && !memcmp(module_name, p, len))
-			return true;
-		if (p[len] == ',')
-			len++;
-	}
-	return false;
-}
-core_param(module_blacklist, module_blacklist, charp, 0400);
 
 static struct module *layout_and_allocate(struct load_info *info, int flags)
 {
@@ -3389,9 +3369,9 @@ static int early_mod_check(struct load_info *info, int flags)
 
 	/*
 	 * Now that we know we have the correct module name, check
-	 * if it's blacklisted.
+	 * if it's denylisted.
 	 */
-	if (blacklisted(info->name)) {
+	if (module_is_denylisted(info->name)) {
 		pr_err("Module %s is blacklisted\n", info->name);
 		return -EPERM;
 	}
-- 
2.54.0

