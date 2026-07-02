Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A932E2F0E;
	Thu,  2 Jul 2026 01:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782956127; cv=fail; b=D/20UIjuH+JiAPzp+Jv0DZw4avIDiM2BcY0m8Sr31JzLdAueV8iNEpjPkCKa+VUb+UbyCFuXRe0HYnltDTwyLF5mijdDBlJnzxq8b0LjgZgnkggDgN/NE3zg5sFXeiGveMI3qHcDk9U9ndxeP5F/l1JiCr5waN5sD/MrgjyNUZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782956127; c=relaxed/simple;
	bh=YZdpalyp1HpIVd7jGRzbYlmK62NKHa5GDKY63W6aMkA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a3kuDRfoRkCul6TdP+QcXFky7Pgn8awLztrgNUJ3hsd75jCz32wpMwpOcQzl/+VkeYD34LEBfATYo9VmkyXDI2N8jOn8rlebpAGZDh7Q9HVOz9HUVcz8Q+UB1Azcs3TgDDL2wFSm0KYj/I8w3sIoCMnVYjCyoyBWs3LPfOWUb6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AaUBrR/F; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=forlNVwB; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AaUBrR/F";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="forlNVwB"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661EL3mV3058415;
	Thu, 2 Jul 2026 01:35:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=bOpd7viLXWgvVFmpz6pKhlW2+YY06yEoSg1+fxsRJrU=; b=
	AaUBrR/F1qfEaGfEAD3p7Nr5ip8AuEJmv2DSZmZScEyiLIXzLTUOaS5YH+TSlnl8
	a9oqJNa4jZzei4YjFqeANWAzKPl07qXrCZ6U4nO7AL1t0kcg5uV2mwdD7AUzj26k
	9G0kOWiD50LZ73+j6DhDtUkaeP68a/nL/6yAfDjrOwYRsFQYBZcY44VGPNduscBV
	qaB0trha6w2CCtJxPeqJxz48EkiqpUiZnIH2/ZWxYwQpJ2JSFUmCcpZ6zdko5qpv
	PvCfqCoHg7f6mtNvzRV9CuxiQfUvxDY3Y7NW2++QBcU3WfFdptACTXyYP4x5Byy5
	+ekW3d/aG3fRG6bG61O4aQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4f26mk77mu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Jul 2026 01:35:02 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 6621SCn2036151;
	Thu, 2 Jul 2026 01:35:01 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012066.outbound.protection.outlook.com [40.107.209.66])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4f24ygbywk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Jul 2026 01:35:01 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U4KsY38VF9qiQpKJhJ6tFETXEaY+3RV0tUO8p+XUumV6kahKuAnXF3QXPLyUB7lzyaIV5hFAbijceuu+kQPB7SBGtR/PoLz2pK39vYREmBgSvxwfAGIWzkBebm9nydDHD02GAe+48LDQ0QSzMeUh0Q/uVuwcGkOnnv7TXS+Qpk//GccO32Qp5GY6fbbjHYDxJO3YCUTUctZDAniZgWbPeh8kORDiZud2SRpBXwWVPF0PGKlLulZojq9bNkBEU22WV0j38eBxKYs+rxZz6jZ6XKeVCe9RCXdInwOcliHlqvh2kAeBAvxI7T78lVJSAWiSQ7+hE+dw45Ej6uPDVVm8eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bOpd7viLXWgvVFmpz6pKhlW2+YY06yEoSg1+fxsRJrU=;
 b=ZquEWaMXYHT6sUK3Cgy0v+T9bhwXd87lgIOBxWRqy6+PPNyr064ooJzkIMP5G9nzWBbA7jreGq0x6hZiY7spCgALYNWdCIrQtPHtfOVH+XpZ7wzI3oYfBcW8xj9PB1zvP0XwnZhfD8NRKsjDrl5kCgWlnHTgi4xnzEIAYiOGaIBGz2x2i6JtUpSvWRxHk2Mr8e8IFOey4rc5qcYcum30xrDx1IKBgT8MmfuG00mRfHClENzyXVG8Hk8hO58BfviC+xLUDIKVnqXtPfIDaqxC57KDpYXnMq6zdb9DWzmDj2kC1Eri+DqO5UXJIsZUhNyy6W9AlbwvaPovcewo++T3bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bOpd7viLXWgvVFmpz6pKhlW2+YY06yEoSg1+fxsRJrU=;
 b=forlNVwB00IYfrGbk+wQyR1duCZKiA6+HG2K59OgkG1QJdBpi6MdmO21dEEFYadlhAkK5cS+5rleePYrOpsldZP5rtAIWnI7mDCpAoy0tm8yKHfjbfWGNE28F8rZFaFY9rjkPwhHwrvYxE2sm69Gfno/eHF8m2aRqA/BAV2vqjM=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by IA3PR10MB8760.namprd10.prod.outlook.com (2603:10b6:208:581::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Thu, 2 Jul 2026
 01:34:57 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 01:34:57 +0000
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
Subject: [PATCH v13 14/15] barrier: add tests for smp_cond_load_*_timeout()
Date: Wed,  1 Jul 2026 18:33:33 -0700
Message-Id: <20260702013334.140905-15-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260702013334.140905-1-ankur.a.arora@oracle.com>
References: <20260702013334.140905-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0089.namprd03.prod.outlook.com
 (2603:10b6:303:b6::34) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|IA3PR10MB8760:EE_
X-MS-Office365-Filtering-Correlation-Id: ed0c2496-0794-422f-3ea0-08ded7da202b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	M7oktglLcJJ/UujJPVqvfz64evaUBBNCX1GYvK4jpWMRyatz80w5mBY7E50GkIPX0SGuDIB6XaFWenBQG0JxxPt2Ak7dQnfG07q0wIOnNMTprXx2R1A0/AmFdfB8+uDDJO2hILb//tqub8tJwS4DU3MjFmmU6KdB94Rz71Kt7g2ZB6G0/FDWgDh1pBuhRle9pOPRhRMtpU6476zrVL8hO2gnLK7gMsfE5R1VuU6eyzn3hw2vmV3CwEtK6i2uqNapC/XCLjUmXjpK4Rv5IWIidnz4XOcTJtJKgV734bIO4xVN6n1JOK89+RFVFrNIvdYP61xF/rF07MvyCJG7FfBybvvjen7UebtsdC/AQ+enXq7ZBklZ5v++jqtBTu6yi6ibq3Q/lo5f280u+0z1EawR4Ux98sKxgnxlQ2KXQ2HhP2+JXpbT3IsNMToJp0BckfDls9oF9BcJ/PX3k5K5QfX9RWFLf3uIgCkhGQhU1KyyLY0NGuIMSbWTJebD8S1VJm2/Q5/5ByXrxuov7FI4hQEVyhCG6U3H8VqizFOOyWUR2JIqHJ7lCY1vFT+DNypwumsyZPrVa2b8Ub5RebdxRNgdEw9NpJJ3UAtX1lDBGyeh4WY0CMOh7QtKPaI34za/WBtsqjTbN5O0EiENXxcEyLgXnRtv2DstuOwb9TSWmkIXgAg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eSy3050jXTD4yDtl6mzlv2n9pE/unqHwG9SRU51NMDeKeVImA1bUI/gFYDY7?=
 =?us-ascii?Q?1VTYR9XNUp8afqlsBZ7ZSVYJyr+prlARCOnhn5dhz+5ciC8uv9wtgM7jILxW?=
 =?us-ascii?Q?e+iyz1Owt2hQ8UjupxBW0/rcooq1/D5SxU50WeBZBWVNRUzgZGd4W+H2rsC6?=
 =?us-ascii?Q?XKcZ4iLkYojY39dCo0UBVJjYKiLlWu/1yKNfdJG9SKJc47kIdJrFyy9KqzeJ?=
 =?us-ascii?Q?EcdG7btL0h4PC29UzTcKT3ASUI7nvx/e+8bikU3oGd/8QyZHDJPksLRuevPs?=
 =?us-ascii?Q?/tLbG9Wiqj6tqhxQPiqMe2Fa+08x6yu5m4+2gNhIZyiCF/YSbxhZPczS4Y3t?=
 =?us-ascii?Q?/ybrT2nb9cJb+UExeaqHd2ACbHucKf+W1hoZ0SOme4Z95NaQS8odEwC3xAI5?=
 =?us-ascii?Q?hDt9+4m4CGFYQ7C+XZE67+i6gPETjs8D6ZxH7myd/wnV6JV7z992c9X5/FhQ?=
 =?us-ascii?Q?KDP+7P4FmzhoFjsVf1NBxqjm7o3sajdkTFxmv5GXL5ZwOzuPwruxIxzhB5xJ?=
 =?us-ascii?Q?F3LnLJJiEJAN8ygdUYbNV3yiYrxOVt1Bct4AQ0J9Fg9c2loXhScjYOS3oFwt?=
 =?us-ascii?Q?tKDvV3IPpG+gdM5SUPSqjEzeYlkPFynm8bZ/Vf9jLh4TPkV2QR/fONLjoQru?=
 =?us-ascii?Q?0HNLgh9GINDryCh0d9sIepqIfSsRs8SoaifpgqL/3mZTUhMGOV5V7EZhWesk?=
 =?us-ascii?Q?CiHNnOYvPaFgMsPZlf64sFvD3znI1uXvhJLCE2kZdV7IhnhNXWc7BjeoQsNg?=
 =?us-ascii?Q?ysOTn4dgwUK6yBr+teKKRsBTnDWPe1oFql1qjgCrELv369rk7ST3ACaRCwRb?=
 =?us-ascii?Q?r7W1ixVLKiDJ8mXED3nJn9M6XkWjN1PHCMtiPAr9ZRSkpnw76sM5pXMlWSBr?=
 =?us-ascii?Q?Cph+wy+CRRCkPqIoybj/1ul3ahVA/hy/+1hiG5bOKHdPk3U8lBjFdR+86tF7?=
 =?us-ascii?Q?3PeGhMMY+3u+WPmMc4E61dq7haTnJWMNo447PtzW4UZaz8uI74pgCcZi7c09?=
 =?us-ascii?Q?BmbUZGjUwliPabtDGT4KkG00Npd6glZ8QEdZmWHwr1/FWwADOUkI37RGQ1P7?=
 =?us-ascii?Q?mQJ19XQJW9c+edM13jLIQV0Z5E8fRgeXxqA+PpmWA/gaHX7HCJZZflvHfxjv?=
 =?us-ascii?Q?RZGArf6u+xZ4el7QXvy4n+yTNmCa+j14qI24gDmSR3C/D4Afg4dJE0UHWwU7?=
 =?us-ascii?Q?1+Juueragnra1xYKDk4sgtwITyx+Rcs0naOe5FAv/h/NOiRuwjn+j6beYXG/?=
 =?us-ascii?Q?8mtVr8xQz9HLPlgr371GYVAR/N12ge18avUw/r+1hZwQie10h3rkzXpzpPwV?=
 =?us-ascii?Q?aodaQWQZZnuOiXehDJh1B5eaGd3xC767Or9Rf2JxNo3dShebVCTZm8PPmhhf?=
 =?us-ascii?Q?zTh6M6v/6XpurdTOV5KTSnhg3PCg+KvnFkAcvp2j1h50vTb4atXxpAnVeRn0?=
 =?us-ascii?Q?05cZU293s4LFhCCV+h9G5gswMWQaFygclqckGU8seKPvyyar8/VNhCbjo9vD?=
 =?us-ascii?Q?QJoRT6BFejvFSPbU9JgOFlhHkMxqkr2rOhVphvsfYne+1PDM4zFZcAHeQREa?=
 =?us-ascii?Q?A0qCdUSiEMC9lNVv06qzBJNFqRDYTFJqUo7jZnpzPzHb3tX4taI9rS36aX/e?=
 =?us-ascii?Q?6F5TkIp9LYDZytsJ1DdkkBAzkVlibkU2QR3CUjUFIvqEcIoLxkUltCwE7GKr?=
 =?us-ascii?Q?Q67UlgcWvBTc1JHCz+DkYaJ4DMztAj78j4VqLFpRBfHYN1K38sXqGmpT57VV?=
 =?us-ascii?Q?5aowv7x4oAsyCa+EAd4PXblTa4sErcI=3D?=
X-Exchange-RoutingPolicyChecked:
	YqehM1Z73Pf40nwD7AZTUaTfdlLxJbIoQ6jW9PPEnFcnpyI7fgaQ9tbYQi9Jw5hOHbfLNrUtgW1iDrIbCUevNuQDFrtY8++C/wQHBmGJuyChMNhmStFuKMF/mrWm9Q3nYBIF0tGF6EE8DUBCHzUCes8D/Wx9oKiDlPb0I54AtxY4FMBBvdHplDwd3qQD0Vq605EVEqlgGtBZmvkyt/Jfry7SkMIDqOEzCELVv9GKftUsr/1K2Shr5rpK01bRm7t+ytDnl68wLE4jVoaGOJVrWUzfrfAzHD0QOQtse/gFPHns6acyI/KMmll3hzL0M1uodtBhk+0PJlES4yIoWtCtXQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	f0Rc1llxmKQJ/j9F3Str3hAYir4cqBMmrjI4Dts1ro61+bVKSJ1OXnJraavLnqY5cCZm5nbGGHNyMvDwdIoetwwxiVju5WfA9yGih9sOQsRxa9ux1Afc/PxLRp4O1w17nUrCEdEGkRGTSBdj8zG7GOb2c8txQNWGsHh4ZOOVFYwGq7HTtIIboU9OmYcStz2x8QJEOCQHsxPe9eh7HvrBXOHh0mweUubjRIdUiyjafDBFEUrYVYWdXWXHllMQjYqzoAXGyDnSMawVq+leG/lCm0Wublwv8snulZoVhMFT6TY0M/4HhlXMUWqUO8gOENIiyDMcUz80lubXmaQcws+ITpSDmEZ4Rq58Jj6yscIoLPcMVItN1UloiBWXmhiZik8YIIo5PvzUjvazlVMBO30pZ13OlH2BoOOAJ9BJjbJ70lJi8rOH1Ujem3cNCEGTzez88VPiuFdASeB6gbKoExfp3hZCXXIpHv0vkTKOJIpWik5d5LMiVEWA6F9xE7NeX/oNewDU+30wfcvlACIU872rcuHbe1u8dnsApd4CBh2EFnLUR90RRSlWfceleXPLJOtFh+JCPSu77QbZfGsHJ1BTywL9y0kqJR/I+TxIBwdG8W0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed0c2496-0794-422f-3ea0-08ded7da202b
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 01:34:57.7276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nlJiSXebCw1KSaYoTL4EECGHdG31qMrpCSYxKCggC8AeNHRCtzpA3PtOxI/d7ZiXvE46u3oKjIrgsWnTNZc6Y49jPkCvmr94pPE9RKdpihc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8760
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 adultscore=0 phishscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2607020012
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDAxMiBTYWx0ZWRfX/sLkyb7e7dCa
 BTCDmbVHPty45hzOAIqwsABzXBz56Cc5dOgZu3ViOBh+p8BtmQMpavVz1WKE0EpIIeQcuCAPkBe
 uQkEpBzAis8j3ZfRa3sU4H78Qi6Lr4p2OySkXapQ0z26mVeRl9w/
X-Proofpoint-GUID: yt1dNFROD_hYeVglMIEHT-jt6-J02qQB
X-Authority-Analysis: v=2.4 cv=OKwXGyaB c=1 sm=1 tr=0 ts=6a45c046 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x0eKOSpe3m1H3M0S9YoZ:22 a=yPCof4ZbAAAA:8 a=UxPBd3nWClNUcXyx1RAA:9
X-Proofpoint-ORIG-GUID: yt1dNFROD_hYeVglMIEHT-jt6-J02qQB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDAxMiBTYWx0ZWRfX3RqyLGINofr7
 QFDEg6nI+Z5X55BTOa3AzOjJvbt78gh4wjEVD+2cRdMzDLkkbdRe8ilILoe8y4kJDdJRnHjYa46
 /dpngazFvIwJ79sf7W7PQjNJJIUUd7xMOEBBhFF0/d1fLLHU0o5taRRTVxLe1L9vDG1Ywc+mkK+
 DZxx3u+/QzXm6j6oKNoLiyJAnnHUH6Stq0BoRu+9lNPEcxNQDE2FVHIGLIZ6+nIPL8huQzgwck1
 +bVtNC5EgAw2rPsHZ3bQtZy48g7mal9AOSDPJo96lIk9WOF/VItUB1c0g17VkDaGRJ9hhZrxSak
 P2vet3tUkU1exvBFwZmt1V3oYUhUXOsKi3drfN3jwIGRUwdord4RoxPW9/IrA1kz4dl9VcP1Fwv
 Rmc248LqmXTvf+Yp+Z+ae4w5ndBiJlvAcTW1u7wGx6DD1zH6RvE5d5sT4bA9HWLrlsVNI1sjMbJ
 FHcYMNheu4PbQK+Cn1g==

Add success and failure case tests for smp_cond_load_*_timeout().

Success or failure cases depend on the expected bit being set (or not).
Additionally in failure cases smp_cond_load_*_timeout() cannot return
before timeout.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 lib/Kconfig.debug                |  10 +++
 lib/tests/Makefile               |   1 +
 lib/tests/barrier-timeout-test.c | 128 +++++++++++++++++++++++++++++++
 3 files changed, 139 insertions(+)
 create mode 100644 lib/tests/barrier-timeout-test.c

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 1244dcac2294..bb499c316caf 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2406,6 +2406,16 @@ config FPROBE_SANITY_TEST
 
 	  Say N if you are unsure.
 
+config BARRIER_TIMEOUT_TEST
+	tristate "KUnit tests for smp_cond_load_relaxed_timeout()"
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  Builds KUnit tests that validate wake-up and timeout handling paths
+	  in smp_cond_load_relaxed_timeout().
+
+	  Say N if you are unsure.
+
 config BACKTRACE_SELF_TEST
 	tristate "Self test for the backtrace code"
 	depends on DEBUG_KERNEL
diff --git a/lib/tests/Makefile b/lib/tests/Makefile
index 4ead57602eac..291cc9d1bf76 100644
--- a/lib/tests/Makefile
+++ b/lib/tests/Makefile
@@ -21,6 +21,7 @@ CFLAGS_fortify_kunit.o += $(DISABLE_STRUCTLEAK_PLUGIN)
 obj-$(CONFIG_FORTIFY_KUNIT_TEST) += fortify_kunit.o
 CFLAGS_test_fprobe.o += $(CC_FLAGS_FTRACE)
 obj-$(CONFIG_FPROBE_SANITY_TEST) += test_fprobe.o
+obj-$(CONFIG_BARRIER_TIMEOUT_TEST) += barrier-timeout-test.o
 obj-$(CONFIG_GLOB_KUNIT_TEST) += glob_kunit.o
 obj-$(CONFIG_HASHTABLE_KUNIT_TEST) += hashtable_test.o
 obj-$(CONFIG_HASH_KUNIT_TEST) += test_hash.o
diff --git a/lib/tests/barrier-timeout-test.c b/lib/tests/barrier-timeout-test.c
new file mode 100644
index 000000000000..4226fb6456b3
--- /dev/null
+++ b/lib/tests/barrier-timeout-test.c
@@ -0,0 +1,128 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit tests exercising smp_cond_load_relaxed_timeout().
+ *
+ * Copyright (c) 2026, Oracle Corp.
+ * Author: Ankur Arora <ankur.a.arora@oracle.com>
+ */
+
+#include <linux/bitops.h>
+#include <linux/types.h>
+#include <linux/sched/clock.h>
+#include <linux/delay.h>
+#include <asm/barrier.h>
+#include <kunit/test.h>
+#include <kunit/visibility.h>
+
+MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
+
+struct clock_state {
+	s64	start_time;
+	s64	end_time;
+};
+
+#define TIMEOUT_MSEC	2
+#define TEST_FLAG_VAL	BIT(2)
+static unsigned int flag;
+
+static s64 basic_clock(struct clock_state *clk)
+{
+	clk->end_time = local_clock();
+	return clk->end_time;
+}
+
+static void update_flags(void)
+{
+	WRITE_ONCE(flag, TEST_FLAG_VAL);
+}
+
+static s64 mocked_clock(struct clock_state *clk)
+{
+	s64 clk_mid = clk->start_time + (TIMEOUT_MSEC * NSEC_PER_MSEC)/2;
+
+	clk->end_time = local_clock();
+	if (clk->end_time >= clk_mid)
+		update_flags();
+	return clk->end_time;
+}
+
+typedef s64 (*clkfn_t)(struct clock_state *);
+struct smp_cond_update_params {
+	clkfn_t	clock;
+	bool	acquire;
+	bool	succeeds;
+};
+
+static const struct smp_cond_update_params update_params_list[] = {
+	/* mocked-clock updates flag inline. */
+	{ .clock = &mocked_clock, .succeeds = true, .acquire = false, },
+	{ .clock = &mocked_clock, .succeeds = true, .acquire = true,  },
+
+	/* basic-clock doesn't update flag. */
+	{ .clock = &basic_clock, .succeeds = false,  .acquire = true, },
+	{ .clock = &basic_clock, .succeeds = false,  .acquire = false, },
+};
+
+static void param_to_desc(const struct smp_cond_update_params *p, char *desc)
+{
+	char *clk, *update;
+
+	if (p->clock == &mocked_clock) {
+		clk = "mocked";
+		update = "inline";
+	} else if (p->clock == &basic_clock) {
+		clk = "basic";
+		update = "none";
+	}
+
+
+	snprintf(desc, KUNIT_PARAM_DESC_SIZE, "smp_cond_%s_timeout: clock-%s, update=%s",
+		p->acquire ? "acquire" : "relaxed", clk, update);
+}
+
+KUNIT_ARRAY_PARAM(smp_cond_update_params, update_params_list, param_to_desc);
+
+
+static void test_smp_cond_timeout(struct kunit *test)
+{
+	const struct smp_cond_update_params *p = test->param_value;
+	struct clock_state clk = {
+		.start_time = local_clock(),
+		.end_time = local_clock(),
+	};
+	s64 runtime, timeout_ns = TIMEOUT_MSEC * NSEC_PER_MSEC;
+	unsigned int result;
+
+	flag = 0;
+	if (p->acquire) {
+		result = smp_cond_load_acquire_timeout(&flag,
+						       (VAL & TEST_FLAG_VAL),
+						       p->clock(&clk),
+						       timeout_ns);
+	} else {
+		result = smp_cond_load_relaxed_timeout(&flag,
+						       (VAL & TEST_FLAG_VAL),
+						       p->clock(&clk),
+						       timeout_ns);
+	}
+
+	runtime = clk.end_time - clk.start_time;
+	KUNIT_EXPECT_EQ(test, (bool)(result & TEST_FLAG_VAL), p->succeeds);
+	if (!p->succeeds)
+		KUNIT_EXPECT_GE(test, runtime, timeout_ns);
+}
+
+static struct kunit_case barrier_timeout_test_cases[] = {
+	KUNIT_CASE_PARAM(test_smp_cond_timeout, smp_cond_update_params_gen_params),
+	{}
+};
+
+static struct kunit_suite barrier_timeout_test_suite = {
+	.name = "smp-cond-load-*-timeout",
+	.test_cases = barrier_timeout_test_cases,
+};
+
+kunit_test_suite(barrier_timeout_test_suite);
+
+MODULE_DESCRIPTION("KUnit tests for smp_cond_load_relaxed_timeout()");
+MODULE_LICENSE("GPL");
-- 
2.43.7

