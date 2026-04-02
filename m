Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011037.outbound.protection.outlook.com [40.93.194.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1753783A0;
	Thu,  2 Apr 2026 21:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775167180; cv=fail; b=GPyc7Nq1xJiLiISr1U9NzSvhDUUnmYIIQlS4V1XMKwXe+zZKp4HwvOENHzPom7HV+JTHs+MON7hWxJIVA/n+2He1EhiSoBS1wZo1D2GpFlhcBVqCFCWyeRo3TCoYBgjgD2SwVzYYQWo4z/w7LmWe3N8MEqLiQTYNJ+Cym0jYLQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775167180; c=relaxed/simple;
	bh=nZdjAYfc/99RMcOE8LAp/kNaoDON9AR3CYJIjHk6sqc=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ue/JrhSg6VYf5fYLXpDVfNLzzvTzHPMt/tlTmFAbV7N18YZl8aObMgqb3rq2XDu6dCbucTwWjmShY7w1zVcj3CZe5WsWeTKgIDFCW3U5D5I3+Iz1e5IY810SX2YqaNuAgggTjq85+zuHGwdwCOMXRbI1UCfjrsiphDrrgv2Qwws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=l7oEl4F5; arc=fail smtp.client-ip=40.93.194.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="l7oEl4F5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zc/ewUHAKWEU5mXGoasltpe30VuCNn7rJk7COk09MCTFae8yeFV1Lw9n+XPJu8I1N457v63QMHR/vSTvOA1CWQBg/uNMono7K5BYaB/wnzenlg05uh4ZFc3hVHq9o/LzOGMd3I6G2MVdmbJot84e5+mai1k5knrteU+LQsselzrevYjTNb3hYpnSwhwgWeass6XVEEYCwaeOENwKyQiDVtcQ7RHGbA7SCaZ9Q+T1pGft9WVgffie7NuFpXI9ytQ9P2M4FmMaJrvQA42nSgmb0L4EftwdF8PqWpQ0fNAbZggh3iTU7pHslpjO5mRRIG4cL+pz9ghLR6CjIZH16W7uvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QYNNiUYlPGTJ1aTpjbFbGrazACCoO0swJzbLzdLx6Lo=;
 b=mBqAbWEAhEO982kM/suw9qLN1n5mEMYPCgT/g8/dU4aiuDGD4slAWtvZW2zkyULCHCDUeLEw/y4SxJG5UWtcf5nAdM8wTf5sJBTWbMFL03cmciy8prHKBbQMc8wbPrXCpDcw0BvmwKK5eCTGCj/t2TtAAIkXsgp8f4YKr2Ec7254nXTbL515e4dVglfFEUD4ObcFU216siPIyVj/xcNat5q/WqOCxKFvVw+jJkgRQG27FCAWVtsW68VbnhGCqA/kq+uEz/m9Y12FXPWcl8bBe5QVf64zkhZ8nMEFnnXQ8S4aur1JTTPVBACmVV7emv14XP6pqIt7zI+PGJ/sfYQTaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QYNNiUYlPGTJ1aTpjbFbGrazACCoO0swJzbLzdLx6Lo=;
 b=l7oEl4F5kFnNhFQsShzQ5S8qDzaCgzhZleLykC/ufUlr5iCmZ8V48AFdWrfh33qLtwLZeUz7CB0g9nu/axtduuDGKG3Cn9s8PdvvhiVuA+wip/Ujzv3V209k8hpr6E06taPgUk8g56fDm2i/IF3dbXHW5UHXsgtuYGA0KoRrhvZrl0DAB57M2pTKRKsx9ww/Qu+WhjEq+6Ftvfzuj0s/rk4Ei4ddpvLHvHQLQTY1p4FI5E7qGUvo1awybqvTPeVhFHfVXMpTHToTLGkjhVmT9w03h+HT0rGIeMia7gLrL2rzVEfkK08Sy+EsRDun+1IrJxBdxsqocASC7DfSiBMhlg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 MW4PR12MB7030.namprd12.prod.outlook.com (2603:10b6:303:20a::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17; Thu, 2 Apr 2026 21:59:34 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9769.014; Thu, 2 Apr 2026
 21:59:33 +0000
Message-ID: <5a2688ca-3cb5-4f64-a51a-8b65dcd3487f@nvidia.com>
Date: Thu, 2 Apr 2026 17:59:30 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] gpu: nova-core: fix wrong use of barriers in GSP code
From: Joel Fernandes <joelagnelf@nvidia.com>
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
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 lkmm@lists.linux.dev, dri-devel@lists.freedesktop.org,
 John Hubbard <jhubbard@nvidia.com>, Eliot Courtney <ecourtney@nvidia.com>,
 Alexandre Courbot <acourbot@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>
References: <20260402152443.1059634-2-gary@kernel.org>
 <20260402152443.1059634-5-gary@kernel.org>
 <dc9c3448-d82f-4cec-97f9-7ea3387d8296@nvidia.com>
Content-Language: en-US
In-Reply-To: <dc9c3448-d82f-4cec-97f9-7ea3387d8296@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: IA1P220CA0023.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:464::7) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|MW4PR12MB7030:EE_
X-MS-Office365-Filtering-Correlation-Id: 658600cd-21c1-49ca-2d37-08de91031f98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	xFzgkv9BqSi4v1Y1e23YdSlvIV+9JtHJUROJCPiF9dBe7+8ao53csxJCLIn2lVZNpsjeArDBfKo2GBYZmcm6LjbKXz89Zkb+GUIZ5fzS2TNox4qTTjU0nAnhH79LWyhgyY0Z1Aa2ueUHI7q9VCkxbCsoaOlww/+Yw2hIUKHseCZXK3xCRRxhXNHTcC45cO2N0PSX311Z5chtXR2BkgdSc8mhrGVF78nIPvGUUBqSdW0rTiWwfKjYq4oNEorm6ThHUNePV8DPF8dnF+Tg1MSlz0i7Y/9Ns1uLUmX+aFHYhF8rJ51JMg3VIhBfAhWJ6dVI2SjGK7UqPIhLWaS4KhTOP+k4OST7FFjUuSji7Gwe2fOvuEaR1RZjpRX+9+bcDRHsef5D+oy7O7v2NWPUjOI/i0VzkN5cYFQ6xEMIGs5Ou/3bxs4BYU5swE2E2kRSuxrzGSD30FvL+qVq1uNpCAJf/5O7ThMqyrDuKOGuBT2dsawt7zHEiIo5JGB1KL9H1zcwx9D9a5NfmvRFG9RNQf10QMPKy2qXdzGqURhKUZjR0DMbKfmK5qT02QBK0W/c6phTSsVCuVGEHyhwizy8Rz1DaqQeB7RsSS9Al6Lu2lYG3bG2RMTeXoPzHyxzz90cXQ+FvuNpwhPkA9rpt14Yrw+4CyhZzbEABhMQ7UNVGzSbdCCM43+NaWolYoFAm99EecmHhMyWoimro4NEXZVo2nMtaRGRL5+wKvnKyLtKYKU4gDhqY1BBM5jrznRVOOHT74UZLrJA3q+gD8pFtNF5CmBHHg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aHJjcHEwQlMyNFJ1V1BSc2tPcTZKSkx5bFZ2S0ZlZmMyTGkxYnRmN0ZoZmpY?=
 =?utf-8?B?QUdCa3VXeldwTmp0OUV6c3g3TlNETGVUcFpkS3d6cHlPMktTb3p5NEQrRVZw?=
 =?utf-8?B?YzVJZ2FrM252RXpka1JDaXRuUXpwZm50dkc5U1R3S21MS3NuMUtNNmpkTStL?=
 =?utf-8?B?bWFnQ0pVWlZZVENZd1UrMHdmZ1c3RHRGZzd0WHA2OC84T0JRRmpOcnM4c1VQ?=
 =?utf-8?B?Z1krMytPUFlUYXBIQkxQLzRJRVhBdmxnakpicWVZcS8rM2VFUGNkQlIxRFlF?=
 =?utf-8?B?NjRLZlNnSDIvUkRYVFJETFpOOFBha2hYams0MzR4SjZENWdoVFVSY1J5c1pI?=
 =?utf-8?B?RzE3MkY0UDN3T2xtb3pXV1A3T2tvYnVUMDF5ay9XbDJDNkwrdEtSZis2Y2Jv?=
 =?utf-8?B?TWZsc2N3R0dCalF5bmYvY2Vxa1NjQzNsNXhYL28rZ3lyYzhQUmpSYUVVOGlO?=
 =?utf-8?B?MllMd0dQS1NwV2lSS0hGc2wwQ1ZNR0FVVGpBQ01RNkNIdWZieDdJMjJvWjRu?=
 =?utf-8?B?bm9PMWw2UnJ0THpuaHdBcGxxZ1NuWjcxaEVzNE9EeENZZ3VKKzA4VzR0eUhk?=
 =?utf-8?B?dDY0eitEaEt6U2VEeDRrNjVSOFhOZ2tmU2dycXl4VThRNVVLdmJUWHdoeFBx?=
 =?utf-8?B?dWRsZHRTWS9mYzhWR0h0R2xRWk5qKzRwSFR3cEJNUlBBYitvZnpGT2p4S1My?=
 =?utf-8?B?dThWVWtmVTlpUlhCWXhzV0gyVkhzTXg5ZlRxNG15c3FyRjhKVm9BY1NNOFJa?=
 =?utf-8?B?c0VkTUI1UU5mR1VRTkxzL2xDa2VGMkdVaDlWZjZDc0M1V3o3VnYrcHpFM3pv?=
 =?utf-8?B?T3JkcUxabDNtUVZmYWZaRm9xVzNYdW90V2RjclFNMmhZejJ6ejk2enRDczEy?=
 =?utf-8?B?Y3VCaVgvOHUyU2J1Rm15WWtNU0xtRWxXa201OXlLODBIL2o0ek93L1dwQ05Y?=
 =?utf-8?B?QkxXendpS3pPT0hhZ3BWdmEwT0J4b0dtSjAyVjM1TTROL1RjcVR4dklMdWdZ?=
 =?utf-8?B?MnkreDhjUDJicUZWWjhuMWJzUDZ5empheEJsRG0zYjVpYzJ2Y3I5eUJHRUlB?=
 =?utf-8?B?cE11QjV6LzVhUzFTU0xWWjN1VmpNbmJlMHlqOGR4Zk9MSHd0M3c0RmtZU2JZ?=
 =?utf-8?B?bzdGbjhGNlZReDRqVTVQaFpGd0loMmZhQnhZSmlrMXZCSTdwc25VKzBtRFZ3?=
 =?utf-8?B?Q3JtMFhGMUs1ZTlWWlhMcE9NNW9rbXVzNjdYU3dRQ3VaTElzV25sK1BIMTll?=
 =?utf-8?B?MUJMeTFkOHlENE1nb2RNc3NmQ3ptbnJyZlJyMzBoSFNNTk51d1h2d1dNZ2tk?=
 =?utf-8?B?akUwUnpQd1RXdUlkRFRoWmJmRjhLdDZpZTV4MlJlblVrc01BOE5jUkFpTlBs?=
 =?utf-8?B?YzQ4QWVMOTNhZmgwUi9ucyt4TmFYV1ZTODMyaUZnZldEOVkzVTUzKzdXS1Zq?=
 =?utf-8?B?UjVVa2ZVQ3FIeVNxL0l3SUluMHdMWkhUUThiTW8wRG1rN3lYMWJqWU9VTTFB?=
 =?utf-8?B?Q1MxaEc2c0pXN2sxSzhCUWRkVlNjaWRKbm9tTkpEZ25tUzRUUDlpeWpWb3Yy?=
 =?utf-8?B?SDNMeXhrcGdKTGVmZGdtU29IQmJQOUJieks0THVrdjJ4U1AvYmc1NVJvamxV?=
 =?utf-8?B?dGsrK05CVEZTWnMzZjBKcVR2VnE5bVFnZWlnWjlDMnJHZlhpMHQ1MWFQNzRJ?=
 =?utf-8?B?TERJcHRzd2tzcTZ0aWx0U0xkZmFrL3RpNDVadDVyYjJkaXhsa1lyREJocW1p?=
 =?utf-8?B?eUVlMmJPSGpjMXhBUGU3b0lRMkxmZndTMnRGcEdhMC90NVRYUEdnWGJXM2Fa?=
 =?utf-8?B?bDFOdEZjSmxyQ2ZWQ0ExblUwZnpIb3YzZEp6MHZRQlZDcStvUmxTSTlqSHVV?=
 =?utf-8?B?SER1cytESWE4eDVwN1dHMlpCSy9zZHh5K0p6cDZSZWpLbXkrQU9HS0NpcWdB?=
 =?utf-8?B?ckFVekVXTlZzTDlpbzZGbXJOUFJDR3U4Z1VDRmVQV21vTzhaeE5CSDlCdE92?=
 =?utf-8?B?enBma0JsQm0yaGltQklkbCtWZmtDdEd4c3hTeHJyOFJYaUViTW9VWEw1T2Zt?=
 =?utf-8?B?b1lMTW9hUTg5a3JFUzJFVEEvQ1phVlBBWWppSGw3eWNzM2VHTWxuNzlZcGZ5?=
 =?utf-8?B?aVpXQWJYVUJXVldMdlpOZFp6Q1NwZ0RvR203enYwM0orbU1tbDhKSzJSaEl2?=
 =?utf-8?B?TFNIVUdUaHIwc0VBZHZlbGZ2d0luRGorMmRHMndka09ySjFmQXRzbUkrVmZU?=
 =?utf-8?B?OFRsWE0yQnE0RllLV2pvYWsydENNdHlpV0tGMWdFSmEwOFlVU2xNNzhDY2F0?=
 =?utf-8?B?T3V6WXlYK0pnMm5lNlZ0YXhIYXVTTUpJTEJtOXA5U3RUTlhxR3d5dz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 658600cd-21c1-49ca-2d37-08de91031f98
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 21:59:33.8231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wzd6C6BhGu8tddfETwKf2ilJm6r6skLHvwQr5UNAg8VPmk7h4xHeP7t0UyNb+xyrJJmvPA/wnTpWFx05OVbYQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7030

Btw, nouveau@ list has issues at the moment, I suggest CC Nvidia nova folks
directly. Adding some ++ and dropping Nouveau. In case my reply didn't make it,
it is below.

On 4/2/2026 5:56 PM, Joel Fernandes wrote:
> Hi Gary,
> 
> On 4/2/2026 11:24 AM, Gary Guo wrote:
>> From: Gary Guo <gary@garyguo.net>
>>
>> Currently, in the GSP->CPU messaging path, the current code misses a read
>> barrier before data read. The barrier after read is updated to a DMA
>> barrier (with release ordering desired), instead of the existing (Rust)
>> SeqCst SMP barrier; the location of barrier is also moved to the beginning
>> of function, because the barrier is needed to synchronizing between data
>> and ring-buffer pointer, the RMW operation does not internally need a
>> barrier (nor it has to be atomic, as CPU pointers are updated by CPU only).
>>
>> In the CPU->GSP messaging path, the current code misses a write barrier
>> after data write and before updating the CPU write pointer. Barrier is not
>> needed before data write due to control dependency, this fact is documented
>> explicitly. This could be replaced with an acquire barrier if needed.
>>
>> Signed-off-by: Gary Guo <gary@garyguo.net>
>> ---
>>  drivers/gpu/nova-core/gsp/cmdq.rs | 19 +++++++++++++++++++
>>  drivers/gpu/nova-core/gsp/fw.rs   | 12 ------------
>>  2 files changed, 19 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
>> index 2224896ccc89..7e4315b13984 100644
>> --- a/drivers/gpu/nova-core/gsp/cmdq.rs
>> +++ b/drivers/gpu/nova-core/gsp/cmdq.rs
>> @@ -19,6 +19,12 @@
>>      prelude::*,
>>      sync::{
>>          aref::ARef,
>> +        barrier::{
>> +            dma_mb,
>> +            Read,
>> +            Release,
>> +            Write, //
>> +        },
>>          Mutex, //
>>      },
>>      time::Delta,
>> @@ -258,6 +264,9 @@ fn new(dev: &device::Device<device::Bound>) -> Result<Self> {
>>          let tx = self.cpu_write_ptr() as usize;
>>          let rx = self.gsp_read_ptr() as usize;
>>  
>> +        // ORDERING: control dependency provides necessary LOAD->STORE ordering.
>> +        // `dma_mb(Acquire)` may be used here if we don't want to rely on control dependency.
> 
> Just checking, does control dependency on CPU side really apply to ordering for
> IO (what the device perceives?). IOW, the loads are stores might be ordered on
> the CPU side, but the device might be seeing these operations out of order. If
> that is the case, perhaps the control dependency comment is misleading.
> 
> 
>> +
>>          // SAFETY:
>>          // - We will only access the driver-owned part of the shared memory.
>>          // - Per the safety statement of the function, no concurrent access will be performed.
>> @@ -311,6 +320,9 @@ fn driver_write_area_size(&self) -> usize {
>>          let tx = self.gsp_write_ptr() as usize;
>>          let rx = self.cpu_read_ptr() as usize;
>>  
>> +        // ORDERING: Ensure data load is ordered after load of GSP write pointer.
>> +        dma_mb(Read);
>> +
> 
> I suggest taking it on a case by case basis, and splitting the patch for each
> case, for easier review. There are many patterns AFAICS, load-store, store-store
> etc.
> 
> I do acknowledge the issue you find here though. thanks,
> 
> --
> Joel Fernandes
> 
> 
> 
>>          // SAFETY:
>>          // - We will only access the driver-owned part of the shared memory.
>>          // - Per the safety statement of the function, no concurrent access will be performed.
>> @@ -408,6 +420,10 @@ fn cpu_read_ptr(&self) -> u32 {
>>  
>>      // Informs the GSP that it can send `elem_count` new pages into the message queue.
>>      fn advance_cpu_read_ptr(&mut self, elem_count: u32) {
>> +        // ORDERING: Ensure read pointer is properly ordered.
>> +        //
>> +        dma_mb(Release);
>> +
>>          super::fw::gsp_mem::advance_cpu_read_ptr(&self.0, elem_count)
>>      }
>>  
>> @@ -422,6 +438,9 @@ fn cpu_write_ptr(&self) -> u32 {
>>  
>>      // Informs the GSP that it can process `elem_count` new pages from the command queue.
>>      fn advance_cpu_write_ptr(&mut self, elem_count: u32) {
>> +        // ORDERING: Ensure all command data is visible before updateing ring buffer pointer.
>> +        dma_mb(Write);
>> +
>>          super::fw::gsp_mem::advance_cpu_write_ptr(&self.0, elem_count)
>>      }
>>  }
>> diff --git a/drivers/gpu/nova-core/gsp/fw.rs b/drivers/gpu/nova-core/gsp/fw.rs
>> index 0c8a74f0e8ac..62c2cf1b030c 100644
>> --- a/drivers/gpu/nova-core/gsp/fw.rs
>> +++ b/drivers/gpu/nova-core/gsp/fw.rs
>> @@ -42,11 +42,6 @@
>>  
>>  // TODO: Replace with `IoView` projections once available.
>>  pub(super) mod gsp_mem {
>> -    use core::sync::atomic::{
>> -        fence,
>> -        Ordering, //
>> -    };
>> -
>>      use kernel::{
>>          dma::Coherent,
>>          dma_read,
>> @@ -72,10 +67,6 @@ pub(in crate::gsp) fn cpu_read_ptr(qs: &Coherent<GspMem>) -> u32 {
>>  
>>      pub(in crate::gsp) fn advance_cpu_read_ptr(qs: &Coherent<GspMem>, count: u32) {
>>          let rptr = cpu_read_ptr(qs).wrapping_add(count) % MSGQ_NUM_PAGES;
>> -
>> -        // Ensure read pointer is properly ordered.
>> -        fence(Ordering::SeqCst);
>> -
>>          dma_write!(qs, .cpuq.rx.0.readPtr, rptr);
>>      }
>>  
>> @@ -87,9 +78,6 @@ pub(in crate::gsp) fn advance_cpu_write_ptr(qs: &Coherent<GspMem>, count: u32) {
>>          let wptr = cpu_write_ptr(qs).wrapping_add(count) % MSGQ_NUM_PAGES;
>>  
>>          dma_write!(qs, .cpuq.tx.0.writePtr, wptr);
>> -
>> -        // Ensure all command data is visible before triggering the GSP read.
>> -        fence(Ordering::SeqCst);
>>      }
>>  }
>>  
> 

-- 
Joel Fernandes

