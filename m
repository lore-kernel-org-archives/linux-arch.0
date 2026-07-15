Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013046.outbound.protection.outlook.com [40.93.196.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2886F3B5847;
	Wed, 15 Jul 2026 05:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784092898; cv=fail; b=Br2R+bkZzqdwTp2zRxNY9KMqcC0ROWRtR6xrt8QKeyUiE1fEYWnrRIs6iDHpTzpU/0KcgFJQbOPSmHJ2fgvlkPyz+60s3Wavma04pyAXBrDZ+qPpIVD94YVKf1LeOnI3ftmL9VnnQUQ1A2IL6gM+wgrnOADo4N3IvakfElLvgIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784092898; c=relaxed/simple;
	bh=Ojx2L0QpqVDjfqC9D5PjcTHjoqVX70jEtzw3jRuBqa4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=H940psOO/Hx3UYStY1+lyT3AyAeJPCb6BRlwoRXKpo5bm6ZBmGqAmoQmbtUepw0l6SyZ7RbKx/47b3NKvKaDLdyXIoRNv4wNi2r5dQZ+JPbFTtys+ylrykx7hFg9vGA2hItPLUW3f6W7XAwjfYVxMVwXa0Td2wtlmMPHXXyUmy4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IsEMMuo6; arc=fail smtp.client-ip=40.93.196.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IsEMMuo6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RtQRCSfKudQn7X0eeRoYQSjZJcfpMswHztsw2N8UvM65tyEpKHASmYjm+SU9LbuIB8zo1tI95ImP0XkyCzMwrQI9FiiNiyd/yq0qWUDQoOSroXmaYO9pPqzEEJ4K0TwuylVkmXOAurlDoipd819aNUeoO81FJH3dSoCxrrmuDHZelQZZQwvRTFDS7u55yzivIWJzDx9iBOMfHkYrMyGyJ4GGUzgHjJXIyjYh9U5lEznJqopYDknuZQs0ZuGOZOMJ5GtOJ9MBfdY2oIs4KDR4kC93sEK7nWQVOx3REtJAuddKEVGdFUVFi3SdSKYFHWtgwfsuHChUNS7hCQjeKPmtMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=STenKwsKPP9DAsFDP/uvTytwIVOwEq6SEcB6Ljjj418=;
 b=Be4yIYtOG+UYmNAQx/Bq1cvvdolC8zeZAdH1er//TteLz7H+p2KssHBINWO4btfC8X8MJX4W8LudKbZ1uUnT5uh96tUda/oXG6GTUbRhVZkAAktYRkjAmXklZObVrjg8SQjkZ83w6RIMmhl34kvqjIVr/AneOV0Uw6PFm+8GZ1ItY6LlH42+cg2Zga3m2o9i71R5JGAGnpsx5o5kmNgz7yTyhfMqKHpF+HQFN2MmsdnHRM0NhsUuu6dprol4WQybFCY/JRXLJD43KWTu7ZX/3jxXLWK1Ri1u//Ru70ORPVtgZab9du/KcMV/N7oDtgJoOsd8GaNgd755m/vzuZGJMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=STenKwsKPP9DAsFDP/uvTytwIVOwEq6SEcB6Ljjj418=;
 b=IsEMMuo6rw1l+IkFRG1BlCMkQmplD/+hVjdSLeM55fWYPGjVNXfL89iVVXbflB0yEtvTXpDckwfRw70FWtTKwmsP6aSLaDLUHQWGers+5Q5XgqPkhA7Lkffn1ES2bd2P8Vp/MwE3Yw4RLuELKpolqCIOVdLdfvpxVFmR40XXisty3TahIqRXJgtFvYFrMDfhKlhFf4TU5DpThA2/xkXDFG0aG3HJDffquPwu/i0NCl/C9EnTqNNzWS0sBqSbfQ+DCQOjAf4KcMenE5tLbUFPD6+bmkq8DYF2EaeCi/Bn5zX7O8aqEoVE8Ab1XuamG1LL+vOsmNNQZZjDVgCzSmgipg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB5001.namprd12.prod.outlook.com (2603:10b6:610:61::18)
 by IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Wed, 15 Jul
 2026 05:21:27 +0000
Received: from CH2PR12MB5001.namprd12.prod.outlook.com
 ([fe80::89e3:6df0:de90:8dfe]) by CH2PR12MB5001.namprd12.prod.outlook.com
 ([fe80::89e3:6df0:de90:8dfe%3]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 05:21:27 +0000
Message-ID: <b5af990e-4d88-47cd-bc44-9612e30270ff@nvidia.com>
Date: Wed, 15 Jul 2026 15:21:19 +1000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/8] mm: add a template-based fast path for zone-device
 page init
To: Li Zhe <lizhe.67@bytedance.com>, akpm@linux-foundation.org,
 apopple@nvidia.com, arnd@arndb.de, bp@alien8.de,
 dave.hansen@linux.intel.com, david@kernel.org, kees@kernel.org,
 mingo@redhat.com, rppt@kernel.org, tglx@kernel.org
Cc: linux-arch@vger.kernel.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
References: <20260709112520.24857-1-lizhe.67@bytedance.com>
 <20260709112520.24857-5-lizhe.67@bytedance.com>
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <20260709112520.24857-5-lizhe.67@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MEWPR01CA0056.ausprd01.prod.outlook.com
 (2603:10c6:220:1df::7) To CH2PR12MB5001.namprd12.prod.outlook.com
 (2603:10b6:610:61::18)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB5001:EE_|IA1PR12MB6604:EE_
X-MS-Office365-Filtering-Correlation-Id: cd5f60da-ef5f-4617-7598-08dee230ebaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|23010399003|921020|3023799007|22082099003|6133799003|56012099006|4143699003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	n7mnhLGxTi0MfkQ7qvGLjz8h2VGbwA4Q2n4NRZSXnFzmjCvUrsnq8r+UqQqikp/4gLM7Y35l3KqnJeYwiUuWcxOLTk3uIB0uqlwmTR3KESdSgRzhnR82h7L6Ynw2xQmATfQLY2U7CSgGpX0gdRFa37cL6Jve4MGHtlWu2BWjqi6/vNlAet+H8/ZaqBicgn5YofDKwU/0PaRAJwvjC2mq6BONNFEuAbnE65XSNKfbfss1E7ZGu+//l2TnmyJYCLPt8d5wNReK8MJxeK8Wsn89s+/K7fselfae/VyMtJg9ESBq39LCAudQR72dsAD3ooqnM5OuV7RQaW3zlITtZaEA66AmbV+C7lmXd2Zrz//G5XD2tj/OgBA6It5rorpjnDaNC3tf41+wikE+Pgh0fh2HTD+gMXvct+YQxGsEPY/r6cOyvWnNsp/7VlTq5H+bouXb4HGXTdyCJWbSj5PN+JCCWKEBzTQuCQVLea+AGSGqD8PbRAJVA3lyjV+f/eCyi4fqzghdadIKuPZLieq3wIVzKb3I8+xUKlBS3Q7oZzwnNVbdSbJWIvvYWhW7QjKksDj4cqAZUjpFT+P6IjNPKrYKHRf1QZealhEc/NA58EuXAospgR11XD0apzWdDsb9je8qhd/WJgTYV19/ZRR3Yq35g6j/bmpQN/HTqCBUCl/PMjpsA0lp5WZSXJuIGolmwleNFtUnIWAIkUmU4FcEGd8+Cg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB5001.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(921020)(3023799007)(22082099003)(6133799003)(56012099006)(4143699003)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TTIvT0JpNDAvN2hDTk5UeTJVUjUxQWVYR1lTcEpyb3Z2S0xYMzRpWDFBbkVE?=
 =?utf-8?B?d3A5T0pZY2VVQkFVNkJtWjFJOWVWaGhxc2dVM3FaZzd1dHJGMlhmV0dUSWZY?=
 =?utf-8?B?MTRMb29ZbVRXQ2lXK0dhREpSdStHeGtuYTFGK0VaaVRkMTlkb1J0ZW15Mm9Y?=
 =?utf-8?B?bElaVENHYkpkeUhNc0Eza25vbmlnMDFsL2xwTWhleWVKYkZuKzVNSDdyRFJo?=
 =?utf-8?B?Ym5hcEovUU5zQUVoY0tQOFUyL1owVDNleWxuUFhETGQrTGVTRUs3RzU5bTd0?=
 =?utf-8?B?dVJLQkJpbFJLalB1Q05qSGlPK0VXUUd0aHhNdVV5SWw1OTltaE1HVFZGV0pP?=
 =?utf-8?B?RFpMd0RVQVlrczV4V01WeWdkSndHNGkxeVpGdDhoamc3aElVMFoydEpDOCsz?=
 =?utf-8?B?djFVT0svQXppd3AvWDVTa0NQYllXcUxwZDBkZWk4K2pDZDI3VXVUS0d1S2xv?=
 =?utf-8?B?UDVrK0JaUUw1a0U0c3hSNkFiMTJ2VENBT21yaU44VUkxVkNkK3dzcWpQQ3FG?=
 =?utf-8?B?ZFkreENab2VqRW90Vy9XTFJmb1V0N3p2YTY2d2k3Y0V3UzhiU3FmMEpkaG42?=
 =?utf-8?B?RzlmaTV4ZVlNWVNYVm1mQ0ZKNU1LajlCRUNjck1NYk1FWC93MFR1VXppcTZ6?=
 =?utf-8?B?ZmlhdlJrbUliak9ORkcrTHFLWEIrNTNhQ3ppT1l4UU5OSi9WcnhKZ2RFMXhM?=
 =?utf-8?B?MFN4L2FSNmNESWN0WU1LeWpHNGRHTzFMdEpZRTJuSnRLSGVnSFg2K0sxT2Zi?=
 =?utf-8?B?enBtZGh4ejFiY09xekhaYVZUMFlxM093Y0pidEdNTDFEZUN2RGtoYkZUTjNY?=
 =?utf-8?B?TjF0dW4xYW1CQm9YZC9oSG5mY3JaVHdGTm9yek1mU2N2S2RRNU5meVpnbExM?=
 =?utf-8?B?Q1BZUTY5cWFSeWczeXd3akdCYTY4bDJZa01nVVQ2MUJXc3d0YWJBRldGVnhq?=
 =?utf-8?B?aVVzSG5YVjJQa3oraTd4MTNPY2dtUlZ3UHY5YSsyQWFUZGMvU0plOTc0MHNQ?=
 =?utf-8?B?cjhJYTNWYmN1cUYyZytZVk5xaUNSdWJkRFBocWc1cFhDOHpqa2dldVpJZE96?=
 =?utf-8?B?d3hmazJUUWwyWlJTMGQ5dVRDZmdvb2dVa05vQ1lDOVUxd0RDTVdub1A0NGNM?=
 =?utf-8?B?VC84NlEzMndxT3dBeFpuY0VqcExmQjczTmcvbURFWkMvVmdPejVHYUpoK2NO?=
 =?utf-8?B?TnFHeU9DMXVwdUhOVXBieW8wVm1jcUF3SFBlL3d0LzRXUGQvZ0VPamNqRjZ1?=
 =?utf-8?B?YnllcGZiWFUxVzhoUzhmZ0wxWHUrallkTHVtZlJpWUtzcHFGcVN5cGNWWFp0?=
 =?utf-8?B?S0kxVWFCanF1dmtKZGpMaEI3Zlo4OWZtZlJUWjRVOUFSNzFGWko5VmxxTUFO?=
 =?utf-8?B?YkZ3bkhzOVhlQVp2emk4bjhmYk1wK3RtUzhlbDkxTHJWc1dsa1lZbVJKZnp0?=
 =?utf-8?B?d2lxTDRCRzl6QTJVa2VJZUhvQVd4UW5sTUQ4bThBVXU4dkw4TnVFdXFvM3A0?=
 =?utf-8?B?bUsyUkQ5NjhHQm45aVlXNDNicVVZeWZiUU9kUWErRVhZTDF0bDV4SHJOejhz?=
 =?utf-8?B?RVpmSHRuYlk3Vko0MzFHMGlESkh4VzBNelVjekgwNmQ2VmJJbTBpazlyc2RE?=
 =?utf-8?B?MXc4Rm5EWDBWKys4cDdoQnNHaFdxYjIzS0R0c2h3UWhiNmtNdllIdXVRSnhn?=
 =?utf-8?B?NmlUMFdUdUJRcFBmZnVqcEc4WTR5VVNWL1J1dzh0eGQrZ2IzelZWQTN2NUo5?=
 =?utf-8?B?OXI4RWdpZmpFZjJYc3pQdys3WStxT1BoVVFDbnI2Q1pEQ2lwZ0NoZUtPUjkw?=
 =?utf-8?B?U2xiWTFRRXBPMnFuckZsMHY1QXdsWE5TMWgxWEJRYWtMRlAzbjJwclExaXll?=
 =?utf-8?B?REpkUkxmM0NFMWExYVdNKytlWVFUUXJacHBxbWtYRXZjNVEwUkVLaXYxWXNI?=
 =?utf-8?B?cHNha2RicnhLY1N1bWxBWkJ5bUdxRjROeWp1T05zb3pwdXNROE5jZFdQUmJq?=
 =?utf-8?B?NmIrMEUvWkVEcGc5OWRwTVdBTTF3ZXo1U3FTbk9sdGJIZXFYSmpSWnhOUWtz?=
 =?utf-8?B?VnFQMFVOVnZUWVFNdkVKSWlKZXVaaGFuRnl5YnVKdGVESlp2NDFXMU1zRVBo?=
 =?utf-8?B?NHloTTVFYUQweUtxQWgzb3NtOFRjcW9pNldKSU5NbjA4UVE0YnBjYU9RaEJ0?=
 =?utf-8?B?MlFxTGlFSU1QN1N0Zm4wc0o3QllEWlZLVkhDb3MxNkZVVTgwVlY0dnRSQzBL?=
 =?utf-8?B?eVluV0F1NWlRcVBEZnBYZTY3RG1jczdKYzIzVTNRWXViSjJYVUhQVjh4em5n?=
 =?utf-8?B?WlpsV1d5Qk45UDgyQ3UvL3Z3L2tNNlBBRkxxam1KYW5VeHkvbE9WUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd5f60da-ef5f-4617-7598-08dee230ebaf
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB5001.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 05:21:27.5662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5mgPo77r/W2gj5osvWYLsyWU9zyudZoRVYj97K600SvCdtXzsz5GM2yxL0DzX/r18IqxtTF8+znrNRBbsM0QVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6604

On 7/9/26 9:25 PM, Li Zhe wrote:
> memmap_init_zone_device() repeats nearly identical head-page
> initialization for each PFN. Prepare one reusable ZONE_DEVICE head-page
> template through the existing slow path, refresh the PFN-dependent
> fields in that template before each copy, and memcpy it into each
> destination page.
> 
> The optimized path assigns _refcount through the copied template, so
> keep it disabled when the page_ref_set tracepoint is enabled.
> 
> This patch accelerates head-page initialization. The pfns_per_compound
> == 1 case gets the full benefit here, compound tails are handled in the
> next patch.
> 
> Tested in a VM with a 100 GB fsdax namespace device configured with
> map=dev on Intel Ice Lake server. This test exercises the nd_pmem rebind
> path (pfns_per_compound == 1).
> 
> Test procedure:
> Rebind the nd_pmem driver 30 times and collect the memmap initialization
> time from the pr_debug() output of memmap_init_zone_device().
> 
> Base(v7.2-rc1):
>   First binding: 1456 ms
>   Average of subsequent rebinds: 244.28 ms
> 
> With this patch and its prerequisites applied:
>   First binding: 1440 ms
>   Average of subsequent rebinds: 217.19 ms
> 
> This reduces the average rebind time from 244.28 ms to 217.19 ms, or
> about 11%.
> 
> Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
> ---
>  mm/mm_init.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 58 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index 5fccfbacf855..170021e182e0 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -1065,6 +1065,44 @@ static void __ref zone_device_page_init_slow(struct page *page,
>  		set_page_count(page, 0);
>  }
>  
> +static inline bool zone_device_page_init_optimization_enabled(void)
> +{
> +	/*
> +	 * The template fast path copies a preinitialized struct page image.
> +	 * Skip it when the page_ref_set tracepoint is enabled.
> +	 */
> +	return !page_ref_tracepoint_active(page_ref_set);
> +}
> +
> +/*
> + * 'template' is a reusable page prototype rather than a strictly immutable
> + * object. Most ZONE_DEVICE fields stay constant across the pages covered by
> + * the current template, but section bits and page->virtual may still depend
> + * on the PFN. Refresh those PFN-dependent fields in the template before
> + * copying it into @page.
> + */
> +static inline void zone_device_page_update_template(struct page *template,
> +		unsigned long pfn)
> +{
> +	set_page_section_from_pfn(template, pfn);
> +#ifdef WANT_PAGE_VIRTUAL
> +	if (!is_highmem_idx(ZONE_DEVICE))
> +		set_page_address(template, __va(pfn << PAGE_SHIFT));
> +#endif
> +}
> +
> +static void zone_device_page_init_from_template(struct page *page,
> +		unsigned long pfn, struct page *template)
> +{
> +	/*
> +	 * 'template' carries the invariant portion of a ZONE_DEVICE struct
> +	 * page. Update the PFN-dependent fields in place before copying it
> +	 * to the destination page.
> +	 */
> +	zone_device_page_update_template(template, pfn);
> +	memcpy(page, template, sizeof(*page));

I wonder why the code updates the pfn in the template and then memcpy's page as
opposed to have a read-only template, copy that to the page and update the pfn
in the page?

> +}
> +
>  /*
>   * With compound page geometry and when struct pages are stored in ram most
>   * tail pages are reused. Consequently, the amount of unique struct pages to
> @@ -1120,6 +1158,7 @@ void __ref memmap_init_zone_device(struct zone *zone,
>  				   unsigned long nr_pages,
>  				   struct dev_pagemap *pgmap)
>  {
> +	bool use_template = zone_device_page_init_optimization_enabled();
>  	unsigned long pfn, end_pfn = start_pfn + nr_pages;
>  	struct pglist_data *pgdat = zone->zone_pgdat;
>  	struct vmem_altmap *altmap = pgmap_altmap(pgmap);
> @@ -1127,6 +1166,7 @@ void __ref memmap_init_zone_device(struct zone *zone,
>  	unsigned long zone_idx = zone_idx(zone);
>  	unsigned long start = jiffies;
>  	int nid = pgdat->node_id;
> +	struct page template;
>  
>  	if (WARN_ON_ONCE(!pgmap || zone_idx != ZONE_DEVICE))
>  		return;
> @@ -1144,7 +1184,24 @@ void __ref memmap_init_zone_device(struct zone *zone,
>  	for (pfn = start_pfn; pfn < end_pfn; pfn += pfns_per_compound) {
>  		struct page *page = pfn_to_page(pfn);
>  
> -		zone_device_page_init_slow(page, pfn, zone_idx, nid, pgmap);
> +		if (!use_template) {
> +			zone_device_page_init_slow(page, pfn, zone_idx,
> +						   nid, pgmap);
> +		} else if (pfn == start_pfn) {
> +			/*
> +			 * Seed the reusable head-page template from the
> +			 * first real struct page, because the existing
> +			 * page-init and pageblock helpers expect a real
> +			 * memmap entry rather than a stack object.
> +			 */
> +			zone_device_page_init_slow(page, pfn, zone_idx,
> +						   nid, pgmap);
> +			/* init template page */
> +			memcpy(&template, page, sizeof(*page));
> +		} else {
> +			zone_device_page_init_from_template(page, pfn,
> +							    &template);
> +		}
>  
>  		if (IS_ALIGNED(pfn, PAGES_PER_SECTION))
>  			cond_resched();

Balbir
