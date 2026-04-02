Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A006B244665;
	Thu,  2 Apr 2026 07:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775113358; cv=fail; b=eN4QCdshor2EAoJl9xxfJazpiG/rMx9CJYQlkrF3dvXp+gVdjDtoYapuNbfRtkcKysI63M/2kDKqXI95VFWrcNGMSR2rN63vjdO9VflrfyTGZo38c5CV4ae6V5V30bQx7C/R+kwwrkVZvwYdR6W8mDC6pjOkK2fNQDghnpSXGW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775113358; c=relaxed/simple;
	bh=7mymCDXreXtenHcG6ZaO4hTll64on3VOmCuHcUcnm/4=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=klXs05XGjOjeLqB1ugQjIbEyH/lafNYTzd4GHwJRr/YsWF7AoQ6VI5p9vMmnqKw35bFhDsT5GDgXEhLxr1bmtxcQhdOF1+iYpuviXX639evtZytRktHLo9kDh5OQH/UQWvktHrE2hwVAP9jNLY6tITi51qtGS4ss24WNTG43pJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ExaPv28B; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gxlL+Xbq; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ExaPv28B";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gxlL+Xbq"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6320TL7a897391;
	Thu, 2 Apr 2026 07:01:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=iYAl1fvFqOQ8GHN/37
	KbIWRIR6B2/lwLHHZ+lUgrqew=; b=ExaPv28BouTW70SaXWt68/42LRHbZKGSAt
	h1FONS6/fA11EXpbJ0ButJ1XSnL+tCqDXIRS/DYTE5tZcJ26izr8/0WwcBtKxHqb
	6iYYYfQ0zlGuxfCgrmMw0keCw0qSe/LLzUJBk+o82bkGDLCZ/uTuNG2Sxk0lXdQC
	Fahpq49iLbD5jKZYMIgIhbScJq4OyJAfSvh/NYacLik2Q6KlormUzSxeXfcJPk3c
	XomhUBGFEQuTFk7I5uT1ZPoAjKJAo1wpEemBAV4KifdVGur4zzTZ7IypRohKTbvf
	ONT/2dam8+C+ejcMIoVsbwbO/h3pNfCmObzgVPgSZd7AlYrAuW0w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d65daftcx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Apr 2026 07:01:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 6326INZ1027511;
	Thu, 2 Apr 2026 07:01:38 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011023.outbound.protection.outlook.com [52.101.52.23])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4d65eccyhb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Apr 2026 07:01:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xgRPSIZ7pDlvjGBYksFpIL6vExjHh1fJEOU4pu4OwtBb93sxNiITiZ+PG42rurq2UrWlFEpvb8NEhAu6Ac/lbtNs5yQOKtpEKRNdKgM1gYJuuWcw0sQbfjme95/Ls/pOzGWOj823ChOkCJkSeqEwJOfSrq5ooLH3OqyK4vU/EgmyQOeRzyLABgieUL3AZbkIzg4eJd/tfEWGM2ap8Nj9BpY7kzgiOp/YFYuSXmDJMKH3rmdLjjRnNTCgG30Pr7isie9VFTq6/EeAmK8vK2HJ4PSzUbh4Wrfm51GmD/3zCqw2y46Nd3ZjzL10tdou5lWhmJBgjRm2RLVjuxojsaNBjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iYAl1fvFqOQ8GHN/37KbIWRIR6B2/lwLHHZ+lUgrqew=;
 b=eJs1/hVlfq9MU6WQqXg9/LRQvvdl5FLvWYGpTp1J3dlo8fXxb4UFa1kFebuyj/6jRjFH/Lm3R4kJKZzv2Tj91Yk27n8w8ZH+H6P8asqT0lOIY9WUtOZhXrpBpa7pxM2EXiLNJvR+FSVmZ7r6TBijYTJyNmBCgLoyMFf/B76YTGABrBjsZEAWaGA1bCtdOSZOqX4HF5sthMY8jEDfJuRP0vMLV4VkIDhMN7LRZ4nSfLCELwkrrHHnSzEvZ9jMk9LT26Yg1AlWlIW+i9x95Vla3yeAJM/sWUVdLVg8+9Ndw7h1WgWCPp5Qgm4n38vRs/CXedfae6vp4O4O/Kez6YZObA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iYAl1fvFqOQ8GHN/37KbIWRIR6B2/lwLHHZ+lUgrqew=;
 b=gxlL+XbqNsm1xv7reHEI9FKHaIqA7z5nGmdyjXf5FVDbspX8Lf2gtQH46sLelm1kXtQgc8m1mjYqcbnOWmvYftvB7qJRf3V8km27wvr+bd5Vp3gBhLFKkbCElswDzH+uL6mgehCP6xZGGucxRsejXis8NmIVqmrF3YXFmRa++zQ=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CH3PR10MB6713.namprd10.prod.outlook.com (2603:10b6:610:143::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 2 Apr
 2026 07:01:33 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.20.9723.022; Thu, 2 Apr 2026
 07:01:33 +0000
References: <20260316013651.3225328-1-ankur.a.arora@oracle.com>
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
        konrad.wilk@oracle.com
Subject: Re: [PATCH v10 00/12] barrier: Add
 smp_cond_load_{relaxed,acquire}_timeout()
In-reply-to: <20260316013651.3225328-1-ankur.a.arora@oracle.com>
Date: Thu, 02 Apr 2026 00:01:28 -0700
Message-ID: <875x69rgl3.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0142.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d5::17) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CH3PR10MB6713:EE_
X-MS-Office365-Filtering-Correlation-Id: 0285f331-79a3-49e3-5a0a-08de9085ab5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|13003099007|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	0Q9tu7vC29X5XTDtrf1hjCXqaY0ti+3YyMB89iFS7E/MHNYiFt5Klf5XmLdS/CJoyPC9hejlw9QpIQd0NnPDNw0/FK14yzQIfWTY/TCP1B84x5QQVnHStm8+WSByztIBsXxWmZv+tUboNn7UrbE0FOY9oF1H3fmK60+qxvuvQ/NWTrrNcj93LqYpvpMy3YLpCjhgQ/QGG0vWbsNNwVxf4jkwJNCMESjnPIAJUMKkeFg2B0whwB+wRYMUzwm4gJgpnA8YYtHF5U8Z6AK1VDhHfI9k1KnwBogc+UggTMdV1aTXPw7uTZWHxzzJCID+UrzmyDZaVpwJTBTkZHquuVbfdwIRxC/9vbEZVT2Y3TNpO/OsfHTJ/Qi6tMMx/BsRz7ZIaKNUykYVKWtwPgfyfQgX3qyZN25aMSb348PPQ8LDyiLjuRHGnR9zjyukASCpXGqUdwArlHeHhLmNCHMK7YJuSWMC9pJ2f0XcbdfNopKNBTzI5HV4MFgrJO67iHk+IajpenqTcvOio9nz9Tp9+reOF/O5rTzXcT5EJ9D3VyQhOy/nQdaX5SpRsYNQic08mFnD0QqgH2JPZhZe+21zcKUeJh1ybtVyW2ItXJlhXM/CB6m/E3llAPyqnIUupZ7H8orqpcQPTqJGLLeqNmF74/bbMFGb/HzwY0o8RHwUQHQ+Ru1NPov14z8G05bu89DrIo3US6rckm5V8cwyx70yATZxZMXvSF5SD77tZnf5q+ojNbfPTEtnsdILpyG3paDGIjRo
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(13003099007)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pO68AoM7+8G2JeY14nqoLVSyCx7TLUuTMRXo/t2gjmJY+WOaJ+e3pbjI+Q1S?=
 =?us-ascii?Q?kWXjhd983I/4VJMGWnLakEN6Cm4iA0UMObPNyHT6Q4cqCDAOpEGYmq9JObKc?=
 =?us-ascii?Q?0yX9xL0fhri4rfmxEDhlq/j/Ux+bEPydfIFTAniAK5nIBY8J/pmU3kEa9XRb?=
 =?us-ascii?Q?V67a08nCK+VmUPj+45Wn704hOXPo40pzvjA6U6ihTjIGI575BA1gs+S+zZXw?=
 =?us-ascii?Q?R/RUJ+7Kfyyw5d1Ju/oCoY+fxKDwJpuEMXPY6d4ZZ94CLZBxPzMew3MDecUz?=
 =?us-ascii?Q?8lCWAi6V0w6Y3/Z+cH39NBXUZGB4fOkBN5L/4t9/gFMDTz+X+GrAMcEyCpaz?=
 =?us-ascii?Q?odTaaYhV6oSrX/3ZZRhoGv/fgG/5Qu+ULemtlE4Wg9Jirf2lIDxSa7PkYtof?=
 =?us-ascii?Q?6Cj8EzQE6cvuT1P0U8pFy6Ij++YTkCPh7STvwuzYDhdfXvgVPvOhqJhhwAEj?=
 =?us-ascii?Q?G2b0SYsiNmqSKbFZ8oVW5qeVar7gMN7oVIhdapoahnxCxmkW/uHp1ReVa5zW?=
 =?us-ascii?Q?iSft62NsuviKSe0+FhcB0y/P0H0Zhr8ByJQQqbNQpfTeOPlWaf6GrTpS497B?=
 =?us-ascii?Q?60eXPZR+Sbi8fgAFf/1OgYu1TX/OWfCIulMFORqP0MH/zSa5I7JFyn1eJGjh?=
 =?us-ascii?Q?TJwbw+NS7Z/FGNs3qgS2q/dSuCK7bPzUu5r1hrQljAYfpCVU7cw5HsI49lku?=
 =?us-ascii?Q?OMOyzHDHiOA0cmaCS9sY0nVArQeIApOlYCPSJikX7xqQSJNxCHjFqoJEcoep?=
 =?us-ascii?Q?NHX+ojlMPPTb1wu62hiMfkuad93m0GFqZfJyfuuQsMx/eX0K6RWi5WIEPfxy?=
 =?us-ascii?Q?W8zXyarEuexFe5o+Jevcsn6RJI4DABESva7j3xd9kgman8uJJ06BeLd9xQ1y?=
 =?us-ascii?Q?NRKlOoz2bs/284adA+GDG6WgQ8QYOHiuvc3FhafgVLAZ9No32/JCBmUAlkHm?=
 =?us-ascii?Q?KGT7Xhe3RH4bheMEhNwJxFPJr+EMP+naNsgoRSoMuLwjnKbXm9QaRlWzYNaP?=
 =?us-ascii?Q?WaYda+F4nNgCxojaNRhoTaPAs+W/0GOkvI6XBWmhWw5tV7iIhEQKy+tnuCn4?=
 =?us-ascii?Q?gxWZgJ+fS+PW5IUBZtpnf4PGre3nd79uhqsH9QolgitA739DqaUcTfQ34p1N?=
 =?us-ascii?Q?iVJ+vfp5e83pWxs7gyX7LerNXrYvBYqOnFfcXS+kkLpMEczilY0X19MvCHG5?=
 =?us-ascii?Q?XGPCEBmG+AqE0tfcMY7WNL2LrfSR2nTji6m3fF7eqC+KTRur/0pUmklvp8Z/?=
 =?us-ascii?Q?vo5oMpEkVgZRbd9GFzH7RANlK8TRoARiL4zbH2kgbR+lIrfEDAfFDuLdi6Gt?=
 =?us-ascii?Q?Xvft/IfEj9udns3kFlgz79OFwEuSfYQiePcOhp9dHzsHPC2nX3NHBREHxmIm?=
 =?us-ascii?Q?SkLZS5/JBE20tNRU47r8P3+Yq1wqWWS9Sxf3B/dm4C+TKmL3prix4RQp7SSs?=
 =?us-ascii?Q?EPvyVa1q/XoN7IFHTbxt1F0OqBzMFykx7b0DYbDJyZbIk//2yw9D9DPZF7WH?=
 =?us-ascii?Q?kKQe4KdB7Biz+I416adNz1QF/jfkGDWRoD10dGgCRLD7G1hajplp9rR2dLVP?=
 =?us-ascii?Q?CfHmJ/TP3KAjokOyW8Bne1VMGSqd6J2SHtqCW/A5xk9GysNZEKztOJcKmrmT?=
 =?us-ascii?Q?26zdwiZBa0spRNYe+CBkwS1fcpYvAGYE4JhOku2QvGD5UK5EPg8Ff6pwmsN/?=
 =?us-ascii?Q?SsHcX3vg+fZeyIDErwMallv1zScf8G531re+6dX9Y4ki+fokns/SUI9ajoLi?=
 =?us-ascii?Q?eGgG3m/lsyc/CZFqQxrg8VCSWJBvQnI=3D?=
X-Exchange-RoutingPolicyChecked:
	grp0+YkeKGCMOrFDwTpMBz4W0W8CHa2VLDvhVFTOr4o0pXMjRPcPQZbChcutQ28FxUTAAzOcAZBoOKIfYn70hhlr797oLinor12y3Ravx/MhNySGtE7zPzkpbEctvAmvaGsuF5l71CfZzPPPQBvnjQuX1FCwQ/VSoad0Gr7bUmFdaA1KSui1dIeVhdGQ+7dXlqf02yuZD8JbPX7+cTHY+tGdgTI6RolP7Z+aCNekGqanACVWTdKWaDy8xS3LE3hlHaI4xGYfgDdvi4gcq1uwujJ6nl45Cqbhl9eJ2y4zxJQxg6Kv8LFqUYQ44KXdnL5ijrXFCOlVvgBSfxCv7VztFQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YPRYMWBJNhOfjsRgjwjep1Jpv/BbgMQulzvEW0G1zwHwBuV1N7kTJbph+gYnc4mRsuh3m/8TIgDgAN6ssLAb8FCsod1ocQClIr9GBObTsOh2uQKSjD6WIjR/Go3MdyMgaLdiW4GxEiE9ihUBwqJymO0zc1p3D174U6p71T4jODZrIQgQ06DGFqzEO1WQ4X8ggYqXxPIquj20hQTyaEVw4nValTIiLVDe/jc2ibeXATJINg26OcOp4GAH/iq2UC/LfiOMtbehYJg/6fj0lR3YWIm1hCbVKi2223PPQNMu8Z8VGDenf+IK9TK9w/9yB7LYqQKQKxa72+nKt4Z9JDWMrf5b3HgQVNYASsdlhVJDztbB/wYHY7tQLvFzgyfNEl3Ml+au+D1lIy8Bx+ZTfu1+8uZXDnLQNFkqDrDqLoNBP1vVVddvMwRFctNwIQwKYnDYLXpReVIRgiHrb9d4P8kRbwOPn02c+/8UTPGAgN2MVNHifxo/abHybO3pbFPJlCnnCnshACILtyCbQbUeeUXCIn8T4NGCLdTCgmntmHWjqLRoOqZcPouYANijfk3vxCtI637qnMgDa1RXyeb/5CGIonpCzRMnPtubphEKOBxFA4c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0285f331-79a3-49e3-5a0a-08de9085ab5a
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 07:01:33.2215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wz4/RGPVdhv8Y4M2N5LCq1Sko0R5S3gvNwl1tnLXDR9eBxKe8TPGef3K0fm+2Rfyd9nQWwlX+p5iM6llleVd8BAeSm/Td5rdm0JkR6MWn3o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6713
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2603050001 definitions=main-2604020060
X-Authority-Analysis: v=2.4 cv=IPwPywvG c=1 sm=1 tr=0 ts=69ce1453 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=vggBfdFIAAAA:8
 a=7CQSdrXTAAAA:8 a=JfrnYn6hAAAA:8 a=KKAkSRfTAAAA:8 a=pGLkceISAAAA:8
 a=KPwNAUb5YfN-6pBwkm0A:9 a=a-qgeE7W1pNrGK8U0ZQC:22 a=1CNFftbPRP8L7MoqJWF3:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: cdIo-3ZcycYqeX-M2mp24vor2vusGf4f
X-Proofpoint-GUID: cdIo-3ZcycYqeX-M2mp24vor2vusGf4f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDA2MCBTYWx0ZWRfX2V87hIR3nw8g
 XWyantuT5emXOIvduouWEgGhf0WoezYiaZlTUwCYAZ1XgAnT+CDl3C4djJ+NZzNa+0PGGe8yvJB
 9eTfYtdyPP2Wns6U1Uiuk2L0F4i2N3alzR6+xBQQm8396mc/xeYk43CDYKPpBwghIGpMy8LhPQx
 eRAphAFKkqnvOw+XAQ+A8fzfm61XdyTEtOZXp6zF/FmSdNTbrnAiFCWlT8hINWwsgd66gGWx9LM
 mQcgtXOMd5ArS6kGaS0w28z4mdRLQUGXOdp8dbFDEgIPgU6M/5oKEMA3c9sgGHkgRdpcKU8xIdf
 S44OuRFQTpCeI4M9MeYnpfAk5OW79VbaQCFduGeqJaTHyGIosgEn21URWcFBey1sIGWwWPjcbnU
 8exqgldUZGEEBX178ZqUzKTOw7rwAZovyQISJItlxsgkz/I++/IxJs9MINoqntuSKbAUXEhD/im
 KnqyZWSUa5DU2dyrwIg==


Ankur Arora <ankur.a.arora@oracle.com> writes:

> Hi,
>
> This series adds waited variants of the smp_cond_load() primitives:
> smp_cond_load_relaxed_timeout(), and smp_cond_load_acquire_timeout().
>
> With this version, the main remaining things are:
>
>   - Review by PeterZ of the new interface tif_need_resched_relaxed_wait()
>     (patch 11, "sched: add need-resched timed wait interface").
>
>   - Review of the BPF changes. This version simplifies the rqspinlock
>     changes by reusing the original error handling path
>     (patches 9, 10 "bpf/rqspinlock: switch check_timeout() to a clock
>     interface", "bpf/rqspinlock: Use smp_cond_load_acquire_timeout()").
>
>   - Review of WFET handling. (patch 4, "arm64: support WFET in
>     smp_cond_load_relaxed_timeout()").

Received Acks/R-bys for the two above.

Will send out an updated v11 which adds a testcase and a comment
mentioning that smp_cond_load_*_timeout on MMIO addresses might
break in interesting platform specific ways.

Thanks
Ankur

> The new interfaces are meant for contexts where you want to wait on a
> condition variable for a finite duration. This is easy enough to do with
> a loop around cpu_relax(). There are, however, architectures (ex. arm64)
> that allow waiting on a cacheline instead.
>
> So, these interfaces handle a mixture of spin/wait with a
> smp_cond_load() thrown in. The interfaces are:
>
>    smp_cond_load_relaxed_timeout(ptr, cond_expr, time_expr, timeout)
>    smp_cond_load_acquire_timeout(ptr, cond_expr, time_expr, timeout)
>
> The parameters, time_expr, timeout determine when to bail out.
>
> Also add tif_need_resched_relaxed_wait() which wraps the pattern used
> in poll_idle() and abstracts out details of the interface and those
> of the scheduler.
>
> In addition add atomic_cond_read_*_timeout(), atomic64_cond_read_*_timeout(),
> and atomic_long wrappers to the interfaces.
>
> Finally update poll_idle() and resilient queued spinlocks to use them.
>
> Changelog:
>   v9 [9]:
>    - s/@cond/@cond_expr/ (Randy Dunlap)
>    - Clarify that SMP_TIMEOUT_POLL_COUNT is only around memory
>      addresses. (David Laight)
>    - Add the missing config ARCH_HAS_CPU_RELAX in arch/arm64/Kconfig.
>      (Catalin Marinas).
>    - Switch to arch_counter_get_cntvct_stable() (via __delay_cycles())
>      in the cmpwait path instead of using arch_timer_read_counter().
>      (Catalin Marinas)
>
>   v8 [0]:
>    - Defer evaluation of @time_expr_ns to when we hit the slowpath.
>       (comment from Alexei Starovoitov).
>
>    - Mention that cpu_poll_relax() is better than raw CPU polling
>      only where ARCH_HAS_CPU_RELAX is defined.
>      - also define ARCH_HAS_CPU_RELAX for arm64.
>       (Came out of a discussion with Will Deacon.)
>
>    - Split out WFET and WFE handling. I was doing both of these
>      in a common handler.
>      (From Will Deacon and in an earlier revision by Catalin Marinas.)
>
>    - Add mentions of atomic_cond_read_{relaxed,acquire}(),
>      atomic_cond_read_{relaxed,acquire}_timeout() in
>      Documentation/atomic_t.txt.
>
>    - Use the BIT() macro to do the checking in tif_bitset_relaxed_wait().
>
>    - Cleanup unnecessary assignments, casts etc in poll_idle().
>      (From Rafael Wysocki.)
>
>    - Fixup warnings from kernel build robot
>
>
>   v7 [1]:
>    - change the interface to separately provide the timeout. This is
>      useful for supporting WFET and similar primitives which can do
>      timed waiting (suggested by Arnd Bergmann).
>
>    - Adapting rqspinlock code to this changed interface also
>      necessitated allowing time_expr to fail.
>    - rqspinlock changes to adapt to the new smp_cond_load_acquire_timeout().
>
>    - add WFET support (suggested by Arnd Bergmann).
>    - add support for atomic-long wrappers.
>    - add a new scheduler interface tif_need_resched_relaxed_wait() which
>      encapsulates the polling logic used by poll_idle().
>      - interface suggested by (Rafael J. Wysocki).
>
>
>   v6 [2]:
>    - fixup missing timeout parameters in atomic64_cond_read_*_timeout()
>    - remove a race between setting of TIF_NEED_RESCHED and the call to
>      smp_cond_load_relaxed_timeout(). This would mean that dev->poll_time_limit
>      would be set even if we hadn't spent any time waiting.
>      (The original check compared against local_clock(), which would have been
>      fine, but I was instead using a cheaper check against _TIF_NEED_RESCHED.)
>    (Both from meta-CI bot)
>
>
>   v5 [3]:
>    - use cpu_poll_relax() instead of cpu_relax().
>    - instead of defining an arm64 specific
>      smp_cond_load_relaxed_timeout(), just define the appropriate
>      cpu_poll_relax().
>    - re-read the target pointer when we exit due to the time-check.
>    - s/SMP_TIMEOUT_SPIN_COUNT/SMP_TIMEOUT_POLL_COUNT/
>    (Suggested by Will Deacon)
>
>    - add atomic_cond_read_*_timeout() and atomic64_cond_read_*_timeout()
>      interfaces.
>    - rqspinlock: use atomic_cond_read_acquire_timeout().
>    - cpuidle: use smp_cond_load_relaxed_tiemout() for polling.
>    (Suggested by Catalin Marinas)
>
>    - rqspinlock: define SMP_TIMEOUT_POLL_COUNT to be 16k for non arm64
>
>
>   v4 [4]:
>     - naming change 's/timewait/timeout/'
>     - resilient spinlocks: get rid of res_smp_cond_load_acquire_waiting()
>       and fixup use of RES_CHECK_TIMEOUT().
>     (Both suggested by Catalin Marinas)
>
>   v3 [5]:
>     - further interface simplifications (suggested by Catalin Marinas)
>
>   v2 [6]:
>     - simplified the interface (suggested by Catalin Marinas)
>        - get rid of wait_policy, and a multitude of constants
>        - adds a slack parameter
>       This helped remove a fair amount of duplicated code duplication and in
>       hindsight unnecessary constants.
>
>   v1 [7]:
>      - add wait_policy (coarse and fine)
>      - derive spin-count etc at runtime instead of using arbitrary
>        constants.
>
> Haris Okanovic tested v4 of this series with poll_idle()/haltpoll patches. [8]
>
> Comments appreciated!
>
> Thanks
> Ankur
>
>  [0] https://lore.kernel.org/lkml/20251215044919.460086-1-ankur.a.arora@oracle.com/
>  [1] https://lore.kernel.org/lkml/20251028053136.692462-1-ankur.a.arora@oracle.com/
>  [2] https://lore.kernel.org/lkml/20250911034655.3916002-1-ankur.a.arora@oracle.com/
>  [3] https://lore.kernel.org/lkml/20250911034655.3916002-1-ankur.a.arora@oracle.com/
>  [4] https://lore.kernel.org/lkml/20250829080735.3598416-1-ankur.a.arora@oracle.com/
>  [5] https://lore.kernel.org/lkml/20250627044805.945491-1-ankur.a.arora@oracle.com/
>  [6] https://lore.kernel.org/lkml/20250502085223.1316925-1-ankur.a.arora@oracle.com/
>  [7] https://lore.kernel.org/lkml/20250203214911.898276-1-ankur.a.arora@oracle.com/
>  [8] https://lore.kernel.org/lkml/2cecbf7fb23ee83a4ce027e1be3f46f97efd585c.camel@amazon.com/
>  [9] https://lore.kernel.org/lkml/20260209023153.2661784-1-ankur.a.arora@oracle.com/
>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: bpf@vger.kernel.org
> Cc: linux-arch@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-pm@vger.kernel.org
>
> Ankur Arora (12):
>   asm-generic: barrier: Add smp_cond_load_relaxed_timeout()
>   arm64: barrier: Support smp_cond_load_relaxed_timeout()
>   arm64/delay: move some constants out to a separate header
>   arm64: support WFET in smp_cond_load_relaxed_timeout()
>   arm64: rqspinlock: Remove private copy of
>     smp_cond_load_acquire_timewait()
>   asm-generic: barrier: Add smp_cond_load_acquire_timeout()
>   atomic: Add atomic_cond_read_*_timeout()
>   locking/atomic: scripts: build atomic_long_cond_read_*_timeout()
>   bpf/rqspinlock: switch check_timeout() to a clock interface
>   bpf/rqspinlock: Use smp_cond_load_acquire_timeout()
>   sched: add need-resched timed wait interface
>   cpuidle/poll_state: Wait for need-resched via
>     tif_need_resched_relaxed_wait()
>
>  Documentation/atomic_t.txt           | 14 +++--
>  arch/arm64/Kconfig                   |  3 +
>  arch/arm64/include/asm/barrier.h     | 23 +++++++
>  arch/arm64/include/asm/cmpxchg.h     | 62 +++++++++++++++----
>  arch/arm64/include/asm/delay-const.h | 27 +++++++++
>  arch/arm64/include/asm/rqspinlock.h  | 85 --------------------------
>  arch/arm64/lib/delay.c               | 15 ++---
>  drivers/cpuidle/poll_state.c         | 21 +------
>  drivers/soc/qcom/rpmh-rsc.c          |  8 +--
>  include/asm-generic/barrier.h        | 90 ++++++++++++++++++++++++++++
>  include/linux/atomic.h               | 10 ++++
>  include/linux/atomic/atomic-long.h   | 18 +++---
>  include/linux/sched/idle.h           | 29 +++++++++
>  kernel/bpf/rqspinlock.c              | 77 +++++++++++++++---------
>  scripts/atomic/gen-atomic-long.sh    | 16 +++--
>  15 files changed, 320 insertions(+), 178 deletions(-)
>  create mode 100644 arch/arm64/include/asm/delay-const.h


--
ankur
