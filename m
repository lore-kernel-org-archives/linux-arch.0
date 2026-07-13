Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012015.outbound.protection.outlook.com [40.107.200.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25952253EB;
	Mon, 13 Jul 2026 01:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783907055; cv=fail; b=C76pASZnOckhfgycE55TNctbmZU9pqyUuU1y+gjxMhQKS0zIjQ2bFucdrI9lWiGPsNb7g7NFR8FJn9LQxneH/LQ38inqthTyG9ir8dR9UTyFvJwXalLrXmQYlKlu2t+IhEGK1Q9BltmLBSnD4L2ibm+vlSOU0zn43NkPSoBHdrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783907055; c=relaxed/simple;
	bh=F5e3MTu4IFdI0hXW8P7FPKCvTyNbBEcxkjkrhfV+gDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kY39wH+1/o9HTYxe7hEUPgxJiOXYyDkKCZ7CPjw+TX9yOeb/qktj3BkmcZcbW7T59a3GQTG/9JsamM1rtGJKc6hwbQc3HGiWkpjAmY+r0S6CVdI3eB34czpXfb7oahLjrBe/6XnWy9vidLcPiM3JTL/JJKx1HYjxLWncT7gg4WM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ickTLkUc; arc=fail smtp.client-ip=40.107.200.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ickTLkUc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AAul2ecRcwqJxD/fCLSgkwnlHYHn3oJYiF+ROlO3w9kXVdJe/UIPhV2uNCxDJJOqqDRf6i6dmRscJIkLnzjgfCmINXRQbcqV3lY2OFpOOJRDQh3QSXUPSZrrgHM1+OKHAQlpS4S1y17eFgVEZKYGG3DNNG7LidCqKGpqvTV2gbcCLRP8xBX5cJBCi8/1l3VBU1VFfl/KVyM2cXHhp6SnI82ibudInjpYEuCtLhPADkE9M4ekIH0g+mRT4NvyCx25sGzRVtKhszfuAOAp+HeeD687RrEg88iqPohwinCjXT1uj5XkJ7inVTArc9dyUrykMu8LOpfyFBTkonISTpC84Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uC+ThPy3AfBidw73Ppy2mGd99AXqZLJNJX2ayeIFBZI=;
 b=P6QitrFCIsE+kN8IIjbvdsk8VNkhP26kDChwRSKH0intPtwYJC9YjewaY4Wd/CpxSfGJYH8fa426ZCtJbCmVjAxd0Ig1sazCILeCzwYPQKPVeqJYIGeopfT33Y4qoLKFsPV/BaRCcmhJ1o5lZJhaC6Mwm2G201xzccdA4enBQLgBi30nEiv/hj8b1WBOqQ0NhVzN/vqhct08vnc/BmqPMkiYDvfjA3BQg90UsBU763IGhhMaPVISayWrsodFIt1trSW3dtm4fV/uRKzsPuM5K25oSQEO5telWTbwKeuqdTMUiBKegQVsrvvZASNTsXoM3AVtAb3+Se3TGUYqmlHfow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uC+ThPy3AfBidw73Ppy2mGd99AXqZLJNJX2ayeIFBZI=;
 b=ickTLkUcRHw3pGhK7wpsLalbO8JNuK4PGvUusxJyjAh8mjOIyF6RzZkuuSGLAnVg6S8I+RHiaXTIiz4RoAS3k/z5598RoKvqvy9WHoO6wFmgZGQQYTN/Mpl2yZa3SUcyVrGU7q1qEEsVJBWu0E+Y1d8AvL/aNy6eY7+rJf5TwD6BFhXTbkesfKlnQBUOrRfU/3aO6RDJJVY3aQmukR96lJpJxmYQ6hguoEPltQP+tb1cjI2qeOTxl92psD2YmfykEcR3AxzMMDqKOvL2SBiOw1zaCuDp1hbP2VXzMTtt/RLBpOoIhRooZJamW5g+dwRzIBkq3JRy7+k704ht1MZ7Qg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB5001.namprd12.prod.outlook.com (2603:10b6:610:61::18)
 by IA0PR12MB8647.namprd12.prod.outlook.com (2603:10b6:208:480::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.22; Mon, 13 Jul
 2026 01:44:09 +0000
Received: from CH2PR12MB5001.namprd12.prod.outlook.com
 ([fe80::89e3:6df0:de90:8dfe]) by CH2PR12MB5001.namprd12.prod.outlook.com
 ([fe80::89e3:6df0:de90:8dfe%3]) with mapi id 15.21.0181.014; Mon, 13 Jul 2026
 01:44:09 +0000
Date: Mon, 13 Jul 2026 11:44:03 +1000
From: Balbir Singh <balbirs@nvidia.com>
To: Li Zhe <lizhe.67@bytedance.com>
Cc: akpm@linux-foundation.org, apopple@nvidia.com, arnd@arndb.de, 
	bp@alien8.de, dave.hansen@linux.intel.com, david@kernel.org, kees@kernel.org, 
	mingo@redhat.com, rppt@kernel.org, tglx@kernel.org, linux-arch@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v6 0/8] mm: optimize zone-device memmap initialization
Message-ID: <alRCNbTlRFyD8f-1@parvat>
References: <20260709112520.24857-1-lizhe.67@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709112520.24857-1-lizhe.67@bytedance.com>
X-ClientProxiedBy: ME3PR01CA0079.ausprd01.prod.outlook.com
 (2603:10c6:220:1c1::6) To CH2PR12MB5001.namprd12.prod.outlook.com
 (2603:10b6:610:61::18)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB5001:EE_|IA0PR12MB8647:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c542aa4-613f-4b07-607b-08dee0803b67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|22082099003|18002099003|56012099006|11063799006|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	4MYYUDrwy6vk+XRtUXnh4vWFfR7VjdqGNYQrDZwQsJ0Z5PVzqVDW2g/gGDeOu/hQNX2Ii/OhTGC3/aIGbvRic/nkr3KQiKXjvOSmh2mZM91+RWTRup8swBBm6WThbFDxYE3gD+2Zymdzk2tB6ROKTNst1bSrWMK9UCMTEbHh2uqMCUEi68McJvCEKz+ErZ9chUUROoOBajdWo8CRNZB933MxoRuZNJl7XvuDli48Y1B9+7j/ddN/5jTHK+GYk2YUjAf6p9ppyEBlgNTKgGwwsrdSw6LpOuqOGgpllvnn3wUGwu0cYCrDVz88F7QWl8F7zPOpgW+7i9aKk2QTGms6q8HBjzDeCqAX//G2GHvLTTlfh5SJv0OQ1LFX0QoVN/tr76w6Vfg/MX/3oEfX7ZgitbEah+OKO6Cw2HE9Izx7kyhdx2jNgT7qsp3AIgEbnbgKL/qwlhcO10RNUn0fgsyZjgykcoius6zdHrK/huSB3t6EWM23AzUtpBrmLaXTtoOmIjjr+9QTLpkUmdzyjob04P3SaXNCrwrxX57Sck0ZQv5Y564ZnJxfX/ehZfJxTeh2h9r5PPZQIrVbX5Cq5gJAPp3/6uUyNZIv1+Rgzf4CmBUZ7nuTrfKNPxerkaNfCu9G1FxlzjePUArcOFZUjSIv/H1lGs64fKL8jUML03wFnlQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB5001.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(22082099003)(18002099003)(56012099006)(11063799006)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O3F6gMa0r6bhgAkaawoJQGMy8A8Mr2XxgAI16IISQcNOgVwHjiJXEcPx1H0v?=
 =?us-ascii?Q?QcopNimO1lOlbS3CbECkPlxetyiMIyS2Pc9JLZ5+yj+luskEDRKuklktaKCZ?=
 =?us-ascii?Q?0/myu6dNH46yfu3Xao0fl3fgABnXR4CcszzRd/uJWOlWvB/++aBsBEvuKHSv?=
 =?us-ascii?Q?tGzEuPzJAUpHhiCQxeTtbWpCS4SLhvDilyVt3yLFF8nCFi9IfO8lqbaHH2xw?=
 =?us-ascii?Q?5q/mjcCnxPczxmovFwMHn5ANhlr613n8Zlif3/lBJeC9LMUjWXRGtGiXzq+l?=
 =?us-ascii?Q?FxuF2sEYX/e99010wNC7pTpjRVhHz0jytbZ/FsKFQUw5cOtFt9Yg+eQG2Xcp?=
 =?us-ascii?Q?NDQ0+dKzR3rm+Tq0uK8kskalZ9clN32+Z4XmP1y/HwyoumlAniuEbhccUYWF?=
 =?us-ascii?Q?Z4YEUCVlk90UyxK3Zhgki5lIuHjyw7+07tkTeKyyurLC0fmak7c5kyNt1Br3?=
 =?us-ascii?Q?QPiPcYITHNycek9TP3V30Emgb4EmNFgCU3KSPdb8cwY9A6fXL+ykfPF6IeJk?=
 =?us-ascii?Q?tm0AN7j3/4bI0ocCsYtD1qvMkinSErgCGFfMOpax70f31fe8d7XhzHphV4w/?=
 =?us-ascii?Q?iMenp1j38DsS0Pa+uRJLg/6ZDXNdicTy0dOAp0Ws9QSfr8GW0W8o9yNUsdbm?=
 =?us-ascii?Q?4UnjBFqZ+2sIilykMRTL4XPg5N7R8QE03pepIMumPqTgxzThQv95+Jgg8bBu?=
 =?us-ascii?Q?vnc9n83Cf9tPIGKpx5MbQfXxlQhHB2mOAwuxByqFEEcv8BNvT4zdbd5qmU3W?=
 =?us-ascii?Q?1a7z6sCTzAjAUZ6qM0pMA314QEbEzHC7Qn2YvVSVIc/3QUnvBoW1AE0mwG5t?=
 =?us-ascii?Q?IgITVYcWC96IrJ5Ty7gm30beuDDyn4x9vK7YEH9taepTJeIcx0rGuWhdHW7b?=
 =?us-ascii?Q?gHQFY7giLnuYUbVFwEtiRlLvof8CTOBITQEGNG83BFLtWylt+FErpcpDiyUQ?=
 =?us-ascii?Q?6bloP6pBU+8e5BK8AV6umIFQyHP4Hp3KROjacM4t82wmnPJyObuY4dw2UtA2?=
 =?us-ascii?Q?AQmVLEoquBqp6hu+YUdIyRkRgBNoUdCHr52cqanb2c3xtT1D9yjxk3aNR+q4?=
 =?us-ascii?Q?YN8HDD8MzW5mJi8lmM6ia0iHqXp53Omx29BPUtrk2XPyrBO4JwTuvUBST1OY?=
 =?us-ascii?Q?9VijdhsQhCxAueMsPnvhenJAE1sx+Cs6OqZGA1toCqeMSoAU0/UPpkredn5y?=
 =?us-ascii?Q?WV9/FLDZhUPUUcB88Fzua26RuLoD3O4qwXVxhJDX00Mur2Fzn4oUgY9hW2HR?=
 =?us-ascii?Q?IFEvEGpl9afWXWXEp5kaO42ZO49+whR0i35p3QI8bOVf0Qu3upWKsoemNZKB?=
 =?us-ascii?Q?BkUBNTwXLjCUPiveBN9woRObELEPyfZMUOkfbo+P3R1m+6umoMlJxrs25hjv?=
 =?us-ascii?Q?cwnrBVsRSePo68FarHubrgT+EWxCxFZh0MX4hHo4lH1xj63/jzUjrfh+ZML8?=
 =?us-ascii?Q?baFKy3i8LjJUbkLVETcqgry98aJ6CTlkEQIePjLN9KRSoz76M/9lmdLEuao4?=
 =?us-ascii?Q?TUO34WH+LgwVamlm9Ex4s/RNpqKUHyK7V0+RpCvEile52YsGn5TR5zWj9cFK?=
 =?us-ascii?Q?ZJ7jJGsu6lXL8tMJZtMZnYBfEBTTy/HvtgCrP5dfx66yqDB/eCsP7fOexGeB?=
 =?us-ascii?Q?j6ypkCk5IMIn8u6tOOkS+cKYAJ6InFgjq5XHQZ7wjX2szEazlzP3XM0pvs8R?=
 =?us-ascii?Q?VktXQG6yrDjQ3OXoGRsU4z0gi5rsEEDwUA7IzoLq9w7XJtkb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c542aa4-613f-4b07-607b-08dee0803b67
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB5001.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 01:44:09.4498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zwnZ3UBoOlzHbKCmHkHjRgjDiWj+h29T3nA+I3/RpxYNYdDx8jk038319fNJibrEixXeFnUJzMVYbIGC1qEpwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8647

On Thu, Jul 09, 2026 at 07:25:12PM +0800, Li Zhe wrote:
> memmap_init_zone_device() can take a noticeable amount of time when large
> pmem namespaces are bound or rebound, because it initializes nearly
> identical struct page descriptors one PFN at a time. This series reduces
> that ZONE_DEVICE memmap initialization overhead by reusing prepared
> struct page templates and, on x86, using memcpy_nt() for the template
> copy path.
>

Is the slowness specific to an architecture? Do you have any test
results from any other arch?

> The main target is large fsdax/devdax pmem configurations, where the
> cost of initializing the memmap shows up directly in nd_pmem/dax_pmem
> bind and rebind latency.
> 
> Patches 1-3 are preparatory cleanups and helper extraction. Patches 4-5
> add the template-copy fast path for head pages and compound tails.
> Patches 6-8 introduce memcpy_nt()/memcpy_nt_drain(), extend the x86
> fixed-size memcpy_flushcache() inline cases used by that helper, and
> switch the template-copy path over to memcpy_nt().
> 
> The fast path remains disabled when the page_ref_set tracepoint is
> active, and sanitized builds stay on the slow path so their instrumented
> stores are preserved. Architectures without a specialized memcpy_nt()
> backend continue to fall back to memcpy().
> 
> Tested in a VM with a 100 GB fsdax namespace device configured with
> map=dev and a 100 GB devdax namespace (align=2097152) on Intel Ice Lake
> server.
> 
> Test procedure:
> Rebind the nd_pmem and dax_pmem driver 30 times and collect the memmap
> initialization time from the pr_debug() output of
> memmap_init_zone_device().
> 
> Base(v7.2-rc1):
>   First binding for nd_pmem driver: 1456 ms
>   Average of subsequent rebinds: 244.28 ms
> 
>   First binding for dax_pmem driver: 1462 ms
>   Average of subsequent rebinds: 273.31 ms
> 
> With this series applied:
>   First binding for nd_pmem driver: 1272 ms
>   Average of subsequent rebinds: 96.79 ms
> 
>   First binding for dax_pmem driver: 1354 ms
>   Average of subsequent rebinds: 119.04 ms
> 
> This reduces the average rebind time by about 60.4% for nd_pmem and
> 56.4% for dax_pmem.
> 
> As an additional data point, I also ran a smaller set of measurements on
> the same physical x86_64 host with a 100 GB PMEM region created via the
> memmap= kernel command line, configured as fsdax and devdax namespaces
> with map=dev and 2 MiB alignment.
> 
> For brevity, the individual patches keep only the VM results rather than
> including a second set of physical-host measurements throughout the
> series. The physical-host numbers below are included only as
> supplemental evidence that the same optimization also provides a similar
> benefit on a non-virtualized system.
> 
> Test procedure:
> Reconfigure the namespace mode, rebind the nd_pmem or dax_pmem driver
> once, and collect the memmap initialization time from the pr_debug()
> output of memmap_init_zone_device().
> 
> Base (v7.2-rc1):
>   nd_pmem / fsdax: 179 ms
>   dax_pmem / devdax: 264 ms
> 
> With this series applied:
>   nd_pmem / fsdax: 82 ms
>   dax_pmem / devdax: 113 ms
> 
> This reduces the measured rebind time by about 54.2% for nd_pmem and
> 57.2% for dax_pmem on that setup, which is broadly consistent with the
> VM results above.
> 
> As another supplemental data point, I also measured the test_hmm.ko
> module on the same physical x86_64 host, using the test_hmm.ko setup
> from the previous discussion that times ten 64 GB
> memremap_pages()/memunmap_pages() iterations during module insertion[1].
> By default, module insertion initializes two DEVICE_PRIVATE dmirror
> devices, so two avg memremap values are reported; each value is the
> average for one 64 GB chunk.
> 
> This is not the primary target workload of the series, but it exercises
> the same large ZONE_DEVICE memmap initialization path and shows the same
> direction of improvement.
> 
> Base (v7.2-rc1):
>   avg memremap reported during module insertion: 116689362 ns, 116539263 ns
> 
> With this series applied:
>   avg memremap reported during module insertion: 54607108 ns, 54458236 ns
> 
> This corresponds to about a 53.2% reduction based on the mean of the
> reported values, which is again consistent with the pmem bind/rebind
> results above.
>

That is a good result, thanks for sharing

> [1] https://lore.kernel.org/all/aiEoByaQdRR3xtM5@nvdebian.thelocal/
> 
> Li Zhe (8):
>   mm: fix stale ZONE_DEVICE refcount comment
>   mm: factor zone-device page init helpers out of
>     __init_zone_device_page
>   mm: add a set_page_section_from_pfn() helper
>   mm: add a template-based fast path for zone-device page init
>   mm: extend the template fast path to zone-device compound tails
>   string: introduce memcpy_nt() helpers
>   x86/string: extend memcpy_flushcache() fixed-size fastpaths
>   mm: use memcpy_nt() in zone-device template copies
> 
>  arch/x86/include/asm/string_64.h |  78 ++++++++++++-
>  include/linux/mm.h               |  15 ++-
>  include/linux/string.h           |  23 ++++
>  mm/mm_init.c                     | 186 ++++++++++++++++++++++++++-----
>  4 files changed, 273 insertions(+), 29 deletions(-)
> 
> ---
> v5: https://lore.kernel.org/all/20260701090553.62691-1-lizhe.67@bytedance.com/
> v4: https://lore.kernel.org/all/20260603080152.64728-1-lizhe.67@bytedance.com/
> v3: https://lore.kernel.org/all/20260527033636.28231-1-lizhe.67@bytedance.com/
> v2: https://lore.kernel.org/all/20260521040124.10608-1-lizhe.67@bytedance.com/
> v1: https://lore.kernel.org/all/20260515082045.63029-1-lizhe.67@bytedance.com/
> 
> Changelogs:
> 
> v5->v6:
> - Rework patch 6 so the x86 memcpy_nt_drain() helper uses wmb()
>   instead of an open-coded sfence, while architectures that do not
>   override memcpy_nt() keep the generic no-op drain fallback.
>   Suggested by Borislav Petkov.
> - Rework patch 6 to use the usual self-macro override pattern for
>   memcpy_nt() and memcpy_nt_drain() instead of a dedicated
>   __HAVE_ARCH_MEMCPY_NT feature macro. Suggested by David
>   Hildenbrand.
> - Drop the default: case from pagemap_resets_refcount() and drop the
>   WARN_ONCE() after the switch so newly added enum memory_type values
>   remain visible to compiler switch checking. Suggested by David
>   Hildenbrand.
> - Drop the unnecessary empty set_page_section() stub from patch 3, keep
>   set_page_section_from_pfn() as the only !SECTION_IN_PAGE_FLAGS no-op
>   helper and fix its indentation. Suggested by David Hildenbrand.
> - Rework patch 4 so the reusable head-page template is seeded from the
>   first loop iteration, keeping the main loop intact while ensuring the
>   first page is initialized only once; also drop the extra template
>   memcpy helper, as suggested by Alistair Popple.
> - Rework patch 5 similarly for compound tails: seed the reusable tail
>   template from the first tail-page iteration so the first tail page is
>   initialized only once, while keeping the main tail loop intact, as
>   suggested by Alistair Popple.
> - Rework patch 7 to rename the internal fixed-size MOVNTI helpers to
>   movnti_*(), keep memcpy_flushcache() as the externally visible
>   wrapper, fold the new 32/48/64/80/96-byte copies into the main
>   fixed-size switch, clarify in the code and changelog that the
>   ZONE_DEVICE template-copy path relies on the 64/80/96-byte struct
>   page copies while 32/48-byte copies stay inline as well, and drop the
>   separate alignment check based on the physical-host microbenchmark
>   results. Suggested by Borislav Petkov.
> - Run v6 VM spot checks for the fsdax/devdax map=dev paths. The
>   results stayed in the same ballpark as v5, so keep the previously
>   posted v5 full-run numbers in this version instead of replacing them
>   with another partial data set.
> 
> For changelogs of earlier revisions, please refer to the v5 cover letter.
> 
> -- 
> 2.20.1

Balbir
