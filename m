Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010041.outbound.protection.outlook.com [52.101.61.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D7A3B7B99;
	Thu, 30 Apr 2026 21:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777583645; cv=fail; b=HbSm/AwIbJXt5TW0P3xN09UfAn6mx2/xyJ5hcH40tkel+Ztct+GE/NjJEC/IvTfAYNgvanZv1c1dFytQEhDC/BbVaCuF2qZ8xdbFNhN4gfYj92mVhh5SKCN0SYIgoqr509Yz+IhAvrmNF0QBnrUnxhv9U0ejj9FuNsOM0YIh9Ic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777583645; c=relaxed/simple;
	bh=sgzzQLtWVS75+XSiorjeWUt0EBkLkRPi2/kscZNVLEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nv/fIzUS6cBZK2HqL433HIW93Rh2qeFPUOTpXvsleW8WoY+Z6E+KV8z/pFMwqrahYiMqtK1PbgANCkmDXbB+71nZLP1eit+pda/iCOJC/lnVjvhAT7RU9osqaKh4xT8ZqXCXShGNixUbEqVm+Udv2qKrrQTbBWTs5ejZQikVxQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CKqsOcAw; arc=fail smtp.client-ip=52.101.61.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CKqsOcAw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O4kUaqbNDgf13jrH0qLbRTJ9UDJoxYwzwBkPeUggAGesJlIzlqbnpqWk+V8mPdKnPtFbhYTS7rliptEunoa6zICh6IthOx5asQo4ZM0LPf94JqiWcpTX2Ln1Rk5u+zaUAmHNPoBw2BKynxrU5bGKgX8Awn8mbCkBbIHfLYM0VRQFT7e4yVOJJxjZV++lTH81Gd/BE8/zT/gv1n5FF+Im/MXmmOgLu+OUdkHWfT5XE6ZKqib6zb8pfwrdbEg9BQHbUdzYlJsHIXyYKbb7nLs7IrnwDylalTIIoRxErJgJrWlMkEfACFBVW1OuvVyXqosbknM1lLPASKThOgh+yvgn1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BX18IKY6Ec8zxy3Kj2X+Pof7LVTX7pmE0onNUt3V+OU=;
 b=grt3dPtk6CC6jg/QWkQ2afPatfELWiRcK1pFmNvz/RV2d+V4jRnpz9BwSFoKSmR9v/dwYBWNS4wAPdujoSi8PF10w4IeW9FXkgL+HyNXeV7xsGoO2M+Y83y/ZnUF8ZbHwJF+xNoYrZL982sqNlYqRR9TB9MAlG05z3vpaiLiORPaLc50EnOBE7Ci1neWMsoz7Rnqd63AYxzCPyaKesg5Sm2SHjTbb2Nwt+kNC5he63OBcJaOZOgW0qJfFAdMwreybKxILm3RtQz2Lvt6UskisZJLNpmMbFDnv/B8mRCwaGsQAbM1JLRRh3Te9vGFNFcXNRtG/K4HDP75NusvXARSSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BX18IKY6Ec8zxy3Kj2X+Pof7LVTX7pmE0onNUt3V+OU=;
 b=CKqsOcAw4dBw72JQ6wMkOVxw1XqDYgjHnCWSZZgac2939pMqG2FlOuveiT8TNQJe5WexRCg1QiBCBNEhf9Ep47Ne9rLqxOtvNPmuQXPAUTFLnzw5Z3I+wZFnZMM+mjsV8LCEklL6SGN9WeIWcQsLjpGPlqUPW2zgEPHg8a1zEMMPGndhUh8ER59Ad6QJNSSKyYjI9YQgUjS6qUdthHdnN7+WL8ohBeF8+xoQgiiXYY0B0N2ZNyklhjeMHdMX8Xz9iQLYJfFH7yBFV/fWHZDJloR3Z99kie3xAEfeOF1xYrx5eDgE3TA0OCzHzi2kSd6IECpirqF5riUqAg6TTluCJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8300.namprd12.prod.outlook.com (2603:10b6:930:7d::16)
 by DM4PR12MB6256.namprd12.prod.outlook.com (2603:10b6:8:a3::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.20; Thu, 30 Apr 2026 21:13:58 +0000
Received: from CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de]) by CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de%3]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 21:13:58 +0000
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
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 1/6] lib: include crc32.h conditionally on CONFIG_CRC32
Date: Thu, 30 Apr 2026 17:13:45 -0400
Message-ID: <20260430211351.658193-2-ynorov@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260430211351.658193-1-ynorov@nvidia.com>
References: <20260430211351.658193-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0163.namprd05.prod.outlook.com
 (2603:10b6:a03:339::18) To CY8PR12MB8300.namprd12.prod.outlook.com
 (2603:10b6:930:7d::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8300:EE_|DM4PR12MB6256:EE_
X-MS-Office365-Filtering-Correlation-Id: 1df29fdf-3d5b-47f8-2447-08dea6fd64c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|10070799003|366016|18002099003|22082099003|56012099003|921020;
X-Microsoft-Antispam-Message-Info:
	4NT2RlD+voJPmPr6LAUh7W9dbWXWEeJ3NySnmFK5xrgpHk+0xwLQZoMDvD7hJOXesc71tt0VAV5CeQvBpUhdWARlPJ5P7j0MLOrZJ+hEzV4Wbh5ED9/w0KTx36wdcf7duBM43c2PQmesgZb/VLqNDA1xOEgJCT5hVwZ+ct+yw30GFsmYUvkIrG1gUm0q0wkDlJYHKxUauaEqw+sUlOhY63ViCaA0j2viTzJ4vI3m/1VGNW+T5OmkoASzZYEe4yjRpQHHXN+US2UAgOshokf/acHxCTw0VmomyWf3jW/2xJaMfUwnh4LbKo9gEQ0KU2j9GezKaOd6wqacxVhi5qTFbmRVxqziVRNVe1//bojYHW5Q1o0FhvEnu78JsxmeArIPoFaBofrbTQt8aekRQkD4/yu5Ra1zIB0HtAF0DMphFFVvnxVmL6Uih/jwxM8uMlj8vRWEtJEXKH+Z6z+um664nc1s8ndAyivE0YYz5lmBe2nTgPtkw89AI8nG/MmRj/JKOP973dNNWO6DWFS7CDdCOdM5Shej/AQhbLDxs5QMEVstuHocyg2zBOz0wUAXEinueVgb2caVdPogv6wsLVjeg0UnQW+65KVkBqVGXRU6p7DmVM19KkrHW+SsbQhqfJ5nSuuMFz1XcWTWR7ecJxFwyXwSalLzbzwagmrEd6kzPrSSVSiNHfHEp32Wk07LvkLnvJSnvZXErop3jr8VA5BmD8LaH7cwYyGYShbkF+Cf75o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8300.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(10070799003)(366016)(18002099003)(22082099003)(56012099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KHTdN9/HbgU3gjwirwZw94As/R0vG03uIm+Z9NJt0P6ONUscdhSvpL6Y0W0O?=
 =?us-ascii?Q?S2DKUG7tEzCTzjk6pVgvi4n8ea6F0plxaKo+Fpoh15XTz18HtwoShsgaarKk?=
 =?us-ascii?Q?TYXu3aWMFpVhvytAhTyoM1yAprIrT39xbuSA6h5XmWAeFkr//K+abtpIBQKb?=
 =?us-ascii?Q?MHXa0x7ddpnEN23l5LF7eClQBnEH5fDBrOTs/FIzhGqMeimQw5vZgsgWnsaB?=
 =?us-ascii?Q?arpe/eq+t6Pcnsy8R+WrefGVQOQG40Ik49AngCgaNvbMV3fm1ZQzJF/DAxbu?=
 =?us-ascii?Q?zjJT54sCk7CyZ8Z37TLZeAIsmiWa02Wufh55a8QmkNaCEb1SfKnMF6zdtQ0E?=
 =?us-ascii?Q?4WpCYDfsYPuiQR4v+I/0gAAL+y4zrTjGrssdvPLaBzpCAZy9OHVuuYZUjTLu?=
 =?us-ascii?Q?gUwJEgQuKLQcKimMujn905kh1XedldznKMdfhBPVNJkkhRJaUfyElLlskulq?=
 =?us-ascii?Q?BuHZNnDNVBGoyOb8IF/oDfE2400/ESTIhix8wcGggoDWmR8FirFHa5nyYUKE?=
 =?us-ascii?Q?KMnEwv1brIjJP4oRemRvkLR8KP/cWoMUcS6VAQNegq77VjEcAs/TJdeWP3ws?=
 =?us-ascii?Q?HFTcklMZBkm1AmZriYC2obXB6Q2wkjj2Kr+FbPX9k8yepvPQMMpdVX2hxKpb?=
 =?us-ascii?Q?gYsaveH6hnhcY+TmFEgfrPrHhWeeOGpF4JCPWzsi3duMGue+2W7hX+xgg9Bu?=
 =?us-ascii?Q?Nv1g5xljK64dpnofz6ZwPqMXplQMh3Juffz0US2hSxIx8AZ9VZBfFOX5UORF?=
 =?us-ascii?Q?tG3PKseD3LqAe2RmZrVDKxlGfQWdubF/6c12x5KtOvmAjBUdjUFaiymId3gc?=
 =?us-ascii?Q?hgVm404LmaE2KVLWGhX56KJGeBUGQnLHWskmlPfy18lPYc8xmH3Zznerb++v?=
 =?us-ascii?Q?MUhcnTsfGl2m8m8zEBARBk2e/wyKb566k+VjNjeUzGPHpPZmoq07/t9g768c?=
 =?us-ascii?Q?NEazH9FZBCKMtglEU4BLxbnJVWhNU0rlcpELzg9wTNIgEmnOnpZN/pDwWiYJ?=
 =?us-ascii?Q?jDH2znm6rsrecUXd73sXOZdlJSgtr3rlLz9l9q9TKT4YV/KoxCHvBYX/f9vg?=
 =?us-ascii?Q?VCsaYMLjoMon+WVxz6oB6fxoYtGhbvq7q5udHIfBEoyqkOx6JCh4C4Igt4+l?=
 =?us-ascii?Q?pf90eYWEx82994cpOx3RbfEvVlvGKKQt1uHAkV4lYU/MwPF9ZChOIEb+Ssqx?=
 =?us-ascii?Q?woTEnpjWdt/5jZvWNQVNyekc/njI3S24p1BPYXSw4BLRiVhXCaKGL5InsFRp?=
 =?us-ascii?Q?7y2FxBUO9go3f2efTp5zEn0tw6KCml3GBY1bpbEIjI0kVOa0B//U0gnnVkib?=
 =?us-ascii?Q?Ofyrb36/AiLfyvmG0e4DRh5YgATlziMgz+REgvel1eVQmc1zpRk8USB6QUv9?=
 =?us-ascii?Q?AsWA/w2wDWVBwXhPVZOZY2QAG2MeUdOpE2EPny/FaS5xscIu0zVXcrSoAO/9?=
 =?us-ascii?Q?JcIWhpEEWvviIEB4HVZirfbLsSllmHm5tR1XMNvIV7CrRy0cW7SbbQfEocCN?=
 =?us-ascii?Q?kdoLPxw8CqPw0jrpglC1zc7z+bv5vz7VS8tD5m7Lp4/UVVCBSJ/N9DkxcPNS?=
 =?us-ascii?Q?0RioBeIjLdTa0TWdLsMeLTn+XZMYmbuZnPFbjAhEWr/GqbTSydi35NxqNVS7?=
 =?us-ascii?Q?udivivXiga3sQ6d+yW/XvQiSCwmvnhPavHCcoeOLgYnvIULnbVyeJfCbLsJz?=
 =?us-ascii?Q?JcjtqhJogUVbr8DIm0bKEebIP8ZUWl+TyhCssZP6vyusNPFrHxCWam8Wjzc6?=
 =?us-ascii?Q?rF56DWwpN0jmi6IG8NbMtuLXjzgFX0mPi1yto4Hr39odctXuZUQt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1df29fdf-3d5b-47f8-2447-08dea6fd64c2
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8300.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 21:13:58.3457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HwwCQtMAXsLlptAKPKt+FAViSZ7g2KGLsTxL7MKWigjwmxpH0c75J0JeIV0tEJDc4aUuxTFBy0WvfdU7y9W7Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6256

Currently, bitreverse API is either declared based on
CONFIG_HAVE_ARCH_BITREVERSE, wired to arch implementation, or if the
arch has no bitreverse, based on generic implementation.

So, regardless of CONFIG_BITREVERSE=n, the corresponding API is always
declared. If that happens, the functions become declared but not
implemented, which is an error.

The following patches of the series make it possible to have bitreverse
API undeclared if CONFIG_BITREVERSE=n, thus spotting the problem when
building the tinyconfig:

   $ make -skj"$(nproc)" ARCH=s390 CROSS_COMPILE=s390-linux- mrproper tinyconfig fs/select.o
   In file included from include/linux/crc32.h:6,
                    from include/linux/etherdevice.h:23,
                    from include/linux/if_vlan.h:11,
                    from include/linux/filter.h:21,
                    from include/net/xdp.h:10,
                    from include/net/busy_poll.h:19,
                    from fs/select.c:33:
   include/linux/etherdevice.h: In function 'eth_hw_addr_crc':
   include/linux/bitrev.h:16:20: error: implicit declaration of function 'generic___bitrev32' [-Wimplicit-function-declaration]
      16 | #define __bitrev32 generic___bitrev32
         |                    ^~~~~~~~~~~~~~~~~~
   include/linux/bitrev.h:67:9: note: in expansion of macro '__bitrev32'
      67 |         __bitrev32(__x);                                \
         |         ^~~~~~~~~~
   include/linux/crc32.h:107:36: note: in expansion of macro 'bitrev32'
     107 | #define ether_crc(length, data)    bitrev32(crc32_le(~0, data, length))
         |                                    ^~~~~~~~
   include/linux/etherdevice.h:292:16: note: in expansion of macro 'ether_crc'
     292 |         return ether_crc(ETH_ALEN, ha->addr);
         |                ^~~~~~~~~
   make[5]: *** [scripts/Makefile.build:289: fs/select.o] Error 1
   ...

The current unconditionally enabled codebase doesn't use CRC32, neither
bitrev functionality, and if generic___bitrev32 prototype is provided,
the compilation and linkage phases are passed OK.

The only header requiring the crc32 and bitreverse prototypes is
include/linux/etherdevice.h. Thus, protect inclusion of corresponding
headers in the etherdevice with CONFIG_CRC32, together with the only
function depending on it.

Reported-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 include/linux/etherdevice.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/etherdevice.h b/include/linux/etherdevice.h
index df8f88f63a70..d35be27a91a5 100644
--- a/include/linux/etherdevice.h
+++ b/include/linux/etherdevice.h
@@ -20,7 +20,9 @@
 #include <linux/if_ether.h>
 #include <linux/netdevice.h>
 #include <linux/random.h>
+#ifdef CONFIG_CRC32
 #include <linux/crc32.h>
+#endif
 #include <linux/unaligned.h>
 #include <asm/bitsperlong.h>
 
@@ -281,6 +283,7 @@ static inline void eth_hw_addr_random(struct net_device *dev)
 	dev->addr_assign_type = NET_ADDR_RANDOM;
 }
 
+#ifdef CONFIG_CRC32
 /**
  * eth_hw_addr_crc - Calculate CRC from netdev_hw_addr
  * @ha: pointer to hardware address
@@ -291,6 +294,7 @@ static inline u32 eth_hw_addr_crc(struct netdev_hw_addr *ha)
 {
 	return ether_crc(ETH_ALEN, ha->addr);
 }
+#endif
 
 /**
  * ether_addr_copy - Copy an Ethernet address
-- 
2.51.0

