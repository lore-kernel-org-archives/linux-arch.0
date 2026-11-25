Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.165.32
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795590912;
	b=GrkXR2vDYThA6lQ2vccFbaYxArtucPdjcAVbghPo4dGRMfUwPvzVa9qLMGzYnbm7zIu9
	 Wr+SYmw/WBnTgSkkLkM87zqeFKA0ORqSW+iGVEncgHlw0drSjsBd4Kao2YPuq30jmNw8P
	 9NNYL+l3pyhtY3+OaWwKrf7jz5KKv7zVz9t2IKYqH+uVg6FJv0c3hU9CnOcREYjfsmxtp
	 4ZlqKo0MkBKURQn36ZqqChD5/b27SClzAZmNn8Hy0lLyTtnwarx7JGPuxIKk2C/UvsNSe
	 tDY9zbZluEydJ0o1UZXAcfl67W/LgdkH9hGPBB9lwew+KnGYdSN0/ydYC8hCSstoGMQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795590912;
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
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID;
	bh=V1GP5DaSP71xSlvAj6UZrSTe4Cb3zVN3y38qIcjgf2U=;
	b=S2Q4S0eePc3F3tMbmRu7U+OlLiRi8WFVAcGoCxsOYUa3/9/D5QNHP2K3vUwSzOLytz9Z
	 ny70SY+gtJAEEns8KVjwuEaX3juexeSjgFm1Rb6B9CaK5fxFT9kIxW095hVNoJLcyl4ra
	 T/L+c8/pgWPh2JL1ZrqziJU8xFyepYF+go8LUUsxL5rDhc2a3pc7Ih2gx9E4PtyxnwXWq
	 JnvaUKrauFK1bVz9AjZJIlySTAYYGHE3VCOG7YDBwRLpMcytkJPdDTswWkU9cldJY4sSC
	 kfUxCl6L3lwxXleMFSk9atWw1hLam/iAhOgOI00QrMCWa0o22TDruVe6z+hD86Pf5MA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oracle.com;
	spf=pass smtp.mailfrom=oracle.com;
	dkim=pass header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2026-11-19 header.b=uhQFnVld;
	dkim=pass header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=rnq8cIZ7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.165.32
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400B4606A686;
	Wed, 25 Nov 2026 07:15:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 400B4606A686
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2026-11-19 header.b=uhQFnVld;
	dkim=pass (1024-bit key, unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=rnq8cIZ7
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AP5uPxK4003056;
	Wed, 25 Nov 2026 07:14:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2026-11-19; bh=V1GP5DaSP71xSlvAj6UZrSTe4Cb3zVN3y38qIcjgf2U=; b=
	uhQFnVldCexZpbg+CXwR44kFkCXAKKUCSeZqvuWCsyNRXjamNgw7ZEf1WmyxrGdo
	ObaTjXa57gAyiN6Li298I4sEz/4gmCG/IXRIRqh0xeE73K1p1o6b+DKv7UmeOYZJ
	povOAI1ekV55ll9MgrhHwg18kajbjT/aBgeYzwOdPFz1gYvIHzGjJkhjsWBS9REZ
	2Gi+YRQ2bNoydME2MvjAriEjSsruZObuAEXYYeMdI9mZqGwLJwgvL0kGnQYVkrTR
	GT1NGypajHn8CLktNwm99dxTWS+kBbboSpOOLfLZFMzABFHPOysqHCZ3Dvx2XZ1o
	EPdLQ4hI7jUaHcEj9H2uhw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4j34t1ne0r-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Wed, 25 Nov 2026 07:14:18 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.11/8.18.1.11) with ESMTP id 6AP695ct1753924;
	Wed, 25 Nov 2026 07:14:17 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012053.outbound.protection.outlook.com [40.107.209.53])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4j5ss2jwfv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL);
	Wed, 25 Nov 2026 07:14:17 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aq7j0U2JO5LB9VudqBoNF6h+dy3V3MxubJWNoSkGZPymoD85gquZTcep/QE4uAUMa6PElvs3Ji2pBSPtNvsYaOfpz0BtOmBglG9iM4I8BJt5Wwo02xTENCCm4rccQ3HsA7F5n8ewez/vm1gZLgtqJMwkcoDZxNmXAkxhPFfzrvF+wfL5awhuyK6qfJu1mMW0oXHjn89foTN9fUkkr4C2RQJj3VZ6+2ouAbc2hU1cArprDu+HhenQc68m4h5e1ycUYmSA0suEIFsb6WRDL+2U9lzW65xFAdD7tNcDBb6jxQf5aDcgpmdIuBeTpOcUYUSXtse+jbnXnU2JB2d9FN6gHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V1GP5DaSP71xSlvAj6UZrSTe4Cb3zVN3y38qIcjgf2U=;
 b=RRfXL7UWiKNBHEMNAG3jfdrty8X8G+AvS3e4HUwb4MMjvcZGg0jw4T3HJjRj1IH6tMxyAJUZzRcxSLM+lDDwoVGzQho5R5L6ipV8R1jrcHFpc0CER/uQRLET/J0QjUKuqjhO4OEj+lsxenB3r/HeCtQ9RcGK2934/Bxi5nwWVjazWVipo4vEibY1BJHv32GI7AxErHz2sUDCclSAmCt+M7JZJ8GHetI4ZX3FHz0iXqG2U3CfM/NguZXxv14vHHVHOTlkbaoVONm5XLirU8PX13DFeyTcJw6oAfD0ztnXtNyiPj7A9rtEsNuWVa/AABVK4MvVc0wz+vcikWh0y/6KKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V1GP5DaSP71xSlvAj6UZrSTe4Cb3zVN3y38qIcjgf2U=;
 b=rnq8cIZ7IcPz8H/m15Z7GctkrOgm51RLesVzwAJCPRWviC0oE6fa6FzHiGxMYr2ffeWmlNUQTmFScdv6R7c76hmyu9zq9nNOmjWUF9dig4Z6wcEM9MiYnHmjGQLWhTOn3BJ4WZkvJ4fk2xJboYeTVvc9Oskdy5jQVQT2qVqbjkw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by MN6PR10MB8023.namprd10.prod.outlook.com (2603:10b6:208:4fb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 07:14:12 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%5]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 07:14:12 +0000
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
Subject: [PATCH UPDATED v17 01/16] asm-generic: barrier: Add smp_cond_load_relaxed_timeout()
Date: Wed, 25 Nov 2026 01:14:10 -0600
Message-Id: <20261125071410.10233-1-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20261116082437.66739-2-ankur.a.arora@oracle.com>
References: <20261116082437.66739-2-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0352.namprd03.prod.outlook.com
 (2603:10b6:303:dc::27) To CO6PR10MB5409.namprd10.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|MN6PR10MB8023:EE_
X-MS-Office365-Filtering-Correlation-Id: d7786fca-5953-4581-2682-08df4ac3b489
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|7416014|376014|10067099003|56012099006|261026121527099003|261026140227099003|261022105027099003|261022075727099003|261028144727099003|261021135927099003|261021121427099003|261102123227099003|261009221227099003|261009223027099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	cvymZXLZTDrNtFHrS3tTD0XYXU/2gfX0CG7CkqCCSj1ctDUkRrHufRfaij/MZ9JcMukkNPhlLc+G4uQKa5TMspIbqrxkXXjVtuqrWRH476As89FSlc6xXc87KQ2S9gh2eyjiy4OzbOz0qdO/EBbHW15LVKQYvbwLA+StT4AXPpPDFzpaor6s1Pouk/7PQ2MWvwupeEQh+KVU71K6J5SR86V2bkHICpLDFa469StzTZTaVHSScT5hXXwW5CWlXNiSBVWj/Fe2hEUqD8/3Gn6Is1YHOt0v3f7G43iWFr4LhqkxTOcNGSJpsSAnxOjnHlLI3XisQPnvHfa9IcCatFjWdDetu0CgLMdcn17IZvILnrnCbJmDyqPsI/W/rxq3cWjb0GADyXHwRe1KUHhUthsgZXDz6IbqUvIRyVumIKY/hpbU2I/ptdnH8gsuk5NU9mPH7ksWD/iZitbZKcBHDQ3uOWyge5FRAGNn4BmWSUQ+r6hui4kJoKG+SDx0UrGk0L39D2+kQTQCVf8Z8IUbkeR+SfVVOedRKTiI7sYWl4PiHIuqoLtPoi7ICQ2he01r8IjO5KacLwseDipXWx4eOPSM2B5hxDzNbxjf7ReRuelAiw9O6te7Mx3HN40Nld5ILvFiDml+akNnSAl/3zJKavnIeWktY1lr3V3jpVQ1gP1vai8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(10067099003)(56012099006)(261026121527099003)(261026140227099003)(261022105027099003)(261022075727099003)(261028144727099003)(261021135927099003)(261021121427099003)(261102123227099003)(261009221227099003)(261009223027099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mcS0wHEc5+n/+GYFkK7k3u7eaHSrZNjdsn2fl2O2LjRo4jF/W9YWNLfOgbHt?=
 =?us-ascii?Q?uW/h1kfiss0M58fEeLj3MWxz+6vH8sjRfUmnXmVFmjZD1Oe0jiCqblXufbjt?=
 =?us-ascii?Q?dIuTtuAxI8ULpzR7JkphRkKX4Ggwqt+RNksIi/KutWB163b1j04sT/T1d64V?=
 =?us-ascii?Q?czMGTGN2/wA1tSl4AmY3UB/br/jrh2AXZwObiYOP55VS8KlfkyHtwov2RZwB?=
 =?us-ascii?Q?DyG4pUB5Jv2MlFxMVKn6FK2Og3kPOo5RSeOQSP2RxbJqEi7DubR4nvT8f9lp?=
 =?us-ascii?Q?jurZxn9nzLyTwlw1IIpUt2FNucINRNo8ewzFSY0IZwSWiGqKX3ZIy49JYrlG?=
 =?us-ascii?Q?xULTOoQJBgT8sVBG6v2nHp/iZJHtOvJ5md6XYCt0BOoMOV93331GxX1eOmZC?=
 =?us-ascii?Q?gCW+jao6kJvy68lTCAX+rqbqoo+lfaiZ8LyjAQMXvz3B21WM3bCdgyKQmHZL?=
 =?us-ascii?Q?XtkOpBA8bqBX6Y0Uz8BACTNHnpr0wPPDkLZRu54cdPXmcNVGKi4ATzrllKKR?=
 =?us-ascii?Q?IpzhmCmb4wSxPJ/L8bzvZpv0Yi94Xo04xxUtbebmoyZkJmctoTuIIylpgrP6?=
 =?us-ascii?Q?qA2d/4MHNGcko5sygGd9cvyZsz1Qm8wKHJl7UszZ73P91YLMJ1421nsYCNoL?=
 =?us-ascii?Q?u6l+HB37pSrE1SCjv1O8BqozV6oe9per29D4ThjFxCvgtyoz1wAw+2q2Dsee?=
 =?us-ascii?Q?CezwgnaBLOLvpaTyskYste7f61V18vJp2Y6X54ImoRI6gAMjYThFRffijPmJ?=
 =?us-ascii?Q?Gmk+z53SqL/nphYMZh8R94gr5g00/7qaZGXAFzpdBfGA4UqFOWBTX7AQUSj7?=
 =?us-ascii?Q?nZFHEKjE1LdLq8HMMjSEJK8W2fgjCJbUKLQC57pdLc0TmAHCj2WEb+qo9IWY?=
 =?us-ascii?Q?+0L6LQR3hiBVX9q9Z8wx0L2P9NMDKMZDSFOaZSoMBG8u7O+vEMc367mXpE8w?=
 =?us-ascii?Q?fjHa+9wlUK90WEq1TvX92D7ZSFP4Eapb78rfkQxEXmkatYiJPGS9zUKtiOKT?=
 =?us-ascii?Q?DXAtP9mR6OwccIJzcviv1qDEmFU+hiM00ZhnTlH9LmYRHRxzIfcb98oA3Coh?=
 =?us-ascii?Q?XdTfNsShp0CNAmMqzFX4kIXZiqf1Ugg6i+P4T3YDnJYj5NxzIOcqDX6Z3GJh?=
 =?us-ascii?Q?OsC2AdseAN5TQaaEUGelgcbrp+RKcGGSNmEuVJIglgDzhvBhTiImqVUKmyAG?=
 =?us-ascii?Q?cDA6btMRM9RFnPS24azWqy4wta7CtdaM4fNmGUfF6iEPKGujTUZ/2s2JKKHN?=
 =?us-ascii?Q?F7m+TchJb/XLTAMG8BzQxmI/ZSJ0ax+Qc39q6KVUAco1Z33YGW6YrhgACQV7?=
 =?us-ascii?Q?QSjTfCDgjEkj0LED+twlk8DiG6M3cddPVvx3XQICpkGnZ/MdWTrsM4q1+Tce?=
 =?us-ascii?Q?gluf2soMvTT/Bc3tAeuHlihHBnK8hgQt+fFNJE3iF018sliwNtX1sSfgmMZo?=
 =?us-ascii?Q?PSfZr+pp8gqBaZbBohV4dp4aiAaG+EgsZPeKJHH1/fzh8YTFDmNG9+uoZcB/?=
 =?us-ascii?Q?zr4aBJ1rqJUZSs9yb8p6tQoliHZwNqBQ5d0v1vW3RET41VrAbZHgStxs6aYJ?=
 =?us-ascii?Q?r5XTroz7uYZ2JmQDezOhrpH5ob8aCwslcvpkjDr3gULPVI1jchaTDzGy8EwS?=
 =?us-ascii?Q?HTu3157xL4QkSBHSzJM0kM91RKYXwr0R3Z05MJp1IziUSK6metCgY/62nxSC?=
 =?us-ascii?Q?WSZX3nq2qG8Y7nw1cgUaIfMN9lKR/ii3XsVxaKLLfSeaggUHle4uh9YfqrGY?=
 =?us-ascii?Q?xQ+ouC5uou9IkmCm3sNNv6GjrhiEpLU=3D?=
X-Exchange-RoutingPolicyChecked:
	d0JRvaFZW2+sVtqh4pd/YzTC1T+1HJRhSjesWURs8K9g1S+ioEgCbO1ePbIVW96yAMI1HRJT9HmPjA9pa2PrR0yWD8+WoLs0fC6ebQw82wKr+OJZ5WiZ0D/B6Y+yxQUCJqa6yCXjJ5Unxvw9Vfw9NSadnwkMMr7gsitt6QidmWB9BM0IvvYKapc+iON7wZem+z/AA70MpqOf0JW8eTIVdcVoMLXCDU14F+Yqrkv9bBPIIz4RrbqKqJV2n+XUrtn5kQfT1k3+OQQPC/HJvWk3dVketrPLW9vuU8ZH8tDOUDbt6BUqxVerA01EqCQc2dqYwHKS2XBShAq4/ZaD1DfJOQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8dECQv9q05267ZtCwZJSNMWmXCKZ6aqJPPO94oIPdJ6ch/ReRSGP5Sqs4lOoCjFjyWKKKxA55TlCVUn3cHUGOiXX7bklfv5ikQZ/+GYGO6LK+KB5T8VgJdBCcUPY0rtzCPU5XqirgzzmZU0wTkVMKU4zjRMV9wVbun2S1eTUEtg9qKYTb8cW0PG8OG4vGGB62bd25GMGeY98W53uatw6b5j+SsYQaXc/4UKpU9tulOdv4ZVBARwCBBFJQUXb/zOFoIP9ZojRS77993Fiq+3myP3Lv0dUZ/IsvdTNyFlGVR9p54D7k7YDUbaWyH6ObxrEGbubjyar0Bq2qruSgCy17Kl/bV/c748enGzksPd/R+xPvrImYfeJOHSWtmjAuvX6LGW/hOlhVQEnX8OnEEh9d56NlGPuiiMVvkmW3n0sDo5x/9C4lwlSw1khAp9a9whUdG1ObWXgHTRymkRfsDyNOZFGQLC//rU4f/h/8gCJePdeWsvVVOCjL6LzwOUYh6yiWxcljgQEZ6xYGe1PhCeyk90rePoXwOcKGDpCjvSVuavuAxzpkKAC6sNXlbgvxWotpj5HFopdvVvycQB+4l4LhXhLAIfXpGAeeKOWgupY9b0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7786fca-5953-4581-2682-08df4ac3b489
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 07:14:11.9538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FmxeynrHaynOaqt6rG2UEcI/YM3C2jnNS/w+cc9Uxy9TNQ6JQzsJCtIiWqIkAm+mIj1hXpf3GeP8oj0Svy7Ytdn+bp5hkQh7JCgZ7+PSIks=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB8023
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_02,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 mlxscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 lowpriorityscore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250028
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDAyOCBTYWx0ZWRfXykK3Mx6s6PHe
 LjT+JkN/C9pdD4F8rQANzXINP9AuVviNB0rl2Xw7S/LjrvBcpRmkikvL035xOG7P1GeD61fD/lH
 hF5UPrPYKsvW8j3nJtfiakhueFKKOgpZWCa+TkOArxHvFVnTRvCp
X-Proofpoint-ORIG-GUID: tDKsUCBnUb3mII4lxwlk_-wx98ZCgeBN
X-Authority-Analysis: v=2.4 cv=ePaGH3p1 c=1 sm=1 tr=0 ts=6b068aca b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x0eKOSpe3m1H3M0S9YoZ:22 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=JfrnYn6hAAAA:8
 a=vggBfdFIAAAA:8 a=yMhMjlubAAAA:8 a=yPCof4ZbAAAA:8 a=xjBfvZVMSjtnnSOzluoA:9
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=1CNFftbPRP8L7MoqJWF3:22 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12101
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDAyOCBTYWx0ZWRfXwk+/w0ufX4xI
 IcPaZPFd2ywDmCJDhEwprqrucodFZb8LUM13DqTNp/g/XKZAFmKtZvLUoHunowwb1mU8cxeaGb2
 KgQEy7cMyR81KuSJ6tPuT/FWsPn1l3KQcKu8HMW2PMPSK7509tnz1v4LUv2EIGuEXejPdAaZnLH
 6dIactVy133SRtF9nAJnUC1lfhoRiBkZv57P6FGE4yhTvmt+wGBqjcTB2S25dieiqxjUaeUOD7L
 aiBk4f7+tV6UC1UycjPlAqmv68gHS+uLP10+BmX2i6ZV3jBVPMlSjPZkOUzvLB0jF6AzkMEtlFn
 Pb+v6U9EfakTHzRTZjWfEqoGFEgZvUILjcDmvyNvTUmu2ytbom1UTq2H0Sp4rq3K++71xy7THQT
 XWELwoS0iDenO7m8QSDWQTzPu6hbTNenWvprBBwEgQANRdLzz0vXlDiGpx8Pl4xtB2Sq8t7wpWw
 0szUx93La+zMQ9OGLCwOUDtZHDHjgriRkKqlRaDQ=
X-Proofpoint-GUID: tDKsUCBnUb3mII4lxwlk_-wx98ZCgeBN

Add smp_cond_load_relaxed_timeout(), which extends
smp_cond_load_relaxed() to allow waiting for a duration.

The interface loops around doing a periodic time-check, waiting for
the condition variable to change. Loop iterations use cpu_poll_relax()
to slow down the busy-wait and these, unless overridden by the
architecture code, amount to a cpu_relax().

There are two ways for the time-check to fail: the timeout case or,
@time_expr_ns returning an invalid value (negative or zero). The second
failure mode allows for clocks attached to the clock-domain of
@cond_expr --  clocks which might cease to operate meaningfully once
some state internal to @cond_expr has changed -- to fail.

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

If a architecture provides a waiting implementation for cpu_poll_relax()
(and signifies that by defining CPU_POLL_RELAX_WAITS) we define
SMP_TIMEOUT_POLL_COUNT to 1.

Lastly, config option ARCH_HAS_CPU_RELAX indicates availability of a
cpu_poll_relax() that is cheaper than polling. Long timeout values
might not make sense for architectures not having ARCH_HAS_CPU_RELAX.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org
Tested-by: Haris Okanovic <harisokn@amazon.com>
Tested-by: Sahil Chandna <sahilchandna@linux.microsoft.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
Notes:
 - Expose the timeout state in __smp_cond_load_relaxed_timeout().
   We use it later to provide acquire ordering for the timeout case in
   smp_cond_load_acquire_timeout().
 - Associate the kernel-doc comment with the actual barrier, not
   the helper.
 - don't reuse VAL in smp_cond_load_relaxed_timeout(). Switch it
   with _val which is safe to do since cond_expr is only evaluated
   in __smp_cond_load_relaxed_timeout().

 include/asm-generic/barrier.h | 112 ++++++++++++++++++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
index b99cb57dfccc..bafc8eeff132 100644
--- a/include/asm-generic/barrier.h
+++ b/include/asm-generic/barrier.h
@@ -15,6 +15,7 @@
 
 #include <linux/compiler.h>
 #include <linux/kcsan-checks.h>
+#include <vdso/time64.h>
 #include <asm/rwonce.h>
 
 #ifndef nop
@@ -273,6 +274,117 @@ do {									\
 })
 #endif
 
+/*
+ * Number of times we iterate in the loop before doing the time check.
+ */
+#ifndef SMP_TIMEOUT_POLL_COUNT
+#ifdef CPU_POLL_RELAX_WAITS
+#define SMP_TIMEOUT_POLL_COUNT	1 /* Wait mode. No need to poll. */
+#else
+/*
+ * Assume that cpu_poll_relax() provides a small blip in the pipeline.
+ * Combine a reasonable number of cpu_poll_relax() instances before
+ * doing anything substantial like a time-check.
+ * Note that this assumes that the rest of the loop (largely evaluation
+ * of the loop condition is relatively cheap.)
+ */
+#define SMP_TIMEOUT_POLL_COUNT		200
+#endif
+#endif
+
+/*
+ * cpu_poll_relax() stitches up two kinds of primitives: ones that provide
+ * a momentary blip in the pipeline (ex. cpu_relax() on x86), or ones that
+ * support waiting for @ptr value to change, coupled with a precise (or not)
+ * timeout.
+ *
+ * We keep both together because the objective is to minimize expensive
+ * operations while polling on @ptr waiting for it to change. Either
+ * version allows for that.
+ * The arguments (@ptr, @val, @timeout_ns) are only needed for waiting
+ * implementations.
+ *
+ * Note that platforms with a suitable cpu_poll_relax() implementation are
+ * expected to define ARCH_HAS_CPU_RELAX.
+ */
+#ifndef cpu_poll_relax
+#define cpu_poll_relax(ptr, val, timeout_ns)	cpu_relax()
+#endif
+
+#ifndef smp_cond_load_relaxed_timeout
+#define __smp_cond_load_relaxed_timeout(ptr, cond_expr,			\
+				      time_expr_ns, timeout_ns,		\
+				      timed_out)			\
+({									\
+	typeof(ptr) __PTR = (ptr);					\
+	__unqual_scalar_typeof(*(ptr)) VAL;				\
+	u32 __scl_count = 0, __scl_spin = SMP_TIMEOUT_POLL_COUNT;	\
+	u64 __scl_timeout = NSEC_PER_USEC, __scl_time_end = 0;		\
+	s64 __scl_time_now;						\
+									\
+	for (;;) {							\
+		VAL = READ_ONCE(*__PTR);				\
+		if (cond_expr || timed_out)				\
+			break;						\
+		cpu_poll_relax(__PTR, VAL, (u64)__scl_timeout);		\
+		if (++__scl_count < __scl_spin)				\
+			continue;					\
+		__scl_time_now = (s64)(time_expr_ns);			\
+		if (unlikely(__scl_time_end == 0)) {			\
+			__scl_timeout = (timeout_ns);			\
+			__scl_time_end = __scl_time_now + __scl_timeout;\
+		}							\
+		if (__scl_time_now <= 0 ||				\
+		    __scl_time_end <= __scl_time_now) {			\
+			timed_out = true;				\
+			continue;					\
+		}							\
+		__scl_count = 0;					\
+		__scl_timeout = __scl_time_end - __scl_time_now;	\
+	}								\
+	(typeof(*(ptr)))VAL;						\
+})
+
+/**
+ * smp_cond_load_relaxed_timeout() - (Spin) wait for cond with no ordering
+ * until a timeout expires.
+ * @ptr: pointer to the variable to wait on.
+ * @cond_expr: boolean expression to wait for.
+ * @time_expr_ns: expression that evaluates to monotonic time (in ns) or,
+ *  on failure, returns zero or a negative value.
+ * @timeout_ns: timeout value in ns. A timeout value of zero is treated
+ *  as the minimum wait so we evaluate cond_expr at least once.
+ * Both of the above are expected to be compatible with s64; the signed
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
+#define smp_cond_load_relaxed_timeout(ptr, cond_expr,			\
+				      time_expr_ns, timeout_ns)		\
+({									\
+	s64 __scl_timeout_ns = (s64)(timeout_ns);			\
+	__unqual_scalar_typeof(*(ptr)) _val;				\
+	bool __maybe_unused __scl_timed_out = false;			\
+									\
+	if (unlikely(__scl_timeout_ns < 0))				\
+		_val = READ_ONCE(*(ptr));				\
+	else								\
+		_val = __smp_cond_load_relaxed_timeout(ptr, cond_expr,	\
+						      time_expr_ns,	\
+						      __scl_timeout_ns, \
+						      __scl_timed_out); \
+	(typeof(*(ptr)))_val;						\
+})
+#endif
+
 /*
  * pmem_wmb() ensures that all stores for which the modification
  * are written to persistent storage by preceding instructions have
-- 
2.43.7

