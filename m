Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012061.outbound.protection.outlook.com [40.107.200.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5CB4C042E;
	Wed,  6 May 2026 17:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778089967; cv=fail; b=AVQD80mS0s1UB0sGvMs+TYbl3Gl0xwILkUm9RsQICJnydftbJRwLILifOKFg3BGicxZtimj8iikBRyHqTJU7/a34kZKNQAggTi6+X3YNbWV473iaU+MPM/1StHht83704pJIqJRSntMtSZIxAaNe7YtMTjs1OGPHtDVBPISC1Fo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778089967; c=relaxed/simple;
	bh=5EE3wAu2EIGtRTbpWMELac71axwvRTGMY5NI/WSWuXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MILXa4lSpBcfiW7EwEx+CDQBFclqAzOklMRbaXr4/KgrBzQY132kWxyWF6v9jHGyQ2SI+yEOSj7c0Ib0RVhGTqJoR2CMM+dWMBRX1ZwftFxVhtax1uKOrcPV2AbwnhuYFCPQeVFbPpaLSGSdi+0MINNw/mfcqLdfCfO1MdGSLG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NxqKLWDK; arc=fail smtp.client-ip=40.107.200.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NxqKLWDK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q+jT50ZrIRS4tzISz6C4iSggqxe39oJuZX/HBWGEfg7aDQ9FUjyRM0CDkbC6HqFFIw/D1DLD1S6kF9uTXPBTPMUYM5scEKBwHLjw/LGqe889G194QOIIAJLa7GjS77rAaaOMi55jzkXd7pjwSkoOwocXajdTjJBOKTSLiTtmZJtxhaVBe/uQ1ncJhw4b1e7FvS/uFOpk6WsuSjshuuVxLxpJOeGQn4TA+8mABIrr+hcgoxr5+w8uEughZP+Bx1f/AkGV0aKtQnr8NW5galLnEQDupif/11vnGihyHRFpickSZduGp57Yk/jtWfrdoqqhukPx2kus4dUtBOc1I6F3fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0anIAl7aoJ/aPXmaGeiymKeN+l3HVUsC+v4c2Aw1xuw=;
 b=OAO6spkbteHCHCITtNwpPSqQvUeXlv51L//oTEP7oOS3EnEp3semcCJa1aSOCNIgo69n+hx+9TbbWtBjW8/+Klt2+P9/3luQ+gpmp0NYNMxX1Lu3KWFlUIQC0cRTGOMWnwYsJ3FD6/FvgS/UjVcyvkjaY4ExkIyMiIJOS2m6HemeFaS0xOrd/Ze2DPebcHPnf2nzjxBw4CRkKWDvb55HcvF0Zc6FoZ7LHOuBdoxLKMNtc2EFgnEOnbc3OI1AkciH1oZBuSB+Ps0FXYuKjRmj7jh+s/aQdEa09CrKkT3oRJ8EgOhiGBYNliPn6jtlCV3KO42gLswo0ymqU8kEg/lioA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0anIAl7aoJ/aPXmaGeiymKeN+l3HVUsC+v4c2Aw1xuw=;
 b=NxqKLWDKT/gGnSfImDQlkPZ3EFPrYCCj+N951la8hhOiyVQ7Vl3l5zDEFYP0aZm1pYMKv2AX3NACm1nAWRL6dU6np4hdQf4G4WGvDakqs+YeClwBCnqGfv9LmR4KSF44PyGLoqCrwDLOykFoj8hZSq6TiGBtsJOo7ZionlVTaJF+WvO/zOLYTkv4pQ2H8shG0Xa7T8gkLjQZPnglcnVvRnVQKtx3QH0F1woTwZieXcw+JWVcDNjQr9ObQixH2z6lKWHW5FGROvncUJ1hE/WA62c+RSn+UUAz8L5BDabeEGTev9i4+U5+8lqB7VV+gB7QgcOMP/Nz7hj1dhRYu153Ow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8300.namprd12.prod.outlook.com (2603:10b6:930:7d::16)
 by CH3PR12MB8188.namprd12.prod.outlook.com (2603:10b6:610:120::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 17:52:15 +0000
Received: from CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de]) by CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de%3]) with mapi id 15.20.9870.023; Wed, 6 May 2026
 17:52:15 +0000
From: Yury Norov <ynorov@nvidia.com>
To: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Arnd Bergmann <arnd@arndb.de>,
	Eric Biggers <ebiggers@kernel.org>,
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
Cc: Yury Norov <ynorov@nvidia.com>
Subject: [PATCH v2 2/5] lib/bitrev: Introduce GENERIC_BITREVERSE
Date: Wed,  6 May 2026 13:52:03 -0400
Message-ID: <20260506175207.110893-3-ynorov@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260506175207.110893-1-ynorov@nvidia.com>
References: <20260506175207.110893-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0002.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::6) To CY8PR12MB8300.namprd12.prod.outlook.com
 (2603:10b6:930:7d::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8300:EE_|CH3PR12MB8188:EE_
X-MS-Office365-Filtering-Correlation-Id: 636bcd07-d154-4d9d-753b-08deab983597
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|7416014|376014|1800799024|921020|3023799003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	IQvei3Q7I33LWeT+2sfULXlLQcgaFjQVkbcGPIz8hpwpqc4+GozQ+4PFgG2q+0hKjGBQRskT/98qdqLRq8A+3vEMU0QIBMvsbBkcLQuA0jMS5qUKOvlqH9xNRF3MtBnE4d9Iz9xNaKzCm1sqOFZ4q6Xztk2awM/qjPcs7MDiAqejsmq5QsZmHm1B4sxFw2qLHz4+dtfQs5DSTKxlvJuBe4k/rJjqOKkBybWXPLstFJ2AwaMPNM6/r4qc2YFUy78DJ4iIPQL3eeoBxCKHKFNuomfDjnP+lTXcIDnZJwylWCy8VNJhHeo5qK99Iikm9JBqt9HaNWXViL5//UHaaOJ5bzfVoPqcg7C+h4QbPyGNrTnLvDLWm4gWZZZfWsqZ2xU5CW05UD26Z6Ocd80ydSbQQG8qwF6O6Cgr/NXMickjmTqPf8oxOsBxcuY3vLDwBm/5t2clMJZ2iv/bGuBtWYYIqSA02GbOmYOpDqVI1bHHOxPS/8WJxiTqRjFXy4d0lpgdTupEd1Ykotk1yjagZbotofYU067IiunX+fwK+SUXOexDQqdbx4xphg5gABl36uxJSiS5hPF1yfl1C7ctmQYfYJ4053nWlfViD43cPFKImmq9roNoXkkUlRorudIuG5AEFmjH0CPECHbf/jT5ajug/MZUUag0Av3hGfA6J01FmFksf2NhUzOvUZJAq7/3O7NG4FChcjjw7P1ovmAzB1srqdzpAxI+6kwwOezjm2ZUuIg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8300.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(7416014)(376014)(1800799024)(921020)(3023799003)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lbEGVKV73fNV4vobIL2U8b3oxpyNXysqOtk4UgzDTiUlDZ+JGVT+34zQAXXt?=
 =?us-ascii?Q?48Tyh1C6uGRfTMRAC7JmdE4/+A5XEAN4h1Jdhqz18iCGcGckH9KG8N7nQTOd?=
 =?us-ascii?Q?V6OXh1V+PZ7Vf42uNP+o0P6DwmBMUBNu1MmZ5/LtjcrHpJWGGbC+Bz5G0kzi?=
 =?us-ascii?Q?ejrRqfLWrt1fwP8Hio1ro093Ju5rhZhxc/LgIvO93wmy9/ZbFN23Hj49mpNc?=
 =?us-ascii?Q?e8kSnBiQWpNxJHSDPgwGtXPziqrH9z2QnVRD/ktFbgAD8fIOF3WZnbfGAnXd?=
 =?us-ascii?Q?hPrTx4ji5pnsPn9a7Q1YS2FgGAV9Wo+WKZZgPsbFzJg/OjPDLGKSfOArFV6J?=
 =?us-ascii?Q?DrCaPuWP2sauf30UxfiZQtNDfZkY++oJyseP3Y007965NCxzL+Y5PPuBVvfq?=
 =?us-ascii?Q?kn47C3MEEqluF0CEcb1HZzERrepIe3yTVtYoXnbJwCqSkOrWe0k2z2fJnd5j?=
 =?us-ascii?Q?lNKF1KOFx9T8Ed3bBjRAIBT0r7UsW4UfyiT4PSangY5g1yn3pvDa2A5b23L7?=
 =?us-ascii?Q?djp7Leb4BZg6NJmFlXxGY296N2TMWi4tZqB1pLTqJS8I5rH1U2cAweBXmUIO?=
 =?us-ascii?Q?h0FH3jkEzYQIeLD2R2Krj1JjjoZHf4owEkn1rUPshHy3ICuzfwhk7mxkwlZ3?=
 =?us-ascii?Q?DhJxBUQs5SBoZ486LgT4ussL/Jp3bdE0Mena3Lia9n9DyXK3qUVnUGdHWaZn?=
 =?us-ascii?Q?iw5tNoX4vDcgylgc307iWaPmkxgnFs40hmgKI+qf5lf+M/YaD07Xry2DzxAC?=
 =?us-ascii?Q?5uYsbYZ/loMneLnOK3w/dnMiREVqTCh8qsHeA0Ap7itFmpx2EB8sEVyy+z+G?=
 =?us-ascii?Q?5IpHdttIRYp23PFP8nb6sCgjXvfAhV840oJPDifNmu5syHl0oGm15cCNTpjK?=
 =?us-ascii?Q?5rzC0arWshHlgW4Bn8bgYFWzP6P+n1zuxlarB1F/OYWnIGpOclBQwqJ6VakX?=
 =?us-ascii?Q?+O0wyzv4rnlqUTR2ngd57HK6ksASW3kKJstlL8cdYiT0ejD0w9YPBIxMgzPE?=
 =?us-ascii?Q?2cCNshyEIdKvI7Dk0yasUNDdfC3ynfx70NhoRVc+7BNQ6sf+Xh44MZC2KCXu?=
 =?us-ascii?Q?MHo0uUNsdjq50TjIxgTcQoepeUxemUILJw44gsF0XFaOnVyg1ToE8+XnOcCr?=
 =?us-ascii?Q?P0UOUXj3P6bcWTjQE4pCi+Y0AvkaTLmGDGfKv1LdQ6OAUX4euTKGbMk1mLAr?=
 =?us-ascii?Q?YPzeKLpt8b1+5da9Vy/TJRRMgWjH5rn8T9ciVKWoGWzZDeYICSYJx7nk2K8j?=
 =?us-ascii?Q?+QO4RBrrpg6xoEcH/ZPxq645GVrjRejSM0234Q+b8KMIk5LXXQln85HlFUmf?=
 =?us-ascii?Q?T0PM7OkTuadmTl6uWBx4SNNEEykaVHD1DFW+T5qcetnErNVdKPGG0EsPB/dg?=
 =?us-ascii?Q?dAyCIz3Vv6EgB+Cq1iZxmJbNx14ok7/weZ4GS/y46S20MdesfwnaxTiRronL?=
 =?us-ascii?Q?UaBHmp8kAKCyvDq6LiDJb/Z1TjXhqq5aw/bYGOuR4fcUbWPmITAoysmlpCwR?=
 =?us-ascii?Q?jFEHH8CGZG2v7xl52xtcBYmlsuX5fMS1YzqR0DixCyo6gMf0owVqflTierzS?=
 =?us-ascii?Q?2kVoVIZY7cHFJVwgGhvJ+LsxwYEwkRkYGEyzecCEAc4sHNwoZp7Ee2UUBsRC?=
 =?us-ascii?Q?nJqFQ36CXXXu/i2nE4UTcVrfsjCCc0a/aPECVeNEY4I3yNPzalwuUCtxNxiv?=
 =?us-ascii?Q?MFSvsi1tzsjeSmIi7TJBPJL797c2/m5QM3j7RB46nK5zWC6IlTSWKlamlIMF?=
 =?us-ascii?Q?uEaj8lxbyt1uQObGQvcewh1Z+S2Aw8wmfgRAWpy+RBmInERsFhys?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 636bcd07-d154-4d9d-753b-08deab983597
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8300.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 17:52:15.7766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ASfRW1pf3jPPBUQxwpGRh2c9SmjPyYy/ejEiXuovkgGXRhXM68XP8pozsW6ziwi6y9941DTmirIPk2woulIt4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8188

The generic bit reversal implementation is controlled by
!HAVE_ARCH_BITREVERSE. This makes it difficult for architectures to
provide a hardware-accelerated implementation while being able to
fall back to the generic version if needed.

This patch adds GENERIC_BITREVERSE, so bitreverse API is controlled by
BITREVERSE, GENERIC_BITREVERSE and HAVE_ARCH_BITREVERSE options. The
relationship between them is described as follows:

 - BITREVERSE is selected by user code; it's required to generate the API;
 - Architectures may select HAVE_ARCH_BITREVERSE and provide an arch
   implementation in arch/$(ARCH)/include/asm/bitrev.h.
 - if HAVE_ARCH_BITREVERSE isn't set, BITREVERSE selects GENERIC_BITREVERSE;
 - if GENERIC_BITREVERSE is set and HAVE_ARCH_BITREVERSE is not, the kernel
   provides generic implementation only, and wires bitrevXX() to it.
 - if HAVE_ARCH_BITREVERSE is set and GENERIC_BITREVERSE is not, the arch
   code provides __arch_bitrevXX(), and it is wired to bitrevXX();
 - if both GENERIC_BITREVERSE and HAVE_ARCH_BITREVERSE are selected, the kernel
   generates generic___bitrev(), but wires bitrev() to the __arch_bitrev().

The last option allows architectures to use generic___bitrev() as a
fallback option.

Drivers and core code should never select GENERIC_BITREVERSE or
HAVE_ARCH_BITREVERSE explicitly.

Architectures that require generic bitreverse API as a fallback should
explicitly enable GENERIC_BITREVERSE together with HAVE_ARCH_BITREVERSE.

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 lib/Kconfig  | 12 ++++++++++++
 lib/Makefile |  2 +-
 lib/bitrev.c |  3 ---
 3 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/lib/Kconfig b/lib/Kconfig
index d8e7e89ae320..a33988adfaa3 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -54,6 +54,7 @@ config PACKING_KUNIT_TEST
 
 config BITREVERSE
 	tristate
+	select GENERIC_BITREVERSE if !HAVE_ARCH_BITREVERSE
 
 config HAVE_ARCH_BITREVERSE
 	bool
@@ -63,6 +64,17 @@ config HAVE_ARCH_BITREVERSE
 	  This option enables the use of hardware bit-reversal instructions on
 	  architectures which support such operations.
 
+config GENERIC_BITREVERSE
+	tristate
+	depends on BITREVERSE
+	help
+	  Generic bit reversal implementation. Drivers should never enable
+	  it explicitly. Instead, enable BITREVERSE.
+
+	  Architectures may want to select it as a fall-back option for
+	  HAVE_ARCH_BITREVERSE, when the hardware-accelerated bit reverse
+	  instruction set is optional, like RISC-V ZBKB extension.
+
 config ARCH_HAS_STRNCPY_FROM_USER
 	bool
 
diff --git a/lib/Makefile b/lib/Makefile
index f33a24bf1c19..23e07d19d01c 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -145,7 +145,7 @@ obj-$(CONFIG_DEBUG_PREEMPT) += smp_processor_id.o
 obj-$(CONFIG_LIST_HARDENED) += list_debug.o
 obj-$(CONFIG_DEBUG_OBJECTS) += debugobjects.o
 
-obj-$(CONFIG_BITREVERSE) += bitrev.o
+obj-$(CONFIG_GENERIC_BITREVERSE) += bitrev.o
 obj-$(CONFIG_LINEAR_RANGES) += linear_ranges.o
 obj-$(CONFIG_PACKING)	+= packing.o
 obj-$(CONFIG_PACKING_KUNIT_TEST) += packing_test.o
diff --git a/lib/bitrev.c b/lib/bitrev.c
index 81b56e0a7f32..05088231f31f 100644
--- a/lib/bitrev.c
+++ b/lib/bitrev.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0-only
-#ifndef CONFIG_HAVE_ARCH_BITREVERSE
 #include <linux/types.h>
 #include <linux/module.h>
 #include <linux/bitrev.h>
@@ -43,5 +42,3 @@ const u8 byte_rev_table[256] = {
 	0x1f, 0x9f, 0x5f, 0xdf, 0x3f, 0xbf, 0x7f, 0xff,
 };
 EXPORT_SYMBOL_GPL(byte_rev_table);
-
-#endif /* CONFIG_HAVE_ARCH_BITREVERSE */
-- 
2.51.0

