Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3545C2C15B0;
	Thu,  2 Jul 2026 01:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782956118; cv=fail; b=ARo6Ww1Ue8MPtmDNkTwLzrLiRzVG/LgZ/qGzKFQ+tGcdnoI4r3bocRAmB4n6+0LiXGPV0kHmZOL0Y+MUy8/2t9zUt9Va4vu8yIlWgC+V4No6fc7D3PXQWHbyT8nX0S/nu97AHE/W3rx9MJwAUh+0ykHLO2ReG+uZh5qXmN1/FyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782956118; c=relaxed/simple;
	bh=5X9U02aS4T8loT3H8XpIbPonFBPvCzFQej/Dq2yztC8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i5tDiv7VBBTV7F4bGxbDjkfG/8FLg7qZ/a0/pRtAv6wz+uW4D6tVutBXJT7XA/yRBgTsg4WdqdAMKbq2SEy/x7aVyW4kGm5lbnpjfaf5wEPIOWY2Zh/YpbHKn2tBZk35xiCGVrIrLTjBrvLt/zLXeeGXXtmFwWDnK3miEFOazKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=D5j+gzM8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=w56qz+Ei; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="D5j+gzM8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="w56qz+Ei"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661EGshs2838611;
	Thu, 2 Jul 2026 01:34:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=5Urzdw0yqkCzs1wDL5pmAGbiBV1x7SWWrwo4lrMKHUE=; b=
	D5j+gzM8VejB7AM236qBFXX+QKvFfOxRtzvTPDAzB9TRCZSfFHGIREw6DcX4rdIP
	rnUTPSAzROYu1PWC5gxrv17728N/tUWPR7AmuGG4NmHPQMy7Lc+EfVZvTbEJwdew
	A835iMFLbcZaVqEx1tu8kjMwOy5ol1ugQ+z1BHdAyzbsWWjeH56pYFF225UlkT9g
	B0Ruf0QHrAMfn4lV/kK0jwB5+sVN1SZXye71qiTyRD5xpy3WJNbqZeIMYzV7Z/lj
	wlfKED54sq+Bb3+4SQY9Ci2vXUdAu3IKhLpJmu1QjCynO6Uo2KVcjqHG8bYCqw5F
	rgX/uVXoZBI/RQvAhsKqrQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4f26p4786m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Jul 2026 01:34:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 6621X8no012640;
	Thu, 2 Jul 2026 01:34:45 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012060.outbound.protection.outlook.com [40.107.200.60])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4f24yg6x44-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Jul 2026 01:34:45 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DTs5HSI9Otncxy54Wmsl6VKpUn5I61Yttoz+fpkT1zn+pZJgmtEF7mGW3QlRzc4S/aaUi4ymHqWRUnZgDZkIKKUECF8hQNiA/A2eIWU+E+S3KioOFvaGcUr4E+dkIx4VndurCTjjhQyQdOIKEwccvh0iZyiGTHSBs3rX9cGoxyzpJIF3sihvxggnkYa1TCYnUlz9qoBSXaSO+1NL86zNZslgNBbkrkKZEWV6BfzuyDfW1KKSBxg8930GfLfldfqTSPwEtU7Vq29Jt56JQTdHGIqfJ/L71qH8tNoWJI9/4X7dcdRPtjQTeLdG2BhQ4Cb9lhxZ2jUDw4awV+pL9w6Hlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Urzdw0yqkCzs1wDL5pmAGbiBV1x7SWWrwo4lrMKHUE=;
 b=BPCY3UCKRCoQG9HjMQXgKuDYnSHsTB7TpmVn3IPDeHiKDrS8wOPHorUNdgDf6XvKZS9WOSaD5HuUqn3fLRA5i4vFqibBsBWf1w1ERfoRTF+DMkKy2jwDdcyHncxy0TY5sHxJ7XGLf+VubobhYHRSGmMKAB1PazZyzDTZJoSw2RSThq8NL9jucydGQSiG+5H2mvTnTL6Cvn3K+DYFlFru73dCpHSPD8rk0q1VsK6VT0bhdWVziSMt+gdwGha3pRk30abW9lf4WLNwTJ0Qa6SIUYn6dog3njQx6Rjs3qcpxFSofVVZmM95VOV959tcYCRxbcaUvZIUjMpDyiU+UhP8Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Urzdw0yqkCzs1wDL5pmAGbiBV1x7SWWrwo4lrMKHUE=;
 b=w56qz+EiBA1syIFMYSQSrsOviMKy2/daHzuAmtdye7/3Y05uM/ly+GRgUCqXz3XDBn75ETD01bXKVGOsjmLzq6TQelxla6zM3zMgoqckImnvn73hk3cu39FJhvNMLifNMyeAJu3H3C23yG56hSI38DJYAKe28Nr1vpLnjg+4Ucg=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by IA3PR10MB8760.namprd10.prod.outlook.com (2603:10b6:208:581::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Thu, 2 Jul 2026
 01:34:39 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 01:34:39 +0000
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
        Ankur Arora <ankur.a.arora@oracle.com>, Ingo Molnar <mingo@kernel.org>
Subject: [PATCH v13 11/15] sched: add need-resched timed wait interface
Date: Wed,  1 Jul 2026 18:33:30 -0700
Message-Id: <20260702013334.140905-12-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260702013334.140905-1-ankur.a.arora@oracle.com>
References: <20260702013334.140905-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0412.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10b::11) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|IA3PR10MB8760:EE_
X-MS-Office365-Filtering-Correlation-Id: ea50547d-1f00-46b1-5b19-08ded7da1518
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|3023799007|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	q7zVBqFTOT2kVgtzS5EBCM6gr9iHEHFIlRO6khWbV4R/Yg9y9vOZAyyvDAIpozvYv35DgoZ5WjyemuHmWx4/zDmW5Y2KuW4qYPPT8UopIKupXnGMQLkCyjX9GX08RNTI3b2VJaLl1WwDuoki8qvVoFR2vmUoS37mV6svs+dB2fud4TzZNil7WMiBnMCRGFnpDsoA+8nup+Ngo6X7ORq+Kfh1J3RaJWZJ5uxitM9FpPPhUl2veg8RcXIAd2kYdHr/EoLS7zNf4oUsHVx5C3yybBl8aBIFAOe3eyeWVR2+OYJ8yU9BTpce1l2TZP/3IlYI9FPjqMpWg3ncAwd/BnqMkkmmLhFFKf3zV3P1mXvuUuaeFsXUq+nJ9t+fJ+LfxrNQSPsmGJkLaqm6cQT2tL7e0fGV4l7badNl4EGxwth5BL6aJWij0Q3lCrBpMiYQhk90adjbldMHgt0RtMLc9tcjdwQusCSebjtH0d139LdRQ03z+IoxrHDyrhOk6SJVFrY1GFydKsehPdLG+ZyGxgxHk2q4OiF3Z/sBs8IpHLDmdN44Iy7Sr5I25GXt+1SknCbIfFQawl1ntsrwLpi6RbNV3R+ELAd4CA3Lvj6c0d/5v0HJsQBxlTlD5HxegNPZUTUpZ/M0/qp/2KldVZN12fiKQLvFY29ZZ80jGjafFiVaP94=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(3023799007)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SMLCFGQo35/+8HusyeJcSdieB5VMDqJ4nX4pDv+8HsbfRRd37lzsdA3yi9Dc?=
 =?us-ascii?Q?3InDs4OuNd2eGT1RPMWd+K75Z0pT9Isohqgcl8TXmxyu1VNP8tiGcFvQn6TQ?=
 =?us-ascii?Q?gwm4MoCPTNVZTRh8fjpcaATgDKi7w1CSNpEfpPVtLzKH7DwiPhKCRD1cSZjE?=
 =?us-ascii?Q?yRlUKe7mDLKtUps+JBIqwChdREHPl4PRQ198gehla3n7IH7kCn8ItGVawO2n?=
 =?us-ascii?Q?HnG9f3hUrAU71TYC7DhjnwAbjrJNf45Ki8OD0nX8p96nWT3fBUDrxEStNVyz?=
 =?us-ascii?Q?F2+YdJfS9bNWdV0V0b85ESUU/ISG9SyEG/5Ko20efGAHQoMHJEgI+41lUtHU?=
 =?us-ascii?Q?O0ClbeFlWK8FNt+mTnrDpv+NNwix1s2xUWFADpJfvRAR2HXCvz/Cok+aSEe1?=
 =?us-ascii?Q?ejmG/Js2RZStybhLKzPmuKndO16hX6ixdnfDvMOlD+htyyrehcnmUPlOUMVj?=
 =?us-ascii?Q?nzGdzB4cI+gfCac/H6DvS5czBEfGTJYmwM/dMZl1YuKvDGNLun2CB+T/bPI+?=
 =?us-ascii?Q?NYhxziIFdNr9dcfZJ2QT3hNIXLhXF4eKW7g262VayF+5grgE5rv+Tlm4/mub?=
 =?us-ascii?Q?BENbbDHcdrmdsCC0XF4PHcTWcZDZR9IULOIkPIOgy8w4GPWf/zT0s3fd0n/M?=
 =?us-ascii?Q?xKbUm0wyUjRNHX8RJ0BxDY4l/zmWeGpKz0Dt8+6tM8we92IPsxJYI1hlEhD/?=
 =?us-ascii?Q?ENQAlb/7EscttzMGhTOy1wNq1iP2GJ8lkxt5ooln818wpdRLuGZo0cY3qVuG?=
 =?us-ascii?Q?Xgl4XahKB1o1dd48X+IFtaUZGi6QX8Y7djZ3hhrgKIP3GNRrIuC5X6KZgxZA?=
 =?us-ascii?Q?RnnKqiX5wNebtVji3V4Xj70P4xsnSDs4ZsAOYoZtz3EUvIgHyxjNjco4m+1V?=
 =?us-ascii?Q?3z7g3ZVvJ5SmntD/sdr9w8w61IJC0KwY6mRtg3/9R5vh4OlcgJ90LAEGsErQ?=
 =?us-ascii?Q?qHS72voXKcJKghAKjv6jjLniNWJiwHP3e+w0+K0CQECBIa/cCkyMSAzjNXCo?=
 =?us-ascii?Q?pgP9R0jnarr6dn4zw8MbMotwhvV0cUlFBo1X+WGEHlF7vxKgiERlU7YlNcjQ?=
 =?us-ascii?Q?HMpTfHsVV3zE/IRAYj+yV+XLL3eUfncHTfk+TBvY/NPrRV4y0dGzLRx+jwsu?=
 =?us-ascii?Q?0UIjP8FOVYcqMuN9cpHhXi3IdJWZ1sIhMt5Txibjok+jYbKsZ+xgNveAeaQc?=
 =?us-ascii?Q?r+MARWkOU0EQWn4k9yt+W6MJhYyT7jn/4xUSwmVBQvhI8KBI9K/+uGvbGTc9?=
 =?us-ascii?Q?DT/d7VSvkgKtMV41jNvXZssvxtMBJEarC0JSgcQLZhFLTrPT7thzF+2hZo0H?=
 =?us-ascii?Q?IVyXTt4DzwwFCwazSuiqgw8XV8wgUNIKJiFpX5xi65vtUoiCtooct6te+O/D?=
 =?us-ascii?Q?HO8GCNs6DeQyTYHraet24dqtsUCCxpIMIdnnD1X4UcDgYXEf1PtKmICEKE/Y?=
 =?us-ascii?Q?/8jY+SpGI6OYNOBNx2lcuhgbobkLH/vEF5XC6VO2/enVzLmcnEkwRsOEb3ur?=
 =?us-ascii?Q?GXDrzkXwGreLcdMj3viT+hOkkZbNIlrer7oBl7MtRdvM1b9Y95sjNH0a76r+?=
 =?us-ascii?Q?51SlQM7jV3oGXGxRv+bV5njIu8Rxi6EEFn16VF7nUWH+04RAyOpGYh1ZQn5u?=
 =?us-ascii?Q?xZGijGv6Ji9Rb5BPzXE8BjNzkGF2GwAQcVI3XPp600YCc7rPOrfymcQGWU95?=
 =?us-ascii?Q?U6aGE13NDZi3+Q2hnEgRwG5x7/9V44z/c9x4loWnasqTzYLvFX/JaS/MUHIr?=
 =?us-ascii?Q?zmLNzyMQxgz4AKsUzF9ExOLVCq3FnhQ=3D?=
X-Exchange-RoutingPolicyChecked:
	p9qOk6FQT6IttLw7hBrxoyhjGL9j/YYH4cOpXDhp2Rdo1Za0YJYfPA1ed9rfeDFte20DVjUsHgXWVN5ocNsnJZysVQCiFIaCI8DhH9MSsUzSHuGrBGCdMeDtTpSgviFyGLRztoaEIegfXMIxoTHzORwJUK0/fSrF0uLyOXOHgHWMj1A26jDkGjdZVhzbNjz4FZ8TyDnTEjcFdq+ab6a6/2wALOVxWFXu7KfaKOHPjYejyRBNCJAM2guMABJ8xHblonWMdoCdu2wgPTudTPoKOVdxMCoDFwmp+iWo+BdCXMYb5H0eg0/qTqh8KCl591UeuQShovPZEj0mP1ryGpCMqw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fedRJ1xTpc9638yOD+93KjJFckF8WEOTIO98tUyKL74A87WVP6onIqlYHhoocP2DkVbWdVE2TtakazigS3EBL0443S1tEGMtWCdQH7UGVldahzvuPAni7DRDclFqt0tqmg8jcd40sKw5lxiZGX5WDbYC38rxLyDD/V7JkuN+RZSkZXxnIkw1KmtMEyLFtqd3d8kJhjYV6fxj4/7nQHvwgJR8Zs2Se74vnxLBas6kOEzIwejeV9c8PFtDzu88piTAPpVX7qkswAfHUw0A7Wt5L7FAAZYrRLWgge2O4uGWIRISNXlVwd3cyRCZXprCDa6YS6CiApDZFsVg9Ixyte8EiTjX2oY1SOubGRi08aGOSdiDqDqotmLuM9102fvdKXN3wZPRQ0c4dtFK550eIY3XKR8cA4rIV5JFRHCEAtXi+Mas5AjRmCzndApjwuzclK9XmS+26A+dvdzGjfUbM8XW3MSQk6oQuabg0qXcOK2zka+YCL45PDXcKRKrAAfWjfY8g/Q4SlUhZELBBdVCqJvttudUABFubxegKkmq/rYvOoDu7dPsM3UmZT6IHrn3biCTlmoxeDnb6imZzNH6SfI1vUV8w+4jAbSShNasPgtf8ts=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea50547d-1f00-46b1-5b19-08ded7da1518
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 01:34:39.1532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cMzLgZfvqewGrW8e4HJzs9naSDcrTQTe21mUPbMagwS8MHn8tNh0vLruueN+Dpj03gbqhsFmbaSlfJ99M2mqQY0xWpvcHwTj7aJpbpsN69U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8760
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 adultscore=0 suspectscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2607020013
X-Proofpoint-ORIG-GUID: rr1wDGWULJg1xxbu5Rtrzuix637PR-ks
X-Proofpoint-GUID: rr1wDGWULJg1xxbu5Rtrzuix637PR-ks
X-Authority-Analysis: v=2.4 cv=DK6/JSNb c=1 sm=1 tr=0 ts=6a45c037 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=KKAkSRfTAAAA:8
 a=yPCof4ZbAAAA:8 a=DC2jtUcBNbVnd9lHvZoA:9 a=1CNFftbPRP8L7MoqJWF3:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDAxMiBTYWx0ZWRfX+1loiB4kpoIe
 CkkDR9bcF3CeaGBDjJJT41zSUOM8QC7Q9FE8u62t7Zei36er9lSUZing0PcbPbVnLLzKi33R9Cu
 Fv3EtyQKKFD8ec3I+J648DP21YUlyhdg+WxFPb+m9jx96jbhAYOYDyJtO+AnWLtTazqNGhy+ARO
 saFLwFUa3G0TaWO+iPOLsXiagpEv3dHaMVYVcyHY0hDaXKiaV+H8MPkIM3e1yPqpBdsU57XMpgu
 CGv6Se2hwi77PaDfFVmFJq8THdxQhHFDC31OfGZAJVyxBNlURx8iDqPtM1QdZHux2B6vE0oNy/U
 VJuAy7fXrHSoPieCn6dxsLcXYwzPiOgaZof97lZjnAtV2NW4ZGZuelEzJEv92B5ANFC+6mgTg92
 nvF5xTa41c9hko/sIsYODeV+6gJOUF6xjM4wFE6iB6U8ZhK+rUOS36jFbt+sI2LLij+V5RtM2Ky
 mmvabMTObcxO2uIZrHw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDAxMiBTYWx0ZWRfX/c7M2DU4s6e3
 JnjvjRZ78XDJuBJS51DLFwMosPZm2bTxIBj5u0Vu9704D0FSqRg3lF5qrW00bB8J18wlPz2gURk
 GvDX3vxq+FRQalt3jOvMP+3QQOz+YTGoNY0Yfrd3tilR5dcRpGKK

Add tif_bitset_relaxed_wait() (and tif_need_resched_relaxed_wait()
which wraps it) which takes the thread_info bit and timeout duration
as parameters and waits until the bit is set or for the expiration
of the timeout.

The wait is implemented via smp_cond_load_relaxed_timeout().

smp_cond_load_relaxed_timeout() essentially provides the pattern used
in poll_idle() where we spin in a loop waiting for the flag to change
until a timeout occurs.

tif_need_resched_relaxed_wait() allows us to abstract out the internals
of waiting, scheduler specific details etc.

Placed in linux/sched/idle.h instead of linux/thread_info.h to work
around recursive include hell.

Cc: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 include/linux/sched/idle.h | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/include/linux/sched/idle.h b/include/linux/sched/idle.h
index 8465ff1f20d1..ddee9b019895 100644
--- a/include/linux/sched/idle.h
+++ b/include/linux/sched/idle.h
@@ -3,6 +3,7 @@
 #define _LINUX_SCHED_IDLE_H
 
 #include <linux/sched.h>
+#include <linux/sched/clock.h>
 
 enum cpu_idle_type {
 	__CPU_NOT_IDLE = 0,
@@ -113,4 +114,32 @@ static __always_inline void current_clr_polling(void)
 }
 #endif
 
+/*
+ * Caller needs to make sure that the thread context cannot be preempted
+ * or migrated, so current_thread_info() cannot change from under us.
+ *
+ * This also allows us to safely stay in the local_clock domain.
+ */
+static __always_inline bool tif_bitset_relaxed_wait(int tif, u64 timeout_ns)
+{
+	unsigned long flags;
+
+	flags = smp_cond_load_relaxed_timeout(&current_thread_info()->flags,
+					      (VAL & BIT(tif)),
+					      local_clock_noinstr(),
+					      timeout_ns);
+	return flags & BIT(tif);
+}
+
+/**
+ * tif_need_resched_relaxed_wait() - Wait for need-resched being set
+ * with no ordering guarantees until a timeout expires.
+ *
+ * @timeout_ns: timeout value.
+ */
+static __always_inline bool tif_need_resched_relaxed_wait(u64 timeout_ns)
+{
+	return tif_bitset_relaxed_wait(TIF_NEED_RESCHED, timeout_ns);
+}
+
 #endif /* _LINUX_SCHED_IDLE_H */
-- 
2.43.7

