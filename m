Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012061.outbound.protection.outlook.com [40.107.200.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A344C0436;
	Wed,  6 May 2026 17:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778089986; cv=fail; b=QBy47UdbT1dLZ+qUo9CBzNc/WJWGSdpSO26QiWCsMhtV+cWO0h+c7py3TVNfXwVQUOuzI3Xdi6zg6AMSs21B+PuudOKNkl6aeeExOeUvVQLNxpkVJm/HHnUHHheiwzul103Ea7x44c1riLOynZ+7Zh32el9eUSWFlyvpzkZqMig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778089986; c=relaxed/simple;
	bh=AATj6940SCF8ZKvvzOBQ2KmDAYvgigsLIp+pqkdy61c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t+/yDuj7ArcIviYDcTX0y93XYNAC0lT7xI+H6x1DcP7KomN6XXIIHLy9MbDsZM+xC1rfi0DlMZ4/Hls2JNTm06FbPTU8dL+JyhVqgOkEzLdN138LIMrPzL3uS7AEEIvHFCoVtqfqDJWdVwwIjLBJ9RiM2Fe/gcpjcmIbAm4fXGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rNoPKDaP; arc=fail smtp.client-ip=40.107.200.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rNoPKDaP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SCfqHXlTmo4H8n5xOYZKdXsloNICp5kEo6KHvjuDm6G2rGzT76873o9aI0wXpT2XVxD+PWICY20b6dhg/fgQkff3EUuFZlMlL/LrqTSIIlmyToTEhm6hGgAiqj2BzvSGC69HLac9gElRD7o9z/eDl7/pUPgoKTr+wJq48SAdWXcTNJIHh83lWPQ5DICK4j5JwbmRdURQJ7mf4V0di5nm2COTUBE+ZGssniwSFT21ayr6vZ54ZIxW190YgVaE40JPMaQMhAyOqDJHfxssNbMEZZj5HGG91modBorTX+CS0CeSceQLz7iN48oAQKQKv6QD0TJLTBRtUXAdwJE7VisySg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OwONzQ+mH11c/vIBQuSfhfQcKTu3+q6+C+MBNuhD0mU=;
 b=HCBZZ0pg8w9NTTfxbkEY0uX1n/tm0uOe+215J/t10Y4jUdWiQzvMNTB3TMEy0PFYQ7vm2msdZTB2ayzJwv5hRRPxQiXfqcF3oTtThB9ocQ7tIBMoOZUDgsQEHbFOS+mr1vU0NRe/2MdnXrAaKf1HBfhfxxr+f4xsTeI36Fwq/0riZYSJg1PpE+uT2MeMhEIDLMfUf8BvQqooRQ40hbQSpnuUd9vzLW+hi/OHA5+F9nqW7sCIFaGAnYregPdqev+gw20wN4LiGPMgBJsbZsWlUdpd65HZxB6zwDylJp1v7ECSSXsCgDEbiafTFrZlrUjLVHLZ1okgdlPd8wbRaaAPyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OwONzQ+mH11c/vIBQuSfhfQcKTu3+q6+C+MBNuhD0mU=;
 b=rNoPKDaPydyLhokcr0zMyNjUEJMceoi4LusUcqPzWr4+1lWmI4l8EuJ47krU0IIRxt98ngbwEsCRABavv69rdDrcMEBC6ga9HKm3ucDtTNO7QExt9UeC4c6ug3oDxSxEUbxCbvA4yM4QhPK2tjDiQRf80IjevqpJ1tIs7bEPo+r8sIF+nPvl6lDPeKFcmAGxSN/FzxePDTjgSExRSJ8MtvH89eI9+1rcL+CgSV1I3Pv8+NfaNrNZF9dLigeQgkiwyDMv/rGB6cc4weaAEbBrSWBzL1H46ITYouaUCFypUOJ9GbFRpHZaSILUaUEIi6I3sA4AIatUE5eKgiiR9dTLcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8300.namprd12.prod.outlook.com (2603:10b6:930:7d::16)
 by CH3PR12MB8188.namprd12.prod.outlook.com (2603:10b6:610:120::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 17:52:23 +0000
Received: from CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de]) by CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de%3]) with mapi id 15.20.9870.023; Wed, 6 May 2026
 17:52:22 +0000
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
Cc: Yury Norov <ynorov@nvidia.com>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH v2 4/5] arch/riscv: Add bitrev.h file to support rev8 and brev8
Date: Wed,  6 May 2026 13:52:05 -0400
Message-ID: <20260506175207.110893-5-ynorov@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260506175207.110893-1-ynorov@nvidia.com>
References: <20260506175207.110893-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR03CA0013.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::26) To CY8PR12MB8300.namprd12.prod.outlook.com
 (2603:10b6:930:7d::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8300:EE_|CH3PR12MB8188:EE_
X-MS-Office365-Filtering-Correlation-Id: 44dcf105-ed83-418b-61f3-08deab9839bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|7416014|376014|1800799024|921020|3023799003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	T10VdUvdmr+h1/7fgW61A9XruUbuxNqvXMlM/DNMGX5zaq1cS+As++JMgjtI0eYrl4UvlWtdQwC05wlOGFPISsRrD03MRE/gC3g4pKee6eyfNQ/B/2xZUgMSpdGAWhSAlXQRL+vEI8PYx2lawv+PBr9LdU4c6HD+J/MRi+TBISH0YdciQrdMA6r7DpGuwqNPvyv0etyZ4piFz4m68oilIT2YX4M0nRj+e2bFAJUo7mbOMYdqROWzp3HqC5Eql/nUr9mrGtDQh89cpO08QElcbrDCi9t6JdGDY8BZPxfW9D+rbExHkdnz8jGkEUatTn5htfXT062xbxDhVhGW3uVgsT8FjgkXSNJgbqSbxW2zyq9s6C2z8e6/tPrPeQcNWxdwGuaa6XZUw1PvsvZqVkdyNCL6yZFN9bgZcozwM9wR7PBFcadINWCsVFS0W5yfN8qye7jgDik3UJ8vZJWfh/eycKrkmKyEeRIskCDr5l0VRQ21y6yfqWDOHGMJ7E8LbFLcX564xgKql+2LsxNPaY0YOtn+nvJyVCGtlx3sHFKucnfxhvnfWS4HuTUagdheBIWow4qNKhgrw0Kk0E/r00JHNRarGn05/z92eXM95Rmp1qF5hR9ItbQyhwUzfXJhfziDHdrsdf1PzuAOpa6X4nQyUa6p/12YvE4HTYKdX8m00B3ZCJDCHuGPBi35NbKd5K8M0YarZcNi11vvl1Iu2aq1hO378rBRbYtz1QsKs9oSCjv9Q6U7bIRSWv8RFaxeuAm4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8300.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(7416014)(376014)(1800799024)(921020)(3023799003)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D4MNolgjjYwNUDCgVhc/0LPHrkoNIs5MAggp/FD60udTxlhWkim2EeY/N0fo?=
 =?us-ascii?Q?VrMhp1KkGVJGKExdr8x21tKKixJG44wZnFJpslRmjYTCaqyjQj+bTlCCaKl/?=
 =?us-ascii?Q?aaZtJLWY/5EqoJRUXBv4kHi1N79x1ysgEnBAWZuKeLKBa79q3F5JgoBwFQwS?=
 =?us-ascii?Q?+QSCM1f88PqYqKdIYJwEmL2bE6aO+Asm/0kgcTVyMQaqjYVDH72eNV2W9vpk?=
 =?us-ascii?Q?kh0uxxjJyDyhbaXHRIHrj6MhwdpKBL8Ttjdh9pl0ONiQ3ht34Aur6edTcZI1?=
 =?us-ascii?Q?GlbRh4CYY6PbcTH+FIoXDY9eG88MmPSWjGWKrAsEV/cPTqdnZYeAZssA7fXZ?=
 =?us-ascii?Q?IZX5r2a6YhC98bJ20cil2TW9QmxED/XEOCxhb92cUQAh3fW1CC4YmPeiypOA?=
 =?us-ascii?Q?mnVwOG68Vx25d81t9OajWEhSKUUk0Q4tupvQN9wVHmNh8xNsebz0KsQ75UHE?=
 =?us-ascii?Q?0N5diV/QWS+Agj9U4izREaLm7AZpkT5qc15A01LP5JySdLWW1/lTRZyrSdiu?=
 =?us-ascii?Q?cIoKv/jcpKaEzU5aNpbkAmrtwfXZMQ+cuMjZDo2elbAIeh84vxgKiCGnOWRQ?=
 =?us-ascii?Q?AsyQ4UD3y/9U7K9fhZ+2LGY0CXkTa81YlheWIOw7h+HJX37fQtLKmP54Tpsx?=
 =?us-ascii?Q?S1QXEjy6Y7cn/QEQmxagM5qJdYOhs73Y12vNh7cctmsWLuf9G6KGMsrnyE0E?=
 =?us-ascii?Q?XFKuHuabEHbEShH40K7IBBU1xF5MmO+I6Hmxdp3b+obmoatgX04zQ/DhQhom?=
 =?us-ascii?Q?j5uvTihJW1VL65EnhIfaZB2nF2bJIHuW4ZxnUztZmVkHtGF+VRZPUkeHgYck?=
 =?us-ascii?Q?JCxajhAZsbFb6ToQQN2y+4/wXCT0ZTd2Tvkb4RxXbgJKQouSEfJu9ng6sZ3E?=
 =?us-ascii?Q?a+89aUU3icBQJIAaisCRagdAduPdnoYIKF+SoFQjhGHFgWqRz0Wac5JgoNp1?=
 =?us-ascii?Q?6qX/Ze1XqxnDRoK7X1wgzIG3gkicFEllbp5GNLi02QvBaHm0ao4YtI5di02U?=
 =?us-ascii?Q?FSky9w+hh1SpM5o2EEhGarwDJ1Muzdh73ACvhu99VgU5UQKSZKbnhD7iUPn/?=
 =?us-ascii?Q?qmfyunfF4KDtKzldiDYsi3wuqOa6r1ss+bEuxa7Op8lM9IMpava+/Uxy66BX?=
 =?us-ascii?Q?aXM1Ods4DIBlWdDFPgNRQvdDz7iPBl2IDcerqof9Y88CLAykncW34gumN8PI?=
 =?us-ascii?Q?cLB8YHudLDhmxV+cA7BiDy8QZvBZh8dT4SXeo+7Ipt8p6CfTSIRUJ0E2KFnE?=
 =?us-ascii?Q?XqCxFBST6W+CkhuEJgk6xPCUedAT82hEF7gWgIwYSa+NqabUTyQdVOZxJvFC?=
 =?us-ascii?Q?j+afYZmuQOvM5szraPgutb3gK79HmSMA5zzvxu7ouTh0nsmkR3AVgej1vwnN?=
 =?us-ascii?Q?/mKL+eFZrNqK5sqT5ZlZ/6wXVOSU9JKl8fo+VXXFlgPuUpIdlzFs9SOto0ZJ?=
 =?us-ascii?Q?jOiAicDttX+BPZDy5/G9BFfs3wnOlk/0jyjppokJkV7ahWm+KJXyWx2jOXz6?=
 =?us-ascii?Q?nQdpidFSuHDaf0GKlHxZSVOzbAF0WIS2dmswgo6fj1NIGY/KmoPWHP2SS3Yj?=
 =?us-ascii?Q?tJe+Q5X3brDzyRf+y6RZ6TmNZ08oZrGIzYW0WYjY2Di1u4OXUYJn/W/Z9Zbc?=
 =?us-ascii?Q?SyCUEQONZfZji7/9CWXFFL56gwQkzKVyeSAbNhuqXU88bSKsSCOj1vqQ94+s?=
 =?us-ascii?Q?+X1d+sLKKqZe4/ucxD+vuTSABPMISMQtoH6P0O34DBxJ+Q9z0f/1G2xIugyV?=
 =?us-ascii?Q?HXXNikXHFa1h1m4UOasL5m8KJXFtU4YbFgA+obddgVueAU7QC9F+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44dcf105-ed83-418b-61f3-08deab9839bd
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8300.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 17:52:22.6693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Pw/hAZT1GvTBU8W3kDDP5tN7JaS8sqzJxHJcK1gSCUG/3pjV0W6myLdtXYBVamXOypJWZt0eIGRT6cY0R4phQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8188

From: Jinjie Ruan <ruanjinjie@huawei.com>

The RISC-V Bit-manipulation Extension for Cryptography (Zbkb) provides
the 'brev8' instruction, which reverses the bits within each byte.
Combined with the 'rev8' instruction (from Zbb or Zbkb), which reverses
the byte order of a register, we can efficiently implement 16-bit,
32-bit, and (on RV64) 64-bit bit reversal.

This is significantly faster than the default software table-lookup
implementation in lib/bitrev.c, as it replaces memory accesses and
multiple arithmetic operations with just two or three hardware
instructions.

Select HAVE_ARCH_BITREVERSE as well as GENERIC_BITREVERSE,
and provide <asm/bitrev.h> to utilize these instructions when
the Zbkb extension is available at runtime via the alternatives
mechanism.

[Yury: select the options conditionally on BITREVERSE]

Link: https://docs.riscv.org/reference/isa/unpriv/b-st-ext.html
Suggested-by: David Laight <david.laight.linux@gmail.com>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 arch/riscv/Kconfig              |  2 ++
 arch/riscv/include/asm/bitrev.h | 51 +++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)
 create mode 100644 arch/riscv/include/asm/bitrev.h

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index d235396c4514..a708583f785d 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -104,6 +104,7 @@ config RISCV
 	select FUNCTION_ALIGNMENT_8B if DYNAMIC_FTRACE_WITH_CALL_OPS
 	select GENERIC_ARCH_TOPOLOGY
 	select GENERIC_ATOMIC64 if !64BIT
+	select GENERIC_BITREVERSE if HAVE_ARCH_BITREVERSE
 	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
 	select GENERIC_CPU_DEVICES
 	select GENERIC_CPU_VULNERABILITIES
@@ -128,6 +129,7 @@ config RISCV
 	select HAS_IOPORT if MMU
 	select HAVE_ALIGNED_STRUCT_PAGE
 	select HAVE_ARCH_AUDITSYSCALL
+	select HAVE_ARCH_BITREVERSE if RISCV_ISA_ZBKB && BITREVERSE
 	select HAVE_ARCH_HUGE_VMALLOC if HAVE_ARCH_HUGE_VMAP
 	select HAVE_ARCH_HUGE_VMAP if MMU && 64BIT
 	select HAVE_ARCH_JUMP_LABEL
diff --git a/arch/riscv/include/asm/bitrev.h b/arch/riscv/include/asm/bitrev.h
new file mode 100644
index 000000000000..4b9b8d34cc3b
--- /dev/null
+++ b/arch/riscv/include/asm/bitrev.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_BITREV_H
+#define __ASM_BITREV_H
+
+#include <linux/types.h>
+#include <asm/cpufeature-macros.h>
+#include <asm/hwcap.h>
+#include <asm-generic/bitops/__bitrev.h>
+
+static __always_inline __attribute_const__ u32 __arch_bitrev32(u32 x)
+{
+	unsigned long result;
+
+	if (!riscv_has_extension_likely(RISCV_ISA_EXT_ZBKB))
+		return generic___bitrev32(x);
+
+	asm volatile(
+		".option push\n"
+		".option arch,+zbkb\n"
+		"rev8 %0, %1\n"
+		"brev8 %0, %0\n"
+		".option pop"
+		: "=r" (result) : "r" ((long)x)
+	);
+
+	return result >> (__riscv_xlen - 32);
+}
+
+static __always_inline __attribute_const__ u16 __arch_bitrev16(u16 x)
+{
+	return __arch_bitrev32(x) >> 16;
+}
+
+static __always_inline __attribute_const__ u8 __arch_bitrev8(u8 x)
+{
+	unsigned long result;
+
+	if (!riscv_has_extension_likely(RISCV_ISA_EXT_ZBKB))
+		return generic___bitrev8(x);
+
+	asm volatile(
+		".option push\n"
+		".option arch,+zbkb\n"
+		"brev8 %0, %1\n"
+		".option pop"
+		: "=r" (result) : "r" ((long)x)
+	);
+
+	return result;
+}
+#endif
-- 
2.51.0

