Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E511E487;
	Thu, 19 Mar 2026 08:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773907230; cv=fail; b=CU6RLr3jBGkKJj7xhbqu88HdYYUk8vW/sibcRfjYaEh8dUBiEfFE3KQsRYRUMIEFL2rCSxoi+mtNVoo9iAqj0yfq5nYENQ4eJMt8NnT22Opb1sURcBBKXdKmrnS1j0tPc8UKBbaWrOdv/eKKB+ZaFPewwT5wdNnJEQ2aAE7vdTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773907230; c=relaxed/simple;
	bh=wKIzynjz+nkjeWBdmWzseTBfWrMFfTn6PWoxBk0vnVg=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=RGfT4BrGSjQjv9TH5W68UbVz6EZZ1ij6XJiTS4l+kdFmscvYBywKwPJ9RWGFey9v9jFRobszEpvJ9tF8xaOM2GWc9MM/0zBFitpllkKGGaVB/Km8fx3UDCaH3lD21AO50WoIyspQVxqV7/iV/CpEFCMfVL8SvQmFf/yVwLGQ3GE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TCj9XwEl; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TCj9XwEl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773907228; x=1805443228;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wKIzynjz+nkjeWBdmWzseTBfWrMFfTn6PWoxBk0vnVg=;
  b=TCj9XwEl5jgfzAzKENAczrdzpHY8it2arz+IVFbpni8V716o7e06JKn4
   36/HgBlIQQ32Ygi5ChOfprU5/sGQLW+p4ipBAGDdBqoYLZHB135ItWv+L
   tlrwdFKybblL3UqXciI4kIrzszbRUXvaRUWgmqGRjgkQUWzwknsZJ0Sc4
   quGhqr4hSk8efpETVwTQx22ylCfbnMJ99/gjafg/emAlFgP4z6jKhQ72h
   PPQDwSqS30tpD6GPKqWkwQE8qU0V/fXs31mT8gA9FaygcFvCIzkRhh7nQ
   Z6MK3GXhi4OlCnVx+93pHKhFDPKPuqAv696i1Vza/Jg34rl6clM03T0Ro
   w==;
X-CSE-ConnectionGUID: 5VQKjjP5Rzq40XlbT6f1DA==
X-CSE-MsgGUID: vvxW+NfmQH2JplM2Q7LflQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="75006100"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="75006100"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 01:00:28 -0700
X-CSE-ConnectionGUID: l8tgXa9pQZmx4xBz+BhsJA==
X-CSE-MsgGUID: Z4xISxEATeeWmqCw/LXWQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="224906014"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 01:00:27 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 19 Mar 2026 01:00:26 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 19 Mar 2026 01:00:26 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.27) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 19 Mar 2026 01:00:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ed+SvOeOw9ShYFBzC+uqO7egwQKjw2BGsKtj4FpZAvHij+1YNWCEHQufTfq67Zbus0ru7osVdt66PjMYjUwCDwLJkf5p6j/Hlql5GTStNYrlSPS9sgAIWCdWfsIXIaIgns2ZPTXChTnncicE1Dc1lORwkUDhdmdrO/k4qWv8qx5csa51vXc0JoGPUg1g3L0zq/MI/Zdy5WvAxlnSG6MTd1tzXbAbi2CcK8x0+1md9wbq0GBSBAuZVdV8QK8iESQh621E66mJImSDUzCoyB79MqimQ+aOMm4kB5ri4maOA2MRIROzBjX6Dwzt0CpPyNaZRDVswYi52odKXNXV1QfDCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gScC7mso8XSIsJ8UKnd1zQLlyjoapNUNoqW9G8eMKrM=;
 b=lOvbNVQ7Ltjpss1jiTZCirNxYo1KV++H1bYM82xylNSJt9bmUlx8zl0MAXQbbfXnsZI/9v+QHmK1ql5O7GA9EPzadwKVf8Umr0r/pdliCcN+MLuou9hynUuQ6i2elKWUCb8qFOZq2FG4CsL0DHf8g4CF48lt7n2yxoXbjJY8R89VQi3NA1YoQxVeS/1S2FGj/KiaeDaBAcTImDI+hSylBlgYivgvxwhQL48vs1ITua1i5wzMyS9BzJKen3ddL7nMfoKhJp49QRUfcwCq5X8Ckgy22fHXGrVGgq3YZEbqyBBMJeVmJor7L3eccu0Z3Jsg5zPOmY/2TJMRBLaFVwgjoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
 by PH0PR11MB5077.namprd11.prod.outlook.com (2603:10b6:510:3b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 08:00:23 +0000
Received: from PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707]) by PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707%3]) with mapi id 15.20.9745.007; Thu, 19 Mar 2026
 08:00:23 +0000
Date: Thu, 19 Mar 2026 16:00:16 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Ard Biesheuvel <ardb@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <linux-input@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [ardb:x86-pie-v4-wip] [x86]  fa65278b9b:
 kunit.VCAP_API_DebugFS_Testsuite.vcap_api_show_admin_raw_test.fail
Message-ID: <202603191529.cfc2cbbe-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: s-nail v14.9.25
X-ClientProxiedBy: TP0P295CA0020.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:5::10) To PH0PR11MB5832.namprd11.prod.outlook.com
 (2603:10b6:510:141::7)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5832:EE_|PH0PR11MB5077:EE_
X-MS-Office365-Filtering-Correlation-Id: e1f9399c-88a4-460d-d71a-08de858d9258
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: Fqd0m7fsvTE0w1K1cdZyOMhNrDLLcLQ3pYw9CVauP5AQ4e21c5m4Hu9ynWl0JdmJPq4r+z4DuLWzVEAmo/7RvvHHJFkYELDocUlDtYuVpMcfgzWsHC4F4VtGTH7bhB+aJ4v4CSjOlDvmmx7tboTU8KJ4xDUr4aC4xo8HqSB3L6OLj+SNpp1v/ZnurOA/9jwXJ1FNsXlt7ds2/3OKxbCQcAeWz56igckUJ9TvFbYXEzdVXFUXickrSofV710skcbTLHImVFJSnf9UvK0IPZQU5eNyakvl2jnWgwb8hEjtrcbQRI9PcoS4DAl9/7iizp3ORUZ646U9f2KP/ZhpTdW/Go/4Jt22Cl1M/Vzh9h0KwDO8jSwM/1S5ArasTOWV4kU4NMNdZ9ZFh7QSb3vq43IJGfoy6XEg2WgNvIerluyrJROL0xN9XSkjvAra6hEvvh6YS8uWhfxKYYyj2giRTnsWtSjh0GB2EOzYMGbvbrqz9MgNmZBT2qly0L/kY4Dkjxg+Llu6o9gU8/TtRupG4QRxVs3lsWLqZ05DHKdTA5r2tNd1iBeTksBkOHNhqM78F3j1cFOSqp7V2fcJXNh4+PveIMTPj5Py5Z1bYlmL8fjrXBNqd8UypD7o9JQoGmhklwnOTMDJt5Rb2EZ+BTMXD80YEa8orina/gOrI3jb3mQeEgXzN0ugkJ2HdN2QpH+V/zgH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5832.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2K25w8D0ZCJ4Lfqpioit7ioeo0dwO7K251IvkkXnsNyTO3Az4HvByASVx09V?=
 =?us-ascii?Q?mUjzpIV/QMLqPu0hlZqRHErq8YsiPsXnjQbN05DdMLsEZFqLw7g9VhINch/m?=
 =?us-ascii?Q?+x8jXfCeItY1PnDQGlQzeMKqHfZt8vhxjVTNI57lt6od46ENxx2aLPneNXoY?=
 =?us-ascii?Q?hcgRVSQkOXf91TWizOw5EizakaXW28LmoNY1VGggxoXNq1lPxX9F0qeY87nO?=
 =?us-ascii?Q?FHMYitIGGJHFLroBdUUWCgp+YMcAWF/2ShUflf5EISAYOinhp5PTdt1SQSHi?=
 =?us-ascii?Q?xd1DzQD3fZb/TZK4n7l+trI+WcnXv8RhNBJ8uHuP1IkZ7oSJgUqFYKWGuMxh?=
 =?us-ascii?Q?ftHdSVyDVrw3iKdiBF+V7D/oQS/nIE4UHaE6fNToGqmaRtT0VF/AIxxrdEBw?=
 =?us-ascii?Q?KvEciah0a+uaZNFPYQnzMcRjwl7A3W/xw/Gz678moOUj1Dmm/k9XCq81oicW?=
 =?us-ascii?Q?39M/uUCNBdIgBhIg/0YxM6dSo3c4uZ77dg72zaIjs/5PaNuzL0ogYdJGAQFh?=
 =?us-ascii?Q?axvhrRohT+4y5Bgu5EiezXW4eqdHAgpbK9uXUYuLqh3GkC1Da5//z6Dgvt+y?=
 =?us-ascii?Q?az6Y+LnQwbbM0z0bPDkTL8liARVd4CruYvQg38R28nhgdbOdTEE4cCup+08+?=
 =?us-ascii?Q?ibkQ+dNxGfGBkiskPpf18RA7U3ezSW2+Rh47M4gdm3m9azvWB5uY/vIpBXP3?=
 =?us-ascii?Q?3Wg69Os9Po2sdvRFjw6KP1UKLyJyc/z1wfeO+mRglgCZNR6lPGRaG564OhqR?=
 =?us-ascii?Q?rJjOkNJTaFrz4gZay/7qjqyJ3oqpOjwTmdW702KMIIGFcLzJbbD1H4/EELjQ?=
 =?us-ascii?Q?D8eCnP3ItcDde8+eIwX93RWWaSKMc/BmRPicFHYacZGBmFp5BdDmF1x/v2ht?=
 =?us-ascii?Q?9YMKHMwKOzqH/1y7doXJeTumVKaTA5//quhedAJQVVC8TrhpH95eikJb9X6D?=
 =?us-ascii?Q?eG6LlrdumvIZISfjEma4kj4NLF1gW8h9O/jpwg6Yp802/seLSTujXnE0ciZe?=
 =?us-ascii?Q?mDmcdmrvFwaOYFqBL9TilV60uJhEMGVVYGlKXiez9OaCJEXQMTr0THtmGKb+?=
 =?us-ascii?Q?fB+D4qwxZzPqR/KBxYrIg17QECZ3a0RxVJOGajXVV+9Npks1yWdOpzAncjm1?=
 =?us-ascii?Q?rbs7qFNpQ4eW9qI7A0+j55KO10Qf9Wb2zfO+JBDMTAGUe1f3T+4g2+3JnkzN?=
 =?us-ascii?Q?LZ0NJYzKfGjlb0/qdFzz+xY3mdmdO2T0WwgfuJM+ARvhrghD9v+CvXM/AqBV?=
 =?us-ascii?Q?DTq5UD8OUQG4AN1EsgkDGj1m+K2NzmtNA5z5NQwLzW7Csv95PmhK3DG91bTX?=
 =?us-ascii?Q?pKGfxMFW0Kz7mODN7TKH9ea1VHIP1Flp8haq3xtS9cYSV1WHSe0BgYqd3e+7?=
 =?us-ascii?Q?DJD2V7+sGayVJA3vp0Op155gNSzBP7nlDQbWRdGyw4yVcmP6P3n6L6jPfVdT?=
 =?us-ascii?Q?1pRD04NRMfVjPIYn64L26A2ke3MREMQC6i/AXw8+lvKc/Fq01YVWJTLjZ6ms?=
 =?us-ascii?Q?rOEzE46++pnY4adboy7F59Pd2E1Onbi2b6clVCzUL+RsxvZIxWB05RPFVqc+?=
 =?us-ascii?Q?WkPxeC0Ow7QeVV5wuxY9A52/s+i4I4A/qDOZlXyU1lI+cF2M8Up8g/+ISYxk?=
 =?us-ascii?Q?SgL0HogGH2mRfQh7fodh5cnvhU6UcftCf81gHQPxxTOqRk2x4DV8dvwtY+rL?=
 =?us-ascii?Q?sO+cXqOeNvfVJC49V6dorUVaWZFT48D6uJ6jJvIQsuisVbiHFJdVuzEEClHC?=
 =?us-ascii?Q?amv3EXeLzQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: ZdSKQlY/1rady9axrJMTzpMM4+XEfjvyQszCuI3UK1RXp3xlExdkCT7CBIzKCuxg3v0xNtuedjGP8J4UBG10J9vTfufoMbrISB2hik3QZ4xYprXYGbqnnvtzEN5WSpBsO2x/p5PxXcVlOWROcQako7xm9ocWTObVEzsmXU3nPmrZzwt4RkUkjAJNtjGengAtlxRXEplKLhSe3AVKoA+G9XurTbo1n9NmcZ6gb4PN704Jut85NEVUf9hOiU0Oo0WNACwEpLcLtECCWhI1ZXAh152WDw3rVIcvzmI5n1yoM80BBFdfq7BNdY/a7D9Bh78FnotGaWtQmh/Vgw+BBgNbwg==
X-MS-Exchange-CrossTenant-Network-Message-Id: e1f9399c-88a4-460d-d71a-08de858d9258
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5832.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 08:00:23.4283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p+/7R9KGX8DXs4K3bt+Wshwpe38CLzy8yArr4XkY7MxyiiaVMpS8ptqrRp0m0qrgO09wLqpBFQERn5qOe0yjJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5077
X-OriginatorOrg: intel.com



Hello,


we don't have enough knowledge how this change caused below kunit test failed,
but the results in our tests are quite persistent.

=========================================================================================
tbox_group/testcase/rootfs/kconfig/compiler/group:
  lkp-hsw-d03/kunit/debian-13-x86_64-20250902.cgz/x86_64-rhel-9.4-kunit/gcc-14/group-03

96f4aca8b6e7fd65 fa65278b9bdce81fddb3ec54017
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :30         100%          30:30    kunit.VCAP_API_DebugFS_Testsuite.vcap_api_show_admin_raw_test.fail

btw, the configs have below diff which seems reasonable to us.

--- /pkg/linux/x86_64-rhel-9.4-kunit/gcc-14/96f4aca8b6e7fd654c7fd3ce990e3326345c8f3b/.config    2026-03-18 11:03:48.295524180 +0800
+++ /pkg/linux/x86_64-rhel-9.4-kunit/gcc-14/fa65278b9bdce81fddb3ec54017ccc384fd42dca/.config    2026-03-18 11:04:47.609268479 +0800
@@ -530,6 +530,7 @@ CONFIG_ARCH_SUPPORTS_CRASH_HOTPLUG=y
 CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION=y
 CONFIG_PHYSICAL_START=0x1000000
 CONFIG_RELOCATABLE=y
+CONFIG_RELOCATABLE_PIE=y
 CONFIG_RANDOMIZE_BASE=y
 CONFIG_X86_NEED_RELOCS=y
 CONFIG_PHYSICAL_ALIGN=0x200000


below is full report FYI.


kernel test robot noticed "kunit.VCAP_API_DebugFS_Testsuite.vcap_api_show_admin_raw_test.fail" on:

commit: fa65278b9bdce81fddb3ec54017ccc384fd42dca ("x86: Use PIE codegen for the relocatable 64-bit kernel")
https://git.kernel.org/cgit/linux/kernel/git/ardb/linux.git x86-pie-v4-wip

in testcase: kunit
version: 
with following parameters:

	group: group-03



config: x86_64-rhel-9.4-kunit
compiler: gcc-14
test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-4770 CPU @ 3.40GHz (Haswell) with 16G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202603191529.cfc2cbbe-lkp@intel.com


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260319/202603191529.cfc2cbbe-lkp@intel.com



kern  :err   : [  109.892567] [   T3126]     # vcap_api_show_admin_raw_test: EXPECTATION FAILED at drivers/net/ethernet/microchip/vcap/vcap_api_debugfs_kunit.c:377
                                             Expected test_expected == test_pr_buffer[0], but
                                                 test_expected == "  addr: 786, X6 rule, keysets: VCAP_KFS_MAC_ETYPE
                                         "
                                                 test_pr_buffer[0] == ""
kern  :info  : [  109.898412] [      T1]     not ok 2 vcap_api_show_admin_raw_test

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

