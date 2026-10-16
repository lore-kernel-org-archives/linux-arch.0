Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC9B3E5A2F;
	Fri, 16 Oct 2026 07:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792134577; cv=fail; b=nqplvZcNiGiZKsU28StZZmtsv8PgXnTDjPflajnV3IJbaqvre73CMDwc0sbqGamye+8Uwq5ODA2VglXJLNDHfdhNchi9D5NCfAItuDKRupdFh831zwgLFd/nh+396tRAdwVR4i1m4d8drP6/HSfUELlpMIndrklH7PWXQ2BVkUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792134577; c=relaxed/simple;
	bh=30IyKNQ8CEnB/lPD2oC+EHUu4hnTFE3LGSGYLoy+ZmY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=BUIrOlaUnFQokktvViETEKQfceQkNDlhlidovWuZdxpK3fIF94c0XNspq8rZZPwuoRed5iOUkRj6xafT5lzHE6bQa5IJmyRI031sNA/FVOXpuIQuZRzkIee2tkB8IbwmX2IIz7bQNHjUvlGt4sR4apwhJPQdFnSLZYT6BCLUBzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=j2S+DCte; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jSVv5Pml; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="j2S+DCte";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jSVv5Pml"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69FN6q002066127;
	Fri, 16 Oct 2026 07:08:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=CvmGmt1/YeNt/fKX
	1rE+IxyCn81c/fRlsNiGF6NFyAM=; b=j2S+DCte54pO3KDymvBRW4v/YPzKXgRP
	H4EAf9OY1zlYVQmiv93/ZMbanLXzIekzQzGN7OnGVvhOiaSy3VmJtcmrHYegm0GN
	gb3SQZgJxFL3UQ8NksvA32jH0LvLOmnCjgefdQcY/tTKStGmI5orGO8Sq+SbszwK
	8cJECEzwcylmGcD1RsNMto4XbpcfJsFJut9GIeOpRGoQx7+TqFmMMIHllP44iM8i
	c6fJaPLeuSy7xWnYZllOozP0OoT+QRFKWjXXpA5d1vObQ1Em46oor0HiJofPNeN3
	q3JP363g/KgJsOhjmPfw4xPEGt7m5oh/iAEk1olAdXMmBUA0MUcE3Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4h7de1sc54-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Oct 2026 07:08:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 69G76feb020911;
	Fri, 16 Oct 2026 07:08:46 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010055.outbound.protection.outlook.com [52.101.56.55])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4h7btss0ng-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 16 Oct 2026 07:08:46 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W1GZaUPF/adLy0BNCnPecQB2wwEP1KhCmYsfTpH8i29HIcdM8AFQQ66A2Dmn4TCnsklJhrigeG0xW8rBoHfmgLrIEXTizEQSwb/+apDK+Fa30shOwc/NHxBBpModICNB0XuccpkYkkbC9vuSGAJIcY8lVPtYGCfZeAR0mSjo9Az9u/ZI0k8Su8slm6gD50sgdcDjDd/5HBylLG7CejRobl6WVi4taieCjolKvno++RRAq2DGsq/xAsoGVxeWfd3DfhHyjSaw3yoIOidgcXupx4TFbuKzYByEk80J3glWuUKGHTtpgxYIYohIcX8PnLJvKoDNgIKlQxLMFJ95aCIDZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CvmGmt1/YeNt/fKX1rE+IxyCn81c/fRlsNiGF6NFyAM=;
 b=H7ytZZ4f28e2Fe9149DAojPCIgSmdOxZJOti8EUg7atpsLSZbX5Irqtnl9cgnKK6TNNWQ1mfCWynm+yefmpod0P7mm5vVevsH02duq1b+slO4VXv9ebn38bzU0QKsWXq6sw4Q5N6wZKiMlD7aEP/SYJ8/QmAH/7Nz8N/t+4qpF7njZX00eHefUlbPDwkNK9x1yo7WnNROtB2D2Yax44o/p4GrnREBMKXXvMVhBAjBr5quMuzY/SH5++Lm2mx0Hawf8Yu+Vba7mB6a7zHu/mmd4AOkQrdxekj9Sm8Z7+BD/7YJTH9CxNbpllLJMHh62wJQmE6nN8DrfIFBJVZfYR8Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CvmGmt1/YeNt/fKX1rE+IxyCn81c/fRlsNiGF6NFyAM=;
 b=jSVv5PmlWDQcriTKYMV0/MA4dA7JJQVYAwMkbg4nslIiTyCUf1a7ekYE3IWpHb+7ApJ6q8qifLK4ppIl846T9uiHXz9Uf+cEMD5QPrW9sp7kVRgU9ZDKQp5P5fqi1RYdsQWW37pvLmwfEyx6ymi9hQfy06yBbT+IGdmU1Ub/KlE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by MW5PR10MB5668.namprd10.prod.outlook.com (2603:10b6:303:1a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.7; Fri, 16 Oct
 2026 07:08:41 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%5]) with mapi id 15.21.0546.010; Fri, 16 Oct 2026
 07:08:41 +0000
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
        Ankur Arora <ankur.a.arora@oracle.com>
Subject: [PATCH v16 00/16] barrier: Add smp_cond_load_{relaxed,acquire}_timeout()
Date: Fri, 16 Oct 2026 00:08:21 -0700
Message-Id: <20261016070837.440748-1-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0007.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::19) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|MW5PR10MB5668:EE_
X-MS-Office365-Filtering-Correlation-Id: fb71773c-350a-4a33-abc6-08df2b544e45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|7416014|56012099006|261009223027099003|261009221227099003|10067099003|18002099003|13003099007|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	XTV87+FZPKFCwEF2wx1fMGX5iacRAvVgq5EcANdnIap5yQE3y1VEWaZVWBnwAJaqgnNs3GVTcoNvUXV+yE8S1Mp1VLnP9/9goNPm7Asd8UyYWxKiP2Xeq5ruAy8iR5tFTfg1qwogYFg63IJx4wi1qC5k6uc4CvVNERdPoHYP5oXGzo3aqg//VwEAEsmfeRMeBb+gl5TPGL8+TbkTqWA8TxyaW6EZvNpw1GvaE2aX7MX54oY3um/vmvVpLJjdb8EbX/rPD58lEr1qGWWtOS/uPmkgaHJWS1KoJ6n3aLyIL/DLtuNiBE2Z6zUj2G+v7SmIFjc6mef0V8vy6pTCarbh6uUUO7uAfdFGDxY/g640EWVY+0aBgzCQN+hlIIHOL2B0YljtdyItKRx/jfC/8p5Iihgtvg4ygHsfwZibS3/jXh4yoAeU2gPQkAOdz6k9RTJ4ViVQirhWawbFMSPxZ+eUFXlTPgfdITNMZA0fzG9pdf5tlmqzKHUH4V2ZaHLDbO5h65k9Nb9ONjQSMwlCwiQ3n4pnloUzjffZxl6opLv/E1GzigYdwK6LPI7mV3rcMfxwDjJpuSvcCgxKINbiP/8i/cb3jsdzWkQv91N3qb33U6gKheg+ShAsVbYiIDd4P7fu
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(56012099006)(261009223027099003)(261009221227099003)(10067099003)(18002099003)(13003099007)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7gaIOShuNtLXvVXwlYW0rV0ETygDwNxNhNQhRplYs/vBRQY5x88HLFLfycDI?=
 =?us-ascii?Q?LsjzzFClFN7WH3Lr12hZs6Q1Lu7Z1A47OsZHcROKq45YCI51PkFjkENx/R+M?=
 =?us-ascii?Q?cn+rOz76bjG44x1CwLJ6HIGfz1M8gDPWGS1HN9ZsXjz1uVg3m/III6ir6qq6?=
 =?us-ascii?Q?RRu0t9OpwtjQ2i0uGrk3/IEEGMImSiam8OZ5UU+Rr+H7g08ON5RApyMZmuAP?=
 =?us-ascii?Q?CW53zHodPFQPG8APdV5IZf+hWxuGaGw7tTuMPooPK908zEJEwTj1u8JhmMxQ?=
 =?us-ascii?Q?tbDvh439jUoQY209DOEL9586GON5YRPiOh556qSxSSsxLGxgHElotPfiXksp?=
 =?us-ascii?Q?aUdulIIfNCF9aW7ZxXV8B0oMRYdTgmgeM3denxDUOLSNnHr9LRWaMgIEYYlq?=
 =?us-ascii?Q?KzMSjIEMhKCcMwcETqNxnTdAnekFYrAiROKRQKlNNEJvLo5TB0ERBGEQF9xX?=
 =?us-ascii?Q?wTM3qHAmOjotuukymMNDVvSSTRg2rgb8o0AuvWIU91P9Y045ZpIcdxC9bzOV?=
 =?us-ascii?Q?oYsoxwM8LqDsuTIKhTQhqLu/qxhtRvDu0SccMnD/yvudOzVA9SQ6UwgLfYKB?=
 =?us-ascii?Q?GpZ2Qo6sVKnZE6RJ9H9gYXfnGk+XIEwS2lEQFNnMaSmugwKiYXagM/P00QY1?=
 =?us-ascii?Q?2sZWD5Thbo5EMDmRVfvsXNhDIbkzdbg9gBtV6WT9gSIwVHA/yf7KlO8M8L8J?=
 =?us-ascii?Q?ExghimCw72HHoQvNb4GAk+kPciAdstD/KVJHr62rnhze4xAlTxuaHq03IsRS?=
 =?us-ascii?Q?NUnip/fnLqRqrLsJzX41L/XbvaGwYY+6uS4DQyVgAVUsdgO925RYfo/4TvWm?=
 =?us-ascii?Q?EHeMM9gGeUvdmefLyPiY+cJ6ZU/DR6vDM6aXifpiTA7mYJgFWFRKe3i9nKjB?=
 =?us-ascii?Q?AwnLdcHmzJVe76sHsvOL87/IfYBpb+DVZJFxb9wX9riymObi/AYP8SjGSA0d?=
 =?us-ascii?Q?9D1U3I0xZ8IcVMMm697CxTbqMf6/e3cpuKT82R3v0gHbNzOpEuFAcFPox22c?=
 =?us-ascii?Q?tFHGTNdifNNBEyGAz3PHlackFgs6aDs4RpsXADBf0YeaCJEipj+uiyOMnfek?=
 =?us-ascii?Q?s3xGlqSaTBLyUsS1wavQUhavD8kFdkhI4Kuys3oZCZWNH2ffiv92aBEo20em?=
 =?us-ascii?Q?NTgiq3eBIy+ySLHwjdIzzrLHKWWUihZ5yhyfJocIVZAdOjZP+VC6Py8Ja96d?=
 =?us-ascii?Q?G+XxAbZ98+PeMQXju+VYkdKGKhy7HJUTvFUOFHk13mykyAyOK9XF0YdNWJ9k?=
 =?us-ascii?Q?LalAKnq1LSwYgow1A350ZTrSs1ASKje0KVAxFXfZDGq9XPMQdom6guJduPoH?=
 =?us-ascii?Q?She+uCuDcXJ7P6cnITlXMCdz+lpJX6oeB3y576uJ/Q6y8eUdbyL0/83GCZlj?=
 =?us-ascii?Q?qt83r+gD0/pAs/GgOaTI3FN0I5JsgycmfqNrCLMpSdiFwFV9X8JygnzNlf4P?=
 =?us-ascii?Q?4bYSYoJHWMG7mPmXwp0Ve/lRaxVdWeRlv4TgIjud65I6JCF7ZzGtxL5Ps3ye?=
 =?us-ascii?Q?iurZBCBg5oGj8bQvCLAEfJXw9C3JX7bqM/CTSVC1D9ANdEES0HKN41qa+JOh?=
 =?us-ascii?Q?R6RKgYnJsJATAtP5jZ9iDOviZKfkGM1FQVH7HKZ8MQuFPz0I5fTOP9G3lXFO?=
 =?us-ascii?Q?9egC0FyDfn7pmpn9JUasP/KleWyRGfUEOd9PHwBJjjn61Pc0A8fcPIFSHZEH?=
 =?us-ascii?Q?o97WT0Mw5rMUIOCD8M8IprJ0/GwT6UE39p//GaPh6kRdEnz6+t7cOIhy08UO?=
 =?us-ascii?Q?lB7dVk9rlgDgcSdw7Uq0+e7t4f2jZSs=3D?=
X-Exchange-RoutingPolicyChecked:
	xuwoaJ2O+XYAGDGjc3TKOulFaR+31ofmdSzoQPE41DV4FQZo+p9f2GAyOYHrgF1G3mZSAajL72WyIZX6wNn54ZgBCYV28ygpWJDYdyOraG524GNiPmqFKqyz5u9E63G6ot38hTAQkbygumVPpx7874gJmy6NxIZbM2jc1s0jH31avWW1dCW/WhL3Vga4QT/6IqESFtAtBLxUp8oV3M1pZvt46kP4lij0oZIF+eib+FB14i4yCVZeI22szrjuu/8surS0Yj3NoLjQjIBrBdrO7fUEI4RbT8yxv0RllF5FKf64rClEZbVgF96XuzCBQRHdbe0wdqJ5DlhoftPXRcq6SA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NdyYuZEOaRG12WGUkDmuKZdGlEPHJPcLRthTtW5xLto1F96Oc+60fJLkE3mvCMpChk0Gsyv5hvYzqS0g5jFpaNchEjGAn4t03Ltpgp/28fzY0ZjVm3ePf7Bts8wG7abLYpu3o0O4KO51mzTyfhOx8oZwPAV/VY6UWiW7Mqiz62Q0yVh8Rw38wlICjc+oHBCo8loiCA2khPWbxGf8KlIANvGK9Qk+CuvMnO0grjWMPktnufn1A4ofSQxlyYh4ZkSTEPZKaCHtZzIlGptNgl6qssZTgnl1WKdY5kawDVTi934n6KKnB+LaStifxfOfX1EJhw4AvvT4BsnGlX0mHHuPpxEWzcHeXNw4GZmjui0s3vrr6R7R/ExrClO1ThFY4zkoqEN/8RKfkZEYKYF381t6lVa6/EeFhkmPtN+sn6AUJ/KfRFLdA122aH+jiU5KnFMGJQiCgk/da5W04lRJbcbU1Rf106u6varzOyD8GcOzIdO+duqMhAOrtLC/khn1g01DrVh4QXKcg+D7NpcIuEAtILB24ED8JDP/+lCwh3LFN0fxDD/d4Me17xIoB7QI8MN9jXaQKL/4d7JDLPNdIm8rbTe6cbHI1OgivdrBxmuu26A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb71773c-350a-4a33-abc6-08df2b544e45
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 07:08:41.0327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1U9lLoTku+D4FexlootNzhVtIb+clpau+8ZFzCzaRc8qo+XS9im3DKqewd8uZk5ADgBcNgCRPAoJHZiupDcNXHv6yZx/uBOuctCyQ1cPB84=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5668
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 lowpriorityscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 phishscore=0 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2610020000 definitions=main-2610160028
X-Authority-Analysis: v=2.4 cv=O9SsLx9W c=1 sm=1 tr=0 ts=6ad1cd7f b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=EIcjfB9IiI4px24ztqRk:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=vggBfdFIAAAA:8
 a=WsHKUha7AAAA:8 a=7CQSdrXTAAAA:8 a=JfrnYn6hAAAA:8 a=pGLkceISAAAA:8
 a=Z4Rwk6OoAAAA:8 a=h_KbOXyVtjuNjm5C04gA:9 a=H4LAKuo8djmI0KOkngUh:22
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=1CNFftbPRP8L7MoqJWF3:22 a=HkZW87K1Qel5hWWM3VKY:22
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13537
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDAyOCBTYWx0ZWRfX5o6d4z/i0YqW
 EiZG0ktNDhVAS6HBdh6F3YUelAKqy4FWJsf78ZA1M1gA6xbx7lAViIcAt53K1VfzbXeNvIveIlm
 KoReMaV8o6IxDlwKzoKCtNyLXgjex1s2gOKrwDPRjf8Yju3Q792L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDAyOCBTYWx0ZWRfX/eIUwl1HlvcJ
 /jEKPQD+kqmcQtng+r9h3ufQOa+bmP/wUpqNUPJoHt/0rzzOKbimmLFxKyegu9mvuTswwIXIRdh
 v+JnMpFrn1tXEKLwr+WtwMFQEd+IDaojDAiXgDogLgft9S4VYMNombSftG3JPu0dzshCePM0N3h
 4GKaFirChmccsqR9KnCoE7ToQjcsFZ8Y1EvQE8UC+64nCt24iJQRwHSP/NHfLigKwmFcRpo92mk
 L4x4DcDekufywOsHXPA4A45PAYX7UmP/kFwNOnxhsxugE8WN1mAOOKsuVoVDUJuhhKh6EpNyPMU
 0D5C/FYWx7gvcGzUc0kpF3gxv9wI3Sg7V52ddRCe7rS4ERocde+ETXOEXn98FKaf0aiT3G0fywb
 NhYydr7B+15lBgYYUw4boUP5A1O08KU8d+9GS/uKAIge/J93X/mb0e7LiMqxpXLEHwVfIbUf//J
 sEpafjpw9H+N4hquuLPCI8BR9ro9VBp/QYbc5UvU=
X-Proofpoint-GUID: FxBHBVj9dZZcP1DwTr8I7xuoyU0LzNFx
X-Proofpoint-ORIG-GUID: FxBHBVj9dZZcP1DwTr8I7xuoyU0LzNFx

Hi,

Changes in this version address sashiko comments [17]. The major change
is the change in the exit path in __smp_cond_load_relaxed_timeout()
which allows us to simplify providing ACQUIRE semantics in
smp_cond_load_acquire_timeout():

  - patch-1, "asm-generic: barrier: Add smp_cond_load_relaxed_timeout()"
   - unify the exit path for the loop condition and timeout case
   - includes vdso/time64.h
   - document the timeout_ns == 0 case
   - use u64 for internal arithmetic

  - patch-3, "arm64/delay: move, fixup usecs_to_cycles()"
   - While moving USECS_TO_CYCLES() into the driver namespace also
     make it a static inline rpmh_usecs_to_cycles()

  - patch-6, "asm-generic: barrier: Add smp_cond_load_acquire_timeout()",
    - use the change in patch-1 to fixup, simplify the ACQUIRE path
    - thresh out the commit message a bit more

  - patch 14,15,16 "barrier: add tests for smp_cond_load_*_timeout()"
    - enclose the calls to smp_cond_load_{relaxed,acquire}_timeout()
      in preempt_disable(), preempt_enable().
    - WFET makes it difficult to use a synthetic timer. So skip
      timeout tests on configurations with WFET.

Haris Okaovic tested v15 [18] "Tested again on AWS Graviton3/4/5
(ARM Neoverse V1/V2/V3) with haltpoll changes atop latest master
8ab1afb2e: still seeing average 6% improvement across various workloads
(mysql, postgresql, cassandra, memcached) in latency sensitive
configuration.  The new unit tests all pass on both metal and virt
variants of the same machines. -- Haris"

The core kernel often uses smp_cond_load_{relaxed,acquire}() to spin
on condition variables with architectural primitives used to avoid
hammering the relevant cachelines.

(This primitive can vary greatly across architectures: on x86 it's a
cpu_relax() to slow down the pipeline. On arm64, this is a __cmpwait()
which waits for a cacheline to change state in a time limited fashion.)

Regardless of architectural details, typical smp_cond_load*() usage
does not allow for termination until the condition change occurs.

Beyond the core kernel, there are cases where it is useful to additionally
terminate on a timeout. Two cases:

  - cpuidle poll_idle(): wait for need-resched until the cpuidle polling
    duration expires.

  - rqspinlock: nested qspinlock acquisition that terminates on timeout
    or deadlock.

Accordingly add two interfaces (with their generic and arm64 specific
implementations):

   smp_cond_load_relaxed_timeout(ptr, cond_expr, time_expr, timeout)
   smp_cond_load_acquire_timeout(ptr, cond_expr, time_expr, timeout)

Also add tif_need_resched_relaxed_wait() which wraps the polling
pattern and its scheduler specific details in poll_idle().
In addition add atomic_cond_read_*_timeout(),
atomic64_cond_read_*_timeout(), and atomic_long wrappers.

Structurally, both the smp_cond_load_*_timeout() interfaces are similar
to smp_cond_load*(), with the addition of a rate-limited time-check.

Usage
==

These interfaces drop straight-forwardly into the rqspinlock logic
since qspinlock already uses smp_cond_load*(), and the time-check
extension can now be used for timeout and deadlock handling.

Using tif_need_resched_relaxed_wait() in poll_idle() removes any
architectural details allowing arm64 to straight-forwardly support
that path.
(However, for efficiency reasons cpuidle/poll_state.c continues to
depend on ARCH_HAS_CPU_RELAX since that is defined on architectures
with an optimized architectural primitive.)


Performance
==

Apart from simplifications due to this change, supporting polling in
cpuidle on arm64 helps improve wakeup latency (needs a few cpuidle/acpi
patches):


  # perf stat -r 5 --cpu 4,5 -e task-clock,cycles,instructions,sched:sched_wake_idle_without_ipi \
  perf bench sched pipe -l 1000000 -c 4

  # No haltpoll (and, no TIF_POLLING_NRFLAG):

  Performance counter stats for 'CPU(s) 4,5' (5 runs):

         25,229.57 msec task-clock                       #    2.000 CPUs utilized               ( +-  7.75% )
    45,821,250,284      cycles                           #    1.816 GHz                         ( +- 10.07% )
    26,557,496,665      instructions                     #    0.58  insn per cycle              ( +-  0.21% )
                 0      sched:sched_wake_idle_without_ipi #    0.000 /sec

       12.615 +- 0.977 seconds time elapsed  ( +-  7.75% )


  # Haltpoll:

  Performance counter stats for 'CPU(s) 4,5' (5 runs):

         15,131.58 msec task-clock                       #    2.000 CPUs utilized               ( +- 10.00% )
    34,158,188,839      cycles                           #    2.257 GHz                         ( +-  6.91% )
    20,824,950,916      instructions                     #    0.61  insn per cycle              ( +-  0.09% )
         1,983,822      sched:sched_wake_idle_without_ipi #  131.105 K/sec                       ( +-  0.78% )

        7.566 +- 0.756 seconds time elapsed  ( +- 10.00% )

  We get improved latency because we don't switch in and out of a
  deeper sleep state or from the hypervisor. This also causes us to
  execute ~20% fewer instructions.


Changelog:

  v15 [17] (as listed above): 
   - patch-1, "asm-generic: barrier: Add smp_cond_load_relaxed_timeout()"
    - unify the exit path for the loop condition and timeout case
    - includes vdso/time64.h
    - document the timeout_ns == 0 case
    - use u64 for internal arithmetic
  
   - patch-3, "arm64/delay: move, fixup usecs_to_cycles()"
    - While moving USECS_TO_CYCLES() into the driver namespace also
      make it a static inline rpmh_usecs_to_cycles()
  
   - patch-6, "asm-generic: barrier: Add smp_cond_load_acquire_timeout()",
     - use the change in patch-1 to fixup, simplify the ACQUIRE path
     - thresh out the commit message a bit more
  
   - patch 14,15,16 "barrier: add tests for smp_cond_load_*_timeout()"
     - enclose the calls to smp_cond_load_{relaxed,acquire}_timeout()
       in preempt_disable(), preempt_enable().
     - WFET makes it difficult to use a synthetic timer. So skip
       timeout tests on configurations with WFET.


  v14 [16]:
    - patch-1, "asm-generic: barrier: Add smp_cond_load_relaxed_timeout()"
     - deferred time-check is now limited to a single usec.

     - smp_cond_load_relaxed_timeout() now enforces that the timeout_ns value
       does fit in s64.

     - SMP_TIMEOUT_POLL_COUNT is explicitly defined to 1 if the
       architecture provides a waiting implementation of cpu_poll_relax()
       (defines CPU_POLL_RELAX_WAITS).

    - patch-3, "arm64/delay: move, fixup usecs_to_cycles()"
      - convert the 32-bit arithmetic to use mul_u64_u64_shr() to avoid
        truncating large delay values.

      - make usecs_to_cycles(), nsecs_to_cycles() static inlines.

    - patch-6, "asm-generic: barrier: Add smp_cond_load_acquire_timeout()"
      - provide full acquire semantics (via smp_load_acquire()) in the
        failure path.

    - patch-16, "barrier: timeout validity checks for smp_cond_load_acquire_timeout()"
      - add some tests for clocks that can fail (rqspinlock like
       semantics)

  v13 [15]:
    - rename kconfig entry for the barrier kunit test to follow
      the kunit style guide
      (s/BARRIER_TIMEOUT_TEST/BARRIER_TIMEOUT_KUNIT_TEST)

    - make the kunit test be visible only if CONFIG_KUNIT_ALL_TESTS
      is not enabled.

    Both comments from Julian Braha.

  v12 [14]:
    - smp_cond_load_acquire_timeout() now only has acquire semantics in
      the success (non-timeout) case.

    - arm64 now does not define ARCH_HAS_CPU_RELAX as without also
      defining TIF_POLLING_NRFLAG, in some cases we end up with a
      degenerate version of poll_idle().

    - kunit: removed the test case for timeout=-1 (not supported)
      Also add test cases for timeout=0, timeout=1.

    (All of these address review comments from sashiko/bpf-bot.)

  v11 [13]:
    - addressed some review comments from sashiko (see commit notes)
      - The one notable change is to the implementation of
        smp_cond_load_acquire_timeout() where there was a missed
        control dependency in the timeout case.
      All the others are minor.
    - fixed a low probability race in the kunit test added in v11.
    - added a bunch of kunit tests validating the implementation's
      use of the clock.

  v10 [10]:
   - add a comment mentioning that smp_cond_load_relaxed_timeout() might
     be using architectural primitives that don't support MMIO.
     (David Laight, Catalin Marinas)
   - added a kunit test for smp_cond_load_relaxed_timeout() (Andrew
     Morton.)

  v9 [9]:
   - s/@cond/@cond_expr/ (Randy Dunlap)
   - Clarify that SMP_TIMEOUT_POLL_COUNT is only around memory
     addresses. (David Laight)
   - Add the missing config ARCH_HAS_CPU_RELAX in arch/arm64/Kconfig.
     (Catalin Marinas).
   - Switch to arch_counter_get_cntvct_stable() (via __delay_cycles())
     in the cmpwait path instead of using arch_timer_read_counter().
     (Catalin Marinas)

  v8 [0]:
   - Defer evaluation of @time_expr_ns to when we hit the slowpath.
      (comment from Alexei Starovoitov).

   - Mention that cpu_poll_relax() is better than raw CPU polling
     only where ARCH_HAS_CPU_RELAX is defined.
     - also define ARCH_HAS_CPU_RELAX for arm64.
      (Came out of a discussion with Will Deacon.)

   - Split out WFET and WFE handling. I was doing both of these
     in a common handler.
     (From Will Deacon and in an earlier revision by Catalin Marinas.)

   - Add mentions of atomic_cond_read_{relaxed,acquire}(),
     atomic_cond_read_{relaxed,acquire}_timeout() in
     Documentation/atomic_t.txt.

   - Use the BIT() macro to do the checking in tif_bitset_relaxed_wait().

   - Cleanup unnecessary assignments, casts etc in poll_idle().
     (From Rafael Wysocki.)

   - Fixup warnings from kernel build robot


  v7 [1]:
   - change the interface to separately provide the timeout. This is
     useful for supporting WFET and similar primitives which can do
     timed waiting (suggested by Arnd Bergmann).

   - Adapting rqspinlock code to this changed interface also
     necessitated allowing time_expr to fail.
   - rqspinlock changes to adapt to the new smp_cond_load_acquire_timeout().

   - add WFET support (suggested by Arnd Bergmann).
   - add support for atomic-long wrappers.
   - add a new scheduler interface tif_need_resched_relaxed_wait() which
     encapsulates the polling logic used by poll_idle().
     - interface suggested by (Rafael J. Wysocki).


  v6 [2]:
   - fixup missing timeout parameters in atomic64_cond_read_*_timeout()
   - remove a race between setting of TIF_NEED_RESCHED and the call to
     smp_cond_load_relaxed_timeout(). This would mean that dev->poll_time_limit
     would be set even if we hadn't spent any time waiting.
     (The original check compared against local_clock(), which would have been
     fine, but I was instead using a cheaper check against _TIF_NEED_RESCHED.)
   (Both from meta-CI bot)


  v5 [3]:
   - use cpu_poll_relax() instead of cpu_relax().
   - instead of defining an arm64 specific
     smp_cond_load_relaxed_timeout(), just define the appropriate
     cpu_poll_relax().
   - re-read the target pointer when we exit due to the time-check.
   - s/SMP_TIMEOUT_SPIN_COUNT/SMP_TIMEOUT_POLL_COUNT/
   (Suggested by Will Deacon)

   - add atomic_cond_read_*_timeout() and atomic64_cond_read_*_timeout()
     interfaces.
   - rqspinlock: use atomic_cond_read_acquire_timeout().
   - cpuidle: use smp_cond_load_relaxed_tiemout() for polling.
   (Suggested by Catalin Marinas)

   - rqspinlock: define SMP_TIMEOUT_POLL_COUNT to be 16k for non arm64


  v4 [4]:
    - naming change 's/timewait/timeout/'
    - resilient spinlocks: get rid of res_smp_cond_load_acquire_waiting()
      and fixup use of RES_CHECK_TIMEOUT().
    (Both suggested by Catalin Marinas)

  v3 [5]:
    - further interface simplifications (suggested by Catalin Marinas)

  v2 [6]:
    - simplified the interface (suggested by Catalin Marinas)
       - get rid of wait_policy, and a multitude of constants
       - adds a slack parameter
      This helped remove a fair amount of duplicated code duplication and in
      hindsight unnecessary constants.

  v1 [7]:
     - add wait_policy (coarse and fine)
     - derive spin-count etc at runtime instead of using arbitrary
       constants.

Haris Okanovic tested v4 of this series with poll_idle()/haltpoll patches. [8]

Comments appreciated!

Thanks
Ankur

 [0] https://lore.kernel.org/lkml/20251215044919.460086-1-ankur.a.arora@oracle.com/
 [1] https://lore.kernel.org/lkml/20251028053136.692462-1-ankur.a.arora@oracle.com/
 [2] https://lore.kernel.org/lkml/20250911034655.3916002-1-ankur.a.arora@oracle.com/
 [3] https://lore.kernel.org/lkml/20250911034655.3916002-1-ankur.a.arora@oracle.com/
 [4] https://lore.kernel.org/lkml/20250829080735.3598416-1-ankur.a.arora@oracle.com/
 [5] https://lore.kernel.org/lkml/20250627044805.945491-1-ankur.a.arora@oracle.com/
 [6] https://lore.kernel.org/lkml/20250502085223.1316925-1-ankur.a.arora@oracle.com/
 [7] https://lore.kernel.org/lkml/20250203214911.898276-1-ankur.a.arora@oracle.com/
 [8] https://lore.kernel.org/lkml/2cecbf7fb23ee83a4ce027e1be3f46f97efd585c.camel@amazon.com/
 [9] https://lore.kernel.org/lkml/20260209023153.2661784-1-ankur.a.arora@oracle.com/
 [10] https://lore.kernel.org/lkml/20260316013651.3225328-1-ankur.a.arora@oracle.com/
 [11] https://lore.kernel.org/lkml/20230809134837.GM212435@hirez.programming.kicks-ass.net/
 [12] https://lore.kernel.org/lkml/c6f3c8d3f1f2e89a9dc7ae22482973b5a51b08cb.camel@amazon.com/
 [13] https://lore.kernel.org/all/20260408122538.3610871-1-ankur.a.arora@oracle.com/#r
 [14] https://lore.kernel.org/all/20260608080440.127491-1-ankur.a.arora@oracle.com/
 [15] https://lore.kernel.org/all/20260702013334.140905-1-ankur.a.arora@oracle.com/
 [16] https://lore.kernel.org/all/20260714073041.40250-1-ankur.a.arora@oracle.com/
 [17] https://lore.kernel.org/all/20260831202251.305046-1-ankur.a.arora@oracle.com/
 [18] https://lore.kernel.org/all/178908146776.2725577.2613699832033292946.b4-review@b4/

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: bpf@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-pm@vger.kernel.org


Ankur Arora (16):
  asm-generic: barrier: Add smp_cond_load_relaxed_timeout()
  arm64: barrier: Support smp_cond_load_relaxed_timeout()
  arm64/delay: move, fixup usecs_to_cycles()
  arm64: support WFET in smp_cond_load_relaxed_timeout()
  arm64: rqspinlock: Remove private copy of
    smp_cond_load_acquire_timewait()
  asm-generic: barrier: Add smp_cond_load_acquire_timeout()
  atomic: Add atomic_cond_read_*_timeout()
  locking/atomic: scripts: build atomic_long_cond_read_*_timeout()
  bpf/rqspinlock: switch check_timeout() to a clock interface
  bpf/rqspinlock: Use smp_cond_load_acquire_timeout()
  sched: add need-resched timed wait interface
  cpuidle/poll_state: Wait for need-resched via
    tif_need_resched_relaxed_wait()
  arm64/delay: enable testing smp_cond_load_relaxed_timeout()
  barrier: add tests for smp_cond_load_*_timeout()
  barrier: timeout validity checks for smp_cond_load_relaxed_timeout()
  barrier: timeout validity checks for smp_cond_load_acquire_timeout()

 Documentation/atomic_t.txt           |  14 +-
 arch/arm64/include/asm/barrier.h     |  24 +++
 arch/arm64/include/asm/cmpxchg.h     |  62 ++++--
 arch/arm64/include/asm/delay-const.h |  35 ++++
 arch/arm64/include/asm/rqspinlock.h  |  85 --------
 arch/arm64/lib/delay.c               |  19 +-
 drivers/clocksource/arm_arch_timer.c |   2 +
 drivers/cpuidle/poll_state.c         |  21 +-
 drivers/soc/qcom/rpmh-rsc.c          |  12 +-
 include/asm-generic/barrier.h        | 157 ++++++++++++++
 include/linux/atomic.h               |  10 +
 include/linux/atomic/atomic-long.h   |  18 +-
 include/linux/sched/idle.h           |  29 +++
 kernel/bpf/rqspinlock.c              |  78 ++++---
 lib/Kconfig.debug                    |  10 +
 lib/tests/Makefile                   |   1 +
 lib/tests/barrier-timeout-test.c     | 297 +++++++++++++++++++++++++++
 scripts/atomic/gen-atomic-long.sh    |  16 +-
 18 files changed, 710 insertions(+), 180 deletions(-)
 create mode 100644 arch/arm64/include/asm/delay-const.h
 create mode 100644 lib/tests/barrier-timeout-test.c

-- 
2.43.7

