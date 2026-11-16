Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.177.32
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794817607;
	b=kbBmoYf0aFP3lQ9VEIq4e7nVpJZCLB4Qt2Oy0KvXzsrDkwPoYHHDkH2qF2PYyQIK9zE4
	 Sx4/v8c/x3wwAfvKqCfyq00qM4KY2RzGUdxxzIAKuc3YJm79HmQbD+CLALduu2P95V8ly
	 AswCpgJ4AT2+ILyUnS5qv3s2CTu67P/dGvG0aKrARASKZu68Lze37CqZ9hZIAqp5vhZfh
	 dr/CSXahCpUmYModtWwBb0WXMyvLHjgXtEvM3KXuFQ8qwJzjlr+DMn3glba7j15HMa+0H
	 kE1ugdzEYKTgTSPVQXCBrxuYjQfMhm6tdI2Tc9WsA4kVcbssXvtJ3Qle8ZyoNYLkUyg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794817607;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID;
	bh=klY/txPmTSVSG0+q0NTnGUzpoF+ghrOwwUlYs5dzFuE=;
	b=FV2GzVrOoNQpgRhLn/FFCHfTdSY+Oafm1foAiBg+1NjTcQ87rzLcGOcZwWxu+tH7LYy0
	 Bx23QyLyPOYXlU/UboxmETbF83yhqgceZuENjjB3U8DiNCV7LwkFfZe/b6WsRN5/W+xiw
	 s0ZsYKRytWPY6rnypAKGUHZ/dhPSXaGV0q91nzOylFvi//fApmTTSYGw9UJTcdd1r3FOz
	 3r0qPiy6YV3BTX8bIAOwCuhMnaD2JYMG/2kpcbBsA5AEJJ5Dm6oTRlMOLdlOr92OgAAxn
	 6+aot6ukvH8e9dxqGzCdgAC4P+sbw+z5sYoTCK+AIMXJxp9bQNydOhKDbZmkAiC7DHA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oracle.com;
	spf=pass smtp.mailfrom=oracle.com;
	dkim=pass header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=qCUs9NfI;
	dkim=pass header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=TJVWXI6Y;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.177.32
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E20A606A333;
	Mon, 16 Nov 2026 08:26:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E20A606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=qCUs9NfI;
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=TJVWXI6Y
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AFLg03U020612;
	Mon, 16 Nov 2026 08:26:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=klY/txPmTSVSG0+q0NTnGUzpoF+ghrOwwUlYs5dzFuE=; b=
	qCUs9NfIDh2c2Tem65VQmioh8UIQzs3xAOrrdUssDq94P+h/7nS5DJTHZgF1dPSY
	ove7v5K9uZu1u9R4xN6N9XdfdNw9zDQPD42bpfUySG1qRfI1FjMnrvf4e4HTfxUK
	+g6huQB+swhbWbtnJl5yrIh7hHF3SrzXCNgtbyhedsQAxTsGR27enjPvr9W8xeUn
	ud99rXwfS7WNtZ8eHVZleBXn18wmgyg7Kf8ANtXFgkq6i6Lu+OQbnwtA+khU/WXX
	+lhyObIbrFjEq0TFpcfHO6s2HUz2tM/Nf0QYVZdGqQTZ8JCeNLraNCw17xqwTBQP
	ZAsQ3abC1dTJhbWIW+J0fg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4hxfpe1kwd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Mon, 16 Nov 2026 08:26:15 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.11/8.18.1.11) with ESMTP id 6AG7c5Vu2871229;
	Mon, 16 Nov 2026 08:26:14 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010002.outbound.protection.outlook.com [52.101.56.2])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4hyvt1u5sj-4
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL);
	Mon, 16 Nov 2026 08:26:14 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cJqqaSoFFRxB34PAUBxE30eJIitzztwUelidBICEPBx/Sfclwq+NjYfM90Fjz+v6QQseaICUpD/yeqg1H43dVSaxHkJzs4/OTbiAAQSlekaSxG5RaNTt6VzguPxvV90C8rO11/DE/34cdVRhBdoEpGxqb39LwHJR9Xb5vDXAY4lC/ns+tjiMO8RVQM8hl+Slv5X2C/UF3nHmslXDmM6KDwCR3fJdB33VC7dOKLr9scgP4PlAWFMpnn7i0KLW2jay/6ODGjtRAarJe6UWqH17kmzoqhnmWgQKC2m1KHhjmWZaX2uDbUgBecwAs3QI8qqvjISpZP687APzAb6dHPY4sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=klY/txPmTSVSG0+q0NTnGUzpoF+ghrOwwUlYs5dzFuE=;
 b=C19/hyVsROFq9YOE9qCJ+fDhfwmjcsnX6QOFtwMt4oqWYUkOo9j1b46CRK6w2+byV2kkI1t0oYVNSBlmdYeqFHHkmO9B2+aLMcJz/uS0/yY70RwsfP9Z01aptfF2ksLSda22GY06MDkk/+HGf4VVyjXo468rope0i1WKgSRxJdJ7gdyH8otkznyj799+ngjdxeIaaHeE5Me4ZM9DzBb6+DV2IgosQD6U+OjnmKl6O/y/0pANaGbOla9plAs2dotuNk5WEt2i06t3k4zrQT2i3T3Nu2TjHMb/A2/Y0zSeSZkdASmSPRrglFnyIGkDPnwIHSgGZynOs5wMphPP6P6CUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=klY/txPmTSVSG0+q0NTnGUzpoF+ghrOwwUlYs5dzFuE=;
 b=TJVWXI6Yj6bz8pT4YdEm08aTObCx42AIotwCwC9WLCOZULquYfBT41Li48O8c54d+mha94SN7y8z2h5G2xNuk+LSERSi+rHx+hn+0qdb/X4GsSSipiLEKWW0mnq4q7j90WfngYeBbf3KJs4PrwVb4XsB+LRX4KFqnF+2kcpn0AU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by MW5PR10MB5764.namprd10.prod.outlook.com (2603:10b6:303:190::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Mon, 16 Nov
 2026 08:25:17 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%5]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 08:25:17 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        bpf@vger.kernel.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, sahilchandna@linux.microsoft.com, cl@gentwo.org,
        ast@kernel.org, rafael@kernel.org, daniel.lezcano@kernel.org,
        memxor@gmail.com, zhenglifeng1@huawei.com, xueshuai@linux.alibaba.com,
        rdunlap@infradead.org, david.laight.linux@gmail.com,
        broonie@kernel.org, boris.ostrovsky@oracle.com, ashok.bhat@arm.com,
        Ankur Arora <ankur.a.arora@oracle.com>
Subject: [PATCH v17 16/16] barrier: timeout validity checks for smp_cond_load_acquire_timeout()
Date: Mon, 16 Nov 2026 02:24:37 -0600
Message-Id: <20261116082437.66739-17-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20261116082437.66739-1-ankur.a.arora@oracle.com>
References: <20261116082437.66739-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0133.namprd03.prod.outlook.com
 (2603:10b6:303:8c::18) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|MW5PR10MB5764:EE_
X-MS-Office365-Filtering-Correlation-Id: c81937ed-8200-47fb-47f6-08df43bb2522
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|10067099003|56012099006|261026140227099003|261021123027099003|261026121527099003|261028144727099003|261102123227099003|261021121427099003|261022105027099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	MMo+guCM6pj3IG5IxlWHPp03paehk+1YHDkkH7N2YsQWIxpNC3bZjV8yLxPkjVLfYZy3+LGg7CDuCQ25pB9XHqHEe4Amg5Vf2JjQ6RL9aQ/oR8K8zoZhPo9wwH+Hkss+FLViMckql+Y72H83Y5Vh/pzO+jEFYWO+aYdJH7RvhdTiiA4UC4uGNGjz0foyovObH82Scq9HxDWvGh7RL/rkIwFXQs6f7mG40MbjeDzCCSzEZIOsa1AI/wrlU+4ZkicrF+TKNHKymwL75Ns8SkoIN9D5vUrwnvMilOpMWZIL2j5UT8wJgktQHj13gHtp11RKTaEW7iBGN/aZmXoU0VXPFa4zxUonVvNqTmJdUCw2l1LSmSsc3lsMiIWj1bZqwcN7l1KnMPMXQWIJHKA3YHIv46qfimLZe3zclVpxJVKOcAUn65f50jW/LJzOc9wwSj8enZBXD03uhzhID25oUk2C2g71mhZZlafSGneY/xzuvHeEGXo752nKwgbCrP2LzzfZ4PUhHg0nA4ecJFJPWSVY98aC/uzXMUnaNzQZvXoYF3xUeXV+sR71W49fYAWRh6SbyWKlnyDGrRq36GITQ38JAphVljQ/yfn/YNmb1KkSpaF5k9kAYhkrYvlik3JgXMv5AH+T0h04xJXQMPx4kwMekkwDOByen0zGJPAtDXwk1vs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(10067099003)(56012099006)(261026140227099003)(261021123027099003)(261026121527099003)(261028144727099003)(261102123227099003)(261021121427099003)(261022105027099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mBQm/CUPYMxYOxpqpSTxOsZ3cQHvk0x5v3AM5AiDQfU/gpNAeKD0iuoDr0oL?=
 =?us-ascii?Q?L+t7CR38w9F0rPmQ1G6K6pnLowIDLqLzE3D6LOIuxKiDXYhpTmqtPIQ7OaMX?=
 =?us-ascii?Q?do8uU/zr9+0HhYOINsowWFUHIjfAuHIz8QF4caJOuhS+afvIetFSbnfhoa2Z?=
 =?us-ascii?Q?SFdqospO+05tdZPWF2h+/TVwRhtEyTd9Xy9UtP6hTH10rywQLGcq56iAW6BP?=
 =?us-ascii?Q?x7uk30jY29HN+FwI7tkD6VhxWmh48YA87jcCWFDNafHHZWncVnJRdRJyFZf9?=
 =?us-ascii?Q?UEgjRYs4zXZC7yakgGG+zOJSRxLV4Q938T90cm2DqRAeqO3Ygalr1L96t3F/?=
 =?us-ascii?Q?ez62CVwEiNn545krymt6Egkqi3Xsjrj9kHj7Q94mEsXYAZJgFuRgb2svarEx?=
 =?us-ascii?Q?FoJ8cmRSBOrgfshPcCMmG8WQ0zWIXMiP6MyrrDkBJJXXgNZgP9YHvzqCbAwl?=
 =?us-ascii?Q?qKFHNj6rME60Pu/wNI1lmtYO2sJ3tUi2S6mPH7sdYE5FGOsap6jJAGvyvNI4?=
 =?us-ascii?Q?ogY0E7d6k/Oe6eNFHm+II58iS/K/KfH+xBHwp3l/Ol2MwwIus0S2J+mhgZ7+?=
 =?us-ascii?Q?tPdk/Gsje990ljlUbrdQYBpKlUvV6Y9J2EZt1ZYSAlhP+ctqZOEtrYafcPmN?=
 =?us-ascii?Q?lRo2Wl6rrazjbvXvmcTKAx+4z3Ly5RUbVi7yRHFh2CjVHq4zpsKQfNUHALxG?=
 =?us-ascii?Q?luAZwchHbNDTJYpw+DzPtsMdBIgNpeYcXNrri89efrZV+jyuKEJMdm36ovW4?=
 =?us-ascii?Q?J7PMKQLkEcKtCctPQ6eQe+0X/DeRu4o64xdAbplb8sO/M2Mh3D8cjPsECfP1?=
 =?us-ascii?Q?ZvmU5U9oIbcuozNq4rbXyID7X0p6upNj4U+aIV+7JwPpa58UcZ2HS7csBHlA?=
 =?us-ascii?Q?YS2/YMBkUTyWJII8qLMJ9F5hwW6M5R5Z9G2MLNxh8SUuW0J/3/j5D8NjXcSq?=
 =?us-ascii?Q?GJl2vUaCBgowocT7ENdrUdKlB/S0BeEnF39EWPrtIA/xIRdvKWfmE7cP+GUh?=
 =?us-ascii?Q?b/mZ2BkwyaMbw6mcqtVXFrYYu6JxDqsiZPC/LoMKmb9EJbJsRf86NrjT0bCI?=
 =?us-ascii?Q?s3do2dKxXSRknF49lVIlTMSW8tD7hmC7P0JK+yuh4Mv+rmWzwEguWHmTBuB+?=
 =?us-ascii?Q?13oiXf029VqIIMiPEGUpQKtP7YcFneWxqUrDBTwflQNYGI5FVsCpSKCveaza?=
 =?us-ascii?Q?BQRaMUpDKKYL5VvLOZ5bC7HpXd8OnDPUVyJzjnOzstFAGxltfcUOth94CRNv?=
 =?us-ascii?Q?bDJbxFQ4+rBk9e9V3LsIAluMqnHW9G3gz/bIkzmx1uRGpnzZrU5QhKJPWLCF?=
 =?us-ascii?Q?8dC8AXgQvZMvvk12QI34lPZc4AkEtNFVjVVA5rS2ViBfEcBgainZvfsqeUZB?=
 =?us-ascii?Q?eHVV7dY6M9mY9j48F4lEvqqLCJ/Pi3eonA4mJfvH1aAV5U3qjkgSTgYUzUXb?=
 =?us-ascii?Q?0N0fV+bYAwawvE+Nt10Doutr79vSfdbIAtgZJITfln6i27DxgUMf6UzOyMUJ?=
 =?us-ascii?Q?OEkPTdgfDp8UcO1TqB6vN0MPLfhS1FAmwhG5qOsVlR2FiMSNHKvr9Kzb8T89?=
 =?us-ascii?Q?uGxdXUQpEw+A/0igHTzNn9n7j1z/NYrGIA2WhtPcfoxX90SLYiuuePPlhEe2?=
 =?us-ascii?Q?D3lAVRR1GCzErjUS86vE27AKkukwla76o5n5xuIN00qg4+ya+on8fOJdDSlv?=
 =?us-ascii?Q?XP9NaIWTOpefNuRYFmm7w7usUDeT4Dpv0iIS2eaxGSenOyDxIdc8Gel+cSsG?=
 =?us-ascii?Q?mk7YDHoK6xJp9AeIw+by3qEVCx8B34Y=3D?=
X-Exchange-RoutingPolicyChecked:
	IGB+1y9I7wuzWIz7IpHYLwbXK88cQyfujaSuvqDsNL6fcOxdsnrXgGxpe/EYhkEkpTwQ8MV8yR23PI25zit9S/AksYso+fP3ODeLU5LAZAK7P7jOU2nlfyCqdmyjRTJcpZOVRvuIdJSLNqEsOdedFPI+lbsEZXtCHXOJXC3VQv0nNYeM5HiD5eZacF1Kvpxttj16eiou9QHwAp10XS6Fjow2nRPrWDp7EAfjpfJMZ++XmkNTuPDdIeply+cF5igtKJ6QThWge7thYrQxxpnj8fL4ly79aurHA8ZcOe03elOcDBXtaiPFvcVBasORTNaHdRIiOvgfFARBLAuUZNs9Bg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VsYX07hBE0DnzjXzFoAlIlgOYmmbD/92FP+R8skFyD5onMapWuA9R+IoIlldmLbRXwg3+u6xxnzzBlQmOFtxhg6AUmBUB8MyaUXqPu9/z8ago/RNwm9WFMsumhL4ebteiBXI2mKOkxewexCMEl8eSC0eez9j5iiHPAcEh5GAhlSiQDt2GbJ7xBGIJGGJ1vnFpbT7ZmppiDOT4HjY5ZTkn+QjHSmA0wsLx9WoLOlGLFx58y0s+BLNpLxVzoL+zLMV5dLA2lwCFyl79mNsxqq7dKeGFCKxClHorVLwVqhMYSTxWco/HBIGKdEoAcrNV6GiktZ8xG+Grp0OwsC6ypKp/0Ks6J/iXhBCdLWFeOLbmQGR2mR5RdRq9+ppb2NoREjPSLgE1NpZdTLVKFk1+sApWNP+5qV4FHR2EWT03mdVx3RplDir2mQ3hS7FqJNL21Wk7BhAbCfVQD0kvbHwgX1CCbPsfUuz8DGJse2NvNmo91KJAeqSYetg0/GWDdywmJdqqWmoJdxzAFEXbHG47ANZH224t008PfyTP4Yv1/P8RCWs42gy4u/PyFgCx3oligRQP3JLAAfVtnpvyUtPGYUPZDm7454lb9Oz0J9EqwU8HJo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c81937ed-8200-47fb-47f6-08df43bb2522
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 08:25:17.2217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GMxPR5kCUNLrH+dYNEQ4Fto2k6Elepf04EVRATGp0Tz+R0BL7M3PSjo6Z1IPVvFooCxBSybT6hwjjRUledWaPsRTrNv1RV60ZfkTrTawTnA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5764
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 spamscore=0 phishscore=0
 malwarescore=0 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2611040001 definitions=main-2611160033
X-Proofpoint-ORIG-GUID: XhkFum4RtQ2MNmahe3SIPQotjMk2kBrW
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDAzMyBTYWx0ZWRfX7wxWbLPeJ9YE
 7qsflFDB48CismqZgcY419jg/DyiRgTcjvp7Z0KwTKahr1Vm9ZvMbVzC+jckTWxCM/RiC46eh1T
 RacukZG5iFSjpWzSIgf34koEsAW8QbLCOmBIfYb63SbIzdKc5V2X
X-Authority-Analysis: v=2.4 cv=PeNqFShd c=1 sm=1 tr=0 ts=6afabe27 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=vggBfdFIAAAA:8 a=yMhMjlubAAAA:8 a=yPCof4ZbAAAA:8
 a=Ze9yCt5EFHv8u4PATkMA:9 a=WmVTiCyuxqgg3mnwYu6p:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDAzMyBTYWx0ZWRfX67yE7gA/7NtO
 6jD2p/1hp8Ni6+eOgG22/CGW8RwVB4jts004sKbraRciDJaDmEeIvM4SQ4PaNABgcqLj9uR7V1D
 ynQaoLflMDC7fbZrzz+h23tKt1SRDLax7iR6LxE111h4d9Eln908kLjdLgyWkSxzQwp0krCDuJj
 RpZbV9QdywfF6TVXxNkKV7mImLyCGLxrKOoBXkeqdhNvN7AYAT9IENl+Rfv3HbhIR8cofEJe2al
 4mv4Hv18Jn/mBc+CY9bZF+EfC163uq8O9uOi7vMS0m3IxCbzpvuLLRpEku+RDtv5FhTpXOTN9DS
 4PZ0s9sYBfcuw7BqAiH5wCkbq4POJSMHMz1Y3zAakEQOqqtbYkoVdsWb0BD0oQnGIyYDxYXTGgY
 hwRx2X6Ko3vghf3QfOG58Yel1g7egIVIzoW+CnwmJY8Fd3Qs5UxXr4XTHLLWj2QKnGOIoLVWqOV
 mFQjx4TQiUUbi42bUYQ==
X-Proofpoint-GUID: XhkFum4RtQ2MNmahe3SIPQotjMk2kBrW

Extend timeout tests in smp_cond_expiry_params to also test
smp_cond_load_acquire_timeout().

The interface supports clocks that can return error on timeout.
These are used by rqspinlock. Test that by using a similar clock
that starts returning error past timeout.

Tested-by: Haris Okanovic <harisokn@amazon.com>
Tested-by: Sahil Chandna <sahilchandna@linux.microsoft.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 lib/tests/barrier_timeout_kunit.c | 58 ++++++++++++++++++++++++++++++-
 1 file changed, 57 insertions(+), 1 deletion(-)

diff --git a/lib/tests/barrier_timeout_kunit.c b/lib/tests/barrier_timeout_kunit.c
index b6cdecf29574..5c48a71f1864 100644
--- a/lib/tests/barrier_timeout_kunit.c
+++ b/lib/tests/barrier_timeout_kunit.c
@@ -158,7 +158,7 @@ static void expiry_param_to_desc(const struct smp_cond_expiry_params *p, char *d
 
 	snprintf(desc, KUNIT_PARAM_DESC_SIZE,
 		 "smp_cond_*_timeout: clock=%s, timeout=%s, iterations %s",
-		 "synthetic", p->desc, iters);
+		 "synthetic/failing", p->desc, iters);
 }
 
 static char *expiry_skip_test(const struct smp_cond_expiry_params *p)
@@ -223,10 +223,66 @@ static void test_smp_cond_relaxed(struct kunit *test)
 		KUNIT_EXPECT_GE(test, runtime, p->timeout_ns);
 }
 
+/*
+ * Use a clock similar to the one used in rqspinlock where it start
+ * returning failure value once it goes beyond the timeout.
+ */
+static s64 failing_clock(const struct smp_cond_expiry_params *p,
+			 struct clock_state *clk)
+{
+	if ((u64)clk->end_time >= (u64)p->timeout_ns)
+		return -ETIMEDOUT;
+
+	clk->end_time += clk->extra;
+	clk->niters++;
+
+	return clk->end_time;
+}
+
+static void test_smp_cond_acquire_error(struct kunit *test)
+{
+	const struct smp_cond_expiry_params *p = test->param_value;
+	struct clock_state clk = {
+		.start_time = 0,
+		.end_time = 0,
+		.extra = p->clk_unit,
+		.niters = 0,
+	};
+	unsigned int result;
+	s64 ret = -ETIMEDOUT;
+	char *reason;
+
+	reason = expiry_skip_test(p);
+	if (reason)
+		kunit_skip(test, "%s", reason);
+
+	scu_flag = 0;
+
+	preempt_disable();
+	result = smp_cond_load_acquire_timeout(&scu_flag,
+						0,
+						(ret = failing_clock(p, &clk)),
+						p->timeout_ns);
+	preempt_enable();
+
+	KUNIT_EXPECT_EQ(test, result, scu_flag);
+	if (p->miniters != -1)
+		KUNIT_EXPECT_GE(test, clk.niters, p->miniters);
+	if (p->maxiters != -1)
+		KUNIT_EXPECT_LE(test, clk.niters, p->maxiters);
+
+	/*
+	 * scu_flag is never updated so the clock should eventually
+	 * hit the timeout and error out.
+	 */
+	KUNIT_EXPECT_EQ(test, ret, -ETIMEDOUT);
+}
+
 KUNIT_ARRAY_PARAM(smp_cond_expiry_params, expiry_params_list, expiry_param_to_desc);
 static struct kunit_case barrier_timeout_test_cases[] = {
 	KUNIT_CASE_PARAM(test_smp_cond_timeout, smp_cond_update_params_gen_params),
 	KUNIT_CASE_PARAM(test_smp_cond_relaxed, smp_cond_expiry_params_gen_params),
+	KUNIT_CASE_PARAM(test_smp_cond_acquire_error, smp_cond_expiry_params_gen_params),
 	{}
 };
 
-- 
2.43.7

