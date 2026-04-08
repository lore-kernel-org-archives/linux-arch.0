Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3BF3806DA;
	Wed,  8 Apr 2026 12:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775651250; cv=fail; b=ORZp0t2UqSY/Q6VuD+U8Da7SPOD/a6IYcpGj1pnHUS9/unRhGmO0ZEj4LJ/35BSgACjmF2IOc9evUYV02/S8/9eDKDbmk8xRrOoPgh9QQWxUbzx3p+Xl84KN/CpkWNdrWsouZ9Lkmw3OrTK/nrinbaq4A45fkum/SdWx/QiW6xY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775651250; c=relaxed/simple;
	bh=Ma3+LLvRNlnb9rpI/GexQynajwIoSrQH8Zz5qEdytqE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I+Fx0PMrEJSdjmaYZPHjsvFMaHe0G1sw3XWMc1hcKbwWCCXawjKZCQ9wKa+xm46ePzErWrhiPhP10LX1eO8iaf37nmm84+yDlqM1ImmpSQPK1HCaqVnPYfwWlE7K7EQNf6AKneDoTXkoSYJU+HMsvieeTRwNOXOUO8PAy9pEq+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=isoSrxqe; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kQyNyKzI; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="isoSrxqe";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kQyNyKzI"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6386gjGO725753;
	Wed, 8 Apr 2026 12:27:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=JL5DIg/fCw9vB94OcC1DQAGQTB4WeTAPUwqJ5Tkeiqc=; b=
	isoSrxqeRrD3dmDYn8gehKuISonbgjFVXDqIsxY1JgHWxXJe2JuJadGjLleX1eei
	LAPDcApFvD/8q69+lzNfxVRsbo1aNwR+N4clPqyKt2S0Rmilifiej+EDb3Ax1/0v
	HBGBGuDmqfWIqqQ5K8sEJH7ybYBfH0NUmAVlleixRrRmB37jUmS9oQbEutBxfnok
	G0zTE0t17BNnRM2xrC6rasOIUKRht0gykIYZgpepPG9ND1M82tjz7xZKjy7iiVC1
	J0cZ8g3oDsHAInRKs5hCe12LAQOqmvShYOpHUWHSyoC+IQtSAhw59iHKWJk8Sqg3
	aE+p4zma/bD6yFWYDgQGRg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dcmqebcxv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Apr 2026 12:27:02 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 638A7NJ8011883;
	Wed, 8 Apr 2026 12:27:01 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011012.outbound.protection.outlook.com [40.93.194.12])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4dcmnrfkc8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Apr 2026 12:27:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dvit+pZYkpd/ucWGJUqhbx0/w6nLqA1qhv/n4Rv1VNofj6GM30OINvlv/LlXluvJsoVxzHhv9RiIs48bMIq4agn1uhI2hvJPDzjfPesAPmTrz+8f+akENLziYS+CIvdzRiWxvdkVexHix1S3R7+fOgrn6SELA9tRL2pbK4sDuSkgriIIwPVl1gNlACzpTxN3NDyJy9DntydrKP0wxbAEChD4OYEh8XGxjFwZogZPdoV0BNLBZ2YyLIx5FhBLNyHnLa9knRTIzMkuSHVr11iC/saZiJj4zmMx8eSJ0j/L+JFbiODh27/OLCkxct1xKRkbxnE/dHXDaxm8uV9JlMbPkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JL5DIg/fCw9vB94OcC1DQAGQTB4WeTAPUwqJ5Tkeiqc=;
 b=DCpbAWNTnmSoxjo/NLyqoxFAOBkqscWWF5zv/RgHLKmsKts6U7JWm6zBtqd91Pec0niMbM4K3y3BF+VK73ijBnIreJ2Oysfc5tngXk1mo8zcTj2PE5C2ThsG0gM8RaZgaD/vfvB2u0VkcU43kUsFjqB0nVqmHQcYinuP3uy2W2bsYGayaX2yzoXi7fLBDvPmULo9AiRLlC1rR1w2bQ2ufEsEzW7WDxI5Ql2jhms5wvyjFkAOkvDsdwwOXRuYecee47YTp1bkSjxOl1CRWYmypJ+OvpDPpxZ7Zfw6vpXm9SsnXwJnRlSbUNqnRBrNKTvZR3hgpfx/oPLLck41OUJ37Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JL5DIg/fCw9vB94OcC1DQAGQTB4WeTAPUwqJ5Tkeiqc=;
 b=kQyNyKzIw3cErAqF5+cK4wh8hJjiJmPfl7uULOTy701ey4qtd2+u7vmthFt6tRhJnUy4dEnioQI3gJ062bb0g5THtQGzOf2FCWJBGpFPZicIF+bLc5QcuDG8yZnBYnz0UIUmHnUUvPfkRA+zB6OQey8j7o4QxCesUUBHlJc4/j4=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SN4PR10MB5574.namprd10.prod.outlook.com (2603:10b6:806:205::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Wed, 8 Apr
 2026 12:26:58 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.20.9745.034; Wed, 8 Apr 2026
 12:26:57 +0000
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
Subject: [PATCH v11 12/14] cpuidle/poll_state: Wait for need-resched via tif_need_resched_relaxed_wait()
Date: Wed,  8 Apr 2026 17:55:36 +0530
Message-Id: <20260408122538.3610871-13-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260408122538.3610871-1-ankur.a.arora@oracle.com>
References: <20260408122538.3610871-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN4PR01CA0125.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:275::6) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SN4PR10MB5574:EE_
X-MS-Office365-Filtering-Correlation-Id: f7e066ab-bdad-4d0d-d30f-08de956a1ffe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|7416014|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	1JBwErO82+rXYv3U9HPraoZNmhoEIyd6i6cpCo1SWwKCrCm/d031wrF+BAOWjf/H4v9R+PJ1Rv5ESbWyagId1X6GyjJ6WKffVdXKpg7zv+UIYTR238/keThjnNS7ffcyEEHPEEMkjNVi8+FfxrT3oe2TAFTurD333lboovD7YtTat3iWzLRhsqxnxM/DLoxtzNVwngsu67rLxs3BPROtQZw/7pCi8yaOysGDnBb71qqxYcid8AgdCqR1/Ws/U/Y/mWnyqPGBAuA3Yp/thpalD1lUI6RFbZs+RLiaH98hQ/PLSVmR5nFDbLivMLfLferblwI/KBrtfpIN/d3szErxcybLzkMmADX6b6WNpSJ0QVQCDxGaD2G6yBBqb6fL1NndyQ2AcmMHRY81CDlUdAfdD3czi1nbu90Et63n0L2sxeJbwTVJZk8a3T5Ic/7F+PKhmaNnG4893iXfDE67UK6n4xGDoD238EKNNp5h8W+QfXWuEYZIVvute149IaCrQ0XHPKpKCFtIePFDKXVEwnfJ83GBV+b98gKWn2oFagsUOkh7xW81LAtU1FUAzPDWQRSIuKflzVHOUc8qYDJWKy5wLP2LRKpqIYhwntJuqK1fmM8lcU1G4km3NEcfs24R6X+Oy2wukHjZyy5C7sQ0O38uIElovItvhMEs2u+wmEisBEAP1HRxl+athJm5GigIDwraM07nrspJLCo+xKAipk7Aa3vHeOoyknOgXLp8kXWCMsI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(7416014)(376014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kB13R1jDW53ImjELYk5zEhQbDlxeyW9jPwkwdxidVTH/9heZUte6/Zak8lL5?=
 =?us-ascii?Q?Gv/PKP9AMWoCef40pzl/IwgdwIXF4Iv9SlocwkczSOh/iCHrzm+uBIICkYZk?=
 =?us-ascii?Q?ps1e3Loivndxi7/2hOXoLaQnEY1sERMGZyiLUo2zlA0f+RxkVu2t1dTGSj2j?=
 =?us-ascii?Q?8pNlO/vuBvXTaz/L1oHfxRe8KZZH0oUNbkl87GRqPWiKGCvqGg8emCmnRpW4?=
 =?us-ascii?Q?0XV82VgJsz5jDIW7b+xsyHXkZJYi/seH9GzL7J9KnqWtDM5QDE+P6shuQFa1?=
 =?us-ascii?Q?7/Nl8ekHo/+o9HSnlFNI9RwI2k5aLJWScQNa3ZRY1hnPnFksXQ6noVa54kC1?=
 =?us-ascii?Q?CvpLXFuYdIRHJU7zaUzxX4/wo3AyYji1+UWX/ihHA+c2FfNdOq5A5nf8KkWc?=
 =?us-ascii?Q?Q/J2SrSWXGvIgjtOZ2upVu7kM/Gv43IP2MWugvz3NOhLAwCshVz7ZNolp9CO?=
 =?us-ascii?Q?WWhRDJUyOEKGhNGjvQjFCWTCYzSPIUx0DFeBNJjDY28DpVadn+6IBfGJfrTF?=
 =?us-ascii?Q?o7nvBGBqAW7N2Td89gyX5sN3d9QveClOZvlMkUqxq/yia+ZD9Ka867jSy8U7?=
 =?us-ascii?Q?FyDCkzX9cidB4RrObBPrNDERRY3vYTQspAtCJVcbLThP0eIfVIWAvXS1uT2b?=
 =?us-ascii?Q?Adkgrquwvtc+c1vgkLp4xh9eIwLw6lXhVwvswMyfc5pRXTo6T8IwRRobuXHY?=
 =?us-ascii?Q?R5x2/FJRfEWnqt5PlUqCZoIkjw6dX84CtV5dxi+vvcsVZqkQKQvPjHYiPevm?=
 =?us-ascii?Q?BHcSu8Kr2HmiG4/XStusNw7q0K/FGqqEn77ZzOB9+YxDiWmjk27XbKYDSbFw?=
 =?us-ascii?Q?wY0mhHoUOqofYqqGpjiCw0NUnu4W0Pcr42RQHf/bklN8II7Yqj1ocmLTa9ly?=
 =?us-ascii?Q?CNX+9zTXbLw6Hh+H3gOrxO6sWAntuDjLy9fN+9vLGL048l1mSMZdRX4uPoKl?=
 =?us-ascii?Q?0Zo1sD7K8EYcdy6YM41rx2TNTHu9BTrIunhApRFJwiJKRRp02b1fgkLqIkvZ?=
 =?us-ascii?Q?pO3vp2S0TTa47enT4jj9Fn+x5t4yPGvXuAdnJ76pRoUtRNNucFCWTgRHE761?=
 =?us-ascii?Q?ELjyI2PhA42py8QhRiqi5s51P4D7CQk3Wx6+RJud+QJkVwx8xgUAnVdAMUBk?=
 =?us-ascii?Q?oT/ubuhVW5mWy4SL+xH6h3OvVaVai1T7rB2VyjTB2FyjNNDRgLp4TKnllizA?=
 =?us-ascii?Q?kjt96cAlsJuWRBfVwhvOffNIq2XaWorcgIucMGvR6Fq4SFmHCt7ISvwjLAqL?=
 =?us-ascii?Q?ZxfdQwR1wdlr7WtnaKUkvmCVa4HpT1Zw0Tz2YCrY5qDPJJAuTFmlCRGYVxc+?=
 =?us-ascii?Q?2QAKkX5nslK30wgCZ7tmq1OxlxA7UUDqnU5ez5WKP2PoQEArl1UVcXZujaxD?=
 =?us-ascii?Q?prUNilTFY38D1nHlB9n8zPkW8IW3hPdWQboK6Zt2IeSu6F47PMRx309L2hK2?=
 =?us-ascii?Q?LFvh2Pnx0865OvPYvD9dfFb5+OqTGuShiZUw50jYDv6vkXq6bxh0Nbgilopk?=
 =?us-ascii?Q?R1ckfhPwOHNb8hFEDzeMQYQ2cZLARy/Z86dXeo2RD9HQGATaLubLcPn4BTK3?=
 =?us-ascii?Q?NQvrA/MyNZCRaafborlCfc1G2gMZ5/cj6FfudvJ5t8tLblkmxDMoIVE9+eZl?=
 =?us-ascii?Q?Juqf9CBNz1eIedhoxqP6osjFNmzdNs7rNEyke9/lnZWIANZp7tGRikqKWVQ2?=
 =?us-ascii?Q?EoXqccXglsv9P1Svq2LNJkwz7bwqgLmzYex/bB9tkvjA8vtIHAZJn6a+uBwL?=
 =?us-ascii?Q?7TCUF+/Dqec6wUeW2Lg/itejzLr9knYlJFXZw8LO2ISrUHzgfd6YtWKWQEJ6?=
X-MS-Exchange-AntiSpam-MessageData-1: CbYeRpIWaBwhpR5NhYkxPS3D0hZ6wRUNSeo=
X-Exchange-RoutingPolicyChecked:
	hz2NV+GIlR5ePk0i1n5LSAzivnoT4od0uK9DOHPwcZxnPGYh3p0g9PWk2FyDTV807q3U1TcDTXAobEumibqe53V38Pi4urYt0gqgTHp17sG9IjrWvi9Oh2Lusbw61ByXyVJzJxnkEwXa57JrOb4NHhO1BmVvTe597Gfr5ubeCPL1o7PsqVhB+ilL3wgQ38B4Ll4icATrv7jLj2V5GOuOTp0aAbyqXIj0KKifOabhxVWXyEPYI41WNaK9S8RbuXCYfshg5ts0K1PZ73LhgKwpLMiK9e5wDVpyNoq73prMO959N5m6qvlomYFRJr9JqxQE8DQBJqf7yOoHO2TLREQQow==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	otTxKMm4yJbGe4O07NDV1RFD4cAHEHPjAkos5YV43gYH40EMfejLMQDZwfPZl7dmgOFLFmVyxj66utcok34gn640OUm9B85nbkB3z0+Yyx3J9gVCBDdDrfDvA84DvV75uLFOoC9emaw301UtQKQ+1+r6brOsezS3ebEuG4JyOAtvuqkBVVVlasx/pqlWZQAVb/Cfb0c+hIMs0u/cC4h6efjlXF6RypGg5BUY0b1xTn+t+ohkAOItZs5WxZYW8ohGoxtfizlHFIC7Kg1IrjaGb9mYg8A2FPeGfXzpOjPEm0EzFhA/GskMujQbq/1/eDcqqo8+dGAAtiR3yVUeMYq+JNMWQxgilO6nCuoUFQrm1+Y0YIOKCXulOawoj1J3AEQ/UcAO6NY3ZEIsWRYXiva+8GKBw3pCkWIWKYUe4oInpF/6/4uHMxbNINCkCd4WNMKZzPtAlCrOCoMN5vnA3wHfpdxeTgug8MNk7l9eIgqRSlEO1sqaTqPltPVTAFiMJvkpYm1Q8ItTd1CLT1l4Ng4np1Rd8NCyJFrVE4RLhoFePxU983ftnm5KI2UGdz3+5U3JuhOo81I/7/WMJMajIUns4FrWAfTp7O0zskYFz7NClVo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7e066ab-bdad-4d0d-d30f-08de956a1ffe
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 12:26:57.5296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t8HTL4yBSmvLiAO45bIied0miVKNNwCgKv6LRNzt6ptGPpj9Dm5PeinBo/sytDkDZ8fzNlJqgkrtL2aJcPRw0Lofi6ojFTI2unD9wbCrvdI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5574
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_04,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 spamscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2604010000
 definitions=main-2604080115
X-Authority-Analysis: v=2.4 cv=MtJiLWae c=1 sm=1 tr=0 ts=69d64996 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=yPCof4ZbAAAA:8
 a=7gr8-LgUhGOHEYCj_R8A:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: esDwinGADznn3LxdEKAjRaW3Ht6V49hZ
X-Proofpoint-ORIG-GUID: esDwinGADznn3LxdEKAjRaW3Ht6V49hZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDExNSBTYWx0ZWRfX92WPQsR6UYBA
 rExoFkRNYeyJkyIysodyjivC4IPF2rBMGFCkZzhGXXPIwvqmnwPRPuNgR4cE0OjwD5UPMpiCe8u
 hrctdTX0/oLPdvTIyj+g1Of+JHppij5Kve2hRze7XFkgD++bPMqJEeeITpPGknl/G4S4fOujr03
 q94LU0jww8fbjziu9UQXuRxoaKmR96ObYYgl73KHLDyewDTbw+MsRdBnbuDtIvoQZmtSxng7SWq
 sAZ50M5PcKiZn71Gq8qnQoJ9og/bxggytB6gXC4GDhTGnbCjXETQgrgq/ZB3n1yEx+mLwb8Iod8
 s+wc8p9ylCj2JSyWBO57fqVnwo38qAolCjV3O1fUEPeBHvCrFdgj1IBgCKsovTU0USjlF9O+ESi
 WGsHQKWdO+26yT0rgmlj1M2FCdHRq1jjBwMfzuQGn2z3fglWUJNJnorTyKip4SOqONw+oO8/tMd
 GQueOqf3Qxhrd4H+AzQ==

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
2.31.1

