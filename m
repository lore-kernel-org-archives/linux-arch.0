Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28AF2DECDF;
	Thu,  2 Jul 2026 01:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782956123; cv=fail; b=jL8MbW+C0pVfBFSPgGjGAL0Y7IKpKUgFAE/3K7l2Bu1XzQSteclu3N98IkGL8NO0Hw+4HIp2arHH9POXAEtwLf0tPHoQ3Yk8fvk30ONOncLx4tcMBsds1RNHXzPIAX95HPFnFc26jrTJa1gvwZ8GGoodRgEfeLeoKiXCA8d1NDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782956123; c=relaxed/simple;
	bh=ilsVGFgnfTU05APQjYBFaMMKf4GH5aKN4n/vSm735vs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ETw2SYXW3x7xAtQrvSuNwD3Dy/WJBXHjxav3F3sZEfvDOaBq1P2XOwsIrlO+KSBmIcH7oHouiD6BehZ2pIi7oDcKsTYEUcZI97Fi8Q42zFUS3auhfuSxMFeJwhKaoa2WkuIfmeLWyVFZLPtYENWJG3eFm8ANbK9jQqk/1WXuze4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aMge0CJK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XfibHBqZ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aMge0CJK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XfibHBqZ"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661EL3xV3058417;
	Thu, 2 Jul 2026 01:34:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=+MLP5yM/A4A81s6dRxuY3RHkqdeIHMR2A0iQnrOHkzo=; b=
	aMge0CJKpYGJB52K/cjL6hy6vkCz0qcwa1jh8IV1kVOKhFkbNaeAaTsyRXt+mdAw
	CK7k+ZV9LFCCLD+/cylssi3MZkdeYB5N6crEkDsQS7lfreT5MXoUDC2lu6etHm2B
	sbs2Cv/skicO6WDCai7UEVAhflnFc9rAzTKsGyWdkIT0rexvqzgbsuQVAXd591b3
	+AT4wcKc0VmjnOo0yw0Ke5YD61Xi66wdTBPx/eB5qa7++xx+DixX3XQEuUdOc3n2
	MEuG6fa7CTd2QlY4xn33pyCSfuEYQnwSDR9ldCpqH+1zs1okGB2Xtz/e7g2Rk5Wp
	tsLiMqwdoUk2b6CnOmPM/g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4f26mk77mt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Jul 2026 01:34:52 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 6621X5u9036103;
	Thu, 2 Jul 2026 01:34:52 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012069.outbound.protection.outlook.com [40.107.200.69])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4f50yt4gnq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Jul 2026 01:34:52 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fwNR+dcjwpUD5pfCzWZHWIiI6cyTjyqFyYppOq3+byUTMlNu+XLEST1/xXe9L9FSWCughx9v9VeGeUWzTWihaFe1VvjpO0xJBSwk4D0qFWh6hz3/9pL4MCuhzARKd0hzMsjlEEFoRr6xkNK73TLgL1HnRJRN1drQiP6Dzf6Pq12i4jjq6pPnFEzYBJdqChLtqJVNeGUb2uMnqX5oqT29KRor+lHfywuSKvt91CxQx0aSMgS2gFnsScpdQXYrk0Exviee38ihtgq7vjN9LikrMaKjWWa7A4SQdoiH6GBznelKWgYWz7eunh69FuFI7di79PjuVqHK7frjktOp4o7pNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+MLP5yM/A4A81s6dRxuY3RHkqdeIHMR2A0iQnrOHkzo=;
 b=abqMX/n+BCsIG0CWkWQ+oRQN7LfcLqxu+Wl33HVwN22wlCSLrNYZO57kIJOdduVqJuFddr5u66TMlLVIxojrI+sks4ZHFWjlw3mIo8VyY0gAn8B88pOg8/W6LuKn1SjAoIPBWndO8NW6CiPBPYKur8Je3ZgwpGs3faXdBRd8ll7Q6ltNzTRli+csyzE+Vzvjn54P8LzJrfSC++Cl96l4MrzrT3AeSG5dGGMUyANy5oBrYOmTSJtqPvJBpjZl4bIfmw6FO610awhInpGBVaNyXt3V2dev7ejLCM13+82rKGhq6ekc3dupMcfYqKesDM5CH1nN1YrrA0b3zfmsW3p70g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+MLP5yM/A4A81s6dRxuY3RHkqdeIHMR2A0iQnrOHkzo=;
 b=XfibHBqZ29bYKqIFwKlPe9dmUauTl8+LMT2Z7RRVpC2WhDIBOwkFXvAzbv0vWNkBSZynyJLl0DHpIakrY/0S6NCoUG5YIjV95lkGmgsIIwyMbv5SUnxzQ17+AhRT2vu7vrcMFA9PtVAu1rmqPULWdHBWCoymB2a6T/8CCFkQvTo=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by IA3PR10MB8760.namprd10.prod.outlook.com (2603:10b6:208:581::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Thu, 2 Jul 2026
 01:34:48 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 01:34:48 +0000
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
Subject: [PATCH v13 12/15] cpuidle/poll_state: Wait for need-resched via tif_need_resched_relaxed_wait()
Date: Wed,  1 Jul 2026 18:33:31 -0700
Message-Id: <20260702013334.140905-13-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260702013334.140905-1-ankur.a.arora@oracle.com>
References: <20260702013334.140905-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0062.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::22) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|IA3PR10MB8760:EE_
X-MS-Office365-Filtering-Correlation-Id: a0f19983-429a-4324-618e-08ded7da1a88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|3023799007|6133799003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Bc7/mBp990qun4+FwHF+KmF9BsVSxMSAvh8k849dhg80SoY8hrxrHRGybx4ZckmqJ7UA0sNfwh0FLDOvjWxfZ7aF3SHlt3LdW7rcsmyYwLLHHdSWGSmubeoLRtULL0wZXCSI/iVlutJPAQElDyyRUTVoe5djKc+YCL/+w+oGou30btHpP+ALm/4Rde64Mz+x7HEZnONu/fijz3RGrTIBKl5vAQbCAIQ+nUk3BVfh25FKxQzqDfeP6VlgtdOycH4+ZxkgkhN1TqDRHxLks4Yll3T9uqDh3TS8SlXHgiLlojQl1KxVqHGzxr63xxS5DM/fxNO9ugOOx5xsnYEnNudjVnrxv4i5BjyDp3zgQvw7mqyBBN5mPJ6mzSwDo+h9wPDLkoUV5kuSYs/c5IuUh4GU42QdbhSpDZECxpeFhzLTGqWSlTj4ZvQv74xF8b+PogiGVer0JIzx2BATPOeXXXPg2ebCoVmK+71lJcG0Y9tlEkiAtFv9TDA2PDeCTb4Kb3klN6L01btjc3pSQ3750tX6NVZFxeaRu6PkPEnxu3zM83ZZS9oJGUCnXGv1jMc+StQtHCYTf1pzjkBQZq+V08LDRZN61vcizOkUsjWWQbatTI1ME9MCVWQSiZ7Kot1UKxDhG7VFWhYREDuOLHKZghmfDE6nJQhW+zic5Q8smt+tGMo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(3023799007)(6133799003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TMROOSIHtLPlXanZwg615PYHMZKsyILo75ICdG2n92ywS4/CaAv5e7OxIqJz?=
 =?us-ascii?Q?EUIKDX2H9zaIjjEkNxqxNEXYeI50+KSb+sR5epfYvmKIZblUgZUFn702PSmT?=
 =?us-ascii?Q?WDlYAOpfrAB4THXJWmkoaAa9wY2aIoTcDHMTha2wEW1IfpYhGoMXLyFViipy?=
 =?us-ascii?Q?OUxD2MApwdbYB3hUTC4PsT2UieBhzReiZG3J1F8yakCrYqzKyjfoXtp4yo8J?=
 =?us-ascii?Q?eiwi1/HpiyxaANy2j0LtjgGS1yEnCfREodfSc1FIiPyanVqNMX0OMxj6fQYt?=
 =?us-ascii?Q?9WMZ/7R6xfvXDNbD1nJlhhaKEIHDjNe1s4kQEctcC5fq/k1fevmH+WHhPvNb?=
 =?us-ascii?Q?6xaVGuuKXGbg+oKorKs+fTZ6vlyw4YqEvsAQHPnnUcW/76+ze1RtKVvgTDsB?=
 =?us-ascii?Q?1cFMEoO0RcHc11QtXC265ESxIZv0q9FRRZ8FxElC4UFfuN37aalCio/ntuoq?=
 =?us-ascii?Q?WwTdCcCl0MmIqkm78kwf8/T22XNV6xbgQOsHSMxzvDZsn1ZAVU8vgcYPLDNK?=
 =?us-ascii?Q?3WIZGr+Qmctu9NnHnAWzPOO0qPIs0SBP5EyldJkchTBZadCWKpV9bdlZFK5r?=
 =?us-ascii?Q?GmbLEJya9mdlMFh59003SofcJczIVdGACPVJ3Zpf7eAWH5v5Q/qVdG2U+NQH?=
 =?us-ascii?Q?h50WcUYcQRtEhZl9aikAkyUHpvnAvjZSGyzE9Uiinu117XX661DI9sF8Ep/O?=
 =?us-ascii?Q?rg3niWP0TwS/ASovwtDmJZHzFFyc4cokK1XGHFFrnoXqFFE7CS2NLeMcT6I8?=
 =?us-ascii?Q?V6kz3Xu70Xf+bXhT7dDDFD8MOCi9zF51TnbBjA05zygjaT7I2bmkh0tADz3b?=
 =?us-ascii?Q?OKbdSH4g9U6OCR2MWDiFzKBXHrmsbjoDmv4BiRUFTD9OTynj8Gp/chEAA3xv?=
 =?us-ascii?Q?/IZ59zRYIYio0+J66VvOC35mTVpIGwmOtI/7OCIeXvDEdlvCDzLmC+S8s9eQ?=
 =?us-ascii?Q?Barpq9efnhSuHRfhPbRHfh5Pnfpneaou06N/8san+vncHTabB/Pf3wtfkKjP?=
 =?us-ascii?Q?8O22mRDU5A5uUCsKiS97jVlXvK1kzYI9f42OQDt6zw5dHSSX7E9wTe2cFN98?=
 =?us-ascii?Q?afSXlx/ExG9tip5zWsXdT9yu2gkfL3IcOLE4gWk9YiNwmjxUBNZVw++lq+7j?=
 =?us-ascii?Q?6HuDwDTB5qJEuLrsEVjSIl9HEhwU1uUCAKBpuNWGBxMwVLj7vdcBLi8msQw3?=
 =?us-ascii?Q?Sd4Y6YksGTqLLZkCVNrdRycXXd0qXEh6bFC12wC6xE2qycTpMrLnDRNSQubJ?=
 =?us-ascii?Q?pHYnryexUHEpYu+GcGTzCTHyngt8dx0SMa5MRFzmumLTuSFWx40+Eb20l3Hh?=
 =?us-ascii?Q?i7fhFRze3fJoz7xOW95h1xONRfvE5qrNso3k3MdMvHQAHSBpAWZRubRhajn7?=
 =?us-ascii?Q?FGXopMS4eBm7ukf184oA9EfhhD6FK8iovrtKCOlVkJ294GWuV6//Q08L/HMQ?=
 =?us-ascii?Q?qVppX7HKNzx5QrDW+yyU7Qpwd9h4W9C/FqrbF7DHWs0s4xOA/OYom/wDBd55?=
 =?us-ascii?Q?4OCHrrj7inAy3XmudsIVzVdAIiB1szUiuzYTDPjN33snZQ4NbbNBcFUHIN1o?=
 =?us-ascii?Q?sDuD90HQ5x6L9qyXs0qAxpglzJ1Xfv20l5CjOVa80Y1AzYCLhIfp+VWHnA20?=
 =?us-ascii?Q?KmMK1UNZGwbF3SbPuIb06iDQQHzlvWOOJYI8VCJTD7az1memUqf2JygFSLbE?=
 =?us-ascii?Q?DucOn+Le9Ipdj+SnDR0Hn0zQ6z+1Rilx2LynKKxGBowLFDst/9TiQo+mjfCl?=
 =?us-ascii?Q?3NhLIHSEKGwQT/M7v+GKob0qxNj8oH0=3D?=
X-Exchange-RoutingPolicyChecked:
	N3S/kHiC2BPz9yclIFpM6/v2La6fvD6Jc/Utp1+f3JxCYyKpsW3sb3kCWqPP3iCilefo0H75z9y3p/EdnmVOJW5j+rVjeXc4Es5+3bZ42bK1qeN+m9DGKWsNoJMZt82NGVzBSHj2D7efQ3CexZKsaNjrl1tm3NmhleDXcJcWphqUxlNALH3mY9aZskbj+cNoLKZdlcb+CVHxUg1ZC+J7puLsr84cyucWanhf2IrI2i3WtzWzDA0UUJDY7ofqj6UMtkAqg1k4twXX177AdlHzUw6u4KMZijNWzCtJWiiqbXDsvQ9e+pQJuJLbBkBPMYj4HbTtVxN/vA0NenqWvWuT5w==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	q+t7OCEr7+NnpCTVODfQHbX5ROeFdOTJe+fjwZsA5mL7epWJTOHmxLt/yGx+faF6DbTYcuy0lPa7uzHaEK7HmaguD4ZpTqJ3k3fIdFKFc14jxpfGT8uMEd+tfwCrZAZygSqxhmUxwnTipwyfPtAUi6CC0FOtrGGCGUP+o47OlGLZsZY2aayaTBhi8Lq+DtSkg2es+QUP7JJQDIqvg/dug5VPuXiXCv1wH+f4hbLi16bQ5TnUxt3iS7aoqBZzvuYbXbFLcm+sLZvzcGIig5iCF2aJXSDYY3kH4Z/YbUdnzUAm7+FCXFXcxuE/gzPE70+cATqllSnFaJ1viMA61ecQN69fJ2N24PjO6yVEY9Qns/u5feA8+4xe9hPdSZ+2F6kKPP4HThrzHO56s39AJK4ihkRRoBT9fRjrlU8NfN3Q/qmniAaWp6awWZkbNVa1JJZ7P2axG1hg8mSEQXSI0Lp1Xpx5VfYvR+xXY5NmwaTJMxnAqe8aMuNDDbLjMgjgyKkm/1m73b62Y2gUrxNvUNb9oyDOwWSZfeX08seBmmh+1SMBQc/W+X419uCNqb7FfwoNlXwJIABp2Ic0wt9eHHAcKtLcC0e5fbZnq5Cu9hyTMtc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0f19983-429a-4324-618e-08ded7da1a88
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 01:34:48.2341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Te/56A7ljYHN4G9Fh9f4fsJ05NwDKJeAv8/sWl+K6y/jlbkq91K74vdlxTscOBUU7SGBPBjf3nsCE+eyCnAF3cuE4ZG6dYORD5vZxWcpokA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8760
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 mlxscore=0 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2607020013
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDAxMiBTYWx0ZWRfX8ClZIFNxrr3r
 I3Ml/cT2r7WO0FhOiv6TY4JwllYzCR76xtr5aGcaH+FvX7hOmigShIKq7hlPvRmD9YPQYvPLVQ0
 GWCpDgd7WSJiEeiq8HbbyeLhx6t9ho1QLNK0UbbjNW2E3GEcTUzm
X-Proofpoint-GUID: FNUSfBLuxT9PMNog5z_34fz3DiS-ksmT
X-Authority-Analysis: v=2.4 cv=OKwXGyaB c=1 sm=1 tr=0 ts=6a45c03c b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x0eKOSpe3m1H3M0S9YoZ:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=vggBfdFIAAAA:8
 a=yPCof4ZbAAAA:8 a=7gr8-LgUhGOHEYCj_R8A:9 a=WmVTiCyuxqgg3mnwYu6p:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: FNUSfBLuxT9PMNog5z_34fz3DiS-ksmT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDAxMiBTYWx0ZWRfXzfbzL3vRIO0w
 fsryA7vuCLFWgCuNKX0Fs4Wa27GphDOD7u8v6dAYa/gRD6UbJR5gyZirj3QWtbRDvTfxGfH0Dzy
 IcoG5T/Hizx08FFQRdZ7s8HfSOJKVj/EUTR2kKcAV6hhMqCaUk+XjUO0+o6FHpupucwtuIHjJgG
 o93C+L8fCeWEOuVeZCi3kDPmRI2SUr8zj82j3qv4cGlPetJsyCW5QMQXX6joQNChfkPce65Z+od
 DVO8T3EvBcckQh1bvnVlCWDD81kpZwoZnlWhuifmqzysXPCp8u971Y2vR5nx/DvAKR3K+7EdxKM
 BA+8nhStAm6AJ6Pk1VM9mez3uaMszEQRbtwY4rY+DK/2EQ8Sxw2AMkfdqWaBSqOHkbe2YOIzY+C
 /4bgwV3EnpssNE8EmAIbbz0EIgrSXnGerUVY2+NF+jEg2avu6FwpwDM1bjPp4UplDPplTIC9RQf
 PEC4d4PBGN80rheH4mw==

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
Notes: does not address comment about breaking the timeout contract [1]. 
as the interface isn't meant to be precise.

[1] https://lore.kernel.org/all/20260608083136.20A521F00898@smtp.kernel.org/
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

