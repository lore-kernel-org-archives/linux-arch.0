Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4E839A04C;
	Mon, 31 Aug 2026 20:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788207831; cv=fail; b=H2ozdR3QeJwlgcYD95twzwW6rI73316V0+aV8NFcll4cl3FndlY24v7tiM81kGRrAvHcKC8uIooM5F/l7HhBpezolDooXpY1j4CrlSg6jtY7Is34maJlEvFM9cr8M3hnFCzEVQlEAbNzr97jm0m9iai293mXyFmb2SyfiSP2oKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788207831; c=relaxed/simple;
	bh=t6qu3CxR+KN0oHvwJiHGvyVbaiWepGHlL/MAvUQqbLg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IaTbiT65rmSTkemiWhAEh16m+9k2rLYwUuJI6O3+k3sTmcVMfy5DprqDtRixyoPuOY/hsH1k0MGxeiCpOnlYTB7rXz1bDRfwH5HfqdTzwWNh/xumjK94frUo0+ET+IsdRDOZkOI9JsrY7f/yVIiltIyItkUUt6vVpjad53ey6QU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Gx6sanAf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cnivkOR5; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Gx6sanAf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cnivkOR5"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VGBxSr2332972;
	Mon, 31 Aug 2026 20:23:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=R8xc40dipoB7isXedtATIEEmRxv/SMWdlqGpWg1xw8o=; b=
	Gx6sanAfhtT4f/LFYzbrtdbg9g4idr2ORliBa8nY08hbK9iUmiyzBfLaSSKZLka4
	8pXjORJioppHMplzepXPtYxSUwGQK3a7JUEiK6GGGwP/j52xI29TcpkAHdqYYRF7
	sbWPO48sG3R6tBse4vSHE3A2NVDYSgNEQUnoEhpkmPorVdyk1/f+DEZ+Sr7RtkoX
	/PDsesUHrPgR6/JZTQ891Cc+ZxQN/hCYFYz7TomQDrenzcx3IPKhWrSPyujZZaqV
	pCsrl6xyPmr2ZjJ9UGlseHmxxUrFq9Xa+gZYE/rvudDUT4vzQW75fn5gFoIh/eyZ
	Iqa5QLYIlA4jhdCOFWDsaA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gbpbaudxy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 20:23:06 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 67VKFXd4003016;
	Mon, 31 Aug 2026 20:23:05 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011044.outbound.protection.outlook.com [40.107.208.44])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gbnvpkd8j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 31 Aug 2026 20:23:05 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EiF14WMDQXRyEv61dq+8mNzhSiuEz/kltEMjAG9WvWH8woCltWbxXYPQMWo1qhDlFwCu2ZXw/c0Lxr3yVDcbw3KQltWbmc8GL0T/Mb5zF3ABHLqq8Z3QORM/I02gIFQxzCSphchqhC9LCh7pdalhpoL1FtfclGsHFOyoGpXUSYL/jstKu0g053X08QkHSPTyvh8nUyeaPB6c2sjNt1NBEWE8ue3UcAicIWuFPP1M+yDvA0Wagna/5nO2UxycNmPeBtonVQQrLcPaa/uPAcC+4sfmzxhTB26iBsCaahjyhNH80a9l9WKXokgsjnlqj6IQgmg1i6qRug+Dyh7P3Ddqsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R8xc40dipoB7isXedtATIEEmRxv/SMWdlqGpWg1xw8o=;
 b=TlMWwAMZquzO8FJ+NI4mVX2lq9nHQvvrZMxxioDcnu615wsmYtzakp4uTBOWQ7tByPY99d9rS20xN5P/bVNcwQpCM+RPV/BF3uuNjzMEARtQ0Wt4IoGmcjgoprnmwiT+huZNxUjuozyyYV5+pjsIegoUlgT8MiDI/nq5axdByTgPRuc9822/DqBR0s8YM/fwfODFKMebSbE42O4htjn+GiAEV0YKpGfNwfXaTmRvPgHBGuvxUUAQX06Li2LRF9kY6LYr2UBq+QQQQpPW9GAnKWb4xooenLI27xAzIIZ9NjYkeJyi66ooVtbkAZJRXDLHES0zW85zk+fsdJaz4+/IvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R8xc40dipoB7isXedtATIEEmRxv/SMWdlqGpWg1xw8o=;
 b=cnivkOR5fZ0KYFZrUl1ehgUdfFTR7t6beLAC8EzFHqKMyY4f3Kw2Cz8Jn2dpqSqiuitXBCFfaMOzZAdpEzCoMre5p7527gvbI5Mcc6Tx47lt5Y4DRib20m5sv4iLP7vw0P0PbOuGV1gxBjzqpgVnwiBRpHjgDOyjv6M5plFj2LM=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by PH7PR10MB6179.namprd10.prod.outlook.com (2603:10b6:510:1f1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Mon, 31 Aug
 2026 20:23:00 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.21.0382.007; Mon, 31 Aug 2026
 20:23:00 +0000
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
Subject: [PATCH v15 03/16] arm64/delay: move, fixup usecs_to_cycles()
Date: Mon, 31 Aug 2026 13:22:38 -0700
Message-Id: <20260831202251.305046-4-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260831202251.305046-1-ankur.a.arora@oracle.com>
References: <20260831202251.305046-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0151.namprd04.prod.outlook.com
 (2603:10b6:303:85::6) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|PH7PR10MB6179:EE_
X-MS-Office365-Filtering-Correlation-Id: bbbe94df-1512-46c4-3a06-08df079da6e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|7416014|376014|1800799024|6133799003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	oCdF+hO1G4M4vYvTwx5gw9ryS+IuMLwAKpp6ssn7Iob7+zjMRPH5MFi5YwRy2/uVi3CVyaon+aD9u4oJ1FXPM3dKspK7hvShB0Z8qV6NX7CBZHR4ktXvdxwW3BKTPajRO1k62UzJL5ZLPVXQOMlMZ9gQSwbZJCJh3WLV6wUrGW3WUHO+aVPO+GZflsxnI8JHLFzVC7fnA+N3muceQ0LikYwuhc+jtDmHNntWr03IiH5Nqm/ojnGZ2RhLxR5VqBHyk/aIjHK8eNJ4Muo4d7b5Qvlhdw1yge2GnB963AECDt6auBQFUW/tqFEWvsbO4NeMu1lFoHKcD1ZumsLlyBzdwIX0HmyaZdYQfxx6Z4vRDuaHLlpSXyK/KCdRA6UkXnOfrUK+2bmQUSSdHBDE0oUJI8Hf3CZ4aIsn0fmT+mOJgSoONqv1M0HCzYWzkPGgmNROpis04gMgSUjWekNmxsfaTB0WyHc8bxuLCszr32gmpCIIX34j6MgaYCrkJkY0LSekfokJ3Z/bHbLIbkOIk84wdd7O3mrESwImSTmADZ1TIjD7q/zEkw9SJxOD9G7WN4pSn6vbiRSBDymL32pAxSyAD5WoqzSb+IsDpwYoLxs68+32oFJHKGfzB5iKUFDYutgrud9LBbDkVPNxzgFhaGx03BQ/w3oLBvOb8+9Su1TYtQo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(6133799003)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ayjRkVADSMztPSyYD7gZ2OxpbNgE6OoSkjte6pgIJM50D9euzRpag3VTS2Nw?=
 =?us-ascii?Q?T/FdVhvo258zVXgbpdynAjD56bncYHn4DPwRGEjsZH7hTD9MXYOdKNafDPiy?=
 =?us-ascii?Q?8v4DS2LQGPiQVbOkiaN2xOXZEKN4k5a1tcd3RK8VfDHpIFXWhD74JN5B5rrH?=
 =?us-ascii?Q?zdNFdbHDL3tVFaeTUW+WGenJOHAw6CiQcyuYppak0QKiShIXQeTILXa+rElD?=
 =?us-ascii?Q?9hqlc24xJ52Yj8MjrK2Q7xinSIF9mohLrX519V/WNPWqvOuLJ4KNa2xuHVKi?=
 =?us-ascii?Q?6UmWefZgwK3YpI/xfKC2zGUnH6wSAfpoEasK1rF8W9omeo3KDPXiZnuWlax2?=
 =?us-ascii?Q?OFCJZn0+jkd6ildG8LALX/HEOtZxqEtyNIEksrnnbquS25NaspjAvowEPsts?=
 =?us-ascii?Q?fpn1bGPo/NaKdoyJPfW1+74bTHEJO5y2/c0SM2xm6J2V1mPDs0aZEaJHkJZy?=
 =?us-ascii?Q?1QI9oDKpM6+HCuEXE9T3jUPPCnktiOPp/2f2nlgFEtxx6cqJPHnTkMRXr8Q4?=
 =?us-ascii?Q?NYXoJAaJq1kDeDtBm5u1rba+HX5MstSPA3fjUX+nPgLx1QYtqtKG8QAllxm8?=
 =?us-ascii?Q?4Z7W/PPdLb8Nvdx5XToPsNCZOaqUrQH6A2Js86Mmt/cr79h+0Zcut31eFMyA?=
 =?us-ascii?Q?ns4+tuC5peDTJG6mW3KZXvl72Q5KrPQWovJCktkGKc5qBt4s//m/akUWAYiq?=
 =?us-ascii?Q?PSKfSiOuo9U3YzK9cE9CI8hf6h6FpaExGL1DfO9VtLS1z6lGpJNuX7dHdaeh?=
 =?us-ascii?Q?Kj+g8TLNV5jDd3v7CHHudGkqjIVsDNqjnpxwqPnpXfaF9lpWsdgn3haxHK2T?=
 =?us-ascii?Q?cWxzb14YPvomzuAAiVoOcoTx/UU7YiUnJdp+6UFPQZCpV0niwCWES3LVJVl2?=
 =?us-ascii?Q?Za7h4OZTffheDI9lJZpzg6oua5yVWUHEVjtigcQJbBU+UeiioikYG5nnehVK?=
 =?us-ascii?Q?dbmPBNKu7mwSkZuUyMC+eduYrrQjax9HvfF+RG4vTSDI5LbBrc00LQpLzLiu?=
 =?us-ascii?Q?ysHY/xpHME7Lio6WwS7s9ai2rHAi6FyVYbnCyuXQXxvIkIKidC7Yi6khf1bo?=
 =?us-ascii?Q?gJbzmtwkW8RHcZSNa1BornV/osaVScjCGts+S8mGNYg7ckA20ek99qUwqpwR?=
 =?us-ascii?Q?P0LgcmNjn8m1CJvJ1KrRzsYD5BcA0oBylRbG4JVSjVBNuc3D64qPmMOnY3kY?=
 =?us-ascii?Q?YkxRRG0lzBLJG7ml6bcPVq7O4zOGp/kgSOqxurKL9ULH7jeoZM7i2ocdcDr/?=
 =?us-ascii?Q?ns9pP8efMI21ggcbJBn4hoGC+J6+2zQmmyYYtHJ+VkIhEG1x8QRiLGh/kur2?=
 =?us-ascii?Q?xR8BG9OPUxATOGA8sAWAtu73Q83XnLGM7ScGAKvocYO47ysFa1dSq5q+Vpg7?=
 =?us-ascii?Q?QAs9jU4V+gFnGbb6wP3QpsNxFB6+HUN8AWecqfgBQ5Jnzg5HEM+QW7iD8BGk?=
 =?us-ascii?Q?Ida/BigVZBam0aEiT+qQJKP78qJGrC3zQpNZ5Hw05gE6NHe/+c9psHO7228W?=
 =?us-ascii?Q?3OrC8uepATQID1WVkAMrjOXlN1cLd8nMT4fBhoigBrCCKLwrEkG7KGB8l9+G?=
 =?us-ascii?Q?nGKyXkT4wua2MhzQBtFR7E6eSJ7MMhIb5vRIQ97HFXvKCYRS7LmG1S/EXJ82?=
 =?us-ascii?Q?gYZZwoq4o8yvsi25yyw+i77BZVQdcW9eTpFGoEj/lmtatUdZZoIsO9Vmt8FX?=
 =?us-ascii?Q?rIvms0B3JYZ0cRPd+fRJ5Uvzt4GdupxdxMPEtFM5FD8iT9RYhEXboYz36E3Y?=
 =?us-ascii?Q?OJHVd5U0+YHUw/IBW/m+qpFElwI2HcM=3D?=
X-Exchange-RoutingPolicyChecked:
	T1UnVOzrHrJ7eS6vGNSihssRHftNSPmnLWyLhocT/6OJ6Hx0nPFKZTo1SynYmvTncN/ziz6eVUZyP6K6IWuu5GsZWjige37uIeE1Y7W9dWBxmBDk7JUwHj9fzZbq96JJMcMHl4P5bT3HLXuhl0uEcVAh+SMauu/jGVJyl44ov7tHt9QymwiZq6XA8/+0lg9iBrEZyimeiyYSZVJzQYZeZ+zNhz6IuLtvN0S+ilo59T3pg21H9tW9FLexhrR20GutmfOADBJODfyCLPQ47Z0MQdla0kGL2+DwUvvHqpQVcuaVajDwMk5niJdAl6Fx9hB+56XQHuO3Kd418gjDviot+Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	V1Boez3qUdDLZJkfqXzCviCQFpVaMM8j3fCsa6tGEKovdA2MP8G7taNRDUaszcBLLJWa3CJMcaph5YV8FV7wnRbHT/DFalRC6oQsx/gXvvhurQnCq2Jy7yFk8R4YPmtAhGnwJPEDC2dkgE8uSjtL5Cp6ojJTyqeCu6s+aTHjckIMenxEow3IKvldGRCl+KjOmLqY+JVAKd5lNlqqQpJIyTh7A1EC05N/sCGQUtopBrXYsIh1QdgnuBLnAJC2Tlw90/EWT5viB4gqdapFG9iFMwRVEQ/BWsti+b7RfotggNNS3oi/NU1eS5fp6Nf1aU5NUJPPdy58cFa7jy7a5q4+W35Kbx3GBNVl/FtJMdJCZTqQiwttL1Sz1sBF1g+KpJYuiI+l5n9BWq+nLFKpPVJvrbqA10xcm0Hf0l/ZcHP3ZBOcdtFXQUxwkI08QxK9NXJMEsxs8zp9efhgrDKo9scE0YAL8Ru7JpgazgAWyM+AHwaZBO6xOuhaCWqk/COpYN6NTGNAgyjMvCEXLLG0avA4cgolPCMUYf1BfUpRDL5Tt+5/AaH9rmS1/gePX+NzZnifQp5UYzhNa7tE6jopW+EYXj1xhBzMOcv0ApVL9kcOsyw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbbe94df-1512-46c4-3a06-08df079da6e6
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 20:23:00.3513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6AN6KU7eYp6n16iIumW+7lBgPVlFHG7HDclqrg4g+AjOetYT/vyUWpqaNf3+W93otjbv4LxV/88hSJzh1C8GdY+0SuMsOKvQezC6OkhjUqs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6179
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_06,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2608310175
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDE3NiBTYWx0ZWRfX8lTjyE/H9EBL
 k69LTDCf+2c9evJmi18epWpLmSWAhR8QBYXdErL3H1YUalvVqaP/Eg6Fd4mNtYGnK74R3Ob0tw1
 oBrCOHfDFPK2xIkwqsIPmakJ3lhU3/2CCPH1c14XGhG1S+fDvmmB
X-Proofpoint-ORIG-GUID: XyzpgfVVE7HWJay1AvobwcANPBv6W8Eb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDE3NiBTYWx0ZWRfXw3pma7Mer8hl
 Md2c4B4U0TFedLoCAU+tQQPlvOHxfXaSXWc9jvRN216nKDXJ1DBSnPugLCw0LVgjH5H/fD+br0p
 8k5qdASSY8btGOoXKr200hmDkdy68xX1Eha0KhAd1gPf27TKtmoMFMF6oEtTK+FyWZV4HgEsqnF
 5eVOlivYQCUGV8lOaNhJYh0V79SPeYr5IsHLStueUO/ivceaYt1CY+o8islBJdPiz8AE9R63Del
 lAmfhA9AjmE6N3mt5O7Et49ay4Twt95Bm14uw/fyFtzNYlE6e+WBH0f0rriFr+Jdn300PulF1qU
 5l1yDjfQvr2zSnmHuFRDWZG+7EqEdF8rsj7VMGjyf/VCmjA9PD/4PWv2zCPHruXICqCFTab0Y0y
 ctAHKD7P2GEuE6rffE2NMqvONBmJLj6WgesbY5b2OuuABdX+5R//90UDqFZYl7XivZTHa9TBWel
 c2Q9BjdPfF5a6eqmYx6oyskuC+lkE8gXuUz37h6U=
X-Authority-Analysis: v=2.4 cv=DMi/JSNb c=1 sm=1 tr=0 ts=6a95e2aa b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x0eKOSpe3m1H3M0S9YoZ:22 a=7CQSdrXTAAAA:8 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8
 a=NufY4J3AAAAA:8 a=yPCof4ZbAAAA:8 a=70AoctknFhLFtkeFxDcA:9
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=1CNFftbPRP8L7MoqJWF3:22 a=TPcZfFuj8SYsoCJAFAiX:22
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12102
X-Proofpoint-GUID: XyzpgfVVE7HWJay1AvobwcANPBv6W8Eb

Update xloops_to_cycles() to use mul_u64_u64_shr() instead of 32-bit
fixed point arithmetic to avoid truncation for delay values larger
than ~10s. This adds an extra mul operation but since xloops_to_cycles()
is only used from delay loops so shouldn't matter too much.

Also move some related constants and functions related to the cycles
computation out to a new header (converting some from macros to static
inlines). And finally make __delay_cycles() available outside of
arch/arm64/lib/delay.c.

Rename some macros in qcom/rpmh-rsc.c which were occupying the same
namespace.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Reviewed-by: Christoph Lameter <cl@linux.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
Notes:
  - convert the multiply, shift operation to use mul_u64_u64_shr()
    to avoid truncating large delay values.
  - makes usecs_to_cycles(), nsecs_to_cycles() static inlines.

 arch/arm64/include/asm/delay-const.h | 35 ++++++++++++++++++++++++++++
 arch/arm64/lib/delay.c               | 17 ++++----------
 drivers/soc/qcom/rpmh-rsc.c          |  8 +++----
 3 files changed, 44 insertions(+), 16 deletions(-)
 create mode 100644 arch/arm64/include/asm/delay-const.h

diff --git a/arch/arm64/include/asm/delay-const.h b/arch/arm64/include/asm/delay-const.h
new file mode 100644
index 000000000000..6ccdfe0a4130
--- /dev/null
+++ b/arch/arm64/include/asm/delay-const.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _ASM_DELAY_CONST_H
+#define _ASM_DELAY_CONST_H
+
+#include <linux/math64.h>
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
+static inline u64 xloops_to_cycles(u64 xloops)
+{
+	u64 loops_per_sec = (u64)loops_per_jiffy * HZ;
+
+	return mul_u64_u64_shr(xloops, loops_per_sec, 32);
+}
+
+static inline u64 usecs_to_cycles(u64 time_usecs)
+{
+	return xloops_to_cycles(time_usecs * __usecs_to_xloops_mult);
+}
+
+static inline u64 nsecs_to_cycles(u64 time_nsecs)
+{
+	return xloops_to_cycles((time_nsecs) * __nsecs_to_xloops_mult);
+}
+
+u64 notrace __delay_cycles(void);
+
+#endif	/* _ASM_DELAY_CONST_H */
diff --git a/arch/arm64/lib/delay.c b/arch/arm64/lib/delay.c
index e278e060e78a..f08eacef2f0a 100644
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
@@ -54,7 +47,7 @@ void __delay(unsigned long cycles)
 			wfet(end);
 	} else 	if (arch_timer_evtstrm_available()) {
 		const cycles_t timer_evt_period =
-			USECS_TO_CYCLES(ARCH_TIMER_EVT_STREAM_PERIOD_US);
+			usecs_to_cycles(ARCH_TIMER_EVT_STREAM_PERIOD_US);
 
 		while ((__delay_cycles() - start + timer_evt_period) < cycles)
 			wfe();
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
index f881af35ecfc..c9a814d9e06f 100644
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
@@ -828,7 +828,7 @@ void rpmh_rsc_write_next_wakeup(struct rsc_drv *drv)
 	wakeup_us = ktime_to_us(wakeup);
 
 	/* Convert the wakeup to arch timer scale */
-	wakeup_cycles = USECS_TO_CYCLES(wakeup_us);
+	wakeup_cycles = RPMH_USECS_TO_CYCLES(wakeup_us);
 	wakeup_cycles += arch_timer_read_counter();
 
 exit:
-- 
2.43.7

