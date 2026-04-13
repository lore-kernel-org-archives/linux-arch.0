Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020072.outbound.protection.outlook.com [52.101.195.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34453BE17D;
	Mon, 13 Apr 2026 11:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776078809; cv=fail; b=Ei4wpq8LV2xu8LNpkxrvQoFXaTJsFradhWF4h7aQBG0jwP0XH9XIREQKQ42qQXIVMvrKnMS3ES4d+4RgHqKiXyeCnQAmvXdqc6EjlaJhxokSEPINn9tji14EryP4ui2eWLr6lA856RNPb4H4xfW0SuJrU3LN/f7IYcmrp4jJo0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776078809; c=relaxed/simple;
	bh=XRNlOC1pVR0rjIXlUow1z0Ds4Af3dF7hc9fqbt7HBqo=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:MIME-Version; b=sWdeFjWbh5VJ5Zl/UxjTts13UTo0ZgfKK5T41PItPwXdE9L5BueCLQ2CKE18CrtN5XIZR/1IdlSziPWCoN3M/cA5Fnh4shFeyGoXZDN8XRBCbtno0egHHNhaJDiDJrfn4/gI9Rh8/riaKmtCvqKGj/PPvqAFAAVOxKfxXBQT60U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=DcxXu5nz; arc=fail smtp.client-ip=52.101.195.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="DcxXu5nz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WLP/UB3FiDbQee8J9KEaIwxPCEgkG6/3gb2dlHshRTCm4Izm8k02uqF2drCJP+4yJ8ciDLvbR+hIuXytkujnc1/WBqskaBmkb+aYPYXTWftMWVm9q2Ll3nzvSLnSBMOmbkMVBPnc35W/f7M+jBjn6yKQtuhjJj/tMIxfzhoAWB1MR9ilh68XWiJuJJBZXzplbP0V053EGfRv24dHpRhf8BN76wgBO+0ccs/XErvmar6U24JDnuSo/8ayulhONuyaPy+4/urfzgWnN8AJrlxXar/VQqR7g8q46fD3nbgHXg8/bDl4ejGXBKqcUAD8JqGwLXGwrNZtpMHou0bGQlkILg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/hc48p/qKe6sFcD+IYjtEwCgqfqKFxn/VpVbXiSjbB0=;
 b=VZy1ag360kOazhOMMSPcWtd9CD2TmTUIG5xzLiBxKc3jHvtU4CUBU+ZuWd7Gz4sIBVUt0lSEPkcfkIm8+dZDe8SLVyBkxbXh6ii+HD2t7ZQeoZUR8Bjl4Ii+tAZsnd5VcUlKLieypXJqScrYsdOFb3fNJW7W529TOFl6eZvZdG3amuJPxpYvnqaBc38DY+WWZa91f0BKLDM8PhaPMAm6JOVcxBtLqjUdaSPvjsClZxLKZTFwPPlPpHwXTv6QLOT7aR1otte5hbY2hS17CPFWRjQXpoBJ5xN2pK9MCYtdsg6TK66/9tE8sX/JbZgqzDO7NA1+lv+8lYDwbfExXLdzPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/hc48p/qKe6sFcD+IYjtEwCgqfqKFxn/VpVbXiSjbB0=;
 b=DcxXu5nzTlte478MpQk8dx3SxXfCF+jTooLXoEEaqA47eI9QiOMk+TyCA645CtUDZfR8Dk8FzUxyKsMnOSPGUcr5IE4/UHo2PFzUOToe6zCiVl3YdFmqkjUa3Uwndw0wp17UOVZtT/v2betcfeAaScAWZMzYxjwtkdZkn2Dgcwg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWLP265MB2081.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:60::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 11:13:22 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.20.9769.046; Mon, 13 Apr 2026
 11:13:21 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 13 Apr 2026 12:13:21 +0100
Message-Id: <DHRZE1B9D8M8.3G97DOTB881RR@garyguo.net>
To: "Eliot Courtney" <ecourtney@nvidia.com>, "Gary Guo" <gary@garyguo.net>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>
Cc: "Alan Stern" <stern@rowland.harvard.edu>, "Andrea Parri"
 <parri.andrea@gmail.com>, "Will Deacon" <will@kernel.org>, "Peter Zijlstra"
 <peterz@infradead.org>, "Nicholas Piggin" <npiggin@gmail.com>, "David
 Howells" <dhowells@redhat.com>, "Jade Alglave" <j.alglave@ucl.ac.uk>, "Luc
 Maranget" <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@kernel.org>,
 "Akira Yokosawa" <akiyks@gmail.com>, "Daniel Lustig" <dlustig@nvidia.com>,
 "Joel Fernandes" <joelagnelf@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <nouveau@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <linux-arch@vger.kernel.org>, <lkmm@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH 3/3] gpu: nova-core: fix wrong use of barriers in GSP
 code
From: "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260402152443.1059634-2-gary@kernel.org>
 <20260402152443.1059634-5-gary@kernel.org>
 <DHRS5I7ZTI01.27WY0OTHA7ZMQ@nvidia.com>
In-Reply-To: <DHRS5I7ZTI01.27WY0OTHA7ZMQ@nvidia.com>
X-ClientProxiedBy: LO2P265CA0072.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::36) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWLP265MB2081:EE_
X-MS-Office365-Filtering-Correlation-Id: 34945224-0e43-42b3-5e61-08de994dac68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|10070799003|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	LX+uHc3JSQqT9e1aRFYVnsiKhb+lyWXbgGQ6ZbkmAXLNef1kBvOaH4aEceTzBG2YjdlfQ8I8zGuK/hOYVmCXZ9mmEu5jmhg3fN6LT84f0nDFyYUkSdeJnzP58nF5tDnvXvzPeReh6HOfDRyMm0QTR3u3/4t3dNq3eYTHM7Lj9gddqys9DQ63kah+zT29wiCEAocdTYQD/D6Cpe8fcic9bgrpOCGEmo607N6lRhITgSPyqOYTuBU1ei+8ZpV0NWO5uMi5BmAuJlB19ruiTnIPg3OI23q7or+J6cKi12Yc+n8xED5TU07h+WKAqHsBDMXvygESqn7bGtpNoQGDVZIr4/Qa9vQc5BbidNaMDXTUJEEijTfYlEX6AmxgTpxn+OOvWPnCij8EppP5cZ4pCB5RKhqGrC8fofWYt90KE+Y0NIIMqD2p7E2oGPlAqvT6r7BL5vKjnIPMSFPoH5q6RSfbaRkLgSSfdQZw94kplZYj4KwyeqL4JHJ1UfHLU/h+CENAww5061EicxXzo8zI5kozNCz2/eiESZva9LUu+pwhyjjDhebydrPEiZ3AAhniU8oh3JVeTDjWrb9BRDDm+d9JQ4MKJjv1nhEtRBkUZG/Yv7fcGKez2YGXwsDXwz9c1+uBgJpPy1ifVXauYs1Xj4FtbWVoMYxWMG8fAFKsGBcmQX9tXlhTf9XGVKZEiBm6vD3xG7iPuxX2Y/JUg2yuONlxrvRV/jRtzssQlyZTdiyLbDXVI7kXJmlnCCFurZfGANJzvOUn8jFVu7TdaS2G3rmTFA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(10070799003)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cU1KZk1SWkVBSVE4R0lPbk1EdlBsUEh3UHprUkxETUVhU1cyK0xzcXg0dERS?=
 =?utf-8?B?V25oakpHNUk5eXNIaGRDM00yTDdWNW5QSDJqZ3dNMHdyYnZtV3hhZ3Y4bkVG?=
 =?utf-8?B?RHNyVThpbGZ2aHpld0kyMWd0M2Y0UUR3ZVlWN1NWMy9LTEpaMU1rWXZrMnhM?=
 =?utf-8?B?TU45anpPR3JVNFVFTDRFQ3J1cUlZN3o4K0NxUzhTdVFpdDBzUTd6dHMvYlpZ?=
 =?utf-8?B?d3FMU2VpV0lPU1Q5M3VTN3hvUUIzS3E4MWFSOVg4UzZ2cWxIVytvSFZPQk9a?=
 =?utf-8?B?VjNiMXZ2WVpEcmNnQzAxL08yOVJ2cEZDbFNEVUJiMDBBcXY3ejNqd3FFRGtp?=
 =?utf-8?B?SzFBTUtyWFRna3pjZjJ2RUJPUWF3TEhSYlM0VXJYb21SRHVnbytWMTVFbmdG?=
 =?utf-8?B?L0dOMW9CMHBwZzA5ZFl5QXA3OStVMlI5RU1KbnBDa1o5aGEyMHpTUGR3SW9Q?=
 =?utf-8?B?S3J4cXpyZVpYU0JPb2tndjNmNXFKWms3VWNuTGJmVUtoSE1ZNGdhTExsNEN6?=
 =?utf-8?B?dEU3TEhKMHJFNWFrU1dYQ0c4VnJsWGx1V2VpUzhzZGxRQjN5Rnd4VUoxOVVY?=
 =?utf-8?B?Um84N0VtMWpUS3A4UFhQRUU4V1FUdGVycXN5RlNQVUdMQlhLTUsyUkw5QTVx?=
 =?utf-8?B?Z1V5M1ZjRHQ4S0UyR1cyVGhQSlhSUjlZVm5zRHlNUTlrTmtMZ2pLWVN5dEZ5?=
 =?utf-8?B?eGtlUlRGcnJtRG5PUVVtcis2SnNpYU5nK1FjMkZSbEZWbUxhVXFJTHBzcjNP?=
 =?utf-8?B?ZThEQ1pJYmFObmpJMjd2Qk9mdGYxWW1LWFpIc1FLc0lIajdaYnc5a3RLRXZM?=
 =?utf-8?B?dXJ4Y3R5L1FJcDhOTmlMV1RXdU81TlNMSUJTSGZhaU8yZ0VPWnY4VUhBM1Rp?=
 =?utf-8?B?dm44M0dkeWxsaXJQMHN3SWc1eVBhU3I4N3NoeVhTMHJzTnNZZDZMNFEyb3Nx?=
 =?utf-8?B?a1VxcXlXTnhPUGI1SFM4SnNIRENReDlvNXpZTUVvYXdmZURrRU1ydW9VZmUv?=
 =?utf-8?B?ajZpQ1NROFBFV2VtcVFLaGJXdlFxdkkwbnNjZjg2OHhDVTBHVmVzOU8rSUYx?=
 =?utf-8?B?cGMzUXN2Y3JFbFhhRndPdi85dVRYMWRkN2g3aDNmZ1lNdDQ1cEJVelpiNW1E?=
 =?utf-8?B?MHRFNEQ3K1BoUzBTZ29VZ3h3cm1tVlRjVk5hYnRpUURJckEra2g4c0F5N1JT?=
 =?utf-8?B?Qm1GZ0MzVnhhRTRaQ2JtNFcyeEFTSW1MT2MyRDlpQ3g0QjNzL2tJOGFWeHlt?=
 =?utf-8?B?eTFJM3lQWnh0TFE1c3QyU1Z5QnhDLzNMeEZiTmQwUXdTMG1JZWRhNE40SWhn?=
 =?utf-8?B?RjVzL29CaWUyaXAwWjFmWXA5bUNWeTFsY0VvUDVkZzREUkZkUFB6OXJzeUtv?=
 =?utf-8?B?dkM3dGl2V2ZMNzFudGpab0VnbjBSNTJTelNlWDNSZjZJdmpQQmZUZ1FCQ2ZZ?=
 =?utf-8?B?RGxhL1dMS05qMmpnajloQ3lkRTRFQUlYZWVnYkxiaU8rdnJIbk1QOGpISU1y?=
 =?utf-8?B?TFhwbHhqRVVEQjBtRnFwc2xKamExQW9xWlc5S25SZGJzMWdxNGJoQ2M1eTA0?=
 =?utf-8?B?dGwzY2dpNGdwa2VoM2hsdFdibFBrbHlEUStmc1lyTS9kNjA4K1RwN0JjOXFl?=
 =?utf-8?B?VjNzS3RlMVY2ckd6bW9qa2VaSm9uT25GZlJSMTFNYzNReUloS0NKYjRsK2hF?=
 =?utf-8?B?SHlBUlBReFJpeWprbmg0WUdnWVZEeDlTbC9BVmlYMWNnWE9TWmgyYnVOTnFm?=
 =?utf-8?B?L2hvcW9nNGJiVVNPejFNdDZFSFVNVENaK28vdmJ1cVJXNm1kVHJuS2t1Sm5x?=
 =?utf-8?B?NDNTMHJBdlhIY0ltWWM2TkVMTFdSQ1llNmVtN1RqWWlmOTdMbGhDb0Z0eTQ1?=
 =?utf-8?B?angwTy9MTnkzV3c2M24zekMzTGJaQ3ZkcUpodXUzV0RHUThOUmVpbFc0U1FR?=
 =?utf-8?B?bkkreStUTFlmdm5sN2hNTjQrVHRxTWRVZ1I3c2t3L0MrVUQwdklkSFBHWSt4?=
 =?utf-8?B?NGlHZFY0MVV6UlpQVWdtTlNVcGJIMUFtVThmK3p4QmFDNHhaNkZsMmY1L2xm?=
 =?utf-8?B?OEFXeG5vU2p4QmFBVUdrYW9nTmFVZGxOWEU0WjVDT3ZyNjVxdzhkbERlemJW?=
 =?utf-8?B?cDRRSk5xRFZML1JWQ3EwWVlsendoNWdjM3RzWXJNaTlRL2JVdWFHcWZuY3Av?=
 =?utf-8?B?UjRVRnkzeThuOEZ3QjRoSUthY1ErWHhEVUhvd3A3S29FS2FkTXlkdmlpRmZ1?=
 =?utf-8?B?UlBzdmppSktHeUoxdFZrMWJFbmlIcGs1aWlSa2VEaXJLTTRnUWNJVzlRYnk4?=
 =?utf-8?B?RXNkMG8vVU1mbGQySEFyRWdMVFJ1Y2J6elpXM2FLa1FWek0rWVV0QT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 34945224-0e43-42b3-5e61-08de994dac68
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 11:13:21.8284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t7lBuedKy6N/WQGdg5MeyL12zx8q3b/gcVmTPz9nVCJXu3JRUluBeXbpe45oOSK1U4EYtYegRCTIZhduLg+pDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB2081

On Mon Apr 13, 2026 at 6:33 AM BST, Eliot Courtney wrote:
> On Fri Apr 3, 2026 at 12:24 AM JST, Gary Guo wrote:
>> From: Gary Guo <gary@garyguo.net>
>>
>> Currently, in the GSP->CPU messaging path, the current code misses a rea=
d
>> barrier before data read. The barrier after read is updated to a DMA
>> barrier (with release ordering desired), instead of the existing (Rust)
>> SeqCst SMP barrier; the location of barrier is also moved to the beginni=
ng
>> of function, because the barrier is needed to synchronizing between data
>> and ring-buffer pointer, the RMW operation does not internally need a
>> barrier (nor it has to be atomic, as CPU pointers are updated by CPU onl=
y).
>>
>> In the CPU->GSP messaging path, the current code misses a write barrier
>> after data write and before updating the CPU write pointer. Barrier is n=
ot
>> needed before data write due to control dependency, this fact is documen=
ted
>> explicitly. This could be replaced with an acquire barrier if needed.
>>
>> Signed-off-by: Gary Guo <gary@garyguo.net>
>
> nit: should this have
> Fixes: 75f6b1de8133 ("gpu: nova-core: gsp: Add GSP command queue bindings=
 and handling")
>
> ?
>
>> ---
>>  drivers/gpu/nova-core/gsp/cmdq.rs | 19 +++++++++++++++++++
>>  drivers/gpu/nova-core/gsp/fw.rs   | 12 ------------
>>  2 files changed, 19 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/g=
sp/cmdq.rs
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
>> @@ -258,6 +264,9 @@ fn new(dev: &device::Device<device::Bound>) -> Resul=
t<Self> {
>>          let tx =3D self.cpu_write_ptr() as usize;
>>          let rx =3D self.gsp_read_ptr() as usize;
>> =20
>> +        // ORDERING: control dependency provides necessary LOAD->STORE =
ordering.
>> +        // `dma_mb(Acquire)` may be used here if we don't want to rely =
on control dependency.
>> +
>>          // SAFETY:
>>          // - We will only access the driver-owned part of the shared me=
mory.
>>          // - Per the safety statement of the function, no concurrent ac=
cess will be performed.
>> @@ -311,6 +320,9 @@ fn driver_write_area_size(&self) -> usize {
>>          let tx =3D self.gsp_write_ptr() as usize;
>>          let rx =3D self.cpu_read_ptr() as usize;
>> =20
>> +        // ORDERING: Ensure data load is ordered after load of GSP writ=
e pointer.
>> +        dma_mb(Read);
>> +
>>          // SAFETY:
>>          // - We will only access the driver-owned part of the shared me=
mory.
>>          // - Per the safety statement of the function, no concurrent ac=
cess will be performed.
>> @@ -408,6 +420,10 @@ fn cpu_read_ptr(&self) -> u32 {
>> =20
>>      // Informs the GSP that it can send `elem_count` new pages into the=
 message queue.
>>      fn advance_cpu_read_ptr(&mut self, elem_count: u32) {
>> +        // ORDERING: Ensure read pointer is properly ordered.
>
> What about a more specific comment that describes exactly what is
> ordered, e.g. something like:
> Ensure all reads of message data by the CPU have completed before writing
> the updated read pointer to the GSP, since it may overwrite that data.
>
> Maybe this is just me but it's a lot easier for me to think of the
> orderings as a pair of (load? store? -> load? store?) which works for
> everything hw actually supports except for ll+ls+ss, rather than mapping
> 'Release' to (load+store -> store) in my head. e.g. here IIUC we need to
> make sure all loads by the CPU are done before we do the store for the
> pointer, so we need to make sure loads don't cross ahead of this
> barrier but also that stores don't cross behind it, so (load -> store)
> should be sufficient? So, depending on what you want to do with the
> memory model, this could be tightened IMO. Unlike the one below that
> only needs to order stores with eachother (ss).

The pair of `(access, access)` is actually the first iteration of the API t=
hat I've designed.
You can see it implemented here: https://github.com/nbdd0121/lkmm-rs/blob/t=
runk/src/lib.rs
A good thing is that it maps nicely to loongarch and RISC-V. A bad thing is=
 that
it misses ll+ls+ss as you pointed out.

However, I think the more tricky part of this approach is now the semantics=
 is
harder to fit into LKMM; it is now became 9 types of barrier that we need t=
o
reason about, and that's a huge addition. I am not sure it is even feasible=
 to
implement, given the KCSAN only have 5 types of barriers that it could enco=
de
about.

On the other hand, acquire/barriers are much easier to reason about (and th=
ey
already exist in C11/Rust memory models), and KCSAN already implements mark=
ed
release accesses as ONCE + release barrier (with acquire accesses being
implicit), so it probably doesn't even need changing.

Best,
Gary

>
>> +        //
>
> nit: stray //
>
>> +        dma_mb(Release);
>> +
>>          super::fw::gsp_mem::advance_cpu_read_ptr(&self.0, elem_count)
>>      }
>> =20
>> @@ -422,6 +438,9 @@ fn cpu_write_ptr(&self) -> u32 {
>> =20
>>      // Informs the GSP that it can process `elem_count` new pages from =
the command queue.
>>      fn advance_cpu_write_ptr(&mut self, elem_count: u32) {
>> +        // ORDERING: Ensure all command data is visible before updatein=
g ring buffer pointer.
>> +        dma_mb(Write);
>> +
>>          super::fw::gsp_mem::advance_cpu_write_ptr(&self.0, elem_count)
>>      }
>>  }
>> diff --git a/drivers/gpu/nova-core/gsp/fw.rs b/drivers/gpu/nova-core/gsp=
/fw.rs
>> index 0c8a74f0e8ac..62c2cf1b030c 100644
>> --- a/drivers/gpu/nova-core/gsp/fw.rs
>> +++ b/drivers/gpu/nova-core/gsp/fw.rs
>> @@ -42,11 +42,6 @@
>> =20
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
>> @@ -72,10 +67,6 @@ pub(in crate::gsp) fn cpu_read_ptr(qs: &Coherent<GspM=
em>) -> u32 {
>> =20
>>      pub(in crate::gsp) fn advance_cpu_read_ptr(qs: &Coherent<GspMem>, c=
ount: u32) {
>>          let rptr =3D cpu_read_ptr(qs).wrapping_add(count) % MSGQ_NUM_PA=
GES;
>> -
>> -        // Ensure read pointer is properly ordered.
>> -        fence(Ordering::SeqCst);
>> -
>>          dma_write!(qs, .cpuq.rx.0.readPtr, rptr);
>>      }
>> =20
>> @@ -87,9 +78,6 @@ pub(in crate::gsp) fn advance_cpu_write_ptr(qs: &Coher=
ent<GspMem>, count: u32) {
>>          let wptr =3D cpu_write_ptr(qs).wrapping_add(count) % MSGQ_NUM_P=
AGES;
>> =20
>>          dma_write!(qs, .cpuq.tx.0.writePtr, wptr);
>> -
>> -        // Ensure all command data is visible before triggering the GSP=
 read.
>> -        fence(Ordering::SeqCst);
>>      }
>>  }
>> =20

