Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012071.outbound.protection.outlook.com [40.93.195.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF592EBDD9;
	Mon,  2 Feb 2026 18:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770057212; cv=fail; b=K7xDRf/6hwuHGq3NDLkLRrAst3x4OQN7lwYumLcINd5+hbw16f8H3vf5M/KkLFBAAjXXt0Nrqt77PnkbrNUJ15P+TfVwusBV5KoSpESe8hjlhysqEKfUi8UEQRayEUWSGqruQz8MjRBM6i+tvhfY0C5oiWXNExAe787VLcmXRT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770057212; c=relaxed/simple;
	bh=sXWS/CQ8aSqpm6F5sos7fnufdHIRtUYh9xmYs4sDL6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dQ3aam9Z6gAPekGURjnCz4ZEV2FDrRK5Cx2kXqb+kClPtTN5Xs9ie9qN+DPvIZZ01FjD/Z7D6lqAXWuULQgzFOeN9nSyCS74B4pgwEmcOp3BqxTK0BaZDn2CYtKTNHP9McI+K0OytvoHaPc9drZJD+0KISXzPSB91lr7WUCzNbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SrvjB5fG; arc=fail smtp.client-ip=40.93.195.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SrvjB5fG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ez0B/7lPJbqHyxu0Xx30VXIK3IjDmK09A7dVj8JHoUvV0gKqSgPGBb1+6nNkjTVIBPAHu/zMpmNNOmHBDjRtSmzVnEPSB5mcR+5jDImWrFd1VNWR51IpIB3/J7QXOlGSzKzjWwoyktj9nXAc8U5m/LA5/7aIoWSb36dBA2Uuf5FKBbSQN7m79CWVYhyY7AnM4ah0SSpwc7k2L2hi1kP911zaETI/kXwP6pyuvo6heqGp8eLHYboJtSXdXDCflDx245TsmgmCN8vbYmH76WyD2aKEESuYH2LYwKUNS8xGG5BYOe1phCSdc+wtSN/oFHkT6LMaCohge/7XWUqpYjEDJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IB21WyXklEIS9fV+wwt7S2vg/YbWbleLrTqIKIZZYps=;
 b=MEd5HOMe4HtVtDGfwFWnU+8ukhfonl/f3PGnCNyXsV3pGSDUkmXU2rNbwZepxGB2XoOYBI+NLBghg65hKOQsaS8YUTWrJB1tJAKqGJmlopTHSLlsXff8UYMffEVlRVhAX0dbvCdAk2vD3I3+Rrx955jLyB/Ow+QMfkNUjuVBwDXQB5NCJ0axI5XNonz2Lfz/PQaexx1cKD/b9RCs4tCf88oE1jgYsQWTnERNRXU5tmYxhe+N4u0mJ/O/D8tKAfJV8wpEFUcRwjZMq+xnErp5j4iZ4hqtvba1NpzW50/rY4ntjMgwApRlXOwzeX0ne90x92SC86O37nyEiQ2YeIXwfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IB21WyXklEIS9fV+wwt7S2vg/YbWbleLrTqIKIZZYps=;
 b=SrvjB5fG81FWKUZtxW+jYWnXBVShH+JG6OcezYfVKT2pV/rawHNPd+Fn2s2F1RhRdq9SRWYhPXeM8CC4bNaBTZCfx8D3Db5/R3C7dclnf4Fw1/8bXVmp1cjl73GjolClQ3T2TGfgfZIuyL/yFxhzJ2bQ4VXm3jXjcz5TUK844dPqeOF+egC+s2RjiduF/ehvwRdcENTQ7VYYoFD9Lspz94mOCbrlBgQVZBdFp6ASlAHMRr0Rf11vPTa5LR0AT9dJfsYpg4uqGCKcz1Y23V3gcS0Q4YLuANWdLAUOIKKNSjE8hFyWjT9XkGjv/8KJ9I9bjj6Vs9rrhyMeoMDsoRN/Wg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB8800.namprd12.prod.outlook.com (2603:10b6:510:26f::12)
 by DS7PR12MB8249.namprd12.prod.outlook.com (2603:10b6:8:ea::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 18:33:24 +0000
Received: from PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d]) by PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d%4]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 18:33:24 +0000
Date: Mon, 2 Feb 2026 13:33:22 -0500
From: Yury Norov <ynorov@nvidia.com>
To: david.laight.linux@gmail.com
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
Message-ID: <aYDt8gLSRbFHwVpn@yury>
References: <20260121145731.3623-1-david.laight.linux@gmail.com>
 <20260121145731.3623-3-david.laight.linux@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121145731.3623-3-david.laight.linux@gmail.com>
X-ClientProxiedBy: BN1PR13CA0023.namprd13.prod.outlook.com
 (2603:10b6:408:e2::28) To PH0PR12MB8800.namprd12.prod.outlook.com
 (2603:10b6:510:26f::12)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB8800:EE_|DS7PR12MB8249:EE_
X-MS-Office365-Filtering-Correlation-Id: feb3cfc6-9f06-4fdf-4344-08de62898cb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?F+R5lUlazg8GYwoHEWeUHpwlecaMQQujkgKpEOjsglIk6J9oj9Js+LZgUNhk?=
 =?us-ascii?Q?FSZj+g847HqQybW327A6Znmlf2knpQFMq9SDvvEu5Ww5Na0OXR1s1EkZfvbM?=
 =?us-ascii?Q?Iw/OSgNBSyD0H/dLjmy2TAQHMaAf4s+YbNTzv8Zl5Fm7QQU8ObRulz7bYyAZ?=
 =?us-ascii?Q?GusXT4jiGAAPudKqisk1dPopbc0dtnLW7rRC3qsBoa5cUXSJPQfLbNEui9No?=
 =?us-ascii?Q?5CyV6UhPoDxHD4Ydx7A/VyWdiAs1CIV2ilOq3lb7wQugB7tOkvehcsrrgSFC?=
 =?us-ascii?Q?cXunSr2BB1NEXCDj6kHBJ8Yq1tAv68ZfG/6n8O+lbAaZXrym1DF/JG1IUr/3?=
 =?us-ascii?Q?7YjlDU66cA7J1W3P4jbhoSaHZTblK+arK92UZF5dLPttoWFxRg5396WmCgeH?=
 =?us-ascii?Q?3uizCQHuOLGJwujsRuDnhPB4HtwNyraC8xR0AQGQGbGR8XJeF0juangPScHg?=
 =?us-ascii?Q?XYa8yVjkqw0gPZcoqoE7NI7K0Lye1AvTneXTTaNZq6xGNObpXxGDwCJAzUe4?=
 =?us-ascii?Q?ndysYjh7yDuU8pbITxjDFnIajxfuaQkOA4k+WKbnuaR+1voyj+b5QLi+9tbb?=
 =?us-ascii?Q?7dQkeAgtlxfKiGeydrqbpNLEBAQJ7oAtkXa/pPT1BbRCM+I8KZmkwlpmupxz?=
 =?us-ascii?Q?FTRgRPbToYIETROcOLkEO+Sx5OM064cmOS5PpBoHQagnnLU261tQ47400w62?=
 =?us-ascii?Q?ZGhWNIw2ldH66jYjueOwaA5R84VpY21j0R9BakdBL+PzCFJMP21xckSY40GH?=
 =?us-ascii?Q?KEqwt9zgLddKyisdU+rEou4Yv4eCZL1IRdmPRQBQcF9juQhtgTgeuoD+ji+j?=
 =?us-ascii?Q?58hjbLxUFbAr9t6SPACauBQHlKVQVm4nGaB1xQl7OM9BUxk/GO8m22V58kpp?=
 =?us-ascii?Q?Qj3CprAEnvi18SAhhn/aq6kZvBEiBAesSpXnKj2ryHL6jzJwD9VHjHgdbUCw?=
 =?us-ascii?Q?EPrYt1NX0+EazIS9R69+4V4NQ0b4ld0vpiuT+Y+lQHL/FI7bdpX/Df72DfJx?=
 =?us-ascii?Q?rjIhAJ/pg8edf38AXJ/fjeZ1X2VpW0DljqASxgm7FgFgB0u73Qww97VJyYy5?=
 =?us-ascii?Q?/IyM/+vbUEu4Awcg4/BUJtjbv+AvSBtrP1Rq2r7MnVNMTw0npvjCBN0uoouD?=
 =?us-ascii?Q?sdcnH+fgHKZqKO8T/Xisk+P/E41VKpBNLE2B+HVBY3PenDVSOW0pVANYFzAk?=
 =?us-ascii?Q?PPY5eyQ1sZhYWzl5+Xae8pVv7/hjklWp+ZSsEglJNP99vzeV8mWalezSuIkF?=
 =?us-ascii?Q?BQgmdzg8Qu+4vZPnvh22BFccrJNpAV43tvFLhFgRVBMhzga1Ff3/D1w1N9EF?=
 =?us-ascii?Q?60GR9WR/SMocHtxHdQcPjhI8G55SbJ6S2LDwgjzgMASVyL+XltlPDMBGln/l?=
 =?us-ascii?Q?B+KaWQ6J3d86amEztmuDJnH6iGs6bEX0BxzgLHun3ouxd5yNOjjc7JROJKrk?=
 =?us-ascii?Q?VdDXyak9a5Jv4/qAk/Jy1jPQDTOlcmztYFzQNlOwewk2tF5b1qtZFyrpze6p?=
 =?us-ascii?Q?TCvUu5APlRfXHuhhgG85G35G6dc9NB3iYWu016BpNB/gIJnTy2kMsZwkvPJF?=
 =?us-ascii?Q?Uorka06akp+YEwJGvak=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB8800.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3RIau9SrXwm+zQ8srBoZem2M31BBqdwJt0B5S+FFThnnAVZYBovErJW4Nhxu?=
 =?us-ascii?Q?qIVh3OcEmoLlWuy68LOxPT3/xAGnwXX68q58JxDBzRnkbspakReuvEXRNAT+?=
 =?us-ascii?Q?lFj+pkFHj+EAgyF/JzTk70+7XZosSqf4vyWGcNv4CyhxAV60hEKryXpTCdSk?=
 =?us-ascii?Q?v4llpp3ag3S8E7qV+Sfda0FWYiKggOrsYoQJP5LEN/Vw/GwH54FLy7LA2pjP?=
 =?us-ascii?Q?2B8Ed4MucN1BO/nywgsqO8yZc1qHNLh+0FJNFN+WMrtnM64vilAA1PDkpV+N?=
 =?us-ascii?Q?S3RcjGvLrFpiiGpq/OcB7foW/QxrAnHS6cIw/OQK0skUKHMPRW9nEW13/8Jb?=
 =?us-ascii?Q?Q4b9a3Yf+6zHIpplVT+008LS3UqNT57EBb8E2LRrvmSf9RL6uNSRhQhm62WH?=
 =?us-ascii?Q?OJN/vhwqqXkTXydP0oIxzwGWLPoaQXKdnRgqT5fnUf9SC9IHysqpzOMxGdtN?=
 =?us-ascii?Q?5m/bh7HaeE7yPUQ5/g2PkejAEWp/zSXmWUTLmEzs8qcZ9EeRuMZsJccMu+sg?=
 =?us-ascii?Q?6T29kQGYP4waDiODWfZC+KxUAF2Zd7fjWeuDqaHsIyj/t857FC61XsrXAV5F?=
 =?us-ascii?Q?IsY3jS1oqXGlZKY+g2fnxvO0siuz1kCdaIwdwXUIQ5Im82NzAAb0dPhYGj+h?=
 =?us-ascii?Q?8Bzx+TQGkBZIWQQs++WIAX1/KWKI2efT+upxD7fagb8G//0gZJ03eH9BS4Dc?=
 =?us-ascii?Q?NKA+NUTeazsh6aGZQyIqzLhcfm4P3LbNb+4TR1GIHkdrDB8dZ/+rS2Uo6vpx?=
 =?us-ascii?Q?5Y1SzYpWT1O8ig7OIXusT8/zhe2AoVcd5C4skDVi+Lt5kBjcxcYnXLaoCu9F?=
 =?us-ascii?Q?wCMjVWR0O4H0fdKd5vdcWqH88r0JEo2uBcGOkxVyxBcoEykMdz1Akcm8Lt1v?=
 =?us-ascii?Q?/jIBQHv/812p3KskecqUUmHtWgHaJN0PfdBZr3rlAi/OLgB5libiNX0zNbQS?=
 =?us-ascii?Q?AAgPWEGUk1VXaKFe05VTGJ/uCHeEfbwmbpMCXRY3376g6S3CftqOxlvSnK3h?=
 =?us-ascii?Q?VeSJG+yUNHWNHUKkaj8JPtCdec69jeRCEy1UttYWStl4zx1dh/GE0uV4TUD+?=
 =?us-ascii?Q?IdCby6ditNh5Qju084zCsPTv11LkQ0Hr+i0lxebzPmc5KZLgCaKQ2LMz2Qc5?=
 =?us-ascii?Q?rByXOXdxSyNg7ZEckK9a/sIt3/4dap4JoMeR4waOQ9+8mkaybeHwtSRaO1CG?=
 =?us-ascii?Q?pEsyMZukfMTPYaLPJvsegUh1lgHKITeV5oE2gZUYzwqt43FWtuyQPdskgOJI?=
 =?us-ascii?Q?xm1gZgHJCjuhON6/ywuLo3z/vgQGW3i5PJJm5p4PhEwUsN52zoCXjyDGr3Lb?=
 =?us-ascii?Q?Us5WgrI8KK5TLyC/wY+zXLAYM2wZiOUZJ0XAZbbZcK0m57PGY2y5693vSNRk?=
 =?us-ascii?Q?W02e7G+65LdGyGoJ9OuhY9gL5PllUpLh+14kQ6Lw+/Fm9IuEvvP7wDnIvFiE?=
 =?us-ascii?Q?K/0DmFUyjVmfCWPZmuNKi+yivH7pZlHxcmmGxf4+SCiJnNVpJMvnoF+PADgJ?=
 =?us-ascii?Q?yKioLnmHrv2r8Q5s+U1ohP3RD5qXTsONjk3A5xafAc1y/3/OVv85oysbc5v5?=
 =?us-ascii?Q?qW+RxGHA+R9jii6Na5ceiLEmcdVjdfwcL3AOn6BUC1vTtSep+X6MH2d51TCV?=
 =?us-ascii?Q?vlkUkgfZgf8yWJWtdHkwS8zlgkF8Q6hN7LiXYMJITzdRtoa5clHnrutKolzW?=
 =?us-ascii?Q?ltF7vOiYmcgn4Y0k20CkbIrH0NTuZ/Tzo2HT1vb101/VYgWuzEMsMgu/3hPR?=
 =?us-ascii?Q?V/mcH5UwAQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: feb3cfc6-9f06-4fdf-4344-08de62898cb8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB8800.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 18:33:24.6842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KSaviAvogVH3QaPDTdNzFgh4lym3U6lSfSukV6BLFV+ZLRAfj6LKIxV71SPtIuFRgS9RYd9upWI4SQcbZunVQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8249

On Wed, Jan 21, 2026 at 02:57:19PM +0000, david.laight.linux@gmail.com wrote:
> From: David Laight <david.laight.linux@gmail.com>
> 
> Some compile time checks significantly bloat the pre-processor output
> (particularly when the get nested).
> Since the checks aren't really needed on every compilation enable with
> W=c (adds -DKBUILD_EXTRA_WARNc) so the checks can be enabled per-build.
> Make W=1 imply W=c so the build-bot includes the checks.
> 
> As well as reducing the bloat from existing checks (like those in
> GENMASK() and FIELD_PREP()) it lets additional checks be added
> while there are still 'false positives' without breaking normal builds.
> 
> Signed-off-by: David Laight <david.laight.linux@gmail.com>

Honestly I don't understand this. AFAIU, you've outlined a list of
compiler warnings that slow the compilation down, and you group them
under 'W=c' option.

What is the use case for it outside of your series. I think, a typical
user would find more value in an option that enables some warnings but
doesn't sacrifices performance. Can you consider flipping the 'W=c'
behavior?

Can you please explicitly mention warnings included in W=c vs W=1? Can
you report compilation time for W=0, W=1 and W=c? What if one needs to
enable fast/slow warnings from 2nd or 3rd level? Would W=2c or W=3c
work in this case? 

What does this 'c' stands for?

Thanks,
Yury

> ---
>  scripts/Makefile.warn | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/Makefile.warn b/scripts/Makefile.warn
> index 68e6fafcb80c..e8a799850973 100644
> --- a/scripts/Makefile.warn
> +++ b/scripts/Makefile.warn
> @@ -2,8 +2,9 @@
>  # ==========================================================================
>  # make W=... settings
>  #
> -# There are four warning groups enabled by W=1, W=2, W=3, and W=e
> -# They are independent, and can be combined like W=12 or W=123e.
> +# There are five warning groups enabled by W=c, W=1, W=2, W=3, and W=e
> +# They are independent, and can be combined like W=12 or W=123e,
> +# except that W=1 implies W=c.
>  # ==========================================================================
>  
>  # Default set of warnings, always enabled
> @@ -109,6 +110,13 @@ KBUILD_CFLAGS += $(call cc-option,-Wenum-conversion)
>  
>  KBUILD_CFLAGS += -Wunused
>  
> +#
> +# W=c - Expensive compile-time checks, implied by W=1
> +#
> +ifneq ($(findstring c, $(KBUILD_EXTRA_WARN))$(findstring 1, $(KBUILD_EXTRA_WARN)),)
> +KBUILD_CPPFLAGS += -DKBUILD_EXTRA_WARNc
> +endif
> +
>  #
>  # W=1 - warnings which may be relevant and do not occur too often
>  #
> -- 
> 2.39.5
