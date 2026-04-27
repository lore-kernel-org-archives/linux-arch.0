Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012028.outbound.protection.outlook.com [52.101.43.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7C331F9A6;
	Mon, 27 Apr 2026 20:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777321102; cv=fail; b=st7FJtWaHhIUX54PH3v6sIL9Qop5AL89v91vi51BlHFcBPouNncNRfbD2Npka1/98uRvCSulsLnc4meqEb26RwRDFjRkohYU2armodTEcqbZi8ztSy7LvI1gr/5qKlVjUX2yiZeOzHE4chhGp4iD/YZdqMCvyOkfAdfRmr7wEX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777321102; c=relaxed/simple;
	bh=o2lKcy+X6BIr7wrFgTD/EmB3U4SR5F4CRwUcVkmrp+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sMysIK+oM6UsG+JEONAe/gIVAYtlav6uoAudMiDQqBiO0a527hV3D1fGgeXGsA5+NFeswLQ+5I2E4id3176AUOnt6zHre9y4OiCqv1Te4hgHYPAlRzRgviw8fuBdZvRFiR7pYl9+DXJVuYT5j8a//LuemyPrWmgn5hKrQYWn4Bc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JAqkEeyW; arc=fail smtp.client-ip=52.101.43.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JAqkEeyW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TKSwurLwNpnQ18YptcHGExBoyiZind9vww03Ya+0O+aQVZWUGwd2xe7gtnhMPHC7BIapHm9IpQwbCpqnj1/bcpD0RAlYkgJx3G0uAwvCdozHYG//4BiYMMn5VrNadeuMZWG+BTYdysUgI04NjNGeruAaF8PI/smtdfcvALhrY5QbGKMH69CFHfqOF+izFwg3YB9QXa/L9NSbp7/Y8dZ0Q0kqs+5oPtdAxDDs7dJLDnyP018eN0T3LIXUOghyAWsSFezTflrcf7dDGFRLuuG9eeCorY2hHEP99puP4OBxkAQm+0Puuh/s3WyqDqLuPEr/JLDKWbHi9UK+hTVD7wKqIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BqfghXCDzHzV4Jb7JUu6vo96BVypRROCjovZeui71x4=;
 b=an2w4B2W7TKPyKSXVZ2PFqT82bfuudq/KNzqPcLUxdbuomx0muM6m85zOZCwwkkU7Sa7GxXrTjhdnYO4rsM7pKcRWznSlavDlXqvUWQkdtftGxDIDx7yJohsMWCk5ZObTDXCxthx9PyfX3mkchgB1T6HrGI215Ik2FOH/uwXsxDBH3q6Pwi6gwnhqbRs+8sL27JBj90EQaCyn9DRsH21LzEvSuKyFd0rNwUyr8cv55nb/Jxeu0hjLxPACNgjKMNwZbL+yDuJk6N0irL9r9ZcP2j0mPd+yn8TEyCfqJHS7i3YtSoL7dNa67ZDNQjhYe7Lcv/XNjLe6l2fURpXKPLSig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BqfghXCDzHzV4Jb7JUu6vo96BVypRROCjovZeui71x4=;
 b=JAqkEeyWqx+qTikTqAT6X/66nvla0oE9yCx2M79dTrkKq0vhETSoboPrm1hQ9veVILoIfUmlMPmd4InLD5emSNaTuZHYAcV/e3TqGz+ZF2TaBprZTWAqlzJ01Pwnb4YV2Ll5CJc8F0NAqoZ2dB9fgCiqsi+SOwvoh1sTeq7u7Y7MLZ2sl0qfJ885RBennc9eDp6avTJOlg0DPj2eXLidigNNI7y6r9OVcrzshK51M3XCvtvee8WY0ZifD44bn10MInzQdvfADhIDYoPP8qEVswyfOCliKJmacz7fEaIgvqVn//V2LiqFSrYmpGTgoZtAu80jgSUZ5pneFv7JbFnr4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8300.namprd12.prod.outlook.com (2603:10b6:930:7d::16)
 by DS0PR12MB7605.namprd12.prod.outlook.com (2603:10b6:8:13d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Mon, 27 Apr
 2026 20:18:16 +0000
Received: from CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de]) by CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de%3]) with mapi id 15.20.9870.013; Mon, 27 Apr 2026
 20:18:16 +0000
Date: Mon, 27 Apr 2026 16:18:14 -0400
From: Yury Norov <ynorov@nvidia.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr, yury.norov@gmail.com, linux@rasmusvillemoes.dk,
	arnd@arndb.de, akpm@linux-foundation.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, david.laight.linux@gmail.com,
	nathan@kernel.org, cp0613@linux.alibaba.com
Subject: Re: [PATCH v5 0/3] arch/riscv: Add bitrev.h file to support rev8 and
 brev8
Message-ID: <ae_EhtFaeAPxpsDd@yury>
References: <20260421130752.607500-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421130752.607500-1-ruanjinjie@huawei.com>
X-ClientProxiedBy: BN9PR03CA0133.namprd03.prod.outlook.com
 (2603:10b6:408:fe::18) To CY8PR12MB8300.namprd12.prod.outlook.com
 (2603:10b6:930:7d::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8300:EE_|DS0PR12MB7605:EE_
X-MS-Office365-Filtering-Correlation-Id: f97a8322-7613-4881-d56c-08dea49a1d6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|7416014|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	I9NSN6v0Q3ynEmzoYUo8nIrCDy43/1u4P4W9E3/BfKMgMtZaKKWj5mEtCcwCTyikI7VK1670vi+je/FQ2icoQMDApJIj3bqbN4JqxZrBltJ0JdXeYUhZdWn2zC1MQhJgQKdzx72qaJc47MjoyumSBNKlHUr/5YVOX4mSj+8p6QARiv3ADwg427/EkAOKA+RXi+zFb60NCdwCDUKdYAnxKaEMBRjDS1gvVwtc6Fa/7sEBnH48wc7BAHT2JYFEP2XUIwshsCDv3sixPaoPnC07LT48iTi79V5N9K0u3yieUNOjUbqpEtpxaXD7dtrQNNhSKO+Rs7GIZv1KJfdlWaQfZeuMGxlc673C7ueATi44t0+3HiH5x8btUl2/YzMhDHh+FHMHuI+E4lETiz/Wi/eKbIA5/rnbWet2Km2drPrLDJ7qxrvq4zietXaBMAjatvMSyNrClwK14zyNkxI038c5Oa5MpvHEdkxvX43jFblsGois2m9xTMaTBojU9cwRzYT/ib6cS17+sGaCOQbchMqydqRGITnOhK9EflKsGeoO1/4wMhcMNShtTdj4AfNzn0XzFqAn1cwHXnw6ivKEqwRsR/fMVq+aVfq0DAbBXAAJYNdyM6JyCxmaVutXTpOid7wsTtdy2YSU3GzWsNNS6Ng+i9A6yeFYx3uWD+wdtVI/evAlXHaSbUX+wOfwTNb5EaaMikpyhLS85lmxRbuJtjrGSH4PhFyD/yFHIHwro5e/iZQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8300.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(7416014)(376014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qBVr2NWr8d0IHIZGIOBCb9tqeohK+c+l700Roqwkl4P0fB0vDbtRqP4THjhn?=
 =?us-ascii?Q?z8U8acmpxNycJ9omPWKPwViFXpC2+2k/rScaE073A3Jd5NNMMi2Tj2cQeUDb?=
 =?us-ascii?Q?EltFiRHU9UcAE2ZNMUTxX8ZCGpTmJmjCEhkym4xRP7vXrRxy4dLZnHL9YjKw?=
 =?us-ascii?Q?GmFUtwTDg5dtpwhmMWGze+gbX+B/hs1fDNsqNJlyTcBXzaxwfyNUTWy9KD2X?=
 =?us-ascii?Q?P9mengqtOEcSpDkvVMidzIs44zlj0VRhgMWRyZI+0rzaP0u+DjpNfhpw9hyY?=
 =?us-ascii?Q?anAIiIJrtQl7V2ypFfm+tmHFxMFHJ1zM27zoaRGQUdngtMWaLIO5GV1zsxj+?=
 =?us-ascii?Q?HtBJvmPHb8V7XADqE3dRE2omxUgMGa0kx45/oqP2XAWohMSJ8D1z8On4w2aT?=
 =?us-ascii?Q?N2DFsmXqVv0wtNvl1Dl6BZYq2xv4ghsvput5NgpQvxhMrW/U8E0ASSNPLnzb?=
 =?us-ascii?Q?5UbxsFGK6idTjbsztyn/3Hmu7ewLWxac2zjkJQ95z/xmJd1peLGK2E5fR5I5?=
 =?us-ascii?Q?31ZWAYHoCYrThJBTuW8YB8xUxbaF5qy/C6s2SanrCcdj776dVp/H81jwSMIA?=
 =?us-ascii?Q?+CUC9cDd91ahG268lGnhzn55MzQC7ACHbMpmYsmVpKeOA5rcMgcx0NU3QrRd?=
 =?us-ascii?Q?E2huk9wena7AVLeojD/jOBozSe2c3Rde05gL2/ucUtcqk4xaw1RGfkk4UQtq?=
 =?us-ascii?Q?e7284AIJaqMQLAyh3NetZN3hWPNLi9MgLMhFuB1vKUewlFIH3WZA5CbKXq/T?=
 =?us-ascii?Q?T7TbjZWjVp7MsSoO3Agesg+Ey06BLCkzMgjqus/T/elvcWlJXq+c+dwU2da+?=
 =?us-ascii?Q?InJr8fr+MQXvRTfJfZjTtL1PV9BjrIT1EzgrNG62U959Hg0nWE8zb9rRm/+W?=
 =?us-ascii?Q?djYiM6DGbakgVnDsgBJ01eBQuqh+WAK9A92Bq02NkJZ/yueVPpFZS+Pfe7OC?=
 =?us-ascii?Q?e2NNRiruOq53zRnfhz2I3k9gLKmNh6k+X4a/4mchBpjtxlm+BpraqSwqAwx9?=
 =?us-ascii?Q?6W2MrUk3NQ/XcNqwcysyLnKg+EHLtXiCoYghUlq9q6kzY3M49+jgcb33am8j?=
 =?us-ascii?Q?/WbZou/ShHpcKIUzvf7uxvhPbLOVEC60+k5lyLQfHVsOaJyejGrukOwgY5Ni?=
 =?us-ascii?Q?TEAQbWqqHsT7OhUZnrrSPETY5lOYkPcf1lPrf5HSN8cw9QyTX1RqUz2XOQ46?=
 =?us-ascii?Q?gmt6kNbmHVH5Pi+r/JoLSDz144GmXaVk4JMZlavFH0Q7HeSw8vJpust7Cxjy?=
 =?us-ascii?Q?GYKuKfIRIXlnjlA5Oj3HxICQefyai5axAUjy6r9H/r+l+4OZRBzLBU3V4RVx?=
 =?us-ascii?Q?PzPFoAD4cF2AGRlyaCMtbxStb/ZKqT8r5i0CHFDnRWlwD60kKzlEfvJZ7z11?=
 =?us-ascii?Q?Y0PS2avkeTx2Gj7u2HKzopZX/ghfeyQ0Ce4aV7S6iMS7hxzK7AESypES+d3x?=
 =?us-ascii?Q?bsNXlbIzRZfzqwYzRasmWCVP8NzfHht+ebFImawjNyCB37lX0HluStWN3snQ?=
 =?us-ascii?Q?tgUao27G18HMGrH+ajnJsppXrR6kdW5AQLwfIgoyz2FKW5HgxCtqzuo+cEVJ?=
 =?us-ascii?Q?OSpqnOH+Sd8YJmdgJwTAF4OEU2++rk603DraWGFyU7lqWul2XmwknA+nOSlF?=
 =?us-ascii?Q?f4yCIsEeFSnPzH+RZA9DcDL6hXYJfXq1e86HnVenZcoMx6I/PtR6OTlUG51d?=
 =?us-ascii?Q?JHUPhIH8SS6LKaBX6lNvH3KL6twKI6n2DoCwVv6vUFPta48X54XaoVSjh9DK?=
 =?us-ascii?Q?mXcmhXw7H0Xr2GwPPdMR5odFU+a1XM/d62o0JS+iUUAmQoxfr7eA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f97a8322-7613-4881-d56c-08dea49a1d6a
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8300.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 20:18:16.0074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +vesJ7CZwrZWcu9Iq90GEsBOaVRwDWzav7+krNKh3B065+zKyvZYSFnCsEc6yGI7wGeIOiTpwqws/7MdFEoOlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7605

On Tue, Apr 21, 2026 at 09:07:49PM +0800, Jinjie Ruan wrote:
> Add bitrev.h file to support rev8 and brev8 for riscv.
> 
> Tested functionally on riscv64 QEMU with:
> 	"-M virt,acpi=on,zbkb=true,zbb=true"
 
Applied in bitmap-for-next. Thanks!

> Changes in v5:
> - Rename NEED_BYTE_REV_TABLE to GENERIC_BITREVERSE.
> - Add help text and make GENERIC_BITREVERSE depends on BITREVERSE, and
>   use def_bool.
> - Split into three patches.
> - Add suggested-by.
> 
> Changes in v4:
> - Update the riscv implementation as David suggested.
> - Add new config called NEED_BYTE_REV_TABLE as David suggested to avoid
>   bloating the .data section for architectures that have full hardware
>   bit-reverse support and don't need the table.
> 
> Changes in v3:
> - Fix the build issue by remving the CONFIG_HAVE_ARCH_BITREVERSE macro
>   for byte_rev_table.
> - Update the riscv implementation as David suggested.
> - Add Reviwed-by.
> 
> Changes in v2:
> - Define generic __bitrev8/16/32 for reuse in riscv.
> 
> Jinjie Ruan (3):
>   lib/bitrev: Introduce GENERIC_BITREVERSE and cleanup Kconfig
>   bitops: Define generic __bitrev8/16/32 for reuse
>   arch/riscv: Add bitrev.h file to support rev8 and brev8
> 
>  arch/riscv/Kconfig                    |  2 ++
>  arch/riscv/include/asm/bitrev.h       | 51 +++++++++++++++++++++++++++
>  include/asm-generic/bitops/__bitrev.h | 25 +++++++++++++
>  include/linux/bitrev.h                | 20 +++--------
>  lib/Kconfig                           | 18 ++++++++++
>  lib/bitrev.c                          |  4 +--
>  6 files changed, 102 insertions(+), 18 deletions(-)
>  create mode 100644 arch/riscv/include/asm/bitrev.h
>  create mode 100644 include/asm-generic/bitops/__bitrev.h
> 
> -- 
> 2.34.1
