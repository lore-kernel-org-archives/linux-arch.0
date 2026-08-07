Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022088.outbound.protection.outlook.com [52.101.101.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04794B0494;
	Fri,  7 Aug 2026 01:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786065971; cv=fail; b=L1UvCqw96DJR5DvPQztyTQFnrBUwruu7Ib4cYi340OiVuR3n2HJEDmz6oCDfw65/yOLF6SQtCnc+re9W3nBXGg+vA5cQ4EfK4gb5Gc2uaXbyOvARUpxrjLwze5WF+S6ViHYp41FLWC6iExiKxzqNMhyNvR2xILHpM7s/kiP+C4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786065971; c=relaxed/simple;
	bh=Wd9o73VmlHSFHg+Lddnb1qX/Nf1F4ioXWxo8BsF5kQc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=gIBu5cShK/s3rhUa6miyUAMpzctUuTFK/TTVb1QxMstd7yIzQaQmUqp0DyymsqvM03j/57FgyjWPYwcYRT6nZskeV8g/uxun/IVIzn+VmQs+rdSgc9LL1bMoXoYK/EYmm2prJku6Jy4PERNt4zcTdThdcnDJ+wHBWRl5/LsAmMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gX1tNnetmRW01qERnE6SmOWgBPIYYNjhOe56uJxlc/1Mhlbfw/FZSiKXrCjGiF0mzZs3dZXkxJT2fZc+iIFU1qmo2dOCGteyTNSl1mHrbhXzVsI+7n0oFwlYmtO9hFEyVrfDTGOUJJ3Go79CTwxFqBk/t+8Rhw3AgFwk7yRTUfbN/zs5P7s7UrIk0W2+j9kBtO2WcTO1LxtOXPPOzGIvNNEjurDDa9UW/iY2XlXtfk2FH/qX2iUThHJr6YuAik9dxhHs6X4NnQ7HU9Y37bT5Y+WHVwPPMOTSVVn2EKnuDA7UsqTiL5P9NmgI/uCv4DkjoFMWvjsI1GdnNs4N5zIx0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=djAO4y2PYp1G1sT30UXvEr8KxauMHkz1mKkkZ213IMY=;
 b=MzX+HAPvbTL4BYN/FJISayx8eBKE8foo6UMwxB3nwEzWuU71pYvRQ0xnQMtm/N0uLCFUtTbE4W3hPS2943GXkrUklDij6tNx7VUoHjE8PRj65iJs24qRO1xcZZRvE3ZOHtDu7OBR59afkARziKFbRgEsfN/UzibEIyreJzMeALYeDR9xtjcz9Nz0jNytTiUj8wnFYs39QSdpfy+hmD9l54ZqCd+KNESbsMj00kMohpQBGtbNQyomVkq0f/Fg//qsxcw/oUuR/z7VJZfDpz6RoNPdFL9pEK4qCPTbjMaJzrjsKKooiXuiC3F0cs/BxrK6zwoXUjp6onLxlyZ6u0GnqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO3P123MB2825.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:fb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Fri, 7 Aug
 2026 01:26:05 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0292.022; Fri, 7 Aug 2026
 01:26:05 +0000
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
Subject: [PATCH v9 0/2] module: Extend module_blacklist parameter to built-in modules
Date: Thu,  6 Aug 2026 21:25:59 -0400
Message-ID: <20260807012601.360452-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0925.namprd03.prod.outlook.com
 (2603:10b6:408:107::30) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO3P123MB2825:EE_
X-MS-Office365-Filtering-Correlation-Id: a9523571-0c2c-49f7-0d39-08def422d9b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|18002099003|3023799007|6133799003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	5W9Jf3e8EszHiTPWVkYe+qHxiMoLGrZV9uyOpcza17SBzxcHHfjbMKZQE4iX7SwZU1O3o20kaBA+N69wPOCrNxW1J1TyNVFKB5QJw/4aZVVEtbnJlcD4dzOEix+zSySjqLjpjSZleGaHq87wJvF3f9s6NYB9MB+Q0eFWN+y1oriVnwivAwcbelUXf6M2MHCVelS956EFOVoCRhui4k4uGyU0Kit646defzpiIm/eckGqEOGPRamqJfQXwe27bvOQ5L/cuguDM8PBf7HpyTeYRlKx9lTscCU56KBugUhuqUBhF1IgJDsTaLRP2dXwJrDsDrJd8wmxelJvsS9CdYJot5TNBDXLxTc7KiROTIRTm16kSaJ8lt8+TLltO1SDBUhoC5P9LxAGXLIlZrZY06zhpXxyMCqz9NKpIPBZIQXClVRfj7VqV56S97FWW5kiW9SNp/5FESA9uwfivUjoR1dNHMJHp5fJWJf392scT+gggpLb/PNb7Qhg7B5KmvkBepr+RM4AwqulHh0BbCfVBtG5vg29Bwr91OIFsqadTqTg+TlRVGSLw3i40HeoUBlPLDiKW6GAx4aJb3tzltXPrTDkVc8Lb2sLn05732tdEnLuUwxEB7KMpRLDxPl6fOyXMxHessP/KUTcC8usZYKufH1vuDVNnAVvNZ5fL0qS0xbINAU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(18002099003)(3023799007)(6133799003)(10067099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yNUxyluusMjMxXpXeskoOzOr5Eb6od6ibCAAX2sE89Io7IQc3gAg8F8RP7A/?=
 =?us-ascii?Q?I7pBZj26jVhaeNOXXirlVlsjJsxardIXuaFp8ZcXTQP0D9HYPnRWhrJj+gCw?=
 =?us-ascii?Q?Qd93nXlKT7uGPlVDlpvgVryVI8rZr3vX8VPxgAj5cNpN5eZMTLig+v04paka?=
 =?us-ascii?Q?KkCr6E1Vu8cFexSRsH4Rr1xtTmwSyKctSqp12Xy7bDBjVB+sGORCOCO92Ix7?=
 =?us-ascii?Q?OdmzNmNYKWl3y0N3AazSj4dRxs0REs11XKQ2PdqjaNAzXBjyujtE6V8ZU48+?=
 =?us-ascii?Q?PJeR80Ly7olD8ZtNMprY++k/6TVAUBA1a4wKZNCf7XGH8affuJByai7z5u44?=
 =?us-ascii?Q?1+69ZdkTdzFtshUNdEGDNYL9V1eTqf0AtUGOdB5p+sqBzlG/CfA94b/lAndT?=
 =?us-ascii?Q?xdJYRE9RuO19R+GBP1L09SCSI1x5vbLnJYNSAUIVUv3v9GOJXXVFnMRMxbJT?=
 =?us-ascii?Q?hENldc4AfezIQ5QXm7xIfiQXxfr4/qmKM68iBol9BD41SdSKm5El9Xl0qrcs?=
 =?us-ascii?Q?0AX2E/iIufHZNPfyqdrEirX7fGzVisorkB+3iEvnqNApgtPzEc4Cc2Lt4sAb?=
 =?us-ascii?Q?hixz/TTkOMteEYZ9APYBCzxvvKDunbheN0QFa/KPWB5GmB7gMa5vMx2vf69B?=
 =?us-ascii?Q?Ho9xfg/H/BRlMU4KU/esxh28qZO0CXYFsAIIhXeOenSnz0WkSTeiUBqER7Kl?=
 =?us-ascii?Q?n0p0pF3pqvQtkHLJr3QuzCWW25/eUV0D+oY1RRG5zsYgPL5cRdpbvuSjAdM6?=
 =?us-ascii?Q?2vVLFmHS1RWUzUDrK8Ak3vxfpzeCOJh4CYVOCMn+O1A3oz7CE7afBladRP5U?=
 =?us-ascii?Q?SlWSjnbvyIL69Md2dSto8rs7hpLUemR4wN9ELJ1JZ6Xn06+UAlHW07wJRYHU?=
 =?us-ascii?Q?BMV5SaqmeODCBvFtGGQYBUqcBiMCR+Z5xm5djvdf3PpllmXKMWSZdkzE4vOQ?=
 =?us-ascii?Q?pdbByt8GfYX9Wh/WdViK3l6C2gLs5L6/H9cNxWL9TQYWhNp17Jfid4A1ehH6?=
 =?us-ascii?Q?lS3fG8fKhUH3FnC8SlWlcbW9LVAgYO1dM9DTlVGZSFB/asABm6Y78bIdSVPk?=
 =?us-ascii?Q?dHxcdfp/XtVD7fVu8ST7zp3sy7zi/q6FZG/fvUGuKHCUDMmsTyD8Gxm5PkgV?=
 =?us-ascii?Q?2uaLs5EgpWt9Pyl1L5HxVPLy8MdAHCfkwVSj+/FwseOpqoSNtuEBouVHHoL2?=
 =?us-ascii?Q?Vr33nTY5WeiIs1x9zUeuwE5eSx9jD7KLeoYTXv+lVdnZ3hx1oMD1PcysA0xg?=
 =?us-ascii?Q?pV8fd8RO4zgAYs0wjjlGn9xpZZAN+BSM/g+GUBathdkF5am8urNzdKvlb5fP?=
 =?us-ascii?Q?co1OXZ/BqJYNKXJUPaDd3km4LWiq54b7S8cWAUWNFzO4O0bJhcb7p8eZr/Dc?=
 =?us-ascii?Q?9i7vzRYZ7wZTTNiVBO3spBr2/JgUGwYcKEMq9tcX1Wyi1FRqC71hkkMzf00Z?=
 =?us-ascii?Q?oKPj6gMPtFrHpbwJ+eLVUp7Wmj+olUWL4CUK4GF1umfjWRdTk9XmgO/b6zZS?=
 =?us-ascii?Q?XJv/4MoK+6KZ220oUShsiQejxhYxXKk1tfDyy7QgPvgWpJWiMZ2SY9pyv2Aa?=
 =?us-ascii?Q?bL845mnkvhpn5XpiMt1Zzg/uSnxczhNhC/i+f64ET7C3Ukdn8woGdW9fod6e?=
 =?us-ascii?Q?hCgOZKBlWP1HsIvpoNhL5qwbnHiIZjDXg2rRixzgzoYFJGK45c5YpSmDSAcq?=
 =?us-ascii?Q?qBlo0M6SC57lq8V5hdB7Y6mp+UKCe/PItkdGwhPIvNW7/btDXJBvf6piq+3h?=
 =?us-ascii?Q?YJZpWt1pmA=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9523571-0c2c-49f7-0d39-08def422d9b9
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 01:26:05.4303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aGEvTPNEFoUrOWoMUxOJkHypsGGiN0IGg6WktXVcEy6lRE/Do4B1RhjBzjXLkXI1i3r85KDqPT/glqwgQWM49Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO3P123MB2825

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
 include/asm-generic/vmlinux.lds.h             |  4 +-
 include/linux/init.h                          | 24 +++++++-
 include/linux/module.h                        |  4 +-
 init/main.c                                   | 55 ++++++++++++++++++-
 kernel/module/main.c                          | 25 +--------
 rust/macros/module.rs                         | 16 ++++++
 7 files changed, 105 insertions(+), 29 deletions(-)

-- 
2.55.0

