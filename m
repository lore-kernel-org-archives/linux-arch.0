Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFFC3ECBD2;
	Tue, 14 Jul 2026 07:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784014308; cv=fail; b=rGoLMoWJELtqbrVaO9+ejqoFo42ZwyU+I7XhCXuv/DimLBIm367UVxbQ+BCta2QjGz7uKjZVV+5A71ALWEyVRJt+S8RG8bG9By9bke3iwtVt/ptfTTGssi2xtbp2LnIJgt2+shXiF6kbzcsIB5x+uXGQ6FxxxoeRkS0Mrqb50P8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784014308; c=relaxed/simple;
	bh=bZKut+D6baTggQkQ5BccLLEj5wfmguY2HhufDGBcnrw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MOmCt0N2pRyU++SvFTsfsM3Hacz+X5GAJROOZbH08f+PV2o5X6faTUyMxgxNJ1J77+kEIRF55O6WAsGvDvrkmQOv0sxmOmR0vk0BVDh846J3C+oTxDQMXVb+RTJZTHySisLFBJXmED5s5Jl1r03b7e8F9FEdxgM8PXZJZocYw6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AjGvA66c; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Siyvc8nJ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AjGvA66c";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Siyvc8nJ"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DLCkk51376086;
	Tue, 14 Jul 2026 07:31:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=gB/bbdqh/0Sfqj/AUZ1l/h5lMgMMBqCVKXeuXLr0klk=; b=
	AjGvA66c2+DRBeuvkQulJ05tGGQMsbVTJkj++q/CYD0c1AKGtfok5J0fyuJkQsqV
	mZ3ZhhJKlMYxJRKPxk2vou0hYq0xfz1QxAeTq6sl/HtMeVug1sK/69VVu6swWUaQ
	o8ims3iFnLmjubQHYhQeblKDUJfWBw2VhdXZB6is6Xf8ILyf3OCoXpkuDJOWV19p
	2L5edtE18ME4lXUtikaLYnewfFmq28Bcs2SM+mVcwHXKhJQ584pVC96VNNoKpj2a
	qjfr4JwNLvPT3nJG9Mt6UBz6bmISEx22z4jZpkpQwhIx4hd1aJMaqvsfk3iBZJoY
	gv1GblLAGqJTljyAY/8EmA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fbeedkp10-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jul 2026 07:31:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66E7Scd1028621;
	Tue, 14 Jul 2026 07:31:23 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010017.outbound.protection.outlook.com [52.101.46.17])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4fbc9r4gk7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jul 2026 07:31:23 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l3lnynXSG+/LyiTJjjmY2CFPETK+mTENwhDfaCNzvCljYdb1waPi/aUKk3HTU1ej4xUuHpfp7rbb35GAqgvMMMZmrr62UOQxPgZaGfahazJSkASYnC+wFXb6CTAAXqQWcYr+KHYwCml2+3s0FRhYQ7VJr8b160xro4bdlPqs/jGzF9Da5GYkwat+7hQuAMAajcw4Ct3r5YBByecLzRT75CUCIDK2WU5vRq//2vB+Yz2MbFmrECC2MVVYTsdU6SvZEMUORuZiBZCBegnCBCPvNEqzgFE/a854KmsZaGNhNllDjPF+6BfvMoMiA87DI04PVKATFROanHx3ugbflxdf4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gB/bbdqh/0Sfqj/AUZ1l/h5lMgMMBqCVKXeuXLr0klk=;
 b=UcVCbfvNK69TIjkF2mfMVgiVnic+cvyChVe3gwCD4VcWkPvLb02V8qksJ682vH1Tq9lsEXcDShcd+rYdUZZbLcWNprn4gn8vk4TaFaxg+ZAqN6vTCcUQDj2+bPH6h3REbu85zSvBxNi188YjMOKWkRZRLzQeYWH19ecL5PLtzEoKdUghwxkusX9DwhhXT7rJjsGK4RkU8q/jvIF7MKS3BF2umJe2/DceGL3PVk2/AWFoxvE5qwO7z4TJunnluC2lCV23fjg7tE442UCHWgQEmWGDpFgqREy3L60rCFqSVBbpjUH3cx3qdCGIHOwu2lgOAUHzsR2yEcNt8PLDsZPf2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gB/bbdqh/0Sfqj/AUZ1l/h5lMgMMBqCVKXeuXLr0klk=;
 b=Siyvc8nJe7+MI0zbgbq0BQfsCWdvK30bo1ZL69wkR9bjdw7YswvzZndAMc69C9ZdjrcTQzRIynQ8N8JSqZyF8VqoTzydoBVpsVGZhZFd7AKGQUHJSgx9NuXP2s0XOuqwYX+JzO2AvKqv1/prDqdCWNTeNOUEGGqHVfTo2W5+vNk=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CY8PR10MB7124.namprd10.prod.outlook.com (2603:10b6:930:75::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 07:31:18 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.21.0202.018; Tue, 14 Jul 2026
 07:31:18 +0000
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
Subject: [PATCH v14 09/15] bpf/rqspinlock: switch check_timeout() to a clock interface
Date: Tue, 14 Jul 2026 00:30:35 -0700
Message-Id: <20260714073041.40250-10-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260714073041.40250-1-ankur.a.arora@oracle.com>
References: <20260714073041.40250-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0050.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:111::10) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CY8PR10MB7124:EE_
X-MS-Office365-Filtering-Correlation-Id: 99d72847-6600-4e27-cea0-08dee179e52b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|6133799003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	MhSTCALWAoYCJRAQtE1SjiiC7Mp+AMqp6VE6t1x6kX2LVHtLKksZ5wePffhi9InCIfsbTNQ53WpqvHdPei68l+c9EQUA1tJ9759ugWZXoMuoMF7nwvrpS250QYzASxkQWwqMHyUu0kRjAZeG75L0FlP5f+xQKmtk/nCKU6C41GeFn0lzQF8B0DLsIQQ1fiXbr3JeTimq7ovhAcFWpwF9aQq+jd9Omve7wly/ieMVLzZ5JLsUOfVdLS6hUzC81fxa5BGnfkfVFGdeFHAcmm1OTJcy6QbpaWi+vOn09jUbHf4qv6dNdlII97k5+r9/u99r9JwkSu9/FzcTKIb79pzMwYwRXu4LHikiVoRzIowOrKeKCEtQ/kC8Mk3ZehUpLE1oXGvHhQHOPG0/CX+3DtR77/4cbKM9VJxZ4fForc9AfLDlPNO3btpqFrIXQUerH34M405uiSb74sYZ2gvvhlfF1p2s/4fzxaVmQOfMXr5o4yZ/LedAiRf7ElJd7BZfnIaWz0BUP+qxoxsCfmxt+SF7trNT0vsZrySTyYt3MGimXkBJ/MCxVv8mf8rK2M1J+BJG3bRT0syD8CIz6VEms0OTol22KhRZrcxjls6U7Ax3kOcrANIQsm2GAt3qH8MtV9OBnywL22r8nls4NgwUcOwkUEUx9a9RtZ1eX5irU1M9BG8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(6133799003)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GP2z7b0YCnR1fO72tGmyRxyaXC85+t5f7bkT7YFPdE7/+YLmjj/cjbi/wSk9?=
 =?us-ascii?Q?EA5VAmB4MyM3gvWmGsLoo32AUYLPk/HLZ/6J0yKly1Pa5GdnRMy/DlhHW1j9?=
 =?us-ascii?Q?067Fn7u/Vi1NRN9z9wKY5ozsNs0k18RTKQB4ICUn4LmRNBN1Ez9fBIgvqcBV?=
 =?us-ascii?Q?j+wQJ3WKRzDFxnHpIwQclooAxqK7q18uSAxv7AcNdzNbJWpHcbn3/1+zX43B?=
 =?us-ascii?Q?EdgBIFPNPZOLzFTk4VxPg0PCX7F1bBFCtBFJgIOdzYSScfFHoUqlAtCIQDz2?=
 =?us-ascii?Q?6olspQEqijUqswZ69lFEP6s9+GN2AyveMzIL+k9+Y4YxwtqvcZgavUMK2IM1?=
 =?us-ascii?Q?6u0ue29KLjRdjU93RNtTZG1Zp3fyoyHt76NDIxo/55YkSk+tjUhX7zoXJIB1?=
 =?us-ascii?Q?e7SBuR2PDwSL1U7dH10R/f79irhq3osICdiNa+H6cwJk6cFNFR+MP/61yPHe?=
 =?us-ascii?Q?K5wWQpHjmVfPALpz6gmhisT4L019gVXRQ8R03AMpzV+NYj/DX33Gy4c7XtqO?=
 =?us-ascii?Q?ODD0IpaG53AtKCc9yTwztt5nBVZnDT7LV/YBS56NCgTVfBOHrmMddCB8Nk2T?=
 =?us-ascii?Q?JNFGR3OAZcyQ4AKGGlxjnl7gKH+O/8zitsNa3wpTH70RhSL0Ua1oTLrvPMjL?=
 =?us-ascii?Q?mxuHbB3wANm8zbbOfaxZbaGVpGUw7J2ywCLS8cE22lyGob3+bIdsI4C8WKkw?=
 =?us-ascii?Q?1FjZW37Oj0HCe//VrsBBRrHETEb/+D9uYD3IEsSRzFUe06kyUcLDkIXipHNc?=
 =?us-ascii?Q?sWJaUPWs9wMZWAiElE7L5eoNNCC4Fv+L/RkFgoZdQIJlSQ4b+LGZLr1NZIoj?=
 =?us-ascii?Q?wrOPsrOGTtttECuB1dIFCp5J33kjdTLIb13K+hNZWgovEIrS0vxWUVRwhpEG?=
 =?us-ascii?Q?iP9V7ABYt1PrVl5gCdzw0rzEVhQjXF0Hyo/YHwFMQxJYSO98bvzfJkJUnhfr?=
 =?us-ascii?Q?Uvu5+9OLN1B+39ayBb9s6k8G/PlHy/MI4KPjzwWd1uQXCNpUcL5bHT00D+C0?=
 =?us-ascii?Q?fnL8zbmCcQytsapEa1gKerKSetDZLZ279LU5V6zHExJLIvObuaX5A4NG4nAf?=
 =?us-ascii?Q?s7KRn/1uPoks4xI0uH5ZeNqb1WmrIGUygyNSjGGlTY26neDoU754mxA9JrmE?=
 =?us-ascii?Q?bQoN5GWG/R2JtiG8ExnWfnSB/vMdN+F/AzU5NSO5bV/aKBUtnvAoO4mSgiSP?=
 =?us-ascii?Q?JpLmSxlCkRX7+NpHEMSGHxoMsjzsegJbum4SFfMAKkpS2fxXJf9dmQCBDCph?=
 =?us-ascii?Q?zjhWk3Nf4BfFudOLuPEmRkhab5tgG5tbcio+mKJ5yHed9zUQDby0do+0fy6l?=
 =?us-ascii?Q?GwpCxW4CQamjVo5Z1DJLZGzzehe3kVXMmeusMSASxB6BSb9ttnlsz+uM8jYE?=
 =?us-ascii?Q?11WEFajsbweXsKEOJ+HlZ2hyBKiP40WORM44lBRmW9Gp/KQRQqDJS6kCf+Pk?=
 =?us-ascii?Q?p24csApItIP8HU+zaWHZXrvQ1MUYU+jUEs1f7K8IW1Og0WDwhkrA/AOmBG6l?=
 =?us-ascii?Q?uStFFC2e8V6O5Spfku2pudv44kCZjjksxe7rYQCtUgDMV6q8t+MKVgLW1Nn/?=
 =?us-ascii?Q?1040Z5bcCArJq9vLalTVfkxl6/p5aPRASrrzo/KGV5aBE581qduUMJo9yveD?=
 =?us-ascii?Q?HCJeM0OEO5TH9/3pzC6VyTlAniSniGB+pD7B46xXwAFBY7SCC+CduLIaRZJX?=
 =?us-ascii?Q?taWdhbs3NJG7U7tyJELGUqt3HtSNkpjZSeUrzbhaHxrHnGFIb7frXCZFJ7UF?=
 =?us-ascii?Q?/Rf+I4bx7A=3D=3D?=
X-Exchange-RoutingPolicyChecked:
	Cm1xASPh2j6WklAM+KNtBYKCJRG3oldPIIMG6aGQJgjADES09s3bqnnZUaEuB3AMk1fVFAOcvOiF7XUgStVrRwQbuAE+3kO5J7DuO6q7ZWrrN6ojs0Xn06gI2by5zTzOlGg29pBjImUlShJm17kSDXBYJILPLPJSvojFVIqbVp8uel3A8H3wcenen7fDTgbOTCmtmCQoz7nfXekxrZlwA89UKpEwrgerInD5IxZhPLXKl8ZgbNo3ka+ngO3SVl882sF3YbkkimXEo5gbkGZY/JeXCjMBWpoQyyfWa8BMAZO2Nanq2OeibWHUsudiqWTxsDEJM7VOTeJpaJVUhEMqsA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aoIitUPd3z3N3CjyOHpMpo1XhAkY0gXpkTXE4pRJwZNv9qKrwtFmE0BUlKzrt6QYUcHG+EOSbsiLW1yrzqJMrjIf9ybKVMzGYDcxmXuPPvR3gmOfiMmCriELSa69aGcMA5B5HfKrr9gopbBD0AtX6ks+9Po5iizOE5Z6TQ7cTwBiQO7xMi4s0ImNDrqGAa60whaRDmJOdeD4JZlq2kClJhK5OyN44R6Vg91/fJD6106wPrEZk4+5tCPjByDvP5/OgP+d8hrQAybjb103WqXl4t+pUFluPpEFxkU6H7lBAvRNstwsfgef+6b1pCuECA7ZyBsBQWK0z8O6BzT2HxgPbA0tOZ1L1L2+qrB24/zHBiHgNnma5sgkDYub5m5zo6Lg7DKFCt02nCz8l4TWOsbpTzBglSzMX5PPFyujqg4sZcBdn8eRYw53ZjUNUn31TCe9ZeEbn6u6mTBz+ZO+L6JTDycxJbdEQFkHKBP7y6Dfw+DCI/TZYEDh3iXwB+pXPy2aVBktnRvQM0JhgIOiJoWMlPxSBPtVVX1jcAboF4PC7UNYUicagZ1I476D9Hv6vJ4pWmaD6b0+Yjr4CGqOpmNutG2or06escitr/+ON+s4tAo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99d72847-6600-4e27-cea0-08dee179e52b
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 07:31:18.6724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZDdBE52Jfm7at+HOS/Uwzd0t35UxLjV+Es3237WgoQF9n6m1mMsL4dNF5se7dePqbB2hb8e2BwdF2HutFKRSlquNqYLOl18UlvaNeOj07u0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7124
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 spamscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2607140076
X-Authority-Analysis: v=2.4 cv=d+bFDxjE c=1 sm=1 tr=0 ts=6a55e5cd b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8
 a=LqkqbBbWekfmbT-3qckA:9 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22
 cc=ntf awl=host:12222
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDA3NiBTYWx0ZWRfX91k6fNGUPmls
 i/pyCb0JszElg9Fwg0A6mwvbA8Z36MmB3D9wR4kjoTWawa35Q9OmnASv5bReHepDYRTweFqVAIf
 TNT6MwINL36LWEB80jUUYbcd3ixfNqHZr8iOU5ynhCKghIN9Q8PJUwSsEtfHN5676h2eejcejnO
 uWLBgnuqtOlL5j1n1jr4wv6+sfywWYeclvPqHlEXghRJinTB+3oujMV6p/yhXboDmszBrJ4cSva
 FzxG+BmJdBe3E5sosd5B6hr0ZmMUxGZMw7reGnKHznbgaOwTiS63BfDrARzcuwS4lBvE5z7x0nQ
 itj/i9YCUT5WX1NKL3khsz93+YJjL+m0P/L8AKuD2+VKDwOeiB6VTAAvHwbHylfZfJQ/AKiD6ox
 8/A9CAcNh8RWcSPNnpV4Y5kl7vpIIeHRnvR4Ip+976rttWMUJNAPP/YQGrCtvBfzvgxiYeTZOE8
 viBIdCCbaVOk5ht7pC+xfhRigAjBi6upXmx6RIIM=
X-Proofpoint-GUID: iCJ4he-xDupIPSxAGLGSE_cQfPESqfcH
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDA3NiBTYWx0ZWRfX4oSWPjGAyXkY
 madZWFd6RR1XxUUiuqKiOWRSSsPewago37/+WxjlM2W+8K07m0vkO+l7+np9zKY1YJXFod7Vjg7
 lbbYkOghmWNvHpNvB45rvYKufacVzJtR7FMdAqvaKv4pzaoqXEU/
X-Proofpoint-ORIG-GUID: iCJ4he-xDupIPSxAGLGSE_cQfPESqfcH

check_timeout() gets the current time value and depending on how
much time has passed, checks for deadlock or times out, returning 0
or -errno on deadlock or timeout.

Switch this out to a clock style interface, where it functions as a
clock in the "lock-domain", returning the current time until a
deadlock or timeout occurs. Once a deadlock or timeout has occurred,
it stops functioning as a clock and returns error.

Also adjust the RES_CHECK_TIMEOUT macro to discard the clock value
when updating the explicit return status.

Cc: bpf@vger.kernel.org
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 kernel/bpf/rqspinlock.c | 45 +++++++++++++++++++++++++++--------------
 1 file changed, 30 insertions(+), 15 deletions(-)

diff --git a/kernel/bpf/rqspinlock.c b/kernel/bpf/rqspinlock.c
index e4e338cdb437..0ec17ebb67c1 100644
--- a/kernel/bpf/rqspinlock.c
+++ b/kernel/bpf/rqspinlock.c
@@ -196,8 +196,12 @@ static noinline int check_deadlock_ABBA(rqspinlock_t *lock, u32 mask)
 	return 0;
 }
 
-static noinline int check_timeout(rqspinlock_t *lock, u32 mask,
-				  struct rqspinlock_timeout *ts)
+/*
+ * Returns current monotonic time in ns on success or, negative errno
+ * value on failure due to timeout expiration or detection of deadlock.
+ */
+static noinline s64 clock_deadlock(rqspinlock_t *lock, u32 mask,
+				   struct rqspinlock_timeout *ts)
 {
 	u64 prev = ts->cur;
 	u64 time;
@@ -207,7 +211,7 @@ static noinline int check_timeout(rqspinlock_t *lock, u32 mask,
 			return -EDEADLK;
 		ts->cur = ktime_get_mono_fast_ns();
 		ts->timeout_end = ts->cur + ts->duration;
-		return 0;
+		return (s64)ts->cur;
 	}
 
 	time = ktime_get_mono_fast_ns();
@@ -219,11 +223,15 @@ static noinline int check_timeout(rqspinlock_t *lock, u32 mask,
 	 * checks.
 	 */
 	if (prev + NSEC_PER_MSEC < time) {
+		int ret;
 		ts->cur = time;
-		return check_deadlock_ABBA(lock, mask);
+		ret = check_deadlock_ABBA(lock, mask);
+		if (ret)
+			return ret;
+
 	}
 
-	return 0;
+	return (s64)time;
 }
 
 /*
@@ -231,15 +239,22 @@ static noinline int check_timeout(rqspinlock_t *lock, u32 mask,
  * as the macro does internal amortization for us.
  */
 #ifndef res_smp_cond_load_acquire
-#define RES_CHECK_TIMEOUT(ts, ret, mask)                              \
-	({                                                            \
-		if (!(ts).spin++)                                     \
-			(ret) = check_timeout((lock), (mask), &(ts)); \
-		(ret);                                                \
+#define RES_CHECK_TIMEOUT(ts, ret, mask)					\
+	({									\
+		s64 __timeval_err = 0;						\
+		if (!(ts).spin++)						\
+			__timeval_err = clock_deadlock((lock), (mask), &(ts));	\
+		(ret) = __timeval_err < 0 ? __timeval_err : 0;			\
+		__timeval_err;							\
 	})
 #else
-#define RES_CHECK_TIMEOUT(ts, ret, mask)			      \
-	({ (ret) = check_timeout((lock), (mask), &(ts)); })
+#define RES_CHECK_TIMEOUT(ts, ret, mask)					\
+	({									\
+		s64 __timeval_err;						\
+		__timeval_err = clock_deadlock((lock), (mask), &(ts));		\
+		(ret) = __timeval_err < 0 ? __timeval_err : 0;			\
+		__timeval_err;							\
+	})
 #endif
 
 /*
@@ -281,7 +296,7 @@ int __lockfunc resilient_tas_spin_lock(rqspinlock_t *lock)
 	val = atomic_read(&lock->val);
 
 	if (val || !atomic_try_cmpxchg(&lock->val, &val, 1)) {
-		if (RES_CHECK_TIMEOUT(ts, ret, ~0u))
+		if (RES_CHECK_TIMEOUT(ts, ret, ~0u) < 0)
 			goto out;
 		cpu_relax();
 		goto retry;
@@ -406,7 +421,7 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 	 */
 	if (val & _Q_LOCKED_MASK) {
 		RES_RESET_TIMEOUT(ts, RES_DEF_TIMEOUT);
-		res_smp_cond_load_acquire(&lock->locked, !VAL || RES_CHECK_TIMEOUT(ts, ret, _Q_LOCKED_MASK));
+		res_smp_cond_load_acquire(&lock->locked, !VAL || RES_CHECK_TIMEOUT(ts, ret, _Q_LOCKED_MASK) < 0);
 	}
 
 	if (ret) {
@@ -568,7 +583,7 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 	 */
 	RES_RESET_TIMEOUT(ts, RES_DEF_TIMEOUT * 2);
 	val = res_atomic_cond_read_acquire(&lock->val, !(VAL & _Q_LOCKED_PENDING_MASK) ||
-					   RES_CHECK_TIMEOUT(ts, ret, _Q_LOCKED_PENDING_MASK));
+					   RES_CHECK_TIMEOUT(ts, ret, _Q_LOCKED_PENDING_MASK) < 0);
 
 	/* Disable queue destruction when we detect deadlocks. */
 	if (ret == -EDEADLK) {
-- 
2.43.7

