Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792698074;
	b=ysg0CP0WRLmfeZ69bAPMerXIV0cnWieWTFjEdkBwgIyN5EtYZzDhAnI11ox6SItbvF/q
	 razrpQ0GIanmaXjkcPJvyttuICR5DJKoJQxqZDFyMuBqk4yVC4mH5xLLg07FhrraT1x/a
	 muBbvP6t6MiMXSA6vQhb7RstM5f01ycXESIQqehAg5RhV3VXFlAXszZpWanYKt4dH9URG
	 RVzGskJMR1WQduEdNmQuu+LsVB/gDaZO6TKnP2c+Wr7rK58+zWlss/NTCP7Z1S7RZm+57
	 5pggtwjbsQb96xyyjQsixByjEOjoRqOYZu5DpR6OLTQrqqpvYnW64qe2vLAsG7CkTYw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792698074;
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
	bh=z3i0AZNv4XQHbJf3m1TV5gbxsQQzIo9DlKW+LNeaAGI=;
	b=ikWRwyzyj20RDfh3lAdGgCjk2iJjr9ZT3lL9EbmMBWuBG4PsHr/uwvVN5hGQSu6gXRJi
	 4FnMD1xrkNftYmzKNId33Z1U5suYJrDXaSa8ZLYyhJoVQQgL/aYtbEANro/oLoqm/soM5
	 3rwyHCE/f9T3DtsWUHkav0L+OdRGdtVzcLr+fmsksK5i+OS7J6g/qOnRUOCDdgB5KnL6V
	 IT5ylonddzIp4tWB+jm48pATbu0L+Tfi8OU+FJrcodsI1ucyRnFd8Xw2SeIwkBuNdSy2r
	 tVKWFC8SuiPLPl3cw8v98Q35lWtzS+CoQU899KYYSmQMMl6nK8lte3hSLnraD07qJUQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=bMtMxNvv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.53
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010053.outbound.protection.outlook.com [52.101.201.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E324606A319;
	Thu, 22 Oct 2026 19:41:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E324606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=bMtMxNvv
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HdPecUGz6A4m+i1Lyct5m43ekyedqkELYg8kSCa8uUjkXqf/12/NKGhQ/pYuucANH7UmQbnrl3BA8WSTu7fZg6vzaU4VvPeiHAQmB07jWmxmKdJJt2kcT5Olg1tD3YU/Bh3lg3TA4b3Vmui8YjN3Ml8GvCj08m38ihs4ZRpgNU6uxhp9yKQMr07J1DvNkxDBsY7gl0l5jZ4Nech57B7XM7VB/4gAXqUVClhwlrniuZj2Ep3Wk4i01+/Mti9upMiNdVMJp7JWylfuN3keAt/l9fTrQXIFBL2bioiKyLfO5iLNwIoahP9CfPdLmhim7+t9eXBBv3m5U27yKiGqBefZmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z3i0AZNv4XQHbJf3m1TV5gbxsQQzIo9DlKW+LNeaAGI=;
 b=deVU8m4YvIUZ6csqo8YRf+ji5zH7EPzyx9oPFeoWbUXTQ6YeD6Q2ZURtZYSXJJsmzh5E4om5DTxnxUB+7KqbOUvq0GMqPPNHe5UEUw/Rgfyk+W4qOS+BO39crFviZc19SKlzzZnvZNxiEYh6Kj46S+gGqvQVHgzP3Ofi40Y1bZLY75Rpjz9YCakjBkXP0K/FZnoPPG8G6rNQoq70SyJC6oL7o3w30j1Y/NBJVE79rV7KErkZ5f0AiRjoTgMBGoH2+tZwxf8FsonUDTW2H2R0SzcyrzfKv/cCP5AjlA8Bsgw4AdM6TCv8zuZOCz4YdLBPH0m6W/i5+eLcDcaOqqRuKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z3i0AZNv4XQHbJf3m1TV5gbxsQQzIo9DlKW+LNeaAGI=;
 b=bMtMxNvvHHRU994kQEszaZs6V9voGGqpDxZxObyPioB7IIbjhN1quxM49eC36csIc4i7BmbDuSRi7W6PdWIf/j9RpYLckSA+/REM6gVqYn+2++Q/VUeQD8iCE2SDEcQezqPi3iLk/ovx8V5X7D7Nrhoyu15S6ZnmeW9Dd/JlYTKvPyaIbJLhBEGfoiqbUZcpn+0e8BvxA/7jJdiPXXYvkZW4lN0t2kPcivKzWa0GeHNWw8J3jMe9TVAVrXZWB52+euiddtF7NsRhxSoJHL36GRypUuVWCFLBFhH3cauPWAo3cc5xQmdYYuNDnwiw5C0JKo5y5aAqvD7VTZnll6nO9A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by DM6PR12MB4265.namprd12.prod.outlook.com (2603:10b6:5:211::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.18; Thu, 22 Oct
 2026 19:41:10 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0496.015; Thu, 22 Oct 2026
 19:41:10 +0000
Date: Thu, 22 Oct 2026 15:41:07 -0400
From: Yury Norov <ynorov@nvidia.com>
To: Tzu-Ching Yang <shingekinocore@gmail.com>
Cc: Guo Ren <guoren@kernel.org>, linux-csky@vger.kernel.org,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] csky: bitops: Use the compiler builtin for __fls()
Message-ID: <atpm00m6KYhXo6Wi@yury>
References: <20261022115922.1210342-1-shingekinocore@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261022115922.1210342-1-shingekinocore@gmail.com>
X-ClientProxiedBy: PH7P220CA0079.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32c::27) To LV3PR12MB9356.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|DM6PR12MB4265:EE_
X-MS-Office365-Filtering-Correlation-Id: 974bf468-3a47-45e2-7dd6-08df30746c6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|10070799003|1800799024|23010399003|366016|56012099006|261022113327099003|261021135927099003|11063799006|261009223327099003|261021123027099003|261021130227099003|261009223027099003|261021133027099003|261009221227099003|261009220027099003|261009221727099003|261021121427099003|10067099003|18002099003|22082099003|3023799007|261022105027099003|261022075727099003;
X-Microsoft-Antispam-Message-Info:
	H1m1rbqVw4bWkqpVIhyS6o7HpT5lK5v/4vooEGZC36AjRRIhcNSGd1H3rZCbCR05L5Mv5XVBVWMIQtUaG7jo5T4tx9jVuoZcmtvI3jh8b/qeWZVjzV2vsvU1whJWWSjbv0kWLCThmc6oNOqMkOvrIjfSi0mojQ/Nn0oBsSK7Jc3zlNtWg6Ty2Y6nPoZjcU+tWk/WAlHiHioBkpqXJDN2+87LG09CoUm+V13F4dho2iHFY+4a2SpoB/E7pYGtQvgd2JK5U4b3CWoNbFcJfX4MHgdQSAhCheH7GMcMNS2Qfu31ViJ7S8xqnnbxlHwM74lYnj7jOtCWO22q9ct+5QroBhEoXkktknWGsM+/TekFll+jwq2l3Kyju/PW6X1XzsqQzc03iHqnS2de2Bt3S0nHIzI2D8+nLL3R1iW+KeN7PqBRX/GNDq/z9h2wyWGj4FOnRQHm8PT30HJ/HNGqF+u9GlVdxDmzQaqQd97aYyMVCUlxYKcvEaJlzNzxSIvGUoqg1HIpYoXfm1/hPtG3FIYcvYBzlDsfAawOAERIS5QTj9h0Uw9QPwkZy85keVBlM8dAgCWHGm8n0x54SAOK8wP6KHlHkQYLSnv7/bWOhy0fGe6paTRH14bvhJAGsHj5RJ5y/YJiH0UOAL5xVzCfLlYtHkQgi4FfsNHa6qfnWsbrOrM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(23010399003)(366016)(56012099006)(261022113327099003)(261021135927099003)(11063799006)(261009223327099003)(261021123027099003)(261021130227099003)(261009223027099003)(261021133027099003)(261009221227099003)(261009220027099003)(261009221727099003)(261021121427099003)(10067099003)(18002099003)(22082099003)(3023799007)(261022105027099003)(261022075727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Vm2YPFVnpuhf+t0Kku2vQ8BBukBolx4hTq16uCL+Ob4voBfp/Bn5glh6rpQX?=
 =?us-ascii?Q?h4vyRfgTkvhWK7t2Nggp7jop+EAT1MAHz3ZtgtGc6OseNiKzy5F+2hAs5Jzh?=
 =?us-ascii?Q?KGBd9PZ/b+B7rCv/Xm3/pdsfgSInT2Bia4WoZOy4AW/c3tKu7mBo/9pWQpG/?=
 =?us-ascii?Q?e1nkTuitSvPjYmvR8eZj1siOYEi6PdWYtR37/XzWxZ1Q0OcDbiF5/GEd8C08?=
 =?us-ascii?Q?mzZyGA9+vmKgX7u4Z3U+CXUloKCAcGHX0cuUi9j71P8sMI6zmTGDY+i4rw+W?=
 =?us-ascii?Q?I8nM5vzeUATPJXe3YnBxZST/CqSqiVR/5j2Fu5v0QI3e+lvevBIRpR0k/B94?=
 =?us-ascii?Q?OROvB/yzdgPCc/QkZXGqUUXW3KRRrXeK4ed5qpvqSpxa3gKxSog3pefVvafL?=
 =?us-ascii?Q?iWuTQOcnJa/V9Ci6UBSmavMXkXf5cqwqGaQRBl/FXFPsgbOSTJd9zwqOzRGD?=
 =?us-ascii?Q?VVS5pR7Q2jGxb+GDZcBZlRubKo6Y4XiOwu6wRLVjpWxcNgr9bevop8R78OyL?=
 =?us-ascii?Q?RvOaezoicS4o9r/hOeEsmEB8ajAoMzURgPMP3txjKsdUxniOKivIitSgSQxP?=
 =?us-ascii?Q?BSNBzxx5gFpBzXTSkm+D60YJvPY9rToT5aXrlH3+d1tJD1Lr8t8gAb1FIN5m?=
 =?us-ascii?Q?n/bab43pMw8L4vB5a2OnlSJtPP6nRWx8MEV+gKCjJXhUES0p4NcT/VrH69Mv?=
 =?us-ascii?Q?q1yZjt8ViCHfJsi0fTw1KDLng2XXyU4xFid8qDQM9T1OO3eT/Ivb1gUFTfxA?=
 =?us-ascii?Q?fH0A8b9OaHrkTc4tcz7l1cR+mTzW7YPZwXunKm2uUi4y0uQkaqvOBqDgGENj?=
 =?us-ascii?Q?y7V70SF3xwZzDO/uIG2HBgPF5H184PHwNs9/0ywPmMO2CT4ljBtp7iIK6PO6?=
 =?us-ascii?Q?5R31sb/ImGov/1Ak3ZuLUfB2XgY78ZiB9G/z+7AC1ExMNbasPAS9IPj3yg9a?=
 =?us-ascii?Q?u38oOxbkXJeUeVEB+k02K9vf7vIw1/HfFBW5MJtqdc0+BTFwM29yB+s0HKij?=
 =?us-ascii?Q?7kLzPHCTJHt8/DBSj1YwdLdfgQhqPbkmQgFmGca16nhB3iMcjmgSAUEsxnwy?=
 =?us-ascii?Q?cZeokyTyG5nCM8bAz4ExebZtHj8HxC5jnc1QaVHuFVsjmdGsw9PZjG3qJ8gD?=
 =?us-ascii?Q?08T/CBveZGhBfLpxNqpG/txXJGBCKjWGUFL54bXRRpFW/LzAI42DhqxgRb9B?=
 =?us-ascii?Q?jkFj0C8AF/TMd3NWP4A0oRsV//dAXb02jmdtBiHex+WwD7pwGuTDuadvw78X?=
 =?us-ascii?Q?O0Z4a3wWuvFlVOD1uXkSfFtDG+IATCwDAA/zZ3s97MQPWZJ9SmDZ/uF43avN?=
 =?us-ascii?Q?2kHXCCjerhV7Qwwv+6dwq/lJxrVNmZwy/8NqhfydORYtr0k3ZKFxtJF8FKJ7?=
 =?us-ascii?Q?ydE8ZsQ5UzWXwFOUAFU3LiRbJ2TWDZsPXxTolEP9d8zxGjrgMpPNPApYTM5d?=
 =?us-ascii?Q?WmAbgNAUnwr0Z4DySXEa3kHnrJws0oanLr/PARSy7dIzaTSWM9SnFk8k478H?=
 =?us-ascii?Q?KInoxY0/SuqNfdQoDmMrAsbnX0gIlvgnkvyMIM24GxxPgKeHVqzHf05K6VUc?=
 =?us-ascii?Q?xD+ydnlmKcqWaom2FsrVVaYt73iCcIDgmFkUT0cbeWxBipi1cqwc3SaCMZ32?=
 =?us-ascii?Q?XjMaKBAtKbcjhbjiP8cG1xUvsfmxq0GWotqaUX6xUY/zZ1nt0gh5zCKJoRq2?=
 =?us-ascii?Q?yBY7M2/LHBNc4roAqdTey+B3S7poYvftsqRlfbnJY2Artk53uoZwLGHymDDb?=
 =?us-ascii?Q?EJeTHQ95dzJQddFl1KT971kONT3fcoy/tch6yhTSh42gaPGK8fsf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 974bf468-3a47-45e2-7dd6-08df30746c6d
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 19:41:10.5393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FiC4tIkW2zPFeOBIpl7nL5HwqU7FDiK2/5mj45+raT2R/4L1ylVYUZxRfWHeL0w+Evxuuf4VN6K8x2kae5o2CQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4265

On Thu, Oct 22, 2026 at 07:59:22PM +0800, Tzu-Ching Yang wrote:
> The csky __fls() is a C wrapper, fls(x) - 1, around the ff1 asm
> volatile in fls(), so the compiler can neither fold it for a constant
> argument nor merge repeated calls. GCC implements __builtin_clzl()
> with the same ff1 instruction for CK807, CK810 and CK860; CK610
> (abiv1) cannot be built with upstream GCC.
> 
> Use the asm-generic builtin __fls() instead. ffs(), __ffs() and fls()
> keep their asm: GCC has no ctz pattern for csky, so builtin ffs() and
> __ffs() would become calls to __ffssi2() and __ctzsi2(), and a builtin
> fls() needs a test for zero that ff1 makes unnecessary by returning 32
> for 0.
> 
> __fls() now returns unsigned int instead of unsigned long, like the
> asm-generic version; both are 32 bits wide on csky. __fls(0) remains
> undefined.
> 
> With GCC 9 to 16, the text of every defconfig-based vmlinux tested
> shrinks by 128 to 320 bytes.
> 
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Link: https://lore.kernel.org/all/affe7da1-41aa-4710-bee0-5e3c2b8a8dfc@app.fastmail.com/
> Signed-off-by: Tzu-Ching Yang <shingekinocore@gmail.com>
> ---
> In a test function, __fls(x) takes 4 instructions (return included)
> before and after with each GCC and CPU tested, at -O2 and -Os; with a
> constant argument, it now folds.
> 
> CK610 needs an abiv1 GCC; the only one I could find is the vendor's 6.3,
> older than the 8.1 minimum and without a clz pattern for abiv1. There,
> __fls() would become a call to __clzsi2(), which lib/clz_ctz.c
> implements with the fls() asm, so it would still work; a builtin fls()
> would make __clzsi2() call itself.
> 
> Testing: 35 defconfig-based kernels for CK807, CK810 and CK860, some
> with KUnit or SMP, built before and after with W=1 by kernel.org GCC 9.5
> to 16.2 (GCC 8 has no csky port, and GCC 9 to 11 reject -mcpu=ck860): no
> new warnings and no calls to __ctzsi2(), __clzsi2() or __ffssi2().
> allmodconfig with GCC 12 and 16 compiles the same objects with the same
> warnings, but does not reach a vmlinux because of GCC internal compiler
> errors, before and after. Under XuanTie's qemu-cskyv2 user mode, the old
> and new helpers return the same values for every defined 32-bit input,
> built with the kernel's flags by each GCC for each CPU at -O2 and -Os.
> On qemu-system-cskyv2 -M virt, the ffs and bitops KUnit tests pass
> before and after; test_bitmap passes with GCC 12 to 16 and has the same
> one failure with GCC 9 to 11 in both, from a test bug fixed in
> linux-next. No csky hardware was available.
> 
> Against the linux-next branch of c-sky/csky-linux.git (abb81e5ce7d9);
> also applies to next-20261021 and to bitmap-for-next. Full build and
> test data on request.

So I didn't understand if you have an access to the hardware or not. I
don't know the story behind using the non-generic version of ffl(),
but it may be for performance reasons. Can you / someone else please
run the lib/find_bit_benchmark.c on real hardware before we move this?

Thanks,
Yury
 
>  arch/csky/include/asm/bitops.h | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/arch/csky/include/asm/bitops.h b/arch/csky/include/asm/bitops.h
> index 80d67eee6e86..118fb0df5267 100644
> --- a/arch/csky/include/asm/bitops.h
> +++ b/arch/csky/include/asm/bitops.h
> @@ -49,14 +49,7 @@ static __always_inline __attribute_const__ int fls(unsigned int x)
>  	return (32 - x);
>  }
>  
> -/*
> - * asm-generic/bitops/__fls.h
> - */
> -static __always_inline __attribute_const__ unsigned long __fls(unsigned long x)
> -{
> -	return fls(x) - 1;
> -}
> -
> +#include <asm-generic/bitops/builtin-__fls.h>
>  #include <asm-generic/bitops/ffz.h>
>  #include <asm-generic/bitops/fls64.h>
>  
> 
> base-commit: abb81e5ce7d995baa41556b8125fa59e28ba3be8
> -- 
> 2.34.1
