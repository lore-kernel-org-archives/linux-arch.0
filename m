Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020109.outbound.protection.outlook.com [52.101.191.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C848722425B;
	Tue,  6 Oct 2026 05:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791265889; cv=fail; b=cAhr5I/QmCqUPluzbmEmd97UULnCWtQpGaqAeCwhH8eHq9SqBXVVPV8QdQl9EFeFMZquceVyWCrs6Evxksj8r+Pu/XR1VJnB1Vloy2iZaUatkqJoOOK27thKlRqO/dA8V19FgcxN/e7Nfyi/ui5IwJLdLbL7LBR/yqH1IUdbrMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791265889; c=relaxed/simple;
	bh=7H2lIAs0B/GODfGRuN2wJ7kUWgQLBQ8WYlIJskpSQWk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cVPfEMeMjA1ZLpyiOiY5M6Ljp6haYjCFXGpQSkD75kdDozKQO6zIvbEXH/DlzFIxjca2nFSWrcZMjcQNFjgw0kY4j2KIbGvlwwRG7NXvvjMWCHSaKbbXTAVwmGuwId5KJDMzkkbtMyuJgiTBzbEmMygPmJtwCiZtpRaUk/2LNdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=btY7cJ+7; arc=fail smtp.client-ip=52.101.191.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="btY7cJ+7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jpJDvqvB7VguNezP8OwYZ+OD4WoO5RiFvfkf8LX+uEbl8kN9TilOnTxKs3pQtu0Uc51UZ9MU6Ap5g0bRzoRwJDhH3UxJw4TlSedjw1egNny52+HJcPOaNwV2SV+lxylnDbCwEPzkHTileGcI63KGNCEE+vmLFW4ziYTUUmlCyB0kiCQj+cKSk1QzYGJ82hjm9GhkKj38m4bUUaE8tKeMMDcZsMfPMK2z5Pa5lOjMuwtTIEWi7468GEFbV7uc9CMb6SDI6IgNRWnaEbcAxdd/+JaRGGNBI4roRmJ+1wAaLYdNRkvUpgm3QfQXUJgluaeFvLQPeSR9JJuAD5kFcmNhvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NVI6BT1d2xVC8fdkqAHIc8MOEJ8FdTuPWgJwRZm25ik=;
 b=BbouF1sXA2a5WZyq/UJrZ7clodcVqu/OhsGX9XD1BKthWg6pOAAEi+a2/VxkMMsRyH8n2H/vDlVGuEvTFU/mkzAXxKXx9dnUn1RsO+KQNhNrUb5BlbO00ftas+JdvvoJ3Us/eLXgFGd7AJnvR/ZTLmAcYCgZsqNBpeJOP4TuvmJ1uh7hrXA4aHklkd05szqlv7SPF1kV8LedcRB/Fd3LSfkc8snSoHA1QMurB9yNTJmJjCZI3frxeUJGUndk29cBmI6jUX0YYOgQzo+QAh0nTeNWgBe/zcE2VbvEW6pR2Zona8xD995biReMH7TTPpAZx9D6k2RybNOrUCqlOr/87g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NVI6BT1d2xVC8fdkqAHIc8MOEJ8FdTuPWgJwRZm25ik=;
 b=btY7cJ+7VutmeQMS9vUF4JrLZlZ5Z2lwv83e0LbYWcFr6pfXlOazPPdhlvAXDqNGPqBs3H6GMCtS6REtAQDesZ+bZFKx1LaRyUJXA0PpV2yDnw85rZn0mbmEjK0/u+V561hZ+iKNCI+WGzdaKp26UTwIBehPcn38ktZ2eYxR9FZkErQIdOwGtpJ+l97mDCIxWVvrjSy6UcBaT/f382jP1Njoyz2qTyIG3B5zfa5mbAGvcO3dNn7aWU8KvCOQ0Ch62OJGjB9k2FxnSrJ07iQPUud37zREm2k8KMMVFdtAMK5hUwv8o8v3ncMh7O21KgXIlSX93EFM6nUgptxFi2rjAQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YQBPR0101MB9310.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:61::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 05:51:22 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 05:51:22 +0000
Message-ID: <bedc399a-151c-42e5-b33e-d78221702fa5@efficios.com>
Date: Tue, 6 Oct 2026 01:51:13 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 02/15] hazptr: use Bloom filter for shared scan
 waiters
To: Kunwu Chan <kunwu.chan@gmail.com>, paulmck@kernel.org, corbet@lwn.net,
 mingo@redhat.com, frederic@kernel.org, neeraj.upadhyay@kernel.org,
 josh@joshtriplett.org, urezki@gmail.com, dave@stgolabs.net,
 lianux.mm@gmail.com
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
 peterz@infradead.org, boqun@kernel.org, npiggin@gmail.com,
 dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
 akiyks@gmail.com, dlustig@nvidia.com, joelagnelf@nvidia.com,
 skhan@linuxfoundation.org, rdunlap@infradead.org, longman@redhat.com,
 rostedt@goodmis.org, jiangshanlai@gmail.com, qiang.zhang@linux.dev,
 brads@mainlining.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, lkmm@lists.linux.dev, linux-doc@vger.kernel.org,
 rcu@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20261005171529.1378809-1-kunwu.chan@gmail.com>
 <20261005171529.1378809-3-kunwu.chan@gmail.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20261005171529.1378809-3-kunwu.chan@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0094.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::7) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YQBPR0101MB9310:EE_
X-MS-Office365-Filtering-Correlation-Id: 98148b01-7cd9-46d2-4876-08df236dd9ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|921020|56012099006|4143699003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	GkP+6FWNEhb03zxN2JJrEMu9auXnhcPRd89T25cz0kfU/tLd09ajovkX/YEKYEUYOrdL586o2d4V6EUZN9OS51OPF0AG98A2278xmKY279kP4ODmg6tzPNwtgWaxuJGPs4ngrDSAIZf7/t11P/ojkApSHHJMO/kgFJ+XbxGMqxA8YSh02OcY08eOnTEBlptZKhYZh6mLIYANLAZ6+oBsWDTelIWDzBoXXffOlLCQqQctIlkEAplJb+GFGUiYOP+4K3kIssE7lLkLN5vTrT66Gayh6hIps8lIBEwOJu4AKRougOw398D/EVBW6Wsd3bwlEtr/ENHPRc8CZZyL7VbkqrzWojLwPNCNsXIVsncZqvXNk6/8SgamCwiC1LOVK1MtXfXQ20cIvYpJzJ6Fp9yO20wmntZmJk2tLqEIbroFczYhY0XwVAFGAYR3zQV5dkHYgGMk+qOY7I47J8niCGQxJdl5hq8P/2CBxUSmiNfG5zFYAVikzDiJloz5I85KHI1LeoKoa9unFxSuEbP+aKcvNukdX/v2avcfsqHWMPsu4Qen6TanlSDI+ECukSy0lDQGzSRGKwJkHrlEjJVy/Xk8mEy/aNXiFIGk2WlRcJez5Gty7HGpwTgSCKt9uMkBD19McPY4BYLlcujt/EAv9AHDoQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(921020)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U1dFQnRENU9VM2tORUx1aXMrUGN5a1AxSWFDb0xKd0xLVnZPekFQK0VWVXk4?=
 =?utf-8?B?MHd4aFpGalVVd3F2a21vdlIyb2lQYVEraGhKWDJ5L3BzZ2xJRVJPWnV5cTdR?=
 =?utf-8?B?azRNQm1rTVdOdEk1OVpDdWxmSUh3dkpScEk0c1RXS012MUJidU1jZEs3MTBT?=
 =?utf-8?B?YS84UE5iSTVRUE9kZ1VBalo1U0xCVEttTTV3QjltcWR1YWdrTzBNU0lPRUV3?=
 =?utf-8?B?OVRMNEdGMjNlZDEzZS9EUEVPcWF3OUFWUjdwRFN4THJrTCtWWjV5ZHBUME5l?=
 =?utf-8?B?S0x0U0svU1pmNjZVaW15ZUpLc0F5M2szTGZkUUhmVmlEYkxJbXVlVDE5L2px?=
 =?utf-8?B?MEZGS3FZUWtGWWhkZnorbytuSGdQUnM1Vm16V3N6SWsvVzZabzlEa0ZIcWpM?=
 =?utf-8?B?Y0xkNi95d0lpdlBMMFFuRFV1SW5MWERSdEZjSW5wTmN5WGxPV25iSC9pNmZT?=
 =?utf-8?B?cTZMWDR6anRORlBUOXpwakxLdzlVWmdhOEt6Q2tXbVVLTzZUbnFUOG5oWU9S?=
 =?utf-8?B?eVNITmNqdEZmNVFkcHM4dVhtNU1yaHlxdy8wZDVmblhvUkk2amUzTXRqcTVt?=
 =?utf-8?B?SVVBRnkvOHg0ZXhUbFl2b1JvTktjK1VDWlZ3ZmQ2M2gxTXR6T0ovWnNqOVVn?=
 =?utf-8?B?L1Zlby9FV3VlOFJBQTh6QVJ1Vk05Nk4yZ0tSREVDRm43dlloK0MwaEMvdXlp?=
 =?utf-8?B?SXRRNk04cGZHajBPbE1zMEJwdDY3K1c4YlRyRHAveFNvYjB4Z3RiTFdjdERs?=
 =?utf-8?B?QkFyWkhKQ0tOd014WU1hYmMwOVFYSmphOWJEN1dKMGw1b0RPRTJpcnkzMit2?=
 =?utf-8?B?SEgrM3RVWnIxeUhTY01uTXIwRFpTbkFOMC9PR2NLUnZLZXk3b2x3eFVta2d6?=
 =?utf-8?B?Ry8rcXR6L0t0eVBQQmJwbDJSSlZQaDdOdnBEeVEzeW9BNDUyVnN4YVM4TmVU?=
 =?utf-8?B?NDBIbXkrMDl6NkxsNU03SnlGU0JnV2FReHpJTXE3RFNJYnBUNTRPMFhNQlZK?=
 =?utf-8?B?RUJoWlNNSkQ0L0NKWUFCYTdiaDJ1cVE5N0ZKZHFZb0lXSlZ6TWNHK3hBNEFG?=
 =?utf-8?B?MUZxUXZMRHdIOWk1UVNPU2lIYnVRZHpXRU1GaEtORm5pSGdUZzFkclBWYVY4?=
 =?utf-8?B?RkcrZXRIOHFLS2Z3ZzJ2ejFGSlJrVVNKa3ppbFJCSHQ2Q0xpSGs2VW55Q2tE?=
 =?utf-8?B?NFV5TnRBMTNRcGFlRTlDTE9idndTa2lBZ1BxTE1WOTFSR3ZTRWlLZ3JyNitQ?=
 =?utf-8?B?cGtyb29zRWRWcVp1MHF6VWljWVd2RVRNWU1BT200Z1lYNmg5VHdwQU1IckxP?=
 =?utf-8?B?YUQxZFlQTEdaZC9JOWlhZWdXM1dVZE8zUHFnL2lxV2xDZWhaQWNpN05IblBt?=
 =?utf-8?B?RlJOd2MvaDg3SFJjbmxnTUVMVVhWUE9SdzdLSWNWWCsxWEVLWUN2OWFORXRa?=
 =?utf-8?B?SndRUWJ1TWR2ak1hYytabFNzUnExbXo3VjhxeDNVWUozUUxxL2JsNXV6MUFE?=
 =?utf-8?B?akl5TmtVN3krU21OZXB0SG1rVTlMdlNZTW5GdktSMXVGZDJ6cm5xWThSZXI2?=
 =?utf-8?B?WjVFZzEzNjBWbU91VUNESTNaQ3B0dEpnRk5QOTBjd3d2eER1Q3ZSN2xBbWRj?=
 =?utf-8?B?ZkMvbXphWkxUci84SWlvR2R1YTU1RmkvUkNQU0VReWsrc1NmaXloaFJoVUVB?=
 =?utf-8?B?M2ZpRnU2bHFpNVhUbGJhT0Y1VGV5Nng2K3hnVlZiOG44YW5wcUp1ZUhna0Z3?=
 =?utf-8?B?RlI0a1c3Qm1mcmtQR2pMVmpIWlpKdWFzUnN4cHBrbDB3UnNCZTg3Vkh6V0do?=
 =?utf-8?B?YXVhSWNZdDNPU2E3V0NRV0RUdVpZSjFXNWFrbzR6RzlSNHpCR3ZGcXkrb080?=
 =?utf-8?B?WDkxZkt5eEMyNmMvb0I3Y25nTHZTeUl6MFlueVJTVVJweVN1Z3VQbEpEM25q?=
 =?utf-8?B?VVRkWFhBREFYVWdUVUtCT2N3SFV0WnRuZnFKVGR4cTk1OTB1SGUyVzJVVlU3?=
 =?utf-8?B?VFBjSlhqWXU2MWViV3BRc2FrZ29IYU9lUEI1cG5VeThhbDdkbGhaVVVUbVhj?=
 =?utf-8?B?VjRwMXNaSnNsWEt4UXJ3ZnBVVXROVjh4SkNxQWE5Nmk5QjFzaTVuUHJkUnRs?=
 =?utf-8?B?bitrRW9YQ1o4SGZCUi81cktXdEZqU0dVN1ZxMFhWMllXaHpBSTBxMUVIUXZx?=
 =?utf-8?B?Uk4zVFhFT1lpcUl2VWFrMTRrOXZCQWk5dXNjL0lTeHdVby9tY3U0OXlzRnpy?=
 =?utf-8?B?Ulp2WXRwVlQ2d1BFQ1oyRmdhbklpc2FCSGg3enE4djlqajl4K2JkdXdDcnoy?=
 =?utf-8?B?amdmWVhFWnhTSkVtaTcrK3pwTXBwZkQ2eGdXWGpQVVZjeXpGbEVJdmVXVCtm?=
 =?utf-8?Q?SiVAClge4W7VkDiM=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98148b01-7cd9-46d2-4876-08df236dd9ce
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 05:51:22.3822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AoB0rZkacFKWTrO/1tS+HxUdgtx+mKNUAvZgv4oH04ZocaVpxbQmJyAXScKXkWxe/xX+Hu6FpBFe7SCwIfphlnjLVSeH9u5Q9lBoiX55l0I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB9310

On 2026-10-05 13:15, Kunwu Chan wrote:
> Replace the per-waiter exact-match scan with a shared Bloom filter
> built during the second drain pass: each observed non-wildcard
> address sets three bits, so a waiter whose address hashes to an
> unset bit can be completed without another slot walk.
> 
> A Bloom filter has no false negatives, so an address absent from
> the final drain scan cannot be held by an observed slot; false
> positives only delay completion to a later scan cycle.
> 
> The filter uses a one-page bitmap with three multiply-shift hash
> functions.  It lives in the hazptr_scan_state and is only touched
> by the scan kthread, so waiter state remains on the caller's stack
> and no dynamic allocation is needed.
> 
> Suggested-by: Boqun Feng <boqun@kernel.org>

I actually suggested that to Boqun in the first place. Feel
free to add my suggested-by tag as well. :)

Did you run your Bloom filter in a test program on the side to
see how it behaves with pointers, and confirm that the false
positive rate is not too high due to hashing algorithm/constants
concerns ?

Thanks!

Mathieu

> Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
> ---
>   kernel/hazptr.c | 93 +++++++++++++++++++++++++++++++++++++++++++------
>   1 file changed, 83 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/hazptr.c b/kernel/hazptr.c
> index 9e274a691af5..900ba35de2cb 100644
> --- a/kernel/hazptr.c
> +++ b/kernel/hazptr.c
> @@ -7,6 +7,7 @@
>    */
>   
>   #include <linux/hazptr.h>
> +#include <linux/bitops.h>
>   #include <linux/percpu.h>
>   #include <linux/spinlock.h>
>   #include <linux/mutex.h>
> @@ -16,6 +17,7 @@
>   #include <linux/kthread.h>
>   #include <linux/swait.h>
>   #include <linux/sched.h>
> +#include <linux/bitmap.h>
>   
>   /*
>    * The current hazard pointer wildcard. Flips between 1UL and 2UL to guarantee
> @@ -213,6 +215,55 @@ void hazptr_scan_period(void *addr, void *scan_wildcard)
>   	}
>   }
>   
> +/* Number of hash functions for the Bloom filter. */
> +#define HAZPTR_BLOOM_HASHES 3
> +
> +/* Number of bits in the Bloom filter bitmap: one page. */
> +#define HAZPTR_BLOOM_NBITS (PAGE_SIZE * 8)
> +
> +struct hazptr_bloom {
> +	unsigned long map[PAGE_SIZE / sizeof(unsigned long)];
> +};
> +
> +/*
> + * Multiply @addr by a per-hash odd constant and use the high bits
> + * as the Bloom filter index.
> + */
> +static unsigned long hazptr_bloom_hash(void *addr, unsigned int i)
> +{
> +	static const u64 mult[HAZPTR_BLOOM_HASHES] = {
> +		0x9E3779B97F4A7C15ULL,
> +		0xC2B2AE3D27D4EB4FULL,
> +		0x165667B19E3779F9ULL,
> +	};
> +	u64 hash = (u64)(unsigned long)addr * mult[i];
> +
> +	return hash >> (64 - ilog2(HAZPTR_BLOOM_NBITS));
> +}
> +
> +static void hazptr_bloom_reset(struct hazptr_bloom *bloom)
> +{
> +	bitmap_zero(bloom->map, HAZPTR_BLOOM_NBITS);
> +}
> +
> +static void hazptr_bloom_add(struct hazptr_bloom *bloom, void *addr)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < HAZPTR_BLOOM_HASHES; i++)
> +		__set_bit(hazptr_bloom_hash(addr, i), bloom->map);
> +}
> +
> +static bool hazptr_bloom_contains(const struct hazptr_bloom *bloom, void *addr)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < HAZPTR_BLOOM_HASHES; i++)
> +		if (!test_bit(hazptr_bloom_hash(addr, i), bloom->map))
> +			return false;
> +	return true;
> +}
> +
>   struct hazptr_waiter {
>   	struct list_head node;
>   	void *addr;
> @@ -226,17 +277,26 @@ struct hazptr_scan_state {
>   	struct mutex lock;
>   	struct list_head pending;
>   	struct list_head scanning;	/* kthread only */
> +	struct hazptr_bloom bloom;	/* kthread only */
>   };
>   static struct hazptr_scan_state hazptr_scan;
>   
>   /*
> - * Check per-CPU slots before overflow-list slots to match the
> - * acquisition ordering of promoted slots.
> + * Walk all slots and return true if @watch is present.  If @bloom
> + * is non-NULL, record observed non-wildcard addresses in it.
> + *
> + * Per-CPU slots are examined before overflow-list slots on each CPU
> + * to preserve the acquisition ordering required by the promote path:
> + * synchronize must observe the per-CPU slot release before the
> + * overflow-list entry can be missed.
>    */
> -static bool hazptr_value_present(void *val)
> +static bool hazptr_scan_walk(void *watch, struct hazptr_bloom *bloom)
>   {
>   	int cpu;
>   
> +	if (bloom)
> +		hazptr_bloom_reset(bloom);
> +
>   	for_each_possible_cpu(cpu) {
>   		struct hazptr_percpu_slots *percpu_slots = per_cpu_ptr(&hazptr_percpu_slots, cpu);
>   		struct hazptr_overflow_list_flip *overflow_list_flip = per_cpu_ptr(&percpu_overflow_list_flip, cpu);
> @@ -244,10 +304,14 @@ static bool hazptr_value_present(void *val)
>   
>   		for (idx = 0; idx < NR_HAZPTR_PERCPU_SLOTS; idx++) {
>   			struct hazptr_slot_item *item = &percpu_slots->items[idx];
> +			void *v;
>   
>   			/* Pairs with smp_store_release in hazptr_release(). */
> -			if (smp_load_acquire(&item->slot.addr) == val)
> +			v = smp_load_acquire(&item->slot.addr);
> +			if (v == watch)
>   				return true;
> +			if (bloom && v && !is_wildcard(v))
> +				hazptr_bloom_add(bloom, v);
>   		}
>   		for (int i = 0; i < 2; i++) {
>   			struct hazptr_overflow_list *list = &overflow_list_flip->array[i];
> @@ -256,11 +320,16 @@ static bool hazptr_value_present(void *val)
>   
>   			raw_spin_lock_irqsave(&list->lock, flags);
>   			hlist_for_each_entry(b, &list->head, overflow_node) {
> +				void *v;
> +
>   				/* Pairs with smp_store_release in hazptr_release(). */
> -				if (smp_load_acquire(&b->slot.addr) == val) {
> +				v = smp_load_acquire(&b->slot.addr);
> +				if (v == watch) {
>   					raw_spin_unlock_irqrestore(&list->lock, flags);
>   					return true;
>   				}
> +				if (bloom && v && !is_wildcard(v))
> +					hazptr_bloom_add(bloom, v);
>   			}
>   			raw_spin_unlock_irqrestore(&list->lock, flags);
>   		}
> @@ -276,7 +345,7 @@ static bool hazptr_value_present(void *val)
>    */
>   static void hazptr_drain_wildcard(void *wc)
>   {
> -	while (hazptr_value_present(wc))
> +	while (hazptr_scan_walk(wc, NULL))
>   		cond_resched();
>   }
>   
> @@ -309,12 +378,16 @@ static void hazptr_scan_do_cycle(void)
>   	WRITE_ONCE(hazptr_wildcard, scan_wildcard);
>   	old_wildcard = flip_wildcard(scan_wildcard);
>   
> -	/* Pass 2: drain the old wildcard. */
> -	hazptr_drain_wildcard(old_wildcard);
> +	/*
> +	 * Pass 2: drain the old wildcard while collecting observed
> +	 * addresses into the Bloom filter.
> +	 */
> +	while (hazptr_scan_walk(old_wildcard, &hazptr_scan.bloom))
> +		cond_resched();
>   
> -	/* Complete waiters whose address is no longer held by any slot. */
> +	/* Complete waiters whose address is not in the filter. */
>   	list_for_each_entry_safe(w, n, &hazptr_scan.scanning, node) {
> -		if (!hazptr_value_present(w->addr))
> +		if (!hazptr_bloom_contains(&hazptr_scan.bloom, w->addr))
>   			list_move(&w->node, &done);
>   	}
>   


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
