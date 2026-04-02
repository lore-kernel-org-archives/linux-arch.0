Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011050.outbound.protection.outlook.com [52.101.52.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2670B388379;
	Thu,  2 Apr 2026 21:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775167000; cv=fail; b=JasMJsKTsYsTExFnBy+n8nLZXOVGwaVSRIwpxIUsEwj6qSuxGm8vYynwoIJDF2jDeBC50PnS30eLaM6FJIDRfNQAdQJrvAEscAG9qSXEVbJPmhBZzjLb4tnIVSrEPpXh7z7jIOorNq6ZusFfTdB/UfEAHms0e8zP68Q+jw84yQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775167000; c=relaxed/simple;
	bh=jZrqV5edfhTY+fs99RpGMAwo/tF19A2AFT0TYf2Dwbo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CdrSIBVD8sZez84gzjRp6HNZ3T+rQmiH+oG6EDkZ+UrjxMVMoHu+aVoeJtf/xhrLt0+cYzIwQg3a4pR4IGUyPQI1qQotU5iI4kCFSxS0+cOFgxVC6SnFee1PmgVCpCDSVeVNtk104FgAVho+KQxOWZC5/PT/BKLBF0PqjmZsbyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cBY3f05f; arc=fail smtp.client-ip=52.101.52.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cBY3f05f"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=khBaGWTXkkuMLj22if97m28g0ZGll+tKydmSFXrlUooc1ZYKs+/ZPyfKX7qTU3cg9R/tXJqEEI1mymeyLbgIBwVArqjwJD0ivGAzB2LuyIGQI+uJWIOBjBHaT/km1+o2SQyp+49BV0ct64mSLnJMjVMbBDlbzC+TYtvP7hhYwalZeveLAHkhHOdTYdGc0Sws4l1Rjf4uQBPa6bZDF7KaaKv898QcUgPseZ0oVRllHqizz0fqAoP5xPBHK9yUSf0LERLK5Mp73kF95t5hP0BwHjydo3Pc68MqAztvTUavK0ENSViPiekSuvARXlLzV9coDx02/9aI6Topp3GpoJWEvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h38DhFmw/xnQr07Sa2I/+beUOgvDvJPrwhYwEjVAQpQ=;
 b=B2YcUg0JAeu9XTu2Iat2cxO9iFQgYLOK81TWqTb18BxuJykH0/fHtG6ehrQ7X/V+40PUIIp8yv1YOXvwl/CbFtChTMBqWW3Jh4z1gORgSARWRa7GQUxfEZqmLl+BMhFBY+O0kRdjLY1cp2hpqGM5cg348HjnzXifka3VWBNoX3/hjxwgaUvscqKsKLx2rHTyPpjctti56qFWX9KKCvYXv0QtUFNTRT0obrNhxlydYXaBIi+4oM7ZMctTt6VngQVagyq1lZpk5YuzbM/phTopVD9ZdtTaQR5z11C2CmV1UE80l4GRH0O/5zUSq1sNWP4cJwO+xrCxfgupiqPy071b1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h38DhFmw/xnQr07Sa2I/+beUOgvDvJPrwhYwEjVAQpQ=;
 b=cBY3f05fDOb3ARkTw8sUZdb1b0r/9sXuS1bU0c+zWSZOnq5mKjwG+GT32noO3eu/rgA/Z1zlFPRe6AsZ8hDTikDqO30WttQ1aYMbh8y3UaCEtOaoLQM2kPQIilpFThR9+OK3PWlsq9jXrymdB4M2uCj0DxvVdzVB1ZVEZrJUp2E4zE30NDw1O7/W8Kd9u6ESHOE4123Adk3zH/JOz3urWxcb7/6pA8X9rlwRfIJ59SjXAgTYkOY5xDnbIKE774Ka6Pg6fg9WYljaZrURWOu/aBuXyC8smYIrZoZ/14kqYrSyoJA551oRsGP7gFuY+t0Sx4j8FS96panG3jItoaVwqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 MW4PR12MB7030.namprd12.prod.outlook.com (2603:10b6:303:20a::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17; Thu, 2 Apr 2026 21:56:28 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9769.014; Thu, 2 Apr 2026
 21:56:28 +0000
Message-ID: <dc9c3448-d82f-4cec-97f9-7ea3387d8296@nvidia.com>
Date: Thu, 2 Apr 2026 17:56:25 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] gpu: nova-core: fix wrong use of barriers in GSP code
To: Gary Guo <gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Alan Stern <stern@rowland.harvard.edu>,
 Andrea Parri <parri.andrea@gmail.com>, Will Deacon <will@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Nicholas Piggin <npiggin@gmail.com>,
 David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>,
 Luc Maranget <luc.maranget@inria.fr>, "Paul E. McKenney"
 <paulmck@kernel.org>, Akira Yokosawa <akiyks@gmail.com>,
 Daniel Lustig <dlustig@nvidia.com>, rust-for-linux@vger.kernel.org,
 nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, lkmm@lists.linux.dev,
 dri-devel@lists.freedesktop.org
References: <20260402152443.1059634-2-gary@kernel.org>
 <20260402152443.1059634-5-gary@kernel.org>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <20260402152443.1059634-5-gary@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR1501CA0014.namprd15.prod.outlook.com
 (2603:10b6:207:17::27) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|MW4PR12MB7030:EE_
X-MS-Office365-Filtering-Correlation-Id: 17ba13b9-7420-42e5-7ce0-08de9102b0e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Oq/BbGHD2NPH38YfQ+KZ89++J1fq1tGmfKY5XfcixHRXIbRJezp2yuUgrwaFjd4L4LWv6rhp6Hp7dFFuF2hyvX1l4OWV33Fa/NSL5r7gtpTQES/0l4pjxNgV7IpwbWMYVpD8lht76Z9LcJ+GvDKBq/3AgRHB+1/FqiZASgncVaiqwOvH9v89eY09UxqFSfx3okFtHd3nSNStegyakps9qygxexmk9sKtJJbvmL0fYos1S6yh/MsxAd68wpO4aEbQKi/OoKFviH7qwW+4ASH8BbzShv7DgYFuB/d0vH4oLi90FchKF4ak6vobc9v15fZSaKDi74oPm8nb9tlJprr2yx2JCL1KupW0JLytaGfWkQa36vu+X2ve8Ftsrn7nPmKpzGxUCteZhNEuz76+cFursNn7QyuOFIj5RlRtoQYe5+oRT+cf6pFBRj8YvxwCxG/W8lqE7Ap8UTr2TdVnI5MKfUstqcTrTo82UQjy+v8CF5dcf11kmLgP4HLBV8DgwAGUKLRTexNvuBhYW4OmjsqlPrZpHpsACHkJVkFkG9NhOGP+bzyZ0JT2TM+H54Zsr4yNGwPAny/I0dXS1LoOndNbt6k4ecXCbJ2jMqvHu8RNUqshAyGqrIoLqbdX1lpT0kqWE9ZCWx0UUN+VE4tVVk8az0FnhOOZaXJY4Ruv9b179B46auMybg1gkzC1VyF7QLmeKNhdaoeTkh7gmWsidKhSXh8qtGGxbGy2RfERSE4rCv2fznhdkt/Z7jtNtJwBMMD/T8Rd4Y/7+xouh/gTAW9AQw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y3hSZnRFV1k4OE53cUh5Q1hDOUtVRHE3WUFncHdvZkxpalVkVjNNbzlJdEU2?=
 =?utf-8?B?SWVJd1NrT3BQWUVjblpBeXJ1dzNXUFU3ejJSSkJGSVVPY3VWdUthK3pNM2Ry?=
 =?utf-8?B?NG55TlhCTXVkaXl5MHNFN01ZUndEdEVMVE5yaEMzSXFMeUs0MVFDSk1RUUNo?=
 =?utf-8?B?WHh3eHRlcTJKc2hBM2lZSFRhcTVKUGVaLy9URWxtTFc5bUZSUmlVbmQyV0hF?=
 =?utf-8?B?NFBLZ0EyWHlLcERTVFNreThudEVwMTFydHErYjZkdndVbkRqRFhNK0xZRGow?=
 =?utf-8?B?Ykk2cE13LzZhZmN5RGJoY0FMMldvaWdtT3RCbDFwWEJCYldFc0pWUW8yckVS?=
 =?utf-8?B?RFJaR2UxaU5qOC81VnZHMFBBNmJtZlhBUUUvbjN2Vlo1QnRjc1BCUVZPMEFY?=
 =?utf-8?B?UlhmRUkrRXlUbEtIL1oyRHFuczg3cktucUlQV2t3WWlSUjBNcGJURTgxUkFW?=
 =?utf-8?B?V0RwNkRwbjFtN00vWmFZTUVXU2hIRU9lN0FjOEpmMDBIMll4dVhoS3FMZjhR?=
 =?utf-8?B?WWFNOHpVeENSaU45T3Q5a2x2UkFEeHoydnJ6cnF2cmdGdXMvYXc4dHJiUUxT?=
 =?utf-8?B?N2hRenNmK3VObWdFSVgxN2RFaGVIUUt4MDlWMG1OdnRjaE1uTXkveUNFZVFT?=
 =?utf-8?B?aUR2NitBeXNocFRtVjZPNWdpY0tNMG0yWjd4OUphWmNrdjVHVVJXVXhWY3dS?=
 =?utf-8?B?cXJKMEEraFNLUituSzBCckFiMEdnT3lXTTRVOHBjc2lpQk5ydW9lSXQwUkI4?=
 =?utf-8?B?WGNrQzNqZlRGcFdZYk1hQWpybS9qaW1BL011SkNJaHVhUWZvRXpWZjA4aS9q?=
 =?utf-8?B?NnBFTnBKTzk4QWVuWjAvbkd4T3N1c3VETGh6RTZGNENmdG4ySWFCSm1NWDNn?=
 =?utf-8?B?dzhSRFR4N0ExZENyWHJsbG1kV0FEVG1TMTZzbG55M2dCMk9nTjQvdm4wT2ti?=
 =?utf-8?B?WlYvM3ZzOVYxL2J1NkRZSHE4cXZaR3R0WnQvcXBDU3phTjR0L0d0WFlFSjU0?=
 =?utf-8?B?cE01NWY1RXIyL2RaSWNGa3BCSmJ3ZCtveE9mN0JkZUM2bjRwRnVpYm0xL0xB?=
 =?utf-8?B?SC81VUZ0K3RvSkNRbmkvVy9nTE4wSStjQlFhYzdCQzRwMEozZTlTUm0rTVp3?=
 =?utf-8?B?VUNWSjkvUkc3TFI4bWtjcDNUcDJ4b2syTmxpMnlaT3poanp1RUxPR0p0ZjJn?=
 =?utf-8?B?L1JLLzV0YTcwYnliNTF6aXRBWmE5VHYwdVEwYjZpMWRmblRoZ3N4d0ZEOTFu?=
 =?utf-8?B?TnFYdGFEREwwelNoQWJ1eDZrSlFGWmVzbkdVY0QzeTJyaEcwSnBpRG1jcElY?=
 =?utf-8?B?WGNpRG9ocHZWWG9sNjBiQk4rRVg5ZFRHUGRtdjhXdUg5dURKR0hnMUM5Tld3?=
 =?utf-8?B?d0ZGY2hPakFoZG9VdTFNSWhhcXFYUjluWDB5VEN6TXBtMHRzSjhoKzZoWDd1?=
 =?utf-8?B?V3dybGE2SitXbXNXdDJMQXNiR3JrYnV6V2UwZUowN3Nhdk4vSWJ3MDhVZ1NH?=
 =?utf-8?B?UlhiSlNEb0J5cXF3bC9VR1J3em5BQTU5aGNsR2FVSjd0bWhnT2Z0RUQwb0pF?=
 =?utf-8?B?eDFxeTZBbzhpTzV1b1pNdXcwT29sWHdxQlNDSzI0VzJFeFYxMjRGcFJ2M2t1?=
 =?utf-8?B?V2tpandxSDRYZGljYkg1NzZ5dmJKdkJoUjkrcmhaakd5V0JpYk5TTUFlZVJn?=
 =?utf-8?B?N1BMT3drLzVlRGd4Wm1ldVlLRkwreEN4ckR6VHlGT1dKVGhzcWRIc3lZa3lK?=
 =?utf-8?B?T3dkaFRyNlNrcUQyZ2xCREhsZ2lnMHhHK3ZvMnMvM0d1d0hwaktjU1FmVFln?=
 =?utf-8?B?ZzJKUEtpUkpKOFZibW5wdXY3SlpyTjBtN1F0dmwvQVo3SVFDZjlKU21KYXh0?=
 =?utf-8?B?RlUyRDRVZHY3K25tMTl4T3hWWTJybXN6b1lockFYTngxdXVMK0VlS1BNYm1T?=
 =?utf-8?B?eEl0UGhRaU5aM2I1Rkx2QlpyUjRHTjBMbGtlb0JaTDgrSFpDL0lKSkhNNW1V?=
 =?utf-8?B?YmVLOWpUMTB1QktveWExL2RxUktMc0JLL3F4SVZyNEg3d1pXZjEzMzBXd2RB?=
 =?utf-8?B?dEFvQ0tqQVYwWkhsTGwrbVdJZWlRc0EvUWRna2NYcWxXaWdjcXh5RU5KN0lG?=
 =?utf-8?B?emhnTUVodVVaY1oyUkIwaGgvaExEQWxOUUVLWHdnK0lSTW94MkZjZGp3WjR4?=
 =?utf-8?B?ZjRBZVdaelA2YmRVa3FsTlJCcVFkeTk4OUhZMWpoa2xEeHdUWWEzbkNiM1VV?=
 =?utf-8?B?SDBMSXRkTUlHN0Y4N0tiS29EdVdGRllISHlHSEJxMU9RZkl0TlNKUzVUcXhp?=
 =?utf-8?B?YlRoR3pWWldsSEFFSWx6WHVKbjhoMWR2ZTZkOFdBRklsWVV5bk9jZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17ba13b9-7420-42e5-7ce0-08de9102b0e7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 21:56:27.8428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V5x5kLjKu8bMpaLTL7kvog9r17X/BsfPZiLo7M5v98lOfDGqG0Ai82WN3cfU/tFjIyPwkixgu886sGjwlJgbiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7030

Hi Gary,

On 4/2/2026 11:24 AM, Gary Guo wrote:
> From: Gary Guo <gary@garyguo.net>
> 
> Currently, in the GSP->CPU messaging path, the current code misses a read
> barrier before data read. The barrier after read is updated to a DMA
> barrier (with release ordering desired), instead of the existing (Rust)
> SeqCst SMP barrier; the location of barrier is also moved to the beginning
> of function, because the barrier is needed to synchronizing between data
> and ring-buffer pointer, the RMW operation does not internally need a
> barrier (nor it has to be atomic, as CPU pointers are updated by CPU only).
> 
> In the CPU->GSP messaging path, the current code misses a write barrier
> after data write and before updating the CPU write pointer. Barrier is not
> needed before data write due to control dependency, this fact is documented
> explicitly. This could be replaced with an acquire barrier if needed.
> 
> Signed-off-by: Gary Guo <gary@garyguo.net>
> ---
>  drivers/gpu/nova-core/gsp/cmdq.rs | 19 +++++++++++++++++++
>  drivers/gpu/nova-core/gsp/fw.rs   | 12 ------------
>  2 files changed, 19 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
> index 2224896ccc89..7e4315b13984 100644
> --- a/drivers/gpu/nova-core/gsp/cmdq.rs
> +++ b/drivers/gpu/nova-core/gsp/cmdq.rs
> @@ -19,6 +19,12 @@
>      prelude::*,
>      sync::{
>          aref::ARef,
> +        barrier::{
> +            dma_mb,
> +            Read,
> +            Release,
> +            Write, //
> +        },
>          Mutex, //
>      },
>      time::Delta,
> @@ -258,6 +264,9 @@ fn new(dev: &device::Device<device::Bound>) -> Result<Self> {
>          let tx = self.cpu_write_ptr() as usize;
>          let rx = self.gsp_read_ptr() as usize;
>  
> +        // ORDERING: control dependency provides necessary LOAD->STORE ordering.
> +        // `dma_mb(Acquire)` may be used here if we don't want to rely on control dependency.

Just checking, does control dependency on CPU side really apply to ordering for
IO (what the device perceives?). IOW, the loads are stores might be ordered on
the CPU side, but the device might be seeing these operations out of order. If
that is the case, perhaps the control dependency comment is misleading.


> +
>          // SAFETY:
>          // - We will only access the driver-owned part of the shared memory.
>          // - Per the safety statement of the function, no concurrent access will be performed.
> @@ -311,6 +320,9 @@ fn driver_write_area_size(&self) -> usize {
>          let tx = self.gsp_write_ptr() as usize;
>          let rx = self.cpu_read_ptr() as usize;
>  
> +        // ORDERING: Ensure data load is ordered after load of GSP write pointer.
> +        dma_mb(Read);
> +

I suggest taking it on a case by case basis, and splitting the patch for each
case, for easier review. There are many patterns AFAICS, load-store, store-store
etc.

I do acknowledge the issue you find here though. thanks,

--
Joel Fernandes



>          // SAFETY:
>          // - We will only access the driver-owned part of the shared memory.
>          // - Per the safety statement of the function, no concurrent access will be performed.
> @@ -408,6 +420,10 @@ fn cpu_read_ptr(&self) -> u32 {
>  
>      // Informs the GSP that it can send `elem_count` new pages into the message queue.
>      fn advance_cpu_read_ptr(&mut self, elem_count: u32) {
> +        // ORDERING: Ensure read pointer is properly ordered.
> +        //
> +        dma_mb(Release);
> +
>          super::fw::gsp_mem::advance_cpu_read_ptr(&self.0, elem_count)
>      }
>  
> @@ -422,6 +438,9 @@ fn cpu_write_ptr(&self) -> u32 {
>  
>      // Informs the GSP that it can process `elem_count` new pages from the command queue.
>      fn advance_cpu_write_ptr(&mut self, elem_count: u32) {
> +        // ORDERING: Ensure all command data is visible before updateing ring buffer pointer.
> +        dma_mb(Write);
> +
>          super::fw::gsp_mem::advance_cpu_write_ptr(&self.0, elem_count)
>      }
>  }
> diff --git a/drivers/gpu/nova-core/gsp/fw.rs b/drivers/gpu/nova-core/gsp/fw.rs
> index 0c8a74f0e8ac..62c2cf1b030c 100644
> --- a/drivers/gpu/nova-core/gsp/fw.rs
> +++ b/drivers/gpu/nova-core/gsp/fw.rs
> @@ -42,11 +42,6 @@
>  
>  // TODO: Replace with `IoView` projections once available.
>  pub(super) mod gsp_mem {
> -    use core::sync::atomic::{
> -        fence,
> -        Ordering, //
> -    };
> -
>      use kernel::{
>          dma::Coherent,
>          dma_read,
> @@ -72,10 +67,6 @@ pub(in crate::gsp) fn cpu_read_ptr(qs: &Coherent<GspMem>) -> u32 {
>  
>      pub(in crate::gsp) fn advance_cpu_read_ptr(qs: &Coherent<GspMem>, count: u32) {
>          let rptr = cpu_read_ptr(qs).wrapping_add(count) % MSGQ_NUM_PAGES;
> -
> -        // Ensure read pointer is properly ordered.
> -        fence(Ordering::SeqCst);
> -
>          dma_write!(qs, .cpuq.rx.0.readPtr, rptr);
>      }
>  
> @@ -87,9 +78,6 @@ pub(in crate::gsp) fn advance_cpu_write_ptr(qs: &Coherent<GspMem>, count: u32) {
>          let wptr = cpu_write_ptr(qs).wrapping_add(count) % MSGQ_NUM_PAGES;
>  
>          dma_write!(qs, .cpuq.tx.0.writePtr, wptr);
> -
> -        // Ensure all command data is visible before triggering the GSP read.
> -        fence(Ordering::SeqCst);
>      }
>  }
>  

-- 
Joel Fernandes

