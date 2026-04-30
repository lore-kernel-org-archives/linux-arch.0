Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013048.outbound.protection.outlook.com [40.93.201.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4C92BD033;
	Thu, 30 Apr 2026 16:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777567295; cv=fail; b=r5sJFMvaBoRBc0jqeSZeWCfI7su+WKHQwPCEfcfjBU9ZkJu2kR4DqQhgs4lePNFN+2KHTMnQvu+5qO6AwCu1h73tNiIjtjKTtDaZTMGUNyP5B2gF8oV2jHgZepPGT4QdsM3YbzAer838DmUTrG1FlIs+MMt/TMk/PBWTOA94rO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777567295; c=relaxed/simple;
	bh=IFNThPrhABnNqal+tvsu7bhfIsNL5u+1meT6eN/xgIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qSLekkn4ScyUSmoEOHUZ1rUH8LsVimL9VAwcsRecT67dOwCwY5/vEj3Pw0cjOjWoWnRQSrB6exrRgHOCQYtW7MeLwGHOz/GU9iggzWfNKerO/ZxXmDyCmVYZZ4AmQXLwSuyP3fR9ipTxIpxErD4NFXWyw4TytjBc4sSQH0785Zk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=j45TsNYT; arc=fail smtp.client-ip=40.93.201.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="j45TsNYT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N3aWoWiQvFgPA7sJzsvTsebmFF6wavIn/+Aa8JwszhJF3Rhz5mTSunz0VfW0V1+MdUgFNEXKxPuPzHOu3jjt2fZbp4alKwkpOegyOwjjITBMzDeqJHnyYvuCKdzEHAKOKDj3CQFrWyBrPMWcBlSPTBpPM8lv/AtRMDiqzPhEYbJ8kDuFgrd4PrMo5HrncUGLTQCffbNue/mRCb6owAiBx4k7IPyFc0OrsPowj6/D2qOyHT3Tfo63BOnbkRv5By1/DHlByHSAwbuuQ7n4RTFiVM0GZhThHTTvBRDTC/7duy4uIH5/4z36By36XryCrsSDRPjlCSas3Db/pGFq/LzC5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XXmNdCGGiEWcFn6WmU781J+1K9mTCwa9EMwgz6fhK2A=;
 b=hvuZ+RXK0Ey4rNNp3T9Cf8SjOz5or2Xcs0V9rZhbcR0Qyu5dFPYA2R36QWvc8FpcUzHStna/xbeZL7ZjBb0otpgmzwQnUk4eIG9wE3w5wsZoEkSnSxhkhhVS9xQ3jPd+kXf+pzwowQ3Y+FlXkiXUqe7JENDVz1zMRz9pRqR/7yO/Ow5VAjcvw9oQe9DbjnIaCL+1sjSgVaHr+AdHmIxr5mN8Seht18QuToqrDIDdovWY8QGkZmkSCYvmiGZLaAJriZMY8wR4cmFKrPhl3NB8XkzuKFYGvFtuI2Kc/SX+132DiAgz2eLpn3tsw/BsuoF3i5mLu5M5GOGgaHN/4g7R4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XXmNdCGGiEWcFn6WmU781J+1K9mTCwa9EMwgz6fhK2A=;
 b=j45TsNYTDL68ATa1uKDlurr7UQOlLQEv5NtGM0CU6hXaXItAenY4GkfQBC7/dosVpAgJvNLiaHIeHpvLwwsTrgBHAGs5mZYzIwbtNE166M7EjaiFSQkaCZPLcFA4Cx0d7/Ab6mGhrLCx7vUVb5telI//5rowity/MFbhn8AeX8G63ssQhj8TbxlHPsrBlc8CLIAZ8CYIvtzJ9JEP+mFpVI1A6ti2hraf2xVjSHmPBsWHuAXs5SiFtWCkRkV/xxruRPjms1tRTKWNh0c5Qp2Fq0jFFl+Yk6IG2wIED4jeWhIX5NN+kmOgdMnEsYzTpoOtXq+o3l2v3tpe7FhQe8u9LA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8300.namprd12.prod.outlook.com (2603:10b6:930:7d::16)
 by SJ1PR12MB6097.namprd12.prod.outlook.com (2603:10b6:a03:488::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 16:41:16 +0000
Received: from CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de]) by CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de%3]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 16:41:16 +0000
Date: Thu, 30 Apr 2026 12:41:14 -0400
From: Yury Norov <ynorov@nvidia.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Jinjie Ruan <ruanjinjie@huawei.com>, pjw@kernel.org, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr, yury.norov@gmail.com,
	linux@rasmusvillemoes.dk, arnd@arndb.de, akpm@linux-foundation.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, david.laight.linux@gmail.com,
	cp0613@linux.alibaba.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH v5 2/3] bitops: Define generic __bitrev8/16/32 for reuse
Message-ID: <afOGKj9SfozoS3x7@yury>
References: <20260421130752.607500-1-ruanjinjie@huawei.com>
 <20260421130752.607500-3-ruanjinjie@huawei.com>
 <20260429202922.GA3575295@ax162>
 <afK0oL5FS8eLobpV@yury>
 <20260430035943.GA2164248@ax162>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430035943.GA2164248@ax162>
X-ClientProxiedBy: BN0PR04CA0050.namprd04.prod.outlook.com
 (2603:10b6:408:e8::25) To CY8PR12MB8300.namprd12.prod.outlook.com
 (2603:10b6:930:7d::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8300:EE_|SJ1PR12MB6097:EE_
X-MS-Office365-Filtering-Correlation-Id: 80784a2f-e24b-4a28-dc18-08dea6d74c65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|7416014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	gU3jC268k/ofs6B/tdpvCfoV5avw/P4oSSs4AItjf4w7zr/BgWSL8rIRtE4tu5OJUm1t5aQp+jTA6BXTv+bEKPVXqLnR7LwBp7/OAfN0wDU9j8J5yL18INltTBkwGbz+OBNOj1r+VvKl45N4oPT6fbsmIwvOsDdP1oldIaBCi4Jad4BJrRpDiaCStRydPR44RAY4XD8vDCCtUsqNvvlhssG35XH4ovlTXl7hFLgs3/1bUloNFFJMZRKqQ+O0kMxeDlP5jXBNVJF/RR8IMjODKPVi8ezN/HS8Qncr7Je15l80zjX638907Uueb2Kr1JzB1fcfxbOm3oWipAt4aI7tVGeEC9MPexyHMKnPl3FSUgAC4dZ9SEgIXAkYlcAWVN8JdCOdCHwkr5UA2BnX+cMzYgUHHnZ3j5rd0T0p8H2zYl4AtUUOMKUMl6WvlZoQCbCRjHpBsMcqUDBvWcgUGZcI0FhU6Ss0hgKvZimuIz7tq51kEeWrnv/cF3OXYshmbsNobmupQoSbeZ5ROwm84tnM/EvEZb7sN9QwFguv7JSf35pc1awjXlj/NbhBK9MkxKHI9GGAezSW/36yJtRq3ugfhVfShQ1/I7xmfJHu/0j4K8/Vi4EuwIdzjLaz7mIuGLUXzAtjkgzTX+Gf4MfTLsjbSzp0f2FXvGsUiPOwVhfUQZ0f1DnpZrYNuwx16PTxp5vJmupkSZsmtN0Nes8DCVp8hwZRlZjiYnrNMINOB7BJbM0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8300.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(7416014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5Gok1QOF2Btb2QT0rjsYAcisR0mWFpB9YdINIsLXAsLgG0Nf79gADujVSMS6?=
 =?us-ascii?Q?sg0/09Ui8QmdVPqi8ETZwl1N977YQJHC3qn6jfLr5ieWZKq/ggpQdBJ43WRd?=
 =?us-ascii?Q?eKmxAdkNoqqznSNzJYjPkbUPdx206dt2sCiTEcbrIP0At28oD1/G1qmmQ/Fh?=
 =?us-ascii?Q?mSGq2RgvOklxj0MgSGcl9zYb9Bf/6ZNdXSteVaJ7R5Z5zSDgbGoLCj4iZEMZ?=
 =?us-ascii?Q?7Dibcqq0y+VeAjbOLsbL4DHeLHgibqGwGTOG+mA0ryc5RgZZjVsyS34cIDcd?=
 =?us-ascii?Q?1pRrK3v0uYD5MWMl+LOX2p1up8JWiN/f9OF/yszZMQ/tOltWzZIIqN2fE3Op?=
 =?us-ascii?Q?qMzKUTkKb1Ytp1ZZb7G4HaAj20JfcpRDlfexOyb0F94j24lUHW2ajxvLGGUr?=
 =?us-ascii?Q?SCbAHOvOj4jTGntxPAOiYBuncxkpFVBmDLWd3Tzp9Z7ylg9GXTjFWei6RouV?=
 =?us-ascii?Q?axrP36SzMhFrNWd7UE/P7zDdcvErAdRC2NC4Eq2C9lgeeVBz1zmMLbka1syr?=
 =?us-ascii?Q?x4Dd6Md2Q61mmPZCglB+qX2q8bZ0kw41whWwLfZ0MpgaTcZPqiwyOY32XXL4?=
 =?us-ascii?Q?WK1RFvg7xmsa3Ggmqfc5xpkd2yP1b0NGz70OmcWZwIZ/v6o9Qal5BU362/b0?=
 =?us-ascii?Q?dXRlutmZm+Bw1LDfYzNUIJn2sRWisY8Ee0WTMIUcZOxbUBfHpC9gA4H6GvD+?=
 =?us-ascii?Q?OY1v5CC35XmjloA7h1oR71hMaeL+O6bGHdkIc4692llbTgpehQwZ5bdt+jSh?=
 =?us-ascii?Q?XVrwojXv6RWrZlnmRTdg5yU6Jf6ACFEYaAqDn+HG4ZmeRNUSjvxBW4+qDACZ?=
 =?us-ascii?Q?cIVcoX8YwqgGinrCp8RR5CvuFXsG7kUYF2slADq1wsjktZta7cDi1aa4GdLZ?=
 =?us-ascii?Q?zBCdqjwxYDK3tRHvtrrP5wRq1YPmcqg2evD4vch+xpFzH5gKsGyRi1XRgSrV?=
 =?us-ascii?Q?mTXA5dYMTbuXzZIGQly0Xf1YJ8l/ci4GPQs6SBw2oT61TAJS88gTcYJQcH7e?=
 =?us-ascii?Q?8n36IMpCPql584DdBdeGM4qfIEXQeEqNFPgN7sw/7q8+a10qRaF9HayU+wBL?=
 =?us-ascii?Q?RZmiSQoHX5+0s5jANniQfiAKRCrmGnV4U4FGTfDTMmrJ9wKL9RVXuq18xtRI?=
 =?us-ascii?Q?cymzPUr64W7XBzzq4aVXh8ZdjXrJ+kbm8lARY05WFDosikJmZEmSmPEeMs4v?=
 =?us-ascii?Q?xnQ3PuB/6V2zkj0vadi7hOmvziFHuE8UziRCQ3Z9lXG/csKK3sF98OkuwEEc?=
 =?us-ascii?Q?UiqflaWPSCPiDxM2zvOwnT5QXvdJTwwfB0cDo6fUNwuYWBHJcrliZO1Z4Eqc?=
 =?us-ascii?Q?5X/EQ6OBZHAszeMBYTGgPYKA31qc3JKwy816+yQtRO/Neh1FZCYn6LIZ2Ho+?=
 =?us-ascii?Q?+VDklreTecCnhcCCxispsIiEdxLwSBbnJVBBU92AVyZ/NjUUYXCO5SoUjv1B?=
 =?us-ascii?Q?IdTVQFipDK9wJomMMUEmcmINv0MHFPTz4uLzHVmeZs2f48p/8tkjr3ZH3sL/?=
 =?us-ascii?Q?QsUoEdYAoRtJSxgJkvHzWAhzbi4BLhxPwGjbr7jHYPokmMpLWki5UPUrdO16?=
 =?us-ascii?Q?VRVo3aDEiAE8jy6bTNPN+17Q4/PfrUbdbkW2hXfn9VjH2+ghBh9DopJRt8kO?=
 =?us-ascii?Q?p8sZSGz9wmew34XclvKgGM47bMZktE9jxI0/pyLgANLtsOwar5FB7JwjzUR8?=
 =?us-ascii?Q?HAjzd0+GFkcDbRegaFErL3NcA3+D5zPYumHL5zBjFXL3qY6/xw+WyCSvl2JY?=
 =?us-ascii?Q?9/KNkNx/LRAMMb1QHpb4bhBAHBCRvG3N36xySzOIqqaeKTCSTmrO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80784a2f-e24b-4a28-dc18-08dea6d74c65
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8300.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 16:41:16.5027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q8K/I34gykqXH/Nv4L+bD/hmjQJnidTI+DACXBkhLn8+pR1PecGzNj01bIcQWIsN+DlUxrmwbR0Uir6g13E+GQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6097

On Wed, Apr 29, 2026 at 08:59:43PM -0700, Nathan Chancellor wrote:
> On Wed, Apr 29, 2026 at 09:47:12PM -0400, Yury Norov wrote:
> > + networking maintainers
> > 
> > On Wed, Apr 29, 2026 at 01:29:22PM -0700, Nathan Chancellor wrote:
> > > Hi Jinjie,
> > > 
> > > On Tue, Apr 21, 2026 at 09:07:51PM +0800, Jinjie Ruan wrote:
> > > > Define generic __bitrev8/16/32 using the implementation
> > > > in <linux/bitrev.h>, so they can be reused in <asm/bitrev.h>,
> > > > such as RISCV.
> > > > 
> > > > Reviewed-by: Yury Norov <ynorov@nvidia.com>
> > > > Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> > > > ---
> > > >  include/asm-generic/bitops/__bitrev.h | 25 +++++++++++++++++++++++++
> > > >  include/linux/bitrev.h                | 20 ++++----------------
> > > >  2 files changed, 29 insertions(+), 16 deletions(-)
> > > >  create mode 100644 include/asm-generic/bitops/__bitrev.h
> > > > 
> > > > diff --git a/include/asm-generic/bitops/__bitrev.h b/include/asm-generic/bitops/__bitrev.h
> > > > new file mode 100644
> > > > index 000000000000..f06af929678d
> > > > --- /dev/null
> > > > +++ b/include/asm-generic/bitops/__bitrev.h
> > > > @@ -0,0 +1,25 @@
> > > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > > +#ifndef _ASM_GENERIC_BITOPS___BITREV_H_
> > > > +#define _ASM_GENERIC_BITOPS___BITREV_H_
> > > > +
> > > > +#ifdef CONFIG_GENERIC_BITREVERSE
> > > 
> > > The dependencies of this symbol seem insufficient, as I can trigger a
> > > build failure on next-20260429 like so:
> > > 
> > >   $ make -skj"$(nproc)" ARCH=s390 CROSS_COMPILE=s390-linux- mrproper tinyconfig fs/select.o
> > >   In file included from include/linux/crc32.h:6,
> > >                    from include/linux/etherdevice.h:23,
> > >                    from include/linux/if_vlan.h:11,
> > >                    from include/linux/filter.h:21,
> > >                    from include/net/xdp.h:10,
> > >                    from include/net/busy_poll.h:19,
> > >                    from fs/select.c:33:
> > >   include/linux/etherdevice.h: In function 'eth_hw_addr_crc':
> > >   include/linux/bitrev.h:16:20: error: implicit declaration of function 'generic___bitrev32' [-Wimplicit-function-declaration]
> > >      16 | #define __bitrev32 generic___bitrev32
> > >         |                    ^~~~~~~~~~~~~~~~~~
> > >   include/linux/bitrev.h:67:9: note: in expansion of macro '__bitrev32'
> > >      67 |         __bitrev32(__x);                                \
> > >         |         ^~~~~~~~~~
> > >   include/linux/crc32.h:107:36: note: in expansion of macro 'bitrev32'
> > >     107 | #define ether_crc(length, data)    bitrev32(crc32_le(~0, data, length))
> > >         |                                    ^~~~~~~~
> > >   include/linux/etherdevice.h:292:16: note: in expansion of macro 'ether_crc'
> > >     292 |         return ether_crc(ETH_ALEN, ha->addr);
> > >         |                ^~~~~~~~~
> > >   make[5]: *** [scripts/Makefile.build:289: fs/select.o] Error 1
> > >   ...
> > > 
> > >   $ scripts/config -s BITREVERSE
> > >   undef
> > > 
> > >   $ rg BITREVERSE .config
> > 
> > Confirm the same for x86 tinyconfig.
> > 
> > The problem is that the patch makes generic bitrevXX() conditional
> > on CONFIG_GENERIC_BITREVERSE, while before they were conditional on
> > !CONFIG_HAVE_ARCH_BITREVERSE. So if you don't have arch bitreverse(),
> > and dont' enable BITREVERSE, the generic implementation is not defined
> > now.
> > 
> > Luckily, the only user of bitrev() in unconditionally compiled objects
> > is CRC32, and it's not needed if CRC32 is disabled.
> > 
> > This is the minimal working fix for me. Please let me know what do you
> > think. I can prepend Jinjie's pathes in my tree with it if it's OK for
> > you.
> 
> I will run it through my full build matrix overnight and report back
> with any problems noticed.
> 
> > diff --git a/include/linux/etherdevice.h b/include/linux/etherdevice.h
> > index df8f88f63a70..245b206dd38b 100644
> > --- a/include/linux/etherdevice.h
> > +++ b/include/linux/etherdevice.h
> > @@ -20,7 +20,9 @@
> >  #include <linux/if_ether.h>
> >  #include <linux/netdevice.h>
> >  #include <linux/random.h>
> > +#ifdef CONFIG_CRCC32
> 
> Initial testing shows that this should be
> 
>   #ifdef CONFIG_CRC32
> 
> here and below though.

Sure. Please let me know if this works for you. If it does, I'll make
it a regular patch, combine with Jinjie's work and my follow-up and
resend. Meanwhile, removed all bitreverse material from
bitmap-for-next.

Thanks,
Yury
