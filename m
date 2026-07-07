Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010056.outbound.protection.outlook.com [52.101.61.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9032535F603;
	Tue,  7 Jul 2026 03:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783393755; cv=fail; b=U44CzPGGyEPpyluJ1mfMfDL7UbuyDogHbtwdD5LJOMhlV3K498xJoJT236JE6Y1lz0++0YNQpNI4Nj+bKeqn0hX0xPSIap2FY8bWmy3mQPe5Qkm9nmUWC9bkiJEM237SOsCBo68Vajn4WCzKZLHcvFUPmPdu2m4EJlD707UcKr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783393755; c=relaxed/simple;
	bh=uVKEAUcfMdVX5ZTFrbMPvQoxdKtPNd5K4lrRrXF+GuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q7ZZR1khwNnl1cjl+8N7CdYN1qbxisERjC213xK2hsMVSh3q82Y6jPS1J5vSWoK2qtmItY32dUBvMRDRIssQCJIFQ4zn/dnNQTABSfJblJ/lvG+tpAQoxcmB0cM9SL2pgy6JT5ythucTcNM7pg1SIYF1bJTr3thSjOYa9/nb358=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Fw4f9/Ey; arc=fail smtp.client-ip=52.101.61.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Fw4f9/Ey"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o3z1wTks6XKI6iS8jI2lL/9ETVE4OF33IxeAqqriKoeghTLsyDomJ4AhVE4Ktkte1fV+0KdILokheto1Thxba3QiFU5tbJJvDRBUd4SZkF3DhevTW0NFfiY47rHATaxGvzpomGnWw0+N55GIsL7lJ296uNT+IlQw1WuKs9i6/fsmh5FTHJdncntdPS1OW5GJPSyV9o4Sf0O3Frt1onTdNWhg31WEn00v8NuKbiNcUE+efQ3ACwS9VYtTPJHJN5UsK6BiyuPkqzs6xo6J+t2Q44EcJebLYYBPdCuO8tgdGwTW/5sn6w/j19R1z9BiGZwGDH2beL77eXs4orWCLA8ddw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4t4UnRbPev6V92mwdFayNZ4B22D5taI2KmwMwZ7NZS0=;
 b=FUIvPsjPH9CZZqP8XW8rcuwm2D0DhNjur82Me9XVNh8cnnN8MTomDvhbwOCfoWfPYic28RSf2gRj9kwSCCLufLYmF/7ITfZI1v2iuG9LFVJ9Pyv2ZyHdcOvP9AiF4MRY3m1BQ4WxQJMfcdCGo1/CFo9oy93YPL/8G0qtkbvHTf2iyhlRUTrQ5PLhQxKosFXqYDdYKxOrBFiA/FcZLtScFmRXw6rLbrVdt8gwQ1td7WYb9jInipGb8wC63LfkYtvqZU3aAfjBvoC+J85COiWL9VY/gIw/ToIEKKIXw878g+RCND/DTKLBzNF87hC1PRo2ujILSWfXnGzkHFoI/cVJxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4t4UnRbPev6V92mwdFayNZ4B22D5taI2KmwMwZ7NZS0=;
 b=Fw4f9/Ey8RksEYbmXb3VhniumSneZtiaYtHtVnY3BYVEUfVMBqeJk0freqirYFGSTxhYnuWjuwU+eBOstb+2T+ltfbiVwPHUGGPuAMzJBisZ3KmVQsVPo2ESMjmlPAeA3zK137bVdQMac4jlqiQBvPClz5mHpEU2gO5Up4VG/dzuuDquHa4SpcRgfgwu6wz/bVZL9pryRFHwJzjSws32IGTIYG7VGXLpbYP6tkVhcQQXHXmG0mqQMg8quzVluh5td/cpdGj7jT7m7Or6hrMqdripLoljexhfCfbsfHHJKijudWkzM4MR3dDSJe3D61DSRazMxaTZjT8mug45j8jA+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 PH0PR12MB7096.namprd12.prod.outlook.com (2603:10b6:510:21d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 7 Jul 2026
 03:09:09 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0%4]) with mapi id 15.21.0181.008; Tue, 7 Jul 2026
 03:09:08 +0000
Date: Tue, 7 Jul 2026 13:09:01 +1000
From: Alistair Popple <apopple@nvidia.com>
To: Li Zhe <lizhe.67@bytedance.com>
Cc: akpm@linux-foundation.org, arnd@arndb.de, bp@alien8.de, 
	dave.hansen@linux.intel.com, david@kernel.org, kees@kernel.org, mingo@redhat.com, 
	rppt@kernel.org, tglx@kernel.org, linux-arch@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v5 5/8] mm: extend the template fast path to zone-device
 compound tails
Message-ID: <akxtWBdz5XjoAAzF@nvdebian.thelocal>
References: <20260701090553.62691-1-lizhe.67@bytedance.com>
 <20260701090553.62691-6-lizhe.67@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701090553.62691-6-lizhe.67@bytedance.com>
X-ClientProxiedBy: SY5P282CA0194.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:249::20) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|PH0PR12MB7096:EE_
X-MS-Office365-Filtering-Correlation-Id: c60e1696-4766-45df-bdb6-08dedbd51c5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|3023799007|56012099006|4143699003|11063799006|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	8mamLpxnK1HXxzhyv8fi6dtHeeUQLEzc621PTu6eSi5o4k8cBc1fGnr3q4OHYi/xXikFaYGZBCygBNKwAJAZ6i+pHZUisSj7UgJI2IGEhuLQVaV3Sgtlffey8PPsbELpv1R8DsD+M5VWJp2UE7O+PVfeL8IL3ueI2ucQ3ZnxalbrB08OjXpVip2bY9A+4XrDMxanJxjqU5sdpPSjx04BX9SIBi7kPjBkqUegKnxeDQmWhwbXc1xKIPR0O5DFMzstNfnY3kkEvlQMaNwd7QSKubmTPtF/h4FE6WEB+y+7ZFRrl+0seOD/fh3pJTaaSHM3gtcHQS7GfXSmrD30Hns57Cw3aL0O/n4vHFAS2kvGplu506b5Z2BPtgt7sBs3A6vLqLLRFR2E43w2BwQYwCb2do13W/c3FXUJ/GzOaeYBm4sabE8t8taVZ5ifTjrSWvcIZRdaooePmk+lMXBcJG4hf462816iY+PEm7I4n7W6ZzibXzQ+LPLpQgRpPpwslhkyG8ghaWV1p7DnmfVS63f1nOdzo3hY41PX7ca2xojFAalItTCZKvd7N3wYKXeBYInGPWIRfCcTugPTCstRpPYTdNDBDq4uqXVzPWwuGcfdklxq34AF2Mg5meAzVE3Q5wg+7X2RAAsjl/7tHtHuYl4ksJiraAC8magOy4dqXNk1izw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(3023799007)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KCmLvX1thLguPpcm3YHT0Z0cVt9ljj6KAi/dC3vGcSNv+mb7y4LrrsvDUQa5?=
 =?us-ascii?Q?6xTGPsWXF1EJ0ZsZpPmUc/XKw6BRLPyqbO/KXMf5Z5zVLKQ9OUeYoFF850w+?=
 =?us-ascii?Q?aqwD4z65YiAJrf0zKfnb0xdubhr1eVboKgYL1kxMue5UXHQY3yezN5ACyzMJ?=
 =?us-ascii?Q?KhTNpknhcK1DXoRY/pIVEobpVJ1YdLdHfauBB/EnIS8X5E0O1M5AyAZA6W8S?=
 =?us-ascii?Q?Gkbx8G3oav8fvDb0HaMmIQvzAm34s/5O8MkhCWSwYt1mDsD45TV93au2B3nd?=
 =?us-ascii?Q?g/TxbWbpfPw5Im/Ld9NV0VFMZYRuenFY9qvdVYCPPFXl30LPhij4px8wNiqD?=
 =?us-ascii?Q?w42+ouaReUKmEzaXbL0niIP2R+jCSlRB3kUQiGgmamkkPxjUlyCsrZnX5vTK?=
 =?us-ascii?Q?aqFPHCQQfFLNq+CszjTnNmmkqlDVUSVO1NUa3JxsAvvgSct/WwNe15jTlKvG?=
 =?us-ascii?Q?qPse/N+E4J0myTpaQBbn0Op8dU/ocDjSRFKEXneO+9cDOAwQ81rdnDfKDf0V?=
 =?us-ascii?Q?SdHGSPjvamBVbvJ3xZIK8iv0z5EuRZ4k1IYV1EJuU+ETPSLJLFtaO2tYvDrN?=
 =?us-ascii?Q?LjVN2gMYQnhnMOy8sMraMv6X4Z5HBCkmYWSRLWy5ORgOgrboH7u7slY2Kz0s?=
 =?us-ascii?Q?XwV7l8j4HMGQyCs+qp6FpKdaLBsU0WAq0AYA1j9O9cFvGycTUH+XtCPEfk/D?=
 =?us-ascii?Q?Ld9enomvtwJ/R/RrSuACqRm5mdiAR9IDOXF40fuQ3rKRnNObeb/dhIWOLwQk?=
 =?us-ascii?Q?NuR7psihKhJlmo9Me43jCiXAfWNwSTlNajP83PcdoOaAsT1XyPQoDCYrIhaw?=
 =?us-ascii?Q?sVippkDmGDFhyynKMLhH5BhYelOfPcAro8yK9BAt3zt5BfzMOfqHpQAgxjEV?=
 =?us-ascii?Q?IrrMXDgYBFPzHPXUfRVd3OYDS/A5h3Xm1ihhuwGnwd+Past6cF95TmrOsLq6?=
 =?us-ascii?Q?i3FnnY+SM4dyWcq0GxBhOKf48MTj8zQvM56C2IOFVsEiZLunXZcqiDHKs/NE?=
 =?us-ascii?Q?6oVh/+pvvY1iH84DLCaeRE6l4RCjZPd7p+ZW42c9x3UbJTvEjEWHUNAfuJL0?=
 =?us-ascii?Q?r8R74hXx8HNmYLwNx7oNbi+aQ+Q+E+sEWsmZeFTPzEsOD+iPnHOhH2uvN0ez?=
 =?us-ascii?Q?fomt9qF/mBnM0dvnW2MPMtsVeBtYilvhv8l81Tag7fWWLw8wjXLstaP5vAEY?=
 =?us-ascii?Q?rYdHa6ByF6Od1XXyDYeNFn5V7gLUcnc0S9UujpoNUPsMN1xWC7XTG8iygBXZ?=
 =?us-ascii?Q?8/RCWIGBFrSimHOVCKt86NhRV1Hf07P4qk7CrHKVhpEBky1skVBy/DVYfabB?=
 =?us-ascii?Q?3dRZsJ9Q0BIn53aIeTad8FbKjXw/MjZHv3haj4oK9lJ3SapgbhPPs2Xe0EGn?=
 =?us-ascii?Q?CCbquRfLlK/uLLPgNNvTLldzkNrXMejAl60bKdsYW+vlUV3IGqevIJQWk8bx?=
 =?us-ascii?Q?t6+/XY2RpzxAp8ziqo7Ns+i/u075KzMfTaiY4NCE23XykQQ0rfJX01dt1S31?=
 =?us-ascii?Q?qT5K9VF3X1OPAJcW5Zkn8rSUDy2S1qrqU1rOxDibP5Zl8T9M4f/EKAdmkrQc?=
 =?us-ascii?Q?CrcWtEJiPKTDGZmQrFpjpmAQO/ssDGFa45x8/rHeera8FkNrwKYqVH3wN51B?=
 =?us-ascii?Q?Rdt2vVZ1SRcNh1Ao9+XQXCzOu6OC84+lLoH8MWpX5m2KxU+W1RcxZauAKyqf?=
 =?us-ascii?Q?n/FcbGetrGEnteT1VaSiPVBjASQtiVvP740TJea2p88w0p7PEfrlcqZap4We?=
 =?us-ascii?Q?UmI5tpTxlg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c60e1696-4766-45df-bdb6-08dedbd51c5c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 03:09:08.8940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a+AMtJoHm47VyKrNiMMZnLTQVHcNAjBH8BqXLXJ5W9nQ1iCdp8SRvUtFP4t2ezOohKson70PVRYH1IcC2ZXrgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7096

On 2026-07-01 at 19:05 +1000, Li Zhe <lizhe.67@bytedance.com> wrote...
> The template fast path from the previous patch only accelerates head
> pages. Compound tails in memmap_init_compound() still go through the
> slow path one by one.
> 
> Build separate head and tail templates and reuse one prepared tail
> template across the tail pages in a compound range. Head pages preserve
> the existing refcount policy, while compound tails always start with a
> refcount of 0 after prep_compound_tail().
> 
> This extends the template-copy fast path to pfns_per_compound > 1
> without changing the existing slow path. Tail-page PFN-dependent fields
> are refreshed in the reusable tail template before each copy.
> 
> Tested in a VM with a 100 GB devdax namespace (align=2097152) on Intel
> Ice Lake server. This test exercises the dax_pmem rebind path and
> measures memmap initialization latency.
> 
> Test procedure:
> Unbind and rebind the dax_pmem driver 30 times, collect memmap
> initialization time from the pr_debug() output of memmap_init_zone_device().
> 
> Base(v7.2-rc1):
>   First binding: 1462 ms
>   Average of subsequent rebinds: 273.31 ms
> 
> With this patch and its prerequisites applied:
>   First binding: 1403 ms
>   Average of subsequent rebinds: 244.37 ms
> 
> This reduces the average rebind time from 273.31 ms to 244.37 ms, or
> about 10.6%.
> 
> Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
> ---
>  mm/mm_init.c | 47 ++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 40 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index cc8417951467..60794050bc07 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -1081,6 +1081,16 @@ static inline void zone_device_template_page_init(struct page *template,
>  	memcpy(template, src, sizeof(*template));
>  }
>  
> +static inline void zone_device_tail_page_init(struct page *page,
> +		unsigned long pfn, unsigned long zone_idx, int nid,
> +		struct dev_pagemap *pgmap, const struct page *head,
> +		unsigned int order)
> +{
> +	zone_device_page_init_slow(page, pfn, zone_idx, nid, pgmap);
> +	prep_compound_tail(page, head, order);
> +	set_page_count(page, 0);
> +}
> +
>  /*
>   * 'template' is a reusable page prototype rather than a strictly immutable
>   * object. Most ZONE_DEVICE fields stay constant across the pages covered by
> @@ -1138,10 +1148,12 @@ static void __ref memmap_init_compound(struct page *head,
>  				       unsigned long head_pfn,
>  				       unsigned long zone_idx, int nid,
>  				       struct dev_pagemap *pgmap,
> -				       unsigned long nr_pages)
> +				       unsigned long nr_pages,
> +				       bool use_template)
>  {
>  	unsigned long pfn, end_pfn = head_pfn + nr_pages;
>  	unsigned int order = pgmap->vmemmap_shift;
> +	struct page template;
>  
>  	/*
>  	 * We have to initialize the pages, including setting up page links.
> @@ -1150,12 +1162,31 @@ static void __ref memmap_init_compound(struct page *head,
>  	 * the pages in the same go.
>  	 */
>  	__SetPageHead(head);
> -	for (pfn = head_pfn + 1; pfn < end_pfn; pfn++) {
> +
> +	pfn = head_pfn + 1;
> +	/*
> +	 * All tails of the same compound page share the state established by
> +	 * prep_compound_tail(). Reuse one tail template for the whole range and
> +	 * refresh only the PFN-dependent fields in that template before each copy.
> +	 */
> +	if (use_template) {
>  		struct page *page = pfn_to_page(pfn);
>  
> -		zone_device_page_init_slow(page, pfn, zone_idx, nid, pgmap);
> -		prep_compound_tail(page, head, order);
> -		set_page_count(page, 0);
> +		zone_device_tail_page_init(page, pfn, zone_idx, nid,
> +					   pgmap, head, order);
> +		zone_device_template_page_init(&template, page);
> +		pfn++;

Similar comment as the previous patch - I think it's clearer to just init the
template page here as a separate step and not unroll the loop.

 - Alistair

> +	}
> +
> +	for (; pfn < end_pfn; pfn++) {
> +		struct page *page = pfn_to_page(pfn);
> +
> +		if (use_template)
> +			zone_device_page_init_from_template(page, pfn,
> +							    &template);
> +		else
> +			zone_device_tail_page_init(page, pfn, zone_idx, nid,
> +						   pgmap, head, order);
>  	}
>  	prep_compound_head(head, order);
>  }
> @@ -1205,7 +1236,8 @@ void __ref memmap_init_zone_device(struct zone *zone,
>  		zone_device_template_page_init(&template, page);
>  		if (pfns_per_compound != 1)
>  			memmap_init_compound(page, pfn, zone_idx, nid, pgmap,
> -				compound_nr_pages(start_pfn, altmap, pgmap));
> +				compound_nr_pages(start_pfn, altmap, pgmap),
> +				use_template);
>  		pfn += pfns_per_compound;
>  	}
>  
> @@ -1226,7 +1258,8 @@ void __ref memmap_init_zone_device(struct zone *zone,
>  			continue;
>  
>  		memmap_init_compound(page, pfn, zone_idx, nid, pgmap,
> -				     compound_nr_pages(pfn, altmap, pgmap));
> +				     compound_nr_pages(pfn, altmap, pgmap),
> +				     use_template);
>  	}
>  
>  	pageblock_migratetype_init_range(start_pfn, nr_pages, MIGRATE_MOVABLE);
> -- 
> 2.20.1
> 
