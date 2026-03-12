Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576C62FD1BF;
	Thu, 12 Mar 2026 08:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773302554; cv=fail; b=i0DPPc/KI04oWETd+oaCKLUL4/OKv1eGK8yf0PGnqW4bT28ExJHZyu8rIq8ehombOB9S4jQNf2AHGR4MtJvQ536Jbw7bt0lr8aPkHnL1J3BV5G8qEtlrfbtbBVbYiMvAaVu/OG0SWy34B2xGYoEbA1M4d0Jgw310r9qewfvSXOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773302554; c=relaxed/simple;
	bh=l4y1NkVHiHb+Ectg4ifHJ6vfH3t6dNNBYS3VyxaCq/k=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=S5vDKhLpheczih3OgxwrAmuCQo3jSeUE4p2YDm9P5kS6E772vpkOHVe16OLfHek+AojnonxKILQpXqD3/oTnyn+TeLEnouPTXDb3OYxQaE0bQNKZDyju1yNer20tSY1OjyRVuWKAW4ZmaUVbtCdSgWCLVHjckolzJADBw2q2ytI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F+4pvdBO; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F+4pvdBO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773302553; x=1804838553;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=l4y1NkVHiHb+Ectg4ifHJ6vfH3t6dNNBYS3VyxaCq/k=;
  b=F+4pvdBOXT+uXkwBo/Jebzvt/fAOQqk6EpCwaY/ZLI9XMM7UpwKxfn5x
   4RQcIo5YGZIi/mhK6mDIUTLrPS/hYKtXgoWfzb8ex7gxDUpsjWczyFAuh
   21sO7fUsrjbsj2YZd5srnsep6pBasOFxUFGRl2kv5RXWbEO8KKHubpjJo
   yCdemkpjKcHYkWe4FrKvXIxTPgSUGa9xY19AfEe++k8+DtgI4n29Gbj/8
   hzRdkyme9p+viD6maNryxQUAgG8LfJlIDwpt8NUDYmfO0sO4aVnGG7tjt
   hqor7VWp8zXrUn7YSPznJW3MG0TYq820j/XXuHvBLy+gGERKi04StIJhu
   g==;
X-CSE-ConnectionGUID: DTt9+g8JRFOQDn+5QmlHAA==
X-CSE-MsgGUID: c59Xq4E4S12UMWWJFIsm1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="74427114"
X-IronPort-AV: E=Sophos;i="6.23,115,1770624000"; 
   d="scan'208";a="74427114"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 01:02:32 -0700
X-CSE-ConnectionGUID: XD6eBZASQ1uJ13O7NpXt1A==
X-CSE-MsgGUID: hqdHRLjfSHqpk84IC4hXXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,115,1770624000"; 
   d="scan'208";a="220930121"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 01:02:31 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 12 Mar 2026 01:02:30 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 12 Mar 2026 01:02:30 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.46) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 12 Mar 2026 01:02:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DqXZlosUqW56wPQUepjT4czkm3G+LXmUdqr9MR8pqLAYq1JTc36w+YkIiDBS9zHO9HbPkfMiCIpQ7LIJTN9WIlWInT3hi4mOD+wMEyUtrsbOfJUl0qIrMh9tvv1/PETdSC5Pc1JaR9pdUvDNnVqtEVY15I9gXsKYTdNPEmSKJ2OWu2uxcf99L2Z8lc+jlNh14KYHko0Q12Qs4e1l3wwkECLznqw2EAc8zYFldSXMFnGQbqgj3Zn6Nad1IWdHPOx9Iwd8bm78XntueOmDFEBP/hFt5drXxuzTxIIhr5ghS3eixJeie8yT8fAOEdtp4GRGQO31z+unm5K2NddMfPjphQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JHWaEumjwGDUJjQpW+Gdt2EO8UMlvFLEXHU2kk74JjQ=;
 b=m5PawHoSvnJ4ma0xM0Sc66xdS5DBfU4/wXv43e6vysg7xGVU/Klygk+AuFPK7tpx9GyW1uEDYE7fB/dRSyP3sAOYIhrDSHd+ItKoTUw4elZox1b7DWOeGto4X3vOxmrBrWM5kaMoqDNqBm6n4JqspnDECe/fNKafIfluOzLZ4MIcnH4uoxBsKV1oRN8GEl5O/C33Fgk9gOKsUelWytDa2LdqstwlC1MEIbMSaGf1xIbKb7C3Ywy8PutgrcacDdrbqYZfPX6mB8oass+3xt/8CPS+cKultKna6mDZ/Dss5XGiCzjFKP7haLZs4JbfLg3NeTXSuomLps/AYAmfOW68lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5815.namprd11.prod.outlook.com (2603:10b6:a03:426::9)
 by PH7PR11MB7004.namprd11.prod.outlook.com (2603:10b6:510:20b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Thu, 12 Mar
 2026 08:02:28 +0000
Received: from SJ0PR11MB5815.namprd11.prod.outlook.com
 ([fe80::7c33:9702:ea7:13d7]) by SJ0PR11MB5815.namprd11.prod.outlook.com
 ([fe80::7c33:9702:ea7:13d7%6]) with mapi id 15.20.9723.000; Thu, 12 Mar 2026
 08:02:28 +0000
Date: Thu, 12 Mar 2026 16:02:20 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Tal Zussman <tz2294@columbia.edu>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, "David
 Hildenbrand" <david@redhat.com>, Rik van Riel <riel@surriel.com>,
	<linux-arch@vger.kernel.org>, <linux-mm@kvack.org>, <oliver.sang@intel.com>
Subject: [linus:master] [x86/mm/tlb/trace]  8b62e64e6d:
 BUG:soft_lockup-CPU##stuck_for#s![kworker##:#]
Message-ID: <202603121500.b3c3a3d8-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: s-nail v14.9.25
X-ClientProxiedBy: TP0P295CA0006.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:2::6)
 To SJ0PR11MB5815.namprd11.prod.outlook.com (2603:10b6:a03:426::9)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5815:EE_|PH7PR11MB7004:EE_
X-MS-Office365-Filtering-Correlation-Id: 021347ed-376f-4c96-4e83-08de800db418
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: CIvj/RGkEhIxYFL6F/vCA0kOTiU7u5ar01mMZLfj5tDHDzdFk4S0O5LflmYXG5crK/mL8XiKIjFM5Cj7d9+YBpr/c38rMbYoZ7YTtt+YebGZHuATKLDVRMxckofNV+7DHmoh+aP41Bo4MUTlgyRHXHC2w57++Sylf3TseWJpu9Dmraz34dQiX4jVJZeAkw6cb5k28BJKX48P4//Yzbws4zZ0eyPPb3HJOiXLXnk3f/LKTGMo67vZig5H2kP+/YsfEmlQe2+OXg0uJCnnDPZLhfsbTfvw9wsisTy7y4+LtbuVM2j9MpcCQk6ZUpPDQv5RPAdQvRBnDV7D3lVn2Gxk82peA2BTK/A05JlxwtJIhr0/f6bZ5i3aguiIQ8haUrQd5e6ytMfBjGHAjCAPcyOhtE/AYDZnX7Esf12DhpfSrGyHQDtQd9yTXt2+AqhB41tfHbLff1zxJff6/Ai/e7HaYKeXKi8otSCixQSVDB674StK5tBcsAITjKzfaaw+8tHdypApJbHlQnxqlAXfrtz4CEpDCFdhRpyrOahxEKp8/HgMwussElQgA5BF2LPisZ4mODYqqL+0y9VS9vcMv2EkvHFlohhsvuXgMVkoISXDZzPf7uUmVr14aNSjr+bY8T9XGE7YRtuG+M6mmwoxgVWBH6IfRNcDvnEMmIsh1hcV91o7yw4siq/VRC+8K4a/x5YIJjhT4Laz93lLq5R13JMRqQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5815.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cKqCbUsCBRMrk4DUDVNR2nTlmzdcS3II4rqDPlIBD23peIEqqBOY9RR4gy1p?=
 =?us-ascii?Q?0d9sPROPJRhGWrpCWM714H3wkx8PmAiVFSkP/sJALsV9yyZohYPdgoqtP2L6?=
 =?us-ascii?Q?YltvJFv9mJJFawPUVessISdnjGNhbfcW6SgP8b97yAnHRq3uxYzCMSy78rAX?=
 =?us-ascii?Q?ufYVaS5aI7ZKCsjrqDXCNRPl6xLuhjnlExw9fBzvVpS35+zSMe81iJMxJl8r?=
 =?us-ascii?Q?URVETMRUEW58M8R4x1kV+pq3NWlOGoYZoQr6KVWo1YewYMegfuEYqboD6MYn?=
 =?us-ascii?Q?y8bo60As0TsYuO4NXTXopbTvQ7hr6b5NkoEIhnk4hyFIMrTr35W7zV7wiv1+?=
 =?us-ascii?Q?n598chC6crgFIxs7sL4otTQfGkAnsYZQq8qd3HbqKqQN75aXNYLpqCUsASpP?=
 =?us-ascii?Q?UCJerlXGsZ7KnBzQyrrnu2zU5frkofaNxDA+PRw2nUGG8eCVPW8AZRxrckWS?=
 =?us-ascii?Q?+ijPBZa1wwBF8DUDyL6oAoIeTwtCJuNv8J426OnSF+eLvjE/BoC8ZaaLF86C?=
 =?us-ascii?Q?xdTZKzjDgJMEIp7/Mmt55hZUhe3IFyq/B/vACSH8Z+dev4uFoYUoa0BC6VoL?=
 =?us-ascii?Q?j1F1owfI4GGIm701ON2erm1Q8u5wfAKX9PHrTUq7WMijt6581pl4xlC707wH?=
 =?us-ascii?Q?018sKrojJkqVIp/nMUJVghGmcb40Zr10OO324957mCn05WxrMoZlmV7fCFBT?=
 =?us-ascii?Q?wsqtYqIuxqAOlTihZPLD2Ggt0QGnC9ZE14MWbeewC0N3PqJvVfNGjSaVNv8e?=
 =?us-ascii?Q?MLes+c5OgiZmxTwZFoVEiBWvNPvlCfoghgkpIshI0PHMDj8NX6wS71ZmI7e1?=
 =?us-ascii?Q?wB4EhespCyWy1B6A13fwI0sQnjzSCKv6SdinCH0Q/vWHbWYmHbFKM/YRNuNl?=
 =?us-ascii?Q?zPTA8XZ+Jb4cH0iUS0A1hBLP64rXU/NnJTf87b8PJ7smn9AlrG6aaEbLyTka?=
 =?us-ascii?Q?lrcZ3x6qYwz7hkSPnur/BiR8OJ4dIGlM64A8YoY1SyA6DbKNfCQU/GCO+0Ze?=
 =?us-ascii?Q?ozDbk540qywGANdeWSHI4FxaryzjGGfJ86Ku4keIa9DSpJPpJr4t01BS8rhs?=
 =?us-ascii?Q?MvfFeUYIj27kY7ZlvI18hjyCH7L6LoWGfuLn+Q6untoq33Tyz9Cki3LyRd2K?=
 =?us-ascii?Q?CZjsPOZd/KHuQzw3G2Zxu4Mbk/5yQZbWTNWKQDaVJaaNCBjYdbsk9Fpcqwyx?=
 =?us-ascii?Q?uNITUV7NUPWBiB6zB39aDo5PVBaDduyzh9Jv8V1cqD6D54blkZERiNchUmZj?=
 =?us-ascii?Q?tQy7fipdYQK88tO2ncmEKsUHMLxC/lOnFxETaKxGCVVQFwNGgCWRM3L3v/z/?=
 =?us-ascii?Q?DCGfF82gKSaz2FOZH92vbBcVj+/eQrV5HQhKJFDJaZ4XmAIobLd6pQ7OqvTw?=
 =?us-ascii?Q?W4k6ZoFZTvQei5B2u6ug13rUDUlE0ez6LU8x4eYQvSvaC5mYVrCky5wqrtIp?=
 =?us-ascii?Q?TXyUX97pHhnvsGKzSJRqTXk0r7SSD/Md+EK5YOaPEzf3R5iiiQItyD3GiR5C?=
 =?us-ascii?Q?3RLpuytQ+3MHjNJZMLYQ65mZOjw3cMfViCRgbvwgSZyB+4y8eZVJTnjq+A+n?=
 =?us-ascii?Q?eo1wajobGTfe/vwcmQGkKbTSPwKGddWkNXgKwEfxZhJpUdckvt+fOnEa4eL0?=
 =?us-ascii?Q?EqvUG0FlxjscKCb2yphcENAGrZ9IQdIpzbF6sEkIRvJPi4buSn5yib2PDGcP?=
 =?us-ascii?Q?J7BIYjo5hxHOhTvbA9Y3NFHT+TIjS6TsQ04HhzJ9hVaNrqFKychXL/ya3Y5c?=
 =?us-ascii?Q?iT1qodcB/w=3D=3D?=
X-Exchange-RoutingPolicyChecked: RqvhA/8yi+046NrHD9q4GdiVOI1OUTXIJo7cWUIEJaVpcTkf5PDQ07zIyaaqkpH6WAx7DZK2F7OAGzQiVKDuY7k/I3BwoVCXkvqyGM3/OYuo6z3OBSHODuGH49ZzWcDJtw1PSw8vyy/Kajfu1mSD9cSxpTl471UaRfFl98fxLZDIbEpMcpPqlIN/Grne1oWURr0BfYIfs9ilZ7I+KgwTryQf4dqzRXJiO5IWsrTTTXAlGKkj24GV8/COZuMON/yFaD+jHGlVFmeMJivt/XI5bUIduSuJWOB/J87lOqwNm8FCsVZCAlOlhtOfl4Pe5RzTP1FzlkXSzdVkxJEF7VX3aA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 021347ed-376f-4c96-4e83-08de800db418
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5815.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 08:02:27.9232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qc84Qp+/rKFCyiuPLSRnv9SsQ/nyTxZLIJZuQVb286jjQ48a9l21GoCSTmesz5dIq9Wia/xvu+ANPG5DzhCSEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7004
X-OriginatorOrg: intel.com



Hello,

we don't have enough knowledge to connect the issue with changes in 8b62e64e6d,
however, even after rebuilding kernel and rerun both 8b62e64e6d and its parent
up to 500 times, we still observe 8b62e64e6d show various issues especially
softlockup related, while parent keeps clean. so we still make out this report
FYI.


=========================================================================================
tbox_group/testcase/rootfs/kconfig/compiler/runtime/scale_type:
  vm-snb-i386/rcuscale/debian-11.1-i386-20220923.cgz/i386-randconfig-003-20260227/gcc-14/300s/rcu

043507144ae13d3b 8b62e64e6d30fa047b3aefb1a36
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :500          7%          33:500   dmesg.BUG:soft_lockup-CPU##stuck_for#s![kworker##:#]
           :500          0%           1:500   dmesg.BUG:soft_lockup-CPU##stuck_for#s![kworker:#:#]
           :500         16%          78:500   dmesg.BUG:soft_lockup-CPU##stuck_for#s![swapper:#]
           :500          0%           2:500   dmesg.EIP:_raw_spin_unlock_irqrestore
           :500          8%          41:500   dmesg.EIP:console_emit_next_record
           :500          0%           2:500   dmesg.EIP:finish_task_switch
           :500          1%           3:500   dmesg.EIP:ktime_get_coarse_real_ts64_mg
           :500          5%          25:500   dmesg.EIP:lock_acquire
           :500          4%          22:500   dmesg.EIP:lock_release
           :500          0%           1:500   dmesg.EIP:queue_delayed_work_on
           :500          0%           2:500   dmesg.EIP:queue_work_on
           :500          3%          14:500   dmesg.EIP:timekeeping_notify
           :500         22%         112:500   dmesg.Kernel_panic-not_syncing:softlockup:hung_tasks


kernel test robot noticed "BUG:soft_lockup-CPU##stuck_for#s![kworker##:#]" on:

commit: 8b62e64e6d30fa047b3aefb1a36e1f80c8acb3d2 ("x86/mm/tlb/trace: Export the TLB_REMOTE_WRONG_CPU enum in <trace/events/tlb.h>")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      1954c4f012206147c34acda8da04f827aa7d3ee3]
[test failed on linux-next/master a0ae2a256046c0c5d3778d1a194ff2e171f16e5f]

in testcase: rcuscale
version: 
with following parameters:

	runtime: 300s
	scale_type: rcu



config: i386-randconfig-003-20260227
compiler: gcc-14
test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202603121500.b3c3a3d8-lkp@intel.com



[  676.809255][    C0] watchdog: BUG: soft lockup - CPU#0 stuck for 626s! [kworker/u4:1:18]
[  676.809255][    C0] CPU#0 Utilization every 96000ms during lockup:
[  676.809255][    C0] 	#1:  27% system,	  0% softirq,	  0% hardirq,	  0% idle
[  676.809255][    C0] 	#2:  28% system,	  0% softirq,	  0% hardirq,	  0% idle
[  676.809255][    C0] 	#3:  29% system,	  0% softirq,	  0% hardirq,	  0% idle
[  676.809255][    C0] 	#4:  25% system,	  0% softirq,	  0% hardirq,	  0% idle
[  676.809255][    C0] 	#5:  29% system,	  0% softirq,	  0% hardirq,	  0% idle
[  676.809255][    C0] Modules linked in:
[  676.809255][    C0] irq event stamp: 776
[  676.809255][    C0] hardirqs last  enabled at (775): irqentry_exit (kernel/entry/common.c:229)
[  676.809255][    C0] hardirqs last disabled at (776): sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1056)
[  676.809255][    C0] softirqs last  enabled at (288): handle_softirqs (kernel/softirq.c:469 (discriminator 1) kernel/softirq.c:650 (discriminator 1))
[  676.809255][    C0] softirqs last disabled at (279): __do_softirq (kernel/softirq.c:657)
[  676.809255][    C0] CPU: 0 UID: 0 PID: 18 Comm: kworker/u4:1 Tainted: G                T   6.18.0-12697-g8b62e64e6d30 #1 VOLUNTARY  80d8d0334b0142a6d2ede86c263b0b8ef70fa3ec
[  676.809255][    C0] Tainted: [T]=RANDSTRUCT
[  676.809255][    C0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  676.809255][    C0] Workqueue: eval_map_wq tracer_init_tracefs_work_func
[  676.809255][    C0] EIP: lock_release (kernel/locking/lockdep.c:5893)
[  676.809255][    C0] Code: 44 89 da 89 f0 e8 b5 fc ff ff b8 ff ff ff ff 0f c1 05 e8 8c 7e 44 48 75 56 9c 58 f6 c4 02 75 3f 81 e7 00 02 00 00 74 01 fb 5b <5e> 5f 5d c3 90 ff 05 10 80 64 44 a1 dc 5d e9 44 85 c0 74 0c 8b 40
All code
========
   0:	44 89 da             	mov    %r11d,%edx
   3:	89 f0                	mov    %esi,%eax
   5:	e8 b5 fc ff ff       	call   0xfffffffffffffcbf
   a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   f:	0f c1 05 e8 8c 7e 44 	xadd   %eax,0x447e8ce8(%rip)        # 0x447e8cfe
  16:	48 75 56             	rex.W jne 0x6f
  19:	9c                   	pushf
  1a:	58                   	pop    %rax
  1b:	f6 c4 02             	test   $0x2,%ah
  1e:	75 3f                	jne    0x5f
  20:	81 e7 00 02 00 00    	and    $0x200,%edi
  26:	74 01                	je     0x29
  28:	fb                   	sti
  29:	5b                   	pop    %rbx
  2a:*	5e                   	pop    %rsi		<-- trapping instruction
  2b:	5f                   	pop    %rdi
  2c:	5d                   	pop    %rbp
  2d:	c3                   	ret
  2e:	90                   	nop
  2f:	ff 05 10 80 64 44    	incl   0x44648010(%rip)        # 0x44648045
  35:	a1 dc 5d e9 44 85 c0 	movabs 0xc74c08544e95ddc,%eax
  3c:	74 0c 
  3e:	8b                   	.byte 0x8b
  3f:	40                   	rex

Code starting with the faulting instruction
===========================================
   0:	5e                   	pop    %rsi
   1:	5f                   	pop    %rdi
   2:	5d                   	pop    %rbp
   3:	c3                   	ret
   4:	90                   	nop
   5:	ff 05 10 80 64 44    	incl   0x44648010(%rip)        # 0x4464801b
   b:	a1 dc 5d e9 44 85 c0 	movabs 0xc74c08544e95ddc,%eax
  12:	74 0c 
  14:	8b                   	.byte 0x8b
  15:	40                   	rex
[  676.809255][    C0] EAX: 00000047 EBX: 460083c0 ECX: 4651ede0 EDX: aadc23cd
[  676.809255][    C0] ESI: 460083d0 EDI: 00000200 EBP: 46513db4 ESP: 46513dac
[  676.809255][    C0] DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 EFLAGS: 00000206
[  676.809255][    C0] CR0: 80050033 CR2: ffd99000 CR3: 05284000 CR4: 00040690
[  676.809255][    C0] Call Trace:
[  676.809255][    C0]  ? _raw_spin_unlock (include/linux/spinlock_api_smp.h:142 kernel/locking/spinlock.c:186)
[  676.809255][    C0]  ? dput (fs/dcache.c:362)
[  676.809255][    C0]  ? dput (fs/dcache.c:929)
[  676.809255][    C0]  ? put_fs_context (fs/fs_context.c:516)
[  676.809255][    C0]  ? vfs_kern_mount (include/linux/err.h:78 (discriminator 2) fs/namespace.c:6045 (discriminator 2))
[  676.809255][    C0]  ? vfs_kern_mount (fs/namespace.c:1225)
[  676.809255][    C0]  ? simple_pin_fs (fs/libfs.c:1109)
[  676.809255][    C0]  ? tracefs_start_creating (fs/tracefs/inode.c:554)
[  676.809255][    C0]  ? tracefs_create_file (fs/tracefs/inode.c:645)
[  676.809255][    C0]  ? lock_acquire (include/trace/events/lock.h:24 (discriminator 5) include/trace/events/lock.h:24 (discriminator 5) kernel/locking/lockdep.c:5831 (discriminator 5))
[  676.809255][    C0]  ? process_one_work (kernel/workqueue.c:3233)
[  676.809255][    C0]  ? trace_create_file (kernel/trace/trace.c:9589)
[  676.809255][    C0]  ? local_clock (arch/x86/include/asm/preempt.h:85 (discriminator 15) kernel/sched/clock.c:319 (discriminator 15))
[  676.809255][    C0]  ? trace_create_file (kernel/trace/trace.c:9589)
[  676.809255][    C0]  ? event_trace_init (include/linux/mutex.h:253 kernel/trace/trace_events.c:4469 kernel/trace/trace_events.c:4630)
[  676.809255][    C0]  ? tracer_init_tracefs_work_func (kernel/trace/trace.c:10923)
[  676.809255][    C0]  ? process_one_work (arch/x86/include/asm/jump_label.h:37 include/trace/events/workqueue.h:110 kernel/workqueue.c:3262)
[  676.809255][    C0]  ? worker_thread (kernel/workqueue.c:3334 (discriminator 2) kernel/workqueue.c:3421 (discriminator 2))
[  676.809255][    C0]  ? kthread (kernel/kthread.c:463)
[  676.809255][    C0]  ? rescuer_thread (kernel/workqueue.c:3367)
[  676.809255][    C0]  ? kthread_complete_and_exit (kernel/kthread.c:412)
[  676.809255][    C0]  ? ret_from_fork (arch/x86/kernel/process.c:164)
[  676.809255][    C0]  ? kthread_complete_and_exit (kernel/kthread.c:412)
[  676.809255][    C0]  ? ret_from_fork_asm (arch/x86/entry/entry_32.S:737)
[  676.809255][    C0]  ? entry_INT80_32 (arch/x86/entry/entry_32.S:942)
[  676.809255][    C0] Kernel panic - not syncing: softlockup: hung tasks
[  676.809255][    C0] CPU: 0 UID: 0 PID: 18 Comm: kworker/u4:1 Tainted: G             L  T   6.18.0-12697-g8b62e64e6d30 #1 VOLUNTARY  80d8d0334b0142a6d2ede86c263b0b8ef70fa3ec
[  676.809255][    C0] Tainted: [L]=SOFTLOCKUP, [T]=RANDSTRUCT
[  676.809255][    C0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  676.809255][    C0] Workqueue: eval_map_wq tracer_init_tracefs_work_func
[  676.809255][    C0] Call Trace:
[  676.809255][    C0]  ? show_stack (arch/x86/kernel/dumpstack.c:338)
[  676.809255][    C0]  ? dump_stack_lvl (lib/dump_stack.c:122)
[  676.809255][    C0]  ? dump_stack (lib/dump_stack.c:130)
[  676.809255][    C0]  ? vpanic (kernel/panic.c:487)
[  676.809255][    C0]  ? panic (kernel/panic.c:365 kernel/panic.c:362)
[  676.809255][    C0]  ? watchdog_timer_fn.cold (kernel/watchdog.c:869)
[  676.809255][    C0]  ? softlockup_fn (kernel/watchdog.c:774)
[  676.809255][    C0]  ? __run_hrtimer+0xea/0x300
[  676.809255][    C0]  ? __hrtimer_run_queues+0x9d/0x100
[  676.809255][    C0]  ? hrtimer_run_queues (kernel/time/hrtimer.c:1999)
[  676.809255][    C0]  ? update_process_times (kernel/time/timer.c:2455 (discriminator 3) kernel/time/timer.c:2473 (discriminator 3))
[  676.809255][    C0]  ? tick_periodic+0x3b/0x140
[  676.809255][    C0]  ? tick_handle_periodic (kernel/time/tick-common.c:130)
[  676.809255][    C0]  ? vmware_sched_clock (arch/x86/kernel/apic/apic.c:1056)
[  676.809255][    C0]  ? __sysvec_apic_timer_interrupt (arch/x86/include/asm/trace/irq_vectors.h:40 (discriminator 4) arch/x86/include/asm/trace/irq_vectors.h:40 (discriminator 4) arch/x86/kernel/apic/apic.c:1063 (discriminator 4))
[  676.809255][    C0]  ? sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1056 (discriminator 2) arch/x86/kernel/apic/apic.c:1056 (discriminator 2))
[  676.809255][    C0]  ? handle_exception (arch/x86/entry/entry_32.S:1048)
[  676.809255][    C0]  ? dl_server_apply_params (kernel/sched/deadline.c:120 (discriminator 7) kernel/sched/deadline.c:1876 (discriminator 7))
[  676.809255][    C0]  ? __filename_parentat (fs/namei.c:2820 (discriminator 2))
[  676.809255][    C0]  ? vmware_sched_clock (arch/x86/kernel/apic/apic.c:1056)
[  676.809255][    C0]  ? lock_release (kernel/locking/lockdep.c:5893)
[  676.809255][    C0]  ? __filename_parentat (fs/namei.c:2820 (discriminator 2))
[  676.809255][    C0]  ? vmware_sched_clock (arch/x86/kernel/apic/apic.c:1056)
[  676.809255][    C0]  ? lock_release (kernel/locking/lockdep.c:5893)
[  676.809255][    C0]  ? _raw_spin_unlock (include/linux/spinlock_api_smp.h:142 kernel/locking/spinlock.c:186)
[  676.809255][    C0]  ? dput (fs/dcache.c:362)
[  676.809255][    C0]  ? dput (fs/dcache.c:929)
[  676.809255][    C0]  ? put_fs_context (fs/fs_context.c:516)
[  676.809255][    C0]  ? vfs_kern_mount (include/linux/err.h:78 (discriminator 2) fs/namespace.c:6045 (discriminator 2))
[  676.809255][    C0]  ? vfs_kern_mount (fs/namespace.c:1225)
[  676.809255][    C0]  ? simple_pin_fs (fs/libfs.c:1109)
[  676.809255][    C0]  ? tracefs_start_creating (fs/tracefs/inode.c:554)
[  676.809255][    C0]  ? tracefs_create_file (fs/tracefs/inode.c:645)
[  676.809255][    C0]  ? lock_acquire (include/trace/events/lock.h:24 (discriminator 5) include/trace/events/lock.h:24 (discriminator 5) kernel/locking/lockdep.c:5831 (discriminator 5))
[  676.809255][    C0]  ? process_one_work (kernel/workqueue.c:3233)
[  676.809255][    C0]  ? trace_create_file (kernel/trace/trace.c:9589)
[  676.809255][    C0]  ? local_clock (arch/x86/include/asm/preempt.h:85 (discriminator 15) kernel/sched/clock.c:319 (discriminator 15))
[  676.809255][    C0]  ? trace_create_file (kernel/trace/trace.c:9589)
[  676.809255][    C0]  ? event_trace_init (include/linux/mutex.h:253 kernel/trace/trace_events.c:4469 kernel/trace/trace_events.c:4630)
[  676.809255][    C0]  ? tracer_init_tracefs_work_func (kernel/trace/trace.c:10923)
[  676.809255][    C0]  ? process_one_work (arch/x86/include/asm/jump_label.h:37 include/trace/events/workqueue.h:110 kernel/workqueue.c:3262)
[  676.809255][    C0]  ? worker_thread (kernel/workqueue.c:3334 (discriminator 2) kernel/workqueue.c:3421 (discriminator 2))
[  676.809255][    C0]  ? kthread (kernel/kthread.c:463)
[  676.809255][    C0]  ? rescuer_thread (kernel/workqueue.c:3367)
[  676.809255][    C0]  ? kthread_complete_and_exit (kernel/kthread.c:412)
[  676.809255][    C0]  ? ret_from_fork (arch/x86/kernel/process.c:164)
[  676.809255][    C0]  ? kthread_complete_and_exit (kernel/kthread.c:412)
[  676.809255][    C0]  ? ret_from_fork_asm (arch/x86/entry/entry_32.S:737)
[  676.809255][    C0]  ? entry_INT80_32 (arch/x86/entry/entry_32.S:942)




The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260312/202603121500.b3c3a3d8-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

