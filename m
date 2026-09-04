Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021119.outbound.protection.outlook.com [52.101.95.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41714CB8BE;
	Fri,  4 Sep 2026 14:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788533992; cv=fail; b=Uxp4jacGNzpvc2cHmggd2xmAZ+YOPTJfRl9X4HKseG67rc4tHqjfhlZPXJqGPqlspGJUAkLkunHAImGzJLOPgTjXfQ7uhseoOxys6dqraFQ4h8MHbEUM9ZocH47mKwCjo4EZz0T2E90wMU5mTifaiUa+8y0Z9uC5/f0d2SAZIFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788533992; c=relaxed/simple;
	bh=LQ32kJh/jtonzqAuDO4mpStgy0HG50EUgHLOnBUnwLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q23II/0tTJihEtPZyocEp23NU3TXbuaQ6vkTdXt0q+qwWQYrjuoOrU/3VoJfdHDaIkzJwyNR8sD+J/e1koak0xoK2hN97gzp36A2cXujHxzoMuNwoJ1B3PJ1bHCvUyC0Y5YDPw8+yq2Bxc0mMgyVjDHXXY0rAm+XwiSF6d4IYoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E4bxAUXrdFfef3f02laTF2UVH+fIyxFvmuw/yUeB9rW4P9KO+7/BVJBPoVSAb49lW8cHR0S8NjOKFUSiCf7+7MUTZiunTabXmdWM32ueBFTpt6OgoZvhgxxJqGJaCocDzSmnJM3AXiWn34GKk+CIBm3Mow7RrBckC0e1rzauxCY8xF7EyGCrjd60yjDxIVPPVQsNafq3zhv1eAyIUcb7gunWHAulOGPn9qFYwr9z9xa7WvWXBJINa+MeInn7nGRxDOQ4gznHlyn0y6C5Wa06LO+K6nVTfjV0nFA5m6iP1xT9Wj7mw2q5YviPvA/qLlKmU/tX7bsAwxEquYM1paj30A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=miZfiHemO8Mc3gM4CMJw0JTJc6uXHYg1lLGpx67IMXw=;
 b=oBefJiBkRBvUrwEe6Ye2hfxDwDtADSkuzSPAHUquYWHFZj/nsV64nBC+KqZc5/JFuQ1hy9dGjhLjfaLowiSD+mVnCMb3WTDKpvHE+T4JIh2/U/XtJm/s51uy4jHTMgLDLtghdX1YNMCm8lK2UtXrldfvU2B54Yvl9e7t9kdt2xu5VykSUJsQvwrOUPAwzsbEbR0Pp0Js6CoD4a/F2ossrJ2AO8ftlSlVvEH+3R7AuW704To7syYi8tkTGzOLf+c533WQSbbpJ1vjVArYIezAsK+wfC64Dy7QtwnNfQ+lr+dX9MJx2KNkapUibFlYFK0zC6fs3WR4zNnbh83bJGIumg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO9P123MB7690.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:3eb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 14:59:46 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 14:59:42 +0000
Date: Fri, 4 Sep 2026 10:59:38 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: arnd@arndb.de, mcgrof@kernel.org, petr.pavlu@suse.com, 
	da.gomez@kernel.org, samitolvanen@google.com, peterz@infradead.org, ojeda@kernel.org, 
	mhiramat@kernel.org, boqun@kernel.org, neelx@suse.com, da.anzani@gmail.com, 
	sean@ashe.io, chjohnst@mail.com, steve@abita.co, mproche@mail.com, 
	nick.lane@mail.com, rishil1999@outlook.com, linux-arch@vger.kernel.org, 
	linux-modules@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 0/2] module: Extend module_blacklist parameter to
 built-in modules
Message-ID: <ultg4rym4phqwqrbuz3hqtlse2lgafxebx3un7s3tdht7rz5xy@3ckauomiwqsy>
References: <20260903185557.183224-1-atomlin@atomlin.com>
 <20260903132924.7a4d1b84791d30c706b394a1@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260903132924.7a4d1b84791d30c706b394a1@linux-foundation.org>
X-ClientProxiedBy: BN9PR03CA0505.namprd03.prod.outlook.com
 (2603:10b6:408:130::30) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO9P123MB7690:EE_
X-MS-Office365-Filtering-Correlation-Id: f3fcca10-b044-4d8b-fa30-08df0a95269c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|5023799004|6133799003|10067099003|4143699003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	nlF1odgiiHtxKkUMBsRUrk/7fRPotvdyFBIrcHT6pnz9ZNYVhkknnqSMi+z5QvJ8yzkcWTyTECSk2mpT5/3Sclx2ii8yOo1RvRauTen0IspnqS2DYg21HviuBFh/aZg7lCK4dWpJP8LGNcZxrpYx8n6wKp0qsOtW8C1A+xU1eu7HP139UaDoE938HyEYfoeCFPCNfMTdzPCK4SoVqppazms8A6zfRaTmRa2omhAvsxHW8lq9GgRzyk32fsh4qvkcL59pYGQwaZdySDWQeIj+ZfEMaLC4//cIOywpOkBo4dI3pmbXmFnO3KwE57Q3TTb/2kX8kp5xpuvjAqDjzqxrkhY7gFVT4W4eyeKIvdB24CxVNuKg079kN7rTpfgoYdtBI4CN4khq36RU6vFIULGXFGSKtEqkEo5HBPFrmdXbO/h3OEyabbuvV0z1nH+voGa5j18soC6fCKR3C1gfeH7L14yuIwjdJPxHXUOQj2NMO8AEPU1az2x4RzXUcFZjS8TUEPh17KCAWzbxB5oN//s/xfPjPS0SHYC8nxHo5uGhnN7A5xyZoor0TIgL7fc9zcRL9EHudVpPZ1Y0HnhSjFJbnl71BvzqBP49rhkN7ZdwS9nykZUs8QeuWC5/ZCrVYcNzYVKXC2PsW5nB4PEU0pVoBDiHW3UHpG+CbBP2eDAHfYk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(5023799004)(6133799003)(10067099003)(4143699003)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TVJmM0pqcmZkZ0F2cjBtNDNGTTlmYWpXNVROaUZ4QUJacXdWanNsaSsyNEdh?=
 =?utf-8?B?ZTk4N1dSdnpGeWRZazl6TGZ2ek5vQkZHVEhScXpaQUU4VStlQ3N6aFBQNlI0?=
 =?utf-8?B?SEh5VEpwTjM0d05YNjFMdms2aWhwUWxmamZOQjJpcDcweE8rTEdCT3V5VUR6?=
 =?utf-8?B?YkNvVDZDMWMzQmNwcmRkZnBja2gwTzJtS0tVTGtzRUxPZ0U3dHJNVVVLMk14?=
 =?utf-8?B?bXFBNW5UOFB5MUQvR3haajhNcE01THRLTWM4cE1XWDl3RlRtUGdGUUt3N0ZW?=
 =?utf-8?B?ZCtHMFdycU5iMHZ4NFNOTVhPRXIyTmtRcW4yLy9CeTU2OGQzZDgzTXpKcVNa?=
 =?utf-8?B?SlBEYmgxcVZPUDhiUTJUNFZzRW43SnZGWmgra1BucmNZTDJoVnl5KzM4Mnls?=
 =?utf-8?B?NDRlajJNRmc3TnVmckVreXp2Q2t6YU16MlVqUTQvQnpmd0hic1pxTjZDY1E3?=
 =?utf-8?B?cmJWUlE3eXpRVHZXM0hqVEJQTlRVaVlKRXdWVkhmT2o5WnBidkxoZkV3Q3F6?=
 =?utf-8?B?NVFxZ2c0YjQ4VFg0ZG1UajYvejVuNWE1MUo1TW9kaVgzWkFmZHVISmRZbXE0?=
 =?utf-8?B?NUtsRGlycjZaOW1wc01VOWRibHdlOUVPTDdaS00wTDByejFzTTBlUHgwUmVX?=
 =?utf-8?B?RzB3ZDJSeEpZQmZFeDZZL1ZPUjBzZ2pNSnZZVzJFSW5pZWpOeW95Z21VUGZL?=
 =?utf-8?B?STBjVmhNOWZjN0VGaTdzUHdUY1FvcnFZaGFDa3N2TmcyNFpPaWYzWW96N2h0?=
 =?utf-8?B?dVcvNHRVY2VMTWJkVnkzU0lJM2ZJWmdBTGlmcDZLanpNZEpuWlVPRWdxY28x?=
 =?utf-8?B?MTNUeE1jMlhwTEhGRnFWRHJZcjlKRFREa09SQlR1UHdKTldod0NNVmhyemVX?=
 =?utf-8?B?MHVZNUpVZ2xMSTlsSmkwclVJSVVTdC9uS3p0MnFsQVY1LzU4UmZRbTJIVXVH?=
 =?utf-8?B?SjlWSU5TVDRsSmIwdmFEOXlSRGROT2Z5NW5GWjlQeHArVVQwaXZYdUgzZ0hD?=
 =?utf-8?B?dlVRcFZXUGVIdWlVK0dhNGcxb0Q0aFpTR2ZkV1hyaUh2cmxSYS9ud1ZDcm9L?=
 =?utf-8?B?Z1pObmVXL2c0SiswV3VhYURVRWU0K29OQWpoMktuZ29BYm1zNFVWR0FMNWho?=
 =?utf-8?B?ZkpnNFBVWEl5UGhCNEJKS0kxd25FV3VsUkdvRjdMTTVDTG9Gb29xS2JBRlZL?=
 =?utf-8?B?Z1pJMUhTUENseEpZOW03aHZwUFFhd2VrQXdaeitnNEVDaGJ2SUZzY0RYV2xW?=
 =?utf-8?B?dnhodG5nU3Q0R05LdTJ1V2lqNW5xMWRFaTJhSjRwMzFQcUxvY3NrMHVqYVYx?=
 =?utf-8?B?R3d5bjRyYkg4bSsvZVBQZDNIbHQ2bldYcHBnMlNoYXVQS0ZXV2oveW12OUEx?=
 =?utf-8?B?QktNM2c4Tjk2b0JyS1dBQnEyNzhLWjJ5c2xELzVzaFVjbU9XenlEczFsb2Iv?=
 =?utf-8?B?UFlWN2dtUmNPZDZyQUYyNGx3cGxYRW9wMURnbVRHLzZjeXgxWENjcWc3S2s1?=
 =?utf-8?B?cGVqTzNkQnJPY3FVbDFmOGdwQ1h2NTg2VmhRbHVSL1NIeGhyNkpDQTBIR1BR?=
 =?utf-8?B?NDE2TXRzYkRNRElsZEdWcHRIS3N1dmo2dWRnQk8wblZyY1pQczUxVTVOeXBF?=
 =?utf-8?B?enhpcXpBWXJPbkFaNGgzS3pwNE1VMXBTS3lReGErWlEzQy91c0hDVFV5VDlw?=
 =?utf-8?B?dExWSEQ5MDJvL2xnY05OZ1p2L0g4Y1VjRy9Cdi9RNjVJclJNQ0lzV1JVNFhk?=
 =?utf-8?B?VVFzSEdCcHFPWEJtQUxWMXcvakNUeWI4c002dTBSZzlaMmxTeDc4czdOUS9y?=
 =?utf-8?B?emw5S0U1ZXd2bHd3dFIrSVE4bTViZEVEQ05CRjlxWkRZZ0VrMTgzR2ovNjUx?=
 =?utf-8?B?UGRJNVJHL1YxNDBIcXM5bFBRR2x2L3U3cmZBQlc0NXJUUGlkQzJ3M3daU3Qr?=
 =?utf-8?B?Uit1Rll2SEoyNDZHWXRkeG45RFlSS0FhRTVFWW05RWxBcFB1ZmE2UUgxbGY5?=
 =?utf-8?B?UGdsV00vL2thNHpWSmw4TVhvd3RoazAzQnFMam1hcjhHNXFLaTcwUDVWVU13?=
 =?utf-8?B?QnVLb3NOeVB4QkY3dUdadWJGeC8ycXM0OW5nblk3M2tYOHZtN1B5U0pmNCto?=
 =?utf-8?B?Y3psM3FQNlg3cThaZkY3c2ZJTHhPam1RNHNjMS9aRXRHN0NYMGhsZkxaam9y?=
 =?utf-8?B?S29jbXc3NERZeExHTWRYMU10ajQwTUR2SnB0QlR0V01SQjFVeVpXTkNEQlFy?=
 =?utf-8?B?WGRDVHJUYTRKZVRyTHVadW5qcjZJUnFrQS9pQnhZMHUyT2ZhazFhODhiQkgy?=
 =?utf-8?B?dkZFVkxTb1l4aS9kNXd2UmZqWEw0dHpSOEVNS0R3VDBhTGVNSkZPdz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3fcca10-b044-4d8b-fa30-08df0a95269c
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 14:59:42.6935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rs3nYcNb9fhsDYVQkL6UHpI5OdTdeYmWw4XjhkDyhcT363/qD9WPZ/WqbUDaBYRyr3aBFS0LrunPR7XFqnna/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO9P123MB7690

On Thu, Sep 03, 2026 at 01:29:24PM -0700, Andrew Morton wrote:
> On Thu,  3 Sep 2026 14:55:55 -0400 Aaron Tomlin <atomlin@atomlin.com> wrote:
> 
> > Currently, the "module_blacklist=" command-line parameter only applies to
> > loadable modules. If a module is built-in, the parameter is silently
> > ignored. This patch series extends the blacklisting functionality to
> > built-in modules by intercepting their initialisation routines during early
> > boot.
> 
> Why?  What are the use-cases and what is the value of this change
> to our users?
> 
> Important, so please don't skimp on the details.

Hi Andrew,

Thanks for asking.

Here is the rationale, concrete use cases, and the value this hopefully
brings to users and administrators.

1.  The Core Problem and User Experience Gap
============================================

Today, module_blacklist= works strictly on loadable modules. When a user or
system administrator encounters a driver bug, hang during device probe, or
hardware fault during boot, the natural and widely documented remedy is to
pass module_blacklist=[driver] via the bootloader (GRUB, systemd-boot,
etc.).

However, if that driver is built into the kernel, the parameter is silently
ignored. The kernel proceeds to run the driver's initialisation routine
anyway, leading to the same panic, hang, or hardware misbehaviour.

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
       On systems with buggy firmware or conflicting device IDs where two drivers
       attempt to bind to the same hardware, users can prevent the conflicting
       built-in driver from initializing without patching and recompiling the
       entire kernel image.

4. Implementation and Overhead Considerations
=============================================

We took great care to ensure this change introduces virtually zero runtime
overhead:

    Scoped to module_init():
   
        - Only built-in drivers that explicitly use module_init() are
          tracked. Core kernel subsystems using core_initcall(),
          subsys_initcall(), etc. are unaffected.

    Zero Resident Memory:
   
        - The metadata table (.initcall.modnames) and the module name
          strings (.init.rodata) are placed entirely in init sections and
          are completely freed from memory after boot via free_initmem().

    Fast Path:
   
        - During boot, if neither module_blacklist= nor module_denylist=
          was supplied on the kernel command line, the lookup is bypassed
          entirely.


In summary, this patch brings parity between modular and built-in drivers,
removes a pain point in boot-time disaster recovery, and provides users
with a predictable, consistent interface.

Thanks,
--
Aaron Tomlin
