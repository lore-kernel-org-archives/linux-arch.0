Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012040.outbound.protection.outlook.com [52.101.43.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6171314E2F2;
	Sun,  8 Feb 2026 02:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770518226; cv=fail; b=h0Bal3JfOf1EqHcOF2z5MRAvJB73Xt1/73lcGrDaV+AbgltEa8UK/4NFW5WhLb8l77+okoCH6ed8fYAac/JxLHH/6UwaO9bbsia1VpjbVYW5WXk0McNmgsto5t1pfksTE7bSOao/Kl2x08vpYG7I/ylGXWMvhhXRIb4u6yoejRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770518226; c=relaxed/simple;
	bh=IoKSDT9vTcOtGgRMedEsaGoSDooiiEoKAKrtd9yegL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jL7o/PWi5dySnpeRQ3cWskoVLK6kQ0jZvvPD5k+yCf7KxgJnSy+KK3Nd2p7OR8YLlSVpFmUz7MN067wGVa2kIPS2K3Cr2+3y12ezMyUAbvAh8mFix/jozfgkfahAzfaqtt3UVLRg6c3S1HC4OHRm4cPVCz4DRO6zMcOJR3VFxcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=f8NxVf6i; arc=fail smtp.client-ip=52.101.43.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="f8NxVf6i"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xFFlXP7gKbqIYIgxD4KmHlOPp6w1KYSO/h4m8vqBrKBxkfcawCzOPJMw1Q7ZdaAerUcRgPnWTQazLGgVZD6iHXudJ0nFxkFVE2huliO11t3Y+otcbcCwE9hI+aWh8lL+hKgDyQByFuFWUmavPn9Urcf1sU8TR7vhI/MegoLIqnZFAJswu7Ron6J4s96LeUllmAQ33l5uzweZUHaF3YK3qzbZ7gbHWqUqitlTxAG5njixv4FeUnlnYR7jSexdHmP6K4ogIZxXn3skTqvt3xt4Lxb4YQc2jWxipxnbvguQV4NdhG3lRuihOXEK3Q4pyGrCT1CFEoLxlWLEVerNywiJXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5fvceqiVJtxHCLjr4jJZdl97jQlyGDDVwX78pK7rZMg=;
 b=TlCMjG+rQIldOTOmz0kcea0pxwgwqvujaZCPMxeBL70wI3H4W3GB2tLZ5gHiYIrYiebExvh6nPlxgaxw0mGn7ByTKC7KNEpdIidt+25p3w8gzbarP/w7i/YBXB2y8R7Ht6/DA9BB7maS26RX6jC0NdXa1UXQY9NKqc2T4lDaQvsONxLWTOHCWc/GY7q+nS9V8/UDvjUWWogU1KTMczkXv6iS/6EGSRiRrwqIeBkxezbX8znrWzSHOFQ8LPsGvXT7ouVYL3HbLxUlj3O4yJA6FLQ3rwcuhsEe1RM/bLrc28gAcTMB1o5m3S1aPGq9lCR+Ax6OK+MT3S+/Lp8Efkxukw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5fvceqiVJtxHCLjr4jJZdl97jQlyGDDVwX78pK7rZMg=;
 b=f8NxVf6iMh8Lezw1QXvHkoInvWCJIwQcebZmUJoor+BSMp+0R1hHsRUZd1rEci/8QrVJsC2+ZQxavnh04SWxyPy4YU7czFlCrCwE1Ztbdpnh2zQi7cSso1PyNTSbuGZjs8rqv1DGYu2jGi+ye4CsV3MVAcwnsy7mN3vhlLqnz+lTv6Hwpg/QTlaOkoKyvf+MPIeGTtrxjiUH2QJAdheGjZPJVxv1z8xUt4euntVufQ5yK4kFn9sBY8JtIJfwA8qOUpX4RR5u72uCO75CqVp/xLsJnFNTZdCAI+e4OXQ/ZkHmucn8bsMPL1W+WnxxEt9ANY2tXhMpzY6AuLhcy2e/Qw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB8800.namprd12.prod.outlook.com (2603:10b6:510:26f::12)
 by DS7PR12MB6095.namprd12.prod.outlook.com (2603:10b6:8:9c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Sun, 8 Feb
 2026 02:36:59 +0000
Received: from PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d]) by PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d%4]) with mapi id 15.20.9587.013; Sun, 8 Feb 2026
 02:36:59 +0000
Date: Sat, 7 Feb 2026 21:36:57 -0500
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
Subject: Re: [PATCH next 08/14] bits: simplify GENMASK_TYPE()
Message-ID: <aYf2yUazqVJBeWZb@yury>
References: <20260121145731.3623-1-david.laight.linux@gmail.com>
 <20260121145731.3623-9-david.laight.linux@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121145731.3623-9-david.laight.linux@gmail.com>
X-ClientProxiedBy: BN9PR03CA0043.namprd03.prod.outlook.com
 (2603:10b6:408:fb::18) To PH0PR12MB8800.namprd12.prod.outlook.com
 (2603:10b6:510:26f::12)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB8800:EE_|DS7PR12MB6095:EE_
X-MS-Office365-Filtering-Correlation-Id: 962635ed-f857-48f7-66d8-08de66baef0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z8dNOdEsVUh7T3dfGz6KlI41yPKbI2VQtke4xA0meU6vZuU8/S+LJZiXNpK5?=
 =?us-ascii?Q?IYFLwZyvCuYFhur0AgnseXfX7/ikfbqyvelunBYZYFyg0z1lB8m9JLvpf4GM?=
 =?us-ascii?Q?G/FVaypapSvMsIQK81NWnM3iGJ44gbLwnugAsuTgM1JtOYfMnFytR7ORBf+3?=
 =?us-ascii?Q?by1NaNPSKkG1XJlfJsNaeoj81Tb+ZMg98osopncaQ5crrhdRvS2rapG/UqkB?=
 =?us-ascii?Q?mppkInAEt7a1Z//rCqFsfPZGqwHi0wIJIthEgTdjw71Id9VcF3ME9nmklAm7?=
 =?us-ascii?Q?gU7hwXVCRLmKzlCJGqSQVFPHjIsAtRBKqJUO75UAOaATRles248xAqM327H+?=
 =?us-ascii?Q?93BaOYtSxI5U00kTAH51FWJKRiOEeF0ublInJHRYVd1kro32y3BLkOmEg86S?=
 =?us-ascii?Q?+oiOzLySMKIQnROh14Wkpd5/oRaXzsCBx0y72MMGEiRLVxPaBps6nu8CtZ/0?=
 =?us-ascii?Q?ediflB//0UJUerE5nuspaVyDYLEr4UVd9SGJNqa35NSz/ysMRxHEQLqpNnQ0?=
 =?us-ascii?Q?6sQXnCq5zMViSEGZtmxJNl+7K/dkEGxD1dnRH/2HgOYAqodHe2OidFEGD56+?=
 =?us-ascii?Q?tIBzUKjx2lcmYBUorEt5wIxTETwT+BCp6mTUyN/wi1sd2lcNmJ7kjVp/HVzQ?=
 =?us-ascii?Q?4dkLrWbh5dwUCv/IO8yGk729v1Feen+w3mxMqUzi3A1rNmCe3HO602KMATBm?=
 =?us-ascii?Q?jp/AMq3rIM78jmfNPOmTDy2bgFoltBg4nCt5N1eiaRQ5wMT+InI84wgCWb2G?=
 =?us-ascii?Q?GkbUp6U4xfhMqzgC0wfGa0HAdVcFs2GWMbZSQNnWBQgAs16HvzasZ8DcpODK?=
 =?us-ascii?Q?JGRkC9JP5ZAuPv2idQIqo2/fnm0/1UOzkEpTEa0FE/I6R4Cw7Uh0ZGpQ5YOz?=
 =?us-ascii?Q?x8CSyOAk2uTpW5b3C9z45LOC/yhT3LeetCsS/mEyiYUOBCqJg7rPD6LNQlCy?=
 =?us-ascii?Q?AzE9O2GZQZMgDLOzhyKj7dqEz8ZzIzu7l9TlsavBZi7XHU4kkQiHyLF9xT6y?=
 =?us-ascii?Q?tfGX7hy2BBvjdmUNcp1XFad3XYNQFmr/34578HCQls6lWp58Jnuh0vcTAzK+?=
 =?us-ascii?Q?nh/F9W31Hj/j0IkWmjZ6QOjb7/LK+lrxLhmGkPqN8qsvProkGvEjG5RpVU18?=
 =?us-ascii?Q?K/2eIy/A4kULoM3MUAuNz/yT/nK87V+RLEcsBysgAHx/wXAqt1EQr6n+lqEN?=
 =?us-ascii?Q?LEL/sAUEuAD8G++u3j3koohaPbLmvDmDRENQ/4Q9V6qkpSTJl/5Mngoc1sHY?=
 =?us-ascii?Q?LDUxy4Kxi/+MXZSOwMFSZfYql+k6PjiGDNUVUP7dIgBhQTIOU43E+yejZk+v?=
 =?us-ascii?Q?sTqcF24+i5qD6YaUj+Lhj8ZL5MGWMXbknP4oVcbMFB3XniRPEZdeQqAceURw?=
 =?us-ascii?Q?hf309QLLQPf8Skp75gA7hrlwIBhadb1lz9VY7mRvjcCaK6sYK860VpTccx0A?=
 =?us-ascii?Q?2nCVKS4Rsx29GcabgyEncTpYm+muKQD4dfxQRl+BLaLUc6SGblr6tDiPbiLv?=
 =?us-ascii?Q?LS4FJ6E3dzYbrWPEuygpcU/qd4IZVoBIQ/qJlm/dThjunSji05vxeCrWlMzt?=
 =?us-ascii?Q?8/LX4U9irMx5hhrdgnk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB8800.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TvHF/REHwp7Ghl2Qo8O5MBP+tQ7JRv9nRMwCPYKCGr7PgSeZEx+w31XJ2ALe?=
 =?us-ascii?Q?ExwiINdMRAUDdtmEOUx2CQJ+8epjdb8Aj6yOjUeuaMgtF7ZqHOr+7dLTcWiD?=
 =?us-ascii?Q?/7/JvSgQkVtwoQNWcTDu1MeNvzaHRC+2UG+SvpmqUPGZhXPrT6jVM0YCzl7y?=
 =?us-ascii?Q?3Yya6K86Jx5x0xPDcVrsFwWYdZ+zmkld4fByPxHLoyteSzq4fZBxqPECbxGx?=
 =?us-ascii?Q?NH4JT6pmK/LzN0xBJBH8L9/VEqs6oSZsqWi2m6RIvrsDbL8dvSjW1muNm1fH?=
 =?us-ascii?Q?zeucLxAPFtMaJ9v1UNFdrzVFhsfYAdHiZJ6ejZePvI/KWXSu/uFxzV3lvDMN?=
 =?us-ascii?Q?Qq2r1WeTzFEYfAlbfCEvU4PL+YdNMm1vDL5lkOairtfp46WqZjH6ZL9Lzj5q?=
 =?us-ascii?Q?TjlM2cL7zhHoJcHafKa4o7dwd0eQ0mS+UnSBJ2fFaJwN0cZf5zHjhT1Ccp5q?=
 =?us-ascii?Q?Wy87A/tOeOdXt2hCwITplAU4CMHA6hXhuxlN4UGo/kJet8oJEj8gBEEmTxyR?=
 =?us-ascii?Q?R2TW/v7cgk7nQcOyM8UC2Plcc0dt2azaDQlowsOR+rPSUkw/loR/rOBZhh+p?=
 =?us-ascii?Q?qGN8S7iR5z0DFiaFdKKGL49o7grmSd7cGpLpPLMzVs2XT+2uwsGt97bk8yiC?=
 =?us-ascii?Q?1UebJLQcYpvtzfMy2ULDkcCrS5J/9tKsYIuOATKU/bWyWAcsCc0inn75eWH2?=
 =?us-ascii?Q?N111EFqz9FhK8nVWMJtO9y6MmZB9xjp3655Kvp7rEfF/fL3Rwm8aV9xBbCrL?=
 =?us-ascii?Q?nG+fANxJ+lJP678Ind23Q/DncOdJW5xs/4c64lhoBNw64tnccnGqXJWEL01h?=
 =?us-ascii?Q?te5WN00u7gy5d03216ZkMQrw2MHOJWOG0h4r6ah8stSp5eyhCUhwaixVeDGq?=
 =?us-ascii?Q?CX8iRNt6Ex+ynVWT5Fzs3sz8RCclWh8ZH4ajutTTw648YqBg+vewtTGrbssi?=
 =?us-ascii?Q?qKhqE7bijEmfGYKGCWbQPtDpZFBhKcJ//s0uehLz/M9OxVtvSABG22RhIFPl?=
 =?us-ascii?Q?KGUCOTmhic7hgqz6wL7f/QUPYZB9/eVZmZ2qoFoNqxJSE4M6YDtEXGJM05ne?=
 =?us-ascii?Q?8qQlglCtoxP/hSMG/lJs8ziTa9tiZDLagaevRN+BwoxvRroftLhuDcQJuE4Y?=
 =?us-ascii?Q?ITxlNLCPS76sHK10/CEIZyvbd9Oyfzs2ZOk0MXE5/1DYK76hXqbmdr1SGuUs?=
 =?us-ascii?Q?Wa5xLLbevYkgXpZ/uBrhW6THm1e6+3irqCYDFJXJh+S3IO/4Hy1JBi2snb+9?=
 =?us-ascii?Q?gBIDxH7JJ7zjwaqUvPTk4hFFHb0Xf9MJtKF5BChV27upFrIS46HS9wLf/Zlv?=
 =?us-ascii?Q?p0uPm+nOIH6o7biYMqvQkN111mkMlJRWvQE+ZBf9cCyQQjM/WfFOebfbIP4v?=
 =?us-ascii?Q?svqQaFLQ1Gs9xCHQ+KrowxcCHuQsJ6kqkYD+jKzfhD9TfymCnifZopMu/f7T?=
 =?us-ascii?Q?Vji4/WMrcAjSLNGC3656BmmbtDrGQIbuMdoc5C2ORsruRnXK0gC9O7W7miev?=
 =?us-ascii?Q?mn8jCqDiNAhDzn5ZjV01Arx6c2nuKhhQXKbNZ8INx4yhZkxWpiJB+zNnCNQY?=
 =?us-ascii?Q?PZCsBIWhl0Xp+v01GWf+OH/BacirDZShDvDmFlq8Y7eIm30PQE25ya0nP5ZM?=
 =?us-ascii?Q?WClmWFcmVUdV4iiqrtmqfxNYVvWMRL5hHjnLN8KEBplaLN5bJrsLOYR0uzKY?=
 =?us-ascii?Q?HCCfxRPHKjHHiZWgQNIKOkg/PhKP9simc0YZrdDaP8+GHxd4XOBOMhIk/Tgh?=
 =?us-ascii?Q?PKWUTjttgg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 962635ed-f857-48f7-66d8-08de66baef0e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB8800.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2026 02:36:59.5156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TxmCCV2CYXfdISEyP9EX+S8AbMQDB3u9M7Yhk0gYncIMYupmvTx7VzCkJLgW/JZd6TN5zupXJhLU5Ftt+fpLeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6095

On Wed, Jan 21, 2026 at 02:57:25PM +0000, david.laight.linux@gmail.com wrote:
> From: David Laight <david.laight.linux@gmail.com>
> 
> Since the type is always unsigned (T)-1 is always the correct value
> so there is no need to use type_max().
> 
> Signed-off-by: David Laight <david.laight.linux@gmail.com>

Here you implicitly add a new restriction that all types passed in
GENMASK_TYPE() must be unsigned. Can you enforce it with
is_signed_type(), or at lease with a corresponding comment?

> ---
>  include/linux/bits.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/include/linux/bits.h b/include/linux/bits.h
> index a40cc861b3a7..697318f2a47d 100644
> --- a/include/linux/bits.h
> +++ b/include/linux/bits.h
> @@ -45,8 +45,7 @@
>   */
>  #define GENMASK_TYPE(t, h, l)					\
>  	((t)(GENMASK_INPUT_CHECK(h, l) +			\
> -	     (type_max(t) << (l) &				\
> -	      type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
> +	     ((t)-1 << (l) & (t)-1 >> (BITS_PER_TYPE(t) - 1 - (h)))))
>  
>  #define GENMASK(h, l)		GENMASK_TYPE(unsigned long, h, l)
>  #define GENMASK_ULL(h, l)	GENMASK_TYPE(unsigned long long, h, l)
> -- 
> 2.39.5
