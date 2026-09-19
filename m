Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020083.outbound.protection.outlook.com [52.101.196.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60552BE7BE;
	Sat, 19 Sep 2026 01:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789780689; cv=fail; b=olYHYtkAwI1ER5ZU7r7gKO4815o+LkehPvUANvDctOkhrIUSLYIRIWFlJV89jecrd8372U/WA+XpbmonBOJnusjFr2+vDwqMKs+B9a1BXuKEfmmFxO6ztjlB47Fnv9ZsngPDVZlkCu2FAULUMmmi3Kqjp4LBNWa1kZ4BqEg633s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789780689; c=relaxed/simple;
	bh=ap6JL+t/QXMgBjwhQI/FUJ5Jw6Y+f4eSyXcwIw+EGx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LKAz5YBRaWUDgczg6N6AuYmsqCb/WvcYFju3JZjGJeRVjpoLIzdzvHOSS5evHUbTo6uih3/WLr0uslBgnSFvgHg9v8JG3PEmG1zJTInhTiobO5dSn1rSZ+3xG60N8FlpOZ4FAbqBF8ipAPL07mjsLuek15ALxtRclw1V0gMxNz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.196.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KxDuhILnzfjEPL5UB+qygiJB6a7YATIz62aK0JuEN9VYRHtxGPCfvENG2j+ZvXXRM3hgZpfyH3dXxB9yRzjbb9iOHKDkzLjckj/sbOMrv6NfnEh+TjW8wFgni8i3zmg3zvetDHu2Euobv7xCP2KtaTVCVkINdw65DUGVPH5n2jfC7GSR1eebQU3njd+6FYfmLcRIUGEx6hnSbssQP2+JK5SrwMWKMQFHRPCpxHe8jPE7DGsQH+ZsMfJbWxPWwPnD3JrIfPKKPySxMwmJqINDqwqmekg3UE0oRAeDGhVrKSaNcLAwaHtvr3i5+99UjNvzXn8r0R/Cq+CCsgkcVp0YhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=Vnk5+0g4OxabwNXhckadLYmEjZjnUhMNnva2LT3L2kA=;
 b=J3sI9oyxI16vT0jm5iQxS1pJoE5gUcxmTJpQ6uISMQpVMzLfWVMlVT9qRiAK/ZRSlsgZVgRMURTkd8D/Zuhvd0CZwZ2wvnJ8QKplzHfJy8iYZyq1Pmrqvcl5m2sWSwMTa0DKhAe7WBkXT690MoKY/F2s8Zvd15dL0ZmuMuoG73RDPJOR99dE6QYrVhg6Kv8pSkO3gur5bHhYIkmxqXH39ZfzQR6dmfenCn9IbkUEt1ufZKTbb67rtn2uwelkPTZGXu/LhOgAlCPJQScOvfIXrMud8ZcvoLjPei+4r86HrEqd4QVKMWnwSXiXHt9F/p1HUj9s0d99FB0+yCVExgAAxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO0P123MB7751.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:407::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.16; Sat, 19 Sep
 2026 01:17:57 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0428.011; Sat, 19 Sep 2026
 01:17:56 +0000
Date: Fri, 18 Sep 2026 21:17:53 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: petr.pavlu@suse.com
Cc: akpm@linux-foundation.org, gregkh@linuxfoundation.org, 
	mhiramat@kernel.org, boqun@kernel.org, neelx@suse.com, da.anzani@gmail.com, 
	sean@ashe.io, chjohnst@mail.com, steve@abita.co, mproche@mail.com, 
	nick.lane@mail.com, linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 0/3] module: Extend module_blacklist parameter to
 built-in modules
Message-ID: <nthuwdm7jb63nivqtemkbnoagzu62kng7rqon27se45agxvr6y@6aabdiy3pqs3>
References: <20260908203230.401020-1-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260908203230.401020-1-atomlin@atomlin.com>
X-ClientProxiedBy: BN9P222CA0025.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:408:10c::30) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO0P123MB7751:EE_
X-MS-Office365-Filtering-Correlation-Id: 78c42a81-a147-45af-00cc-08df15ebd647
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|23010399003|1800799024|56012099006|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	TYzdCSbjmMyhB5IBDTgEvDH8L/i3XcB69biAHm5GNOLe3SApodkT+4RJbWRN+3eJCvCANry9cOxVkh841luXiUj3GN6K7JCAPV5eEmw0zXNXUJWKWRNmZ1YeQjbnQvLG+li6fU+pnXNw90XPcroOj7tTLfk7Wek01+5fgt/jxgS+W23TWGONRjVeLxigW0ayKeA3jGatQXFtR48sZMlHrmTtAzh9gVac1fTBUM6P+cvyrCacVBIa7mXsdALhKsp2mbWyndQY0/xwx6XGGRfa+etbzETAlMGOLAmD6BGOHuYs/cay0Jj/geFtktcgjZV8jC/+kDse388apzOmzr01Geiya9gSp21n4finV+9mJ6mzqBAZI2SJmUxrhGpgV8FfDa6LeP3fuqqsT/ZamweMbKqarWQcg3ogEQlGnjeVq1C3HnC3AJxiJu6ejo9RA+Pb4j08e2AS4SaK8ewapMJ3umj1mbtOe41+Yvt82k+a1fk4KDQ/degg/IOJEO1Q2OBc+BJ28YDUQQwvIgfydq0MJqfhBJyKw3Li5M8iu1lrdNmBfuGmvjezEV5x3FXts+t5uTBNrS+4xPOBLV1b0hWIywiMu2XlD2FbRcZcKGzThHBmDTeL5UDYW2Zq4qQw03n0jCjfiWQ7/GtiukmCs32qNy3fJTURrpF1vRrhiC7zHBU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(56012099006)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WXdybUJKS0xzNEJCYW8zdm54bERBUVhjaHhNeC9ZU2VmR21oanVEUkszdUtZ?=
 =?utf-8?B?SXZVTjJnTWFSd3h3dTg5ekd4cE5VSm5ic1F4N3VzMjFCRjdUVTM0MmVPMElk?=
 =?utf-8?B?Q3h1S0hrTkxxaXJMNEFLWklHVC96Q3FNSUk0Wll3TURQVFlhdTQ0TnZsMVdZ?=
 =?utf-8?B?b2o3VE8wcFI3bVZrc2hWbEl0TVIyNjhLWGhQRG12d0pXUGZnRDAyZjZSdEcz?=
 =?utf-8?B?MHFlSWczSml2K2hUWCtsWW9nZ3o2R09SVE11dHl0VzVQWHVQblJVRCt1UE5X?=
 =?utf-8?B?R0dQYUJhRDBRc3UzdFRTUC9uaU9aSjdTQ1piOUpLSDQ5SEJ2QTNlSU1PRkpZ?=
 =?utf-8?B?UnlEWjNmcEFxMXlQYTdKeG40QVZ3c2pkVTZqV05aRzVLVGRzeHFMcThtam9J?=
 =?utf-8?B?MXc2N2txZjRIay83a0s4RXk3dk5qZGIxSkptOWxKU09qaEtkTWNyalcyYWZY?=
 =?utf-8?B?Uk9WcTcreUd6K29qT2VCREprcS9BVzVhekxEdnlzSTlFSVlObEwrRHZqNXI0?=
 =?utf-8?B?M09lUnBKMUVxTTRZQjB3dkVSMUlrY3hBVW45WENlTjlid1g1MkVIQ3lQL2xh?=
 =?utf-8?B?dnVJbk5yemF5VVNPdFZKN0NCeXhsdFQwdjh4Q1JEUXlSWFlMMm1tcUxoUlJh?=
 =?utf-8?B?SlZNMVl0NHVBek5vWTBiUlJxeCtoS0k3OFRSUjhPQjlLNlhDdXRpV0FTN2pj?=
 =?utf-8?B?dnB4SkhNVFZUS29ZUnl6ODRWSEErVkNPN1B5ZWFXb0pSRHp1TVpmR2JEc0Vk?=
 =?utf-8?B?c29XVW44WG9nOTFtTDlpaVFmNnQyMFRFTmxOUFlOMnR5TFFyNE5ISFpSWXNu?=
 =?utf-8?B?aHZZSlFjaHIvYnk1QjVubDExcVRjNUt4TTZiYzJXOUxoOVcra2pSeDZ1N1Ns?=
 =?utf-8?B?NVgzZkMzWVZiayt2d2Z2YUVkMzNNaVdIS3k0UVREVTRvMmxsOHpFOGFDdkEv?=
 =?utf-8?B?U0JHUFhCZGR0MzdMVnhmV2lEMUN6Slpzb0lTR1R4Ty8wek9JbEJ1dVVCR09V?=
 =?utf-8?B?ZktRTGVEallVTXhES1dtaXU0YVBTZVBLQXBReEhZaGh5N3JKb0NKcGdEUXNx?=
 =?utf-8?B?TVNQYnJPRUovM1hiMFh1TUVKUURpa2xSVDdub1Q5MzFHU3VOcVp6OGJaZ0hk?=
 =?utf-8?B?c01CY1E4YStEQTdUODhRVm9VeFd5STgyRjZIV0tQWnc1em1wRkZKNVR6UkJn?=
 =?utf-8?B?akk1b01aTkNTK3NVdSszbTg3SmFEaGptVUFOWjAzSkFRd25JUExqdUdwMDBS?=
 =?utf-8?B?ekhQK0dxS0IzUUZ0WmJLTVJtRDZYMFBsY1FIUTJwWVJEZkcwM04vNGRjNFNj?=
 =?utf-8?B?YUozR1BEcmhKckhDK0tReXpmalZST0E5WFJ1UkE3QjVjUnVUOHhoOHZRVXVK?=
 =?utf-8?B?N0VSaENPOGZ6aDNwQk9QenNZQSt4YXpTZlJFQjhBM3llN1ZYalF1WExhMC9W?=
 =?utf-8?B?MGdpUHN3TnR1UkZuUS9DK0N4eXFidzZIdTFwTTY5VlNXS2d6azZVVDI0RERo?=
 =?utf-8?B?dlZjcDZDaFdwRENQdjNMMlVUalo3KzFpZ1JDYWxRQU9ONVQwYmtSdXJKeVlx?=
 =?utf-8?B?SmZxYStRL0lCaUZGU2J6ckRsaHJOekRFd0kxWHJUemdyN0FWR3dsb0QvTi9k?=
 =?utf-8?B?L202dzBvWlA5ZVpHdWp3UDBUejhyTVZHUUhPSytmcGxLeDZHY21CN0daek81?=
 =?utf-8?B?TThVVk8zdWQ2Q1ViaVhnOFFremFSWXdmdjVnZ3o0cnAwaytDeWVmTVBFNXUx?=
 =?utf-8?B?M3FJazAxajl0MWVNSy8vUjQ0cCtUd1Vpd1RIWjEvNmtZZk1hcWV6Wm9odzRW?=
 =?utf-8?B?S1JpS1hIc2t6VjUvRlI2blNnZEJhMEY4OUZiVk9NTERaeExiL0I5Rm5oMmpD?=
 =?utf-8?B?eFMrVzNsSm9HdkxoSW9MRHZuTEd2WDZqMm9hL1BPTW0ycENoT3F2S3l2Vzl4?=
 =?utf-8?B?d3EzSm1yVk11eUlBbGg4aXhOKzE1NXM0SzFlT1lvUWFTd1VRSlcvSEkwdnRQ?=
 =?utf-8?B?N3J4b3VRWXltbFcrRC9ybGJrZWZITzZ2Y3lXVHBaWldSVUdaejBnbk5nVFo4?=
 =?utf-8?B?MFExaWFiTWs1ckRWSGZkZVBiWVU4L05wTG5WRkRmWURwSUQ0b3NkM053aVRy?=
 =?utf-8?B?WVE0S2x5cDV3STEvTXNJMlVwcG0rYWRHZG1USDBUOGZBSFI3bVFWclhOS0dM?=
 =?utf-8?B?RmFBRCtoVVBIT216SnVSVmlhcmdDUDBCZlFpUUd3V0dINkhvV2djTFhydWYx?=
 =?utf-8?B?SVVDc2d1cXl6bHF1MkJnUkYyWnd4dklwdHhLNGpWdWVwWGhLRERiY0VOeDhH?=
 =?utf-8?B?L1dUWDBIcFFzYkRJMUMvemlxY1AyUWcyQy9wendyVTdJYXR6R0czdz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78c42a81-a147-45af-00cc-08df15ebd647
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2026 01:17:56.7510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A3PiIK2+eo7sThpHajAuLdx112zqXzuZ0LuABew+PzYZgy+PGzoKbleCg23UdL5bqixq03GMtgFJ6bkUTsgdyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB7751

On Tue, Sep 08, 2026 at 04:32:27PM -0400, Aaron Tomlin wrote:
> This patch series extends the module_blacklist= command-line parameter (and
> its modern alias module_denylist=) to intercept built-in modules during
> early boot. Currently, when a driver is compiled statically into the kernel
> (=y), the parameter is silently ignored, precluding administrators from
> suppressing problematic drivers during boot-time disaster recovery. This
> series resolves that discrepancy by mapping built-in modules to their
> initialisation routines via transient metadata that is freed post-boot,
> providing a predictable and consistent administrative interface regardless
> of whether a driver is built as a loadable module or compiled into the
> kernel image. Below is a detailed breakdown of the motivation, operational
> rationale, and concrete use cases addressed by this work.

Hi Petr,

I hope this e-mail finds you well.

Whenever your schedule permits, could you please let me know if the current
approach meets your expectations or if there remain further points you
would like me to address before proceeding?

Thank you very much for your time and continued guidance.

Kind regards,
-- 
Aaron Tomlin
