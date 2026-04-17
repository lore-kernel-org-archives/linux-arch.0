Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012046.outbound.protection.outlook.com [52.101.53.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546EF29A32D;
	Fri, 17 Apr 2026 16:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776442154; cv=fail; b=Uh0UuHsONusiSHMyFJaoKhG6BGYrvNJPReT7HC7RSHRwkTHXfQ1v0vWTS+31i0MSJy4S48pLoJXGK5SADHpkm0LasFLTe+5LI3wuaCwPJyTcA74hVHqLjM4pCkblGkCNSaaPTQyU2ZwUr++D0qsO9L0wtwNAFgZ80yjnySe17Y4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776442154; c=relaxed/simple;
	bh=4SdvrMjBymo/5q73PS/GABpPJgD3asjaI1/KncX0zLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=f1pyMGKU+vHZmN0pOQ/47Yqx7BeSNPjZmN6CNsn2RuskmRKWbZtVnp0N0abQ3Njky4HB0FyJ0joZrhp/4GM6A1XA7n5bYIf02WiGzK+iREbJNPm4ZeH9C/L72Z5s2bHFJGEEkFVXFVWG55gRpvLg7PVGx6X1DImGaAG0megA4Ig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Lyz4sT7c; arc=fail smtp.client-ip=52.101.53.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Lyz4sT7c"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zELhCknf/n53DkNcGTldlqS6fLC0pc4HgogD3w+Gp7pCoth2UUQTFy3x3ELHoVa1mlaR0no1OiGCZ0XoGgm5aCyHStlon9UlZEyvi4x4d+LdheCSRTzg/ZGtDzfXVfWAd4Z/he11GDrdbMdx+yAh0r9GTeYg4j27BZdygBxWuhTbI3paruovaoc86Ogf3SdGL8vFoCjPx33jvzFC6slgcmiV5EinP9AaLwtC9doFphUFQQJio77HpZbI7kIqFLPGM4T/NIESgitnVQWe8iCkodtKGuVR/uB/jCYF6svd1+s3S2+gSPLnV4dXP4hLPD3WbCoD5LA7Z0NuKsoX2lhoug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zLd0u5pzMivIZeBkbPi3xhQZ80ADfeTv5vaH2XiotCM=;
 b=aZsCjWzlYEkf0aZ2a8ZA603KA0hgEU9rmBhPuUoXiQqOZ5zSPqy225GCYs7JFnrssLbkIDKC1nGqgwRr0TEdLESr2k/2Y5FOffCz3D4az36RvYfIPs2n6sHGra8SMPTpHBhQYh5urZfgFCW21mVXpwqTgY+Lbt0hyBmzd4c0PDKzBJGGDgcHuA0MMhrwgYINGdXM8Jsrd0ndu/COsIRBxEpMrTj9h2NJIGR3Cixz90BUMIftNNHYZGOcIVpGLFiEnIfj3MQt5KPOEQD9nFi1AiQNZs7O4v+YVr0zPCHi3Ks0n4PdUN5ZdUYQ3RIfx5fphAZC5wmleBER6UpGAHHmpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zLd0u5pzMivIZeBkbPi3xhQZ80ADfeTv5vaH2XiotCM=;
 b=Lyz4sT7cs7lO9TWwRJ6fMH4zVmQTyI/nX/OFJaAgNcaoPUNFsB7L1Eu6g8a9C6f8vh2WUo2SlZGJYue2e1sIlC/W7sQYEe/msWDnLQwQWCFt7NL6CQaSFLYm3YuiJJ41Pl7N566IFalVBf7FnUFLaVQZ3EQk5I6drmaLNZfKsEe/+9TOroQBRmqhPDd6Phu5Xg9dl0TUhCzziaVPKmUBqKb3T/n+lmuY1lyXQkAcxZqMVeHpmk/2Sa93tEn5yBc4Suwlm1PnxGhRQgpDVDq3HdJSPQzpL81WaRU2Qvw5qohgmQRsogzIA6HMzc6cqhwZhUS16gqRjBd8GocSCtN3hQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8300.namprd12.prod.outlook.com (2603:10b6:930:7d::16)
 by CY1PR12MB9558.namprd12.prod.outlook.com (2603:10b6:930:fe::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Fri, 17 Apr
 2026 16:09:05 +0000
Received: from CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de]) by CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de%3]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 16:09:05 +0000
Date: Fri, 17 Apr 2026 12:09:03 -0400
From: Yury Norov <ynorov@nvidia.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr, yury.norov@gmail.com, linux@rasmusvillemoes.dk,
	arnd@arndb.de, akpm@linux-foundation.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, david.laight.linux@gmail.com,
	nathan@kernel.org
Subject: Re: [PATCH v3 0/2] arch/riscv: Add bitrev.h file to support rev8 and
 brev8
Message-ID: <aeJbH7vfRpPuOGB0@yury>
References: <20260417093102.3812978-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417093102.3812978-1-ruanjinjie@huawei.com>
X-ClientProxiedBy: BN0PR04CA0172.namprd04.prod.outlook.com
 (2603:10b6:408:eb::27) To CY8PR12MB8300.namprd12.prod.outlook.com
 (2603:10b6:930:7d::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8300:EE_|CY1PR12MB9558:EE_
X-MS-Office365-Filtering-Correlation-Id: 76022949-ffbe-49fa-e612-08de9c9ba5fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|7416014|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	sjTR74RfZ0VjHe6zJhVFIfXXlPampT1xwI8vd084Mtc79cgR/Rxw+mgvrK2lRDStLvL1/nQUequFiI2j82Y3FuzUFUdNbnsvatTYeeiERBCjvdno0NNPwh1CVi2my8qyIewYo8g5CFdqOiCxQ+dA37aA07X2jA9Dn0dv61FmgvfOiEy2qiD/WXwa7Vm9OSksHTLa9csZOssyUwJSWXhu8jrZLVjjAnBcJLqxA9ZZGu7ZhxA9wtRqXS4r8l03txEVY1YYeUkX0lCKjWPAb7B4TLB3R90y7sl79VXSkBBL9l9zGmcWKKuIpvo7ipocKo2aT36O6Mdaqe+1DPaz0T+Dm843shv8Z5ZJV1ghlw4OPQ8jBQ9BVfovmxcXUES/jU4hP2xHmR9jem+hTkOsTyHyGRx/CwTmzs+aGMT2BrKo7j0F054+gJzohvuNQFL89nycK9Adwod02Cz6cqCAJHWeN+Eqy9yaD4IT6pHa47STc4laC7VudF9F9W089u+E7/Nc5lZFnGgWzAqVoaw/1XHAGL/uVaubW9wH88jO5OBcimSk7i4G5JZ8wpTdcMSRMqHmtR8b+Jc29pnp+LKQxr8ozYsETkRtttvIIRcqqfgmBlECnfCken+iV8iz+aj94J4k5FE6FNB0xqhJunnz8+rmwyP9wdazDgfnO59AwvLqNzEXd0cNFiovojk3nLmDPHA2p4UCjUBmF0Y2UBxw3o8mnqwb4Fzw3NNFR4+reZFn7iQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8300.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(7416014)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mE/DZb0D3m6gJIoqFtH8YOesn7axENywX1DKg1y2MuJqt88o/53xn7+Kbubn?=
 =?us-ascii?Q?QKaStjFmortynNilvZdR8trJu2TJ0sx/FJtmFg9SYB6TUMX1u5DXDz5Fe0qX?=
 =?us-ascii?Q?K7otKLNLO1ODZ/FqKWA+o4dli+5o1TeC+ZfEBDaoPsYm7VFAXJas3soRe1Oh?=
 =?us-ascii?Q?fxw8eJtoA1WrKtGvYaN96mJOrVzB7aaoykDCg9VLi2NkWrrz2XuxOGFkzDMl?=
 =?us-ascii?Q?wv5SPtvbMp4vnJWUYXPpjtxmGfMkgtoqvf/u/1hEGtCd6CS/W5ErQGy4C/53?=
 =?us-ascii?Q?tU+2iZ/NwbegSpxo5dnF+13HhsZJWJZFgBWPK+rpG94L2Q3wohsWbYPToVO8?=
 =?us-ascii?Q?xc5lP6L+I7QZ1NeZKXdpQkHYPwrqAFA15dl9AmXv34lHsoyOsJT5/0FFBlFk?=
 =?us-ascii?Q?mwnRWAQaIxnwa77lhw7XChmhEsyGtbBCkSnnklOpSDQbUKFcBSRCzh8MslrG?=
 =?us-ascii?Q?9VoBjSpVVmp8a4m/R+jIl1YcOKqmEQ0QlorhJ31SVHsRqmuWuRq8R0gVzNJ5?=
 =?us-ascii?Q?LtPVE3K4joSmL4ZsLS7WENZTFgTKCupoxzGEUa15YtV1wHWnymNhmtkMzIDg?=
 =?us-ascii?Q?BFGPwJtwQeUi2ahIZgV5JRVPuVbqlIDPuK3a0z+OK/aBJpIAVhk9MSsr9WAE?=
 =?us-ascii?Q?HQR35pOI9pBX0YZSJlBmFhkRbPpZ0E8O81L0XihbyCqFL6V5vESXNlpriTjO?=
 =?us-ascii?Q?r/wdFjz5BSHhhoeHMzl5uEwtgsJv0EnX7R2/qpgZ3UoGQU7+gfKnQUBqZMcf?=
 =?us-ascii?Q?Wn9WTLG/SvoQhMhLyy6LsHFVzTgrq00Cr6F1qGnK10mylo1jcKATF3WuQyjC?=
 =?us-ascii?Q?7Dzj2TZvkCWdetJjBSiO1jnSjY6Gug7hfcNe6bpJ/EvTBtdk0om0yaT2WmV7?=
 =?us-ascii?Q?GCwq/+UuIsWUoB2Lf+M0CHojO57QSWwVlEnj9UM3R4sApWGRIuBPKW2Y8VDh?=
 =?us-ascii?Q?zdnLkLjcRu997tewA2/9jqHHAaVYSwyY6ZXzM6A0sEXOfo/yAbSa95OegnaZ?=
 =?us-ascii?Q?sXXiZQ3dMIdX4Xfs49HhdVgH/ZhZsXB/xRWH2d//z+0SCyykHYdYzQ71xk2H?=
 =?us-ascii?Q?qicNdx+tkTdx5Q6oIIraz1iziVQV6bdnGb6MIZ+nLMSu4zbaNRWeGhlKdC7+?=
 =?us-ascii?Q?zSW0+9dDvSGaDaeEZs/bdjPPmebb+xjOUESjvQP0fRlp7rckvoQF8w7Nw34I?=
 =?us-ascii?Q?6QUZFRn4zhZdHTDXAuSUrTe/eaK0rhY6MINSSHKAZzUqCVFfExZT5O8qvBSG?=
 =?us-ascii?Q?AdZBolzZjvQxoSr4CXTFdkGQQwc5pRXJexwlMZFc6exkLfFT/EvlfY1RFYm/?=
 =?us-ascii?Q?KpBieX7mPGXbKvb3/S/Oo1HkSf3Yg2BDateCoRNleBF2pYBnO5AkZ96SK8op?=
 =?us-ascii?Q?Kr/yt8Hjo72XvHICOqsoQ2rv5LqLiT1f9AD3/aJ1bND10ANBPTqlvZo0oY3k?=
 =?us-ascii?Q?06wnGZ1j3v8UYmYzClbZdNsf0Xu9W+43DNIRR4tSfDbZBJH3xpBZWWP6MhJq?=
 =?us-ascii?Q?2nCZMaKM/2HwTA0Q12ZXFsFdu/EMsjCNd/cc26gg2fAhUje+gXe3esQP7t/o?=
 =?us-ascii?Q?uCxPq/TiKVTLHhZ39WZBmLIzXrdDxPC3sRxbqMvA6J1O45DyIucosGCjx+xI?=
 =?us-ascii?Q?rGFOEvAQo37FMisBqP146LQwTqXEKxbvshGb7UAHIcMTZpQFFJH+O8P24wpI?=
 =?us-ascii?Q?Vum3weIw+extmaeYEyjSPxAswnk8FJguFNb2qTaFIykGPu8vivyO3D1B9yPX?=
 =?us-ascii?Q?LrrrUAkk4ZDliuxAE0/vFkUtmB7kMu3l+R47jonrp29HRgY/pTkx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76022949-ffbe-49fa-e612-08de9c9ba5fb
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8300.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 16:09:05.3956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uPyv+SEYOENQdYeo0LZC7fOCKC/rOV0HOcAVIrz/qzxKVu9fmt3y9nv/RGBZ7+fojPb749zUo89CVuYB+Lh84g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9558

On Fri, Apr 17, 2026 at 05:31:00PM +0800, Jinjie Ruan wrote:
> Add bitrev.h file to support rev8 and brev8 for riscv.
> 
> Tested functionally on riscv64 QEMU with:
> 	"-M virt,acpi=on,zbkb=true,zbb=true"
> 
> Changes in v3:
> - Fix the build issue by remving the CONFIG_HAVE_ARCH_BITREVERSE macro
>   for byte_rev_table.

No arch needs byte_rev_table, except risc-v under a very certain
configuration. Please find a better approach that wouldn't bloat
random victims' .data section.

> - Update the riscv implementation as David suggested.
> - Add Reviwed-by.
> 
> Changes in v2:
> - Define generic __bitrev8/16/32 for reuse in riscv.
> 
> Jinjie Ruan (2):
>   bitops: Define generic __bitrev8/16/32 for reuse
>   arch/riscv: Add bitrev.h file to support rev8 and brev8
> 
>  arch/riscv/Kconfig                    |  1 +
>  arch/riscv/include/asm/bitrev.h       | 55 +++++++++++++++++++++++++++
>  include/asm-generic/bitops/__bitrev.h | 22 +++++++++++
>  include/linux/bitrev.h                | 20 ++--------
>  lib/bitrev.c                          |  3 --
>  5 files changed, 82 insertions(+), 19 deletions(-)
>  create mode 100644 arch/riscv/include/asm/bitrev.h
>  create mode 100644 include/asm-generic/bitops/__bitrev.h
> 
> -- 
> 2.34.1
