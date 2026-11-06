Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.196.141
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793983532;
	b=xXXTPKIKgYcr5NTjysUdmA9xEUxjxiUMydhuqf8THxMaBXwH0CDaZMjsdJDmSlYmiYXC
	 U+mL4gBsfZgTKNgz0PCRmeIhnwP+//sr/1xAL4ndisVTQ+t+TrU8hf+HeRWnapNPP/t2y
	 npNaWsFsrJS1V1SoPpMivKpTf8QGCXhyDom8mm7w9qCpj72Yo80p+Uoetpkrlpg0EG4Mh
	 Br47r6KIejON6L9I5kOTyIm2pB6AFrDn08BCBhW+0YW1dGLBc3NfLKoFb5B9s8YuLVsyc
	 oYmMrLN2l4YaJp9V/XjXyj6tpRxBOOHUVpSVnjkxQrISX6fVUByLzLrD75PIJPSyP3g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793983532;
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
	bh=HYiKQsiFkZiToI5O151BV4sE+6LaLG23PH3hOnfOZ+s=;
	b=zaTbv2REZV7DU8HNrX7iyiDdKl2aSzOGzPgKv2nmKZAUJJNSt6NHGCahRbX6tKgiiJg1
	 /pki8xRPaNPEURK9fqCw3/MhoLJYtBceK/BOI08+xEavL1a1jjN21ZceDKu/OhlaTaNne
	 /DrKU2INUQvOmCnA9ZxwrZ9n7pGFlsGOuwhV4kOvhlvBHs3c6bTGXKZKnqnlaOI/TzMb3
	 hTINz3C8H+qJ4orXQyDKI4RWwXvjNmq6h5Q045WweAUBmtUMFnHzryd2bdHj+jQASrU2N
	 jcVj95I9ohnpL3Q7pxGdlCnoSr4ER9CIZoOwsy6bLdc/8Z2Amfo/IzQoEwXNnUWSSpw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=atomlin.com;
	spf=pass smtp.mailfrom=atomlin.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.196.141
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020141.outbound.protection.outlook.com [52.101.196.141])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC964606A329;
	Fri,  6 Nov 2026 16:45:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC964606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JpWjKEQusn7FFqEH3hlqioSvkpzKxFpoVJrSgI0lzgRxdr/LtKBT4adV2exIbxlBeSBM1BTx7FkdPutpCbTXkrSIluE5/78FHZhY80KD//VJ3mn7xRboDAqlXiJWhqlJrV+8ndF45a6X9n+ZMi4DCGyMzp8BupSsEXcPucQDFgbHMKHdsJdp5GHTslhAJixWPY0tMyv55SWHmKLsAexPvb7M9W5rbs53mY38FfxoKJJc90CqpfIrNlZcKtRQX6qOD1p7v+yYRdZ102EnGn4LklitziUVQm8g31yRwGLyRzWMlJ2KFq7BCn6v19ZI+e8+1xhyTZSEW0kZUMF/thBwuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=HYiKQsiFkZiToI5O151BV4sE+6LaLG23PH3hOnfOZ+s=;
 b=R4ky52Drj/r7rD/kJzyJJj388TLwCXF7WTnGrEqzk9/I0NHQH+h/svvtmpbqraSyTamR804WCDg/EoiBwuHtG5iuSBFeTpudemZ8fX1ZC13Oq+fqAv3+fSgg7kpzryZfxtJOJHMHmBEKYy0Lr99YGY+yMTyrLZXDEYQjntN2OqEh8pxCBZC/If1S5O+j98yAqZJOVlVWzesmoNNnAcNqICbYNZC0AkMOXAS0/1eenLpmCW8QcFxO5U+Bh3XFDDKM4GG3EFNMBZvIUNaR1xCGT8ApHhi+q7mWZdkaX6yu/WvEecL0Oa3NDDTZLIrgWhPYHm8HgmODmvDRGm+R8CFIeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:163::8)
 by LO0P123MB6202.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:1ff::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 16:45:25 +0000
Received: from LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f71f:a9f:c4de:687a]) by LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f71f:a9f:c4de:687a%5]) with mapi id 15.21.0592.010; Fri, 6 Nov 2026
 16:45:25 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: jpoimboe@kernel.org,
	arnd@arndb.de,
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
Subject: [PATCH v14 0/3] module: Extend module_blacklist parameter to built-in modules
Date: Fri,  6 Nov 2026 11:45:18 -0500
Message-ID: <20261106164521.116168-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH5P220CA0002.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1ef::10) To LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: LO2P123MB4190:EE_|LO0P123MB6202:EE_
X-MS-Office365-Filtering-Correlation-Id: 21a93ab4-6ccc-4cab-30c0-08df3c255b58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|1800799024|366016|376014|261009221227099003|261102124527099003|261102123227099003|261009223027099003|261021135927099003|261021121427099003|261021123027099003|261022113327099003|261022075727099003|261022105027099003|261022115727099003|261026140227099003|261026121527099003|261028144727099003|5023799004|56012099006|3023799007|10067099003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	MzooYO0OuRbFFB5U9MpD7B2zYcye1HUIE6XCuxZjNlnArNwSVeQgFNnTt0NMq/W9/bkLJ3FPKcZNSAJrkDSYFNM5d+zyY7MVAs/u/IENf8Iw1TxOwtO18f3eX9gUqCe0QrVYBZoGnPLsJ8NQCRyPgHcQAW6X6rhvrn8ijJTwwu6AIglk8i2nyfZRpY9k3px5/koH5tq4a8qlnBGk9Ky7zAtRnSllRvOA9LH4anq7zLnd6a2okXpAa24aWvdhjOnAKDaq/3CAPLOY+SEGbHlvLSlNwzXKF4lX0Fz1qQkjP0EmfbQQwboJdd5WAutfUI5/ArE96Hk8n/AuBsT7DgFhAQ9VP21Y/atMhM68wJc9kKuWIQuMKH89kqQtv68FPHF/JbCieAvLzHGp7VVoAkDnfnjNlop5JhHF0UiRpGxvq5RGIoIPdHBt5LfMr5NQ5Kd3XAVEzy1ZtjddrxXarlFkylFtftweZYbvJoroxaLrlSeUMjaS4MzhN8bBkWVJdlyr5DGKEss3ugphVCfuHZaV0bNAmlD4Pl9i3Ge6RFNoYlDPMrVAF/J0KxGXQllYc0iSl0S3lqE9SOm/fSR43SghYLK4C8NNKadF2xzQjJtAGOpw7or0n/EI57moEP7VLFL7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(1800799024)(366016)(376014)(261009221227099003)(261102124527099003)(261102123227099003)(261009223027099003)(261021135927099003)(261021121427099003)(261021123027099003)(261022113327099003)(261022075727099003)(261022105027099003)(261022115727099003)(261026140227099003)(261026121527099003)(261028144727099003)(5023799004)(56012099006)(3023799007)(10067099003)(6133799003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BiPe0jKO2mWteCk4W0iFzuEiwFdkpXX+bXt+fMjiNpnBxQ3+XvxJdO6vVU67?=
 =?us-ascii?Q?VrEYTD3uKucbYpXhXYna1/aUwsndU5d44flN57LFvSyZcBWIChmmeGs5zuFB?=
 =?us-ascii?Q?P0WeHAkon+ZX3LXYtFiQemRjPdQ2tZ6Jox7AfwOVDZ1cwMu7PkHPMe2Uz2fS?=
 =?us-ascii?Q?WJnYe3FWzSB7Qsqt4E6Ipg5o+nWk5piww9hae5vGpxxC2EpZzLMamtpbVIFe?=
 =?us-ascii?Q?g8P/ttwPMz2cT/kisu/hp8n+SWhGKZ1xuJuIfg1sOUyYgM9xMUd37uXujcQF?=
 =?us-ascii?Q?8hHnX5rI9C9I4Apjky7EzHKvtoSex3Vxv5HJy5qbTk/WapGe70G0KBN3U255?=
 =?us-ascii?Q?+3s/9OdXrKvmnVB3pYlSz/MKkBTFXJSEwB0Xhyf3qePU2rhtinwRhVOHASqk?=
 =?us-ascii?Q?0pBSrBN0AuZGiOQhfP+Sh6uIxb/E45oHC4osNJy8gig21UwWjuWCm2xiQAF+?=
 =?us-ascii?Q?ZPr00yrokS6+uH0isTfjP9XCjw5G/ydBU6E+DL3uOKOqLLz6LtajH792kqPz?=
 =?us-ascii?Q?DWsWATF4DL/LaB0iM6GuI03fSVBjqFnu2V2ATKr+5/TzguOsQGB1DbFW/afr?=
 =?us-ascii?Q?3tjDwiKdnIGIPd9S5pk8DJKiv2TQ2p7t1H1sHrm+7pAmaRBP2h0icRSncnfQ?=
 =?us-ascii?Q?IHGLs0uxULy7eBlb68Hn1PFVOIk9WBW/VVK5zYYV02Yxr8ppuxm8GMw45toL?=
 =?us-ascii?Q?mKRjYktmex24x73IA4xMMeTWvewLUd58ZkynHeN48FeSX2kCbcmf+1aiwOXs?=
 =?us-ascii?Q?IUP6qEBrQYZCmc/m2GaN1u09/3eeKkc4cv5TkrF+0O9CBJUciVQSDMo/d98C?=
 =?us-ascii?Q?4iZmuHJwF/dX478km8ExOiCEQnYf/Qgg0RjGt5uDGs07OrSBNQZ0p7R3wjSH?=
 =?us-ascii?Q?KWbIXP+oRd2+tRKP/L83YY8Lkpb1JOnu5fghGqIWX8npKNb0qT+nxyu6iIZ4?=
 =?us-ascii?Q?JkQ3XJduWsfrtKnFWlterwsXCVhXSPVtkPe1AKRHqAekpFlxVnoli3hKv3K4?=
 =?us-ascii?Q?/Jo21hzvJnqOWtDMK2ugsUH5+dvdn5xEe50KwFoC2TL/EtzniF6FaECYxeaq?=
 =?us-ascii?Q?xkDE7RywWF7v1XtVqHXNUSDYaNWIVmC4Ux0UJ2pzaa+RQ0HfECBLJWZhGDId?=
 =?us-ascii?Q?dJR9c4StCSaNVCDsd18IF9FMyaUx2NxUk7v7L1KOmv4rcywUXQKHdp54etSs?=
 =?us-ascii?Q?+LWz5O8Da/Yu5EjQpY58zM6IpRyxac1arVHcl0+VaQemKiZs23G00njJVBmT?=
 =?us-ascii?Q?hUs9GI8w74LIVw6TsYnenIzF19HxXFOxfc7Gv1mMskQ7wJBwks0nALcmyGfm?=
 =?us-ascii?Q?usEvtMy/h6rAFa+5UMpcMHgUeeGJRFFI8lsDj/WADKnL97hgaWNtfuchCFRe?=
 =?us-ascii?Q?p53igQf24CHGjWNfWLSmXgygPP6twE/XjEj/HQdKtd1qiajCovhI9KlN16St?=
 =?us-ascii?Q?I7X86cA+mzZ/B7r63TvlYF7f/HAr1iq77AlXrGPBQPR7HcfHcOWwRCnok8EA?=
 =?us-ascii?Q?aBc7RM20UFRUA3SE5xKgiDbj/uKYNZxIu+9u1HTKdUzoDHa+bTvkXPvS+wx2?=
 =?us-ascii?Q?z3YPNhjJtU+Z6e/eL4WinTVkf6zp0BNjCdGu5FS7NEqseU07J9EqUzwkAfJk?=
 =?us-ascii?Q?ingKao7AN3Dg7CrXxuNnNwLt+nccpQRwC3FCfCyqGNZ6LCod2XQc5QnP8v81?=
 =?us-ascii?Q?U/khYfqVIjA/jlg5kiX6tHE6oOd6E9fVgT7zqtaMpgjhy16karPGJjRTNODS?=
 =?us-ascii?Q?2sMORqOpbQ=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21a93ab4-6ccc-4cab-30c0-08df3c255b58
X-MS-Exchange-CrossTenant-AuthSource: LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 16:45:25.5453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W7WvBiC2TPqz0sRQoiAFaGH1tVfJ70oNJwVsHejmJq7alZI3UiLyMuccMAQKXGlE+1t+JkrTYx6nYc0sDVjp4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB6202

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

Changes since v13:

 - Excluded __modname_ symbols in tools/objtool/klp-diff.c:is_initcall_sym()
   alongside __initcall__ and __initstub__ so that __COUNTER__ or __LINE__
   shifts in __initstub__kmod_* names under
   CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y and CONFIG_LTO_CLANG=y do not
   cause "objtool klp diff" to reject __modname_<fn> as changed data

 - Link to v13: https://lore.kernel.org/all/20261104154003.43313-1-atomlin@atomlin.com/

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
 tools/objtool/klp-diff.c                      |  3 +-
 10 files changed, 136 insertions(+), 30 deletions(-)

-- 
2.55.0

