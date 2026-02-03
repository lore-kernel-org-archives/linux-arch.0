Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011059.outbound.protection.outlook.com [52.101.62.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DAEBA21;
	Tue,  3 Feb 2026 19:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770147712; cv=fail; b=ho5eBspJD+t3y7fk4oKy6zkfxV/aCMI52k+zxVyVrErF0TdkJQd/UMKWza2BOx1R2ZX9Lc6mcRSbJTMVRUXLWDV6ltx4huEI0I8RawZjYFwAZQXn56sr4R4q9TdBe1bnqjqD27nLlFmcM+x4Y6hLFk2IZfIlveMIXkc/ZDbe+I0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770147712; c=relaxed/simple;
	bh=BBbSgzGdmHuy3ZXcXJaFXe2sRDB/KxXYLZEev4a+hfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tPY2xdxmAvuMyzA1qazZBGESG4xg406nXA8P8th2p1nNK5Gx6fIQOG7yukxGhwojCVj12WJsZej0Qnsv9lVr7UQzAf98FWHskq7Bwk1tKDFGdBrmekpRWqW43Gw4jLLO73vYlvkR/gCFsMW4MYRWaFVnWSzvlTOsESJVVDx6ovE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IaB/a2qM; arc=fail smtp.client-ip=52.101.62.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IaB/a2qM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i2UMSX74XtJXOPlM5J0IPyZkGd++muh+tDrCWkBBN5+gXk6kBraxlkAcvbbHT0BVtOi4JQnFLQMQUS8hewtvMvbGdOhZ1Emj0xUJtusTNpLyO6Cj+I+zy5ohqB9opHyM3o1y6CuHSgeGt5NRrlDG1C12BpxqLbwlMT74OwGvSuse8DLqJjGRYp3xk7bNcPSYmsSWMobazfkGHnzL2L1mVQWXGezc3LNN4kV5zkJzzlJmy67yR8kSxLCGFXlxE7gYdS+jEYH+YNIyBN2qeU44+4SoTcKVz0uAoigALNJCNTddCS6rAJQGB7p5p0aumQHq7vtPlDBGurBWMXHbLXOsBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1sLHrn5TJyy4F54FpIv+rjGVo0or9jo9fQj0PdOSe/g=;
 b=ocjKT8+dB4uecprKNBKIw5tCu09R6fV+EvDgBjsIIwQB5AyrAT+3PgMQAvp5CUCAow1cZqHGcCRD+9vxsx2WSWp+IgE7GTOSlVBNxgC6+0Yk4eJsOyj1SfnzjiinlWnE2bO8Z1+SAtaKnlWJPkLWzGSuv7SVX3B8EmXlziNd1jdiZ2ME01l8hABtkbLk54J6CUwfnsdnyg4ufBk5K+UVMD2loCV3XzNbfokZXUv/UoHE1C7GPz58TBQQC94hpWXmA7xLM9jY4ybaHTBDNtNy5kyiVkLWqo6BPOh1afEvpSV9N+dZgUyyGRdzdXh0tmT68ZugTauTWLogxCzSRbUS4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1sLHrn5TJyy4F54FpIv+rjGVo0or9jo9fQj0PdOSe/g=;
 b=IaB/a2qMz/IvjkkYaZYHxUNrI1if4f5HOxRhjiTXzwYXS0i7TJU/Esb2R87r13wjl0pT1oZiF0CaMlZ8NM7kDJ4EtVqvIz0R+WzxtphQW6quQ90OHxIWLNtdCGrTUKh3f9N96iGTqRJzYKZydH8oTCwu739taf8zD+WgWGQltSrqGIX1Qu8DTRDN7YsKoqzeL7Ro5eC1r8Vp8FKo0UDeu3Ucun1MSAZ1MckK4xMLlaeRi+hwgH3baHfgDHkJd/NLDdXDP+ZTQFAYyLtz4Zw4SB0bI2sWcOY+IniZkfQexxc2i67gObOtOfttmEa9nn6BgXCELtBTe+/IlqHkdnUmZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB8800.namprd12.prod.outlook.com (2603:10b6:510:26f::12)
 by PH8PR12MB6771.namprd12.prod.outlook.com (2603:10b6:510:1c6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 19:41:44 +0000
Received: from PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d]) by PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d%4]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 19:41:44 +0000
Date: Tue, 3 Feb 2026 14:41:40 -0500
From: Yury Norov <ynorov@nvidia.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Nathan Chancellor <nathan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, Yury Norov <yury.norov@gmail.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Kees Cook <keescook@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH next 02/14] kbuild: Add W=c for additional compile time
 checks
Message-ID: <aYJPTo1B2K44c_kj@yury>
References: <20260121145731.3623-1-david.laight.linux@gmail.com>
 <20260121145731.3623-3-david.laight.linux@gmail.com>
 <aYDt8gLSRbFHwVpn@yury>
 <20260202200743.6182eb60@pumpkin>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202200743.6182eb60@pumpkin>
X-ClientProxiedBy: BN9P221CA0019.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:408:10a::34) To PH0PR12MB8800.namprd12.prod.outlook.com
 (2603:10b6:510:26f::12)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB8800:EE_|PH8PR12MB6771:EE_
X-MS-Office365-Filtering-Correlation-Id: cfafeedd-31e9-4f78-a2a5-08de635c4286
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OZzE5BbmDh52YvATQkrvcyvcUXHRdYhVvHZ2ynHr7nzoSSoXF1x0ovppiSL4?=
 =?us-ascii?Q?P5NFVMoNikwKgC2eHhzL4tKzd7J7Lch7QqYQESYJqe9f/4V/MlejB+1vfQCL?=
 =?us-ascii?Q?E+GrgPyu5ub5aIynmoU1kmtM5TL2iTVcsj5TAkysU5h5zeVVClasfBlisZpC?=
 =?us-ascii?Q?Ck/O7J7TS0Slo5lrTOKKvSenxAL3hP361OJ0zrwiyAoedr006o5lwRw0EuQ9?=
 =?us-ascii?Q?RiSZXuecDI7P4XcX1DiDAbh0e3fLWVA6u/vPkjdNFEM8pAmHIbuBCPKBzM6m?=
 =?us-ascii?Q?KIrU+N/d9e7G58xM4j9OqlCNi9t6LO8bDxK//fKubta+nPoy61gJR3WamH5c?=
 =?us-ascii?Q?pxkmbfxYL5MCFl58rFu1VS4UTdyJ7q/LrDakGIYeqIx/38ajPLfETJnCSNDE?=
 =?us-ascii?Q?AGRBtDBkIokjzT4Y/l7TKNnKniCyNM895reaT/EXiNmmQ+ExdRxWJlbPnK8Q?=
 =?us-ascii?Q?hyYXkDPw9147UUqFm7+TeaqiTSQN0KEeq77AfWrL3HIyfw6jTCfjW3Yv/bV5?=
 =?us-ascii?Q?ocfbSGYO119ltHu0nc8ETBGiZ7kXT+77cS9vPjrc4E4XUMccrAODrf/p3Jlx?=
 =?us-ascii?Q?FuBeFlD74XMgmctNGFHgt4xOtD7cgJz171G0o42DP2f2E0DKwcBV5fAqKhl5?=
 =?us-ascii?Q?GNhsF3WLBbj5MZQH9s/pZXmDCUuXfXt+HOMnfCqed4wENBl2j8PqpVF2vdHb?=
 =?us-ascii?Q?pJIkCswEoNygTSDDkpIuuFczlCMsuLvaGVlMU0aFi3Q8WxcSD9qNzMsXVPcb?=
 =?us-ascii?Q?TVLFMbgMuKfV8BoGlH81FA6y8EGHC42l2zQC3wLpo43QmwOYC23tXrYp7VDQ?=
 =?us-ascii?Q?TmOxppALoTZ1UEocW4+eFbOijFiozKFxHZW8YpR5QRarqrgf72PbqfRb1L3E?=
 =?us-ascii?Q?NJ/Jsl2EdTa/PlqO+KnbfpaBXbnh3CKw43g/oLdhze8d4VJ5N9mV/dsxVEbI?=
 =?us-ascii?Q?ssHhXRdipuAKEPMf4DC4kf9xqYZmB3nTjHwarwseE+nVW4mdEXDBpNwGobwX?=
 =?us-ascii?Q?X9SWjozljL0nf0/0pCCl8SZKAnyQ9pgtvEIKD6hejzYOA99BbYDBDix0hvtm?=
 =?us-ascii?Q?PpwZSNmyaAcFB8GIUMo8EaFMq9PWQ9uXXCki9jgxkDrJbEoV+BChJzaUvrgS?=
 =?us-ascii?Q?JkOrKZNMwXmvOlgYm8fSZ1JbsYvjQMjV2TT85IQp1YMkROYmc8fgt68IA/UL?=
 =?us-ascii?Q?lv5vScQ0jzbHG/AKelvtJhvaGejzzSG6Sw5tagKONOMBZKXe/mKzkC3BuMYh?=
 =?us-ascii?Q?oE/fDCe6y+VslQ/0/r0+2qLaedPA9lUrr34wFWkSpsDPUHD2ef2RJr4Yj7Qr?=
 =?us-ascii?Q?1C7RbBgNUFt+Q5e0Q7Yvf31X+VyqaTsPVFdIZKyq7IgJQVEslpVddjpOK8/B?=
 =?us-ascii?Q?3TtDhJKpuEsr/6jmQ46MjVBCIAO/cfzZr2NYdcapEnSgGz0xveIAdO2CST7S?=
 =?us-ascii?Q?0Im9MXAYntU1V0tKKvbFBCduN0XlhdJokuYux5ON5myl2mFdye/DHPsEBir7?=
 =?us-ascii?Q?KcZkbvfMKWDMZ9hYRJBSu5APkdFJpbDp2lWkXUNxrYhytCPzQwI6CmFurBfh?=
 =?us-ascii?Q?Wk9+fiVNoOYdu2n8gzY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB8800.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(10070799003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SI9llbh8wH1lXOgudsdruksyfeLrwbyMkuuS0Tgc/1xX4nXzaYqkW9fUYGZL?=
 =?us-ascii?Q?5exVUWPd8S14I5S6PTeh+Dsirn2jZOIF9JD5RnKHV8tO+zJ1fZTKLtu1lMTq?=
 =?us-ascii?Q?kVMfFJ4esPbLMyFWbL/ws/E9aUjl86GpSl7CXN5B6eHeMPWXdbQCJnSjho+G?=
 =?us-ascii?Q?ls1aNNinEatHu/OPPJTW4mNXCcay4is4kxC0bRZeSbXKxwpH5Mo387t5mCSt?=
 =?us-ascii?Q?Ch35cnheggxzUhoFOHuA7tlB5KGEc2W7CScoV0hbQnLQJDXWzUWWocE58sWI?=
 =?us-ascii?Q?efLGcZ18wVf5/DUaPwawhYZASKoDIBSxelm6aQNdL1/1k9orEKh+5BuAYV1W?=
 =?us-ascii?Q?J7s8GAPp1e3ENmwMn4Z4fjYdj0rBQIFglyp2nCbycImj6x8rIXDu0rjHPAjF?=
 =?us-ascii?Q?onGsESTT20qcyQQoUiT60+yW3/iwDIqBGBF5eRe97ipo/ra+yUec/QgZFLM2?=
 =?us-ascii?Q?lpD0CSGDgdWpts/THnkQG6bkLRVynQRKdXhtr81w6lck+4BPQWdRRtYeXet+?=
 =?us-ascii?Q?blhxm0C1wm9l1HMMar4EmU3DReRR4QH3/tsD0SVNDrdnYY2nJ6x9KMlFLxKp?=
 =?us-ascii?Q?ATvvukehmxFLYyPbYkMjLfwLi1e3CbU93AYR9FULv3kQ9+MTy9/iNfD+cy6z?=
 =?us-ascii?Q?kuodfmpw4Bg/INgoOnwj7JUxvlZdmWpAft5BO4Q/Jp2pIUqU8/wjTkdFlwDF?=
 =?us-ascii?Q?oC4VyjNAqks/4dwDpawEW9KkCdvri56cT7ZxuuN6R2yybtskf9h/MOhUia9Y?=
 =?us-ascii?Q?fjVom+aSgm1WPPFOwt0v2oJoO9DKcs6uOygtif1N4DZs2F590tFf2Ni9pTld?=
 =?us-ascii?Q?+/rtITfPSEJSexCRDQP13lhLkUwlxsr/nbwoZCjhxmS/+KK52XdM4rAfS/Xg?=
 =?us-ascii?Q?UhHBzs3yc6lTTsTjzy1Gt63wLxyRXQ5fSNH1emp7JE8uBCu+ePHrbwh2jzBS?=
 =?us-ascii?Q?VfkUTxLF5DC+CkEPThQZVezbpk6O21UBnw2BOmDW1nA2u0QfQRragbBLYvA9?=
 =?us-ascii?Q?qRD0BkjQrqVh379dWyP16KU3gTRLcTu/0J23Pl163i8EMaUaVXrrtYSbTJAh?=
 =?us-ascii?Q?pDcNGL3zK6dWwbWrfH66JN5Ak5m4K7lOnmXV0Bw/A0bgbpmqqZkTXkV3SUkf?=
 =?us-ascii?Q?nQB6z7htZUC4HvGm7nqc2GYZXOa63/zIr1VzkXOTlPwgrxl73JR+q2QFocQR?=
 =?us-ascii?Q?j7ODaU00WDztpBLkLWBsnbqRp2IY6TyCBsHY/EMnAusRmRUBMePxI32xN6Js?=
 =?us-ascii?Q?3ZBz1M7elM5HOMZVEAmVfhb7ZP0vwZv7qdvO/ulpY7hsWrHRh6qI+glYk5DZ?=
 =?us-ascii?Q?1EO1We6rs3pkCirRg9Shgw7MnSY9ssdB8l7uf6njn3ZHRvbS17An9OMDV9Xf?=
 =?us-ascii?Q?m099RkghFaSVxkWioZUHenVwDRUZwT2dB4EUopSxnjpWYPS17cpph03f/X6L?=
 =?us-ascii?Q?kpNBp7xHjs9qZecQMOZ1L9JdOAyYwRByAKCQkGRBd76Eb6hrOOf6JMhbKrkM?=
 =?us-ascii?Q?U++ohnsB8VJGjLIfILtuoIhgb1mZgrlbgHX1Su2rWOf88oDQ3CERHDb93TN9?=
 =?us-ascii?Q?qXYwOcHejH2eo8CvxkCRZsTEdlRktVY2n7ix3wmG3nLywn8KaHkT9yIzBlJb?=
 =?us-ascii?Q?fG+h6GI524+FsFq5CKG17CZef8wx3MwKDhRTVa7vG0JmN/P+3fz3WL5T3Gba?=
 =?us-ascii?Q?biiY9GajoO0b+OjEztaNMSbhiq8QPZSeOIC7awtEeUCDoPfs/UiGUdCwDRJ5?=
 =?us-ascii?Q?FWQAcFgFrpwJfwPB5A7wcs2OOT5MS4JGbpu8xVPp/x66fbRmVKYu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfafeedd-31e9-4f78-a2a5-08de635c4286
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB8800.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 19:41:43.9458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oCzWClCvQTPJunm9jokAHHFCmjLCHeULt2Uf5bKFfIo3Ico0uVyLwWyp7XXrCBwXZ1rNWR4HbbUyCbmgjFfZMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6771

On Mon, Feb 02, 2026 at 08:07:43PM +0000, David Laight wrote:
> On Mon, 2 Feb 2026 13:33:22 -0500
> Yury Norov <ynorov@nvidia.com> wrote:
> 
> > On Wed, Jan 21, 2026 at 02:57:19PM +0000, david.laight.linux@gmail.com wrote:
> > > From: David Laight <david.laight.linux@gmail.com>
> > > 
> > > Some compile time checks significantly bloat the pre-processor output
> > > (particularly when the get nested).
> > > Since the checks aren't really needed on every compilation enable with
> > > W=c (adds -DKBUILD_EXTRA_WARNc) so the checks can be enabled per-build.
> > > Make W=1 imply W=c so the build-bot includes the checks.
> > > 
> > > As well as reducing the bloat from existing checks (like those in
> > > GENMASK() and FIELD_PREP()) it lets additional checks be added
> > > while there are still 'false positives' without breaking normal builds.
> > > 
> > > Signed-off-by: David Laight <david.laight.linux@gmail.com>  
> > 
> > Honestly I don't understand this. AFAIU, you've outlined a list of
> > compiler warnings that slow the compilation down, and you group them
> > under 'W=c' option.
> > 
> > What is the use case for it outside of your series. I think, a typical
> > user would find more value in an option that enables some warnings but
> > doesn't sacrifices performance.
> 
> All the compile-time warnings slow down the compilation.
> Even apparently trivial ones (like the check in the generic READ_ONCE()
> that the size is 1, 2, 4 or 8 bytes) have a measurable effect.  
> 
> The code a typical user compiles won't have anything that trips any of
> the compile-time asserts.
> They only really happen when compiling new code or adding new checks.
> 
> > Can you consider flipping the 'W=c' behavior?
> 
> Why, most of the time you don't want the checks because the code is
> known to pass them all.

Please don't speculate for what others want. I already said very clearly
what I (probably) want - a performance-aware set of warnings. I can tell
you for sure what I do not want - a heavyweight subset of W=1 with a
partial coverage and similar compile time.

> It also means it can be used for new checks before all the bugs (and
> false positives) have been fixed.
> I did think of just enabling the checks for W=1 builds, but that makes
> it far to hard to enable them.
> As it is you can use W=ce to enable them and stop on warnings and errors.
> 
> Also W=xxx can only really add checks (there are some checks for it being
> non-empty). Documenting that W=x stopped the 'x' checks being done
> would be painful.
> 
> > Can you please explicitly mention warnings included in W=c vs W=1? Can
> > you report compilation time for W=0, W=1 and W=c? What if one needs to
> > enable fast/slow warnings from 2nd or 3rd level? Would W=2c or W=3c
> > work in this case?
> 
> The W=123 options are all completely independent, my W=c is the same.
> I'm not sure it is sane to run W=2 rather than W=12, but it is allowed.

It is allowed and sane.

> I made W=1 imply W=1c so that the build bot would pick up the extra checks.
> Apart from that all the 'W' flags are independent.
> W=123 fiddle with the command line -W options and set -DKBUILD_EXTRA_WARN[123]
> so that files can include extra checks.
> W=c just sets the equivalent -D option.

Again, please:
 - list all warnings included in W=c and their performance impact;
 - report build time for W=1 vs W=c vs plain make;
 - how would your new option work with W=2c, W=3c and so on.
 
> > What does this 'c' stands for?
> 
> Anything you want it to :-)
> Discussion session arranged for 2pm-5pm by the bike shed.

Meaningless parameter names are not welcome. NAK.

> In some sense it is 'more warnings than default, but not as many as W=1'.
> Like a lot of the W=1 warnings I wanted to be able to pick up 'code quality'
> issues without breaking the build for normal people.
> 
> There are definitely some other checks that could be relegated to W=c
> once it has been added.
> 
> I'd also like to add some checks to min_t/max_t/clamp_t to pick up the
> worst of the dodgy/broken code without having to get all the patches
> accepted before the test itself is committed.
> Tests for code like clamp_t(u32, u64_val, 0, ~0u) (yes there are some)
> tend to get very long and may be problematic if enabled by default
> (I got burnt by the 10MB expansion of nested min().)
