Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.71
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795620955;
	b=GN4wf8MBj+BbYfZ88LYCi+plYUo5Ojw4TskbfYjSTonVuvuUAXiTRQERTgfzZ03VAdmx
	 arfGPv+MKd5EosGXieVgc5NKUsjZ0GJZeY/5QhnXmkH0grZYrHe1crtDLb95oF5y6aEiE
	 eSTaEeA0jZ232V6SOMj5Fuy3QI7Fh1nlhdfe0ppZQ0dK/iGn6GDHFn5JbeqvPEZJWqulZ
	 7QE4v78m68ehrG8FzWkGcrMLV0RA5Cqog3NoJRAlgq98XqHHMTv/tUAK6Q0lrQBi0v2Q2
	 zm4wgZykCWQrr4f+ALl9JEeN8KsQ2GWVo2zzyDowqb6nnGEGeOifTxdFppwdSlQASQw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795620955;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=g9I8ZbKMVmz7nfQ2vEn5QKra+hWh1ZHVTsj2FYOLRHs=;
	b=IxWZzQOKdN9f49jsattP5QhQ7YuzxZgg0Gug4BGOZPiB3t6WM/LZjEM81+0Hu4V72OeI
	 U32e77CcOr4GI6u1MikXn3uvSPEjGu6EHGvrRzGp07udwQuL9vpLHFRnBqrSposF9mXoQ
	 MudV0sKkixfe65UfGep18df9hQZbRRiRa8IVNhUxAktdjDzMYPI0UwrBinDd2RN9AmzyM
	 3DvYXE4SwHZHweF1yMaZY1YU1vrMtauiCsjP84nq8+pD8kdwbqH5wzTxvrjvlCmyclblX
	 A1oH+/ETTCE3Si207g4Fo9hoJ6+r1Hl7I/QtmOujQvpSnPekTO/Jj9usL693IFcaZjQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Cc9T4SyN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.71
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011071.outbound.protection.outlook.com [52.101.57.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE2460A5BE3;
	Wed, 25 Nov 2026 15:35:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CE2460A5BE3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Cc9T4SyN
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y+Ocy/DGgiBMB+fezxkpERt1RXDqJiGbYoD6QDhcrG7qSH8FOZTdq9xI6sy/7bpVDGSDISAQEJttCKyXC0Ey54BNWPN1N5OeWU8Iyr15clTDUZW1OGYKhTnk8HwQrvxygVhjMzVd97oIr62FX+XMPagYUlKIDxeJ7k6pxbL5I2bC+2/qPDXwaw0FKb1hdvDqLXboVlj7iSLEZ2XFUn1kcpjaOSpe5xqT/wz6jMgi57XwR+U0d6r7kwd67vX1oUa6/oW4yB9dk/GqTjtddSG4Ol635xMrUgxLRcKp1WHtylXG2igLPnMisWxuEb8j4GaTwUOstOoUQVeyvoTGlJIr4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g9I8ZbKMVmz7nfQ2vEn5QKra+hWh1ZHVTsj2FYOLRHs=;
 b=VcEdi4noBjroB4cM50/wQd5qjfz5naSKGIlruuJTfyIt4mfWDjhVn7LLU3sL6W3cJ5R1l2S5COjdjTWeLed7RdnY6p68j3hKCO1kP56vPDb5HLPcFCsqgbaDCKJvdMgKjKkHbuLNWb4muMGBZ7JK6Am9zrX5qLzA1spsQFf8Rptjj2oH60GEpWglSwMD+A0Nj+mv5yoRHUXWvlKtADDvrzzf3Zc4qC0Y0P5tz8Yltx1bIr6e8gKZv8nB8fCcfD813wgDgmeqomI9/bsKFQ0uuKorScvmmYy/CtezVXMnnzBv7an5yN/OmKChMpIE+Dq0B3Zjd8nalJP+uXEj0u9AEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g9I8ZbKMVmz7nfQ2vEn5QKra+hWh1ZHVTsj2FYOLRHs=;
 b=Cc9T4SyNB6d67zuJ7HQNV2xiephnYuALRwOb+40xAx2edQpJSHrU2esFO7cb6v4lmrdxuh7U4K5pLFgp4kKCpD+qSS2yOxVgk89edporYBHcNkeCbz5V4eJz6vr0BHtSCf9miXuOIeLNg4tZuFcdidZVjylfC1cCvDcC0AfTl0z9qeX4XX6swHyXOGogKm2k9e5SL5PTRrETRkQgPFv2CNoZAuEeu+pRPqwlmdlg4R1RoYPZHSpjS3booV3o+SAV09y2yX/fx1Ewk8kfypVTjK7gB26JrREK8wb+3zWTpfL8GXLsU2NZ5Vdu7BHcwCGAUcNagqWHp7CJpprawnSvOw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN6PR12MB2814.namprd12.prod.outlook.com (2603:10b6:805:72::33)
 by DS7PR12MB5863.namprd12.prod.outlook.com (2603:10b6:8:7a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Wed, 25 Nov
 2026 15:35:49 +0000
Received: from SN6PR12MB2814.namprd12.prod.outlook.com
 ([fe80::9a18:413c:9702:8f59]) by SN6PR12MB2814.namprd12.prod.outlook.com
 ([fe80::9a18:413c:9702:8f59%6]) with mapi id 15.21.0639.012; Wed, 25 Nov 2026
 15:35:49 +0000
Date: Wed, 25 Nov 2026 10:35:47 -0500
From: Yury Norov <ynorov@nvidia.com>
To: Tzu-Ching Yang <shingekinocore@gmail.com>
Cc: Greg Ungerer <gerg@linux-m68k.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-m68k@lists.linux-m68k.org,
	Angelo Dureghello <adureghello@baylibre.com>,
	Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] m68k: coldfire: Use the builtin fls() and __fls() on
 ISA_A+ and ISA_C
Message-ID: <awcAU5CFq714lWcu@yury>
References: <20261123131101.639643-1-shingekinocore@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261123131101.639643-1-shingekinocore@gmail.com>
X-ClientProxiedBy: BLAPR05CA0039.namprd05.prod.outlook.com
 (2603:10b6:208:335::20) To SN6PR12MB2814.namprd12.prod.outlook.com
 (2603:10b6:805:72::33)
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
X-MS-TrafficTypeDiagnostic: SN6PR12MB2814:EE_|DS7PR12MB5863:EE_
X-MS-Office365-Filtering-Correlation-Id: 1967180c-8e9a-4775-5067-08df4b09c7bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|7416014|1800799024|10070799003|10067099003|261022075727099003|56012099006|11063799006|261026130827099003|261026121527099003|261028144727099003|261021121427099003|261021135927099003|261026140227099003|261022113327099003|261021130227099003|261022115727099003|261022105027099003|261102123227099003|261021133027099003|261021123027099003|261026135527099003|261009223027099003|18002099003|6133799003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	TMlsfkYRaJDzlof+Sd3OcPRYkvo0oWmsdHKx26/S8MWcLRkVlXhNnpa0AagC9iDlz00iV3Y2BHyGE75KEU3Ilxs3/+LSK3JalbnsaPCTQkpKrz58Q4wdctbA2huEOvURu+KdYLDhF0apenDztuDd6V3vqTLqIKYGYxuYkiwrsIXz+VWwtiLqTYdHeZgjL+9huvxvy/wrTpKUtuicKp5vzOL6rIOWM2b5BrrHPtRylXBg9ZYnrN0tCwycI3rrJFKksEoOgGGZxRnDODTsw+xiAn/bVXogDs/Z/u/zZbqE+fn6CiOlmlUci45j95FsK0t+PZ3IdPnvn8CrFjt0Dz9CMGu/V0rgjMubWJR4j2/e5F/m2ffWymuV89AVfpx9yEY3pU5XOasH3nQhVNtxp2aGOb8icEjgEBwu58eIV0m8LdmZzuOd03TLZqx7+UwxSaFRK2kXY1HK0G9CKqLQKCpu79XsPYf0K+Xi3GMAFREOSlcYji8Z9xcwI9bO0Ublfg/yIst52k57pgs9M9apfCPjAM/waiOBlOckA9Vb9+OASofxYbFZ9GGwGqTsuYxKAnO2kZXDJvaMMdkk+UJOytbntSzIOyYbsuI9Y0m2+MFYkQGV2P2o9w7B/LU83GIL3Ae2QdSBLpOamU9B95zstls7nXOtCcxinVz7GL0UxLzE/4s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2814.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(10070799003)(10067099003)(261022075727099003)(56012099006)(11063799006)(261026130827099003)(261026121527099003)(261028144727099003)(261021121427099003)(261021135927099003)(261026140227099003)(261022113327099003)(261021130227099003)(261022115727099003)(261022105027099003)(261102123227099003)(261021133027099003)(261021123027099003)(261026135527099003)(261009223027099003)(18002099003)(6133799003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4jZazmqgarbNaOIoZrC3FH22hFmSLjwBRay8cOccJvG8k8ZOJVb9xPCDuOXM?=
 =?us-ascii?Q?oumTIXvPuKtmtg938C/akCplJGdKiPLnxkTtSINCw+cWl8G8H1/UDOSW2wqv?=
 =?us-ascii?Q?0qMF4DGEKdhxDXmYqqX82Ip9+QFw7F7FRfyHFrB148xFo302eCzekx7T25/n?=
 =?us-ascii?Q?ByjIzgCJCGJYJhspN7x7a4x7tAcSgfyxZtEnPsGzz3xfbPkRDvc8BSu+mD9o?=
 =?us-ascii?Q?RVIMVjg95UNl05FKNZv/dqXESoOuTra/ZDEJJL9ByO328Kpeaw2/6HMm4shv?=
 =?us-ascii?Q?8sRSSDnuuXRSUHfJZ/fXxvn934UQGW+RdwYb/hZy4xZF4XpuoIJLwbCHD4vq?=
 =?us-ascii?Q?9wy05yCsmkvdW42g1yUYJQIg1ss7lfrNsoJI8RmFFH12WGt8UMS5VuMks+Gi?=
 =?us-ascii?Q?5ALVooLwS2rLcAGx3B/IGFUTkEtwOwT1QUFcpT/tWsLI7yRpyIygk/O1rpfH?=
 =?us-ascii?Q?a2o/EdRRRzLFTC4IVf4aHQahj2OmEl9+OJN7sT9baZrLdJDZVAJTQnQR+R/i?=
 =?us-ascii?Q?2mGJQJwyWB7o7wxIb27tbK4G/ZcwVSKNpq/YOITEPHMz6YrSN+Ob63ogajAD?=
 =?us-ascii?Q?5Bz19NFyJpRcev0g6IbOcNXAk5WjhbN8VshwvPsbD9jNl4CuS53JVvw6+MQF?=
 =?us-ascii?Q?djxGsuJEXQPvTVAkAzmLgk2QxrMiOV3BjvibCfBHUY57Z+MbJKcB95BKgZT3?=
 =?us-ascii?Q?L/H3EAcgxqjeWRc5iEtLR+aZ44tFVGQ9S0VinwdHGKtDPjlG35d5/n5sCtMM?=
 =?us-ascii?Q?uNeddX4dlchZaQ9lYk/x0agxfpvd9fmjJhfCoGUSgopG1w1Ht+eG4Znu4mVB?=
 =?us-ascii?Q?pIy+DQ7Ct9GMYsMduAO7EDK9+R4I6+zkn8UMC+aJRTf1vin6shSv++keu8qG?=
 =?us-ascii?Q?m0otMNbFxP6TpYxu2N0+lFm7VCDhbxfi8HQTfzF10ZXFdey2Wl84PtruMnG0?=
 =?us-ascii?Q?ZEGjqm5rszhQgeYHSyjNP5dLyABRSh8twsmrovff+iNvvKoJcX8jL2IhMooC?=
 =?us-ascii?Q?RevlgFnAqxKjw7D1ND7kPV/BxabD/45e4BZ2wiMTz9+qMLDrS772QxklmKWu?=
 =?us-ascii?Q?WuMACfhYLOkfYgptGOknFQO+XF7FB8g5O563WKBcu4oHVYwdPbigSWehiAod?=
 =?us-ascii?Q?0sNBWK72MpQLubQrtXA6CPMEhhNZv4VbCH7Typ9q5LVKKALggAYRnhy2V/F4?=
 =?us-ascii?Q?meuXIlU0E4051ID3JmhfapS7B6A0naI9dpM9C06CTlyHBq3KnnlUQVWPdDmX?=
 =?us-ascii?Q?W+lmT4Hiv9pIjKfAMpILpjCwRQ22UJZTOUdJ/enltkzGbdJSFotbyiQGxMtT?=
 =?us-ascii?Q?MqhNHcXu55GHoyB7WIZTMjLUNH/S71kM7qp0+xT6TEIjuw3/86Tz7HsOpZo+?=
 =?us-ascii?Q?kVuoNTW0yx4SM7f6tUiNde+3f004Bf/RiCJig+nGVXx/i1n9hAGPKpoJ9o/U?=
 =?us-ascii?Q?gzR0H3FSQhiWiS621zg8PmmmJAm5FAHFdN7mDYEM0t/v098xqtdOs8W8HEsC?=
 =?us-ascii?Q?pwW1oFRcHCBErJSRNkc5TC3OeUgl+R/bc8WmvXI5aVNGwhfMkcOZlAwPL0yA?=
 =?us-ascii?Q?M2B/QjRMdTDy+Y6vFJxSJR1QP+iisnfttCwx3ukwqHOCzJM+iity99PhawOB?=
 =?us-ascii?Q?FLd1g2oPJkNGKMGgtbdCE7EaXYcHd7mVhKfKOjBNARyYTS4he/oy5UMZAtD2?=
 =?us-ascii?Q?LLx3FngOUKpspOmYrDxvTEgYxmW2aM7WUFmlHk/jec+LpY0z7pof/B68gZfd?=
 =?us-ascii?Q?PjKzk1GUqPdvr6JqAM0gWWq1ZHJZi/Z3fT2e6hc9VdGQNR9+Lu/i?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1967180c-8e9a-4775-5067-08df4b09c7bc
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2814.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 15:35:48.9840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z0zb3SGEiuLVKDOZvBFFGBuL2EQsGInP7wD0idYms29dTYHyu9m8zycnR8m4L7lJ27OzOSIp8O0yigR6cUQ++Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5863

On Mon, Nov 23, 2026 at 09:11:01PM +0800, Tzu-Ching Yang wrote:
> Let fls() and __fls() use the ff1 instruction on ColdFire ISA_A+ and
> ISA_C cores instead of the generic binary search in C, as __ffs() and
> ffs() already do. GCC emits ff1 for __builtin_clz() on exactly the cores
> for which it defines __mcfisaaplus__ or __mcfisac__, the macros that
> already select the ff1 versions of __ffs() and ffs(), so no new
> condition is needed. Commit a6260ef84103 ("m68knommu: add ffs and __ffs
> plattform which support ISA A+ or ISA C") added the ff1 versions of
> __ffs() and ffs() in 2008 and kept the generic fls(); the generic
> __fls() followed in 2009.
> 
> Use the asm-generic builtin versions of fls() and __fls() when
> __mcfisaaplus__ or __mcfisac__ is defined, and keep the generic C
> versions for ISA_A, ISA_B and 68000. The bitrev/ff1 asm of __ffs() and
> ffs() stays, as this asm is shorter than the code GCC generates for
> the builtin versions of __ffs() and ffs().
> 
> With GCC 12 to 16, fls() shrinks from 28 instructions to 8 or 9 and
> __fls() from 24 to 6. With GCC 8 to 16, the functions of each ISA_A+ or
> ISA_C defconfig kernel shrink in total by at least 8676 and at most
> 13266 bytes (scripts/bloat-o-meter -t), depending on the defconfig and
> the compiler. In lib/find_bit.c, only _find_last_bit() changes, from 55
> to 35 instructions for m5208evb with GCC 16.
> 
> fls(0) still returns 0, and __fls() still returns unsigned int.
> __fls(0), which is undefined, now returns ~0 instead of 0. For other
> CPUs, the preprocessed source changes only in its line numbers.
> 
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Link: https://lore.kernel.org/all/dbb44e92-0bc5-449d-9e43-1f93362aa6c3@app.fastmail.com/
> Signed-off-by: Tzu-Ching Yang <shingekinocore@gmail.com>

Acked-by: Yury Norov <ynorov@nvidia.com>

> ---
> I have no ColdFire hardware. On QEMU mcf5208evb (ISA_A+), the ffs and
> bitops KUnit tests pass before and after with GCC 8.3 to 16.2. In
> find_bit_benchmark on that machine, with the bitmaps drawn from a fixed
> seed so that the kernels before and after use the same bitmaps, and the
> executed instructions counted by a TCG plugin, find_last_bit goes from
> 52.3 to 38.3 instructions per iteration on the random bitmap with GCC
> 16, and bitmap_find_next_zero_area_off, which calls find_last_bit(),
> from 3302 to 2864; the tests of the other helpers do not change. The
> ISA_C kernels were only built, as QEMU has no ISA_C machine.
> 
> Under QEMU user mode, with the kernel's flags for -mcpu=5208, 532x and
> 54455 and each GCC at -O2 and -Os, old and new fls(), __fls() and
> fls64() agree on all 2^32 inputs (fls64() in either 32-bit half)
> except the undefined __fls(0).
> 
> The seven ISA_A+ and ISA_C defconfigs (m5208evb, m5235evb, m5275evb,
> m5282evb, m5329evb, m54418evb and stmark2) were built with GCC 8.3 to
> 16.2 before and after, with the same .config before and after. A W=1
> build of these seven and of twenty other ColdFire and m68k defconfigs,
> each with at least GCC 8.3, 12.5 and 16.2, has no new warning.
> 
> The new out-of-line fls() for m5208evb with GCC 16.2:
> 
> 	movel %sp@(4),%d0
> 	tstl %d0
> 	beqs 1f
> 	movel %d0,%d1
> 	ff1 %d1
> 	moveq #32,%d0
> 	subl %d1,%d0
> 1:	rts
> 
> Against v7.4-rc1; also applies to the m68knommu and m68k for-next
> branches and to next-20261113.
> 
>  arch/m68k/include/asm/bitops.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/m68k/include/asm/bitops.h b/arch/m68k/include/asm/bitops.h
> index e9639e48c6c3c..81923a9fa4494 100644
> --- a/arch/m68k/include/asm/bitops.h
> +++ b/arch/m68k/include/asm/bitops.h
> @@ -506,13 +506,14 @@ static inline __attribute_const__ int ffs(int x)
>  	return __ffs(x) + 1;
>  }
>  
> +#include <asm-generic/bitops/builtin-fls.h>
> +#include <asm-generic/bitops/builtin-__fls.h>
>  #else
>  #include <asm-generic/bitops/ffs.h>
>  #include <asm-generic/bitops/__ffs.h>
> -#endif
> -
>  #include <asm-generic/bitops/fls.h>
>  #include <asm-generic/bitops/__fls.h>
> +#endif
>  
>  #else
>  
> 
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
> -- 
> 2.34.1
