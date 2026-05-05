Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012006.outbound.protection.outlook.com [52.101.53.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572D34B8DCC;
	Tue,  5 May 2026 19:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778007723; cv=fail; b=WurtS90pQbpJCqiJBvFfEtpekeW7GTqjYBoN2LdAoi3Ew3rnoIxqAXwHq7x6hYFHac5XpirETZU3/74BWFCuv0a2JzoY+Imv3/vYDOoV5poRkZUgmMi6P+kNOWXbK5e4+zmjWyBZkKsowhZD+AfkH6RC+fNz//ENN3zvXbCCpCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778007723; c=relaxed/simple;
	bh=uWll22HA41ph64EDSj+EwNznAShTxs5mRaoSyjmQENE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TsSIIkN3TazGKrQdq+uFU+eL+QRga5LGSq52sL+Bna6QPbiP/7QDtScd29MWKQUQOVhtun9N+HOZmx1GTQwWzeuV4/U0KOEYT6t4TvVUqPORNe9r+PAVQ5a03NenZFFpUpvpxhKY0wm88o5cDegztocKXNrAW+bkY1GRzmcuRdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EF/84ajB; arc=fail smtp.client-ip=52.101.53.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EF/84ajB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S22NELtibyZMD6iTiLjHjKiBTUi69YS49c/MXQuWjRwklPsEendEFDElEd8XyZ2/HYTYiIb0v6vpqSKkCFU+kdO8xavoJj2LIrBRLhFFVPJVsfJ/7jdTXJ7DkjbKLWT2myGRSORmq6s3J2EsZKx105SATSTT/nDxtpRRZU1sMBSQL4JWyKH6onO27ZvAda5IAWhq2kONlnPlYpRYrNaazlqkekSuAVtp9lcunSITiyhOeLw+97VXkO9TuGjU3KJ7ZJUx/gMFA3Twu1SbbqxincNOPWT01xsWNZU9H6bGTF/DGYoHIxZrbM/QtGLNdFLmyEkQTedi+VU2uWKkYYQDsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=15rY4Kfd69SER9UWle0hCcdxFESePJhStWHki6TZW3I=;
 b=x8C5688AzafkxXz9w3NV/O+Ofd1vyBDkL12RMBAk6k5+UDq/yhAIjuZySi3sN3GB/luImL/Um/KM1fcVwTmhj7ixmVbo1TmynoTmft7ir65i2egBYOcm4rl17jDmFOit5wZyT4IaANfW/dOG4eKZoie4xV1y2EJtOe/IIUKRCXAu6UhjogajVnHLDtlYDsd7Ykx8nKgb17wyk/U3rrWcBXex6T6PBqtZ47+LRaznbuqZn1ReZgRT6DuBZ+GfokQkjyE6aEtDyxLNLRNAeL0tvWRRtu/W0JSvL4qhpWOkHYKsAm4SXGOUV9INqH9Rx1esWiR7FSbSQUPw1Bysco2CVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=15rY4Kfd69SER9UWle0hCcdxFESePJhStWHki6TZW3I=;
 b=EF/84ajBb6jEbtOW2GtPHRfthnK5/hpWTYIu2HNRVBTRVs4rOvclKcHu+1fLssi+Ulzl0TBSLh8nwRfJA2/210jH/dbJ68aWb6zWIK3+FyrSWq/kH3d40js1gGt0+eGyEwPipS3u1ZAXaEaRPsCCZn4loDBawWXEQ6+z5sT67FERYjiKPdFq03loeX/u05pQX/cUAyoev2tNtbFr5yKFELmi6NXchB15eAbouEu6RrVduEMqxs23leoAnM/gZ4pkfLG8Qt6jRMcES5IzUB8pK+eXl5pJEc4YEo2lKvkvxDzU+6uqTNgOI7C48aAbEuTXZQaWtcr9LIKPdlLI9QU0qQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8300.namprd12.prod.outlook.com (2603:10b6:930:7d::16)
 by CY8PR12MB7489.namprd12.prod.outlook.com (2603:10b6:930:90::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 19:01:50 +0000
Received: from CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de]) by CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de%3]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 19:01:50 +0000
Date: Tue, 5 May 2026 15:01:47 -0400
From: Yury Norov <ynorov@nvidia.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
Subject: Re: [PATCH v4] bitops: use common function parameter names
Message-ID: <afo-m8JvDhmzxDOO@yury>
References: <20260503052508.3166614-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260503052508.3166614-1-rdunlap@infradead.org>
X-ClientProxiedBy: BYAPR05CA0103.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::44) To CY8PR12MB8300.namprd12.prod.outlook.com
 (2603:10b6:930:7d::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8300:EE_|CY8PR12MB7489:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b3c946f-5e57-4beb-774b-08deaad8c34e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|10070799003|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	wNf43fNZChrh0qogCEy9CZ41akq6mCTGTe9UXSRIP5yMAuvm8FwErvCc6jp8UkIlUwk7lfI5YqcdA8daqYXcK+3aIflTrrf1tOTsLU44u+Qv0HCL/hhYkVb+2XTj6EXTAQAyVQO5vsHL6g56kb3RtSVFVDUEV3G9OZKMkoT395zyhyQOiDTw0fJyHPMUpX8aT7OOlAvHMpjLlJKjph7YlsYOJnM+gSKlVoi97jmibcRqkgOeLFfuPDFWEpm94LjgFce5J7L/BVo1CsxSdomVKLOr77uJJonjqwzmBeJhzKWX6ErEGmCCtgXfoPJhGOabIvVFHFCQCdw/abGc2DhgocvqNuwx76VWGNMNE/4gDsuj/A6CivqfEgm5/WQ4sHkthmSApDQFr1c7LpEXaHCTCuVPCkgaPNWc746mMmpAMt4++pXaxWn0aKlougQ22zZ7p17URfWH8COq37b05cYymuT/TKMEiZ8kNdVdUyf3ISNKfK7bNC1TO7dKyBnyNLIU9hNbuoVdP/nduhulaDPLZzHjGAP9IVdAC4rSkc/75q8vQuDMW6TaIsGquz+UFD+OlTBJ41e6tBZO41/DPYYrJQAplApy6UI0DybPnDMzKgVnx8Z4vvIJYCET6bv9RUDWNjHXQ8C8EFPnAwqCfg31x7VbTZx/SP2kZvMpwGQAd4SquWzUSL3pddoZn9LrBUE/j4XN6B0RBP8HGvB8vqDJvA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8300.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UOGD9kX8YlntAlCmAzEQtyZPFdQavRmIaFSaNDcY1qCo56g82p+cvKqZUx6e?=
 =?us-ascii?Q?2UQOP44HeKDrJdufDYvk/9Dq0gS4BboNztOdkJpRnu+mznt3lgGRpjaLVE4h?=
 =?us-ascii?Q?xni+yTylmxgnyIRxH8im+69DJ+EWABpgusV8czwsyqkNQOdsOjG0rODUkWQ+?=
 =?us-ascii?Q?QyGAET//I4dLKz5JcgRWSlv4DXaVJE0PCjw9P18LaZJrYWx5Nuen+PigPXbJ?=
 =?us-ascii?Q?a+XrHFqAFGh3F7BREjTVBLGE1SSgdWye56a/lxILeUG/HnmUGtBju1xV2N2W?=
 =?us-ascii?Q?NulstBp0p0THg87Pnz9/w3DmjB+aYQi8OaV9hCplhQw1RUrjTNPRBQoYzakz?=
 =?us-ascii?Q?eSlbncrkyNPGLO5KkQCu3fNkKHTMCBI3VrXDLkYBzBATB1TQKMbW0EOhHom5?=
 =?us-ascii?Q?SoXO4aVTr34Ty3axms0dR2s1ZeV3j3oXY8PVd/BKRtyKVCyOZ7/2QixLMIoh?=
 =?us-ascii?Q?Sw9mRGYtjY2+TBN71ghniGv1p9ZQN9KEltnrSmDSJdjlDZ6lrZXRJZ/9IUhc?=
 =?us-ascii?Q?mUaukE8jLx7f3yBL+JO8zPCqOFP6xvdFAnI/s8L7O+viEKM/kssPPQAxhAOl?=
 =?us-ascii?Q?Wknh8kwUK6A2mlTUmxtp+InXy8HDsEOo6VAfMq0J0l/WygbGSQQNuhPKGanj?=
 =?us-ascii?Q?v9jryZO79Psi7PtcZqw4PUQ4yCBY3xE62yEy0hW+8O4KeoSDGkP94rT9uxbH?=
 =?us-ascii?Q?7mCP9xCwExSU4+uRft0FYS4/+7OAxzXZW4fCjoSt8DowryYspYhSShB0NUS2?=
 =?us-ascii?Q?EKntqwUvt2QlKPJFXE2uqEoFUp5bSq7dnPkRj0/430PKsqFD2YKVnMH3KZf0?=
 =?us-ascii?Q?jwtWBtQg7IGi0uBRqRLN6y0XC0WG+429HrX9omZPRkcIysGYaSni8jC7IQ70?=
 =?us-ascii?Q?eJCEnE0iY1nUS/W5kl/kJNUoS9uAAaCQKdPC+tgIu6X2TanBGPZrYblIsJRK?=
 =?us-ascii?Q?4Whxf7hFf9DsOil2QoyIQXs1jz1CumnOTt/FJDjIAn5e2HpWuLkWJi3N4SJ4?=
 =?us-ascii?Q?+QevxMDuxWfI27ojz2HJWZBrK6E+Fl6GHeQJKz1ps3olOH+j4P9Hl0vkgVWM?=
 =?us-ascii?Q?sGmD1OeeKze66aHOWQ76x1lrJV5tzXdfjKNfF0/DJqbIabs8gfj/vo5Ob+Xw?=
 =?us-ascii?Q?8cCzd7UNEjeUSyGkqYA7pKRhUVTE0y0VBLY7HoG6D7lsgyy5agOqV35EdDZs?=
 =?us-ascii?Q?cWmvwkq8eutrwzPPgSLQ4FnGF30gWmQZ32pBFWoZam324NUGpI8Z9X/zUfCm?=
 =?us-ascii?Q?+o2+oQvyVyEVCmrho4c8gji1k2lY0WZpS3mkCft7K7slwrs7hFN23/tD2du+?=
 =?us-ascii?Q?A/XNnc92kcIfuWf8dM0jsW/slDHPTbkBjiu2I8gxTtHhkcxYhFeRDula5pVM?=
 =?us-ascii?Q?aGj9XiLAxOBLBrNgIknsHGzFZ1WcuNDg34YwAl2Fq++gu3DodjYU4QRZrB6x?=
 =?us-ascii?Q?3/87a1gnM9ceE07lLf+r2WjUP9lFLfj+LQQ9vdsVCnH7NPdWRAxMgJ32JNAS?=
 =?us-ascii?Q?PjDQTYbNiIf0KArenBUwejyNmi7pCKAX0ZARnG3fjQ/y7ojX15pts1W+lWeH?=
 =?us-ascii?Q?Z8e0POBl+W0GPcl9HWlvmp23pkqudCL4TrfFOsY2LY5l4YygMnXJrIa1P1gn?=
 =?us-ascii?Q?jKTVyA8ai3Vyq3KSCpBVVluhPQ6gnBXxnDnBvTuuV+SF3wLTyQSg0Mwk/HEt?=
 =?us-ascii?Q?Xrb9NLuoUB/UCHBfXu34fzQoypJ05eJvFDWjak6TxCcYP5o7gttmX86OZPqJ?=
 =?us-ascii?Q?FVo9B1n3ZdSIoHrTkY5N3X2Cy8j7yWrF0q+TDaMEJDTM8CJlyr2/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b3c946f-5e57-4beb-774b-08deaad8c34e
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8300.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 19:01:50.2535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N1CNkS3e23CP72SO2aGRd9FOGtid6KUZu9QDSDZqO/v6Ou3+6NrBwxXrS7+iIGhWE71vnt6SZlwAXv90ukP52w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7489

On Sat, May 02, 2026 at 10:25:08PM -0700, Randy Dunlap wrote:
> Fix the function prototypes to use the common parameter name 'addr'
> instead of 'p' (common to arch-specific implementations of these
> functions).
> This avoids the kernel-doc warnings:
> 
> Warning: include/asm-generic/bitops/lock.h:19 function parameter 'p'
>  not described in 'arch_test_and_set_bit_lock'
> Warning: include/asm-generic/bitops/lock.h:41 function parameter 'p'
>  not described in 'arch_clear_bit_unlock'
> Warning: include/asm-generic/bitops/lock.h:59 function parameter 'p'
>  not described in 'arch___clear_bit_unlock'
> 
> Fixes: 84c6591103db ("locking/atomics, asm-generic/bitops/lock.h: Rewrite using atomic_fetch_*()")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Added in bitmap-for-next for testing.

Thanks,
Yury

> ---
> v2: rebase & resend
> v3: change the function parameter names instead of the kernel-doc
>     comments (Yury) (Fixes: can be kept or dropped at maintainer discretion.)
> v4: convert function usage of p to addr (thanks, Yury)
> 
> Cc: Yury Norov <yury.norov@gmail.com>
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-arch@vger.kernel.org
> 
> Note: Shouldn't this line in the MAINTAINERS file:
> F:	include/asm-generic/bitops
> instead be
> F:	include/asm-generic/bitops/

scripts/get_maintainers.pl is able to find a proper entry for the
files under the direcory. So, I guess, we're OK.

$ scripts/get_maintainer.pl include/asm-generic/bitops/atomic.h
Yury Norov <yury.norov@gmail.com> (maintainer:BITOPS API)
Rasmus Villemoes <linux@rasmusvillemoes.dk> (reviewer:BITOPS API)
Arnd Bergmann <arnd@arndb.de> (maintainer:GENERIC INCLUDE/ASM HEADER FILES)
linux-arch@vger.kernel.org (open list:GENERIC INCLUDE/ASM HEADER FILES)
linux-kernel@vger.kernel.org (open list)

>  include/asm-generic/bitops/lock.h |   22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> --- linux-next-20260429.orig/include/asm-generic/bitops/lock.h
> +++ linux-next-20260429/include/asm-generic/bitops/lock.h
> @@ -16,16 +16,16 @@
>   * It can be used to implement bit locks.
>   */
>  static __always_inline int
> -arch_test_and_set_bit_lock(unsigned int nr, volatile unsigned long *p)
> +arch_test_and_set_bit_lock(unsigned int nr, volatile unsigned long *addr)
>  {
>  	long old;
>  	unsigned long mask = BIT_MASK(nr);
>  
> -	p += BIT_WORD(nr);
> -	if (READ_ONCE(*p) & mask)
> +	addr += BIT_WORD(nr);
> +	if (READ_ONCE(*addr) & mask)
>  		return 1;
>  
> -	old = raw_atomic_long_fetch_or_acquire(mask, (atomic_long_t *)p);
> +	old = raw_atomic_long_fetch_or_acquire(mask, (atomic_long_t *)addr);
>  	return !!(old & mask);
>  }
>  
> @@ -38,10 +38,10 @@ arch_test_and_set_bit_lock(unsigned int
>   * This operation is atomic and provides release barrier semantics.
>   */
>  static __always_inline void
> -arch_clear_bit_unlock(unsigned int nr, volatile unsigned long *p)
> +arch_clear_bit_unlock(unsigned int nr, volatile unsigned long *addr)
>  {
> -	p += BIT_WORD(nr);
> -	raw_atomic_long_fetch_andnot_release(BIT_MASK(nr), (atomic_long_t *)p);
> +	addr += BIT_WORD(nr);
> +	raw_atomic_long_fetch_andnot_release(BIT_MASK(nr), (atomic_long_t *)addr);
>  }
>  
>  /**
> @@ -56,14 +56,14 @@ arch_clear_bit_unlock(unsigned int nr, v
>   * See for example x86's implementation.
>   */
>  static inline void
> -arch___clear_bit_unlock(unsigned int nr, volatile unsigned long *p)
> +arch___clear_bit_unlock(unsigned int nr, volatile unsigned long *addr)
>  {
>  	unsigned long old;
>  
> -	p += BIT_WORD(nr);
> -	old = READ_ONCE(*p);
> +	addr += BIT_WORD(nr);
> +	old = READ_ONCE(*addr);
>  	old &= ~BIT_MASK(nr);
> -	raw_atomic_long_set_release((atomic_long_t *)p, old);
> +	raw_atomic_long_set_release((atomic_long_t *)addr, old);
>  }
>  
>  #ifndef arch_xor_unlock_is_negative_byte
