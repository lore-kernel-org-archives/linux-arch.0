Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011028.outbound.protection.outlook.com [52.101.62.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3F01A2545;
	Sun,  8 Feb 2026 04:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770525548; cv=fail; b=AWEFiG9P1utQibb2i58F2ejq8M72aANacur/M/uwxHGNE9WLmg1RH5NTSO/2phVHEjbbYDKxKP7KIGWLj5zd09CbjwgRgZhtksHB2sjG3Ukl7AGsI8HbkAm0ExJ1B5H20fTFhT3LH4/yx8Cyzj/hQSfAjQZdomrou17d0GR54ZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770525548; c=relaxed/simple;
	bh=OXuACOEdGSbftlpxcchi3Rvtze/4bpTITH9MEuXiaSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=W21LQUuVD2dSIW82+EnBH5tPIz2ugQApyGY/5bxW2l4HrYhZ9wv7hsKnYUwQz6pMYC+sCAu0Y6JShPAttCybOG67Xfr9bzH+44IeT3BuctbBj6ZmpHa5MMCbpxjMzMj55g4emTONwF+DG/wBxZooCWzb8S5P//PJ6l6tef1xF6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Z2C7IBza; arc=fail smtp.client-ip=52.101.62.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z2C7IBza"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cNCBRPVtrB8H559DkqlabQFdHu/qxEIEPBiJA7Smo/3ShMTOi/yua/0ywCbycgZTsx1wnX11RLFTdnBeWcQwSvkjF7mVplpPCpmUrQkJnXhIt1D9fs+Mxk+BYemoEQMRteUOAn9ZBV/7tBLnJg72mE5Jg1byeTS5RsYNOz+T4ncbsZzPeXd2hiAF+umkzYI72R4geqZk6Nowbgc6Ndoc7or8p6kertApS0dYrjWu3gyinwhRf0RRts3tZfDm2fThRLOTVNdRe6NfRxWTlQItYz9rlAYwc++vepJHGgO1K9sJsctxrFbnbiq515izPT9+srCAqnGYmCyx9f3MqVKIPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DbytyxN34vIv4rQpE98Uy1HMmkWT109l3uQdaSZ6BiA=;
 b=W2IOQr4TEWVImezRqPS+4W3LYJwPGZVToSEi2KJ7Nk8Js59mLHfHNpxRTwNPB7F76PpCLLVbGVjc0KgJedgjIJIEkfdNviDlXhtBx4H651CkLBKRfBf2LPQJK+ySM7lXdg1DYB4LzDoZOnO5pJ+vROHencPhBEKJVohMEuOl/ICvhW5pmg/JvG7wW9Tf5/ZjGtX4y8Mokka1eAiw2pPZH7uCuwwLlGmmChyFj6PMAn7CHduLJ8twcPoWwmB3sM5V8ATh+Y/yDIllpZQmKc8ic+4nKbvjeN0b5bX/OzSjC9diB9MFeE3Nq+8hVX+VH5lDN4eyNIUzB8AeGrlMQqsq7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DbytyxN34vIv4rQpE98Uy1HMmkWT109l3uQdaSZ6BiA=;
 b=Z2C7IBzawIteR4uKYzmh8PTvgpFsmu8kxAMgwePv+VpeZ6qZZNuub73hDNF0wwG9CGNViIbd9FXRj2AQ7n6hhsrH8U95fdQm+SXPHmhGArl97/MMe7QvO6KN076Cd0BMV0RHzJWtgbqiPDHvlEO17Yd3Iung3QfJLPSRftoKFIyKHx8K1asPN6MWdwgToSZ6k8hpvWXCi0EAqrC6yg6ALA3MpvhQt/PwgguHGgl4KxlxUekqGOBnSMvQd8zvfD50URogM+QB1i+UX/JyJKNjsrvg+RKUClULyQIrQs6OZVE21Y6yNq7Z0msWNf9wNAobF37R0tlak4Mq0waeGQ+NVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB8800.namprd12.prod.outlook.com (2603:10b6:510:26f::12)
 by PH0PR12MB8800.namprd12.prod.outlook.com (2603:10b6:510:26f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.16; Sun, 8 Feb
 2026 04:37:50 +0000
Received: from PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d]) by PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d%4]) with mapi id 15.20.9587.013; Sun, 8 Feb 2026
 04:37:50 +0000
Date: Sat, 7 Feb 2026 23:37:49 -0500
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
Subject: Re: [PATCH next 13/14] test_bits: Change all the tests to be
 compile-time tests
Message-ID: <aYgTHfhxDws-D6yl@yury>
References: <20260121145731.3623-1-david.laight.linux@gmail.com>
 <20260121145731.3623-14-david.laight.linux@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121145731.3623-14-david.laight.linux@gmail.com>
X-ClientProxiedBy: BN0PR10CA0013.namprd10.prod.outlook.com
 (2603:10b6:408:143::17) To PH0PR12MB8800.namprd12.prod.outlook.com
 (2603:10b6:510:26f::12)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB8800:EE_
X-MS-Office365-Filtering-Correlation-Id: e37955b4-0aeb-4061-3fc7-08de66cbd120
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bYZl7GquNZ8Cx8+5TZszGVb73pVdTI0VSLtfown2eUjWU1tZ0SWpKE2JURE1?=
 =?us-ascii?Q?zTxul1YyLm0+J4GBrRXG97yggqQ/Z34DXD2LN3fKy4dbJEQOzYbYk9sMUucE?=
 =?us-ascii?Q?c+sa8KfvMJF2B548teVusvN3jo42elGUQ18uUUR4dm8PE8A7Hg/sy6viYEBd?=
 =?us-ascii?Q?TGdDeuWQPI532F9zGkzyD9UhNNIeto7kaOYEHitQ6crRyyU0wOGH4jBml/z/?=
 =?us-ascii?Q?WQgGykxM6sDfKKUJgfYRK+xp3ZL+4ws+LATy41w9O+AZA15WTgTVi47GijNx?=
 =?us-ascii?Q?j9oPiI4hL6bnxuZSujqsb68lzw0ULpBfqegH2X+fv6Oj+SlzOmMmjoPLgDri?=
 =?us-ascii?Q?1d7cwRUFQM6i56FmN0f7W9/SMNXFx5Z5YbVHt2AkwQf1Vs941mynxOT8KwHk?=
 =?us-ascii?Q?fmU54IDGfNBeqf+3Yme0uIF+ipu6M/8GQ+GSiAisYuevgmi6s5oA+g5SRE1+?=
 =?us-ascii?Q?ebAVuqNG29is5to7xx4Chhrhj0UPjWuIqgi9qyu2DSEEKWFoIUN100/g9Om8?=
 =?us-ascii?Q?xissWL6AeBK6WckZTUpcVdbCwuRcg1Ph6NtmqpUOW4yCeY09EReXg4CYroTg?=
 =?us-ascii?Q?MMeclTCHgBdPUXKBv/amb5/7vGyf7K8qsqDvSyt/I4LCmTdkBhGHhGH3501Y?=
 =?us-ascii?Q?CyBHUM1Ql9rifdOb8SWk5QLTvw5HXzVaKubN/PZhsjadMBJAKFcIINKh2YGh?=
 =?us-ascii?Q?HqKJdUzv1TibatekP6aReLDUiHQihU/xss94oclHjec/Hl9JQ5PKxXnOsbh8?=
 =?us-ascii?Q?/jHVhvE/WXFEcX9UPS8IsXB2xLHPameuHZl/xjyxS4QUGqmWmtWD182z4/v+?=
 =?us-ascii?Q?VUNZuXLeSnmgbWRdAO4Y5NXPEGJQmCVSg4BRiH7CnOI1MSiyp7kHpih1fDq2?=
 =?us-ascii?Q?2PQuS9bM/LS91p7oLh4KyRoSnS8KLZS+pidgS9JZ9J45WTGhwYwOK2K6MhBF?=
 =?us-ascii?Q?gUO/T3OKWiszUQXBM2v2TEiVVo4bl/fUgNl70QLJxdiT9/5Lo2rFTr0TYBQ6?=
 =?us-ascii?Q?A5e8kmWQ0lc2grImim5bpvUvEzPs89SyLGyi6BRlbb1whNhRVu0sZAqclXNk?=
 =?us-ascii?Q?wspQoc5zJ/he6cSwAlu/hmlp5pLL214hpA8J4FE54/yd8zsLU5gHS53+G53e?=
 =?us-ascii?Q?fsE32a2Val6j7odcAZSEJIJVP1W948YM/lmKGUdfZ0uB3d057H9+qTaE/Jgw?=
 =?us-ascii?Q?J1e17VzAT0Qu/+1FxRvOKhJb+9b+C+qmnJ92PJ8NNUvqRi10DnuH4Q78e4Ec?=
 =?us-ascii?Q?1NEuBDObO/z2q2X3K8KrL1TIZp0I+1eGC8jXUuC5Lv8xF8swekh7KwTV8ZBd?=
 =?us-ascii?Q?lgG3B3Wob9lVSaN7qji/LFaMVsokf9fH2ykDWZdL5PsyDI6DKlkpTOREf/XK?=
 =?us-ascii?Q?dnDwhpEkn9EEI1BDHsq0Go3cIO1v3m4fWVhYfCDG1Hcs9SHjAUEEaNInhG+h?=
 =?us-ascii?Q?TMYNHCwwStrT50BUvX32OZEln3dXGZNnktLK01pLCkftptOOF6BEGB8yp8Yb?=
 =?us-ascii?Q?l4dnSr9IGtpCC2Urne+q6redpySKWbIa/EZH/SYwlfHPgUUZKu6SFBvunIAB?=
 =?us-ascii?Q?4FqEf1I9m4kjwyVov4Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB8800.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pVotO3fpI9xGhsBgV85hgPRcCUvqqrWeTDhAl9aUw1LPaaLgGcMqFdF14PUG?=
 =?us-ascii?Q?A1YeGYxI8CmR+/jfft8H03rJ/UPoGs0s3617EcLXm83nwsuVaV8PTc1qiV+e?=
 =?us-ascii?Q?p1P+D+VnhwxGMYzJBXClkACs0IOekfvfEmK9i7Qf8d/S/2yiInynTTWJdUZj?=
 =?us-ascii?Q?yi2SKvlhqDJqJy5+ubiNkCA3bqydjNqJylK5hE/82BD4Gc9zXAtpmIKkf5YF?=
 =?us-ascii?Q?wEoyXsNNY8xM5hMGb3SWqWUfz0UmCeXR+zP+z6imVUJP8AXsuxhu7kfHstXx?=
 =?us-ascii?Q?LJKbfmlUwLlNZdETEX6gEIfU9L4l+3Rs8KSGpU7DLxK0wukjX/E5bPx3dT4E?=
 =?us-ascii?Q?awk/vYagEGuD2Tn/4+7qwtn/ZZsqFOcpdNAV9567TX05F19w3c3P9+te6zYh?=
 =?us-ascii?Q?JQeMMy4eZsW7tS2oHVMb2Znu+fcl9Ucu4y7sF/NhVb9jWjEep9dBoVFA0/c/?=
 =?us-ascii?Q?HbSD1Pj4Ez9AZL9vE8NlCW7DVz5WnhGjDtGHtimDMAnt1Fu6Bi2UMbqog9s5?=
 =?us-ascii?Q?EWplV+U6laqex1MGAqOIp2XBNZcZXKf6qsiA09qG1u1rfycHtCdq7IDJfS77?=
 =?us-ascii?Q?gl+BVKXC8kaMl4HMIyb5TlYnAQlRW1LT8Fyb3v3T4D5CG/mZ9K6Fxwt21RWz?=
 =?us-ascii?Q?LJX6kN7RqHNVhmH2JtG8Rxy9lPCP3bpAsq1IDabnzp/jB3dCB8/tQ55oH4U0?=
 =?us-ascii?Q?nBDMCzStGgVjE8lRQnQm7F+4ZTHYJqO8o6qYzY1FR08lw3R4VzM+btAF0wL+?=
 =?us-ascii?Q?RDhL+G6JF+kqbWx5WD5+4vTpD39CStLZdajmUWCD34Kao7GMfaTP5IheDVy5?=
 =?us-ascii?Q?VHzTiBQej1PrBSFyWAdle/yCd4XMoZyr8ooVMkTGG9QjNBGzYpQdfi2eI7ks?=
 =?us-ascii?Q?ihAJa8Yw9fPhnoarKSiTI4rb4GPnlrpG12Y8jx0GXVcZeZafKJZAj302dq4B?=
 =?us-ascii?Q?oesKO8jL/Y8kzsGVuVSv1M1G1RUR6cVX2HRpxRuLaBcGncnCvNCGTMjuienv?=
 =?us-ascii?Q?iF2IW2ainObkTutJDXZDlJz50bQmd2OHmSIn9+ho5PWU7J3MfWAU3suTKebw?=
 =?us-ascii?Q?9vuz1hGC+wLHi3G7UJyP7uBF7BoGsA0cxtuemBC1LVj9dREwmedlUgAp4yFI?=
 =?us-ascii?Q?R8R/Gz4ZxC5F0bj+99NpsHcxukJbcfLkRfqrVpACvH91sJ4AH3/zilzCNzLh?=
 =?us-ascii?Q?6AZ4i1eTYwLsO0Xa9BsWCHo33fQV2FhfwnANpdbkvjNPyN+Gqx3BK5eYMKfL?=
 =?us-ascii?Q?7/3LyFl0e+rXndEe/SdYjtAc4PA5qLGwsyN4CzwcuXJYGlHbBbsWUqJfecHV?=
 =?us-ascii?Q?eX5AM1JM57Z31Cb4F2/y/nKUG6L+Q2XLdguhLJ4qUesajOQr+rxRuvY0fzSQ?=
 =?us-ascii?Q?YTbxBk+jTXyjm+/FwVMZxrkwR/56br3+Khasf0lEhzs46Lq+oMddDZkI1omC?=
 =?us-ascii?Q?JIIn6ERL3RffcFUqL0G4Fii3kjrDmUM7GqVezUVh6wFdp8CgjBzqnbc5eyJK?=
 =?us-ascii?Q?xZthPWU2w/qT4IisDhjhm7cta0VYH1+VctRSzGqk9i4aJ8Gpq+nxNoKfEGpi?=
 =?us-ascii?Q?PvSTUaSUTo00RQHgsTzyip2FawTeULd27oHqLomkt6IrrmIbVxznU/RAwA+R?=
 =?us-ascii?Q?ysG0tDyde6sKV3U5AF6Ydc7sB+ZmRGekW+R1tg8it2UtugOZAesJ+w736mB5?=
 =?us-ascii?Q?28fmmoA3pTVLNP0CdRLGMBwXqB3SzEaKYNdbgN//YiUz+HaBHGkO58P9q0We?=
 =?us-ascii?Q?AQjFxolXPw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e37955b4-0aeb-4061-3fc7-08de66cbd120
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB8800.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2026 04:37:50.8113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iTp/8p79yLS/Too3Fj+DNi1vHr7YkHn96uTocK7ol0l47uxP5ksWi3NS+9PA5N/z62Uf+4/N1py3B27TWheOiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8800

On Wed, Jan 21, 2026 at 02:57:30PM +0000, david.laight.linux@gmail.com wrote:
> From: David Laight <david.laight.linux@gmail.com>
> 
> Since all the GENMASK() values are compile-time constants they can
> be tested with BUILD_BUG_ON() rather than KUNIT_EXPECT_EQ().
> 
> Signed-off-by: David Laight <david.laight.linux@gmail.com>

I thought, KUNIT invented this EXPECT_EQ macro for a nice printing
and some accounting. If you want to make sure that __GENMASK() is a
compile-time expression, it's OK. But I'd rather keep the existing
KUNIT_EXPECT_EQ() and add

        BUILD_BUG_ON(!__builtin_constant_p(GENMASK()))

next to that. This is actually how test_bitmap_const_eval() works.

Thanks,
Yury

> ---
>  lib/tests/test_bits.c | 90 +++++++++++++++++++++----------------------
>  1 file changed, 45 insertions(+), 45 deletions(-)
> 
> diff --git a/lib/tests/test_bits.c b/lib/tests/test_bits.c
> index 36eb4661e78b..4d3a895f490c 100644
> --- a/lib/tests/test_bits.c
> +++ b/lib/tests/test_bits.c
> @@ -32,30 +32,30 @@ static_assert(assert_type(u64, GENMASK_U64(63, 0)) == U64_MAX);
>  
>  static void __genmask_test(struct kunit *test)
>  {
> -	KUNIT_EXPECT_EQ(test, 1ul, __GENMASK(0, 0));
> -	KUNIT_EXPECT_EQ(test, 3ul, __GENMASK(1, 0));
> -	KUNIT_EXPECT_EQ(test, 6ul, __GENMASK(2, 1));
> -	KUNIT_EXPECT_EQ(test, 0xFFFFFFFFul, __GENMASK(31, 0));
> +	BUILD_BUG_ON(__GENMASK(0, 0) != 1ul);
> +	BUILD_BUG_ON(__GENMASK(1, 0) != 3ul);
> +	BUILD_BUG_ON(__GENMASK(2, 1) != 6ul);
> +	BUILD_BUG_ON(__GENMASK(31, 0) != 0xFFFFFFFFul);
>  }
>  
>  static void __genmask_ull_test(struct kunit *test)
>  {
> -	KUNIT_EXPECT_EQ(test, 1ull, __GENMASK_ULL(0, 0));
> -	KUNIT_EXPECT_EQ(test, 3ull, __GENMASK_ULL(1, 0));
> -	KUNIT_EXPECT_EQ(test, 0x000000ffffe00000ull, __GENMASK_ULL(39, 21));
> -	KUNIT_EXPECT_EQ(test, 0xffffffffffffffffull, __GENMASK_ULL(63, 0));
> +	BUILD_BUG_ON(__GENMASK_ULL(0, 0) != 1ull);
> +	BUILD_BUG_ON(__GENMASK_ULL(1, 0) != 3ull);
> +	BUILD_BUG_ON(__GENMASK_ULL(39, 21) != 0x000000ffffe00000ull);
> +	BUILD_BUG_ON(__GENMASK_ULL(63, 0) != 0xffffffffffffffffull);
>  }
>  
>  static void genmask_test(struct kunit *test)
>  {
> -	KUNIT_EXPECT_EQ(test, 1ul, GENMASK(0, 0));
> -	KUNIT_EXPECT_EQ(test, 3ul, GENMASK(1, 0));
> -	KUNIT_EXPECT_EQ(test, 6ul, GENMASK(2, 1));
> -	KUNIT_EXPECT_EQ(test, 0xFFFFFFFFul, GENMASK(31, 0));
> +	BUILD_BUG_ON(GENMASK(0, 0) != 1ul);
> +	BUILD_BUG_ON(GENMASK(1, 0) != 3ul);
> +	BUILD_BUG_ON(GENMASK(2, 1) != 6ul);
> +	BUILD_BUG_ON(GENMASK(31, 0) != 0xFFFFFFFFul);
>  
> -	KUNIT_EXPECT_EQ(test, 1u, GENMASK_U8(0, 0));
> -	KUNIT_EXPECT_EQ(test, 3u, GENMASK_U16(1, 0));
> -	KUNIT_EXPECT_EQ(test, 0x10000, GENMASK_U32(16, 16));
> +	BUILD_BUG_ON(GENMASK_U8(0, 0) != 1u);
> +	BUILD_BUG_ON(GENMASK_U16(1, 0) != 3u);
> +	BUILD_BUG_ON(GENMASK_U32(16, 16) != 0x10000);
>  
>  #ifdef TEST_GENMASK_FAILURES
>  	/* these should fail compilation */
> @@ -75,10 +75,10 @@ static void genmask_test(struct kunit *test)
>  
>  static void genmask_ull_test(struct kunit *test)
>  {
> -	KUNIT_EXPECT_EQ(test, 1ull, GENMASK_ULL(0, 0));
> -	KUNIT_EXPECT_EQ(test, 3ull, GENMASK_ULL(1, 0));
> -	KUNIT_EXPECT_EQ(test, 0x000000ffffe00000ull, GENMASK_ULL(39, 21));
> -	KUNIT_EXPECT_EQ(test, 0xffffffffffffffffull, GENMASK_ULL(63, 0));
> +	BUILD_BUG_ON(GENMASK_ULL(0, 0) != 1ull);
> +	BUILD_BUG_ON(GENMASK_ULL(1, 0) != 3ull);
> +	BUILD_BUG_ON(GENMASK_ULL(39, 21) != 0x000000ffffe00000ull);
> +	BUILD_BUG_ON(GENMASK_ULL(63, 0) != 0xffffffffffffffffull);
>  
>  #ifdef TEST_GENMASK_FAILURES
>  	/* these should fail compilation */
> @@ -92,23 +92,23 @@ static void genmask_u128_test(struct kunit *test)
>  {
>  #ifdef CONFIG_ARCH_SUPPORTS_INT128
>  	/* Below 64 bit masks */
> -	KUNIT_EXPECT_EQ(test, 0x0000000000000001ull, GENMASK_U128(0, 0));
> -	KUNIT_EXPECT_EQ(test, 0x0000000000000003ull, GENMASK_U128(1, 0));
> -	KUNIT_EXPECT_EQ(test, 0x0000000000000006ull, GENMASK_U128(2, 1));
> -	KUNIT_EXPECT_EQ(test, 0x00000000ffffffffull, GENMASK_U128(31, 0));
> -	KUNIT_EXPECT_EQ(test, 0x000000ffffe00000ull, GENMASK_U128(39, 21));
> -	KUNIT_EXPECT_EQ(test, 0xffffffffffffffffull, GENMASK_U128(63, 0));
> +	BUILD_BUG_ON(GENMASK_U128(0, 0) != 0x0000000000000001ull);
> +	BUILD_BUG_ON(GENMASK_U128(1, 0) != 0x0000000000000003ull);
> +	BUILD_BUG_ON(GENMASK_U128(2, 1) != 0x0000000000000006ull);
> +	BUILD_BUG_ON(GENMASK_U128(31, 0) != 0x00000000ffffffffull);
> +	BUILD_BUG_ON(GENMASK_U128(39, 21) != 0x000000ffffe00000ull);
> +	BUILD_BUG_ON(GENMASK_U128(63, 0) != 0xffffffffffffffffull);
>  
>  	/* Above 64 bit masks - only 64 bit portion can be validated once */
> -	KUNIT_EXPECT_EQ(test, 0xffffffffffffffffull, GENMASK_U128(64, 0) >> 1);
> -	KUNIT_EXPECT_EQ(test, 0x00000000ffffffffull, GENMASK_U128(81, 50) >> 50);
> -	KUNIT_EXPECT_EQ(test, 0x0000000000ffffffull, GENMASK_U128(87, 64) >> 64);
> -	KUNIT_EXPECT_EQ(test, 0x0000000000ff0000ull, GENMASK_U128(87, 80) >> 64);
> -
> -	KUNIT_EXPECT_EQ(test, 0xffffffffffffffffull, GENMASK_U128(127, 0) >> 64);
> -	KUNIT_EXPECT_EQ(test, 0xffffffffffffffffull, (u64)GENMASK_U128(127, 0));
> -	KUNIT_EXPECT_EQ(test, 0x0000000000000003ull, GENMASK_U128(127, 126) >> 126);
> -	KUNIT_EXPECT_EQ(test, 0x0000000000000001ull, GENMASK_U128(127, 127) >> 127);
> +	BUILD_BUG_ON(GENMASK_U128(64, 0) >> 1 != 0xffffffffffffffffull);
> +	BUILD_BUG_ON(GENMASK_U128(81, 50) >> 50 != 0x00000000ffffffffull);
> +	BUILD_BUG_ON(GENMASK_U128(87, 64) >> 64 != 0x0000000000ffffffull);
> +	BUILD_BUG_ON(GENMASK_U128(87, 80) >> 64 != 0x0000000000ff0000ull);
> +
> +	BUILD_BUG_ON(GENMASK_U128(127, 0) >> 64 != 0xffffffffffffffffull);
> +	BUILD_BUG_ON((u64)GENMASK_U128(127, 0) != 0xffffffffffffffffull);
> +	BUILD_BUG_ON(GENMASK_U128(127, 126) >> 126 != 0x0000000000000003ull);
> +	BUILD_BUG_ON(GENMASK_U128(127, 127) >> 127 != 0x0000000000000001ull);
>  #ifdef TEST_GENMASK_FAILURES
>  	/* these should fail compilation */
>  	GENMASK_U128(0, 1);
> @@ -129,21 +129,21 @@ static void genmask_input_check_test(struct kunit *test)
>  	OPTIMIZER_HIDE_VAR(w);
>  
>  	/* Unknown input */
> -	KUNIT_EXPECT_EQ(test, 0, GENMASK_INPUT_CHECK(x, 0, 32));
> -	KUNIT_EXPECT_EQ(test, 0, GENMASK_INPUT_CHECK(0, x, 32));
> -	KUNIT_EXPECT_EQ(test, 0, GENMASK_INPUT_CHECK(x, y, 32));
> +	BUILD_BUG_ON(GENMASK_INPUT_CHECK(x, 0, 32) != 0);
> +	BUILD_BUG_ON(GENMASK_INPUT_CHECK(0, x, 32) != 0);
> +	BUILD_BUG_ON(GENMASK_INPUT_CHECK(x, y, 32) != 0);
>  
> -	KUNIT_EXPECT_EQ(test, 0, GENMASK_INPUT_CHECK(z, 0, 32));
> -	KUNIT_EXPECT_EQ(test, 0, GENMASK_INPUT_CHECK(0, z, 32));
> -	KUNIT_EXPECT_EQ(test, 0, GENMASK_INPUT_CHECK(z, w, 32));
> +	BUILD_BUG_ON(GENMASK_INPUT_CHECK(z, 0, 32) != 0);
> +	BUILD_BUG_ON(GENMASK_INPUT_CHECK(0, z, 32) != 0);
> +	BUILD_BUG_ON(GENMASK_INPUT_CHECK(z, w, 32) != 0);
>  
>  	/* Valid input */
> -	KUNIT_EXPECT_EQ(test, 0, GENMASK_INPUT_CHECK(1, 1, 32));
> -	KUNIT_EXPECT_EQ(test, 0, GENMASK_INPUT_CHECK(39, 21, 64));
> +	BUILD_BUG_ON(GENMASK_INPUT_CHECK(1, 1, 32) != 0);
> +	BUILD_BUG_ON(GENMASK_INPUT_CHECK(39, 21, 64) != 0);
>  
> -	KUNIT_EXPECT_EQ(test, 0, GENMASK_INPUT_CHECK(100, 80, 128));
> -	KUNIT_EXPECT_EQ(test, 0, GENMASK_INPUT_CHECK(110, 65, 128));
> -	KUNIT_EXPECT_EQ(test, 0, GENMASK_INPUT_CHECK(127, 0, 128));
> +	BUILD_BUG_ON(GENMASK_INPUT_CHECK(100, 80, 128) != 0);
> +	BUILD_BUG_ON(GENMASK_INPUT_CHECK(110, 65, 128) != 0);
> +	BUILD_BUG_ON(GENMASK_INPUT_CHECK(127, 0, 128) != 0);
>  }
>  
>  
> -- 
> 2.39.5
