Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010063.outbound.protection.outlook.com [52.101.201.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685373BBA1F;
	Thu, 30 Apr 2026 21:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777583656; cv=fail; b=Wz+E6n088DoGrwfhsMy7M3pwgdIxI2JfUcGIqVlGlNHfZEl1K4sZeCOD8QCgvy83rSJcr1SGeShDdcaziv/z6oC5vL1qPBJEsBEZzRk7qpizoJAslBwqvzNyCVIwkgPsLApin5NoCNz0FVmUlGybZnEnYWIqeDf+tNLPoEkGSvw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777583656; c=relaxed/simple;
	bh=epGCA23X940LrtNipz0pcIgE2Lbamw08hXPDFmRbrMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MdFntbxF3fWvtfPflqDiRY9NaXVESoJgGQlG7LZDnIDKk6qwPL+C17wZBynU0UYFQqQ1UI3Wkvd2YmgpJTVy82NW7lWW8w+EaWQNSjU6s20RMzgd4TzO34gbisZCTLWAzUdikgfJC8vRgBp58OL69MNAYvyOjJKfDXVkykzFPYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oLYD71wi; arc=fail smtp.client-ip=52.101.201.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oLYD71wi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CiVD8d+/htcO/4FrZrihox4uiGrL/6JaQlzAVePWT4lDrwaondOyfmK+D7xCiHELaEkfrAxApk/UMgKjdPKVo/IQtyKJ3daD6Mz+/2Na94yUmLkohniI49/KR55HtTTWh3OPXwYL5gAVb1IllsH/ct8JxSieMjCIp/IZMEyahObSdPWCHapX1oKSr5HKZWIUbgYeHFFzolEto3dv1a4DtG/2k4EGkJh7jrjThrC0vep8KewUo9fokOHNOucpMWbl5BheiAMRo/JRmSJheRoRGMMlBrtNgTYI1jPVx/KOvbZdnCqt/p5e1I0/Ph+oJqAK8jUWQXK3wiIt9Sms2z67xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9feHIkST6Y5Vu5s0HfXTQL38kxSktYYVQYPnSoS1VGQ=;
 b=OP36/5K5Q6YM9ouknteSqXMQ+VTty69w2pJyee+r1dv1yIqfIuktPvORsdF0laFWYFyT+Loo8SiXlMRyXF6kaqw5qjqbiXMvOM0Pa1TwtQ0CWtP9BJfyekZOuXtGb8UkbKwFPZK24ZbdXaJQgWUnejqmP0th/7VF1waQgPfz4+zs7F8pgA/OXj9ao4Xnmwiec3D6H4Mdhin0exZu6xTtoMvHjbvSZXoo9AnrfpwSNPcwte3uMBhqAYfYHRwws4yM5/O77bCvy1k0L5k4d4lcVPhpTgbfKFc+JMwcE7gIq3F8uaRLQw6nva+L8S19SZPEB4XEK1+L2eDju4mJNKcuGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9feHIkST6Y5Vu5s0HfXTQL38kxSktYYVQYPnSoS1VGQ=;
 b=oLYD71wi1GCtnbhfhVUEmMI5SK94JEWnjzIyVlZ5sISEu9C7e1b3L/lhw+/C+oBKgMYx/rlj2crNBQKLoEIxxruatsEVErgIPXdD5fo1tYBWXTjDQSc6kmImjfLIEer6mB+xXerjD14DeI3D/lNGM89lkeCJBw15nPXcjSaHcYg7ArSiUDHOrttdw1x1hhQ8FjQ5N0rFJzvpgkrU7lAP9zklzeXrYUIUDA93ATJgZ+izygnVkmdGFtOS6/wVV6vkhqcX7S8DD8ILbxKzzktPtkOe+cX6t2beeqViuNe10DVar9yj1G43CppUzpnlO7YnZn5uhGcujeAzJimg0NqN7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8300.namprd12.prod.outlook.com (2603:10b6:930:7d::16)
 by DM4PR12MB6256.namprd12.prod.outlook.com (2603:10b6:8:a3::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.20; Thu, 30 Apr 2026 21:14:09 +0000
Received: from CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de]) by CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de%3]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 21:14:09 +0000
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
Cc: Yury Norov <ynorov@nvidia.com>
Subject: [PATCH 5/6] lib: compile generic bitrev.c conditionally on GENERIC_BITREVERSE
Date: Thu, 30 Apr 2026 17:13:49 -0400
Message-ID: <20260430211351.658193-6-ynorov@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260430211351.658193-1-ynorov@nvidia.com>
References: <20260430211351.658193-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0331.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::6) To CY8PR12MB8300.namprd12.prod.outlook.com
 (2603:10b6:930:7d::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8300:EE_|DM4PR12MB6256:EE_
X-MS-Office365-Filtering-Correlation-Id: 98892ada-93a5-40d4-a536-08dea6fd6b48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|10070799003|366016|18002099003|22082099003|56012099003|921020;
X-Microsoft-Antispam-Message-Info:
	XJz4+BPAuJUeyP1mM46ls8m4vXTLikHQKY8xLKOS+3p4xqmq3DjkqBY73wF/ArwGInPrGnjPRs28BecDakKuHIBD+374V7jbVOUk8j294DrnTRN7/odbNkWQxd+PFlCHH1YBzJDGDn18GyEsxAb4/IFyD0xqOBGWqQv6MwKO76LQLkyAAvwH59LVz+PZyQXLwFZAcnlqbj+oGQmiaftPxrds5g3rb7UeLHML4noyeYjHGKciW6mD2GAKV0OY07RhkZuXem5lL8QE9ZuqM4GoEaDogEvB39Nhn/1RHi6ATYfdVRBBwDloLlcc80sIEhJXJQaLaC7BazGWzn1zJldxqZ6zKLDCBg/hZDQUMYSe8dart6oQhpstLWip8+vyBkxV5RSjyoIDTBPon6TU5OmTsKHNid3n9hDluah/JJX/jtCrfjo9CqmLk9uNF0Tw5h2n9uzHQRaom/wSUzHIplcT9Lk28j2hwEFSaA8roCmkHM/PPqrMDvXd2ImTvrdI118l1Jux7CJIGUuxK+F+efAv1yYg33uHjVe/kZHzsK1MQcvhIVZ9vaGWhc5v1cDENTOOgiQOnvozkq6v1Tc2HePOZWhgCx5/R03LdE8Wx+AkcHaH4A1TAF5N+WKuSwmDmP085KR8BQp6ktLwMGQavaP5AgXQoEnCcKxAYjIMqx/StVjAPqOh+QGz/FlOuah4Wp9feO75HGEg/xa9IgBc02rJg5EjJjRkhBu+f6tL25+JgMU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8300.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(10070799003)(366016)(18002099003)(22082099003)(56012099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jvvbYIko4Ttx256s5yp8gOgJ+Sb6JeS0aQUymhrC6lmCgrKsGFcF8RCVSymV?=
 =?us-ascii?Q?/0lzdWg25VjOBk+R0684/yLpsA5h3hgmswZu5/nM/02FEONf8k2YIvupIk8L?=
 =?us-ascii?Q?Ze4RjF3ygXE+hguKo9bdKfcfeYFahAw/o1CJfCtcwUTnyUdIUqzPnoT6mbRv?=
 =?us-ascii?Q?YR3Ai7uilZmGnU1VZdwyVnfd/CLAvlNQifHL9SYrz+RGPj9fncfUYfp6de92?=
 =?us-ascii?Q?JONHmVTE+7m90LqOVK9cnW6S1SBltUeSOTxkcpuA9+ymY6k2EKfWIgw3W+Z1?=
 =?us-ascii?Q?TdVKO8Dw1d6UKO6nZt4R3Y0gXNb13WEWLkQKZgpiNzzECWy8HMcA6MkfBInv?=
 =?us-ascii?Q?uaOy6YNrA97DrKvNc2yTi/YBrcElg8ONefIu2PL/4WOhSzr2pM9P4v4VfVn8?=
 =?us-ascii?Q?QDqLNle8FE3TK/WvoByXBn7qT26AHYoN+ObHZ/fteG9ApEnMeQhA6kB1eAC4?=
 =?us-ascii?Q?rI7RbCyea3qNB8ztPAjEph0m15yuQo4k4DKi2Xz41UjqE9/dFCe91wzjW6Ik?=
 =?us-ascii?Q?l3AxQrpH4HaBZNhpB6dQvmqZoiFpc6hb5nxBLUsMoJsRWN5qE+NHBE1aeLtV?=
 =?us-ascii?Q?yIBdghd17wNu40oM6hO1lhrPgEwlUwFSH2O+yvhARSMsuBko27VsCpBJOy0j?=
 =?us-ascii?Q?6f1Gh0JDMoxWsfx7VMcggleCibK92mE5gbz5p07SoELVdikbuG8j9SwuxlQ6?=
 =?us-ascii?Q?RubhoGYgAhRzGQ0qiJbPm2SdlXhjmEsK9roHy9Nu/j8/477Vv89o3P1txc/J?=
 =?us-ascii?Q?bB0stQ2VCCVzSPCEB5xSkbZRfjmbAUYdj/zVY+T78DVkm9UVKF2X1x6AcA+R?=
 =?us-ascii?Q?VbRUiJoRjIyTIsJeCpecrBI8L1g86C24nR5KjBGz4+JgwGNCP+Q6dBtHehha?=
 =?us-ascii?Q?Hw8OiWMFkc/5glq1O2aqWY1qZ5/ILO/qgzn3Fk79U0GOF7g1EHi4j5olgu8G?=
 =?us-ascii?Q?wSj/epOyJpHHyhhOLlf72ooeYRfGCkiAORMp4pa6mbq/+na7Oar6euOXF0tx?=
 =?us-ascii?Q?sKoftXeyKBretE2sw/024fy6/uewO5Am1dG72RcDpdZx8UdSm0MxsS2BWJdg?=
 =?us-ascii?Q?Bh3gUSfSjk2UAqc9gRDpsZsK5V8BD0ptBlS9wzug42PNiY075/MIkFA88yOc?=
 =?us-ascii?Q?hBNMXPYWpOCrWQBX0RG808wGt70+ZpBeNCDq/GJMSgFz8N+TudAytvdrcxS8?=
 =?us-ascii?Q?qHn07nE+4lVMH2jL9nRuY1QTPkQ0cJZZvgAGgs3EmGxGcqAiBjbwRK9UAbRp?=
 =?us-ascii?Q?Cf3KuA4303UwJtZzETumF8bepYIB4RVGiWZD6DCNuV+JYvVBoB0pDmwssXB/?=
 =?us-ascii?Q?hB3O1yCdNeiJDUiVG5HtMsTSt8MoBYa0knC+NEfKmZa4lC3IESylirJkquan?=
 =?us-ascii?Q?ZzcCYO5C4REZCJNZO/9C/nv5ZuAJ33fbo2CUWlRsxmXLqR9/PvSc5idn+YZi?=
 =?us-ascii?Q?+9OFUx+QmM808hLi5qpSW6Adsgr4QLrDpR9ZuA2S07XqTlc9EQGdMM0eK+r/?=
 =?us-ascii?Q?CYgd1j4qiqId28gHgAXkU+lzU4yq4PhI63meeq4EfNg0KeoZFyHynS/3JaC1?=
 =?us-ascii?Q?WZVEkd0FJbG11b0EGfOyVmbSlpgXNGXjygnRDzOHRwS/O8N+JdXPydTovCts?=
 =?us-ascii?Q?RpsD2C9MOqAiD/esGVu0OluhwCpEngMWluh5gWF/5dqCEagUg7buNmgLlAS9?=
 =?us-ascii?Q?pjDomW7jUwH3R20Tp+gUe8gKoWJ+wrckk0azuG3zKKqd0kzz1bFduJWkFT/W?=
 =?us-ascii?Q?nf/l0oqWqGtT5cAeYic+N2mE9h0pnEGq0JUE3lu/RJmUwRpt5Y6O?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98892ada-93a5-40d4-a536-08dea6fd6b48
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8300.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 21:14:09.2796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xghcYGoGuD0GCqOpMK8kA1wzCY6KJeDVx390ws7HlCTWXkdOGjtVrRlrNfXwgzMSaHUwcfzjhF2gXvPWwEPgLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6256

The file is compiled based on CONFIG_BITREVERSE=y, but everything inside
is protected with CONFIG_GENERIC_BITREVERSE.

Make it simpler by switching the Makefile to compile lib/bitrev.c based
on the proper config.

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 lib/Makefile | 2 +-
 lib/bitrev.c | 3 ---
 2 files changed, 1 insertion(+), 4 deletions(-)

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
index 3a53ff67aeba..05088231f31f 100644
--- a/lib/bitrev.c
+++ b/lib/bitrev.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0-only
-#ifdef CONFIG_GENERIC_BITREVERSE
 #include <linux/types.h>
 #include <linux/module.h>
 #include <linux/bitrev.h>
@@ -43,5 +42,3 @@ const u8 byte_rev_table[256] = {
 	0x1f, 0x9f, 0x5f, 0xdf, 0x3f, 0xbf, 0x7f, 0xff,
 };
 EXPORT_SYMBOL_GPL(byte_rev_table);
-
-#endif /* CONFIG_GENERIC_BITREVERSE */
-- 
2.51.0

