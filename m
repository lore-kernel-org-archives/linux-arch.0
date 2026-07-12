Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A1936AB57;
	Sun, 12 Jul 2026 09:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783849031; cv=fail; b=GENg2PXO8b1ahqwYqDHdQFjFicH2R4YSMvZuOYaNq3ZYCOStD4KqmTeSD+m5oIUg0AB+YG1QbSIz071w58Iup2W58oQd6GwdTE8pHgmHQ8LKqXXy6n0+8RLk7KjojBsG+9sN9DjqsK5++ZVSw0ZLWdVUvPwVEASqZlcH26xVWRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783849031; c=relaxed/simple;
	bh=ST/g1pqs63YgTn0spuaBckQRnYs/9KG/1JETUgPcj30=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GHH8K8Q6EZVEty0CV52NBw2MbjnIcxJ/36vM88ImQsJOJ+gei4KHJsEGHOeZH9bVGGoYCa6FkSlKDZvJaRN66IzQwo5mmtMzPeBiabjk2fVNwMKT/7CQx0L1YX7yOIzoCJcj8hZj3eZb7hk0Od9GDMjj+yTcdR9BwYqnjgko2PU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R0VjAwm4; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R0VjAwm4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783849030; x=1815385030;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ST/g1pqs63YgTn0spuaBckQRnYs/9KG/1JETUgPcj30=;
  b=R0VjAwm4lkoVhTQaL+aTYAIAspxbxKyacw/zFYxRg+syMCYFeW8Wd00q
   b0P5yf7Uq5vlAZPtxeJNKHFJest1dgx17LfW4VIqmXxNNlF6R49a39GoL
   AuodGRDoi81tcYLq72GOiNS1nPXgtCS1yvT6DmvSnjJPGjOqTkeUbAjp+
   t66t8MYemt71FHClFEmYJoQRo//YCVrx2O4w5KA5l1z3AfzUUz4ALIuh3
   As6EN440ONnJZWevojJh2f2AGu9M1Bd2kzzzkRnO1KAWUZxabZtEgdtB6
   wbzNzvkVATaGAJ8wTSGmMmedxY9n+MOMCR5MP1UYRoh7IvevyIEHbB4AR
   A==;
X-CSE-ConnectionGUID: OcphvNFfSW+JX68LJBVeLQ==
X-CSE-MsgGUID: MS5fyuzBT0WKd2X3imJ1Bg==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="94840051"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="94840051"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2026 02:37:09 -0700
X-CSE-ConnectionGUID: 7GghGHM9QHeXCSNqN79S3A==
X-CSE-MsgGUID: zL5tx+4FSRG1uQ3bUSCfDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="278536868"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2026 02:37:09 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Sun, 12 Jul 2026 02:37:08 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Sun, 12 Jul 2026 02:37:08 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.63) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Sun, 12 Jul 2026 02:37:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hxNv1rRb9Yc5SEOW4Kg4aG0kRMh2BedEXztbY47j7ZNgpJVuACIWne/v5b7odCthkm3s+A+H+ovhTMZj/AmWXvx5BcG8vhG9SzNu264TcDY/H1b97QV92jkaOqNPbu3F34uG16Xv0gy97iHzdHBwwOqsPji5ntT1l3MZl1TZPsi+atknaz5e2sYxM9W3EjOzErsnAHXlIHRjlHnb7uVkPjcKJfAXxexfArwQ6AIfPNDKQn6GMtDqj8e5YERWBufWFcsXULwbfjPAhyhUDxkPtgItksw0yuCr5wEdIEMQoXGzWtrVWH734TfLdsHSMg5CDIwlss+Y1/46z1rfq9T5Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4BxH9N3vLE6zaXn5LvhgAZYMekUW4i41z3sr7+H7x1s=;
 b=asXDwyQ89gfYBKqWfZgkEwB62Ihjfm67+KLTLJpxlugG/YN3QIg4AnbcT1EEY2VUYOfga78n6t9MdTuTp58Ne2PwXIyR0a7DXxLVk1vVHfZ5C285XZzb8ehVPWDSbJb+ykY0jQlhGbLDMVMexzT8ErLpOui8vId2OR0MRK4Ea8/RRiz6hKiAdP/UQtHE1ee8mC8nez1mFF0vUuY2mE70+Rd3a+ToXWrBpORbSXTCtCEoIXdgaOdyG0ETKCk968PhETrgI/RxD+RwvCLJvoFQ59fFCTdO5o+TI9gCxWyTtsGC0TjFEg5245LTmsWAi3UzdSoFfmmVJoHtc5qgvbBlig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
 by CO1PR11MB4916.namprd11.prod.outlook.com (2603:10b6:303:9c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.23; Sun, 12 Jul
 2026 09:37:01 +0000
Received: from PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707]) by PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707%5]) with mapi id 15.21.0181.019; Sun, 12 Jul 2026
 09:37:01 +0000
Date: Sun, 12 Jul 2026 17:36:54 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
CC: Peter Zijlstra <peterz@infradead.org>, <oe-lkp@lists.linux.dev>,
	<lkp@intel.com>, <linux-arch@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: Re: [peterz-queue:locking/core] [futex] 58141fa298:
 Oops:general_protection_fault,probably_for_non-canonical_address#:#[##]SMP
Message-ID: <alNgNvhIkBfkGo1Y@xsang-OptiPlex-9020>
References: <202607091538.58e3f39-lkp@intel.com>
 <2e3a18e4-8746-4df5-b4b1-2d76b3d16940@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2e3a18e4-8746-4df5-b4b1-2d76b3d16940@amd.com>
X-ClientProxiedBy: TPYP295CA0023.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:a::7)
 To PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5832:EE_|CO1PR11MB4916:EE_
X-MS-Office365-Filtering-Correlation-Id: 00b7c95b-845a-4649-891d-08dedff91fdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|56012099006|11063799006|4143699003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: GL2UIw0763owvCieyM+8100+cmkBxWRjtqzPFqVPJPE1w6cQUFuwgs2Bi8uyMDo9n22SXiZQEqLuBsvfYXn587fZIQsTioDjiwO31NqFmESEFYPIjma8TEf/HPA1BxkspAOBqdohwz1GnjR897D4WUsUYRelc3EajXRF8rS6a9upB3fpvmIp9kvlJMMhN2m26jeElIVs605TPwLbeCRlEp3tHayFzbPB+zbZfVg3VIG0NjpSCe+dthQ5xlPeUWc1Aw+MjWT6uGv91SY+LRYhzPDAN60ckbvPZVpfuqLuzQyZ3IGCkPU7EFqDYu11ClRf6kbL6bWveaRR/AMFQHdPsbNAFmsyOH0N2Xr1Nv9BfHMd6k3KOMTaw4St7+dt7ut5rZeQN6SN3Gm1aW7FSKIU2dBIOvW+zeh60dXBUWwJl9nmDxHCVBkxAyE4NU8eckN8zLITIMrhUmo4MQ2iUNu/aIGjFvDJlF97/1TqSojWd8s/ND2zZcFpytrp2TbSWBWLpKAM0K0To/Z9ZtKBbFs31ITF60BOGiUJ3QzF54yqglqcQAXwRGcJtvj7qJ+UVcwtkjzSzIbXfC0TffkaHifSJ54izE7vdjGFXWwRDS+Kteem8uGcvUCtutyxzXeCbmfi0hgR12y8V69V9uMQsmP17wkcu3/A+F6df6T6XRh6Uh8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5832.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(56012099006)(11063799006)(4143699003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6Ck0Qgbx+8nxHU78Wzq8WYM9stR/monOlFtHKE78MYNUqs9Bm6Gk8/CR6sBk?=
 =?us-ascii?Q?BT60IXvHGl2FV9H/bRo6/kG1O8fSN+HWwoZgJD46aMfuYAKqZ4WlsapUjVbk?=
 =?us-ascii?Q?C2a7hIzjbg2RmQt1w2aEP6ssOks+8IrG0pZ2mmY5rrgBMPuoBGyor81mchDJ?=
 =?us-ascii?Q?cfSI+gODDHMH0YxEwghEcOtlcQXizit2yQISqeGfWjZj5JNIzdvBQR4BrHCt?=
 =?us-ascii?Q?x0sHFsduZfBwNGv9Y7Wme9Q7TB9wdcEZ8ZBW/EaaFl9YtyJa/HkwhdzPgjkC?=
 =?us-ascii?Q?Pral9HEQOerf+/zhh0d2tnyhNzllA97M5hAUYsmzqycBaIvFKglwgYe1D27Y?=
 =?us-ascii?Q?wQQZkn3PREAwfJhhFxM+LNkIO+x3eSxh46vu8Fvdbwk0Ci09yrUJ5as1eoUV?=
 =?us-ascii?Q?hscTLrANX980ZOk1p7gubegiUNrlX8+yQ9s0TKtR+VLhjEio6v0Pt/OBKwOH?=
 =?us-ascii?Q?X/2k/5h/LZ48mt1wlnA/1TLWHrfvaTZk40SwpFnJ7cGzj0z47+6uUhM95+o4?=
 =?us-ascii?Q?775v5QL1qS+/LcqjwKihAI4BSSDRM6tGS/nO90gj2HReExmx+R/L3YgEzozW?=
 =?us-ascii?Q?VePX/QFN7iyTlmPf5bfCR+s/RaCa85tQ6yu4UebwOPaOvYA2IFp8Es5Ge4lE?=
 =?us-ascii?Q?7qsQzjgermdlXiIqCiY+LAdI6z737utHqJsBwtbR39J/ySL2YhYvYfHUCGN5?=
 =?us-ascii?Q?KkRNCpw3lt0KaF3+LfgM4N5kEIvxlSYpVOFgea5WPb3UPpOmxZUVUQ1+Du1m?=
 =?us-ascii?Q?wXiA8R27OKkBzJAF3Xcd6oES01+FBhwFB1zxu1porriuIYaxZy2M+dKZLA0o?=
 =?us-ascii?Q?cTHdye/OvJCCtSAe5vrW+gJ1M0MP1n10iu44YGxAtlSr+hjsaOyIkzznP24u?=
 =?us-ascii?Q?l8xZsuxQmmc3KrJB53C6chtIuBSIA0rmKd26m5nyYx0vD+DJBeNBziNzjWVL?=
 =?us-ascii?Q?EqpY5M4g1J1U3/1JeGwaQFMG1LgKO8kbIMkRTwmTlV+KoWjkmDBKfXmYqbRx?=
 =?us-ascii?Q?KmqkW+seSNgEylJp9UPMWVuQqP91aajGg8sPAlhlWi214l3DkGIkCO9fYwq9?=
 =?us-ascii?Q?KkU5BXxuL5WA+Hs4S2/nJ1B4LopMYMULm0KPmcB7IRCZBNDf2yum6REVb+Zl?=
 =?us-ascii?Q?a12U5LvM0SPr/D8ZygUyaEJMLhp6rCdQKdL/oUxaHGSn6ewwbGsCuLnUv8J5?=
 =?us-ascii?Q?GhB1ReB5hQUS2ZlUepqF8lYcm4qzh5eebg8eNqWZrsbGPDacFvw3PLbJAi3B?=
 =?us-ascii?Q?L3pLrN9ltBmTqFI5qFibtPG3PnH830xokRfkjxpItGd6hVjGitTbCqV0qtLc?=
 =?us-ascii?Q?xuW0MtY5uKGqjhInmpcxsw8WGW1bFVZNMmfqYj4iw74eUViyxSBtGZEmrDTs?=
 =?us-ascii?Q?1zkCjLyLLfRKxryuMpnfpPNsGkaOMEVYXDOYclFsKKaOJb+mew2wcSu4B12Y?=
 =?us-ascii?Q?XNQJsRaEdUoX3Rg26eNhEzn5StXw2Uk7ThqeLzc7IkHI5NIqBLbhPYq8c6Om?=
 =?us-ascii?Q?/OuH9sPF7OqNs98Myk2MWDbNkXPLhEet49cEQmk0atjhuCAV5hnkgSSz1/4q?=
 =?us-ascii?Q?dZ3ym2iKVtffe2TOK7Xoawa2lSTHrTdCvYGXBN6Fd9ohJaY4UZPLkLalA2We?=
 =?us-ascii?Q?zscUNqYoYuggGOJ/bDXd4xbGrvU83+mzQ+gBFPJL3rPTgkSbwqCAkDz2Nj5N?=
 =?us-ascii?Q?1TqmxSEfGk3RG2IdUP6pSFPFoi5JLT1GPzo600BXcYbl7MF1IqyjKYg0tmj0?=
 =?us-ascii?Q?a08bwCvWNQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: rlVlUuWlohE2aVt86iAbjXW7cE4p0fD3i2B+djxhHSuRb1tq1KtCaZ0ea3+dML5/vphYZSKo/GpKc9Wj6u61+iIQ6sWu4HoePNDaS3MMNGVqJUq3gVsKkj4ja9M2GYvxe1madIDzsPYJXrHYfUQtON9ORxvhf4uivxLeAO/tBi0U2u4iFa651qLU3+qfScViZBB+tZxCOAoFmoGecf3JXJX83eKFUJvWKNEy/UoxAJ4VaIOeobiAbiQiQSA333bSI75YsuwJVr8bfXmvt9VX+Ku1ArmEi5jldjraMQ7sabvJCE53qoJz47FWoCOsWH6V2TLkO+VCUwHUHITToYaR4g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 00b7c95b-845a-4649-891d-08dedff91fdf
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5832.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2026 09:37:00.9981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l0gpmTtXJTNzUoAXMCjrqLuYpxVUo8pJ/bVN0pk/ECqG8iotGCm+X9RJ6V+6HixLtc94rgmhAPuxdqoNZFK10g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4916
X-OriginatorOrg: intel.com

hi, Prateek,

On Fri, Jul 10, 2026 at 01:36:05PM +0530, K Prateek Nayak wrote:
> Hello Oliver,
> 
> On 7/9/2026 1:47 PM, kernel test robot wrote:
> > [    1.259631][    T1] Running RCU Tasks Trace wait API self tests
> > [    1.261867][    T1] posixtimers hash table entries: 1024 (order: 5, 81920 bytes, linear)
> > [    1.264376][    T1] Oops: general protection fault, probably for non-canonical address 0x123456789abcdef: 0000 [#1] SMP
> 
> Thank you for the report! This is an unpatched address for the runtime
> constant which suggests we are using the address before it is patched.
> Following seems to solve it for me on your config:
> 
>   (Prepared on top of queue:locking/core)
> 
> diff --git a/kernel/futex/core.c b/kernel/futex/core.c
> index c6af6edf5d7ae..0864c6e8cde78 100644
> --- a/kernel/futex/core.c
> +++ b/kernel/futex/core.c
> @@ -2027,6 +2027,8 @@ static int __init futex_init(void)
>  	runtime_const_init(mask,  __futex_mask);
>  	runtime_const_init(ptr,   __futex_queues);
>  
> +	barrier();
> +
>  	BUG_ON(!futex_queues());
>  
>  	for_each_node(n) {
> ---
> 
> Could you please check if this is the same issue you are hitting too?

I applied above patch upon 58141fa298 directly then build kernel with same
config and run same tests, confirmed the issue gone.

Tested-by: kernel test robot <oliver.sang@intel.com>

> 
> My default config seems to have been much less aggressive at
> optimization to have exposed this problem.
> 
> -- 
> Thanks and Regards,
> Prateek
> 
