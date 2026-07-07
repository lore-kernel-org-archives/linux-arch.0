Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011012.outbound.protection.outlook.com [52.101.52.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB9F361DBC;
	Tue,  7 Jul 2026 03:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783393579; cv=fail; b=XfG9lLqrqKKMi3mMJu1CqL4mp5JCICw5k+X/vBl1DvcG4fdVIxTQUvFPfHUZBcEpSTNFQ5MABEfKOSBa+yhKGAQUQrl15ndiBnwHF7G6kwNMutBJnIyKFq96NvTYzzTd5yAWCoWID3N6q8v9ymirXtZIS7jntYM7aejLJVkhOlc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783393579; c=relaxed/simple;
	bh=aaTMnV1AmGeOAAQ1089Oftti3UVaqZlX3QKtWqlZnh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PQDL7U95cjmkHBQnM6C2QWN5wQfAug2lYue5ueQmZjdhMNYNv9sgQ2S2wD47orFY37P5+7yfz5Gdfi17FX0+6ykRYtuTZBVseBB5eH+CYty/NZBH5ls98X6/AuOo8XqSe+H/KFygcJIsaCk/WVo0KL5NJVIH91ycjDG+xpZMcM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Cqo2MWph; arc=fail smtp.client-ip=52.101.52.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Cqo2MWph"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UIq/uCQXnfFnP6QFOz3gx+2oYex6D4vrgh7YLtnu3w2/OsU9aDZVjssuZMj3maV/vk4XUpxhfHrKGkSVwRNUdFtbVdjbFKZ7UT5+ziQfht7numzcAV2aNzIkCsIxigUsbGwjDjNoE3CNp/xA6GVDThFOL6mp20UDphUB2iGNFlMoBKngOGU4N3omseYpixp/PB8jtB303wyfgEI9mavvYp1QCa7RBCMrE2oMjWFJUB9OQCD+W5FgCW5bj21HI9s+9Xjnj4zSkR9/iGPjLbGtEo6cVnNRZngjAcj0m3bArtmpG+EWiW5lDq4Dt+Av5cheq59OIU4x1n+DjLG8GKWrWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NFSIJSvVNdPYipEw8/N9+K3vNngSaxtwRnYZA4/b+WU=;
 b=afjU98i59rnUhszk+1tVx/F+AnttXW5pEdUs3fa5Zoeoxf4u6JEYgvmM4rKxieFjR99zFZ4W3HQc5VlWsLBBD+PCKhg5TkqIAqbnwE/qLmSy1hPsxNb4Pjq89EIrR8lVMDIbtnkmseaGgIES9ldy0vHVxhBX0j6TWoJ59/xhOQZjSUU+RrgpWiQnSk/B/yme2DYl8ztoVDnd8E4QSQV0Vf/At9/LWoTsTzP3xAk7VdQJiUzMnGd9oj3Bc2hcCeYnFR7jY1uTEJWfeqJ8CNDpnnPmzKMpHHUaJunPKzeY/TqLDJnwkkDbwSJe1MPDBuVC/q2BqYSc10exeTjtjOE2bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NFSIJSvVNdPYipEw8/N9+K3vNngSaxtwRnYZA4/b+WU=;
 b=Cqo2MWphe5610oI0GwXeqHryuLUQ5RMx/xOmI5+H+1Y9xAZUQpLQp4yveRohuYgrB9QRY+uVRQyPFv0ZKMpsPy8r0iR5IZzPTd+5Ft7ecaRXrfqRNOFctAgvyul7JW42EjI0xHhn+mQhKPCj9CQofYW+QEpHuqFABCwNZsimJW3g1xiMINQAXlvgY8VIQyuSy43naEQu+CmrVb0FN69WN01V1IGnoxxFzF631MobEEJxMLx3jxkDkA4qRPkdW3C94PLXM5ohrNp6tP3Csdy0g0f9GbUE70NMP76T9gJpayssRGm7LciFOBmIWv8mxJ8wtY/f5OkXZ73AXUpmVKNQPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 CYYPR12MB9015.namprd12.prod.outlook.com (2603:10b6:930:c8::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.8; Tue, 7 Jul 2026 03:06:09 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0%4]) with mapi id 15.21.0181.008; Tue, 7 Jul 2026
 03:06:09 +0000
Date: Tue, 7 Jul 2026 13:06:02 +1000
From: Alistair Popple <apopple@nvidia.com>
To: Li Zhe <lizhe.67@bytedance.com>
Cc: rppt@kernel.org, akpm@linux-foundation.org, arnd@arndb.de, 
	bp@alien8.de, dave.hansen@linux.intel.com, david@kernel.org, kees@kernel.org, 
	linux-arch@vger.kernel.org, linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, mingo@redhat.com, tglx@kernel.org, x86@kernel.org
Subject: Re: [PATCH v5 4/8] mm: add a template-based fast path for
 zone-device page init
Message-ID: <akxsbwyfYH1LCyGm@nvdebian.thelocal>
References: <akfB6Qe-jKDEMUxz@kernel.org>
 <20260706074527.23978-1-lizhe.67@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706074527.23978-1-lizhe.67@bytedance.com>
X-ClientProxiedBy: SY5P282CA0168.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:24a::16) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|CYYPR12MB9015:EE_
X-MS-Office365-Filtering-Correlation-Id: 1659c594-d589-4962-6687-08dedbd4b147
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|366016|56012099006|4143699003|22082099003|11063799006|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	M0kM/zLDaElV04vAbIGy647DUrCC2+K0vyhCiBSen0w7QOOB+rOchKiATbRSSslD9kwHysP2vvrO93ZgtfxkphnhS2KRFMiGVgTO1asJ/zVpc1/Rgu4RFC7fUDNerWfmYHtGku40G7Lj7+KYkwLgtrHsIMN4tLtAxRxIYsq5REfIg0VaHkt3XJnS35vCl3NLsYiqHXg7RQBOvxHxgI761KWjYENPPOzCxsGTx29ELxn9Rbm2bRP8kPNXeo/uUjfA1tf1MaT2r5aA10PzTRKjPfvW/v4i1VHCS2lN3Er1RKaw4AY7wf2vp4OnKS+EjTh8nmzMk77JpmuSoa3omsf1wOHQ1r204LwMeYZPu59KEh3dFb+VKWwMsr+SOXw3r3rI8MqU+mvc9LL7/BX9gxGEGnO2PJHlF9QzzDCjbYdrOtc6jAG9N4XU+NyvduSQpvRUS4YSkREoBNHZViIbRMZSfwc0EKxFl1skwG5keIqt88qOBmRLzmTpP7G7f0wAPXEt9S5sOka6g6K8+BnbXIBAe3d7CaNl8EpK/6/L5oQiZDZC4c6egTYfafyxYqgdaakQmlLSQ1bKT5O2EfXf1RazCw2wQ0yrrz/wkwTt7asIlsmGw+SOuSNE/MMOQ5v0+r/M+CpC9KtYkp2uYXYaGKJ3Dq3wFdDmNvtv6nhbCch4hXk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(366016)(56012099006)(4143699003)(22082099003)(11063799006)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ixl4udeTcjOnwV1uwzTyqUYKNxOUWeDBcjRySQjkLZI1I80HlH1dZI5HZi+u?=
 =?us-ascii?Q?4K7ZGslFFy8zj5/b9xe8yyl2PebW8VPT8i/4kaapr64150lhpmf38pgudgyn?=
 =?us-ascii?Q?ga8QAOZ6FCDLUJ6UYQtpUbsbrfvRbDQ0P36EjQzue7lMeVjJ0VQ0q+afY560?=
 =?us-ascii?Q?C/HhVwURlmzwtUr2UOixcyzFJ9aWkosoggqmiWEK1tQiBzJOAid9EK2inPcR?=
 =?us-ascii?Q?zNLF2i//1nt+A/0HFpi9y8qF9D4E0Wk4AoOVky+YQ0gZUcLpSJNU6L7oqKbV?=
 =?us-ascii?Q?x8SSKIM34GsaKj6BPgxcKgXRv60oJEsZ2BrSnfdZScfYhwhZpcN0MlQabJsP?=
 =?us-ascii?Q?VRkq7i6VncKrLhe2E4uSPhN8xJGHAZ68Uu3X2xKTqpsKiQX8aydkUOGhKvsh?=
 =?us-ascii?Q?1zMZPsdVv7Nq7zXRKxZU/Dq/P8PamwAaum5K7nNFoSxjrbIty84Po5ZNvyk1?=
 =?us-ascii?Q?KyYvr0jACdVbtTpU1+g5YXPgndgrodGcNgcf5rxwUcoxvp55vBxs7irCAQ/N?=
 =?us-ascii?Q?Vp59Nv+/FsOZjAimgH2/LfmdblpJYJTKdpOOSjOhkfApP1RICDkdzX+EZEjl?=
 =?us-ascii?Q?FJTZDJoFFdqrcqyEp/0vP/6MZLjG6XEOkhFkoui7ybsltHfPlJmAfqCNHyxR?=
 =?us-ascii?Q?62oRfYLUFg5VYM+HebXZfNvqmVoWSrJWvLYRWnHmUW0JotbW+Z7fwQ12wn1k?=
 =?us-ascii?Q?n9wcbYeETIDqoAZI5tbvqHWtX+2cdf3Rd9/4Cc9STM0+niaDoCLRBmlQvnlM?=
 =?us-ascii?Q?FILeJxJqwEdVdP0P5T7iBUu2iv6yR47nOSi+W5SeG8UBhlRiccreUkACgZHX?=
 =?us-ascii?Q?uWJezDmg5AaXjuGgkQRhlXFkHRn+bTI6K+u9IT3fCarMHsl2V3MXKLqPkwpp?=
 =?us-ascii?Q?IwUCojmxL9wJEOlzH8XNHsPXpZ7Q9Qmj8MYr2Iv79IEvcgPKUlQUWQFGBOqV?=
 =?us-ascii?Q?yWu9CR9bKEKPg2H3GfBiDm7n4fiMnjbN/YnXgS3gWOqFThY++1FDjg0Rxuw8?=
 =?us-ascii?Q?A3K5aodzSM3C9Aqk6Emtqia2FcjXy/Z95qtO5gc+lMPp6YC81xpspQedOhlo?=
 =?us-ascii?Q?WHCVS1XO+xZj/RsJR7zX4IbUiHLMJ1Wpw0x196qVJghdpmRv3NV9kCyT9aJr?=
 =?us-ascii?Q?Tl7+qTVt4pQNUgMO7Es0XbRx50KJ649JvF1RZ8PrJ5++pIa+7hDeNPh6KaUj?=
 =?us-ascii?Q?pKQ6KvCbktbLBXxUEHb1lIyKfYVSu/t8rjS24C1DaPTuZtg7I24+xCAwdZs4?=
 =?us-ascii?Q?J+ViWvnDWwpZCN+TX0rFl6RR5YMkYxr8HtRFkRJx6825Yay/uR7kvX2SpkPl?=
 =?us-ascii?Q?bqBeX6SYnX6rKk29wfxIhufnNIpoA3Ckh0KaQj2qQfcT8DFYhoB7y0iX2YA+?=
 =?us-ascii?Q?1roqc36h8mzv2M2H27Le+eqb3ISQd1PPUxvvlgcWIYjj3tCXZjwOXuI3jLFV?=
 =?us-ascii?Q?K8mzeLMN9y021ea7JGaaTJEIRO1pUdXchUv6jwgl6dPuuXEUgYxLsnBkih9X?=
 =?us-ascii?Q?B7FzN/bSIeHwR7MLNQos5d+d3yuRbL8sGWfdFnptvQ5Tbnz6SeMH2YW930Sm?=
 =?us-ascii?Q?6l4WacbhrDUP6GU+bTzKDtsLSN2BZFk5R72O0uH/TU2Ep9eBxEkVyKLc05lZ?=
 =?us-ascii?Q?0W74TjJcXzsmWQCTXrGpftJgZ4vaXFLf1X6WTEg47DHXTxxjrCbtzyuXyt64?=
 =?us-ascii?Q?b05m/9a58DJEynfHwBfag/FtqwirHPPUTU7pf03w/CNMtNeNt1S2V2hV2q7H?=
 =?us-ascii?Q?DtHc0JtZNw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1659c594-d589-4962-6687-08dedbd4b147
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 03:06:09.0782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Khk4NPFwOf5DVfRtbhxnZMxLJQ9HXf93sWwAzi0KsTLahnTxgfeHNuRR+dknN8fqZ7FqLVERf7F8Mz7Y8LnkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB9015

On 2026-07-06 at 17:45 +1000, Li Zhe <lizhe.67@bytedance.com> wrote...
> On Fri, 3 Jul 2026 17:06:33 +0300, rppt@kernel.org wrote:
> 
> > On Wed, Jul 01, 2026 at 05:05:49PM +0800, Li Zhe wrote:
> > > memmap_init_zone_device() repeats nearly identical head-page
> > > initialization for each PFN. Prepare one reusable ZONE_DEVICE head-page
> > > template through the existing slow path, refresh the PFN-dependent
> > > fields in that template before each copy, and memcpy it into each
> > > destination page.
> > >
> > > This reduces the average rebind time from 244.28 ms to 217.19 ms, or
> > > about 11%.
> > >
> > > Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
> > > ---
> > >  mm/mm_init.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++++++--
> > >  1 file changed, 74 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/mm/mm_init.c b/mm/mm_init.c
> > > index 4c7fad440c2a..cc8417951467 100644
> > > --- a/mm/mm_init.c
> > > +++ b/mm/mm_init.c
> > > @@ -1066,6 +1066,50 @@ static void __ref zone_device_page_init_slow(struct page *page,
> > >  		set_page_count(page, 0);
> > >  }
> > >
> > > +static inline bool zone_device_page_init_optimization_enabled(void)
> > > +{
> > > +	/*
> > > +	 * The template fast path copies a preinitialized struct page image.
> > > +	 * Skip it when the page_ref_set tracepoint is enabled.
> > > +	 */
> > > +	return !page_ref_tracepoint_active(page_ref_set);
> > > +}
> > > +
> > > +static inline void zone_device_template_page_init(struct page *template,
> > > +						  struct page *src)
> > > +{
> > > +	memcpy(template, src, sizeof(*template));
> > > +}
> > > +
> > > +/*
> > > + * 'template' is a reusable page prototype rather than a strictly immutable
> > > + * object. Most ZONE_DEVICE fields stay constant across the pages covered by
> > > + * the current template, but section bits and page->virtual may still depend
> > > + * on the PFN. Refresh those PFN-dependent fields in the template before
> > > + * copying it into @page.
> > > + */
> > > +static inline void zone_device_page_update_template(struct page *template,
> > > +		unsigned long pfn)
> > > +{
> > > +	set_page_section_from_pfn(template, pfn);
> > > +#ifdef WANT_PAGE_VIRTUAL
> > > +	if (!is_highmem_idx(ZONE_DEVICE))
> > > +		set_page_address(template, __va(pfn << PAGE_SHIFT));
> > > +#endif
> > > +}
> > > +
> > > +static void zone_device_page_init_from_template(struct page *page,
> > > +		unsigned long pfn, struct page *template)
> > > +{
> > > +	/*
> > > +	 * 'template' carries the invariant portion of a ZONE_DEVICE struct
> > > +	 * page. Update the PFN-dependent fields in place before copying it
> > > +	 * to the destination page.
> > > +	 */
> > > +	zone_device_page_update_template(template, pfn);
> > > +	memcpy(page, template, sizeof(*page));
> > > +}
> > > +
> > 
> > The whole bunch of template functions look like it could be useful for
> > initialization of the non-zone-device struct pages as well.
> > 
> > As I mentioned previously, it's interesting to see if this approach speeds
> > up normal memory map initialization as well. If if does could have a single
> > set of the template functions.
> 
> Thanks for the suggestion. I agree this is worth exploring.
> 
> For this series, I would prefer to keep the scope limited to the
> ZONE_DEVICE initialization path and get that part settled first.

I think that makes sense, especially as my initial perf testing with other types
of ZONE_DEVICE pages without altmap didn't show much of a perf impact. Meaning
it might not be so useful for normal page init.

> After this series is settled, I plan to look into whether a similar
> template-based approach can also help normal page initialization. If it
> shows a real benefit there as well, I can follow up with a separate
> series.

I agree it would be interesting though, please let us know what you find one way
or the other.

 - Alistair

> Thanks,
> Zhe
