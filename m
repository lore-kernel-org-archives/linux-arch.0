Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022129.outbound.protection.outlook.com [52.101.96.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC72232395;
	Tue,  8 Sep 2026 20:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788899563; cv=fail; b=kCSjczTU1AAeU6Xpd6DEyrHf0FVqpODWhbpsW5+n2zMUKuWDhZYOrsIh4gAvkN+yJ8q2W6i2uR1hWq2blDOkhhZ9glGuFry47pTlurN9CvKjIQYHPxy8Su1YcsLGRJzFtXcxE0spjOE7KsVV3KZ14Ae7jIBk/j3AiYQpjGAs9V0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788899563; c=relaxed/simple;
	bh=wTlxUuByBz1STUoZPxWgZT8l9AaMFGoPHqe+Q/gltPk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Xl/JNXZkHq3RRYc//VQS3tSGrla31YQfBvQz5KiRdtNS4RgXxXZ1o3DRs3Fwtq+ilHfEnvj6KSvnVqb21/lbnE/BF8w4cNp8DxpNm8gCCHITpArpcEN/P5cZ/WwfYNS70e3Hwvhxn0ThNOhemO+9UKr6kpbl6rqCq3LWf6Pyfdg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.96.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SsuUNYfeThFy1fLsJTssVNY7A6Sd9ezom4z12vn2QULl8PbeF289Ri5+CN9/CozdbhDevGOc6e8riiVmirMGgHUQHuuNgzq74wjJO74R8dZT6J1IiF4geUOZ/280IQTWbEjTgaSsakzUWbCub38zomJX3Rzwa4BJG3dt6/qSW6aIstep6oFVyFutOmYwFM+d0PZKa3QnTWsMUToVn73+5uOLyZGpF8ee9ULlUPaAd5fzKe/HfLWNQUUo3QWwa4ezpaY75SG7UDll8PnuTxnmrF8+YZT1DpByneeWHsV29xiWMKcBfKfAuIYpzw81IMiolTj7GX6VVLHqv6dW99wRFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=yNBMseKDxx/wOYsXnh7RHqZsWMeQjcDSdmFjOS/Xnm8=;
 b=bMcjoDOazdYZ9chJsQqJQpER7A+N6HoqcA3FV9uRkIkAHgOSjq3JayRK6r7meRJRW9DtcqkEa9gZIrZww3JpkxuRUSdci80egmAZAoG4lOFJlrAs1duG2t22dqey3MHXIAWvpxsCVpq85zVq+JHYVfEDyIUl+tEEM8lAu5Y/gIv6pfqyxXluxAEUUdmhYL+vnqOJIu67k/s1Q7juURJN4mmeTZ/tZXA93oOCcXH5GIcvehiueufJ88FxDMcZZKh7b2gWo5ZnuaCWysw8TWDEE1hWQ3Y+gsN+Nxy1R7n7edHpjCsGjnsROMRRYlPcNtmi8MWuNeUBLqxSdKdHfwJqQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO6P123MB7126.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:341::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 20:32:36 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0406.005; Tue, 8 Sep 2026
 20:32:36 +0000
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
Subject: [PATCH v11 0/3] module: Extend module_blacklist parameter to built-in modules
Date: Tue,  8 Sep 2026 16:32:27 -0400
Message-ID: <20260908203230.401020-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR14CA0049.namprd14.prod.outlook.com
 (2603:10b6:610:56::29) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO6P123MB7126:EE_
X-MS-Office365-Filtering-Correlation-Id: c58d42d9-3c44-434f-bf17-08df0de85134
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|6133799003|3023799007|10067099003|56012099006|5023799004|18002099003;
X-Microsoft-Antispam-Message-Info:
	hfeObBphrhOBGk3onWPys0kwz9E77BGxflC6tN0kOul3tDCKdGnX08QmSHciBOiDYTniJYxieNYYXw7Fb0+x80WY/e7hxuOzW4YuVwQGVxAJARAWS6i+Fu4/YOf9+Ly4eHeVaHLfNZoCdb+LrOA8hJJGPWY//7t/qhP1gOz9qSfmZdrv4kU1epZBmjrTc1XrGhdzs/g7HtNx2BVD5bCXxL4m3ZThgarhmXJobUBnPO3vK9hqVTdx24i0sM+mL8DdE0yoh/OBa5BHnRk8uZLAl2jmAARzuPQ1ovvmCIgPEUpnVrYpfR6hDCUvVJSqOTtRKTigdlpAhLSUDtS2php5EtMFVlAC3QPP7DVFjQ7WhR5CVwG6RpWEfGU+bRkUe/ubTjm0OO18RiPM+pPkVT0m9qFD9eLEZhmeq+YWam39kpKhY/nvQbtjqPJWzSKAjHVkufkLxKQKQSg3EhcsOgR0KAPaixGv6G4hxHeAqLPD3jdqhxeC4299vTGme+xCsBCGoUe2VMiplPSHOeeq+UAZA2p0BANZqUA/AwGdugSO5Z6gt0IHA1B1/SGTRUtZp0kUzNVxwK3/aRXIjsbD85pM5pOx9AOvmszOigkCsfk1v1qtWRpV+Ha68Nzkcxc9Zgg3+u15bR54wH7arCqfnUQgS48OyfKDytMJXDQuHC9/rV8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(6133799003)(3023799007)(10067099003)(56012099006)(5023799004)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LqDkzH9r4KrFY++49VoXVEbVLFFJXK+0ufeftODQlBPGvrVPc3Mpf0sJvZRP?=
 =?us-ascii?Q?YdmkHAS90m7xAcaflOMqvWJHFvHiZDNjj/iYLx/fbwgbFvS3zWtsOxk3MloW?=
 =?us-ascii?Q?SNOQMguHelW3IOMJMl2CqYpvtgn4BCRmcgcNEz7exXS5uTFEE/Q9oighVLFY?=
 =?us-ascii?Q?Nn9T6+s8/AeAjNdVMZLqIqLf2H4INH4kEhwDGLBszBCMlBn7KdWVSK6fhzIv?=
 =?us-ascii?Q?JdJDA7aLAX2ctOjFAtMYQvvQxB7U1tOlK6nSGvs47nlgeSMk0Q3O00B+Vjxh?=
 =?us-ascii?Q?gijg8B4WaTygxWeCqTsivmez1Z4auknxDWV5V7zWo3jX3bFZHFyrWKaIHo4z?=
 =?us-ascii?Q?DCQe456z4ceOY2R9TtShI3XJoAgFCY8rDCoGogHcsSgHJPqTkIfLz5KAHDlu?=
 =?us-ascii?Q?hQs+IhXAC9JX2WsBxld3Axm5f8HjzGAgp76khbsfN7+wUre6cVwxQehwzGVl?=
 =?us-ascii?Q?Sc11JyYJcFkT1uYMPbxWpDNm6J94jL1iS298PChdmH+lq6eWAyShUZgjpgou?=
 =?us-ascii?Q?htpFkKBVUm2Z3gvTcTd4DBJ0bFO6yY/zk1jc22WlYKFrzpDdHhHIJ4Cg+zWQ?=
 =?us-ascii?Q?zwGIZKSTEtXcRGq768uga8BccNBt0kbEXOCOqA+gwFDUTuSP3TRVUUCV/SU/?=
 =?us-ascii?Q?qQnhwka3ftXRCcItohYc9EHccvvYKvmw171p/4l6P041cSSpv8/lH6el16uP?=
 =?us-ascii?Q?8JjtnvRwMfihbNMZib+V7JXt2DQTWh5xLhPIkseQPLgM1EAMx2jitk0nAUTu?=
 =?us-ascii?Q?YA9twalwPPMSKI7WDgI52SXxdbyOkxs+GHW6Fg0RZyNeiSHjQcc1RUG3RZqz?=
 =?us-ascii?Q?t4P4AK6zdo1C7ySBusZn7CYKzvb8nlVVRCk210Ja+RjWedgQIz+Fptcd8EyC?=
 =?us-ascii?Q?LALS5zYd5d/d7OezwL1k4gFEXyIFhBvOVNsXStiKp8h4SPzuMp37TzHvOKYK?=
 =?us-ascii?Q?idS0aoRgJrvupKhIbJVASNjEH4n5xMALngxxncdqp2aRbEPztKaEr+/r3zAW?=
 =?us-ascii?Q?MRwgIfsKnivTsNJsqcPoDIiAsb14rxn0uuabzIVvSp/SViJSFvvNPmHBMyy7?=
 =?us-ascii?Q?djR0QbDqyqmVdElRAbVIbYi71kusohOFRPfO0U76rnssdSETkGCIGKQ/+jVI?=
 =?us-ascii?Q?aEgYq3fgIPJRhAsX7YC3I0zpfUSB/ILva4sa8JOxUtNHf2DHWe/ugsvhgKSB?=
 =?us-ascii?Q?3QF1oTBIi4t9LtdayY3QQBhKlfOefGMur0MG25MfkYnB0Z+ZBhTcntxs9wNs?=
 =?us-ascii?Q?OvM0P66qMzVsojmz+MrM0Jj/ExwQAGhq4onERDRJj5Ct3pxey/QmGxlKfNae?=
 =?us-ascii?Q?DkCB+wwYbtvlZClBkmii0JD3uIMovT1ozd1Mn7PDkOv5UYnUvb6xhQH7CWch?=
 =?us-ascii?Q?a6XUyqQNVi7Y9HI8SzQk/PPs+LvrSuUrVT99LZl4KW7BJI570jE7kQBftC87?=
 =?us-ascii?Q?MeRNJKazPYhJqNGMNkeFj85yJPF0VheVeM56+QXtTwxnuWiv1H+ozr22ONt4?=
 =?us-ascii?Q?CONYFFNeesJIVbefQ1VTxIlvrwQNoOSVdq2Y/ggXAO6gR1lXkWZYi7uWbWLG?=
 =?us-ascii?Q?Y5M1XDCqjTiFNVu17Y5zUznAp01jo8Q+1Egvs8fC4im8DG06dnxaFje3Bwyj?=
 =?us-ascii?Q?TiqJchnC4BffeACR4dxv/yH3FWIhJ7XvCta633tIQGWiIajdbISGr1VSjkj3?=
 =?us-ascii?Q?OetcUgms9AlUxyy9OaItDgpgWIrHqyyTMyV3FUMf+ZXVwme2w8ZGzPPCUfpr?=
 =?us-ascii?Q?fWVJV24WJQ=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c58d42d9-3c44-434f-bf17-08df0de85134
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 20:32:36.1738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BXePFagF5b9vl4sJcaCiFktI1Sjt6gX6AlEYJLZMXoLVfY2o6tECHWLb7MBtgXAvnDavjmc1Z8B5XHTWgobP+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P123MB7126

This patch series extends the module_blacklist= command-line parameter (and
its modern alias module_denylist=) to intercept built-in modules during
early boot. Currently, when a driver is compiled statically into the kernel
(=y), the parameter is silently ignored, precluding administrators from
suppressing problematic drivers during boot-time disaster recovery. This
series resolves that discrepancy by mapping built-in modules to their
initialisation routines via transient metadata that is freed post-boot,
providing a predictable and consistent administrative interface regardless
of whether a driver is built as a loadable module or compiled into the
kernel image. Below is a detailed breakdown of the motivation, operational
rationale, and concrete use cases addressed by this work.

1.  The Core Problem and User Experience Gap
============================================

Today, module_blacklist= works strictly on loadable modules. When a user or
system administrator encounters a driver bug, hang during device probe, or
hardware fault during boot, the natural and widely documented remedy is to
pass module_blacklist=[driver] via the bootloader (GRUB, systemd-boot,
etc.). However, if that driver is built into the kernel, the parameter is
silently ignored. The kernel proceeds to run the driver's initialisation
routine anyway, leading to the same panic, hang, or hardware misbehaviour.
From the user's standpoint, whether a driver was packaged by their
distribution or built by their provider as =m or =y is an internal
implementation detail. Having module_blacklist= silently fail solely based
on compilation configuration violates the principle of least surprise and
complicates system recovery.

2.  Why initcall_blacklist= is not an adequate substitute
=========================================================

The kernel does provide initcall_blacklist=, but it is impractical for
general users, sysadmins, and automated fleet management tools for several
reasons:

    Obscure symbol names

        - initcall_blacklist= requires the exact function name of the
          initcall (e.g., snb_pci_uarch_init and e1000_init_module). Users
          typically know the module name, not the internal function name.

    Internal instability

        - Initcall function names are internal kernel implementation
          details. They change across kernel releases, refactors, or macro
          rewrites, making it impossible to write stable bootloader
          configurations or recovery documentation across multiple kernel
          versions.

    Mangled names (Rust)

        - For modern drivers written in Rust, the initcall symbol names are
          compiler-mangled symbols (e.g. "_RNvX"), making
          initcall_blacklist= practically impossible for a human user to
          specify manually at a boot prompt.

module_blacklist= (or module_denylist=) resolves this by allowing users to
specify the canonical, user-facing module name (KBUILD_MODNAME) that they
already know.

3.  Concrete use cases
======================

    A.  Disaster recovery and triage on production systems

        When a kernel update introduces a regression in a built-in driver
        (e.g., a storage controller), administrators need a way to bypass
        that driver at boot time to get the system into a usable emergency
        shell or collect diagnostic logs, without having to rebuild the
        kernel on another machine.

    B.  Monolithic/Hardened environments (CONFIG_MODULES=n)

        In security-sensitive environments, kernels are frequently compiled
        without loadable module support (CONFIG_MODULES=n) to eliminate
        module loading attack vectors. On these systems, all drivers are
        built-in. If a hardware erratum or firmware bug triggers a hang in
        a built-in driver, administrators previously had no
        module-name-based mechanism to disable the offending driver.

    C. Hardware Errata and Conflicting Devices

       On systems with buggy firmware or conflicting device IDs where two
       drivers attempt to bind to the same hardware, users can prevent the
       conflicting built-in driver from initializing without patching and
       recompiling the entire kernel image.

4. Implementation and Overhead Considerations
=============================================

We took great care to ensure this change introduces virtually zero runtime
overhead:

    Scoped to module_init()

        - Only built-in drivers that explicitly use module_init() are
          tracked. Core kernel subsystems using core_initcall(),
          subsys_initcall(), etc. are unaffected.

    Zero Resident Memory

        - The metadata table (.initcall.modnames) and the module name
          strings (.init.rodata) are placed entirely in init sections and
          are completely freed from memory after boot via free_initmem().

    Fast Path

        - During boot, if neither module_blacklist= nor module_denylist=
          was supplied on the kernel command line, the lookup is bypassed
          entirely.

In summary, this patch brings parity between modular and built-in drivers,
removes a pain point in boot-time disaster recovery, and provides users
with a predictable, consistent interface.

Following review feedback, the implementation is structured as three
separate changes to isolate a pre-existing bugfix, decouple the
introduction of the new feature, and handle the terminology renaming:

    1.  The first patch is a standalone prerequisite bugfix addressing a
        pre-existing flaw in the module blacklisting logic where hyphens
        and underscores are not treated interchangeably. Because the kernel
        build system normalises module names to use underscores (e.g.
        "my_module"), specifying a module with hyphens on the command line
        (such as "module_blacklist=my-module") failed to match due to a
        strict byte-for-byte memcmp(). It replaces memcmp() with
        parameqn(), carries a Fixes: tag, and is CC'd to stable.

    2.  The second patch extends the "module_blacklist=" parameter to
        built-in modules using the original blacklist terminology. It
        introduces the ".initcall.modnames" section to map initcall
        function pointers to their associated KBUILD_MODNAME strings
        (restricted only to module_init() invocations to save memory and
        avoid matching core kernel subsystems). It also restricts the check
        to a boot-time __init wrapper to eliminate Use-After-Free (UAF) and
        Spectre v1 vulnerability risks when loading dynamic modules at
        runtime, and adds a fast-path check to eliminate lookup overhead
        when the parameter is not in use.

    3   The third patch renames the variables and helper functions to adopt
        the preferred "module_denylist=" and module_is_denylisted()
        terminology in the codebase. To preserve the existing user-space
        ABI, "module_blacklist=" is kept as a legacy alias pointing to the
        same module_denylist variable.

Changes since v10:

 - Introduced a standalone prerequisite patch to treat dashes and
   underscores interchangeably in module_blacklist= via parameqn()

 - Added '. = ALIGN(8);' before BOUNDED_SECTION_BY(.initcall.modnames, ...)
   in include/asm-generic/vmlinux.lds.h to ensure the location counter is
   explicitly 8-byte aligned before the start label is captured

 - Fixed a build failure for built-in Rust modules in rust/macros/module.rs
   by using Literal::byte_string() to initialize the static byte array in
   .init.rodata, avoiding an unsized slice dereference (*(&[u8]))

 - Expanded the cover letter to detail the background, operational
   rationale, and concrete use cases for built-in module denylisting
   (Andrew Morton)

 - Link to v10: https://lore.kernel.org/all/20260903185557.183224-1-atomlin@atomlin.com/

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

Aaron Tomlin (3):
  module: Treat dashes and underscores interchangeably in
    module_blacklist
  module: Extend module_blacklist parameter to built-in modules
  module: Rename module_blacklist to module_denylist

 .../admin-guide/kernel-parameters.txt         |  6 +-
 include/asm-generic/vmlinux.lds.h             |  4 +-
 include/linux/init.h                          | 25 ++++++++-
 include/linux/module.h                        |  4 +-
 init/main.c                                   | 55 ++++++++++++++++++-
 kernel/module/main.c                          | 24 +-------
 rust/bindings/bindings_helper.h               |  1 +
 rust/macros/module.rs                         | 19 +++++++
 8 files changed, 110 insertions(+), 28 deletions(-)

-- 
2.55.0

