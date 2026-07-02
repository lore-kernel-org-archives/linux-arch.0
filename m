Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CCD29992A;
	Thu,  2 Jul 2026 01:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782956110; cv=fail; b=l/9BFb16h5S1K1G/a0dbhnpo0F1Uxy9VKv37yvAdLnyblkWxzJ7wB+hKpIkOoyVeG3eRvwBukFBcpJ7MLdyNX84NWcEGAlVqrgR070XgZKJsgKHH7OKb+R2+XWN/pdILO9qWAcGaH7nqKeSRSlNMP1vEWpYcv0FNr9Yo7oeNqjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782956110; c=relaxed/simple;
	bh=OGgZFOJnEFXL2DxEhblWZm+ihjvmCsHzXw+FF5ZdFAE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eUoRGFgT0ZSpD4RURZKVBdUPv61054eFsINpBln0bqFwDO7GursrwED4e1kLRSwjMfwmMiNF4vgwPv8UhsFbkre1rKAYuyh/5rkz+brNcJBayb6jMZsvD5OpqeC22eYylgb/8Ru4ySY/BqmDMkzVZJJZlZf9kU3aS3h+qw7ltvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hM7zI2O2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lKNZJapR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hM7zI2O2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lKNZJapR"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661EHFFB2814376;
	Thu, 2 Jul 2026 01:34:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=OeHj89SpsumH2DaeSYcLq/KfrJphpYP5mF6B1d1qsLk=; b=
	hM7zI2O2aQnazsPovc456QXzAn56y4fO7sBrJUV4GM1g/PeYskP3zT+JnsnyC0VE
	jE72cRxDHXITrrrw1dTaPXSVOV1A2cciVdi/+rDakbq0T2o0nqmI2Fx0pxd9fyof
	MfTK4qAM9PtZW6oPcMlnqeHayIJL5olhQmumpf29YQiemzCMpIUjBEFciwQUiwpx
	Wy5mwDX/ZUJnfFpKwfvamSKDjlaH6Hgw07A9egH0TUojPLggEK2G1WmnB+04ATR7
	DeVWgjtzsEooLCcRYCEc0tPkfLcVwhjPQV0ZXnPsT88d9e4vCST88ASpVjn24xmN
	atn8nxeQ6dFGQv6ycCU6SA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4f26n1780f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Jul 2026 01:34:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 6621On6h032478;
	Thu, 2 Jul 2026 01:34:37 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013056.outbound.protection.outlook.com [40.107.201.56])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4f24ysf1ka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Jul 2026 01:34:37 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JJLJzT2ehW7XqH6ZSCygUILGuhdaV0a1pQu6FTQP5PE6WOCj9vj8F+7FOO/VhJ/9sDU/38HATzPh12RjvFG0tRwh7U6qsju/UL8q2M/iFfQ68J/bDO/52Z9I61YL0WwiGpYykl1ud2u99KdYUTZKl+jp2xqkzNJ7ZsDKenv96f+r8tWj3KgpeROd0CsUt5rX0Jps+BCvTAlDtitirW4DWSYgeUCTbycOo74WAaKuVeV0LWFjIhPojorsxjjvEcS+TU6R0dta0JXM06ik2W+NGJWytddYRlBOS94U7MiNUKRt14y755Vjbsma57mrFshOrhJJqMCpu8fH5eRdc8i3tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OeHj89SpsumH2DaeSYcLq/KfrJphpYP5mF6B1d1qsLk=;
 b=qEQ+qDmhOEfQaYgErYbi7AKX1521V2K0pjf+peSl8SgXqsI0pgajVVsQw12jBBQRFgA0bxXcPkwHgWhGNSYqyDBdFmt7oWR5hctlNBqdi06lsD2vtf3P58tsp/dONrLQNGb++WxoIFx0ZLzMLLOCMpmPuQRKVM2Oa8Kh26bLTswyz5994AlOb9Zo5bzd1Xi3QYSICkqmXU9eGB1iSW+2vc4pQzexaa1DydEv/fYcGHsLX51M0P+Tmdt/iadZFeBXUQBxq5pMd0kcXNnj43sFcbr2V0rkNp1KZga5EqV51PISyrGXQzGpotFVhu4ciT7y1pCcUygvhhQJyF8iXB937w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OeHj89SpsumH2DaeSYcLq/KfrJphpYP5mF6B1d1qsLk=;
 b=lKNZJapRYNfOX0YDMuEYhf3Y5N/C3z635gJrrX15fUT/HtrBfdaVzkx4R0YQph264ogEofFd0IIEWaIOJ7gN7HoTEZodjssjznWOcz0WHPXj9fBxyPgi6452WbmCnSs7wPYr9IGj+tJyuwxq0YJiFT1Rht2hT65yfGyFIQ025Ww=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SA2PR10MB4795.namprd10.prod.outlook.com (2603:10b6:806:11d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 2 Jul
 2026 01:34:34 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 01:34:33 +0000
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
Subject: [PATCH v13 10/15] bpf/rqspinlock: Use smp_cond_load_acquire_timeout()
Date: Wed,  1 Jul 2026 18:33:29 -0700
Message-Id: <20260702013334.140905-11-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260702013334.140905-1-ankur.a.arora@oracle.com>
References: <20260702013334.140905-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0009.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::21) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SA2PR10MB4795:EE_
X-MS-Office365-Filtering-Correlation-Id: d0ade672-66ff-4a36-2291-08ded7da11c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|23010399003|1800799024|18002099003|22082099003|5023799004|56012099006|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	Iy6PjcBzx9uz2g6hSNx0s7wmM0x4vK514CxUEE7X5wpJmJQXA0decW7FasANachxjnZC3/4xWrfP/7PWyXk57scffrCymS54ymhJxW+zBtygTd2AVT6oZw/HmjAU7UPEhoAMdoUxnenRa2kicRp8PcaQ2gfAb8SoF+F3a7SWTy3D4ioMi+8bum/i5MRaUSS6oPdckdAEnWRdtggA857FEp/78QlHqbvHgl3y/oT9PWlLnWHxotfkuzBiFOLrYgf+JZnqKpBlXg9yxL+MMWdhZaJWIt4jKafuwU50BMOHSj9aZpAyy8T5BOYHyNsouSFOHW3BtpBY8RnhkFucNVKQbMqmP6NmgdH1HtL8n/DhgcV7H1jD0no4xwopP2zCbYPRLygLRMxgONp4bZXnnGPyLNWVfTlpHrtynOKbZaywt7Dzan+SVzt+dfghsLv4NloeirrVzuov7b/hoWdG9W9gTmBggo7Sq5Lc057RlTF0GTnfErTsaoAqvDgMixdVeYkAAz62h+C5kyzMu0rPhfVxCigZw0pLmR/vkV89vbWQeokqUJquPGmF9feADcr3OwKYtO+2F/v1gptwgKe/KK0HpUTeJ2Mk+Cq5s+TGpzvas8Oy1NIKmDb/5vfLOfalQwit3BeGWgVeQnpgKkoUZkh8PxUGobgFPhxGpqOVN9Kk2WQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(5023799004)(56012099006)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M9u30TVsWs6Da0AYWOqah3WXQk5F9wNOoOMVbTavQwjLX2WZIjHFLahnPA9d?=
 =?us-ascii?Q?ScDku631AS2jxProCAaB1EG/15LsOY61+AAcUdAzpOS9F6Xj8Ef/PmxT6N8F?=
 =?us-ascii?Q?FkjDe9DWTmvO3gD6jwEtgK4fMAVc5COECxrYD4ReEb3VkOwCjxuc45b+Y5vC?=
 =?us-ascii?Q?f1IcoZu0zZTG8adGXCJfC8LZYSyXDOoePzPPU+qFxxsNpI2sgviMvuDdHido?=
 =?us-ascii?Q?py6niZd8mU5WMNQjhTcBC9RBCK6M/TGQ/CzCbO/M+eTiRu6T8oZkrzX+X30c?=
 =?us-ascii?Q?/J0Szvx023Sx702AOtcydApxFMXBNSzEeO77+KZUldAG3fdT2WmAIbBqIdvy?=
 =?us-ascii?Q?hDPrMZiYuewDm0eVUEZRhmdRDIgXoaI1rTvWvF08wcxtU9UG5dBCI9SSo4mS?=
 =?us-ascii?Q?kwH3YeRzSgX71SvPlFdkMaL6WoyQ2Hxokl2RC+IXk0D5VoC4RrWMkZbIhLLt?=
 =?us-ascii?Q?ayNCxyThriAQvtQfMcM+FjvcfJQFygkErtyJhwiIGNHEucQ9uy+f3EMT+CCS?=
 =?us-ascii?Q?5VG50OkEi3Sca78I0Iv13IaDmNLD4ej4sOVDYcqM9258F9DrTURWST1BJJ17?=
 =?us-ascii?Q?TDVgz8iOKdb8ilpZR5bxntfUgYRhqBPt58FvnvILlbcNeDQBKydF6xayG8/H?=
 =?us-ascii?Q?HWwlVggcubrLxvHw9P7QK3NVbqTEUGKcOxGCY9KNX+It3A1mFXLH78CxM2Rs?=
 =?us-ascii?Q?E4chqFo0DvOtmMOavLDrp8+FgxGBi7Iv0ZYCJtxl64wsQlAuVOJJbXIKBu6d?=
 =?us-ascii?Q?rCZews57NudjJ8+3Vjf2KdchgYY9iGAY1Y2bCcEGRk3TgEoSaU5iRRl4vlTH?=
 =?us-ascii?Q?tfwD2qN97BuY1C87XjYvgwSyPMeTd03ENlUaCIe4TAsJEBupAHWZ0fcd6mRU?=
 =?us-ascii?Q?F6pIQy4czoTE/BGLzf7cibfw/MxJegj2h436k9uV6CwoUQd4QLzb2IE6n+w9?=
 =?us-ascii?Q?HeWrvz0gXQyxtNvFz9w/QqeETHaZBsjcNMmzIahUrfVy8xBdEmcWoVa5X1Ph?=
 =?us-ascii?Q?GLwBffCECZSGuq64Pw/h9siMKWi073r5FdwRHgVRqI7spQlGF/Q2gTRcOOOJ?=
 =?us-ascii?Q?p3H6yiMYWYbgoZxMlkO8MpdM2SNTkHcAsaP/F89NdmGxSnheKfBmMUvGANQp?=
 =?us-ascii?Q?L60FD3ugq1z8wC9Tlea0qDdlJhgvJED1Z+h9G9znAwsxqrMIMIjA15pf25Lb?=
 =?us-ascii?Q?KoO6GJu1WdrQqzWOoLqXBbxK+3lImruSOT5rZG1fT8NPi/VlgoKR8CB0+Z1H?=
 =?us-ascii?Q?ttly9PY/7THN0wq3TzPOmjvtNDooclJRPAk6jR5r3YKlRwQqEYLXLae9o5y0?=
 =?us-ascii?Q?FCc5rQ2x59tiZogrB0KxkwzOeV4vNixWpjvOUtRa5j7hQm/RHeNVKdUyxBf7?=
 =?us-ascii?Q?D1FP7Y8xHh46nI4YOOA245aTB+X18rKZQvEVuu0/XQLqrzeJEWp++s2D+SFi?=
 =?us-ascii?Q?grb2zgZVWMoOR+ANvoPwC/5BdG9g2KDk/dA+2zv4n+r+kgsMSLKeLkxRKmxN?=
 =?us-ascii?Q?3En6dRzlaeos2LMJ81o6iWO7FpWDqFQm8992i0ZnYZoI0hQD2e6Qq6sQ0Ljm?=
 =?us-ascii?Q?yDHysGF1OIv3OS2+gofi8NqpQDAt1EiJ0nrGo9km60tUyBda+ZfM39nqbE6Z?=
 =?us-ascii?Q?2uLyUsh8g1lbr/cCTZYaHxo+Sb+m1QmZEbWxNIXRa9BGH6aUqWJbkxJ9yWr1?=
 =?us-ascii?Q?u4mcZ8AKczsAxVF0SqNabk8Pcf504130Fyq3JoJCtr6G4UPeRg+HsnGW4kGF?=
 =?us-ascii?Q?qfOQfu+dG/F/U3lxpfxwavVDMpbP270=3D?=
X-Exchange-RoutingPolicyChecked:
	ZH/1sBE1IH7KpwYBOC7TbQ3hgPdoulmvpo64ZJWWYLz4LYrYtOanCWPs4jJ3ZjUZM1+M0lisXFGLO/V4nGl/8fk/vbp0Dr8ftzTRQSZwTqOFSa/jbKR5kC7VSIAhkrvhGRTlCdgTnLBYpDRchuP/HL7EtuxBBcTv7RGh6hYw4cewqAWD9fOR1mqs0pk3ZsDGaAmNRPzXejaOoYTJlRnDd9OY1CI5k4YV1GlVbzZ4hc8mwixK3a8IxB9g444x9Yo0GYU5Mua10tSUI0qcKKhEeiFmDEKOUDPRGiS9HF/jbvdeBAVxLjLY83eeOS7E/JWc+iYo6jBd89Ia7I6JfjX1eA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IvVVNWZsvkONNKXt5pyrUxoOegsgqOQ2dGAN4SO63H2OjXFn6LXV45w2pur+JSxzKKY9fDGtuA536xmuyc/45kvty5AsbJef73dVrs80JoVhcc2w28zI25ivDfwgWqYn7AWCyfskwBoIRKUfl1rnpSWPXhalQQrRs5fyGMdU456tCE+pFnQgs4Iz2wp3bI+UfLja2bQpFKyL1Tz+vChSYxQUK+jvEoK1GSN5XHO8hagq2TsNErzd3tuSJX201kAro4PAurzOnp/IR6JkJehaAgj1FNc42vIC3AXLMOM0jWb+GPIhs/FDrGayic9Y8bGtxqldxg3grEQ0KaMhcyrqIg6BpOGBIEcsbev5Ym6aXV1bsABF2DT8ts/l3/Qg0ucqEmglPb6bTfBO6E7HR7P5F9mCp4IpIY/tm7RQAMicGpwHislUf2JqnM2NHshbJWACuN+tBFbOcAEr+yWYl/bt1JLqgv2T1v3LdfD85nnIrHC+dzZcaWh4ZCx7k4lK/1g0VUVNoOy6N/Rn7NXMiAfEfXy/6lZbAn9N6asAKCUbrv7hRyvDKYejakXMxGU0rlctZITpUEWq2A36Tn8d2Nd+i9iVSgzondz5C6JF5p51kAI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0ade672-66ff-4a36-2291-08ded7da11c8
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 01:34:33.5399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RpWaS9OIir8/D0S9vm9K5M/fpO18L7nQQ5ZlPLqdH2BkGh2K57bt6Q8p+to4RPY6InPzjW0MUwATGpHSycPlXyEt/yyMjjLFylRrJTXqbuI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4795
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 adultscore=0 malwarescore=0 mlxlogscore=999 lowpriorityscore=0
 spamscore=0 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2607020011
X-Proofpoint-GUID: uM05C1Wpo8v9p0SathwjAqJbCnKn3VmM
X-Authority-Analysis: v=2.4 cv=FvI1OWrq c=1 sm=1 tr=0 ts=6a45c02e b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8
 a=Ru_WXoCZngTtvYUXGSoA:9 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22
 cc=ntf awl=host:12312
X-Proofpoint-ORIG-GUID: uM05C1Wpo8v9p0SathwjAqJbCnKn3VmM
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDAxMiBTYWx0ZWRfX40zGmTabGw5Z
 EOqMsVPWC/N4IDlj550FaSa7HU8aHMDIHk6toZ3QjLl3MKmZ5grqNWY305LvJ3U0S8EGX4uEoLr
 TtcFgAMfVh5HdTpK9QxIlAJKQWRZoG1Pm7wjTFzTf61//4r2YrsI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDAxMiBTYWx0ZWRfXxWIBD1nBp2I+
 2L8vCFaaPUYnPfhXAnobyBNVqMHuoLeKt5OPv5MgA9f8Qy9Bdvy6bl5CoV2n2+Xj+SEF0/lqkbG
 Ki/fLdHwdweUV7HIoqTA6DFYs1IAyvk/bWIZVz9BP9b88suN2QcX2UnvoEhnn8CxMFVs7vGhjBk
 648OkK3DvNaYFjrvxFWHu8uJpJJnu2MBh9B7tF5vkNT3S89i2K/ldIi68HEnf4wMwUKEY2a/dJr
 PbC5/3ZqDkq5zUAPHTnTb9+6iaUtqk5aQt1Eff+pdROcGErFciiqLng2F5Jv/gslE2Q491VBuJt
 JDZctbfTBwFym8eTzp52JQUZkm+j7eLWX/abYJ8O897gaEXCRyyTiCVTeQOHbAhCvEoq5rFBgSS
 2mVqBBdqXVXk7FwXlPLrH+LoEB8gUbPVn9APWA6mHkXPUsyGBibKH81/6TRr8JZeoormHMxhwD0
 VitltkNpAKNiTWzGfrTiMxqrKSpRdmKa+OsKXUzA=

Switch out the conditional load interfaces used by rqspinlock
to smp_cond_read_acquire_timeout() and its wrapper,
atomic_cond_read_acquire_timeout().

Both these handle the timeout and amortize as needed, so use the
non-amortized RES_CHECK_TIMEOUT.

RES_CHECK_TIMEOUT does double duty here -- presenting the current
clock value, the timeout/deadlock error from clock_deadlock() to
the cond-load and, returning the error value via ret.

For correctness, we need to ensure that the error case of the
cond-load interface always agrees with that in clock_deadlock().

For the most part, this is fine because there's no independent clock,
or double reads from the clock in cond-load -- either of which could
lead to its internal state going out of sync from that of
clock_deadlock().

There is, however, an edge case where clock_deadlock() checks for:

        if (time > ts->timeout_end)
                return -ETIMEDOUT;

while smp_cond_load_acquire_timeout() checks for:

        __time_now = (time_expr_ns);
        if (__time_now <= 0 || __time_now >= __time_end) {
                VAL = READ_ONCE(*__PTR);
                break;
        }

This runs into a problem when (__time_now == __time_end) since
clock_deadlock() does not treat it as a timeout condition but
the second clause in the conditional above does.
So, add an equality check in clock_deadlock().

Finally, redefine SMP_TIMEOUT_POLL_COUNT to be 16k to be similar to
the spin-count used in the amortized version. We only do this for
non-arm64 as that uses a waiting implementation.

Cc: bpf@vger.kernel.org
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 kernel/bpf/rqspinlock.c | 40 +++++++++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 17 deletions(-)

diff --git a/kernel/bpf/rqspinlock.c b/kernel/bpf/rqspinlock.c
index 0ec17ebb67c1..e5e27266b813 100644
--- a/kernel/bpf/rqspinlock.c
+++ b/kernel/bpf/rqspinlock.c
@@ -215,7 +215,7 @@ static noinline s64 clock_deadlock(rqspinlock_t *lock, u32 mask,
 	}
 
 	time = ktime_get_mono_fast_ns();
-	if (time > ts->timeout_end)
+	if (time >= ts->timeout_end)
 		return -ETIMEDOUT;
 
 	/*
@@ -235,11 +235,10 @@ static noinline s64 clock_deadlock(rqspinlock_t *lock, u32 mask,
 }
 
 /*
- * Do not amortize with spins when res_smp_cond_load_acquire is defined,
- * as the macro does internal amortization for us.
+ * Spin amortized version of RES_CHECK_TIMEOUT. Used when busy-waiting in
+ * atomic_try_cmpxchg().
  */
-#ifndef res_smp_cond_load_acquire
-#define RES_CHECK_TIMEOUT(ts, ret, mask)					\
+#define RES_CHECK_TIMEOUT_AMORTIZED(ts, ret, mask)				\
 	({									\
 		s64 __timeval_err = 0;						\
 		if (!(ts).spin++)						\
@@ -247,7 +246,7 @@ static noinline s64 clock_deadlock(rqspinlock_t *lock, u32 mask,
 		(ret) = __timeval_err < 0 ? __timeval_err : 0;			\
 		__timeval_err;							\
 	})
-#else
+
 #define RES_CHECK_TIMEOUT(ts, ret, mask)					\
 	({									\
 		s64 __timeval_err;						\
@@ -255,7 +254,6 @@ static noinline s64 clock_deadlock(rqspinlock_t *lock, u32 mask,
 		(ret) = __timeval_err < 0 ? __timeval_err : 0;			\
 		__timeval_err;							\
 	})
-#endif
 
 /*
  * Initialize the 'spin' member.
@@ -269,6 +267,17 @@ static noinline s64 clock_deadlock(rqspinlock_t *lock, u32 mask,
  */
 #define RES_RESET_TIMEOUT(ts, _duration) ({ (ts).timeout_end = 0; (ts).duration = _duration; })
 
+/*
+ * Limit how often we invoke clock_deadlock() while spin-waiting in
+ * smp_cond_load_acquire_timeout() or atomic_cond_read_acquire_timeout().
+ *
+ * We only override the default value not superceding ARM64's override.
+ */
+#ifndef CONFIG_ARM64
+#undef SMP_TIMEOUT_POLL_COUNT
+#define SMP_TIMEOUT_POLL_COUNT	(16*1024)
+#endif
+
 /*
  * Provide a test-and-set fallback for cases when queued spin lock support is
  * absent from the architecture.
@@ -296,7 +305,7 @@ int __lockfunc resilient_tas_spin_lock(rqspinlock_t *lock)
 	val = atomic_read(&lock->val);
 
 	if (val || !atomic_try_cmpxchg(&lock->val, &val, 1)) {
-		if (RES_CHECK_TIMEOUT(ts, ret, ~0u) < 0)
+		if (RES_CHECK_TIMEOUT_AMORTIZED(ts, ret, ~0u) < 0)
 			goto out;
 		cpu_relax();
 		goto retry;
@@ -319,12 +328,6 @@ EXPORT_SYMBOL_GPL(resilient_tas_spin_lock);
  */
 static DEFINE_PER_CPU_ALIGNED(struct qnode, rqnodes[_Q_MAX_NODES]);
 
-#ifndef res_smp_cond_load_acquire
-#define res_smp_cond_load_acquire(v, c) smp_cond_load_acquire(v, c)
-#endif
-
-#define res_atomic_cond_read_acquire(v, c) res_smp_cond_load_acquire(&(v)->counter, (c))
-
 /**
  * resilient_queued_spin_lock_slowpath - acquire the queued spinlock
  * @lock: Pointer to queued spinlock structure
@@ -421,7 +424,9 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 	 */
 	if (val & _Q_LOCKED_MASK) {
 		RES_RESET_TIMEOUT(ts, RES_DEF_TIMEOUT);
-		res_smp_cond_load_acquire(&lock->locked, !VAL || RES_CHECK_TIMEOUT(ts, ret, _Q_LOCKED_MASK) < 0);
+		smp_cond_load_acquire_timeout(&lock->locked, !VAL,
+					      RES_CHECK_TIMEOUT(ts, ret, _Q_LOCKED_MASK),
+					      ts.duration);
 	}
 
 	if (ret) {
@@ -582,8 +587,9 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 	 * us.
 	 */
 	RES_RESET_TIMEOUT(ts, RES_DEF_TIMEOUT * 2);
-	val = res_atomic_cond_read_acquire(&lock->val, !(VAL & _Q_LOCKED_PENDING_MASK) ||
-					   RES_CHECK_TIMEOUT(ts, ret, _Q_LOCKED_PENDING_MASK) < 0);
+	val = atomic_cond_read_acquire_timeout(&lock->val, !(VAL & _Q_LOCKED_PENDING_MASK),
+					       RES_CHECK_TIMEOUT(ts, ret, _Q_LOCKED_PENDING_MASK),
+					       ts.duration);
 
 	/* Disable queue destruction when we detect deadlocks. */
 	if (ret == -EDEADLK) {
-- 
2.43.7

