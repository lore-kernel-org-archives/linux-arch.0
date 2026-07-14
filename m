Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5EA3EEACB;
	Tue, 14 Jul 2026 07:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784014347; cv=fail; b=a809IxM3ba4XoDF2SmfpyHnqqQbJXqPf2sn9db/KbT+qhugSpDenrdXhv8zwQ35OrG5Rhgy3x3r/wxQfIWgQPgddUrYyBgUZK0IApfhSrMV23KIZwn9AfZ8P40VbOTc68DyvCxRgCT/35VZCQVmupuygOSQrzHtj8pK+ci0H5FQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784014347; c=relaxed/simple;
	bh=2U6uEtiE8+fonTvYmcIOUJLYa+DRw18XN3m5kJMjjc0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Lc1njNRPQF4l+5nR6A+KUi704/ysrQtz7tzxP9Q/lhu4nIcxB/eGcWTlboJbjtcHdr81JcGehqfGuvyYo6hwPsPddWhVmClwn4lYWxUjEpb5pWs0Zw+7dzfXU/w0GXHk7gD7+hJ38qSQu/RVRPs2RAGEBCBde1UFlXcAuQfLLYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qlWpMibY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=M2F+gXIc; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qlWpMibY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="M2F+gXIc"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DLEeCP1396300;
	Tue, 14 Jul 2026 07:31:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=7WIJu7+A1kAmf36MIOuhn9JVeZzVmh6rGoasBUyzvos=; b=
	qlWpMibY5+q59UIYQckUB+YuN0go1wVCoemqnfeXAA2vh8TFYAs05SNlFXp4d4HM
	OVgGjLzrS15tGmmuSorLB9DOpKl9LBTzwJaUE/6CCy/YiOuI/oom1Sax4Zwj7Fo0
	rFvcvjuOlV9/DgsrEo3o+iXhT5MnMNyLxmJYX+++EQMnubv+m4FJ4h2//ZW72sNl
	tzhJMFHCBy+L3zI1GVSo8o2D7SfaYF4SXxGHaXPE6ObWTmyw+POWxks0cRE6fga0
	ezgYxrKqWEgsFicM4rck9YeIDmj3pYXASuDhASJm+wLKJ6D5wWEvleOZ6F2WUcax
	PpPqyqGboKf+gDvTSGYjzw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fbef0umpa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jul 2026 07:31:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66E7SWE9035512;
	Tue, 14 Jul 2026 07:31:31 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012003.outbound.protection.outlook.com [40.93.195.3])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4fbc9h48ws-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 14 Jul 2026 07:31:31 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RXeUwuTW/NR18pahJf8rvEyGLaaG6l1zAR1hZwYxgfOuUqSDotE4RNpHI410ZffyeKXmeDcvEZFckQvIeOIpZ5pUnHI4tmrhqsDI2ZKPSoFJhfwEeu2wMH5idSE8XOOIQ8dH4NdbAHCCvQtSsr/rWhMPG5yF/A2mYaWHEOpwPsn1/5IhEUWYc3hDoUS7ziFwcuF1+HtqCzpHCNFRysPeNZjjCWVvthMqF7vq0xLScFEySIGzqHoGluEp0+Orxm+f3qJoPBiFJeXwGp8Etow7CBcoRtIviAeKhW/hhu9TjO3+2WEssBt8isa/Qq5EDo7ueP5QbP2krjFZd+032Yab0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7WIJu7+A1kAmf36MIOuhn9JVeZzVmh6rGoasBUyzvos=;
 b=ODI0b3ODVRfGudVmOJ4ZBMYtrM0e4nwMR4RkNuTAUGbvFfpAiVRGqeysm4cDfaWXWr1CesPxBmBZcyd9lvNZHI/By/VpNopPL97EdX4PjFXE37q5gkPrHO22TQ6Yj8crhnRvCjLWF0SH8pVyLXIbmNwt0dLxteZLIW+hgw04b4ez+ujC0IHGdHL2zrGpUCcOfk2gz0KVG0SKR9QlyHBtH357V9TkkQaSNn3FdCWJvBTyNoTLI2FCrDfzChFI21w6GAoNWKYUStgk8spnBKZ9vLD4yDvvxZt2xS2l7jzEQidX6albEl/Ak7Nfqlqg4gVVsBLU05wI2Sk4pRAO46p/ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7WIJu7+A1kAmf36MIOuhn9JVeZzVmh6rGoasBUyzvos=;
 b=M2F+gXIcbI3nBbhYHO18Bp1MlfSQWQFtrHfJ2fwbjh1zUb427mGCqTNfAkA43byuMXNi+CvihH1eGB3/mUpoirJosmKnWbkRkamwhHlyEKV6M8ZbWS7uJGGlmzH3l/AoHi0XXzVm010LktNNvOIHfhWOUI+EMu7taZlTeACRFIE=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CY5PR10MB6262.namprd10.prod.outlook.com (2603:10b6:930:42::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Tue, 14 Jul
 2026 07:31:26 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.21.0202.018; Tue, 14 Jul 2026
 07:31:26 +0000
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
Subject: [PATCH v14 12/15] cpuidle/poll_state: Wait for need-resched via tif_need_resched_relaxed_wait()
Date: Tue, 14 Jul 2026 00:30:38 -0700
Message-Id: <20260714073041.40250-13-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260714073041.40250-1-ankur.a.arora@oracle.com>
References: <20260714073041.40250-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0040.namprd03.prod.outlook.com
 (2603:10b6:303:8e::15) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CY5PR10MB6262:EE_
X-MS-Office365-Filtering-Correlation-Id: 6517aac9-d3c5-474a-53ba-08dee179e974
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|366016|1800799024|3023799007|22082099003|18002099003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	4qoVFCJabWF0kDRmGvLX03AMUqir7QhcmVBPHlTzIdvMH73Wp6Ouz3Dw1LlcCp0hiwYNXaDOcxMPOHcAh+0xBubEAXmifzt5v4ZStWDhbHQgq/q88PpxDrzcpELkChvpzdUSmTq0uTmhITq4L/PCS1HlPwhTfFP14Qs20iqUeLNviigwcmeXSy3Scln5KHy3VKNdmQjTm6yej21ZKMBVlIeGCsOUfu/E2MmQu04GGWpPL+WH53EW/yjf1lS36A8Lut9O6JdGtEisYRf7J3zfhpPzUHk5sL3FKNFIvvSifLn20HQm+tBQEBkKm+ikb76iPU6v69SSLmlhMbt+8O4quyrnSWt0qlCwMjsrfPrvcQT/CDsFNdbpfyJVfKqtXJ8s/gwAnU+N5BpQGIJr21oKbW0DjwNZJTfOMTgIZoIAot6m+QCO/QCVwOrZ1aTu8aOkKnwHIjYCoZognlzcNLfdlVgyYZoOUATNLAI5/Q97VcqW1esfo8QDbbVfC9DJdKwctPqYorspHGGyBAj7/fRRQqFRfv9MhBenCt7Y5w8QgK/pe/l4QAv5Etiex4abin27a3Jb2yOKosAvLDEIZRSYwB2rUggpKR9LI2jaSk+UAeI2mFYej8TQNvzsGd2CUpkbhxsBLJHWuLgtevSIWO785+6oB1LS9cla9Z47ACSZ79g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(366016)(1800799024)(3023799007)(22082099003)(18002099003)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kC5oAGnrDTRHD7bmHaC/LKH9Lf2cW/UC4FuCfLULJlalSXHW9rh1n6rVrEjb?=
 =?us-ascii?Q?vZblBil8aY7+5hXyBjOQJdNwSf+01GqKn5uPKolm2YlRS70uqHZyuvzW2oq3?=
 =?us-ascii?Q?ej/XejSsPamv9nYjNODbBp7LUIQctM7xjxNhlQFWEwnz0CLiqp0YZl6wdizg?=
 =?us-ascii?Q?h31hnIHla71RJCIkaKT91Msf048Mb2TgI8ga6PZohEus6yePxQ0PB+GLV++a?=
 =?us-ascii?Q?V5c8zYxbCUuVGg/LyTEsEO7AaHNrc+JkoboADOuJwvhO8MMIJZzku1PXLNWh?=
 =?us-ascii?Q?8wcxE7CIhQNuw1BGu3mdtfoEb8rGwDOAv+rkX4D8MX/pQ6C06+ZQcDsQtatR?=
 =?us-ascii?Q?0Wo/m/tAP9TwCQvlN7V2WYGEqEnM3pVpX0s30Tbx2nz5aXyo+Fa9MUKV1F2W?=
 =?us-ascii?Q?437g+dDHS5wliJI5970Bqrira+fOm1hqVaPI9vX/wwHf4mPq2NJPXIoe+gAF?=
 =?us-ascii?Q?2YYdnyQ4l6AnQWOXnfLsGm5PuuKELDdsKtHe4FcUzhqwtzM3vdp/iyk/9XQk?=
 =?us-ascii?Q?Dzr7WeqS/N69gPpDm1jNtybEjZAYhUHBQFwl7AJ1E36ZFWbdPCRiNnbAiXTd?=
 =?us-ascii?Q?ZLu7uEkGr8HzFK4+4qqRbJXal7s5zv/oJp9Q5SCkhSmb7Pw4BH1z6yrmr4E5?=
 =?us-ascii?Q?gqf8ZAxJXejwCJYUtYwKy+YnbHlGtG1q4T46QUeGJg2LgyyMmoJ+bMWq3iLl?=
 =?us-ascii?Q?xCWMJya8vrsFK+UEynsMNKUgxphc9WNwo3NG35HyNMUTRVHM+dUBtfULMkvH?=
 =?us-ascii?Q?fNkRfEarx67h34xIZXdntrBnuYrk2UmN/iRD3+fJpNQb+oPz5YwwFkH3RJYv?=
 =?us-ascii?Q?FpZ03ohTzKqYjGiJn3gGOtGy+JW+rUuXRnePcyWLMypmsv6UFK3RFILJ7wl5?=
 =?us-ascii?Q?jcWf1NgmTUuxwKvGx8nOkJjjCDXewSDQbXiulGO44NGJfLjToQMQYLCT9mFr?=
 =?us-ascii?Q?R654r6Sxjg57Mkm/LL6JJMu0Vfg5iPAiCKIRr6DW9lBtbhkpGQuyi3Rd15aO?=
 =?us-ascii?Q?Dkl0e8lWvViWfbRsjec5Y5Tth7I4LV/X8OHzT2H7DFPc7krc8Rt3OewwPUOF?=
 =?us-ascii?Q?matd/j0OGdjLChkyVCcLBq+g/hQTBgSr9yev/m6ouSq17t+s+GPN5MiK6Gl+?=
 =?us-ascii?Q?qimedUFg+gqvboViqObhLXAtSp1Nm1QYegYvqwvK1oKb0ewAMecE+tArOMoL?=
 =?us-ascii?Q?ON0k4AzYRNsX1nfefk1V4qnMmWS3HbqkVdtziuAFGX1izs/DSU04jzQcMOgR?=
 =?us-ascii?Q?lrQvSKGS8Q8+OJbIFDIXq9fAHWjL3dP/a0rEqVeEzJBYte+KX+otdAmhwS6P?=
 =?us-ascii?Q?LxrqQRVMso2TPES4uapK0PW0uZxY+nO1Eg/5sCrO9ctqM1TryKAu5OyQfr+u?=
 =?us-ascii?Q?Bcza9nkSYufs42WNSp1BTCRCr28n/WnoQBg17JREOkQ0gIz2KSUCheAZGI5r?=
 =?us-ascii?Q?rixPjj/ec+8Z5D48bAd3uTj9qK0q5fCiPIsWQsP+timEijFtufOv2NGs4ML0?=
 =?us-ascii?Q?1r5laKTbcLoUHZAGJNyPHDm5DrkR3anpUYM9e/SxeSJXmsCGEDvFokEt7ZuU?=
 =?us-ascii?Q?ctltdg+3rmKITRYwQ2ruRfXUIS0mnB5a/mnftjL0NerUquIX5y9WjWBisYcQ?=
 =?us-ascii?Q?P/g1ja7GNZvZZlrgMGs5rTotmMDB/zvnfV86wh/c6siOc8VAOjVZb+zQWv8B?=
 =?us-ascii?Q?hXD4l7R3IvNw2bVuRxMXZE7xWHWYyvBVnhgKaKzrX+3ZpBD7RcGGCyQS5pnv?=
 =?us-ascii?Q?LRghW4VRZRNF0gBMjBzWswSPNXbiIhM=3D?=
X-Exchange-RoutingPolicyChecked:
	Eok2o2K25C2j1G3VFZHHXtFT8BNZvuwCRId0RfHQTQ8emV0eahkv7x35mxAmlk8OnwqwqS82gT7QtduTGAqePAGstuCNNaB9PMz8YHk8TtyCNs64nlFfKpG5cJPJzT5bjld8Gq56DqBY3Zo+PXL6wCyhrFJwIGEP16b3ccwgX0YzhCPXEW3WffUr28wLHQs2SQbRlRGWkjf0It58Kz03PVLv/42dmT2LzTT3Rlfvysk2ScabC/N+slIMqbgx6tjF1ATZJRu0h3yUNHkKfFNh03Bq5iw2paXLuxZILPxrPYlFj7RyilRBIlGcE6fL25AStCj30CoFSG7gGMGKeOWGHQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UDsINB4CTTZa1xanFs8VhUlF3MPDPIU5egcc+V49Qn/MEhRfifIaK1fS2WMF2Y5v9KzW1ZGIg4/JYmzo1FF//QmIf22tz6adPWBkeoXwT2xy4ouXZTUT+/4J1phacVbYgyGiIY6bsPGa1RjWcqOWyh4OZYuxGMtj9+xHKNkZu5XI/gIcVP/cX17TMjUSsV2VEmCqPXRucsU9yI87o/v9wrp38lF2ZAZj0mKWNZKlULezSSltj9sWgqKzOMYsIRc55vie/Xk+K00aFFEpXH1MHqWSEA1+qTu3rNMzoLZsF91EpUJBR1UaWRsTKtp5bb4m6jyE7dcNf+EG1mDHX+LQW9CxrS2BPACKbriaGSbZiGE1zdtL6jsD2bRdR2+kwyEC4bV5caB/x1q9OLWEojUbayS9jOA0wz52DosKd+OH1soXTtqzu9piiI2dFcjct7e6qWOEZog3wGfrLivqPdhnOPxXnDbWRB9zMCJjokMi5ct86FdVFTOb2/ExJuyKKquJiVqkeSplpuQe4c0cI2fVWnC9zSw96krJj4pEhKwf9vEo/KD/cCrQRUjFgDliT4ZEfc7XUvQkjMiFdsB8xjeoUYQmrbqFJ95TrH/Im3dMM/k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6517aac9-d3c5-474a-53ba-08dee179e974
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 07:31:26.2716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5o+XUqSid4/J69zlR2ycnOeNjk6NWW67TCVyLcwufNzZSx4kMGXEHQpRXga0eRsjk1AH9r4bVLgCoGwYDAbl4wwGb0K/uGQ7+HTlnh2nzo0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6262
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2607140076
X-Proofpoint-GUID: RRv7vaZHvY-lfanJMU8RyFSgMVM2r-R5
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDA3NiBTYWx0ZWRfX0ffGXigyQCbI
 siuCmrZGZ4rz+krFUR89mTFbUbR+8PB4U6b0XThYatneYjvMcPcSd8sDv0C0Wy1TJfN1NVo7K3W
 ata7rudOkOXSI/9s3sHheJKXPg6RpTntnGPi+WGmFt6SMnxWd2PX
X-Authority-Analysis: v=2.4 cv=KJZqylFo c=1 sm=1 tr=0 ts=6a55e5d4 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=EIcjfB9IiI4px24ztqRk:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=vggBfdFIAAAA:8
 a=yPCof4ZbAAAA:8 a=7gr8-LgUhGOHEYCj_R8A:9 a=cvBusfyB2V15izCimMoJ:22
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12221
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDA3NiBTYWx0ZWRfX5+UJZKBewHg2
 BpT5HQeePhzJVJYqj83pDMDwWSGaDu6wIq+aul7FlyA3WQQe+3ic4bVfCht7lhlE8u1DAZbpGN+
 qwMSw3fx2WkZMALio7Xk2iQAMKMdUiRy1g6lNnkJVw0UUW25H5mvc8Iqomc5Y/eG/J7TdTepyWM
 k5fKt4tCOnmRQUZg4pktifPjA+I1QoKjYEAYqTZz4ZJwoiNDIaEE7u9zLobjKP3YlktQ+uJWd1A
 ScAcXvCGt/CYYmI3514X80ZPi8zOkTDkXG+TYo/VtUETW167fF+nmkcwtaIWbAh+pi8T9PchAPv
 I4WEMDPz7Vt/wo5+yJ/9HYriHwf50nywk2/9+8zRhoMYmCHJvePz4Kjo/K5ulxwoCzhDiHng1EY
 xJn3GZevAaKqrppUcE0p62gDM2e6DINnZpYZ+ehxsKIdTbuQ+qXNRTmmtxjfX2HMiYH1VS536BR
 q5gLdqiDVSR7VPeRRQSJUBFWKr6ShvIn6MFUCIFM=
X-Proofpoint-ORIG-GUID: RRv7vaZHvY-lfanJMU8RyFSgMVM2r-R5

The inner loop in poll_idle() polls over the thread_info flags,
waiting to see if the thread has TIF_NEED_RESCHED set. The loop
exits once the condition is met, or if the poll time limit has
been exceeded.

To minimize the number of instructions executed in each iteration,
the time check is rate-limited. In addition, each loop iteration
executes cpu_relax() which on certain platforms provides a hint to
the pipeline that the loop busy-waits, allowing the processor to
reduce power consumption.

Switch over to tif_need_resched_relaxed_wait() instead, since that
provides exactly that.

However, since we want to minimize power consumption in idle, building
of cpuidle/poll_state.c continues to depend on CONFIG_ARCH_HAS_CPU_RELAX
as that serves as an indicator that the platform supports an optimized
version of tif_need_resched_relaxed_wait() (via
smp_cond_load_acquire_timeout()).

Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org
Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
Tested-by: Haris Okanovic <harisokn@amazon.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 drivers/cpuidle/poll_state.c | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/drivers/cpuidle/poll_state.c b/drivers/cpuidle/poll_state.c
index c7524e4c522a..7443b3e971ba 100644
--- a/drivers/cpuidle/poll_state.c
+++ b/drivers/cpuidle/poll_state.c
@@ -6,41 +6,22 @@
 #include <linux/cpuidle.h>
 #include <linux/export.h>
 #include <linux/irqflags.h>
-#include <linux/sched.h>
-#include <linux/sched/clock.h>
 #include <linux/sched/idle.h>
 #include <linux/sprintf.h>
 #include <linux/types.h>
 
-#define POLL_IDLE_RELAX_COUNT	200
-
 static int __cpuidle poll_idle(struct cpuidle_device *dev,
 			       struct cpuidle_driver *drv, int index)
 {
-	u64 time_start;
-
-	time_start = local_clock_noinstr();
-
 	dev->poll_time_limit = false;
 
 	raw_local_irq_enable();
 	if (!current_set_polling_and_test()) {
-		unsigned int loop_count = 0;
 		u64 limit;
 
 		limit = cpuidle_poll_time(drv, dev);
 
-		while (!need_resched()) {
-			cpu_relax();
-			if (loop_count++ < POLL_IDLE_RELAX_COUNT)
-				continue;
-
-			loop_count = 0;
-			if (local_clock_noinstr() - time_start > limit) {
-				dev->poll_time_limit = true;
-				break;
-			}
-		}
+		dev->poll_time_limit = !tif_need_resched_relaxed_wait(limit);
 	}
 	raw_local_irq_disable();
 
-- 
2.43.7

