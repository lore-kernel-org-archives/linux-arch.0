Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011017.outbound.protection.outlook.com [40.107.208.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC292D47FF;
	Tue, 14 Jul 2026 12:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784030966; cv=fail; b=UBmpdWVBa6BecJ9mTtriCv0GSmodnCK81HG/qiDvbsF4vPmhv2d+isaE+eDFj3MlUgoLvFmlRXK0JCTJV/xtMQ8FOzyeFBBcxp/s1Yl6iuNyFZCEtdqNnbOOJy1OVWL6UJgL+KfqmWlg2V7kWosZQ60p0cHHtG/SfvUuWPUDT+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784030966; c=relaxed/simple;
	bh=NzOnEjtYI8FBawQK1dEsjiKTscYAMFEsgdA62wxgn0o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WB7+Azv5FYV7zw1FMDwTyL7ATVpRkrL7/ROk5tABILRySrDytj66j+Moe5pOL1CBOHVj2ehRaq5xN3cWYJTp47MY80fqIUt7nAGolDXToRaFpkiRMb7mW4O5U/uuFNfNwa5UiL6HMEfc6XoUIq1SZYKe316kr8me3I97lvMOXJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QSix9szY; arc=fail smtp.client-ip=40.107.208.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QSix9szY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L5AQyYqMSC5+uBcVQH2krfRP7iej0ixZJIummJ/rTvcj2JdAiLoqTamiCJKCtErIbfqlGOwCUoayY63/Ht01ZZ8KbNze8niOIfjMcwBgMt36afHO+sdmgE0EPGEA08Z5GEquy4ZzHQifZH37ZsbWqrwuLJ69/Dv58TResD+rm514JoMhQ23fJK8rpEo/ENEknzW61S7hdBInakGdt0Hn//Nu3g/EAW68cmhzpQbVSSHoWQwibPaa63HVKaKH0aApcgl64N9qybadmFt7MEmiV5gsana5wrliwjOBuKgPMTIZ+dw+pWetYAf2pHXo2k3CU6O4JjE7qkJGB+UheFoR0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tB1E8AflNK9lYSQiXymfQGGwDjrSU4Xu8+uOqchFgOE=;
 b=BRyM9usouIp2GjMczGKY12toFZitZDS7V/vxbRRc9QfHJGVM21HS0as9mrwats3wxLcWvWL+tff4EyNpvSNvhs01yMyG3jqwEyJsTPapGj8sJwIdTFzBl+JyWsaqloOQJizDDz5wrCCnvhJkjKX4A2onSPEj4YOz7Q8WTFdiRw8xTf5lWO3KA4Zud5lrEVArJJ3965WF45kwwIeaEH9CGIeotVz1MmC1ln1Cg3mB0RU4vgE/98dwF9XB3+F1dv/lG5LfublxZGS/VT4L+KfVvf3qtLsrmAJRaAaMepBuGX7Snh71Z0RFR+LvtLpPk7xuDNKizmDXQdhbWC1AidRZpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tB1E8AflNK9lYSQiXymfQGGwDjrSU4Xu8+uOqchFgOE=;
 b=QSix9szYZwEOqpv9KmKA+p3fx/eOIhaPP5YfXMqA0+12bJaPaXSmGOK805ZFqsPN/b3RAxOuR5iMOxxTZxpet0YD/oxgWK6nJG/vg/N7ihHtMcML4m+DFx7ZlDlYeGuNXnNtysLJAeAhEF79sDK4MRThayITU+eVsgYdgqfrQDkkIK0K/bSRKR7DZfJuxF3yJsPLzXI/fRlDT6J/vxKvbW17SazYjCOAW50vB8IaCmvTiEtHC64BhjbpmxEQKzaxaGNn9N7wqRyNlV6egqe3AVuBP5b2HQJT52d8kzK6SOMMSo/LQ/g4bGBu8mZWCZCuNQitYiU7/Z+cJ36hiEyKlw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB5001.namprd12.prod.outlook.com (2603:10b6:610:61::18)
 by BL1PR12MB5706.namprd12.prod.outlook.com (2603:10b6:208:385::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.9; Tue, 14 Jul
 2026 12:09:17 +0000
Received: from CH2PR12MB5001.namprd12.prod.outlook.com
 ([fe80::89e3:6df0:de90:8dfe]) by CH2PR12MB5001.namprd12.prod.outlook.com
 ([fe80::89e3:6df0:de90:8dfe%3]) with mapi id 15.21.0223.008; Tue, 14 Jul 2026
 12:09:17 +0000
Message-ID: <5d9e8ff3-49fb-4ece-921f-a59214973894@nvidia.com>
Date: Tue, 14 Jul 2026 22:09:08 +1000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/8] mm: add a set_page_section_from_pfn() helper
To: Li Zhe <lizhe.67@bytedance.com>, akpm@linux-foundation.org,
 apopple@nvidia.com, arnd@arndb.de, bp@alien8.de,
 dave.hansen@linux.intel.com, david@kernel.org, kees@kernel.org,
 mingo@redhat.com, rppt@kernel.org, tglx@kernel.org
Cc: linux-arch@vger.kernel.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
References: <20260709112520.24857-1-lizhe.67@bytedance.com>
 <20260709112520.24857-4-lizhe.67@bytedance.com>
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <20260709112520.24857-4-lizhe.67@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MEWPR01CA0034.ausprd01.prod.outlook.com
 (2603:10c6:220:1e5::13) To CH2PR12MB5001.namprd12.prod.outlook.com
 (2603:10b6:610:61::18)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB5001:EE_|BL1PR12MB5706:EE_
X-MS-Office365-Filtering-Correlation-Id: 47a85bfb-60fc-43d3-dbeb-08dee1a0ba0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|7416014|18002099003|22082099003|11063799006|56012099006|4143699003|6133799003|921020;
X-Microsoft-Antispam-Message-Info:
	7LMjloBgAk7EriW6tQDf8f/G2Pqc69wFXvG/7+CvrX+2VlcNehKsgmMIJk7KjAOxdwQJ/fC1MVhnmDVeOfXCcZH4WuCof3UOg1FDD/P0Sah1uLYYcP6BpX1ovdaM1j+/ErZ1kb2QhCrWHPYH5dCrKoQC/u6lgNFWJURZrAZ7o6OUPS6lmGzeUy4z85T5z2Le42gOuHavgCKhFkOTq2FrttCp3CeRBLh+gWEmUsezqWAuQK2/7li0W2v/pVZP2AqpwDQZN6wLX5C5Us/s83OqGxAXmDDzgn8vdvVBcF1RA7xAByFrZdNTWzMESAWuNaLmETalFWdBK7brJ2xpr32hh6akofQzI5g9Pz3aZgYSy4Ju7ZqLdf7ApqQMIVmxcbyn6FO0Tcbb6EfpZ6gWHcbQvDyil9V2aPm/2erNWK/cOMKjuoCH/B4t2JwXO7UcraUE4m1lDgtUqitA7ty+BwRTMyZK+QiJjKzHEnjWmCZHjVwoQTTNavKTuSpLlUX0altjiKgGRrqVM9sVAJgJZWVikexQ7FlwQdFh7ryZOqpmmGBS9zGD2dTPACpRGNL6KiMiPbBBKnrfs0V0RbzQJo43Nrp8gBIGqIJ89dTAP6iGF4C5VazIVeoGVPlHkHuCadQ8u+DLPQvUukKRcdyoA2IVqasit9qPZXheqVlZFZja1NMlxJsjXSgeIyCNIJwDIx/fLpvQO67Qs8jvhKPkG42Oog==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB5001.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(18002099003)(22082099003)(11063799006)(56012099006)(4143699003)(6133799003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aGFPRVQwYW5VTXFZTktaSmVsY3l5ZEhCOERQeDBqUGE4L1RMb3NYeWhiS1Bz?=
 =?utf-8?B?cFNoTTJ1NjgvRk9HWHN0ZUtVbGh1M2tTbERRVlhjRjZMTFNEL0x5K044YjBH?=
 =?utf-8?B?OGc1aXdCeVU4dUV4cFVDenRwektqSEtSeXozYzhTUkdFUGErS0dhV0YyU3Zz?=
 =?utf-8?B?OFdGdm5yOXFLWmtibU5JYUVzMEF0VG1VN0Rhd3lEd1dVVGZndWdLZlBadDBW?=
 =?utf-8?B?RzluaVFwb0ZZZDBvQmNPeS9jeUZSVXhxYk5mZW9RN0dvb0VsVmJ3cUVZQkhZ?=
 =?utf-8?B?aFR4LzhKck10cm5zM0szdUk3V1ZUbzIyaVBORkVkanNGWkIrcXpMZnUwWGVG?=
 =?utf-8?B?MFFITnNUUjVpVkQ2cHdvUkZlSGpIdFRUSjV1L2tyTmtsRGphNUxORkZZVDJ0?=
 =?utf-8?B?L1p1L1p1V0U3SG5tN1ZtRlBFc1hwNno5QlVQYUxOczI2MkNxVFVuaVdlRU9z?=
 =?utf-8?B?WUJoMTFZL1ErUjFSN1dXVTdMWFhSWmhvQ3o4ZFZjVnZSZ3prb0wySDhrTVNy?=
 =?utf-8?B?enJ0dGRmM093dlRKdGlPU0JPdXpEQXpvWUpnOFNZbHhCQ1Ntdzc2MGNBMjFk?=
 =?utf-8?B?bFpnVmhsS1djV25BSVFPd0FZUHhrTEFEUjBFNkxaM3hHUE5OWktqQzBtQXZy?=
 =?utf-8?B?VEtzemY5Y0phWGlTcVVaMFc1NFZTb0MvWTYweHdDSURMTlRtVkd3TE1mOFhu?=
 =?utf-8?B?U3doVVZjby95MGxkeDExQ3dOeWk2WGdkWVpoQUthNVcwUU5rWGkyWm5GWlly?=
 =?utf-8?B?WEV3bzliditndFlFa1l3YlhvaWpmRGE3NEZHRll4WnZ2TFgyQXlwTjQ1WnpK?=
 =?utf-8?B?emhrMm8yU1pneFBpZWZRaU9GbGFOTXYwOFRheWQzRitCSEtiSmFmL21UMGxi?=
 =?utf-8?B?dXc5cTJKTy8vVFRCcmgxUVBUQlpNTThtWTVEdE9zNXRpNGoyUTVsRXdmV0s5?=
 =?utf-8?B?Z3F2YnpWNFFWSEFCR0RjanpPaDdxWWwxWlpvYzJBTG5mTkhhTmY0THNFaklT?=
 =?utf-8?B?S0dWTENqU0NvdFF1VmZTZmQyeEJlRjVxbUdlZUk2MVRxbDJhb2pWeXZmRndr?=
 =?utf-8?B?YUFiakJIUHBwRDlqNnRobUsrMHljNkxJZzdDOUdCYWFjM2pxUnNlU2MrWVhK?=
 =?utf-8?B?V1FHZnJnUnZqS1FlbHRwSlFLVXVKeEVlWDhlSGlYVXMxczJ4Wnk2TXM3WG5B?=
 =?utf-8?B?K2R5UzRsMWRTNHh1bE5seml3c3FLNk1jcGJLNTVlYjZ4YWtlSUFWMXhuS2Rm?=
 =?utf-8?B?NXFRN1lsOGZJZlNEQXRDWmk2c2laMEJHOUo4aVJDcWpuRmdyVTBKZEhYc2ht?=
 =?utf-8?B?UzE4ZHhzcUltc29RTm03TjQ4RXE1dStpeGVYVks4enN6bnRaM1FnWTUyVEFE?=
 =?utf-8?B?bHE5d2JobzljbUNSWG8zeU4xSFBmQWdUaHpCbGx4ZzI5dG14TXJnQmplR0RM?=
 =?utf-8?B?Y0ZBOHFNdE85UWxGeVorZy9sbXFxOFZBdjJ2Mmw2ZDNHSi9QQTl6a2FnTURG?=
 =?utf-8?B?NVlobjRVUU5acjlnalBaQUdEWEJNTmdQY0w4RTQzaFZ6NFNnM1dpMEdGRDlK?=
 =?utf-8?B?MitHb1VaM0N5cjZrelBsTU54QW8wb3phQUVaOGVoWHl6VStrSUl4ak80ZDFx?=
 =?utf-8?B?YWwrbnAzQWJuK1VmMEFVUkdnRWJGU0tCUXQrQytsOGk2YlhLTDV2QmkrdkYw?=
 =?utf-8?B?UTVRNkV5elZTR2x3NEZodXpIUjFEZW1HNXBkb3EvdFFoL1pZRWpYT3ZKZ0JI?=
 =?utf-8?B?L1dkVE5DQjNYUjY3R0tHdWR1YmQwamJCcmU5K3VlYkNKNWs5WmJuSFA5ZmxK?=
 =?utf-8?B?V09nUzFVbjNVajcvY0V3Mk5pS1d5bUUzcktWNCtFdWRkU210cW1obHNtV3VM?=
 =?utf-8?B?Y3Bhem1UeWpKUE5NSks1SlZrWlZiQUdPYTdlZzczSVg5aU01Q2dHQjNNUVpJ?=
 =?utf-8?B?Yno0eTcxNUFUdWlac203VExXRFZZaUYweHQ3eW9ZcDd2QVhHZjkrUmdSdnNw?=
 =?utf-8?B?NS9iTW8vVU9EOXp0cUFDZFN3WWVIaWdmbjdWZGdscXhEemRMcU91VzFNSVdo?=
 =?utf-8?B?aGZlM2t1eHA2RmRmZEREUjBIa2UyaDg4ZUtYYXNUVjg4eGtJYkFqRzNsT3BZ?=
 =?utf-8?B?OG1DQ2FOVjF3aGRZWS95T1JjWG1LWlMxQzBKUGZ2UFd0Z084UXpkYnVFVzVv?=
 =?utf-8?B?aEMwWnhoTkdLeXRqbnFTR3NZbmxzL05CQXEzTVgxQzRJeUE5dVpFMDdaTW4x?=
 =?utf-8?B?NGd3cXF0Z0lTVDVBZVNxWEQySVBOcHVoL25sMnNaVUl4WUlRd1R6d09zc1Rx?=
 =?utf-8?B?ZEVHWGJsT1hySUhTOGU0eVFyRzNScUNkMXlyUzVFQlk0cTZCbGtsUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47a85bfb-60fc-43d3-dbeb-08dee1a0ba0a
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB5001.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 12:09:16.9869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qv1bGZWjOjRJwqguu5BMULhrLTi1p5h6vhEaksExy5pVuL0qXKF3Dc4SOZgKashL3iSDmt4rl4RSWLdpuDeb0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5706

On 7/9/26 9:25 PM, Li Zhe wrote:
> Callers that want to update section bits from a PFN currently need to
> open-code:
> 
> 	set_page_section(page, pfn_to_section_nr(pfn));
> 
> and guard that sequence with #ifdef SECTION_IN_PAGE_FLAGS.
> 
> Add set_page_section_from_pfn() to wrap that update in one place. When
> section bits are stored in page flags, the helper derives the section
> number from the PFN and updates the page flags. Otherwise keep it as a
> no-op so callers can use one helper without open-coding
> SECTION_IN_PAGE_FLAGS.
> 
> Convert set_page_links() to use the new helper so later ZONE_DEVICE
> fast-path patches can also update section bits without open-coding
> SECTION_IN_PAGE_FLAGS at each callsite.
> 
> This keeps the PFN-to-section translation local to the configurations
> that actually store section bits in struct page flags, and avoids
> exposing that detail to generic callers.
> 
> No functional change intended.
> 
> Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  include/linux/mm.h | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 485df9c2dbdd..43343bfce493 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2541,11 +2541,22 @@ static inline void set_page_section(struct page *page, unsigned long section)
>  	page->flags.f |= (section & SECTIONS_MASK) << SECTIONS_PGSHIFT;
>  }
>  
> +static inline void set_page_section_from_pfn(struct page *page,
> +		unsigned long pfn)
> +{
> +	set_page_section(page, pfn_to_section_nr(pfn));
> +}
> +
>  static inline unsigned long memdesc_section(memdesc_flags_t mdf)
>  {
>  	return (mdf.f >> SECTIONS_PGSHIFT) & SECTIONS_MASK;
>  }
>  #else /* !SECTION_IN_PAGE_FLAGS */
> +static inline void set_page_section_from_pfn(struct page *page,
> +		unsigned long pfn)
> +{
> +}
> +
>  static inline unsigned long memdesc_section(memdesc_flags_t mdf)
>  {
>  	return 0;
> @@ -2768,9 +2779,7 @@ static inline void set_page_links(struct page *page, enum zone_type zone,
>  {
>  	set_page_zone(page, zone);
>  	set_page_node(page, node);
> -#ifdef SECTION_IN_PAGE_FLAGS
> -	set_page_section(page, pfn_to_section_nr(pfn));
> -#endif
> +	set_page_section_from_pfn(page, pfn);
>  }
>  
>  /**


Reviewed-by: Balbir Singh <balbirs@nvidia.com>
