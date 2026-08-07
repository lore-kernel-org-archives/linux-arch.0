Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E394052CF;
	Fri,  7 Aug 2026 08:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786092666; cv=fail; b=ehZQVcq3W0M+sr3U/yZ8Rv4PCPjrEzgLZLgsDXLDdfPDefde/T+6n5gJkgBpEvEGgGNRUj96G028hWzORJuGhPv4DbXzapWG4JpQs9i+8LGm8zC4P5CbgGbpb/yFE90AHEvFMqapZ70Y8kuJxDBRuq9HAUtuuyw89kNlkubzLKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786092666; c=relaxed/simple;
	bh=Eo8ohsgNuKzdxbsF2jtk+kmdE4xcSkCRWGA2O8WvFQo=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=bMg7n7fVOOrrSMtrlIQAchx88elBsj/n+3MgdByXkn+nzyaVuGAjiDTRHLP4f9BTaFOEEeWPOygajXdZZgHDcmHjpc2iY5gNrgOR93GglF956PbmGgePd9Bjax1CwGe7s6+O0uBVzLMuvdMEekaNw1Oi7kg1PEpMnI2gRO+qkQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WIODc+oh; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WIODc+oh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786092664; x=1817628664;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Eo8ohsgNuKzdxbsF2jtk+kmdE4xcSkCRWGA2O8WvFQo=;
  b=WIODc+ohmKvudqBMHZ+3DHh+9V4KsqCAIORjdpHbimqb4rtz5rMhrLn1
   CaJ2Wi55l+EthRpvZnqUvlDw8IVxQ9Id+WJoP4Dp9Oc8Bt6vpCgMeHkNj
   AFcYL8y1RbCSzb+/sfttJjV3zfDCmT1UXXHFrOyc6yakl6y1jt2aDqn2r
   7lzC2ZBmQP0nP1nDkuZm+lnqBVEaUIlVsneHo78NHTzVfdAY+31geyeO3
   EU96T5Fzoz2tTI4fzITUIvcv61E7TcBySUJo9AE0S7KNhZ2+RThP1EjIM
   2bpX18gtyDudLRGeQy1a37JRUEukX2a9z84UIHqpAYcUXFM106m0nvyg7
   A==;
X-CSE-ConnectionGUID: wUO6Z4CgRwCMo0gosO9/nQ==
X-CSE-MsgGUID: 3andqQGNRZGZpCYlPyRC9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="86810271"
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="86810271"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 01:51:03 -0700
X-CSE-ConnectionGUID: ahIomiVhTKKiNveXGyVI4Q==
X-CSE-MsgGUID: L5q+NM/SRnW+ZpigXnFwNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="261827156"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 01:51:03 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 7 Aug 2026 01:51:02 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Fri, 7 Aug 2026 01:51:02 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.30) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 7 Aug 2026 01:51:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tFAEgErJt/MbKDeIHQy/BZEjGu3NKEY+vTa+RZLx90R4GlFKhp6rNGQkXPnld1FqRdUH79MXoOuYgPzdDNp6jjRWa6p378mwRMibT5DiOcffCwDLemMBhwzMd3HPhd1TZNW5ag2p/y+7ov+7kNkrgJdX8MweZTntQHc2f1RGVDYMkqkX1EaJJViNuoho3iqQeUMx3wAsGoUEM40SKcjBBeoGi14e6kCMX/QOr4knEzpoTtY7m5kHj9OArTKkWkQdMfDhYquIUpO93P+/ubDeSjOg8n8G0ZrUqqdGj4HFEVw5+8UQjF+JhPsaVVw+f+z1rmiG/3DH7fvG2EKTq/4peg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/tDI1uxEU+gT9dEWdegZm6YWd7cGliao4qAxglRfnWA=;
 b=jtxTrVcy+L01CmaUC8IXUXH9T3Fq85j3nx5Qxs5rSk24gY0KxxuOZ4+vHDHzlnDWlaDTQHHczvkmm7SPIho1dbbvi5qb9IOWFiuQtnAlmFVb4eQSwa0dQA8s7B20pPetiYIhM46pheGFka+JzpfpJAcePWh6B9NFR4Dwt4/9Tjbeot6Ocxzf4RCpqVFK6NpOG6SMBuDiWKZOsc6f/753NRPH11zrOD/dqNwCWsQLIJLQpN4QtMpatCdGVumDfJbC4p9c6ne1miXPTqBOMDTOF43unI5Ubgy8mxczzDSFRpglnrfuxGfdsFZ7FwUFqcu9Jr3iz1kCCpUhdv6HH7aNIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
 by SA0PR11MB4749.namprd11.prod.outlook.com (2603:10b6:806:9a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Fri, 7 Aug
 2026 08:50:59 +0000
Received: from PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707]) by PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707%5]) with mapi id 15.21.0292.018; Fri, 7 Aug 2026
 08:50:58 +0000
Date: Fri, 7 Aug 2026 16:50:48 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, K Prateek Nayak <kprateek.nayak@amd.com>, Charlie Jenkins
	<thecharlesjenkins@gmail.com>, <linux-arch@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [tip:locking/core] [futex]  b78b0b6582:
 kselftests.damon.sysfs_memcg_path_leak.sh.fail
Message-ID: <202608071053.6db6276e-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: s-nail v14.9.25
X-ClientProxiedBy: KL1PR02CA0023.apcprd02.prod.outlook.com
 (2603:1096:820:d::10) To PH0PR11MB5832.namprd11.prod.outlook.com
 (2603:10b6:510:141::7)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5832:EE_|SA0PR11MB4749:EE_
X-MS-Office365-Filtering-Correlation-Id: 920f1c2e-7434-44d7-d765-08def460ffad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|18002099003|10067099003|6133799003|56012099006|3023799007|11063799006;
X-Microsoft-Antispam-Message-Info: UHkGBw3WqjjpaGyktWebb2FbNIPaDuKjob38Urxh5slyUVguiNbNSS8qGPV6qO6cbywqVfq+K1mLx5Vv0kqNoUGZsrAzEDgUBJYlN63DKqRkbtaUfX7sBiUO73ne2nOPXIkK/UPEm3q3a9Ssi++Ny8zCsLCqBwAT6E5zu2c8JD9Txf9+jRWOz6kineJHj6CLynWRzkruHrZ1g8xbUQfSnwZMitVCEJGFwn7bhbezFyGsFUo7TlknxQmAnMcCMvIb2FXAG3HpmAcjpGQMFNGRNoboY/VnOGnWgG+NeYIzxKvq4QaSddSl0JX8591upXoVVjnh+e4KysJhvzYwm9sQ32WPmQUu5qMoK4zUWDJrYEZ/IXxaUnzYhtVjZQkHZRcFgYEqMzC/hNC9SaI6qGV0N9EeQX96Hm+iBTvj1gQEUX8dv2c03Z/adN8UJBc7YE5TJh9JCI+Hspndl8JXgclNGOT+c5NO6jTIxREFcES1Ah0Oq6Q2X2lxxVaeVt9RS1cFhiNRtyJjCJ+PDc7KaVaHt/ywaLdkH0FqzAxcG7zOx2UPHGMToMrNc8Bt1vjhdHwS1CIglQxklz502jnxVa3LbnPpxwjcqWGDWK0HAtxq7FAolPrGpHFUtmKYCmvyuEQMo2wTyuRAb7D0GLdo9Q3qR6AxScGNGJhcnU/SHrlGAHQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5832.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(18002099003)(10067099003)(6133799003)(56012099006)(3023799007)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yGMTbCyBZclOp16/lMklkc2gd5N+/bEYG1lvcTafDC56sXbvrSOEHrJCB1BB?=
 =?us-ascii?Q?j7wjoX+CcAg9KoYpZukpaE9HmwpSnIkF4WP0VEaAwvc7h0Tczk5exxCuXpws?=
 =?us-ascii?Q?nDsScJ5KvvK9c0WP+omTaFcXwB6jb9khhqMPuMnhcCep5M/LAfGQbTFN9BFI?=
 =?us-ascii?Q?hnNbuwNCkNuNJM2utgDXGmTxjUIFfsesesYlR/JJUR2owJtvNizuSabFo/kc?=
 =?us-ascii?Q?1NVa1D+2/KheUmuqH/ssdRVoNmB36Wm+8ki19f7KumRExgW/xKD998tTQtwa?=
 =?us-ascii?Q?cUckimxu8/cnUuvdKh1OcCWidQj+kA4mQP6OhEKlKNgEdsmC2mPvH5bhcfEB?=
 =?us-ascii?Q?WBJ5wUjygw6hodEyuisui9EzRiVtHdIhCfC1ATIVx0gRMLLCMfSoKkUcXZG6?=
 =?us-ascii?Q?7jTLhg0Ag5zJD+5jOewQniJNuKmLhLukCLYESuQ71Ax3NWF5Vh5xoOBAEuiz?=
 =?us-ascii?Q?IoqFwauzgs6glMzvwuy2Ep1C0T2pKitOirlO3HBmwrjmhKU3WrABqEX3SacR?=
 =?us-ascii?Q?ctnYjN/efLIQbzZar6uIMRG+MPsklzY3wwG/WKjG81353M+aoxHPdmEP4tgc?=
 =?us-ascii?Q?OUvcgkr2aK8NQoPPc6umpKjOGFHiXSVTHmIXz5rQtH83tb69mHV5nGY2tnfj?=
 =?us-ascii?Q?xWm/WU1E7qFhrVaTfo4wSRrTF2O/Tj+KD1EU9Hm/9LXDkOvPztCx9sy6uBl/?=
 =?us-ascii?Q?vsJgMe0H88RtoPllbDWDFRtHpgUGk46dHhhD29jV/Nq5VtMcD2hqznXIL4Ql?=
 =?us-ascii?Q?XVcuP7caU7fwyZJ7c3r1sA/PveWdZAEL7z9MadgNb7jBYkjqjVc3LWUDiW9P?=
 =?us-ascii?Q?MUzJrt52TbXkmXbbgTlrEhWDVl0T2ouFpRU9sRd73VVLv4zm9mxkHYeM+/+e?=
 =?us-ascii?Q?jMIRz/79rFg4xc7JHbzsgibtxysimIv/l2owxkm4QIdtE9y6fN1hxGSk02fY?=
 =?us-ascii?Q?J5va0MHL/sqc32zNRMwEwixPRhl9ETIP55EzUDzdNPQTfujx4399YZ4JTWxe?=
 =?us-ascii?Q?edBaEmYuPD4xLKVTROrOI9J2fjB3ep1CpyjsTAR/vXko4bNnvg0vwR/Y+Oc8?=
 =?us-ascii?Q?jvrZorRqHzGGo9hBK+aIBBF/oAOybPMzMlUS/LDv+WQNl67DBi7dY995AQjh?=
 =?us-ascii?Q?rf1VHX8ZVBRxmrMSHPVeWtrrT+Xs6+/bS01+MkAysbfDb7v97EnZBFxYzx6I?=
 =?us-ascii?Q?7iB/X/0j+0vQ455FMekGL7dAGeCJNCah02DZ8qxxso8Tay/QldYTCO39EDNP?=
 =?us-ascii?Q?pmx2mjVHYAUXPFy1t9PdcMHWeKsX1T4DAZrvMy+zK6grZllMYDwUiu1cX9XL?=
 =?us-ascii?Q?zFRaqoRyC+WhO5b1G7/CXeHOjyaEv5elkwvxGymgH4SqPPxWrikTiKOtxa1E?=
 =?us-ascii?Q?wp9puW5LdwI4XLryEQu2LKL1AZjc8AytltkLkSwB0XRo8U8Aainl88HBcPbx?=
 =?us-ascii?Q?j3K01nntvgaa/b/CqKnaAmoRB0HvJawOiLIORCrVK3CSLJYKv8agDW4gGijP?=
 =?us-ascii?Q?V+wN4N9U4+O6lP38TZyWuay4KRWunu5h/K7qjlnbh+VQd8jriLze+C1VW6Z+?=
 =?us-ascii?Q?9fCsFppRG1YwWrKfosmfTz+IIuD30nPynUD/xFOAfXyAW76yOWXc1fU/hDRk?=
 =?us-ascii?Q?MRwKDNFey1uaSlWSHhLzNVwYINRpaTdipTk+s++JBTFDUhFRyxuLUpetoeDf?=
 =?us-ascii?Q?9uLkLXAA6pILDHN00zMScBSdAfNLjvXrqrSeV1qUTH7G4ornWISwZx7OV7eC?=
 =?us-ascii?Q?Qa0ECiiDDg=3D=3D?=
X-Exchange-RoutingPolicyChecked: KPgiYZRWhHXo1zVYAIkwqhIWZI6MgN2kdaHB27s6IandFS9ogKay7uvoKdMSuZiscHY+gj/qIH6f7PytyYttZEGcRsV99kWGhYWp0hb9LDVuVf7F8+wodIDj3gR6HoSnWJ9rN8VJn0RAbpUF5lIgGisTkKObXkIRSaQG/gCYUNL/eO+WbsLwIaH5sYXkFbnMkJ3mnAOQsCVIoViewOuiIRYe4+hWDpSDwV4DMIIZY69JmdATGbGwTtz2UWugLVfAwIdbjLd9XhOiDimAtGQPuMI7mxMXU4A7/7pmxC5yjxyB6nFNSaHjKogWLCdGWdcNyDf6eDX3nBwDIGljwB/exg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 920f1c2e-7434-44d7-d765-08def460ffad
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5832.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 08:50:58.0729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SQ77VzpBJF0Esi30Ib1qIh7u1DCp42le7YUZF3aUh3Wvi1TMjQ5x5YKHE0GL5ZDIkxQN0noNjmyrqDKo6e4ogw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4749
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "kselftests.damon.sysfs_memcg_path_leak.sh.fail" on:

commit: b78b0b65825275f58336a43611a700de174be8c3 ("futex: Use runtime constants for __futex_hash() hot path")
https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git locking/core


in testcase: kselftests
version: kselftests-x86_64-f5098b6bae76-1_20260727
with following parameters:

	group: damon



config: x86_64-rhel-9.4-kselftests
compiler: gcc-14
test machine: 16 threads Intel(R) Core(TM) i7-13620H (Raptor Lake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202608071053.6db6276e-lkp@intel.com


# timeout set to 300
# selftests: damon: sysfs_memcg_path_leak.sh
# unreferenced object 0xffff8881029e0ab8 (size 8):
#   comm "swapper/0", pid 1, jiffies 4294668108
#   hex dump (first 8 bytes):
#     00 00 d0 02 81 88 ff ff                          ........
#   backtrace (crc 6c1bc6d6):
#     __kmalloc_noprof+0x56b/0x830
#     futex_init+0x108/0x3c0
#     do_one_initcall+0xc3/0x4b0
#     do_initcalls+0x215/0x240
#     kernel_init_freeable+0x4a1/0x530
#     kernel_init+0x18/0x180
#     ret_from_fork+0x547/0x870
#     ret_from_fork_asm+0x1a/0x30
not ok 13 selftests: damon: sysfs_memcg_path_leak.sh # exit=1



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260807/202608071053.6db6276e-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

