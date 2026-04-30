Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010063.outbound.protection.outlook.com [52.101.201.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC3C3C9ED0;
	Thu, 30 Apr 2026 21:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777583658; cv=fail; b=CzfUODw0m/V3R9SilSDaQI+XFejHUveiEURsgIn0E9t/KggaI7uizNsYRW17MUznGEq6nFLbFAH9WzmrF0qB+bVhZXpldKEigLJoE6eGMHWp51naf7eSugoWSRfRWpjnVDM9as8FQ4e1f/YPVprMQrywh4m10NyFIwZnvn2p1fs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777583658; c=relaxed/simple;
	bh=rc5cqknl/CnoIlI1I1MMMBOTPMYV0wFK8+mmKSpeN/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lrDGyxf8ziKaYjrokKAYDMwNYjipyH3Ks+199SziXtmghBpR9nKfR3rz+pK8YFAp0DPCKDTgUH3TszAwwmEOMbocAfXJePWo0aIsGMXArcYfvf3dPHqZ4c1MvuqYyPQ846tfogu3XCv/2lgd3zmloYxhaZ1+y9XTWVQCKjOQzN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=d5CI1ie8; arc=fail smtp.client-ip=52.101.201.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="d5CI1ie8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H7FUkxC/iPwOaXVi2Wp5EHX3qxkBVNqDFxuo866HmGtsOPp1nA7xuaa7qzNOR5zMIMjn0z/UdJsElGK0vibJNruahVvrJq7qnN3SBP51Xa/84vR4lmVZkYFO58gBs4dbmYS6IYR/+IwwYODsooNEyn+ikLrnae5bnssHAwm8EwaH7Zi/PiLrXPqRImhQJCcrpyGQ00zNYXR4YDY2kDC5yLVtDXich1EWzRwfEBOFQ55Al65xUpStj/VmZ/q98n1tRS8qg9J9jQO43E65qR8FS7FLIrJppMTiStG+KPIaIlQsU9S5G2leHIk3LQzopK5QZbh5dMrP0rqlP4rV4P35HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lN9OVRi+Y1hxu9mlQ1znXmrHFiq6XZWSfVQaDNPwdK4=;
 b=l5ron5ozc/P8LLaio72PJzRYrGh+Pi4qyXWB7ns4Wm3ZkdDzNSbokEttUgRgr5tLbSBk98CkmP0BgxvGfGeyYmUGTIQOJF8YRp86Pp3yf7j4FZDx85nsNNfMXZNxXuGLqZ8jUW2+jWK8ulZrd4t6zdwGTMP5DiunO5sofDguJnXG9INI3InpiMStGAbtwB3HdIk8GX9raRuv7s/h+9WomshRgSiWPJ592xU7qOJu1pQxtco2bVdOUpHXXcpXmdRc8Xo7XhZHaJ+1JAybvFp5aPfgwqACEjXfiExdqeD0yMZGjyIzVhcdOYKIlAuSpdjCPyZ9ajdL8xRjJ0di0ynJ7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lN9OVRi+Y1hxu9mlQ1znXmrHFiq6XZWSfVQaDNPwdK4=;
 b=d5CI1ie8jxpD/zs5oy+3KO3FQPB1CWdGFld4zv1c3l9XcewsccHEhvB21XYYaCgnMIsF9uraUIZMw5jFAR2GeuRL5BvP0Rp1CS/9V/24Qk8vFKJLoP2Csfg9zwqmQe7sc1Xx8c+JKBO70pyTB8QOzce0t8AMz9biyqz856wG8Bz73qjY+XaScG6l0YunG1Jk8XoINtp/GG5JkchU70Wa01qfsBBL2+1nQy3BWJlljr155mId7pA7pt9vwVKCguXpXrTA1Htd3KrsA+fx3ftwKcB+OX9Ecq/VfL2flddQ4bwovsjdVuhL+sJ5xd3rmbFcH+1JbiNH8CgaQ5v1w5e1dQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8300.namprd12.prod.outlook.com (2603:10b6:930:7d::16)
 by DM4PR12MB6256.namprd12.prod.outlook.com (2603:10b6:8:a3::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.20; Thu, 30 Apr 2026 21:14:12 +0000
Received: from CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de]) by CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de%3]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 21:14:12 +0000
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
Subject: [PATCH 6/6] MAINTAINERS: BITOPS: include bitrev.[ch]
Date: Thu, 30 Apr 2026 17:13:50 -0400
Message-ID: <20260430211351.658193-7-ynorov@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260430211351.658193-1-ynorov@nvidia.com>
References: <20260430211351.658193-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0118.namprd03.prod.outlook.com
 (2603:10b6:a03:333::33) To CY8PR12MB8300.namprd12.prod.outlook.com
 (2603:10b6:930:7d::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8300:EE_|DM4PR12MB6256:EE_
X-MS-Office365-Filtering-Correlation-Id: 3db01636-b453-4882-9aae-08dea6fd6cf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|10070799003|366016|18002099003|22082099003|56012099003|921020;
X-Microsoft-Antispam-Message-Info:
	HOIiDduRXX10Y7SclksQifcXHvsYAIXYRBTVmnWXnEywip5sFPlhNPiHbKsQkq10uz5kGB5w4c4nCsZ/Jtvbyj4RpCdCgf760BCUjBO47ib/z+6OFS1bJpv3b0CJ5t0SmuYotIWpVPADJWmX5xj3ZtJa0qbebIyjuqsMkZBFxPMhTGrnL3RcacJWpGR9VzIwRoXBAN2AqHyigEASwt4P4zeqGIkDcJjsU6pcMtsSSLk/u2krMgieVm39OLWVtPvek11hwdlKc8QjNYj71nAkNeRQg/18+WGgBQ9UHsDOeGwQ110t9KSFw35ZDbkrWb4BP95oFcvvyCMCP5b3aKeeao/9K1V/jQJ/9qFQCDQSbfiRP9DFVwpyqsLq2fo9bu24Styb0+dImslVe+DuwMSJC7JIZAmkHLCd+g+v9u4lLrnN1LUUs8lBl1xjmlM7FBy82r4DRd35RPgdHaX1Zksv/5c1gcowqXNt1EY3sZufWRVyU+p2+EC6dE7NstOnC7GNVjEzh/fb1a4sGd6TnDORapTnsIeHHHkLfsKzz/VcpXRDsGXSnjpjBJ27gwB7z7ytxILbqypbf9QQAKcz5SstjDvSXA6YVVxPRobony2WzB5sJAQh2z9aDQJGJ+ZPavGivXaH95TDvxwQiNw/McsYAcOpTx9oStFmH5B0KEWonciIL9AfoIme5t3hgnrEPAtXVhnDLWlMfUYQHtHV30fTGHexgNeftaQKZdZTSPXWfw0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8300.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(10070799003)(366016)(18002099003)(22082099003)(56012099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lg7Z8mqCkGPjlp1IkKRVcE6BNshnyrd+6pHXDOIBZHaTgQZcCLdJYXFfbWSH?=
 =?us-ascii?Q?VGkWKtqOkjYZvtmq6iiZ/viB5huV6FIw0rXYgsDE7jtLV92LdwePQukGpJZA?=
 =?us-ascii?Q?NVniABUTiGfp3wtr1gvLsUOz3PkqifiUDNrvVtKd3us4o4ibOM/7B1fFfzmt?=
 =?us-ascii?Q?A6fgExyKC/4Oc2B9zFyxlFdRqbUGrK6/dXoirRTACJRsSMoxnYQXTCJ85kFK?=
 =?us-ascii?Q?ePP098FVmXNdJJaMcWE56afbjWPdqv4WU0eat5Tf6DUQ25eVU/U/dxyP6VTI?=
 =?us-ascii?Q?SyIb+6D2oxH1uHXics2K7swRdQlv0F0bPyLLy2wlc6ylcVR+tOrUal46gTEY?=
 =?us-ascii?Q?Ye9yvAxKoW3jyWyk9NQ1blFm91FY6fI+No7OrqoiIdcwpB/OMTErVAGGGGzt?=
 =?us-ascii?Q?M7hmJ6Eu3UEYdxgsWmpkAZrbAUesluXi2OBXnu1DtJcOwqVgpoV8zIV0Ee6Q?=
 =?us-ascii?Q?3r1M8i1zUlkIJ/8z6swEQdjb33dap/7kbikgzQtyo/xHzaTKgui5xdEBlkFT?=
 =?us-ascii?Q?J4gcgoiHUY2Iy8hI4YGg8ep/ua609J++I8ihYhDA2WYUUmYZ6sXc8tbnKyFk?=
 =?us-ascii?Q?L9d+4IRVnZbtnZd2PLrjPCf9HqYViRycRreNadzwCmB1Ap5FUfmSAwCNENwJ?=
 =?us-ascii?Q?auOAI3jli0b0t3dfYGdc8ORk1rtUyzlKTk5y/RXGD9MDg0ZmBRWtd7FZ8IBA?=
 =?us-ascii?Q?tm940X6eYtowJaeb9YAOJHjYi+Fks3E9GOJldgx1BVYdpJYtgBVRrXRmAlyI?=
 =?us-ascii?Q?8NHSlZI3uuNnZXgWMoXK82pH2s4x2/rJyRzrRwCRAcK7rNclykP3XwqlrJNB?=
 =?us-ascii?Q?HKZ0/jGMfSF9lQ7kTlc+WcZnpNTZ/8j8ST4IWUDEjguUHA7C8pEVoDHH9SMX?=
 =?us-ascii?Q?BtPpVJDPIOxrbXHQvj4tU7tXl59RsQQ85fwoXWI3TIEXizapA1dzqEf87dz/?=
 =?us-ascii?Q?XGX25w+bww176tP4imFLp3le2Ph/gQtJvE7zsjTzgbVgJ1Z3fQIYRjyfaZCj?=
 =?us-ascii?Q?U7st/9J0rXtjGPVM5IfJ//8XZx1jrZdVXtWclidsjtmaIE/BtaxYPvzOGkJq?=
 =?us-ascii?Q?f8U1Mz9GHokgaEGCnRCT2XVXsJMTfX9+5/d5xTGyOwHySue4pCzECV6zYFpT?=
 =?us-ascii?Q?LMFdLwJrnIlry/9qPw0+obbEECd7G0z9JXJME+0noOiLB5gk9h3ioiZVWLMS?=
 =?us-ascii?Q?g0h3+LvxQBRHIsPlMDZYguZvQ2XL7LOcO4t+F+4dfSE2zwLGz/XVDX1Vsx4G?=
 =?us-ascii?Q?I5O81iVonqGcRuNRWYWxA4jrfCo6NWfoiYV5LLqMZhgFMnzQ54+uWIsf9kjN?=
 =?us-ascii?Q?AiG/AFuR4omGsmgFqLAMMpr1gBV29hM5iL4ruLzpEumFWvzKy7tdIL4qHT+Z?=
 =?us-ascii?Q?h+66r8XCLYtjsGPZew9XhNtlYXEMnhR49sCWs2fAAz8eFbJ+FuxWeVGJvwI7?=
 =?us-ascii?Q?9mMC2/Eceb8Q1EzZIzr2se4vXF/3ZRNn+Tu4K9bpOZh6H3CH10refbk8mpDV?=
 =?us-ascii?Q?AWX86RCB1gK3UY5/XTMkAV3TTQvLKBRqXbfHlNvWCZAbndhygz39f78mMURS?=
 =?us-ascii?Q?LbGpmRlU8zYHkJS/74nsGx4tmHJoyskYQGVNUzJu9QlEBR7vthdBbU9Piss2?=
 =?us-ascii?Q?ildpN+vC463KeBcbWdLxQsv1iEnRZGUPPxm+NEzXWeuByFD2EZVaP3UE8rqR?=
 =?us-ascii?Q?4hBN5cSGC9foRcgUqwCkdMqq+tMviNxKGxAiRNoo7ZoQ2x7zJV8RDrAwObxM?=
 =?us-ascii?Q?S+qsRs9ib7u7X3eV25wUtxZOv/6hH7wzHcDqn5wdKCajX0EX+LJ9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3db01636-b453-4882-9aae-08dea6fd6cf2
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8300.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 21:14:11.9841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G2y6TQB78xO9VMNUmJLBswxApWc4ZhvOoQQDbYNeaRzhAgCBScAruEr5ro/2xRCK1y+caj3VrT3L+aNRnuN8+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6256

Arch bitrev API is covered in MAINTAINERS under the BITOPS entry,
while generic bitrev is unmaintained. Move it under BITOPS too.

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 27a073f53cea..b69db2a7031f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4549,7 +4549,9 @@ F:	arch/*/lib/bitops.c
 F:	include/asm-generic/bitops
 F:	include/asm-generic/bitops.h
 F:	include/linux/bitops.h
+F:	include/linux/bitrev.h
 F:	include/linux/count_zeros.h
+F:	lib/bitrev.c
 F:	lib/hweight.c
 F:	lib/test_bitops.c
 F:	lib/tests/bitops_kunit.c
-- 
2.51.0

