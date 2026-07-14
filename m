Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011005.outbound.protection.outlook.com [40.107.208.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3174A3845C1;
	Tue, 14 Jul 2026 11:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784028961; cv=fail; b=IKb5JUJ8WnIZJ/rMMX2xRqa8AzThagsbApLYXf/NEUIYfFz84DxmNvTNJ1TbJL0DwuOHk/7aIBmCPHpWaf0A8SgS8o8I50psMkgxjRvlJmhrHU6tDUsoSTOIzDqFXMeRf55SBr/Gos9g4XCJzaZDxKbkiEl/Un2D8EJ44aTabWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784028961; c=relaxed/simple;
	bh=4vV77GVq0z3peGS/mg4Jsgfwb37ocnT++rnxYn7gXSg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mErdKCD5iC9DgDdsER5AyYB1AKpF+QFO2LMId18Kn0mK4ztq9wSbbGrId0Mdx2xe5PTLrbrg2K8ps4t0VucI8g6Fqp3dgr1d6dqzIr3t0dpDHQKaMQES7DGdheBl43Shu4qEco99zGC9dz5f9Uz7W65ic4hmDhfhopEun9c7+Z4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Xu1EBMXz; arc=fail smtp.client-ip=40.107.208.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Xu1EBMXz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qQbn4Hihz1RqBLgDPtTxXw04gKtpWl7SUyuPUJgux7h2XlWXNSLasvjYiO55U5fjozZogB1Af2oc9Am/ZuzDxpyh592LahAZHghfsGif+mJi/DQfMNJHktOR5FfumYHgOyLL0qen6XUtN4TkVn+X6ustfVBFf1CC3tuwOs410UAwu0HCvvxqN2fEZZJ9ufiE9VAUWn9fNpae74dHlJq0buFYjJvOVj7VKtMpY4tNNLJgoOzTcKMoTSmh8cFPdwDi3SyeK33YK0QRAYc9Vp1qaPZqKSCS/BdU7SDjiJCk6Q/3HzELMrTgExf71Og7j2QXy7cgbzSHeYgxoYVkJAwcuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=50c/2a4cgZyUQrqlxOZ0b7WMOIbsLSy6QmLfqAj6kcw=;
 b=TpNwdLQXFezB1dKVqcQPexC85wgr3UxYb8jRErTyzw7YKy4pXgOdIklw7ciI9HkCVy3ONwdSlIUeEVpdKG//odK8p6NZu37D5OuORUo6UTnceEe/yHhFexKLVlGmvUPT1QWELZ2ZyVZMU8xWgER3u1WtfnMS/GiWN5/OAjKoWR2vgxqLYxoJ4RCd/wDKMCFAqtWwra1sf7OLJrYlIebceDzpXuNEJIukP9u+ULTRT8tDaEaqaD02rd0UAGRbER8EUbUDc/iXTIab0MF07TQHwCJCjkpb3PFsr/jD80Ok7OSiD9Yc0/cQYBJGYHDKFFAYsspRea8eQHCSyX130Ji2RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=50c/2a4cgZyUQrqlxOZ0b7WMOIbsLSy6QmLfqAj6kcw=;
 b=Xu1EBMXzdGOfW8TzQaxm5uU5LeHAPrqZ2AC4RJBPwg4LzsEZGT3f/r5fHicgq8vaUTzgekeT4kTtlbDBuk2CQESPU27z22Z31/7s3A/LNMbcosyMsYi6/rts5MC2s99QPQBmCqM46Wcarw4a1IvCvY5eEdAXPU3eEWcHQLqaLANJLVYOPoI+o/AErpOnAPb0e3rD/yH0jHtbG17Yp/NaOrhkD9x0hP3DJWupSELDMEo2ZY8lQzFNjuUPRaGMyyBADaXgxWK5zS4kePp+mP/KXRrcuoMFIcCMycojME1jlLyDmG9H1TmoEBjFlzDbfFtAiBGWSaVBQq2SIvrfrjroag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB5001.namprd12.prod.outlook.com (2603:10b6:610:61::18)
 by IA0PR12MB8746.namprd12.prod.outlook.com (2603:10b6:208:490::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Tue, 14 Jul
 2026 11:35:53 +0000
Received: from CH2PR12MB5001.namprd12.prod.outlook.com
 ([fe80::89e3:6df0:de90:8dfe]) by CH2PR12MB5001.namprd12.prod.outlook.com
 ([fe80::89e3:6df0:de90:8dfe%3]) with mapi id 15.21.0223.008; Tue, 14 Jul 2026
 11:35:53 +0000
Message-ID: <ff75fd32-6aef-4712-8a4c-4deaeb5c3269@nvidia.com>
Date: Tue, 14 Jul 2026 21:35:44 +1000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/8] mm: factor zone-device page init helpers out of
 __init_zone_device_page
To: Li Zhe <lizhe.67@bytedance.com>, akpm@linux-foundation.org,
 apopple@nvidia.com, arnd@arndb.de, bp@alien8.de,
 dave.hansen@linux.intel.com, david@kernel.org, kees@kernel.org,
 mingo@redhat.com, rppt@kernel.org, tglx@kernel.org
Cc: linux-arch@vger.kernel.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
References: <20260709112520.24857-1-lizhe.67@bytedance.com>
 <20260709112520.24857-3-lizhe.67@bytedance.com>
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <20260709112520.24857-3-lizhe.67@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ME3PR01CA0053.ausprd01.prod.outlook.com
 (2603:10c6:220:f7::10) To CH2PR12MB5001.namprd12.prod.outlook.com
 (2603:10b6:610:61::18)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB5001:EE_|IA0PR12MB8746:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b608fbf-fb5a-428f-91c5-08dee19c0fc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|6133799003|4143699003|56012099006|11063799006|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	bux7qwnPEaSVJc8ISOIMthqPu0LhA/rEZudXnF9fYH6KEsuaNA486+npTgsA3exjzdKGDNjuIb5opUqufiKGWXJZ/LNn3ZQGyokHFLpro6D5BxiWqKVjOgmyFObEytS0cNrVCbfZVT6D5apDItygKZlLnmztY31/F6YAIq5vrLZFrpHjnWz6yUs/8tAZlzBfqG2Wq4LvsvNGTAYhI9iYtOktVM1qUylO/SV11Ow+HTXkXOoXzOKbm4qtk1NzjK6CgA2e0+IAIrgZ2JIkMIozCKw0jG0MxoZzuOAlqIGBINELat8vuBnciwZ31MZoXVygDCRmXMDOSVPxZfI2323Nb0ghCeYk9giG2pGXD7W1kC0AA8CkBuqjVljwUPIHO/LIRoXgumw5TcNsKepmN+PYnxEtI4oZv3lr9rqwbDDug1py3T66I00mapXJhmpQ+xniUczH81HR88PLcKUsSnYhEwnWOcisjpiRnKsBEX3CqOC5UXgxyyMG9ZxsZhRvDEpzexdaUgxq6VjO3Yq8m8m1w8Rhgqs7AqETWgdTiZXVzFYXjQFHmdC2l4MMe7/UeDJeKoM38JbByvwDU10k1PDnGqJB+/2s0hELnQSIbsM3jRoQ/iT8bgwXiKkkeutGgKM5BWVwcAJk4xqeKUxSt8PNf31pOvmr2MmoHqiCEqwRmCnpjNQfkjBBzGriZpCjTXPsK11/2HcPSzMgru2hTf6ziA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB5001.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(6133799003)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SU16UEVlUkdxWXFNcDR2K21xWTZOa3BmcURqMUl1U0NtU09yN1dQblp4SW4w?=
 =?utf-8?B?Rm50SHFyM3VYN3EwS0xuT2JWRXM5WGJmS3FIdXF6UEc4RFZIMks5d0xLeGlU?=
 =?utf-8?B?MnlDaHNydElkRjhpNkt2TElDbkZIMTR6QktZVFhCVEZhTEpSM2Q3akI1VkY5?=
 =?utf-8?B?YXpOTy9mVWxRTERrN1RVTnJWbHp2OWc5MURPMlRJUXk5Nm5yWGJveElsdFMw?=
 =?utf-8?B?SCt1S1RNd1NVVUVrMVNhUHJHdm5lSnJCTXphK255dXpydjdScUZHdFFpbFZR?=
 =?utf-8?B?RUZQWHVzdWVmdHZtZmM4RDZQVFNnY0x0bTRtOGZtOVVKNVV6amdFZnkxQ2N2?=
 =?utf-8?B?WGloYUYzWk8xdGtSbkxFN3YzT0FDdWRVa29GL3IwdFhOTnV6UjRFYmEyc2pa?=
 =?utf-8?B?eHFQQlRWU2t2Z0FUSHZNTTRxbGdlb3MreVpaMmVJdTkrb2U4N1JwdmJLNnJG?=
 =?utf-8?B?b1ZUT1V4MDhNMFZkemkvSnFsbE50OUFFdXVucCtacTlNSHdLbFBycGpwVFpM?=
 =?utf-8?B?dW1FWWExN016c3p5dHpXd0NxRXRCM0FpbDN3dE5Jbi9OVFpSMTMxTVJhR25y?=
 =?utf-8?B?Sjl6NVBnbEc3UzIyU3dpZng0WWtUVk1qay9MOEZnY1RwM2I1ODJDQkh4RUdv?=
 =?utf-8?B?YnROMEFVK1pVeWRRdGFNZklDYnBtdHhlRDkvYWZpUU51RUk3YzdiditqQVRo?=
 =?utf-8?B?U2RxMDhSOGErYXRGeGNpbkJwdTlLangySGdxTkpqMXMxdjZWY3U5aHVXejhE?=
 =?utf-8?B?YnJ3aXBNMk4rSER6Z2MyM2hxY3gwU1RzdXdWZ3lRdEI5MmY5Qk1ZMnJmVmRu?=
 =?utf-8?B?d3NjTzVWQ1NIeUdJelBrZmpGSk5kR1F2b0VKWklDSWhLUUtoejFweFAvQnlY?=
 =?utf-8?B?RFZIcXNLV3llQWFkVWNTVVU3UXN0cm5Xc2FLRGNZdjJ4VHVVejNkRmJzbSs5?=
 =?utf-8?B?bm92QWFzc2krR2hEUExFcE9NMmhKWi9wc1FnNjVIdFExcU1seEdaRjZXWUpn?=
 =?utf-8?B?QkZmUndabnBsa1hkdnVQRld4Qm1IZXUyL2tabC9XOFd4L3hyWHUreXJCdGdk?=
 =?utf-8?B?VEZIY2ZRdTkwN2lyemxZNGtDRjNYUm0rb1lJVjB5WGR2OE8vTHhSMUJGalZp?=
 =?utf-8?B?K1lnZTJwbXFOakxaZThrVThNNUYyTCs2WmZ0WFRxQlRJRkNLa08yR25oaXhw?=
 =?utf-8?B?YmZmTnY1MHEvb2lxcXB5Ukptbkg3Vm1OWWtrQmkwQlh4WWRmTkp3czRsK1c4?=
 =?utf-8?B?eXJEZHZaRTRRRHF3UVQzL0I1MEU3cXNMM25mWUhxTllUZzdMTEVMVjQ1M2Uz?=
 =?utf-8?B?SnVEc0hDTlhKQnRvK0JwMFdhVnI0V3dUVUE1Y055T2Y5LzNTZG8wT3RNaWNO?=
 =?utf-8?B?Y0hIQzhSN3V5MVc5eE1CaVpWUVhFcVZsMlhkOFpsSUtMNVI3cHhRZU04Um5S?=
 =?utf-8?B?QytEVWZGNnlDMk9YMGFBOVZPWk5ZS2RvUlN6SWlqSklOUWRVNFFkdmZtb3dk?=
 =?utf-8?B?bG1XSldraUhNREJ1TGc3LzV1TDNyNHIxdEMvL1Myc0c2dVFMeE5pTzIvSVRQ?=
 =?utf-8?B?M3B5UG03Zi9ra3p0cU1LZTBrNWU4TU9nQUkwbkZiR0l5eHgyVEQzYnhRZGpU?=
 =?utf-8?B?WG1Wc2o5TitTUGtDdmREQ3RIUTlQQ1RHUXpsd2o2Uy9uSlU0R2FETlEzbndo?=
 =?utf-8?B?enA1V1g2azNNZndNZCtSUGJNUDR3UWhqcW9JcHdudmFFejNHczZyT1VQL1A1?=
 =?utf-8?B?alo1MWl0QXlOcFFnbHBsZ1plTGRwTlRTRk5hZWVkN0JEWGplVmJFa3A0RTZV?=
 =?utf-8?B?aysyRTdEaTJQK3V2Ung1ZHpCbW5ZblJ1WU5HUEZhZXBjVEhCaDlnYXJFTEE0?=
 =?utf-8?B?VGlBczJ6TFE0ek1wREg3ZlEwaUJZRWw0N1gxZWIvR1FLbG5XN1J3UXJTTFhU?=
 =?utf-8?B?TG0yYkV0ajJEc0VOMWNKSGlxdzlFYnJuMDRhWjFtWVhQeUFKd1Z0dXk0dGdq?=
 =?utf-8?B?V0R1UURuWjFvajhnQVplY1RLckVOV2lhRTRPNE9oMHFUUThtT05TeVA1QXJD?=
 =?utf-8?B?Nk5CQitlVTh4dkh5bWtScnp5V25GTTF1U21Rdm9Zc3F2aklxUGFmMjVvUDJL?=
 =?utf-8?B?SXQ3Y2VHMWdaSmI4U0RXeEZ0akNMajRXUmtkVklSSnlmL05kZHQ5WUY5bU5E?=
 =?utf-8?B?bHJJNDJadGtmdlIwUTNlNm1XMVFnb1ZBeDl6QXpWTTh1NnlYQmpScExzSmhv?=
 =?utf-8?B?cmdSMGFBUzVsWndFZ2kvQTNCSk1BTDBlVlhPbGJGSmd3S3VaWnQzUzFxMkFH?=
 =?utf-8?B?WS9UdFJHaGM1eDJyQVdlb0owcHc4UGQ0aVVhMERyS3R2RlQyZjNjQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b608fbf-fb5a-428f-91c5-08dee19c0fc9
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB5001.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 11:35:53.3096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dMKCSbwsVc8DMIiesXdcadp9a0aLX9XDL5oKSgxdhR/j8X21FGir3vulJo+pG/VjWWAYZyrCybq1R2Au/ej0pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8746

On 7/9/26 9:25 PM, Li Zhe wrote:
> memmap_init_zone_device() currently mixes refcount policy and core
> ZONE_DEVICE page setup in a single helper.
> 
> Factor the refcount-reset predicate into pagemap_resets_refcount(), move
> the common page initialization into __zone_device_page_init(), and wrap
> the existing slow path in zone_device_page_init_slow().
> 
> This keeps the slow-path behaviour unchanged and gives later patches
> reusable helper boundaries.
> 
> No functional change intended.
> 
> Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  mm/mm_init.c | 56 ++++++++++++++++++++++++++++++++++------------------
>  1 file changed, 37 insertions(+), 19 deletions(-)
> 
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index 95808ab5cfdb..5fccfbacf855 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -1005,11 +1005,37 @@ static void __init memmap_init(void)
>  }
>  
>  #ifdef CONFIG_ZONE_DEVICE
> -static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
> +/*
> + * Return true when the free path for this pagemap type restores the page
> + * refcount to 1, so memmap_init_zone_device() can keep the count set by
> + * __init_single_page(). Otherwise initialize the refcount to 0 and leave
> + * it to the allocator or pgmap callbacks to raise it when the page is
> + * handed out again.
> + */
> +static inline bool pagemap_resets_refcount(const struct dev_pagemap *pgmap)
> +{

resets_refcount reads like it resets it to 0, but it could be just me. How does
pagemap_requires_refcount_reset() sound, with the value returned being toggled

> +	/*
> +	 * MEMORY_DEVICE_GENERIC pages regain a refcount of 1 in the free
> +	 * path. The remaining ZONE_DEVICE types start from 0 here and raise
> +	 * the count again when the allocator or driver hands the page out.
> +	 */
> +	switch (pgmap->type) {
> +	case MEMORY_DEVICE_FS_DAX:
> +	case MEMORY_DEVICE_PRIVATE:
> +	case MEMORY_DEVICE_COHERENT:
> +	case MEMORY_DEVICE_PCI_P2PDMA:
> +		return false;
> +	case MEMORY_DEVICE_GENERIC:
> +		return true;
> +	}
> +
> +	return true;

Shouldn't the default be a VM_WARN_ON()?

> +}
> +
> +static void __ref __zone_device_page_init(struct page *page, unsigned long pfn,
>  					  unsigned long zone_idx, int nid,
>  					  struct dev_pagemap *pgmap)
>  {
> -
>  	__init_single_page(page, pfn, zone_idx, nid);
>  
>  	/*
> @@ -1028,23 +1054,15 @@ static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
>  	 */
>  	page_folio(page)->pgmap = pgmap;
>  	page->zone_device_data = NULL;
> +}
>  
> -	/*
> -	 * MEMORY_DEVICE_GENERIC pages regain a refcount of 1 in the free
> -	 * path. The remaining ZONE_DEVICE types start from 0 here and raise
> -	 * the count again when the allocator or driver hands the page out.
> -	 */
> -	switch (pgmap->type) {
> -	case MEMORY_DEVICE_FS_DAX:
> -	case MEMORY_DEVICE_PRIVATE:
> -	case MEMORY_DEVICE_COHERENT:
> -	case MEMORY_DEVICE_PCI_P2PDMA:
> +static void __ref zone_device_page_init_slow(struct page *page,
> +		unsigned long pfn, unsigned long zone_idx, int nid,
> +		struct dev_pagemap *pgmap)
> +{
> +	__zone_device_page_init(page, pfn, zone_idx, nid, pgmap);
> +	if (!pagemap_resets_refcount(pgmap))
>  		set_page_count(page, 0);
> -		break;
> -
> -	case MEMORY_DEVICE_GENERIC:
> -		break;
> -	}
>  }
>  
>  /*
> @@ -1090,7 +1108,7 @@ static void __ref memmap_init_compound(struct page *head,
>  	for (pfn = head_pfn + 1; pfn < end_pfn; pfn++) {
>  		struct page *page = pfn_to_page(pfn);
>  
> -		__init_zone_device_page(page, pfn, zone_idx, nid, pgmap);
> +		zone_device_page_init_slow(page, pfn, zone_idx, nid, pgmap);
>  		prep_compound_tail(page, head, order);
>  		set_page_count(page, 0);
>  	}
> @@ -1126,7 +1144,7 @@ void __ref memmap_init_zone_device(struct zone *zone,
>  	for (pfn = start_pfn; pfn < end_pfn; pfn += pfns_per_compound) {
>  		struct page *page = pfn_to_page(pfn);
>  
> -		__init_zone_device_page(page, pfn, zone_idx, nid, pgmap);
> +		zone_device_page_init_slow(page, pfn, zone_idx, nid, pgmap);
>  
>  		if (IS_ALIGNED(pfn, PAGES_PER_SECTION))
>  			cond_resched();

Balbir
