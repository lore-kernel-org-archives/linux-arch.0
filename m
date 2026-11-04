Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.196.85
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793806822;
	b=t8AD4ZbsHc//oOwupQm8n6DndPDGWujecoQ0VX3cYtXSsac3bqUTNvzeXrKvmRt1/C4a
	 b3PAWDFbTZooYP7cG9sF675cijvsaIKedUvVC1fiLY4dpBddh/+oLzy3lZCZa0Ae/xQ3x
	 wkSAwDBrS1CnEcl8p3YwKNtziEMzcrrSREcESDSocwnPciStFzyK2bDt8gUHTSgjIEO2p
	 +AnP/wirrTEHZnRwrC2UOZPZJj9aAuYH/9IYBpqpymKQHXWhIOa1dSbDFf51vqswtg/ca
	 k+WIiK09c2/KBp4b1Tv4CifGPulOIwRShmI137SeLd0SR0wlun+zBGNISdsx3hyDtuw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793806822;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=0w2sKGOZ+B8bqTdR3kDhKqluGqfnxndm5NwtwviGInE=;
	b=QW9+MA2WysRoYHQEq+ezFTKML/fToDEwx4QynEdTtSnxYdHEgQXn6GXZUCskOTXIt7IN
	 WWqYxFAAyqNdvL1M7fL6cAzJIm4hQZuC4+9ujmyiiYpD2TVk9372/oahl7IadzT0tzTfC
	 gnxG6IwynO6wBA2xGwornQa3l7Y1VCgeNyJ+0L2QBrCh18cd9S04kJW74JQHaRi9vd+9V
	 gjy81vDnHLiZ1AYiuwjbLxwfg4ooAofU6Fa/c6DxgYANnUtruAU2PmIp6xrqjNaH4YA/z
	 5AQcCbNpejVz7+fKA9ytHFd22m7gmiTA3tWPeG/sg0ohMjsjr4T6fmoLvjRguZaTVFQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=atomlin.com;
	spf=pass smtp.mailfrom=atomlin.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.196.85
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020085.outbound.protection.outlook.com [52.101.196.85])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150EC606D816;
	Wed,  4 Nov 2026 15:40:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 150EC606D816
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CSV5EVZA26TvRn++HI5ZFBF0/Zm2UrtFiJZWEUI10qadB010/AOvqsj8d2vZn9Fr/4ZBLiwEfW0S4Clwip8qA/DBOqnq/8R/ef8yxfExGdqk/lp/L+5PmMKSb6H5Taw5FD5Rxv45BnLOxud1l7xMPFJ+f+4VeAq+Ponecy8Q7rIOKLuya55Q0C0OgnmPemaJZ2dCX/2pAlrT/w1O2ZtU24ckmUdhmMYngYPpgcnwDijPaQSorVDuTtltTF9vDjT7Th94GpG0qhzrGTurTaL9AIsccom1yN3ywFUlOIfJeMCh/xW5fgrbIGnR/ArooUtB+T6LD+XpJwNUT1EiRDnRgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=0w2sKGOZ+B8bqTdR3kDhKqluGqfnxndm5NwtwviGInE=;
 b=RLUwAU/QJOO/Y2JOfx0s1Mh4qKScxUBBj8kqka0+OkOgwkV70pV/sfv8wzWWMyMWQkqkXw0m4nSFMREkdIHgZii75CUt4ocN1yOUaWVo28c277jxRDO/cO6Xaf23Mku2u0Q5IXKf+DJQBA5Dz8znqnCgEAbIMXMEPECrgT051Bsnz819+2x/z4G4m3RbbdtU2N5Gb8kW7sAFlIsgPFsTYrYgPfDd9cy9KAPniQYsuwIhrVMwg2ISAbQhfqt9PDgmyuvnmXInVqtu7VMY8E4y/dXIvH9ZS2yM9Kh922LnKBJXsWhujGnl+FCUTIfv5szBABkZnQs2XDMwYyZ5+RMU2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:163::8)
 by CWLP123MB6624.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:182::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 4 Nov
 2026 15:40:10 +0000
Received: from LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f71f:a9f:c4de:687a]) by LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f71f:a9f:c4de:687a%5]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 15:40:07 +0000
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
	mproche@mail.com,
	nick.lane@mail.com,
	linux-arch@vger.kernel.org,
	linux-modules@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v13 0/3] module: Extend module_blacklist parameter to built-in modules
Date: Wed,  4 Nov 2026 10:40:00 -0500
Message-ID: <20261104154003.43313-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQBPR0101CA0243.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:66::24) To LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:163::8)
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P123MB4190:EE_|CWLP123MB6624:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a0da718-5ff2-452c-8966-08df3a89e730
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|5023799004|56012099006|261021135927099003|261021123027099003|261021121427099003|261009221227099003|261009223027099003|261102123227099003|261026121527099003|261102124527099003|261022075727099003|261022105027099003|261022115727099003|261022113327099003|261028144727099003|261026140227099003|10067099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	Sp5Lihiv+GpRRmHFDwkGxKbh+OFg/3evloVhW+ErM83tm+QCROoWSQ5CmaMtPpVcWpthtm37xt4mxte+XgJaksDISF+Fg4bHGimI3gj/9jC3kE3FvSwionyt8seECAe8WwwtyQEhge9NLcmSYdeZGDNbx5sbm08Q8lwZQr82R2EKrue5w0VpmfJMmDz2tZUztp3fXGPJqfsQoYB2EJ3BVcyVbhiSlNa8h5E2r05f8BT7vTzTsiR8FvzD4QRIUHjeFB1jP6aoRZT6uCqexgAOyZhK+wJeL3vTVZ6Wdm7EtUKf9wczwCir3QDlttOrdQyi+9fCRtTcJieAcIBoAo29sV7O0Onfu+G4bnIxeQvXtZdAIu63FRWASslwLIvAEed7HuEVMJpIs0RWlE/hrBVPuCHePOicfMG7Wtoal0Z0MfOMBaFhzPJ43xgERiByTeAayCumYrfBscZ6NLQyurs3NzTyaj0n48AQ21G6Z+0eCNKdv5vKe92ruo0uyohIP1Fd8Lqu6WyBbf2AKKMGocbDQ17ndizj3QoQNBL1whG+i0gD3sLhjAO8JIlb9/PzGanF3ErpJfhc/BqZbMRvX8GR2jo0tQmvB7KEeFJevK8kA1FxrdjilB/nHBBKH7Wi6mjU
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(5023799004)(56012099006)(261021135927099003)(261021123027099003)(261021121427099003)(261009221227099003)(261009223027099003)(261102123227099003)(261026121527099003)(261102124527099003)(261022075727099003)(261022105027099003)(261022115727099003)(261022113327099003)(261028144727099003)(261026140227099003)(10067099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?05lxx086TrLgc69YVOEE/EgMMQGK+Re5VTqxCdar0efP0gGvl9/ZHfokXrNS?=
 =?us-ascii?Q?SGUwY/h6NTpTBQ2tnKvFA+n9zzdpcNLA12bHT5HlAz6c4ZXSew2hbnki0NCh?=
 =?us-ascii?Q?JWVKYzx8RgpY7ClldPnWQHQT+Y0ssIw/QpcZx2EKwsCLKmeQvz1S77Xdw3WN?=
 =?us-ascii?Q?fuuOpw2EXNFsirdp5U0BoUUR8akzwHccHypwUjXCgi9Ejf2m8nuV5q27Navo?=
 =?us-ascii?Q?8iZFWYt1TY2kfPYqa9RiJGrImXaSt0o/8vG9vZdPXxnDfnWoeMy7XKAcjTNE?=
 =?us-ascii?Q?zz+gt0BD5I8YgT3lwL9ksKFnxLd4E017McQDxKsIl7JbpGVrcNqOcLwh8fed?=
 =?us-ascii?Q?xHsPAnzddRyuvvXFz/fBvKZ2YyZXN1EMGCcKN3SzkfvBdnPc5NQyjyhwAGR9?=
 =?us-ascii?Q?06vjvHCag21KWuCeCIImxQdmNefNCnO+atKXGk7xdczIr+eySUGIvzWHfvMT?=
 =?us-ascii?Q?wxM7T/RV3JNxojpmJAdWn76TxJzjdeAGC1JKovgmmZssI12YSb4VL8IaoKM1?=
 =?us-ascii?Q?UIQEl2JD6jQcLQSUHecuoUNrclGPOLd0tWHzX0XLhwSRpmz7xOp7nYI58DPt?=
 =?us-ascii?Q?2wP6QrMPWwffifnIx/YusfCL+JiLCWOv8S1X8Wy1posHTKoXa0gs3v1ZuLiY?=
 =?us-ascii?Q?xHUQHo1aByD0zFP3J11pQUOy52KRJ5uqAHArPdBIJid1+6qRR87TS/9AESn8?=
 =?us-ascii?Q?3MOk4Lfjy5ofrXEUuwGDEyQIfNNFqbgTgGjrh3kceqZ95dO85E4suXBMJoPn?=
 =?us-ascii?Q?RqflA4za30vrlH4pgL+1q6KrXwsFXBUjLI8HBLF+/KAF0Ka9TeOLAKASAHBI?=
 =?us-ascii?Q?QrsKXJ81gZ84m6Twg969+0y6qHUoX7RVERwmMP0BToTrKbNIKLSpviaFDQVC?=
 =?us-ascii?Q?7wXQbkBHpzhTG4nQKdQmlpWMbGgY7o78/9T14loZi1YIxKYiwf6QZAHPt9aj?=
 =?us-ascii?Q?Q5Be0072w9tKYrddIPkQAqvSS3krhYTQBMONK5Y/qiFdfjNb0fLIQincAak6?=
 =?us-ascii?Q?SFNCbRCWXV5RYUx5hBCI49N45B9YHssa2KNjhkNpCEOOd6bwdHI0C6NdtTP8?=
 =?us-ascii?Q?tMkXVxx0wds9WWJSTHr0Ms7CVHmOUthJ80p8DXLlu41dW3PHCGBcUETCedf+?=
 =?us-ascii?Q?PVIMkZEd90A8N8Dw2PZPUFr8L6orywRj3hGYBNMDl9Uck10KdliEsnIlGoBR?=
 =?us-ascii?Q?YmTn0zi+VhDEjCwwGlxqBnOv38EhoompSAsSnehniKSES21KSJzOZRlH0laH?=
 =?us-ascii?Q?Qn6pvGLGe/s2dSeTfQi5Keyf3taFUaswdhkKZxiszAnDQU2Wx/b8bZwh19Ze?=
 =?us-ascii?Q?B9VccqnzSxaxQzB4lpGwVWZ5Sw2muP/X3pFXNYf1BLX7gpW+PCSTBreVi4wL?=
 =?us-ascii?Q?iASxM1Q/Dw+u0niNDhP/FBDZHWiTcu3qzE9ffH9DWjfj421FEDhajPpPlfzS?=
 =?us-ascii?Q?yMxhkBeRgEKayLXZhue8LR6YE0ye4LgfpVkKhbcEsfezbpbAmRufZLQsRgP1?=
 =?us-ascii?Q?5whG5U1SS9mFo+kcLULpnp3JbdqJQQ4OSzHgThPuuJZqlhMe/qDwfF4hRlmw?=
 =?us-ascii?Q?6sw8EVQwClsxfLHxDfjd3Jji0gyw+wwu6N8JhgjHLs+Zccyino1m2KGdXJM2?=
 =?us-ascii?Q?7ZcayY0cGZSwxGe0sYWheWSk21M8NmUssoZwObTDLPHqvmJVRbfGaUFIoyeQ?=
 =?us-ascii?Q?zccyPkLZtgiiIxSutBPs629ergGK9v6nHKmNg3HT9bSw6uRmNer2JGQJNjge?=
 =?us-ascii?Q?uevuxf5o1Q=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a0da718-5ff2-452c-8966-08df3a89e730
X-MS-Exchange-CrossTenant-AuthSource: LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 15:40:07.6758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 307gkoqv44aclfQeWdpTmyJfVehpO9/PdpoVYPdA1XyjRjBjzBn4f5Y2xXuxveNt6M+g8NqY95DGfeHJkz0xsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB6624

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

    3.  The third patch renames the variables and helper functions to adopt
        the preferred "module_denylist=" and module_is_denylisted()
        terminology in the codebase. To preserve the existing user-space
        ABI, "module_blacklist=" is kept as a legacy alias pointing to the
        same module_denylist variable.

Changes since v12:

 - Updated Documentation/admin-guide/kernel-parameters.txt to explicitly
   state that module_blacklist= and module_denylist= prevent both loading
   loadable modules and initializing built-in modules

 - Link to v12: https://lore.kernel.org/lkml/20261103214223.32598-1-atomlin@atomlin.com/

Changes since v11:

 - Replaced BOUNDED_SECTION_PRE_LABEL() with BOUNDED_SECTION_BY() for
   .initcall.modnames in include/asm-generic/vmlinux.lds.h so that the
   table remains inside the .init.data output section rather than
   defining a nested output section

 - Introduced a #[repr(transparent)] InitcallModname wrapper implementing
   Sync in rust/kernel/module.rs and updated rust/macros/module.rs to use
   it and allow non_upper_case_globals, fixing E0277 (*const c_char cannot
   be shared between threads safely) when compiling built-in Rust modules

 - Link to v11: https://lore.kernel.org/lkml/20260908203230.401020-1-atomlin@atomlin.com/

Changes since v10:

 - Introduced a standalone prerequisite patch to treat dashes and
   underscores interchangeably in module_blacklist= via parameqn()

 - Added '. = ALIGN(8);' before BOUNDED_SECTION_PRE_LABEL(.initcall.modnames, ...)
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

 - Removed STRUCT_ALIGN() before BOUNDED_SECTION_PRE_LABEL(.initcall.modnames,
   _initcall_modnames, ...) to eliminate unnecessary alignment (Petr Pavlu)

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

 .../admin-guide/kernel-parameters.txt         |  9 ++-
 include/asm-generic/vmlinux.lds.h             |  4 +-
 include/linux/init.h                          | 25 ++++++++-
 include/linux/module.h                        |  4 +-
 init/main.c                                   | 55 ++++++++++++++++++-
 kernel/module/main.c                          | 24 +-------
 rust/bindings/bindings_helper.h               |  1 +
 rust/kernel/module.rs                         | 18 ++++++
 rust/macros/module.rs                         | 23 ++++++++
 9 files changed, 134 insertions(+), 29 deletions(-)

-- 
2.55.0

