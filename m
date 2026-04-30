Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010018.outbound.protection.outlook.com [52.101.61.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED473BC69C;
	Thu, 30 Apr 2026 21:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777583647; cv=fail; b=aHc87KUXRlfhAnpqYjoLOtiiPsX+awF8kr7ia88G7q/83YN7muzuN8+tPtdqpsqk2kdzXUWNntbkGR6WFk+vt5uoYoKJR/uRcm18+CXk8OotEARJr47OjcGtrNMF9MsHcDmhkmhJ9YFGDnCyt90uJsi6Acz28tnlBZtqw8tx0oQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777583647; c=relaxed/simple;
	bh=ZZ6SogvdX3RuwHuiSbSm8EXeGFVLg43DXgv5SXzLXJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AHvrkA6nTa5k+SLifLsl/1DIcRZ4mmD2y7lQyAFcTE6rhQL6jbPbfcMdYXBqiPkp1kSRmP0tklQ7P5wc391OTbmWnoTdG3KloaQpgK08C0ZmE3Xu3+fJwb1C5UR1V4JaTzZ7fZcknJ6gu8QqNf+CxJnUZqKd/WOzYhC/qoj75Ts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=b6cJrFKD; arc=fail smtp.client-ip=52.101.61.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="b6cJrFKD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=avRTYxa5P9T+7VtkK8mV+r73zZgrFApJV2eDZE4hIRv9xWoXKyVQA1xx6CPIpTc946x7etCRk1+dqKhvuxldjl6TTCpGkYE9wgpSNlLKTtsp3kikJYQfxWjBUjBNRdPvk0DBln+0MVcMma75ZIoYHqCoZx5Z6m2albGJKUNis0QEHDaZSggYhLSe1yrlniCGcqDX+NSy6Nhxsr4474BILA2cYUiGjVhkY/5kFt8AvCeGsitkL4ffTMZxueDBN8VT8CHKqXrmZUHEbBJ5zF5LEBgNVnMeJmPz60pxCXhksK7skUIHg6JEDglcR7cBoHX2pUFFgLjfjR4FoTTKuG13cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RoJww6/Z1UU4ANdDeelHxtmtDjgOW1yfdaDOscA6NK0=;
 b=eSEV+BuqDezQRXNXKUqoEf3axpaXtTyKZ6iyDwE4pEi102nK4DaE6qrxxTQBl9KD03pBokpCNY75KNujLkUgIKfkhzvBkSHGE6gZvZM9faYnXRJwiuKa/WfOFtOUqF0MuL9AUl01JFa1JwcjXF9gfV8cWxDj/JlnedCUU9Se01M4i3DDMb89uz2ZG+TVJZVv7nsIohVh6yiyLWz+84uEZAqgAtLR/exmCeRtJWgDfW8So9NanrByNmzfYubk21fTI24o2ZW1+6rgriGbCocSuadkGM41JfR1pfHCAKt7ltlC5r0xs0GZpABcmbwFePF8X5hWPf6bEXWvkPP3MApGyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RoJww6/Z1UU4ANdDeelHxtmtDjgOW1yfdaDOscA6NK0=;
 b=b6cJrFKD+A9AduRw70jWQ+7c0gEaHSzm3eNb3yHxoaNXD1nvkqLR0Rx+oCJiNzbZ71QHwLrITTVCBUvb01McCIomLoM2FT8IBu/snv/4KDaJ4Vdlanbszt21x5AydPGahVdU8Yn/r86R0Y6wVullu4wWs9AWbPIbKxJQJxLVUIv9uz4vV0JAplp0CsTXjRt1cnppDWF2MA2ftBEbZeuxx7rCvnvrKKgSWGSuWmed36UidswcSfS4Ag7Kg9f6s1Mw3t+0xHC5CiVtVL3fUHlmlNwuorAFi/Vewfb9W6CArZnUUcyxaRpSoHGQUzcHQYK6cgJ/u1ruQOZhSHDMPJfuyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8300.namprd12.prod.outlook.com (2603:10b6:930:7d::16)
 by DM4PR12MB6256.namprd12.prod.outlook.com (2603:10b6:8:a3::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.20; Thu, 30 Apr 2026 21:14:01 +0000
Received: from CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de]) by CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de%3]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 21:14:00 +0000
From: Yury Norov <ynorov@nvidia.com>
To: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Arnd Bergmann <arnd@arndb.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-arch@vger.kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Yury Norov <ynorov@nvidia.com>,
	David Laight <David.Laight@ACULAB.COM>
Subject: [PATCH 2/6] lib/bitrev: Introduce GENERIC_BITREVERSE and cleanup Kconfig
Date: Thu, 30 Apr 2026 17:13:46 -0400
Message-ID: <20260430211351.658193-3-ynorov@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260430211351.658193-1-ynorov@nvidia.com>
References: <20260430211351.658193-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0172.namprd05.prod.outlook.com
 (2603:10b6:a03:339::27) To CY8PR12MB8300.namprd12.prod.outlook.com
 (2603:10b6:930:7d::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8300:EE_|DM4PR12MB6256:EE_
X-MS-Office365-Filtering-Correlation-Id: 54d8eeef-b5b9-45c1-29d2-08dea6fd663e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|10070799003|366016|18002099003|22082099003|56012099003|17096099003|921020;
X-Microsoft-Antispam-Message-Info:
	/WickSFBeO9KcgPf+c5SXnevvyd02WF8qrpvk2YhMr2d/O4HbTrmz38KmMU+cyOj8hnTmRDK2cgDkTiSURjgxnrupCT3V/WduXxQYZmwczOzr79QrJdTdq9GrSXF6sdW47rMf7ZHH2aGNUAWXTtcyTMh7TYpbxEnUsST5bmsJ+hcjgftecxCQxwhC3PrSpmhOIt7c5XLxSTVm6iKrWd4Y2upyExxVwKe1aDY0V2O3il374gA60cCvQK7j7DRJilsdQhuwx3pPI6wP6nHlMQTz5NCp+TtcQlzILXKL5HfWoO46QVqtZ3jtgE8fC7T/mtcvwewmEnPpKG/YvbJnZTeVYx5qKkvDYdyZjzkB9eIsn7QgNDjxN/TLDivdBQs156dDP0cVd4SBp5xmIXXOQJTk+CDm8a6YXxqn2tLUBQYWK1SzyQxQSXwnHqWY1wd3Wq2x43+jaoioCt36ae1Tuz6SIKgno7qoqrLwrZmiFGcQhcpR/EWOaawVeuHgr82j8qMHTjZacvvCQHT4yh5BfsHMiyZLonPV6zYs8XtKP0WXn99hTO714JSTJl6ROXtDvRgzeVZd1V4N3l4+oqkyLILL1S9WxJ8sgQbEhrpv1W4vBPCsT2crenQ3aWDO0ka5RivAc9lJ90MNG/jNLAUjRcjE0WSwZ1KI3mRPHA+fZZ8XKgn6JZADHwi/9uLyZn0GyDaqj7ewi5RCszfK/XmxpeRRTP1NhhvyOGZegcG6EJ/K9M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8300.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(10070799003)(366016)(18002099003)(22082099003)(56012099003)(17096099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+oVLIW2UNr98qlYqaYCNs/X5PU7jLVXIY9NOqrfufvb36xHK2d66c25x0LD+?=
 =?us-ascii?Q?8Cqw5kYzXFwp7UflPcrrONjofZQ72Xxud5WWXh3AT4msUjY6isfNra/Y9t5x?=
 =?us-ascii?Q?dsAnOf3DLOA1lkV/CYFpGzNJvCULy2ahbIp/Np6GMWlAiOlId9/ZLeqlMDMf?=
 =?us-ascii?Q?uDXhh7jVyibgQQKQOeD+VJrg+K9S9i+6CXhJpIHJNngwhgzpAECSLX6Pcq7/?=
 =?us-ascii?Q?xRp2ol5ZwLRJ50l06DQcpFd2xj7UaGE1KRGnrUBBZgOUX/cs3mPB4osKMT1F?=
 =?us-ascii?Q?Y6pwN/aFWQBAYNjQzfTboisZ7gzISgA40FxEfvwBGNUrcHpbUoPE6D9ysZ7t?=
 =?us-ascii?Q?exapYdpcGrv3OOU10U51MZhKv2uEJbvX5MKFggAbEy4Vvf+BpFwjAOPXutm2?=
 =?us-ascii?Q?uon56t9LBc+0b4KiPrJ80vq1JcStwj2Ur253S04rKtDOCNzzhP1sxc+WEhTe?=
 =?us-ascii?Q?4UjMfXYwrv1x5kPVlrgtDt55n4GxgTTyq0hnJwHtImOn6g8r3GPN/NuxRayR?=
 =?us-ascii?Q?fKFUHxbm+htEQub6gHIpOYtBOa+uHF88IN783/5HGm1NwsoGiL03db+dfNaP?=
 =?us-ascii?Q?uNGGb8xmGSxAF6xoWMHOei7bpvURIAEiADykN5ihQAxVwg+OpMss+8BfICfW?=
 =?us-ascii?Q?qK48d2gU0XIjtFCIEB9AtiH0VMaH36moboP77xSA5xBkEJ2O8rTahgylzsVY?=
 =?us-ascii?Q?L8e4XjX3eixHk5ejDdHbDB+8aygvioj5BI2AnAXPhY5I59epG0ufU7vPlYic?=
 =?us-ascii?Q?1c/pb9owHPbXFnDYTgvy88cLDs7z6jbSe+PKwe13ScEvrqzSx0FVSZ/mK7x3?=
 =?us-ascii?Q?gT/TbEfnt8VjLxy6QrNr/W1QJrF7rVa85YODiJuh7NbcPda75I3QUw+HBAw0?=
 =?us-ascii?Q?MIggAP0iLp30NNKjDLKhQnvu3XOJ++7m4rLJTWxrhxHVX1n0avshzmosC6fr?=
 =?us-ascii?Q?lZVgtda10EQMvED+jPvDHlOjRGR8uVzEp22Mj6Hhfz+nTrXtfGgpFWvHiOzC?=
 =?us-ascii?Q?q2KDqiJMxEZ7viZ4XG+q8NYDC017Ismf0yqGErVb/1ilNxwvY1M8FvwizHxf?=
 =?us-ascii?Q?YJJPU4NP51lpJSYzoQ3wW9ORVGGBJLzdr+ksSVhSTEiQ+KoZMf/3ZPG1255j?=
 =?us-ascii?Q?efrA39VqbPDNM2mNnojFz9zKKpjL0O8nUh9NM6T/glUtpRQh4CLj4v1f3Qlr?=
 =?us-ascii?Q?78aua7UMViXfgTpMVTGuXJZ0rA+i/58LOtB8KDzxNfh6HAAHgMgcePLh784/?=
 =?us-ascii?Q?8UHhZ6WEKZLhvZyyS+c/UZdxR/C8l6s74ljTkcm6Pleu7y++BOen41ebwbky?=
 =?us-ascii?Q?Kz3XoWEEKZroTPeLNASm/KzI7OKo/wvFk9f76xsffPCX4xqv5JZDpqxtsqij?=
 =?us-ascii?Q?aBK2WKmltQ/mWb3YvzuFz7JXzY6umRjL51D8CkeJb2m6QbVxQhGtJ2mI92bt?=
 =?us-ascii?Q?q5P7/Y9gqX1P7BR9ZLKD8SoPjC5+zq5+wHaiZk7MDb6yGU6rgqTzk5RuCO6i?=
 =?us-ascii?Q?gpUMn812PR2WMQyVdg3CWL4NS5OTUhsoC76S8k/KBpEl3FBlsLDknn4WOHDI?=
 =?us-ascii?Q?zMfiUfSDs37UZxxdUlH+6PmuKb9ba5mv4zhZzDOHXP9MrCGAv3i7k1NouYCJ?=
 =?us-ascii?Q?Lkc+wx+VCdjtEVdbtqaeSb9n1CgdBJwsr2bOdfInzwNKmiYUGLVESerPJFLA?=
 =?us-ascii?Q?db1j8bqZIHiAyj9qxM+2FZShHkWqLfjERw6H09XJfGZq+2NjCP+HAcoZwIh/?=
 =?us-ascii?Q?O47wCP1uZnfQ2+Bg10c9of24R/C9nNJJux2n49qxtRRDCUk/YcVy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54d8eeef-b5b9-45c1-29d2-08dea6fd663e
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8300.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 21:14:00.8222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gdn3lUTLm7ZSMZj01ZuM2bkj/QyHpneFTe3txlWuseY7Qs+JFpShmkWEdO9EUGKZP9s2A2greJWa8vkwBZq2gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6256

From: Jinjie Ruan <ruanjinjie@huawei.com>

Currently, the bit reversal lookup table is controlled by
!HAVE_ARCH_BITREVERSE. This makes it difficult for architectures to
provide a hardware-accelerated implementation while still falling
back to the generic table for specific configurations.

Introduce CONFIG_GENERIC_BITREVERSE to explicitly manage the generic
lookup table implementation. By using 'def_bool !HAVE_ARCH_BITREVERSE'
with a dependency on 'BITREVERSE', we ensure that:

1. The table is only compiled when needed.
2. The .config is not polluted with useless options when BITREVERSE
   is disabled.
3. Avoids bloating the .data section for architectures that have
   full hardware bit-reverse support and don't need the table.

Update lib/bitrev.c to use CONFIG_GENERIC_BITREVERSE instead of
checking the absence of HAVE_ARCH_BITREVERSE. This provides a
cleaner interface for architectures like RISC-V that may want to
selectively use the generic implementation as a fallback.

Suggested-by: David Laight <David.Laight@ACULAB.COM>
Suggested-by: Yury Norov <ynorov@nvidia.com>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 lib/Kconfig  | 18 ++++++++++++++++++
 lib/bitrev.c |  4 ++--
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/lib/Kconfig b/lib/Kconfig
index 00a9509636c1..3ac12308eb76 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -62,6 +62,24 @@ config HAVE_ARCH_BITREVERSE
 	  This option enables the use of hardware bit-reversal instructions on
 	  architectures which support such operations.
 
+config GENERIC_BITREVERSE
+	def_bool !HAVE_ARCH_BITREVERSE
+	depends on BITREVERSE
+	help
+	  This option provides the standard software-based bit reversal
+	  implementation using a lookup table.
+
+	  Architecture-specific implementations (HAVE_ARCH_BITREVERSE)
+	  and this generic version are not necessarily mutually exclusive
+	  at the configuration level, but selecting this ensures that
+	  the generic `bitrev8/16/32` functions are available when the
+	  CPU does not provide native instructions (like RISC-V's ZBKB
+	  extension).
+
+	  If you are an architecture maintainer and your CPU has native
+	  bit-reversal instructions, you should select HAVE_ARCH_BITREVERSE
+	  to skip this table-based implementation.
+
 config ARCH_HAS_STRNCPY_FROM_USER
 	bool
 
diff --git a/lib/bitrev.c b/lib/bitrev.c
index 81b56e0a7f32..3a53ff67aeba 100644
--- a/lib/bitrev.c
+++ b/lib/bitrev.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-#ifndef CONFIG_HAVE_ARCH_BITREVERSE
+#ifdef CONFIG_GENERIC_BITREVERSE
 #include <linux/types.h>
 #include <linux/module.h>
 #include <linux/bitrev.h>
@@ -44,4 +44,4 @@ const u8 byte_rev_table[256] = {
 };
 EXPORT_SYMBOL_GPL(byte_rev_table);
 
-#endif /* CONFIG_HAVE_ARCH_BITREVERSE */
+#endif /* CONFIG_GENERIC_BITREVERSE */
-- 
2.51.0

