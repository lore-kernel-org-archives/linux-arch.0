Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020118.outbound.protection.outlook.com [52.101.196.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC6D1940B0;
	Sun,  6 Sep 2026 12:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788698037; cv=fail; b=em77d2pcNNU79nQbO5ZWkxk+1+KYcGh2fog+0p7tk0jsn0Qd5QkjMqJ3/VBl6qUqqN63iC5CQy8j+UcOrg8z+yJ6G3P5C8UT25nQMJhPkRXEiQ3YuWKGmyHzYnkMTSvtANZ/3LGOXG9NF32dCfNjWy4VzKsk1XabYfWIdVz3S2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788698037; c=relaxed/simple;
	bh=mMkjlmh2T4Gc/mU1Fii6aYRax9IjbBMjXDejLO5E9UA=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:MIME-Version; b=mhc03e4wGVSon8YFtMM5G4CXpk7YZITg3WCrQ8u6KTxHz58MBTl/t1hylHuLS84rhuUin+wrrN9P26w9lRNLM/jSQsAIr5RNnAsOLROdA4Bwl2dce6cyC/xi36Mh8XYPUK8omqcf6+BHohDFhGJeFv+V41FiD4K+tuo18C2VmY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=tk/9XJdb; arc=fail smtp.client-ip=52.101.196.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="tk/9XJdb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HMXvWmfbtMX91cjNqD4rhSyKgMivHRs1srfXkPAiCYjr3ILI+P6lS2HPWF+yYM6hHNDa85gV+DvyL+nNTTMDMSCuNDKKtlb/tARXBX249jQHFMXcPhZNCfUrGglczCqA3rwtCnAsaruKbhO95W5UR77FwyKx0MbYIJVvnQ8pvDTxfsZpHby6ysGKsd8o8jWRRaEd5UVnIS7wZjJyYqsTIwacU3xHLwV6LoNYbPCfjjK6uAmtAVtPwJI5Yfh1rIhDUDOQ2a+ODIp+09FEm0+qq4Mq4jhX7OoYApTCX2iSUrlr+SWFfaMVguJfX4mGF6hjCJvXssOlE8AIOyZOUR84yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i4w1OFscw1NjY1uW21JWvlR2aOYFdIXpniTPXRhpJLo=;
 b=omDmyCgTdZCmL48gISu239pr6ntxrq+wWxdGbQ5PqBnDkCgYSiDIg4DYhjlLIhdHeGXc8vsycimwUSr8u6c9iWeQpFLCDqxFqtWup4sjW+dlTqqlbgMIVz+eMG6q2knhHIMStJseM1QsBItDQDARzKllqWzVRoNBD8YwT01PPrXbn8srNkBKY/Cxq2Y/17q4IDXuw6EWhntyYSUXhaYSTE1bTHIaKpez3D2jnJvmlvcCPEA+QuJAaY8liwU7JJoysMC1Tvhhao8jYseA2IWzHGMV4agRqsGUL+arETvS3ERIkr/qlDY8JaWewN+LFUarJyMp7VvCTQTaNAL0Epwu/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i4w1OFscw1NjY1uW21JWvlR2aOYFdIXpniTPXRhpJLo=;
 b=tk/9XJdbu0GBISG1JM7OMNqHiqlCZ/JK1H6BIKrZWClHlVuyheOSczTol4l5BwmivUWlPqyguSogCTA/gt4WhF8InwZpzRZJsyCa3HJPJ4cihgDf0lCj6KT6sApdW+5NjjlhGhlHnxX+xrvE1zuKG2Ip/MMhktaSh95rEBC5b8s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO7P265MB7639.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:398::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Sun, 6 Sep
 2026 12:33:51 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0382.014; Sun, 6 Sep 2026
 12:33:51 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 06 Sep 2026 13:33:50 +0100
Message-Id: <DL88J7DRO10E.1QCYWPWBLE7QP@garyguo.net>
To: "Arnd Bergmann" <arnd@arndb.de>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Aaron Tomlin" <atomlin@atomlin.com>
Cc: "Luis Chamberlain" <mcgrof@kernel.org>, "Petr Pavlu"
 <petr.pavlu@suse.com>, <da.gomez@kernel.org>, "Sami Tolvanen"
 <samitolvanen@google.com>, "Peter Zijlstra" <peterz@infradead.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Masami Hiramatsu" <mhiramat@kernel.org>, "Boqun
 Feng" <boqun@kernel.org>, <neelx@suse.com>, <da.anzani@gmail.com>,
 <sean@ashe.io>, <chjohnst@mail.com>, <steve@abita.co>, <mproche@mail.com>,
 <nick.lane@mail.com>, <rishil1999@outlook.com>, "Linux-Arch"
 <linux-arch@vger.kernel.org>, <linux-modules@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 0/2] module: Extend module_blacklist parameter to
 built-in modules
From: "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.22.0
References: <20260903185557.183224-1-atomlin@atomlin.com>
 <20260903132924.7a4d1b84791d30c706b394a1@linux-foundation.org>
 <ultg4rym4phqwqrbuz3hqtlse2lgafxebx3un7s3tdht7rz5xy@3ckauomiwqsy>
 <20260905172817.e367c940d750ca3e8484fef9@linux-foundation.org>
 <3cee4548-0ae7-46a7-b437-bf84e5c155ad@app.fastmail.com>
In-Reply-To: <3cee4548-0ae7-46a7-b437-bf84e5c155ad@app.fastmail.com>
X-ClientProxiedBy: LO4P123CA0679.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:351::12) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO7P265MB7639:EE_
X-MS-Office365-Filtering-Correlation-Id: 189e23d4-e9af-4abf-10cd-08df0c131b6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|10070799003|10067099003|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	urRFfxqgR0bNFf6kxSrUqFaA7yglxBa2AtqkMM8EzQckwoURWCLHgpW+LCa0wy03R6D33cGCvasdSyc38cDul9iLrPIhTLmaPULwUut29z4OPJzV+rsG1J/6Bcd51CI44Zx5XhzLkbA6oGOIiP2rHXlaJIAR1zalKKyq2gR3S8NKYPxZsEDMhPJ1vEH4iUnlsNctIETj8GrfbUJULhHk8g+RhqVSehRtQyFkKFzQgTg1W6RT1JdISsD0o4MZ6BHvonHjd7S6sZJRZvEsFTOdhcpod+a/rKnLvurP/IvdCnGlcyRypxOtqSU6GMrlbhVFpkgDKz2nK6bMEBP712hXEVlfXv4A1hqVC1T2/SBU1zhZ8/hv/CStyzjD2reEoJwu590jfJS6uyn66Nz4t/rnQ9WV/yLAJIiuHu3PdMeWhZR9exIzpdJR1ACEnkYadfQFuk7ZPDybz218m9RJYxQ4ueCx2IZhYme1Cv+rb1DD3OUK3S5SyG9lly6Q31pi97kdNtj79UMKbSlGKQd8Lqr2OtZMiGyvth2r3A+j53yLqAEAWX7yCbMZI9am3lm/mwiPWsvONo60vxP+XHVtKYBk7fYF2+FR4YuDbRTSDh0V4d0HC7tc/xlancJyWU1Ynrgc3rpp91bmzdrgZOTDnoarzxdD6K+qvszArSpMfHUWfas=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(10070799003)(10067099003)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cTBxekt0ZXJQMlMxYm41amkrRzQvNk5qc3NzaTl3aUVlRzlaenVZNVIrS21s?=
 =?utf-8?B?RFFIMisydWFTamU2UG9Kdk5kZDNsVlhkRDR6blBycEVqMFFmNHFLN09kd3pF?=
 =?utf-8?B?ZkxLTGphY05QQWxSOWRWU2hRWEtTOTJmTDBkekQraXlzVXlkUENzbGtMaHJO?=
 =?utf-8?B?YmdhVkladjFwN0hIMXlYWWRNd1RhcEwrMzIra3VldVdMOEVvczNkeHp0bko1?=
 =?utf-8?B?RDlVZVl2MmRPaytwcm14bWd4QU8yMGlVd1JlTnpNMUc5YTR6VzZFSWlwdytQ?=
 =?utf-8?B?YktEK05DYWVocEhIV2Y3VktEUEY1ZWY3TjdJdlpRZnAvaUFjQzBzYmEyRWZm?=
 =?utf-8?B?bzNuR25iOHl2czlvdDBCUTI1Q2R0YWl3N2k2UmxEdkNVOGNscWlGUzdIQTgw?=
 =?utf-8?B?MXRSUEVJMm4veW5xMTltM0NVUFZhVE1mYVloK1d6dnBsUVBIZmFTUmQ2MXRP?=
 =?utf-8?B?NVBjb04xVjY0dndUSkdDa1RxYmcyNWZqSW8zdUszam5YSm9TYTYwTEVBekZ4?=
 =?utf-8?B?ajFkZzJ1SXpha3NVRDlXZlRKNUZTRjZkcUVKL2sxbmVwNy9XMU13VmpWaW5q?=
 =?utf-8?B?d3dUelZuZW5nWjlzWHRER2tmbW9JMTUvNUxhdzdvZTZ5Z2RrdmlPTm5IOHVP?=
 =?utf-8?B?TUprYXhlK2NVOFo2KzNMSlorZDM0QTBPNXJyak9hRTZXbjdxZXlYai96eXhN?=
 =?utf-8?B?VlNHb3RCRjJldUpDUGlLTmExZlY3WVBrK21yNmNhMUtYQmdHdUVseGRZeUpw?=
 =?utf-8?B?QWZLNkczWm9pVWJKdWMxSDd1ajBFN1FYdVJJQnI0ekw0WExoS2dGcGZWNGoy?=
 =?utf-8?B?SmdrUGhaY1FGOGEwQjc1NDE1MzU5Yy9hUzY1MXZmZkxZTTdGTWttS2kraUtt?=
 =?utf-8?B?ZnVDZktFL0RlS2lMRDdNNUkwSUtUV0I4Q044UXRJUFdXT21LZyttbVpFak5I?=
 =?utf-8?B?TnlocVM0R09HRzcyM1ZTM25CTlJQL1o3UnFXVWZYNUpYN1BaUkxaVEp5Mllp?=
 =?utf-8?B?SVJzNlFDTnkvdlpSYk5TRlBMSU90TmEvS3VCbmYyelZCVkpobFVCREpPbEYx?=
 =?utf-8?B?bEVuVFBYZWRDRGhEMVplZWxaVDFDcXV4Zmdkc3BxVmpYZWFIWkJITXFWcG85?=
 =?utf-8?B?Mk9mSXhvUEMycm9tL05HUURQVHJTSjE4Slh1YjQwVUdiODBrVHNyTHJka1Zh?=
 =?utf-8?B?MHk2emlPS2svSFdaQTRnNStzNVRMdHcwUk9mUjYrbXlZaGVwOHVwMStKTTlz?=
 =?utf-8?B?S0p0NG5JdndaQkxvSnk5aUhuTUlZTzExL2V3WXFQMXplbUhIdFEzc09pVDFC?=
 =?utf-8?B?emNGYWhnSzdQOXdHbHkwZk9tWUI4OWV1RHdnNldlSm1kRzVQM2ZOcGZXNWZW?=
 =?utf-8?B?S3RubndJYjgxU3ZXeGt0QXdSOVNHMmY0T2ZmQ24zWXpqL0NUY2NXM1hvZUN5?=
 =?utf-8?B?eUNqSkJvVkFOUDJBZWhua3l0OUNBenp0bkU4YTdTdWFRUGdPOENWVkJxQlht?=
 =?utf-8?B?UnROOEpzYkhIY2NXRlJTYjFkQ3cvaEF3VE9kTlRoczQzd212czRLV01CdGxj?=
 =?utf-8?B?VGd6dUhGTGRKWVlOQVJmWjYxQ2s0RG05NU8weVJzcGsxM3V4ZXdBbENLSmpK?=
 =?utf-8?B?MGVSWnFRNCtxUEZ1S2ZYbFp5Y25aRytBbVJVNk1Pck9NSHE1VGNuVHdWWEU3?=
 =?utf-8?B?NkpEL0F1RHVZMEh3L09STnVCSlM3TmdLeXVHcVU1VEhEa1g3TjhnZUl1VGVO?=
 =?utf-8?B?Y1A3TkVjWXBxcUJCbitUYU9WSDduZWlBUGY0ak9WN2kyNXQ0NlRlMU80Rk81?=
 =?utf-8?B?OHl2dGRrMVJ1S0htaWtUK1Nwc2lka25sSkd6aXBHOFZjWmw1c3dDTG9qQ0xM?=
 =?utf-8?B?Q3ArdUs5QzVteUtqV3MraSsya0pRaWp6YmdTV1Noc1greFJwY0dxZEpmb1p1?=
 =?utf-8?B?SDdldklJVjNZMFFGaXFlOEdUaXJtNEFiZ0lDK2tPdkdpUVNmNTBvcUw1Q05B?=
 =?utf-8?B?YWUrR2RJZG16aXBWUnpldjJQTzNpUmw1cXUrb2ZFSUNYaVlVem9JUVdxRkV3?=
 =?utf-8?B?RDhnQStjZkFTU1NuOGFGTWdqd2wraWNRaVBSZDI5NEtsdEtpMGwvOHhEeUk1?=
 =?utf-8?B?aUJhbTlJMDZDRC9DSkFLdTBkYnV0a0Q1LzZUUXZ5cFh0US9sQi9FQXdicGZU?=
 =?utf-8?B?dHpPNldCZmF1eDJUMVI5ZlVrYjQxR2RpOFhwcDIzRzU4aHNibkJIT015bVor?=
 =?utf-8?B?RWhZRjNCNVlXdUZxV3RKK1RmaWIweVZxaFpuVXZZZmdrd0d3allLZC9pTUM3?=
 =?utf-8?B?Y2tOTUZoTE5WNThtZHJyS3c4Y3RvZXgyVGVabUNtNnl0Y3NubktOdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 189e23d4-e9af-4abf-10cd-08df0c131b6e
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2026 12:33:51.4757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4g+UARbZkP9qsJece8T1rsjzYZa1lSX1JpkSsQx0ArWDbo0z7LppT8ewbuIxXZd6+DyC2W/gF39C3mnZptdvTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO7P265MB7639

On Sun Sep 6, 2026 at 10:56 AM BST, Arnd Bergmann wrote:
> On Sun, Sep 6, 2026, at 02:28, Andrew Morton wrote:
>> On Fri, 4 Sep 2026 10:59:38 -0400 Aaron Tomlin <atomlin@atomlin.com> wro=
te:
>>>
>>> In summary, this patch brings parity between modular and built-in drive=
rs,
>>> removes a pain point in boot-time disaster recovery, and provides users
>>> with a predictable, consistent interface.
>>
>> Really helpful, thanks.  Please add this to the [0/N] and maintain it.
>>
>> I don't really know who are the potential audience for this change, nor
>> how to attract their attention.  Greg might have some insights but he
>> wasn't cc'ed.
>>
>> Let's leave it a week to see if there's feedback then resend with these
>> adjustments?
>
> FWIW, I previously asked the same question on this series
> and still don't find the explanation lacking. Obviously,
> consistency is good, but the added complexity doesn't feel
> worth it here, given that this still has most of the same
> problems as the existing "initcall_blacklist=3D" option [1].

Yeah, I like the better consistency, which is why I propose unifying handli=
ng
for both built-in modules and loadable ones in
https://lore.kernel.org/all/DKNWEO3BOUOL.9COZBXZIGS6A@garyguo.net/.

IMO if we can unify them, then we get something that is both consistent and
*less* complexity.

The current solution makes thing more complex with only apparent consistenc=
y
(i.e. user observe the consistency from kernel parameter, but the internal
handling are two separate mechanisms), which should require a very strong r=
eason
to pursue.

Best,
Gary

>
> I think patch 2/2 would be fine on its own, but for 1/2
> I have yet to see a single example of a real-world problem
> that could have been solved by this but not using
> initcall_blacklist. In distro kernels, almost everything
> is already a loadable module, while users with custom
> kernels could easily turn off the drivers they don't want
> or disable the initcall by name.
>
>       Arnd
>
> [1] https://lore.kernel.org/all/78ec1da5-11ae-4c35-a08e-cc88a5d083f4@app.=
fastmail.com/


