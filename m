Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.3
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792770341;
	b=bsciMEW+xn7EnMWFHxU80oLemL2VnhExM88rnqGsSGJnJG1ebW2wp7bwmn0DiNfjkYyB
	 bXo9Av5y4WucWLg+vKmXn5kAMHGmSUns9+XkU3KoOqQHF8gCWGeRzUd8cWX4N/yu1g31J
	 /vKGmkdVJzKcF9qLKhc3SwVYpIRtG8r+q9QLB9Jv0dGWWqBddUbgPCwiCyJhbo3JvD1OJ
	 3YrxdeOrKYR2G1lXnE8syzeV4ySK+EpnmQXOJ9D00z50+8lA0m22fGBWbt7eomjFnJqa0
	 QJFyN+QxDYcKVO5koYeWhX2VgpNAbihEjsLyT4RJGjMqUbf2XI1HGdQnHXHv7NaSMHg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792770341;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=PGElkKCbEKVsZRf7SdWStE5ri6VGTZgNqWGjGvHSYrc=;
	b=yzbceWBmuHJGkbSQ7VVHAPDxdA0sXM7q9+QAX81qH6s6W+r9rNC+1SIHZVu9AaXmn8d+
	 KuIJzh5Ib/k2FPcLuYIUG3fluwPu4OXx2UDn2QLonx6dJ3WSZhcu+fdQPD9d/XCt1VF3l
	 Rppp1LZ5rp7Lzpdu2Jnk0C61n5Lw36Fb76CSliGJEACrlJUG2WVmH8CZIMk4LgEkWT2B4
	 uQfJwUUttts+BDn4TrfwPGlVt+pqOCpSXbtwGaeCykDNYqtJH4exsoS+KmHg2Bt1twqin
	 fLXM+4rImrJEpLHcSnHOy0m71K5knizMCAXwrWYWJJ1bMBitZwD/aBiIvEPMTrisqxg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=NB00zfFg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.3
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010003.outbound.protection.outlook.com [52.101.61.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A483E606A320;
	Fri, 23 Oct 2026 15:45:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A483E606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=NB00zfFg
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ir2/kNV4n/Xe9Hf88JwKDNHDisw7cDdKvG3MfQnoilzvNsn1z1tUgdKOSUKgvp2cKnxAJjQjYPxsbkXfAg02Gy+Vnv0AqylDDSPt3MZbMotgr+M0n0R4xFb1XLBnIgK6YugXg1wAwTz0i590aW2ea5c+/4YZVtEhwAxPoIEz+DCL8/kITo3+B0kl3IT3wf7ctA4nqE+004jQdOe14zJrMkhIIUOc/aNcq8Ir+FoOnCHwiH5xoeas6Hdu3jxY6AqkYfx/t2XrzuajchjUU15X7TDu6nCzbmhVivpayr5v+66XACTG6nIr1ikep/ab++WeAPC7ePVnvbMxL8uQxRBD4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PGElkKCbEKVsZRf7SdWStE5ri6VGTZgNqWGjGvHSYrc=;
 b=CkByUzGgpVT6SkQNFFpGQD+VQK64YfPyNtyrzSsnC66WWDxZoJafKgbLGN6+/E3WnrqKIjGlEWL/tlg4oBdt+kYmz3KKdM9erpm4OIdhvKuAvqu0Zz3n2dr/rrSjz2BRJBS8xbTcEl1DaVNHNL3rSYI2/gJTFmWAYVwKd+HDhs3SE0QX10iuwTw0VE8osx7+lXXX160ZMHEAtJpgGRgAFELvI3fBHK+kUmLNRrr2RcewehqsBfXTsrsWlLM8plDnk9ytovizOVlrbTpgYslJ2V5Sf9wQIMz9McrHu8CxPuBqaCZ6hwTqBUIP+GVa0PGeHh6NthmAAodCXA2mwuCIqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PGElkKCbEKVsZRf7SdWStE5ri6VGTZgNqWGjGvHSYrc=;
 b=NB00zfFgk03BYrpYAPR0HIBEmutQBTBnriIxRc3CtflKuMfjJVYYqwrbtcVBTWs9znKZV/VeuL+Ols++kIJbOeeFJGX515GhiZcXogC+X7Ef6q0qgwHK/PiwbID5C6AV91T5IBOlWhTmowhdCng5VOZc7F86Em1UQ5yMWVO6QsHxP37cODA2fLu8iz/KNjxToYrdY1Es3BxLBhLjCWc5rQwXCSLgZWdBH6HLjoUxXib0nmIOF9czi94eVqFs8V3sRY6xu3IQo5YV3PqejTrCD3BJXFh2h2zXr1yi3ldNRFNZBuvB1CgwMfBzzx+T8k43C5Ke078Iuzx5ofD3WPElPQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by DS4PR12MB442241.namprd12.prod.outlook.com (2603:10b6:8:506::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Fri, 23 Oct
 2026 15:45:37 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0496.015; Fri, 23 Oct 2026
 15:45:36 +0000
Date: Fri, 23 Oct 2026 11:45:35 -0400
From: Yury Norov <ynorov@nvidia.com>
To: Tzu-Ching Yang <shingekinocore@gmail.com>
Cc: Guo Ren <guoren@kernel.org>, linux-csky@vger.kernel.org,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] csky: bitops: Use the compiler builtin for __fls()
Message-ID: <atuBH6-LHueXYbFy@yury>
References: <20261022115922.1210342-1-shingekinocore@gmail.com>
 <atpm00m6KYhXo6Wi@yury>
 <20261023140806.1367050-1-shingekinocore@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261023140806.1367050-1-shingekinocore@gmail.com>
X-ClientProxiedBy: MN2PR22CA0002.namprd22.prod.outlook.com
 (2603:10b6:208:238::7) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|DS4PR12MB442241:EE_
X-MS-Office365-Filtering-Correlation-Id: 26514c0c-cb8e-4a02-921f-08df311cae8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|10070799003|4143699003|56012099006|11063799006|261021123027099003|261021121427099003|261022105027099003|261022075727099003|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	2kcxMx9K1j2I8X5GRpA/lDLG+CdLIjrJ15EaEXjByg8hD+BrqV7Abufe1XSPMfDtpFIYcEQa3EsyKB0eAZBeN7XJW9CRa2aNXWy4F9E5yqffONr22VlbPWy9ZFZgvJfONX2RfWHq3TDC0VMwS5EE/yCtRLlRPCRBXa1PZcPZJKA7v86OSlZisYWBNR3knplRGiZzbeuiJHOPzInnU9S9xoIlBawGoTYBwkZbdoD3OYTBTKvZIAXfKUuFfPS6pplCMtzqfT9lFHjydXluVlybUh+tCchlzSgbqJjOynpDEeJuT5QyT/ziOQoBJn3wMytSgjLpSq0q7hAGdX7Jic+y+asY7+lnA18HhcOOR7ivg7gBGTJksQ9xmI3nkHfk6n596BkPSIsIYcXeTbT2UKfSSbFrBA5jqpGQohJpo/NZ/AmMun9W2YADq6jLNfYxFmrJWSLFteoX0Re02bHl9a2lAfjeIZaoFCQG63/egbI7DHva3OcTkf6p4TipXMLxffG9IzMxiHGC3Qn4V8WMmkQLQA8OERJgJWlbOJezxNOD9PPM/IKJd6VA3BLEM1HhC+5G9ZnVreZOvTRxMDWyxrKxQ10l97z/eRIXeZWdxT9qT+0p/Hta2aSkVfj8/Txr0sD2AA5CjkZvnuMMpxvZ6LnAvH9SZuITOml3gNzOY7k16mE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(10070799003)(4143699003)(56012099006)(11063799006)(261021123027099003)(261021121427099003)(261022105027099003)(261022075727099003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kV/xj7xbXU/LBlumsMYMJn7VFy/iKImuc90qBpv8YFbJ5eZtbtKsbm+IHg4j?=
 =?us-ascii?Q?MXS8fLAiSNKryzOsM625NEYKmcD4INmcaISQz+jzArcB0P/Yb4u5IdQufd2A?=
 =?us-ascii?Q?tQesl3KM0KKimyZ8Wpizm/6m9w+66ehxUVb4siszktkZ1RXOo8hqTBQFTXS9?=
 =?us-ascii?Q?gjLFJqQ5KLxnET3Z1HLYSzO6mZEhWHmQMUgY0eAMHelcrlpC6eLOCIdgj0NC?=
 =?us-ascii?Q?/tdl3F5wTBrCizBLWUj/7mFi7WGRMJFY1UMS3lNMz4uJLDXNw0xrH0KWV+c4?=
 =?us-ascii?Q?g3oB8PYlFjw1+stbB7YrGyLlVAZ8t/by8c4u9ZPR9pVhTY+/AcOtT8UuwWFL?=
 =?us-ascii?Q?VRAZYBqMMNpwcAskWhcHL6OKe2B8YhNWGCvbCZcOQZDr4kKJ9RCEf828n9du?=
 =?us-ascii?Q?8KNLEfsnc/DmKw5rAiiMZELO09I7JcYBobGjH6epvqZE7il/S0o0co2OgqAV?=
 =?us-ascii?Q?tMOkLUS92u6HoaTVOL3DO4sNI1T021PxU0AikIDFOhUIpjpjGQfPDZDLuh47?=
 =?us-ascii?Q?3Ag6LXA105vfJ+IL9wvLLaQrdYnza2fuUgdTL5i6AQBdBQ+rE4MeEePli5KH?=
 =?us-ascii?Q?SklexjZqWmY22RJx9K1jT7dq5QcRljTvHiWWSPFCEQ1x7O5sry/KuDa3VeuI?=
 =?us-ascii?Q?Zm8dN4Tnaic0nvwJglzgIyQ0vVpCjgD2xWxBniAy1rSBpQyVWGoov9VPXkzr?=
 =?us-ascii?Q?sBGvn3H7L39D4qL9N0a/Lr8TfG6W6E+D1iytLQCUMpztYbBTHafRH1/tNwmV?=
 =?us-ascii?Q?N+I9iD3zkgvTpoqcNzmzvk3tGBe3h/F6NlP5WIgPNZuHXaqdYmKqACjxxxTC?=
 =?us-ascii?Q?Qgfx4ytnPKqlKh5XTWpbUzv1xtnsIM1bdUDG5D3lm7IVWGf+dk/arhVsj3uj?=
 =?us-ascii?Q?UqiPbZesN9pVMwVF43sGoocwL5YCG5xlhh2DlfQ4MAbwkNBrX1ItByBiDiaK?=
 =?us-ascii?Q?NCD0WO7vIbfLHKMsqx2EkFhWmN1wb7P2g/PFlYO4Slc1Ir+MUDeMmsASgsXm?=
 =?us-ascii?Q?+QTX1QH9qKXvKrD0FBBtyoKCVBeDI3w7eLF2Vpm8c0NOoaZnPmY/hv7EN36b?=
 =?us-ascii?Q?7OkxxdXjsb137ViAhpuxz5cpWaOeETCGmWIlMdZNuubdAbQ9d3nCvh2FGWJv?=
 =?us-ascii?Q?wMgS0fDuP8a6HCT4H+lAvtwIiCYfIzy7xo7TRiJyY6nvNI9RumvGLb9zqmw7?=
 =?us-ascii?Q?4orIZD+SEh+vN2WPx/unEOvFftLaRNuYf8TQWNO133yJrHUGHi8GbPH8de0m?=
 =?us-ascii?Q?A+ZZyW3SovnCinqYjBIKgwd9sgFjOuEXrwiCv1VkS2X4ylxy4filQheoABij?=
 =?us-ascii?Q?IC0XzPpsFORcasAKeObIfumfl2CMsp+urxehlTZn5iwCOREbZdfIefYCCX2n?=
 =?us-ascii?Q?wjChJKWj1tLQsLFvRlOljJbhKlx35TD/bpDRPlqa808xoDiLXWQgWUUQBQi5?=
 =?us-ascii?Q?e5PJcdwGzstbUAIlHu0PEuqdLeSOXjneaPqJJIY2IWIID7m0BI9JCg2ch/V+?=
 =?us-ascii?Q?LF0dYPPtD6ntFIKiis3IwKDHxCNOKzmrjD8Gm3EHbnzmpsvNHK9XThWKQqTh?=
 =?us-ascii?Q?UrACKjAQrXq/IFi2G8gALLY/p3EepS0eZd7Uqa4LaKnBGBOxfznRVmeFX0vX?=
 =?us-ascii?Q?YjWFzLJ575t+5eoC/CVOeDAEO+nX80GRXffksQ3o+ODBidqJqsyS11F+yzHz?=
 =?us-ascii?Q?W+SCw8CEz5WyCpHHEYezLR4vEZLqFzis6GDq2otjA9z/HIb5sWcP48bE/ZkF?=
 =?us-ascii?Q?K1N6mzAS6AJ+zVFgFWY8JGgn1KWjJzc4LfT+EbInG7d3tZ72fR6H?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26514c0c-cb8e-4a02-921f-08df311cae8b
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 15:45:36.8283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uJ+DTOAnDWmvu3X6Kagy9dx2v8+U00buMNhbJO1nQRzE2D1W8OFxZx6e1/R6ZrLeNCsw5wmam/jde1q/9yE1MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB442241

On Fri, Oct 23, 2026 at 10:08:06PM +0800, Tzu-Ching Yang wrote:
> On Thu, Oct 22, 2026 at 03:41:07PM -0400, Yury Norov wrote:
> > So I didn't understand if you have an access to the hardware or not. I
> > don't know the story behind using the non-generic version of ffl(),
> > but it may be for performance reasons. Can you / someone else please
> > run the lib/find_bit_benchmark.c on real hardware before we move this?
> 
> No, I have no csky hardware; all run-time tests were under XuanTie's
> QEMU.
> 
> The ff1 asm is in fls(), which the patch keeps. __fls() has been a C
> wrapper around it, fls(x) - 1, since the 2018 port (735ee005c371), with
> no reason recorded. The builtin compiles to the same ff1: 4
> instructions before and after with every GCC 9 to 16 and CPU tested,
> so __fls() itself is neither faster nor slower. The gain is elsewhere:
> the builtin folds constant arguments and merges repeated calls, which
> saves 128 to 320 bytes of text. It is the csky part of the conversions
> Arnd suggested in the ffs()/fls() thread (the Link: in the patch).
> 
> In lib/find_bit_benchmark.c only find_last_bit() reaches __fls(); the
> other six tests use the unchanged __ffs() asm. _find_last_bit() is 27
> instructions with one ff1 before and after with GCC 10 to 16 (28 -> 27
> with GCC 9), and under QEMU with -icount it executes the same number of
> instructions per call before and after with GCC 12 and 16, one fewer
> with GCC 9. QEMU has no pipeline model, so a real core could still
> differ.
> 
> Guo Ren, or anyone with a CK8xx board: could you run the benchmark
> (CONFIG_FIND_BIT_BENCHMARK=y) before and after? I'm happy to wait.

While waiting happy, can you print the bloat-o-meter results, and a
couple listings of the code generation, including compile- and runtime
cases.

Thanks,
Yury
