Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795030603;
	b=1dYF5GG4zLimrCKAjg/M6HWjLhKWU0USvpn/VecsgRzmQWps8pyDgcCVHHIcAKxnRezx
	 8+F2qmDlSD9ojkQmH/RojNTwl6xfFZSB/0guO+Qx5coS/RSXx0ryPaAin1PIh4WJnMguQ
	 auWmk/k1nhxxX/rGgtZjRFOWgkC72FivGViHNzfv94rsx0vhvTMyaqQ9sRPJqhlLb0XUr
	 U5+Ket6GncVG3zQ1NAsvQA6L3dJJBjs3iOWDBsDueEfvmmcr4u4aPLd4N1bkehPqExqh4
	 B58mTykshr3Oqm0goRxIoRZL3SyJlGLMYfbGbA1TyRS4l+5WWRvRcHHZGRfb/4xOtEg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795030603;
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
	bh=jc/Bg5KeNWPzRZfBZFQHFFsfcct4miIggNr3HlsGPnk=;
	b=k+5b9CMb4dqMNQbdPjGpNW+amfF3ZdPP5fe7cnwetQvRuXT2Hwm9aAL/OLTgLszEYzia
	 rsofHkkMZS01qbmxsx0I9dpFeda8OUjJFLuPL5nAF6VD9pmMPHoW42/+RRfIJMYpKuovv
	 NEkLu1xjgTPiYRWbcDKvpbZdXJznu0vnxjwX+ctf1MDq2Gm3WP0DX9/QmonjBpLEkRfrC
	 9nl7I6X1ZcOh5XhCwdZNGDgeDu88Z+RWe/sbfbPXZ2W4NKmxvE6QDlXS9I3mBPZPyQlfH
	 zTVszvMiTtIvaQXiOEQuHY1pWfH+N9SnK1sFPyL3AAZ2lu5LSvQVtryVyxK3B6wFkCw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=s7G4VDYN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.15
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010015.outbound.protection.outlook.com [40.93.198.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E4E6073D4D;
	Wed, 18 Nov 2026 19:36:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0E4E6073D4D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=s7G4VDYN
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tu0+WJkoImunbS4q83J5GgsSAxqyyEAzisZYkVmIbvT2sz440+gZZdkiLWX7sNRKMeiCLtzDAUCyY6FLWyabedAcr60bamS920D7U6L+zPtijAduomZ+LB87l9Sg+mTdTT5y/fFB5lATebLrEjMKh8HuZPrYIm1S0vkodlhFyKUlmFNQX/lALY/PnD+l6mffvMcVThJyF1Ylvesflq7uj7kBQnL84tM5634wUHlczj+rrq5HEH82mesBI++T+xMmX40ye3xuniKGfugun/MOuw5FPc7aleWY94qiE5JjmC9vzy+BoCVv+SmJtdurQ+jYGDkjyVDFPxtpEQgkyPm3Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jc/Bg5KeNWPzRZfBZFQHFFsfcct4miIggNr3HlsGPnk=;
 b=GVhArOv13iqud6VXyvQ3ElNtS+i2gtze1ilm2eRdoRnI5Xhsoi+4s0qGziyvau43HPdCfkHddzLgwGEncrwCMpLFzGhkwQBkIkhRrJBhf9mueY2Y3036icCopk5/8JGd2/a00Kcaa1wmM1V/ux5f2mUBZXrJ6u3/SzQ4sPhbTq38/scMXpMXs+d7z9x5yYnOOFs5kBriAChleaYO2bP/OibUoy0Kg0CthtCAZLa0WhcpEjA1Vgls+a8TSLRrodtu/kYHkIIWAoddO9e5phBfm53icKjV2f+xxDI6JY1GAF6i87YCDqT9GNT55QaaoXLk6xrxylRUD2nLCUvUXb1Zkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jc/Bg5KeNWPzRZfBZFQHFFsfcct4miIggNr3HlsGPnk=;
 b=s7G4VDYNLkpWex0i827vzfEmgi5NzlD+cUCp4Oigj4haZ4TOyhBWKf1QTErjiE+cZsoQcrEnT1qEV8mz3HM/v3eICVzFIr3DQJyE+CqKDbIHeVpSb3KeYb+kbkldefrrzfz3uEyMFLnjfazUcIo8oqOz/tVRTxyQ1N0Oo7Mk5gbuwQyJ2i7c6gKbjt5DN3c5DhAFH9+aVwmfPIjPmgsU0CCGpIPZ9RrJrDPyNtpnIi8M1LYNCtFY0Sl08FauKY8nH++ov/ndgVKX8GwJcPIKSAqo1o+ukFVUIE1FPIT61NSimN86w1B6sugy2FM6fGDJatse/Q0dOS0ng+0td/In3w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by CH3PR12MB9023.namprd12.prod.outlook.com (2603:10b6:610:17b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 19:36:37 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%4]) with mapi id 15.21.0615.012; Wed, 18 Nov 2026
 19:36:35 +0000
Date: Wed, 18 Nov 2026 14:36:21 -0500
From: Yury Norov <ynorov@nvidia.com>
To: Tzu-Ching Yang <shingekinocore@gmail.com>
Cc: Brian Cain <bcain@kernel.org>, linux-hexagon@vger.kernel.org,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
	llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hexagon: bitops: use the compiler builtins for ffs(),
 fls() and ffz()
Message-ID: <av3-Nf01tdGw62lh@yury>
References: <20261117054939.2126980-1-shingekinocore@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261117054939.2126980-1-shingekinocore@gmail.com>
X-ClientProxiedBy: BY3PR10CA0009.namprd10.prod.outlook.com
 (2603:10b6:a03:255::14) To LV3PR12MB9356.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|CH3PR12MB9023:EE_
X-MS-Office365-Filtering-Correlation-Id: df2c0a65-6ffd-4f8a-d029-08df45ab4150
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|10070799003|366016|1800799024|23010399003|11063799006|56012099006|22082099003|18002099003|6133799003|10067099003|261009223027099003|261021121427099003|261028144727099003|261026140227099003|261026121527099003|261022105027099003|261022075727099003|261021123027099003|261102123227099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	3a6fWcaEva7x0iGWf2FVla5m5nN3OWHnZ0/KdZV0+0U3POyKYp5EWZuTW9bZlsT9O5Qwy+uX4Sa1JE1i/OA5EH5ZiPOFahTG2gp3KYBDqzROCZK2SzqJz5rttM2LMvYJKrwhzn4sF4nxmHB5VGvKXUASbDOTYfue+4oYD9JhlwYLOwkGB6SNuATN7hPpAdouM9aoESeX5WpqAjX+E+wAl/qdedDs8zfgN2KrQAoC28kqw0+icH4u4wAOVjkOuwfo5E9soAUDejimcB2dURPo0ZRBy8rPAmuNDkZQdyVD1YAeE//f5vZ3O5yP/Q4+5hPD7Qa+0hhUGuK1UUo0keE2aKfbBEJQusDPKxAJzuJM0WNj7YqVm8s80U3R+8Qfk67d7ixv4S4TWiaVuxMdGc9/b7LmP/GC8EFHW7KkPQymmKSdHwS+/GJ7tbWxbWzmDNiEgOZLwLSQ1gdIwdC9kwRU48/UdrxarswVF6uE+6nrd4Jt8Idk+ATFendAgwN9nihQIy8+VcOQhRX5zUaSIWm0+BDqLQxIS60RDmYMFiMM4mxNEaDgWpJVJbAmSBNlGIiBao1IJ98qorAITj3F6PcfN8gtnCMEEYXnGZV+TUVDycg+9I6WrtBLr0UKXDDJvw2I0CghtLuNsPVetH13mX6mRjr1VFY4nq3tQL7wRPA21Ko=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(23010399003)(11063799006)(56012099006)(22082099003)(18002099003)(6133799003)(10067099003)(261009223027099003)(261021121427099003)(261028144727099003)(261026140227099003)(261026121527099003)(261022105027099003)(261022075727099003)(261021123027099003)(261102123227099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iTYSSNKUN1OQ9VmZvzTH1WwI+rURVDi2E3UTW47J1lb5BCI4ZGYI39ycFZue?=
 =?us-ascii?Q?vd2tSzG/ZmOvfBdx/Ph24oQbReXdZR9Dn7g+RK2wzbyNU/cO7NSURQo8dhJI?=
 =?us-ascii?Q?BmPxHHFRUKAeSAAZyZeWmVLndpJdMRPP7OD/JAYggzClt0Un1fSnN5RC7ynf?=
 =?us-ascii?Q?Q2HzIftRIt+b/vw/7uo8bnYTfA2KZz4YCl/R1MWDoVSjiC6CbKQSe4F+b3EK?=
 =?us-ascii?Q?lTm7ph59PG7QIv8ZAZWfq1D3OnAMUUFSSqi4uF1ewPXg0sue62dSmOe2jY+Y?=
 =?us-ascii?Q?ocM+nRqbx7L6YrbkFFIIGMDEyLbASaFsp6KT7b0mYG2MrYgN3YadMs+uQPG6?=
 =?us-ascii?Q?sPfM7Dat+39OBpKr/ipnBQngHr+sHmpJsvXjBCL5Bx4sr2wLvf74he4rnswA?=
 =?us-ascii?Q?2Md3T65jSo0vykNdOTiwoIAHa9wH9NMix09yhLTyF8yBrzTAKuKD6C/0pcm6?=
 =?us-ascii?Q?2JIQXFIntvosvEBhGcsySniQF5nBu3RbUEU8tAbLNJ/SujB6M/vlxTSBsoLn?=
 =?us-ascii?Q?6YLEQAjM8AwXONuHSdLtuIAXkB7qpiuALqy5lAwvdoIlbwZDcMI2sz+S9ms7?=
 =?us-ascii?Q?Fe2XbMnDshTp35P4MVQDdwX/lD4hfQaPDOoINWSxl5WYcHZsCdKKZZAeS9GU?=
 =?us-ascii?Q?Hedk1pNJyvkxb1x/Rp41RVoYGdaFVir8dh9EqsVkQ1ENN/pHyBssQYawcr2K?=
 =?us-ascii?Q?8cU4pa/8xNTAH9Jec1BSUKtjNq/1EI2TJT7iTnAlbXUhA6YhkHJKz9fxxmTZ?=
 =?us-ascii?Q?CCNiGjnA9Yk/rKjNArq9lV5fwqIAsdw72SCsIWFhi5jNuovPhQQmiKqj0Xqu?=
 =?us-ascii?Q?CzeZ8mlazj5JqGu9EY+v+eLBc14MbOzE+hvjwcE9ZBHh27v4bT1bYw3dLtr+?=
 =?us-ascii?Q?uGqJLJuXQaj5TYLWeLrooXEH6uG0stg12eVvf8nyE6dffAujKOL+B8Yw9349?=
 =?us-ascii?Q?YgBYR1PU/DfqWeT4owd81UA4pGtyeDh2lJMkdH+d2FDz987HsAh5QHybx8JE?=
 =?us-ascii?Q?At87TEo+i7/pdz25Ik9XNdniiy1coWwgOyCUFvtaEb6uB5brm2ATUuexI30O?=
 =?us-ascii?Q?3RkkHb3H3uuGRfHysoY+gY+shgEuvQbQSy+K8mBgnvhT0QTFtumJlS+RmAQb?=
 =?us-ascii?Q?zPlqm1btNyKv7GdGoAw/jgIJhOktnR4LwlhcUm7W+eT8TbuAkD7tFAS0CikM?=
 =?us-ascii?Q?M5OvIc4lXV0G58QqBXOFH993PpbtObAyr/YjXWB8b0cIEtbBMxbbtwMAtZYH?=
 =?us-ascii?Q?qbIGMjfKMl6afaGqsUMcuqQcEUcetyY3clUbheB/8hBL6Qkau3OHvSraWfLE?=
 =?us-ascii?Q?P5OxFhcCsTyW+SkZeindy+B6/aYSkNcnbd+7i/VT3kgD9VRSYH9VSG1HgpzI?=
 =?us-ascii?Q?p+AppbvC+oWpjyPwCfqeVMMWmcXsHayYVsYoOEvO/nslvN75PY/+BA4GgKy2?=
 =?us-ascii?Q?9QzL+/N+iqEfbuoQcWW+xpwl/SHofJIIBnBr7s2bMaqNnNE33vWAAW71TR8B?=
 =?us-ascii?Q?XQ2rxE4vBvGzXrNw+Ri4+Ra1cxUZ122tCwZ1/pIDBQAMDxkLUTuM2JEqx+Gg?=
 =?us-ascii?Q?WerO5jC469EpF/Wl5syqyzbsW7inKjuzF9k/YFyTZCchAe9nWSUMkUUkZAwl?=
 =?us-ascii?Q?ML0HtdICb0P5z+WkB8KgfK+i5wNHDMDs7k3WKLsiDWfT1pynhMQ7tcTexu2j?=
 =?us-ascii?Q?VrhsdqKxRhuw3ZynBNUxXD0OHtZItxIPArnUe2k5ImPvUPrSgCRAc2SF3rAD?=
 =?us-ascii?Q?iarBQsP6llgoBHPnlO1FAxcsF8nPknzOnp2buwn0uFQjFWv0m2FB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df2c0a65-6ffd-4f8a-d029-08df45ab4150
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 19:36:35.1171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: itz2/uwg8B7/MwXn8ZIYn3zTjIT4Xq1FBJs9BuW2r1fhlIJ+2w4ZzzBhYSbfvNI0N9fUoYUMsgxarCiIuMvn2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9023

On Tue, Nov 17, 2026 at 01:49:39PM +0800, Tzu-Ching Yang wrote:
> The hexagon inline asm for ffs(), __ffs(), fls(), __fls() and ffz() is
> not needed: Clang, the only compiler that builds hexagon kernels, emits
> the same ct0, cl0 and ct1 instructions for the compiler builtins, and
> unlike the asm, the builtins fold constant arguments. The asm dates
> from the 2011 port (a86a7ce30ac0, "Hexagon: Add bitops support"),
> before the builtin-based asm-generic helpers existed (048fa2df92c3,
> "generic: Implement generic ffs/fls using __builtin_* functions").
> 
> Replace the asm with the asm-generic builtin helpers, and ffz() with
> the generic __ffs(~x), as arm64 does.
> 
> ffs(0) and fls(0) still return 0. __ffs() and __fls() now return
> unsigned int, which is as wide as unsigned long on hexagon, and ffz()
> returns unsigned int instead of long. __ffs(0), __fls(0) and ffz(~0)
> remain undefined.
> 
> With Clang 17 to 23, the functions of a defconfig vmlinux shrink by 1972
> to 6068 bytes in total (scripts/bloat-o-meter -t). One helper in
> lib/find_bit.c gets worse: _find_last_bit() executes one instruction
> more per call that finds a bit, because LLVM rewrites 31 - clz as 31 ^
> clz once it knows clz < 32, and the hexagon backend keeps the xor, which
> needs the 31 in a register, instead of sub(#31, Rs) [1]. A few 1 <<
> ffz() sites also grow by a few instructions, as LLVM rewrites that
> expression too [2]. __find_nth_bit() executes two fewer, and the other
> helpers that find_bit_benchmark calls the same number.
> 
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Link: https://lore.kernel.org/all/affe7da1-41aa-4710-bee0-5e3c2b8a8dfc@app.fastmail.com/
> Link: https://github.com/llvm/llvm-project/issues/236764 [1]
> Link: https://github.com/llvm/llvm-project/issues/236765 [2]
> Signed-off-by: Tzu-Ching Yang <shingekinocore@gmail.com>

Reviewed-by: Yury Norov <ynorov@nvidia.com>

Would you like me to move it with the other bitops material, or leave
it to Brian?

> ---
> I have no hexagon hardware, and mainline does not boot in QEMU yet. On
> Brian's out-of-tree bcain/hexagon-qemu-virt branch (dc370baa041d,
> v7.3-rc1 plus 24 patches) with this patch on top, qemu_defconfig plus
> the ffs and bitops KUnit tests and find_bit_benchmark, built with Clang
> 17 and 23, boots under qemu-system-hexagon from qualcomm/qemu hex-next
> with -M virt,hvm=on (and under -M qcs6490-cdsp with the prebuilt H2
> hypervisor); the KUnit tests pass before and after, with the same
> .config on both sides. Under -M virt,hvm=on, with a TCG plugin that
> writes the same bitmaps into both kernels before each test and counts
> the executed instructions without interrupts, find_bit_benchmark's
> find_last_bit executes one instruction more per iteration,
> bitmap_find_next_zero_area_off 36 more on the random bitmap through its
> find_last_bit() calls, find_nth_bit and test_bitops' fns() two fewer,
> and the other tests the same.
> 
> Under qemu-hexagon (user mode), the old and new helpers return the
> same values for every defined 32-bit input, and fls64() and __ffs64()
> for selected 64-bit inputs, with Clang 17 to 23 at -O2 and -Os.
> 
> defconfig (also with the KUnit tests and find_bit_benchmark, with -Os
> and with -mv73) and allmodconfig were built with Clang 17 to 23 before
> and after, with the same .config on both sides: same W=1 warnings, no
> calls to __ctzsi2(), __clzsi2() or ffs(), and a smaller bloat-o-meter -t
> total in every defconfig-based vmlinux. allmodconfig does not link with
> Clang 17 and 18, before or after: ld.lld before 19.1.5 rejects the calls
> in head.S as out of range.
> 
> Instructions of each helper in a test function that only returns its
> result (return included), built with the kernel's flags by Clang 17
> to 22 at -O2 and -Os; Clang 23 adds an allocframe to both rows:
> 
>             ffs  __ffs  fls  __fls  ffz
>   asm         6      3    4      4    3
>   builtin     5      2    3      3    2
> 
> The instruction saved is the copy of the result to r0: the asm's
> early-clobber output ("=&r") cannot share the argument's register.
> 
> In packets, only ffs() takes one more than the asm (4 -> 5): with
> df5e4db805d5 ("hexagon: disable the LLVM packetizer") applied, each
> instruction of the builtin version gets a packet of its own, while
> the asm is bundled by hand. Without that workaround, which linux-next
> does not have yet, ffs() goes from 6 instructions in 3 packets to 5
> in 2.
> 
> Against the bcain/hexagon-fixes branch of bcain/linux.git
> (0304683b4c43); also applies to next-20261113 and to bitmap-for-next.
> 
>  arch/hexagon/include/asm/bitops.h | 100 ++----------------------------
>  1 file changed, 5 insertions(+), 95 deletions(-)
> 
> diff --git a/arch/hexagon/include/asm/bitops.h b/arch/hexagon/include/asm/bitops.h
> index b23cb13833af..975328172b7c 100644
> --- a/arch/hexagon/include/asm/bitops.h
> +++ b/arch/hexagon/include/asm/bitops.h
> @@ -194,101 +194,11 @@ arch_test_bit_acquire(unsigned long nr, const volatile unsigned long *addr)
>  	return retval;
>  }
>  
> -/*
> - * ffz - find first zero in word.
> - * @word: The word to search
> - *
> - * Undefined if no zero exists, so code should check against ~0UL first.
> - */
> -static inline long __attribute_const__ ffz(int x)
> -{
> -	int r;
> -
> -	asm("%0 = ct1(%1);\n"
> -		: "=&r" (r)
> -		: "r" (x));
> -	return r;
> -}
> -
> -/*
> - * fls - find last (most-significant) bit set
> - * @x: the word to search
> - *
> - * This is defined the same way as ffs.
> - * Note fls(0) = 0, fls(1) = 1, fls(0x80000000) = 32.
> - */
> -static inline __attribute_const__ int fls(unsigned int x)
> -{
> -	int r;
> -
> -	asm("{ %0 = cl0(%1);}\n"
> -		"%0 = sub(#32,%0);\n"
> -		: "=&r" (r)
> -		: "r" (x)
> -		: "p0");
> -
> -	return r;
> -}
> -
> -/*
> - * ffs - find first bit set
> - * @x: the word to search
> - *
> - * This is defined the same way as
> - * the libc and compiler builtin ffs routines, therefore
> - * differs in spirit from the above ffz (man ffs).
> - */
> -static inline __attribute_const__ int ffs(int x)
> -{
> -	int r;
> -
> -	asm("{ P0 = cmp.eq(%1,#0); %0 = ct0(%1);}\n"
> -		"{ if (P0) %0 = #0; if (!P0) %0 = add(%0,#1);}\n"
> -		: "=&r" (r)
> -		: "r" (x)
> -		: "p0");
> -
> -	return r;
> -}
> -
> -/*
> - * __ffs - find first bit in word.
> - * @word: The word to search
> - *
> - * Undefined if no bit exists, so code should check against 0 first.
> - *
> - * bits_per_long assumed to be 32
> - * numbering starts at 0 I think (instead of 1 like ffs)
> - */
> -static inline __attribute_const__ unsigned long __ffs(unsigned long word)
> -{
> -	int num;
> -
> -	asm("%0 = ct0(%1);\n"
> -		: "=&r" (num)
> -		: "r" (word));
> -
> -	return num;
> -}
> -
> -/*
> - * __fls - find last (most-significant) set bit in a long word
> - * @word: the word to search
> - *
> - * Undefined if no set bit exists, so code should check against 0 first.
> - * bits_per_long assumed to be 32
> - */
> -static inline __attribute_const__ unsigned long __fls(unsigned long word)
> -{
> -	int num;
> -
> -	asm("%0 = cl0(%1);\n"
> -		"%0 = sub(#31,%0);\n"
> -		: "=&r" (num)
> -		: "r" (word));
> -
> -	return num;
> -}
> +#include <asm-generic/bitops/builtin-__ffs.h>
> +#include <asm-generic/bitops/builtin-ffs.h>
> +#include <asm-generic/bitops/builtin-__fls.h>
> +#include <asm-generic/bitops/builtin-fls.h>
> +#include <asm-generic/bitops/ffz.h>
>  
>  #include <asm-generic/bitops/lock.h>
>  #include <asm-generic/bitops/non-instrumented-non-atomic.h>
> 
> base-commit: 0304683b4c43048082483e9445fdd0691d088431
> -- 
> 2.34.1
