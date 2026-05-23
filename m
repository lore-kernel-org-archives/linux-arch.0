Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC68D3A6EFF;
	Sat, 23 May 2026 14:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779546371; cv=fail; b=K17FfAQnrUFbHFJsnXhZcUydVGhjZZHTnyzQssFCoWBti5OZEFomANCCcyseb5JykKui9S/EdikE8MP2oynf5vRcObYS/C23zaRQIqSMVpfupIcFR4RgKyirbgIuvoZpNN1KObVZDW864vZkYnkTthZ7J1C0hgFuiRyCyuPrWTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779546371; c=relaxed/simple;
	bh=CCoZWiLiKuy2OwvIMM0USVlA7+YyzThwNq9Q0rgUC4k=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=o9qqJ5wFt77Xt52Q5emV3jJ5/3v3kgsXL4Wdl/b330a8iCLIRKrdugj05u/Dk3pjMti+viWjXdvpaizSBC/zj1dcyEy/BQBJMK/1WdOK6Pnbrfuy2nA6ltjKcBpJ/ukquWmiEM2P8NMGw+hXjSGneNFufYXqKopMA+rPXvi5Ue8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Et0idSIV; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Et0idSIV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779546371; x=1811082371;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=CCoZWiLiKuy2OwvIMM0USVlA7+YyzThwNq9Q0rgUC4k=;
  b=Et0idSIVIlnJos6gv0W+hSiC4NptG+91AhQJvSBHYJxefv9lLqIC5Bxf
   E33ewzQNSNZFhga72Wtbv39j1dyDrLMLfkDW9tn/qq7q+6FY0eD40CkEx
   TiasM+8Je2QP3x2TsE16tuItU6lldpRFMy+s+qUNgIEOa3EvZJzAbNKfC
   pV35bu2aL1G7ucTxrXQMXKt8nONs1CDBoBHwxRg12fUeUOAmTs0Aa2NLT
   bYsvW/Y6mbSEO2zgw7IO05tsc2vMmlshNg7UvmqfUYtSXvKkeRFKcNDDB
   eJ/ory2GcT2rm5YrsOkZTBHF2BdrOS4rqoDLnRxF92d0H7u1ZzX9euqAN
   w==;
X-CSE-ConnectionGUID: OYVCo5iaTByHg7+cxeeEBA==
X-CSE-MsgGUID: yHPL5Uv2QCWN1WRAcb3cQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11795"; a="84066019"
X-IronPort-AV: E=Sophos;i="6.24,164,1774335600"; 
   d="scan'208";a="84066019"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2026 07:26:10 -0700
X-CSE-ConnectionGUID: stsF+8EZREev1k43tB0OaQ==
X-CSE-MsgGUID: gIUY5tUPSeyyR0oHQZi2vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,164,1774335600"; 
   d="scan'208";a="279278460"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2026 07:26:10 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sat, 23 May 2026 07:26:08 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sat, 23 May 2026 07:26:08 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.14) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sat, 23 May 2026 07:26:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k3gNgXO/HQwTq1s70CKdgD0QK3bPkkSS7GVJSGGsvgcQn72+k7TguZ0FVc/3LQWLnOo821+vjoaAm4Q16Duf58RlNHXmw7DAzrRoojO0oFvYE8TEgd0aiPwDwSgnzDtm/jUOtG1XzMAjmfGtSxkFbkC6lEzI0vMhmXD322/cHZluxqKrQ3mjxHnLxXQ4gTsl7o1ZKXseqUloKlX7IFM85Y1p2Ww338U6oID1fWdoL62M7YimiyEGaykmr/pbgSG+VBJibeUrAMEewAfTKuxZgMxEBaOI5XkFeyV9eaHFwQ/l66+dJ4hUnA/7iSvJ6AZxPRICkwh5hqT9njA5n8X9eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m6h0GgB7cA8OdGXMMv2bnzChBrj8kBSD8nzsgv7j1WY=;
 b=NCv4qtsnT6/ikfXQ3h/5ST1uh/cPFgQIq1wJfz8sd9PltmpO3bO5reI3ogKeFDWJldOEVs3e0JFui8e+nO/QRybtfkwL9vUBKXrsxHBAsUBCNC9+lg3SQIcfbFoH24r1WHrdos1Yr7rHBcQ0RC+cI+17kfezUG2xaIOy3+MlNVVfKY0m95/johccIapDNsU8hpVxx0+ZLkA5kDBR7hfzZGhyeRmJ8xXQ7sPNKVwhDKbXA8r5GNDnuY63aUef+Xyg7MxnVyLgzjQfm2sw1m0lM7PcZTfY0tzztoLdbf+7nE9lijLOgMVMtWSHNRJwPS72vqbAndJwFpRsZ7gCWAIj2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
 by BL1PR11MB6051.namprd11.prod.outlook.com (2603:10b6:208:393::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Sat, 23 May
 2026 14:26:05 +0000
Received: from PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707]) by PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707%3]) with mapi id 15.21.0048.016; Sat, 23 May 2026
 14:26:04 +0000
Date: Sat, 23 May 2026 22:25:50 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Luka Bai <lukafocus@icloud.com>, Luka Bai <lukabai@tencent.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-mm@kvack.org>, "Jonathan
 Corbet" <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, "Andrew
 Morton" <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>, Zi Yan <ziy@nvidia.com>, Baolin Wang
	<baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <liam@infradead.org>,
	"Nico Pache" <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, Dev
 Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, Lance Yang
	<lance.yang@linux.dev>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport
	<rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko
	<mhocko@suse.com>, Jann Horn <jannh@google.com>, Arnd Bergmann
	<arnd@arndb.de>, Kairui Song <kasong@tencent.com>,
	<linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, Luka Bai <lukabai@tencent.com>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH 4/5] mm: enable map_anon_folio_pmd_nopf to handle unshare
Message-ID: <202605231645.88096ca9-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260501-thp_cow-v1-4-005377483738@tencent.com>
X-ClientProxiedBy: KU2P306CA0013.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:14::17) To PH0PR11MB5832.namprd11.prod.outlook.com
 (2603:10b6:510:141::7)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5832:EE_|BL1PR11MB6051:EE_
X-MS-Office365-Filtering-Correlation-Id: 312ca272-dc9b-4beb-b7e0-08deb8d738ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|56012099003|18002099003|22082099003|3023799007|11063799006;
X-Microsoft-Antispam-Message-Info: 0AtV04F3WecLuCWNpkXra6m5JoKOgNIrOH5Wpj51DZRTZPLlwH/MWLb8VfFhP9T53SdW5MgpTjfG5rkso49IJDa6wde1GHZjyX1iiFtbGGg5B+IVf7krJRiCvGX+3yBIJ7hMDT8oWZ8qbv76SPNSC38XVG24kmGGJvRSufhzm8uSvzrk3c2lCtf4hhlmaKjsFhvTNmnsW7oU1ckZch0LSdW6U3qEZu2yFdgaqt828r8R3zuXCwaLHnxGCUOeJfrL5T60kfxpat2ChL7Tz897vxsHiLgZjDSnhwV+I/QVp/u/QLngP2gzeI3yUwvpNbNR4XJeL1nzXuj78ulk8QtEL69jz3m/9hqopmQWQ4ivdpHDV39UAtupv3xXbzvlm4jJDMxwLADNYZ9+3XrEvQxWL7wi4CRMvFemsVIjMKQTlRsmwrMFmf9N57awA0dYx70lHoM4010pJcNSzuL2VVFNqRk65V/YXufm7nRJeMPQJ2HCZJqLQaQaIAXnqBHT/5p6oFnVvsVTHKa52D2bT5Ac+jVdFQRLaQa/knQ4jEZyoPLPEScTrJdXAn4g97PERvfW4TcFbJfyMcqStkgRsHNNFUmc4axZL/BoByr8fEQ0dmntbUNxIZdZ+xuN4YK4l23GWxEJVxZr7pNlYmEY4rKPxA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5832.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(56012099003)(18002099003)(22082099003)(3023799007)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5yn77dJQeBCbah0d0xCsdt9rNzuMVVCQ5sjLexBpHwQa5FGoMPtVimm1SqmU?=
 =?us-ascii?Q?EqqGFdEmaO9fXxYRMj7fai+m0WTKtvHUuf55X1f4Y9RGkq+Q22EO+Cw94ZJ+?=
 =?us-ascii?Q?upGDMQ3a2H/fuq+o0pXg3j4w96KMEUcFzrzuGE9tWUt6rTGNtdCco/C4sQ3k?=
 =?us-ascii?Q?gX7arQ4Mb0EBk12vUmVzjEa1PXVjn1wACiPZGq0phz0OUtKvyjH/AG7KvCXo?=
 =?us-ascii?Q?yLtMrFRJONZHSBlYT4GjSvkwIjMJyS3FYTOUZlssYA7nCW52gSZG/3nDR+Mw?=
 =?us-ascii?Q?gQYdZs3UJitf3FtdTNCQK+nofl6SgAK1ddg0bQJBGhdjCjTY1PGvjr42Zb/R?=
 =?us-ascii?Q?VAJEHLhfJTEWomn93beX4NgO0p2RCk/iMwoX6BbvWzsOngWvejC0EaD5OE9C?=
 =?us-ascii?Q?5bV2D7ZnVxMlfbS1YWiNPDLvE5iXUAp/WgPrPkhvyFWEWWjSYi9sB5XvvBhX?=
 =?us-ascii?Q?dNcVzJnILecNZNpIbGSjSEbp3iEZB5Sre12Vr5L2CjuGB2Wh7Oglagpk04US?=
 =?us-ascii?Q?G+UGkp16fb2e9nMuLy330ww51Xy/mwaP94Icersp8PBu/x9nhPnmIX89B3B4?=
 =?us-ascii?Q?7cj+Bym/QnoJfGlkcFUT7sPtfB6xDHex4zlfjlpws77g4YvTE1HbEl5Qv/2g?=
 =?us-ascii?Q?ZEMyNjNro9eLwKICI9pZbtxG+JFgEiwbI9qvRnPaS2YG9/dsvj6SlQFXPxQA?=
 =?us-ascii?Q?5Pyth8nl/Z5E30g4hgnQQNg6RGCZ/nt53VGojKY7DMBfd071RuK1W2BqmGXd?=
 =?us-ascii?Q?w/8pOmbMOC8xyKjD98qJFBmIVs7hH2XEKnFyM4eqcwpSkB9CvD9FzhKyhyTX?=
 =?us-ascii?Q?1Xpg7yWpj8Wo7M8wIYO3rW2gSAqFGCrVn/98vN1AwrBjij2NjkLIuuB/Wb7F?=
 =?us-ascii?Q?lG7hmC5OIgdR1Qa0X5syVBJ/QpSgFgV8xGyrdPOMysMG5Pi7ZaCna/2TD3De?=
 =?us-ascii?Q?QpYpZvz/q2YQhVkEKRFFHcGnT0p+f38FD+VvfCoIEWSUxde+y0hoVM+70BGV?=
 =?us-ascii?Q?TvWyGXvML+pd9SdXlZPtTF1kcEAFf1zplFxoHlwpAj75IZjzavPwdunidZvQ?=
 =?us-ascii?Q?tu4kdrfZGd+1LUqPZFFfXFvpSIfbAZa/FAKIJrCRoY8JLU8Eep7YwJ6ZOVQA?=
 =?us-ascii?Q?RMv6AXOjgpNrY1X20E03b08380LsXADybkOTY3PMunegqwiVh8nAFNyoww48?=
 =?us-ascii?Q?PYv0g42Nr5yrprvPTGrtWQ6kCQ5tzrhZa5ZFl+VTAgjSpsxfxrF2A8KKJYl4?=
 =?us-ascii?Q?J47WCWmo6vma2g9p5CATHSRDfUPcREzR0YmZHCJskiK0OVl0+wD8ThNzlMux?=
 =?us-ascii?Q?ZhulPT4AQXIkGBzyCMXELOAd/pqvMXWXqnkfGYH6a/YqEe057LaMtNYUKJwj?=
 =?us-ascii?Q?Z7hw+ji5yW6DkcDNsyorBxBx06fM4vhfsWGobUBOdmOrgnCeib4UZfqw+S1Y?=
 =?us-ascii?Q?m4eDXZXBCp8czilvy8u0CRi4P14ZpUKWQ1RQRBJv6naZqi1zY6CW30ylh3+d?=
 =?us-ascii?Q?1RW6+GU/DFhoxbbKJqH//bjsZ9iDE3TIIgv3KgDou57qnncJv2dURuW+R7Xy?=
 =?us-ascii?Q?G1B+vx5W0xWeO6c1CtJSu/tSlaU1/rDgCaobhsNRD5gYOX+PNsaxe84Fl+4C?=
 =?us-ascii?Q?ghKyrZRLgjqPxgT1bb+td3M3Nmd8y8YknJzvpDMBlHwZWz2NjihqAx+UHfah?=
 =?us-ascii?Q?etl/BkG2AsUhdkdzMguYEwZhPFm82veqs430s3FWF9BCchd0pKV/eZq35a8r?=
 =?us-ascii?Q?pBNM257d9Q=3D=3D?=
X-Exchange-RoutingPolicyChecked: aRe8tXx0eUY+gkHiVk1ytLqNbxKkhBekMrhjgRWMbP/3byll8XcKz1dYBmQXofuAPosYaudtejhsystNXVTviMp0NPUu2y3JBrC4xXOWG3VqYzUKLDwZMb8MDwneCnxZ3S+89v9Neob5ehDV9ZRE/1ByrP21Oki/RVajvxz5jPio01T/r/qacdiM28pFVkIixkbdu0h52nIcZJhIUeZRv7LEKGH21U9KdaBkIttZCzTOoqRvG1eXOBnC1CjIVKjwv1yK+EYqxuj+jlKQo8l8Pt23qTNnpHm32v5Cw+Dpk2sQxvkFzN5BBtEQl77pNW+2jgokK6kK1hwGE22/CG2WLg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 312ca272-dc9b-4beb-b7e0-08deb8d738ac
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5832.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2026 14:26:04.2843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fyRWhuZVOhaVRzQGn91SSo/B/rF/QEs8RPxPxQx/zU7KmjyDO0wsuOOUHiICs4fIVwChCYKsHFWl513IHzhpqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6051
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:kernel_NULL_pointer_dereference,address" on:

commit: 419ac88f7d747a174b48e12d2fd2178a128f54de ("[PATCH 4/5] mm: enable map_anon_folio_pmd_nopf to handle unshare")
url: https://github.com/intel-lab-lkp/linux/commits/Luka-Bai/mm-add-basic-madvise-helpers-and-branch-for-THP-setup/20260502-230731
patch link: https://lore.kernel.org/all/20260501-thp_cow-v1-4-005377483738@tencent.com/
patch subject: [PATCH 4/5] mm: enable map_anon_folio_pmd_nopf to handle unshare

in testcase: boot

config: x86_64-kexec
compiler: clang-20
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 32G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202605231645.88096ca9-lkp@intel.com



[   15.354503][   T37] BUG: kernel NULL pointer dereference, address: 0000000000000000
[   15.355458][   T37] #PF: supervisor write access in kernel mode
[   15.356077][   T37] #PF: error_code(0x0002) - not-present page
[   15.356690][   T37] PGD 0 P4D 0
[   15.357088][   T37] Oops: Oops: 0002 [#1] SMP PTI
[   15.357612][   T37] CPU: 0 UID: 0 PID: 37 Comm: khugepaged Not tainted 7.1.0-rc1-00099-g419ac88f7d74 #1 PREEMPT(lazy)
[   15.358688][   T37] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   15.362222][   T37] RIP: 0010:map_anon_folio_pmd_nopf (x86/include/asm/pgtable_64.h:79 x86/include/asm/pgtable.h:1210 huge_memory.c:1448)
[   15.364849][   T37] Code: e0 ff 48 89 df 4c 89 f6 4c 89 c2 b9 01 00 00 00 e8 b7 a2 fa ff 48 89 df 4c 89 f6 e8 6c 93 f4 ff 4c 89 64 24 20 48 8b 44 24 20 <49> 89 07 48 89 df 31 f6 48 83 c4 28 5b 41 5c 41 5d 41 5e 41 5f 5d
All code
========
   0:	e0 ff                	loopne 0x1
   2:	48 89 df             	mov    %rbx,%rdi
   5:	4c 89 f6             	mov    %r14,%rsi
   8:	4c 89 c2             	mov    %r8,%rdx
   b:	b9 01 00 00 00       	mov    $0x1,%ecx
  10:	e8 b7 a2 fa ff       	call   0xfffffffffffaa2cc
  15:	48 89 df             	mov    %rbx,%rdi
  18:	4c 89 f6             	mov    %r14,%rsi
  1b:	e8 6c 93 f4 ff       	call   0xfffffffffff4938c
  20:	4c 89 64 24 20       	mov    %r12,0x20(%rsp)
  25:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
  2a:*	49 89 07             	mov    %rax,(%r15)		<-- trapping instruction
  2d:	48 89 df             	mov    %rbx,%rdi
  30:	31 f6                	xor    %esi,%esi
  32:	48 83 c4 28          	add    $0x28,%rsp
  36:	5b                   	pop    %rbx
  37:	41 5c                	pop    %r12
  39:	41 5d                	pop    %r13
  3b:	41 5e                	pop    %r14
  3d:	41 5f                	pop    %r15
  3f:	5d                   	pop    %rbp

Code starting with the faulting instruction
===========================================
   0:	49 89 07             	mov    %rax,(%r15)
   3:	48 89 df             	mov    %rbx,%rdi
   6:	31 f6                	xor    %esi,%esi
   8:	48 83 c4 28          	add    $0x28,%rsp
   c:	5b                   	pop    %rbx
   d:	41 5c                	pop    %r12
   f:	41 5d                	pop    %r13
  11:	41 5e                	pop    %r14
  13:	41 5f                	pop    %r15
  15:	5d                   	pop    %rbp
[   15.372240][   T37] RSP: 0000:ffffc9000013fb70 EFLAGS: 00010282
[   15.374712][   T37] RAX: 8000000143a000e7 RBX: ffffea00050e8000 RCX: 0000000000000000
[   15.377932][   T37] RDX: 000000000000021f RSI: ffff88881fc271b0 RDI: ffff88881fc30640
[   15.381250][   T37] RBP: 0000000000000000 R08: 0000000000071ce9 R09: 000000000000b2e9
[   15.384563][   T37] R10: 0000000000000001 R11: 000000000000003f R12: 8000000143a000e7
[   15.387726][   T37] R13: 8000000000000025 R14: ffff88810e098900 R15: 0000000000000000
[   15.391175][   T37] FS:  0000000000000000(0000) GS:ffff88889c101000(0000) knlGS:0000000000000000
[   15.394883][   T37] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   15.397492][   T37] CR2: 0000000000000000 CR3: 0000000163644000 CR4: 00000000000406f0
[   15.400508][   T37] Call Trace:
[   15.403414][   T37]  <TASK>
[   15.404723][   T37]  ? lruvec_stat_mod_folio (memcontrol.c:993)
[   15.406687][   T37]  collapse_single_pmd (khugepaged.c:1411)
[   15.408449][   T37]  ? __pfx_wq_barrier_func (workqueue.c:1144)
[   15.410197][   T37]  ? __thp_vma_allowable_orders (huge_memory.c:124)
[   15.412115][   T37]  khugepaged (khugepaged.c:2901)
[   15.413596][   T37]  ? __pfx_khugepaged (khugepaged.c:3113)
[   15.415388][   T37]  kthread (kthread.c:436)
[   15.416719][   T37]  ? __pfx_kthread (kthread.c:1738)
[   15.418155][   T37]  ret_from_fork (x86/kernel/process.c:158)
[   15.419600][   T37]  ? __pfx_kthread (kthread.c:1738)
[   15.421001][   T37]  ret_from_fork_asm (x86/entry/entry_64.S:245)
[   15.422510][   T37]  </TASK>
[   15.423538][   T37] Modules linked in: sr_mod cdrom sg ata_generic fuse
[   15.425454][   T37] CR2: 0000000000000000
[   15.426674][   T37] ---[ end trace 0000000000000000 ]---
[   15.428142][   T37] RIP: 0010:map_anon_folio_pmd_nopf (x86/include/asm/pgtable_64.h:79 x86/include/asm/pgtable.h:1210 huge_memory.c:1448)
[   15.429793][   T37] Code: e0 ff 48 89 df 4c 89 f6 4c 89 c2 b9 01 00 00 00 e8 b7 a2 fa ff 48 89 df 4c 89 f6 e8 6c 93 f4 ff 4c 89 64 24 20 48 8b 44 24 20 <49> 89 07 48 89 df 31 f6 48 83 c4 28 5b 41 5c 41 5d 41 5e 41 5f 5d
All code
========
   0:	e0 ff                	loopne 0x1
   2:	48 89 df             	mov    %rbx,%rdi
   5:	4c 89 f6             	mov    %r14,%rsi
   8:	4c 89 c2             	mov    %r8,%rdx
   b:	b9 01 00 00 00       	mov    $0x1,%ecx
  10:	e8 b7 a2 fa ff       	call   0xfffffffffffaa2cc
  15:	48 89 df             	mov    %rbx,%rdi
  18:	4c 89 f6             	mov    %r14,%rsi
  1b:	e8 6c 93 f4 ff       	call   0xfffffffffff4938c
  20:	4c 89 64 24 20       	mov    %r12,0x20(%rsp)
  25:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
  2a:*	49 89 07             	mov    %rax,(%r15)		<-- trapping instruction
  2d:	48 89 df             	mov    %rbx,%rdi
  30:	31 f6                	xor    %esi,%esi
  32:	48 83 c4 28          	add    $0x28,%rsp
  36:	5b                   	pop    %rbx
  37:	41 5c                	pop    %r12
  39:	41 5d                	pop    %r13
  3b:	41 5e                	pop    %r14
  3d:	41 5f                	pop    %r15
  3f:	5d                   	pop    %rbp

Code starting with the faulting instruction
===========================================
   0:	49 89 07             	mov    %rax,(%r15)
   3:	48 89 df             	mov    %rbx,%rdi
   6:	31 f6                	xor    %esi,%esi
   8:	48 83 c4 28          	add    $0x28,%rsp
   c:	5b                   	pop    %rbx
   d:	41 5c                	pop    %r12
   f:	41 5d                	pop    %r13
  11:	41 5e                	pop    %r14
  13:	41 5f                	pop    %r15
  15:	5d                   	pop    %rbp


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260523/202605231645.88096ca9-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

