Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCFE397942;
	Mon, 31 Aug 2026 20:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788207829; cv=fail; b=boRg3QX0ZHzs36kOxvLW3h71ZU4fKeKdGf5eStwIG//dPkSePL5ubpsmosIXsajIS3RCAFSzl6+j1dxQNnCBnE0GKADC6OUbJBALnS7r1tg6UDJ1VO1UBSHTykGOuqVFpt1VD/JvNEeEuVh6K2E84m9S84T69V+A8qgyLz6LEZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788207829; c=relaxed/simple;
	bh=rUMYliG4l8oZdUHHnMaHYXaPviR8pu5Oo2Ta5S4creA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KiVj7RorGM1/u6UVL8FPCq7IwNRYKtn1dfcTEE1iYQSVyAFz1vnJa8GvJ65DeRRSDhHw1z/pTDD9FMlrXubA3dIFKYrkrh0hW4adIU8qDLsSoDQksFE7PNU4o1Hh5AzhKwmTBXbLzEkFutihK7EOUP0V9//zjj/d4H6aYtFEF3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kcZ0fSIe; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sLoLzYRm; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kcZ0fSIe";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sLoLzYRm"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VGBpSG3113680;
	Mon, 31 Aug 2026 20:23:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=QsHyDwbZDt14FavL1G1amq1dUCjoYT5O4o88+Pn2YyM=; b=
	kcZ0fSIe+XhF0jET81QAMfcMVQ5i7yEioSxofXLV4h4GMBDBEajmBpWXAXb1wZsX
	vBMEjEKqZZSnjP1KzTAs6LMEYVHBniUlv1h9oAVuXIQF6AXixcXT7STdTxOaBnro
	r/jKthKHx5xPGt9wdacNnuFv7F6SVvJMwRL1gimca7TcBOYrSurAlbHipBiWmgNp
	KUW57W8LjKNdb1544FXT1Tbw1H6F69JtT6ABb23WRwGn5tDq56NGnwPumfxKEoEb
	SnkQLLydnyD2d7jkkhYd6o+5Rlv52BM5QSW/Np+nDLaIB0Ocf5J18QZoxXAZQqJ+
	NbxrS9U/uuspwyTIFLMwXg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gbqfc3cjs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 20:23:19 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 67VKFeoE032899;
	Mon, 31 Aug 2026 20:23:18 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010062.outbound.protection.outlook.com [52.101.61.62])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gbnvpqtsv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 31 Aug 2026 20:23:18 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NcrXCNY6OACXE1Iy72QScjGZrmnoXMF0eSwHjrBaVFJPUmyfjSYxErxzpDy1Cy9fz1M6oatIJsSgo1077RBS7yfA6tT5OXfEZDPQxDxOrJELc5jtEvPyDj+GsNss5i61wyefWFBGNOJV4emVHQUCJUuubnm5EAf+nq/5vFbTEotQ5m6Qy+7UFt/y72rddM4mjTEe4y6cv2HMFoJSIcXDBWx+sDjD4ji9RFCIvHytd5u8A8RmYdUKB/LfjpSzvbta+wj4aHX1XD3ioBLa5CzRZHUIBxjKDUJn4CYFC87pDhQsuNGa/hOsLcud7xrsYe3/25+snGzDS8P3Yjtf4OR8cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QsHyDwbZDt14FavL1G1amq1dUCjoYT5O4o88+Pn2YyM=;
 b=PSOLSUQpELxYC5S7gEEajDDW/uQjkr88N5VQorNsLHd2yoMa9zIoFDLHY6P30Nf6Prk4zZOdFI6f13IdiEPD7CCXGnDrNypR7PhQZIUlHAdL1CDy9BSh1VlYVMkq+/oYPVriIvc2S+/k2Kfqw0Tej9VIV1OQeOmw9R7V6wOfjVJvDbSEkRkAKfZMae/GsHeOnJOfLcQUd+4wbPitCkHVdu6RbrpYmF5pzcX+poJHt6qsH31fcjQBWRkxe5//l9vukEY1o5t1HTbepksHu/5FW+MQ4qpTFWmW/tAtx3AayCCKS3RUWDrN5oEnyjLzhV8ArXOForddl37HUDfJg+RDvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QsHyDwbZDt14FavL1G1amq1dUCjoYT5O4o88+Pn2YyM=;
 b=sLoLzYRmFvsz3QyXCeAFzWsxOlE5khba3On8ptdZe+5yxYhmV03EzsJ1/zimOt8uFPkxPwYkDYkcZjx5+kGeUl/mYKQKtihw8+kaILjLEWnd1nWgwpeBLZCxRzF7BqXhvSGGhlt8+uJ0HlKGeTLSpmp8etMEHWVfMT0vpIfVY40=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by PH7PR10MB6179.namprd10.prod.outlook.com (2603:10b6:510:1f1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Mon, 31 Aug
 2026 20:23:11 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.21.0382.007; Mon, 31 Aug 2026
 20:23:11 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        bpf@vger.kernel.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, memxor@gmail.com, zhenglifeng1@huawei.com,
        xueshuai@linux.alibaba.com, rdunlap@infradead.org,
        david.laight.linux@gmail.com, broonie@kernel.org,
        joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, ashok.bhat@arm.com,
        Ankur Arora <ankur.a.arora@oracle.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH v15 07/16] atomic: Add atomic_cond_read_*_timeout()
Date: Mon, 31 Aug 2026 13:22:42 -0700
Message-Id: <20260831202251.305046-8-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260831202251.305046-1-ankur.a.arora@oracle.com>
References: <20260831202251.305046-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0279.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:109::17) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|PH7PR10MB6179:EE_
X-MS-Office365-Filtering-Correlation-Id: bea14d1e-8c99-4c15-bce7-08df079dad8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|7416014|376014|1800799024|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ni3I+CYyBAc4AioM8fgNCyO3WcxAVQpLFYV3BHuxLj1DAFXVidVrgRenTpJ4q3YcyOev3x4GaIXtYc0MRLt1BjTdur042cOityBC5MQ9W2v6EeorgkoFEk8wFaCbR4ZjiQoexzJousLSRugeemHc2EYS6Tz7AV29qZjvUviFdhRKokAbw0oUfaYwsdlCmRLBkDihYkNgFNH4ANfJ3d3TMkBoCL+ekd+2l1V0Gg+7+9NIG8K4K6dRkxhvK/u6PW/zJ6DkbdRKm1UeUho0BaVrPlAsYASJTefrvyEneDJQB8uJp4l5c9uUkaIIIz8ZB76ZOcXeHjzZrNXauO4H4AiTUqQfJMHyri5LQLTzE3Sej8JiHkGYsjFTJu0DewIZD6kiqeUPRZsTuPb6/EQy9I0WdC7to8WGvvnewHWTyn6y7wVYThrgedUcKgDXU1TejnOnDWxfXatFrvFiGctIYLHD4kdoYQuuVfBHfl8/2IsryRBXlH6hI8XP/iOdUBPZ++CQttVsF9UA2mM/P2U3y/e7dBUBty+3oZFK9oBwLkPZs8DLNgf9ee7xbM32ScXYS8OdP9MP9iZunbWYlpV+0nw5SOwrinbOMzzFU1gZZ4uU7JqEaIaSgrIqSlutiWx8Z528l5S02AIBaULwBPJSpPsyMgcKeVC0WYxZegcm2cUe8H0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tOCFeKHO3nirDniGdY54zLkdaSo3Ju4o4nYXL7dy18PYgdQNlFXC/n3Guc+j?=
 =?us-ascii?Q?LIHoOyEM0+9vh2hbkzDGFBeKjpDvDpPYlmLf+w8xvw0oUxmJM1vPitSpYkX/?=
 =?us-ascii?Q?SANK4rs/nKyVWkEUdta3EZ2zjo1BCBs2R1/90M0Kt+hcaTpu5YiGNNZOI7/N?=
 =?us-ascii?Q?Ee/VS0kWJJ+GDhq5JfQsbBJB808+7BR/zmYnfeRjYVJHPfCQ/Gs34Ef0RmPY?=
 =?us-ascii?Q?Sm6D4RtK6F5H28CODVHqUkMT0uRM10qDm6R+LgDeVNTh6eqMy+jqRcy9la2n?=
 =?us-ascii?Q?20Zarz0sOldAgl/DE6rCP4XBFHJ2dTaXc2/jpoATrzFCX9ShJ37GW1MUHh6h?=
 =?us-ascii?Q?6cawv35jN0ZRQR6eEsN2TFJBWztjxg55ht44zpe3MIB0MqkBHetHRL9Cw8qU?=
 =?us-ascii?Q?LAv0qZDXrN2s/3gp0bHO3ZKircCoCTF7icOFWWe7Drp/0bkROwLELK+0ciAd?=
 =?us-ascii?Q?+BxNSLP7bfLZtOwo2c0e3kqNEU27lTD1tN0yOIpAaRXypC72scTwIWuqjYU2?=
 =?us-ascii?Q?MYMKiseAcou8L0E5f4OkZnV7Les41/hN7rD8EzrKiYdCiRwzW9Zu9MTKe6pG?=
 =?us-ascii?Q?HfTDl1ER/VWxrWymH/oIBV6g8YgOlJLwD9m6yHrcCwS1nlac2EblUJOWoUjV?=
 =?us-ascii?Q?i9o9EXTR27nafl79iAri+shJ+A0MSZonySCBwBBMPnEky7L6r6SnBerQgrLu?=
 =?us-ascii?Q?NjAn3QSLCYkVB6FTgjSw0rsqrIHf8XW9xH/wLz7+m0APUdPOarTbG3A7yeHk?=
 =?us-ascii?Q?sta22CAOR6OZSg7qtlkNqhem0CsQK9cA661mz5Y3z0S+Efrl3XTnxl3B5svy?=
 =?us-ascii?Q?S/5vbXTLQt9OJqa5rqN4RrL3eVE4WHFiHkylByMAQBaszlMKyBFFODhSgWAY?=
 =?us-ascii?Q?jqt5woa74hANoVq5mL1EG+RNNz9z4ZQ1rY1MK6v07Gi5Y0Tt12//XH7CdsD8?=
 =?us-ascii?Q?1gxh7Gvzrma+XA5WAJ97RQmrEsr0mZU2CYs645MK6GbOGuL7HU5kJhu/CfdX?=
 =?us-ascii?Q?Ew4f5MdiAKDd6kwVsxWEOo+1VeKvIIAHfG7UivQrI2rM8aEM1VGQxn9JSeLT?=
 =?us-ascii?Q?3iniLrMGrSxxO14E2svzYml4nhHo1XRYHteSM7zlP681mzu4puxaoxhO7QGH?=
 =?us-ascii?Q?2955h0aePECRpTsJzw1qlIuSpkz4tX9tpWXa8EQgWCGRw3ZygNXiLqdrIpt2?=
 =?us-ascii?Q?8/oeVPIdZOkPAt1CUrWuRRW3FRHm5UP4cdzAxN8pEX4cDcNeEierBVnOJK4E?=
 =?us-ascii?Q?L7CiAkJq16L1WVlysEsE8aIVYcy7XDMPoiXH2pcT8mEjxiKao5k9fxgnfoiK?=
 =?us-ascii?Q?+nJLf1MF/xfTSGj0krVtjHEaDQD14ILtNCE6gmyM0myP7wDmqwnZxhU0uRX0?=
 =?us-ascii?Q?HBnvcAnhtEQMa8v2Ta/Oh1k+Sna8BLWxzV51LyJReThXLvgREFNda5DfLCQw?=
 =?us-ascii?Q?l3JBtEarZv8zdn7ony5IfmT2eAvIUFcqZg7l7r5zjKTP6Cemx5za40ty0Zbq?=
 =?us-ascii?Q?vBi+DucksEujcQ3sUWUcrqFzEFrY6Qjlt/kj7D+VOftCuF2IaH3GPYfubhf2?=
 =?us-ascii?Q?X1FSSS/0hYLxWcpI2MdlwEODBqMFcl05h8h3ZfNuhcohpSgezrY/676nupS8?=
 =?us-ascii?Q?glEBiqaVIBuCYCG/PF+mpekVFRX4kPwzkv7soMpABEfTIslAA/LRyX/Hm76/?=
 =?us-ascii?Q?xarPraE2++86r+9JCj4t+TFYddQq9q8sPbg6R5YVOxC5zj7CKurQTbmkk7Bm?=
 =?us-ascii?Q?/WVJZbX6F15FeiwmO1iOLNQzMBWQQHs=3D?=
X-Exchange-RoutingPolicyChecked:
	2dK34IEhofkH+TlYMITppDjICOGVy/w1XOkxs4IEGM1/OfW9RSH5SzUO2D9/QE7ZTavDnw7aarKBLZF6zkM8M8xOPKESdvFye9OWhlOYsKStpWZyBmjoNrANWU/lDt8hEuhdszmcyw+xjLncng8a3UiEMxzjxu7l93KVbBkg72JUR0H71oAS/gFcF/AW1Sy6sV0NXmTc80LGYhHVJimceYi1K7CBtRzwi7S5Ji9CD3tQwP14XzyHLqKl6U2SGcQPlS02ifkbmnhfLrlDueNF6Uuo4jQ6dEMTDPovBcIkt8s0liqmdIK9OZfZOu0I41+QvovxVYbIw+J3iZE0OcnEKg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aNFgBDjIJI6GhU9dZhA38LGMPP0AwkP+SuHotLN+NgOb7+x0xTaTEZgse/fPxi1GCVsVOk/EGNW4bJeVH4UTK8HFjbuzqSZTBBPmhvazHkSti/38LoFA9na7Zl38niyfod51WUeUtQBQgr0mM+VqBvM+rfzJvdZInCYUGsS/d+DKY/ESJZQHj0BsUAVGXgFMP+lGT9lrZLvd8Sl/B2zpaDnGDn1qibBVmfG9wyNG7/SsP4oJ/cJcoU7lpCJR+pw9WFn9OMfa8qviA/87yj32M+Ul/HSHPrbgFaW+OGiOswX1zBtkA7KRZO6Cfd1TbnZUfqk+uRT1gPL/elEgL9Ce+OKUnBLcEhlk7nsCnGrMovhSkE13dq6nQCKFFm0+z0yWJJKXQm+ig1ux9G6qa3yVVSvkon/J3+PfQ+eNHYrqvHgKfXscfdcotVH3wjzI9lFm7SOPqZGsYDWISpv3mzeFlOrlXOLrnR7HXq2sBsXOetkSRPxl66UFHEb84ZdR5K+WYqU3iLzYlN8pEMVuQcX7V4Iq/v457pf0mAZ1VuLSprfAMBHCRoeLF/icUKyfCpIaiBahvFZYxpT8Rn6QCk5Q+yEz8Pqbs6LrT9XqeXRz7EE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bea14d1e-8c99-4c15-bce7-08df079dad8f
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 20:23:11.4401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f+X7wNRDyqbMB9KraJiK2SyPvcfw0VgG59dzuG4Nh3BxHAe5kRVo7NXPKs6nUIrfqn9buU72/a9fF55kMJiBUI9js+UyzvzwdRsnnYy0cy8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6179
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_06,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 mlxlogscore=999 lowpriorityscore=0 suspectscore=0 malwarescore=0
 spamscore=0 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2608310175
X-Proofpoint-GUID: wuRfSfQrxJ6tdtU4R4U5z-L63G7gPsL1
X-Proofpoint-ORIG-GUID: wuRfSfQrxJ6tdtU4R4U5z-L63G7gPsL1
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDE3NiBTYWx0ZWRfX9+xZQ+74+aSb
 MVuCB1A49BzYiQNS8sCv/08SMxni6Peu4W9scApj5AukY31CHuF4ipwxhscHB3NWmyvMitNoTcR
 6VYg0xXVzOarS4pfQJkywXyTfqeSrYb7IryKf71L8pBeflUZAHhN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDE3NiBTYWx0ZWRfX1lo9WGkyyS3w
 i7XS5ewZ+CYy6fr8hSEjqjyldoJnJC9GBrGIIjEOjnJITM5rXRsxWihVvuaLveREP8z6aH3afbj
 XzYon16nB8vqGkAbdHu8X3eYTuvQufX9JhXSj1q2P393Rcoe9UsCj13krpC9f6bdXWppkvIpihC
 h6mvOr0t/gqV8aVQrWq2GZqaYPzn0+S/yhuilyAJirvXEFzIOi5+akATTDQpJQFTurFq8sbwwrs
 LLSuVwlDyFevb+6722se7skt73AGvKETeoG0e5vvDGMO/Sf+UiGUX8vELRH9fp++fakOXQZu7S0
 hQmSYwZ21RisaB+gr+JvzssxM8hVMG5HNp8WRo5N9dDlcjA0daQsKnHNYc1AvrD7JSoFnixBLu9
 3zCjVCwz7d5U0u/H6Gnhkak/6gsHkH/8IcVE3fcLLS2MHqjkG/QnMjjJ2zMdHaOLGHLcb0s6HY3
 cLdMqaRmDgh/kgmNwJvb0VhIvQ5febLck9hbO2GE=
X-Authority-Analysis: v=2.4 cv=a9gAM0SF c=1 sm=1 tr=0 ts=6a95e2b7 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=pGLkceISAAAA:8
 a=7CQSdrXTAAAA:8 a=yPCof4ZbAAAA:8 a=RgR6v_fFY-8vhBXvnRcA:9
 a=1CNFftbPRP8L7MoqJWF3:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13521

Add atomic load wrappers, atomic_cond_read_*_timeout() and
atomic64_cond_read_*_timeout() for the cond-load timeout interfaces.

Also add a short description for the atomic_cond_read_{relaxed,acquire}(),
and the atomic_cond_read_{relaxed,acquire}_timeout() interfaces.

Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 Documentation/atomic_t.txt | 14 +++++++++-----
 include/linux/atomic.h     | 10 ++++++++++
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/Documentation/atomic_t.txt b/Documentation/atomic_t.txt
index bee3b1bca9a7..0e53f6ccb558 100644
--- a/Documentation/atomic_t.txt
+++ b/Documentation/atomic_t.txt
@@ -16,6 +16,10 @@ Non-RMW ops:
   atomic_read(), atomic_set()
   atomic_read_acquire(), atomic_set_release()
 
+Non-RMW, non-atomic_t ops:
+
+  atomic_cond_read_{relaxed,acquire}()
+  atomic_cond_read_{relaxed,acquire}_timeout()
 
 RMW atomic operations:
 
@@ -79,11 +83,11 @@ SEMANTICS
 
 Non-RMW ops:
 
-The non-RMW ops are (typically) regular LOADs and STOREs and are canonically
-implemented using READ_ONCE(), WRITE_ONCE(), smp_load_acquire() and
-smp_store_release() respectively. Therefore, if you find yourself only using
-the Non-RMW operations of atomic_t, you do not in fact need atomic_t at all
-and are doing it wrong.
+The non-RMW ops are (typically) regular, or conditional LOADs and STOREs and
+are canonically implemented using READ_ONCE(), WRITE_ONCE(),
+smp_load_acquire() and smp_store_release() respectively. Therefore, if you
+find yourself only using the Non-RMW operations of atomic_t, you do not in
+fact need atomic_t at all and are doing it wrong.
 
 A note for the implementation of atomic_set{}() is that it must not break the
 atomicity of the RMW ops. That is:
diff --git a/include/linux/atomic.h b/include/linux/atomic.h
index 8dd57c3a99e9..5bcb86e07784 100644
--- a/include/linux/atomic.h
+++ b/include/linux/atomic.h
@@ -31,6 +31,16 @@
 #define atomic64_cond_read_acquire(v, c) smp_cond_load_acquire(&(v)->counter, (c))
 #define atomic64_cond_read_relaxed(v, c) smp_cond_load_relaxed(&(v)->counter, (c))
 
+#define atomic_cond_read_acquire_timeout(v, c, e, t) \
+	smp_cond_load_acquire_timeout(&(v)->counter, (c), (e), (t))
+#define atomic_cond_read_relaxed_timeout(v, c, e, t) \
+	smp_cond_load_relaxed_timeout(&(v)->counter, (c), (e), (t))
+
+#define atomic64_cond_read_acquire_timeout(v, c, e, t) \
+	smp_cond_load_acquire_timeout(&(v)->counter, (c), (e), (t))
+#define atomic64_cond_read_relaxed_timeout(v, c, e, t) \
+	smp_cond_load_relaxed_timeout(&(v)->counter, (c), (e), (t))
+
 /*
  * The idea here is to build acquire/release variants by adding explicit
  * barriers on top of the relaxed variant. In the case where the relaxed
-- 
2.43.7

