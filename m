Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012061.outbound.protection.outlook.com [40.107.200.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F0F4C0439;
	Wed,  6 May 2026 17:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778089975; cv=fail; b=I5b6X4uEYU2EM3shjvab4qGKIu0iH6W+5QlHcBU4w4ZSIWMRN2InUMGsytvwhZ3cyBqc9sOKvfLp4O8GQ0HDn0ucZRlj5ng4Y3tYxvBVSO7FKpHv+xnTeAfsxwpKdA2e02ztSyNXe70JeFwqRes6aAovZpFXm2JZI77e8Rs6akk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778089975; c=relaxed/simple;
	bh=kwJNJIB1QUyH55Mz8uWSN0Ty/23Y4Tx2jl/fZKrsQX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kbqbVPEf4xRznaJPknyCqPvutfPwe9B4UKOZ0WA4JtI2Tt6YFR+pGgBjt/LUWzIVpI7st2xuJ7BH0AZW51cKZ4C0Cb995+i54eVZ/RnCo/e59SndMSTfgSscHaEm35hzxtGsYWrRB01b3YOLm/F6nQiUS1auI7JmXPdLV3ZO5tQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Uj3xZwJA; arc=fail smtp.client-ip=40.107.200.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Uj3xZwJA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QFM+nvAHiOBkDQ4Vr8WH7p6xbAlt3feiK/+myuqYFXkXO7f7F2ypfT0V7nPAEZXalGv0VImR10RzhIiPxsDDD4ObG2ZocowB7yBM1aywBuVhmFaU4yZL/Ec3zWrD0szVzFDvtiKkDXBXnS/L2YPk4TaNGPrrLJJARGrtcuNklTgXGEXSEEYH/kZNshB+fW/bfxfJl7B5tb8kz8e65RI0S9AvpurYU5FVsR/RHvXEp6LlxfLVIp0KPaqnAk9SKhny3zkckLT0yzs2g3bI9rzB9k0auYXB8460sLtPdtDl0+SE2DRNYZnXPqYntwPmO2ETS2qnBpF9lEVsM+kyEdixMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PcERl9jq/ivV0VSW/OyjJ7uHKNtcch4Ge1C1PViFkDA=;
 b=lz9D7gS833f6SKgK2DOLS9hDGzs6DK+9W43Own+0DzSCuuWHawZMfYB2dRz+UyIUFhNPDglhi91ftNXBRTlHlr81QYACH7N10hxzkaFwB5z0ShKChX+O07sEI4MptMagmyi3HnwUudZSTaLre2ITakQ0WIonrA1Q/UIBooZ47q0/IOomr+ChIGDC6l0Y410Yvb6XcTBt7lh6wBfKzKmYqmg4F5ijFAhUvDvghx6LHktGQYs5xprdaLcxxaXsZ4gxwSBYWV1jOGHxEMbb8HBoBLpwR6fhA0hpyvJA1z1hjPJBNHuTgKIJiK979K9k4/SWR2tmjaY2AZX7NVe/9V+BXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PcERl9jq/ivV0VSW/OyjJ7uHKNtcch4Ge1C1PViFkDA=;
 b=Uj3xZwJAl7hQZUzHjMIv9Kw2tvldbOxK+uq09dPUVrdtn+FrpTZi2trPl1sCMimGDY5PsMQGsNsl0NddDaWZEsMBj6DuuIWfQd+6l2o8Pgeiq23p7vvOZm1HZJAiJfGDFW5Rqi0GBUZUTAgybMJBymTp2RbYSjYF5jyKU3fXiOYjhX2bBISYiZ6CUDyHPismVxdsBN4JDsDEKJZ1Ja2M4kYenEwvPUWAeSD6ia5t9jFdyKc6I5V7OU1kuFDyqJz8FQXaxp1z9Y7GRdEt2SqCcxIVDRaNd7aszJDp8NlF7VR/16kPo15pb7r5KA3eD1BsVSvzQMbrOAQZH9c9IL50rg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8300.namprd12.prod.outlook.com (2603:10b6:930:7d::16)
 by CH3PR12MB8188.namprd12.prod.outlook.com (2603:10b6:610:120::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 17:52:19 +0000
Received: from CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de]) by CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de%3]) with mapi id 15.20.9870.023; Wed, 6 May 2026
 17:52:19 +0000
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
Subject: [PATCH v2 3/5] bitops: Define generic___bitrev8/16/32 for reuse
Date: Wed,  6 May 2026 13:52:04 -0400
Message-ID: <20260506175207.110893-4-ynorov@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260506175207.110893-1-ynorov@nvidia.com>
References: <20260506175207.110893-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0009.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::7) To CY8PR12MB8300.namprd12.prod.outlook.com
 (2603:10b6:930:7d::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8300:EE_|CH3PR12MB8188:EE_
X-MS-Office365-Filtering-Correlation-Id: 5341933c-9886-4429-e704-08deab98377b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|7416014|376014|1800799024|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	9y0XRjUfaxjaBP2gruqCBBAA9D7bCxCH7ufSkC5/HfbQA8XJpz5FFZ4yK4MVNvXzB6jzxrWyJ0VcpqoaJtrKnzyj2+cScoHuL+7FxLTPvHYFIsPES+aQj4umeTo1x3X/Hjlga+LE1ptXQ0TamFKuRsYM0K2LOqi1QEScWiBS9NuyPw7gScOvptvGg5JATvQhI82cn1wr3KdwfoqtFtK27NKD8pPoieBqGo4+vOJkmYC8BqFSOXMigOBpLjnS7E5i48/aZQNnHKF7WzyntD8E3FdCCgMhI8mIyjRvgQIg9iK166jOao28dZsBQybn33K3M3kp4GhpXlul2o1rPc1AbpYZT16ZQDuaz8SpsXSOu54y4G4Q6QUmmvluPqysZ/eMgt+4VWVHgeIGI4BIQQMLCplOPQ4SswmpET9sUHDFz7/jJ/x8aWX7rZ7CbF5DU/7qChajyLOCJWb1B4/jGG9Iw0aJbEmgG2Surm3GkXLg8qHrLD0RQ1OscGp2o7e9NYtLNgiw0WxAwgLVkkdnVg4LLo4t/sVAnoNlh2NZqijWD2zs3WDBk4zzt7OuzPOSvAVJBBa+abG9db1BObpoQ2EYkHfgWApgXtPkREwKhG+Ork5kyMEaTZasEJZQ7A79zswQCqmZZieD86T1SwoTeX7TARV83yBPx94yncA3VSQJmoq1QBvloT1t2/9jYV78mxHTu29NEdOpCP/UXItIwVpnXzC7EIIbI86jigXOhvW+THs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8300.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(7416014)(376014)(1800799024)(921020)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5gKur1M2xIqSwIjWyf/4T8iVB0ZbWXgOAZkb5jN8dDo36grzrzQiHNQPIpVR?=
 =?us-ascii?Q?9Avdo/id0lMweoHMZdcc1A5YBnaXZM5paZv5/TK6atbDaBLV2Ni695BJfeqO?=
 =?us-ascii?Q?UoiyBwh1GQ+j/OIX/HAK+7nDMo5cBjbZYwJecmLU5lyR4ZnJE1JYtSN1YJr+?=
 =?us-ascii?Q?CzaQ3QI8aIf2uhCt+tRQnfUM0gqt0jYWjBZzCENrZBzglwVzJg1DTyz1nnS9?=
 =?us-ascii?Q?q+FE0p8k/f1x8rXDxKE1ebdXER1QW7jsBWD13VAgNHBK2OZG3CFXtz2Dkw8P?=
 =?us-ascii?Q?dapfd48Tar+OdsohfpZkLJzRMND/lI0hUf7R6fKmxPr//BcA2HOA0v/cUSZz?=
 =?us-ascii?Q?ee3Kuf4PwckxXWZPIJmfkOkfGU1b81k25X3aCKuP5tNqFOj5JG6RQteUltmk?=
 =?us-ascii?Q?cSr/cYlgaOhdxC3SSknGOSrEcNHmZZXrrTcftK2MuGM+6qPVNa/KbhRmQA79?=
 =?us-ascii?Q?bN/15p0chcTyfZRh7ZGEmwfklLX/Ledce84vRr9T9qBZ8udeh8vezrp8n0Rf?=
 =?us-ascii?Q?Ag83ZVf0Z/yw0XLGzK7L1YPd5iEtCUB9B6UYNb2Kr/Y/0h5+1Kjo2AhnaOLC?=
 =?us-ascii?Q?ntbYW+lIrfKxTONpES8Y1O8zhpw6fzj0ZrrgnGpMcgpQ2r0k4tDQ9Ha4JuQj?=
 =?us-ascii?Q?dkSwqzEu8jSBUYvJQqg4XqpGG3xPDfmlNlmavsTlZlifaP4h+MMhxSKZWbJy?=
 =?us-ascii?Q?Hry0ESY/FSOOqfDpK2yDSKg+hMtCGInCphKHw+rYVfhAS/iS2KpWhkvyb89p?=
 =?us-ascii?Q?qOu0i7Jcz9zb6nsG61wgk8PdhlDbAFcQdf5Y7TrbWpAtj/hZUZl9bjr0xrtO?=
 =?us-ascii?Q?Sj8gi9Jf4asEHGczr8jxijxHrfX/KucmKLq8hymYwVsywE35e/bMLNJmWtlJ?=
 =?us-ascii?Q?cvNxARjMtCTnSXgDiqvxEI3lAIGneiBdntT3YmANxAC2CurIyJOgb9mFbgNM?=
 =?us-ascii?Q?X7h4GSwo/KU4I1x6/x/PVlbiKEJz+Ly2H0GJsx2zmqV9dSAe34JCWQARnfSk?=
 =?us-ascii?Q?ddMaUliwFhS9q6BfMVA17jsRxg6v2rUVBusxOeVtn7n5vS8fyM3sDrljHbgr?=
 =?us-ascii?Q?0XuovBWnv80QFTDFMK2pBoSIj1HxqRr7i38ia5j2Ws7wysAe/8+/AaTIyj7a?=
 =?us-ascii?Q?nDDYGsLuFjC3S/QpUrgO0HIR1cn4k7ehMaOt32dUuYgCoyXu1VjxXRHuL70q?=
 =?us-ascii?Q?2MphAu5xGt+2PSzo9ShIsmhCCT6WO5lqeZyIZuRuJb396w9VusUArLUo3YHH?=
 =?us-ascii?Q?ql1cw88+aQIaJOFOn+S4WXUVX6Xpm/BUoMBmVxnWxYJstcyg2RvCKYaPyN7V?=
 =?us-ascii?Q?EvzQ7+BOqrjLhf8RgioZumH/9FbzpYjZXdu20frPwQkR/Q4dWqM/XZJHtWFc?=
 =?us-ascii?Q?aNuRIPh71ypIdZgVZxcNRbX6BYsVekpx3Oxga1aycD0+YJvUYkqRqk0yWc3K?=
 =?us-ascii?Q?f8YuwPXVHubZSZxQfBiApvR6brR60BrOnbZpjsuQfb7hXDidXSZz+r+fwbnY?=
 =?us-ascii?Q?CWbcRSEhq6yA2+tLFgqde4m/t6tZiHjdT1fAQqJTZuUmO1t2fIK8IO1d1eWS?=
 =?us-ascii?Q?mf9pPEajyDuXvqGl79TcDgz1dL/pzKlpzeKYcLK0h3osygp3Skd/P3xT3V3V?=
 =?us-ascii?Q?kArw4r1PBqgPrIVQBknE6L7jdkPMiqEzlD0ZtnvCVPiS8BVev1vVEc6Pa9Dm?=
 =?us-ascii?Q?a+Xx6QFdSdYBI84ljO8HVUPPH5cg7amc0/kksHxaY1vOvrDfGz2JT7suHjTu?=
 =?us-ascii?Q?bd7Y4yPDLyHDio8Hb+CNs2sDwDwzhXphsKo7MSnX1Pt7tgkjCpKJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5341933c-9886-4429-e704-08deab98377b
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8300.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 17:52:18.9706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: my2/8Ekb0jY1oWsI3fUqllkCzHtIIde2yQLIxdl6ToyppShm4blNa6HZm3oFbl/DlIEYviK74UFm3Jx+bUr+EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8188

From: Jinjie Ruan <ruanjinjie@huawei.com>

Define generic___bitrev8/16/32 using the implementation in
<linux/bitrev.h>, so they can be reused in <asm/bitrev.h>,
such as RISCV.

Reviewed-by: Yury Norov <ynorov@nvidia.com>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 include/asm-generic/bitops/__bitrev.h | 23 +++++++++++++++++++++++
 include/linux/bitrev.h                | 20 ++++----------------
 2 files changed, 27 insertions(+), 16 deletions(-)
 create mode 100644 include/asm-generic/bitops/__bitrev.h

diff --git a/include/asm-generic/bitops/__bitrev.h b/include/asm-generic/bitops/__bitrev.h
new file mode 100644
index 000000000000..4addbde14050
--- /dev/null
+++ b/include/asm-generic/bitops/__bitrev.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_GENERIC_BITOPS___BITREV_H_
+#define _ASM_GENERIC_BITOPS___BITREV_H_
+
+#include <asm/types.h>
+
+extern u8 const byte_rev_table[256];
+static __always_inline __attribute_const__ u8 generic___bitrev8(u8 byte)
+{
+	return byte_rev_table[byte];
+}
+
+static __always_inline __attribute_const__ u16 generic___bitrev16(u16 x)
+{
+	return (generic___bitrev8(x & 0xff) << 8) | generic___bitrev8(x >> 8);
+}
+
+static __always_inline __attribute_const__ u32 generic___bitrev32(u32 x)
+{
+	return (generic___bitrev16(x & 0xffff) << 16) | generic___bitrev16(x >> 16);
+}
+
+#endif /* _ASM_GENERIC_BITOPS___BITREV_H_ */
diff --git a/include/linux/bitrev.h b/include/linux/bitrev.h
index d35b8ec1c485..11620a70e776 100644
--- a/include/linux/bitrev.h
+++ b/include/linux/bitrev.h
@@ -12,22 +12,10 @@
 #define __bitrev8 __arch_bitrev8
 
 #else
-extern u8 const byte_rev_table[256];
-static inline u8 __bitrev8(u8 byte)
-{
-	return byte_rev_table[byte];
-}
-
-static inline u16 __bitrev16(u16 x)
-{
-	return (__bitrev8(x & 0xff) << 8) | __bitrev8(x >> 8);
-}
-
-static inline u32 __bitrev32(u32 x)
-{
-	return (__bitrev16(x & 0xffff) << 16) | __bitrev16(x >> 16);
-}
-
+#include <asm-generic/bitops/__bitrev.h>
+#define __bitrev32 generic___bitrev32
+#define __bitrev16 generic___bitrev16
+#define __bitrev8 generic___bitrev8
 #endif /* CONFIG_HAVE_ARCH_BITREVERSE */
 
 #define __bitrev8x4(x)	(__bitrev32(swab32(x)))
-- 
2.51.0

