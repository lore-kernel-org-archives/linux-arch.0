Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00A63F0AA6;
	Tue, 14 Jul 2026 07:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784014332; cv=fail; b=tX2MiNIMqmzmhWk/RqbghjP68MQCqhivdt4sjjbtxozIqvqj9riUeozlghDbkXBDzwlbUUOUJ+uVvFaCefRlhDGWOduEMrRWr2i5gFuGpLKlgLqNpFzi/IkGUHO8CEmnZxh4LYhfbIbzQ3wZSZtkoxwbFSW3DsP3Wui9JD3AVQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784014332; c=relaxed/simple;
	bh=OGgZFOJnEFXL2DxEhblWZm+ihjvmCsHzXw+FF5ZdFAE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IcxfPr+dHZmMXSA63FalmChcQ3gyiJ5gsWH+tJCQUFN7Yn+f76/FIlawzf1xOyLWULrTmB9bhRYvbtgU9tAJmX8/yAuvEs5ZdhlfZKU+ATkfXtASHZWsdoT5UwGmrW8AqscTqzg0LpdA9qD2JWIKKrJqVEdbB2DLmd90/lOqb7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Pmv1qmdf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gzMQDuh5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Pmv1qmdf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gzMQDuh5"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66E0fn0c2668378;
	Tue, 14 Jul 2026 07:31:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=OeHj89SpsumH2DaeSYcLq/KfrJphpYP5mF6B1d1qsLk=; b=
	Pmv1qmdfQjc8clrwHSQOl5ahqRUvXjKtHhfgch6t2S19FXst8KLbGWLY+OwI6/fl
	qwP+A71e5oWAReP/XKW8G3pZbye9bM0RGFf7ziU04xTqCPmQuRyF7bc8j2iRJ1o+
	R4IhfAbJFudNkeTrE5nouLSBgXHme7pyHDEwSF0j2OPa0kDn+ElIeVaINUkl0v65
	4anDDMRcWUEHTs1Dc3lftDv+ubRcg9+u5lOOlfoJihl0IaJ/4y5yreiugvmJele1
	L5nmlZ8nQ/ESVNzcazWsMYCJJO5+5d3pGqaFkbqWdnqfyJYNAqGhDyWW57kM+Cdl
	9AlSdXzvXz3MZoqyVcETOA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fben1kmub-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jul 2026 07:31:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66E7I0h3016738;
	Tue, 14 Jul 2026 07:31:26 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012053.outbound.protection.outlook.com [40.93.195.53])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4fbc9dvk1b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 14 Jul 2026 07:31:26 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YX73q4HjsXZlj/qXp3u/QMZrHGF/XkBJkTlmUw5x+xPmUTuhKlITMaUjYLX5rCdbdduiSUsS4LzY0KaMDg+h6fImn5f3PmNgKTRlKosmBWQItNSm3Sg8qnHNJGBJVH+RY1PWEW0QLmY4nNqSbYjnI6+Q2eUyU2W5VN3PrDHkJ5jHTqbC04J45Q1IOzAyom+J8u2mA2i5/pC6VWf4RqGHtPFTx5tflE+9oi5TcO98BWRMY25U46/WTuLmNGTMbR3QGfKF6T6HDkoZynfOYHctAZPGLVvOquo2hpoW/JxYg5sizyTaWTFD8empsmmrxGERaoUo1/2L8L8Wg2IoH3Ayig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OeHj89SpsumH2DaeSYcLq/KfrJphpYP5mF6B1d1qsLk=;
 b=a1uFX5/0JFd34OR9k3JDh4gNcPLAE8aO6FiZNPaR7ZMQXbU6ttk3xtKcqTHFlIA4Y8shCQZBhSelnPuTzTRdSerUHs0CSy5axCUNC9RistYj7dzCwhs7H5BsgijoNODjqsrKm8m6zg7AZzFO/ZXej343qEkaAU4HPUMlhaSQ280yPAS1ZdlcJQU6XBrORerKy+LG976K74l85r3sV1vOxVT/o+AMgGtWKQ/L3MD07cBX4DNWD6qWCFP29jhjj1+2clg7lqnWh3luyeFyjQ/2fTRjIYFQBU2SuKYjph0s8zPb51Hy69yN1DS4uTvHzTd05QOnY1B0HVROyiJhkgBFMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OeHj89SpsumH2DaeSYcLq/KfrJphpYP5mF6B1d1qsLk=;
 b=gzMQDuh5oq4x00rJnyOl1ZQ5nPfwuAwlhDqwIrpoBmO3/wu9kWEs9Vrli0SltQdA067lf6ddol2FUSxirc08lZ8B4n7s0EcaIHYVTDcfi7n7bT//7rO2S4iauO1+SxFpwKHkOmaYRrqwuvpFTI/V8oN4FNHNb6i7Yq6lRItilzQ=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CY5PR10MB6262.namprd10.prod.outlook.com (2603:10b6:930:42::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Tue, 14 Jul
 2026 07:31:20 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.21.0202.018; Tue, 14 Jul 2026
 07:31:20 +0000
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
Subject: [PATCH v14 10/15] bpf/rqspinlock: Use smp_cond_load_acquire_timeout()
Date: Tue, 14 Jul 2026 00:30:36 -0700
Message-Id: <20260714073041.40250-11-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260714073041.40250-1-ankur.a.arora@oracle.com>
References: <20260714073041.40250-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0158.namprd04.prod.outlook.com
 (2603:10b6:303:85::13) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CY5PR10MB6262:EE_
X-MS-Office365-Filtering-Correlation-Id: 250c6a72-b256-477e-f7e0-08dee179e60d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|366016|1800799024|3023799007|22082099003|18002099003|56012099006|6133799003|5023799004;
X-Microsoft-Antispam-Message-Info:
	rtBwMEFhuyMkhObhwUlWSEz63skqyfUSidPJepGs5hidJBspz15y+dCt0jSBIs6YUCDQOKZx0/pe6ju3bjCC5saivXdD85qMkgjQ2mWIllqvnI5zdOvaOoWTY9a6+gdHX1c9wybod8iShe72EnNLEHN9A+qiDD7KUE8RKFwAtoaRbpBLM+Zz4OITLZ8q618fU1aOtTHShxXdP1GI5XDxvmNEhdSZsw56VmRh3P5DQhK3jzpzs5QyagdpHQnb3qUICD4HtAefkav4aJ8InmZlJBiTIPcCxHrtN+RMm66MNnvkv2w+SYfu2aXyeGRxQunx1KzFDN9/gia4BW/iaj4gkJq+1UEVhPHPmIPksYhBp/19o7uBfXY6JoAXZODeqN/kTFSnXCoVXvTQApBdQ/fQgzeLrksuXGpwycWXZJG2tSoGHLpkbRep8W8LxhLntQCPQPITMXT4hiz16IMN7ErDC6GeBLZAsS6utse5LDIA7m81DVIXcyQt0jsMcANKa5c2+AX02ar6DjTWwjqbudvme+54ZmO9AJfNURnKFzQY+6U7i4U0eS06biTEhaJOWq+IHsB5ppyCQaaqQVzi6+DUhtXqVi9Rd0+usnn0+zC69OMz5qqIuvz/5X/3EvjwPdeHvPJBAXawvReQcabpyaLVUxNsAVpNWjaOF43Vc/PeugM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(366016)(1800799024)(3023799007)(22082099003)(18002099003)(56012099006)(6133799003)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J/dpbfPIgVC2XjIc9Mmr49cgkEBssLAFLJDyq51cXQVdP+wr8vTNKqIGhDNn?=
 =?us-ascii?Q?PaKkI0F4/ZAcT9kKCTRb0LBT5Xr0E6Ps8SciJGMb8Mg+0lOa54hZyPaNMbl4?=
 =?us-ascii?Q?WwDa/kvqy94u6ZB5bkyVRmI0SBDlm/KDV1+bMhZPW6CcGUZo5WkD3rRuHgo0?=
 =?us-ascii?Q?138XYExabY4WoLS89ry5t5kAO3kQU7q9qWw8cdAOekqvzxWaEMnZtGQshg/J?=
 =?us-ascii?Q?xo/bn8UPIdfLfp140mxShellcv97PLppa2iiEiWZH0fmCW9C9/oSfpAh2cPq?=
 =?us-ascii?Q?nHRDgt3zeX9H+bIVr0ilwqbcDsCrOD9AHrfIKbXmQoox1UWzIhicHX1PX2It?=
 =?us-ascii?Q?s4ifdaDGjMMsVHfccvnkdfZEoDPP8nH6jUAmHX52YfnOY5z/bZpFGLFfphkP?=
 =?us-ascii?Q?CHTbYQmv4nBwBEQhnAy/t3cPL/bDmDC++rp10RImauQGARlVKjcLtn1Dx+yI?=
 =?us-ascii?Q?J/7ZyhpSkCt+e82jAvfTFZl53+pTaPJNx70mQgOAMpT4abv5/Lb16BRjAVi7?=
 =?us-ascii?Q?wKOEhvHA0uvTIzRB2RrXpbk3pzYcVbZUSOQ7ZjIl4XtXZTwnBQfub0T2jz3q?=
 =?us-ascii?Q?dVFNJfow9/mwz5Q4Z/Y/zf+CXMQKHNyjVDfqOQi9o0BLwbz28qsEkr0XaXAV?=
 =?us-ascii?Q?rUL7S4qmSFZuCLIddLFjgP9HqV+tdg//DkCOgFNQsLTWpJWhSMvjfBxr9ytJ?=
 =?us-ascii?Q?MurMkyoLlpxAG3Vk79Lktt0UphzWtU7u/vddYsf8WUz/xjue6VquvXJdJeE0?=
 =?us-ascii?Q?jAJKWw0vaG/c1U6gnLCcngKYTJqyWvwnasD145wIgpdiNRZ1LRTfVh6Xly0z?=
 =?us-ascii?Q?gkzXuk/RkAhW2wZhgmOX6yVJ8AsvIscbTdwVLEmOeqpmSr9/b/7G/IH3irFH?=
 =?us-ascii?Q?P7G8Gk2/Qd/epui4mIRplqv5wVLFBGaxbuhPtAKxA0p1C5TZRS0Ar76eHJPS?=
 =?us-ascii?Q?ainiHW1I4tbbzNJXCfcLu8UYXle6jEbwnPDB7MqPJwcE+LvTpYN4r2mQS0ZD?=
 =?us-ascii?Q?ceqYydJA/hDjms0dVXndJ5Wh/+idAUH0pSleTjDo+2qS4THzSk/x3T94o/sa?=
 =?us-ascii?Q?9HPd0MXdG5Png3UW64zqr5h7kEh/iC+YceRYxRFWZ632gCuICM6aEDtv+pHH?=
 =?us-ascii?Q?7ZxWGAdrmEc7tRDSnv9VyOEdaKgiR9wiOEUux9ViX/q40RWw7PfEXKskCFss?=
 =?us-ascii?Q?DyGw3wjAJYZvoP2qRsa6fJdX7R1mpj24dIvjZkrHC7Yvzl479BVdbHxgNIUW?=
 =?us-ascii?Q?4DnYJDHNH+7Bus1XIlinATIKAUfMcsLXqOrM0rk4n+td8d0qjl8cnWsoZe1h?=
 =?us-ascii?Q?4Zko2mVqr/l/txnjKagsgaSIR2L6j++o2wJfm8CEDfLiBI+avh3PGT1zhtGU?=
 =?us-ascii?Q?tgI5vMzPDYylFmUZ9Bswu7Pe5qVozZ74mwrnzybTpvIv2hE2SnerKi2awE/8?=
 =?us-ascii?Q?vQBntQ8E22o1NwtZJHPtSvhPhNDd/vPq54qLaNMajxT5UQTj7cPJ1eCXIqM5?=
 =?us-ascii?Q?mWp5Pyk7GN7jRW4Ai2E7FW1x+5hNKAAT7YSHbyafVk8A10++uWVlfFSyTmKC?=
 =?us-ascii?Q?xck4FHMPCaqspWyNXqzshNvB7qsNVBlFHKDJqaTRs1g9qsKxet/hO4xoiShg?=
 =?us-ascii?Q?l1sxhGVFzOtU4C8Siv59AcxVZZH8zOMwNQSDg4KJ/v0oW/eWtKw3uxduERF6?=
 =?us-ascii?Q?/UlOM6VoSCCKzhp1mz/XV7aAqHPkXZSjBKtOLmbEwSoVQzROcOp0FWTVd02A?=
 =?us-ascii?Q?wR38+qcyf85x4FN72Zr99wdQbr+5l04=3D?=
X-Exchange-RoutingPolicyChecked:
	g0moKG6Q1+Y3WWVYQj9WADPq+WnPCRQAd5yI67eqUerVgXQuIAYoreMCNjQVObQ4Lolod7S18ljIFT4E4OacgCyLjpaQhPOK93+3OOTtqbGL9Jjxm99nFmcXJJrTuPgRjbzEuzSYkpSwQjoJfSjpOLtA1gOJcNg8eZOrJ19gOe397ZGnhrpiKCdBWvSdfd1o6DiKLEQmbhVKRh23somwPQfKj3lbARHtuIluYT5h+loL0DH/WDoDZqZIstWmzq6j64Enb1Tcz8mxeboadIO+Xes0YY3fF0kRYRqK8zqow+MHJEBm5ld0MEalQul/BpMuzPBlrkyN34fuuy6XQkykQw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zyPzYd4Nf5Q1BEjvvwRuuDWbyqfUW6w1iAcukQPcnV4faYNAG9YV0FjRKQH3bSenkbpclYzqumgMbNmdScCLf9qkQaP/utAzEd7FWPJGIeAlTuUUw0tUrEbujAnCuq/DSwQ/2FJvYu0EEcQ16XLqWhIVJ3rxQzT8QGF2/Z6aiRWQnRFBfPxRFOfH/rSkuW9H3hxPLYVm7ksYtc24uPJrEB5nqDGop30+tJp5z9H60xWiKTEK+BuWMgCFK+nLB4vo1adbGcuR1McmB0cAlMrUlklSXoaDfEs6zNq306xubSiJdMjjBL94NwwmSEu0LhIRlvLjCYH+nxR3myqVnhoIM5deXW8kn6o9VFYH5oPK+1fQp9hsv19zNGlIorMAoPSkMP68BgcQFwm3shFdluQuQGLV0UGafhCxDeQFZtqtHNvd0156q0a8oJ0ELjKabP3Zq9+p3Qz4kqTxV5e9RSOoVed7n582h+d8fzbyNgmbGKG79aDlITRhMwAje++xaZRu5mzfzWnBtFi5bxQJwaXeIaee+FBDT6b8x9fD4AIExTEf4qJmIHfdHJ7P74xX3mk8SmXg8rDrehIdGHBbucL44LUvFAMePYP20A1kgvU8g1s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 250c6a72-b256-477e-f7e0-08dee179e60d
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 07:31:20.1462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IZinPqdh8zDMP87+Et1QR9602BVLW7e0WL9BYnhjqGnaqMqeu5A34akgLu5F+ps2zopslGjwc3E7nDIhpF7C3rCBwOKWUsUTcZVB47GKXpU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6262
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 lowpriorityscore=0 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2607140075
X-Authority-Analysis: v=2.4 cv=d5nFDxjE c=1 sm=1 tr=0 ts=6a55e5dd cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8
 a=Ru_WXoCZngTtvYUXGSoA:9
X-Proofpoint-GUID: 3OLmCnlI9rP2QcdbLHi70AL07blbig3E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDA3NiBTYWx0ZWRfX88Rzo1HFFzcQ
 UyPEyAJ7eQkeq40+9FaRjymAjAWwXm3XTMLxPp/tL3PWnK8zE47MohLrziU+8BF/kmG7rWvd2DX
 tarSfb6dttUS7BhkKtSDcqHE3tTK8o4LHk+dEeRPtp7UyX8o1cIq4pmvd7iRW/wixD+Wnyqd+CX
 CSSgAbAldRDQdTbY12VekIBAHoNLfEWnMGZgpATKAI9aki9WUwSzjNItWBv1m+p67Wh5aci6ItD
 yTsSOMUAqj2gMPVP/RNHcLEIGlk9GVLJFE6cNW6GgJayNWUzrvUz4gdUH7JnLBtqDBE6MiXYEcu
 xXOn8CFElqkz7SLChjJFrswhsAHOLk/z7oRkUhuuLzTwjXbOloX7Bdvu13JV9z2UwSbK1nGrJAx
 f3x/r06toPfHaSOR5DsonV6nTz9zzywMYADj/ZynWAMBZaZqczDkwZf8Bcfg8UFN7NPVyjQv2A8
 DozfKDcLhURiNnT5lzA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDA3NiBTYWx0ZWRfX+6K6mTE9WiPW
 jR0s6OgHwTWt/KTGNxOZ31Au/72EfeNLLcgLvQOzkAob3E9mvX9Hw1G8g203WaXFeMlaB09AtNo
 bxiK1fNmbIaXX24TeEFKvQix7PhzUJ6g1CE+lEnSp8TL8ABvmtM7
X-Proofpoint-ORIG-GUID: 3OLmCnlI9rP2QcdbLHi70AL07blbig3E

Switch out the conditional load interfaces used by rqspinlock
to smp_cond_read_acquire_timeout() and its wrapper,
atomic_cond_read_acquire_timeout().

Both these handle the timeout and amortize as needed, so use the
non-amortized RES_CHECK_TIMEOUT.

RES_CHECK_TIMEOUT does double duty here -- presenting the current
clock value, the timeout/deadlock error from clock_deadlock() to
the cond-load and, returning the error value via ret.

For correctness, we need to ensure that the error case of the
cond-load interface always agrees with that in clock_deadlock().

For the most part, this is fine because there's no independent clock,
or double reads from the clock in cond-load -- either of which could
lead to its internal state going out of sync from that of
clock_deadlock().

There is, however, an edge case where clock_deadlock() checks for:

        if (time > ts->timeout_end)
                return -ETIMEDOUT;

while smp_cond_load_acquire_timeout() checks for:

        __time_now = (time_expr_ns);
        if (__time_now <= 0 || __time_now >= __time_end) {
                VAL = READ_ONCE(*__PTR);
                break;
        }

This runs into a problem when (__time_now == __time_end) since
clock_deadlock() does not treat it as a timeout condition but
the second clause in the conditional above does.
So, add an equality check in clock_deadlock().

Finally, redefine SMP_TIMEOUT_POLL_COUNT to be 16k to be similar to
the spin-count used in the amortized version. We only do this for
non-arm64 as that uses a waiting implementation.

Cc: bpf@vger.kernel.org
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 kernel/bpf/rqspinlock.c | 40 +++++++++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 17 deletions(-)

diff --git a/kernel/bpf/rqspinlock.c b/kernel/bpf/rqspinlock.c
index 0ec17ebb67c1..e5e27266b813 100644
--- a/kernel/bpf/rqspinlock.c
+++ b/kernel/bpf/rqspinlock.c
@@ -215,7 +215,7 @@ static noinline s64 clock_deadlock(rqspinlock_t *lock, u32 mask,
 	}
 
 	time = ktime_get_mono_fast_ns();
-	if (time > ts->timeout_end)
+	if (time >= ts->timeout_end)
 		return -ETIMEDOUT;
 
 	/*
@@ -235,11 +235,10 @@ static noinline s64 clock_deadlock(rqspinlock_t *lock, u32 mask,
 }
 
 /*
- * Do not amortize with spins when res_smp_cond_load_acquire is defined,
- * as the macro does internal amortization for us.
+ * Spin amortized version of RES_CHECK_TIMEOUT. Used when busy-waiting in
+ * atomic_try_cmpxchg().
  */
-#ifndef res_smp_cond_load_acquire
-#define RES_CHECK_TIMEOUT(ts, ret, mask)					\
+#define RES_CHECK_TIMEOUT_AMORTIZED(ts, ret, mask)				\
 	({									\
 		s64 __timeval_err = 0;						\
 		if (!(ts).spin++)						\
@@ -247,7 +246,7 @@ static noinline s64 clock_deadlock(rqspinlock_t *lock, u32 mask,
 		(ret) = __timeval_err < 0 ? __timeval_err : 0;			\
 		__timeval_err;							\
 	})
-#else
+
 #define RES_CHECK_TIMEOUT(ts, ret, mask)					\
 	({									\
 		s64 __timeval_err;						\
@@ -255,7 +254,6 @@ static noinline s64 clock_deadlock(rqspinlock_t *lock, u32 mask,
 		(ret) = __timeval_err < 0 ? __timeval_err : 0;			\
 		__timeval_err;							\
 	})
-#endif
 
 /*
  * Initialize the 'spin' member.
@@ -269,6 +267,17 @@ static noinline s64 clock_deadlock(rqspinlock_t *lock, u32 mask,
  */
 #define RES_RESET_TIMEOUT(ts, _duration) ({ (ts).timeout_end = 0; (ts).duration = _duration; })
 
+/*
+ * Limit how often we invoke clock_deadlock() while spin-waiting in
+ * smp_cond_load_acquire_timeout() or atomic_cond_read_acquire_timeout().
+ *
+ * We only override the default value not superceding ARM64's override.
+ */
+#ifndef CONFIG_ARM64
+#undef SMP_TIMEOUT_POLL_COUNT
+#define SMP_TIMEOUT_POLL_COUNT	(16*1024)
+#endif
+
 /*
  * Provide a test-and-set fallback for cases when queued spin lock support is
  * absent from the architecture.
@@ -296,7 +305,7 @@ int __lockfunc resilient_tas_spin_lock(rqspinlock_t *lock)
 	val = atomic_read(&lock->val);
 
 	if (val || !atomic_try_cmpxchg(&lock->val, &val, 1)) {
-		if (RES_CHECK_TIMEOUT(ts, ret, ~0u) < 0)
+		if (RES_CHECK_TIMEOUT_AMORTIZED(ts, ret, ~0u) < 0)
 			goto out;
 		cpu_relax();
 		goto retry;
@@ -319,12 +328,6 @@ EXPORT_SYMBOL_GPL(resilient_tas_spin_lock);
  */
 static DEFINE_PER_CPU_ALIGNED(struct qnode, rqnodes[_Q_MAX_NODES]);
 
-#ifndef res_smp_cond_load_acquire
-#define res_smp_cond_load_acquire(v, c) smp_cond_load_acquire(v, c)
-#endif
-
-#define res_atomic_cond_read_acquire(v, c) res_smp_cond_load_acquire(&(v)->counter, (c))
-
 /**
  * resilient_queued_spin_lock_slowpath - acquire the queued spinlock
  * @lock: Pointer to queued spinlock structure
@@ -421,7 +424,9 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 	 */
 	if (val & _Q_LOCKED_MASK) {
 		RES_RESET_TIMEOUT(ts, RES_DEF_TIMEOUT);
-		res_smp_cond_load_acquire(&lock->locked, !VAL || RES_CHECK_TIMEOUT(ts, ret, _Q_LOCKED_MASK) < 0);
+		smp_cond_load_acquire_timeout(&lock->locked, !VAL,
+					      RES_CHECK_TIMEOUT(ts, ret, _Q_LOCKED_MASK),
+					      ts.duration);
 	}
 
 	if (ret) {
@@ -582,8 +587,9 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 	 * us.
 	 */
 	RES_RESET_TIMEOUT(ts, RES_DEF_TIMEOUT * 2);
-	val = res_atomic_cond_read_acquire(&lock->val, !(VAL & _Q_LOCKED_PENDING_MASK) ||
-					   RES_CHECK_TIMEOUT(ts, ret, _Q_LOCKED_PENDING_MASK) < 0);
+	val = atomic_cond_read_acquire_timeout(&lock->val, !(VAL & _Q_LOCKED_PENDING_MASK),
+					       RES_CHECK_TIMEOUT(ts, ret, _Q_LOCKED_PENDING_MASK),
+					       ts.duration);
 
 	/* Disable queue destruction when we detect deadlocks. */
 	if (ret == -EDEADLK) {
-- 
2.43.7

