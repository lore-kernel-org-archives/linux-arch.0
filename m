Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB923EF649;
	Tue, 14 Jul 2026 07:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784014352; cv=fail; b=pKZy25hnxl97eGba4zDfHAxZ5HIDLALR2omHdIfB0d+RNaBvhqOW7lVRFtDkhYfELheUmPX8iIfdu2Suoisvt28zVMHlb/maXtF9V24NOiAOzNNYohX5l9Nzn1Ri42bG7hKY9JuD1SF2b16TIHaqxeAr451wIQiQKwE6r/gQ9OQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784014352; c=relaxed/simple;
	bh=RDLq4kxv/mshx0hXK7zz531b9LCUJDjOXvdZ2PlIWZk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j/wCVk6fqeetbRO3gWV5TbJKdj5JLwLOvk0p9GbP/4sZ8dZe4DcXUd6QumqNQfvS1RYMee0cPCdIjYOFyOJO38vss1bmmCN3tQP2mWyhRTqYJ34PCAweNaa+2BwuKwwAyWnrEdjdMCyEXL6sbmIWy3uZXvXeXtW0/6paxse4paE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=R3QJWC+A; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uiQu6lpy; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="R3QJWC+A";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uiQu6lpy"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DLFiLM1346009;
	Tue, 14 Jul 2026 07:31:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Qc9kxLkDGha/9o5ViVD+9oBCbKgLib4L+J3lTykDaPA=; b=
	R3QJWC+A0sKYYshO659/6diD7VCp6vhqhmsgT7GcmgJk7gE0POOIooLmQk7KVsx0
	dEpwY4fKQyYvUgsMIfQtmqCglADQkdplXlSyvnfOB8Koifxhl81OUbYsVUVgb7AI
	8JfOfd+BYpSJyvPUBd4zgRy9sC+3IjzN+ExJEM5S+pSGqwLWty4NOpNI3P7tbbcY
	Fdz6wiJeDNeYnqO53WOslsB6HYVGYji1qyYndIO4lEgAQDH8BIoFvBmMVYjl5CCi
	1mGCnxV/ZrXzVOk+MT+KqGAoqBLRunRene2UWmmvM6gjpvPcacJolJi55IZNikPM
	Z/2m4E3Yo4uVXERg3INHzg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fben1kmt0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jul 2026 07:31:03 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66E7SWOU035514;
	Tue, 14 Jul 2026 07:31:02 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012024.outbound.protection.outlook.com [52.101.43.24])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4fbc9h48a7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jul 2026 07:31:02 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GtuaipzpWVJJWMpixziRilyz5MOHg1gyJdAgmUPfdfmPL1uQy7rVVY+Vc1LP379sH1SRjCS1wrL8OsNmuIkVIsapLj7QRW0bTFVBxk7RvpYpJe/VCMpYimvzEiYblhEk5Lp6vGbdT83rOT9m7CC/LA8E+RKt9uFDxwsfSzSNJp97uAeeDbCxRaAYiUokcBRq6XdbWE3csAXZCvpB6XNG+OEUUIL0WX2PBCp9ZdlENRreG7EIZ4f+42Y6Hv6hKYoMCvoMr0kZ5yZittilz7PAMwPuAwlWKWem9rM9NEtueJMga5GfYQMHEuDj22+vC2MkE3P91JP9pkvFU/SrLkWQvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qc9kxLkDGha/9o5ViVD+9oBCbKgLib4L+J3lTykDaPA=;
 b=pWnQ5pfy9twtE9pF4LKbK2YYUhUzsMuwPUGe4qdzF8Q4pebPx0BfmzciowvH8Ib8NnvRUzRLHjigQQM9Q+QcaRoDCxxdbYrCxaj1TdTFPbsSO0aGCnoFKrLS9KwKpDxd3DLnh/x/Q3nDfHtv+0PtMhjpCpErO/XXkEawUKYipcfE8vd13O3eM/0XpCJbRoqvpN22vMg7IifEerVTeR+qK2JasZISJE1BTfuzk+UaZtCwW/Ym5x/0N09OqeSz3oVDMfFTiPP9KGFQcBBRkPq1MAZCEaeztCYv92p9qynN7O2WRldVA46vu2YS0ZfEVGln1ReAbP2hGmDIEaKMRN3B4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qc9kxLkDGha/9o5ViVD+9oBCbKgLib4L+J3lTykDaPA=;
 b=uiQu6lpy8WwZDGmkka4ZRHc6WHafPDr2fAkJBkWG+uh4pOdwudTOHAMv/+y+Op15Q78TYlBCysyJ7OByCtbHNDnzFkAL2mf44KSpYSxuHFSx8/n05/foO36z7YCo+bYrm8Vc1QQlKeX0f/hUxdXVt1r278J6Pwn+UZWYN9E6QzE=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CY8PR10MB7124.namprd10.prod.outlook.com (2603:10b6:930:75::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 07:30:55 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.21.0202.018; Tue, 14 Jul 2026
 07:30:55 +0000
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
Subject: [PATCH v14 03/15] arm64/delay: move some constants out to a separate header
Date: Tue, 14 Jul 2026 00:30:29 -0700
Message-Id: <20260714073041.40250-4-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260714073041.40250-1-ankur.a.arora@oracle.com>
References: <20260714073041.40250-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0299.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10e::14) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CY8PR10MB7124:EE_
X-MS-Office365-Filtering-Correlation-Id: ab77ba34-07d1-48d8-1562-08dee179d728
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|6133799003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	BgesFQtNjmdp18yPfCg+hdgThvGnaE+F06nt63c3IZO9ZsGBD0XHypRmW10p9D4dwQt5XS0ioRwomSc1ZbKr6bstDBBWZeL7rAj0nSZPuBJ2oLrOn8cNeawPklbSVDeLg+w1Tc2i4iWBLjdIU/Ombur78AgNMAhma8/8HC62JCLF63LnE059SaFdXv9Qa/AAXxtsXQ64i0pDGF0+6D8KLDGOeMEJnhn2TZnLFg95LaWeTkcNMXG6VvUaIGov0sXU9CaaU1IrxA76fJKUtpUfgh9Zqb0vcNllj9lISd0m+Imx5lEiVWLEVOptKN47SqXh6JLrifO+desrO4Xsa/wPzkqneLKM9mUEWuM59C/cmWrnDZpUhuSZgCifysIazdmOFXqV9sfP3M3Q+6qXU2Alsnsvz4MrDTWs+RakLaORVpU+kb3sA8CNgCe3mVY4GI507/dwQNlUr/YEcCBhCKDtp/0zgmxF2ZcL1Tfx4NMF4LMg6StryvI3tTNuhMWy891xBpmrVUqMfctwD6dE75l159//mjkV6FrM7C73Fc9VjpUmk6E2wCC4pOd6BJqPHxeHNeOh492xqmkKk/rJNfwyZDx1kjgdcXtx2GvP6yuTrUB+Pa90c5c+0O4YXRhgYdvJXU+uGZ2LeEaCwasyf33jeJ5OXg9NUTUHPIw6DW2Dkzc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(6133799003)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/YPKZKN43yaxawWKSUL2klUbzmpR3xQtBwPyGJU9eAH68di6yfSfbEhm4f9k?=
 =?us-ascii?Q?oou8kG1jxaAuuiDuk9tThfh9JxFU6mxZ12okSwESzXgk3XXgcNkFo1d90AeJ?=
 =?us-ascii?Q?usSLxGSLcKJzlsE8hc+dp4FaL+ODRbrag3fzlvIf4CueGIYu6ia/PeMcyTIt?=
 =?us-ascii?Q?9Yb8rhhoRs0ixnzYMCI11R359yLA7zBvcS1iY1Yvbq2+D84GbLclg2LvqxRg?=
 =?us-ascii?Q?DZIwmaI0QSUiZD9IFyAq8lRGm+zMnyUvjNJ0wqA8Z8fFegRg/XCKY++VXOyW?=
 =?us-ascii?Q?BDPHbsscQpu9QwkN4DY2Fox6UfmqZqWksRb73U+7EjFVyDPlzpKxnuA3bfrM?=
 =?us-ascii?Q?jMrFQYz1gsZNtM6IZKI+XwfoJjCYOehYguptVM5NuZdwr6mAi+1U9RBAJg1r?=
 =?us-ascii?Q?eozh5gGMbV741r/07aR1TicqpZK85kZ0yJbgK2EFs4xcEOG+sUFyE8o62ptw?=
 =?us-ascii?Q?KcBhHxgb2bvT55oMLqMUuThg8qeXukuhC2D23HsoAHlb4CstMWS8iN4Oz+Mg?=
 =?us-ascii?Q?st4UPLj2zNJW1YAxrCH4Ufas8JfnmLT3wnSbxDAHLm/VnFijiPKsiVWTePnk?=
 =?us-ascii?Q?tpq5u9eoC6Dj4wZB7vO7XvkOwAIrCqcM5VEH/vuGbE+gknBlqkyqNL4NUPvB?=
 =?us-ascii?Q?cjC6l7a8swBbVNZxNb6DHGNXGyikp/HxyOvZNs+rvQxQQGdUUPINe9TibLho?=
 =?us-ascii?Q?JuwfMvfFiaHLFtUcFmPpaK7TbMTMYb8rbRjssbfGpwm8JIMe8x+pjvH3fx4D?=
 =?us-ascii?Q?9+QFyKNUILkyFpyE3rktztOoZLXSyrRkrVwaIEJ5uzQS+TQB4k2s7ww+oTu+?=
 =?us-ascii?Q?UvIERqmYaAcuIMVbLimrQQgyxOPd11MYZmQGrgmWEj3AJQclwtuEYnquZ00b?=
 =?us-ascii?Q?2JQGwjJE2m/zG4cIz4Sa6hxDuLSjqNbQYKtYeuFfSCYUhLbaP481eMfJAqEK?=
 =?us-ascii?Q?dUKzugRn3FBqEw6fItWdOcPMkDPFWbK2DXRPqOseEESo7ZwjM9P0sPJHGkEX?=
 =?us-ascii?Q?LJXuJQDAaZ+J8YlQNResbCeLZuOzMXfx8j1jBmWcc2t6VicsiRP1fikA7vB/?=
 =?us-ascii?Q?TDU/W09bs6mFaxpjWg/aI5D0r52Kv8M6efNRLZgFKR8qwZyEn04uxYDNnRFd?=
 =?us-ascii?Q?KUbV8KbkqGWXwgx6uTxwtxK9sZ5VDhBO+Bgox3yEHu2g9Ad6VDB0EO9E8bU3?=
 =?us-ascii?Q?1NvURPoVmm56IZhGns9P5SPe/FT2Qqy39cju/qwc8l3oCQDw5gxoJGmIbLgW?=
 =?us-ascii?Q?RbphE+gqVE3IHuy+sRC7Fws9P3+zfPb0NKZ9KLO4YNXFKirmC7j7xebyPZQh?=
 =?us-ascii?Q?qOcXivA7fGeEflG7Dr3KhsLzgHft0kokWJzwFSfq36tdq4MM77WgytmTprvD?=
 =?us-ascii?Q?DbKO5CoVNvNCYlpbir2UrbkUjz7Of2G6w7wrC2V7FJ5WxSWXry6I5vZX68/p?=
 =?us-ascii?Q?d1ZumvL2pJdSRs1vfQTgc5Cz3+0Fnyp1GilWSxio6gBtox9kOMW5OMfr5EaT?=
 =?us-ascii?Q?XJ+66zxvRn7mmH6+LV7ODZa3A4ROP8/KDBlP/kO2zbU45RF2HcdgCVTehakg?=
 =?us-ascii?Q?HrJVcBuLTCJ0bnSLyqx+1tFfkf9j15kDJuwmcleKciKOCj2nxXrXx9hn1JVx?=
 =?us-ascii?Q?79gid4CdMsPNttuHzIk7udoW9uGupWcJZjHlIxr4HJXxjkqQVS5hvfo7aEBu?=
 =?us-ascii?Q?Bq5kYFsAqxizh5yU/K0Rk33fRDJLYu13diEu5rJ9dcM+9jb64kkR/5liUJ8Z?=
 =?us-ascii?Q?ANr6x/TumXIc8WzXQ4oxADTSFnM89EU=3D?=
X-Exchange-RoutingPolicyChecked:
	pwzQn2nPqhES41jmRpMDbaedU/61p8XN3vvVqK60pwLYwqu1hqFXorydsjG3z+QBGWOmzhDpZ6TFjWACWb/ez2T8C1lsxY1mCYtwkWcsUM7+EsWy/8S8SwHudQrRz9mIyH5jF945CeN31vWkb+DE/vrYOTt9QXFTPWCFg4TfGct6fVq9+dCFXzVetZXu43zzuA0RwXfqWz2PVAUs3Pmksq6EuwF5ewnwQ5+s5m0hpCTMeVjDyyIdXuteEReAPdvt8SoD1UBUkQpkC/77p3OKo9PSfEgwwKk0xnjBfYbatYVLH1eKOLQqk6WCh2vRKVAD9d/5ut/6Mt7nv+JF2LwVHA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xFvdSHniY5ITOK62+G6htt8KvBzYpvEM3yPY+iGhe8x1ZG8ywe3WrdJ3n+Amn5Vv/CEle2HvcI8L8NckxQJamt8tIz9B3I0bDY8Y4gkM+8VI5jCmXhAiQSYUw8hf3U9ZaFIs9HGSGtQ6tUUYh7STUHgb8TfTgGn8W23n5NqCMtsfP2xTdV//vfShidFrd47RBeXryb4nt9QKzQasvSvNFBj/UK0/UhPKd3HK/XfqAXYhFEr7lUrmSN67o2Binm+3zjuUi+D60oTKqBtCptdrNZ+l4XwyjUXixTuk1gM4iKv3hhBZEPT/rTBkjckypaXTaxbhrV8DRe/Ue99zC+apYcPXqhzP449pUSzYldEmnrOkPz8lZHIrpuSsSkorxQpMgond+Tzbmo8HbB4ymilMPJTUailuJ1rIvRRg+MkWkecJ/PNyYUMQEcCioi2vnafJyB0K3fve9ZecjejaLud9bU78HcOOmIYJOD7O2GdFk66oWKYD+hE04mB3mwVrKUbNMF8MCljvsME5Zgh82kU17fuRYqyfwx7DHiOSxncYpmVsTcD8qEloP4sYv30L88ffUjlUAiIQP6w4q2nVxkB6cREPHr5kfmBi62mc1FPJ9Kg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab77ba34-07d1-48d8-1562-08dee179d728
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 07:30:55.1909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r9BNroR0+txQDbS9UxlPOD9FVwXtqgDSgCYI7jCnTIcRLIFUfnLb0nWVeRL7F0TXkM6utvfbS0BIIuAnCn9I4aZP31Bv4y3ke/3LCKnnsPs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7124
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2607140076
X-Authority-Analysis: v=2.4 cv=d5nFDxjE c=1 sm=1 tr=0 ts=6a55e5b7 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=7CQSdrXTAAAA:8 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8
 a=NufY4J3AAAAA:8 a=yPCof4ZbAAAA:8 a=gQgDrPkycQ706KZxoKkA:9
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=1CNFftbPRP8L7MoqJWF3:22 a=TPcZfFuj8SYsoCJAFAiX:22
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12221
X-Proofpoint-GUID: x32LtzfjBEyz25nnkT-nS3ICCBFIwcjB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDA3NiBTYWx0ZWRfX9F59xyh7+LLW
 YJOrCTK9vhz8Uyuto+CQh3XWPTA/qXrfnSGpOXUwZEAnYPUy8V7lS4mcXAzk0WROQTYFPJlVV71
 Cj/1P/3NkUyIfVrKBhlNBIdvtb8nLwy7bVzWJBGLxsKSu4RChPJxcQmsgY7D0PoSXJxHcu67f1i
 xHNLZKR29bwLu2ySDyRmVYB8VegmxBC6WlFC3xuxP+W455buKjapN/0YbqIGmgeWEKxzv7wiIPX
 xeBKVwotBYD7H5ruuMk2sEOeepxu0nuJlBjEUmuEdie0J2GnOMEUV8zJFmhNYMTUz4MXMuWWnxz
 6SBxTgOsHEr0OYIjkArwh+Y81dJ5NC7j7GyCT2iEToNAdKDH6SW57W3GJL4DrvaeDnIxiNRlmb6
 n1AZ5d29tBGJraQqz7F21Fxfi0q5W2oTAbitDvqQYNjcBOHLUUyGQehkayZZIx4Pyg8O53Aie8W
 SIPgaXa50/4/Ilh2KE2hHFaZqCj6CwWrGcNf8cV4=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDA3NiBTYWx0ZWRfXygVmArcbmiht
 jzRKex25Q+UB8ti9bDoVj3U2F1BKAo9wLDXw+mfKrHGzxT8uFSWLtQeD5xDxanc4gDWeicGKTSs
 NJ4JfMa8MOUGk957rCcLi4uK5kE0OBkrgYXGXiD7gvSW6x/fHhJa
X-Proofpoint-ORIG-GUID: x32LtzfjBEyz25nnkT-nS3ICCBFIwcjB

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

