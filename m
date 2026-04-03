Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021118.outbound.protection.outlook.com [52.101.95.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3542744F;
	Fri,  3 Apr 2026 00:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775174836; cv=fail; b=RBmzIL5bDG8jZAyn3BqmyffI2VUf8vXLD92TifoH3T3AMSab6PVmxINA4MTdBVCFGsFJwLkSh+3hfT4cDdc6AnpjEI0jekyftFZ7WcG2+/FEWVXMNPllH5eDBru3ybB+QgyO/ES6G9e0OFuklGF+7XwQ+FbaiRt4gCEtHt7+8w4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775174836; c=relaxed/simple;
	bh=jhwXmxWQB0m0352uLh76DAeyLgEM36Ckhl0u0WYe9NY=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=FaE86UVICNF+PkoSUISqXBRpFOwdAhNOKOm6lq8yWm24srblwtkxPG9gRE8/fGI3eC6q1jk5P+TNb2dMllRaTm1RF3SJCqy20dc9JrwinzT9c6jjtWbTO1XbVNpXR9UiAllkX0n5w8eD9ZaFrgJz8Ce/9rcDRLJpTlCrDPxyJe8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=TeR6FrjQ; arc=fail smtp.client-ip=52.101.95.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="TeR6FrjQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cP9EBDqkyamdnLdzXhcWbqk39Jvp7+oQK60GMnbcte8Shf/OZ/GHzYml+FZOJMN5E5X8HPEIF1g3RGoTXtz8BjsLdNyB3mVBtQ+fW3q0D8vG5NDq/fXChwVfWd+yVhm/WrqIoBRSthNDNmRG7tG3pRJwVuXHoISUHUQazsyoG/yE5QWN0ocUgiKfRnihvDyV2o9y08Y+z6evLk/srl1T8tyIEk16rdTzl36jZs6YaAG/3WkAG86EsNO+EbsZe1U0FZuQLzqT+ZtBsf3Ya2M6q/yzweMFm3w1267Wis9mnX03/6DF9HaFENrJ2eUynAe9VFGH9T1ThTFwNcCaeSbccQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AvZqlv0W34Q545+btLig+obTHAA4aaPBWYkRRK+uz2A=;
 b=x2qJuLIb9ejETeQ8urJg8R9MtWPIFn1qm12puhBspSWy0nNYN6+Ay4Bl/CVQCsvTeJgnomsUl59n/Zf0Ak1c2XGilGNSIPV22ynW6FqxdfaW4Iy65qqjH0W9EQO5xyoMorMgX+bUOWDn0lDK47l6t4doJECUJ/DlF85esUs1kaP33/5UiXururb1BlMcNUWfGeGCRIrvB25OUCnOtmb7L/A1ISF7afdiLjsfVP/u40BB1DE+LGbk0xxWTasvOS6VIikWr3sgYDZaghI+vFvp+d9A+PUnEOKugciZdV3uVPMsFV6xNbUx5hUu4NPxOlbaxZieoCwO4YbAyP8Nee1+gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AvZqlv0W34Q545+btLig+obTHAA4aaPBWYkRRK+uz2A=;
 b=TeR6FrjQL2vPT0QI1YqKaYXkQLuXXI5Fwh31oWXrrDxSteuHvAJA32SL8Hppi4hVIeGJICEa4zsGwLVQzZ+BaSyzqaH776gGb5nNXRcCccKSACPVWmWji5/iCcXSrdgnwDGKarMb/VU907prhtnot46mGGiJK/IBMY4ZlWzrbrc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CW1P265MB8976.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:272::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Fri, 3 Apr
 2026 00:07:10 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.20.9769.016; Fri, 3 Apr 2026
 00:07:10 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 03 Apr 2026 01:07:09 +0100
Message-Id: <DHJ2YICMLZBL.1GJR8TQHG4A8C@garyguo.net>
Cc: "Alan Stern" <stern@rowland.harvard.edu>, "Andrea Parri"
 <parri.andrea@gmail.com>, "Nicholas Piggin" <npiggin@gmail.com>, "David
 Howells" <dhowells@redhat.com>, "Jade Alglave" <j.alglave@ucl.ac.uk>, "Luc
 Maranget" <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@kernel.org>,
 "Akira Yokosawa" <akiyks@gmail.com>, "Daniel Lustig" <dlustig@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-arch@vger.kernel.org>, <lkmm@lists.linux.dev>, "Alexandre Courbot"
 <acourbot@nvidia.com>, "John Hubbard" <jhubbard@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, "Eliot Courtney" <ecourtney@nvidia.com>, "Alistair
 Popple" <apopple@nvidia.com>
Subject: Re: [PATCH 2/3] rust: sync: generic memory barriers
From: "Gary Guo" <gary@garyguo.net>
To: "Joel Fernandes" <joelagnelf@nvidia.com>, "Gary Guo" <gary@garyguo.net>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "Will Deacon" <will@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, "Mark Rutland" <mark.rutland@arm.com>
X-Mailer: aerc 0.21.0
References: <20260402152443.1059634-2-gary@kernel.org>
 <20260402152443.1059634-4-gary@kernel.org>
 <620eaaf3-0569-4633-afd9-74ec18dccbf8@nvidia.com>
In-Reply-To: <620eaaf3-0569-4633-afd9-74ec18dccbf8@nvidia.com>
X-ClientProxiedBy: LO4P265CA0222.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:33a::10) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CW1P265MB8976:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d20b57e-1eba-4d7b-2096-08de9114f330
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|7416014|376014|1800799024|921020|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	oLYQYXq+DfO/iU1qk/g/UEXh6PiasEWYKeDegTATFENXrael3IBqILfrUFict5ihHnjO3WpmZe8pa6UeHrrS6XKZhpwmoFHIE+zsB5YnayxW1qs9k0X4ioCDhm9JtfLaq3tuLoxqaKFr+KumMn4/gpb76FI05pgn3OIE31H7ugnsq7hOMIm+eI+KzlbzhQHXTogyx9Xy+Z9KiDcdb+9tkMKPpsnwv2pSpuSZ8E3YxdoyC7jmBWB8AoDRxeWVY5npHtYsZbTaDYY5nYYG55Dule7PBXpRjm2KwaFHrParlaZ6rNpWepMIaI9Cgenfp7rPno79CCZomWkNhit8ex/zI4GAImIjqyrcb7tGWWXUU+vLiZF7+9DKFhNOr/ijWiG+gRocNmWT5EtHTN5mtsFRoSAP/SdpXFQ2S5nNFuGV0Wt13gSzj3HD6Yr9UFuKL3I3/xwkBXAIyTi0mrI8bCg5+4AzSUPyTIbq3j3QXex8cAttZxROH8LnW+7AQA9qvDhDvE1tMhIvbBKmpwN+3+l5rni9S3+H+5MbxYROmViGuXxQZZhcIybakV09VcRhm9t96hZe2z309TOK7I/4WEdWbqlIPYyKl+a0KoeyeqpGUw5Jp8E5mbUM21X5Zv0Q6P0woOWNFLUgFlGmy03FEt7khReknJhbbmHenU7VkzuE06xSTFCAghYRkQh+2Rkkd/fI22L3bPM+DlMoBtbHgkmobYOUa+OYHySsIc3Bw8QknNw9CXEkT79/27p8hry8hRsg4B7WlUi679rWe40H/P7E+Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(7416014)(376014)(1800799024)(921020)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dnBWM2NPeEtQUVRpc2NoTWVkbEZnYUUydXgrWFBXZ1E4NGxrY0hTYk83Z2pR?=
 =?utf-8?B?dWhpRThETU5QNDUxcjNnUUpKeFVCazBZS2hYVTdZc2ttRzNWSE00VVBlVk1p?=
 =?utf-8?B?SStjUzAvZ1R2TnNYSFBtWVVGVUdLOEdVeWc4TkxRS3hTR1EyS2I5TWtmZC9t?=
 =?utf-8?B?cHprM0QwOXBFNzhLNVV1NWZMcGI1UVl5am9Oc0ZNV2VFTDhmK29JdEhlSGlZ?=
 =?utf-8?B?Q0szSk5VZ0Y5RHk2bS9DZk1wc3VoS1hIU3RMSU95eWgrdHVTQ0lRYXUyN1FL?=
 =?utf-8?B?emNWbkN3eEtLbXhFczNlUGhLTzcwejZxWnpLMGhMcXFPNU5vOW1vRVJhak40?=
 =?utf-8?B?OU1DWnEyS1RYTlEwdDJGaERHaDU2Zy9WM3JSZHlPTnhWWEhoRDl6cDdsT1B5?=
 =?utf-8?B?OFJHK1hHZW1aV2tXa2lXMHpWUVdtWlp4TGpCOG9nVUZwTElMcW83T3YwYktk?=
 =?utf-8?B?RkVabElrSWJzZXF1R1BmY3FNY2V6RmsxaXJjY3c5dkpWZng2QkJaa2ZGdzNy?=
 =?utf-8?B?NDJiUWxWQ0xnaTIzMVNHUHN1TnZ3RnNtbEhmcWozdnp1YTdyVzNEWEMvMGJo?=
 =?utf-8?B?eUtNcmkvVXZLd1JUaFpITWdRSmQwa1JnRWgrdTByblp5UXhoR0haazA0Um1G?=
 =?utf-8?B?S1N2VHhjUTkyWDFRWkNDbG9hUnBHRG9aSmh6OWl0bEJMaG0vTU4ySlJNZytO?=
 =?utf-8?B?L1lHVUF2WTRSN2MvREU1ZENuY011c0dYbXlhK0duRDlYVlZmNmx6eTlCRXJs?=
 =?utf-8?B?VGYxZ1dVWXNpdmZjMzVRQXpkVTZiYWsxSVlLMW5lUHNSTkhVRUxxY0RrN0gz?=
 =?utf-8?B?Y3hGR2JXcS94ZVAyeFRjbk1OdENwendWK1FWRGdFZHdaSjJEdmVad2EvV3lm?=
 =?utf-8?B?U1F3RWN5WEhxemNVbWExaUZyejNkWHcvYjZFWG1iNFlSL0xUWk1sWVlPdWdD?=
 =?utf-8?B?U2o0YkNiZG5LNmtLb0R2VTFYbXRscXU0ODFKWUNoVzFBUERzenlJd0QyMjQ2?=
 =?utf-8?B?RUEvUDdKOVA2eWVGZEROaEU5WlRCdFE5cU5jQnRubVhzYWUvK2dBS1FHT2I5?=
 =?utf-8?B?SGptQ0dWU2hJY2cxVDVxRG5zQXM3a3NyQms0Y0J6TUtaRHdkbWFWZnZVSXZy?=
 =?utf-8?B?clFSeWN4S0FtVk9BTXdxbyszNTc5MDZmYXpWYUtEVHpPdFFvUkNad1F4am5D?=
 =?utf-8?B?SkVzVGNiRG8wRmptWDRHK3FzR3VTQ3JjZGd3b25UUnZlK29oSFlGZEU4ayto?=
 =?utf-8?B?NFJpTHhCSmt5dFc2d2s1NEx0T0NRMW56cFh2aUh6TmtGSlVoY1JBRnhIVTZB?=
 =?utf-8?B?eGZBVlZDVU5ZOHM2RElhZDhDc1VHcVV5bUR3am9xRjhHeFo3YnBlZmVNSG8x?=
 =?utf-8?B?ZllRMlpJUklCSHhjUDZPZFdNT1RqSUQ3OTRlQ2w4MXhOcS9kY1NhVnNCM0lS?=
 =?utf-8?B?RmhscFEzeDU3ZllvamFFWnFqN2F4WDIvY3Y3RklXMW1IZFUwcWNXM3lXTlNh?=
 =?utf-8?B?ZFFvRHhjdGM1UTlVcG1YRldXdjNFYWp6RUgxYUdldVp5OXh2RHljakhDSVBG?=
 =?utf-8?B?bXZvVWdkdzdIMUw1Q0pPRmhPclg5WHoyNFYzNUNhR1B4WnpiS2lLejd1MjlX?=
 =?utf-8?B?NUdpZlRwbWFOa0J0dHFnb3dnaUtoaHF6WUl2RmRjOHc3NjdIL1JCdTFuNWRP?=
 =?utf-8?B?T2o5b2tNMzRTS1NMMTliaHpHd09XeWdqbzkwZ2lzRmtmeVV0S3h6MGpRR1Mx?=
 =?utf-8?B?RWd5SGt6VkhtbmFrWXdJd3Bpbjg4NHJTMnlEbjA2Wm1BNUZGZjBIS2g2YlFC?=
 =?utf-8?B?c3N1MnNERFUwL1VPM1JPblRnbHROaFQxZFZ2SXNXYjZJR0JZSHVMSCtSTTJ1?=
 =?utf-8?B?OC9VK1dIOFFoNEFWNkRNNzhCaks3ZjR2amVGMFQrVXRmQjhMMFRjK2Qrb2N2?=
 =?utf-8?B?SEZDUjlRNEV4cWdPSWMwc1hycjVITGlzOHdoZDRpOE93TDA1ci92emRieEd2?=
 =?utf-8?B?ZXVCUElSN1U4UWZBc1JFK3dreXNjWmp3ajNyNXR4UDN5YnR3NjNTdVp3NFFW?=
 =?utf-8?B?VDdReG91dkYyNmFjSEs0NEM1bk9CbWJBQ0hQWDRyNUs2ZGlBTm84Ym1rTmwx?=
 =?utf-8?B?SUlHNE1na0xMbDBuZzFWL3pUQnAyMHJQU3hXQmo3Vk0xRjFESDJQL0NLcFZY?=
 =?utf-8?B?SG9kTVJaKzJHWTFLZkI1dHdZb0tyemxYS1IzL29RdzNieTJudEJRVUhLQkhT?=
 =?utf-8?B?eWFzMC9ON1ZMSEtnY3Rwb0tCVVlRTjRTZ2RDOEFnUkxBMnpaeklTZUxGZTdC?=
 =?utf-8?B?SVl1Q3BIUkVFQThkWDhuWkZBdzd4aFJTWExBMTg2TkZuUHpwcU1kZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d20b57e-1eba-4d7b-2096-08de9114f330
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 00:07:09.9555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jOyqb+DMiwZxXIGkQAucQSRSg3MkABMteZDYxWi/89jGsYZPA4HLzdAu/ovvo2xLn2Z/78d5RdZwYIVlgGN5qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P265MB8976

On Thu Apr 2, 2026 at 10:49 PM BST, Joel Fernandes wrote:
> Hi Gary,
>
> On 4/2/2026 11:24 AM, Gary Guo wrote:
>> From: Gary Guo <gary@garyguo.net>
>>
>> Implement a generic interface for memory barriers (full system/DMA/SMP).
>> The interface uses a parameter to force user to specify their intent wit=
h
>> barriers.
>>
>> It provides `Read`, `Write`, `Full` orderings which map to the existing
>> `rmb()`, `wmb()` and `mb()`, but also `Acquire` and `Release` which is
>> documented to have `LOAD->{LOAD,STORE}` ordering and `{LOAD,STORE}->WRIT=
E`
>> ordering, although for now they're still mapped to a full `mb()`. But in
>> the future it could be mapped to a more efficient form depending on the
>> architecture. I included them as many users do not need the STORE->LOAD
>> ordering, and having them use `Acquire`/`Release` is more clear on their
>> intent in what reordering is to be prevented.
>>
>> Generic is used here instead of providing individual standalone function=
s
>> to reduce code duplication. For example, the `Acquire` -> `Full` upgrade
>> here is uniformly implemented for all three types. The `CONFIG_SMP` chec=
k
>> in `smp_mb` is uniformly implemented for all SMP barriers. This could
>> extend to `virt_mb`'s if they're introduced in the future.
>>
>> Signed-off-by: Gary Guo <gary@garyguo.net>
>> ---
>>  rust/kernel/sync/atomic/ordering.rs |   2 +-
>>  rust/kernel/sync/barrier.rs         | 194 ++++++++++++++++++++++++----
>
> IMO this patch should be split up into different patches for CPU vs IO, a=
nd
> perhaps even more patches separating out different barrier types.

Given the different barrier types are quite closely related, I don't want t=
o
create a bunch of small patches adding one each. But splitting out the SMP
change and then add DMA/mandatory barrier as another patch does sound
reasonable.

>
>>  2 files changed, 168 insertions(+), 28 deletions(-)
>>
>> diff --git a/rust/kernel/sync/atomic/ordering.rs b/rust/kernel/sync/atom=
ic/ordering.rs
>> index 3f103aa8db99..c4e732e7212f 100644
>> --- a/rust/kernel/sync/atomic/ordering.rs
>> +++ b/rust/kernel/sync/atomic/ordering.rs
> [...]> +// Currently kernel only support `rmb`, `wmb` and full `mb`.
>> +impl MemoryBarrier<Smp> for Read {
>> +    #[inline]
>> +    fn run() {
>> +        // SAFETY: `smp_rmb()` is safe to call.
>> +        unsafe { bindings::smp_rmb() };
>> +    }
>> +}
>> +
>> +impl MemoryBarrier<Smp> for Write {
>> +    #[inline]
>> +    fn run() {
>>          // SAFETY: `smp_wmb()` is safe to call.
>>          unsafe { bindings::smp_wmb() };
>> -    } else {
>> -        barrier();
>>      }
>>  }
>>
>> -/// A read-read memory barrier.
>> +impl MemoryBarrier<Smp> for Full {
>> +    #[inline]
>> +    fn run() {
>> +        // SAFETY: `smp_mb()` is safe to call.
>> +        unsafe { bindings::smp_mb() };
>> +    }
>> +}
>> +
>> +/// Memory barrier.
>>  ///
>> -/// A barrier that prevents compiler and CPU from reordering memory rea=
d accesses across the
>> -/// barrier.
>> -#[inline(always)]
>> -pub fn smp_rmb() {
>> +/// A barrier that prevents compiler and CPU from reordering memory acc=
esses across the barrier.
>> +///
>> +/// The specific forms of reordering can be specified using the paramet=
er.
>> +/// - `mb(Read)` provides a read-read barrier.
>> +/// - `mb(Write)` provides a write-write barrier.
>> +/// - `mb(Full)` provides a full barrier.
>> +/// - `mb(Acquire)` prevents preceding read from being ordered against =
succeeding memory
>> +///    operations.
>> +/// - `mb(Release)` prevents preceding memory operations from being ord=
ered against succeeding
>> +///    writes.
>
> I don't agree with this definition of Release. Release is always associat=
ed with
> a specific store, likewise acquire with a load. The definition above also
> doesn't make sense 'prevents preceding memory operations from being order=
ed
> against succeeding writes', that's not what Release semantics are. Releas=
e
> orders memory operations with a specific memory operation associated with
> Release. Same for Acquire.

I worded my commit message to say that these are about *intentions* and not
semantics. I do want to change the semantics too, but it's not fully ready =
yet.
But looks like you're interested, so let me share them too (perhaps a bit
prematurely).

>
> See also in Documentation/memory-barriers.txt, ACQUIRE and RELEASE are de=
fined as being
> tied to specific memory operations.

That's what we have today, hence the implementation upgrades them to full m=
emory
barriers. But ACQUIRE and RELEASE orderings doesn't *need* to be tied to
specific memory operations and they can still make conceptual sense as barr=
iers.

C11 memory model defines Acquire and Release fences, and it looks to me it'=
s
relatively easy to add it to LKMM. I was playing with Herd7 and I think I'v=
e got
it working, see the attached diff.

Another thing that I'd like to note is that in all architectures that we ha=
ve
today except ARM and PARISC, the smp_load_acquire and smp_store_release are
actually implemented as READ_ONCE + ACQUIRE barrier and RELEASE barrier +
WRITE_ONCE. I'm planning to propose C API and corresponding memory model ch=
ange
too, but I want to gather some more concrete numbers (the performance benef=
it of
having dma_mb_acquire/dma_mb_release compared to full dma_mb) before propos=
ing so.

Note that marked dma_load_acquire/dma_store_release (and their mandatory
versions) don't make too much sense, as AFAIK no architectures have instruc=
tions
for them so you're implementing these as fence instructions anyway.

Best,
Gary

diff --git a/tools/memory-model/linux-kernel.bell b/tools/memory-model/linu=
x-kernel.bell
index fe65998002b9..9b3322fc5b9c 100644
--- a/tools/memory-model/linux-kernel.bell
+++ b/tools/memory-model/linux-kernel.bell
@@ -25,6 +25,8 @@ instructions RMW[Accesses]
 enum Barriers =3D 'wmb (*smp_wmb*) ||
 		'rmb (*smp_rmb*) ||
 		'MB (*smp_mb*) ||
+		'mb-acquire (*smp_mb_acquire*) ||
+		'mb-release (*smp_mb_release*) ||
 		'barrier (*barrier*) ||
 		'rcu-lock (*rcu_read_lock*)  ||
 		'rcu-unlock (*rcu_read_unlock*) ||
diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux=
-kernel.cat
index d7e7bf13c831..d7be7c03bb25 100644
--- a/tools/memory-model/linux-kernel.cat
+++ b/tools/memory-model/linux-kernel.cat
@@ -33,6 +33,8 @@ let po-unlock-lock-po =3D po ; [UL] ; (po|rf) ; [LKR] ; p=
o
 let R4rmb =3D R \ Noreturn	(* Reads for which rmb works *)
 let rmb =3D [R4rmb] ; fencerel(Rmb) ; [R4rmb]
 let wmb =3D [W] ; fencerel(Wmb) ; [W]
+let mb-acquire =3D [R4rmb] ; fencerel(Mb-acquire) ; [M]
+let mb-release =3D [M] ; fencerel(Mb-release) ; [W]
 let mb =3D ([M] ; fencerel(Mb) ; [M]) |
 	(*
 	 * full-barrier RMWs (successful cmpxchg(), xchg(), etc.) act as
@@ -64,9 +66,10 @@ let mb =3D ([M] ; fencerel(Mb) ; [M]) |
 let gp =3D po ; [Sync-rcu | Sync-srcu] ; po?
 let strong-fence =3D mb | gp
=20
-let nonrw-fence =3D strong-fence | po-rel | acq-po
+let nonrw-fence =3D strong-fence | po-rel | acq-po | mb-acquire | mb-relea=
se
 let fence =3D nonrw-fence | wmb | rmb
-let barrier =3D fencerel(Barrier | Rmb | Wmb | Mb | Sync-rcu | Sync-srcu |
+let barrier =3D fencerel(Barrier | Rmb | Wmb | Mb | Mb-acquire | Mb-releas=
e |
+        Sync-rcu | Sync-srcu |
 		Before-atomic | After-atomic | Acquire | Release |
 		Rcu-lock | Rcu-unlock | Srcu-lock | Srcu-unlock) |
 	(po ; [Release]) | ([Acquire] ; po)
@@ -97,7 +100,7 @@ let ppo =3D to-r | to-w | (fence & int) | (po-unlock-loc=
k-po & int)
 (* Propagation: Ordering from release operations and strong fences. *)
 let A-cumul(r) =3D (rfe ; [Marked])? ; r
 let rmw-sequence =3D (rf ; rmw)*
-let cumul-fence =3D [Marked] ; (A-cumul(strong-fence | po-rel) | wmb |
+let cumul-fence =3D [Marked] ; (A-cumul(strong-fence | po-rel | mb-release=
) | wmb |
 	po-unlock-lock-po) ; [Marked] ; rmw-sequence
 let prop =3D [Marked] ; (overwrite & ext)? ; cumul-fence* ;
 	[Marked] ; rfe? ; [Marked]
diff --git a/tools/memory-model/linux-kernel.def b/tools/memory-model/linux=
-kernel.def
index 49e402782e49..e32aea2c01a9 100644
--- a/tools/memory-model/linux-kernel.def
+++ b/tools/memory-model/linux-kernel.def
@@ -20,6 +20,8 @@ smp_store_mb(X,V) { __store{ONCE}(X,V); __fence{MB}; }
 smp_mb() { __fence{MB}; }
 smp_rmb() { __fence{rmb}; }
 smp_wmb() { __fence{wmb}; }
+smp_mb_acquire() { __fence{mb-acquire}; }
+smp_mb_release() { __fence{mb-release}; }
 smp_mb__before_atomic() { __fence{before-atomic}; }
 smp_mb__after_atomic() { __fence{after-atomic}; }
 smp_mb__after_spinlock() { __fence{after-spinlock}; }
diff --git a/tools/memory-model/litmus-tests/MP+fencembreleaseonceonce+fenc=
embacquireonceonce.litmus b/tools/memory-model/litmus-tests/MP+fencembrelea=
seonceonce+fencembacquireonceonce.litmus
new file mode 100644
index 000000000000..d53b848c5687
--- /dev/null
+++ b/tools/memory-model/litmus-tests/MP+fencembreleaseonceonce+fencembacqu=
ireonceonce.litmus
@@ -0,0 +1,30 @@
+C MP+fencembrelonceonce+fencembacquireonceonce
+
+(*
+ * Result: Never
+ *
+ * This litmus test demonstrates that smp_mb_release() and
+ * smp_mb_acquire() provide sufficient ordering for the message-passing
+ * pattern.
+ *)
+
+{}
+
+P0(int *buf, int *flag) // Producer
+{
+	WRITE_ONCE(*buf, 1);
+	smp_mb_release();
+	WRITE_ONCE(*flag, 1);
+}
+
+P1(int *buf, int *flag) // Consumer
+{
+	int r0;
+	int r1;
+
+	r0 =3D READ_ONCE(*flag);
+	smp_mb_acquire();
+	r1 =3D READ_ONCE(*buf);
+}
+
+exists (1:r0=3D1 /\ 1:r1=3D0) (* Bad outcome. *)

