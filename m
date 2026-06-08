Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483C43AA9D4;
	Mon,  8 Jun 2026 08:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780905951; cv=fail; b=kPx3UEL+woEuGfGnGkVoWkjuUeLU1OdZX4Jo1FWhNX1qflqd+v+ZR0xUqEQRPcmvoqljF1NfoRoYbps3giH32kFNTUQYA1PDukvpgak/rbHP9tihoxJjgMvZGz6eitu0gkHULC1uYZ5JDdR/ugb37t+7el2x6cbN0l8o+RQKp5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780905951; c=relaxed/simple;
	bh=tyKyeS/2jLpr49Q3e1dU8wpSrToIlZAHNWmT99aDwP4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CbJSsymHX2v5wgu0kjBWz3wKjjtAkdOtCmF7OB/szgP4e85yJghEbPBlsFsbjQaK0VYo/K+ibuhn+OucKj8h4ZEXTfQk4AuX3yvwsLIbiZoho+7eRFZOcacLzpx9T1f7gUlqAJEjTDUR0mqQzvatqvzdd6+64MI8W8FGzt0IFAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bW4Gt46p; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zE5NsCJt; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bW4Gt46p";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zE5NsCJt"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 657NNtEY3891636;
	Mon, 8 Jun 2026 08:05:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=YyobJUMrCqoQpiemBzB2+HPq7GVYfYiMd0Ms2zfNasw=; b=
	bW4Gt46pHrs8Xx/BEevZbUq7MJGFIQEDDjaEeljKVZyDjgXeFTkNXMqaYRkjGJQh
	uvKXEwAalSz7uMB2nhTrDfMYk+OBSSDC0k5xygAu37eQ6WU9Gvr/oGLbsSixjBzK
	x8I0QwOLOYGK5k0aISV2WEvYgb/HEOOaLm9inmkRvyt7rXLcbtYV0jXqckLUxJ1J
	QOCXknLRYyjpU9JLS33gwQ+Z4NSxTHy56c4FxMse7IeF8jX7nXtkWUPTNhb6PoQG
	G9pq9S7rHgddQsp2qfk++9zBSXbpduWcviEfh++zfTOk4NpNCDINQHYca70Nr0WX
	JmylVzS3ZJg4XkoX98+71w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4emb5st0ff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jun 2026 08:05:07 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 6587w7p2040494;
	Mon, 8 Jun 2026 08:05:06 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010052.outbound.protection.outlook.com [52.101.46.52])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ema0dg6pq-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jun 2026 08:05:06 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XdRLYHmydHwe1ts2xL95V9muEqoTe3Q4nUEMI5RLKJoKGognLIgkOKIzfd0Zeqhs/qti+yHOkn0+ypaYGmFX8tPvmqM/l6vIwZvOJ1q9IgMqHXDbo5olyMLlG0YEXzot+cO5yWpW3yjREDufjSq7AOqmMO/GeJRdBP3qPIBmtpJR8hXRUOv+cHF1+9kZeXY4V0ApB4j+ONBTIPXoSF5tH8bteLuJWISNgHhKmDB0+kdrj2229EiR+5RiswK80D+cebcBnVX6sk+z3wEHcBHdlLMSyVzxd34VSfsSkwHBwWSso4VjUjmKx3A06QBIY20NshsSwEM8/V0YJVUDUlB/Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YyobJUMrCqoQpiemBzB2+HPq7GVYfYiMd0Ms2zfNasw=;
 b=nJM6NBKBe/Z8EwHHLzDu4DXwUaZLrvxjh2kDEywYwljM0HAeSLRBBYJoDDp5g6GBKx1E9+6S14TPmDBTAnCZ/f2OhfVsre8LUKUaQz+BCYo7Auyxsx4kSB5I1oifzGytNUrZanLry3+BUoY+c4ccqWjlpLItcQ3FOKVP54ifCq/CkcUEakPPHCe64Q77YeI9r0ipdpkIVpweM1fG0BVYXHBd0o8vA3a87/sn6E0nRvNmE3g1Dj8CNXUtBZkmp1omM3/y4vjGNBiZeR4gjVW4W8EJyiC+V1gcRXN3AJpuIx+fDMs047eKsVcLyoQrsRDUJpNOeXtBncUEP9oW34EUUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YyobJUMrCqoQpiemBzB2+HPq7GVYfYiMd0Ms2zfNasw=;
 b=zE5NsCJthdYeVtA3gY/SXEb9O1L8BrB3CiNUDzN8pdHfNR4/9zxeKH2iUwvnK1fYPvQ7SjePBdrzDaJSSIdjVwLwXIJrz27Nt5HjWT+YCC4ndIcHzuaTbIFZngzpz8s2IaJf8aGQzsPQy2aYoOicMacjDbQ+ojdExKi+zpMny6Y=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SA6PR10MB8133.namprd10.prod.outlook.com (2603:10b6:806:436::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Mon, 8 Jun 2026
 08:05:03 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 08:05:03 +0000
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
        Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH v12 08/15] locking/atomic: scripts: build atomic_long_cond_read_*_timeout()
Date: Mon,  8 Jun 2026 01:04:33 -0700
Message-Id: <20260608080440.127491-9-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260608080440.127491-1-ankur.a.arora@oracle.com>
References: <20260608080440.127491-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0276.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:109::13) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SA6PR10MB8133:EE_
X-MS-Office365-Filtering-Correlation-Id: a9f3d1de-320c-486c-5ff0-08dec534a4df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	9JNh96ljOHCamhEKcy2qVPqY3ThZxne9jsZG0+sVSs0bY9+pJg0mVRxF9tpZsAoysyu77QdmDQgxXLxjzmC5yqXfKhmhd5PM3AnCCwm9ESyEhWc05ktnx7U1KVTzAEbY2DS7nogPJFJ04ET8RAUbPMMUc0W+zPVIz+PKMSLKZvLmpllN1gHr+OOUKDE8h757exp9tLaedcCbV+LLrcSQk3ds03a90NZ7jhgueeVByFd0YUqAyMCfF0f2BYSDuz6odppTAs65IVjN2PmiMl8+HiFJJpqCmE/CVIJCvcNDb/PA+60WwgihEX/0L6Rjfg+gBK2MC5/YD9BqxQXvGSTJ7vVZEQ9weDzahktycwskzowDxROY+drcy9INONRFyNvTIVT4ZVgngyS451WvspwrIFJa+wemKClA4X3qAu4p4x1oNNJa0y8u4HuRtK8brkVV7UmxlXCnJ2RZgY6h27V9ehdXht8cHtYcLrE8xGnr3uE/vnnEUlIge1xGSguAKi+wAmTu5shvP1qt1vdX8GbyfnBUGBbuQj7nb3hfdb6lH/P9dvcJ+Vp9qYVdZ1hRT5F1KKxt+9E84Hz9t5CiUgc396q8TjHfx4JA+mTivkIzbvlbB/PMLqSHvuOD7qKms1mtbwjZAja0/mInpcRfAk+rvRKwS3oJfBQsG6QkiwBnX/PIDrFu/Fo59sKN6TZILeoz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JYUlmQ9CJ2rc6v76YGHYcgBaFniQhCwjoSi9IpXGdl2qWGpPZGtBZjmaT+FE?=
 =?us-ascii?Q?HVO0rAlWmdJxLFvxpQK4ffTUdS58DzihJCm3DfkRFOXTCg0N5bxqkbvVbNzi?=
 =?us-ascii?Q?0hPukLbM3VBALh0h9VOhdvB8XnkZWYXDcxuMSdKJdIjhLYI28JI8wfUIxQQX?=
 =?us-ascii?Q?c+weu3Cy0tp8mU93bkgiiAmqXMfVa+O+2Z8K2i+y4MdjujePf9YIASSua2h+?=
 =?us-ascii?Q?PrrjGCvaZAEvqooiKSSq0KO3sERRz6hoHlawH2n4X9PdlkokIuUalq2FAs+R?=
 =?us-ascii?Q?B9bEfBnQVTlziEEKJURXGV/FWTe8nzhSsSovYnObXpjh7Tklqne3sUfw+e9S?=
 =?us-ascii?Q?/F9IZGLUEIQZzV7/jDTX/eAuPfhHfS1TELqWNQYYTntrN07MnXj4DZMTiIv1?=
 =?us-ascii?Q?50IrmXyG8OKUxjFKlFWRf/FX9K2dR9qx7trmmCdcBlQR3fLN7Q1HFICz/s8P?=
 =?us-ascii?Q?9wCS6YfVzSQlRiQ2Ff/Gy0Dq4q67rCHIvCqbcs05c0y+xncwN5b1Fl/qcgY/?=
 =?us-ascii?Q?dtksaHzEAP03XehQgwW88qL/wHVSI9wZ1XHJhrNqrjRBbCPiKFD3GsJlnROQ?=
 =?us-ascii?Q?m6w3CT47B9PtQYPJnnB5/YeQl0OJyfu8n0l1PYZR7J8Nn+P+38008Z1QQ5yk?=
 =?us-ascii?Q?9nsvoxbaKyez5qUkXOb3600/KnN+mZ5vYzLDYa2DdKRpJjarSGMv1DWEDSk3?=
 =?us-ascii?Q?pqQpYzR+jpu/t/PRgkLVOuHhy0tTcYN4OAhXfk03S9PK58Cv92YfFbNI0mAL?=
 =?us-ascii?Q?ESC+UCWMqvFYbbFdKpnCbKS/PAzRjUmCK4Utbf+dxqNVponhmDNzygI0ZlN4?=
 =?us-ascii?Q?tmxGkdaFGNLzwFaWE5bYy4RCVHXDC5EBw5G8cK477hR38f9hjtKQ2cwHLFQK?=
 =?us-ascii?Q?o4oGCInO/FJpd7xr5bFsvgDHOQT/Y+VOmp+zln5rIVWMXbwc3hW19RzS/8Om?=
 =?us-ascii?Q?f6wlE4Jrq5d59xweqwflE8eLUZ80AuFYma2BMkIBN2lMBlYz4UDLewfhqtPW?=
 =?us-ascii?Q?B35T97U06vOymvDmUCPdcuPn9lwZdFUnk488t8Va0au2hkP+CvJ4EJ3zRq++?=
 =?us-ascii?Q?JbS/3pRHqO5TDL11dltJC4RR0XShKerdhj63Nh/jrjGGJLdJH4i8wa9wGGod?=
 =?us-ascii?Q?IXNo1KX1t5HHOyTTuD/8FHBHyvg047X4mp6cFHNVLmiOo1Wga/F0F34wFRqz?=
 =?us-ascii?Q?qERY6g/gP3eZ3MN5gbQBqjxDkPwOTtMunYSP0GyOAh71PXODlZgK4JhgYj9+?=
 =?us-ascii?Q?GxlF2yf1SWA048yX1nNidFaJ6vRjG9cyCaX/jISpBfvyyum8RsSeYYzCSXfR?=
 =?us-ascii?Q?6NonklAVFMbbdSR7SF5nW0JjPXm2eoZZfiU7KUPmvp0tYGMUxSGITx13Q5C7?=
 =?us-ascii?Q?8hYJv+DBE+mBM1n5bF5igiaPlRMF1PlFm7tQ3qlWKqgvXwqDJh9d8R5RIrUQ?=
 =?us-ascii?Q?BtL4/nSDNrsqXlAOZAQzNPn36dUAgFEavFTDsvcbjuc3igZuCp/nH4ElZWzH?=
 =?us-ascii?Q?tJj44UjVW8//b8rGkPzL+bap9wyiiZ7XoiugpAqcNQtmvBjzL1EYLxZ33wKK?=
 =?us-ascii?Q?fQG2s2OhRWMiWe+oSJgmHIhzObYiD/rSHvyMl9lot6hDhiCj3kPRBbfTn/tL?=
 =?us-ascii?Q?nx3Ie3JtKJEe+hDlBUJ10/r2RPdgM8KdhlRnV7LZqATKn9IicF5un9pmfa6Y?=
 =?us-ascii?Q?k7l/HmqzM+aj51JGR/xMG1sAeRrUeXNC86Hh8H/HZAsGuHuL9MgxR7FzJSg2?=
 =?us-ascii?Q?JpQLKipVsg=3D=3D?=
X-Exchange-RoutingPolicyChecked:
	iSXpbeKSei1yhgyuYaP160osPz20wrvxQGhsYrO5Tt/FceE9uGAhIILqKOHi2FVBoivbHVHrM4/XwWDaavsgSBJs2hRNjDtXJNVUiy5fj3FMLCdLDkZAxEDHykOpyP4mm32nqShMJtcQjiaWDyxuhUi+vZxnmdwrCKfVLXpEMe3biiE6YxvfGzXWU6ouH445qryu/C63CdpWc0/cMLESF1GUrplkyTc8Z6ZldHTz3eQYT1b6+X9AD6XFZMfSGGl9vuyKFlGPbaM759CMonAlh7HTMODQGVO6IXeeIjNdr5Cw5WzZHhG66dODHbt0sapV1+KM+hxVH9n/ARZbNNrW3Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	e0yEirDXfL7L7uu8x3LHL2QutUsRkXmUh37FNq2KjNdYzMfRuUQcddR9n+nLWFXfj0QsbKjwdst+DJAe3VicFVT7oXXU8ansejd2GVZvr9OVp6gu2drtRiWMNJkp9GOFMfoWgs3wIksawMwDC7zqxPtP/CV28q9AD+iYjHxmtqxH4a8VpReiuS9vuuBlmaCbH19s8WE8Nz7sbSxXBVf6cIuLxdbH8r+fSgujYXjeF9GrFr6o45J8ismYgFDmDVaoRc+cbZqQXye+CW9zWJdMbDzH3qoDuNWufY9KTTti90kDqZlK+4eMXST6EndSOx2osgAILxmOG39ANwKdm+F0RfQtfiMCCoBm2+Z4vUFDtzgf69MkniZ/U0yudABiBpdvGNiOdRPstur+/k199nfh7r3I6NDtBxu0hdZxzsSMsQgmbGNOfJb/SsVxDqRp6IWLBeTvj02P37Dt6jNcseX1W0LRka95SuKmk9jw86TAs5D6aXFbAu1X7egFAa+GuwyLnoRlKOmtU1lXxB1gvAjSZsrpZnyGvXhMTFj4kfl6zqVU8PcFhLru7esbDviIlFeX7fc/e+c0Na70JxKEZQyrgGkXlrxwd6DcnMNFLaudW+E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9f3d1de-320c-486c-5ff0-08dec534a4df
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 08:05:02.9974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z8uCgFm+T8SOpIUvOICzVjiCDuo/AGrTIj4zFx8/9XCUX35IKh6S6MYkRa7wzq7jy3Mv/iPNpNEerxm89YjZWQq27XaGq7ooj1Pdu8rd3pk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8133
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 lowpriorityscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2605130000 definitions=main-2606080073
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA3NCBTYWx0ZWRfX2J+BdT1/pFMb
 +sizMy3yrOHzrf9B+iiQ3fEnS1l27xB624wuSEFXf2Zhyol+NbyGd49n/M5g8cOf7BL8h81N/qk
 GwTSgugOlSyG8adx+2kkuzDSSJFBt9NKqCLkpZ48i+CavUZHcYJ9fKNZWdVhTwbe1nI9a8/6RnZ
 Q3QRaGRjSUiKFPMsZS63O2v4AekOcCL1bfhR94UY8durmcxNDV+DOYcboY6LOw/zsacWORGa84Y
 nBJmk4OWpTRCKLBn7xG2ORN89JP22F/4KmHPER2JJRgat/ZoRVJkVlQzg7QBlm0IHvfG/D5mZyC
 /2h8xBRt1NvEEa5aH6hJ8asSoLdZbyjJcRwdgdwlybSo3BGH5AJ4Xw9l7aeozTTj3sJWVHQF2mo
 d40cHpKkUUCdULxoIoxvg1JUsanK/nl5P7KcZsrz68Mixs/gED2vN2z7mArzWyXTjn1ImASc2dY
 lah8gjrLx2b8Cpun4oA==
X-Authority-Analysis: v=2.4 cv=XeC5Co55 c=1 sm=1 tr=0 ts=6a2677b3 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=FelO9ux0wxsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=pGLkceISAAAA:8
 a=7CQSdrXTAAAA:8 a=yPCof4ZbAAAA:8 a=LKnZA62imwlViN-40TMA:9
 a=1CNFftbPRP8L7MoqJWF3:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: Z31ZLgy1yBBZtbD0LSl5F4769iX2FJgT
X-Proofpoint-GUID: Z31ZLgy1yBBZtbD0LSl5F4769iX2FJgT

Add the atomic long wrappers for the cond-load timeout interfaces.

Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 include/linux/atomic/atomic-long.h | 18 +++++++++++-------
 scripts/atomic/gen-atomic-long.sh  | 16 ++++++++++------
 2 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/include/linux/atomic/atomic-long.h b/include/linux/atomic/atomic-long.h
index 6a4e47d2db35..553b6b0e0258 100644
--- a/include/linux/atomic/atomic-long.h
+++ b/include/linux/atomic/atomic-long.h
@@ -11,14 +11,18 @@
 
 #ifdef CONFIG_64BIT
 typedef atomic64_t atomic_long_t;
-#define ATOMIC_LONG_INIT(i)		ATOMIC64_INIT(i)
-#define atomic_long_cond_read_acquire	atomic64_cond_read_acquire
-#define atomic_long_cond_read_relaxed	atomic64_cond_read_relaxed
+#define ATOMIC_LONG_INIT(i)			ATOMIC64_INIT(i)
+#define atomic_long_cond_read_acquire		atomic64_cond_read_acquire
+#define atomic_long_cond_read_relaxed		atomic64_cond_read_relaxed
+#define atomic_long_cond_read_acquire_timeout	atomic64_cond_read_acquire_timeout
+#define atomic_long_cond_read_relaxed_timeout	atomic64_cond_read_relaxed_timeout
 #else
 typedef atomic_t atomic_long_t;
-#define ATOMIC_LONG_INIT(i)		ATOMIC_INIT(i)
-#define atomic_long_cond_read_acquire	atomic_cond_read_acquire
-#define atomic_long_cond_read_relaxed	atomic_cond_read_relaxed
+#define ATOMIC_LONG_INIT(i)			ATOMIC_INIT(i)
+#define atomic_long_cond_read_acquire		atomic_cond_read_acquire
+#define atomic_long_cond_read_relaxed		atomic_cond_read_relaxed
+#define atomic_long_cond_read_acquire_timeout	atomic_cond_read_acquire_timeout
+#define atomic_long_cond_read_relaxed_timeout	atomic_cond_read_relaxed_timeout
 #endif
 
 /**
@@ -1809,4 +1813,4 @@ raw_atomic_long_dec_if_positive(atomic_long_t *v)
 }
 
 #endif /* _LINUX_ATOMIC_LONG_H */
-// 4b882bf19018602c10816c52f8b4ae280adc887b
+// 79c1f4acb5774376ceed559843d5d9ed1348df99
diff --git a/scripts/atomic/gen-atomic-long.sh b/scripts/atomic/gen-atomic-long.sh
index 9826be3ba986..874643dc74bd 100755
--- a/scripts/atomic/gen-atomic-long.sh
+++ b/scripts/atomic/gen-atomic-long.sh
@@ -79,14 +79,18 @@ cat << EOF
 
 #ifdef CONFIG_64BIT
 typedef atomic64_t atomic_long_t;
-#define ATOMIC_LONG_INIT(i)		ATOMIC64_INIT(i)
-#define atomic_long_cond_read_acquire	atomic64_cond_read_acquire
-#define atomic_long_cond_read_relaxed	atomic64_cond_read_relaxed
+#define ATOMIC_LONG_INIT(i)			ATOMIC64_INIT(i)
+#define atomic_long_cond_read_acquire		atomic64_cond_read_acquire
+#define atomic_long_cond_read_relaxed		atomic64_cond_read_relaxed
+#define atomic_long_cond_read_acquire_timeout	atomic64_cond_read_acquire_timeout
+#define atomic_long_cond_read_relaxed_timeout	atomic64_cond_read_relaxed_timeout
 #else
 typedef atomic_t atomic_long_t;
-#define ATOMIC_LONG_INIT(i)		ATOMIC_INIT(i)
-#define atomic_long_cond_read_acquire	atomic_cond_read_acquire
-#define atomic_long_cond_read_relaxed	atomic_cond_read_relaxed
+#define ATOMIC_LONG_INIT(i)			ATOMIC_INIT(i)
+#define atomic_long_cond_read_acquire		atomic_cond_read_acquire
+#define atomic_long_cond_read_relaxed		atomic_cond_read_relaxed
+#define atomic_long_cond_read_acquire_timeout	atomic_cond_read_acquire_timeout
+#define atomic_long_cond_read_relaxed_timeout	atomic_cond_read_relaxed_timeout
 #endif
 
 EOF
-- 
2.31.1

