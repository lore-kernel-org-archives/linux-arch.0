Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4840282F15;
	Fri, 16 Oct 2026 07:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792134590; cv=fail; b=Ce+9+SE/iatOOB74fHOuNe4T28bXsRi9WhPANAmzHQKhLOIc71bn75nBWbxyvJjfnYzzAeOVLPisLJKcjNx4alE0Bak/oyj2yEZ+l1IYO1Q6Fpb8DStVdH/scvThYHejKGOGyxSoGYLW0fAtvSptjFBZ4lEzNnGdgIxMAXsqsKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792134590; c=relaxed/simple;
	bh=ojN6rotIbIAfJKlO1MyqmeOi1zWc2jY+tGVwNQ7lr28=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oUGBBOHOEI3mcD4rpiSm1t5Zcl/jF6mbtGHsdM0lI2+p+0A1UCCKrb2Tet/es06bHxPpP4MKNdtMleD8zKFYSa1nAhksPM6k3NT1rqSTTT7J/ZzjTTlbCY61QyIid07hfk96n3aCMc07828qXSeVkJj/V/V8J45TAAzNN49oz90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PrFecDDR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=peoQT26f; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PrFecDDR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="peoQT26f"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69FN6nRC3989691;
	Fri, 16 Oct 2026 07:09:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=S20dGHKKS4wRGthBkiO1JlrzyRBsuGiJ35trtoHHkDY=; b=
	PrFecDDRoPzI79u1Quur5XByGGTFmFxQCJ4/XrjTYV0QcESxtiSujBiQnS3XlEM4
	AWIMcnzSEETjkNNfkV9L7/TB0YtLhCgc3ToAoPfeUioU8jlZMXJdOMSIg/qfK6Fs
	xssnkOeGuiL7De4+B/hmV0fDHcl23F2lr9naIsX85UJOWHccGVdWZcB4MsAnY4bR
	Y481unzCrDRF/KGNgbH8pZ5RjYt7BKWA1ktItKFx3/njE/9H9ZtJCdhvc+FHd2Zy
	Aamf4rks0xbPNXQrHsdpNRm6UzEtHCt1pHdopv8W7QmyUewtyN5xI8Po7EHDODaD
	vJJcALQA834cv3fnpVnLoA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ha5vgkty8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Oct 2026 07:09:17 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 69G76NZG022873;
	Fri, 16 Oct 2026 07:09:16 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013008.outbound.protection.outlook.com [40.107.201.8])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4h7btduf7b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 16 Oct 2026 07:09:16 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eLkswN0XPtmptXcBH8NZQB4at/AyKqGiWxJKzyBH55K2VpjWxs5usb4hTTlxVIzxr5+sooORO4V1LtcXVgljP2KBvTz2Gd2jiIHbhf2/6Yh8z2BJ+GjtzH2WQkNMNwrR1X1aO8bF+AXAxk2/a2KzqDDxo45P2bRlAYAyfsb9xyfs86B1aQdstrLiQ8Uvi+Bi8SiT4TWXT8L15moy8MT4k6A1QRlRq+4piJP/jAiJ/1HpXxOT8OksELf3+1/T4e16JeZGMrYMcSeK6HXzH5rdTdQdaH+SL4Qw7ieDXhq1RGDsgCLVm5hWH2+0bOEZGzxVdgrDgzDNnTtI4FB2yOUhhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S20dGHKKS4wRGthBkiO1JlrzyRBsuGiJ35trtoHHkDY=;
 b=OcxI9EDCWw8sDPmigSuMZ3lnGxX5Le4Ai4krO8MUTgF7psFTzIHlCQ0ROLmgBHIpGC8mB8KVvp2p3liDQhz0h5p5rHRJoxG1y93XqKptW73ia5X6ouoBpd0pBNN1CTNbhKz58CPJWbxguYZO9P2XmRseJA2Ci2Uas5oKsikN8/sGp05ox5VcRv4iOkYqzSIbKgxvAKwRJ7GYopMYDZnJYru81B7XfOgg0vyofy8t8tScK7BfWuBlGo1KJL3dX0IbL88w9oTce7PyZeMYlWV4UPLxejWe4w1qlbTR2V7vn4t8idrbiu3h9NV3bo6GVhknUIUK+1pNuTBkVryYezAwhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S20dGHKKS4wRGthBkiO1JlrzyRBsuGiJ35trtoHHkDY=;
 b=peoQT26fYQV8hvv32d+e5COaSXNDanSAlgi9iiknwneB5txuPMdYmTvXLA9l7xbVYBFOuMwFWB1PAN4KRHR28M/9LEuFP9PEZvqYXUQyIjQvoAjXJK6GeF3YUw+K/+Lo6qL6PitB+P6jdX0ZrqIsvjejCMLW4ugMiYEIj2lIky0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by MW5PR10MB5668.namprd10.prod.outlook.com (2603:10b6:303:1a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.7; Fri, 16 Oct
 2026 07:09:12 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%5]) with mapi id 15.21.0546.010; Fri, 16 Oct 2026
 07:09:12 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        bpf@vger.kernel.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, rafael@kernel.org,
        daniel.lezcano@kernel.org, memxor@gmail.com, zhenglifeng1@huawei.com,
        xueshuai@linux.alibaba.com, rdunlap@infradead.org,
        david.laight.linux@gmail.com, broonie@kernel.org,
        boris.ostrovsky@oracle.com, ashok.bhat@arm.com,
        Ankur Arora <ankur.a.arora@oracle.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH v16 08/16] locking/atomic: scripts: build atomic_long_cond_read_*_timeout()
Date: Fri, 16 Oct 2026 00:08:29 -0700
Message-Id: <20261016070837.440748-9-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20261016070837.440748-1-ankur.a.arora@oracle.com>
References: <20261016070837.440748-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4P288CA0063.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::28) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|MW5PR10MB5668:EE_
X-MS-Office365-Filtering-Correlation-Id: 91492291-f363-488e-c1ae-08df2b54617b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|7416014|56012099006|261009223027099003|22082099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ksFpZOoF+5AY7U457lronkZjEB9GoY1hDLnqp0WtTxqC1uno9Of1NwSdoyP1c36WjxzgG4yHvl9GcaAb5kmO3QITMGjdSZSV9mXJpyuwbpWXkeqr8nbULxOp6yMSf9sMzQ6L1LvtknB3AFWpm7HXmDHc55gSGvGpQlQbd55IkEpap4k89An2XnYfe/He/B3BsG2DhwgkEd3uk6c519zgeCCEDyHmYEru94PIuEj9Leo8hWHz74yjMo9KJQKwATEZxF/+K1IVBBXr6Yu6fZRj9GcFL1EmY3puWAF/tUsu+QS+TDMT+lTvh1eRtuJkOArFbH5NDodkWpQNF4rsct8Q2Hf6WDQbh5QLV4E66ZeI/M3QPBuKSvEXn/1tZeZp6Kq9EbBm4PZR56hGmsO0ZPGNhZDvR+EBXntHmisifRgBckRSsa54d1nCdsyAzZTYxq3EvnbKLj5B1h7UfytyfdeJ389jhFZrECm1du1BM0t6oHBI2JmxpTtT4mruk/WuXsM+3wjq2OfBBzlroLztr/tf3wST0zWTzWGhwEeYcpFp9wqKOXQxhN1vAuZAkpH5CZJiSBvVq1771wFwVR/SkjyA30pdNbMNIm8Lpe9sHjhs2jRGAzKUUMDJgVESmooCgF+WxQ7e6iouX5cFfrTWq3/qdUNDun8z27Qg2SjRbvHyL7A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(56012099006)(261009223027099003)(22082099003)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oW+SRXg2qUV/1u9GWIp+IBm7g11G2jbal7nAvbSN1af8JDtX58befJbp37M/?=
 =?us-ascii?Q?BW92qq2wbpAlKJfnZxzMGe0IrULPB4KN6qHLIYtHLWLXew2SWkyzmliR7LOb?=
 =?us-ascii?Q?PKgVJVCya5rFQKR19c4JU//G77qSiswFjPeviQfFa+Odj1ornWS8nMp639l/?=
 =?us-ascii?Q?4U/lvvkFUYxBifbJ9TW0RqXAbhqin+QkpKRGJGXmLXGcPRl8tH6gHc2D8mhh?=
 =?us-ascii?Q?N56tClbONVSbjLTCL7Xs9SchpdlTQfiMt8ybbKflkcV3B1UMVJ9iepLaA+wj?=
 =?us-ascii?Q?/Ob6vs2jgZgn56VJwcFQw4hbpx9k3TRZ+/jaG9Kb0g7SXnXKENX+9TQvphRU?=
 =?us-ascii?Q?vnlvgatFGk3Ya2JuTBoeUg2qy1j44x9oxp4Nekv5DC4cHzmPNjq5pSV0qJWp?=
 =?us-ascii?Q?SntD1ngZll9OVqAKhWn4E9e9PiRvKBJasL2aS+gbNf1UrpFixateqPbIftNx?=
 =?us-ascii?Q?LHyj0gixgHrNf5BzTv6hkFuemS5tnHZ3937F39dstHQXECjA4Ysx79U/NBzb?=
 =?us-ascii?Q?2gmUwMO8ABZVWD1dg4ctbOUiTzFPG6hCCXranZ+e/mSBmrZM9ADIF92nTgbh?=
 =?us-ascii?Q?tV+0GVLUOCzlPU6HcUJQ/bTvaKV9bcqdNtGCMdc7pNXpx9HKsZW9r4ZNN/Pk?=
 =?us-ascii?Q?xfDMYMwj6I2fpOnG3JLRy5wX9XDgH8SoLMVitRS3Czmzk0AAym/FO//LkZzR?=
 =?us-ascii?Q?CL6tOD4BUW17cQSBuAtoMs6SYirD2iCD7zVn+sG7Jk5aC2xZVkjpLjBLhdur?=
 =?us-ascii?Q?MlP+tHJhDXbwP+9NgAKWeepWlF0+3Ga0WrFbiyirsqWjbtpokMnwUn2WjLOs?=
 =?us-ascii?Q?eLjIjmi2/RgPdclgcm8/4TXgWizjbJdG8SK9LBsKe8cVCJfIqx0V/RFIFjaT?=
 =?us-ascii?Q?qFoOnwc7ejex6hxVfzYJdFD9AE9UKRFag5EU6Sjm91JWheawfzNEhnyx54yQ?=
 =?us-ascii?Q?tYNmJd6GStwHadSFco+2PyrKS5w+3lwfOPO3ullW01ts+2954GW923eQpNFq?=
 =?us-ascii?Q?zWyGpTc+RaLctEZqPQSEMxDGJ96Ul4TKBv2FB8Ik31cn2LpZgp24hjDofODT?=
 =?us-ascii?Q?eLUskavHbjw30wowTP1bc67/xg8f0KX/9h30sNgJgy84Vpq1RsaNbMlXog4T?=
 =?us-ascii?Q?P5yS1WlsW8YaTeo4wZf73sajjy96ZNB1tm6V8M7yUXEQkuR3pcW9GJdy3HI3?=
 =?us-ascii?Q?raQAFSmpjbxt2dArcRQTnJWEzo8ihWe7VcRQCGywmJ5T6bzndsAx5JrDiJJx?=
 =?us-ascii?Q?U0IqCTLjBadxSOIyldCbqOAORo5YjoU3OSoEXxPZoFbYW/Ydje4mQJjdlMiX?=
 =?us-ascii?Q?/C1n0k5STMzLb4oWl0KnxbyrAbYx82rFAUx4Fu90YWosgK3b0MwKGLh3hDRK?=
 =?us-ascii?Q?Ca3Azc6Ji4tmgC4se3UWbYloX8P0nqsjo06Qkacmk0jrgT7WqliftMDgG6w6?=
 =?us-ascii?Q?G6/TC9tMZ5tMY6UHbrONb49gWYjfdyGy1d2NJ/XOZqTalOepOSXihQ4Km+gC?=
 =?us-ascii?Q?hsy5EG2/3grYBnrRR2HV6dknotSGeGjAioucgmaBjGgZPDroSy11/4Otcj2U?=
 =?us-ascii?Q?EMS0kII8fFChVJXuIZ7M71el2F1qJ+1gchOaU3ZM7Z9nBAiNE9AISg+jHO+8?=
 =?us-ascii?Q?MGCGoDTxx7eiycpJcgOnlJVOG9WGXwFByoOzCY1O+hB9/RgXBv3KpEVertIo?=
 =?us-ascii?Q?fRtogL0JYt8YlAx4CFjlJGILTqAy3jHVgfqFoK2aYcUaDufmBfYN7RKFK2lF?=
 =?us-ascii?Q?IVqJ7mEnV5aABrM/7R5lrX6zafj2Kfk=3D?=
X-Exchange-RoutingPolicyChecked:
	aq8MMJ1yO8VGPrX7Y5708fjQwWZb17M2IyDC0nhdr9tStoyCAEEXkD9bFjwRzJAjTrQNNNL0NQmvktt2PDkCgiiWtElVkjNjJ5pZBZCK2zmOFKXQ0f82RvpOl40B3ZaOsRRns+YZF9NPCFv8HSxYIL2Lg3T4Du/pN3WRyM1sum6C7Ux7ZpeDyNKoq3Rlrmas7c6vDhY6uC57Wc8ObWxyD0u3mIP/XWV/8mjQkGq9kz9doGkoHJXlvtsmTGg+V2hUys+JpPKlMy1dbxXaW7qg84Ini3W9QiZBWskWutqth16VzO6UXHrvG7axpdfu5V+pnJdL92habQtRCxaeOLkxbw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CsV8qw331wjMvmxzOFIUQGwyBi3uV2yrn9+1OTQobr+BBo2d21DfmCYfB5xcNdWat6nxCI0q9V/wXnNeOqJspVvPSP5I/wBo2WciUbSx7DvFCQPOqCMDm7hDi1vVsbG2oNr+W+Fd1+penKNhAYA3L6X5r07jqCAEf2utOvOOp+2P0mCAvDvlgyyaub88vDOHFsW4B+oDTEWaDbKA4xhe9IvYS+BwDcDAZxFT3r+ngY1nlO8Pp9jrZ96+AWzi3NvjHZvjemxWcAtnAKXZFvxPNqfBTlE6DN+BNkJP0+6H832HVd9lVcU3HKr+3RC55mVaebO+K3KBA1N/xgVc+gYVVjYlLF9L0DFkrj1MFpCbuwVzcYrf8wDCFpwmOsiI33X2WwZej2uCRATqrZwSGUpedl4+5aaKFBfhlUESe2faYQ7I1g2dySuIkNjNJLf1xuDvl4oVEURU1UtI0VByvM+tm7fCl2xfWOzlO3adc7IbWjufUSgKvVrIGZ4PJeXXsT/rkvObEgDwFF5f7WSPfdgP7rW+44+431DEj1ekqFc3FvEbcqGj+gi+JYghWFN7gOvAGgZOxRNeSNEKvz5Cm3IcKszYtN0+ykYMq39CIiPKLzM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91492291-f363-488e-c1ae-08df2b54617b
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 07:09:12.4124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tt3+uzq/50HFc61qcIAw+s2Pi0uvU5JaDdi09j0TcjY3wSVj4qW8KrNR/KNzZanb+nfFmX6JIpQB2KavhQ8ghGc2Bzj8ew0sPfZ0UI/bKDM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5668
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 phishscore=0 adultscore=0 bulkscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2610020000 definitions=main-2610160028
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDAyOCBTYWx0ZWRfX7Z0XEZjyGuyw
 DA97o6e+Y0yrpawbOhopRPD+E2QaVgK4wlM9OWENMqCsOpRdxz5aUu9kbxENrJhao1FbD37+nOU
 xVtZnhOPq48DQlOg3FZ7rUPjYW4So7lvuVC2JKXZ5NYg34CpSmLf9s7nSnzTvyW0Fqq59HchxRR
 ePOWHLKM8H3/JtIR/4xoPLJMtaT8tNHW/rXzi6OuomhBcgPSrf/icFIc8YqLuiMqcZbd2O+JcbI
 2f2pSfe4ss80AlknhxNhYjwdi38Ff7qKcKcGcL9j2n7VG668Od1rFw/IZgDKQDyuILloPwunsJM
 Xc5WRj8PEgGXS3chi9vK+EieTCTsSPEQyna/HNlODcmqVjloR6CkgC0dV8HKvOS11Ytl1zP4Fvg
 uLn4QgzRFlQbfxNK4V31RWyhJGtdsfrZqAk5e9bazcArta9qqDhtTrdp28jRH++Lrov6OXfa+IU
 q562Ufv3m8zoM+EamaA==
X-Authority-Analysis: v=2.4 cv=OtvaWC/t c=1 sm=1 tr=0 ts=6ad1cd9d cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=pGLkceISAAAA:8
 a=7CQSdrXTAAAA:8 a=yPCof4ZbAAAA:8 a=LKnZA62imwlViN-40TMA:9
 a=1CNFftbPRP8L7MoqJWF3:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: UXJZulL-VTIDWEnSXgfkv1wxo1HGEw0y
X-Proofpoint-GUID: UXJZulL-VTIDWEnSXgfkv1wxo1HGEw0y
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDAyOCBTYWx0ZWRfXxrDh8FzPHa8L
 6lkM1M1yjgzfgfHjucqPQ+phsi3DzyZi/wC9+ZiW9R6ssivGLhfSjdIrq9QtZqPaZ0giDKCGLgq
 K2fZO2cdVD5BRNTvPX9wFpxGpVnla97sye46IgWwcUldzVS86MAw

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
2.43.7

