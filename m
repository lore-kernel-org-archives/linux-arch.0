Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0112E39D6FD;
	Mon,  8 Jun 2026 08:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780905957; cv=fail; b=mIcO7305s5Ed9mpR4jBC5q0kv6D3iC+eG1dARmTv2dKHMvmHaseK0oXPg+IcYQcIBg45wLxccDBAHx5QnvizE1ZKL6CDig5iq8rXBUUDl3Z/FrpkXmnM/HhL3D0koqTNzvNZL54cLt19CslqzLSwFZSOoOYDSVZPwOibrX/U7O0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780905957; c=relaxed/simple;
	bh=8dG4wS8IlRQPAQsGk05r56CV1kpHBr0zVYXB8v6oJTw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R0WUVnFm1VtfonCyHPg0NxBsjMKM7lFnmDVcjfyqdtsm7n437OeLuZ2i5y93X2ubgBPUOqU59LYTeBoncUJ+CV+21SoaKTklKlwX3kTKPwV5Tp07vXaUpTfzn/vnI5zMDf1gJnjJG9NbDBa8r2B04zc/bfEeNwcuNkYs+BWQgZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=rBtVwg6E; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BvOiXFCa; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rBtVwg6E";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BvOiXFCa"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 657MujDf2098651;
	Mon, 8 Jun 2026 08:05:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Jv5eACUEK6cT0sLPxVCS9b1EbxvU55GTImTUklK2Pxw=; b=
	rBtVwg6Ea/FnsuKpkG9O3iOG/81BtZsjvYUjrkTMe0tBF8mLWzboPcOzQcaNYxWK
	tTb4YGjA1OEADrJySrQ8S2Dm0sNzYyWDeNQWZeummY70c3ijI4APBwXTLBp9YXAC
	fTl+w6tlt/8vA7z/N4ahzcsUDtGrhtdyOhFKo5pJvcCy3hlq8Qr/6qLICNwJVSGn
	lL15Pc4vn9BizV3BQSTQ7cRHxNlcUQjkk1auFBwG1/B89ZqLyFFhkbyYf+5iddS+
	V15c3WoGJ1CozaqVCZ4E1JDYXNMapWJ59o4sz2d/l/EWtjfixrVsj2X+FhXVEdVw
	E6bT87qfbPpGIKBJMIR3cA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4embkja0sy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jun 2026 08:05:21 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 6587w60d040403;
	Mon, 8 Jun 2026 08:05:20 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011020.outbound.protection.outlook.com [40.93.194.20])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ema0dg736-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jun 2026 08:05:20 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rHMchIaDmmMUDfLyg95zTnfOx/4v6YxchGfMg283hKH8M50GDk6tJBYSqG6P2I5spxaF6KXwtp210SvzZXkXrVs5gLIQA+ZiHnfAXkIcbTUepLj4zjjJvXq8GBBBjqRRzU/McrqgR1aujM+L2qRmbR2aVZaMyaLxvSsUARDetG7+OVJJywD4Uq7j2vYtCFtSo7o/lud15SU2eiaPEnQn7TsUe+LQLlT7fqEv+3dFdw8PkNSF1+KhsGxyYf9Bigi63n/qv6bNd1GxDe4TEswL46bRX46aIGAR2lhKnutuYRK88msXUSE0VIacDy6zuQrNA3BO3867GF1SyFx3snce6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jv5eACUEK6cT0sLPxVCS9b1EbxvU55GTImTUklK2Pxw=;
 b=Y38jXiq9XhEliH3xSI6OOzDaSZmPgxZgtIOmmXs8h9DFqVoP+MghGCozzhPnQG39o+HqZMIsGem612ufOD7BONM+DssV5/AzLgZvCVQJ0fyPEjEpMHNjxt6p6bLf5yH4q483W4GyNS+F6qDBDd2IqmFIuy4Zq3H3c6NMcFGlqnfIHs8jsTiBb+Qx82I3KfaJUQ7up1PlMaTTU8edzo2hLcrPHEi5T2fKtuAkTuLoaNnAof/NjbArefmKNram6UxQJe+KecGZHEu0+e6+lZTzf4GbGcGIWDn2jCTb6E5zJ0BFV/SNj/iQmQEz7UXxBFm839IfIIpwPBW4JaAkyGXBBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jv5eACUEK6cT0sLPxVCS9b1EbxvU55GTImTUklK2Pxw=;
 b=BvOiXFCauRRxxpwePsLH2y8J0u9AAdqZ5rmLR02FBDye1kTwwwPexAzHXiBehBV+N1os7nLy1DJZ6YtzLMKY6/SN68EOHcAdAPaWeo75BqsNTTcXKEScZkbKzA2MkcKjUNpvfqf1MWN6bch1jMIjehyvq8qFlyEs4uodAzB1R28=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SA6PR10MB8133.namprd10.prod.outlook.com (2603:10b6:806:436::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Mon, 8 Jun 2026
 08:05:17 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 08:05:17 +0000
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
Subject: [PATCH v12 13/15] arm64/delay: enable testing smp_cond_load_relaxed_timeout()
Date: Mon,  8 Jun 2026 01:04:38 -0700
Message-Id: <20260608080440.127491-14-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260608080440.127491-1-ankur.a.arora@oracle.com>
References: <20260608080440.127491-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0331.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10a::27) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SA6PR10MB8133:EE_
X-MS-Office365-Filtering-Correlation-Id: f6a60dcb-196c-47c5-446d-08dec534ad7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	ye9lapyO4ZHpq41rwQhdUBqNuM4Q1UwyBnNRFD7aZEd8pXkow6Dv1smWnNHZPQqTyZe77w134O4lYARRBGWaGxnWyW/Y+Jr4q6g9JGxuii4ZEsbT3vHevQgWhirOiCOTPd/3Xyc9DPCBdxnb12D2F43XirsVgcLsy1GYvaiyfgYxNY0xBhUR49v+XMzcrcnUwd0Horrkdj9f7MSZ8sF8HHqVW0128TITjrxqCabsVy0DIfDPl/jc+zTPcu147J/w7/Z25X/G949dV88D9rO1XjzWmUqwZ0bECvyUA2UDwzMTLkwej4Dc0uyY+AP+eiP3Q7Y/JMVIn17UDWqDxpgWnHjyCTQZxE9In9/fPEWTz2MpTt99jfBLmnpO6lWCQIjBydNIyCKqQb/sFykD7e0C7kbaVx4HkFKGKHMnZCf0on3deAON8ZLb/7gY4XcUFo1YtV4zXOPIS1dlPM54pLF+O1+K5Bhy9zMoBpajYTbfaMnuShphw3PDGs9HHFn9acAdqhR6yIsilu9BhxV6gpslBcHXBtrz1Atr1ljcjo5mACqK5QOfa6lfG/MBuZW85gw4gC4j8KckitPsgnq2VeC/ZB/hFJImmbSXE1jLcHv9hLj87pyQw7lCZrLMWfjK/7K48gYLSPyego2OcjDXkS3VotYQcZRe3NFiDbj9iBIraveV6kbgKOhDi4amXQbSWrUt
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+pVvjC+LxC8gvH8EUExrma3Db+Ya8OJToFzwh+5hnVkhUQzx/dQj8Tlsfy+z?=
 =?us-ascii?Q?aI+WH/yJo+cj/nbrDRiwVPawkujNtRw8a5CJx8qW0+752kjVpve5ZKwCqbUa?=
 =?us-ascii?Q?Zrf+grO6Mv/kpXqa+o7Pg7dde+KaA3N7gEwdjaGo+kJUWUD0PycbNkG90/T+?=
 =?us-ascii?Q?PL1j8SC8lGHxd7OqoQk5dhkuggwCCQTjENuzLGRZGMMSlkiEnb1L11YNKoQL?=
 =?us-ascii?Q?N5rwWRCXiauo4FKgxWLd0MGCBZ30QMHGcqJk60xE09jKcPI/5HON6NA0meT8?=
 =?us-ascii?Q?zCa6MVLSjELZV9tjgYx05VDr0uqjok4p0nWsnLlX1yuYUg5HTQoRK0dP1ipe?=
 =?us-ascii?Q?bWq1mMV4b35k96Z7sM9V8KUCxwz7EM6VpNjOSGkJj2gd68dl5wpy0tJYTct5?=
 =?us-ascii?Q?QN4E/xdDDBPgdu/lzyPKVBBFGaQ9Pznnazra+9LhUKs9UZqU9xlRkh8T7xi1?=
 =?us-ascii?Q?UwRnVJ6ycfbPGhu4uxZrGu5R0v9SudolboV08G8D45fvXmj/MXL+Q6RQbFyV?=
 =?us-ascii?Q?+stl5LlUjKAIftszlyZUP92x0VGpE0Wa6pNO23dd3M/b5WPfXmiJE6o4TMzQ?=
 =?us-ascii?Q?kUkVJfw14Db6IQX7xK/ECmX029KULKzZVw5fCuiiV9FhLJnbDVOeSXV4Zczy?=
 =?us-ascii?Q?b1SjNK63m1a1fG1kmnP17KEpi7d0h7bC+FwlNl/sRHqIg0teaU2OU3jEE8kH?=
 =?us-ascii?Q?43aFZdC1cfx5loUxbHfUHQBSoZIhVwasb1COtbLVPelNry1d36EBJ6mP82zt?=
 =?us-ascii?Q?iE+rTIu4/r+8SxgDr2+Utg+NWLF19ARCHScHQApiM+aDocTiQDEJsKqRrYSN?=
 =?us-ascii?Q?y/wId51UpW/3JDSt0RWDxTuuK0UI+7hbXFg7HCZAPzqzHHwBp1vt2hgTzPrf?=
 =?us-ascii?Q?9hCeec8BQOR0NMUao+JPty9jw3PagZTSvRqaNHkTii7CgTPyI3P29/vNLxbz?=
 =?us-ascii?Q?ix0a8+ttAvGWFQtPlFGDAQW3vmEQTJyzsPHyxw/K0ECUd9et+oPMnwS7NRA+?=
 =?us-ascii?Q?DFCtKDvmDj5mafIDDDRzMTBpeZoxtFl4HyMTS4etkwZT/inoOY2GGScsgr76?=
 =?us-ascii?Q?WO8746Ft/vJDOwsj6yLFJ/Avo4f00eK53NCGOFcRdGDOJlCnypI1zFOVhAK1?=
 =?us-ascii?Q?9uZdpdyMhpcro1h+u4CMUnr2nwXQ6nj9dS37QiSA6wJDTcELf9gYRburIOwL?=
 =?us-ascii?Q?kmTEiE2ImDpNhXP/wr7/xwVv7VWrgYgoEpbSIsJIFaqcn52IAH2flC25FwT0?=
 =?us-ascii?Q?egDZxh4YCMrNz65DXzk7e9qllp0tTTTxw7/0GH863DRO5hp7jXuurnZH6yF1?=
 =?us-ascii?Q?lPUicG6qIGFW6fX/DmxlxUciVmWqbwbWP9OQ/hATAU9j2dV9Zd82L93+UyDz?=
 =?us-ascii?Q?y6b59Hc+wPW/ERwtYmtdbZzawBp/FDsEo1jdK0uOmcqdGFgI2iu4qEgXc54f?=
 =?us-ascii?Q?ERI3Iy2+o10wK41OT03GQn9ESrpPgzvjy3sQk27UDSLi+g1IdGVVeBkilm6Y?=
 =?us-ascii?Q?3b3D+kwHNEHrTVUiWHLA0AwO1HIIV13OiwqRzZijV0VqIcRDtngY4h6F/e45?=
 =?us-ascii?Q?nC+el6NIuCtrEeculhIZs0sVOwdUENEzbaC/JupfGETNtLngoaND2AUv0UEw?=
 =?us-ascii?Q?IK9MU3UOiY0+kETtcAKkvM7F99SMfbcq1/cUDTM7ert95TWYc5Vlkz4YF3Ic?=
 =?us-ascii?Q?+OSHnlmGB+/e7w0DDTL4un9jVkpE962TyNn5fC7cl4jCo9R0gLxRJliX8+9g?=
 =?us-ascii?Q?CyIyozALGJh0ATQ6ZvjmEvQ7w1zTXjE=3D?=
X-Exchange-RoutingPolicyChecked:
	jx5xvGSzEzh2XgU5Az/cOeHmVSG0fwxkzWLaIUDcPA92rSf02t5f6siUX71knpeUiCJ8UsuJqf+6iv8pBF9IMZTGJ2NT41U4YFPoNqJareHgRo4ZEBHa2lT3LEoPcdhS0JUR3Tq6PGkH87a8O9/TLW0ub/yXJhktx0Nk3EQmSVhV3HtMCgsy+HoKj/9Nr28smkW2NrDSf6o6FbjezkY0VwJY75PmYMuWlBkZdQhyrBWRlMf14p6rMMOjyg6/e3XB4cdhgwKItd/DLQMLO6E+8luNdQ0oHBV8G/SvawKyOpJWUc0cXHTsJFYhWn4fqq1hJ7l5LfC2bAN3/ROHowZFNg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0kcmK9S45jqe4aZ/MeKX10Z1hkqKCQiCGgjWerOp+Na9q9zvzGEzXtIGxHZgHs89fWFua4L6+at3JZgyYO+4o7gZw3jg6BSwSwbtDnYtSYmEpcAc7PUEXCnMHvdaEdtDkteqnDTV9aTRoaijdcTAC/GCo5ANm2LUtEZC6Jkm1BYpb2+EWqfSS/sMXSKpHX55JNKy1YqkXKxteKp8WUWp7+iK2mwDsanB68J7ubMlSlhtYYpvc9+O2b+hSwVCm19I7ROwab1ajMCyFcdf8t+YYgovkRMx3f67gF+A7LczFJJ61SMkdZieYIbZYBc/JnoLEtXUwWrILP5ZuQ2/aDevM8xri60q7P3srKcRXjSctq7R/pkxYtooyxzaMDOAww7LN3k2WT5N4WBE6/skATVDI9Hm0mdA1L3/P9QmO4xeisqUAgBlpS2pGHCK/AcYcJ1iUp0ozSIS3tRCgFdmOi+8vbT0v1Ybh9fT6WKVnOX9nrH8+y2BJLNg1cpgX/4LdF5ZRLwlJN150qTFy13PAy/t326itgUG3iKd35GEQm1PRKDQnIq1umLAPGyR13K9VThPEbqRKDBKAWDLGHQ2hpGqRhve5QTO9RhmHH7g4J/cwgs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6a60dcb-196c-47c5-446d-08dec534ad7a
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 08:05:17.4427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ONq0Sh92nNckHrdIkd4vjuwznJY6+mCgHwJqgZbz/ourneCWJwiveM+xeUWQjmrJ8Gr+TgeSoNqNhumJsdP0fmWWm5+/bzS7N0tVUWx84U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8133
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 lowpriorityscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2605130000 definitions=main-2606080073
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA3NCBTYWx0ZWRfXy3lKxGBsdVJx
 im3jTTlOS2yQb8OYe5sarRYhK6rPXD2ER2DIZ3G6jz5BcG55BJoqhGRcuu7/Qyp19uZZl8GaqWR
 sP/pS+ulCw7/I2BCMGBAmwUlZq/PJ/Sxg5FA98veo4y0m3jLQm2dD/je59DvmigbN1qgiDZtenc
 DsXBu2kBrm0RStlIaDBh5gScRaTjAnISwA+W3dhw9iOPPmq2XPXcs2m5+uob1TzEmsFT0Wkwf/8
 PvzLZvKI+TMfliVdK6c8ReqvDlRWX62kaLY7ba0hHr+ivmy36pQtVrVOFSqojGJnDfyyu9LYbIg
 pUGqww3c3WVWRbKM7toUsJifZGG8UBv7X7UqVUcRsTrYuM3pctp5BA/Cc84M+YNijQ33Stmt7iu
 5Pw3wgAUz+URoVoC2K9Vg/w8XCiX4KEJVEljUSXMLR7yuPM6XBp+fQT1X0PNKbEiJB9egkXLNRY
 3chSzgqJ6az+SrLja+A==
X-Authority-Analysis: v=2.4 cv=ROSD2Yi+ c=1 sm=1 tr=0 ts=6a2677c1 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=FelO9ux0wxsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=7CQSdrXTAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=bb9Fw_vXVJAL2FTmegcA:9 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: LW8TiLK7J6IrD8ZZ2dxSrEZKnDMDtJrz
X-Proofpoint-ORIG-GUID: LW8TiLK7J6IrD8ZZ2dxSrEZKnDMDtJrz

This enables the barrier tests to be built as a module.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/arm64/lib/delay.c               | 2 ++
 drivers/clocksource/arm_arch_timer.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/arm64/lib/delay.c b/arch/arm64/lib/delay.c
index c660a7ea26dd..dfb102ce3009 100644
--- a/arch/arm64/lib/delay.c
+++ b/arch/arm64/lib/delay.c
@@ -12,6 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/timex.h>
+#include <kunit/visibility.h>
 #include <asm/delay-const.h>
 
 #include <clocksource/arm_arch_timer.h>
@@ -30,6 +31,7 @@ u64 notrace __delay_cycles(void)
 	guard(preempt_notrace)();
 	return __arch_counter_get_cntvct_stable();
 }
+EXPORT_SYMBOL_IF_KUNIT(__delay_cycles);
 
 void __delay(unsigned long cycles)
 {
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 90aeff44a276..1de63e1a2cd2 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -28,6 +28,7 @@
 #include <linux/acpi.h>
 #include <linux/arm-smccc.h>
 #include <linux/ptp_kvm.h>
+#include <kunit/visibility.h>
 
 #include <asm/arch_timer.h>
 #include <asm/virt.h>
@@ -896,6 +897,7 @@ bool arch_timer_evtstrm_available(void)
 	 */
 	return cpumask_test_cpu(raw_smp_processor_id(), &evtstrm_available);
 }
+EXPORT_SYMBOL_IF_KUNIT(arch_timer_evtstrm_available);
 
 static struct arch_timer_kvm_info arch_timer_kvm_info;
 
-- 
2.31.1

