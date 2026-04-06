Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012059.outbound.protection.outlook.com [40.93.195.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D371F38D006;
	Mon,  6 Apr 2026 18:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775499547; cv=fail; b=Gn3Vr8DiHWAYbEu+C3YwcrgKl7MVTYe/2A4dFwq53AWHqdHPIoilkhjkAVmE+8tZWCB3Ym0LJU72WW7WM6u2KLVouzzSB4HTaItV5Fc9wyrTGozVgO5Lp8AufCuO13DPbAZ3WSrxGyZQIPlKNaWuH3kboLmxMiswlOsElM8fojE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775499547; c=relaxed/simple;
	bh=v/syFEIf0wzZCz0/csp2NndnMTRTKFkAPE6dTTxvp2c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U/p6MoFL5gZwGP+GiX5JMhFs3nXDhHg4yoS0DQDQUoYHpINeg6/Ye+rCiaFZe/cgilfjQZr0rP8VUlNkdU/w526AOmjRuVLnrkVC3w6DTR+65KQ3On9twkQA/J2m53BWUzY+wgLmeKWckLXrnnovoCprfgMFVlZu58CUB2mzVbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GFPqWeOM; arc=fail smtp.client-ip=40.93.195.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GFPqWeOM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fwRUzjrUt6QCEH0Tx3wSqdM/oDJ5M6VDra5HbBH1LrzX3JyJeTrWvp1AMvq82TRdJRsMZCinniZ57ejFDyi7guLK2Thy4IJnE2Lu1RtuRgyoCHmJ8p5NSkJNN5lV7UJo98xGqCJwBE9e5XxvFVP9pIohj0Y1958IYcFnp4sNzjPVh12cZLLQL54g1Ndhms1XZC5By/L9HDyRo2zKbWnb6QUzdNuwGly5dIdb65Iw3xi94ozLAban7PoMTGmxtQTfh/JMMmyaLkVtbdxoImX/dV/zmJNUmHATpzJ518M2LPQMjYCnHdjT8X2rLOm6bkvlUyp2X/6XrVfEf2HMeYuDTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dDkyTZl9Bxk+1ySeGeqSMsFEz7CiFBXaEyaI10rTR7s=;
 b=cZ7ngRNXguIaewxk7favP2XWFPyvdy9JMAN6qnRSOPxdkP+sRHgRqb7BeCLtWB2MbFwBmB71MtYEDrn0oVSicwXlSTX4Q95tTw/zzSiXTUCvg5uNzlOgGKHkhKr6+Lp4knwAfCTLaC+qRPCYJKl1oI+fMjJ0IaJfNokVOhWjl9I/xqlTbKmMt05HYAbdM7RUkQErCbOupxfXSB62Dn9Oh8bW6JIN/HFf9kbZ4u28SCzFS9La8jymK2eigliAURj6RpoPeIsIJB3u2+O18gLTg3OxEf9/MOETzhC0h0fD41kVHjF1zeajnnbQFUo3L5pLSDAdAKXC9Mi4km1oDzilGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dDkyTZl9Bxk+1ySeGeqSMsFEz7CiFBXaEyaI10rTR7s=;
 b=GFPqWeOMZXJXS0ajKu36T2zjRNKZToh5koe6Gra31L7MNA1OziCesi0ubTIgfjIyOvJV7wmVFmbCC1az+7ROY/r0NLT9sP01eI8S16kMm+IG6N5NN7qCgV/Wk16oZIHjbXL6qsrijVQ2KveueA2c3N75iVDlc5v2MEudw8RrIEE+d/5lbsTOKCyChGUY9+9k/2womfNocWyq35SqSMLM4haaPay6tAXN1ntOcl51/kOCXz3IvRAmHn1S5jKXPi0uvPrGvJr+8sy/09xUUsZGYchK42SluodaxoZEidEGlQseEawOBY0MwJFKFrDdYI60wBPmMq1Z1AkA7IOTMLdtzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 PH8PR12MB6843.namprd12.prod.outlook.com (2603:10b6:510:1ca::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Mon, 6 Apr
 2026 18:19:01 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9769.014; Mon, 6 Apr 2026
 18:19:01 +0000
Message-ID: <6f379804-f75f-4852-951b-1993bcc1728f@nvidia.com>
Date: Mon, 6 Apr 2026 14:18:59 -0400
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
 <dc9c3448-d82f-4cec-97f9-7ea3387d8296@nvidia.com>
 <DHKE2U46YAJE.3SSXBYRWRXH4C@garyguo.net>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <DHKE2U46YAJE.3SSXBYRWRXH4C@garyguo.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P223CA0041.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:5b6::12) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|PH8PR12MB6843:EE_
X-MS-Office365-Filtering-Correlation-Id: 85e3897a-0d64-4c26-6cb4-08de9408fa51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	n6BBHOPHUNwk3g4vkWGz9mjXZI08U+Ki6KFwUKRbiqEVBjvNXJPnb+1pg5JTud2ucxvgZ3V6DBlA/E9nW8oAT1NMYs3vcop6TQv5xVlc8z+jrNswvYKBD4p5g9qDJOYA9E//SoVyvqud35IPztprFqoQ94DkHaSDEnlEWhI3/66n74iJHtOfKKsnW6zLZpQCag3kEKjxlFMrQCySNgUsfaq1uxXwdBMfTrmawQX2Wx2zJI/U/oRgF6pSLMgjxel3VfgI9Sv4ct+vum5j+thb1XwQY6f4KXvWl0BPBphVv+BmMvwaNhNjjiJVsjsSDV6LwD2WmAO10TbVICCJO5vrCyAd+TbvgrD8AZ6vpFNNi81+o0GSSk/g1MjFLQk7oexs6bn0cVKBYVNPT32o/k68KBR0hMUElZbiaf4MHrl1LW3n2X+qP1Ti0rCMiW4+Ao9PWHpN4YRmijTgcMjozCHKdDNjzN5w1msGQQyywFx2pSU2RKlkvTVnJli7mF9yirEIsffiFrX3sifyyHo6pDR250NYogpspgg+F5vl9bzOqc/r2r5wME7+fWZ4TQtmSLpcSwrWOxyMgtHpmk3r8Eo9TCsi7HGtM+hSZRZ5zV9GlvNVouSXzHXq1tgkXpeo1bncaKHSgKWtG1/wYFm2MpqSms+3b3cEVjGrdjZcVsGgkrrgSlc6uOjxKBJqeGRCGaWScysQioMHVFTDKbi2jnaStq9eB3RfvgVHUsn7teQLBCTIgkT2MTC0sD6CxkanP269T+Luxo4J8dOv378fl9BdBw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TGlBSVJyeVFJeHZ0THY0UWd1a1Z4ZE5LUmxEV3NMSjRmUlk2MmpjZWxHOXQw?=
 =?utf-8?B?aERyOUkybmNJYzE1ekNoMHM1eXovalQ3c0sva096TFpkZ0Z5WDdDZ0QrWjRU?=
 =?utf-8?B?VG8rYm9ZSnBjZ1Buank4dHh2V2hIdis3cUZjUTJRZDVaQnB0eTNsRXh6QVhl?=
 =?utf-8?B?TUpneHVKM0RPMUxjMm81bmQwQUZzQXlhU3JxMXFxaENhRnFyUFA1V2NjbW1S?=
 =?utf-8?B?U3lRMVB6dmNobzRpemI1NXFzMTJ0QnlFSU41OWxmYnIwNWpqV2V5Tk9Yc2Ni?=
 =?utf-8?B?ZUlOcEFEOTFIOXplb3RYc3hFS3RmVXNsQWVIbnZLVGREeGJGcnNScWw0a2Vm?=
 =?utf-8?B?azVJU3FKT3phaHlSWUd1YUxraSt1K3g2SXQ0VDU5S0RhSmI0bC9qWXVUcm5N?=
 =?utf-8?B?aWRUcUFMZUp2azlaSUJOaitrOFVTcS9QcmdrNVNRRklUcXdQTG5SNnZ3MUd5?=
 =?utf-8?B?dzVlaUtWRkVJT1NYOHYxMkFDZzZHcE9JMjBiOGtsS2dnYjI2b2l2WHQ1eFhs?=
 =?utf-8?B?SFFnS2ZlaXJpeFVscVluN3VPelREbGl5Z3hiZytzZ21PTy9waEE5dDlWQWh0?=
 =?utf-8?B?aHltVjY1cVpneVlkdTlGSXVrTzVFV0xualhsNzFWazdnZ09nZmxvZmR5NVZZ?=
 =?utf-8?B?RldMUktEK1B1bnRhUFlOQjVWMFg0eUFrcVR0VDQrcFY2TjhvOHVIUDBMZGdZ?=
 =?utf-8?B?RVppYjFJZjF3NU5WemphazZXaXgxam5JTFYzaWMwVjhmK3FaZGhDbUlHK3lW?=
 =?utf-8?B?TCtiVmE3bWlWRmdxNHRBVDlSaDkyQ25PeGU4a1grVnd1Nzlnb1p6RkowY2Yr?=
 =?utf-8?B?TXl5QUJFOVJ3MUVFaUtmSlhxdEFDNGhENVV6eFBUU2xIRElvVlRiQzI5TElE?=
 =?utf-8?B?N1VNNHFuUTlaUWFyeWlPcUJVRGVTcXhRWlJPV2RpM2hudFpIRkgrVDIrY29N?=
 =?utf-8?B?QzJTTXdPcU5FemF6QUxBV2g3bnowVURGYURBcWZwT1BmZkQ1RTc1UjZ5TklY?=
 =?utf-8?B?YVJNT2tVN0h1YXVvMG4xZHNzZ2sxT3F2QlpuSktMekVFdHB1bVdXTTgrdUpJ?=
 =?utf-8?B?VmtlNHlCSmRHYWM0bHBsaGhTcndJR051THVyZUx0aUNFTUhlR2dwWXc4cEZZ?=
 =?utf-8?B?biticDZJc0x1TmFlU29naE1sYlhYUnVhVkExRlFiS2ttYzJ6Nm95bTYrZ24y?=
 =?utf-8?B?NlZNQ3RrNzF6R1VRSHIyUVNwYmJQOWJGNmlHN0NTWStDRCtRcVI3bTBlcEhC?=
 =?utf-8?B?WHZsbnhGU0dTWVpEL2lmR0YyTmxMWTFrUzhmVis3WnpPZmRSNmQvU1ZNQWpw?=
 =?utf-8?B?bW0wU2xuR2tKMWZYMC9nMDc5TlN3eDhmajhMWnZldFc2Ukc0S2U2OEQ5Y3gv?=
 =?utf-8?B?bXY1T1ZWVTFTelMxY0FLSWpISThlTXNHYnMwZ2hxdU82QmVQSWdpeWQwYWNC?=
 =?utf-8?B?VjJhOG5TSHZqQkk3TnNpamg4aFM4d2EwcjUxZUhIU1RGSW80alBnN3VhcHhS?=
 =?utf-8?B?VzBWZUdLeFMycUZmMmdOR0xQbTFUVVFHS29ZZ2RuUE9BOUgvcHg3eE1uSUFE?=
 =?utf-8?B?U3AwU3hGUWdBYmZBWWFFN0diRkQyeThJbXVYMFZ0SFhPUFRtb1R1ajBKaWVh?=
 =?utf-8?B?Zkd6YXdtclI4dTZmcmVkb3NGL1djMzdLN2owSDdKV1pzNFRMVTBNQ040MlBC?=
 =?utf-8?B?cDZqa2VEL2dqcDFwZjFxUXB0TXp5OXBrL0swMU44MnJiNWhkNWlZcEI5Z3pK?=
 =?utf-8?B?MEJLUGJpdlJKMzNCVXNLRFVERWk1b2hIeFV4cmhKbHgzM1BNeWhRVEtwckJO?=
 =?utf-8?B?eGNabGJXVGRzbFZJMmdscDcxa0JIUnRsWm0xUTRPajdiQzZHa2czN05YbW9R?=
 =?utf-8?B?R2hXVWxPOTBINmhyWWpudkhERk94S1Z2NXV0aUF6WU02T2wzWkx1L3BCVUNF?=
 =?utf-8?B?My9xd25NMjRvV3hLeGpJM25iQWw0STF4d1Q2a1VaNko0ZzVzaGRSaWZPOTJF?=
 =?utf-8?B?VFlLYm95ZForQS9FRThjNTNENmcxblpjazVYVlpVendjUHJKdHp1OUNuR2RW?=
 =?utf-8?B?SDZnajFtWmJzcWl5cUFQUUE1aU4vYzVva2w4bE0rWDVMU0I5K2hZd3JqZThN?=
 =?utf-8?B?c1FhdXVCUUNxWmVvWlFlZlcwYnY0ZXRENm5OWEUybmFoZnJlclFsQmRXUVd1?=
 =?utf-8?B?TzhIZlh6N1dENm1FVXN4QU12ZmxuaFVFWjltVzZCZXo5ZkFKV2hrQnhjMlN5?=
 =?utf-8?B?Mko4MjJWY2lQc29PNFY2TXpwYTNNTU9IdmErNmFPeGJTd0ZiTEtpV0xDbmMr?=
 =?utf-8?B?bFJEQ3FIN2c1RzNwVVYxSFNBVzJFM2FpalNLcGF0dXdNYWNYR0VEZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85e3897a-0d64-4c26-6cb4-08de9408fa51
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 18:19:01.5140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4CjHIFP51qpTzXqKPiZwpmdqohURewRoiT+2IMRiy1q0fkkpqRdHDAmSFC2I4DfD5B7eNIFcNCzcaAweo4B6Xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6843



On 4/4/2026 9:02 AM, Gary Guo wrote:
> On Thu Apr 2, 2026 at 10:56 PM BST, Joel Fernandes wrote:
>> Hi Gary,
>>
>> On 4/2/2026 11:24 AM, Gary Guo wrote:
>>> From: Gary Guo <gary@garyguo.net>
>>>
>>> Currently, in the GSP->CPU messaging path, the current code misses a read
>>> barrier before data read. The barrier after read is updated to a DMA
>>> barrier (with release ordering desired), instead of the existing (Rust)
>>> SeqCst SMP barrier; the location of barrier is also moved to the beginning
>>> of function, because the barrier is needed to synchronizing between data
>>> and ring-buffer pointer, the RMW operation does not internally need a
>>> barrier (nor it has to be atomic, as CPU pointers are updated by CPU only).
>>>
>>> In the CPU->GSP messaging path, the current code misses a write barrier
>>> after data write and before updating the CPU write pointer. Barrier is not
>>> needed before data write due to control dependency, this fact is documented
>>> explicitly. This could be replaced with an acquire barrier if needed.
>>>
>>> Signed-off-by: Gary Guo <gary@garyguo.net>
>>> ---
>>>  drivers/gpu/nova-core/gsp/cmdq.rs | 19 +++++++++++++++++++
>>>  drivers/gpu/nova-core/gsp/fw.rs   | 12 ------------
>>>  2 files changed, 19 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
>>> index 2224896ccc89..7e4315b13984 100644
>>> --- a/drivers/gpu/nova-core/gsp/cmdq.rs
>>> +++ b/drivers/gpu/nova-core/gsp/cmdq.rs
>>> @@ -19,6 +19,12 @@
>>>      prelude::*,
>>>      sync::{
>>>          aref::ARef,
>>> +        barrier::{
>>> +            dma_mb,
>>> +            Read,
>>> +            Release,
>>> +            Write, //
>>> +        },
>>>          Mutex, //
>>>      },
>>>      time::Delta,
>>> @@ -258,6 +264,9 @@ fn new(dev: &device::Device<device::Bound>) -> Result<Self> {
>>>          let tx = self.cpu_write_ptr() as usize;
>>>          let rx = self.gsp_read_ptr() as usize;
>>>  
>>> +        // ORDERING: control dependency provides necessary LOAD->STORE ordering.
>>> +        // `dma_mb(Acquire)` may be used here if we don't want to rely on control dependency.
>>
>> Just checking, does control dependency on CPU side really apply to ordering for
>> IO (what the device perceives?). IOW, the loads are stores might be ordered on
>> the CPU side, but the device might be seeing these operations out of order. If
>> that is the case, perhaps the control dependency comment is misleading.
> 
> Given that CPU cannot speculate store, I don't see how dependency ordering can
> be broken even if the other side is a bus-mastering device.
> 
> For this to be broken, the device would be able to see the dependency-ordered
> STORE to be propagated to it before it does it own STORE that propagates to the
> CPU to trigger the CPU STORE in the first place? That'll just break casuality.
> 
> I'll say that control dependency is sufficient here. I'm not worried that the
> compiler will break this particular control dependency given that if
> `gsp_read_ptr == cpu_write_ptr` will imply command allocation failure and this
> condition cannot possibly be optimized out by the compiler.
Yep, ok, fair enough.

thanks,

--
Joel Fernandes

