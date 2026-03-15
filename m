Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599F81A681F;
	Sun, 15 Mar 2026 14:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773585359; cv=fail; b=d1JChxrlltJukhd72UjBxrt/uf1GfguAyfVlTqxaro9xcrAFCaQYW6YD1GCuu/gR96/w6mlGOdiinOOgVK/5sGvKDubSSJamT1wUdQFW2S5ovrQWvjS+S6bXhpJrS7pvBndEO4hPDXL2kAPeb32CmkRMm09u+zcY3P6fSWKAQms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773585359; c=relaxed/simple;
	bh=zzljNI9S/95a24Mx3DPQma7dO8TMVfRLGlrBhKZo7CU=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pmZTpuyFN8Tc0qKKC3nne0aWQE8chQCw6945S0YBzbLg8IPJPrGgG5wAifNS4W/e68vcCdkitU8pTFCjzHqe1rQDoK/VO46Ai2ifYR1bRJCvkQOQmVYRlUnp+PFq/ezTB4jdjVEvg7aiurd0RAkPNE8I89c+bWzWokaQwOzqXtY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lucahrjg; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lucahrjg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773585358; x=1805121358;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=zzljNI9S/95a24Mx3DPQma7dO8TMVfRLGlrBhKZo7CU=;
  b=lucahrjgHc+fovJPqou9UtGCtnYWIe4FcGvcq9eWBco4QIe6rmV0Ag9/
   86jpsCXPYsRCsuwp9zmu/tV62LKbguBzpnl6u+hBo3iM1/S3mJvF7bazU
   J2Ebfl1eNiXYFk4kGSV+mnY5+XXDsDZRlizLtvySNiEe8P7EVBmLuv6kf
   k4wLrNB6yWKXxVq20bdaOD6OevyU1V3x1UohPr5jVHN7Uvh89lw8UjJal
   N6hF/+DPcGEW8CXLtlrYZjZOj7Dw1d2AC8yRNchcdAdBGIuEFR+eg3blF
   go4Eb4JgRFYkU2eqVD/TY9+QWPFSn3ONBmPwxmqupN7qFny+dQ+iG6a7G
   g==;
X-CSE-ConnectionGUID: cNCp78ttSBGd6E6Zp4zFFg==
X-CSE-MsgGUID: nOX60sYrSFqhti9UZSBR3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="92003554"
X-IronPort-AV: E=Sophos;i="6.23,122,1770624000"; 
   d="scan'208";a="92003554"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2026 07:35:57 -0700
X-CSE-ConnectionGUID: Dsoz3eN9SXqCRmR8YrMGrQ==
X-CSE-MsgGUID: F9yEC0b6RB6bA/YIdc5cHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,122,1770624000"; 
   d="scan'208";a="218913572"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2026 07:35:56 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 15 Mar 2026 07:35:55 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 15 Mar 2026 07:35:55 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.67) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 15 Mar 2026 07:35:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dF7i8xYqG28Kjd72S8hvP5vnOczZTVf4YrMPZB6bpdAPnCh4MJhAqcu7MEG76N1+7Ono6HEsfRJTYP8gS1gXUNSpQ25+XzBBQgxifCVXgHYjEnhtUoIdt9LzKFl1kHRwHeMjtHKF3y0gevfIUb0PDMQ64MRYsPprSwEMv0LdvWzqIdri4bw+DAi5P8vslsgQh2ffdlBVeWRJf1a3hgKHZ8MlM8Cv+kiQEfosvvJps04+TDdbhRrKmQv9CW1BwcAO2LVmiZrX8elQDqLcGnh8g31LvIUJ2d+Xbslli13+1YcuF0EBXT0Lh9jTObyZVgGwJsoRz6hjwHK43Pp3NI49WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7bU8rbVZek8vcVjHdJmhrGsMuimtYoHZ+gaTH15MlzU=;
 b=kmxwKZpVmzVVL9Cn24foARqjOWZbHyRnHXDKrLYRTViOdU2w+lY7hAkxZgtYrUGvpK53ZzIB38k8PrlNyHUq5GxqWnVxRl/lGqD+ZTmEFZFDBbkTwgLkj1j9wGjEst6bYMOSGqQGTrGu8HyhUsmy9wsBwygGqOZzaIDrtYDOv1DyNkcSyUmg0Ir+U6BRfvZls2f0DPaLWv0afWLGO3NzFrhsEwO9fKL3NXAzCTSkyMzCLRBOeHn5ifXuiev1m9RPJNPNUWhJmsHQAuob2Segb90gWBg2uvcqm0UoVlohmZxD3BnMw5w/iEKJNBnqKIZNPqNVNS7eDtlVwmUUfJ7CYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7710.namprd11.prod.outlook.com (2603:10b6:510:298::9)
 by CO1PR11MB4801.namprd11.prod.outlook.com (2603:10b6:303:9c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.8; Sun, 15 Mar
 2026 14:35:52 +0000
Received: from PH0PR11MB7710.namprd11.prod.outlook.com
 ([fe80::dc6:ac78:d884:137b]) by PH0PR11MB7710.namprd11.prod.outlook.com
 ([fe80::dc6:ac78:d884:137b%5]) with mapi id 15.20.9723.006; Sun, 15 Mar 2026
 14:35:52 +0000
Date: Sun, 15 Mar 2026 22:35:42 +0800
From: kernel test robot <lkp@intel.com>
To: Mathura_Kumar <academic1mathura@gmail.com>, <brauner@kernel.org>
CC: <oe-kbuild-all@lists.linux.dev>, <academic1mathura@gmail.com>,
	<linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v1 1/4] IPC: Added New system call do_mq_timedreceive2()
 for non-destructive peek on posix mqueue
Message-ID: <abbDvhs8cyLSRpHm@rli9-mobl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260315040827.156558-2-academic1mathura@gmail.com>
X-ClientProxiedBy: SG2PR04CA0164.apcprd04.prod.outlook.com (2603:1096:4::26)
 To PH0PR11MB7710.namprd11.prod.outlook.com (2603:10b6:510:298::9)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7710:EE_|CO1PR11MB4801:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d40c8f3-2697-4393-a318-08de82a0284f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: dKm64kGWixv+QmmY/AEV7alpwsIcrQf+VUl7pXIUgwWwDdm6ydNDaY3FpY/nFBkGRNu+70ttR/k8OQ8D3oNQyPUjr6KJAbGBg6mxcbtaQOSziEmaLxR4ZP5b7zAhHGFqB2XdTxrg8gHE1YiAcnliU9UnnWFrSv3wWBC4IGSXvNvSb5d1iYqeZdQIVA2dQK6vvbUX6E84AzU7B7IWvXXSBhHWxHPcd00gGwmJZjIzLwglG+UMJd4gNuGZnHzU3kzMX+JXn3ZJf+aESWoe4QldHSIpkna6ye7ZUoZ9v7xlArcb7oWyyHdRJg59wV5IefIIW2Oxyd1f4psU0iy9hwk6hRiduO8E4FpG63iV4uJjx4L4YoRcFufSFFBfOpBx0SNrV3li7X0wKCU+823+k1EoqHJ6kGC2FuBpFQhMAZuwQPr0HeypaCppyxWHmNfsaL2/OnfcWx4KUL9f1mPDkM+VL3uIoDOpGoD9nc6Mva/A3lsFhg/HmobBFsJ++VJsvrRFuuB6zbaJp7HlpuOIVSAr+ZHlmSP5uMUX50d/H8VzGtCGPZ8Jw9/thztLvZoJnTTVIqTconzu46XW6IwmJx0t2IQEatzOnlTlRuIKT4pKCxMoMYznKrf6l8mc2OsK1eP/Grllb9JdfLypMFly/MUHxx0lxUMMEpVAV5tO6Lke6sIUT11xU4nvJN18PS8vXtZ+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7710.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kDCUR7dHbRENxwLSshPDajS7k9XNGsIbdaxP/NhRcII4mR7RW6RinAuAKUhW?=
 =?us-ascii?Q?6v0p5Fse2rXl2DAShLQ3H11oOx5pMt3/0f8kqBC0VMqBrDKzcaQSieylknEF?=
 =?us-ascii?Q?W9o/Y/sQMwhBi3InuFWJcg+mSuoehjUfvNMKKOOD1KXzEGZja/qKe6sKhHRu?=
 =?us-ascii?Q?F4SuRqCvGTcdsD2XwdLGLYODmI3GrCxje4g9lqzdsY9CvAG/zQV2xA3h551N?=
 =?us-ascii?Q?se8WCIHQpxnmUaMBu1QpLUKNgjk63PCoHwn32JiyJJVW/g5kTycmgRTMcxiQ?=
 =?us-ascii?Q?bu1qVc+n6BF0b1Ce0wNWsqW4GNUXjrVloA6/o/WSDWU+IVV3OXF0w/tJ+IqY?=
 =?us-ascii?Q?jmuYoBNRev6GnzGqr+TyWf4GfHfHDzJ2is6w64JVxOEWzL/ZvAn7Ci6zyoSk?=
 =?us-ascii?Q?Y7YAUw7MqibpzeQ/s5iD8t7+kLdFddEk4nEyRCcr5ZsyY9NsvYwIdyTD7kZq?=
 =?us-ascii?Q?IcnArUKn4wMsqq/vgqFq83c+xZJVFuwCtshLqMwAOKisHoPcND3W8Lj7N7eA?=
 =?us-ascii?Q?3+RM13zn0I368MxoqzkUGon3I9y1ghB2ymcwq9+wTswVDbTAR6fbuf3xphCa?=
 =?us-ascii?Q?Zv7TqMvjzKoPycELIk7Oj8MK4k18y9E7uVn4Apa8lyKJB5I5T9xwXn4UuG3j?=
 =?us-ascii?Q?DYsODO1Lmnq58WXh891PDSDSXGhcl4pf376oQcmoH3/5XZ7/h32XSPzgpdvO?=
 =?us-ascii?Q?OzzcKN0W6Yjd1sRh02kPonMEt+fUjRPTsKV+0kUD7HnpJsspK++p6OCUF9PI?=
 =?us-ascii?Q?MkKjHg+P9VYJpvnidrNuBO27MJRgwpIwPNXzDdLsBYGTo9awMEDOZLAIOIPc?=
 =?us-ascii?Q?gtXPdOrGZpAYxiH7sWPpB0ldzVLFhPFEUvnNqly5sO38cit1o1X5TBg0CC+9?=
 =?us-ascii?Q?pIi7dLqya3k9wlvgmCEFnBSpukoVOF6pynDVSYr2ug+rZy5LFOe5NxlpbxM8?=
 =?us-ascii?Q?cyxsX3c5/NvZP3wr2nEqijanZwg+0tIlnHbY3QwwCcgwHodO7eNVynn3Fsad?=
 =?us-ascii?Q?j8A3xZhBv8nn7Mn42OITwKfd4YItIDt49bg6DJVHPRsPa1B3J7vWbuJEx7Xa?=
 =?us-ascii?Q?NyIFBO8vFls8Ncs8JWwbmnuoT6ANvHVPonR/Ig7aqqD08OtcGSclfQXnLGfY?=
 =?us-ascii?Q?FPW8YFgpoBVNa2X86qTEMx8gB9LD2NzJqmhFqqh89kpVSs6ToaLQlTHbw1bR?=
 =?us-ascii?Q?RYr3K1zVL7/l+LvqzgKOejg30jLiigt8SeFxgeFHGpq9crUHJHOHNLM/RDD5?=
 =?us-ascii?Q?IpqJzcGFr7RYPuXWmBVCujZeFMX2+MU1uNcEnW8L54AkeB5L9BruLqjypbqG?=
 =?us-ascii?Q?IFBJgBO2f79voqAz8Ywr6tXJ/vrfKOzOw3Zce3Ep7q4WdsQ0RhSilxUwYF3v?=
 =?us-ascii?Q?B8g9A/u8j66KmhDEh+wLITP4JqGxE34uvU6oA/pRp2LASYN5SWn+ZC8FP7qA?=
 =?us-ascii?Q?yejuCev7l2T10HgBNwj/PQlVBhIoY7H1l/GMXdaLMwrVv8xSo4bYXXh2YOYR?=
 =?us-ascii?Q?QZIIOucR6h4NAVGmu2P3jQDtpCu60kUe0Kxo01/ElW4kL/HkX5fXZbrSkWMp?=
 =?us-ascii?Q?EBBgBXbM7ijSJG+LPe50JrSue2H5pNR3AhwGhE/Az3UWIKqgtjcPKt+higkC?=
 =?us-ascii?Q?+9FXZhrFeE5tjgJr64zNn8bGtgnXYy9zCCYj8PG5TJeT8LCdbIULLWiEggRo?=
 =?us-ascii?Q?wDmyPhah/fJPCD7aRx9n76jNeg2GGbwGAEXAGlTmFxSpwUnjjh+6FzaI9pDO?=
 =?us-ascii?Q?b5qsGnp7ig=3D=3D?=
X-Exchange-RoutingPolicyChecked: Uan89ENXYDPvyqQ81qfV3IlTTmqyqzTLDO9VOVIAJdHNPWkova8WPip5gu8arlOD9be+U+egzjuwb5wwj5g53PRdezC4plpcHWye/fWpz+Lz5fCxpcbQ0LuBjMzqCsg7IFq0FCRcJtlKCmF56Mk4IWTLrXYP508dIdxr8rScXlHbcffXfCl5rWGd0fGDPBz+6v49bwRkl9YXTZNlMEDGtYF2Bjyo0Xbz1+evAB0NlrKUERr5132wXW1lneA9nk6TeWsMiOx/kw1LTRZYRMLyaRs3LDJb3GVOjDJbee+15d35lQ5KT2/Lspnqd9JkUmmD4cSwXMw7XifZwjJQz1UBBQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d40c8f3-2697-4393-a318-08de82a0284f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7710.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2026 14:35:51.8883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JvsanxZIgntyujnntZ362xRFyaXeGCNH0aZwNzufGupaB6wTFF+azdhB+rjqYGsm8/Qn8K83ZEjpaedeRDTyDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4801
X-OriginatorOrg: intel.com

Hi Mathura_Kumar,

kernel test robot noticed the following build errors:

[auto build test ERROR on perf-tools-next/perf-tools-next]
[also build test ERROR on tip/perf/core perf-tools/perf-tools linus/master v7.0-rc3 next-20260313]
[cannot apply to acme/perf/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mathura_Kumar/IPC-Added-New-system-call-do_mq_timedreceive2-for-non-destructive-peek-on-posix-mqueue/20260315-143134
base:   https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git perf-tools-next
patch link:    https://lore.kernel.org/r/20260315040827.156558-2-academic1mathura%40gmail.com
patch subject: [PATCH v1 1/4] IPC: Added New system call do_mq_timedreceive2() for non-destructive peek on posix mqueue
config: powerpc64-allnoconfig-bpf (https://download.01.org/0day-ci/archive/20260315/202603150853.00qBX9c6-lkp@intel.com/config)
compiler: powerpc64-linux-gnu-gcc (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260315/202603150853.00qBX9c6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/r/202603150853.00qBX9c6-lkp@intel.com/

All errors (new ones prefixed by >>):

>> error: include/uapi/linux/mqueue.h: leak CONFIG_COMPAT to user-space

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

