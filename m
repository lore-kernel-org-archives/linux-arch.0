Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012034.outbound.protection.outlook.com [40.107.209.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EBD18E025;
	Tue, 21 Apr 2026 02:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776736988; cv=fail; b=f8KQgGUgakYOhtrd5vRW5P0uIqUFuZa7wAgjUP14QCT8vBtwjbOrvZa1vz7Ry0NYCRmZJ4SUunA9INqp1TxWKTguAX97VPQF1ZCgU8yCYH055FPwTsFd6xR/fRJQ0gteQ12qVACVk9SpmdUFBOFPDRkxnI+xVXz8MBLR7AFyXrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776736988; c=relaxed/simple;
	bh=iNyCBFDv9LtptjT4S2LBtNI8PPZdi9duX6pmIys8YJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZWtLv6fy7SCBTvWO7D0r0t89v9o9uLdJlQ0T50v4XPrnhvLPKeVEN2h47eBro/elFh9LIFlRdUx9vESUyhxviEUbqVb3jl2Go7VuzPbhWx9UvdE4UdpjfK+/zG1YTcfZC98Knf/LUlc5u1GXSOVv9E+NgtR5QXHSlCzfO2mYEEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AZGLWxCl; arc=fail smtp.client-ip=40.107.209.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AZGLWxCl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wnM6CHeSJ2e/yxhF8Wpyi96sQuwHhWsHXgSqOSF/JRYdxeRe4V3NexcF8Gy3mNOAZDkhNbGnGs7S+g6YlUExik7uWH1PPXeBj/jiNqwEj3iQi7oPkrDAvGjPwHZEdsXbU0HmZnJqLE+UybPObFFlVh+g80fDlMf6P5MrTmQpxYQHQaa+PsSpVlgClPT8uO6Wz1uZALl4jOdF7lZFko8fvVMZy0KZJ5V0UHVHMmOQqBTSWO34yZtODDbKGrtZ/5+//Zavq/OF8ukJTkSLUfSuJOBTrDCEn40rCi//gAMNc7YcIPdcwniqYaCOdqRKiy5ujqRwX923KaQGnOb9Kb48jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7zJb1yC6LADiwWFuWS4akobbenfN+U9cwJdC/0EFBFE=;
 b=py24LoQuGvgnJRODXLqg/LIjznIkTq1i7luYuIrIC0cTHNvnJoXfYQeq55B5hy0dq8K+tA6yNuucM4q+4AVtxeaxCEw/ic2K2s3qDc0Rq2z1P1dlRHzgoT8IAufwbn1o6McPUX5gxYyzX5jk/rqPPC9JhfQreH1aOPBLmAD0KrW6jQhIVK46BZgr0L2HLmELPFyhxi9X7oILnBj25eu8xC4J6NiapZIYgTtpaGO/VP9vrUHRTveqKc+88IS2w62pN9WbPmK5yDo5aBuV/k89oO5nJC74O8LS7CM5KGV4re8Ny/TcwodfxOgK5hEuosiDxf9XLZHZ+0jijdmjqKyBgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7zJb1yC6LADiwWFuWS4akobbenfN+U9cwJdC/0EFBFE=;
 b=AZGLWxClQi14UZfKubuVZaMVDHYFQ9hJFzFqeJ5xN97AP8dmOZacBC2jqOjtqnLq0bFXjQEkOz/exGY7ycdK/ax2lZrMLQChvUsKuKl2mAS95/6mQNDHXrm0LbvMP4E3FKbavaFIdkHlk9aZilmYi6mA1566q8dY1qm5j1BWzIivvknFPs7IMfsj7EE7svhRQvFzXse1AiBWBA9igV/UvzDf3NIY7dE0iBlCOSbqPTBom+06I+E615UUOp27qtGuRk4PVRMOK/FLTyQ/M7j6JgU1nxyy3JrsZ2FA+WP5tuHT4GiT+4q3vhxEdWtIcauvXlYu7HFdpP3fY11u+nTBXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8300.namprd12.prod.outlook.com (2603:10b6:930:7d::16)
 by PH0PR12MB8097.namprd12.prod.outlook.com (2603:10b6:510:295::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Tue, 21 Apr
 2026 02:03:02 +0000
Received: from CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de]) by CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de%3]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 02:03:02 +0000
Date: Mon, 20 Apr 2026 22:03:00 -0400
From: Yury Norov <ynorov@nvidia.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr, yury.norov@gmail.com, linux@rasmusvillemoes.dk,
	arnd@arndb.de, akpm@linux-foundation.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, david.laight.linux@gmail.com,
	nathan@kernel.org, cp0613@linux.alibaba.com
Subject: Re: [PATCH v4 1/2] bitops: Define generic __bitrev8/16/32 for reuse
Message-ID: <aeba1FM6m-gpiMbu@yury>
References: <20260420131252.179729-1-ruanjinjie@huawei.com>
 <20260420131252.179729-2-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420131252.179729-2-ruanjinjie@huawei.com>
X-ClientProxiedBy: BN0PR04CA0081.namprd04.prod.outlook.com
 (2603:10b6:408:ea::26) To CY8PR12MB8300.namprd12.prod.outlook.com
 (2603:10b6:930:7d::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8300:EE_|PH0PR12MB8097:EE_
X-MS-Office365-Filtering-Correlation-Id: 235d8fd9-6b34-4f8b-d7b7-08de9f4a1e77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|366016|376014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	tL+UhR7jhZ/OhGyhM4QvY/p/dyfMF8duZkPbFAC7QCDPcJWz0CoopGIzTy221rMPAknIoCiA95xPiB5VUW8Sek13XbQGp/w0rZEeO1DAFyN8ZNRXAb6/SrGkKNcBNqodntQYwMzgInSvjtmRQUxKZXugn+4nYaKgd7kA9g1mxOS51b4tUT5Z5yyI3FOiiQBAaUiJi27rMhK/LL4x2BuL5A6IK15O09Tc9D2Ccuv8OXM9bab/kb0FLILNvpOs90ybG1ytjPlPhy6giZGM7SxpgXOMEBbtldpThIdja7+thdmq+zLB0vkyR7vrsKKw+t4C8KpCsArbD26q+IBz+oANJNV6V/Tb2M0fPwJLjNsCQ2leT5bwXyjNrqAtSDvL1VaZSIRL74ohuYg1MkQ1aOFEY9Fm94rD8t4y1f0/BNT6h3sEZ6+6cwSKxvUMdoyfD90oX6qhFJg59THJu6pXnUoEl79reS3lsagudjESFf61FE/ECYfoQwY4NmCZgxPM85crkxRU1wedX31jxI5jFvWUY/s24kv/Eaob5/f2cQdxhuhbbF6JvbaWciK30FI7fAKIzkX/gXSSDeTBtkp0rLfhiPhIaXankvPNyEOdmLEtrBep9A0ir/lK/BDEaJCSn42jHbD2OvJwbrQ0tKMc7Qp1SbxqHff3xSFFqcyMWyDFjpLJffjGRIn0/W8rewikIkhcQrJMqJ2UKmGmsp5ziLVStD3lOd1ZcNfb1khNfv87njk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8300.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(366016)(376014)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3J9BU9b5SWulibc0PAEfTxDCQ2onz09s8Hbw1V/kmauD8vyYRve7Rhs/YSTm?=
 =?us-ascii?Q?80z8lGmc96UWveZFqJbepSNAU52GrBQ11ZzQ8WKY+GShzD9P1u4YbyRKl5u0?=
 =?us-ascii?Q?j4e2h3opw96/2tX8w5PCSXeVResqeQ55rAVSry0wSyVA3pJrcPpNxeD1bfb1?=
 =?us-ascii?Q?vNuFvie6PmYyhXdrcdnKBjt1NqnD0NEyNHk8MK1Ym2RgwETnPjBVda8a6Uww?=
 =?us-ascii?Q?zXeLdTldYqVIFjDKW9Dl+5ED9tANEFYFEUhXPev7e9i9gPub4b9yUGMImXN/?=
 =?us-ascii?Q?djXoosR0n40Oc45eJEsmPzeUE8s90XvsmqPxSENy0qFQmhdzY0yXqIA5+8rH?=
 =?us-ascii?Q?bwWXxZL1kh8YbdEnI1iRvFIMr8CaUjJPGt2isLsbOmm9UfxGGTzA1u+LhwWY?=
 =?us-ascii?Q?Jbc8GWlERxBxCn1B0tBFV7nOiaWZdwJPrIYmCc6Karbwygk8CuB27m8iGd+D?=
 =?us-ascii?Q?WC1936JFB1zlLQalGZleJADtKH7j2Wg0wtQiaFN494asSuFa3k5nDot6YSfV?=
 =?us-ascii?Q?6YnYX1hUmFn+cuxD3f55TxaSvRQEnAoqClStfbrB17pCOxB55lmQ7nOc8+rg?=
 =?us-ascii?Q?bK4nTA2j2Cnh7rgptehMdIVjzskmdYsSIxRzs0t4EWVsQpzGNbmwISXedsZy?=
 =?us-ascii?Q?l0eFo6JTi+sIf9JsyKV87+JyA6raupFgEIVokUM2Z7v5g0t9rm9vkeKYTCu4?=
 =?us-ascii?Q?qf1TnUWuV4rNmqs2qdlw0iqn0+Bf03e0/mddJGtIDiDbxiYFRfyAvKPblyCE?=
 =?us-ascii?Q?q1dMDSsymV1SZUNZH5V/TKU5xO7bDPKIplV98IVLRgem1N+k5SpCU73Qu/hF?=
 =?us-ascii?Q?LnKwXQSvJcPASCHp/cmEC+fcY08aemFg7Cq9KIjsTzDVHg6b7EO5BBQDmb/O?=
 =?us-ascii?Q?jTKUQNB4ZQlzRh7dmfO2HR4W4MYcXggoGfvDqnJjV5q403civie9QvqVTbHv?=
 =?us-ascii?Q?Uhh+OTtZ2G3ZG7g327jr2p56bjFbTx6qjd2Muvp/xw8Wi42Uudt72sPaEJZ1?=
 =?us-ascii?Q?t0qzPVkXqIvM+ZwGe7BZ8RfV0bcJifZsi45YsrOgWYE1vzj5FPBnBX2zPihk?=
 =?us-ascii?Q?WC26lshaGdgJbwjdm51yfRQp+W2o+OAL64yxfeOb1W1S4fQFhC184F2HiHlo?=
 =?us-ascii?Q?xGLfLLLixxouMjEeVRddN4vxNBXueU6APv8LorPPIWSWmuOytBkOOJWOq9c1?=
 =?us-ascii?Q?Tpmdzf4FbZJZPNFsItiM1wP4H1YPKeFaeIhoHCjE3SxTZ4zBReS9gzfXfC2V?=
 =?us-ascii?Q?xSBMPEcUByfvV/QgdGRhkHAWMQJGNw7S72iBh41ADYVj5IFyf1qJE2qI8GvO?=
 =?us-ascii?Q?POa8L9agJkqc917kk0nV+WLKuQ8PqT4OXuU/SvmpmoCvNP14TMgeI/ukCEeU?=
 =?us-ascii?Q?43sxGKFMbPDem6sUmi+Bib9Y0K3tINL1Ee/DCkIwoACjh/MnfpOrdbtK8icA?=
 =?us-ascii?Q?3GAUo2shP7y0sRwqK2x0l8DgwVIrNfCuxQLyWfCFPqSV7qIA6zm3bfm3U7bo?=
 =?us-ascii?Q?M4LIxMKn6yey6os/EweB6yQAtMlLqEpJSfheEsnwmizU/5RgVV/M9YTkZIpg?=
 =?us-ascii?Q?Frme/FTXKG3nwWw9xZOYufYbGtQoGTHRriFuR7qur9lIJYrbYTLJ/alz/1kp?=
 =?us-ascii?Q?thCRitXGQPmD7LLPd/Wv8iquu9V065kCQ2ThIfv8IpSus+Ld6XxUvURNwrqw?=
 =?us-ascii?Q?2sZH5+2tJMfZoVeYgpZIdEQ2i2G7cUSzpH6S33MkNIhSUhEf7SU8tAAt149L?=
 =?us-ascii?Q?nveMSBrBN5JR5lEKOJld+ig2WfWOjO/EAGBcRxrUv+4FxRxCK1Te?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 235d8fd9-6b34-4f8b-d7b7-08de9f4a1e77
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8300.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 02:03:02.2471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +0hME9AjFeZbuF7O92YJUMrn6Rtbi2P3U1qMX9bc12+YNcuP3sGjImDJ/OaQHoRRCA5j9YlVtgpjPGRnkk19jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8097

On Mon, Apr 20, 2026 at 09:12:51PM +0800, Jinjie Ruan wrote:
> Define generic __bitrev8/16/32 using the implementation
> in <linux/bitrev.h>, so they can be reused in <asm/bitrev.h>,
> such as RISCV.
> 
> And introduce a NEED_BYTE_REVERSE_TABLE Kconfig option, so byte_rev_table

Please split the move and new config option into different patches,
for bisectability.

> is only compiled when !HAVE_ARCH_BITREVERSE or when an architecture (like
> RISC-V) explicitly selects it as a fallback. This avoids bloating the .data
> section for architectures that have full hardware bit-reverse support and
> don't need the table.
> 
> Reviewed-by: Yury Norov <ynorov@nvidia.com>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

If I recall correctly, the option was suggested by
David. Maybe credit him with a tag?

> ---
>  include/asm-generic/bitops/__bitrev.h | 25 +++++++++++++++++++++++++
>  include/linux/bitrev.h                | 20 ++++----------------
>  lib/Kconfig                           |  4 ++++
>  lib/bitrev.c                          |  4 ++--
>  4 files changed, 35 insertions(+), 18 deletions(-)
>  create mode 100644 include/asm-generic/bitops/__bitrev.h
> 
> diff --git a/include/asm-generic/bitops/__bitrev.h b/include/asm-generic/bitops/__bitrev.h
> new file mode 100644
> index 000000000000..9d7d3d369364
> --- /dev/null
> +++ b/include/asm-generic/bitops/__bitrev.h
> @@ -0,0 +1,25 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_GENERIC_BITOPS___BITREV_H_
> +#define _ASM_GENERIC_BITOPS___BITREV_H_
> +
> +#ifdef CONFIG_NEED_BYTE_REVERSE_TABLE

I would rather say CONFIG_GENERIC_BITREVERSE.

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
> +#endif /* CONFIG_NEED_BYTE_REVERSE_TABLE */
> +
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
> diff --git a/lib/Kconfig b/lib/Kconfig
> index 0f2fb9610647..75cbb647b1da 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -62,6 +62,10 @@ config HAVE_ARCH_BITREVERSE
>  	  This option enables the use of hardware bit-reversal instructions on
>  	  architectures which support such operations.
>  
> +config NEED_BYTE_REVERSE_TABLE
> +	bool
> +	default y if !HAVE_ARCH_BITREVERSE

bool + default = def_bool

I don't need the table if I don't enable BITREVERSE. The bitrev.c
will not be compiled in that case, but .config will be polluted
with useless and misleading NEED_BYTE_REVERSE_TABLE option. So
altogether this should be:

 config GENERIC_BITREVERSE
 	def_bool !HAVE_ARCH_BITREVERSE
        depends on BITREVERSE

Can you add a help section, so that the others would understand why
arch and generic implementations are not mutually exclusive, and when
they need to select this?

> +
>  config ARCH_HAS_STRNCPY_FROM_USER
>  	bool
>  
> diff --git a/lib/bitrev.c b/lib/bitrev.c
> index 81b56e0a7f32..d9d5ee00229c 100644
> --- a/lib/bitrev.c
> +++ b/lib/bitrev.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> -#ifndef CONFIG_HAVE_ARCH_BITREVERSE
> +#ifdef CONFIG_NEED_BYTE_REVERSE_TABLE
>  #include <linux/types.h>
>  #include <linux/module.h>
>  #include <linux/bitrev.h>
> @@ -44,4 +44,4 @@ const u8 byte_rev_table[256] = {
>  };
>  EXPORT_SYMBOL_GPL(byte_rev_table);
>  
> -#endif /* CONFIG_HAVE_ARCH_BITREVERSE */
> +#endif /* CONFIG_NEED_BYTE_REVERSE_TABLE */
> -- 
> 2.34.1
