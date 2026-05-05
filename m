Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010029.outbound.protection.outlook.com [52.101.56.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6CD3CBE8B;
	Tue,  5 May 2026 19:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778007841; cv=fail; b=Hpp2QE9H68JCDWs31JxzxaWY86ThIs86vv+QBF85hkq/Hf5mvmQoeOCOyqNkE+5Q60cd8sRQFqVDN7XQRRAgvsETk/2eMPLvB/w9OEAkBMhJYrvru2+eyJEny81lMLCog6jfrTTlM+GphLC049Yb2tdE6LuI+fjF7UH/4RIX/7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778007841; c=relaxed/simple;
	bh=cMlhhTWyq2t0YAn63bTZL8FWd9fD84CRWQ95+G8dmtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mnkFRSHdnPc4Cup6rkG2ZG4vQANfiNh1ct4V187/fH2mcfK4rqbakp9ee7JRxy2Yfrwg3hyyiKPjuTRG+AiD+qehxc3Sczyw4cAPlgR5HlZ7KCd/DIUHc7LS4Ex5uUYzWc+LZSvUed2sBQ4uvA+O+PUMcVO4u7DN8qdKWZB5xG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ckHHShPD; arc=fail smtp.client-ip=52.101.56.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ckHHShPD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zLAxy0mgShauIoch8n4cuaGGnn6GbgCiWkxqXMDAHvZb/1W0Mx9dtXI2Qhd20obaqzoHBoSWZs8JuD2Za5MoR1MVghNj41HjHjWg4D65Tnd+v6LQ2KSz+6xJPbgY0lcl6QrBzaPI2JdSlJK3iDwb22BiUfKyMjo4QAGqneY7/FUgycnaIEmZ6X1aL3BauFhYxt9zg3w0s1EXIwRt3d6UoLkuW5QjlKT1fwBCrWlt5MRrmt4uZNEKIZasrXOYk3vk/rH5M30RWsHWIEoPtQoNfix2fjnzOE2GAfMqaKFZaJfyDLurCWp1ZhTR5+gGopE4/ZpE3sfQ1EcieYSYeVw1og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+0TFhrNMId4wH3Wtsc0YJpevXIQyz7hHFr6GiQ/Y3jU=;
 b=JP4x7Au50I8CIa7n61FhZxpAOvxPDkxJ9aMspkwosri4eH4mYdHr6PWF3eahqpPN1DFW24z6NSmPm7q3gYTe0e1o2YK0f63agCdMGRzwW4Usaz3kuZw48cWzmB/sjfsx8P//plSfg1rxUuSpGViT3I5ns9+OQptLtdcV/GuGcytP1HTPEBFERk1hWinfZ/IyrbtbR2aQclYVGsYUZpcLj+YXbUdvxXCUyL6c1TmmNDnySaHnZlMHvFoY4qzeC6KPdrfa0YGq6RTGNso7CqKN5gnHiUSlqnkZLldib5RwTI02Sjc1VjzZkralF0+jNOwv2RiwBd1HFso/4t4URhc2oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+0TFhrNMId4wH3Wtsc0YJpevXIQyz7hHFr6GiQ/Y3jU=;
 b=ckHHShPDuPMadydAHVd3d+PKWm3HVy5EQVDnJweZfqzWtm+58tpQM42scs+u0HaI4ylqFF8kG0bQjoDMTDzhiACMZv495wzDcDzwPP/8Znzt0YyLDkhoiomfY9fbJoYbaa/PqYTtcs7zj2Zd794hXgA2QoL/wLmfbyQ61VwDoZDncNj1lWCamKIWeKqSjDOohy7+WdNQfMv5wvQ8e3BUCrNqplTix337d0qegvmnsoprHqL1l1WDqz5SQ0C0GrtgHhU4ZfrNtPZvmi2VCPN+aygzpGIrn0RcW4QT4D2Eo0Z+YYA9ME9wPEzjBIa+25cdgKyodGlokLOWNSCWEmty/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8300.namprd12.prod.outlook.com (2603:10b6:930:7d::16)
 by CH3PR12MB9121.namprd12.prod.outlook.com (2603:10b6:610:1a1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.27; Tue, 5 May
 2026 19:03:50 +0000
Received: from CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de]) by CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de%3]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 19:03:48 +0000
Date: Tue, 5 May 2026 15:03:45 -0400
From: Yury Norov <ynorov@nvidia.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Ruan Jinjie <ruanjinjie@huawei.com>, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Linux-Arch <linux-arch@vger.kernel.org>,
	Netdev <netdev@vger.kernel.org>, bpf@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH 1/6] lib: include crc32.h conditionally on CONFIG_CRC32
Message-ID: <afo_Eb26H75kxPIa@yury>
References: <20260430211351.658193-1-ynorov@nvidia.com>
 <20260430211351.658193-2-ynorov@nvidia.com>
 <ec4ed7f5-b1c8-49e4-b83d-e29c5414b9de@app.fastmail.com>
 <afjNaToyptiMogV4@yury>
 <9d45acd1-667b-4acf-9e2e-bcd79630d726@app.fastmail.com>
 <afjmIK4mlCWeywuS@yury>
 <abf4a586-b675-4e29-9570-fd3ed4158f58@app.fastmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abf4a586-b675-4e29-9570-fd3ed4158f58@app.fastmail.com>
X-ClientProxiedBy: SJ0PR13CA0071.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::16) To CY8PR12MB8300.namprd12.prod.outlook.com
 (2603:10b6:930:7d::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8300:EE_|CH3PR12MB9121:EE_
X-MS-Office365-Filtering-Correlation-Id: 627303ee-7802-4ecc-575b-08deaad909e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|1800799024|366016|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	jMeIopO91BwW5yKNl45Gi5T0n+EJ/QyURNbO+J1sA84KCuOBeQh5jlDgT2Zbc9UZOG4A0fMMFAJ6mn0ENWWI5loQG4aAm8tC0Sk+AF66upA1baF40iSKYvXCsxGYAmNiVV5PihEPd+aIfwJVe/PWIhHmHzrCMTJx1LRzOPHWa8FriexBADVGAL/E+RMO85N0r4Pa27MCQD5+m29uU3H/w/6f7PSuwPmFB/6NbMXsDYhptET5Ek+QtEAqJnSCQKOJG8ePaNCCTnBdazBR93vYsmYyykjXhTMamdmRQhYoMek8l9LHbhKWnRIvTaNJDawdxD5wc58b/b2rP2Zmv97hk4DnUfarU+xi+5H4J4fJdYngoL1AqpOydOWvu8TSR66hcsY7hRCUCmCEM/8flNAmd14YdQP+qbRQ4QMbB6s0iz+Xs3g5StpA08ZgQxSzh3P2RqAIAUZ3kajioLNAOVRb5q9a01mxNxkYLEEA6aPgtRQiBOvMS9190qB9upiqwmB30P5puxe9rzgPSHTZdcR8doP/RXiPoa2jN+DTCGgyhgeCDyl+p2++ZldtydpV46g/iKjW9PGgt93/jwzgunFTerK9Uc0bIJgWDuFyaZ7/tjSvW8fJu7YArMYd3w+cI52gwNv/pXhFAXK8rbqxOtC1XoM6QqTJPj8zupcUH8mv0dpJXGzGgG7ML+ngMps60Nh57sITUuncmWjPb9UmPZZQJA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8300.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(1800799024)(366016)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XlJwvcfTKfP8g+C5Ko5cHQ3GMouHib4USufN5L1IJZJKtXNXy8EgRghzvEmn?=
 =?us-ascii?Q?cD1SRxItCfnTBo5Ak61IKCZb3cN3prc8+de2XkouZctZBGppt8brdxSIjbys?=
 =?us-ascii?Q?WU4QynzxFFyIl0Pvs+agnlYXWTOIf+5tbbE9yKTsQO51cx5Tgg0khyKzuXck?=
 =?us-ascii?Q?U5vYyCaDk7ue65H1PkxzsSWlKQA7Bwi+vYQq+OqOHWEsDWDa68qa0Eof/vNz?=
 =?us-ascii?Q?tDcJ/5Rp07Mg7ZvjZuIjfZ2PYuqWwGbMJV1oGoKJdtX9pilU/Eoz7ltGlHl7?=
 =?us-ascii?Q?OBWz3/Zlf0KMhfc95NbRXO7EKdBm6HSwGQAsmbdS/ikZJ7ZzOtS7g2e2KQ79?=
 =?us-ascii?Q?0XhVErwtI9gatliLlPIykhMZRdyAc/YpQPf2WcBQsEcUrcWr7yHhhERnemIA?=
 =?us-ascii?Q?uPIkB8poSRwOpBCHTOUg1srUFbJlPPipuGsudqODHsJS00txi064dE4cp2dD?=
 =?us-ascii?Q?ecvckECyIGwV9KbLPO8dUWg3csLqExFnVKG1RV0SImsqYw1WOwBm6aCjoG4/?=
 =?us-ascii?Q?NeYMCaGMz4jYZblXTrxHGAnBTfTHPUcEazfMt7ZRM9NtA0knX5tFxTfKyiEo?=
 =?us-ascii?Q?jYlMsOF3mZYVoo1F539l8MR83nHzXF8+NHAvly6Rn6TOb4PJs2+NtE/pZioi?=
 =?us-ascii?Q?qAzybuY/eerEEA+fX2rHnvVujCDimJOSCLo/bwXIBhxlTaFt1W6jALPwyqf9?=
 =?us-ascii?Q?xJWvYG3gxlVGwI+Kq169AsmPai/OqkMAIDpd88FMKuc290LfmlCQ6Q80IeOI?=
 =?us-ascii?Q?m1ZojmjvV4Prv1OltSOH+D43t5GMFzmb6kl8SN6x8CawvjTBzL2OmE2FkYUA?=
 =?us-ascii?Q?lcZpa6cCMwwAkZASZhRGuHx94kOj7TfheilvcZtTs4EVfygvhteHbJoRgGBB?=
 =?us-ascii?Q?952A9mT6/G/B4i+Oq4EZONk8e4poiTn/V54PVVvkRfpIpNLrQENvtlZfBJWc?=
 =?us-ascii?Q?ei4KvNTvucHtYBdHkmnPPkb0fhWS+muRIgMFExTBbNVTNqCczsHV4e6xPd1k?=
 =?us-ascii?Q?wVl4ou3zCifin4Iwmp9n5gawZL849e57NdTUSw22kW6GBda/qnDCFiQ9yUJ3?=
 =?us-ascii?Q?a4ZVw7PXcxq/CnrAuhZuMx0u9WJdBow+qFbXzV/LQs0lg8HVua7j/9yrsq1Y?=
 =?us-ascii?Q?R5KEtuyO5om0L7OGDU/qG0JReQk2CpxB+LT+urT4ivaL1/0u0Xr6ZgCBQsql?=
 =?us-ascii?Q?hEo5jvmnvoQdv747SgHSF4/TFhk4Y5lToQVflQK6DkQxikQLBoxfiOish7ys?=
 =?us-ascii?Q?QpjsrzzoHqTanlvSPq82eUDtqrarbIOwVX2XnZsaXgnMLCLU0ZigVZrso4SU?=
 =?us-ascii?Q?fPaO94QRLHuZjPGGA0Ylp5Ux13PindQe3G0mHuSNGXBLt0GIXa+gUo8eClgE?=
 =?us-ascii?Q?RWrwRGZgJkSddb3EziHUZ5ja6p1fu9rXaoZhqKZV7bW0KpEcn/huumhpVoJK?=
 =?us-ascii?Q?+747k3zUXSbxfD6fEduFShG+xlikV28hwSYXDX1UTscp+GXY791uH7EnbBsP?=
 =?us-ascii?Q?2jiiiJwInMxYLCx2GrMbMMgSBoydW6L1VW73qaOoKe5sIB9R0Iz06FZ4T0Y7?=
 =?us-ascii?Q?JYaNOL0cyqgodcdXLFtbVGsPWr2hhbw1To+TxyKA0Sb3YnSHxUoAiTErk236?=
 =?us-ascii?Q?v+iUvINHUu8uJi4j5UJQS/P14SkTL9FOi42VkR/f4tWaA/Pz9nW4iQFlxEgH?=
 =?us-ascii?Q?jD1lUjD1/g8hEWuDYDd8GTRiib5vElcaKVmOIBJUKvHHr6zvSWfyTYaahvtu?=
 =?us-ascii?Q?WJfKQWMPK38aaVgz8s959t5dc7P4YMBFvP4ulBdjGjs55fACATFG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 627303ee-7802-4ecc-575b-08deaad909e2
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8300.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 19:03:48.6374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eh0As/OpTLLBMhl/6FrpJlnKwmN2kxgdpFNpXIJMFBVadVzuctUAfmK3/sWp1uaJqjLpZ6ZT70D0fmeyJtfW4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9121

On Mon, May 04, 2026 at 09:05:30PM +0200, Arnd Bergmann wrote:
> On Mon, May 4, 2026, at 20:32, Yury Norov wrote:
> > On Mon, May 04, 2026 at 07:18:49PM +0200, Arnd Bergmann wrote:
> >> On Mon, May 4, 2026, at 18:46, Yury Norov wrote:
> >> > Never heard about such a thing like "optional interface". And git grep
> >> > tends to second that...
> >> 
> >> I meant any library interface that can be turned on or off
> >
> > So? If I disable CRC32, can I use the either_crc()? In case of that
> > networking header, the answer is yes. In some other piece of code
> > the answer is no. Is that correct?
> 
> Since it's a macro defiend in terms of both bitref32 and
> crc32_le, you can only call it from dead code, such as an
> inline function that is not itself used, or from inside of
> a block that is protected with IS_ENABLED(CONFIG_CRC32) etc.
>   
> >> >> 
> >> >> Don't add #ifdef blocks around headers. If the header cannot
> >> >> be included without side-effects, change the linux/crc32.h
> >> >> file instead of its users.
> >> >
> >> > linux/acpi.h does that like many othes. What exactly is wrong with
> >> > protecting headers inclusion?
> >> 
> >> There is no "protecting" here, you just add complexity to the
> >> build when headers are sometimes included indirectly and but
> >> other times are not, depending on kernel configuration.
> >
> > Sorry, don't understand... I use the 'protecting' term with the meaning:
> > the functionality that is explicitly disabled should be never used.
> > Otherwise, what for we disable it?
> 
> Arguably, both configuration symbols are at the point of not actually
> saving enough object code size to actually be worth the Kconfig
> dependencies.
> 
> As long as we have CONFIG_CRC32 and CONFIG_BITREVERSE, the
> point of having the Kconfig symbols is to let drivers request
> the inclusion of the library helpers.
> 
> >> It's unlikely to cause problems for the crc32.h header, but
> >> the acpi example definitely risks running into circular
> >> inclusions when you end up with some other header that depending
> >> on configuration ends up including linux/acpi.h while also
> >> bring included indirectly from that one.
> >> 
> >> >> It looks like the problem is the check for CONFIG_GENERIC_BITREVERSE
> >> >> in include/asm-generic/bitops/__bitrev.h, which ends up
> >> >> hinding the generic___bitrev32() helper without need.
> >> >> 
> >> >> Simply removing the #ifdef there should avoid the build failure.
> >> >
> >> > OK, it seems like this is what I don't understand.
> >> >
> >> > We've got an optional feature, like CRC32, which is enabled by
> >> > CONFIG_CRC32. The most conservative way is to declare everything
> >> > CRC32-related in the corresponding header, and then protect the header
> >> > with IS_ENABLED(CONFIG_CRC32).
> >> >
> >> > I understand that from practical perspective, we can declare some simple
> >> > macros, like header size, unprotected. But what we've got now is a sort
> >> > of mess: all CRC32-related functions are declared unprotected, and
> >> > generic headers are good to use them. Compiler is happy while those
> >> > functions are actually unused. Next, CRC32 depends on BITREVERSE, which
> >> > is again unprotected, and it may optionally have an arch implementation.
> >> >
> >> > So if arch bitrev() is implemented, you can use part of bitreverse and
> >> > crc32 APIs despite that they are explicitly disabled - just because they
> >> > are implemented as macros in unprotected headers. And you cannot use some
> >> > others - because they are implemented differently, as a real functions.
> >> 
> >> I think you trying to solve a non-problem here.
> >
> > This was reported by Nathan for tinyconfig. At least x86 and s390 are
> > affected.
> >
> > https://lore.kernel.org/all/20260429202922.GA3575295@ax162/
> >
> > Is tinyconfig important?
> 
> Nathan reported a build regression caused by a small mistake
> in 596a9ea9015b ("bitops: Define generic __bitrev8/16/32 for reuse"),
> which is of course needs to be fixed.
> 
> What I meant is that there is no reason to not use the obvious
> fix and do
> 
> --- a/include/asm-generic/bitops/__bitrev.h
> +++ b/include/asm-generic/bitops/__bitrev.h
> @@ -2,7 +2,6 @@
>  #ifndef _ASM_GENERIC_BITOPS___BITREV_H_
>  #define _ASM_GENERIC_BITOPS___BITREV_H_
>  
> -#ifdef CONFIG_GENERIC_BITREVERSE
>  #include <asm/types.h>
>  
>  extern u8 const byte_rev_table[256];
> @@ -20,6 +19,5 @@ static __always_inline __attribute_const__ u32 generic___bitrev32(u32 x)
>  {
>         return (generic___bitrev16(x & 0xffff) << 16) | generic___bitrev16(x >> 16);
>  }
> -#endif /* CONFIG_GENERIC_BITREVERSE */
>  
>  #endif /* _ASM_GENERIC_BITOPS___BITREV_H_ */
> 
> > Right now half CRC32 is available if CONFIG_CRC32 is on, and half is
> > not available. The bitreverse is the same. If HAVE_ARCH_BITREVERSE is
> > enabled, one can use the API, bypassing the BITREVERSE. This doesn't
> > sound right to me long-term.
> >
> > Whatever this ends up, let's figure out a consistent solution please?
> 
> I really don't think we need any sort of solution here, aside from
> the trivial regression fix that returns it to the previous working
> state.

OK. Not that I've got the answers to my questions, but I trust your
expertise, so will do as suggested.

Thanks,
Yury
