Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010032.outbound.protection.outlook.com [52.101.56.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8934537E310;
	Mon,  2 Feb 2026 16:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770051012; cv=fail; b=U2e3P/p/7KWKG2RVtCrz7w34JSeg6giH00gsfP9i9Yf6zG0dABht+E5q3bxRSs+RZGZIGMKnympqJqlGvgOLNZcw/+P+bKUibKN3BpKd61eK5XCpDbNGhHLdr8qXtQP1CgEyobIMu4TyTJ9WTl9bKQspIgp5lnBteVzfRCDISng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770051012; c=relaxed/simple;
	bh=umTImyEekGa5O/T+0FdxryIy6Jkhav8+Y2HWu17I3aM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BVHKZ3Fw6RPxczxX5/vnToVofzKfWdr73sdGLL6x50/mukxVpsi9dI7BIWE7XaKML1ci05uV0xA8O/XK8xmbQUjUYv5Qhsgnww8atfZERj0t0F+qsr8kG2N1Kt2lE/YMYxl1j2oAbyPNqH+o0zLcLh1KUsHCGrzb80/FiCKBFYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DbRWEQY8; arc=fail smtp.client-ip=52.101.56.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DbRWEQY8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lVuSe11FfJzLB207dJZsgDa+2ddn+rf9ulH2rISJgZwu2STwQPn8aEnEf/vzBRlyvxwoMN0EnWbpkkl07r/z6H7jgzwaI1KStLvCyN4u44oLomf6JCHtSWupFgahSdm0BQyE8Y5xnpz5hr2eDSklS7XoKdA/i72kxw9Y9zN6Y5Pjz3xte9M6ET5FofGOThdO3dgmrvMrbe4cmv8/bleMG5B2Jpnfv+HUp2INWZSWYS16m00jTsnqrF41uaeMVf5fg7HblZFlkPV8gsQKZpI95PAQvkLrAinmbMrb933kaKUHanWIYy1dyUQ2LffPTFQWocdGnvRu/zM9eggLrKEVjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=87fcOiEo60x6OsDqkuIUaoouzR7Uzn5ij/47k1L7QjM=;
 b=MA1nb+dyKxQX3gwvWSrwRzy1atTcfMB3pv7c3slaQ/snqt8MYXDIfcLY1k8yVamt+IBFQmdrDrw31tBUJYLLFdq3HXoquapr7Elx7K26tUzMhwgXcUOjtreVvYeZbXZJIJmvWWwpTyOtN82aVtd1u73lpG/VvCJzfsE/A2pDfhzq6cJe8sEzjpXkN1rLLjqmTh6MSw8vkUczpqwgkufk8KctG4ceKYq2/bBSjE3yXrM7PsvpqHxUtemhQ1eSYX5PdOpG/b3nOj6ZYsEbnaI5QgZzCDJ0Pvqq7+/6yYYenOB5Gb7Ff4Z6BHtuGxt/nm+2irORMYYv/RCqZjnGGaCw0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=87fcOiEo60x6OsDqkuIUaoouzR7Uzn5ij/47k1L7QjM=;
 b=DbRWEQY894WFC6yDtx+K0cPTiY+baFUcYq9QQJOukiEci0dihL5qBY636ao7dzKmHYzmIssbqLI+yk57iL3I21EXKMIZw0C3/nT4R2Bh3cBzR+jRdt7XjnE77WhE/dJBsWZffmT32sHDoRECAUkcrZWF2LmOlKKMYmVgg8tc2d3uT5mRaKgE/G7WNZK/K18NW9RB6aPTHLmsCAjOtzAF0TV5NAiHV/nDyMdk2eSK/iwutnWyknPRcsd9T1FiAoDLTdVcjYLD4vUDNcVhPAwMStPxVUs419t0O6f9n8VEMOD2g2e+XXmjRPWtqpboMYcNBS0AUEeELAP4bBjpUTNTlw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB8800.namprd12.prod.outlook.com (2603:10b6:510:26f::12)
 by CH1PPF189669351.namprd12.prod.outlook.com (2603:10b6:61f:fc00::608) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 16:50:06 +0000
Received: from PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d]) by PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d%4]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 16:50:06 +0000
Date: Mon, 2 Feb 2026 11:45:28 -0500
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
Subject: Re: [PATCH next 01/14] overflow: Reduce expansion of __type_max()
Message-ID: <aYDUqBEnevBJLU53@yury>
References: <20260121145731.3623-1-david.laight.linux@gmail.com>
 <20260121145731.3623-2-david.laight.linux@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121145731.3623-2-david.laight.linux@gmail.com>
X-ClientProxiedBy: BL1PR13CA0176.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::31) To PH0PR12MB8800.namprd12.prod.outlook.com
 (2603:10b6:510:26f::12)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB8800:EE_|CH1PPF189669351:EE_
X-MS-Office365-Filtering-Correlation-Id: c9336e8a-93a4-4050-23f8-08de627b1d57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?k4zRVK6xzE5d9BAGmurEwCT/gmxkF5qaUefLkCGoGUJ5pWI11DG1MUv4X/6V?=
 =?us-ascii?Q?fpIxesZoYLNmRgvvRsSC8zToDBLNFpIftySWNO6ZMYyJY5FSh1pYf/JaDbtA?=
 =?us-ascii?Q?AuvFWsTzbdvoWdQs4L57Pv3oHlI438c4chehzZykJCDXApoHDAcaqoTM8mjb?=
 =?us-ascii?Q?+Pn5Yr+Kt6AJMliESLx/D0wChwJ2q1oUj08tm/M/D6hhGzRYO5wBa/UCuyYu?=
 =?us-ascii?Q?GMuUU8y+Sbs3Lc907Hd2awpuJLxpgFzYXapaQT/IWvBBo6YaowMHXVT6OBez?=
 =?us-ascii?Q?JX8lYZOhSX79a3DeCNE0avPdOtt6YThPdwVNrusu6CFpBh8HdhHo671ccKXb?=
 =?us-ascii?Q?bCb9j+2PaLoTSLkGKE8NbleH6qjeZNre9OTgBJmTKoRSbIv7bWOcwlARx5uG?=
 =?us-ascii?Q?YqsjPXedrK3keaOoFyLhlCImGKnB1HTdhnbH8dIKDU/dgo886ljrbDXYBVKG?=
 =?us-ascii?Q?+eM3GNEO4noN9z43aY3/d4SHr8wToEsH/xrOcBodvGsltM5bJuBziQPVOT61?=
 =?us-ascii?Q?vmqwyu7eO1ajEEnaNQxhMVp+TmMsQ9ox6Ovd/w/XT1HdxocSkbFOouQk2zpQ?=
 =?us-ascii?Q?61CO6Ge4Ig95ntY4+lLcn3GfcWlp86Ilpk2Jzto6kfKc3kz+DWwOgUPep7QD?=
 =?us-ascii?Q?FVo0Sr90Ony0ZP1tEOsqk1IKHN4hsTcLqtUpr0jGqukPWGKXYzXsK4Z+ExUT?=
 =?us-ascii?Q?a7ZlfiwtKHBa76fnzlveUX3WHoPLVXoIOZDd3QRysDaqZJVCIeg72zD7zU7G?=
 =?us-ascii?Q?yJ1XaK+JZLPyLVHy1YhYFnJ3C3hw/ILdvWJ/xu2M19Numbil5U1tA0WmHkE8?=
 =?us-ascii?Q?22bWjk0eb/vs8D3ZaeOPvZI1vmLxIup3+4y7mxPSXtWyIi6djIRWlvSrKsxU?=
 =?us-ascii?Q?aUC7NCrCe1AWmA64agruGbYg7p7Y0OQZOvrpgbpkygVfHhpvspE03gmvuYpR?=
 =?us-ascii?Q?pYPLexNuzt2i+HgzWI9PyTcFP/Qntrji3RUHaV4EJ0Fw6wHTZByJ6p1qRTgq?=
 =?us-ascii?Q?MkA2ab3BarCgVX9ZUNv9L3Y6rNXwFFo7suNjsA3xf4XtfWed+et4RpeT1Occ?=
 =?us-ascii?Q?exa/2/0lK+PUTi0wZmp11xNWkK4UdqDsnDOgLH1trAmyo1j3offJMMg4AdeP?=
 =?us-ascii?Q?Zyq8W+AhjLGkSaviAO5ogrojHSxN2TzsiZDtmBME+azjA/WHeBVivL+11OPw?=
 =?us-ascii?Q?eVlxqesJgofd2++llaMbnYn6iVcmZ0iTWY8BAqOLjvOw1w5hrcLU1cdTYnE3?=
 =?us-ascii?Q?DAu7LZZugcHiOksJb5T5PPkR5oITEqR0rvM4lPdrmmpSAWthEP4z7MHwQXgv?=
 =?us-ascii?Q?tPWhpRRZSUgp7wIcmQ4jOQNRpYKeYu+YfF2eUwT1u5yEqfcEvUROVpuH+aIr?=
 =?us-ascii?Q?KsnuwgGc1BMOHpQ3Z4M+bWdYRKGj12QSWwLd6aqmkOhEJedxAOXDmXa1FJWN?=
 =?us-ascii?Q?H3433D+AXBEFAYbSh3foJJ22XWhx3HQoTgJqTunBxvDwLRl/V/AFO0HIA5fN?=
 =?us-ascii?Q?N/T7OvAEd+VcDc6iTSrpMY+zHOHqFIMoHeeu8yI/t94NEYhONYQaQIN15plb?=
 =?us-ascii?Q?OTNJi+DuimerNdKp5e8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB8800.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(10070799003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uLNg/lOlwokNyYtlNSXs8HXVoyeD9uVxkrSjtmJ7+Epbeu47bbEHKZk+mN49?=
 =?us-ascii?Q?ag0eKqf7oAWCTf27SJ6Rj0t60b4Wu4LjgzemraoY5tZXqjUtXP9e6e9r69K8?=
 =?us-ascii?Q?KlUTUxAr8jjNeiyqUNuW4Qsky8pzDH+KixFR8PZgJdCSzLVPCHRLXrFB/q1H?=
 =?us-ascii?Q?BuN4TnNGe4O4FR8kS6OSE2S6n4soim2i7yoE5zvnF6rgTLH+d26RJTMKAqad?=
 =?us-ascii?Q?XO5mQBFWAcFENLgSIDJOyDlhimsz0fFGW2xqTFVWFEy0Z3pxgIDhuGfle/bI?=
 =?us-ascii?Q?OJ86fxPOqSwfsLu/AWQRPa1ulGdoiXckqXv8xDMH3JgrcYMZwVVYfx7lMjuN?=
 =?us-ascii?Q?3X1DzIfB7p+aQ3IWHmufltgcrBa5z6KPC3CS315IA52XwqrNuu2Fuq2PsLi+?=
 =?us-ascii?Q?MvO0674oc+dFzvPyKiByd5LppuPWYZHmlJZLoC4ceLEdieM+rv+0qE5r8KcP?=
 =?us-ascii?Q?CHryCKl1k5D2iZ2KqzFxXp6lxSzd9uW8kyhtYPkSz642fPdLzAPabUE7BgVE?=
 =?us-ascii?Q?xRTdroyE+nfXZ5xQbX9ojGEz3tKUrXEyKkK18edS5X+fKQoJ+z0ScBgScnSW?=
 =?us-ascii?Q?TELIQ6bPmnQIY3AeoSJwOFP5x7ZJtioedR8aLCMYCqaUV6zFRc/hTotmFS5W?=
 =?us-ascii?Q?7qxyKNZJrKjmOZ/sspQHbRv2gQnAqyMix8KCyEzfGeO8t6aUoWQqhKZ79fmS?=
 =?us-ascii?Q?yYSNIic6nhckPq38zuXlt1o5Dj3XHSgym0+Xr2eZGEglLadCiFZRLVBdjBn/?=
 =?us-ascii?Q?dMa50SQRhtlD7ClM2nj8unDpm679Bv8TCmu9a3N4qd3MLDyxrXfovkIBhX/8?=
 =?us-ascii?Q?Nhr2m+k1iY1kTadbrnfd4aMnohh6W0sHtc92kkHW/vYs0YtrgOLwx8T4VD/A?=
 =?us-ascii?Q?h2DI3Edyfa4X+wNyJN9yb+E1EMFTgW6JR56BmITZMlhzdAlNJfurS4Y4AZsd?=
 =?us-ascii?Q?5SP2TO51grxJeAAqP0umcMATTss719eCV0Is7TQrWKkCN2XI5vQKqPJNYDFQ?=
 =?us-ascii?Q?xiFW2KcPqpRBjRbzRyd40AKT0niDznn+nJ72R990M/zE1Yz7OyTJVPQixr3b?=
 =?us-ascii?Q?z9QCV07VFj+686JjY5wGZNom9tVMcxS4Q57UMh53t356QArsf0wwWS/HrP+o?=
 =?us-ascii?Q?gCXOzEY+/d2zBXOVqUiykMrDTd7YpqBaunh3TRkqp7K6pFK7rxSC8uUNu+AX?=
 =?us-ascii?Q?fWeTXh29Jocd8ktDymRseLd/5he5dnf1xTuqWj4FSzGNO5vWI92buFNtvBVu?=
 =?us-ascii?Q?mLut70GF6zSFCA9KqkdAd81XNhas+3fnnRL9l91ayI8wLwaypEE0kuG0o2KW?=
 =?us-ascii?Q?TiEk+jc0ZNoCcOLp8OsBbEYRettoPSy+yXtDgL+PflCDmus7WikVsK1tkFJX?=
 =?us-ascii?Q?8ThzRPjx7zZ7KMDAoaJKwLBFu8n2zRb3XmhOxcO1qhLyFZZrMgr813G6chsr?=
 =?us-ascii?Q?k56hTpHy6g6KNZE6iyNkboyh0+l3ELnSlbt3bfl+LkPQ3Ufy6+3hW7MODPXF?=
 =?us-ascii?Q?GWWsF+5ZALyR4t4yxUbCI5wxXCqK2arlBamkjZkATfTdZXipeZ3TsCbc9gsT?=
 =?us-ascii?Q?77IF6i+DG7YyPWyE24Ili+Eo85xFPFAyWSp14bMfRBA0ibplQ539LoQ537kK?=
 =?us-ascii?Q?x3IvtsQ8KYKIc5gXg92GP3B0epLalSHYZJXzCMN98pA3EGZSd7ATv/mUTQuG?=
 =?us-ascii?Q?IhijBuaD53LFiqtGc1EpCxSatKO1vLVSMB2yTH/FSFxJHsRcWUWJ0vKXVxYe?=
 =?us-ascii?Q?jwjvjtwCGYXjCyj2jdeDKd0F6P+h1GOKDX37lW0/Rlzvr2AxR7lq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9336e8a-93a4-4050-23f8-08de627b1d57
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB8800.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 16:50:05.6362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ssKDKs8W/wbjlNk9hfIl1vDfFctOVUkN3OMHq4jjYaCqeA5cFHHQkTLBt4ty6HfQ7x6t3wgSNJi3MViS2/B+Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF189669351

On Wed, Jan 21, 2026 at 02:57:18PM +0000, david.laight.linux@gmail.com wrote:
> From: David Laight <david.laight.linux@gmail.com>
> 
> Change '(x - 1) + x' to '2 * (x - 1) + 1' to avoid expanding the
> non-trivial __type_half_max() twice.
> 
> Signed-off-by: David Laight <david.laight.linux@gmail.com>

Thanks!

Reviewed-by: Yury Norov <ynorov@nvidia.com>

> ---
>  include/linux/overflow.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/overflow.h b/include/linux/overflow.h
> index 736f633b2d5f..4f014d55ab25 100644
> --- a/include/linux/overflow.h
> +++ b/include/linux/overflow.h
> @@ -31,7 +31,7 @@
>   * credit to Christian Biere.
>   */
>  #define __type_half_max(type) ((type)1 << (8*sizeof(type) - 1 - is_signed_type(type)))
> -#define __type_max(T) ((T)((__type_half_max(T) - 1) + __type_half_max(T)))
> +#define __type_max(T) ((T)(2 * (__type_half_max(T) - 1) + 1))
>  #define type_max(t)	__type_max(typeof(t))
>  #define __type_min(T) ((T)((T)-type_max(T)-(T)1))
>  #define type_min(t)	__type_min(typeof(t))
> -- 
> 2.39.5
