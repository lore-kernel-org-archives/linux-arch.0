Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010005.outbound.protection.outlook.com [40.93.198.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6E972622;
	Thu, 30 Apr 2026 21:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777583643; cv=fail; b=q7EXEb/+ZFuV8g1/qKQ/Jr7dNZa9ixGcTIkFm4/hpg8EaaeWCJcshkXijhSB4s18AwU9ywWggc8PgQq7fKeMnvMdkecPNYZdw67RPzUcKoL4bzTkPa/CCcQH6GYitjDiFPHaW7aNzHb13Bc9+9xaDIQeBZVczbdhsHYLt3kz+Tg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777583643; c=relaxed/simple;
	bh=bYytc2ztmJUdgRh+g5MPsWIzUGdVFPary3ts7H0w5sM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=gXHDBTy11rhVhWmqxKDOjILbhV0PmmrEmMx97rA2tPJB2qwXzeO9D58gnHEH+KeUIFQWK+H5gL+iabr/xZZ+pVF7TlIklJkF52H4A9bW/QXPBZ8sgNdbuupalYlsUU59NAnyrOM0Me5DuE7GgLQj/i4s19obYOjjbpZqpjFt+X4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fqQ5PfYo; arc=fail smtp.client-ip=40.93.198.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fqQ5PfYo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v0OK9GV2gEMr4/zxIjHHQjJ1xTbBT8NzNKmFHebrU0ZbMr8sap521GP65aHOqK9oS/P9Amh0vvMS8PCUQFKuBi/FxfQS1EvLi4F6AFqqgRKvIn0ladlvy6RFFYfh+Gc25wIlZsIXCXssVvjvkXo0t5sQXeBUCpyEtrBCzpVsgt50jUmynyC8a+BOEnYZP+R5aKkUKobUpJ1xcOZqLVSsaDVqDYRM06gqcdAsmntL9deso5XXNXict66F2Knb+gURWys/OS0Am8awreCw5CJ4DZ51YQZsYxsxPDo8Yi8kT5bpqRLtCJ5FKucAjDsc2xXZBE7FQBae3nU8rRtFDVuBIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QRn+Atoo0Tub/MJUyqcXAlIGpLkykDYDrGB2uE2CuG8=;
 b=y+AffW7TQejzbBWffnFQh6KaaZo0S2vja3QM1tswe/37ply9NHLgtBXuUqpgs0skJQp/dBGGzfkbowrEPuTj0aELSQgccQPz5dNfyztup7IAgJ6BkfS953QBbEx9HrAH8ZQNsFyfnOX7JYBFRC8FhTOFwGtoUJtKTSzYV+C7/82U7VTWS/M7X9/KPf8iDFZdTVut+tNF4etBRtPC61Cd/uFgCwMafZIN9uJ52blIzb7UkbinopvtyuTTsnilCITm6CtN1HGmGKurToD5kmvUJh8tBaj6BZXsDQEnAkai/BLHC9RyFoWz+IgZ3Y8dOkoSxgotRKDGYLDI7CJ7snwfhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QRn+Atoo0Tub/MJUyqcXAlIGpLkykDYDrGB2uE2CuG8=;
 b=fqQ5PfYoa9WTYukJ0+QAmzoFfq+DlrIMjjf2fx4fcg9OZc3xc9Dq28px7m/Vf/wRPiIzMYE+g91LCbgQinFeOoJRhDxbmOeg5X6s5eOZyhNE2J0o/X3tWT78jgdilsQ/o/XH9JESfKpLMXQaSRbJSeYiL90rS3nIvtMpz60t6yn60587cV0uPhtLbPqjn0KcdfTqRvM/fIFcUViNfFK0Mwol6Pp2zODEwirmgvwe4vEGnwm+u3yjbTnbZ9NBksRsLAgWBsu+Ma0n5ygs4OC8oZfOFZYqroTNQoeJXUDIebaNnebRA6gk8OfYnZ/6BmDJK+59fyhUfzE0GqObBkUSQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8300.namprd12.prod.outlook.com (2603:10b6:930:7d::16)
 by DM4PR12MB6256.namprd12.prod.outlook.com (2603:10b6:8:a3::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.20; Thu, 30 Apr 2026 21:13:56 +0000
Received: from CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de]) by CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de%3]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 21:13:55 +0000
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
Subject: [PATCH 0/6] lib: rework bitreverse
Date: Thu, 30 Apr 2026 17:13:44 -0400
Message-ID: <20260430211351.658193-1-ynorov@nvidia.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0274.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::9) To CY8PR12MB8300.namprd12.prod.outlook.com
 (2603:10b6:930:7d::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8300:EE_|DM4PR12MB6256:EE_
X-MS-Office365-Filtering-Correlation-Id: 919cf35c-e24a-48af-ea8f-08dea6fd6302
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|10070799003|366016|18002099003|56012099003|921020;
X-Microsoft-Antispam-Message-Info:
	SPwn79hu4mpZbmd0li5fYtGc34idG9EvU/wMDfiHGkiKvF/Qb6QCMqBTHdyfNg5LwcuBiFuC56G7XJFwsI7ARiOoyRAiU2OXqRXfOUXjy7BTx3addb5lov9Vs/SAtXfEWhmQUMzTYR50Ll3ZO3NAXke9oTcuCrpwq+vsxAI2KAY0AXf2W950j4n7RBErzlIKGKLNGnTHU7++Yu674SLGtSnO9FXotFb5MBq1vO9iETdl84KGNLp3Y2JJ2AsSLchBw/bDXD7BFKDDJM9CVcmadTQ5S2ItWv02oWWvjzh+oRJG6aUy2/z6Tb4+61AIcxTz+Kv+n4KsCzzH83ISgn2vKAJGnC7B0xc1AFxpH9FCo2YLnWpYwxsXPxrKk0OJi6hSRkle95zLePQsOcfm23X59RaP9GVHodxy/q0GaHFqWzSNIP0+itUTw93vjB0S279GNZeBajkIW/7c9SbbHNuZebBwjY+7B/N4uO+xjhJNvYBxQmXbMPqrM88+u/BCau7jH4QqVXSB/EeZSh5F9o0vg6GpZEUl7WrB0LUcZ3ucv1ShrRg+PI5dcezPJTEvBkPtXzHGS3skVO9gpDjqEtVcbIqqAAnJu0VV9OZBmKECqQE2YBESa6es24tl8+lVWTym3sH2qvH/3rJQISyrky+GHUKkRkIuOw3rZsqmrLZCOzzn8wVBN4ZqjJXqj2cbGkRL/+9lfrhgyEEePAJUFvSIkLIio1EDX9Q0vz21ROltgPc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8300.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(10070799003)(366016)(18002099003)(56012099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g95T87zbdJ000amw3EymqQ0gAPj8Dj0n2NO0Y5EYGjIyti3MynWX3s42+cRk?=
 =?us-ascii?Q?KiaeyytztVnc97z3eEcf/1YtjpdFNIUKIDM28DUJ5NjvhabpDDHkIMAcXuI7?=
 =?us-ascii?Q?UvCAwf7kcE4dOZQx2yzHx27becHw7y1x/y3QS5BTDJqHXTFzjiACSzKMrCR9?=
 =?us-ascii?Q?dwjZQfnRk6F87vFsA9ZmM2g3Oi+JLX87vjg0n/SWyiJANpgnq3qmFXwe3e0M?=
 =?us-ascii?Q?HSwSIBDXOf+64qny3xNmAQie2/lk6wc/P9yV1jK7WmMmkAPXatm+DDpfb+OQ?=
 =?us-ascii?Q?rWVhJnsyn7OMtQBLWO28ib5jZoD9EyuewGteDkxJLcLy6hQX06S+bME1iWtA?=
 =?us-ascii?Q?gkaf4UuMSnOll/tcHMPlB/A1ymBit59iPooNIlaA5CKyRlMitvtzoKpRNPyt?=
 =?us-ascii?Q?jHXfNmltrnj2N14C0LuC0avLdhUK4nfYS0DoVRj/XF9uQsNOzdT0vWYX25Mz?=
 =?us-ascii?Q?lnU56W2phvhtw0hVE3MBDE5MQMLX2qXpBVgHC+tg8jhH/qYN9uYDyrgUBFdW?=
 =?us-ascii?Q?KVaj49rD9e8su8sKWF0nNA7KUm5IaSRdFSDV2Xq/i2ltbbUYKcvk31lY09vq?=
 =?us-ascii?Q?qh8lMrpzcgAiw25sVLQ52EBe+AKjdLjeL+Y320pnpm5FbC9wMUDzEto5jSKn?=
 =?us-ascii?Q?CMCeWiLMLpbW7rapc1ebYRLrQGsGVn55vl8s51RKz0/s2/jVLgOWSeek41HJ?=
 =?us-ascii?Q?qKaXPmP0pX8eHQUNpgb6svFMhKBum8qgM4HSs7zpuDH/pPMd+i1DGcHhYsfh?=
 =?us-ascii?Q?K+o3FwEJww5NAoXN0gKMVrW/vRC+uALEn+3SysaC1v4RqU0zcqJyfv5SQ0w4?=
 =?us-ascii?Q?6ZfQqMwR1NBsLpeGqpppZABtMardRSqw2iiDYNELPD83kWhPHnIUGNHVAeMZ?=
 =?us-ascii?Q?RGNetU35JnTZ3APGJBIfECyLsW3cQm7QcrQ7H+edk5KxQ444dyyEdyrzbfzP?=
 =?us-ascii?Q?Q/SvFcsuem9nY3BVUJLDr3JdBNWTeKbBol3dVl0N71AvSiFTsiEhlzson1zY?=
 =?us-ascii?Q?w32iC948kn9AhMrGZVDtA8P+dnkr2/f9XaQog/LeBINgJSqULjXQBoEuLQz+?=
 =?us-ascii?Q?IhsBx18CFadrGtHojYGJTz+1F/hGtAO0mo5z00N/GuXssHBPOWOH+IZV8TAr?=
 =?us-ascii?Q?2iEcWcw9TVYhnjd6Bo7ahDXG4yRycCwOMT4ShK1tQxwZThozC+fekjDuYl1o?=
 =?us-ascii?Q?7vqk68HkIh4+4jH6+trY+SOGFaWMtHBOh+9N6sO1TLys+T7QVmqEWr+bBhAT?=
 =?us-ascii?Q?OVwYeLKSjbGTMZweIb63rSe4qGIl5F6xAxEzH6OFuUnR0sT9VmgijZ0l//i2?=
 =?us-ascii?Q?u1ThAcuR0y+E4U0WQv2o6MNN1K0itrScbro8fEZjwjqBN7vSCw3qcydfF0r3?=
 =?us-ascii?Q?Y68y3x+lXC/7MiGtIAnuH2Pkn0n8y2UR+8+4GRAL8jIg9PfdgnuPB/yFd3C8?=
 =?us-ascii?Q?cVrRXz1SO4N6N2MjaqzqpTEiU363VGavCqELzIDRZDLQyuHWLB9xUvFsTXoF?=
 =?us-ascii?Q?5aYPlJr/uNUDDJJI6CT8OwbAm+PUfJdmY8aUnzG051hDTSYgHvoK9A2wCJVv?=
 =?us-ascii?Q?BSPxPm954H/d+HzcoP8k7DccU3BMbLehUHmIwvRBDqL5ACmyYPspxB1Lh4Ct?=
 =?us-ascii?Q?1orVC6RrrvB5qegCZF2HaIqcDqpDplwlnsyhZ3ay/aSB5NuvpBW1nSNucs7P?=
 =?us-ascii?Q?i+dSA0VIjWp8O1rYTDw8P9ErBlNblgFeiypmnwIALVxJb+z+BhYhOneJOXRq?=
 =?us-ascii?Q?hUjFTFd6oC5EuCJl3c5hEkNMypY7AG7eVxjQdb1CgL+MdAacJwDQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 919cf35c-e24a-48af-ea8f-08dea6fd6302
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8300.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 21:13:55.3471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B25ZgCAYu78XhGs25DylfUSSlNvvS1eOzDxAYibijJORYq7ZXSgN/xppiv0eplmrBCZuGmqcZ9Cjrsc2v9x1Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6256

This series is a resend for Jinjie Ruan's "arch/riscv: Add bitrev.h file
to support rev8 and brev8" [1], my follow-up "lib: compile generic
bitrev based on GENERIC_BITREVERSE" [2], and the fix for a build error
reported by Nathan Chancellor [3].

No changes, except for combining pieces together and rebasing on top of
the tree.

[1] https://lore.kernel.org/all/20260421130752.607500-1-ruanjinjie@huawei.com/
[2] https://lore.kernel.org/all/20260427205210.397471-1-ynorov@nvidia.com/
[3] https://lore.kernel.org/all/20260429202922.GA3575295@ax162/

Build-tested against x86 tinyconfig and defconfig, having disabled and
enabiled CRC32 and BITREVERSE, correspondingly.

Jinjie Ruan (3):
  lib/bitrev: Introduce GENERIC_BITREVERSE and cleanup Kconfig
  bitops: Define generic __bitrev8/16/32 for reuse
  arch/riscv: Add bitrev.h file to support rev8 and brev8

Yury Norov (3):
  lib: include crc32.h conditionally on CONFIG_CRC32
  lib: compile generic bitrev.c conditionally on GENERIC_BITREVERSE
  MAINTAINERS: BITOPS: include bitrev.[ch]

 MAINTAINERS                           |  2 ++
 arch/riscv/Kconfig                    |  2 ++
 arch/riscv/include/asm/bitrev.h       | 51 +++++++++++++++++++++++++++
 include/asm-generic/bitops/__bitrev.h | 25 +++++++++++++
 include/linux/bitrev.h                | 20 +++--------
 include/linux/etherdevice.h           |  4 +++
 lib/Kconfig                           | 18 ++++++++++
 lib/Makefile                          |  2 +-
 lib/bitrev.c                          |  3 --
 9 files changed, 107 insertions(+), 20 deletions(-)
 create mode 100644 arch/riscv/include/asm/bitrev.h
 create mode 100644 include/asm-generic/bitops/__bitrev.h

-- 
2.51.0

