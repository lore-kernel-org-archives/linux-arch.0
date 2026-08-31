Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F653B813D;
	Mon, 31 Aug 2026 20:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788207837; cv=fail; b=JvKlOL6dM/Ewvjfq1odxArekflkUS1hHhl96NTJVAIHwl5O88mwTJoucPcdG73CyF6cjJU3Ib9OK2dj2U+APKFTJR0kQ73nz6d08105lP/+Zaz9ZieWcSqUD2KdBQSid6ANfdM8V3zXX1TaiGa0EzHW1ZeqzCUNhINcVAm9+AMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788207837; c=relaxed/simple;
	bh=/RmLj2rsEqNqE53Z65zqEUnrW7ZYL54iQA+x4EOH+Vo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LsXG6U4bpsG1Wm+jyd83XDwluzQrJERhO0jWB9g3KRn/Ive1uW3lYcYvmesfgb8BfIRSQzfW0PFjgRkGjobgp7uDeNDq33MtAOs6RifwxR0lvUUWWoE8/NnpUkEPKKScU2aT4Ut/9MMNQDD5jhiXZoqI6i6N42OuT3PYshTHJUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bkssnKx/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bwEixmXg; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bkssnKx/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bwEixmXg"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VGBhKP1799373;
	Mon, 31 Aug 2026 20:23:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=d0AtsFZrrW2zUrwyO1RIKoPj5qmFKDCDI96yDNbbACM=; b=
	bkssnKx/YxlwbDGRR/3aDtZjBWmLamYcohBbHwI7haP4s5HhXnBjFnVtFPk0ytq+
	KJKP59Xk8vbCtpFNcz0zwqHsWvh8MES/qHkZAf4iZwc6m+f7LapU3tUJYISu7R/H
	B/tPiUSzatFReuFCXJqz2BWulN7x3PJllql+3U0g+B9X04UV0O6ihitfdBaWRoYZ
	ewqJFd2zX2lMVipWV4ebrSuHozCA6VdLNXprg4blwmk5k1eYaF0clQhQTnZQtIFH
	5CspyQYuyFUhQSSVtdf6sQJ37//aLIM/Jzxzhhjbfqrrukkc/VvJpkRECInESJd7
	bgAfhiezTjiQuMsOvJC19w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gbq1skb3h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 20:23:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 67VKK569033202;
	Mon, 31 Aug 2026 20:23:24 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012049.outbound.protection.outlook.com [40.107.209.49])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4gbnvdc4s7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 31 Aug 2026 20:23:24 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G5trtmEqebMM4KW1DJoZjqRKJwJgJ1+oddOULAMf8xR9i1F+J3/qPudwFUF0eFPQk2cdn72+BSkCTUrdzuqKnWOBxHSS07soqnypHYXuz1pCdoswv/0azVb2eonbm6qsa7jVaXynDt0bgDq8Jc/XPvZbgE4+V7tY0+ezjCurSa24UO57xTemBMjcgGHAdZogVGrs21WuHSFsiZwRiofUR0C169catdgyHVl3QPnkKqKPYmNaTzoBBNicqh2bSbU9Td2Z1AnBDb62FB30KD8yew5QIX2LFaEzjGPPsaIp+QDXB7TDTqbjkVsVJdVdukKmB1cnEMfbCfI/V/aRtsUPLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d0AtsFZrrW2zUrwyO1RIKoPj5qmFKDCDI96yDNbbACM=;
 b=JY4nvfdioeljEsEVsfhI834RtNR533QGyl7oUzzV6OOi/01VLOY2D6I9v+yjfjnWjM8QrFhJBJyt2FhSAkyHRvxfudrV2lUDHmhRTEl3am2G4nFyrQl4FC0fbmFJoANG4u3T2tBmgGymzNhEICl2fohkctGWjFp1wVFZ0w6AewlMGNvOFgchrEIFa+vzaafzfsoDVhZRq3vsJ+ucOddQ4DMjNITNhGDtrrnPWHISkFZX5UvzY0waO6C9Vd6Rl/coyQVvbP9xMCOD085OWQJDeNqe/IRAt1xUNaeEIQUfA/nPZM4N6q+FM2pSXbJ22cbXlTgDv3g7ALVHsJhQWcioSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d0AtsFZrrW2zUrwyO1RIKoPj5qmFKDCDI96yDNbbACM=;
 b=bwEixmXgvRXp6wVb2/r1L5t3OkTa+pBtB3DDhXyOE8k2/Bet1ee1zkummV/lq3pSm56f2TILnTS76RFMnRoVOcE6+UyiH5HjogEHorSWGPZjZkpJDw6mwR5ty27oPiaJo/+DNnLVq2DNzPKFElqkwnYGaxkhd/w1K5WupkZxkWw=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by IA1PR10MB964822.namprd10.prod.outlook.com (2603:10b6:208:5ac::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Mon, 31 Aug
 2026 20:23:20 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.21.0382.007; Mon, 31 Aug 2026
 20:23:20 +0000
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
Subject: [PATCH v15 10/16] bpf/rqspinlock: Use smp_cond_load_acquire_timeout()
Date: Mon, 31 Aug 2026 13:22:45 -0700
Message-Id: <20260831202251.305046-11-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260831202251.305046-1-ankur.a.arora@oracle.com>
References: <20260831202251.305046-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0172.namprd04.prod.outlook.com
 (2603:10b6:303:85::27) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|IA1PR10MB964822:EE_
X-MS-Office365-Filtering-Correlation-Id: b5d9e06e-c580-420e-6364-08df079db2d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|366016|56012099006|10067099003|5023799004|6133799003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	MYM1PpgdtPvLPx22+nSM20Zge1EToDr+Wh3oaUlOSvtP1uR0cPmJ51DAYagXmeL4y/y0ZbMRmmBmvkVGNc4trHvISBBgf7G5qOA/p7nYHDQfSAn7JgCBsuy21fFHmERUIP76YIa5tF4ceL6BFkgb/JqY4GJObTeXF7JAw9Vco5GEwoN6sawqZmGE9HBXGtgcpXBcpf3hRA2Tp4/x9jXzrLicf8J9JA9FMaBUNhUipKOPo/kvQXyyrnc7lHVNmKcfOr10cnXI1eZzB6pSzvxMKmjCs49FhujUPPw7MVYUlO1+7hNhaoTvVCG1mzZr28ycj7UUD7XSNOAghsFtDEYpA9qWHn7e27FKLE3xaFp7IFTaggw705VlTxJmXRMzRq/t8fozxrwl/i8LNDsXJVJ3VWBK6Nkshk5K6/EIzcSD9dws5u9K/ybSiI5vvk6Po0IpANJE0HQx1MGXMEx7lCXRF9EtdqXORT5Po0bI83x8D4A7tmWwGZAxYCrT96mMMqDJdtOM8vnpKLHAtP2HTzppsEv3BN08rhHhQ0PifyzAEUgBteS9+GDCh4KkgvFPdkpFFOakb54FfbybtoX7UKpUC0jo1zwvxsAmAU5HNohkIv89L9SdDZnII4JYJBrBxYO4ZWesRrT3gCq2Wih9B3+bbcQ+Ot9EbdnoxVNYHLY7Hgw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(56012099006)(10067099003)(5023799004)(6133799003)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WjlJKDTX8xZ0+a3YrXNKyOjLLNAQ+7r0+CVhFQ3Xn+FjA/ttnBJY9PoZg5Hg?=
 =?us-ascii?Q?tgg0mlSqLyca09Pe0UYnfs45HQU38IHfBxQQL2iS716Gh46QvDNjvNyAQTBN?=
 =?us-ascii?Q?Fv8+1Er05pkquAnIK6dtbwXNjBJGnqrjlEu9JCK3Q91xWAPwVIJ0BWz9QE4g?=
 =?us-ascii?Q?f3QfmwEvz9+iYEA11m+st52AE6EZhePLP9maNhOAfXE6mMDoPxx3SiqJmIyb?=
 =?us-ascii?Q?jLCm+c7F9MUp68CABxMbVWiE3mg9drlPnprOoIfXtgkDaHE6y4YzT+NJVfb7?=
 =?us-ascii?Q?Grjw3BEvb7lwYbRHUAdo6KZ8EH0obFNdFiNWthxHjj8Z6HeVvTQ8qLJCkxfW?=
 =?us-ascii?Q?xcnuq55PwZn7ar9WY+3A41LlBLTPz+r4xZg+YqxTvihB5GTcJ5J8qCF5oo6y?=
 =?us-ascii?Q?C9xs4CZIjPQ8BZxr5e47DFV5+OPWFm2HEfHzOSmFa8MZO7e0lTPnJ/hZw6i7?=
 =?us-ascii?Q?g33a7JtaLjCk0XaCSPl4Hg5AzWywA2QYer5cqBOPoBADeAjbapYLWK9js7/1?=
 =?us-ascii?Q?ThVf1IO1lL9noBYOGWSzXJojY0fV1OV5ydXB/sbl5H+AIn5m2ICIRklRddLD?=
 =?us-ascii?Q?YvlYIeMFoWpZ76SfhLJIgErhk4jU8J+TMhul4iGcNy+hqb/OG9cDnWf4DXWc?=
 =?us-ascii?Q?XZYGL07G8p4i8l2EbWfjR4hRFPH4dyJsp1Tj7FtLLtCLGOI6dKSN3xb2Pl6P?=
 =?us-ascii?Q?ogo/GGwpkkUmxhNYRdLp5Uk0CTvCkvlQJeFR7LrbdXj6G0YUOdycH0NFscF3?=
 =?us-ascii?Q?FpBD49A6bbbBJrhaJl1moP1jHaHezVhWwpeeheLl9SFOE6FNacj0Gz6Nmb2y?=
 =?us-ascii?Q?FU0WInJVRUNUNx0cFwH6JEzv3NAPmMpLDN6zPxDwX6YYgKxSafhyJhj/7qa+?=
 =?us-ascii?Q?9Nm8odGaYCGmPlbMt+TdDd78THpvbCfpE8LvR9XX8HjiiWK4vlv57BMT9Aql?=
 =?us-ascii?Q?hUu25Hy2TGbL7cZeidy4P7b0nmUEaAAjW/WXrXRcnNaHW9udkjyfTPa355/c?=
 =?us-ascii?Q?baqD6/hgnorWLffdh9ygGAgZEa8ys37NZz7QRiJBbBwyCm5dlQAAlp+zo7w3?=
 =?us-ascii?Q?6stA3Zo/z5i7Di7Glo7tlXkvyKAfGrWRtsOPEEbh3HQD7p0F3z8Vb11h/GtE?=
 =?us-ascii?Q?XYbxnhTBGumPvS6fuEzh9ZOrhFbC9Dqoym/Gdy/Ocm4NP1+hmoT+OkWh0BtX?=
 =?us-ascii?Q?f8PYbDRXxZWswJb4jUeLT+etxcEQJTyZb0GmLaQzHvLpE9j5Vdv3ruEcnihu?=
 =?us-ascii?Q?X5vE8a0ZWhuyzgLcDAHozYf39dq3Dgfjjv/yBL6dkVFz/sbSe0r22G3f4Th3?=
 =?us-ascii?Q?BPT3EYTqxoq2r0Z7n0Pq/YrFdtJObIQYP8GAbkLRJKPTibiHWTTkASgmhs0m?=
 =?us-ascii?Q?uRk45QF3tQXYiXmg/p48tc1RTLT24+MVv/lFo7XsdvHEIbktcgxKg55SD9Mo?=
 =?us-ascii?Q?2Q0FMeXNA5eVhFMgtM5iEaqxYQ3YVvEaYfGlDrmAXkJjMOEQgVJtgAPKjUfv?=
 =?us-ascii?Q?6v4C6w94YWvbBmw3I8sXcVA7XVcpDAq0WR1gAAlysGnpdDj67anWIAa3C1Sv?=
 =?us-ascii?Q?hUCLDvaoe2jAAc3VlxBn7F0RKthqzqbx7CFVrPi4s/l5Y/QoAaubGtOe+bOV?=
 =?us-ascii?Q?7GRrNF4zM2S+/vKo5Tv8OP1gkEcyEM9uCIdkE5Uo9n1QC6LWgTKzA4YvPKIj?=
 =?us-ascii?Q?rRZf5a8vmYJv9zGHQv4ANzmE1nhpW5lbb2JxGkg3CRL0mFPb2NMyiuSBO5Wu?=
 =?us-ascii?Q?/pDSfkso2vukTmxQWGnkQdQhdZcU7F4=3D?=
X-Exchange-RoutingPolicyChecked:
	teLRqXN4etZq9Y7LO2TCXp0uPqnED1NZQx1A4AHHL2snO1MyOOgKnSWV8lV7o1xMu/F1bHnKm+7aW0ENZFESE20gQZC9U4JbfB3IOe5+wZvgnoNzu4aqJ/pmJPNhXpJbIAVjROtqlo1eHEtyHZGNTizMIfh6ZUQ9vbCUkgipJjg37YJ/7DNX/MVj46IDI7NdzqCTx5ryk0Zqq1O6MR9fqwWB92/gtgeDSSshZMQ2Ur+RnGfqqoyFQfIarwaKWtSiVf/iistLlSBHYLLNLqeqwd3sktY1c+Tm39J/vliW9gp3kUpwcNR5OFVJ08wPgFwi4pgKBcqHYwGQ+fKyBcoLMg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Pbf7TOFnwllijwdyIKxqS7uU6JaqEpssZEcfZtxAA54h/YMJis5BLMr65R8PRzYpHTrDAGnCvXu+BKfyK+6MosNYQThsfngG3yrW7OH+pAvwTEK0o2Xzo2OT9gdNui6Q7C2gDuCDQXaMRtrxBhdYcjl37BBZ1VwPtGleRgn24+9ciJQrpbIoc/ltxAN7acHbvWi/oWMgCebwnmOE0jbXk8DK0dS+AMOfdJZrOreJwRDTXTlCHmuxdwLDva6d26SKoah3klyDI4b/gU4V4Sc5wk5UJkJMYLObhtICtqPIvfgtw1tDuk1kOq1ypBks1J5LHX+YUjnUmbAzEpi2mJ/9uuUfdLXVjaW1Dd+7Bzp1VfJuIgEQW97O29MdlcJf0T/T+8BKCcpOtPghocPWAVg+0R/1/QxW88XXsmyTpBnsi9L5tRCIBEwbRloCwBrqTkjrFW0+sl3sPLfA2fa4szitmmLdwmrk/RsNFmC6j0bpXDso1ujkEST0BZRZX7ke43V427/mM7ABzP9RTZvcKY4enVn3ZvMm7B6EvQm18q+Fdq7Zw5VgnX4Qiu8e5qUgcJTtYSwDwdcZM/9JJ06hX/R512LyhFSwcQ4RXE2SIpTcRsw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5d9e06e-c580-420e-6364-08df079db2d0
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 20:23:20.2160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4KUBLB9MhfHnNTmfB7n/WVeo64vKZ82wbRBLBPa1cFfgCNntPJyNsfIDqGonn1tE3IN0ycowA/D2LdwotodExqqqbCLilALDGj9htD5ckCs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB964822
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_06,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2608310176
X-Authority-Analysis: v=2.4 cv=Vp0Txe2n c=1 sm=1 tr=0 ts=6a95e2bd b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8
 a=Ru_WXoCZngTtvYUXGSoA:9 a=WmVTiCyuxqgg3mnwYu6p:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDE3NiBTYWx0ZWRfX/v+kqaGd030v
 Q35A1JOnzYfl+3c0WRueGcg8eBjG9YxNPR+0TBSsTfCHzkkWCvq9qJcm3wY6tLS40hdG+KtCYni
 0Nw2TjpI9Oytaz7uXqWcMfc3r17mfQhTRNYm8sWQxLTD+58977QOKfinGNrAPo8ny1x9CZquvTI
 2YelH7Z+M5OAtyBykAsm/U5OS8nGvLzfpK1jXhMlfU2bZoPF14yySdGOCq0CiPdCf6LtJhHmD6i
 CF3QlKsNqKpqBTB0oI3YTDI8CuSJB0+aNiiTu5FETEVBOlN1UGABO+yjYHeFcG9NSZVMtl5SMe9
 xwLTI3nY4qiT0TOIiKHGXYcAGqw58EEiJIIjfr1KzgN0ggUO350ku8gUfSs7fomEgeb7ZeMgK2H
 FbONQy79XsxxIcZeDFFrX3FolBPp3BKsfw+1Wzjxc5co72M3zVV/4HFWQlyASCA1e8VkjnErLnt
 yWMZGo9vY5nm3WlysiQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDE3NiBTYWx0ZWRfX6xCZIZyDDzRG
 i0gYEF7yfrFsegnu5mcBLK8PR2FXROGlDtitF0A5qL2hJ8q3fk1RXpRm/rZnSQDsbYFmR4l+AV9
 JR+CXL/tomeRcq8tAgO+if0/dQh5q8ikyTBlyDnJhVeE9Awo6LLH
X-Proofpoint-ORIG-GUID: xEKx6AEQr7jMpppIYoXOUT1RPzTRwPEX
X-Proofpoint-GUID: xEKx6AEQr7jMpppIYoXOUT1RPzTRwPEX

Switch out the conditional load interfaces used by rqspinlock
to smp_cond_load_acquire_timeout() and its wrapper,
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
architectures lacking a waiting implementation of cpu_poll_relax().

Cc: bpf@vger.kernel.org
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>

Note:
  - when overriding the SMP_TIMEOUT_POLL_COUNT value check for
    CPU_POLL_RELAX_WAITS instead of directly checking for CONFIG_ARM64.
---
 kernel/bpf/rqspinlock.c | 41 ++++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/kernel/bpf/rqspinlock.c b/kernel/bpf/rqspinlock.c
index 1b249c6f0674..9e8f19afd7b0 100644
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
@@ -269,6 +267,18 @@ static noinline s64 clock_deadlock(rqspinlock_t *lock, u32 mask,
  */
 #define RES_RESET_TIMEOUT(ts, _duration) ({ (ts).timeout_end = 0; (ts).duration = _duration; })
 
+/*
+ * Limit how often we invoke clock_deadlock() while spin-waiting in
+ * smp_cond_load_acquire_timeout() or atomic_cond_read_acquire_timeout().
+ *
+ * We only override the default value for architectures without a waiting
+ * implementation.
+ */
+#ifndef CPU_POLL_RELAX_WAITS
+#undef SMP_TIMEOUT_POLL_COUNT
+#define SMP_TIMEOUT_POLL_COUNT	(16*1024)
+#endif
+
 /*
  * Provide a test-and-set fallback for cases when queued spin lock support is
  * absent from the architecture.
@@ -296,7 +306,7 @@ int __lockfunc resilient_tas_spin_lock(rqspinlock_t *lock)
 	val = atomic_read(&lock->val);
 
 	if (val || !atomic_try_cmpxchg(&lock->val, &val, 1)) {
-		if (RES_CHECK_TIMEOUT(ts, ret, ~0u) < 0)
+		if (RES_CHECK_TIMEOUT_AMORTIZED(ts, ret, ~0u) < 0)
 			goto out;
 		cpu_relax();
 		goto retry;
@@ -319,12 +329,6 @@ EXPORT_SYMBOL_GPL(resilient_tas_spin_lock);
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
@@ -421,7 +425,9 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 	 */
 	if (val & _Q_LOCKED_MASK) {
 		RES_RESET_TIMEOUT(ts, RES_DEF_TIMEOUT);
-		res_smp_cond_load_acquire(&lock->locked, !VAL || RES_CHECK_TIMEOUT(ts, ret, _Q_LOCKED_MASK) < 0);
+		smp_cond_load_acquire_timeout(&lock->locked, !VAL,
+					      RES_CHECK_TIMEOUT(ts, ret, _Q_LOCKED_MASK),
+					      ts.duration);
 	}
 
 	if (ret) {
@@ -582,8 +588,9 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
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

