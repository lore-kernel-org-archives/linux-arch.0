Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010047.outbound.protection.outlook.com [52.101.46.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB1E352008;
	Tue, 19 May 2026 22:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779229253; cv=fail; b=P/YHO+vFucXTrJdWm7WmiNl4P3l4wJeIBQ5Y1XLYjuMexXJW/OwUnqzV3qtrGSy0Asr+TG90v3/+nqlL/NcanO8J02HAQJcAvwsu/caWr//BYXi83rpixkSlZK+XK7R/D1W62V0zjdU9WI7NfeINrcIjVpXAVqdwgGvB9RgIVHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779229253; c=relaxed/simple;
	bh=5pGz+hp804nfDzgBWlfWYTeEzWN5ikADjE8jMoebnio=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SPxRr6LIV45KNyMeekBBTO99Lx7eaSKtKavXwdC4m79Vj2g7glY6NtRkgpr9am23JSwJ7PJTntXxMC+ftx/pxR1mwKlT4HAd9Go1+tbIn8rXtAMidsrx9yBgRG48NHZbWwUNe7fGk+EZ9vBHZ/Rpdj7KQunQ+bx2M5eRQVz3N5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NauE23qU; arc=fail smtp.client-ip=52.101.46.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NauE23qU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=amO/E1qcOBcO7991VUtJPTFISdqF2zz0n2hSsC86aU8pYulXJ+dg2czt/clbdgn43CUecqhJqkspVEqi5ApZatAyOzXKRj4PoGEsDa66bo4PLOOUflZCR9PUmTELKT77QS94EZktiDb3nDZctHVrqQnbapxi8JUQN+kVhy7KAK0l2TfFbEmczOOU170ts5G98M1SBasiF9UdsILbFwuhkr3dZIqlWT3xzfBqzHFVd/W+fWNTyhTneK1skLQghHjMVa7hBwQ7eiWSc0/EmDSbHjYqZ7NcYhKe8pOu9oGBroI9AQFtqq4skwkeawcdIKFmk2ys/qKiGHLxmNdOahFRMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+fLRspDa/V4h14IhzrXQrU61sukDf7J8bloJJUwW7aQ=;
 b=gj6EIX3p2iFv0nf1qhOJ3sEi558Rhlvj+M71/183xvdkVMXLWCPppjnAiyMvxav/KOLBus4Vtz1s5S/eEbMkZbNP0WCEOIa1X3raZutdaXBeltdCLH5KJDWoKGMPdpCIHsK1cG/B6vluLslktNbAMxXR9O8NuOVlXnjrgVdY5NTzq78bjX07wxKjrjIC7otk/Tg02tmW5izNWqkUgj/X9UkUVo/yCLABnL+o237UJOXb18WDJ8o200A8b6kmlP3gcNo1x+73kev+PaTeWiHXuezKVXij2ghBeW/avybgnSw6DfWuf/kfumu37Bs8GiDkQEERtWX22/rnkn/rrNCQSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+fLRspDa/V4h14IhzrXQrU61sukDf7J8bloJJUwW7aQ=;
 b=NauE23qUN3pO+T5YEA1N91Nedw8JF+c0OG2je6435sUfKu37LauHtO5SRd0N5KJVC7QpGbfD/zIMKCp1wE14tQgI8DxlZICqhgPH+WqhOZj0J0yN5ZjbuHgRPbWZbvYA3fgzDTPtwsyLOyNuT85e2GORHy0u1T0uQkT3ea/GbOtGG3qMeXyBwvG6xkFRt4laPTDl/ca95r9G6gmwPB7VFEz3EqH1b8dsr7Nn3FV6Mwo1TKR10y645MS3iWb7qx8aoUg9KtShF5+2UjvfKbiGw+Ktyv3OiOS2J5dNH0USAz72Sz53Rzg2TqjfdGVYnc0jn16pUSVFwpMhHmRkhC2+bg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8300.namprd12.prod.outlook.com (2603:10b6:930:7d::16)
 by SN7PR12MB6766.namprd12.prod.outlook.com (2603:10b6:806:26a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Tue, 19 May
 2026 22:20:38 +0000
Received: from CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de]) by CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de%3]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 22:20:38 +0000
Date: Tue, 19 May 2026 18:20:34 -0400
From: Yury Norov <ynorov@nvidia.com>
To: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Arnd Bergmann <arnd@arndb.de>, Eric Biggers <ebiggers@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jinjie Ruan <ruanjinjie@huawei.com>, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
	netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v2 1/5] arch: select HAVE_ARCH_BITREVERSE conditionally
 on BITREVERSE
Message-ID: <agziMgYIg96fTVst@yury>
References: <20260506175207.110893-1-ynorov@nvidia.com>
 <20260506175207.110893-2-ynorov@nvidia.com>
 <agKPkFq6kuarikAJ@yury>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agKPkFq6kuarikAJ@yury>
X-ClientProxiedBy: BY3PR10CA0024.namprd10.prod.outlook.com
 (2603:10b6:a03:255::29) To CY8PR12MB8300.namprd12.prod.outlook.com
 (2603:10b6:930:7d::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8300:EE_|SN7PR12MB6766:EE_
X-MS-Office365-Filtering-Correlation-Id: a105c6bb-b885-4d06-49dc-08deb5f4da5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|10070799003|3023799007|11063799006|921020|18002099003|22082099003|56012099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	qNGQ2tDmn0g/ixeiWw9Q6KkKEuRAFELhf14jHIp2Mc50M8epYdvqGKo3gJMpRzEc/rV+aYjtCb9uyOvxfv5TiMyJYC4QHZhE0BDTWzOs07UiFcklzDta1ZiD4iK2CwqTifGsqKt0BJ9qfm7ozItOaUSz2lloUSb2K848e3/4MoxBAEhyaFk6Ww60htpgzfUxcPW7AyzjjC+V4YazN52kcTM+RpJTlAfRvMthgNp1tkDItbSA2RhSej2E9jMrghWjdcIe1X03tV32jriNE8/4JcTV9o5ApHJPWt0w8/y6CTD5zaRfkLYzWyrku9Nx1s1S057Ztwd5pQuES+K4rFy6MAxkasWnXbPPntmArp2odKmXoMIZNLwiS9WkSRatCm6DOGj0E+CSBt0cUEsT5x+z/lWzjdIpP2CgfA8nDaMhXI6P9xofNHljlGKXKhDy0GA70HSn3Vig52hOWmq+nNT0j4eHZZZ3sidzH3qptcI+XnQ0p+mhF/MtswzD8iDmeVhBBXqiBV517lzScel7VwdxbZKf4jhFZLpzvHzMoO8OneRF+7/z7vLeSyPAWiECj4o6R/pHB7UCt4rDOh7OqpcBk7t0n4RH4jWLlDb5HR2V0k+LCbmtJ2/tISZF7qvbAwBCBvcLQXEwK1ZD7vxX5YUEI7pZKmMOba3oZ9bUX3fYstUazmxTNngpufblDL6bpJC2sOumH8a12AA+XzKwOYM3jjendPUHsAx/b0AwZT8zxyM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8300.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(10070799003)(3023799007)(11063799006)(921020)(18002099003)(22082099003)(56012099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n3zVr3KUjFnXcLhxkIgmHyydTEs6vVfyZ8/3D/U5JOPxKhIbNzW/hwctEMS6?=
 =?us-ascii?Q?UzINV0RQOW5cbyEPEyQBxQ8oeipjax7L0jz4kPLTuo98Nw36Q6bwRZpjFfZa?=
 =?us-ascii?Q?c5cYRfImPTHBPBjQwUE+pQdma5Eb/F8p0wZ2qeOrfZtu6h++yW5w3+nPBKua?=
 =?us-ascii?Q?T85K/0K33ySnHYdxnqj7i995fHLn2iByimqGzQBl7qtQx0nbpo9WZbEKgWWk?=
 =?us-ascii?Q?hHnUMfOJxzCZA/TE1EVyiFx2e07pVz4Gd9sNvdtuPKgiRcnOUZbcg7+oWUYO?=
 =?us-ascii?Q?qbkip/9jpYWFQBrgHjM18FNF8tFDDs9+dQ5C/4CdUOc3OnOTAvQO6zzKNE6k?=
 =?us-ascii?Q?hzFmjZO4HD3O7R1d7gf51kYfjKJVKD09SLqAdXMY4c4ivEImzUaUX35Peglz?=
 =?us-ascii?Q?B/ngIlsRmReaLGFrvgACjMoj6Vlg3uMVsLwGOZ9ieI20TlpZ7aR8jgjPUvbf?=
 =?us-ascii?Q?4GOLt8x9wDfEAyjHYHEcd2438+gNNDcNEZazLseyNmPgAW1sGvcJgGIjilsr?=
 =?us-ascii?Q?JwFijrt9scvUDYw8lH09swBRM8+WLP1KMlHZ4ov9ahlnBBR8/vh/+oj5gUxf?=
 =?us-ascii?Q?yKWZP7erzXdwRFIYsNjP/fIfdUmGZ+r5tstgH1JeHk1eUsbWYVZq2M1Pt9Z/?=
 =?us-ascii?Q?96lO+l/qUgCoVQbAPpID+4tpv5SgieS1gLiHuoR9yBoiM6MLLjdoXnFR+lYs?=
 =?us-ascii?Q?3VGt1lGad7xTp+cTyV6fEUpRGXUKgKuyNNjkXRN3FP1c1r/cEzc2bARaEwdr?=
 =?us-ascii?Q?AbhQyYdh2yjeVQg2GwxITPK53xbZ30ba/QW6Km6prquc7ZtfE4oudL5QBOpQ?=
 =?us-ascii?Q?9hKGErNr6CQNqCvPKoe8dKmTYVIHPk0CvDt5oYUeWRh+joQpk59Qy6uiNQkr?=
 =?us-ascii?Q?h67k8V+YYPThVRtU/ItzwVAAngAQj9Kzrvg0uUIoGJ3qnOUOYeyerEsJKk72?=
 =?us-ascii?Q?bgS4eINJ1bIejmgSC2am+bDw9TH24Mx4TfTh0ypzOx0Kyky/++w7HtfyAMgg?=
 =?us-ascii?Q?rF+KgkYNDnbrj3AUoDlg97z4HbqyKPJderGAQSN5/kmQtQMnlLAUcoN92ESs?=
 =?us-ascii?Q?8R9AnwrQIf/mhv8VUSXX+qPS1AepOL6PE4lCJizhBEOeyXytQP8zxviUoHEB?=
 =?us-ascii?Q?ecwtNtSr/rxQcgeSLJBBpHRWeyRjpcLhFBm5yBF5fnsewuNFPmOWQkP3cn1P?=
 =?us-ascii?Q?+SRON5wq+7g7/cRGRh71wH7pmthZ5c+NP/RgXxmi4ffB1YuISc9VMa8ZCyP6?=
 =?us-ascii?Q?ILoNuPk9JI0X+q6yljvMIorGHHNZ6FKO8mP6Io0Jbnwbea4f1wq9kzA80A30?=
 =?us-ascii?Q?LYb1iJYkh75sZekNMeoTD5DMXuh4dX1YfZ1AU8BEmgxxeZmk5DzMxh775q2N?=
 =?us-ascii?Q?YnSDmcQDXiHPAnhGN1D/QcmH7hFTibiFgizTtLohD5rPe5XtyL1mzRnl+5/p?=
 =?us-ascii?Q?7fLXzKTRRR5fEmKVZr1GqkXGlHhUOjFYqgaS77WqkPBaaZgCW7c55LP/m8tK?=
 =?us-ascii?Q?t2oSwRFO7a37eKBmj7ZbSg87pJQohX/F+meYn1eDRElJDMbtIylZjynnVufz?=
 =?us-ascii?Q?eLopMYYfsHCwd2lbmm6JsGwk8+5JxXKmVuMfABD6/6Hs5DKU1QO2Dk+vgU8l?=
 =?us-ascii?Q?hjEXhOOm/GGLW/w+ekEvJoPBqJB1V/P7k02n2ybQcl4qN42HdjnR85QydihK?=
 =?us-ascii?Q?Y8aYXekTc5Gi4umc6Kqqgdee9PZ8ZwY5lXQF4iZgh3R2If/HspQRG5C7SFIq?=
 =?us-ascii?Q?JaRGvfFbv9apo3yDmzmHMG9c16XewYsv4S4FJcycy06nSJ89tC/Z?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a105c6bb-b885-4d06-49dc-08deb5f4da5e
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8300.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 22:20:37.6547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yabbc+pAqkzzhfAGXpFZm7LKqLY65kqaQSqd0W0wzZZ5bW4vL4jAaUMiAQOia2GDqNAQWLaEyxMU9jQUGVJ0aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6766

Ping again?

On Mon, May 11, 2026 at 10:25:20PM -0400, Yury Norov wrote:
> Ping?
> 
> On Wed, May 06, 2026 at 01:52:02PM -0400, Yury Norov wrote:
> > Architectures may have bit reversal instructions, but if the API not
> > needed, the corresponding option should not be selected because it may
> > lead to generating the unneeded code.
> > 
> > Signed-off-by: Yury Norov <ynorov@nvidia.com>
> > ---
> >  arch/arm/Kconfig       | 2 +-
> >  arch/arm64/Kconfig     | 2 +-
> >  arch/loongarch/Kconfig | 2 +-
> >  arch/mips/Kconfig      | 2 +-
> >  lib/Kconfig            | 1 +
> >  5 files changed, 5 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index 71fc5dd4123f..0e963e54fe06 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -83,7 +83,7 @@ config ARM
> >  	select HARDIRQS_SW_RESEND
> >  	select HAS_IOPORT
> >  	select HAVE_ARCH_AUDITSYSCALL if AEABI && !OABI_COMPAT
> > -	select HAVE_ARCH_BITREVERSE if (CPU_32v7M || CPU_32v7) && !CPU_32v6
> > +	select HAVE_ARCH_BITREVERSE if (CPU_32v7M || CPU_32v7) && !CPU_32v6 && BITREVERSE
> >  	select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL && !CPU_ENDIAN_BE32 && MMU && (!PREEMPT_RT || !SMP)
> >  	select HAVE_ARCH_KFENCE if MMU && !XIP_KERNEL
> >  	select HAVE_ARCH_KGDB if !CPU_ENDIAN_BE32 && MMU
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index fe60738e5943..f5bb62c2ba9c 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -150,7 +150,7 @@ config ARM64
> >  	select HAVE_ACPI_APEI if (ACPI && EFI)
> >  	select HAVE_ALIGNED_STRUCT_PAGE
> >  	select HAVE_ARCH_AUDITSYSCALL
> > -	select HAVE_ARCH_BITREVERSE
> > +	select HAVE_ARCH_BITREVERSE if BITREVERSE
> >  	select HAVE_ARCH_COMPILER_H
> >  	select HAVE_ARCH_HUGE_VMALLOC
> >  	select HAVE_ARCH_HUGE_VMAP
> > diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> > index 3b042dbb2c41..6c3444e31c0e 100644
> > --- a/arch/loongarch/Kconfig
> > +++ b/arch/loongarch/Kconfig
> > @@ -115,7 +115,7 @@ config LOONGARCH
> >  	select HAS_IOPORT
> >  	select HAVE_ALIGNED_STRUCT_PAGE if 64BIT
> >  	select HAVE_ARCH_AUDITSYSCALL
> > -	select HAVE_ARCH_BITREVERSE if 64BIT
> > +	select HAVE_ARCH_BITREVERSE if 64BIT && BITREVERSE
> >  	select HAVE_ARCH_JUMP_LABEL
> >  	select HAVE_ARCH_JUMP_LABEL_RELATIVE
> >  	select HAVE_ARCH_KASAN if 64BIT
> > diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> > index 4364f3dba688..7e1494e0dbfa 100644
> > --- a/arch/mips/Kconfig
> > +++ b/arch/mips/Kconfig
> > @@ -2026,7 +2026,7 @@ config CPU_MIPSR6
> >  	default y if CPU_MIPS32_R6 || CPU_MIPS64_R6
> >  	select CPU_HAS_RIXI
> >  	select CPU_HAS_DIEI if !CPU_DIEI_BROKEN
> > -	select HAVE_ARCH_BITREVERSE
> > +	select HAVE_ARCH_BITREVERSE if BITREVERSE
> >  	select MIPS_ASID_BITS_VARIABLE
> >  	select MIPS_SPRAM
> >  
> > diff --git a/lib/Kconfig b/lib/Kconfig
> > index 00a9509636c1..d8e7e89ae320 100644
> > --- a/lib/Kconfig
> > +++ b/lib/Kconfig
> > @@ -58,6 +58,7 @@ config BITREVERSE
> >  config HAVE_ARCH_BITREVERSE
> >  	bool
> >  	default n
> > +	depends on BITREVERSE
> >  	help
> >  	  This option enables the use of hardware bit-reversal instructions on
> >  	  architectures which support such operations.
> > -- 
> > 2.51.0
