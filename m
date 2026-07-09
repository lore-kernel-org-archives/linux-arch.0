Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3004A30DECB;
	Thu,  9 Jul 2026 08:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783585069; cv=fail; b=hu7CZkX0a1l21hEC1S56nlIW4Kc2ScTm59r8kQRTD5PEbn3a/AteEEbR19AsT+TBi7d3HVfVJC2ZZxfNGu5ESbxd4jpGtlBtzS+wE59EK8oxC6lsd1k0YzovpD/f/coO+smegdDxpTQUCEqUy+sQOqk4AOr9SXzJ5xgGjWP4JCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783585069; c=relaxed/simple;
	bh=TLuryXYO+9iCs1R5pBO+1ldl54N1su0DsFHlN9zPIzw=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=GGmrb4T3rKPK209RYiiqGFcC9HTsPqRtdjPZjr7dsTzKDgMZKzWkKLw7FQQDIFwMHFn4Q7w3J8tnQvMKmaCUc51VRmG84s5SYhcaUVY43nG+1io8aLZtGQl7xf7HHIpXgn/eiRHdX9MOQjlD7PirsCB1FxhvQ1aw0Kc4QA4Pz3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xm1j89sB; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xm1j89sB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783585067; x=1815121067;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=TLuryXYO+9iCs1R5pBO+1ldl54N1su0DsFHlN9zPIzw=;
  b=Xm1j89sBX5ofZK7BBqAqKfKLGmCRR6dqrnwL45BOXJp7QfkLA78w5hmt
   ljsQj7zYoqL7guAP4uhfiEANIaBi+jx7dj2LjrEGiLpQrfxSMpwqaSunm
   aOTNS27j4t/iBI1dMYFNVJ3h2PAWKlC8n8Ba72XKNQjObn83tlKtd6zi9
   qTpv0EdOc8ef6R/0pKIEqpFpyKoLlZ+MhG3L8lJoh87NeG/Eu+ipJVXmX
   l01ZdOn3csEHqrPUoAErnUN/c/5UMEDQpoP1T2Ylt0aVgkWTJYxi897si
   /NObmprpD+1t54rnX1ark6sMU3a2v344bN+MyWr4q07hSapoowDKt5wDy
   Q==;
X-CSE-ConnectionGUID: hLeF2Y5ORl2DzGGhCf3aWg==
X-CSE-MsgGUID: +RcYAcq/SzCYWdWutWmFxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="83371394"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="83371394"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 01:17:46 -0700
X-CSE-ConnectionGUID: PY+qCKFPRX+JWRJtDbt7mg==
X-CSE-MsgGUID: UUzAbMBISr2FVaKf+862Jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="250535126"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 01:17:46 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 9 Jul 2026 01:17:45 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 9 Jul 2026 01:17:45 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.58) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 9 Jul 2026 01:17:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HXlUNHYgMvZ+ecMs/Obf04IT91+lppSSSFnLArHWeso1AiQdFERSvsImv1kdvumw7jHhDxgBEJ4UTShUJzx5rx5tMrvbzm3YlsmfGeCPWXhQVg4mXB+ANEyFViLGO191wH3Ft82d2cIKQpzfPcFBctlEbI8f2etbosd2JIKiiEET02SN0crvvLd9bYSfwPgk46iKdco22LV+1AnGynNGoF8zv97eal6+wOTjfLtuocva8YzMzXdMt/vJrarFSzIitrCgtbbWoooCMb7X+FHENsYTHUBW4JWfwigB3a92SE5yy/bd6s4nFTtxfih2BRTA2ktYExy4L5Q2HzhAccrAaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/jkfscbz8Idi1LpoPx5RuCEUF/jT20ojfTBSozJuaWo=;
 b=PkSdRTTpyiwev4uUhXEwAnCMrCzRIf5FL4M27/Se1/5IIRC/6rgsDJHfGSKw7c6WVEbOfzuIBJXUiCqgiVuErKyKLsei+JtUZhfmtRCMqOqNWrKgBdsPifW+YzTFi9N8mkFuaun8ckrq8cSjmm4jeWjs7GPGe43rkxsX967Jtvww35P6jx1Bs/RtKyuH8HLbaj9PrELtyX9yRjVLXHAPJpdL3GKYqcOGw1HSyuJDAi/BwINRggBjHq6CMxunjmmnAyqj7t/lDqilHgS3RlVb6u71LyG07HhWgOYBcPjBKTZbmPMKmP1WMyL+Qs0Jg/QKKvgQfGZzSyKRg3NEf4iHbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
 by DS0PR11MB7851.namprd11.prod.outlook.com (2603:10b6:8:fb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 9 Jul 2026
 08:17:35 +0000
Received: from PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707]) by PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707%5]) with mapi id 15.21.0181.008; Thu, 9 Jul 2026
 08:17:34 +0000
Date: Thu, 9 Jul 2026 16:17:26 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, K Prateek Nayak
	<kprateek.nayak@amd.com>, <linux-arch@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [peterz-queue:locking/core] [futex]  58141fa298:
 Oops:general_protection_fault,probably_for_non-canonical_address#:#[##]SMP
Message-ID: <202607091538.58e3f39-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: s-nail v14.9.25
X-ClientProxiedBy: TP0P295CA0057.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::16) To PH0PR11MB5832.namprd11.prod.outlook.com
 (2603:10b6:510:141::7)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5832:EE_|DS0PR11MB7851:EE_
X-MS-Office365-Filtering-Correlation-Id: 78601c42-c306-436e-cbb0-08dedd9287b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|56012099006|18002099003|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info: qv1n4xXFFx8GrxZXCs+yaTZlAnsHV5UU04ZfYtw63lf7RUd0xg6uIqxpaOGmYFjNMuNhnmdJ17QHv4UHc5fnCi/lCzIzwzUcqyR69mdct3ZLk5U+qq5/eYGEw9bWKPM3zWoxr8ZlbiQC8b4lILrNbmPkSLaSPdggMLwd1XbE/h/6bqkdOWIw9Cgt3DNM4mMgJ46uaKHJHq9qclvMK29PIHXmDoJ+lH1Ejc54muWi0QxyQgWzhGAiDijeSyS5QT236KR78bJmidrOnN5HjbViOO4Q21avT1o3kPn5LWG/jq1BG6Aq0kqLTOmj++C4rSPHtbaC2uLsRgwplLhHOHZwieWP3Q0wf/kCnNsUryp7qGWK6jU351DPmvi8Ittgvjkpphs7mQWoi1Z3J5mCiRSatjgQwI+DxkoCViSQdXFjlyIgdKveu9xfFr1FKFy+YgxKhbINgfjjI6PC2Z+MiH7cERab1xlQsh6aGjpJFvUnMhSABrV+d5EMS0+db9qB0EyrryU2PnJwEr3Z97S/+L+wmHAVtb0riJCCJbsrIlsAmfKcD6TOh+xqfPlrpnXq17i0tUMdZ0WikDpj6R+4aB4dT/bRI9AiISafgs8soRUNZPCFzQ8SAOWd6eRNAXsOTrDm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5832.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(56012099006)(18002099003)(11063799006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rdT4z3jlQuNitwQcZfUGRyE8Rbq7EsP/6KzsAlMmduc6ijjFMi1P5eyD9Zfq?=
 =?us-ascii?Q?lAIFQpqpHZ+HiMRLWIwma3SLxPUX9HLGrPgai5m87LJBzsTXf9htM9z+ZonN?=
 =?us-ascii?Q?Iw3FsSyJXoTAWFrr+vyMwxu/xp88OKLX3/CizufqnY/4TnExAQS0y7gPJH+t?=
 =?us-ascii?Q?4s+MEOg9hAv5CFwkoOrsDT4BB4wmuSqCHLBgnwDz8Xxgscsi7OMwWhHB1J8F?=
 =?us-ascii?Q?QjBZskrxQhVEgd5dQjBKdAITOpKg/7ZLwmJUzMxBd0x3xlK7SBbecbNanHJR?=
 =?us-ascii?Q?OjGO1ijOOoV3qJ9pRcUU/3lcmQh9PZsX1ednB74OJp3iWcwXz1K/M/26nEmS?=
 =?us-ascii?Q?NqqwLsvDDzph+Gu5bN4N3vd9U1uWU7ioxiQWpZnSCaSMlFa6NeR8tQO4jIxt?=
 =?us-ascii?Q?AZ3RRTgBbc4FcnmsUvkJr99z7TLjqG/zFiBmxnqrl9P2LvRkggSKV1MzRwx2?=
 =?us-ascii?Q?todjGqRKedNSsDDGCgSvCCh9COj1zh54fg5WAFTQ/PtKrfkJMLtlA9ysIzTK?=
 =?us-ascii?Q?Gn3VlsSgaUbqTDmewQnV/ks73/fevG0Ffu1Tv3U0wind8LsYCAfFFxYIXVTL?=
 =?us-ascii?Q?3MQaPw8z0NfFwtoM5jKl9kpQEtPL8ysB5TyOZCY1EipyXJomnFFr9pbv0iJ3?=
 =?us-ascii?Q?CGo9RJBtdgvwo30t7tjU7rIw+JBTRSKNv7z2gFHL4ILs2dU1Xn6n49QbsEmh?=
 =?us-ascii?Q?oQC5GwC+Ia35J28hkeChD2vDqc1Qp/K0X3S2485DHC96ZbUpUzkt5Ar9B+yI?=
 =?us-ascii?Q?pjjgOQwe99MtS++kIGSfaNUesr+ICTJivKrdo3CLbRcuSSEaYq4UwzZ8mq64?=
 =?us-ascii?Q?Q88J3fkcY8r6uGL7/efZYGXFYNZRNTx8RLgiohRICuDayEl7c0eT8Sy6QPxB?=
 =?us-ascii?Q?jTWHV7f3eZExkXyTnMPK370Fm8c+POIqwfn9/429atWRtsY+FK+25HlRGZMa?=
 =?us-ascii?Q?JhwB5O1fE3XPx0lj23kEJBlGrEq6CJAk+2kM76J2TOSf6QgYT96YCs8uictN?=
 =?us-ascii?Q?/ptUiOR41eIO6cWj1/SsySXs0qYqq2M9irK/Km0LbSEqn/Q8ks6N/d+vD8P9?=
 =?us-ascii?Q?k1lUtE+c1d0vc7izxr0e2uqzjyS2ozYY4GsloukfacNQIyVQo0avM9RtIV2N?=
 =?us-ascii?Q?tGBtGNo+dgp+SCNZA9MmAqXa5C3pUJT+Zojwfa7S2hbft/klK+ZnsN33ABfu?=
 =?us-ascii?Q?GUu4mawOzfQPEjir0HwkAQl+toqWBvk+fQsklaZ3/DvGyXUaijwClHrG59nL?=
 =?us-ascii?Q?vJnBU60ID1JyGbMpQEzEK5HO1rWcHHsPtVC9gGwDb9AEhYRpQA1kr6mSGE7t?=
 =?us-ascii?Q?1RUqH4QbeMVfwmXqof+6KByIfO9HXNnZYsALkpwEpulYrpNtA4P5WPU5/GaS?=
 =?us-ascii?Q?1aoMpT7iiIPyjXSwo/LUPtEwSY33PYto4/gkz8ggp/cLKA+/aMdPq91W+DJH?=
 =?us-ascii?Q?QZiwtODWHMBWJ5fDZsaBTZ2VhKtUkGTCuE2Us7Qo8Nm0awQJCgCljP7t31pe?=
 =?us-ascii?Q?zFisPJ1GgsyGpD4jtkUPhq9/j8gdRi5t/wGlmaK1nTTgEfPDKkzLJtyUY9ky?=
 =?us-ascii?Q?1ohXir+0I3+YgBtGiFxp4+XTjsSF5fzlIIigqIKSFpL1KRTzgl7x4U0bCmFt?=
 =?us-ascii?Q?n6uuAIimqzv4pVEETCCtkxFe9HL792WMuG0M3mymqtxr6G+b8JR6657q7CgE?=
 =?us-ascii?Q?XqQq0wqutHv7pEfiZtKB0ddmhS19Gf8acMAz1eWRCjZugsx5/K7sbI331oMN?=
 =?us-ascii?Q?ssNVdDTrGw=3D=3D?=
X-Exchange-RoutingPolicyChecked: XFDB9tjMgMjg07bN+pedsu9AJdgLdw2v1OqPdZx3FWYDnYY1y6dJBULJFfAYQANFCxjWeMGMBiUZqouLf2R5QQegLJojHQ/aWuQylrSQRuWokvnpEgpQxWyxW3CDHYgl1Dgol1S4Vt+OsIwSKejHBl6QDN/e5Q7GxxyPib2KtHz+WHfskXzhm8D+qZSptDug15VAoYvYTK+8F7M6NFO5haSv2EjwoH5DuDwiTw0o9G6f1fDgiSgT4kkMFqQKyFE0N3CL0i80m28hPKjt9dw8QbNUZigCVnJlESLUdi4vpAREhnqajS6VNd1ntCVH38t1JWzVbsFVxqXo0o9LA+WcCg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 78601c42-c306-436e-cbb0-08dedd9287b7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5832.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 08:17:34.7478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 60zKnhqzU0tjWXUolzRWQgzz7UtnRmsrgwh6xtzzY1bHC0PQd0a0zwXt6HJyl1t+Jm8IQbnv7CF9hlDgsX94jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7851
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "Oops:general_protection_fault,probably_for_non-canonical_address#:#[##]SMP" on:

commit: 58141fa298f3f1df4ee145835eb3491cfe68f652 ("futex: Use runtime constants for __futex_hash() hot path")
https://git.kernel.org/cgit/linux/kernel/git/peterz/queue.git locking/core

in testcase: boot

config: x86_64-randconfig-012-20260704
compiler: gcc-14
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 32G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202607091538.58e3f39-lkp@intel.com



[    1.259631][    T1] Running RCU Tasks Trace wait API self tests
[    1.261867][    T1] posixtimers hash table entries: 1024 (order: 5, 81920 bytes, linear)
[    1.264376][    T1] Oops: general protection fault, probably for non-canonical address 0x123456789abcdef: 0000 [#1] SMP
[    1.267507][    T1] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 7.2.0-rc1+ #1 PREEMPTLAZY
[    1.267699][    T1] RIP: futex_init+0x1e4/0x2c0
[    1.267699][    T1] Code: c1 e7 07 4c 01 e7 e8 bb f7 5c fb 4c 89 f6 48 89 ef e8 b0 f6 5f fb 4c 39 f5 75 d9 e8 a6 f4 5f fb 89 d8 8d 53 01 be 00 04 00 00 <4d> 89 24 c7 48 63 d2 48 c7 c7 80 f1 3c 85 e8 c9 fb 22 fc e9 2c ff
All code
========
   0:	c1 e7 07             	shl    $0x7,%edi
   3:	4c 01 e7             	add    %r12,%rdi
   6:	e8 bb f7 5c fb       	call   0xfffffffffb5cf7c6
   b:	4c 89 f6             	mov    %r14,%rsi
   e:	48 89 ef             	mov    %rbp,%rdi
  11:	e8 b0 f6 5f fb       	call   0xfffffffffb5ff6c6
  16:	4c 39 f5             	cmp    %r14,%rbp
  19:	75 d9                	jne    0xfffffffffffffff4
  1b:	e8 a6 f4 5f fb       	call   0xfffffffffb5ff4c6
  20:	89 d8                	mov    %ebx,%eax
  22:	8d 53 01             	lea    0x1(%rbx),%edx
  25:	be 00 04 00 00       	mov    $0x400,%esi
  2a:*	4d 89 24 c7          	mov    %r12,(%r15,%rax,8)		<-- trapping instruction
  2e:	48 63 d2             	movslq %edx,%rdx
  31:	48 c7 c7 80 f1 3c 85 	mov    $0xffffffff853cf180,%rdi
  38:	e8 c9 fb 22 fc       	call   0xfffffffffc22fc06
  3d:	e9                   	.byte 0xe9
  3e:	2c ff                	sub    $0xff,%al

Code starting with the faulting instruction
===========================================
   0:	4d 89 24 c7          	mov    %r12,(%r15,%rax,8)
   4:	48 63 d2             	movslq %edx,%rdx
   7:	48 c7 c7 80 f1 3c 85 	mov    $0xffffffff853cf180,%rdi
   e:	e8 c9 fb 22 fc       	call   0xfffffffffc22fbdc
  13:	e9                   	.byte 0xe9
  14:	2c ff                	sub    $0xff,%al
[    1.267699][    T1] RSP: 0000:ffffc90000013de8 EFLAGS: 00010246
[    1.267699][    T1] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
[    1.267699][    T1] RDX: 0000000000000001 RSI: 0000000000000400 RDI: 0000000000000000
[    1.267699][    T1] RBP: 0000000000000200 R08: 0000000000000000 R09: 0000000000000000
[    1.267699][    T1] R10: 0000000000000000 R11: 0000000000000000 R12: ffff888100450000
[    1.267699][    T1] R13: 0000000000010000 R14: 0000000000000200 R15: 0123456789abcdef
[    1.267699][    T1] FS:  0000000000000000(0000) GS:ffff888899778000(0000) knlGS:0000000000000000
[    1.267699][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.267699][    T1] CR2: ffff88883ffff000 CR3: 0000000004ab8000 CR4: 00000000000406b0
[    1.267699][    T1] Call Trace:
[    1.267699][    T1]  <TASK>
[    1.267699][    T1]  ? fail_futex_debugfs+0x80/0x80
[    1.267699][    T1]  do_one_initcall+0x62/0x280
[    1.267699][    T1]  do_initcalls+0x177/0x1c0
[    1.267699][    T1]  kernel_init_freeable+0x11c/0x1c0


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260709/202607091538.58e3f39-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

