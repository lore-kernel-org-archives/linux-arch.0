Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.96.74
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793742151;
	b=d4jRa/SkJh9ApZ5ZoXlhzSQTpMV/t2SKcnjyyt01n6fn+Ky7cnK1+sf54v28fJfYYmsf
	 +epTO/BuJpUPOZenUp8iGe93L1mRx+yIkZcpsvJ2J/fn948PDW9Sc6ziHMEoCh5n/UlEW
	 c2lWPHtOz/zizuCvJtKG81MBCcgKh3w74Gjix22XEUJlv8IT/oKvdgiHesFtkiOIhezFA
	 q7KIJj8RB6ZIQ45aFfKRctvVa74cMBXXPkF1Qrz7iSJQvHBuTzDbXgXEamzsVfbaR/OBS
	 ai/64T2RmsL9za72ungKCakz8bBOk8AzZvmWbuG9XFH0n/DEbJhZaEurWoifB4EsBzg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793742151;
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
	bh=xyG2HI4NcpK/DSvXjulwOuySX9lUQEEcGSwgmpPG/G0=;
	b=FN4x4BaViyRJQSIs4JJ1RuyRJWZDJD3E7glq08ImhMMtTbBdksTHcFqBhoUVb0B4wfeq
	 ZfQDbXiB+a4wcbtTPeiZHI99F/MoFvhixBr4Ep8Z7MNRdXtyBTRFmmiJ2NmG9BpbSaX9S
	 pp8RwpCj0BDLR3pizSZPW2yP4Jym0s3qTrO1Jg9HYQilsvUAhnnabHMegWFfT8Oi3NZCh
	 Y5Uk8qiKTfADigklB5YGjCM8xpzHnKut8fhwelRrMwRcq4PwJQiWkWRldjo8HcFdp3F5F
	 X1aBVuZV3sVE29RTetlJzOWlf7W7u+wc30KLxVRsDON8hxHH2SHfH+bHgjlWR/ml85A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=atomlin.com;
	spf=pass smtp.mailfrom=atomlin.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.96.74
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022074.outbound.protection.outlook.com [52.101.96.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D931B606A31B;
	Tue,  3 Nov 2026 21:42:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D931B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NXcW7j0l2HZeqBjT/QJE/oIQCnuBdju53p0KIHI8xsgOHFwGHyj/t7AdUkqnDdrETT9/e9SB0OTrgd1dgkiLEz0N6T/Kk0opM4vlZp3PphYudkxLG9Yq5U2mMqP/tVM++Fn78Bz7vn2mayg4Gu+dCO883UmhWY3pl2CAeN+7sUBONSkralbF8pSHXRNNTixV4qA4z70P4Hmr1eijzw0yNHCN+if+t3/FStgIqRDicskA1DRBgzu8r6Yfqn1w5yS6HOts2TBdrjK7OMXrJMcQzaKDYnv1q+ZNEfLruOtNRcMhLJ/9tyVIWc+Bz5WmCVzmONFDucUblS14LEK8Y4OpGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=xyG2HI4NcpK/DSvXjulwOuySX9lUQEEcGSwgmpPG/G0=;
 b=aASi64D0aOIxtN1UWtn92Hq6E6vsxGUff3UbmR+LW4qhghaMWHdn3D6S+sQ993vL9FGcVf1WPIFcLX1N1CQljWCjKF3W8M6khEbrGuaDC9+IkELijBaiM7nO6MR8BClJKtmgAZTSoiz76PBm1aO7Q/O1XvIv1qzUNiIx6VaevrVoT915b1ULdNbB1RvBXZLZxqWU9ToLCRdeHbiiGhd5Y7ig9PC9vV8AJ93O0/zyv9zHz8GCQv3VEFOXTAwviK+tShwkcW1zGkEkHzJYAVEGypHDF94zQJSlcv3dDYZKSuRT/nS5c6JseL6jUJryOigsUar/Kx5HKTwA9IuNK9Rgyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:163::8)
 by LO7P123MB015864.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:604::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 21:42:27 +0000
Received: from LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f71f:a9f:c4de:687a]) by LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f71f:a9f:c4de:687a%5]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 21:42:27 +0000
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
Subject: [PATCH v12 0/3] module: Extend module_blacklist parameter to built-in modules
Date: Tue,  3 Nov 2026 16:42:20 -0500
Message-ID: <20261103214223.32598-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1P222CA0009.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::14) To LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: LO2P123MB4190:EE_|LO7P123MB015864:EE_
X-MS-Office365-Filtering-Correlation-Id: f0b9fc8f-2b5e-42e4-2e80-08df39f35a75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|5023799004|261022113327099003|56012099006|261009221227099003|261021123027099003|261009223027099003|261022105027099003|261102123227099003|261021121427099003|261022115727099003|261021135927099003|261022075727099003|261028144727099003|261102124527099003|261026121527099003|261026140227099003|10067099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	pKS95ZnvG3tWfpCEYkSMtW2FzCPJmCS85sHZDiDlHJ2IutWPjqtT67/BVvplNMeVPo+TwGUY/+GrVnWnj18w/JfYMuVasHXH9HC5ls3v9Jq/Xe2uDo+mib0hOYTXw26z1b9zA0poUP5ARCiBisYl9V7w+OPluxqU0VLdk5XgbUAMkyoiHTQEai6bssDpIm8kCNTf63nEPxPWjs+HpoTX6uyiThoOyba+xLlyeUSvEYTsdmbUqBkVlVurovHwzA6ONf4OmJYu8F4ce2JCWrbojSXuUFet9Tf0Dedcbs7ipUpvqEV8ZIib+JUINy5hMPFJbNDs39x7of2bM52LRcMj5+6LHKimYgTl+lNzrv0tsPIR5u6oAJdBsT8de24tDwIdxUzigzy5KWlFp/dtxz14B35bq0FZ2G7Ea1UgaSAj1o1SvemKNGUuAUgAO7QmrjMIO6hWbKwIbHp5wY4JXkvMFH70UZyGgadnl4BBXZxa2pSnHw71+o8agEcbd6md7+YyoEIUUUaDRjMRmYFJX/RPgrpkE0opwni0knFxExPQDqGGI+oScbnChujBfbzPXh06y86aTk5lyyK+0p6asv4rtQKdtG6ADQNJANCsJN7JPlfaiXq4Yxn9OuWZbX49qkHN
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(5023799004)(261022113327099003)(56012099006)(261009221227099003)(261021123027099003)(261009223027099003)(261022105027099003)(261102123227099003)(261021121427099003)(261022115727099003)(261021135927099003)(261022075727099003)(261028144727099003)(261102124527099003)(261026121527099003)(261026140227099003)(10067099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BE3B85tSXeU9aGQnk1DglWlYUPt2HB2K5futhl4YtwEf4zls7WWCxQE9Uwg/?=
 =?us-ascii?Q?5EB+HJV/KBY3Qoc6840hA6DBGcNQX3zeQ+y2Yi+hMSqwYfwc5qtdgDEqQZYE?=
 =?us-ascii?Q?YQGpOvbV5wCzWl7OqaE2dymEqT+RV3fwT3/6rjfVCMwrUCBpfLKbIXF5pf7L?=
 =?us-ascii?Q?tZ3UK+eVVMv6ivpO2r1UvCaSCfCwWpn6kgqv2sO2mkVdUXyU2LtPa7Q0ZBDv?=
 =?us-ascii?Q?oz58xceEMjykPHpVLbsUgjvZN4LWFVJ4pfaoVqAogFms/2qNC22GfefEtXkp?=
 =?us-ascii?Q?RV+GA6GnR/mUjDfFN+dwXDAt0h/lpx/NFnXWdM/TvfXsW8FoOT8UhGOA9ivE?=
 =?us-ascii?Q?neIAYNMiUGAK9R9rpMe2XMF6VjJBIioJuwn0hiwqWg2N+CV2MmbdvNzAztEi?=
 =?us-ascii?Q?0fjRAaLgJzUMR/pxhYw5KDkhMtCsD4SDKXyLK+Z5BshFci42Boo54wtu+ZkC?=
 =?us-ascii?Q?CAx8iadBIpacVhZZgGrdwOxqe7JYvOebyxSIqHKFR/9prsUiheRKlWXbq4/+?=
 =?us-ascii?Q?qCIWgo+XQBrMtdPes9aSvrsrm/nXWCKiUbZISITtBB/7tWlneM6i6XmOr1/f?=
 =?us-ascii?Q?Ete13hNbFE5SjIKLVHUcHbpY0vSiAS7KZRjrU/MZlOZYHBaEpwasnZ8nc+sw?=
 =?us-ascii?Q?aYVelPdZTkawBrb1gAsK1QrsgVZ3lBFmIxKKlcKutDok2Q2/LBW3abMlKN6k?=
 =?us-ascii?Q?K6jF47hkz4TcK2iQ8QQDYyTpsf5Ou38LkcOdwB/gAN9vexjgNdY8CJaikp1O?=
 =?us-ascii?Q?mHBraw5YgI66KlffC6UxftVtywPLpM03unlt3449NHmgsgg/HA8R2VjmHA1U?=
 =?us-ascii?Q?lpk+deBfZRc8PpjocErTqywRoeacrg2J/5q/CRyKBSNzfNu0o+2I9ujYlTMn?=
 =?us-ascii?Q?huwevYdDXqUCOY0BxNAn4ObjC4l57GxZXfuvUW38MeuqA5DA9sIbgZZjMSVH?=
 =?us-ascii?Q?IPJcJCHmxT7D47bpZ+CzluReUeOBMyVxtIp+XQvcfR7Q3TtGV+T+xvtH6C6j?=
 =?us-ascii?Q?a4nczfV4mzjKNAMzGfVW7bzM51OBEiSj+zmb9Le0oRHxvG3xa7rtejBtAuya?=
 =?us-ascii?Q?wdkJJnZx0Of7/qEbNBzs+kAkso9FD0F6/1bnQmlA37Snao2NQwUcKF50ja+x?=
 =?us-ascii?Q?c2cKO21C0DhZqRD9YazbMwJm3NMTkpLPuepYMis+mTy6PLxoHxh1nFmZf5uA?=
 =?us-ascii?Q?tfNADdjjMU98jSvw3T8GYvuXz2NTcLN0U1NnKTbjl40iyRMmQK1JXfhPPBQh?=
 =?us-ascii?Q?IhnE6i+oTIDbcKLPr0bYcP9INgFBP8x5ocyfoPSmX+wxGa81iQIQ5Lm8JbEy?=
 =?us-ascii?Q?NFJAAM4drA6r9RxswhjscVANLFgSF5qdzbZhsMmHLOeSkzVZTN5xJUN0iGbp?=
 =?us-ascii?Q?ABXjZj4ce3kTw9KYHJb/dn2wMk4vqewd+TES5FpAnrZzVwNyphzoubzXaApH?=
 =?us-ascii?Q?0yP5sZdhBg9U7HtadDibJrt1lt9DbKwaOGNXudhcyT6uMeEPMHFE/g2dMeLv?=
 =?us-ascii?Q?jfhmoFCHDrw9dLR9vSAJK9cuqMHmC/nmsuEk6+wYyHoTWgZBc03q58nYbA+z?=
 =?us-ascii?Q?s3GBjfvXR6GgJt91DO1bc03rU3yL49JRTgc2viKv9vL/Y9wg62LDZ6DGBN4p?=
 =?us-ascii?Q?IngSrL1D40yRKGXo59QWnQLHIKp2WADbrbEGcHtABqySdJV3XvT1OEthd57+?=
 =?us-ascii?Q?8AEQmY3lq/OQlJ3qvDVVdEIK3HmHg4gaoBGL5j14bHTWg+9rUm02V8jQ2nNq?=
 =?us-ascii?Q?8CgBTQK3Mw=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0b9fc8f-2b5e-42e4-2e80-08df39f35a75
X-MS-Exchange-CrossTenant-AuthSource: LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 21:42:27.0826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CJyFpjG61uqBd/Js2YB6tMhrgJH8ZMUBRGGlyjTK3ny/zfYZlEG79hZ78b0/y+gFzfnsizY+QRtxAMEbMAh0yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO7P123MB015864

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

 .../admin-guide/kernel-parameters.txt         |  6 +-
 include/asm-generic/vmlinux.lds.h             |  4 +-
 include/linux/init.h                          | 25 ++++++++-
 include/linux/module.h                        |  4 +-
 init/main.c                                   | 55 ++++++++++++++++++-
 kernel/module/main.c                          | 24 +-------
 rust/bindings/bindings_helper.h               |  1 +
 rust/kernel/module.rs                         | 18 ++++++
 rust/macros/module.rs                         | 23 ++++++++
 9 files changed, 132 insertions(+), 28 deletions(-)

-- 
2.55.0

