Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021113.outbound.protection.outlook.com [52.101.95.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35685242D9B;
	Fri, 24 Jul 2026 01:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784857435; cv=fail; b=ZJspzlHSC3U4PpQE3ZvIb2iltTEf7miaIHcIxmqufoukoxIi8KSKiITWhzcsPCGpImpvmtC4epLS9G1pbO4A0V+BU1CTCqvIYqbPwekJaFk7Se+qbEu+en38aH7zQdX85mu75WCQ4RkhLZ2hzLypCp/t33ZEkE5rOy6RaheouoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784857435; c=relaxed/simple;
	bh=HOevqhkaX9RStJWlKhnwP4mhO6Dk4k+HvzWPs3iUQEo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=fui2t/J10cU3WBtwRELA0hOsmfsiX1p0LD4rxonSPppAD6QNW5TSRW4AOiyK/abyTZXQ8TtbPKEWiveUULmN2L/yCGmyNHL2BiL/eVK7140SGSjfy+v51VLuf/y68oKhIORlvL5xISNYBLcbrwDdhTIAsIUZBAHWd4SS3q3EBC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o4t4256lxV8eOqEbTCNHegS4NNyFbrXcJwO2xiBi39NNSO5H0f1ls1tWx6eNDp5J9D6lZqXu6fjm0qwJZMvyFJPoBJYW+gVZUYs5j5wMl67kno+Gy19CCORJmBzZLyZ1tk7voWJjTmWpRsiRs5LW8RKisQd2rIupbh4FgUUw+9gssJKUiH7m66LKFJW5polK2QQeVmirCVjgyMl0WJFl+0hFBDMESd4PKYMsA7A23UfB6trdOnDLPhYy8a7Hxkl2gqbgdhMw5eclo7eqMOChKKLWs8kZSsPnQvJUvoyM5AtPZF2U8m3FmoFV6yCXfCnPsapdPe75RCqyc+qEmYJSsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=AoBsOirf33k3byW6co1bTnZvXPrx7X6p2x/g94z6Zec=;
 b=K/UgdosZxdo8JCetIJfwDh18HGUJ4TOp8K9B1h64mW6P6fwn6R/KpBCArykeF1u0vJWrWGXTGTG2dqpvtqG4T6rSW716kh3dwwIfx5OfZh8SC7PTFjXL78yFqd2luNYWsFL/klVt6sMm9GzVV545xQ2MjOw/AVFLlqHVOVjBcVXkrP94rbDadEr3UufgDUJZqnbnqa+lSn1SQQIxBY1j7E3PKbU7g9OtHhHnWsjk+K2W2sOyXd4isaXxKUEq+5AwcNYtqGPBWddp02RLWAKLz21F97A6etgmpuIZh+kKW/nC1RWc0KewTsQL2rilRdQpHm6/fqQrGLFmogba/V3mIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LOYP123MB2974.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:e6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Fri, 24 Jul
 2026 01:43:49 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 01:43:48 +0000
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
Subject: [PATCH v7 0/2] module: Extend blacklist parameter to support built-in modules
Date: Thu, 23 Jul 2026 21:43:43 -0400
Message-ID: <20260724014345.589326-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0132.namprd03.prod.outlook.com
 (2603:10b6:408:fe::17) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LOYP123MB2974:EE_
X-MS-Office365-Filtering-Correlation-Id: 9847e625-1e09-48d6-cf95-08dee92501d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|23010399003|1800799024|6133799003|18002099003|3023799007|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	a1hWumqywW5dh2mYPEgSpWRgMNFPU0i442ep0tRO1e/h+LhqywyUmtyES6oLNG/DofVnujkYiRpSYGPSZMjsgtsaSL3xuMnM16VuSUTWMH7t0l7DyquNGSY+EVuDqPp6Olzw+zebjfr3fw2EJM+2I6VfWhORAmsV72awPOlbg3kYgXIfpSBN7SidZPzzW4GYloUdPAw5VAwJmGGCLQBqUF7NfBqxPBjgrkYP9jGBwjXoJP92WtMDvbI5OAQ9re9ZPTpPz4GW8flqOgQhx7EdvX8eyDlXK3cAEJtA5BZQXz9qKJKMlM3u+WkveuePt2XQxK9ztN7NTfeM0D3ZG/Fnmj+OnKzKwKjaqWif5wPr23CBpJIrLoSS1JK55W/0n7A0nhE4sd4bWPF54y3qZmJ58Kd7Z0FKKKeifD/8zWN/p0CGhdClIcinFBg2vw15DXK2PrnzAxQfZSkoEYghKqTUbWHhjZK+Pr3pWQj2neaWeRXylj5WZwSzAGp1j+qH5BoPIgXiyBKXqfz/MV0xj8VRWX57AOssrSqBoILLPBKjTIcWpKsSRorZZr4EXA9T2jy0yFDRXMpLb/9v5pmYH/Dev+Nbu5wP0uHuOHkCCRHZin94u5EBgVDlBER7FzsC4Zb6dE2NWw4fL1UJyX4kxTqxSL+TIi1/B7spqnsWUF6ge5o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(6133799003)(18002099003)(3023799007)(56012099006)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OktzlUwpRCvrb/PfwNN8EZN0WMStduqbuou3BwHP0ViSWz4OAnEex6NplgEI?=
 =?us-ascii?Q?mTdyf0Hw0Z5WqefPZUos+0MIK03pu+IMUXT5BUASBExNOOSAQtq5p0tlhVPK?=
 =?us-ascii?Q?jkrbvrRWttMXil+8fO5KFB9qWdffOw9c/g/lS1Z/n5EI4kqTN5J9PoB5Vjko?=
 =?us-ascii?Q?DNp3Cl+OlYbD0EJc9lXZiBu6JNS+1r26qFj7EMUmWhRokWw1gTLWcOgbs77U?=
 =?us-ascii?Q?6CAbxHzRYwekTXlizUwolSbhWkByRZPqrP/nazMm4yzSW7ox1bOlg2KLDbmd?=
 =?us-ascii?Q?SuLh4h6aFjuLaLnWkKTynOtY2DwUmamHsAVunTgFVwIk2119e6V5uo7FVYbI?=
 =?us-ascii?Q?HjkcOYYdUtzXJ6rraXmuA26qbI4NtTahTStIXMBqP6ScXjd7zgTiV8No76FC?=
 =?us-ascii?Q?quKvRIMjuCQxEVdU5tnwh4WDZc4R213YZaWA2gs7GVBgYEixO1rNWkXLUTcX?=
 =?us-ascii?Q?zFdOjzZ5TAg/17SDkdUr+aFeFTExAU/ZYvVoyQqaG0gF15Om6M9bYw+ZvilK?=
 =?us-ascii?Q?wdVRzCUHTEmDexmiCemS2gsZUfT4izdMMwHQFB1pEeM0LHypT5ADsID9U1Br?=
 =?us-ascii?Q?VZQRTgYmXOjl2zcdOeleTZ87IB6qMZ8W08seULnlopRYTn8+dKdbOyE+or2l?=
 =?us-ascii?Q?tXP/fPpoNNFxES7KDQkJJVax5mkim7vwtim8MawFqBxzM72XJGyqP6N9hd+a?=
 =?us-ascii?Q?dS59BUDZqwLs+t34i4Hn30TKK8VeJZ1WJfYgX/Dhxxx8jAMUtO7v7+HN8sSx?=
 =?us-ascii?Q?/E67Ntk0xyBmH2+udugxHkoZ/BaIP+nBwHJwXCNUvunY/eq2vAUBnavYoVOT?=
 =?us-ascii?Q?sWfPWC56Z+NbX0JIk+yu6LnaebvNd4D6O3nnxL3aDesbG8ehBF56OcPsyqgr?=
 =?us-ascii?Q?AMHDS4aol4a5VC7LYuXrl0Ujnk8Jk0zuKUAr+rPuzVV3GUeT0do7dXrHIMqh?=
 =?us-ascii?Q?4JIe3K0kUr9DGah/hJepZzY6LuOGK8xHE50/XxyItjOxmeAV4OalYqce49Le?=
 =?us-ascii?Q?AsIdujhezXK7HNqckPRdb2oB7IF5oCwWwxzXWArPHI7L/mld4UX9JXtsBThd?=
 =?us-ascii?Q?b7TIRsTRb9b7MJtj22HWd0fyq1MKG/BsMaZ7hsrLzve1C7T7O81qzGnt+ikj?=
 =?us-ascii?Q?aFxLLiIWW+w/LZ23xjT9RcY/5f2XjMVVt6+rnIpgS9H+LcRFGPFoIHxxaXal?=
 =?us-ascii?Q?mOPbbL1PRGJ5EXb2aUuFnpOnQsBwGt58o8eVsaFNuQd56kFpiXvZE1bd1NtJ?=
 =?us-ascii?Q?UzOlRZIZPbZvYRh+cO+hNtbqASSyvAPd40MZUlCeustwXDZsHFzpoKWYHPSd?=
 =?us-ascii?Q?Y1RMWw9hsUaXA52L+Qw11C5mDN2WTfFMOReP0B/Mx/0IBqDFs+BZKcGN+Sxf?=
 =?us-ascii?Q?zlbkrYHjyUuAfcYV9BOzWpWzJ/NnQAtn6e1Bs83VTMYNEVatbLpLBJVyv/e2?=
 =?us-ascii?Q?++AFKIH1ZatKnTlWbwPgle2bJcUZ5wvGm6CGpcrKLxdmJ9caV/H4cHkMOtwK?=
 =?us-ascii?Q?3O2qLq8uR72vB0O7yisMvwp66NsSXNoSdFQLGsJKdJo1LSAqgm0ywtJ3ivJE?=
 =?us-ascii?Q?G6LApj+DmsA79G+2LEhQZVp5SOUJXXNZr7ZjZEVdbwBeZuyXnbkbqD7H0vUL?=
 =?us-ascii?Q?9z47lmkYPwW7LrWFvwhFmOka3PxqYqLn8WBvCNCBvSi+4bZLaD3f4AMMX5dS?=
 =?us-ascii?Q?HQxBBvJRyL4Ayza1xZX70q6JIeZn3CwEBhQAjmRfN0KiPUu9Hjlcjpyfy127?=
 =?us-ascii?Q?VmxvtsJ19g=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9847e625-1e09-48d6-cf95-08dee92501d1
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 01:43:48.8221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cxorvxrJFvIJwVB7GICghdW1RL05ItNgciIpIJoiwUrvxwB/NQcpRyG8MHCkdrjC9+kLu0eXf+X8C53O2xa0JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOYP123MB2974

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
 include/linux/init.h                          | 21 ++++++-
 include/linux/module.h                        |  4 +-
 init/main.c                                   | 55 ++++++++++++++++++-
 kernel/module/main.c                          | 24 +-------
 6 files changed, 86 insertions(+), 28 deletions(-)

-- 
2.54.0

