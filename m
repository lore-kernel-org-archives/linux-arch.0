Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1797B281525;
	Thu,  2 Jul 2026 01:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782956063; cv=fail; b=T6FHqsWtJ41y89sZeO2m/djffmis0S0Gu2QGFTyNd/B46FQRlth2iNzZa2qEIwWJH/YhimINxMp+7XOf/g/0YmaI5/5+oJxMu+JyqIdcFm15EYGNfIF3/Nl8rODSzeTSHaiw2HFEy74aDqijkkq5eP4SxjTe9wa6RvIoUhfMcog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782956063; c=relaxed/simple;
	bh=YAaMmNb6IOY6TrrY/rpQt43UEmLsmHachAy0k2TJG/s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Jy1nxP7KMLPZPleZSA5XjJ8xyspvQfKxW5gNsnNRBh/Idz4j+cdXBsIGEXHBu1XuZl8NO4543Asm6gtLWgq5GU+ejgEZDcOdy1mKWFUhdcUFy0RFo338XhC5lPGpEA+IfP6Maq2g76bHfAwot/aVmPl7z5XqrBEyYR/JR6Tp2QQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ELhevkU7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cFGhpV+5; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ELhevkU7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cFGhpV+5"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661EJoF62783072;
	Thu, 2 Jul 2026 01:33:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=6n7bSZBhtF9l75cWzUqXT6k25501/cO8HE32bqQm7lo=; b=
	ELhevkU7EgW3djtGMVRtSp3gwHgvD90DtYuAHN8nt/SJaYCD71Q9qE90K0JJac0n
	daCFXkLdtYzQjHQt8dUK4w5iKOYD84fIvLTOodufiPGLdCn0DnexCJKiAmLAwOlS
	fc5t4I+EQiFu3mj/9U47Sc6AtekxhFHkcoi5mLDIROfZGaxntGuD7ZH9fbaOKJ62
	7rCAVLYKVrkKpjt0weCj92jsXWyd2HhUj6Mng241BORuAO1QKKVRGhPBHGs1kJcT
	DWJ+Hj31l59yWsOaR/tby7BcIlG/5l2cLhlCU8ZnsThcy3wlWjd6RCv1WaYAm+x7
	RLVI4IPG2ufGRHeGFiW/gw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4f272qq6rh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Jul 2026 01:33:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 6621X7hK036276;
	Thu, 2 Jul 2026 01:33:49 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011068.outbound.protection.outlook.com [52.101.62.68])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4f50yt4ew2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Jul 2026 01:33:49 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=afpwI1v2opiKMEHzFJHYnXbaGp5DF5etMp7B9mSkjrvTvdi33YkgOB0BN1uIW2BpfAtSjS0XaJ3J1Imh4angInZU9nETEV7B1Wh3m71Rlh/SJIspnoIhL8MRcKQBTcMizUxWk7zBe6PoQogQnn4NlwcOkM1CXw6kkmZSAFX63SqNfjJHHmrVIqUQdc2oWPeLUEK+IRmPCuagihbgBERsIiDg1VGLPUmtKBadwyEcQZ87mJJ/v8XCQUI25b6twkklQoYTxxLOlQogCnOIBlo5co+YaipCXbpzbSNx+PtaTI0gAwk7J1zzfiQnz1Fjl0Of3Mbu4JtrLDnOB1CDbonAzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6n7bSZBhtF9l75cWzUqXT6k25501/cO8HE32bqQm7lo=;
 b=NS3nx6tD/eO/4CfSKNCEW3EbU/Qe09zvXvSnhbUwVhbFzdHIYwbTju4Wg7WY3X2hyqQ8HgqimPjxYEgF47KGUcjrULrlLEGRxtsFz5YV/NgyYLDC0YjV3tLBFCAkxtJfdCHCOEwsnv7ICrbxiqr7oSgxzLaQjPwNgvZ8F0LwMLJWeNXPLsZs9YIdrimhMaGioK/6fYmALMIDS0XjF7uVlD2IGDy1nEYp9wx4fQENRK7JhVgOJYhFckZ9ActCfnxM7j2SAL0/n7Pf788AROsQ+IpQftmA+RmMOaH+drXMhcz8+pqvqTM+CdA4xjN72DcO7XnJYlYBup/7pI8jLvIbcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6n7bSZBhtF9l75cWzUqXT6k25501/cO8HE32bqQm7lo=;
 b=cFGhpV+53WJKf6CSKMvm1RzuC3IIwtjg4KtT8jRryQUomwNplftj3H9oJ3rgL6srRuaZ1+YWLs7Ik5S1ll8rwqC/hg5xLWFwYQZxlJrABt5VYIaaAFdJwiX+zmQiVqNPh4tpEAkq16pXIoRsdWUQkAbgvMQgCjKfZkbld6IPXbU=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CY8PR10MB7314.namprd10.prod.outlook.com (2603:10b6:930:7b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 01:33:44 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 01:33:44 +0000
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
Subject: [PATCH v13 02/15] arm64: barrier: Support smp_cond_load_relaxed_timeout()
Date: Wed,  1 Jul 2026 18:33:21 -0700
Message-Id: <20260702013334.140905-3-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260702013334.140905-1-ankur.a.arora@oracle.com>
References: <20260702013334.140905-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0143.namprd04.prod.outlook.com
 (2603:10b6:303:84::28) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CY8PR10MB7314:EE_
X-MS-Office365-Filtering-Correlation-Id: 909369ca-2164-48a3-c96e-08ded7d9f4b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	kNkZkNm/o5A6B1TNikyv0gwL6tPC8Zorm45joV3OjuegZICvye104lvjGpdgtnJfQoh7XXPoUYWS0XhyQ2e8zNVxQDqgo3aZ8JQ/8IandEj+Ab/pzVw8pKCaK34dkV3kODQA2f7VtjIsCgxSwHBpHk1HkjVmIKIMXQoAeUfPLRU345dPLGFgJYW13lnrV+cnAMCPFa+Udh714uIgRpj7eCgZKSZXTGEcLdKZy10W/5LjMSEbE0SIR1Vz8epmVqT8kKy8OEfBvuSJdgTwC+HDNzNMTnOGmfOWym3c56MqwnlH4x/pyOlHLTEv7Ky+dIUqmFILYQvGHH+U0hrjS7izxp+6s7g784Iv2g8zzw59ak5037M/91yt4/q7cqe87crq1UK9Skjb+GCZHX7gpScWIkpkEWM15hxl40XQHDZR+c4QGnPgzUO553vOoYTC+C93hrg9R3Xw2CloHnZcSrGvDTYGIF2+8hGYFOj0QdozQlKQwCquEs2IKc8FWJ6f0bXx7W/hlbuuotCSIQKwU9fJEuNIrL4t9TKNMIWdPF3Hnbk2IRyO+L/mqYv9CW8Zwp5adZrNaoOubG4vWIG5UCuqSq3CC5j7NDflhB+I/e3vZgtIjTOAxqaKpd5sPAv+p8aTvocSGYL/tP+Wjwv5n3utGZhbhdfPy8Nrf6lCNgaiq1Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jZEIi875eecEi9Brc7p/dsCvbl7lW4XdOxsB8btY/HzKqQZ5aJgapUJIFTOc?=
 =?us-ascii?Q?tS4DVARoKepFwoNbw7kxsFGbDhgLp4zIcT9JDVH4qH8rfn82N1MaSM9SBIgw?=
 =?us-ascii?Q?zpq9TOhwoyBoYTdYjNOquhasySSDdpcfZK5/gQJu7gWyRtWQx59YyhQrMIsm?=
 =?us-ascii?Q?XODoLRikb1VF4c6QVRHHdx084VlD1QDx94Tp9cM5uhCQ6twK1awzDWFgjQ9p?=
 =?us-ascii?Q?Rpb3ZwKa02GEGIEYrsM7NAiQc/XyTQt3gQURUmys3Y7ecVg7coB8ZXznnIyA?=
 =?us-ascii?Q?v8hgMtORgzjINDqNGGhSno8AZKooYgLR0T5kwr6+LkiZBH1cPzGVtcJLRv3I?=
 =?us-ascii?Q?E9OulqbiCb1jHr1ggZPSS1M+t3uc2u+d/N3d2GnmDm7xakvhLtkOWld92+l7?=
 =?us-ascii?Q?1R/Hfaq7tFv5AAS1HomNF9OfHqpvphxWuMXVf2Jv73BuAUMIbe7tsrGpddD+?=
 =?us-ascii?Q?naVTR2aqpizaUySn9uW/FotvMfe3kSQ6ZzwowPaoBC+tuIyDLUy7h4G3HPb7?=
 =?us-ascii?Q?2A0StQCzAuZVDoKkG/r+QQy9NMW4X4r6z2XFUV/SLRxgFNcJUKCeydEvyK8G?=
 =?us-ascii?Q?VkSHL4lkOpSmd40FrjlkNpSEKbHSMiDvs10ufvfbq9dxufEKQgpXqHGNoWjo?=
 =?us-ascii?Q?54dxJEuvj6cFc/o9vZiX+pFnb37qrFoLsFmNwMaZJQpY1fstn0P2qb6eAmJp?=
 =?us-ascii?Q?tS4e3YgOfpxUE+W3jg7XcaA9yHbPCObtumngN3iRrL2fpqFR8pP2K6McJFAW?=
 =?us-ascii?Q?KE2D2aaY/ZLrxQRQcKqqcZexYEYrIs+WAxlEFk74jKt4JYhVZdiw9PwhP7r0?=
 =?us-ascii?Q?GsRpqywX6Te/V6aMJq79jccCi6aiCZHCc/0j0omVgFqwaJZVBYQMyJnmcx9Z?=
 =?us-ascii?Q?sJdBspDDF2aOxpCXkYXFvUbB9OmvR8z4+jCDPx8SUeeuYk2zsDFGPDtG5dzA?=
 =?us-ascii?Q?OKY31aGipwQUL9NPTNH7kTsXmXtgkyWjhqnkKH6InIFPr+loDkYnGIi8IOeB?=
 =?us-ascii?Q?D0inlPMGdfr/cJGoAZfZlXvSo+b3Pf4+wXmQrki4VWBfA7Mx9fY8FWycdCHy?=
 =?us-ascii?Q?8rCFioF+oZP9qhREtbd1jvrMoJAg3hq2kouqYbqxqP0BqQMd+Zw3LIMdawsK?=
 =?us-ascii?Q?sMppMrrW+SFgLmqDeNl2e3SZLTSYlgiMFCfy2Yc6m5zXs6kikYNzB5TnPzld?=
 =?us-ascii?Q?dCslCAvrh+RasvQq0G3Z3h9AbPzKwiRmEapWce/yMJL5Uz76CgPsAvxNbUJm?=
 =?us-ascii?Q?vtg03TKrZ/deiSIhFIMfHVTftL85aZ6Be44W8zHTsxOowPFwAsmL3vdnZ2cf?=
 =?us-ascii?Q?FRGcvd3RN9nQc28ZmN9SZkW7T0daIYOkwgiKp7TorzRJD24sZtXjsunv1nTg?=
 =?us-ascii?Q?ooNd5Anr+jpMndL0HfS2W3ECHtnaqfZ8Bg/SsA+eyGqKlfZ+rSxlP9bacviS?=
 =?us-ascii?Q?Y0RXmZ4eFrVlHl9ZEGxV6Y38EJTPhzBOpV25bntJy6DTRmhKdWS7+0kjIK7Z?=
 =?us-ascii?Q?UQbHQOa+SFBpklbsC9t5NcQ0q6wekScBKWuLvrZIqhWVtW1ytWz2AX5ZQy6G?=
 =?us-ascii?Q?YCD4y+UOx5+RitsTMIwWQR4/nsr0A+e1yBc9jMpAUf9FgnmH7SGeyOkel0eo?=
 =?us-ascii?Q?jved7vRaxKRuU7wY6gHlOKUwBkmFvwK3SuG6aPbURseNDU7ln4OWcMsU18Ht?=
 =?us-ascii?Q?Se+7x7iEyXFYmn0FkmOBzWFOUtCEoxVihjneQOWMyPWUDszW/79GRAZo0j7f?=
 =?us-ascii?Q?8XsDPCkoUmR0DTGtmNartF3TFX0pMls=3D?=
X-Exchange-RoutingPolicyChecked:
	C0GxxHbdiCEh8oKqDRv2bLOMox8+unMvj37ntPp3qUNIKJMnTakG9wLHbN+FBWqyR7Uvz6ox4qmF6niHTdvZLwri0wcdYUd82erYU/18tZC77WIy8T0jVwWtJO1Q6SkC0ikHGXbO+yEPEaKKOd3l93FtGY8kA84WRs4DAC/LEXlGuRrgaF1X9I63bOo+9w/qnhjbNauwR8Uum1DQv38M6Lb2S60geqMVbBQwN3tH8EUy873fSRD7eg8WbUF6mnzMYa4gp8/0HhXA+EdIGkXRsSUZV1UdjC7ANJlXMqMyDuSIgMxB52OKxN8lchvcAElNJIGCN3ysm3ZoxHQaEXLZZQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dNwEa5DpGt4qICix9jr2krH4iY45xMhim8a/5MyVEKLQYKFZQZUEa1esjTDIcnUiFXAjL4oeZlNxwXKZuMNpwarMs+WCXms3mkRxlhDkaJog2U8aCHYpTqUlclE1IxpVyXAQEilxkDM03YddM78VH5A8CGOGqn4d9jabCeM3Y+LqdwnI5ioOTDLBD6zZ++6/8kL1yTdRI/DNJ5PJ8JTCo2aw5uCbPnBD3dNnwa1Pl72WH3ekn7nl0/gFobWJo5H2qURK2KDjoalzK+LZfahKhdF8j4AcK/CUyoe5oNjyv1PeYcry69Ipm3KZ/ERdnYJAYIUh1zQCm+/eynkqBsKmx9LwZtuvH5t9oLYXZCpIqc0rRhZqe9LAb1Lpr6Lw7XWzskOs3YTsvr19fdi0WV+FURZtNBYQv6+Xah8XuBhF2Y4WmbYCkp3z9bMFTJjedwotGIJYySAk8oc35LRtpdGzvfoNPopwowIU5NjnU3Blv3K4D7S2f+O6MlNMSoRvcwLzCyXCP0YoQrGyLaKAyYy3xTCii4T9uKUrkklmMiU/iEq5Za50xjmRqPZ7N2sGIlyj4YRM/jxppSGC52kJ0+y0Vq+AMehJa20LhqTEHHRMYII=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 909369ca-2164-48a3-c96e-08ded7d9f4b2
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 01:33:44.7565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r0iBxtw3uEvV1qRuqoaI5YW+rluEER8+VR6n60A/EqHJtaWExi6MPOd2DXC32dOOhXlgMURSJjSEZ7wPPPLo2O5AVJk5N1AZuSiDbH+ZjA8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7314
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=647 bulkscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 mlxscore=0 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2607020013
X-Proofpoint-ORIG-GUID: 7nGjo23FMHoj9iobu6HiKKgwbPAMRlXP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDAxMiBTYWx0ZWRfXx9HkS+ITs5zM
 /oOTMNSNcUIuTLeTYSUhuLRvdlIUyV8WBsILbOT6ZSL3wudYOB2vVPNvCEHCxHSMt38SB16sNE6
 rcQaavIk3jInGUHK1iWjCxvOftjBa2wJj4k8SqJVbSgdKXpdNY6rsVwUCsq/4NR6GcDQb9RZ3gb
 F8Ukf0vfKE785zkzKob9Dx7uJv+VpqYNGjj6AtY7+lgsGLmHPNm97pjSEQXk9qNnES1s4j+ji1Q
 jl72dD3RlgWKo2MimHZuwYXwvNT8q0zFt3TI6mI9MqbUkQXem1qYboRXMJnEZ9Btx8xy+5z5GV2
 MhZ1JK9H8QDYmhymBeckMTmTWw11iQMwrQNJbTuWGVtzYGN/p8JstvXQgEYLWKd1o26r4WgkW4W
 LtVa4y4otMoTa840rAKm2ec5gqSJk1s52FVn713Xf0k9TvmbrPEELPmPXOCeWsD3t0Bo3lmwAiq
 TxWh8sqZp00azCOckyQ==
X-Authority-Analysis: v=2.4 cv=LOxWhpW9 c=1 sm=1 tr=0 ts=6a45bffe b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=JfrnYn6hAAAA:8
 a=yPCof4ZbAAAA:8 a=x6ygOChz5MOYKFFXTgQA:9 a=WmVTiCyuxqgg3mnwYu6p:22
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-GUID: 7nGjo23FMHoj9iobu6HiKKgwbPAMRlXP
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDAxMiBTYWx0ZWRfX9QnJo0vedXcE
 c7BujmS56unDslaqrveNlP2MBh1+ZvMfUHqq3+/wa/8EpK9xcBQKChNK/x4gnwPrigPfwI8Thyp
 CI/xKzsf0erfgEswpISXMWhpItQd1whSeaBveeTwvSqhpCt9lvps

Support waiting in smp_cond_load_relaxed_timeout() via
__cmpwait_relaxed(). To ensure that we wake from waiting in WFE
periodically and don't block forever if there are no stores to
ptr, this path is only used when the event-stream is enabled.

Note that when using __cmpwait_relaxed() we ignore the timeout
value, allowing an overshoot by up to the event-stream period.
And, in the unlikely event that the event-stream is unavailable,
fallback to spin-waiting.

Also set SMP_TIMEOUT_POLL_COUNT to 1 so we do the time-check in
each iteration of smp_cond_load_relaxed_timeout().

Note that with this we have enough to define ARCH_HAS_CPU_RELAX to
indicate that we support an optimized implementation of
cpu_poll_relax(). However, defer defining ARCH_HAS_CPU_RELAX as that
enables polling based C-state handling, which really needs
TIF_POLLING_NRFLAG.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Suggested-by: Will Deacon <will@kernel.org>
Acked-by: Will Deacon <will@kernel.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
Notes: remove definition of ARCH_HAS_CPU_RELAX as that adds a degenerate
implementation of polling in idle via acpi_processor_setup_cstates().
Flagged by BPF bot [1].

Will, Catalin: I've retained your ack and r-by tags. Hope that's okay.

As mentioned in the prior patch, not addressing the range comment [2].

[1] https://lore.kernel.org/all/23edac0734ee3ef334237165500d8f34e3c649081db7b3140a4a8596a202f339@mail.kernel.org/
[2] https://lore.kernel.org/all/20260608083135.6C0C81F00893@smtp.kernel.org/
--
 arch/arm64/include/asm/barrier.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
index 9495c4441a46..6190e178db51 100644
--- a/arch/arm64/include/asm/barrier.h
+++ b/arch/arm64/include/asm/barrier.h
@@ -12,6 +12,7 @@
 #include <linux/kasan-checks.h>
 
 #include <asm/alternative-macros.h>
+#include <asm/vdso/processor.h>
 
 #define __nops(n)	".rept	" #n "\nnop\n.endr\n"
 #define nops(n)		asm volatile(__nops(n))
@@ -219,6 +220,26 @@ do {									\
 	(typeof(*ptr))VAL;						\
 })
 
+/* Re-declared here to avoid include dependency. */
+extern bool arch_timer_evtstrm_available(void);
+
+/*
+ * In the common case, cpu_poll_relax() sits waiting in __cmpwait_relaxed()
+ * for the ptr value to change.
+ *
+ * Since this period is reasonably long, choose SMP_TIMEOUT_POLL_COUNT
+ * to be 1, so smp_cond_load_{relaxed,acquire}_timeout() does a
+ * time-check in each iteration.
+ */
+#define SMP_TIMEOUT_POLL_COUNT	1
+
+#define cpu_poll_relax(ptr, val, timeout_ns) do {			\
+	if (arch_timer_evtstrm_available())				\
+		__cmpwait_relaxed(ptr, val);				\
+	else								\
+		cpu_relax();						\
+} while (0)
+
 #include <asm-generic/barrier.h>
 
 #endif	/* __ASSEMBLER__ */
-- 
2.43.7

