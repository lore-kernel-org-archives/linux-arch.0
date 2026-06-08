Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0DF3A8752;
	Mon,  8 Jun 2026 08:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780905945; cv=fail; b=NKpMYShtA6Ujid2PquiZKAkob4kA52izNgNghMsQGL+Sq117nNvbzK+xrWfasnrXEgiWAzzQpsuwEJCQfeD6SATDPgVRcVDJhDMCAYhqZw2mFDK0jYVHOZ+dVUoPAbu7oEdFi/1p9dKwDzpR0a8piVEf7F6ioNtMpKk/obTG7LQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780905945; c=relaxed/simple;
	bh=iztq23qAUdnLc/4m3dpiBvOca0eJFYX4D2AE6+uAzCU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=XpQfeeCa4ibDT6x+ReJz6AAAJZY0CLOAipr0t16pxZASt079BJzzhVq63QhN2R5W+NYUf65IftawftHlPAhbmtIuxLBKGgSOQlRXJhQbl73YOG6CzBwn8toACvaGXF+fD4dde1LcziioYIa+htE0tu1iD+7A79o/Z6gLBT5z7xs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pbhdGK8/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OBwHTdtw; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pbhdGK8/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OBwHTdtw"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6580BCbi3969311;
	Mon, 8 Jun 2026 08:04:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=QsFRb26iPRrAbHHN
	vUmMfIft3sszjCJW+cbYh7ppWuU=; b=pbhdGK8/RfiE4bxCtS9oatVFigecLFRu
	3BKjGp8WJK8yEn61bdIezk6hcqG7T83Cqed0yTeDmlog6h46UEapXt2L321/OQY0
	FhwCGGoOXDFxA6KyQPoodtYf0LeuN7k4tysCRi5ycr/xOEkPjj1QbbUuogu5mhzw
	4ONNaOnyGSJuw+TAjJbW2U6nCvDH2wDuvEo6BL5kxATqrGzZLff1whhJAyH2FD84
	1zCu6hppj3hApVup3+GRzsn9L2S2Em8uNsW867NSZ7dviNRK2mzY/T39sR3gTs9t
	uvDwFx6CHwfmam6ysRqCCe0730YoDPhhhSc3Ac0elLP0nuBMGcwRzQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4emb5st0er-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jun 2026 08:04:49 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 6587wTYg005906;
	Mon, 8 Jun 2026 08:04:49 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010026.outbound.protection.outlook.com [52.101.85.26])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ema0ngg41-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jun 2026 08:04:49 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YdQMzYa+r28KKFZ6ySUGLvSuV2hOBezwUgtmTh020kq8hunklmWEMAKwxK1Lo1AAGaWvwUiKfWzInkmss4Ejxu9iZ4S0GSgJ9Ui6Yi8ynIH+GtwHrR0alqbYLm9hB0anPAtk9aAFXqkc3G5qcyPW/OWYlsufQXwng4G+fUbUle/NjoHOnPrIlV34D8vFZ3M/xWB7EBHNHWAGDcUHMucvjcXBDUNswKRvkxClVm+0jB7/jNGbWG1jdNBtKz23Kv9r8hbpjyduYjkNRIgWV5m1sMPK5UJPc0idmj2spG2Nza5CyhLmimAxvRS3lU1juzsLmkd0lw56swY59ekUe5AaXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QsFRb26iPRrAbHHNvUmMfIft3sszjCJW+cbYh7ppWuU=;
 b=Q9meuGxs0oECUZR+6qbQh/HekqBpPWbNsiZB10FP1XAGLpBOewNN9Q4N+GVMZZmJN1GEk2yIevm7bDF+ZGHcAo+zmE+eiJ8BihJIRGL1kIhUtEKgGKgXLFRe0GXnM0QlGFa2JN72+ToON7pqcHHe39oqFMptsiWqJGlngjMIHUyhbAFs0kD4zIVSCd2qLM49FYu/RB6L8kB5O+0weOlnhCzia5y3B8eEu/oULdGNN+HMNX5LgLL4FwYRBvyhKeUIkYqvz9dD3BFT0qrEOGWIJtgicAEweRp75yTBQ9I3GU0+Xio2FhM6NSsnzHj0f78+9g1JROpYHL0d93U8R/olOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QsFRb26iPRrAbHHNvUmMfIft3sszjCJW+cbYh7ppWuU=;
 b=OBwHTdtwUs0RPJQRNrChdgDyLxSNzYH0uUaj5hSbxXvN4RnSNVbFG8sRZD3U9OuftYnJlQyrDeV/wBdf7kbo4tkv3qUAAXNXiyOg/7ROfnAFv8cGuuPUeqXJ4iDtJsJ/pFsVGaeP6KJLys9QMYrlUKTMk8cVxTkk1M9wuHKvHiI=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SA6PR10MB8133.namprd10.prod.outlook.com (2603:10b6:806:436::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Mon, 8 Jun 2026
 08:04:43 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 08:04:43 +0000
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
        Ankur Arora <ankur.a.arora@oracle.com>
Subject: [PATCH v12 00/15] barrier: Add smp_cond_load_{relaxed,acquire}_timeout()
Date: Mon,  8 Jun 2026 01:04:25 -0700
Message-Id: <20260608080440.127491-1-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0085.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::16) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SA6PR10MB8133:EE_
X-MS-Office365-Filtering-Correlation-Id: 97528eac-b7b9-4a95-c32f-08dec5349937
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|6133799003|13003099007|18002099003|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info:
	pe9fncu7Po7KfuHW/PLybz4T8XAIOpRrE/KSgs6RU6vfNqxZBBWupKFRCSV/cdVsxzuAOi1iYQD+9ZCiUKq5TewJeZokZ6i29bzrXuFUPOCUYsjkNYG4OXUkIrcAfsSlTu/OxCVNn4RurjVlPEB9qgZB018Sgd8hSxTo8cEbFizf58Rk5rJ7vmGwPaSaUoMIWhcb41blr1U4a951JbNjEhNzgMsqzD+MRL9xa+g33B6NaJO+v4dEV6VK9zZnKPTGpU6oZyXLikzYBuTXXgIf8GouYGyoS71AusLz5qtegw/I9YU1eK+BI3eIGF/PE+fQpgutY6ZmDeo9ycigTHkLKEHtlUMAfxmqMbfXahjzlSRH6jk0Aq+kBxx29SaYAuVs7fD0zUzDqd50PyffyPtauMiUGx7GXrYLHGytQ4zpZKyhlOStGKYmBKelCObYa4VFOF0xpN74laRu8BPXKXwYLdfwtsomiz7Ak3WQNiH35wfNZXpJSGFJwor5xeB9ydCFqVNJpWHT077RnGnpPSMfSkoA4rTeE0biH0KRhkiWIjJOwaXZl5KXaJwrcWX4zjyFYXtq05A/AP3HwUN7IA/YcvDvJx4y/TB6ZgaJ+xP7+HfkxkAl1O9t16OBGrqGEvlAWNYMH/EQIMoFW0VukXdLXvQHtNMq9uyxAjOFc1r8LXIbYzEocqYYsc2DFHgNQ8SEv8johxPitY1LUF38KxaMsg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(6133799003)(13003099007)(18002099003)(3023799007)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1yvFsOcWjapEzsRLzf2yxePq46eYG4nZZHOPzFSOk2sZh68aMOyv6VR8ydKN?=
 =?us-ascii?Q?sUkCmUp2tdr1n4QN1NUHf0elBBx270AxQ9BxI1i2IiMYU+zbpHij1e/418Ut?=
 =?us-ascii?Q?LhxH3+qF2D8b2Sp5GFjRv8f4TfCSzd9FvA8J7QPgXhG+KKyMzjQtiEUxDrnA?=
 =?us-ascii?Q?p+vfxaGM/DW9otS6Yl0IWuf4cusCtI44guhnX5xljaaXRa8VVPhCoUwg+6au?=
 =?us-ascii?Q?8kTbU4fuM4VyeF6wFiY1Gv2+97hTs034vcWlvXohiTJPwNB9FKVR+PuaUL1T?=
 =?us-ascii?Q?P1c5nraR6+NNsaUr7WBJB7Z1EKkb3kkOsFgN4y17bzc0bGne8eR9e94STcX6?=
 =?us-ascii?Q?Bt9kTGD1tPUMeau/HIVlrc3eeGokQmw7KN1uGshPepLGyh9xEfM1KJ0hYt8c?=
 =?us-ascii?Q?qf/Q5bELY0sRJNkFl9poU3R/+lGbjB/4FjOP8Oqqf6fu24Tem8CvEyHUxjoP?=
 =?us-ascii?Q?ZJeoediluQ+JB1qVWqcP04nDL1XyJZ2Q4g5yV7Jfa/cfg6VGy+BmFlEmY7mo?=
 =?us-ascii?Q?icVA9oUf1T3//xYGdFz6SzHblpS0g6G+m1HL2X1lcXYwE+b3GhDgBq+I6554?=
 =?us-ascii?Q?y+RG4w1cupWdl9Ts0nZi/Z+4B/Gj9JSVzLsrs7gcLYNnsc8HYz/MxZ9DJ3Jn?=
 =?us-ascii?Q?+CKv6qcXdqkPp/Q1osbmv9MVhkRfWBunvcdBuHPOUeUxsXOqTq1qZIjwEpfr?=
 =?us-ascii?Q?QOmJLUgU5n4cb38bI3XNsneSQNiiCuP02lsWoLRSIt49oNzeHfDiuMB/JeZF?=
 =?us-ascii?Q?h85d69IIyH7pFR5ljBTK0d+3wpoaUMNebvQydKav6X2zFb+F/fHecWPEq3vH?=
 =?us-ascii?Q?7y/kpREdTj0yqUmv/nWHsgD87Q0/u2yp7QpAoxPF7phXkC+RQZIZ5jAUIgjW?=
 =?us-ascii?Q?NtTXrQ8hzJxZjChikp5GOyE5klI+1AFssNJuXpyt6+A7cqrdifmPOxsbYhG+?=
 =?us-ascii?Q?3pFgbKP/K5X8NAeBZvdY+e8WyCgDfjBHZ6iMMUjtwW568lDAnqOXPIJGpcHC?=
 =?us-ascii?Q?uzrMEIW2UoZCKE1cajEd+vUHYvMWSq+4Pf76pfyuXKSa6lDjjMM0oom7mcz6?=
 =?us-ascii?Q?ldS78j20avrP+6rPE+MZc1o1/EIZPCYf8SmHKz1o/xSsMCSWKRJxuPTecrt3?=
 =?us-ascii?Q?uxPtfmUcDfHFZtaMGlISMLwpC2guoe/uXDpjb7PORbV10XtOrP5B+claDmCF?=
 =?us-ascii?Q?BluWBiWc72W5nH2Pt11sNSJH9vzJS2MRM0lU2SyP3647hZVXc8+BxzRAmAh0?=
 =?us-ascii?Q?oPS6FsaEq+ru+lzCr5OUQXpM4K3fLeVVgstvkxAGavsxVuqu09zFq86dClM5?=
 =?us-ascii?Q?WOnl/sHzzIsry+SDTt2GS55FExx/H6h59K+VjfOevezCMlJl4rkEf2FSdc6Y?=
 =?us-ascii?Q?PcfTwlVo15heJzZf1EZVzDpgCxGaAJ2cgQwY6TnwNNvCp/SsfpLVNjSYr1l/?=
 =?us-ascii?Q?57U2BvaNOqGyp9pIiC17w6ja0kV64yB20TwuJOBCSxefjoWxaihrdJIaST+b?=
 =?us-ascii?Q?pQaOt01EmC4BVhOKS+o7THE2Y5cnzs2QWuQBu1i9k91SUz05P7gdY+XWZogI?=
 =?us-ascii?Q?cDwm/iQIM0xm6wMPxeOHX0wn1JNJsajpWw/ME6KWOVGSTNJsMIHBN2aMxMim?=
 =?us-ascii?Q?e5/Vy7ANeVh8TFICAnerxpjx6mGt7PmSTXS/iKbMD+lua5YnSXgvKCBp1SMy?=
 =?us-ascii?Q?fjo+/cDSmhs3uGmJMFppNI4ykO/xRF3jdJ2KIwBAmGb8FcC1JIAIbqMLaU1A?=
 =?us-ascii?Q?F8Db2VeHgR1mYnRTD2xgEeDE0ni3Fyc=3D?=
X-Exchange-RoutingPolicyChecked:
	ncYNb5LfKnEACBjqSksKVYuBFXxgxawgjzgiE7n+8zrJiX3c5vNQIA+xmqd1yA93i8r4V4QSRPx/N4YKYN1Zl97I0eIlfy8+ghAdWrJZQl5UZet4m31lZFpn5wAyoZoZqT5+qwb2gArXmJpJVCnN+GYJAEGu6+Gc3Hxplued9H2LtDOOaMuQJL/YwCVsLippEUYVLo/XGU/EtyUHSezlNKOd9IBjQjbongT8zOg3lozIR1ejrukJij8+HMX61OLvQcoFaHyZmQAQNiFnXPasVe1D39+ujZeLie2fbQX91fJvVc/tXJsRFzMaNy4bqNBMD4ZgjdGl8YctZwB2Z2l5Kw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xEdsEu2iR1QxAoyTYQu03in/JPx4NEoXYV0anHQ8LMJFbrko7xl3ZPHrjjYT2lQMnFpNSyXthnO1HqQcfl3zH6JxIRKv4sjaFdzjtFQ6c+3bmwsUcjWudSC9u8oj0IokFU9xrFemfHnCqNKS/b/V7/h+1ohCq0mAcBExufpqznZ/qAO0wIkIukmSpB6GDbWYCFTiKbyeWslQuq2hKJMUVM/+HdLhll4XyRZjxvvlkGLj1UjI5Q66D+EZLTgu2gzB9gd2M+VVfDiNqeMlB0N0ZArS2B6MF7fOD2QVZ3hUtcUFM8Oc5eRvhEbnE1SzMm+slkA2yGsEOwal+/l4QfdKSMwJAe30Wwx3t0DCsOFf5VJD4PQAmv3ABR6GCvrqEMuluBFINSmOvVsON3fR/Kx7R3tuKMNfIDRn8fqRM9jQnBk+yoP/ISKFaqP1JfdUHejEM+cESW5ndOKaQp88rzQqm7/1IdfUdkTxOKJCC+bfFHpKpKtUFVDqEsZ2LhY7mejyUmXlK4HpdlIVHeohoatnHGuoc4P5hFeiPpW8YBX/pQIadLbpYfT679edspeSktmILFW80gZTDUPOkW117gcGd8f798/klvbJ+FsrY+KqHr4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97528eac-b7b9-4a95-c32f-08dec5349937
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 08:04:43.5001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JLVMywp8KdVOOeO7trzdDUbkk3XVq06GOkyU+GEOhgLlONdjZ3GKQ+T4EQTihw/LZeLMaJLXpMqw8nJlhq1z/OGQPZOvXqZRKHGY1v/6eic=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8133
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 adultscore=0 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2605130000 definitions=main-2606080073
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA3NCBTYWx0ZWRfXyJr3zh3HSFUD
 kBB0wJGWtH/c+6BROLi3MB4S5dN5evmoaXzOjPC1+i2xCP3D6cNhnNgbfh6CA1aOzxnWaa9YsGK
 EpicQSP6JVhjn0pk6ycjPjRj1il/2ZUyi+c7BYkQq1el2RRCqalhx6V8XtzNMw8ER9eWfbdh5oY
 XTWezdk4FghRp0HIo2skzTOndyqwqxX8xmE0+bDBnkTlIf/STIygcI+1AN21Iz+FLpYSF1GMpFz
 pW6cYPQ9YrM/xGPpLXfgWcS0MtN014fNYFmKn0kAjsUt4nUEAgvXFFtSOTT15ciQC8HO9fm/oxE
 jkRIExczoWwIrXAZsHuauVR8jsJn1CG2hkhYNWIk8TrE+HrnnBuUXADA+5+DLHX713j3tzzRJlN
 4y7ojRHZCUIIUFcPPeG2L4PGlc+S8T3wZtPLSHXySNYPlcdOpxl5upPpvyzr/y7KJWZIOFWsnSA
 bw9G2F3HAAnHdqmueqkK5m4kFPIgN+f6fzhwu7/I=
X-Authority-Analysis: v=2.4 cv=XeC5Co55 c=1 sm=1 tr=0 ts=6a2677a1 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=FelO9ux0wxsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=vggBfdFIAAAA:8
 a=WsHKUha7AAAA:8 a=7CQSdrXTAAAA:8 a=JfrnYn6hAAAA:8 a=KKAkSRfTAAAA:8
 a=pGLkceISAAAA:8 a=Z4Rwk6OoAAAA:8 a=d51sq9AK_VdvhGiElO4A:9
 a=H4LAKuo8djmI0KOkngUh:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=1CNFftbPRP8L7MoqJWF3:22
 a=cvBusfyB2V15izCimMoJ:22 a=HkZW87K1Qel5hWWM3VKY:22 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13723
X-Proofpoint-ORIG-GUID: 8J-o8mOd4Y7pNi5-weGpE1z1shrlKODI
X-Proofpoint-GUID: 8J-o8mOd4Y7pNi5-weGpE1z1shrlKODI

Hi,

Main change in this version:

  - addressed some review comments from sashiko (see commit notes)
    - The one notable change is to the implementation of
      smp_cond_load_acquire_timeout() where there was a missed
      control dependency in the timeout case.
      All the others are minor.
  - fixed a low probability race in the kunit test added in v11.
  - added a bunch of kunit tests validating the implementation's
    use of the clock.

Andrew, if the changes look okay, could we take this in your mm-nomm
tree as before?

The core kernel often uses smp_cond_load_{relaxed,acquire}() to spin
on condition variables with architectural primitives used to avoid
hammering the relevant cachelines.

(This primitive can vary greatly across architectures: on x86 it's a
cpu_relax() to slow down the pipeline. On arm64, this is a __cmpwait()
which waits for a cacheline to change state in a time limited fashion.)

Regardless of architectural details, typical smp_cond_load*() usage
does not allow for termination until the condition change occurs.

Beyond the core kernel, there are cases where it is useful to additionally
terminate on a timeout. Two cases:

  - cpuidle poll_idle(): wait for need-resched until the cpuidle polling
    duration expires.

  - rqspinlock: nested qspinlock acquisition that terminates on timeout
    or deadlock.

Accordingly add two interfaces (with their generic and arm64 specific
implementations):

   smp_cond_load_relaxed_timeout(ptr, cond_expr, time_expr, timeout)
   smp_cond_load_acquire_timeout(ptr, cond_expr, time_expr, timeout)

Also add tif_need_resched_relaxed_wait() which wraps the polling
pattern and its scheduler specific details in poll_idle().
In addition add atomic_cond_read_*_timeout(),
atomic64_cond_read_*_timeout(), and atomic_long wrappers.

Structurally, both the smp_cond_load_*_timeout() interfaces are similar
to smp_cond_load*(), with the addition of a rate-limited time-check.

Usage
==

These interfaces drop straight-forwardly into the rqspinlock logic
since qspinlock already uses smp_cond_load*(), and the time-check
extension can now be used for timeout and deadlock handling.

Using tif_need_resched_relaxed_wait() in poll_idle() removes any
architectural details allowing arm64 to straight-forwardly support
that path.
(However, for efficiency reasons cpuidle/poll_state.c continues to
depend on ARCH_HAS_CPU_RELAX since that is defined on architectures
with an optimized architectural primitive.)


Performance
==

Apart from simplifications due to this change, supporting polling in
cpuidle on arm64 helps improve wakeup latency (needs a few cpuidle/acpi
patches):


  # perf stat -r 5 --cpu 4,5 -e task-clock,cycles,instructions,sched:sched_wake_idle_without_ipi \
  perf bench sched pipe -l 1000000 -c 4

  # No haltpoll (and, no TIF_POLLING_NRFLAG):

  Performance counter stats for 'CPU(s) 4,5' (5 runs):

         25,229.57 msec task-clock                       #    2.000 CPUs utilized               ( +-  7.75% )
    45,821,250,284      cycles                           #    1.816 GHz                         ( +- 10.07% )
    26,557,496,665      instructions                     #    0.58  insn per cycle              ( +-  0.21% )
                 0      sched:sched_wake_idle_without_ipi #    0.000 /sec

       12.615 +- 0.977 seconds time elapsed  ( +-  7.75% )


  # Haltpoll:

  Performance counter stats for 'CPU(s) 4,5' (5 runs):

         15,131.58 msec task-clock                       #    2.000 CPUs utilized               ( +- 10.00% )
    34,158,188,839      cycles                           #    2.257 GHz                         ( +-  6.91% )
    20,824,950,916      instructions                     #    0.61  insn per cycle              ( +-  0.09% )
         1,983,822      sched:sched_wake_idle_without_ipi #  131.105 K/sec                       ( +-  0.78% )

        7.566 +- 0.756 seconds time elapsed  ( +- 10.00% )

  We get improved latency because we don't switch in and out of a
  deeper sleep state or from the hypervisor. This also causes us to
  execute ~20% fewer instructions.


Haris Okanovic also saw improvement in real workloads due to the
cpuidle changes: "observed 4-6% improvements in memcahed, cassandra,
mysql, and postgresql under certain loads. Other applications likely
benefit too." [12]


Changelog:
  v11 [13] (as listed above):
    - addressed some review comments from sashiko (see commit notes)
      - The one notable change is to the implementation of
        smp_cond_load_acquire_timeout() where there was a missed
        control dependency in the timeout case.
      All the others are minor.
    - fixed a low probability race in the kunit test added in v11.
    - added a bunch of kunit tests validating the implementation's
      use of the clock.

  v10 [10]:
   - add a comment mentioning that smp_cond_load_relaxed_timeout() might
     be using architectural primitives that don't support MMIO.
     (David Laight, Catalin Marinas)
   - added a kunit test for smp_cond_load_relaxed_timeout() (Andrew
     Morton.)

  v9 [9]:
   - s/@cond/@cond_expr/ (Randy Dunlap)
   - Clarify that SMP_TIMEOUT_POLL_COUNT is only around memory
     addresses. (David Laight)
   - Add the missing config ARCH_HAS_CPU_RELAX in arch/arm64/Kconfig.
     (Catalin Marinas).
   - Switch to arch_counter_get_cntvct_stable() (via __delay_cycles())
     in the cmpwait path instead of using arch_timer_read_counter().
     (Catalin Marinas)

  v8 [0]:
   - Defer evaluation of @time_expr_ns to when we hit the slowpath.
      (comment from Alexei Starovoitov).

   - Mention that cpu_poll_relax() is better than raw CPU polling
     only where ARCH_HAS_CPU_RELAX is defined.
     - also define ARCH_HAS_CPU_RELAX for arm64.
      (Came out of a discussion with Will Deacon.)

   - Split out WFET and WFE handling. I was doing both of these
     in a common handler.
     (From Will Deacon and in an earlier revision by Catalin Marinas.)

   - Add mentions of atomic_cond_read_{relaxed,acquire}(),
     atomic_cond_read_{relaxed,acquire}_timeout() in
     Documentation/atomic_t.txt.

   - Use the BIT() macro to do the checking in tif_bitset_relaxed_wait().

   - Cleanup unnecessary assignments, casts etc in poll_idle().
     (From Rafael Wysocki.)

   - Fixup warnings from kernel build robot


  v7 [1]:
   - change the interface to separately provide the timeout. This is
     useful for supporting WFET and similar primitives which can do
     timed waiting (suggested by Arnd Bergmann).

   - Adapting rqspinlock code to this changed interface also
     necessitated allowing time_expr to fail.
   - rqspinlock changes to adapt to the new smp_cond_load_acquire_timeout().

   - add WFET support (suggested by Arnd Bergmann).
   - add support for atomic-long wrappers.
   - add a new scheduler interface tif_need_resched_relaxed_wait() which
     encapsulates the polling logic used by poll_idle().
     - interface suggested by (Rafael J. Wysocki).


  v6 [2]:
   - fixup missing timeout parameters in atomic64_cond_read_*_timeout()
   - remove a race between setting of TIF_NEED_RESCHED and the call to
     smp_cond_load_relaxed_timeout(). This would mean that dev->poll_time_limit
     would be set even if we hadn't spent any time waiting.
     (The original check compared against local_clock(), which would have been
     fine, but I was instead using a cheaper check against _TIF_NEED_RESCHED.)
   (Both from meta-CI bot)


  v5 [3]:
   - use cpu_poll_relax() instead of cpu_relax().
   - instead of defining an arm64 specific
     smp_cond_load_relaxed_timeout(), just define the appropriate
     cpu_poll_relax().
   - re-read the target pointer when we exit due to the time-check.
   - s/SMP_TIMEOUT_SPIN_COUNT/SMP_TIMEOUT_POLL_COUNT/
   (Suggested by Will Deacon)

   - add atomic_cond_read_*_timeout() and atomic64_cond_read_*_timeout()
     interfaces.
   - rqspinlock: use atomic_cond_read_acquire_timeout().
   - cpuidle: use smp_cond_load_relaxed_tiemout() for polling.
   (Suggested by Catalin Marinas)

   - rqspinlock: define SMP_TIMEOUT_POLL_COUNT to be 16k for non arm64


  v4 [4]:
    - naming change 's/timewait/timeout/'
    - resilient spinlocks: get rid of res_smp_cond_load_acquire_waiting()
      and fixup use of RES_CHECK_TIMEOUT().
    (Both suggested by Catalin Marinas)

  v3 [5]:
    - further interface simplifications (suggested by Catalin Marinas)

  v2 [6]:
    - simplified the interface (suggested by Catalin Marinas)
       - get rid of wait_policy, and a multitude of constants
       - adds a slack parameter
      This helped remove a fair amount of duplicated code duplication and in
      hindsight unnecessary constants.

  v1 [7]:
     - add wait_policy (coarse and fine)
     - derive spin-count etc at runtime instead of using arbitrary
       constants.

Haris Okanovic tested v4 of this series with poll_idle()/haltpoll patches. [8]

Comments appreciated!

Thanks
Ankur

 [0] https://lore.kernel.org/lkml/20251215044919.460086-1-ankur.a.arora@oracle.com/
 [1] https://lore.kernel.org/lkml/20251028053136.692462-1-ankur.a.arora@oracle.com/
 [2] https://lore.kernel.org/lkml/20250911034655.3916002-1-ankur.a.arora@oracle.com/
 [3] https://lore.kernel.org/lkml/20250911034655.3916002-1-ankur.a.arora@oracle.com/
 [4] https://lore.kernel.org/lkml/20250829080735.3598416-1-ankur.a.arora@oracle.com/
 [5] https://lore.kernel.org/lkml/20250627044805.945491-1-ankur.a.arora@oracle.com/
 [6] https://lore.kernel.org/lkml/20250502085223.1316925-1-ankur.a.arora@oracle.com/
 [7] https://lore.kernel.org/lkml/20250203214911.898276-1-ankur.a.arora@oracle.com/
 [8] https://lore.kernel.org/lkml/2cecbf7fb23ee83a4ce027e1be3f46f97efd585c.camel@amazon.com/
 [9] https://lore.kernel.org/lkml/20260209023153.2661784-1-ankur.a.arora@oracle.com/
 [10] https://lore.kernel.org/lkml/20260316013651.3225328-1-ankur.a.arora@oracle.com/
 [11] https://lore.kernel.org/lkml/20230809134837.GM212435@hirez.programming.kicks-ass.net/
 [12] https://lore.kernel.org/lkml/c6f3c8d3f1f2e89a9dc7ae22482973b5a51b08cb.camel@amazon.com/

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: bpf@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-pm@vger.kernel.org

Ankur Arora (15):
  asm-generic: barrier: Add smp_cond_load_relaxed_timeout()
  arm64: barrier: Support smp_cond_load_relaxed_timeout()
  arm64/delay: move some constants out to a separate header
  arm64: support WFET in smp_cond_load_relaxed_timeout()
  arm64: rqspinlock: Remove private copy of
    smp_cond_load_acquire_timewait()
  asm-generic: barrier: Add smp_cond_load_acquire_timeout()
  atomic: Add atomic_cond_read_*_timeout()
  locking/atomic: scripts: build atomic_long_cond_read_*_timeout()
  bpf/rqspinlock: switch check_timeout() to a clock interface
  bpf/rqspinlock: Use smp_cond_load_acquire_timeout()
  sched: add need-resched timed wait interface
  cpuidle/poll_state: Wait for need-resched via
    tif_need_resched_relaxed_wait()
  arm64/delay: enable testing smp_cond_load_relaxed_timeout()
  barrier: add tests for smp_cond_load_*_timeout()
  barrier: add clock tests for smp_cond_load_relaxed_timeout()

 Documentation/atomic_t.txt           |  14 +-
 arch/arm64/Kconfig                   |   3 +
 arch/arm64/include/asm/barrier.h     |  23 ++++
 arch/arm64/include/asm/cmpxchg.h     |  62 +++++++--
 arch/arm64/include/asm/delay-const.h |  28 ++++
 arch/arm64/include/asm/rqspinlock.h  |  85 ------------
 arch/arm64/lib/delay.c               |  17 +--
 drivers/clocksource/arm_arch_timer.c |   2 +
 drivers/cpuidle/poll_state.c         |  21 +--
 drivers/soc/qcom/rpmh-rsc.c          |   8 +-
 include/asm-generic/barrier.h        |  97 ++++++++++++++
 include/linux/atomic.h               |  10 ++
 include/linux/atomic/atomic-long.h   |  18 ++-
 include/linux/sched/idle.h           |  29 +++++
 kernel/bpf/rqspinlock.c              |  77 +++++++----
 lib/Kconfig.debug                    |  10 ++
 lib/tests/Makefile                   |   1 +
 lib/tests/barrier-timeout-test.c     | 185 +++++++++++++++++++++++++++
 scripts/atomic/gen-atomic-long.sh    |  16 ++-
 19 files changed, 528 insertions(+), 178 deletions(-)
 create mode 100644 arch/arm64/include/asm/delay-const.h
 create mode 100644 lib/tests/barrier-timeout-test.c

-- 
2.31.1

