Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9E146F4A0;
	Thu, 30 Jul 2026 23:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785453099; cv=fail; b=TRK2+zxGMJUwBW7+PwAr7TaRaUPPB124OUfApmoeXmSK/ML8MIq6mBrsZX7JiKvmRh1buXDtYM8GiCHBnQSRwfBaZDP6J2OsqmbCy+WA3FvhPfzJ0z5yFUf0XVd5xEC9bNNI6y9t+uBOj1VIOEZHswyyL970xlwLeTMAjJIJnLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785453099; c=relaxed/simple;
	bh=D+2Tkjjeu8ZbDPvoeQiYOLNXSGmcwNNlPQoOiJLzrlY=;
	h=References:From:To:Subject:CC:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=S6Sp0wgbTLGgqIa+9bRR7C38rD2vagoAzXdaOV4C6gcv1bLHLHwKQ1QowUdT9+OyvRNsnfuzfoS/JJwLEo3nhiVhjwVuZbTdelW0nUjveiXXxvueC9Ot8TjMY6vmzmRwEwxjTiZPcKMMpvP5GlJHu30RlfX3JIuS2zVH6rlK2D0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=S3WwWCVM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=q3SuMvU0; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="S3WwWCVM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="q3SuMvU0"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UEtnI41417276;
	Thu, 30 Jul 2026 23:10:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=2/a2qJTWH3PKYysI6s
	TDUkHkDHygfC2q7Rt4bEsbL5U=; b=S3WwWCVMGGfKAm1ZJ/LaH9OfvMA6KwGqII
	wAN6qNd0MIMnliyVHaIwiRD6Z5/VRFXRekFemsdSwvWd2sPQEqNDYQEajxWKKSCw
	bq2h/hEcgY+GRIscYmzeJUltIBtJQdggrl7b05UZ9TZLVobS9aYd1c45+3hbebE4
	hqbS0qv+SBdpumnRr4qdeCYDCge4w5hgjCIBpabqQSKrgWdlvDphZIPBC+00Tw7g
	AAGNSL0630wsFO2MjIuba2o5jP2WGhoMfewn1+G+KBVJvnMxvxe8zS9qlGp5M9uL
	pOGMiXtBSejJRo5I1RHOmwiVMjcIbUW3sBqZFftjcxR2E/eXmRmg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fmr1dghvn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jul 2026 23:10:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66UNAY0K033579;
	Thu, 30 Jul 2026 23:10:42 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011022.outbound.protection.outlook.com [40.107.208.22])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4fnh6fquxb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 30 Jul 2026 23:10:42 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mDFeIuHPYTvyUFsdwtpqXpjdLxkSUNsUEjb1wasfAK5PD/oNiOkz1IURjPIimd1N+mf5R9VGDaqsmuL0ZDmnIS8+xR8Q4WuP7Zx03p7F1UGUtILMQjdZXKwAIGBeSEa/We0/QERmnmxa9hokbB2r/zd1S8XjZR7tHQunumsGEdQ5uoPbpkBPfIuQlbPJ6ugPvttzs6ZXTXcTd+Zbbx3yQDQoeulxRpU6YbR2nYC74gNUQKLFbof2B12DPPvRj0STA4K68Ba6NlSs7JBVroNMW8vvOiyy8feX4nPfUUT4WycnkwnSxjtLFmchsTjUEUNwXrRdPMSRKapsbSKic52mPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2/a2qJTWH3PKYysI6sTDUkHkDHygfC2q7Rt4bEsbL5U=;
 b=cc65+6eFjUUbjebEcGT7vGOR+KtY7ijjRZO3JxNTxrIgXtTGbVJTImX28sriTpTFJN5aXwiudYY9kmlWq66InE1PlP7g/skC0vt/rU3YzujAg8eUAmwttgU55JfmuKhlB5bZBEcyFwPRUGDsE5rUd9rUS5J0emPCNthqL+ItgN+XgQncMiI12ARyZ21HbAcwPp8mViixY38CzUzEY3hESt3XFDRNyEVXUIMnX6z8wsTvdjT+ujr2BTvy9niu64RHl7D8bjcpsajwNpP8h8vRy7NcHFb4YfP1YJVvADAM772kgmfCfjwGYjvuHS7E5V4HgQ9ELRof9E6kamapjcQZhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2/a2qJTWH3PKYysI6sTDUkHkDHygfC2q7Rt4bEsbL5U=;
 b=q3SuMvU0pFPTX6xuT8kEX/lbhZoAsRmluwM0yHlIhEAf+jZ5QYzJ7vYWHNf12eqSUe5b06ljTnY8I7jlBtT4NvOee5m5KKFLNlnmrA1AaIzZfRF7RoMSGNjpEokBjlKYoj9eSYyDHmJiOdIcjHLUcAJsW4Dl7S8NbKbShg5fM84=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by LV0PR10MB997660.namprd10.prod.outlook.com (2603:10b6:408:33c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Thu, 30 Jul
 2026 23:09:31 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 23:09:31 +0000
References: <20260714073041.40250-1-ankur.a.arora@oracle.com>
 <20260714073041.40250-3-ankur.a.arora@oracle.com>
 <20260714075017.B66CE1F000E9@smtp.kernel.org>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: sashiko-reviews@lists.linux.dev, <linux-kernel@vger.kernel.org>,
        <linux-arch@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-pm@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH v14 02/15] arm64: barrier: Support
 smp_cond_load_relaxed_timeout()
CC: <arnd@arndb.de>, <catalin.marinas@arm.com>, <will@kernel.org>,
        <peterz@infradead.org>, <akpm@linux-foundation.org>,
        <mark.rutland@arm.com>, <harisokn@amazon.com>, <cl@gentwo.org>,
        <ast@kernel.org>, <rafael@kernel.org>, <daniel.lezcano@linaro.org>,
        <memxor@gmail.com>, <zhenglifeng1@huawei.com>,
        <xueshuai@linux.alibaba.com>, <rdunlap@infradead.org>,
        <david.laight.linux@gmail.com>, <broonie@kernel.org>,
        <joao.m.martins@oracle.com>, <boris.ostrovsky@oracle.com>,
        <konrad.wilk@oracle.com>, <ashok.bhat@arm.com>
In-reply-to: <20260714075017.B66CE1F000E9@smtp.kernel.org>
Date: Thu, 30 Jul 2026 16:09:28 -0700
Message-ID: <87qzkk2hxz.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0334.namprd04.prod.outlook.com
 (2603:10b6:303:8a::9) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|LV0PR10MB997660:EE_
X-MS-Office365-Filtering-Correlation-Id: 67252b84-983c-47bd-9ca0-08deee8f9cdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|56012099006|4143699003|10067099003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	HIPXxL7SaqVIsfJx0kDeNMgXcg8h4orep0yiTxbChNpaCzGflisX9JIBcqjbcm2W1KESWO4A8n5QTwNrM/KIKJw6XDuXncOB0ZckT4JeiMbe8OkMujTATmLcldq0SBQrISHDZprLtVs1jnTnOHivFX6m0G7oBmDdZNYrKEPSp9+p90qElWPZKNMjRhLBPZzgZAZwNYib/w2c2jWzAt8fWTOBKyxaMgEZX+yq1jyH1sy4MmRLwLwHZk6GxEN0PhGCC94oD7fW3JU44VhZbGnqbG5JvlzkHXTmExEaDK/09lJAjZT2BcdzCd012BJYH6tCGAaKRUdkwu5BIrX4rOwwKle7w7CByA26+kbVeB5dmdDTAaU2o6epDH2AN342GZIG7RyHbtJ3bJ93rUvPtF8sBG4zkEEA4hywtQqF7RoZqbqIRsY4oBCOGHeNWnRq1A+ntlcoAsHHm+bHBafJkgs6i5lZ6oF7UtbicWwxY85lKt8wMgjltlea/PvShXPnUob21WPlL6C+TgaW38LvT8UzVNOQwcl/SZk/p1mv2hmi0SuCGUclC/jme0S5JK4ErOnqukNr901h0oOWMvCIRn43kN2Sbl4tUe/tzaYIxZXvM5VXVNsuFUlkLlqeJ2Yb5GPt4Ww21RrCRQbDcNqmTqRTe0SJDTIZSB9eHnzRLbIw6M0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(56012099006)(4143699003)(10067099003)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BLzYXFeep7rQNIo/Wg58SjACv3AGu4RauGEqBh6pz7rI/Mf8eAf4kAwkNBiq?=
 =?us-ascii?Q?iyeft9k/b3ss9Sacl+dWg2SAUn7UnU1cFkkoRRtSn83NVxCoHabrXUroxuZp?=
 =?us-ascii?Q?4CsxXyIijkzy9KZPWQs4lt6bknTiLDhCMQ28bNSB4bVRS+yoVDVdZ/3JWseI?=
 =?us-ascii?Q?p6JypWyzo3XQ/AZlu9QjPQYHbmFnOhsjB6T1Jxczj/mzbfIMtnv8AghYdFAE?=
 =?us-ascii?Q?4AgL8np6jL9y0uJToPUIJw7MoBCIIYf1/WLkyrMSzW1WPRPQUkyIUu0tzgHm?=
 =?us-ascii?Q?N0vddOoqK5LIuD7+/7l9Qp3aYDjJqivY3Sg6lLHG+3fbWJIIaVtM+gO/eK72?=
 =?us-ascii?Q?w1AHkmBiuGYsUG3Agvelf07lmf28Vw+VoV4aVPbOHag6R581NYhHYiERiRVK?=
 =?us-ascii?Q?jR/iGFFY6dg98m0456Wj3qnQjlJr2ZKHdfa8Fybg3wUrm1Ng70A4FLiSQ/rr?=
 =?us-ascii?Q?N8PmhdRevcFpYX0t95iYvj9+oUxP/LWgn75u43JVIslfGNrBZenWEUb6LRu7?=
 =?us-ascii?Q?6q0StuRPemlXsWBmwaZCUgbVmnR1GccC1gB86GtKtek8+mzbcl44rnL+AsCS?=
 =?us-ascii?Q?9YWiOhwIG03T4EKhJFEzRTrjz00KWsY2eQ2fjDjOWzjaZ2pLnTgSwCWc+lkH?=
 =?us-ascii?Q?gPg8pBPf68Wjz7+BuAOGDUZYC3b7A94BXmif3+ct9aGsa5c2EjLPr4iwdBom?=
 =?us-ascii?Q?6/0HvoYXRaoNlywtMlC69GCXA8oZFOUigyDYvqTT5/DtP+ZQNg7CM9vn1geV?=
 =?us-ascii?Q?DgtaM1JvEAtmcvBP1xAtbi1QdNsDveDGqDI8TTqW7a7qcQPUr2akhWBL3ANd?=
 =?us-ascii?Q?qak2j8tETdYr7tfVGEjAqeFPajC9R1PRTLxLZHLKXMzdqe1N+Uv0ihIr+5P5?=
 =?us-ascii?Q?M1mAnlYiYrwuIY5s09divtV0OXhvNoG1JOJIQ9pnftGTn00jxllriC9gc+EE?=
 =?us-ascii?Q?/T+Wdct3ySG3M2Qm7KM0q9pyQvSMg6apwQ41UUYZmzuvy7vKleRh6fWgBEtM?=
 =?us-ascii?Q?f8j45lk6qERe8RgHLXhJ2aqCTmDjqS8LsClT34fC3X2GhIuRj+DoTRWk52ND?=
 =?us-ascii?Q?HVj9aHqJlfYzue8bSJy/rOMlQiXE6/YUEHa4IwDnQB3d4XAP7X5mG0+J01E2?=
 =?us-ascii?Q?2zRynzTQwAYpHQVqGI77K5Kn1Nv4COmS7oUGt5JGTVNyCTKjGMxnp3S0CbyB?=
 =?us-ascii?Q?5RVnwhIjKqqKLp+8R0MMFTz19pETL5Z1wZmMARnGS1TmFZ0JN9eXPoXshQ/6?=
 =?us-ascii?Q?gJ7LpmsTyBv2Zcs1f9HjzTs3zkGSJUeAEklSOf7nSImFfPynigHHs0iPFB5n?=
 =?us-ascii?Q?YXnLsKCdgZArfgqJN53O6Yo94aMGzoExL1Ejusb+2XV+dNg0w75gkMuKJm/3?=
 =?us-ascii?Q?EeKWwK9WPo+0qikRLI0BTLdZ5tx3m7RcX/WmZTKH+MvSQqr7X2VexQ9JISRo?=
 =?us-ascii?Q?Ey/x5SpVyYu5U1q75SJqhSw3zUOGczk8O8J1ZTFqA5KdQvdeM9jckitzMRT3?=
 =?us-ascii?Q?GlYfWwKSm8UXAoaZVUH3ugxRZXoW/Am5qNiFn5MD63HYIUeLsJnew/7XLIcq?=
 =?us-ascii?Q?8EtP0NU04Eofd8uZmpO/JdAIwrmMiZKC5pmR+1F7Q3SYgh9DNuZHKdW1e1+7?=
 =?us-ascii?Q?dJNd5xisbJyxndyB1VOCnjuCmMqC9Rm0W2U/4otED5S73v8+aBPKoijFOXmt?=
 =?us-ascii?Q?3rSLrGYiUbImjaV2MpEMRHE9qLxTdbYxOVszqcOXyflOd6mNCLF6+MIBRMTf?=
 =?us-ascii?Q?ZWDgDjyc2SSxNSc5LMp0r6CBoqETTe0=3D?=
X-Exchange-RoutingPolicyChecked:
	V+eHujI3qOKXvrYhRVD+FW06NFJC4UrFkL8xgABmO3HFDgXu01E2eVlIEeDU8jSJo6Wv383yxCTsls5lGH8+dYtzZrKxTNG0XYPe76WTUn20Zeh8mRj8p3LVKYP4aKzNdAfBS+t2ERITpsxeQun737Q5gnMfmvFSYT2Ys3hVSllLzlhFK8MPMBYGZS/cKWg0BrUinLWV8utk8X5gFCRfh/IvvfMTeyD5CtNXTz5ysjTxdBs6OZf4xBduRDWbebMQnjkmO5vCLGvh826tx/jzOFIEWQIEugPk8xqInc8aKh1v8v7hzmIWeMy9rOJ27RlgWTPlK4g7cNKoliW4G5T0Dg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hgHsf9DfC1ojAWOAotde3XVxWLZVgXFqrofFoDgI/by10VjE74kN82Mz+/27f+sXCalxXai5pbeF7lHm2oLdAatpuuFATRvH4lBPVi2Mkd6xtGHFUfqyQYJ1tf/Q6gHEpCSxmw9ysgzmxMS757F7yfRuB91+cdPJ73N0Ew+Gb0GUnHFmbtsNtiRH6Rh6mP/newZinmZeVGayb1VO+CoC6XOBvFUCX4EM95T3jdud4az8O2hgxP2jnDwr6+fOGggXhRRIaX+9uJaYSLsiwLqHK0vzMzzIZfRWJhHbfv6ZEcG+YyOX2B0QQk24O9vgMTQcRJrNPr8Joe1nz3/GG3Mqn9EgjZCMnvcuHQ9XpnMN86UlIovmA8S11MY1iE65WMZwp9mDli4yyZKi9T9A0pP4xP6dafmQC6AOo8xTdiQrfZsi5nJfDKbdYNf4D7oj/A9kcpEvZDkpQedyEKb3M05ipepBWXB0fZysaGH0REy4VI/4uHeFxL0KOURtf0O0Fs2dI1H3SWpjOxZu6dMf2NYKMDz5PyGHt0WRL2+JPSO4PqtZcJyxE+/rLzUv5P6I9tjICGxWN4RHysB47XRs1doiS4IxUmTwk4tuCEFiY2DT7lA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67252b84-983c-47bd-9ca0-08deee8f9cdf
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 23:09:31.5144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NgA7HgtbZw/Vz7FM8wMuVyMxR134ezoEAYiBmuX+kPeOkaYo0vnhf72tODH8AIpt9V31YZ8Ab5DIGufcLEHPBZERHi0EvaLwKI4YYSVBpF4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR10MB997660
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_07,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 spamscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2607300165
X-Proofpoint-GUID: cpJF-On71iTrq0Es1bQNi8FWga0wstXO
X-Authority-Analysis: v=2.4 cv=Y8fIdBeN c=1 sm=1 tr=0 ts=6a6bd9f3 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=x0qfxhOqE4c-yDlCdjIA:9 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22
 cc=ntf awl=host:13517
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDE2NSBTYWx0ZWRfX9LhkaVkvcEKz
 eihFChXsc8AyGpmINdrBWJM+YhhOC7/buFS4S9TqLy0p4rqJiXUENYweHy/Ol5O6neN4JlW88D3
 Q9TA8aPJnusTW+bJieFoW0Fk7CxKfI2mxe+YfQGflfsvKTMwDHgZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDE2NSBTYWx0ZWRfX5pJRK8iNv+uw
 wvaFjDH/BhSjOTGvm44ytw9QiojGF8aryfcp/GCFOTQevkX+tqVokrb91+KQGY5tcdfnU7ILPq1
 yWbyY01S6vxqx8vFHDdCs8wBi+OPQRwS8yACYDFM0tKVPiE77mxPBOa4OpCxFzs99wd4gtpU0hT
 rcIWfYr+vz+KUR3oyqejwv+lxLhPYHeEDKq8Py8P7IoqNXvjTWiWKzIkffyi7jyXCrQvr81baZl
 4aSw+THbQM0ZY5+T4j0hRbqNZRofUbyBzZ6Zimo20Sm//KRSoDm6F5Jom/5fV4W5FOClvPTcvJR
 vGukPJHKg+XApc946/Bj64/CDb369X84Z3ah3caM5GXm765c/llFtzbW7QRvndWuo6XlC0XBDv0
 eJPLbNqLCkQKdGSNFuVIFMG5ro5S33mI2BIOCNeSzQoZzXoZmRc7AtZKcdYYTL2gKZcTtgOT14C
 MMOk2NfS9fm/uBP/6fHNrPNNuqUyHhSvd0tUWFwM=
X-Proofpoint-ORIG-GUID: cpJF-On71iTrq0Es1bQNi8FWga0wstXO


sashiko-bot@kernel.org writes:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] The generic macro `smp_cond_load_relaxed_timeout()` is broken for loadable modules on ARM64 because it uses the unexported symbol `arch_timer_evtstrm_available`.

This interface mostly exists (or wants to) to unify spin-wait with
timeout where the waiting can be done via a spinning cpu_relax() or
arm64 style waiting on a cacheline (WFE/WFET).

Currently, almost all of the users of smp_cond_load_{acquire,relaxed}
are in kernel/

 $ git grep -E 'smp_cond_load_acquire|smp_cond_load_relaxed' kernel/ | wc
 27     145    2191

The only non kernel/ users are in:
 $ git grep -E 'smp_cond_load_acquire|smp_cond_load_relaxed' arch/ drivers/ mm/ fs/
 arch/arm64/include/asm/mte.h:   smp_cond_load_acquire(&page->flags.f, VAL & (1UL << PG_mte_tagged));
 arch/arm64/include/asm/mte.h:   smp_cond_load_acquire(&folio->flags.f, VAL & (1UL << PG_mte_tagged));
 arch/arm64/mm/mmu.c:            smp_cond_load_acquire(&idmap_kpti_bbml2_flag, VAL == num_online_cpus());
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:    smp_cond_load_relaxed(cmd, !VAL || (ret = queue_poll(&qp)));

So I don't expect this to be needed in kernel modules any time soon.
And if it is, we can export the symbol then.

Ankur

> --
>
> --- Patch [2]: [PATCH v14 02/15] arm64: barrier: Support smp_cond_load_relaxed_timeout() ---
> (Note: The format of this review has been altered to provide a free-form summary rather than inline quotes due to recitation restrictions.)
>
> commit 8ff6ac5954b14995e35ca4865c27742e37086e23
> Author: Ankur Arora <ankur.a.arora@oracle.com>
> arm64: barrier: Support smp_cond_load_relaxed_timeout()
>
> This commit adds support for smp_cond_load_relaxed_timeout() on arm64 by
> using __cmpwait_relaxed() when the event-stream is available. It introduces
> cpu_poll_relax() which checks arch_timer_evtstrm_available() before deciding
> to wait or fallback to cpu_relax().
>
> [Severity: High]
> Will loadable modules be able to build if they use the new timeout barrier API?
>
> The new cpu_poll_relax() macro in arch/arm64/include/asm/barrier.h calls
> arch_timer_evtstrm_available(), which is defined in
> drivers/clocksource/arm_arch_timer.c.
>
> Since cpu_poll_relax() is embedded inline into callers of
> smp_cond_load_relaxed_timeout(), any loadable module that uses this generic
> API will now require the arch_timer_evtstrm_available symbol.
>
> However, it does not appear that arch_timer_evtstrm_available is exported with
> EXPORT_SYMBOL or EXPORT_SYMBOL_GPL.
>
> Does this cause an undefined reference error during the modpost step for
> device drivers that attempt to use smp_cond_load_relaxed_timeout()?


--
ankur
