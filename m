Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.165.32
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794817527;
	b=NLX3ldoTXCgBqD2VJ9UpXTOMNyii3uBc8NljciiaLuai8h2RQTCcH4su4h/4okQPO1ZN
	 ZvXkn+eMcuP8dFep6zJQUg3afZ0Ucq0R+bl0rF93Orss3pOeHsyHK0SvO49KxrpAzHtBY
	 NfC+BihxF2cDz+KFuQ8hJ2zTC/WKlHmgaoxxA7fTkhfFqtCKeB8mgXTNrl9JJnH/BnVCI
	 UToNhPjN9jJ+hlO+/FknoO8CnjEGMoLkmkau8LHymIfXHnjYfa04JSUJcZzD9nVzBZBuO
	 pPb+Vp5PZXGuON5CdCfaMVWfJ362NtnTY4ld0wz8FoAqc+3Qr2UlIgsP2jVlEmczClg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794817527;
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
	bh=9nnAWFgzl8YB7OzrAVtJ/Al0PRMAZeNmCcEj11E6nE8=;
	b=gtWzWsDHF92DKHgchh0XlCmiK77Dx0AArgW/7TNd9DqLxxuimr13a4AeNsKh1EedXvnM
	 vimf+8SG+z9jAjl7SJ3okJd8IMNleSUFHWar14Ff4yl5Oe+bsspMaTZKWfEi0avWe1NTd
	 65fsJ0EVdhxOs0a71rix/3s5XJQhdeQToTQ1nqNfT5BA4i/WsJFaXeeSpEgx7jqMebF6Q
	 3yJjHOeYQsn1XkKIBB5w7zs769hxP6FXrDwoPSh6O4bbhwr8y1e+CJDWhP/sJq3Bjxayo
	 HrWxKM+NwSIaV0FCzRzchLg2AHh0ClFpD89JTd9rG7vNHsOA1zWikeWRFj0zFqmT0Bg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oracle.com;
	spf=pass smtp.mailfrom=oracle.com;
	dkim=pass header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=miJjRpKg;
	dkim=pass header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=meEnYvTZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.165.32
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0F9606A330;
	Mon, 16 Nov 2026 08:25:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D0F9606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=miJjRpKg;
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=meEnYvTZ
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AG3NXmF3948898;
	Mon, 16 Nov 2026 08:24:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=9nnAWFgzl8YB7OzrAVtJ/Al0PRMAZeNmCcEj11E6nE8=; b=
	miJjRpKg1RkOyxE4o32d/yq6EExenqbHa8WOQ4nNf41qqE6K4HjCg++dVFYz4ggd
	+NrHgzR+E2EfkCo33PO9sxX3INcLsNeq31p2A8I+TRqn9GpgHhXVZnI44aQ92TUJ
	rQD0PvwebXBZ3hvDK1Vbb+YmgnwtL5fV6mBeMMb/EGb43lZJvjcmCzgoBOa4RYKh
	/fsBGr9r6fPWFrfCoawlj+dPtEG5kj8T1WzCqxIMndG3XMGdoXK4QAtMflz9DJ41
	adt84HrQt/FHq2aXRqjYpoaMtO2AcA/uSBARqd8qRoAXq+T+GmyZtbEg4gi9NK5w
	HhjyyhXYubY+xqKBlhns3g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4hxg6u1kmn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Mon, 16 Nov 2026 08:24:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.11/8.18.1.11) with ESMTP id 6AG7cccW1550489;
	Mon, 16 Nov 2026 08:24:46 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012053.outbound.protection.outlook.com [40.107.209.53])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4hyv5svjy1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL);
	Mon, 16 Nov 2026 08:24:45 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lIOuCrrfbU5UhGyq9whAaa8Dx43HjZG29kqKr8hpvbkdtpaZafjIZ0W5cFtMMxVGfh1Ass6LDz3MTJiYOfI2R5Epz8yNybQz2S9iwhO4rQrtYlg5nuiU43BlwsqF5cD9QGhWIrcM2bPIkpdZlOBd42Tij00OzlFrJcrA3pb9rIGnTZ5l84AemhHnAGA8x/JhemdfVkQ2OLeJ5gWxWAlSrQ7RBSaW1I8w/UQTUc1bRWAPvojwMOGZ0Abf1+DelUfk2efF9z5BxaJ9IxtPfV90ewooy40PTZ2Blfnfl9zrBdGe5bxIbAn+T7J88G0kqg/8h9r5REG7fkIN2dfE3BrhCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9nnAWFgzl8YB7OzrAVtJ/Al0PRMAZeNmCcEj11E6nE8=;
 b=hnDj6G5zuLJq6YZFpf6DeBVPsovqVihp17iXEPgATurNSVLKrSnUOssD8zGnXDfam3Ng8lN6YFVrv+lChLI4WHB6k4OWh33s0r7WGU6MPt31RQSB3pnxFZGvQLHanh7g2qrM3v0yNdJrYOlcJWRIDi8I7dtOseitLLgqp8J9sQ7y07iUCtRBO2XlpL3OZMgrSC8Cs4f9KKTGFJo5/C9kY+UqT5GThmaiD09oqLtp5thNtTqZW3KyNZjlivl+wySAelQF+NAP6VV475hYY3aW8u7hMY/UYQXj5fFnSGGT5gVH8K7Mknxy3ZXoiEXxOn3BIw6j5MRtb9QQtRGlKKOBlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9nnAWFgzl8YB7OzrAVtJ/Al0PRMAZeNmCcEj11E6nE8=;
 b=meEnYvTZxhycSEyuzKFe35sgDvMXYIyJXKoZRcD5narnbKoYtiInCNpq4SqEf+KxlPdiPCIvGZHBMdPrWA1+IZNzzIUwT/T80MDFXjhhDuKmriwYq1F0lRlOYvGcM+tDfwj7q08HgUjmCWnV1D6Kf3sMawi4WkTHTwRVbIbtW6s=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CH3PR10MB8216.namprd10.prod.outlook.com (2603:10b6:610:1f5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 08:24:43 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%5]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 08:24:43 +0000
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
Subject: [PATCH v17 02/16] arm64: barrier: Support smp_cond_load_relaxed_timeout()
Date: Mon, 16 Nov 2026 02:24:23 -0600
Message-Id: <20261116082437.66739-3-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20261116082437.66739-1-ankur.a.arora@oracle.com>
References: <20261116082437.66739-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0119.namprd03.prod.outlook.com
 (2603:10b6:303:b7::34) To CO6PR10MB5409.namprd10.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CH3PR10MB8216:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ba8c921-3a91-4284-f5b4-08df43bb0fd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|366016|22082099003|18002099003|6133799003|261009223027099003|56012099006|261102123227099003|261028144727099003|261026121527099003|261026140227099003|261021123027099003|261022105027099003|261021121427099003|261022075727099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	a6XI52FS6Ejgn3JOHELEmxUOwzMAd/y5QJBgQuOFewjbi6/k1eF6tZp7y2x6xPhv1JUko1ZbFxZ2PN3Xzm3d917/EF9KZRSxTbaVkX9ErdTiFnwSPWg73DPTPAf1ThEc03Y0giICo7j/X+h2HMMTvOQplCXDFXOoW1Nd4KPXABtNAVCWCvnZnxtGF4zVr7yE4XS4JTQ5DVs3aMq5vNfycidlfQxs2cJ3A/34hzn49pDHfBNTrsz/xjrcyG79Ubw1hU9oCDzRWHRC6mtwlzstH/3184Sl7zEdPksb7nS5tbKSQQwjFyQ6uaQ8xTlxOgF0T+gPRu7hNlC5zOC9Z6IUiM1OZnT1wjVI391HVbh7zv/k5SvilGoW9IJLyZ8xwujcPatdWqZSGPAIY9zKLb4uZ5hH/YtpwmHsIzue3cMEHXxuUlSlK0URyTKr4CSnyr/B9MCEcV3lLsmL9ykqpDeBsWMHfsH1J7wyk9GEQQ1eAv+cTxBU4/CZMO26/t74zpYM+mm2HE3B5QS9id4K+5Mrw8DZVZChmQlnmVWrd0/80JyTESwJKNUANB/62pG+v7uBi4KLt8vXl9T1UAsAaKryLXTlX1Kn3TOVzO9qtZZdGaxouu96nqINvjxlrFzYqPsZ/jDG8KpXEA7KHrsNx8Ca9+xqEUkdDfTS1grZ8IfD8zQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(22082099003)(18002099003)(6133799003)(261009223027099003)(56012099006)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021123027099003)(261022105027099003)(261021121427099003)(261022075727099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tWZl0FVSQmTUNUsCFIXvCl+1dWzomuqJoJGDvX1z1OMeqHRPCL6dDn7SnNKf?=
 =?us-ascii?Q?RKjaWMUQyxROT+WQGVq5HTIpLyTTh/6ZreGwj2BGC8VG+qPyGJFTPPYe3os8?=
 =?us-ascii?Q?5AOs7u8wSBXZTDATGXt9gp7JhOQ0oo0J8+0IcgMo339u/qUB7OSz1OA4Otxk?=
 =?us-ascii?Q?IiaBBXZsAFnTXeLG90Lb379uSTI5TY00UzIcClwbq3BHQBVq8cV2cZS5dInl?=
 =?us-ascii?Q?hXzWhpC378S8v5N65ySAGCCtZeXXRIYKOiwr6SKfmWNGB52TKCy6PNowXx/Z?=
 =?us-ascii?Q?XFCe9rtt+nXXhPmJucYjUq9t0O9hKpKJxXTLkVUn9M7nE5SHUL2gJ4s+Nlbs?=
 =?us-ascii?Q?79pVqKGyk4KHiB47770jNbPOGOgLJBY1DFR0OFry9esWqE7XiaEGdYdBCSkO?=
 =?us-ascii?Q?9Bnibi78RCTFxY9gu3FPKU3T1wqb4Fuv69iFIyjYetZ6gOG1N9tkMVwk4Wqc?=
 =?us-ascii?Q?LxwKMCF5dKkhxeA+sgFMjh61oWb3J+iVQE0Fa1YEDAf7D4jHQeXOVHvhPPKY?=
 =?us-ascii?Q?nQ/iVSERIf7HRxCYV3yq/x9cHH3F+WFzXt3klvT255ifEx+abMRUS7PgqqqF?=
 =?us-ascii?Q?NnScPZQvwqWKeDfuzh/jJuCLlWO2WEUcd9X2F7d1OCfIH0hzgoZuK9F8Pcgv?=
 =?us-ascii?Q?amAGAjfWmPRcGVWMMnfZbXVe7IRtKGMEV7KUMW62aRv2dPjGOL+JHTO+VN9Y?=
 =?us-ascii?Q?2k9kkqyJSUByFV+HiFYg2tGKkzIB7mp8k5sJfM5Xpj8Yek/34Od+YN8ebgjJ?=
 =?us-ascii?Q?foAZZ4fwaG2XXn/opvA1MAfGAacVBcAiIufjxL5/EXpyipHMeN7D/CkfA/ln?=
 =?us-ascii?Q?CdKwHmGV6sN4GpgUXJTe+YXCyL9jn68q1XMX1CcAZ1b2yZTGtXbbon39Ia7Y?=
 =?us-ascii?Q?cww7f1DrbnmIKIhOSmGHk+WgppmutBnr9kTgWItt3oEVBhRVFnDz2XVRf/ZA?=
 =?us-ascii?Q?EbPVz6ItNsBy4LTEgAV/YdWqjqSECJEWu2DH/aPjea2m/T5cbhmq960LCIO+?=
 =?us-ascii?Q?gVhQUzfRqbQoQwjnwGv4Xc03pN0zVbR3ofuTKHpPXeaEVW+BILt5GR/IQJcj?=
 =?us-ascii?Q?QEqcCkaHaLfaqZl8ze9I0xF+hrbC6dql57T5IfXvs0y31LWUeaFPTqTppB0+?=
 =?us-ascii?Q?cR+ni6YnCRy/pCU0jIfBgTlmIF/YLw+fScP/r0RIVU6LxCrkeMBd+paS+GXv?=
 =?us-ascii?Q?SyjnuzAYB757Fgq19qesMVBhceThJKbk4AZbM1u4aHjSuXs/aD8GzzczyCpR?=
 =?us-ascii?Q?xHYeWz0Jix1M173f/6NjMHXzWAI4OmZoSNACvqlOrEdbSi3c0hRfwnePXxaa?=
 =?us-ascii?Q?7B5QB5NidiG2D/v9smts5fsdFqz8GapxYzqDpEm2xo6bhslKwjKFgATW6ymX?=
 =?us-ascii?Q?SrQeVYN81woLkQ0MnyKX1+1Qeuo8qg0sV4uqGFda3H93oevhDzzKtEDvwJzN?=
 =?us-ascii?Q?CannJJs10V1WJwIB3EhtUQsNxJc/ee32P2w+areUMaT0HcaVItE8S1JEBMDU?=
 =?us-ascii?Q?/WWBanj5ocyEtwv6PXCLsd8MNCv+sReWugnqNQVrJb2kesuw+qOEwgDQCrnD?=
 =?us-ascii?Q?2OI6vOLW0urvVXJFZe7H0t+mppLhnRm9IQj2q6FDszX7diJGeVoYz5+MSkkU?=
 =?us-ascii?Q?e3tlDPOIDxnt7u/q/tVJ1OWkF0kp2zDab+Guxa9VcIEAVhpj3klxziUZe3Bp?=
 =?us-ascii?Q?Po6bWaiFMhfYfDyVrcMMisY9c9KLoc16tO2iTuum7fPM8AmJNiYiDajQqpB8?=
 =?us-ascii?Q?UXEnDnYwAb73exPMiyuLz13OM7Kt8Ts=3D?=
X-Exchange-RoutingPolicyChecked:
	gTzuFVb6JDmuWVrRTRQw2zoDD+lgl7KEOHV+V3rG3zG+nk/AKsasVz+S9DrS2FqfFHC8Md3u2gKlLSry0iHQgDlhefLYKh6+kLefOQShYdiX2B9ckc+35jR/e0lSaaqRfds6ghAB0NVcYoxHqT63osVOogk2rRJWlgcmUfQA/NwlUu8E65EM30wRsHV1WfV6ZuK+Jx4dzrRS+dwJ43EQDOqPEwA+48shrlef66lwt+WzHcF6Vhh+VE7/HLWwHVFLlvPzoUuabaIr+DoYnR5b8ZtI/cfoJU/+vadYsgmVSLQz9KKaXT3KqGZWeh+7Ve2MC4RVwagufEhlzkrq1pVXvg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dX0VJQz5l+DYJh3S0V+s154G+nIDG/Hrtn08HoDXGGR5BLITusEOi/JaoEtk4Gk8xn5COAqlj/RLix2MkJP9jBNFGBm/uQm2PK/2HboJryEbxY8hxu4k/yXxKrem54V5Yx/KS5egFKcqK79AIzKYVSYLCxdT9YBuiB7EdA31jR6eoyHkLg7nhAsd2cQVLl9zc56S1nPSWBP1a1rtp+gzcCtdeoyBOf91LNjkCjLHm2JjXts5e1/cJRTpCr7ZSyIMecgabqY84vT1UK/d4iPgHU1gHQxwFX26xRAlu31c8ANIMPOuiY8JImgZPWHHl5TblMjb/BMPjE6oVWiYzskBxjPW+A2Q9ZitejAcq6m+Ha62BaOSumlGyYdWbsTDM572P5tRIvb5e9mueEgz+AICxu878IcuOA+up5hvwlQ7Oxs6h6chHuyh1KZK8PlGmHQUK6XxsnpQdzWvUlwpey9yzqdLrchyV6qJ7x/8G6hFMOIqtk1UWKPY9+0WiZ8ChWepM3V+01ZegOab+XOyjXzCm+yzpRER5ppWyku7mp1ETlfYVjtSEPbxL8tCcdQESVn5fMis9fDFZoyI6/fpRsq3Vku8kCqSgt4tz7T2iHK42Zs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ba8c921-3a91-4284-f5b4-08df43bb0fd3
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 08:24:42.9727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3DmQAzQkmTLDcpmMHBwZfk36mX16WcYi5rDxNu7dbMu2QnoRh29gAQQHUCoCEi5+0vf0ESjQeSkzqLXnzkRpJJKjXsClEyL3xkbls1+9nWQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB8216
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=937 lowpriorityscore=0 mlxscore=0
 adultscore=0 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2611040001 definitions=main-2611160033
X-Proofpoint-ORIG-GUID: cRDSHcfx3PSWsF5XO3HfnO0Fkvgfus1Z
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDAzMyBTYWx0ZWRfX5AQRhH3iGIIz
 YY2RQTQyqvqyvDMbfvOTg4WavNBSqvY7lq2THeg6UiRn141t5nAVkDTlOhVRYwOA0LlSnUEt5bW
 qybexYV2s3aCInsXusYAIOXpQHAk57ILMppSWyCRzufebrh9HC/k
X-Authority-Analysis: v=2.4 cv=foVJ914f c=1 sm=1 tr=0 ts=6afabdce b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=JfrnYn6hAAAA:8
 a=vggBfdFIAAAA:8 a=yMhMjlubAAAA:8 a=yPCof4ZbAAAA:8 a=UzxOc6Dqw8ZgQrJ4fyIA:9
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=1CNFftbPRP8L7MoqJWF3:22 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13532
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDAzMyBTYWx0ZWRfXyyg9iVadqj6i
 Je8w4WFq1SJq+PV+oBZ5sePE8t5FTzvFzA84yilcuneguDBxscG7t7b7JtUaFHynSbrXffidEW1
 vGiVPckoCzdGB5iJmr3jqQ9yhYZKu1B/eSsSgrfL0xjAK8Ex6AFaHpGGF1iy3TS1NLne6XjYFqk
 qtDaKHR1sF0XGsMmud/mV5Kk9iRwOy8v040uo4s33aa+LJlDZAJ9uKAl5qnSw26EnAFxk9T9RDN
 q8mO3YMlqWLCVvkTmN7xPtauQjNbfXhtEIXPiYrJBj037lV3kd3GwVQW7TD0QtQPbr38fA9kcwx
 zTXcs2OIVZFxdrANR0TtTJKSeys6kge8IK1sK9mJSVWOJErzCtFQI3EfxoQHiYjKVlLnGiQ7pJl
 TSwX2fjpiXwMxdJ2SbePcKxwHK4Xlza+6obCeUfxnvpbgHfWKGYsweHwU9q88bsbJIORaeni/cC
 5qDsfwGuJjcPVmRBL1GmSTWwYPQ6quM1lYDgREBc=
X-Proofpoint-GUID: cRDSHcfx3PSWsF5XO3HfnO0Fkvgfus1Z

Support waiting in smp_cond_load_relaxed_timeout() via
__cmpwait_relaxed(). To ensure that we wake from waiting in WFE
periodically and don't block forever if there are no stores to
ptr, this path is only used when the event-stream is enabled.

Note that when using __cmpwait_relaxed() we ignore the timeout
value, allowing an overshoot by up to the event-stream period.
And, in the unlikely event that the event-stream is unavailable,
fallback to spin-waiting.

Define CPU_POLL_RELAX_WAITS to state that we have a waiting
implementation. (Non-production environments might not have
arch_timer_evtstrm_available() but we don't care about that
configuration.)

Also mark arch_timer_evtstrm_available() noinstr since we will
be using smp_cond_load_relaxed_timeout() from the cpuidle
context which is non-instrumentable.

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
Tested-by: Haris Okanovic <harisokn@amazon.com>
Tested-by: Sahil Chandna <sahilchandna@linux.microsoft.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
Notes:
 - mark arch_timer_evtstrm_available() noinstr. This is needed
   because smp_cond_load_relaxed_timeout() will be called from a
   noinstr context via __cpuidle poll_idle().

 arch/arm64/include/asm/barrier.h     | 22 ++++++++++++++++++++++
 drivers/clocksource/arm_arch_timer.c |  2 +-
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
index 9495c4441a46..e2263c754a55 100644
--- a/arch/arm64/include/asm/barrier.h
+++ b/arch/arm64/include/asm/barrier.h
@@ -12,6 +12,7 @@
 #include <linux/kasan-checks.h>
 
 #include <asm/alternative-macros.h>
+#include <asm/vdso/processor.h>
 
 #define __nops(n)	".rept	" #n "\nnop\n.endr\n"
 #define nops(n)		asm volatile(__nops(n))
@@ -219,6 +220,27 @@ do {									\
 	(typeof(*ptr))VAL;						\
 })
 
+/* Re-declared here to avoid include dependency. */
+extern bool arch_timer_evtstrm_available(void);
+
+/*
+ * In the common case, cpu_poll_relax() sits waiting in __cmpwait_relaxed()
+ * for @ptr value to change.
+ *
+ * State this by defining CPU_POLL_RELAX_WAITS. This enables a time-check
+ * optimization in smp_cond_load_{relaxed,acquire}_timeout(). Note that this
+ * is not ideal for the cpu_relax() fallback but that's not a production
+ * configuration.
+ */
+#define CPU_POLL_RELAX_WAITS
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
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index cc9a8b399004..bf27b709d23a 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -884,7 +884,7 @@ u32 arch_timer_get_rate(void)
 	return arch_timer_rate;
 }
 
-bool arch_timer_evtstrm_available(void)
+bool noinstr arch_timer_evtstrm_available(void)
 {
 	/*
 	 * We might get called from a preemptible context. This is fine
-- 
2.43.7

