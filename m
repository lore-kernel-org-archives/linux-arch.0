Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB4E3BA22E;
	Wed,  8 Apr 2026 12:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775651198; cv=fail; b=WO3Wuwmn3WwgD8pRcpp7ce3Whq640EWhakzFLfdEojhteZmjJ3LnzHqxjZlGaHeDfL+M8Yfr3FGsR1jtpFYLwjrv0/8zAhhvtlcMJ4VkJgul1MaQkuRsx/YKyZ+VrYIZElaKo6G8fVyw4J2/B9BxF4rvlfy3abQuX/4jxqn5JSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775651198; c=relaxed/simple;
	bh=rukYpU6UyCIGE6say3xojQ8NZ1wWHw8ZgQfBI2/EmlA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A/fJmRaGy4snvcFb5jZKwShGBURQrqYhVCPx3SWX4xFrCKwkJ1hWtXn7MSRiHiR8I0BVPlk8cvkxgll21Z/XJz1DUL1UeoenIrW6k9SuPvr/FdUCx60tVpxzoqHV68/rYNV6JyZAxRIndy/eC1pEQ+BrmDP0HNXxXnD5lgHrlUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=V8wu1nn8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QAGdoydn; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="V8wu1nn8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QAGdoydn"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6384o2go3396241;
	Wed, 8 Apr 2026 12:26:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=irhAzp5jYokGNtEfcHlu4sTnn3dhBGdV48Zsf6dIgFQ=; b=
	V8wu1nn828YzQsWgp3GCuV3eMuuLjIBl3YpEyhutZko6CGonxtvhknBNfomT+6K4
	rTl4Ktaph1PTkPdTTYa91+PFwqDkrlJfxRrNvFZXTLF4YGYmjMNm+uiqEny5FbYt
	YA1DR4Q75Djq6k6HP1E9aIuvHQPOJbqMyUgT/Vfeg51PvjN6C8G7h9jAXy/APzB6
	YYp4Di0trpRD6iHJIINMQD2l4e3vbE+urerj4Cq40mfjdo+NnFaubbvNnbn6kCcY
	ViY0Kb8/8CuedGUlFGdy2U/1jattdOwxIosu0EuMnPmVgZ0vBwjIAirDBdkWctw2
	ECro2Dz55QRU+WoIb23e3A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dcmqa3fmp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Apr 2026 12:26:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 638CGSNP005183;
	Wed, 8 Apr 2026 12:26:13 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011024.outbound.protection.outlook.com [52.101.52.24])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ddgxqd7sn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Apr 2026 12:26:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KFtFG8BpaSw6IS16Li0zU3ZVMy3HVZ3vlWhUw1FfgmQjsuZ7wCdw/HTsFXP8IXJ6irr3lq10c+qPYq4Zv32bmtpDzua0RxDe0rlq8x58jVEDpjPRFi1egE5MHXGC5DxHJ2AABPqybn3/jpmEq/4XG5vQC2g/udSaYpCnqnnt9SzyLTmkHkFfzayYWwNF3vMjyla+Tm2qiIORCAdwyqXiw63KJGvVZs22KlZ6Y7aVA3XjmTYxZ9clW9bUbRF2buBNO0jXW897B9Qy/semomoi6pYdDEqxzVLJFwg/ijLBqua8z4TNiF+rxVRUJg8euloSb7OKjyuEa7JcVCDmub2rrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=irhAzp5jYokGNtEfcHlu4sTnn3dhBGdV48Zsf6dIgFQ=;
 b=KPTq2sgffAnpSLj5d/T2LI/X4iMcth/35xlfe+YN9Rr/PIdRIZiksKdDjedsYRuwDehBpUY0Prx2APfBx9G8dc6b9iMp+0GhuxA5EJ/KT2fM9QMhShFiR2MpDG+6iqPg37zQbSzsPS6q2EfbtY5LPHDFLkhTqple0+Z1Q6hvxQlWIhdPf+57qq/BTHTEFekt7Ab41L9rXygOarsTupKntPUQkgAhphodVxW/7aaNImCrMStB8bd53G0bn4+QCfYyx+vYJLr8uUDpaI6S2IcACiKDRjAvdQ8awgzeil5VaxqGj++fVTKL4amn2yCGHyREPBcJXDV/JrHjtqj0H8ckuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=irhAzp5jYokGNtEfcHlu4sTnn3dhBGdV48Zsf6dIgFQ=;
 b=QAGdoydn//zVcDVKQouCPjWDK/YAn8QStkEEsJczqHH+8iZ9peWqK1qxJ+SjxLFkIz2qmiU+X0R5LzgYl7SYK5P9KqNAI7cHl3z1jliQTy7sxLz0Ke5l+K+zNbnYvIXWiDRkYKH96W2FfVRVk6YljpvYzVeBCGNIb5EyfWxJ8TY=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by PH0PR10MB5778.namprd10.prod.outlook.com (2603:10b6:510:12b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 8 Apr
 2026 12:26:07 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.20.9745.034; Wed, 8 Apr 2026
 12:26:07 +0000
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
Subject: [PATCH v11 04/14] arm64: support WFET in smp_cond_load_relaxed_timeout()
Date: Wed,  8 Apr 2026 17:55:28 +0530
Message-Id: <20260408122538.3610871-5-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260408122538.3610871-1-ankur.a.arora@oracle.com>
References: <20260408122538.3610871-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN4P287CA0017.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:269::6) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|PH0PR10MB5778:EE_
X-MS-Office365-Filtering-Correlation-Id: f82ec478-4a2a-4722-de71-08de956a022c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|7416014|10070799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	IV72ntBbks3ulyml6eDqDwSh5W8bKWwCNEoXIiaPq2ISe0ZRtgPTyz/Zd1zp9SMWBa8D2qAtzjF3f3/Q3vDvjgdyNl+OSCb+vup9fiLsL0cSIHQMinVOk/3G9jojZEtrt9yh4a/ADNPL+ZQdst34iZBhCVN5ys+351H1DhG/bH3rXS+1JzHXNmdJMdjkGd4faJ9SHoqybuc62UMw2QAivFqya0cR9aGCO7y1jkSdCYDjVRdnQUF87+IU5XuaKo8BrsFf/bInbxe7lLl4NwDrIihZpR5fo8rvjOFfhk9A94ke2Oec8CbeQ/FbHgMIcZ36pPH1736ibc5hE3dFgVwfFkN/8gwpSU3LO+OXRwdmBKRopF/6De8mkRb26WqvpQqIEDL9RTYw5TQmm8PhGqtHEsIyeX6Jacd/Cmm7TgCxPsyPXc4zpxyj3FGqms7c5eaz8Menc1z/XvGS4m2Q/NqFLTmoaVBAdtSg0Uy0A+UURX9yT+5X/r5CKORFW5bvhxfyKDIieJv68TDhyyJQEhSDSqxthgidZiyc+sOv/Kv1EVmke1kvQww/qKz21UJ/dbMPlEAgRWYXqfLGo3zolOzKOaOR/nPJ+a4WKXosLOhPEFhl4Rs0jYuRW8NQbfyLZghcON9FePVxcAjPkYdKAKoQCLHiEZRa5M10oOa2Exh2Ukzwjb0eeehMn3lWl20f0JW5Q1hQ/Jw+FrWPYDNCNR+bFHymfl+WpJzwLgXH43O8qMY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(10070799003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gLs93GsoxcuqNPp1ZyAV4SsfnbaqVMCmAyyip02IFVe4lhDRqJntCB2zZrzv?=
 =?us-ascii?Q?ijQ/wJvL1hRs3nmLGd12DFFXgI7JWwcc8di7Zg2HCI7nOyWkGzCM4joTBGzl?=
 =?us-ascii?Q?beWYENK+DgldgTnzGa5Xs8MfKXsBQ2GwB9syy5YJ18O4YD/5HojbKyW5+6fy?=
 =?us-ascii?Q?b3R/X9SIn75GPSP04DoriAQ7iZtp13OojQh26xZA5pOx04ePQBb7h9yATKrR?=
 =?us-ascii?Q?4jMOYh/BnvzKHWcsNm+F94cVG8M1yJrMYM0zi0VMGqWPPUQLBBeAyOSGOpAb?=
 =?us-ascii?Q?f5xNgZJj2koOA7xLIWTIGWWhuwhK46cdI+FQcvR/Iq+tgpKFUgbUn0eJ86P2?=
 =?us-ascii?Q?IT/V0dkbeYphTrjGZnpR0YeLzdeNvwNuh6vmv8KNtSYngF13T+yeJK3gkkZS?=
 =?us-ascii?Q?WifD+XU247nqJ37Zb0xkdG9K0BVuCJNUswElZbv5QeqsWurzl1EkxLBq4dJT?=
 =?us-ascii?Q?GcCtiCBICgBCVt+gzZo7Ne3pnQ+2dCZhINI9Kcoygmo0YuhGRwJLao21rRsx?=
 =?us-ascii?Q?lQ/eudIuV+zguuDPXjNEnhKTyrYuF0Z91Filq9QnAnH77rbnaY46ffx0CoXp?=
 =?us-ascii?Q?ja5qxL0QZppctXIX0uaRFHqKnBiUkVV8dDj8CzDf/yok1HlRlU0nKsO7iJzR?=
 =?us-ascii?Q?UyK0vbNGu31Bua/cEL+VZf6TYM4+6m2mKvqgVYqTC3e1ugGux3JpIhac8wOi?=
 =?us-ascii?Q?/aGCkQJnqdRObxGgCcyuqg2HIFxcnA5+vM9klMViV2zkqh3JU1T/j6p6IHhg?=
 =?us-ascii?Q?OwhO+AlwHFA47pxB8PceKlwThQ/EBswiVDli6bK/tW9Fuwo38C28QDks5RUD?=
 =?us-ascii?Q?SLpshAuF2oi2r5yJx6bSEjLJfZPXplA9EyosccPN+hJ2mZYEGAveJMNGw5EB?=
 =?us-ascii?Q?4rjrII4D+JYJn2gcHrjjBqH0UTVL8I9togP0Da+8earMISeW1HK5NQMo0ArX?=
 =?us-ascii?Q?OKLDirdqj38jXGJghcLOS2eizQqstwyNK7rkHZMsuL/0lNCtgR3R3mvvueHX?=
 =?us-ascii?Q?IFh8KJvRi+imb+nYTCTuBrd22rnDr7aEmMlLqGr2QdygovzcYrMUpO6F4x0Y?=
 =?us-ascii?Q?yIpEUoJT+N2FMZ4qjhiD4C2Cg1d/dy0IGO1FleQnaenwmfvzFiE5o45kennU?=
 =?us-ascii?Q?/9/CginwNT0dZpJtIrWLl1vWu4+8ozV6rM1+C3IvNGN7JRmRUCLo66wcbypG?=
 =?us-ascii?Q?S6bBVCNTRv0uXgUC6R/sh0mxm7wGE3dUvGI3afP0F4+vCxSXyyr0i8Oykl01?=
 =?us-ascii?Q?E+ZEfExetUZ438VVfsRyvtFnTB0AwUV5ukNTg++RQ4wPTX6jGUS2D5vXQcG8?=
 =?us-ascii?Q?TDeikH7d08qi2RcLDd/+3UBESXGwxLvWhh6eBmXIdKEOyG52xDtT3QS+tPOy?=
 =?us-ascii?Q?jxVaFSPKRpKahp5m8QdHh5eSuz2R9AvRsC+87EYp98h8iwFM/P4wZsge/DVN?=
 =?us-ascii?Q?SalbFdDzWlIhv+P8uLiQWDIoLfjtRT8JKNOJ8th/KQaf3PK4iIJGzicBpeNz?=
 =?us-ascii?Q?RTWDWomisIy89GP4lMSYxINl2A5MY2FM1bJNqCpvbymT4Q45YYc1cZo5clll?=
 =?us-ascii?Q?ptMxQOjiu0YdwX4yO6ZvySa+bwEFY/3BoLedLh3tlraK1kyDbRN/RpfUEuog?=
 =?us-ascii?Q?mmPk1oDgMIQhxBp1Ko9rYWPicIkQ6lUl42FYVXKuHasiEwqb1qyNsGuz/H7N?=
 =?us-ascii?Q?77ovLgCmCgEHVQQN9ewHwfbB3YkGl7TdonUT2wLGsQ4nVWhBy9ZSfvBVpPvK?=
 =?us-ascii?Q?/MUZat/LC1Sw5y7uClvhWnV7vOvzT5qD21rUlJXFkjtDNAuCm8yADGBrxkcm?=
X-MS-Exchange-AntiSpam-MessageData-1: P0wndnYSvUbD+6gecO4Z3sEfEDZ3/HHwqq4=
X-Exchange-RoutingPolicyChecked:
	Vso+gIqDLVxti874NoS4K0F5F9bhb7nC8bbro18ZCcMBk26tEyUdCe4IJDv8TTCQgxd6bCxYNJ+QfUpgpWDqZ6HQYYODBAPinwgr1HCuDvIPATFH2pT6PzswnYV40gGt2il8DCufgKQQPpPTtbpEh9kK5oRwjoJUjckBF05E6famTl/wj74u4/muQEfaCmerWRj9Es+r4yjJuh7zbbLd5laop184IRxlGzdtRdtHpvmTlz2Rcc4RB7U6GiGU4HI5EA38J6QGP9Xtn2I76AbdK+ISEjc+ZGY6NrIqZ0pDay8Xkgxf734d3+mvZw70X/GA6TzY9wPTrAeFRfZPiiNs9A==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XvByGd7VYqhMGnTHaTrDLxiSSXKqJN8KLu9AGJgCKxr8DuCGV2H8+/odDETpcCBDcgSwlJv41tUn00vm0f7oW17MnLMZVkFT2f+qE8eEzprfQqmBlpPg823sUj+/+RyxHYRoTmRT35Sn5OOtceCJPqTbFF+fUFj+EiG/jfRmmsF6I8MjZdOB8bv4vUrM6axrK/QzLd1yKxtsIRez9PYT09lwRTzy9FSSUCD1/4tUxNet3yuYCdM+FQiq7Y/YqiKb0fL8K45w6hyNVGK/5u6sen7+Sa3TkqDfXYrFFw4AVw8LFFYnyon24opTrJwFfRzjVGMAezvMNDqHFdyv4us5nWHDBbe1SUDXXz2m1dfRfKAvcWlxUSaYIX0BvspCjr0aPQzUKQhhoNb3oX1SnKAAOl58yjpl0HL0VLFQ5PChnks3ECgb784v6aTqtlyRMALwBlVzDUn3t6N2kfOs8yYicb5FFg8RO/P5725nRJFg4NFxp5/VPHy1qnEPexzUYwblh7WM5CX8SSR/8XFePuXbVl6gmmaofd/ptSuj8bnakS4FmntqoVeVkKZE+eNbhe4JIsd8GG3hYNaWskO1DzaxvCAm80SXmDpsWzq2B1AK+Cw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f82ec478-4a2a-4722-de71-08de956a022c
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 12:26:07.2058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qu01+sg67iJ0HhgF4Z7Iuzy0RyXn44ZXvBxo9LGDJ2/UbH8LK2RDFUEcsfGyrHGjCmczblnG7DNVEsHrBYBZOGYH+BLMONL1IplBF8cq8gk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5778
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_04,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 spamscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2604010000 definitions=main-2604080115
X-Proofpoint-GUID: _Z3aUGkD6Lox_cAZ2pVhGRM5GWZ540FT
X-Proofpoint-ORIG-GUID: _Z3aUGkD6Lox_cAZ2pVhGRM5GWZ540FT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDExNSBTYWx0ZWRfXzzALbf1DnkHD
 gp4qDZo37pzPllRwMacMI8ESuNR4I2d6ZvTAgLtBjAo9GffOuVSP7gsvunAYO7YxeJ9bIE+wkZ/
 QP6OULX0a+iGQtXdcDY4wpLA2yKhMTYVlEBSe8goWgqwnMUcKW7o73/bol+zfCpr4Biefz+ihyw
 MrlFy9ZnlcWR31iEWbQ/NDXw/W9sdS5RaRyEUE9EVUD+tk+vebkj0lszy6q4M0jvGHiZGfGjY/P
 lgGiuq0FX12WX9eechkg8UPEWDrb38uqnkH9raqTUHkqKGAj8zImn4XjHNoLHtRjWIeoCP3cqS1
 q6dgXtR1xF0zM16MPQvoDREm9e87Vw+8ln2g6dgSZ3frNu9tRiihJdSEqoPt9qeCJcN8OyBkt+r
 +00PEe5TgN3ykfnMH2rgaYcstolZtLgO7BPauGG8RRU2IodSzaBhec3ZWzF8ts0LvMtTwNQ/tF6
 GacoMa2BfvrAfOmU2Vw==
X-Authority-Analysis: v=2.4 cv=DLS/JSNb c=1 sm=1 tr=0 ts=69d64966 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=7CQSdrXTAAAA:8 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8
 a=yPCof4ZbAAAA:8 a=Or_-VBqfnECsjC7ky4sA:9 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=1CNFftbPRP8L7MoqJWF3:22

To handle WFET use __cmpwait_timeout() similarly to __cmpwait(). These
call out to the respective __cmpwait_case_timeout_##sz(),
__cmpwait_case_##sz() functions.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/arm64/include/asm/barrier.h |  8 +++--
 arch/arm64/include/asm/cmpxchg.h | 62 +++++++++++++++++++++++++-------
 2 files changed, 55 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
index 6190e178db51..fbd71cd4ef4e 100644
--- a/arch/arm64/include/asm/barrier.h
+++ b/arch/arm64/include/asm/barrier.h
@@ -224,8 +224,8 @@ do {									\
 extern bool arch_timer_evtstrm_available(void);
 
 /*
- * In the common case, cpu_poll_relax() sits waiting in __cmpwait_relaxed()
- * for the ptr value to change.
+ * In the common case, cpu_poll_relax() sits waiting in __cmpwait_relaxed()/
+ * __cmpwait_relaxed_timeout() for the ptr value to change.
  *
  * Since this period is reasonably long, choose SMP_TIMEOUT_POLL_COUNT
  * to be 1, so smp_cond_load_{relaxed,acquire}_timeout() does a
@@ -234,7 +234,9 @@ extern bool arch_timer_evtstrm_available(void);
 #define SMP_TIMEOUT_POLL_COUNT	1
 
 #define cpu_poll_relax(ptr, val, timeout_ns) do {			\
-	if (arch_timer_evtstrm_available())				\
+	if (alternative_has_cap_unlikely(ARM64_HAS_WFXT))		\
+		__cmpwait_relaxed_timeout(ptr, val, timeout_ns);	\
+	else if (arch_timer_evtstrm_available())			\
 		__cmpwait_relaxed(ptr, val);				\
 	else								\
 		cpu_relax();						\
diff --git a/arch/arm64/include/asm/cmpxchg.h b/arch/arm64/include/asm/cmpxchg.h
index 6cf3cd6873f5..9e4cdc9e41d1 100644
--- a/arch/arm64/include/asm/cmpxchg.h
+++ b/arch/arm64/include/asm/cmpxchg.h
@@ -12,6 +12,7 @@
 
 #include <asm/barrier.h>
 #include <asm/lse.h>
+#include <asm/delay-const.h>
 
 /*
  * We need separate acquire parameters for ll/sc and lse, since the full
@@ -212,7 +213,8 @@ __CMPXCHG_GEN(_mb)
 
 #define __CMPWAIT_CASE(w, sfx, sz)					\
 static inline void __cmpwait_case_##sz(volatile void *ptr,		\
-				       unsigned long val)		\
+				       unsigned long val,		\
+				       u64 __maybe_unused timeout_ns)	\
 {									\
 	unsigned long tmp;						\
 									\
@@ -235,20 +237,52 @@ __CMPWAIT_CASE( ,  , 64);
 
 #undef __CMPWAIT_CASE
 
-#define __CMPWAIT_GEN(sfx)						\
-static __always_inline void __cmpwait##sfx(volatile void *ptr,		\
-				  unsigned long val,			\
-				  int size)				\
+#define __CMPWAIT_TIMEOUT_CASE(w, sfx, sz)				\
+static inline void __cmpwait_case_timeout_##sz(volatile void *ptr,	\
+					       unsigned long val,	\
+					       u64 timeout_ns)		\
+{									\
+	unsigned long tmp;						\
+	u64 ecycles = __delay_cycles() +				\
+			NSECS_TO_CYCLES(timeout_ns);			\
+	asm volatile(							\
+	"	sevl\n"							\
+	"	wfe\n"							\
+	"	ldxr" #sfx "\t%" #w "[tmp], %[v]\n"			\
+	"	eor	%" #w "[tmp], %" #w "[tmp], %" #w "[val]\n"	\
+	"	cbnz	%" #w "[tmp], 2f\n"				\
+	"	msr s0_3_c1_c0_0, %[ecycles]\n"				\
+	"2:"								\
+	: [tmp] "=&r" (tmp), [v] "+Q" (*(u##sz *)ptr)			\
+	: [val] "r" (val), [ecycles] "r" (ecycles));			\
+}
+
+__CMPWAIT_TIMEOUT_CASE(w, b, 8);
+__CMPWAIT_TIMEOUT_CASE(w, h, 16);
+__CMPWAIT_TIMEOUT_CASE(w,  , 32);
+__CMPWAIT_TIMEOUT_CASE( ,  , 64);
+
+#undef __CMPWAIT_TIMEOUT_CASE
+
+#define __CMPWAIT_GEN(timeout, sfx)					\
+static __always_inline void __cmpwait##timeout##sfx(volatile void *ptr,	\
+						    unsigned long val,	\
+						    u64 timeout_ns,	\
+						    int size)		\
 {									\
 	switch (size) {							\
 	case 1:								\
-		return __cmpwait_case##sfx##_8(ptr, (u8)val);		\
+		return __cmpwait_case##timeout##sfx##_8(ptr, (u8)val,	\
+							timeout_ns);	\
 	case 2:								\
-		return __cmpwait_case##sfx##_16(ptr, (u16)val);		\
+		return __cmpwait_case##timeout##sfx##_16(ptr, (u16)val,	\
+							 timeout_ns);	\
 	case 4:								\
-		return __cmpwait_case##sfx##_32(ptr, val);		\
+		return __cmpwait_case##timeout##sfx##_32(ptr, val,	\
+							 timeout_ns);	\
 	case 8:								\
-		return __cmpwait_case##sfx##_64(ptr, val);		\
+		return __cmpwait_case##timeout##sfx##_64(ptr, val,	\
+							 timeout_ns);	\
 	default:							\
 		BUILD_BUG();						\
 	}								\
@@ -256,11 +290,15 @@ static __always_inline void __cmpwait##sfx(volatile void *ptr,		\
 	unreachable();							\
 }
 
-__CMPWAIT_GEN()
+__CMPWAIT_GEN(        , )
+__CMPWAIT_GEN(_timeout, )
 
 #undef __CMPWAIT_GEN
 
-#define __cmpwait_relaxed(ptr, val) \
-	__cmpwait((ptr), (unsigned long)(val), sizeof(*(ptr)))
+#define __cmpwait_relaxed_timeout(ptr, val, timeout_ns)			\
+	__cmpwait_timeout((ptr), (unsigned long)(val), timeout_ns, sizeof(*(ptr)))
+
+#define __cmpwait_relaxed(ptr, val)					\
+	__cmpwait((ptr), (unsigned long)(val), 0, sizeof(*(ptr)))
 
 #endif	/* __ASM_CMPXCHG_H */
-- 
2.31.1

