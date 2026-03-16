Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325DF35CB9B;
	Mon, 16 Mar 2026 22:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773698975; cv=fail; b=jbwkiN12nCuZdvEKE+KFijMKwdwwvpGr3VIQ5XxcvuNXf5bih5IYWfE9ybd4h3yuve20n2X7nYDQeJNUvk09Yk7PtwXmhQRNyQvRSvcsgTH8Q1Ayq0kpdcfbpioMgsfZdAYil4Zh0z+tX2iNj14wa+X3V6MF944HFoPGo4gQKPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773698975; c=relaxed/simple;
	bh=ZOBxg+QFY4/F4jQb01GlUMs4XPGLcVm0wiDjUuj6AvQ=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=fhWsb0CftoWtF6AYzFLq0TgDEWpd5zLg1adVeLuYlkxx8LQXuNTA5gynVHWasN1dpJCK1xkD28qhjzK70+vD0yKLoDYGkPt44ChVdIMrqiyATOa3I9c+CmU2T0q0ENPa/822b335yWEsrDkAfqQ2b0Bwz3F5iEsayCI9rF6GOwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=H5SPbc+P; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VgfxLL6m; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="H5SPbc+P";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VgfxLL6m"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GEGWJs2956065;
	Mon, 16 Mar 2026 22:09:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=eN/7seRlJnnxh+BfHz
	UenuxBuoQc8krkCvBTTSMdd3Y=; b=H5SPbc+PBfYty9xWDxSPdq8s6b2D225FVR
	YOccbregy7Oa3dCtoTF7Ab3x1Jnl9Xs1HKJiRJ618F4T9Zn8EgHIMwOTT4xH5cry
	FaoHVORuTePX4PBey2Gcdg5hF+9noIlLkZBTLsS4PjU2AoNo2yPWxdDhK8PbJGzw
	6zPHm/oWnSGdQFPsjauy8J3spdyhHLIkje2KVmZeS+EEdtqzLR2locdRC9NNay+T
	uWaDEqlCd3d+uWQPpSvZkuuWj9LH3SBys4mQ5hCHnA5NpZcF2/xD/+60WnjHCISu
	x+FQTAu9VgJek5HSdBRlVhxhBmABTDE3ChFV1qHeFf/5nwOqv0KA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cvyqbu592-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 22:09:03 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62GL985J017796;
	Mon, 16 Mar 2026 22:09:03 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010005.outbound.protection.outlook.com [52.101.61.5])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4cvx4krb71-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 22:09:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nXvral7MDaPBfIVcdDwAJdUimrCH4s4EdjDQsQDyoJ0tEpyCtBjcFneCzhevbjsoEkDeoiK1h7+oHrstTgLcuTyMQfqWlTJFpaqNjuziwoNZ187kkHHdjbXXg4tvYlX7MovawmiwzYI/DbmYEYxm1Gz+a+la3ASjOuojSyry/C86FT6Mb2GuB/cJnUaQFjGTtKHqMmwrbeacXQc6Z40ycw7OpSRbPUBzkRqGqJlyRPLh+MpsaF81y2K9CwGlxaAdU0ulCglaSQqdgRRpFJ8ALp89CS+3NgDuA/68me8/4cjUkABpfTec9nucfxwlEY1ii4AZvm8BJLgDzvwzQx+tlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eN/7seRlJnnxh+BfHzUenuxBuoQc8krkCvBTTSMdd3Y=;
 b=yUkL8k5m/fZYWtv6h5qejVrchkG2W0NZ+YHC3Lc4WFcRS266fO9Dim0YKLkB6ynDjyfEVv8Vzu0o20TjgAFaj3sJGUqdECDURyf6OW8oKA2VH5j1huGZJahP9sfWbR2X3Qno55uVA3nXiAQXoGBpU/hqSuCtfKjS4aAgvdJfCVcAZW30Mwn5mmz2qYQ7ORsHEZpCYkXw3xlKFH4SUjOsbr14/TPOeXPPlnLmUmGdT0+qCFEib8gSW5ewpkJ6yeAW4o9LCmkSoFcCUid7mzUqhJim7300x1R6C8bG0UhGOnJWygNffGRdkiz34X/4bvZHoCABY/M6dvKYqNtkmpoVHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eN/7seRlJnnxh+BfHzUenuxBuoQc8krkCvBTTSMdd3Y=;
 b=VgfxLL6mNeOpbvb0mDXw65Bk+gXRMFbohFb8dwG7HxZTqrPFMgD8HdUipIydGFb+WwpiFTn+jqmO2JXQl/3aEMpfy/jthT4Hg+eevj478V6agFGgpln3tP1VB5YxQPukxB+dUjK25JIk9MfoWN9aY7Fuue+O2hq6xSNUstI0bBs=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CH0PR10MB5196.namprd10.prod.outlook.com (2603:10b6:610:c0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.27; Mon, 16 Mar
 2026 22:08:08 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.20.9700.022; Mon, 16 Mar 2026
 22:08:08 +0000
References: <20260316013651.3225328-1-ankur.a.arora@oracle.com>
 <20260315184925.b6f93386e918ca79614843e3@linux-foundation.org>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, bpf@vger.kernel.org, arnd@arndb.de,
        catalin.marinas@arm.com, will@kernel.org, peterz@infradead.org,
        mark.rutland@arm.com, harisokn@amazon.com, cl@gentwo.org,
        ast@kernel.org, rafael@kernel.org, daniel.lezcano@linaro.org,
        memxor@gmail.com, zhenglifeng1@huawei.com, xueshuai@linux.alibaba.com,
        rdunlap@infradead.org, david.laight.linux@gmail.com,
        joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com
Subject: Re: [PATCH v10 00/12] barrier: Add
 smp_cond_load_{relaxed,acquire}_timeout()
In-reply-to: <20260315184925.b6f93386e918ca79614843e3@linux-foundation.org>
Date: Mon, 16 Mar 2026 15:08:07 -0700
Message-ID: <874imftol4.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0244.namprd04.prod.outlook.com
 (2603:10b6:303:88::9) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CH0PR10MB5196:EE_
X-MS-Office365-Filtering-Correlation-Id: c6015823-7491-4818-1eeb-08de83a88175
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	8M8klLwDPcAmaT7Y0Gk51IEtf31e+Fut8WrdGsRDnJNpK6fuDL1XGv99na2QcJTTchWkJw5TqHYlzmyMl0jD/h3OYAltz66Eo95QJZU8fDsObYHpKa3Pven5TjDGn/dyPeMov5IRAX5gpY3SulEXmOULtX0dHJuSpNAUKKKfPExL5LVK0KpUtAmGJr2imDmDjIDrQ3fEfpGEgPceAjnO7oFpiHyIM5NrTtwkg9IPh9znVk8jf+fkg1xGWGdswSsBol/2akcmRhu/+89VhvBMDkXIqggSS/gz2Q9Thf8wqWW3DiIEfRFhyYkdIKtgbwfSozRgtKiUwIpR+U0cdE2obM9GO05XdopFDQrqFSE1KXr3LlMmLa/U0pjVcmaDnV6mOKIy/xBp1mKKq+tojSZa0/fvwU2kFxjptoNjjiaxP506qacJFiA4HlPZtRy5nWX3GuHQerqRMo6Qjbz6HksDlTH4XN55FB1DpHb/J+MZVT3/vgQATGRf9p5Oy+FeBZC6QoCAjYBrktf1gGLmhTDhntD79zT/WiHkegV7cG7BGhVKFwX5Dz4GEHR+2LqrA6/Uxwmu1FLV4pSATcdKFKx1nxhKetfDu5qc0ZG9oSpBqxwxUup93Ja4JLcq7tGMjMZt3X7HGThqwZVMqiP/M3Ovpki6lW2r/3Y/v5KlkKSETUQMYVA961UD4DOzQCLn/23SBnWKVKpIDt8b89KtMWCGVyfDknyUjlRwo9qu2ue3MyuYCUhaFWVrrDKYfBegkILK
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ie+GoJhIc51UXZdlch0dAQKRdsAzbqwCsqdh4EqniOJHhNGMsRQ1bldbiZLR?=
 =?us-ascii?Q?FAHXyLXC81pvTPeKXbzbbJL0g1oT8BRQcY7lKA8Q4dgSA2TMGSbC0AY+kE7/?=
 =?us-ascii?Q?IjN5W5hKkd564pcjzmKPeGAyAGFjjDGKM6algKh7eZ2r6CX2NR4ek/p5eaFZ?=
 =?us-ascii?Q?4ycoQOHv1SJ8Cvbu0WafWxjxx4LEEG04FmUABpL8mqMVG2Eo+bdgDAfsb8u8?=
 =?us-ascii?Q?JVntgWj9+CX9Y0e+xlIqAHKh6CcIgjvxj3xqkWcBQIFa9yAJfRnQGSOXpL7B?=
 =?us-ascii?Q?dXAWOZPnjauSa9kMRPCh47T6xslZNd3KWN+1V/S7tTIkGnNJdWN7r0T3oVgd?=
 =?us-ascii?Q?+lrpLhar5MlETcdePxd8ntSMWY6xDBuYQ+csD7gbRwHgtmkhPLQVAqiBAOXn?=
 =?us-ascii?Q?Vt8DZmcCksGq+MG6hESM+iQD1RpRRs+9EniWMHNo2lN7tyGjSWOew8yGxiIU?=
 =?us-ascii?Q?52y3n2xmdJh7V3/b9s9wV5sYY0KXVg9S+i8vV9cR3kiccnb3q/vg5LD5cBRx?=
 =?us-ascii?Q?AgReGZfhPPjTHizfrY89dw55Vs5S1rpZgHS5inICu/2QbITP0DylESnXBplX?=
 =?us-ascii?Q?KQ9VNinzKpTAQwXkhWt2iNLRNyCG5tRck5nJvARxJmCCvyEqih1W2x/hlPU3?=
 =?us-ascii?Q?dZfykOOfKmu5EpDrE04z1SOcp2JYYmfmesclDv7A5zb06pvaBshMiR8sehKC?=
 =?us-ascii?Q?jGKopfQc0sP/e2fvVhKmRzVNfcUxoxmDLojW3GrtuIapXi22BwD2DhL5SSP/?=
 =?us-ascii?Q?A0cK7PiokHNQkTYwAZbllX/8YY8K8mSKy8j24A5sdUOQciGsZwesGmWej3BV?=
 =?us-ascii?Q?3bA+IiqrrZwzqyt+ZdGISSohInHqQg8C3SiKEIUKIsIQg+oczgBztFji72Rq?=
 =?us-ascii?Q?PfOq8LtPf1dwyOrn7TSmDyHaH+gj8VF/i+YDNRGj2UAPmzVvIL9iWjonDT/l?=
 =?us-ascii?Q?YY5J4laq+R4atX+sGu91Td7EldR1cUvEt4JltqljOjHt0zbpv3IsDDmY0eSr?=
 =?us-ascii?Q?7QC7rHm0/VFh/Dk8DnDDeJ4QGL+tR5vhobgPMaFtghV64xDdADWsBtxMfjge?=
 =?us-ascii?Q?10E+DBDSd0/XkzsXwzPlghGZz8WZEsyRoj+M/kg4u+sdhqP79MmvtbLCxPCu?=
 =?us-ascii?Q?VapI3XjCqxpG+nHdR+Td6tGmqWKknEa+/bk5g+gR8YvjTBRWnMQu9n9vboie?=
 =?us-ascii?Q?Q9SgdzCds1rbZD7oFWZdjgla0f+I1YW4fyFg/z77n/V5qoUvkhQ23pPJcQim?=
 =?us-ascii?Q?ioRyhBNGFWsEGAy4srPfPzgp/XILQPbhvP8Fh0VJ7VMGSAiLeGB58zS30E3Y?=
 =?us-ascii?Q?CW9qcZ6xVcG61lbplq/DfgqUz0QJB2qnKDLPLOkKWrXBAr8huWTP5Sezu9jI?=
 =?us-ascii?Q?pNnX1WZ2yZZiAjnII3kdnzN/Tj5FUiBrEbgCURCUUoDYbtMSONi9jAlQGAlC?=
 =?us-ascii?Q?W3KcODv48/Dph0pC/Pr8ksRCEVBNASCrhafQyTGlh+iPGNJImuPDIzQGg85Q?=
 =?us-ascii?Q?wJyv1Z+3QFt+0/zPKI4vmXyvR/e8jWUqTonNYEriWgnUDhfJ6myDOGLsDXkc?=
 =?us-ascii?Q?0lpf0XotSqAqRvKHZUoTP9KQ5RfslJ7IM680i7iSrXIZysnkkAPmFvQXEaBR?=
 =?us-ascii?Q?KVP99NIAg7mPdmEIg+WxF2gYMRXZQZRb4/3tCHPZYBFhKuoAM1y2Czt3lfMy?=
 =?us-ascii?Q?o7Ljx1O9L8bikkynAv/BLtPSOAnbV6lrbJ5eAFWRKhMasTxi5WTFfAc2jPk1?=
 =?us-ascii?Q?MesWsa70ZFVb5sPKOFwc3ez/qjMu8Vo=3D?=
X-Exchange-RoutingPolicyChecked:
	OMWeLP4rmfWpDwh6dileuhvO49io+srczIgskC45hgdI9VUKkg3CbHDv6fxrFb7n2e/7yHnKM/ErBDcUpFHByj9fBuk92zTfEejPf850J9hrCw7sRrl0+EmScYmWGAGZu5Kd8oIyYZvCHLKIEqOWqK8GYibWzvXHlsQCyfv/dRDB8psV1ZTYrlBkISYavhfCRiAldlxtD4yQQReCdqcE3eXMq1SWkDjFyaeH1T6BaIRDHqR4MRxZ5WdFitIv1xg2yIyt3A/KQFKh+EUdB96rvI2cS4oD7Gio8BnLaTIDWVZcxBQs3iHhxZPYJjA8n28Q0YBYbuTkaTFt5pQX15oB8w==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	i50hcTyW0nRfcOKbv9AJH4ix2N6XHl37kjgwtInba+NEpvlvUsoBBs55a5ryMQbUwfFZAbjGCq4jqC7MbkPBji4FU2baF1zL/hv5tPS9posa2/Zy4pohsWAwD/wqtpoHs4jcpvZZpRlLwSwbCRiPI37g1ewLNd9SQMN7EtXyUfevC151hM4CCfEr3gqwE+QYSc2F5UbItm3t6j+djnxHB8cJDcexh5pxq47vDR1fREEA70scREciaEPoe9sUe9VfPLzdfAYI8SybiY1vS+yJZinDts2/L6a4BSW4dzOOt8ioxrLIoUuJXHLJpMWV6SKaTTr8jB5TpeKgFOpVtxzyN+qMdAi/8ijVp4GIMHJ21Rm2q2F3unW4Go8Rj42OdnZ5HOeBlgIWj8as28gGkjDBsSyUIc64yhNLnPuRZvYQy46ilvf6YFSxzkXS3qpstqqMqhEUaOqGaRecBalm6t6mwMQkUhW0otbyokIzQhciWdb+2AHnAfiN/fMcwahmCdynmIpDUzvhVGWRp/hZbIQXgwyYb+54VfV80PVgh48LFnKprJSgyAinuEIgkU75p/hvZmWsNo5McWcq5PACXxg7EQ2TBuPRl7mQTwTp25cRK2U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6015823-7491-4818-1eeb-08de83a88175
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 22:08:08.4595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ey2QBs9ZHeDb3zeypwC0UW9wfZWeeYT0IpSI/A+5GzFkaCd0kF+/hvpqBoS7S04UTU5m6JiZi0V946+gLaWEaQBWY+C4v7kbFHrNaG7sWp0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5196
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_06,2026-03-16_06,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2603050001 definitions=main-2603160182
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDE4MiBTYWx0ZWRfX3g2+W8mM6GsF
 MC/zE3RRVPUG3DAv3Q0r9G9nNgNnbCdnmZ2KZVkGQMbLiZacHxi6s12mvB03/Z88eXJeQc6EjZ5
 psvBKKvmRW+1ruwPYdUMPT2wB+rWK3eLGIrCTbt1aBGZCO8JCQN7fGo3jZhPajUXUlMXIKYyY/G
 TIWaW0QO+3QNVVRjjpwysCewxLXHqJnSzGpda4Vi2pVIdD/aDaMHWX7sSuCqIyclIFItOuQh00N
 8pIxDa8CsMgorGuko7ykekc2/gtqjelpkpw9+9M9MMELyKPWeVYkH4jzm+GczNyukQzhAsU0sQx
 Mion1j1D2fxqNUleVgC+6lE+8s74FBpuGHEdfoL5Hu9zZC0Wmy5vlIYd8BHS/S/68txKo3sDqaM
 0LXSuARY6WbR6yc6gVppwiyg+kg25lPPRrTVEKoHvagIp11jjodGxx6QRR1eSiICYU5n80QJZvn
 eiDxR/2SB1rOoAqLGRltZtCL11OL1ucNilm1UD0M=
X-Authority-Analysis: v=2.4 cv=J8WnLQnS c=1 sm=1 tr=0 ts=69b87f7f b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=Z4Rwk6OoAAAA:8
 a=PNWjKoLIGiLtemlLGygA:9 a=HkZW87K1Qel5hWWM3VKY:22 cc=ntf awl=host:12273
X-Proofpoint-GUID: p-fU1koxgmksVqKjGsTzEF1QQZg1aMBk
X-Proofpoint-ORIG-GUID: p-fU1koxgmksVqKjGsTzEF1QQZg1aMBk


Andrew Morton <akpm@linux-foundation.org> writes:

> On Sun, 15 Mar 2026 18:36:39 -0700 Ankur Arora <ankur.a.arora@oracle.com> wrote:
>
>> Hi,
>>
>> This series adds waited variants of the smp_cond_load() primitives:
>> smp_cond_load_relaxed_timeout(), and smp_cond_load_acquire_timeout().
>>
>> ...
>>
>
> How are we to determine that this change is successful, useful, etc?

Good point. So this series was split off from this one here:
  https://lore.kernel.org/lkml/20250218213337.377987-1-ankur.a.arora@oracle.com/

The series enables ARCH_HAS_CPU_RELAX on arm64 which should allow
relatively cheap polling in idle on arm64.
However, it does need a few more patches from the series above to do that.

> Reduced CPU consumption?  Reduced energy usage?  Improved latencies?

With the additional patches this should improve wakeup latency:

  I ran the sched-pipe test with processes on VCPUs 4 and 5 with
  kvm-arm.wfi_trap_policy=notrap.

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

  We get a decent boost just because we are executing ~20% fewer
  instructions. Not sure how the cpu frequency scaling works in a VM but
  we also run at a higher frequency.

(That specifically applies to guests but that series also adds enables this
with acpi-idle for baremetal.)

(From: https://lore.kernel.org/lkml/877c9zhk68.fsf@oracle.com/)

>> Finally update poll_idle() and resilient queued spinlocks to use them.
>
> Have you identified other suitable sites for conversion?

Haven't found other places in the core kernel where this could be used.
I think one reason is that the typical kernel wait is unbounded.

There are some in drivers/ that have this pattern. For instance I think
this in drivers/iommu/arm/arm-smmu-v3 could be converted:
__arm_smmu_cmdq_poll_until_msi().

However, as David Laight pointed out in this thread
(https://lore.kernel.org/lkml/20260214113122.70627a8b@pumpkin/)
that this would be fine so long as the polling is on memory, but would
need some work to handle MMIO.

>>  Documentation/atomic_t.txt           | 14 +++--
>>  arch/arm64/Kconfig                   |  3 +
>>  arch/arm64/include/asm/barrier.h     | 23 +++++++
>>  arch/arm64/include/asm/cmpxchg.h     | 62 +++++++++++++++----
>>  arch/arm64/include/asm/delay-const.h | 27 +++++++++
>>  arch/arm64/include/asm/rqspinlock.h  | 85 --------------------------
>>  arch/arm64/lib/delay.c               | 15 ++---
>>  drivers/cpuidle/poll_state.c         | 21 +------
>>  drivers/soc/qcom/rpmh-rsc.c          |  8 +--
>>  include/asm-generic/barrier.h        | 90 ++++++++++++++++++++++++++++
>>  include/linux/atomic.h               | 10 ++++
>>  include/linux/atomic/atomic-long.h   | 18 +++---
>>  include/linux/sched/idle.h           | 29 +++++++++
>>  kernel/bpf/rqspinlock.c              | 77 +++++++++++++++---------
>>  scripts/atomic/gen-atomic-long.sh    | 16 +++--
>>  15 files changed, 320 insertions(+), 178 deletions(-)
>>  create mode 100644 arch/arm64/include/asm/delay-const.h
>
> Some sort of testing in lib/tests/ would be appropriate and useful.

Makes sense. Will add.

Thanks
--
ankur
