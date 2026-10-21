Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.101.135
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792585470;
	b=cXfvSToysED58sJBQj9aXanQEjA/mw5rpA7CXw7YtalQWrjgtCARjWaIpPVJN+HNNU7v
	 nzS5hv39RjxsNLUcsFHoMTTXb9KsE+H3uvfE1xKilZpZlj1j2VQ7AXWahvBAxJx+39HYd
	 Xv4aCO89D8c3JorNyiD+9SQgaW4p2YPz5XYDQKTP5j2h4tklCTRVA4v30FeWFY840hNSw
	 A6/YNuoaIgoKuv7Phc9Fp5f/wpxCfRvhxosSsmSv6O3a2GoPVsHR4x2urBJFIK13Bp84z
	 oFDkhjoZPZs/i4pEHrpLecmOXnm2PLYb2KiXgeT8zKmcTOfdJBxyPygkUI8gJgAtZuQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792585470;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Cc:Subject:
	 From:To:X-Mailer:References:In-Reply-To:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
	bh=40SwkDKo3tES88PTfUDX/yfqgk+oXXMktbCFBoqWC0g=;
	b=4CuH98O4rhLDnHoxHf068lZ4lEcYkJLE4N3YZObK8LXhs9ngZ78LBcIjkUWHORAYMUmt
	 JbdCbBOaC2/+FkTU8UezsfS6Uvdu0lEmi/BuyrTB0QpEgglR2JnE36sGR+Nq7115yvbCF
	 UKf2vN8EKhxCqiGwyUDt58I5277mj0e9+OGfWHFnIyaIXGW1HYCOOhUuiD4MVm/W8zp+C
	 MfQElEUnJSrGJCFBYvOW9/g34UVTNVbaZaVdMfqt1b2aQKt9I4ls1IwL+RKzZwdGsEE4n
	 MWu/SPEFSjvjQuZjDFLG8suUXm/RbSjAo/3/R7vp9+eeR7wpmmUC6LNp/AN34MGawhg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=garyguo.net;
	spf=pass smtp.mailfrom=garyguo.net;
	dkim=pass header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b="TeMYwz/1";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.101.135
Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022135.outbound.protection.outlook.com [52.101.101.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32800606A31A;
	Wed, 21 Oct 2026 12:24:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32800606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=TeMYwz/1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oP5XodsvapJS1cYHohtztkUna+QV84NMYvO/RybihAFC9Y9D+/ihyPoOEAA4YFv/axK/AUoKzl1HUefCC9+zcZz6/fF6sCo0UHe7mHA5VG13FfpLuCQ1Kx2P11BphEyqUrIZVynw5PZYDDz9E5S5eXcfhpWBqMuIsOLhv/BUha7173unDZ/TZiZsZSfO4FM7DasBMJ/rgMKrfZYo67mRGAW75FOz0KpGrH3L400bSRnqyxhievEGFpWowug25jZFLnMZ3KysqBHlHA9xI1jZM/e+Z1FoxjHCZTIIVWDMnCGUeiYOEQ0l3lAvqq2tL5BOAN49G4kTYMhj2KWvatB5Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=40SwkDKo3tES88PTfUDX/yfqgk+oXXMktbCFBoqWC0g=;
 b=lZ33MnziGrAlr3+McVdk4gN2UNEJ9PymU7sRnOuVZmmA62DEGhA5ijoUY2mDhmLMfHXI19uoT7JdHjQ+anrvMOamrMZYLmjHfuB9tAv3muljA2IziFHiolyPLXy2eMaUjXrZ8Gq5lijdSsoBxHGmtVR0iTE4BvQCDqxz4UpN34th0w4a6wmgdsGwm8ZO9QF8FEZjIrhWTiZT896h/zuNGhoh/JNaii7NxkbthuSP3/CNncgWtNOdgTqzJmm2IlFRBiU/TH87yk4n0rZOINQxVDhFZCcoAAtXXt663z5LIPbfuy/Ut05W48p0TIRmlSb7wIqEuOEsRI7vHrKxNXKKyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=40SwkDKo3tES88PTfUDX/yfqgk+oXXMktbCFBoqWC0g=;
 b=TeMYwz/1Sg3y5nz9ViOqUy9Rby6XWPsEoK4efKAiKwdB5ltYzbaOd4zRoXjKfhhs21NPppx+Tw6ap6SJatzcFeVtYdu8MpO7m7mfCC5ay+PS5aiesw0LVb+QQuKMdPkJMCyfaecq2lr9ETBRgr9sPIXr7GAnVjAOIHAMj0UoAf8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO8P265MB7831.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:3b3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 12:24:26 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%6]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 12:24:26 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Oct 2026 13:24:26 +0100
Message-Id: <DMAIIIJ57A3N.GXLM3L5IOAPL@garyguo.net>
Cc: <linux-media@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>
Subject: Re: [PATCH 1/2] asm-generic/bitops: Add set_bit_release()
From: "Gary Guo" <gary@garyguo.net>
To: <phasta@kernel.org>, "Gary Guo" <gary@garyguo.net>, "Sumit Semwal"
 <sumit.semwal@linaro.org>, =?utf-8?q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, "Yury Norov" <yury.norov@gmail.com>, "Rasmus
 Villemoes" <linux@rasmusvillemoes.dk>, "Arnd Bergmann" <arnd@arndb.de>,
 "Tvrtko Ursulin" <tvrtko.ursulin@igalia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Paul E . McKenney" <paulmck@kernel.org>
X-Mailer: aerc 0.22.0
References: <20261021095512.1345191-2-phasta@kernel.org>
 <20261021095512.1345191-3-phasta@kernel.org>
 <DMAI50AJ10UC.16G4TCC3VAM0J@garyguo.net>
 <56108c0554e92191d2678a407d7d8102b9b304b3.camel@mailbox.org>
In-Reply-To: <56108c0554e92191d2678a407d7d8102b9b304b3.camel@mailbox.org>
X-ClientProxiedBy: LO4P265CA0210.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:33a::13) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO8P265MB7831:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d284c7b-26e9-4e17-1277-08df2f6e3f49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|7416014|23010399003|56012099006|5023799004|4143699003|6133799003|22082099003|18002099003|10067099003|261009223027099003|921020;
X-Microsoft-Antispam-Message-Info:
	2okQ2gEz10GI+z2nlTSgrYjwzTUKBe1glOCIbdKWJKBJv5FLfV4e268uZPGM89LMN+DngEJehpjKqyJp4otzQuruGR+KzHncSQev9hEBQO2qfb6W/nL0P73mvjX4W6y/vEn6KpvlgJzOiNI0hF45u2I39gEx5se3bt80m/6AU1CZhsak0j4cYaIyO5VR8tno2hrC7eVJEFvl21DbgUwCa2zZBI1f9EireUJHqVjxrUjEGvWaOxDEihz+VRnOycpzRxG+jQEmrrtuPVOCR2Pe09E+93PLDUObTHFJ3bC8rlNhNbX+kCz8w+2c2kLBLQmo373Ozl8U6nap7mDtIb3Oy/yL4XRtZdGFS4/8G14mgxyHXF9eE3TmPHyPiW4Erv3GE6IyHhi1/zjlof8jFgiIjO6aXLyDFqm0IaaEFGsbUeSfbkc23jkBbpBNqPtfzfuQphq6EW+BliFpiI0c9hHeifCBlmhBNmDHT9Za0bM6Jg1qDPhtUu9xVxkBwfpxhULDecbDIzBLsfZSOQDONDO7DqElFZi3rM0HZjYbEvttq+5xc4Q2BB4awQ1M4rBBg0rZy/hvFKBPJazHuqGtI2+GVMBKMrQph8uu6vd/NbyGq7KNu/j96awMu7IJFmKgOidG2KCVy2eqrj4f0ms50WqWMhSBnb/R9V+grZjNjLcF5vZrYjRaFb6YSDabpVxSk+eyoryUHEqxDbz3/+hnuOundA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(7416014)(23010399003)(56012099006)(5023799004)(4143699003)(6133799003)(22082099003)(18002099003)(10067099003)(261009223027099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?enliQW5iS3BJb3pGcmkxUG1oZDh3VGVmNkRKZGo4VlpzVGRFUGVFVE0yaFNr?=
 =?utf-8?B?MkJYdE5LYjhscC96QURTTmx6eXY4SlJpcTB4cHBrNjJFUUdpRUM5VFlJejcy?=
 =?utf-8?B?eXE4R3BBM0dDZkltbS8rRmhZMHVnZzRFRmRoNVpEa21tUGl3RWxBQkVqZTBQ?=
 =?utf-8?B?bWhjL1F2anp0QWdvUUZJb0hGS0lEL2RuWVRaTncyMElGU3gxeElHb2E5aXhT?=
 =?utf-8?B?cTBTUHkrN1dndmJIRGE2MnorRW9WNThZbFhpOGhMM3hjZC9hdURmYzBRa3Nk?=
 =?utf-8?B?blhJT3NvKzgwMTY5MTR6TmRDcysvaUQveEZXNTFrdkZTTE5mMVkxTi9ydEFK?=
 =?utf-8?B?UFpFeENoeVEyVzJkRGMzbUE5cVJxNHh6RFJocDBteEk1OWMvbWpWRUdCdlZr?=
 =?utf-8?B?akFQZG50TUlXa0NxMmJ3YkkrQXVzVS84c3p3bGdlMkNOQUFJWFVRTnh5QWdW?=
 =?utf-8?B?YU1lZEZDaVJ3V29wVFIxN3BQa3RVa2M4eXpoUWRDbHJrREo0NXZWbzg2VW9z?=
 =?utf-8?B?VDVVTVQ0M29iQXh2SHpuaTR6YTRxbENrUFFaN1I0cE82RzdLQk13TWZZbHpU?=
 =?utf-8?B?dTVyR1R4TkVNb3hUM051ZDkyUnlIV09DUnhWa2lQSEZPelROVFdrbDJudlJv?=
 =?utf-8?B?dVBBZzRzQnF1Nm1XZ3RTRnN3amd2SzluMUxZV1podTRtM2ZZUzI2dmVSb0pF?=
 =?utf-8?B?dWVxNHZFTVFpaEdLUDcyb3EwMUtETDBiTzQ3NTdjWmdUdTdnTjhOWlFFYTF4?=
 =?utf-8?B?RzYzcWF1MkNuTjJGWTM3UU96NkE5d3lzRE9jNzJFRk9PcXNPZmtJaG10NEZo?=
 =?utf-8?B?c1ZxdG44SFpSSmdvUi90bXl5MnZQdGxPY0l4NTNUUVJSdnVScFA3SXEvbndy?=
 =?utf-8?B?UUxsS0NIaWpaTU1JTlNqanJpNU5NL3NvSC9MTDlCODJ5a2F0YmJrNW9sR1Qx?=
 =?utf-8?B?ejZoaXhRYmI3YzVwaHBva1QvWFYzbUk5UVc0MGJvOWdVNHpIZVFTWUVOaS9H?=
 =?utf-8?B?eFRLMjBGQjNndjRXM05nOFhSaS9mQStndTJhbG5mWDdiaWRuMFUyMFZKbzZY?=
 =?utf-8?B?UVhEOTh6SC9YcUJmY3hoVjBzd0V4Ukg0L1d6a1FYSnFRQmJCMnR6aXBjQjJO?=
 =?utf-8?B?bzRnVFMrNHpXTmhNV25aQjRjdmhEMFpzNG1idzYzdHZjMTdmaGR0SGNCdTJp?=
 =?utf-8?B?THMxaS8wNDdJM203anI5YlpnaVNyMU1sZEFnNTl1VGpLSFZ4aEFTWUdLT1FV?=
 =?utf-8?B?MHlHZUxyZVo5YTFZM1lwUG5UMzJXcjZMS2lsRWFKZGdCZ3lGSWJiSUtGNEhk?=
 =?utf-8?B?TnVWYzN4T3ZEYVY1bkxKMjZvUUQvaHAwWnpUM210RFBFTTQxQTdLQm40WVdk?=
 =?utf-8?B?UzB5UU1ma1IyeU1tR0JaM092RTFOeHhDdW9NalpEWjBORnFWdjNMTTE3UkR5?=
 =?utf-8?B?Tlg4dWpvYUczQlZ2NlBlSWdUM2lqbjFHUytobUF0ZnZBdDZMTm13K2IvWTdo?=
 =?utf-8?B?eTIyUFE5NXZ0Rk5sZDc0NDFXZ0hadjBVQTMxNjB5WW0rNG9LMC9pZEY4RVF2?=
 =?utf-8?B?R3E3RTNkdW1la1FDVnNYZVphcjB6TFRxMHY5MENFbEd0K3FOWFN4eDZhY2VN?=
 =?utf-8?B?RS9Wa2VtalUwdHk5STR4RllYdnF6UEtQSm5qTGVPN0tzUWpHRFVTVzd4cnZN?=
 =?utf-8?B?UHdqb3IwTC9KdDdSUVJmNC9wNW5USjFUR0lCamhhejF4SUZJQlhkN1FGWlky?=
 =?utf-8?B?S1FuVXRxSjMrWXRKNkt3TWY4cktaR1YwV2hMUW1UVDFyRUZuRFZIeis5OTM1?=
 =?utf-8?B?MnVySExFRTFpbTdEWVlJNEw1QnJCUHpMN3JlU0JrQkdMUG1NVW9td3ZTdXp0?=
 =?utf-8?B?T0dBNWV5ZWZOT0lHcENUT3U4dmxYKzhrai9iZmZaQlQ0SXYwU2MvOUYyUkhU?=
 =?utf-8?B?QXd2WGRpWWk5dUlhQjA4VmE3NFhsK1Vtend1bFZLaGVQQ1lwdHI3UkphZHdG?=
 =?utf-8?B?RVBxejA2eitMSlJadU5YT1VpMW9oUWxnamJvdERDOTBjdDB2TGR3QmRvYnpF?=
 =?utf-8?B?dGFHU3VyWU1XR1RNc1V3ZWVyTGJoTDNJc3B6MEJrQUtsYlFQakVRaHUwSzFI?=
 =?utf-8?B?N1R5Um9vcVBuV0pIVDl5T1orcDNGdDJNT1lrMW04aGpRbm9sYUJDTEN6cU5M?=
 =?utf-8?B?aFg1eHJZeUcvTWdMdW1FVjZRYnlGYncyT255ZHhLV1BKTFVVRmc4RUt1dUls?=
 =?utf-8?B?bFNFZTQwNERvWmVOM0srN1JVYml2RWJPd2krOTZqMXFiQzFkL3IxU0RUbXpT?=
 =?utf-8?B?dXN0bHU1NEtSWXVpMEZsOVMxbkZjNVpEQUlnMmc5eDJ3V3VGakZlUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d284c7b-26e9-4e17-1277-08df2f6e3f49
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 12:24:26.5356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: weWK80ahSgSW9DbwmLk2/8ZckpWePl0YJSAF8JPdFhX/XjSaANK3x0v+uX4+npOHBsziYXrnF7TjxuQ4jcp2Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO8P265MB7831

On Wed Oct 21, 2026 at 1:17 PM BST, Philipp Stanner wrote:
> On Wed, 2026-10-21 at 13:06 +0100, Gary Guo wrote:
>
>
> [=E2=80=A6]
>
>> > +/**
>> > + * set_bit_release - Set a bit with release ordering
>> > + * @nr: Bit to set
>> > + * @addr: Address to start counting from
>> > + *
>> > + * This is an atomic ordered operation (implied write memory barrier)=
.
>> > + */
>> > +static __always_inline void set_bit_release(long nr, volatile unsigne=
d long *addr)
>> > +{
>> > +	kcsan_wmb();
>> > +	instrument_atomic_write(addr + BIT_WORD(nr), sizeof(long));
>> > +	arch_set_bit(nr, addr);
>>=20
>> This is just wrong. There's no code here that gives you the release sema=
ntics.
>>=20
>> kcsan_wmb() is just an annotation and does nothing. wmb is also not rele=
ase
>> semantics as it does not order LOAD->STORE.
>
> What are the other functions here then even about?
>
> /**
>  * test_and_set_bit - Set a bit and return its old value
>  * @nr: Bit to set
>  * @addr: Address to count from
>  *
>  * This is an atomic fully-ordered operation (implied full memory barrier=
).
>  */
> static __always_inline bool test_and_set_bit(long nr, volatile unsigned l=
ong *addr)
> {
> 	kcsan_mb();
> 	instrument_atomic_read_write(addr + BIT_WORD(nr), sizeof(long));
> 	return arch_test_and_set_bit(nr, addr);
> }
>
> Where does the "full ordering" come from? I suppose implied barrier
> then means it comes from the architecture's implementation. But what's
> then the purpose of kcsan_XX ?

It's from arch_test_and_set_bit.

KCSAN doesn't see arch code, so the kcsan_mb() and in fact
instrumnent_atomic_read_write() both are annotations to indicate that this =
is
conceptually a mb() + STORE for instrumentation purpose.

Best,
Gary
