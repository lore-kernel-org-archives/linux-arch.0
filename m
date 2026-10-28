Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.33
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793200389;
	b=3YHEuK2803gMJMCBH8CNF4ctzy6SXmVpqp25T/fhX8BZoiTtA/inNdY+DuOH56Y9+mSs
	 xppVjGpoUCR2em3bzgiCu3EleX+oW6kLSCHQWD1CYrNArbFv0XbfmnfqrOQAg5IQJxWnd
	 HHjCbsXdURrsnIhgCoc4Nk3VGm2I+ORrBMQ4KZQeYhHd084VABGOmFf78M565stldxswN
	 MlOu+2AQS1jypv8lq6EGDuhRoRrn3moMY1m0k9ZDhgAcjrHA4Xyuzl6DlC+SeCQbnWRU5
	 ViWkaP+memBaaSiMHtgZAlvUgbOwVB5PcYgp7E8eThdEafZgEw7IcuzJLNRbiJL+OWA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793200389;
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
	bh=9elyAsLKxL4O+aWkQbnhoMX43jukLdPCYYy+HegXDl4=;
	b=YKhqqcC7GYHYVDQnESZKOb7r65EsipJhujhoScuqORAf3lPSCuoc5/wMRbXaisGh9+xn
	 FCa51a8Khq8p8QRoJiXkH5J/hZaHU4G9J9n4mRYAhNxZCYB9ERTI59/T7z9+z+sQwa1VA
	 tf3mLLsMEix/RTZw68im6VmtjpQ0+lr6MQ1iDwaHbc1xI8IX2SJuxtY9AT/BMhg4Nq5ru
	 mihRzX17Oo5mt1E1jGpXmPg+UmJRwzB7IuCCAt37FJHfmiHV6Kas0m86wD4Nt/R0YIenz
	 OrZlaE9Aorb14BWFM9AqasurtA9y4ue81C+azCqDPat+M5Y/PGPSEVcZrtFkrmtWKJQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=A2bu4Nr6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.33
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010033.outbound.protection.outlook.com [52.101.61.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA85606A31A;
	Wed, 28 Oct 2026 15:13:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCA85606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=A2bu4Nr6
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SAMQ+JK158MXaTGIIildShXO2uYMIrM+twoVi63sESNBJZq3pPGM/dam4jwTR5gHAraGYh/sgtYF2gggD7+DABqMKII7CnNeRpnHkV3kxaPpFxGIGh2R1ljjoDcU+zyIC1puCQlWaiQh7aC/1WNLUC8vWyH6bHS/hw112mShYUjqIePUEmlBfUgGKZglqKHgReqyAVbGKBf0DiDfMwS+sIgZp/NjjwCnoTEGf+Xo7EE2nNBJyqzMg/GGgt9oADUSD1IUAEMrP4lZPMxeyC/beDHg4ADQuH4INWgwYJMminV9iWefuQj5XI5N/7BckYqx35G2VA3seynNw3y6yEr5OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9elyAsLKxL4O+aWkQbnhoMX43jukLdPCYYy+HegXDl4=;
 b=v2KKTRNcGMVOEcAak59j/wq2tqNLtUwOmmUxoN5BtjiiyIsAG+Gg9zCPOeYHPFHZzoOgaDaWwUhgX+JsVvM08YFLFC6LJIoPThuVGyQFf/MtwtBpNp45xRcK1uDBl4Zn+Lz3uhkfu7YDoTH2+yB+oWStZ6x2IH/cmg4B7owt9eyl0lwPC4DMqDOWpC0QtDffU0jj4sVr5RpceYCc8pPs6IZ26DcnwDQKykbV/XrDxpwNEbsjH6XZUBWurunMmr9m0FCHm7UrnMJVDbGDTACZ5LK4/m3nZvgcn1hXJdk1XCIzgQl8wPfrjCJ6eS3jQ6AqGxlV2PfpVvNBCMMnZENPCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9elyAsLKxL4O+aWkQbnhoMX43jukLdPCYYy+HegXDl4=;
 b=A2bu4Nr64n171v/NHExE2WNpUf62+rrXs0IG81TSJ6qL1qiO8une5AAj9VrS1K9rbbjMgWIsmfmI7wbLO+mDhYLUi5Y7pHRSebShw/BhKPooJZZ8kCPVoT6wrm6CQFyqfpaysKRW4XKFvbBgt7IBDwXFSAfREVQwcwKP8X3d8hW87oMm/RhMhZK/q57vy0rADXMgMuNlqb6EGqk/8HenYhpuxAuxg0Ja1jvb45TB9XcDfu4uHJiVxeGJSw/dIzY5PrDyxeuxB6qRSDg8t7dzuDRSAoXAvajYet5YjplmfZnvY4HOwFVT6UUg9A1VPnPEa99hlWlMhMYQAhs9WXLDQw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by PH7PR12MB8826.namprd12.prod.outlook.com (2603:10b6:510:26a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 15:12:49 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 15:12:49 +0000
Date: Wed, 28 Oct 2026 11:12:45 -0400
From: Yury Norov <ynorov@nvidia.com>
To: Tzu-Ching Yang <shingekinocore@gmail.com>
Cc: Guo Ren <guoren@kernel.org>, linux-csky@vger.kernel.org,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] csky: bitops: Use the compiler builtin for __fls()
Message-ID: <auIQ2RI89C374je2@yury>
References: <20261022115922.1210342-1-shingekinocore@gmail.com>
 <atpm00m6KYhXo6Wi@yury>
 <20261023140806.1367050-1-shingekinocore@gmail.com>
 <atuBH6-LHueXYbFy@yury>
 <20261027062319.1700461-1-shingekinocore@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261027062319.1700461-1-shingekinocore@gmail.com>
X-ClientProxiedBy: BN9PR03CA0946.namprd03.prod.outlook.com
 (2603:10b6:408:108::21) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
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
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|PH7PR12MB8826:EE_
X-MS-Office365-Filtering-Correlation-Id: bf29f80b-76dd-463e-4a87-08df3505eda5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|10070799003|1800799024|366016|23010399003|6133799003|3023799007|22082099003|18002099003|56012099006|11063799006|4143699003|261026140227099003|261026130827099003|261022105027099003|261022075727099003|261022115727099003|261026135527099003|261026121527099003|261022113327099003|10067099003|261021130227099003|261021123027099003|261021121427099003|261021133027099003|261021135927099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	PbECOJxiMgR5x8y2Szfr4mCRdtAGlZgP2r+HRgrGPH8z6ceUFSXl0mOpEwPy/KfHzwdWFKel0X6BPieizqTjmHGY4YkHfaRjyogazCKPJeO1KDtNM0qrue8cHde7rl/OEgjqqAYdlaG9d34eI/EAVChmxqsO2RHvBVfdeWQvF3E5gZ5FNrIjvI74j6/9Z9uUuiq33iCEJL/2szPB+WpIr1/fTy0sGX/pyi9pDylUsC0Bq2+nwEMuS1ppQcgbrWQhDsvzxdrqIiTL87qG4Zp764OGXCT3dEWhqPvmpDjaVNqosHJnWuwApfu+6gcwawbtotq4+dqgHfexF0tDQIoJnLGuOBDbSR7uGfj0P/xpl2+epW2DBePelss+bhJTGhqAfA9j7ugPVILKN6rGHP/hyOP8/b/VWjeGFJsXi5Quat1i82hFinnrmDeXt5Hv3Kr8Fzs8Xc6Ux0ujPW36tnMSOAvJSeQj1itYrz1ri9E8smfRKZf0QMQS3UhilKywN5bRzyU1try+DgJIyEt47bRhvd47QDwEQrTp6Q1FpbS8nUaeMr4WsD5p49v53bcftDKmNj0MqvRbOHnwlAoilf/uadGRvPdw4ObDBSkoL9qBCvL347bjVAMSm2r/SxmaS9QBEx5anlwkvpS+UCMEWTx7rloezhBDLQPwfW3MX7JkO4Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(23010399003)(6133799003)(3023799007)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(261026140227099003)(261026130827099003)(261022105027099003)(261022075727099003)(261022115727099003)(261026135527099003)(261026121527099003)(261022113327099003)(10067099003)(261021130227099003)(261021123027099003)(261021121427099003)(261021133027099003)(261021135927099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?m/GikOI3XNU2wNXsNUCAqxwIG1WwWIZxTlbjbnZtJQgC5ZpKXOYbVkvaoSW7?=
 =?us-ascii?Q?p+fletfUS/t6XK3eStR5zlzOUjbD1KcWQTSfaUi4rLg75Cay/0YdYY3I/f8H?=
 =?us-ascii?Q?kHuiP2XzWQm3qZ0LXhE9hI9JQSOYUAEZ8IFCr7zPRYqXdHTVh8BFhWGs6Bzi?=
 =?us-ascii?Q?p0/d0VCSMOAY/cc7pSlphXvMyMv09PTMMSaIWtOliM79SQUkKfeA3OIx4Yjz?=
 =?us-ascii?Q?Ejs/I6/M3xqpgkFxUD1kpiYn+JAQRtFRoKC0jsBdLOHWZ94CvJEWFAw2ZD1P?=
 =?us-ascii?Q?PE28f2wUKCnAnfQZZMQSLxwiuLeA5HOUvquAO3mY9dVMx+nQP5DFXg4XAqlB?=
 =?us-ascii?Q?dVHKqLqcOc9MANLXRDv1qd+/Rv/qvZg78xHZUPRt0aL6oocV+EZ/td7T1hF0?=
 =?us-ascii?Q?MniUdKM5HvlMsLd6BvdyAsJa7/FiK+CdfnKiNycsBfJpiJPnW+qxpI71EZct?=
 =?us-ascii?Q?E997/js/Gy8BXWcwAVn/eCTant65stYTh7G0q6QjzYnvHN6B736x7ht4XkC2?=
 =?us-ascii?Q?FSSEX/PoPN9KLgBl+eqHkyBJwVWFcy5Dqz+2ubI+nu6ulb1teogVZKOzKgbE?=
 =?us-ascii?Q?t2tVfnSjhf61G3eBUk4hwOCJEpUiZ2Wl2OPLQKdPU4tP7+aRrc1ZTr3FFPg2?=
 =?us-ascii?Q?OE5l7MWEDEDdaS9VZUSnMz2dxWoOaNjG2fGJQklHGwJ/cpbdDBahtreAVZuH?=
 =?us-ascii?Q?plLCMjKzcqdEEQrpAs9MshpAL6KZRrbT9wBjGnsyW1kRpdpV7SzLrWjrJBDt?=
 =?us-ascii?Q?2HnWSJwl8h/BjzkKl9nbnkbGub0XbLu2h8DU/qTmDi2udEVbtij8enLg95nn?=
 =?us-ascii?Q?yij7NsKH8Tgkn/qR+zxs/RJijasNLIOG0thcxf1WqV4eys7lVWqYTUSJydJ2?=
 =?us-ascii?Q?hMH/T99R5gZh4C+g7n1eJdhI5qlUmS8H6SKfSwkoG7zbj8jpj6XW5mToHwTs?=
 =?us-ascii?Q?1FhEZfLyKlXJPZEOAR0LDm7veijlrI9ztSJvSAnkzKHeBHsimekTA6VZt8l7?=
 =?us-ascii?Q?LVr/SpNjMRrVoNtEc1c6BnHKzq+m0KHmJYzGtg3HpE7k7eq9Tu5zJVIHaZgq?=
 =?us-ascii?Q?eE+jvottelkSx0E6r/EAgdbUgVCPruRX9SxCmU0NuTUAffrGqhKN7PrKR3wz?=
 =?us-ascii?Q?PGy6AIIHsUhgnBS+c0x0ewJr68UI/BGYwdX7aP+m5CUm1HO2eukoZiuFejdq?=
 =?us-ascii?Q?d3pwKNf1Z45eiNLhS+MlXWe0SUtYPxQ7C2kjCf/i7K1weIMSMUpgdr7DkPnU?=
 =?us-ascii?Q?zq2R4W7W8xrVeflU4cqhCoMfxlwfX0ISNmnOC43KWbXV5p/EbXUoCYX8/wh+?=
 =?us-ascii?Q?nqAD2Dja2cErWraXmfIP/r/6kHkzhpIWlfZ4niQucYXbZdQSD7Spo6HIRCIF?=
 =?us-ascii?Q?eqcpcOfi+scjWWe25iBoP1ojUcabvSzkttcfQ+GbZJZxoZhYWp2E+vSZM8PR?=
 =?us-ascii?Q?Qujq4LEIkmurLmy/1BQt9F+hfbGfCA8elW4toWY9+Wotd8V59Y30RBYy4TvE?=
 =?us-ascii?Q?2Dbflnfq0agGJTwrE7zCIucFuXtuoNI9bjR9W3F+E1AzMVDsYhkHETdO9IcM?=
 =?us-ascii?Q?3p/y7B+9Six2Q5XXdYVm9LBEtiLwnXv6+bRVnLMeBcOLWIMxgserjPe1uwMK?=
 =?us-ascii?Q?rk0JXk4CRSWSbio27e1eCYPp2k24Z2v9YK63cjKIFzQrNMjLTNe1/K47Wa1E?=
 =?us-ascii?Q?l6mmiGU31C6c1yHqOaRyiGyRh2ero09q2j1eQNk9rfkaJfEl+75g/9TOB5Q2?=
 =?us-ascii?Q?9VM+FscXF8Cu3Xz5GgvczWPXBUH2lYa4bspQwjsx1YAq4Dblfp/O?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf29f80b-76dd-463e-4a87-08df3505eda5
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 15:12:48.9530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JSJBv8zmL+hmjudjjO6Bt6AAKeeHaAZdLY/OWjSRfafL4Llr9C8zxypdgT5jYPhy97/faHSOLcw/gc7HoQ8l7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8826

On Tue, Oct 27, 2026 at 02:23:19PM +0800, Tzu-Ching Yang wrote:
> On Fri, Oct 23, 2026 at 11:45:35AM -0400, Yury Norov wrote:
> > While waiting happy, can you print the bloat-o-meter results, and a
> > couple listings of the code generation, including compile- and runtime
> > cases.
> 
> scripts/bloat-o-meter -t on csky defconfig (CK807) vmlinux, GCC 16.2:
> 
> add/remove: 0/0 grow/shrink: 0/3 up/down: 0/-196 (-196)
> Function                                     old     new   delta
> fib6_add                                    1634    1630      -4
> build_sched_domains                         3948    3916     -32
> skb_try_coalesce                            1766    1606    -160
> Total: Before=4621444, After=4621248, chg -0.00%
> 
> The same with GCC 12.5:
> 
> add/remove: 0/0 grow/shrink: 7/6 up/down: 94/-330 (-236)
> Function                                     old     new   delta
> __netdev_alloc_skb                           304     338     +34
> skb_ts_finish                                 34      54     +20
> skb_copy_bits                                608     628     +20
> skb_release_data                             354     362      +8
> kfree_skb_list_reason                        280     286      +6
> fib6_add                                    1632    1636      +4
> ipv6_get_saddr_eval                          424     426      +2
> _find_last_bit                                86      84      -2
> build_sched_domains                         4292    4280     -12
> skb_store_bits                               622     606     -16
> skb_abort_seq_read                            54      34     -20
> __build_skb                                  116      72     -44
> skb_try_coalesce                            1560    1324    -236
> Total: Before=4333762, After=4333526, chg -0.01%

I wonder why the older GCC works better... Can you make sure its the
same kernel version and the config? 

Anyways the numbers show that the switch to the generic implementation
is worth to try. I've added the numbers to the commit message and
pushed in bitmap-for-next for testing.

Conditionally on the (so far, missing) csky engineers feedback.

Thanks,
Yury
 
> In both builds only skb_try_coalesce and build_sched_domains change
> in instruction count (GCC 16: 524 -> 466 and 1240 -> 1228; GCC 12:
> 476 -> 413 and 1333 -> 1327). The other lines are not new code. Most
> are literal-pool words (the constants that lrw loads) and their
> 2-byte alignment that moved into or out of a function's range:
> __build_skb has 24 instructions and 11 pool words before, 24 and 0
> after. fib6_add, ipv6_get_saddr_eval and _find_last_bit each call
> __fls() once at run time; they keep their instruction count, and one
> instruction changes between its 16- and 32-bit encoding (fib6_add
> also gains 2 bytes of pool alignment).
> 
> Over the 35 defconfig-based builds (CK807, CK810, CK860, some with
> KUnit or SMP, GCC 9 to 16) the bloat-o-meter total is between -118
> and -318 bytes in every one. The 128 to 320 bytes in the changelog
> are the .text change, which also counts the padding between
> functions.
> 
> Listings: a standalone file with the old and the new helpers from
> arch/csky/include/asm/bitops.h, built by GCC 16.2 with the kernel's
> flags, -O2 and -mcpu=ck807, plus -fno-ipa-icf so that GCC keeps the
> old and the new copies apart; objdump -d with the addresses dropped.
> The constant listing is the same with GCC 9 to 16.
> 
> Run-time argument: 4 instructions before and after with GCC 9 to 16;
> with GCC 11 to 16 both are this sequence:
> 
> 	unsigned long f(unsigned long x) { return __fls(x); }
> 
> 	ff1     r0, r0
> 	movi    r3, 31
> 	subu    r0, r3, r0
> 	rts
> 
> (GCC 9 and 10 put the movi first for the builtin; GCC 9 also writes
> the asm version as ff1/nor/addi.)
> 
> Constant argument. PP_DMA_INDEX_SHIFT in include/linux/mm.h is
> 1 + __fls(PP_SIGNATURE - POISON_POINTER_DELTA), which is
> 1 + __fls(0x40):
> 
> 	unsigned int f(void) { return 1 + __fls(0x40); }
> 
> 	before:
> 	movi    r3, 64
> 	ff1     r3, r3
> 	movi    r0, 32
> 	subu    r0, r3
> 	rts
> 
> 	after:
> 	movi    r0, 7
> 	rts
> 
> This is where skb_try_coalesce shrinks: netmem_is_pp(), inlined into
> it through skb_pp_frag_ref(), uses that shift, and the function goes
> from 12 ff1 to 2 with GCC 12 and 16. The 2 that stay are
> __ffs(PAGE_OFFSET) from the same macros; __ffs() keeps its asm
> (brev; ff1). build_sched_domains also has one ff1 fewer.
> 
> Thanks,
> Tzu-Ching
