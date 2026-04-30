Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011014.outbound.protection.outlook.com [40.107.208.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5368F3B961E;
	Thu, 30 Apr 2026 21:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777583653; cv=fail; b=N4Th5za0PBPiItMfWE39SVY4lbDtDDaNz1+rMgXTcAPiAQB22owaq2qJmpNEobzXwPNpeCF09lsuHrQMPw/r+6ymgFDyAzRwXsIiWzH3/vplLRp+apkvhhfkQaM0US+M//tSZz7AM0aiA7hrRhhPFZe1InLyv5c9FjHTeIS8ZPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777583653; c=relaxed/simple;
	bh=UaSQ/6ZZ46Z8wnPp666nn9prveAbtbIxdu+TEqjFaG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sMxzVYSHYog5jUcB4/C9ObDcq7gZadkZGsC6EV/NpRFyxoLI8GEGPOfxxwOH4OoD/tZhNtK/HRQqTZVrR5R6Oqa+Y+xwBUzN4mV6PL5DgLOfKBX761AUUeceQ4legKUNgSsIbmmu5u08NiKflW9+61HDItYykp8IfuUfjTUlTvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZqKBUQ7V; arc=fail smtp.client-ip=40.107.208.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZqKBUQ7V"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vMbaR4nwV5CftRGTfSSsiXCZqJ/yaAAZMnB0xrzvgDp3VXPa7RlY+0ZOjNGW7hZVGX2SgUDNWpDU01F4nPuVmd2VGdI8r8I4vsqwGkdWWQaVeUgFKaYmlhiWy5hMhvt7l3yhHxs6FQaFBXyRnuOvqdZI2cxmgTUMgaLLa5+T8PiRfHb5jn4z8qgahQwmH0nyVW3izM+hKg4EQoh8sMQ8UyMLxqsy3xHrAW7m62GofLslM4CX9IhnY+h4r5iuKhyo6j4KF1ZfOR5pguKac98iLhOuMsxOvWycScSPMFKc/xsa99E8VGPVwBnk8YK56A1BALUHiP2JuIczZhQOPmGV0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gHFr6SBHfvsLMoS/kmKlG2oUCAWkwboh0l5fwbDmGlo=;
 b=e2BZS+yt1JqJRDFMGGhZrAU0k4lO9UpinOmW6zyPDsmAA0uctZvZnK1UCXeHsD4MnBcahVW/Mh1Ii0micbjGHMrx7sVEyYDMp8fKBHzJVdvmBqmc/ZPQoWyU2Z9PofpbcpYctJeTgT5Bw97/TMqTQ6cFMhR5cNbe2aXcTtrXlx8KbU9xK2kfGHexEBJdlgvUUSi5zf61n9f8ggGHD/rzOUIjlzdEf+KGsjELmlzs7dq6RUe/JRStw0LlYeoeV/QjSc5QedVjvmcTxtITUwlBrDmWaWhPx3tY6Gjgno301Oq4IhPyqDrCTNresWcx9IH4xH2VqyO2Iie9loW0wuybtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gHFr6SBHfvsLMoS/kmKlG2oUCAWkwboh0l5fwbDmGlo=;
 b=ZqKBUQ7VVafYMaKrTtF6cYCW+K0cDdlBOk+OZ59e+S/JDEl5CqTnkZEZnhQwUu38YHs2gtj4NNSpOsw6LTkQlQMHokr5/GIjx4Uwk2ciNd3pbNJP6wLyuwrBX/bNgNP1x4ZwTpXJh3216EU5zmE3dRCeWIFA5K5bPz4u4VFPk/+F2PUkCJBU2LTvtPZmdn8n2rlr+jUxqdSqRKU1TJvoxcB1K28YU4dmhsuRQwqmrUEwEQKROB50mrvv7rO6wk/iRDS4Vk1TP2/LM9JoMXBtHNx5TAA81b7/KdKtKH42/BzAw8T7LTYCLAnnRQOFBC7o6PtlmJ/gpYezAQc77IbFxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8300.namprd12.prod.outlook.com (2603:10b6:930:7d::16)
 by DM4PR12MB6256.namprd12.prod.outlook.com (2603:10b6:8:a3::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.20; Thu, 30 Apr 2026 21:14:06 +0000
Received: from CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de]) by CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de%3]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 21:14:06 +0000
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
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH 4/6] arch/riscv: Add bitrev.h file to support rev8 and brev8
Date: Thu, 30 Apr 2026 17:13:48 -0400
Message-ID: <20260430211351.658193-5-ynorov@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260430211351.658193-1-ynorov@nvidia.com>
References: <20260430211351.658193-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0136.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::21) To CY8PR12MB8300.namprd12.prod.outlook.com
 (2603:10b6:930:7d::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8300:EE_|DM4PR12MB6256:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e4cf40c-251c-4f16-2038-08dea6fd69b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|10070799003|366016|18002099003|22082099003|56012099003|921020;
X-Microsoft-Antispam-Message-Info:
	sjsU3DI2D+CNqq3eK98msH/sKGOg/+Dm2mWXvHcuBHdU6mAq9jtcjKhYd3s0mVU/zxnVGvTnPeUju5ZxHc7/le/vJ0kahCSePDgYL8S8ZH9cVhVc8bJFF75GcsAl3qr2F9Xv73h5+8hSr4QFCsBEHrm6HZJVwBh2x1EeouVjktweCIG2VTy2Zf0guMcDrO91VK7/zzZ3GCmOSYFnwW35fvjT2PjlC+CG/ERWftKteEiNWkqzTCe8cCFQbNFS+bjL8c77+rsiPAhv7QD7RnOInQ7mXkhWfmXhQ3YBb97C1GnxOJL3E6WPqhyWulz3owVI+G5CvO2TMOW7IGWe2q/d+DRruvwnU0SZFPHVPmfxR14JeigzfAH5Iga9nFekUEqooQOqCXuNixYhhYR001O72gLjvI/MqE2gtYyNqRBXC/Xpe65dFdKUC2Je5DlkbxDl79jEyvyxBkxcPIw0yqaO2ZuxCQRKhk9KSGBL3m67PKnsAZ4HWfNLbuAO4swY7Zniic8W5YwLKZEYGCdB0RUtur+Ha09x0AkAfsZ4drtNR/VeNmwVAdu+pMkvxqLWp/kbat3mMVsC1uss/tmr40pdH6Ursp449zPTX24uqKVuYF2p8fxssG1mc2yboTM5eOwkmfz7hbTFGioG+4LG6lCpmiZTMVXz3OqJX0EOLBw9sJSGs/FiDTM4crVKp+rhu/x5BHBh3AX4QfjRgHz1fGK2yYGOxLag0DCBWuJHkAgrGDCJnOCXIWaneDqu3krEXOZB
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8300.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(10070799003)(366016)(18002099003)(22082099003)(56012099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AUDClg3RgiS7DfSoWPVlDNeH/YGILAyICspKKYERAiTIyyY8BaH/z2s05x1u?=
 =?us-ascii?Q?vwJ+LOQpRmaQMDAyN3HC4LzyhcMe4PDHtiiJaYYiDxGM5KMzJjoh8qKAi7D7?=
 =?us-ascii?Q?v3ugujxfbmvj6A+I95qRjRf8PFUCRupwhCjE8jv5HPsuu/PdN6R4nknpGPv/?=
 =?us-ascii?Q?EVQS3m8rvaxvCiFPOBx7xwLSHS0QpEtW71xrf+1j1AjVabsvotIbI2/JCWuJ?=
 =?us-ascii?Q?3MaXYqs1L6N6EprcUr4BECcOzD38kF3aw0BlFWvQ9WHxOvp9/HLeN42W+L/L?=
 =?us-ascii?Q?fzEGJpfv1azDUUwUq18MeUuag5KRQQ84egJ0i0x/a1EX+oCyroWSmb3YRFMI?=
 =?us-ascii?Q?pb0icwOY1Qy0eR7OIgzkNsztlLZgbduDaWw/ru1KxbhboVIYp5tH4AwpGmWT?=
 =?us-ascii?Q?ahW5Mz01kgQTpMJntlEfe3VgHPdrw0H/yKDkDEXjCR0fTQXfhGU1mM+eHcBQ?=
 =?us-ascii?Q?8ocA6uiRdWA0oqMoTUn5Qgoxkp9wW15UKhU0ms8Y9zNp255BJmzAsFwGpgbj?=
 =?us-ascii?Q?MnbArvfnLtJXH6POZZiehT4O6gTbQvsm4Dg+ceXjBY8P4ZLiJHt+2J0xZDB1?=
 =?us-ascii?Q?KcWbz+2RQBi9zJhdBzUBka7St3PiRAh+Qh5NQrh85HjIPqMCyLv7MAFPjraq?=
 =?us-ascii?Q?8gouAmU+XFJfrWj7XG8FUlDI+Ak6Zz/GcozCRtnyP4KPnOF+YaGAFmwemWSW?=
 =?us-ascii?Q?BE/Tqr35b+Je3KbiZUTpbI6AtKLpsXUKiRtAzCQpfSJ7TMUPeLOdaer2Ty0Y?=
 =?us-ascii?Q?eTrc2BJ/AsMAsp6xWlPfkEpFTta+ERUm8o8Pw3Jadrr1A4yLOvcE82CuvmXt?=
 =?us-ascii?Q?PqEHz1FdczHZuCEmmJnL7CC4VNNLyqFApf8CszlfoZrkTRnXTtK/gIpRh/Wu?=
 =?us-ascii?Q?Xbid5JpZUkJME+COumR74IpD75/haHtDJvOOGNDUAf+TGZedHlXncm+sOBxr?=
 =?us-ascii?Q?WxPX4owR7RxRPqLUjae5lLdU44yYkGfJF+nMuF8ZaQEKjgZ9oPnF3BznfMMw?=
 =?us-ascii?Q?vlzU77N6pXVzIx5VXyMGLFJtlZFE6VFbfFbocuBbyrylO9HD10JFqqnNztPO?=
 =?us-ascii?Q?kz8daI7WvO2KQ17yQvfNcbQXPLCOKjnsqIhj1w1TFs+ACqdsLJ6s26dqWvGQ?=
 =?us-ascii?Q?k2taT59i/PpDdTzID9fv4911OYByvKqVN1W7AG+3OW36kVOv/ahwuDHOXlL9?=
 =?us-ascii?Q?spvTrHmS3AvRzOPcARCem62K0mWSL71VHuXVZjGlaMMqvFQilLRHOEgCkxxI?=
 =?us-ascii?Q?RwkhqaMEEg+2IGRBrlLTA3iX5mHZtEKQk4P2oATA6JrzQo6MJ+7BtJgPCwww?=
 =?us-ascii?Q?HIRdrBZioc8WG20V6Amhv9rNURNggbtn6VCylPEqmcjg7hva2QdoeuuCFFGf?=
 =?us-ascii?Q?1WKxriZ1FwiEFu1j4a8NeWT+0F/UyYSFsjnhsHt0n/Li+UIY/UA+IPRePdeg?=
 =?us-ascii?Q?2wfmsAqGQagevUjWpMXTF/KMLunLIHOcJILbZZS64JHyv+M3Pb5BFCtCI/A7?=
 =?us-ascii?Q?N9aSbr6eLVcPaoPi+SdQ8YkrJN9Tq/9FOPPWaiA1YOv7AJuYb4fASdYRGyvG?=
 =?us-ascii?Q?dfun05DxnRWcA0hiNEaHjV8WtmITSMcgLx4oe5BQfhzmokajFQjaOi9/nTXb?=
 =?us-ascii?Q?/4O22z35JnbXsUmjNuDyxfmcWlFME06Eg7K13Oon1nbzDDYUlqSUFK7GVuGV?=
 =?us-ascii?Q?/tvG1SJ7/7D6zjIJ5LuzRTMKRvJqPkEumQbfAnTxEzQv+M4EGjU+SXp4YU7s?=
 =?us-ascii?Q?xTZbbScnZDJSxqJrdLexaA0g7OdmnAb35WC5TS43SG/zI8vOsZL2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e4cf40c-251c-4f16-2038-08dea6fd69b4
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8300.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 21:14:06.5935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 50XE7QBow07/nMTncjf4MFTSmeSQPFs7WYowgPfwlTWB/a38d+dZImnVctscJgDzH4IkzI1tC6NfwIY1+DT/DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6256

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
index d235396c4514..d32309846fa3 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -104,6 +104,7 @@ config RISCV
 	select FUNCTION_ALIGNMENT_8B if DYNAMIC_FTRACE_WITH_CALL_OPS
 	select GENERIC_ARCH_TOPOLOGY
 	select GENERIC_ATOMIC64 if !64BIT
+	select GENERIC_BITREVERSE
 	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
 	select GENERIC_CPU_DEVICES
 	select GENERIC_CPU_VULNERABILITIES
@@ -128,6 +129,7 @@ config RISCV
 	select HAS_IOPORT if MMU
 	select HAVE_ALIGNED_STRUCT_PAGE
 	select HAVE_ARCH_AUDITSYSCALL
+	select HAVE_ARCH_BITREVERSE if RISCV_ISA_ZBKB
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

