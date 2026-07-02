Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0C3282F31;
	Thu,  2 Jul 2026 01:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782956065; cv=fail; b=W/M6c5CpbmwMoJmHr5vJRrIQy6/4FcFK4OeizP96psZ5OMuQHsUHPexAs8Us/Cd2WRgwcpCM2zBRUvxFIgZXwauYYv58IUspM2NyMrpURCsZuJERo1Fc56o0EWi6Ybqf3TcK9dXDNhBkZK02Ai8fEMAsx2A3pZGA7ECiNu8L7JU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782956065; c=relaxed/simple;
	bh=RDLq4kxv/mshx0hXK7zz531b9LCUJDjOXvdZ2PlIWZk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UnUSTB6YDSwh3anXYe3b0Irhv0YKSX2nGkV3dRWvk6CMvzlPFTZ1fgQrtROy7thfjUpYwAelOmjhdx+bkqAuGeao0D8UWr3LW2xSuILCvO9EopN+BFX82z9yoQfG8mFaOS+IWqpHgp5VC+ZcjBaC5GQJ4UKWzLy/m5occFYnfoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UClqZuYD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=m10QWItg; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UClqZuYD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="m10QWItg"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661EKFmR2784219;
	Thu, 2 Jul 2026 01:33:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Qc9kxLkDGha/9o5ViVD+9oBCbKgLib4L+J3lTykDaPA=; b=
	UClqZuYDakE70gSsazeZPFvtn7Wg4ow0krVrVQMjotPYnFAPw1uCv1ceZbLZvzxI
	petfatRqZOQtpjFWSBup6kpEix4owig/r0LRSezLEXVmC3dLH8gpeFPoqsJplGqj
	IWOwUF5a+qWlJwgFnVhhGyd52iPOZ/qQ8auIbYD+3GAzQNx3mUISBAFBJwsHVg4C
	SJCtECu5ED1xhFy35Pnw8EinU3nZU9+sD1G8iEke2ixbjG+sUQjPuHavU5U8nQI8
	qtL6oR3Kxr7ppwqu571Q4bpHwRMfZZdxDB/Mu6yWpnSRp7C3aGp8xe/XEM8bV8ag
	Uvwsk7UTOVw1dJHmnPfqDg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4f272qq6s2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Jul 2026 01:33:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 6621XgXx013188;
	Thu, 2 Jul 2026 01:33:56 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013069.outbound.protection.outlook.com [40.93.196.69])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4f24ysqnma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Jul 2026 01:33:56 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EHQrLtlc5w7TCBtfMwZLmSs+4Ngn3G2y9eZyDtMiZx23+qsRD3gJysWefJbr+15L1V9Xf0xpnCi92CsyzcE8Sb1m+pOXCT95P8GYlzc/eHgAMguebRIla3dmvvnBfixZb33S+d0fberKewapesILYLOZnp4fkX02gEmNk2It5uBJm+q+5VRbDl6btUSDBA8DpvN8VSfC/9cEzZVC5ozlAi+/zBSI5vE5nv1gwN6FLd3P6E3hhgE6XyhZ6fbiQaqvo3gl+sAs/a4qsM2Yx8oM/r6YJiaRtD6A6uGdojsqCsePxjP4f4S6fsQZA87dts+9Wl2MVxO5EX/kF+4UCvheuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qc9kxLkDGha/9o5ViVD+9oBCbKgLib4L+J3lTykDaPA=;
 b=QBqjT+KoDhHvliNf/SUrAUDL2m2OFcJ9sZJIDtp2nyzBnba5k2EJduA3WHIc1BKVv5sRRsY/gTdoDr3l6zDt9xwn5ZMPk2PK2haTtzRs3SXAuYs6CTmk+/FNZ1vtNP8PmbddBfZ1VZG047eRkAm9R/xoGa7rJHZu0BCmnvei4MbjTq0K9HJr5ZDtq5ekALTqh7hT2RqxL+XNfHhmaeDU22L2dA8/8jhAQs4cbTh5DMMcAmh5gtSdvOzglVpRZ57nMBY/2xy/qn+o4jkf95LFy83lMkpQT3AEJYIysRY5bSu19w+b7DExxRjOFkV6lFZqiYb9hGCuF3Zl7KOY7LvVzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qc9kxLkDGha/9o5ViVD+9oBCbKgLib4L+J3lTykDaPA=;
 b=m10QWItgBYd4C1XSV3djAeMg09yxasb3ccdNfSnP6ja21CY7Od7MsPoYEujLmyX8t+yDg1Xg86Xn31vwEpAVVqNR5gZO2vq9tauTxfkTUCW6m0Oxct867SqWG6OsILT96jtL7IHD0sTBfrKKEaXegQjax5l1qvw7uEP6mR0f2Wo=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CY8PR10MB7314.namprd10.prod.outlook.com (2603:10b6:930:7b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 01:33:52 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 01:33:52 +0000
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
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Christoph Lameter <cl@linux.com>
Subject: [PATCH v13 03/15] arm64/delay: move some constants out to a separate header
Date: Wed,  1 Jul 2026 18:33:22 -0700
Message-Id: <20260702013334.140905-4-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260702013334.140905-1-ankur.a.arora@oracle.com>
References: <20260702013334.140905-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0277.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:109::10) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CY8PR10MB7314:EE_
X-MS-Office365-Filtering-Correlation-Id: f2ef599f-c4bb-4de4-8d7b-08ded7d9f974
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	iszpNcNaHAWNrhkzOIuxijS26b+kyfHRToQBM3SHx6kfDEXymtYNmDUtE3U9j44LQEiqC+FFeWMOdxhV5zCY0ulYYXGYSF8ZDajCDNAFB9SbJw095T1geV585XWdeCYUgjzQPvHcqUJ8SDQv6Yq6SNAuvjW+XPgvW3IHqb8w2WmAZKqXBy5htjhFNl5dXJBNGCr15JlSBIIUH84tT6D+urT3O2gAC8e9NIOUJxqT3fU2260iEhm7ky7O8yTnUsyzVQvkKUNebxscvhqfRoLYSoF6OymVFMkXTwMUIaY74FQNPHISRJmgpFgUKaLIvG0tWMuF8PFzfLOhMyxXs7fr8fhKpRl2HQpTXk/kzt/ZarFyVvum8ejlnG9UuJdVnQ86rIp+8P7zKPo21IzrYhDYeBKr97x559lRPFgBtzxSg7pqPK8jc4PEYwavmjrH1K1cAAMuq7/GM2xqKQ/spVPG8LsRuy833T7/srVi1lEDPADK6dn2GDZ0HxyJBc2YiYlGsCXkvG+Fre/oH8c/L+k48fvXbcSLSOgRIMoNDRfIeI0L/jVCpnWxOz2iNzQ5jD211UL5bshhfROAlmupVp0umcKgvXTbTM+OaxT2ZYLCOziCMZEr28i9A/DhElFT4H0rghmqmlaRSA7YoB8jNpA86xV9lZ5Shvm3Or4K9MQ6RWA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+qIg3Ro4p767GfZf7ehBmSgNe9fWqdbwvmgnT9II6BgUtd2pH6/hBw0awvcy?=
 =?us-ascii?Q?AOJ4W06rfK7tlV1p+eSYw5YivFPOS8FaqUsiuViJSK/FxiC/++r1FWJ98qQb?=
 =?us-ascii?Q?1lN5xl6Cg/8muhI2wGadaoiHJTOTSPCf4F4s8HczeT00fgCT8SIMf4MurjFK?=
 =?us-ascii?Q?NwwYhEgRstQAILEZp5xfta7uV6VOAjnZ+sFWnMSMqAdbbhjkejEkXXNR1uSq?=
 =?us-ascii?Q?r4kELcsFeWCrKXCQ6Bfs0FifaiHHUBLFlK2kDS9FUpp0Sffhu92cjEgTDb+H?=
 =?us-ascii?Q?WhFLbw/JZG9A3lvEUvTP6+iTGfZLQRhdiul9tU66CEYhKVVCEgeKQZOFYwRI?=
 =?us-ascii?Q?HcsNjmYQjCOiJP8vw6YoEswsnwXm4sFwt++bh4bC2JPRIK1E3E5pLwxBNarR?=
 =?us-ascii?Q?p7Ap1PjaioUazXH+C2N0IzY671OACr+/mvbSXpjN8cLgFJuYsYAQVFN9sshk?=
 =?us-ascii?Q?BI8jj4Kf8ygrZJpeFFa7N/8HAXcFUGEoXUvip3GJYJEfrHFuEws/XXONLEtI?=
 =?us-ascii?Q?aU8wsQ3zyGFu8SF75Q8H+qpojy8kZscM0lum8Ml+Ogx+yv1YweD+8SUxse5y?=
 =?us-ascii?Q?7M+RDWIpETcrKYX938vUOzhQTJSVRpDpIXaCjI1v0jyAyyJR78Whe9IMKHOn?=
 =?us-ascii?Q?E+6/T7hNDb1sT0r2xLz5EdqTFBmfaS/y/YV3/hIJm8hOQVSCf06uhq5hyHgl?=
 =?us-ascii?Q?pJ7l4N/woI3ZfvA7dpJ/6iEHku+duFLDWTe6w6Fb+JT7q3ZpS4x7VYTZxhbm?=
 =?us-ascii?Q?urD+xlrlyqkZWbcfxwdsgH/jgUH0WzzrCvglqjQKit0FgMz6JrA0/IeSjXWJ?=
 =?us-ascii?Q?Ww4fDkrD/NGcMIWEK4zHDREVjSaVxTk8twphxp6zvbVyuPHtoD4fe+/q+UA3?=
 =?us-ascii?Q?QWzkljqDds015/nbgIEVbUQhCvxMXJtKno7F4JEdusZebTD6xrxihw3ivRkF?=
 =?us-ascii?Q?g+ushtg5WJ1nKMiFJshUVFvE/QqCKfCHLNivWaEDFjkGCzqutd3bIf9XzOZh?=
 =?us-ascii?Q?vlDf+b81HkO9jynJDJoy7vIc3h8gKgQ+JPZOoOXkRuqOXuZPnoAz53prhxoh?=
 =?us-ascii?Q?dvuER+UWWermRnXFz0vO408NTOBevFtRzSWInahIG41yp5JA+/2+DzyP/GOK?=
 =?us-ascii?Q?Lm10kDl0XUwlD+wwaJjv55idNf4wb3BtMni9AJ8wFlqnwScPzf8yP5+DdCbg?=
 =?us-ascii?Q?k8Ow2xQHEae7FF9qIrv6HhrPqygRGXzsQaKK5MLzgRGPNq7L8YGzjLTVIz6d?=
 =?us-ascii?Q?lTNPBEIGd1QBrYmKzyjlh4jSw5Mzw2S3lJp6kK496/+ep6+k3E/imfp+4Nuh?=
 =?us-ascii?Q?nsJ2tl5pN7huRZ4PeLrulpUqG3idYRTlDDeB62O1aQIWelRqufASOm9A/hyA?=
 =?us-ascii?Q?tDdHenDsQ0jBCzxd8KcBQcRn8Rc+7HDuTFgJeRvjQNGJnupv6bd6f5kIbKjR?=
 =?us-ascii?Q?YOlNXZbi6uLO0c2YwJ3mNnmLiW10ST6ViEwA1rIIvz0eMnuqA+rLvoE9g2oz?=
 =?us-ascii?Q?VTFofyWQ35zQvY5nO5PBuTxXCtWLtup57KoQYtja7Ky/Fp0vShCZ7xrCtO0J?=
 =?us-ascii?Q?DRQEVU6Con5ydNYaSMFBuejevVgaHrWE0eB58qGVuPmYv1FBnA8jLA2pzgl1?=
 =?us-ascii?Q?j7gimWfZ/RPNFUL6FQeFcMwoPsL9YpLoy/0pDzTe0KDhmE8L+rYT///xnKRu?=
 =?us-ascii?Q?7rHjJWtFOZx89V50Nr4UOE6YGfTuVGMvywobHFiTS7fOu74HFa/MHvNzEwwP?=
 =?us-ascii?Q?1KjzdFs6GmuYNSRVGy1NowdB7baa8o8=3D?=
X-Exchange-RoutingPolicyChecked:
	OKP02yd3fYQG7Jwm7ECTCIfCLnE+DGJ8HRr/NAIiV+x6cxw9LXWVQYYEWP4NmXOzPYTYo8321yQC7Wx4hHWZAnK209MeJsenkxVBpenwR7M6VJgYdzP+bhRUDJCuuZRZGLd2OyBNQj5XbBc5TN2NaTOf63gFzd9PM1yJeIxPF7hFVw/P+uAPYOlGE/+VMrXt9nua3VYBT0edph0Z+ohnssQmCENXe04J/efAhEN0EmNpIkVXJKRcG7oz0QMKmN0W/WhubMKn05+3BComzLFg+6WXOmOYFoLQ+TGrZwulg5I1+3grKIph1nf4H++lDhrslkAYrNhZExHjVoAJd2Tcqw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9L4p9jks2Z/Y7oRXh1L12tFl4wFrYvq/DuqrYiXt3t7NaUxr56Qpb2FldfjFrrCzujuhwQaEhh+NnNxgUHIFNRKglVjAWxLUAx/Bdqdxz++Ak7j5+azzryhv5dDXQqy5BuX9cdq3jjn6RN+5LyMUHmw6tDklAlV4+dojvE846nbEnXXPtkxG6UPwc0yMa4r5f791+WqkfNpWdC/clDoHR3dnT5PRQ/S0NPj0+Af7wP4QHUuiIwJqJKgzFD/Vz2mFgTNNjjMSovHYAQPlQ0n2X+SbM5UbSWo2DL32qm93TtPCTu8Q5AhjF8563Aln95TD5QC1SMkIX7CTfm6lWiek9LQxSXx9ag8kmAQShQg0/QveXbxCpr29qYSwCbD60mchaOiim3+8JQWOQyfaKVB4TBXbmBLGlllJTb495BpOF23aYhgh91bRZsrnKEJ6j01k8tpBYf3fyCeEw6sHr0kdiNXAOG+q7X7XJ8Qivs0EPLsCzFZRyGOJOmHKaRQbhhEREyTjkDH4lZ0qyHhGy2nayMYJrlA1RYg4XKt81+98c7vAbJUoXIG2wzVbHkvaj+SNxgPAO7w2WOLBarreu9I7LO22VdjtWTaVoov8MKAf93Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2ef599f-c4bb-4de4-8d7b-08ded7d9f974
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 01:33:52.7304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EYr2z4dyyDpPgrH4f5obU+/QgLz3wVQ5F1vqrzC2Vj3o9FgnbB7dDnlUOiwtPEYPohtsJc3qr4RSdY6tJrU43wt7WihvMHXeu0CTnhPjuQQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7314
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0 bulkscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 mlxscore=0 malwarescore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2607020013
X-Proofpoint-ORIG-GUID: oudIF-FBed7qqnDJOhl8vv_Z7bKX6glb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDAxMiBTYWx0ZWRfXws+RJvg4Rsq5
 GDilSGf2DdHiAchMgn7U8cVQdod2mdIuQqvfzpKSsmJtTal3fLCJVfqPd4elbpPwpIO0KO4UI9I
 CAc6DQ41bMPVIzx8ZktRuOryByMZ06/UvUt07eXE7a68VWIpmAMtrVrBHTvmc483WQOjSbB4Li4
 ltHPwXJlVlZCKCdkTdXJ3lCUkWutdu5O98z70MSojWXf7JytYtxWVyC0XdqhCpht4rw11FdCqIc
 ZLQ2/BC00ajyowIGnoh6UNhwxKfMYvF9qpsb2/8p3zcDEL67qgARdyQ5s0HbsX9gP5pahRruT+G
 D5XyGOEAj7+oAWjuP49z/+qHoou/SKZlKXq7Ba7+p4nBpjQCteKf1Lc7VoWxCJgCZRpzubOmKdK
 HQDGzulG6oup949Z7kASLoIsZYXcQfHiN3f9+bx7ywo1ruwYUm2K8AuRRKfmTCNUtrUtHdD+CTQ
 mNpd04O7RenJXJjOrKw1NcTRMj/ZFndRmo/vC3OM=
X-Authority-Analysis: v=2.4 cv=LOxWhpW9 c=1 sm=1 tr=0 ts=6a45c005 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=7CQSdrXTAAAA:8 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8
 a=NufY4J3AAAAA:8 a=yPCof4ZbAAAA:8 a=gQgDrPkycQ706KZxoKkA:9
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=1CNFftbPRP8L7MoqJWF3:22 a=TPcZfFuj8SYsoCJAFAiX:22
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13723
X-Proofpoint-GUID: oudIF-FBed7qqnDJOhl8vv_Z7bKX6glb
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDAxMiBTYWx0ZWRfXw6LyRVG33zbV
 FLaQdh1OfleZYn7GPxhd/2s9qcTtM7kVRQCd5CF9S71MXlWBKn1gZ9Lp2z0nCGVw82ICdSo4N7u
 hMLnl5mPGi2SQi2zJuSCsOd2kVzKSbYQp4sd1Til1164vlp08907

Moves some constants and functions related to xloops, cycles computation
out to a new header. Also make __delay_cycles() available outside of
arch/arm64/lib/delay.c.

Rename some macros in qcom/rpmh-rsc.c which were occupying the same
namespace.

No functional change.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Reviewed-by: Christoph Lameter <cl@linux.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/arm64/include/asm/delay-const.h | 28 ++++++++++++++++++++++++++++
 arch/arm64/lib/delay.c               | 15 ++++-----------
 drivers/soc/qcom/rpmh-rsc.c          |  8 ++++----
 3 files changed, 36 insertions(+), 15 deletions(-)
 create mode 100644 arch/arm64/include/asm/delay-const.h

diff --git a/arch/arm64/include/asm/delay-const.h b/arch/arm64/include/asm/delay-const.h
new file mode 100644
index 000000000000..2a5acfb7bff1
--- /dev/null
+++ b/arch/arm64/include/asm/delay-const.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _ASM_DELAY_CONST_H
+#define _ASM_DELAY_CONST_H
+
+#include <linux/types.h>
+#include <asm/param.h>	/* For HZ */
+
+/* 2**32 / 1000000 (rounded up) */
+#define __usecs_to_xloops_mult	0x10C7UL
+
+/* 2**32 / 1000000000 (rounded up) */
+#define __nsecs_to_xloops_mult	0x5UL
+
+extern unsigned long loops_per_jiffy;
+static inline unsigned long xloops_to_cycles(unsigned long xloops)
+{
+	return (xloops * loops_per_jiffy * HZ) >> 32;
+}
+
+#define USECS_TO_CYCLES(time_usecs) \
+	xloops_to_cycles((time_usecs) * __usecs_to_xloops_mult)
+
+#define NSECS_TO_CYCLES(time_nsecs) \
+	xloops_to_cycles((time_nsecs) * __nsecs_to_xloops_mult)
+
+u64 notrace __delay_cycles(void);
+
+#endif	/* _ASM_DELAY_CONST_H */
diff --git a/arch/arm64/lib/delay.c b/arch/arm64/lib/delay.c
index e278e060e78a..c660a7ea26dd 100644
--- a/arch/arm64/lib/delay.c
+++ b/arch/arm64/lib/delay.c
@@ -12,17 +12,10 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/timex.h>
+#include <asm/delay-const.h>
 
 #include <clocksource/arm_arch_timer.h>
 
-#define USECS_TO_CYCLES(time_usecs)			\
-	xloops_to_cycles((time_usecs) * 0x10C7UL)
-
-static inline unsigned long xloops_to_cycles(unsigned long xloops)
-{
-	return (xloops * loops_per_jiffy * HZ) >> 32;
-}
-
 /*
  * Force the use of CNTVCT_EL0 in order to have the same base as WFxT.
  * This avoids some annoying issues when CNTVOFF_EL2 is not reset 0 on a
@@ -32,7 +25,7 @@ static inline unsigned long xloops_to_cycles(unsigned long xloops)
  * Note that userspace cannot change the offset behind our back either,
  * as the vcpu mutex is held as long as KVM_RUN is in progress.
  */
-static cycles_t notrace __delay_cycles(void)
+u64 notrace __delay_cycles(void)
 {
 	guard(preempt_notrace)();
 	return __arch_counter_get_cntvct_stable();
@@ -73,12 +66,12 @@ EXPORT_SYMBOL(__const_udelay);
 
 void __udelay(unsigned long usecs)
 {
-	__const_udelay(usecs * 0x10C7UL); /* 2**32 / 1000000 (rounded up) */
+	__const_udelay(usecs * __usecs_to_xloops_mult);
 }
 EXPORT_SYMBOL(__udelay);
 
 void __ndelay(unsigned long nsecs)
 {
-	__const_udelay(nsecs * 0x5UL); /* 2**32 / 1000000000 (rounded up) */
+	__const_udelay(nsecs * __nsecs_to_xloops_mult);
 }
 EXPORT_SYMBOL(__ndelay);
diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index c6f7d5c9c493..ad5ec5c0de0a 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -146,10 +146,10 @@ enum {
  *  +---------------------------------------------------+
  */
 
-#define USECS_TO_CYCLES(time_usecs)			\
-	xloops_to_cycles((time_usecs) * 0x10C7UL)
+#define RPMH_USECS_TO_CYCLES(time_usecs)		\
+	rpmh_xloops_to_cycles((time_usecs) * 0x10C7UL)
 
-static inline unsigned long xloops_to_cycles(u64 xloops)
+static inline unsigned long rpmh_xloops_to_cycles(u64 xloops)
 {
 	return (xloops * loops_per_jiffy * HZ) >> 32;
 }
@@ -819,7 +819,7 @@ void rpmh_rsc_write_next_wakeup(struct rsc_drv *drv)
 	wakeup_us = ktime_to_us(wakeup);
 
 	/* Convert the wakeup to arch timer scale */
-	wakeup_cycles = USECS_TO_CYCLES(wakeup_us);
+	wakeup_cycles = RPMH_USECS_TO_CYCLES(wakeup_us);
 	wakeup_cycles += arch_timer_read_counter();
 
 exit:
-- 
2.43.7

