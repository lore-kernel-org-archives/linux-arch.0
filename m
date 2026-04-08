Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C5440DFCD;
	Wed,  8 Apr 2026 12:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775651185; cv=fail; b=hIeMQTJwEd1qeQ84ta3a3chumoSubbU2CfoxIxD7vgmdjDZYUfpIY8bvmbujE+n9gsQX+QBP2eRY/qNyQFx8Mi0YOmcWvKQvnrN6BYF6Y/sFkqfACEuD77xBC2YbDbWYycm826lmDWThuoA+OrLmmb1tg3dVHrXgaWd9nyTeUnw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775651185; c=relaxed/simple;
	bh=pgcabR+oKT28mGBpl0rs+F98xIPYkIWmCS/BxdEtJXQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lYFzkzB2fBmuZrYnS1T12GJNbXVwZGxA34lDt3+Rc0tyH0qb+PFvVEkgyqOrmhtuRAW8ew66Cn1EktZbhq1n1+w6J97d7K/WQdouiTP1s4OfRtdFG7x0UtBTg2+PJjgEbo1FiRv93uSTnFzgfryvf5kLGI3+On2uX1WVriqsNo0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QHce9fl3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bOUxJGz9; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QHce9fl3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bOUxJGz9"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6384OROa2988437;
	Wed, 8 Apr 2026 12:25:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=fXXbFgTx+CAT6OSXqGd3pz2aEnAb35r2aNsUOWPbrQg=; b=
	QHce9fl3rvl7ApT9dih65BdVuUrJPbvaE+pZaCEpJPEgZ6B2e/XnOZd6X3aY+fyC
	NxqV2/5jnzzyKG7OkZyhPLXeRphvr6VKPfdnPHodvoqGGbWU3KOxNJkhAegPj4uc
	hBoPEqi6LnE/vby2e3Z8cZbrC1VMZANoVCQwnA41kDY9j2PDrc1VzCvcbakbBr8u
	FoUnDIaoZZy+Ndu8fZWD90Jnn2TwijOh0IMLZRY6kaTkXPmUVWb5lT7pWgcPZEEY
	xii3qtjAbuO7BCzt8+uLpYz9heRWBCGuOk5CDoo9OD1M85HpWIDgCcyqCLdsb+6A
	f4dZTnGwFxvKyz7qYnsG7Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dcmqaudhr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Apr 2026 12:25:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 638A6Uxh007398;
	Wed, 8 Apr 2026 12:25:53 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011031.outbound.protection.outlook.com [40.93.194.31])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4dcmejqmgs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Apr 2026 12:25:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BYaj09JjEzn1kXa+UJJlpPQKLSrJcSGm267jechmBmU0RkbQT9zU6S1Nv0d58JpBK19Wc1/q7hmd48zWx0GYo78iVPnPX+NqBMKWNye5flDeK5rZlJHraS0lo4oW14UFr535QI5PaoSqnpHcKGMfUPPZjpsF7pgOoeAqIPOskCiLH+nbudCc8qp6lDDM9yr7UuZvOfoIpPkPmNfgVdkS88aV9DBxo/VH7zLUhoAWONfil0XkVaPn5U1bc+N2iuug7QlCyLvFbAQiSuyR+ALVHfgjR/O7B2k+Mro4LSwbNl2de4R7Dqj0HrfZW2EnIxYzVrOzGFBg7uZ0PouepTMGjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fXXbFgTx+CAT6OSXqGd3pz2aEnAb35r2aNsUOWPbrQg=;
 b=EnuplkWE3o0yvMLaP3e2NVT7v6j17VnRNUWOTdZjCwMFYi/Ec86fLUtuamBctQHaX2/WT7lwOoSh4hiLbBhQGXpsfG3imVwbH6sJzbiQNJ22KIS10U/oyMd39vHw2Nj+Gbf7Xd1F47vAi4TAYt+47V/pTHaF0ZdALLsGLFs0yj7PoCkY+qB37iLKF7PPyzu3N9vOYMcjXoc0zfjzmfuyLY49V/o9MB9xdWlagaRAeY5yImBVP5mDUH8KIIXXNgHzN6jFp6zonK036u0c15OzCRmgiT9cb//G2wSCOr3flHw61jE96We/a4UgVMUJQnDExP1194fBB8tKKMnRzxomxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fXXbFgTx+CAT6OSXqGd3pz2aEnAb35r2aNsUOWPbrQg=;
 b=bOUxJGz9eA3PnRyNvIEpIiZ4gb2CWz9sCVJ5/rym/+fSV0ChlImm1Or1iGd4AIPn8G1vS75+jXauJZ7tU1kcEeEAUs5WfBk5vIG+pnWyLAv32WG/Vv7prOLQIPexdeTLoPHuzghkkmBtE+RyjNVeWnjBmsIxUTdoDDC4NJeLfHE=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by PH0PR10MB5778.namprd10.prod.outlook.com (2603:10b6:510:12b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 8 Apr
 2026 12:25:47 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.20.9745.034; Wed, 8 Apr 2026
 12:25:47 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        bpf@vger.kernel.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, memxor@gmail.com, zhenglifeng1@huawei.com,
        xueshuai@linux.alibaba.com, rdunlap@infradead.org,
        david.laight.linux@gmail.com, joao.m.martins@oracle.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, ashok.bhat@arm.com,
        Ankur Arora <ankur.a.arora@oracle.com>
Subject: [PATCH v11 01/14] asm-generic: barrier: Add smp_cond_load_relaxed_timeout()
Date: Wed,  8 Apr 2026 17:55:25 +0530
Message-Id: <20260408122538.3610871-2-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260408122538.3610871-1-ankur.a.arora@oracle.com>
References: <20260408122538.3610871-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN4PR01CA0061.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26c::13) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|PH0PR10MB5778:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a9422a1-e2f0-47e9-41a7-08de9569f656
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|7416014|10070799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	MOVVYRyO8RdJQcK3AcUEcT4EL/jydhHy+Y/LfCq+CT6epU/q6fVsKyAhot43qhIRuxzqWiWb5dI+I586WDfzTiYmxYpQ2GwpBMnQ3j1cLDAyl09uvnqmwqXCBUxKW8lJdypO9v2U/B3X6hHDK1LGA6XTxHlXhfqe2g+aQK1JfenddyIdm+cIwWU+492v9IhWQV2XEJoS+dDRmSguMHnG9Io43aEXDbVTElZ92s8x8iZt5tnoGd/ouFd7fTYJ6uGsh9pv2mNEwWV0yEVbBqPWNKCf0MAnHWNQxtXqNPD5QV7pt15EzlL+C6dS1wgEr+1eJ57ZhovzNhsEiQQ83sdTl0VDRX/AttE9ffA6R4qxAauDE+i5vdNwDI1Oc1uQ3QLa/kZDtJoCR/549N1gOhvZkMkYMhf7K9P5imK/2hClQqmDwhPOIvpQhLlbdqWoCinJGtXqMqHbz673KMfiMGSxCcIDismU4aVX/uoYYBTXDCEfh+jgJSP0R5civlPO9Tm4kWyMlEv0YN8UNDh+TIzPCotkyrkw8a3+l+y4nVbfZyS2+z76WL/pXFa38fpPFgZ4H9745SdHpmRD8jgUZVmlyRjiuTy53NjhMd5/NRL0KwhD6/vjrNoNOUlp378v75xkf8/spz9CdCP7F7XFuaihEub0JR24MT/E0FosTBrSCdBWnirncDCj8fMOiAikSkwZw9fKN/gQr4iNAXnRyUGBTv/OU899oSWAfCbwGnKSQBg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(10070799003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Tbm8KgNKW+jb6MDZkqWTXFGwtOE98NQccrZyjncDBXcvC24gvEzh2QACmQkZ?=
 =?us-ascii?Q?NLo7Xb2JfGx0Z7kQOCdkL91EYr5ptjpNI0d9cf8HDX00wYwWrQU+sYG3ZsL1?=
 =?us-ascii?Q?MiHzKV3Za+xnv8znH1wtrv3bHsQMsy9jFsuhL7wBxafouHRn6Dj8+/6ZzMtW?=
 =?us-ascii?Q?rRfWPYG+VSYQjNy0e18BLSF5e2BE1jdrehKFQuj2NTKYqytf3Tt6EZcmVy9D?=
 =?us-ascii?Q?ZiFERES8DR81jc4Ww3O/x95ZwRtWJRZaQH4C09Z4eLx2Z68rDnSU7vRn8nVg?=
 =?us-ascii?Q?Bzg++C+OIOeuFmUAM2H2OGkuGB2OFmB3hxwRF9hHy8ocNri32yvecqHNfQDf?=
 =?us-ascii?Q?5NGCzvtrnNJdVgtijNezCZeW73f1cdkcnAZ10/UOzjGRPyZvgMe99hXTZTb6?=
 =?us-ascii?Q?ivtDfr8ExnW41BaitoRafYGasc4Lf3cc72K3CcM/hL/VOXMAyoeGMfNdZ8kF?=
 =?us-ascii?Q?9vvISnWZYY62G1TI5q7jeK03+cnLotNxmcusMUr910TzAs5xcknm/7XLqGqT?=
 =?us-ascii?Q?MEHg7QkHw3sMMktvxBZyKzLv3U2DHCn34dtV7UYQXwdGiqMNpPinoHfUaqIH?=
 =?us-ascii?Q?LoQGuqoTGbfBOQqofvVmKEbBP3WKaQBE6q1obPm9ZyCR/HIxjYSgTkIi8EsR?=
 =?us-ascii?Q?LGgoQNjYk1JF3ySASsB0sVIiEoTl5MWHuwJly19/tHOqf+BCj56IFxqaPVyF?=
 =?us-ascii?Q?3+PyvVwmKZPVqnXBLzvsNlVPCmV1iAOXFEk9hbgaJArd02phFD51kJI0nhqq?=
 =?us-ascii?Q?KANGkN9uAGicbnomZVbC7qye6BlT2lKVnG/x893ybeRjkveVrcAiYTSXeD16?=
 =?us-ascii?Q?BWuXvx0FeUZmnDWlSD6yQC1XOz3ky5oHiMI7WzF20VToXJpMAQWw7773IeFP?=
 =?us-ascii?Q?HyFqI7waj6NMu9q+/PMpTLAa4pW7fROzUYr8+cnb8VlQSjL/v7zE3uJMGi0Z?=
 =?us-ascii?Q?BhpDEXkmxclsaIqk3SECM9tb/7S0+gTjS+hyNpY1Ri/J4u5n8oRTdkJCEVVb?=
 =?us-ascii?Q?H/FkSJ4I7/CT0ongpn3C7yjKvEYeWL+q9yGF4onAIe6w+bQ5ld30Gh2p2EFc?=
 =?us-ascii?Q?XleYbT+cccSles46jEXgPO9GsTaMR8WIY/O2Ng8eP8uukh3Wi3xTQNXpdmzZ?=
 =?us-ascii?Q?nW0dZrMN++ITqiqQAXvYiKWzQaCIuGgr0kjZuxTVYbz3zaeGCBNKdY+TaTiB?=
 =?us-ascii?Q?rcDLR6jMx6tS/GAMUgeLFFhzkiij0WrGOwtfgD8RNU4dQgqrnE7LRrp2El/B?=
 =?us-ascii?Q?czBxQse/y0FwwrFP20badvWzjbV5S+J8cHQlXljLB7lf3q5zYYEdUwXlqtCx?=
 =?us-ascii?Q?Az11tijfGe+OIbxjrxpAIdcfzLeMqL2r9tn3HGnv4U6OPEwn/To5+hsJR3gD?=
 =?us-ascii?Q?23zk5VTfs1D35WOtFyJbvJ+2+V7vkC8Ms2/x5mXzoaOusJNNRhSVbdwaQsmb?=
 =?us-ascii?Q?EhPTh/5yx8guuRoWmg/n+mR4MG5BKnLYgS07z4YkaM3jJ96HkwQTe9HGwfbA?=
 =?us-ascii?Q?HbowAL+61z9exDNCufeBU/N0xwJqZSYCSP97V2H4ESovah2OGozfgsiMvJDf?=
 =?us-ascii?Q?mKmF+fjNpbCaUlKsFxGJFDCJIVUhdOf14+MFLHQut6FRT586A/ri1k4Csro1?=
 =?us-ascii?Q?OjFtCbWLRf0t+SFsqHjOk8RKsjXFs/uGtSVMTohcmeD71G/Qs6D4oQCw+SfO?=
 =?us-ascii?Q?urgytB8fnCHgQitJTLIVIYem/It40bjOnUaP/gtekiCRjFcH90+9CbT+63aN?=
 =?us-ascii?Q?N3k4aTR34W6cWFaqtbwM2Mqv9n5z9UHJ9WgwydpI5pmtQ6vpikJR+2DU7dF5?=
X-MS-Exchange-AntiSpam-MessageData-1: 01zOyF69AzxGkJhdSgYfPH3Xh42DcFi3rAc=
X-Exchange-RoutingPolicyChecked:
	qg3idUagMhb631MasB092G0R7eyqFuVT8tejgse7uNKwWK2Zw+Kdlaw2EK3KsRfxseIJrnTecXaWs2Iokdd6aUSFn3vrnMdrEXAg5Z/hHisrk3nAK9mnUa2HeyLhk97M+nU3odD9cm1GBXQ6iw6y+6yaTGUM3GRC3zDOVjMIAfajuECZZJ2Or4lv4S3wb7ZcAYJ3RVZZl6l7yriIMh9OBvziW81Rp0pDZamXI84gqjLQs1Qsbt1mtW7izZwATSd1adn+AekAlrn3TLqNKO3YIHvppN0y4Z7i3lznoYVaWQWe9zErreI1Vzmozc/GZ9APhM3yOWvhAqyFnvvLWou1wA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7kojniNn2sAZICrbCm6SnUFdVnuf9u5sP5+NngyLs0REWJ8cr+2+m3av6eAhxQ8bxjFEhxKqVB9JZAsQGaiO4KV9okgE5CZACcmISh9KOXGiWA16/9NgyIJLfyeaNbMfLiX3umd8bTR7HXXGRJxFDwz4ZpUNJ6rINqbDMENiOSDDlwIpr3qInpQkowgqfX2Uim71uX/lMdupPC8j1+JD42a5MYYlAo1SU+7yfUoU1BHWVF0Qoru4ACQmp51z6NFfsM/OJYlRRZXzORXAc1+nBWnKRNJFAuG23WeH7oz3vrOM9MYxjxMLirtIC52m0M5Aa4RzXHcoKwf0DgtyHQyPsnCT0J71EJ3cFvEgofpzW6fWJSy2z/XoGTDUqOVM4z7YwIHqKQSdWcU97AqpXEXNcJtXShE9dd82CYQX/2HtFxP5JRUMHXtSGmXovt7hf+HkeKylpn1yTraYRLC9eGY7Dt6VCTUKmDSNM0jCB31+vqRRrLbgnW7yrsMCZT7dO9PC8KGJQcb82g1q3BWRIfH05p7p7pajO+axlkrWlQh+J219yBwO6dBrP0++7QxqSRXYAghQAfZRuD5dZScG6vpuOmleZFwTkHneElbgsGnnEnA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a9422a1-e2f0-47e9-41a7-08de9569f656
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 12:25:47.3466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tCEWgP2WtqIcrYjVYV6pwG4D8ISjPj3iEpuT967mIR+No/zK+4C6TYiGvqxZPEaFunp9ILmvQm2fYQLPwqhA6QavxYYwfXRNXJ1lvxhr7TA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5778
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_04,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2604010000
 definitions=main-2604080115
X-Proofpoint-ORIG-GUID: Shm6pFw1heK0L-kFaovLW1NFjKYJWDJc
X-Proofpoint-GUID: Shm6pFw1heK0L-kFaovLW1NFjKYJWDJc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDExNSBTYWx0ZWRfXzaTDhwiVcntD
 X5D64BN7s53iwFAFd1ySseiisBeqYqs14J5TuV/QVwUyAQ95g5fM1LZTfQwtGUhfvV0rlt4C3b2
 +K+rHFgHbk1YwaZ11VYXQUhP4Cxp0gu/JQzDt1uoZJeZI0LDz3eoeqXG0rCfeVyRnyIm6qshK3s
 K1XYkKSkRawsr2G0ZCpZEQgpzNVUq6gW6jkqjnxUNmE5aKZePEBxKxAtXX6ZjRh+cKJjvFlfsZw
 7K/YE2ePcUPzzbT/1xf1y517rsz/ZdFMO0Mp+udhv6KB25enlrubeZnjBDt+w2v9ACn/CL7tOVT
 ENAYhAGyZgayFFkr2zBedIOb6v7p+gFs/BUPQSgMSjmk1GwfLbRD0hP0UNcJvkAhOGJrNXO4pmu
 E2dPkFI6fA5cQ5np7UOjD4ME9TTzMatsl+xUQ3rBltzGjsT8+jdLpzfZsyATiBnaJNt2dOxBhfx
 IgFw/71cnrvOFTB0/jzs1RUUu/bRKQrSbcPMjXjs=
X-Authority-Analysis: v=2.4 cv=NZXWEWD4 c=1 sm=1 tr=0 ts=69d64952 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=EIcjfB9IiI4px24ztqRk:22 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=JfrnYn6hAAAA:8
 a=yPCof4ZbAAAA:8 a=1Vp-6p46HJp4oqU_kr8A:9 a=a-qgeE7W1pNrGK8U0ZQC:22
 a=1CNFftbPRP8L7MoqJWF3:22 cc=ntf awl=host:13825

Add smp_cond_load_relaxed_timeout(), which extends
smp_cond_load_relaxed() to allow waiting for a duration.

We loop around waiting for the condition variable to change while
peridically doing a time-check. The loop uses cpu_poll_relax() to slow
down the busy-wait, which, unless overridden by the architecture
code, amounts to a cpu_relax().

Note that there are two ways for the time-check to fail: the timeout
case or, @time_expr_ns returning an invalid value (negative or zero).
The second failure mode allows for clocks attached to the clock-domain
of @cond_expr --  which might cease to operate meaningfully once some
state internal to @cond_expr has changed -- to fail.

Evaluation of @time_expr_ns: in the fastpath we want to keep the
performance close to smp_cond_load_relaxed(). So defer evaluation
of the potentially costly @time_expr_ns to the slowpath.

This also means that there will always be some hardware dependent
duration that has passed in cpu_poll_relax() iterations at the time
of first evaluation. Additionally cpu_poll_relax() is not guaranteed
to return at timeout boundary. In sum, expect timeout overshoot when
we exit due to expiration of the timeout.

The number of spin iterations before time-check, SMP_TIMEOUT_POLL_COUNT
is chosen to be 200 by default. With a cpu_poll_relax() iteration
taking ~20-30 cycles (measured on a variety of x86 platforms), we
expect a time-check every ~4000-6000 cycles.

The outer limit of the overshoot is double that when working with the
parameters above. This might be higher or lower depending on the
implementation of cpu_poll_relax() across architectures.

Lastly, config option ARCH_HAS_CPU_RELAX indicates availability of a
cpu_poll_relax() that is cheaper than polling. This might be relevant
for cases with a long timeout.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
Notes:
   - add a comment mentioning that smp_cond_load_relaxed_timeout() might
     be using architectural primitives that don't support MMIO.
     (David Laight, Catalin Marinas)

 include/asm-generic/barrier.h | 69 +++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
index d4f581c1e21d..e5a6a1c04649 100644
--- a/include/asm-generic/barrier.h
+++ b/include/asm-generic/barrier.h
@@ -273,6 +273,75 @@ do {									\
 })
 #endif
 
+/*
+ * Number of times we iterate in the loop before doing the time check.
+ * Note that the iteration count assumes that the loop condition is
+ * relatively cheap.
+ */
+#ifndef SMP_TIMEOUT_POLL_COUNT
+#define SMP_TIMEOUT_POLL_COUNT		200
+#endif
+
+/*
+ * Platforms with ARCH_HAS_CPU_RELAX have a cpu_poll_relax() implementation
+ * that is expected to be cheaper (lower power) than pure polling.
+ */
+#ifndef cpu_poll_relax
+#define cpu_poll_relax(ptr, val, timeout_ns)	cpu_relax()
+#endif
+
+/**
+ * smp_cond_load_relaxed_timeout() - (Spin) wait for cond with no ordering
+ * guarantees until a timeout expires.
+ * @ptr: pointer to the variable to wait on.
+ * @cond_expr: boolean expression to wait for.
+ * @time_expr_ns: expression that evaluates to monotonic time (in ns) or,
+ *  on failure, returns a negative value.
+ * @timeout_ns: timeout value in ns
+ * Both of the above are assumed to be compatible with s64; the signed
+ * value is used to handle the failure case in @time_expr_ns.
+ *
+ * Equivalent to using READ_ONCE() on the condition variable.
+ *
+ * Callers that expect to wait for prolonged durations might want
+ * to take into account the availability of ARCH_HAS_CPU_RELAX.
+ *
+ * Note that @ptr is expected to point to a memory address. Using this
+ * interface with MMIO will be slower (since SMP_TIMEOUT_POLL_COUNT is
+ * tuned for memory) and might also break in interesting architecture
+ * dependent ways.
+ */
+#ifndef smp_cond_load_relaxed_timeout
+#define smp_cond_load_relaxed_timeout(ptr, cond_expr,			\
+				      time_expr_ns, timeout_ns)		\
+({									\
+	typeof(ptr) __PTR = (ptr);					\
+	__unqual_scalar_typeof(*ptr) VAL;				\
+	u32 __n = 0, __spin = SMP_TIMEOUT_POLL_COUNT;			\
+	s64 __timeout = (s64)timeout_ns;				\
+	s64 __time_now, __time_end = 0;					\
+									\
+	for (;;) {							\
+		VAL = READ_ONCE(*__PTR);				\
+		if (cond_expr)						\
+			break;						\
+		cpu_poll_relax(__PTR, VAL, (u64)__timeout);		\
+		if (++__n < __spin)					\
+			continue;					\
+		__time_now = (s64)(time_expr_ns);			\
+		if (unlikely(__time_end == 0))				\
+			__time_end = __time_now + __timeout;		\
+		__timeout = __time_end - __time_now;			\
+		if (__time_now <= 0 || __timeout <= 0) {		\
+			VAL = READ_ONCE(*__PTR);			\
+			break;						\
+		}							\
+		__n = 0;						\
+	}								\
+	(typeof(*ptr))VAL;						\
+})
+#endif
+
 /*
  * pmem_wmb() ensures that all stores for which the modification
  * are written to persistent storage by preceding instructions have
-- 
2.31.1

