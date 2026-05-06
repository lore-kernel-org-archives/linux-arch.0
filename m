Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A003A9D9A;
	Wed,  6 May 2026 07:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778052705; cv=fail; b=MrB6iZZdDnJTBH4pgXdfdP8Scl5K3+kz74HZHSkRSNXUG4Z5jK4ctq/iC8Wbv0nVhfS8Wp4Bqxdtiolwha7syFkcED0ecnRMo4WI2FBJ8R4A3Gjr5+KHTpiIvmMDqU4xQon2uG0XOhV2Pn6H8d3kWHFM/1zfY0UYRyRnlbv3cDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778052705; c=relaxed/simple;
	bh=sEQfIIyW/gimBe7Lbq4+yKG5CIr3Cq+mst0IRqPwfC4=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=R4lFjlrUJwdMMKvW1yHj+/EoG/RmPVmwCqukwRYnR4AY1CdsElvEcWvvH+zGDUsXYZenE1UwsWblIQt5drlEwRC8mIjEGS1zG+/29ShzQkAP1e+xk1ectICZ+m9bRusRclWJFbwv1aqa/bx372gH8sQt8O+YyaYu9+W8MO3Syf4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gLJV/Q+N; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ogQNO8kZ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gLJV/Q+N";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ogQNO8kZ"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 645HGeKt3875344;
	Wed, 6 May 2026 07:30:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=EuOriAeP1p0PItdku8
	vf2P5ApSdUuusCcGtQuIiVZ64=; b=gLJV/Q+NYQpIHQbCSbEdaioSoCKE4r6xny
	Tffp/X+jjG7WybHrmmxBClRIOiOzKlHuMgbWY1uBLViFG4Alom9GGWRzKsCckfeF
	zH6TeC5Hd5fls9hzUqFbeBMKrE11dK97GvHQjhhFcDHV0iFkbrx96Jbt23D7/+QC
	hMphOIq1GeLbGXhwBOYpgDlzt3Uj8FtK01Gz9wiFc+KgY/pxWSMW8ZpLRjHALS1P
	xZmgyD4Gcng3SH/dV5E6dcYoQPlGeZxTVsIl7wW0u2BPvJEdzcmXDpZq4ZNJnNOs
	ly+ZBfLAORIsB6xb8YcDSpJnydQpVDm7mME1tqm4ikmOm7yh/f7g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dw9epxapc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 May 2026 07:30:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 6467LPK6018657;
	Wed, 6 May 2026 07:30:37 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011023.outbound.protection.outlook.com [52.101.52.23])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4dx576ru22-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 May 2026 07:30:36 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fsH0zule0dQ3aBQnoB+aJxDfGLeIJoUqz9iTi1XjeDoTOiKaF/TfVmQsn2fqOstS3uul7Edh//WRG/uCTGvT7eXdvaEJgD6t38qNYEtwVakv+qyhKrcPBZMtq4JbCLgwe43RehTyfBuZTR/v/wYGXW+aB945JQc8lOxTiV7P9MAyrvLT0CWXSoGFMCpO1bde+ugNUBB3aoNwkUDUyJMGVkxPDzLEbCmljBFmodaQmqjwNddA0wNEoQehCR3TN9Wd2oEoWC10ao4g2tZuoRh9ASYW1Dt3eMA2P1e1SpKg3WccBCWMQtMPaU6ItAmtQ900DUoVETQjHI9tHWO84GP0og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EuOriAeP1p0PItdku8vf2P5ApSdUuusCcGtQuIiVZ64=;
 b=ROvf+l1SnFp9UMkzgxVxCe4tDG+7O0YOWVvoIMWdjmz9o43h1KqBBvmMHLwO+Zn3I/8iM4s9V5QbZs1mYMpkX6yos0ocHLZAeUtJczFU6ItmQcw5t869o3pJUuX1Il33uOcsJ+5wtNaeERxooAYar9CD4rQh8RfI4oGS2UYCrYXNPcyimN1R8Cshoq/glegDjw8XgyWbIlnhPBqhSLDnkJ7juOGqu3Ht+2TchCYMf7m0NUglAnaK9Enu8R0nfXyc1BfBY7ItAKatQlhTQzgzlDzCnImPDNKmjw7bmuPPBJn5KtZVNeOfTJ9elLWMHtaAQTL8EUrV+gznfZQ67R7ilA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EuOriAeP1p0PItdku8vf2P5ApSdUuusCcGtQuIiVZ64=;
 b=ogQNO8kZxC3bsHV3m7QDb79hw111PuGwGdvjRqo85C2owsyMGQzssLw41Rqm0qwe6qPVckaoDWkHR7G4+BfOM6q8Gg3Pft2AWwfp2cZGCQKUQeiBeInYcGI6uClaAOSrNeQY0U+kcRHRuGXIbCICY/n0rmPHVnhZrRnC3MkinfE=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by BY5PR10MB4307.namprd10.prod.outlook.com (2603:10b6:a03:212::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.27; Wed, 6 May
 2026 07:30:31 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 07:30:31 +0000
References: <20260408122538.3610871-1-ankur.a.arora@oracle.com>
 <20260408122538.3610871-2-ankur.a.arora@oracle.com>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        bpf@vger.kernel.org, arnd@arndb.de, catalin.marinas@arm.com,
        will@kernel.org, peterz@infradead.org, akpm@linux-foundation.org,
        mark.rutland@arm.com, harisokn@amazon.com, cl@gentwo.org,
        ast@kernel.org, rafael@kernel.org, daniel.lezcano@linaro.org,
        memxor@gmail.com, zhenglifeng1@huawei.com, xueshuai@linux.alibaba.com,
        rdunlap@infradead.org, david.laight.linux@gmail.com,
        joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, ashok.bhat@arm.com
Subject: Re: [PATCH v11 01/14] asm-generic: barrier: Add
 smp_cond_load_relaxed_timeout()
In-reply-to: <20260408122538.3610871-2-ankur.a.arora@oracle.com>
Date: Wed, 06 May 2026 00:30:29 -0700
Message-ID: <874iklm1uy.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0257.namprd04.prod.outlook.com
 (2603:10b6:303:88::22) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|BY5PR10MB4307:EE_
X-MS-Office365-Filtering-Correlation-Id: 914042f9-43f9-41f1-6a83-08deab415a53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	zoX1YSA/S5NZ/T44zi8OXbUM75yTzf+Bkp03amfUW6UIXKobS4EMtjLw0cFKsBuz76zSyzRWJZCkOUAGZ8EEWUyuHNlnoAV5kqlPP3cW/Z9Rn2chccUV5V3sICcgd9FuoI6CsXqHTVJ+x6E06kySe2yO8sTsG39ynfqv4ZdgYBHA+/pbMdRFOSeB6FlcozoYB0FkQEuC9r2NqzE7Ii6MsbQD66UulPMN+E0tBTH2fyejOzg9X/tQ+icaE6vSgE4pe9h4Ab0mt9qsj61LizHnAQ/aExIS/LEH/QLYS0dgHITZKmehDEvH9N/5ShfxVWf+t4KYJIwApieESc/uK/YHxfO6WGsQqZUl16uwwSONglXICgP3ENydNIc3UCexPEeEX1aOpWuOwYPaH9cRNNCSq6P/yw9hXjU8qC+MvMmBbpIv2hVhesEYWf9A7rz2lrZ5LkzplUWAgPUcBbdDZbl/LBzc4dFW7Av+7D4Nu/oftJG7ZrIZqKNpYRWn7+gLYbsDTMYKvf3S3Lvb4BwAc5PKKddld0vQSmUYuMvOlsZnNNNiygw26FLqJihLB7OdISjSdOFWVwE9R/xGEOI/PcOam/rT3VMwiZxFojP1ocLZqRBETt8yLpURipMlUTSrFsFDfRT/BQgykO0qwOL9CDtlNsa0SZsZSLE4zfeIO72XGuskOFLhGLUYukPy95MAm00a
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YXKfyt9zS7DtKZTKkcz8/ZXI29TOkW//B1ZeoAMdTwPEaOV5y3UfE0Zrqi5b?=
 =?us-ascii?Q?p3JzE1w1nJfulXFMv5POEnny9yZXwSCUqEhpoK5gMu2Geu3v4TUe6Brh9YtC?=
 =?us-ascii?Q?2AF3XQRFr5Ph/erBWRBYzGhSjiZrKFyZwRbgPMpanj2t6FaDgfjDk5zPEaYp?=
 =?us-ascii?Q?0lER9gIATxlXrmgehKmdjwuhwsB8sTQKUEgzBXMDY4+Im2C7RoM55vvWAZtp?=
 =?us-ascii?Q?XJEdVdFkEaFUfMoGhUJTM+rs+8uVEcW+wDqYcQDmG7pvwBhZloH0Zj7Y5uOS?=
 =?us-ascii?Q?ehjFC3J3RDSbSYAnXUgLbc3FVx51Ib8BDuUnzCdPhE6ZCY3iXEdalHkevJod?=
 =?us-ascii?Q?W2dZ+Sv7DHFoFkYVsL0ymkFKxqFSoDIhidHlv7scWadsSVPeyUH1uRaLWjbl?=
 =?us-ascii?Q?77JxfPWbSy3wNRnkLtcRM6upN6IjQMaMAqfFXj7ChGB0+lLn6LkwWmgyug7Y?=
 =?us-ascii?Q?Ps8LRo+EQHwCROk6JM1Gd1E+wgmlYUKQL+L5IJKwSS276jtxCXI1gTer3bNw?=
 =?us-ascii?Q?KtNLDaS3tTBJh1Veq9GrT3zwkUF5YwuLYUB23F/bqu5GvaSyckJqgG2oW7G0?=
 =?us-ascii?Q?P66GufRTf9mxm31QIicSVOl46IRAH/48VU7Cee/lveVlxnt8jTcKdHosJFYe?=
 =?us-ascii?Q?JHzCpXtFy8vh0KK99kaB5RU+F7hJSrOAEKuGqG40s8d0BS6PwQefIPq99Yns?=
 =?us-ascii?Q?/C6nRvwkLHwjXUENoparHnPyLtf8/luBNYm4FcsGFxq3UKDEGIL5y4P+I3vo?=
 =?us-ascii?Q?PYXUe8NOWVgz8SUQDSIqJQrs6Ky09/lyDTF01xqrs91YUwMJsd51wnUWCV7c?=
 =?us-ascii?Q?0VLeoe0ym3OI/wZrwUw5rlrn3/gutvLgsIUHGLPYzKm55GhUxUW+a4EowPPb?=
 =?us-ascii?Q?N3Mm3OeyuGVsTkHhhRV9UsJDD4ZCHqJLWj2ubgY167we+CSin/IFyig0ihB+?=
 =?us-ascii?Q?jUfXNJyfVVD3tUPJyoyLgT8DscoLx0EacGzonVOQQBve+j28Yiy/1rWQJa4D?=
 =?us-ascii?Q?03RxZNFFZtm56cs5VdqieacGrycpKyUicIPQz8LHgbgENA0h+jAUU90WRVPL?=
 =?us-ascii?Q?TitzSfU0pCtIPV/IHCTbggG3LzlJ/tvPcOULvd6bWrdldTg6wb5UsSaRcBC0?=
 =?us-ascii?Q?vhxtygO0R746IE1xhX22oPIZL/XZ6KwPlFMAq12wY/2l7SicBN+5zDJ4pkt4?=
 =?us-ascii?Q?5wWojf4J7pWHoKaGtXBrBA5bnygXdv98tPuu4DNcWKjxiGwOLz/X/ZWFVpWe?=
 =?us-ascii?Q?a/TQSp0Y1l34CBPce0gnDfrCxbO7c3D+RtMs4/db7j0C2xAv5qUNlpvMznhq?=
 =?us-ascii?Q?OvJzkQNNKV0CYzd/rG0ErYhbjMECKTUVH+e4isA7jl9v9RhR0HybmdCdgSGF?=
 =?us-ascii?Q?DPvdW3cb1Z4s8gisGjnIsOO13hlTxtsk6f9DSm2WhK2g653Hud/gD+YDHV52?=
 =?us-ascii?Q?SY7rkDgAy2FqV/Lv1qKHorTha0EyxM9jA/PPg4eKCr0+c4HDOOQDpUizHEOF?=
 =?us-ascii?Q?FR8loUPsDNFtL2jgGb1r+Uu1JlX8Sh2RnwKd3ZDIm6N6PjjNq6OTK9R02c76?=
 =?us-ascii?Q?S9d+7qbySEQxnSe402Qqxz9V1g2EFp/LQ4mJKx08pKmpEnedYuqRxM88QQcC?=
 =?us-ascii?Q?hzeb+JNlOp61pN43aQ+V/vU+8DUc2y0NTNgNt0Q/AQQZgtCLFbiH5xySKm8G?=
 =?us-ascii?Q?SZk4bh9fYQBeILn4NiXkh3+2HPFyacNVhlC7UbSY2YsRuxGMUgUQ5+phlgIS?=
 =?us-ascii?Q?dIrLMXcrq1kvB+3RObeM4nvULBUE7Ds=3D?=
X-Exchange-RoutingPolicyChecked:
	j5dQInvdi6RJf50v0nRF1IiRfSTEt/MYT9w9CDw0iWc200ognyl48tUmKrLnPQbZymWKsSHruywRSgvaqu+gyowaTNqiUjlEFu+2MTS5CwE+9YF1X2s1XGjur3XWCZByBGy086kcq2bRwVrbi0O2oStCFDmeqJlzyazNdX5G5emSPH+2+Eb8MUBH9EWH+xTXyRpO67K+t4400LORqjmw3YtrGwsagFSpWzoZ1G76tIp/4loCBzQPFuCnjPwlJ5EPkYJ9SWzG6A9UxO0MSOq3Q1zSEwFenqix073r7O4+73kyQg1n/NjM5Q9pP/s1E5O1Z1VyGmttfbFn7ITEp011JA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ARGMWCQOXkaNVp65tS/bdvj8y5sDAGbh1tGXt2TaAhTdojNjiDuARvXw/PVfu+zlT/Izu7SApkZ18rnfOzTCKb62ddTiWj/S4h8N15vIbeUDBRXyqUmQV0uDH/9zBrezelNPmRmbGXh5EhY+mTVBRkK1Q7WsHIqjDwfpiYzHNohoF+oH0E+iyQIK9ARuZrnDaHyD9tpHiX5H0h8MkDmmAr8UJxb9T0SO89TzAjFDG5Is6Nq3fJmBDc1HpOcCQV7wrX1rg8QGNStIMbYpFvPRBqSY83Z01wksoWpvorvJnaTJ526p+cGmyQhz8Q6JMEp+LT2VJ4F3R03bEp0bnvd073pIIV0BYIVnquXq5ld2fjQbx7ksJ438gpjtCdlUfXWGaBTO0DWgIV8C4zcxItN/2Ej6iQi76Tls8jU72LWzdZKGLqnwQB+uxBJhW5y4sFoBj5HgazoDtzmr7heKkIIvwF1KlF01VUDiFaWiVi7RAgOsu0mLOc7+d/HDTxbSt75JaEeCqzOrEv5ZBNIFesLSacSdt+FkmdOniODa4EVAU1xEdivMAqi5YhyeDHBd0GpayV+T/AxJN2q476l0MXktiUER3oB/H7VoBCahSZx7JNM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 914042f9-43f9-41f1-6a83-08deab415a53
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 07:30:31.3237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w1SGWgZebjLbIWfTH7YwkKi2zFIgbhOHPZoKggpSmd2iXFw32ux+M4KIaQYdN9LpZP8pyLQGNg8qba4D3Kqy3TTZiuupMGxfb8IQs7OY9aE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4307
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 mlxscore=0 phishscore=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2604200000 definitions=main-2605060071
X-Proofpoint-ORIG-GUID: QHvQLj0Xq-b9D51zg58MRu2OFUREDtGx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDA3MSBTYWx0ZWRfXzR/+YBNPq9f2
 GIN8i9fPtwzbRRdXt7wIlMKfSTWPJvZnW8WR0gQG645pVUVEsXOy3vJ78IAe0Ln+P9jP8Un6YkE
 sCrbDpKlFn2LQUfFoYb5M12xSI5Tyr00Wp6vuheXaIas0qwUX3DpiLjZJfinsT7n7mOZmJ9kuF7
 S2fmnI0pZ4jqGWg5e9IpFEk0vQB7oyzZ8fOmeRhzCcXdmUAzTCbTGx09vfxp3x8ebL39YNpbtmg
 0VL2CSWvNlqs9q+UPUX4oOddV3Jq7uOCunnq8yWFg560/Q/tDlfHEmMtfi+CboKOPIZC9iICU+V
 GPztpj7i3h33Oqm7GhTZccLeZ3pp235Q0El+kHGetuBLplsx8ai8NVSj7Ai8Kxn4MkhqgIx8FiI
 uywgh3x3Y1f1GDT11CXQ1th84ZzpWhG7ix8+B/0fXO2rN8IALwLD7zt6bk0SEOl8t24+DvnYGU9
 CCkZogbwK/mJdq2dSJQ==
X-Authority-Analysis: v=2.4 cv=YKKvDxGx c=1 sm=1 tr=0 ts=69faee1d b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=EIcjfB9IiI4px24ztqRk:22 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8
 a=JfrnYn6hAAAA:8 a=BBXGc6A9iwDNzdzZ20gA:9 a=a-qgeE7W1pNrGK8U0ZQC:22
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-GUID: QHvQLj0Xq-b9D51zg58MRu2OFUREDtGx


Ankur Arora <ankur.a.arora@oracle.com> writes:

> Add smp_cond_load_relaxed_timeout(), which extends
> smp_cond_load_relaxed() to allow waiting for a duration.
>
> We loop around waiting for the condition variable to change while
> peridically doing a time-check. The loop uses cpu_poll_relax() to slow
> down the busy-wait, which, unless overridden by the architecture
> code, amounts to a cpu_relax().
>
> Note that there are two ways for the time-check to fail: the timeout
> case or, @time_expr_ns returning an invalid value (negative or zero).
> The second failure mode allows for clocks attached to the clock-domain
> of @cond_expr --  which might cease to operate meaningfully once some
> state internal to @cond_expr has changed -- to fail.
>
> Evaluation of @time_expr_ns: in the fastpath we want to keep the
> performance close to smp_cond_load_relaxed(). So defer evaluation
> of the potentially costly @time_expr_ns to the slowpath.
>
> This also means that there will always be some hardware dependent
> duration that has passed in cpu_poll_relax() iterations at the time
> of first evaluation. Additionally cpu_poll_relax() is not guaranteed
> to return at timeout boundary. In sum, expect timeout overshoot when
> we exit due to expiration of the timeout.
>
> The number of spin iterations before time-check, SMP_TIMEOUT_POLL_COUNT
> is chosen to be 200 by default. With a cpu_poll_relax() iteration
> taking ~20-30 cycles (measured on a variety of x86 platforms), we
> expect a time-check every ~4000-6000 cycles.
>
> The outer limit of the overshoot is double that when working with the
> parameters above. This might be higher or lower depending on the
> implementation of cpu_poll_relax() across architectures.
>
> Lastly, config option ARCH_HAS_CPU_RELAX indicates availability of a
> cpu_poll_relax() that is cheaper than polling. This might be relevant
> for cases with a long timeout.
>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: linux-arch@vger.kernel.org
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> ---
> Notes:
>    - add a comment mentioning that smp_cond_load_relaxed_timeout() might
>      be using architectural primitives that don't support MMIO.
>      (David Laight, Catalin Marinas)
>
>  include/asm-generic/barrier.h | 69 +++++++++++++++++++++++++++++++++++
>  1 file changed, 69 insertions(+)
>
> diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
> index d4f581c1e21d..e5a6a1c04649 100644
> --- a/include/asm-generic/barrier.h
> +++ b/include/asm-generic/barrier.h
> @@ -273,6 +273,75 @@ do {									\
>  })
>  #endif
>
> +/*
> + * Number of times we iterate in the loop before doing the time check.
> + * Note that the iteration count assumes that the loop condition is
> + * relatively cheap.
> + */
> +#ifndef SMP_TIMEOUT_POLL_COUNT
> +#define SMP_TIMEOUT_POLL_COUNT		200
> +#endif
> +
> +/*
> + * Platforms with ARCH_HAS_CPU_RELAX have a cpu_poll_relax() implementation
> + * that is expected to be cheaper (lower power) than pure polling.
> + */
> +#ifndef cpu_poll_relax
> +#define cpu_poll_relax(ptr, val, timeout_ns)	cpu_relax()
> +#endif
> +
> +/**
> + * smp_cond_load_relaxed_timeout() - (Spin) wait for cond with no ordering
> + * guarantees until a timeout expires.
> + * @ptr: pointer to the variable to wait on.
> + * @cond_expr: boolean expression to wait for.
> + * @time_expr_ns: expression that evaluates to monotonic time (in ns) or,
> + *  on failure, returns a negative value.
> + * @timeout_ns: timeout value in ns
> + * Both of the above are assumed to be compatible with s64; the signed
> + * value is used to handle the failure case in @time_expr_ns.
> + *
> + * Equivalent to using READ_ONCE() on the condition variable.
> + *
> + * Callers that expect to wait for prolonged durations might want
> + * to take into account the availability of ARCH_HAS_CPU_RELAX.
> + *
> + * Note that @ptr is expected to point to a memory address. Using this
> + * interface with MMIO will be slower (since SMP_TIMEOUT_POLL_COUNT is
> + * tuned for memory) and might also break in interesting architecture
> + * dependent ways.
> + */
> +#ifndef smp_cond_load_relaxed_timeout
> +#define smp_cond_load_relaxed_timeout(ptr, cond_expr,			\
> +				      time_expr_ns, timeout_ns)		\
> +({									\
> +	typeof(ptr) __PTR = (ptr);					\
> +	__unqual_scalar_typeof(*ptr) VAL;				\
> +	u32 __n = 0, __spin = SMP_TIMEOUT_POLL_COUNT;			\
> +	s64 __timeout = (s64)timeout_ns;				\
> +	s64 __time_now, __time_end = 0;					\
> +									\
> +	for (;;) {							\
> +		VAL = READ_ONCE(*__PTR);				\
> +		if (cond_expr)						\
> +			break;						\
> +		cpu_poll_relax(__PTR, VAL, (u64)__timeout);		\
> +		if (++__n < __spin)					\
> +			continue;					\
> +		__time_now = (s64)(time_expr_ns);			\
> +		if (unlikely(__time_end == 0))				\
> +			__time_end = __time_now + __timeout;		\
> +		__timeout = __time_end - __time_now;			\
> +		if (__time_now <= 0 || __timeout <= 0) {		\
> +			VAL = READ_ONCE(*__PTR);			\
> +			break;						\
> +		}							\
> +		__n = 0;						\
> +	}								\
> +	(typeof(*ptr))VAL;						\
> +})
> +#endif
> +

A cluster of issues that got flagged by sashiko was around timeout_ns
being specified as s64 and a bunch of potential edge cases around
that.

These were mostly caused by an implicit assumption in the code that
the timeout specified by the caller is generally reasonable. So, way
below S64_MAX, not 0 etc.

I think this is worth cleaning up a bit. The change is mostly around
introducing a u32 __itertime and explicitly computing the waiting time.
And adding a check to ensure that we start with a valid value.

This does make the implementation a little more involved. So just wanted
to see if people have any opinions on this?

+#ifndef smp_cond_load_relaxed_timeout
+#define smp_cond_load_relaxed_timeout(ptr, cond_expr,          \
+                                     time_expr_ns, timeout_ns) \
+({                                                             \
+       typeof(ptr) __PTR = (ptr);                              \
+       __unqual_scalar_typeof(*(ptr)) VAL;                     \
+       u32 __count = 0, __spin = SMP_TIMEOUT_POLL_COUNT;       \
+       s64 __timeout = (s64)(timeout_ns);                      \
+       s64 __time_now, __time_end = 0;                         \
+       u32 __maybe_unused __itertime;                          \
+                                                               \
+       for (__itertime = NSEC_PER_USEC;                        \
+               VAL = READ_ONCE(*__PTR), __timeout > 0; ) {     \
+               if (cond_expr)                                  \
+                       break;                                  \
+               cpu_poll_relax(__PTR, VAL, __itertime);         \
+               if (++__count < __spin)                         \
+                       continue;                               \
+               __time_now = (s64)(time_expr_ns);               \
+               if (unlikely(__time_end == 0))                  \
+                       __time_end = __time_now + __timeout;    \
+               __timeout = __time_end - __time_now;            \
+               if (__time_now <= 0 || __timeout <= 0) {        \
+                       VAL = READ_ONCE(*__PTR);                \
+                       break;                                  \
+               }                                               \
+               __itertime = __timeout % NSEC_PER_MSEC +        \
+                               NSEC_PER_USEC;                  \
+               __count = 0;                                    \
+       }                                                       \
+       (typeof(*(ptr)))VAL;                                    \
+})
+#endif

Thanks

--
ankur
