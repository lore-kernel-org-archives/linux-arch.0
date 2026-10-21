Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.100.128
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792584412;
	b=fZpBiZLEyeSD1XO4X5bSSxykFy9yIc6A+EHFsJ6T868v0kVnyrNRc/IE359TpRsuvjPO
	 Bh7dC6E4kF48Uxo1D1EfVcGdSm+WvONcHsSiftsy01/ALMMIvqFjlD+O8QbuVpbHnZUvn
	 f7VPYCpk1+/WNgNydzk4WZ/K3pzEnshK5OmcVEgtZXif3hN3nJniiGJgCPejZ3HPv2q3H
	 j1tWhxRhvebY8oHZTbQna12G60PEWcyQ5nX91cx4vyDkF4IxAEDUf6FWMbnac0KR6hdxs
	 rvVXicOJaxPjhXAbuZaaJY3vfuQEM+p4+1ZQi3fsf+FTo6PV3LmIRR7YQ95/mY0S8gA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792584412;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Subject:From:
	 To:Cc:X-Mailer:References:In-Reply-To:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=sA041WDa2vqolKp4czatEpxiyQONE5RmxjDRt0fEGRI=;
	b=X6e+ZN9kXMP8t/xlDsoeXnS7yzzqpVJEES9BesPh2X9SlCZ4oEuss1K5wod5awKXyIFn
	 C3r/rK+UpJ+9BQWIOPgi1jvTPf+D7leRTXP55Td5pzpdUVsQ3Pm5vyfrl5ikrGFOO1Iev
	 Ajy/4ZQ3pYTxqf4YzaJFyyQZI8M2ObANA347r9Iyy7XffKASQEiVunpURUsi5gtKnATXF
	 Fl82AyBzalvDShNoNyhTnae5t98H4YlmezTXKZCJ7pUK3VPS1M7LwzjxTGIYg8VeWsdQf
	 rPkf5kKAWSMy+XJ1NqfDSRjgcuGYpyw5QaXUjDp3OO9qY5oYGmZb1bBJl3XgbATG9/Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=garyguo.net;
	spf=pass smtp.mailfrom=garyguo.net;
	dkim=pass header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=qKieBi+y;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.100.128
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021128.outbound.protection.outlook.com [52.101.100.128])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F4B606A31A;
	Wed, 21 Oct 2026 12:06:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8F4B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=qKieBi+y
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nrT1CrkipHC82ZiyHIJf6fIr4XXrgPdeYDScehNlPBqtUMyUGHkwl5GquZL5gKbHGf+p677Lvcq43THlYtx0zzpuS7TbIxq+eMLSGmCDUkxoxTdCfV1c940tMv5lAOKUfLjUZjv8/RsgjU8UEUSVfE0d0HtQ23baXJGfb9zam/vtqdkp3jVI0ZRSh/qtE5t+1qzEwQnBSYvXLA6bv8zLSkHGJ1SbAsOXj9eOavnKutc3hKC+ETqWFwb+BlTRAKgyYtWrQcRg+1KCK/VSlHR8445ThXUN67ZFWZn/iBx3IlQsRcxi5dd8SlVhnOQ6iqHPUiESWW5MZnJg/Xph7wwFNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sA041WDa2vqolKp4czatEpxiyQONE5RmxjDRt0fEGRI=;
 b=UKLejd2vYHf48j5MB//6bIFAUyClfBzy71Yl+m9dX/8HTsWABwS0C1N/0nKmrlHE0zwPaX4yGUwA7Fk9g7DAZk9RW6WOEb7fYO8LBVF9zIglbixLuHX2dRS8RJgybaU/o3jdtHwXpA8Hcn27xpsn93xaMCXIYlQ7xjLTcawi2mQKcJZdp0DqKpBZlIGwUBPYsdnWDYSZmp7pzFCK2GUS8kN0nPBkrkkDT30Kd5v9e6r4OjWmU7zV/8cOu7Et1S1chD+MVduu1/anolmFgzh4aZQzKqIZ36W3FOa7PXKYMuOTJR/DrfQ4nMjfaJnFTfym+LyhvvzXfPyJY1cu7lnydQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sA041WDa2vqolKp4czatEpxiyQONE5RmxjDRt0fEGRI=;
 b=qKieBi+yanImw3SBgkyKS+fgbliTE2UWf0jPeZ+YWYv1/kqBw261IFwJYL2UMFAKyb5ccyaG/291oLVDCD2S0v88VeKdUFIIV0Tc4MFe5qcH6YdGltkRYpjyCedgtPl0Yj4dY1AAJPavjUz8cCwg8KcUgdyx6t6EOCrQPC4gtf0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO0P265MB6773.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2fc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 12:06:48 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%6]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 12:06:48 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Oct 2026 13:06:47 +0100
Message-Id: <DMAI50AJ10UC.16G4TCC3VAM0J@garyguo.net>
Subject: Re: [PATCH 1/2] asm-generic/bitops: Add set_bit_release()
From: "Gary Guo" <gary@garyguo.net>
To: "Philipp Stanner" <phasta@kernel.org>, "Sumit Semwal"
 <sumit.semwal@linaro.org>, =?utf-8?q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, "Yury Norov" <yury.norov@gmail.com>, "Rasmus
 Villemoes" <linux@rasmusvillemoes.dk>, "Arnd Bergmann" <arnd@arndb.de>,
 "Tvrtko Ursulin" <tvrtko.ursulin@igalia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Gary Guo" <gary@garyguo.net>, "Paul E . McKenney"
 <paulmck@kernel.org>
Cc: <linux-media@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>
X-Mailer: aerc 0.22.0
References: <20261021095512.1345191-2-phasta@kernel.org>
 <20261021095512.1345191-3-phasta@kernel.org>
In-Reply-To: <20261021095512.1345191-3-phasta@kernel.org>
X-ClientProxiedBy: LO6P123CA0024.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::16) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
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
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO0P265MB6773:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b38d357-c7aa-4f3e-22d2-08df2f6bc874
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|10070799003|376014|7416014|921020|56012099006|261009221227099003|4143699003|5023799004|261009223027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	SoOdpoJFlcJ8fP1GbOJ8AX6dloqNK0nqCzwUjs4A1Ym7fOS07GJK9SfLfGUq5HQA7HB3NxOnh986l3GayGOygI1T+ldd1aX0S2gYR9fsq5urz7Pltb9qm4k35KLsdQWgs80guhTwJMPDMJq8Q//+hzq92e4hnQI4e2B6t1yC84SlWyD0Du+ZMN1weOT4tiaTLiNw4TM4N/k01wohguqjTPNd1RdwI1wFi/isGO9qaLqlynoPUCwQw9z91Hx6Vxr0jjpAkie2FIv7Fbkx9NBeBEC96aQKxyT7HA59aP4Z1nUbSuWOiXrhSZH8Za0+0eD4//JXa/1Lzvm/kF4Ptvg51ti+n6SpUKLNN15m/MJWMhogmZ5P8fnLwOXEr/6IJfkUQLm1HBd/W7xSbjEnSOBvVF+zG1khJb48pnv8vDrlwvjA+G/++lB2XKJdKcwRYzNVX06M5sSHMD2uqXxlyH8IlOxiPmRaokeieB/VFW8bs1dgHuqP3LQ5t5k4kCOoOpKvfVVpFl+WVekex11h9Y79iMA+l/4xnuwlXFoY8vMVjqfcWY0mgs3+tV5TNiR6JKaJdZfElISMUwpvdYZ1LNFzQGC8DPATn2pEZdlWSDvZ37XNMAV2UNZrzn6i+H45Q8EX+qJ2q629S3/USUwCoUoCrfZo1zrH1PhVJbBv7I7giHQ1hZbR5th02NnfaLMt0YNK0up0MtEsWUzsFYdX7+OVsQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(10070799003)(376014)(7416014)(921020)(56012099006)(261009221227099003)(4143699003)(5023799004)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OEQyNlBSZHAwN3F2VldGSStFcW1vVy81V0FpSlpEYWd5RlovVGt1UnZrWTdt?=
 =?utf-8?B?K1J5d2h0TndIaU1JcFNXaHp3bERhTFFJMWFyZkVqb3BqVncwWUM2UkFkRXhW?=
 =?utf-8?B?b0ZVVU1OYStINjBWWWg0aHp6U2M1a0pYUjdwSnVoRUhmenE5b3hjclBKTGNy?=
 =?utf-8?B?WW1CZFVBcUFTTHMzQ0I0b0VzY0xQZFhXNGpMOThOc1AybTdVU3FBdUx4K2xU?=
 =?utf-8?B?Vzlza05FYm9qdWZKZnBYcW56UytPZTRYLzRFRmRDblgvK2FPdkRvV3dLZXht?=
 =?utf-8?B?RUREWnJNYUo4ZmVuNWd1Y0kxRGthVEZRTmQrdGMrL1RabjZnbWxLbU9pSEtx?=
 =?utf-8?B?cEI4L2ZYOFJsNWNLU1ZNNVdrbnBhaXBpSEJ4YlpkSWdlQTVNbG5Xdkx3anhm?=
 =?utf-8?B?UkdybnNnWk1ac0kwM0U3bitNTk1TRXdpaTJTRUlqVXk1QkoxdktOcDRHeHFZ?=
 =?utf-8?B?N2Y2RTkrOUdLblRpTnFRQWFkU1hiZnQyeDBaZDNQZWY3a3pWcHUvZVBHRmpE?=
 =?utf-8?B?WlN1cGtXcC9oVkVEcGNJaXA2MGtnay9uM0dIdWd5cmczemZsM0o3ZUFKOGxN?=
 =?utf-8?B?N01Hb0F0b2RrSDZ3UUgwRWNWSXlHSm5pcGdNRkRKUlJyMTVVYnduY1lYaWlF?=
 =?utf-8?B?L0o3cG5YZXJ2aUVMajUrU0kyMXIxWm9XbHF5TFVkSWVPdGFONDlSblNMb3Bt?=
 =?utf-8?B?RytDL2FhdWtnOW1EcWdTZFV6cXVGaXlRS0FGOFVjeHZtQ2ExMWx6TTJqZlRI?=
 =?utf-8?B?SDM0N1R1N3ZtK0hYZ0QxSFk5V1NWbnBTeVRPS2h3aDhkekRsZTBNMTNBQnlZ?=
 =?utf-8?B?czJyeXIrVEErRVVBUTNXVGZBU0hTK3RuTGd4ZTVVeTNsMHp1UStIQ2lmVmRH?=
 =?utf-8?B?U1M1U2pvOUJJcm5mZ05aaGZnNUg2UUpPUHpQd1FCaWY3VU02dGtNQkxMOXBL?=
 =?utf-8?B?NS80cnplQWF2Y0JPZXcrM0lqWGVCQlVNRTQzaGRkbVBhbFVVcmJsa0N0ak53?=
 =?utf-8?B?SlU1UWQ0T2FVcG9XcGs0ZFdLUW9uYklpeVNSZUJzMUJxd3lFQXFnU3FseTJN?=
 =?utf-8?B?VGhCMnlPMVVERkZXb2l5S3lPaHg3QnFEeGJFTElIRWlLWk9BVm1CUTQ5cnB3?=
 =?utf-8?B?YUd2bWlIVjB4S1d5eFpCT294NXl5T2lzNkVaRzg2QzltWTFqZVIxTGVkOTNv?=
 =?utf-8?B?VjlBNTJIam91YzhheitubzhrQ1U0bUxFOGlnakVCSWI4T2VlMDNpSDhVR1ZG?=
 =?utf-8?B?dUJFY1NRaDIvajRkVU5oV2pEMDd0VlFEbkQ1dnhmZDNEUVg0bjVFNFQyNkdW?=
 =?utf-8?B?NkJVa0dEZ2ZkZC9Ic2JQeGthb2d0N1ZpZXVFWGpFM3ZZT1dmM0tJTTRCekZn?=
 =?utf-8?B?dGZrY1RVOXdlZnZRUDdTaFFYMnRTRnZOR2Q1VHIrRklBcWVXZXhDWUx0aGt1?=
 =?utf-8?B?L1VaTHk3SGc3L1NSclBaYXNDRWZzcm4xbmhWOXZ6TGRwb003cmtQWFFHdmdr?=
 =?utf-8?B?TXpxSmIyeWNBS0YyaytxN29NRnN5Q0J4SVNQRUxwV0tyd0R4ekFMbDdmbUNE?=
 =?utf-8?B?TjBHb2ZpS0RuaDZyb2QxSU5wVENhWUdTOFZkdm4xTysrcmpQU1RtSUJoTWRX?=
 =?utf-8?B?NjF3OUlKOStFS2NnMnZUUllwWDYrNm9VSHoyZTZKTjJhSEJ6cHIyQkRuN1A3?=
 =?utf-8?B?SU9ITGhlNDY3QVNDYmJ3aDJoL1J5eXM3RXZmcEdXMXlxeW53Z0kvSHZLTjdU?=
 =?utf-8?B?ZVJuQ05LYithVXl1MXc2L05QMTlFNTZYeDBOUjNPZ2hpTkRDK3NzYnZsaEJF?=
 =?utf-8?B?eERwSVFuWjJKekc1TFNENFU0MTVEdFVjT3BEUityN28vS2VqNzZha2JMQmdw?=
 =?utf-8?B?aTNwaDkrY1Roa0xlekc0SzFuUFRUOVVSaFdFWUtpM2VnVGtkM2RkdFV5R25J?=
 =?utf-8?B?Uk9wNTE3Skpqd2tGMGxKcHB3clo1QmxjWkZPbmI2eU04RDZucTQyaDUraHZ0?=
 =?utf-8?B?cXdHS05qVis0VDVvZmRpQzhaWEZ4SDB3L3JYZjE4WG5DMnRVZTkrNGsvTlBh?=
 =?utf-8?B?MytYaVFZdmdvUVJoS3J5NlQrMzM3c09IbExyZC9qYmYyaHU4aVFyQlE2MHFM?=
 =?utf-8?B?UkVrLzRzeW5nSjUyaHJiZGRRbVMvMG8vajViRjVpRmlWeGRMbUxwNlBCMVJ3?=
 =?utf-8?B?TmpYSGw5MkN6UEc2NlJtdW5kbDg0STdaNUM1bUxJM1dLOHVobFo0Q09KY1pZ?=
 =?utf-8?B?K21hTmhkTU4rMWRUakVuaDBOREJtMGFHSFdpejZmZkxnVFlNMkhyOExUamdM?=
 =?utf-8?B?eStzZVkxUWYzZ0NtbDVkNnA0WU5vOUlwRUZLaUVPcnZ3QXJhU0YrZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b38d357-c7aa-4f3e-22d2-08df2f6bc874
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 12:06:48.2245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fsUgfz2Bmr+viVpUOaq+F3Vc1tcfKyWjr8D80z/4HjunP4JI8KMYTcoRRwt4+qXoer9oNEE9R4mUs3OFA/HlRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB6773

On Wed Oct 21, 2026 at 10:55 AM BST, Philipp Stanner wrote:
> The kernel already has test_bit_acquire(). A set_bit_release(), however,
> was missing so far. It can be expected to be useful for parties that
> need release ordering, but not the stricter full ordering of the other
> bit-setting functions.
>
> Add set_bit_release().
>
> Signed-off-by: Philipp Stanner <phasta@kernel.org>
> ---
>  include/asm-generic/bitops/instrumented-atomic.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/include/asm-generic/bitops/instrumented-atomic.h b/include/a=
sm-generic/bitops/instrumented-atomic.h
> index c010d54275e4..fb2d1472fd4d 100644
> --- a/include/asm-generic/bitops/instrumented-atomic.h
> +++ b/include/asm-generic/bitops/instrumented-atomic.h
> @@ -72,6 +72,20 @@ static __always_inline bool test_and_set_bit(long nr, =
volatile unsigned long *ad
>  	return arch_test_and_set_bit(nr, addr);
>  }
> =20
> +/**
> + * set_bit_release - Set a bit with release ordering
> + * @nr: Bit to set
> + * @addr: Address to start counting from
> + *
> + * This is an atomic ordered operation (implied write memory barrier).
> + */
> +static __always_inline void set_bit_release(long nr, volatile unsigned l=
ong *addr)
> +{
> +	kcsan_wmb();
> +	instrument_atomic_write(addr + BIT_WORD(nr), sizeof(long));
> +	arch_set_bit(nr, addr);

This is just wrong. There's no code here that gives you the release semanti=
cs.

kcsan_wmb() is just an annotation and does nothing. wmb is also not release
semantics as it does not order LOAD->STORE.

Given that set_bit is a relaxed RMW atomic, you can implement set_bit_relea=
se
with just

    smp_mb__before_atomic();
    set_bit(nr, addr);

Which should be correct, but is too strong on some architectures (like RISC=
-V),
becuase it will produce a full MB instead. So we can either add release bar=
riers
(hint: I really like it), or we can add arch_set_bit_release and implement =
it
per arch; on RISC-V for example it can then be translated to amoor.rl (whic=
h is
not being produced by any existing bit ops).c

Best,
Gary

> +}
> +
>  /**
>   * test_and_clear_bit - Clear a bit and return its old value
>   * @nr: Bit to clear


