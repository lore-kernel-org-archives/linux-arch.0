Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013015.outbound.protection.outlook.com [40.93.196.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17D9372690;
	Wed, 15 Apr 2026 18:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776277815; cv=fail; b=iU2YOwrsAb+7IYNSYYymV05+/ideupTXsA0xyCDjRneGyeYgzMqZKuThplR4Ds2qJ00rUolXZ1BLgRKUS7i2ZyXnJ6AkwlraRMcOF8UA/EynmDn3dAVzmWY7ngrdSAmisS5qvgJTpo166ypeYk/gsOnao2TL8cF0iHouZUa0Mts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776277815; c=relaxed/simple;
	bh=IhnbmyRJOoZLgpEm5aPu4Oivi9Zsm+r/3jsdpzQFhOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YKGoz8sbxkAoYoAPAiPHN8L6Ujkx8CorzV4ymmBm4GgGnAnu4cojeCGGol9c43KlW5QgF+YgCFmkBbuWGJxhepp5EmuPkrnFJ4ITjCv1kmKeUUpZoyA4ZLgsz2qNg3O4ykmUXKcXSHOl2yQb36M8yq7R8PEqK2fQoFH6WyVZi7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rscyBUa8; arc=fail smtp.client-ip=40.93.196.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rscyBUa8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NAP55ZlkaXVfS/rfFIrWkMgtXLsfw9FmAwDgzTBgM1D/Goge3Ygbq6Xf+E2OBo9Y7rfHgtd4oo9wpd2yC7da01X//tlCy8JgPxsePIFkr7z0WSLV/Dh7PxMJFENbT16Ggglui/SiJ2uguXBfbQ9ojsSzPs+NbXbsBDQU1rqjhJsKEuMz1F2fXakdaFsc0HUGLI6m9uEq5W5DHZTOgBWclSUS+mqsiYmjRrx8MWz6recnQWMdBNqFh5NY9iWV4Eq8wRzT2qCyyN8myr/UgdyoHRflNeQBzAgz26KEDcmOjMEQ5ezFIG43RG7E2pCgNF7FaJ4VODLGL1S3Owp00yTlSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UvuRmm20V5jNhkenVXifmipWQABsWCdq5vPxEe8422w=;
 b=K2nx3/fEL8lSlBg50cRGqmgSYGypbIg3S+HW9RZ2c4nU9L/R5+09G2T4b5FloFsODp1ZVIcfK2R1vyv6f59DeJcLTUM2Ea0HmW7e7VBjrKWt0y/azHXyYVYsj5eh7aZbD0PJhWYsTgnq8T1QvXBF3odSE4aI+SUmILq6qbfQJOlf3WLafygnAsbvEKipoCKghGvCIV2dmW7MpmxoWxdnzuW8mXQaIwYpCTOenspUtb3AN0B/+mBFqck72xR/YNvT0pU+ew0RsU/zGoQhiACKU4G0FWs177fQ0rgPpoQ3fyYK8BDqw/luWn2hCsBg/Zmvh65Mj5pE0oMu6rOA/QaGPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UvuRmm20V5jNhkenVXifmipWQABsWCdq5vPxEe8422w=;
 b=rscyBUa8JsbiXL69ALkRHnH/9VLDan9j/03c2r4GWzmP+TDEWIr2Bvh++ch5ONIfylSegL4ITyQVDznw+kc+emCPK/NptzZX+CR+Qsds9o6NUCMX/pxOvslReoCs8F31nhrAQ/N3mQgUiq6akSb+QGp+qgp+WSHll0fxd5Zszjqncc/PHl+8NL3otyuRy4NSfWTdGvgel132UEfQSwa+QHxQuoHjEjoUV4FwSx8uemcaJr23kZYS8C6+wdCEq0mBkfXWfS009S8bctotctCaFIwV7hADoGH2y+3fB1XHkDtI99v3Jkp/C3/TttGO2aPDwmt2uuZrBO9oCGTx8MwvEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8300.namprd12.prod.outlook.com (2603:10b6:930:7d::16)
 by PH7PR12MB7332.namprd12.prod.outlook.com (2603:10b6:510:20f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Wed, 15 Apr
 2026 18:30:07 +0000
Received: from CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de]) by CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de%3]) with mapi id 15.20.9769.046; Wed, 15 Apr 2026
 18:30:07 +0000
Date: Wed, 15 Apr 2026 14:30:04 -0400
From: Yury Norov <ynorov@nvidia.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr, yury.norov@gmail.com, linux@rasmusvillemoes.dk,
	arnd@arndb.de, cp0613@linux.alibaba.com,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: Re: [PATCH v2 1/2] bitops: Define generic __bitrev8/16/32 for reuse
Message-ID: <ad_ZLNslqjpYRJvW@yury>
References: <20260415093827.2776328-1-ruanjinjie@huawei.com>
 <20260415093827.2776328-2-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415093827.2776328-2-ruanjinjie@huawei.com>
X-ClientProxiedBy: BN9PR03CA0466.namprd03.prod.outlook.com
 (2603:10b6:408:139::21) To CY8PR12MB8300.namprd12.prod.outlook.com
 (2603:10b6:930:7d::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8300:EE_|PH7PR12MB7332:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b9d6fdc-f3e2-41db-782d-08de9b1d051e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|10070799003|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	PO82sfWyKags7px1yuz/ZApKj62nuyxeNrbwZSnU1JVzwEcPK7sX4rUIpxPIQpiP77uujn3bpl0gLRE+XaJzFjkEcJOW1jCV0fqZnOzKXmuitqGwMU/2g4jph5lQMR3yXcPJvpXsuCO/+KX0erK8OyFGBnEHPQgxKBQUeb92gfZActMqU6pTt6F/t8+2DCOyRSxc5uSqXuZL+qm8X7/qOJfIhww4QZsrRz7Au7QHABd4Qe6TtZjaFFNvoNVicZcsBkQNfY+Xx95X4nCou1TXBIhciW+oaiICm8pmyMokofPPQTW0AxTrakMe8O5xB0GACnxItSqwi9QSWzW6ATAzgKlG9AHQqH71s6bC72t75VFDkN+XEJHLkPKWefsH0L0o9XI3Z1qknM8yE+dZ+Tj6vYOpFpxhtBWN91qmb+AVRmlChVBp4DGCj/gzfCzqtaArsSkNzp78BDPCe3j/PABr+4IUsUrZlDk7SjyMKG9OmG/eKwdYJzLMBdEE5k4pJPJErVdFca3hm+kcH4QViJmnL79uint1v9R6ngFzZF4+VvrTIDVJVi79IXydVc8bXQumQXaK0g0uHy8Pgzf8zlyhPz6cuu/cu1YEwmdggD5UYFTflTLiTBZNw3pYrLnz0I/lXOhPK2ojEQ1tlAWAQsPpDRgcdPE1ReBhZHWtm4omkhIojsOVF4ZBS8DQAWv4iFTWPjD9CkA4M52p4FFN6ynZmm0uI55eduEtHEbCVpADkFE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8300.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(10070799003)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ybPDHxp5fHharUs3YbSv5b4ZpgBXA32I/bSieylLjD1Qr3K5VDheKsgkYfr6?=
 =?us-ascii?Q?EZNFKASKQQJUNZh6aTDFHXUI+8Dd6Z0FuMmnJKJ7wj4wBSCoAxjD3coBvFEF?=
 =?us-ascii?Q?NDTpmNoR2hnwqx+4HAK9lRzcyXZxSVtDx1SOFPC24G2GaqqkFwmrSt3tt5OE?=
 =?us-ascii?Q?5HjU2kdLcEVdAFk7Jo/GGi1yT5BVag7DdGm8Fl5HpcDXK1+zLw1JiyCPPEbS?=
 =?us-ascii?Q?vlL0GbSBy4xKE5M5i9FC8m105nX0gviStb4LMvoJkAKThGVoHIy7JCv4Z+WV?=
 =?us-ascii?Q?CdrqImgRPhhMQdpuTqFRV40Y3ND58noOc0MEmAuattfzh5nbAZIaxSQ/U8Ds?=
 =?us-ascii?Q?jMDNq4PtLr7nocalJ8AgEnKlo1GB8tJjv3FGw2FdVabbyDe2iz0w3JY0b/Hp?=
 =?us-ascii?Q?TJiPGvd/WcrGkMAJGTFsG5v7Tmj361zf/okDYFq5z8UacvKLTHJs+oQpMZ34?=
 =?us-ascii?Q?gAJRv3IPRQgIKv9NBlB4nq2edjeNKiT2TgBwAUfyDqdcuFzHRwheA8jyx3RN?=
 =?us-ascii?Q?moppGsHHSBbG3Ba80poHGnJ696KxNPTfbM3PugRD/+/V/H7lpr1sreMEfiaV?=
 =?us-ascii?Q?CF/YAKxK4WWV+WDk/RO6PBb7ruTteCQ85PGl+dMzBmBx/9EuSIDg5gu+pKCN?=
 =?us-ascii?Q?x3SGIYy1sJl/18qLHjd4pqn/X0b5N8kLtGvZHPl3nEoQ+NiOtrRMRGep0wt0?=
 =?us-ascii?Q?KAFsjNwyW8rgMa6eox+HOFkavoz90L7HoheTdazwSXf4C8BFhlQO8UH337eU?=
 =?us-ascii?Q?CJGdMnMuQk97ndxBpdFDAmmBYTpz7vl8RyyB+bAY3mjteOjCb0j6jgrkT8ys?=
 =?us-ascii?Q?g9Lp/f0Yh28qZPdf9VVkHQdqXMtfcqhVmGBW4DjwwAU3bjP8ru04ncZSSOkB?=
 =?us-ascii?Q?QgA/JwWRyxSdDtn/S0UDspaq9Y6sxxhbMoO9AuqaqFFWeLZ3H4f/pYNhCMeE?=
 =?us-ascii?Q?Ox+0y3lgJ0Ma7TO6TrKosyEQ0lSMbviaAD4tjlXjVMhoXHuUI0q3dHmv5S65?=
 =?us-ascii?Q?8fIgw8Ld1YRES8xzLM1aVOdv/EaRW0NtkKcNDlZA9S2QH/nk2nRL0VSVkP9O?=
 =?us-ascii?Q?LPg8+2ZW7l/tpynQPnEECn+mBBk/8YQhHEiew/cJJGhMddwQvgykeRse8KIF?=
 =?us-ascii?Q?33YrM0MbF/jIALJaBBawxIHy1Zbo2bOxbdhk7ehtjCBgP0P0hjsg0eZonTPE?=
 =?us-ascii?Q?uhTap4HHMPGjOoj8furJ/LnqWiYNCBmADtC7cfc+S9Oraf1ySKeEnmU8ekgM?=
 =?us-ascii?Q?rUNxglZTa9T+UpB++Zej7A6AvOHUfh8giggdfxD1AnbtTDntk8dhREoeEmoy?=
 =?us-ascii?Q?XLHUTzSjVrsaabhfaQy4LveIpaEh2+dk+uNffHNJX+d1LCZK09cfnipOQIAV?=
 =?us-ascii?Q?PiEb24UXN15dqK2LJ3z/JKQI4vDtMVfktR2vpoqINshgrtWQti9I3jpG/mgx?=
 =?us-ascii?Q?dvv4RIu2yBh6kTUdLPgSc3quet2tObvWVn+YkgnHwvEiV5XrdR2bveEddwRR?=
 =?us-ascii?Q?8+z17nETCLx3folpCTtqKwUVcmSKiWHFmcY3QgMTL3iWR7feY5A2FtoZ2bIN?=
 =?us-ascii?Q?t1taXYmWKfN3A4Ejw6bWOqOVhu8Kqf6ggCPccE8TPGg8P0bRkP1hoEFCIxpX?=
 =?us-ascii?Q?KxXveLYOWgiTNqz5Sihu3Z2VOGVLGK/5G8CsM/IN9mhwTuBCmCmEMJish4bB?=
 =?us-ascii?Q?YbssmCzcU4T+/7hupVdHNVLziFGLTlp+Sv7Dn8OBQSyEcKw9VBYs2c9vinHX?=
 =?us-ascii?Q?jfKyVhmbsYFLEMehCQvUyOnm1qIKwmDjn1NLnV6Y0VZBVW8tEiLP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b9d6fdc-f3e2-41db-782d-08de9b1d051e
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8300.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 18:30:07.7473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IzNAPRd6MR2Z2H6bGtvvpTmpeO+2ggHJEgbel5DSvUhgXA0v189lPIDGOWTqdyz1jwbj58vbtGlT+9VSvlZHOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7332

On Wed, Apr 15, 2026 at 05:38:26PM +0800, Jinjie Ruan wrote:
> Define generic __bitrev8/16/32 using the implementation
> in <linux/bitrev.h>, so they can be reused in <asm/bitrev.h>,
> such as RISCV.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Reviewed-by: Yury Norov <ynorov@nvidia.com>

I'll take it in -next for testing. That would help to catch some
probable warnings discussed in the #2.

> ---
>  include/asm-generic/bitops/__bitrev.h | 22 ++++++++++++++++++++++
>  include/linux/bitrev.h                | 20 ++++----------------
>  2 files changed, 26 insertions(+), 16 deletions(-)
>  create mode 100644 include/asm-generic/bitops/__bitrev.h
> 
> diff --git a/include/asm-generic/bitops/__bitrev.h b/include/asm-generic/bitops/__bitrev.h
> new file mode 100644
> index 000000000000..1b8c0f464d26
> --- /dev/null
> +++ b/include/asm-generic/bitops/__bitrev.h
> @@ -0,0 +1,22 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_GENERIC_BITOPS___BITREV_H_
> +#define _ASM_GENERIC_BITOPS___BITREV_H_
> +
> +#include <asm/types.h>
> +
> +extern u8 const byte_rev_table[256];
> +static __always_inline __attribute_const__ u8 generic___bitrev8(u8 byte)
> +{
> +	return byte_rev_table[byte];
> +}
> +
> +static __always_inline __attribute_const__ u16 generic___bitrev16(u16 x)
> +{
> +	return (generic___bitrev8(x & 0xff) << 8) | generic___bitrev8(x >> 8);
> +}
> +
> +static __always_inline __attribute_const__ u32 generic___bitrev32(u32 x)
> +{
> +	return (generic___bitrev16(x & 0xffff) << 16) | generic___bitrev16(x >> 16);
> +}
> +#endif /* _ASM_GENERIC_BITOPS___BITREV_H_ */
> diff --git a/include/linux/bitrev.h b/include/linux/bitrev.h
> index d35b8ec1c485..11620a70e776 100644
> --- a/include/linux/bitrev.h
> +++ b/include/linux/bitrev.h
> @@ -12,22 +12,10 @@
>  #define __bitrev8 __arch_bitrev8
>  
>  #else
> -extern u8 const byte_rev_table[256];
> -static inline u8 __bitrev8(u8 byte)
> -{
> -	return byte_rev_table[byte];
> -}
> -
> -static inline u16 __bitrev16(u16 x)
> -{
> -	return (__bitrev8(x & 0xff) << 8) | __bitrev8(x >> 8);
> -}
> -
> -static inline u32 __bitrev32(u32 x)
> -{
> -	return (__bitrev16(x & 0xffff) << 16) | __bitrev16(x >> 16);
> -}
> -
> +#include <asm-generic/bitops/__bitrev.h>
> +#define __bitrev32 generic___bitrev32
> +#define __bitrev16 generic___bitrev16
> +#define __bitrev8 generic___bitrev8
>  #endif /* CONFIG_HAVE_ARCH_BITREVERSE */
>  
>  #define __bitrev8x4(x)	(__bitrev32(swab32(x)))
> -- 
> 2.34.1
