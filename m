Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020099.outbound.protection.outlook.com [52.101.196.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641FF217704;
	Sat, 18 Jul 2026 19:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784401291; cv=fail; b=s2cd1IDxjlkw+GPcspCzRnaZJHzJXzRF3rs9WbnRw96FhfsdAxKxJ0pxb/qUJ0rlfNvm5e5BX8FXVOHj0V9q+Dtr6SnOBJTNvFN0KpjQZeIYI4ZlyAR7uVWU+Ug2YG/SrzlZg7JXR37jwC63/K4pCcpk/+n4s4oAjChJAGgETI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784401291; c=relaxed/simple;
	bh=Bv9D0lZ90hLmmWXXuZa7NwHsrbyDRYLZiFL6Y3nP294=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=bPKw2Gitd9GCkF+bcTdbX7FbwcVOUC2M6NdnqEaTqSAS11te/XRuOf2eIkvp8mT3k98uZIn89mXzuZ22dbND0/JtgWydRGzvxI26Ys2eiIrwz2kMuTISYanZz3JZ7HcPVFB04U9eJCNc8W+ePMXrCid0WDELyIgka4Ne7naCKR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.196.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qAwygGVE3pWxjxt85q8WhR8Nnnuv5OAegAjgsOOnEr30xGRSZtdT0uXkjG3guyHouOgFCkfjWprzM6cGjQwhJ9hheo7Av2LzdydfJ/+cgwZzmNA9B9fVLgTWBC9x0goJGRIzylce6A3EPO/LTkZul5/+eXv9fe6lxEqB8nAP3xUrYz6tqUwLu+oeFt0lIAqL4H/VRGMoNBOHKyEkxuw29aD6d/9LJH7gsjLg/0jL9F5GNfqFC9rYuSECHs2PzPWz34TBQzVBRQ8Wr7v8bNa/bGbPLbhumWrwud+3MMyNy/zgoM78flDfF9COIshT5FigioHC5di2bJ/dbRkQiayKQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=W6ym2XrkvoCVfj/bDDss0KdT2huYMIRASlNgysi30JY=;
 b=lR1qh9gXFwAfbBu8SeVAwDFfWHABWMYTGGKWzi7oAXKlUhZxE6dcr/CFoiOT0vuTD2YRbF52a22XP7TKQGvhDkPJ95tqBtlErMztgqXZxQC8tYGey52zL6YY/S5oD1km0eYfAJ85JsdqGGTRW+4ruEEnE6dmyr2uTxAIqfSbX5riUEszZd4rOVF+qdXr+90mYz8yYdkUsXeJguU/oEmCmc7cJ9BnTYdvMvyMpE9fiomOcPk8JmJzDaoJyfM/vqxDs26ntCfcpA1Ro58IYqxDe+CQEL49R0oF9uA3QK0ojyN0f+XYS4lJsCndUQtqjGF+uXOwmLRCWCI2hA3zRaJL/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LOAP123MB8091.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:43a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.14; Sat, 18 Jul
 2026 19:01:25 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0223.013; Sat, 18 Jul 2026
 19:01:25 +0000
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
Subject: [PATCH v6 0/2] module: Extend blacklist parameter to support built-in modules
Date: Sat, 18 Jul 2026 15:01:19 -0400
Message-ID: <20260718190121.378314-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR02CA0044.namprd02.prod.outlook.com
 (2603:10b6:408:e5::19) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LOAP123MB8091:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f40fe5b-1697-4442-8bfb-08dee4fef705
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|23010399003|56012099006|6133799003|10067099003|3023799007|18002099003;
X-Microsoft-Antispam-Message-Info:
	waslTsSgkYOpivBXYTbMvug7S161jPIVaw/eiZ7RcxpwDuRhiQSMe2tszHbZSUg8oOvBiewTy/WDA6fCr9ycE3LQeKWRYPMVvVrCtOyLFdvZ6qMYVq++iX9ISk8bSZ2sxigrvbPDmbRmNDmZmlVz9SfSA3vCmA8HY9ssa4keCjHmNSPZE9LNi+oQYLjQ6c8y7V/Rdd+kSNXKW/cDQZfBHtfyxxUnwn32XzTAj+v74Fu/KDyms5buSLsnKZGDPtMu5am5IxDYh9/dUCwqahjfEIHgb3ahkvLKVdoabbkTjOxeS3RUBc1g4WTqASaJJtTrtpaf3chrOo70cixQ4G8/4u014L6SU+Qps1ulU8FDks3dWnSJcu0VOQR6OIpkab0dm86md0gXov0oD2lwAJkPIi2mFLtPfYa4ZxH9ZIv/bhsoJp4GLlfSRK7nLSQjXa7wtf2uhKp6PxJFLSPur48nvywQWFlyizUmWYW3SzxJVlAzQeIEjJqRczgG6mW8smKr8mA0mnxfe334yxppOO9qxKwmqayhmr44MdHj9DTRhMK8Q90L0XR5tcnfhNBQ2OEj4kp3iPAijC3Hs7psaSopMsEyx1u1bHLJTW+KLAsMmmrMht69qdl/PNdYooGOlUlXRTbtuwEw82Tp/HV+gzOdKws1NwYWXe+xCKpsFQ5Kzeg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(23010399003)(56012099006)(6133799003)(10067099003)(3023799007)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TxOGRYEeogvTIoINmbCYFtaYp23SFJmDdnjSC5bcG5m6j9axbAIxwNRZYLIC?=
 =?us-ascii?Q?4rOigGMGaHv1O6nSUq5dQTSASKkPd8PIkQHpoz32Z4nvjmByGTRjAK9+w8W5?=
 =?us-ascii?Q?mnyGA/KP+eHfp1duQfyWZ5dFJcsdx8zdm2grmJoT0IR+pSH+eXlPieiO91U1?=
 =?us-ascii?Q?vNnI2bDuYcLwqwaBfFxn9gOPCejvCsnkn5QFDui2nU/ax8xtmlXOeYdjn13s?=
 =?us-ascii?Q?0yPgf1jYaSvDn+9jR0xWcvulCHOo4PjFeO8HlZ8KjKT055ut0mVuHE40KIW8?=
 =?us-ascii?Q?igly76P67MyQD6a0T1fkYS5Y+59R4id937C6sz801ZMBYHRqAsaRTG0xsQzJ?=
 =?us-ascii?Q?uWpMl4NNgrYqlpfVVl7/t1GIJWC0b4b6clSbDsGRIiHqsK/Mqyr9YxvMX/Yp?=
 =?us-ascii?Q?+2uodjZI00ekX0FbdQXrl6uDsRy+oxoKWcFHQVt8zmvu5V7t0fkfzh6M59W2?=
 =?us-ascii?Q?tGh5icfQIXWagOgD4FjaNAWY3xlj/PL2HXqjPCSyXeFrapVEkoJTBIzVuaDh?=
 =?us-ascii?Q?P3q8w7WfTIZ0KRgv4abYhoC5Va5uEBPFXz3omUFhPGYNwHKbnj/WpfU0ByVy?=
 =?us-ascii?Q?CCzT7IYB+rAgGMQ9wURwGhbmFdo70PX0TQZZP7namloyv3N2tXqR1rRpAxKW?=
 =?us-ascii?Q?N2QBmzQnU3hunpExRaenUrcwFaikHjSBrkWjgqo7p/TrFltWbLtqSZYC4uEx?=
 =?us-ascii?Q?wTobKh2JDRoJuH2QsHPma9nI0sWKcPh283JWmHxK3bi+DXB9ANx/SpbJihyo?=
 =?us-ascii?Q?j/IGoVpCOKQEQY7JMcOgidB+2DuQM1CB0VcY/B5oG5lI3tVICeceKA/JBWoI?=
 =?us-ascii?Q?LnVjXV8Af++o676FLXdBuqsi97XFK/pfbSUvBFBpHQqGXnzbkfioKm6f6rck?=
 =?us-ascii?Q?5dOdKJFcUjJ5CrbLnU6AyCmlZRHnxBW4wLvvGEWMG2fyL7T9Vv7L8z9scs/Q?=
 =?us-ascii?Q?De/MOauk2de9UWZOlCmiPPUvdRiEZq9yJY8gFx8qeaG+7AcKdKabLu/uLMzu?=
 =?us-ascii?Q?6A7EZxqs8UCielsEWgVXmt1DPinFq5rh0AcvgCBQzs/XP6kvfwCQK9JroGXo?=
 =?us-ascii?Q?F46t6AZPNUkCwH1w7em4BS5MRFCki6Y6uagqYTW1QW7RLipjU6Rd1lsblXt3?=
 =?us-ascii?Q?WPJP5wexkXUqwB9z/+TreMMFfQnx1RIi67f22CnihzM3UFQpabEmGQG+E3zf?=
 =?us-ascii?Q?J5mYC7XtRrWaVqAY5gEczgpTdcSMU5Auhc1qTM8L1kRLJrbeN5JAW7ERDtfl?=
 =?us-ascii?Q?ogXhi2pI6TQg9RygdSm0FTrY39nfeORo0KqIJVQCajQRnjEqE2KVFsAqCZgx?=
 =?us-ascii?Q?z8wAbpCzJTq7gChMJlsx/Nq4mNz9d6lbQsg1YyqlTj1AeVi/ro1ARHHCSxyt?=
 =?us-ascii?Q?PZswwkYd4Svmw9/v5tDUTVJXXiNP14kkPoOhFiS/ol+pAjvrDmWGKHlQLKag?=
 =?us-ascii?Q?rZHJfXGd/WiNZD7deEWia3N9LGtJIqcK6Nyd8R2iJTJ+7CnQV4Ste1VjpH0a?=
 =?us-ascii?Q?RUWHSaYg8CsZuXz/0QH3/M3F2t1YzOMJiYYjDVZqIVPK32Y3aLXsdrQsxoBa?=
 =?us-ascii?Q?1AKAnKbCfGM/INKMR56OKh6PiYfSzw4AzXb3VJAiPqFoLkUar/UaIuLFDjTd?=
 =?us-ascii?Q?1S71hcJoLZ0RbcGTzVUYWSO9s0I/aethAbWNOJCJdxaHCh8iYwBvWQuxioCl?=
 =?us-ascii?Q?NAjTA+C4eKnV1pPVc4rG69YFCIxxW2PbwhKN+E90Om2Ry9111Yb5Guiz8Ry2?=
 =?us-ascii?Q?ZvxXjFXqlQ=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f40fe5b-1697-4442-8bfb-08dee4fef705
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2026 19:01:25.2806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O4s0xlnOFGn6PyGDT/7sL0bGKEque9q9DZd3Upad6joGyJALLH28/vJRt2oUCqW/qwJy4csSuA8srKKbOJ5XiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOAP123MB8091

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
 include/linux/init.h                          | 23 +++++++-
 include/linux/module.h                        |  5 +-
 init/main.c                                   | 56 ++++++++++++++++++-
 kernel/module/main.c                          | 23 +-------
 6 files changed, 90 insertions(+), 27 deletions(-)

-- 
2.54.0

