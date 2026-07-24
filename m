Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020112.outbound.protection.outlook.com [52.101.195.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739291419A4;
	Fri, 24 Jul 2026 02:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784861273; cv=fail; b=BoFpfCEDsq75fLDe9GlmlViDEMKTxQrwGme+d7ydv2IrulX/dHkrB8AvvWEGln5bRHsW1aZTTzMrGFElszFPItoBlzFp05mLAGuvefJa/gq2ofcT9fDzkDBEAdnqSV2X9ve5emwwjwboCfklE3x67ULX4w0y1hACe/ZudKQpesM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784861273; c=relaxed/simple;
	bh=Fxp39YU7f2B30t/ipu8X/jad446S5G/Rzo+BwZggf9E=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=QtkNQ9V59kZHzGD7cBocGYumnea1I65mnl7/mEY28NIE9/+ir0t+de90Ggs7743csV8kTbteq/kusla/TBsBs+347Ohy7huu5voVtE4svyo+SCuCF0CtaUpGbZJxV1RY9AO9RZdClyQyecwfiq4qdDtJh+ccUBntRNmn+ZvELlA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.195.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tQ99s6UPH6RDh/VZgEemRrAU7ThpHc14RbfGiu6LTqHaLqNEui9c1lcTVzx1rF42dHaC8xKrRFwVSojPkOA+dTTDWQFHyo658FmuotkKS9KIgTRwbcSBDhWXFFNVetbsPknGh2j6jio/EZZpdLAL6a5e+J2iZuUZAKHrmUEQf+RCUSAymjVp3+/VL0/Q1nmQpdfSMhwUOf2t0b+Wr5qNz/LKDCpdUnlNmCcyTs71IOqV10JrF4GoUxmr2ut5+EU4FxwIruLUL569OPGesM7SPFKmv0vRjnBGODw/wBO/YLuE9rLHw/Ar6SgQY1EFDxDk90sTOPrhmqbarAmqCl1kuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=G/MeWQ11SiTBoUY5ZDGwF5hG0KseXPJ2NO9xFj2vZUA=;
 b=RanoyGFd3yOb9ri9b2fyDCfIfpkOSX9fjlV6gB1vtpyg02r5+n7aHGuvJqfbruU7CThLXLimbaFajKfhbh/0cD3nL98+uLMbGc8rNvoZyJhGxPKRBGUshi9AM01i98Eu0nCwod9FY1k8Cn2KD+gFRycEruDbvgTadGT4qUlmoETg2gl1doE5pcLfykcuLZ9c5kthgAW7wagbrZpiJyzpNu9SgaBzcUH4MLeQeEwhncp0besn+kwZuENvvFbT24XnmM+uzraZFc+7f8ffUOI9pqTsQYIvYb+zphpg/F6vC4BpCkupOrwQPdZY8o6eLv18Wh9ULOsZAmGyAuhbFJBaxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CW1P123MB8488.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:269::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 02:47:47 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 02:47:47 +0000
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
Subject: [PATCH v8 0/2] module: Rename module_blacklist to module_denylist
Date: Thu, 23 Jul 2026 22:47:42 -0400
Message-ID: <20260724024744.616286-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0730.namprd03.prod.outlook.com
 (2603:10b6:408:110::15) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CW1P123MB8488:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fc58508-b361-4f7f-553d-08dee92df1cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|6133799003|56012099006|10067099003|3023799007|18002099003;
X-Microsoft-Antispam-Message-Info:
	1khba0KsVPHN6lzIWlTtAM/+pzC0wYJU3zseigtLi9y7JWrC6pyGTuod4k4shJHi07xJt7TOxunqUY7uRSsiaCZI8HZznDluyuoYj+A3z+SWDQ1tiyuKE4+ZyHPrX0DyiEyuxA4ghFJ+vOTAqjszVd1gMkfxtC6bllWlxmldEmZAbvq12up44Hvj+nGf1MXM1twYg7mwH4MiKuL/9IYoFDjnlbS62r1bvfUl2DT6qAXx7xfzjmALtwoidXnUdaQ0xNLFD4aGl1K4FPLKqdCEE2/S+eMZlBi/FGzPaE4Qjur8MIpDjPFE46uCj9HGbT5pHWOmkKc2GyMC+2DDvKopJnKSkqFL4G4sl4al11ZVmlEIMWjE292k7cRC5BPB53guRdQJQBpAm5q1KkQf/LU8e3SJCNkLtTevTnjSwUfh3X7N4tiqcWoswowL5tItxYBxu7Lw1YXr6Oafu5tXJc7wU/opO2QePmyu41pJVpev9EBsSrVk91UDwL8nmKXshdzfq3sSiq83VlmxDwk0usLJ/ce53a5Y4jeIel87Tt4UzaY/lfOS91wFk1JR5TThmwIqySGmpI8ZNmOTO8y+RjpZt3qhLY3QuwaBNPVXJcuV31lOqkSUbzR0DHrHVtkrdK6huXE8HpKfwGCcvJ5DdImrIA2Gtc8iv7n68sJoOgG1mwM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(6133799003)(56012099006)(10067099003)(3023799007)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DFJqe671FBXmykEk/KNGAMrOY/2qd4V1fmPIEAkhKYQwRduRI4qDH/j5tnn/?=
 =?us-ascii?Q?vF0LWXnoI6ynQLddpXOzTPuidf+vSxXk1eIfzXTKPnHM0uQs95iQoy8Whl+j?=
 =?us-ascii?Q?0Jw0G00whOZhLQd1LHnpyMLv1CkvMXrCrWO7AVZkYZSjCa+kiK9LcFERX7Hf?=
 =?us-ascii?Q?2D6hRwUDwSHV3dGJ4VGgYLVR+nKEVMFB5EIJ0htDlCpee/OmYXjN7Qig6TXM?=
 =?us-ascii?Q?PgTTxHAi0CzyGJZ+wdE2OIBUThT5xlCS1HAp1nqphfUHbOAKPZ0Un/rnLWcB?=
 =?us-ascii?Q?blfL9SRDqqCQf7lD2Va4s9wqSX2DIXdecbopy+GCtNrE/gtse3gsmmGV0FI0?=
 =?us-ascii?Q?vk3WrALve1W9D6FaiiOFtxvN7Zxefz8pL/VyCusrLole6G+6gvZTw5aIdXqq?=
 =?us-ascii?Q?QOwIb43uYc9A/eWEs3+R9oC/Lys3Mtv5XE27KcqXFdIWPbqxSu6vxb4hbgqJ?=
 =?us-ascii?Q?QhZtr8jitt8JQ8bOrk4En3LQOIbhOkwtkzF6TgG2VIAF+93ek+kFMamdXhhC?=
 =?us-ascii?Q?PgP7nCS750ZbKykmVyu5st/QpYgChQPDiafGHyLYcUEK3srVFAduwXQld2kw?=
 =?us-ascii?Q?Ail+Xre35z3BxydRgWj8RDmW4LWsTR+ytEPKDsaPEnxSGb7zPgNcOUvdGsFc?=
 =?us-ascii?Q?l2Y/Lsfik9g3xnL2tc4w9yu3YjYeYtcQFMUZugp6KwdvvfZu5/hT0E/J+mdR?=
 =?us-ascii?Q?S3dp1U4cIaW1FG3zGNe0FZdjvdm6+nZXhAPcmnTI/tJrNcBhrUmAvK7oBB4y?=
 =?us-ascii?Q?EYgaqN0Wf3U8w9GDPG4h/Ohnd7M6n1oplvFtCnlidWfu2syw2qFmvuV7XMo0?=
 =?us-ascii?Q?nH3s+3+Y44N4zpyOHUWk5BoLo3xYUwYPWLlexm7WTlUgVhYQfEUdey5o7z09?=
 =?us-ascii?Q?30qFmyW6Ch8rLP3PYhIKx3rP4IU4NFIbyz2jiQNLzkrhAOc2PuX6EYVYC9W2?=
 =?us-ascii?Q?HnB1uuiTJ741nYx2rZpoyCLjCtcmvZ6TSsmLZOWiHZoLJrBO/Pp8kI/6SV33?=
 =?us-ascii?Q?0F8p4KkhYV4kH0jGGCpygWxWsg7bx7xe2u8c4x1nPRuZcLGOXQ/gwXINtkNn?=
 =?us-ascii?Q?GUni7fKAqk+fz0n2/vfXSsLy2+E6iME32ZgbfWmBclpEWPcw+x2lRtA853mo?=
 =?us-ascii?Q?nD6i0K0jRL3zZIZ5Mi7hSP7SRMxDMuPV+O3xKvZuhRDiGjmWOma++xVqTNDk?=
 =?us-ascii?Q?nt0qSDCNhMChgxeDf2TVfxFvOdCnTGJ5wke8H97YOZ1qbF4bNlCRm42XH/ZV?=
 =?us-ascii?Q?fwQTNuNE7l3sKf7X5wqoCN/+Unh6DAPX+k5SQlFxtt7Txcnqp2GYiFMQkeFN?=
 =?us-ascii?Q?4z6kYP2+UMNIGB5b4Qn91zmLm04E/ERm6ml20Mdbg/kx3iHAm3Z44BQaCGib?=
 =?us-ascii?Q?epsH6sPKd18aV60I9wsUETLo9oqqhZGeQmtjIpLJDdRPhXM7HRpVDqHgQQyI?=
 =?us-ascii?Q?NslIoiwPawG1JFxmQJyD3B/OfrHww0r8FrbLseCbViuADy4hApgnMebOJ5PT?=
 =?us-ascii?Q?m+13ENoMbpWCG/8lLyX593s4EziYWHXZdpRS46fDJarcqkQYkkCPsNMeWmeI?=
 =?us-ascii?Q?ys9DP7O2hhbR10vNjOKLoMFnq3L9LWTjSoXoaXFeXI83pkpiNayY0yHyHxPt?=
 =?us-ascii?Q?ZdYjYrrk91aOCiMBgDXuJyPZ9dvQ5c4IAqvuHe+Tqs7P8CEYEVfdvKg94Uzz?=
 =?us-ascii?Q?Z97c4krBs/OvEqQrW/0nfn5kWbKXJCVfr3Peu5oGZd2D3cVsJNEQ5Hi1HcCs?=
 =?us-ascii?Q?IWcJJ3erkg=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fc58508-b361-4f7f-553d-08dee92df1cb
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 02:47:47.4454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UbHHK5YbiIvTAxl6N9w3AdFo/AQSjbQ1u/+1xSbE3+WtkMi4YPh4vffIs47eN0UjOlX/d3YI7QA5cWRdC5qcgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P123MB8488

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

Changes since v7:

 - Fixed a double evaluation of __initcall_id(fn) in the built-in module
   initcall macro expansion

 - Linked to v7: https://lore.kernel.org/lkml/20260724014345.589326-1-atomlin@atomlin.com/

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

 - Linked to v6: https://lore.kernel.org/lkml/20260718190121.378314-1-atomlin@atomlin.com/

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

 - Linked to v5: https://lore.kernel.org/lkml/20260718051350.344772-1-atomlin@atomlin.com/

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

 - Linked to v4: https://lore.kernel.org/lkml/20260708020007.55728-1-atomlin@atomlin.com/

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

Aaron Tomlin (2):
  module: Extend module_blacklist parameter to built-in modules
  module: Rename module_blacklist to module_denylist

 .../admin-guide/kernel-parameters.txt         |  6 +-
 include/asm-generic/vmlinux.lds.h             |  4 +-
 include/linux/init.h                          | 27 ++++++++-
 include/linux/module.h                        |  4 +-
 init/main.c                                   | 55 ++++++++++++++++++-
 kernel/module/main.c                          | 24 +-------
 6 files changed, 92 insertions(+), 28 deletions(-)

-- 
2.54.0

