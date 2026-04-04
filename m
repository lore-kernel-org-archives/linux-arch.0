Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021073.outbound.protection.outlook.com [52.101.95.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10992236FD;
	Sat,  4 Apr 2026 12:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775306593; cv=fail; b=GOoOPhNadaUN6LKfGkOSbtYS0F/3I8qjcs4XcDoVFvgN03sBanYPHR5C0To1Eoo0d05t6rS6ZRr6naaHqpdaKpRnUujF1Q+rZEGlR36eOxq/fWmi7nCmyTQuxydfmkW0iEmAx5syKedpua8NBBfrroHVza8beO+G7g+WQ0kB5pM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775306593; c=relaxed/simple;
	bh=0RfLGE4dLdHnYkzIRV55FggXmMuYegZErbczicbRamU=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=fYavzzXS6U4VZyr3KcW5i4w9aRIVeQvyxLlAfVDmauSRlb8DhgpOv3UlYnMlbfzAwodWfeAd3Z3VJuTkdDvTAImhPtqGErSuDKV6yh/jZdGcXo2l0lx6/dCjO4Ei3Kg9CSXZjIYkc3wOt805HbyNyVWfHjJAE4Ly4k8fwgeHgts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=Mea8uK4c; arc=fail smtp.client-ip=52.101.95.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="Mea8uK4c"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rgp1L09+WAkMrlzsxAZrvB+to9U+z33VMxYc2xHGG/LG1rH1F5TWd26fjP4xpzcaBMP01e11oVJAvdJqkQgQXwKezKnkKm8ysYELQLykWvWmD+gGAtRraLTXvnUPyqlbaZ/oFlVzoA5SsR10CJh92ya198f+bIQ9lI1fMKsEUgvuw3lvoEDMIhE2uXrLHdsC/DUbxCzPtJAXqKbj//pAuWAF9tJQ9mKATYS0zQhwEe7IzoiLXPZ7eGV2IzMz617Qa8pbFz9A62ksbcF+6RuRNzQ6c0wv1bOHgP0IPjQ3UAUCu2OQ4X79ghMPd6sv6v5Orcc0z5H0okJmXI8+olMFpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PQw6I/qAwkE45RpZ6PVnn1cG4q9lw+VQbrjlrrqTzBQ=;
 b=Ch3uzgcSyIwwHWVXmU76SG/HvDCAc952qb3Krf+n0TxDQzJsySZKLpBE+22+w8XiT2MGWhbylrQhdfybBuEeqNsUltqXlOCZR9F5li+fjP9T5T31LiKBxCzk9Ethsa4P7dfhiPvcOckfTZsZAV+lnXIb8SSPZSSmLf+G/44e8l27gWYbknq09Y5HEyP1kUyG4xyOibSJkSNKbzizEIfL2lmOecAoeiE82LzatgDa8LcVcccHWTfDkEgKSkJb0+tfX1h6bqawFgLRChfNAC97LAM8oTYDCTwYul7Ujz2U9Lylqt6vp+DaYsKqXifEqg5LRq+jrCdWf4AXEdBYSm0q9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQw6I/qAwkE45RpZ6PVnn1cG4q9lw+VQbrjlrrqTzBQ=;
 b=Mea8uK4chxSSYx4JXuudf+lutYaPDEphx6gvtrqcVwzyOV7SaHaOZRFiGCdT6e50FKzf9IUp7uWqOl61POdfd73udaDvzXB18PfjSEtVf5+mtU6kquJZUZXgryo3bwvP5eKUZ852/0+vuFkybLtt1bT7rYPwoyDM0I1w13xqfr0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWXP265MB2293.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:79::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Sat, 4 Apr
 2026 12:43:08 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.20.9769.016; Sat, 4 Apr 2026
 12:43:08 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 04 Apr 2026 13:43:07 +0100
Message-Id: <DHKDNVH3DGV5.TP0X6143JHG0@garyguo.net>
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
 <DHJ2YICMLZBL.1GJR8TQHG4A8C@garyguo.net>
 <00c387ea-d49b-40ca-bd82-89dbed6ef3cd@nvidia.com>
In-Reply-To: <00c387ea-d49b-40ca-bd82-89dbed6ef3cd@nvidia.com>
X-ClientProxiedBy: LO4P302CA0044.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:317::10) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWXP265MB2293:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e233335-3b55-46e6-f829-08de9247b973
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|10070799003|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	mxQAi/YnN7a/TAoBNJQmBhiK+nLVptWtNRg9MfX7u+O+GHDJvGWtsG0lYfMbCAYj220MX5CcIPU7MzxH7ghU3VgD8+mb9HIR8DWw9vmCWYlIY4cb/RfpQOSl4WNkEPQvOkvBGLhxgzEIIILPjB7HSS4KkSJHPblYbXVac9rCz+7MrIwpnJWLcBzaWvA0r/7hgmnSZsd+xhJE0x12Oo64CovS68ywry8jWxxtXjGVhIjMI9CW9CLpVPBa6l0AxUsPB+ZlX0+khBXZrXSMrRbSnckiboBBbphGVRgXntZ5+n90QzhiUj5UXVE0lpzNCysnVc1szykO9L95GKd8IbVZEyy++BK9/8UsdGSJcjITInRZrvSrXZsT9Nl0HSg/fMwfyiBpoZC7LNSbaXwMQvkMlzL10HvhefdRxOGdegJW72aKLUCa0gjWKdJHT25edviu6Arx1NWSyEFWXSCE6+pt3RbgC3iWeCiU/Hz+94cF7sBnO6cEobhqXadTg+yT5V+iT1LltlcL1hCts8w1YraV4SAGTWemyrSQH+vpw7416YTZLXDGUwc1UM30vexFxLAq4TE+U57eTryeDHLEgkhP+ZMoBSuMiKtkiXrflY38U/FmVlnDoWIi4lG/N5kKO1IgnSLaF95UX/Nf78e9pzR5UCcJwoRTaJTnl+hzhrtXGMfTr+/3R9u3yixa7GQn5IJ7s2Yy97RZdEhBFwxqn4In6zoEmbPEW6t6kDwPNsKf0SPSQvoFuJRUB7viSgqSevAn7Spoy0pbWiFyyNOlDOazTw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(10070799003)(921020)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZUE5dy9BcmU5TW1TZGFtVHgrUlkvOFV2VXFPRUhOUXFjUjN4b0FMeUFNRVRP?=
 =?utf-8?B?ZzBGaGZsazN4SytadHB6eXQxWTZ1ZGNiWkkwYTRGaHBMSWpESUk1MEVibjRY?=
 =?utf-8?B?TnBHanlON0NCT0ZzdXFJTGEvQVVmeStsR3lXYkg2MEdnMkNoU1c0V05vOS9J?=
 =?utf-8?B?NmtLMnA1aTZudDQxOW9uTFZXOVM1Wm1tSGlvNTRjNGRFM3JTZlIyZC9TWXV4?=
 =?utf-8?B?Wit2L1RRQnNHWkNBVVVYUWIvZXp0a05XUjlzOHdKZks5SEtUWnZCWFNRNzY2?=
 =?utf-8?B?NEhBMERuV0NNQlBGL1BaT1IrbzU1dmZRQUFIWlFHaXVwYU1sUk1KU3BqeDd0?=
 =?utf-8?B?OVFZK1FpOGtucGNmRGswZFd1RFgvVlFaQUJlK2ZZTXVOOXJSYUVISEp1ak1S?=
 =?utf-8?B?b3ZBazNwdlROTzVMTDZvcjZnNFd2d3RTbGJpdHlBR3AwVm1acitkcG9vT2hI?=
 =?utf-8?B?eWhiVkl0cXFtWWhubXI3OHVZWXpYWkhwTnJjMHNKem9vWHZmb3F5RHo3NG0x?=
 =?utf-8?B?SEpkVDUvanN2ZmNMQ1ZVL05DeXRFMWZyTGdZcldBaUVmWFpmZjBYcTlSSSs2?=
 =?utf-8?B?RzZHUVBDY2NwcGdrbFY2SVJHd2xxdTk4Vjczb1pqNUh0OFgranpXc1lCQXM5?=
 =?utf-8?B?bjEycGhveUtFaGVHclR6Zk15cnl4RmJCcVliNUl6dzFQL0VWdTFlR0ZJSVNC?=
 =?utf-8?B?aE0ralJpVUo1a0lSaTFjTlEzenY0U3UzQ2NKSWJJYS9mcXhBN2NSUFd0OGNU?=
 =?utf-8?B?bmFCM2gvQW92MXJad0trWmNmSDJiaGdMZWhIcFBlZVVScHRveWNjMjExYzhl?=
 =?utf-8?B?QXhJVFNXamYxbGp6VjVCYUhPU3Q4RU1GMWY4a1dTaXNsVWVWMnlqcmZxZ2hr?=
 =?utf-8?B?L1Q4NS95cWU2TlZXZTArMitMSmtJbE42MEdyd0FiTUxhczFXd0NNTTZwY1ZQ?=
 =?utf-8?B?Y0VyWERFSUF6WUpVUEFVclNRcGx2UkhmTGVqSXFFOHBpcG8xODFNSjBTb1NE?=
 =?utf-8?B?aVR1UU82c2VUQ2JQcmRWYUVOUEFFZ1U4Z3pUMUFTUktiVEdvYXpLczY2WXBL?=
 =?utf-8?B?QnpxZzNmZDBUTS9QcGtuTGlxclQwYWJjbDdERDJ5Mk12N0FxYmVjSTg1VTFI?=
 =?utf-8?B?SWVpZ1BmT3NubGYxcEZEUnFjMDRjY1lLODR1V3ZDSlZjdUZXR2VDUUNsWFVN?=
 =?utf-8?B?T0xEWTQzOGhOak9EVmVlTlU0SFJQZnM2R1U1NmV5RXhkZDVJODcxMUd1aW8y?=
 =?utf-8?B?ZUJQdy92bzFOTkpPNDdzRTVadUJ5UlZtT0lhR1cyOTEyak1qdlN2SjZ1cmlw?=
 =?utf-8?B?UTZBOTQxUGJPbXQ4a0xJemRhajVuZ0ZmREpEcTVkNnl1WE1FbHZZc29KUWZX?=
 =?utf-8?B?USs5NWpHdXFwNnZuTllySktTb29hYjFaNTgyc2RXb3V0Umo3emI1WGpYdHlu?=
 =?utf-8?B?OE4zNGRiREJRNWR5REZCckI2UHQxYlhWaGVSQzc4R0Vvem11Y0lvODRqeVdY?=
 =?utf-8?B?WURhQ05jR2hyc2poQnlFQmVCWnVqMHFmNi9DUWtVeVZHNGZDZjAxbnJzSEdk?=
 =?utf-8?B?T05KbmtYdVFpMVdwVUI5UDhlQXVLclVjb1dkL05wR1JtTEhuWW1FUjh0THhz?=
 =?utf-8?B?ZmNNRjExRWhQSlpKczcwcU4vdGExcTlRQllUTG5ZNklyclNFekxUcnZURzN3?=
 =?utf-8?B?SWk2SGRGVUFZMXM1UG1BLzJnd2Q5b2JBYXdsVkVaZmFpRk94UXFobzVUeVBH?=
 =?utf-8?B?RTdUck84ekYxbGc4bld1V0JBV05Lb3dQMGFuWnc5SzJ0U2NTbmtjNzlEQlhn?=
 =?utf-8?B?V3Y1YllSTjNvVktsM0lwMTZGTzR5cmFValdFblB6UEk1c0xaS0dOazhYUW9U?=
 =?utf-8?B?aVM4MXNRUGNpeWZzeGt2T1Ira3E5eC9RUVhWMTNOd0dja21zMlhDVXpGamlH?=
 =?utf-8?B?L3JZUDdwRmVDSG84ZDE2alBUUkFVZG8za0dBY3g5ZnJQcGZiZDZIK2p3OHZu?=
 =?utf-8?B?NFJWekEremMvOFBRWXp5UitYVGFGOXFjczdjLzgrdTFPTWx2S0Y2RlFNMUZF?=
 =?utf-8?B?WFlPT2lRa0JCVGphMEVXWDBQYUdrQXBZSzd2Q2YzUU04Y0gydXVBblQ3TENq?=
 =?utf-8?B?ZEhSRVkyUmI5cGM5STlTRWtNYlU0Y002VWg4dEI4clZNZU0zTDZIRnA3VVpG?=
 =?utf-8?B?bXlQK1dyTGk0K25pOTVmMFllRkZDdllyc09aanJOb2N6anc2OHJMdFZ3bTJl?=
 =?utf-8?B?ZXY2U2JkVi9BMjRsR1dPV042OEs2TFdwUVNMOWtZZGpZbFNEY3BrbGM2VTVK?=
 =?utf-8?B?Zk5vQTE4UlYyOTZwdURRMjVnTHlCWXRIRnNudFB6UjhWTlFWMENvQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e233335-3b55-46e6-f829-08de9247b973
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2026 12:43:08.6176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PwNj1qqQ5qwvYBg83JViP3RHlmL6GKaMMSA2QM6AI/QIXJmhHkynbkvj8B17o1YjUOJmnB2X+NtBpCsJ9cLUBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB2293

On Fri Apr 3, 2026 at 10:33 PM BST, Joel Fernandes wrote:
>
>
> On 4/2/2026 8:07 PM, Gary Guo wrote:
>> On Thu Apr 2, 2026 at 10:49 PM BST, Joel Fernandes wrote:
>
> [...]
>
>>> See also in Documentation/memory-barriers.txt, ACQUIRE and RELEASE are =
defined as being
>>> tied to specific memory operations.
>>=20
>> That's what we have today, hence the implementation upgrades them to ful=
l memory
>> barriers. But ACQUIRE and RELEASE orderings doesn't *need* to be tied to
>> specific memory operations and they can still make conceptual sense as b=
arriers.
>>=20
>> C11 memory model defines Acquire and Release fences, and it looks to me =
it's
>> relatively easy to add it to LKMM. I was playing with Herd7 and I think =
I've got
>> it working, see the attached diff.
>>=20
>> Another thing that I'd like to note is that in all architectures that we=
 have
>> today except ARM and PARISC, the smp_load_acquire and smp_store_release =
are
>> actually implemented as READ_ONCE + ACQUIRE barrier and RELEASE barrier =
+
>> WRITE_ONCE. I'm planning to propose C API and corresponding memory model=
 change
>> too, but I want to gather some more concrete numbers (the performance be=
nefit of
>> having dma_mb_acquire/dma_mb_release compared to full dma_mb) before pro=
posing so.
>>=20
>> Note that marked dma_load_acquire/dma_store_release (and their mandatory
>> versions) don't make too much sense, as AFAIK no architectures have inst=
ructions
>> for them so you're implementing these as fence instructions anyway.
>
> Ah, so you're proposing new memory barrier types that don't exist anywher=
e
> in the kernel yet. I thought you were just wrapping existing ones so it g=
ot
> a bit confusing.

Well, I am not proposing new memory barrier types in this change, hence I
mentioned that these are annotations about intention and documentation and =
not
about their *semantics* currently. Perhaps I didn't phrase this clear enoug=
h?

How about change the wording in documentation like this:

    /// `Acquire` is a full memory barrier, but caller indicates that it on=
ly
    /// uses it to provide LOAD->{LOAD,STORE} ordering.=20

or do you think even that is too much?

>
> My suggestion: fix the nova-core issue in patch 3 using dma_mb() directly=
,
> without the new barrier types. Adding a new standalone release/acquire
> fence semantic to the kernel is something that will need broad consensus
> from the LKMM maintainers IMO, independent of this series. It's a bigger
> conversation that could delay your nova bug fix.

Something like this?

    // TODO: Replace with `dma_mb(Release)` when it's available.
    dma_mb(Full);

Or not even mentioning that? I really like the Acquire/Release because they
serve themselves a documentation on why the barrier is there to exist.

When I read a full barrier, I always need to think whether the code really
relies on STORE->LOAD ordering or a weaker ordering that could be used.
There's a conventional wisdom in userspace C/Rust where when you see seq_cs=
t,
99% of the time it's wrong.

>
> Once smp_mb_release() / smp_mb_acquire() (or the DMA equivalents) land
> properly, updating nova to use them will be trivial. But the correctness =
of
> the fix shouldn't depend on semantics that don't exist in the kernel yet,
> even if they currently degrade to a full barrier.
>
> That said, I find the idea genuinely interesting, and thanks for keeping =
me
> in the loop. Standalone acquire/release fences that are formally modeled =
in
> LKMM and A-cumulative is interesting as you showed in the herd7 code. You
> would want to update Documentation/memory-barriers.txt too.

Yeah, there're more works to do on changing the semantics, hence I want to =
limit
this to not be about semantics.

Best,
Gary
