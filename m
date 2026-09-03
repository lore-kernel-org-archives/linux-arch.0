Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020115.outbound.protection.outlook.com [52.101.195.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F2F3CF1E1;
	Thu,  3 Sep 2026 18:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788461776; cv=fail; b=VhHeGLoOojRU0ZHrIqtN0Jdlm0q0L4MQ+hmO8UsJCl6qvbi64npGn+vwbSG9W113uU5/4DfpSDerdJEJiJto+6ySptb1bH0OPyvBmSvz+Olbz/zUJch9cmsCE/yqbrHaAixrlGmlSyZsXR+oRdMIpD716+kXlgC9VnEn/fkLJcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788461776; c=relaxed/simple;
	bh=5yI/NMi3wC196t5GSrerXtSP6OAHOJDpxeTUWCZDcOA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=aVF/11H15/PsGT8i7EBsiSFRAGEvoBw0CM9oOQ0c1xPfUM0jFi9deaLtBO3nDj75JqNvO6FUjsfY1QO3c0vqvH8Kh8Oz+GoKffcfSh/kGfrsqNbC0o81onGQntSDb5VfywtTWff/JBJ48NBMb+tpiZP5Ci7mYxuKAlPmSexaqn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.195.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UwbtCqE7gasW5rhVlXo9d19aVtFOJsiHqkVrPK5TFTd/xnQ/0AuJsWrJb8lBt/by1mc3kZC/Pm9P0qCaRQ2UNsZUDu+jvzsgSzdj090OaAhFfauc4CqnnyczmO5JEq96vTn/TbG+CC3SBzOJFyOMUg5/SjZXNu+v9942OGsPZ2+4Kn/hSvsU7o0iOP2twO3Mmos2iwF3I6+JrLLC7xfOufuECoQuX8wybWsxwWOW3iZzAAIb5wlHnWld3t5rLI046eOhCsg3MNrFymhv83giVmD1bTCLFbeGiRQC3YkVNjhK0V/LqDRfPflgw0AwW/SrgGz//MfcaYnsz3tZDi/m5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=+0to+0zcIwNiaUx1usqB7wh33opGB3PLR4e76ujhjr0=;
 b=j6Vat78jZmGWrMk5wZXMzgk4OsDP0ANLt4wgVpzIVtnccNPnt9KC/x+PttxBKI+LLIH0m5JXVlLJwEPTt/5RL+L29NgyOaCatl1iwpNG+a6tbEmC4WvvKjtq5yzXhzy4pDkpFbFnoKUs4DHIsa/TihW3epegQhv3waACSRLk72o250x6mZQL/5UBQCRJWBRbDC5dJ1fy2nJ0riPE7pPSHkNx/9vwVSema0OrdaKA+DSdOzAgbly1lJp4ScwLkuo9WSxHs7xMUY8LzQmYzSnSHA+e1IWoptmr2H8ED2QhF0+qdd0UkE1aSpnyySko4gs9QgUzoK6MqWrGtK7qGySgLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CWXP123MB3048.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:38::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 18:56:01 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 18:56:01 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: arnd@arndb.de,
	mcgrof@kernel.org,
	petr.pavlu@suse.com,
	da.gomez@kernel.org,
	samitolvanen@google.com,
	peterz@infradead.org,
	ojeda@kernel.org
Cc: akpm@linux-foundation.org,
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
Subject: [PATCH v10 0/2] module: Extend module_blacklist parameter to built-in modules
Date: Thu,  3 Sep 2026 14:55:55 -0400
Message-ID: <20260903185557.183224-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0076.namprd03.prod.outlook.com
 (2603:10b6:610:cc::21) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CWXP123MB3048:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a9ca71c-754f-4faa-13dd-08df09ecff75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|10067099003|3023799007|6133799003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	0KridSh2SYz0wNgdz94gmKiu5Fd4vrwtbWG+lCsf8C6KtEpTEIp4g4HizNiv0Vtf0L/qMjIrIBvBU1BI6KMF/ugI3WUt53U7+xNjAKo6cDyguK0TMarG6ZRgoxq3jmypHVdMLv6N16a7nvwVjBpNReGPKSNKxrdpuPAxVVyQtkQLfnxsMi0Cd+FsbSJvxu8+/27mtQfNpXhWFzAfpuTCokr33OkA8O9tGCzCJI3q/tOO0i+ltlAZ9QuczHrqSgEXy2ABTot08oNnskqgoqU9DtD3kuIJJTaWefGActE4KLPfVyZj8ZGDAlnxuMdWp7ZQKZxFB8dfWCo1zmnjD8EMAw1f8e+gTjJV5I/+Dl5Tu9fOelHxQxQi3oUnH4Yd8ZWUUKG/GvTjeJEDiA6VQvjP+u/rpu0PnyMEU2z6tlhIu/tgIJUAeLn9jzoxB+v3/P1949RrgqEDLEnyMSbzCLShnXmW7Crnma6U37dPeIamkRzQtR2wWPgYqQPKOl+Z1s2DM6PcZbAYtpvY5/7H50JnjmVnuEAcdK8VnrXopnZvzlqbWGsVjNfWSVCdbtHEgRGWFa0YURVEhc5xzt40E8o7SMa+hLP+rQCxtfdmWWP4Og9mXiYduP7OXi9LTaEQoWZLyaaLll+CXzrxbd9Y1mKABH8bJbolgg7M/7iG/v1oKdk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(10067099003)(3023799007)(6133799003)(56012099006)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Tr3fjiPSrkW5IFMhWNj6JdZbF7EfDu4juNZy6u2GsLpFnLAdO5ngePmHyBpB?=
 =?us-ascii?Q?53PP46pQg506y4wQRCnul5Px84xGCL3jHG3w8Co9N+/B0x+S3rLRaEnZ2PFR?=
 =?us-ascii?Q?wtMMHWLnzCLwg0K/HzZCkb5HG7CRS1nwsqterFd3XFTXBqgx9LeQmTAUoHoQ?=
 =?us-ascii?Q?Z4wYKtawK7MpP6Yhz4uUP0VBmR58l0hNemV9X4uSkoC00P3jpR1s7yfdCaiK?=
 =?us-ascii?Q?ozxkI/3uXWFzCHN+giAJ1bpXrWiD/YShZVYse0q9nJIP3tbtbWMMJx0+mHpS?=
 =?us-ascii?Q?NGJIlCyRMkz+lfqpTUD6+TV75+O5YWP6u5UbT5RmhdA4Jyd5XU9Pfp1ASy14?=
 =?us-ascii?Q?tiX1h5AmCgIiU4tzs/P6qzeGRU4Cn6/jBktfd7k/uxAOb6Cm1q5esrY7Pslk?=
 =?us-ascii?Q?+/iUQIIx3pfRJfCr6QISBN4vO5Rxi8Xz7pdk/cE/uMZBIfnNpka/qwlYXJVv?=
 =?us-ascii?Q?whaCK1xGoQpEwqnxmNOwhbWi744YTOGH/oa+Nden/mP56WjTSr11x7o585Hl?=
 =?us-ascii?Q?ZtV6OaJ/tyJSIclQg0m9spfP/6UkpvwIE0wVqW+30E27ylVZIEQwMV/gGUV4?=
 =?us-ascii?Q?ACwCBAFU2NhM5p1cF9KRBOxcB5cOMriuqIFLfutcDOzcYyDuNNcfd/PyCXMT?=
 =?us-ascii?Q?1RHVPjoGer9JlQTZx4i9E8mIF/eWLFobqgHB/OhQVrCzWUkj2qnvYLD9pPvy?=
 =?us-ascii?Q?4TBil3kxDSrFnAvPboiQbQxOOfB68WAsU0PFlXzuW1OytoPXkKAGNiQttuRa?=
 =?us-ascii?Q?1/pS24MW+UxEz7nhD9ACKS5Z078L/SUc/7JwwP1PgpZ23cgn3rLJA6/DSHKH?=
 =?us-ascii?Q?ojd+zaRj/fHQlME9HY72sEqOn7j44TUnk5ZctjFJf3UeKmeDN5UCq7x5wGTT?=
 =?us-ascii?Q?klTJY5u/aW9H8H0cQ4nMSz8TZDBEtzPfIHQw3naymZDuHzAsHOiN85lt/L2C?=
 =?us-ascii?Q?VLCUeZ1R9fZQUlUv1ZRMiO0sSmoWkU8xhP6SL6kaLIg8TWKWktxYmAGgPExn?=
 =?us-ascii?Q?2atsHij9YHuMMLvCFlOOKJt5mUfaB6xWHg6w7afKdW8TL4nCLz3LFitPOxPu?=
 =?us-ascii?Q?sJ/uxcycWXsOVfWOnspbaDtpQrPmdqgerKhmtTTQINYWoFE36HpgdnpQ63Ff?=
 =?us-ascii?Q?cmDiU25Fxdc/33foKTubVWrSdQt2Oqp70P441VNbQevk/MDRWbJLDRY9HNt0?=
 =?us-ascii?Q?Z3ciDb+P++Hb/s17xVAJ4TCdUA/WNR27M82S54JXyMdso1rmLCNvpKxhb95X?=
 =?us-ascii?Q?F6KdBd9iz9RHZ1bzWCh4CV6S3v/eidcyqn731z8AjNUDe0KS1kzYmeRvDLGJ?=
 =?us-ascii?Q?gMBDz2Th77o/JmFO2lMwbIG4eLgMx4gnwSafDGpVBxpolCQRV6oK2hJENidJ?=
 =?us-ascii?Q?qoQTB3oMMGiBkonRM6+1SfcOiix1y4TJyOW/ZildQ1OI+68rap+C9M8i/57u?=
 =?us-ascii?Q?yFO4i78/Y5CKH0XymBD34TlW3ZYERcVS0vdPfkQj2mMXtKqIhWXCJe8WhXSq?=
 =?us-ascii?Q?R5EgswwP1P1IEvfeOK8QGW94CRjSPHmKI6ynqDxOXI73ITPG2GiU+imVrZ59?=
 =?us-ascii?Q?9utod6EjbEP1o+DMtxcrrMrpsXvNVW03d96eN6ILDByRMj/jYzKaup0mPUbj?=
 =?us-ascii?Q?vRYak9BCO/8igweO7DMoeTKKJr3oRYSlzjCzUNFt4hOY0QYnK+CM5ExLewDP?=
 =?us-ascii?Q?8SIlExm/FdglvolTQXcMxBYQbCZMtHxhUofVzdzNxftAdkieMtShLk2rwHs0?=
 =?us-ascii?Q?t57I4bjvig=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a9ca71c-754f-4faa-13dd-08df09ecff75
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 18:56:01.5292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gwbzlItjeOq+2NFluRZ7pDbBwdPB29wibIFZDTV8oAa+M6tsTpSuynKkmmKgohd8mXq/hwMDufqM+bJImU5JJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB3048

Currently, the "module_blacklist=" command-line parameter only applies to
loadable modules. If a module is built-in, the parameter is silently
ignored. This patch series extends the blacklisting functionality to
built-in modules by intercepting their initialisation routines during early
boot.

Following review feedback, the implementation has been split into two
separate changes to decouple the introduction of the new feature from the
terminology renaming:

    1.  The first patch extends the "module_blacklist=" parameter to
        built-in modules using the original blacklist terminology. It
        introduces the ".initcall.modnames" section to map initcall
        function pointers to their associated KBUILD_MODNAME strings
        (restricted only to module_init() invocations to save memory and
        avoid matching core kernel subsystems). It also restricts the check
        to a boot-time __init wrapper to eliminate Use-After-Free (UAF) and
        Spectre v1 vulnerability risks when loading dynamic modules at
        runtime, and adds a fast-path check to eliminate lookup overhead
        when the parameter is not in use

    2.  The second patch renames the variables and helper functions to
        adopt the preferred "module_denylist=" and module_is_denylisted()
        terminology in the codebase. To preserve the existing user-space
        ABI, "module_blacklist=" is kept as a legacy alias pointing to the
        same module_denylist variable

Changes since v9:

 - Enforced natural structure alignment on struct initcall_modname in
   include/linux/init.h via __aligned(__alignof__(struct initcall_modname))
   to prevent compiler over-alignment and inter-element linker padding
   (Petr Pavlu)

 - Removed STRUCT_ALIGN() before BOUNDED_SECTION_BY(.initcall.modnames,
   _initcall_modnames) to eliminate unnecessary alignment (Petr Pavlu)

 - Added <linux/init.h> to rust/bindings/bindings_helper.h and updated
   rust/macros/module.rs to use the generated
   ::kernel::bindings::initcall_modname struct rather than a locally
   defined type (Gary Guo and Petr Pavlu)

 - Placed the Rust module name string explicitly in .init.rodata within
   rust/macros/module.rs (#[link_section = ".init.rodata"]) so that the
   string memory is reclaimed alongside the initcall table after boot,
   matching the C implementation (Petr Pavlu)

 - Link to v9: https://lore.kernel.org/lkml/20260807012601.360452-1-atomlin@atomlin.com/

Changes since v8:

 - Extended Rust procedural macro support in rust/macros/module.rs to
   generate .initcall.modnames metadata for built-in Rust modules,
   maintaining feature parity with C built-in modules when evaluating
   "module_blacklist=" and "module_denylist=" (Petr Pavlu)

 - Merged the intermediate ___define_initcall_modname macro directly into
   __define_initcall_modname in include/linux/init.h to clean up macro
   expansion (Petr Pavlu)

 - Reverted the parameter name in module_init(x) back to 'x' in
   include/linux/module.h to remain consistent with surrounding comments
   (Petr Pavlu)

 - Cleaned up whitespace formatting in kernel/module/main.c (Petr Pavlu)

 - Link to v8: https://lore.kernel.org/lkml/20260724024744.616286-1-atomlin@atomlin.com/

Changes since v7:

 - Fixed a double evaluation of __initcall_id(fn) in the built-in module
   initcall macro expansion

 - Link to v7: https://lore.kernel.org/lkml/20260724014345.589326-1-atomlin@atomlin.com/

Changes since v6:

 - Grouped the __initcall_fn_ptr() macro definition inside the existing
   CONFIG_HAVE_ARCH_PREL32_RELOCATIONS block in include/linux/init.h
   (Petr Pavlu)

 - Localised the built-in module initcall level and section naming strictly
   to include/linux/init.h by introducing the macros
   __define_initcall_modname() and __builtin_module_initcall(), keeping
   include/linux/module.h clean (Petr Pavlu)

 - Removed the unnecessary dereference_function_descriptor() lookup wrapper
   in get_builtin_modname() in favour of a direct pointer comparison
   (Petr Pavlu)

 - Cleaned up whitespace formatting in kernel/module/main.c (Petr Pavlu)

 - Link to v6: https://lore.kernel.org/lkml/20260718190121.378314-1-atomlin@atomlin.com/

Changes since v5:

 - Resolved a modpost cross-section mismatch warning by introducing
   do_one_initcall_builtin() as a strict __init wrapper function, rather
   than performing the built-in module checks inside the __init_or_module
   do_one_initcall() function

 - Addressed a UAF race condition with concurrent dynamic module loading by
   strictly bounding the blacklist evaluation to early boot via the new
   __init wrapper, removing temporal check

 - Mitigated a potential Spectre v1 speculative execution vulnerability by
   ensuring get_builtin_modname() is exclusively called by __init code,
   preventing unprivileged runtime module loading from speculatively
   jumping into reclaimed ".init.text" instructions

 - Updated Documentation/admin-guide/kernel-parameters.txt to explicitly
   mark "module_blacklist=" as deprecated and document "module_denylist="

 - Link to v5: https://lore.kernel.org/lkml/20260718051350.344772-1-atomlin@atomlin.com/

Changes since v4:

 - Split the monolithic patch into two distinct commits. One to extend the
   functionality to built-in modules, and a second to safely transition the
   internal terminology to "denylist" (Arnd Bergmann)

 - Preserved "module_blacklist=" as a legacy core_param alias in the second
   commit to ensure backwards compatibility with existing userspace
   configurations

 - Restricted the population of the ".initcall.modnames" section strictly
   to module_init() rather than all ___define_initcall() invocations. This
   prevents non-module core initcalls from being redundantly mapped, saving
   memory and avoiding false-positive matches (Petr Pavlu)

 - Introduced a fast-path evaluation to check if the blacklist/denylist is
   actually populated before invoking get_builtin_modname(), avoiding
   unnecessary lookups during boot (Petr Pavlu)

 - Link to v4: https://lore.kernel.org/lkml/20260708020007.55728-1-atomlin@atomlin.com/

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

 - Link to v3: https://lore.kernel.org/lkml/20260706050337.7613-1-atomlin@atomlin.com/

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

 - Link to v2: https://lore.kernel.org/lkml/20260622140259.2974-1-atomlin@atomlin.com/

Changes since v1:

 - Pivoted entirely from exposing built-in initcalls and their blacklist
   status via a debugfs interface to directly extending the existing
   "module_blacklist=" and new "module_blacklist=" to intercept built-in
   modules at boot (Petr Pavlu)

 - Implemented 32-bit relative offsets (CONFIG_HAVE_ARCH_PREL32_RELOCATIONS)
   to store the mappings, preventing binary bloat and preserving KASLR
   efficacy

 - Link to v1: https://lore.kernel.org/lkml/20260510061301.41341-1-atomlin@atomlin.com/

Aaron Tomlin (2):
  module: Extend module_blacklist parameter to built-in modules
  module: Rename module_blacklist to module_denylist

 .../admin-guide/kernel-parameters.txt         |  6 +-
 include/asm-generic/vmlinux.lds.h             |  3 +-
 include/linux/init.h                          | 25 ++++++++-
 include/linux/module.h                        |  4 +-
 init/main.c                                   | 55 ++++++++++++++++++-
 kernel/module/main.c                          | 25 +--------
 rust/bindings/bindings_helper.h               |  1 +
 rust/macros/module.rs                         | 17 ++++++
 8 files changed, 107 insertions(+), 29 deletions(-)

-- 
2.55.0

