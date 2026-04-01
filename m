Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A53C3C872D;
	Wed,  1 Apr 2026 22:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775082749; cv=fail; b=pWOBzRWXkHIeUYm8raHgECrnZT6V7hiTqhp4x3wC8J+p8CCKUCH5JGpAa7Dx+rxcJzqJumoF6TLzNE8LliKuVtGyEpfT67zsDJKN8pOGHPkegswFFK05vjw+q46YCSyXLi86KtzKhr7YYToxplInDyR+HNUtpdzNjiStwNyYcGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775082749; c=relaxed/simple;
	bh=n/sfOuHOoe8DbYlWSBTHtuWabD7HqWEKs10KtBsWAHA=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=lKWMsLSPPunwhRAdXqe7Dx1+Ty7ceynHkkYii21jre4eHvm0SB2poTGpIp3S16eb1ZKLzNupYxhl5wRwOKZofeWm3tRobB3jthU4XQWKRQvw3clV2nIUFcVohE+DB8ZiPp6UKc1Fnp7C0WQuXIk1LlZ+IoVB/qI3zc9VIkrCf+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kp2eSY1l; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UX+E6/qH; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kp2eSY1l";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UX+E6/qH"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 631LEXxV050281;
	Wed, 1 Apr 2026 22:31:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=n/sfOuHOoe8DbYlWSB
	THtuWabD7HqWEKs10KtBsWAHA=; b=kp2eSY1l6ttI1YgOlHu2ZhCRWE0hAI3dKO
	ZYLkzyJ6yZo+9cI/Wr/dDc6M10ZXZXCQrB4CMr2Infw8fMnHoaByGT6CL9K50JQX
	0OUnRd7PdBG0dWykm3C2IHTkYs9DtbaJ8Z+DoObzsD/B8tngWV7E53rtyBXCzhEX
	krYvgR2JWbzk+7i0hQymrjSavkvR378v7PF0Z42t8AxI6iwvrMr6YgcKS80+e80H
	RH1S7Rn3WC0abOPpIIWZm6ET4ENCTtwCMji4x5HGL0i6qzwbENdqQxSzTC7gs1Eh
	47XekjaHrYHosxGsChcTFQXRDUq/RtHtlwnDZzWNkyUaaUQHoVMQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d66v5qg62-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 Apr 2026 22:31:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 631KuK99023597;
	Wed, 1 Apr 2026 22:31:45 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012038.outbound.protection.outlook.com [52.101.43.38])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4d65ejh5qj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 Apr 2026 22:31:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wtAvPS0PdI5pM7kCdenccwFob8hPgsV5hK8Nu4pNyhkMWhmmoypn6xyeWEDp+elCF174rEK6Wbxb8SojtEZ/iYiqo+DyvDMWq0SmUJVoXqrvl6IXOv5jRVs4Ewlf/BUkJRp8ajaWLUqPqHFODBAfz7Wx1/o5H8EfpJx7BSrVtNSwBn/Ia3FER3458I/wkNuPEffl+7/c4QivWtEw2Hh3cjS+wWeheiq5DOhdO+xCISStZDdv5puxjqlEKS5uUnuaU6qAaMNzzUMMF3GX2EhIfXdKdb842LuVrlWs/immLldxyug3mRZMGG2XOLDD2i9w++vryRS/q5HxsZ6w8Temng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n/sfOuHOoe8DbYlWSBTHtuWabD7HqWEKs10KtBsWAHA=;
 b=AEDjc5a5STlCKC2GZVFAswT5BjjWd63ob9ldAyOVMwqFLBLz44Xq6rZDCd5HTDmHG/iCwjatwX1jJF+DZKuLCFfhKhOPgRyS8JhtYNvob2W5yef7FPyqr397EJQ9Vvx7qUns9cjOGJB/y+X+p1ot2neK9vgHJiN7dEz0/sy0qqKCST0NLp8SilI5t/lSEXKZYEV4smDz+IZ8jJt9Y8n1YRCpRhnIeFaUvNIM+szZerNrw/7qYKuguRfsQr67W5b9bJ1DcY0ZEmTMdlkFUqicsnvdMGcrE0FIxTk95SvmE/8QvQkqNKS0LkqjDqI46II38gV4SVatMgaKMmMMs1BK9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n/sfOuHOoe8DbYlWSBTHtuWabD7HqWEKs10KtBsWAHA=;
 b=UX+E6/qHuKG7lOlisBIyOwvmthx+qRstGU6vyESKRudTLJavSDOvlT4Zm2MV0w5deyZPxbMYQoPg8lxXtTcwvWI/m48MIDpAA+vReFlfll6aFhzB8k8GQ63BNHbVWbRbmXshxJne4DUeDn2KTJm2GS1wAQpnS9uVsYamNClrOgs=
Received: from DM8PR10MB5416.namprd10.prod.outlook.com (2603:10b6:8:3f::19) by
 DM4PR10MB6743.namprd10.prod.outlook.com (2603:10b6:8:10d::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.16; Wed, 1 Apr 2026 22:31:40 +0000
Received: from DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::c8c3:861e:be9b:fa6]) by DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::c8c3:861e:be9b:fa6%6]) with mapi id 15.20.9745.024; Wed, 1 Apr 2026
 22:31:40 +0000
References: <20260316013651.3225328-1-ankur.a.arora@oracle.com>
 <20260316013651.3225328-5-ankur.a.arora@oracle.com>
 <acz3D1SkqDqyH0Dy@arm.com>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, bpf@vger.kernel.org, arnd@arndb.de,
        will@kernel.org, peterz@infradead.org, akpm@linux-foundation.org,
        mark.rutland@arm.com, harisokn@amazon.com, cl@gentwo.org,
        ast@kernel.org, rafael@kernel.org, daniel.lezcano@linaro.org,
        memxor@gmail.com, zhenglifeng1@huawei.com, xueshuai@linux.alibaba.com,
        rdunlap@infradead.org, david.laight.linux@gmail.com,
        joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com
Subject: Re: [PATCH v10 04/12] arm64: support WFET in
 smp_cond_load_relaxed_timeout()
In-reply-to: <acz3D1SkqDqyH0Dy@arm.com>
Date: Wed, 01 Apr 2026 15:31:37 -0700
Message-ID: <87h5puqpme.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0333.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10a::21) To DM8PR10MB5416.namprd10.prod.outlook.com
 (2603:10b6:8:3f::19)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR10MB5416:EE_|DM4PR10MB6743:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ca4f179-b08e-4d0d-924d-08de903e716b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	OJBxXHz5yllWiTWKTjF2zIJZLtzBH2h1AJgjXW/3L6+XFeqYk0rcBS772I30a8DgClaU4b4dKPu4VRqRrYaduCIlbHpz1kTB8PpJEYQ4ZW1Bxv7aXchSWQ7t+BeAtE76GGdvTE4gsNMyFP5jEZFwMBcDwH1hX19gQnYYkeaHdOyIgAHfLBLgAxgdcLzz2NA3lQ9i2TbJTaC1S2ey5PQkzU5LLrB4AO1J/pvCebp3Ss44wHUwVBwd25W1oJ24q1c4xbOQGxYn5/DpYfdrXMgkMjB47BGeEUs7+y3ialOlf0TU8Gu7XWjgtB6EFSU7Et8yOqjcd4OOa9JSy9W+aS3x+c3zNfDuFbQ4sfZPp3KyPFJfsS/Akx0NhlOWv/e0SSPS9WlBbvOurzX/NWAQj5eIZwRSOFlGgscM1HRCHVACqUmBchAfzpDDyzqiABLyLYFgXqaS/ebqGC+/30Jrnt7ZtygSvMqbhpZZX9jv7PqMbpfD7/o66J/yzfLqKPbKXu28BOyW9R9eSX/Nei/UzbynredynTvTtsI4LzgZRYazTLsobKnPMKQzaq3EeX9Y25BOdj54v7JuWd60MZrGM+8XL5p+LwFOxtsWRRpzEC1Bt81ynLzpE/E4hLjjiop/aAkLNJq4J51yT1dX8uFSOAR4NMZQPsSspT7lIaWgqILMi7JGtjwETYGr812smQRYCeSM8EkHH6rebN5gUyL7ul+rD9mqA5Ac5GY4v40gb6e/OLk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR10MB5416.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?crIi/5M+h10v1SKTXJYcka3odbdgcJHUU8cHLGfPU+gy/diz+2d/aPcc/GAG?=
 =?us-ascii?Q?QGO+CtZ9ggNVz3ZmV1UQYLOAqB7FS5RCLhdqahF1n3MVkkjkFl1kmwHlicvq?=
 =?us-ascii?Q?oOMWU9hOAD8lHdSVzQrBPWUk8015gHPzYMAEu3INwwdp63nDnrpYnn4D3Qn5?=
 =?us-ascii?Q?qO9YO29KmX/hZn5/r/AauQfP7qNNbnI//rHS5spYeTkMxTFoPZCuDaj6fSpO?=
 =?us-ascii?Q?N2awTet/AYDL7gCwILcK+08tUkSbmt2YHP4cOeRp+CkEwJZVKdCkwDciDKGZ?=
 =?us-ascii?Q?U1+Q2rvQU4vEWySoFVvoMFiWKfF4famT6ktmlqwwcGQsxhvpZnQNWfRrqXan?=
 =?us-ascii?Q?paiZ1JmttV4QAsQy20ZVdw/F6foDF26TY5TV0z7LJmZ98vK3OAB4cPuKmj2l?=
 =?us-ascii?Q?ADQMWEf0fudpJwbv4dEmHQoVbsP3tH3jA+FIntaYN7JLJ0W8p1JDb/6bRUIx?=
 =?us-ascii?Q?AUChXWD8xbx+aFgmvDZG1lD9FaKdH0BDJsJkS0gdp4yz8e2x1lGM3Ul4K1sA?=
 =?us-ascii?Q?8SVjTisxye6tLmNsCEKlq6n39ALrKnHs7CxnRecyIikZTR4tgd9A7f/IQgXQ?=
 =?us-ascii?Q?tRwPpwYieGNivtA8fBIaNHVvTbvUvfP3FVPmykwd+ox5DWaqMv6ZvZmagwAh?=
 =?us-ascii?Q?9qBeroLVV4Hvttt+Cu/wCREbRI7aWOi+PVPONPKLyRNenNz8m22hNqsOBIRF?=
 =?us-ascii?Q?M2atCRPCwMrZ9+8d2UIb7nbUll+jr+/Rei+ZPL8aLeF3TJ8wBu9pYyw2SSpa?=
 =?us-ascii?Q?uH7P55l3Pk4mgfDboe4DzduT4Sijd+Wsj2ts9vWxCBLduS+3L1m+aK6N1L61?=
 =?us-ascii?Q?SssNx+0y4i7eF8YiHHDjDboGnpfCAdv9/lPEVTjYoWctiPblAtj9nLWB1/67?=
 =?us-ascii?Q?4uvx6wJl8Z62S9cc87oQw3qJJfIM1pnFUN/N0Cd81NlqWeQHbmbc8ea0vOgP?=
 =?us-ascii?Q?Bwn/icHR7jWzYEptK47RS9SEYaiHiNS/F8NHkdnGIlCvJGmHjVHqf0AigAkH?=
 =?us-ascii?Q?fgk3EPUhhDOuJmiosSsGElAJsECF8cJf656tf2amY1KVBMjnkQv8Js2GHwI6?=
 =?us-ascii?Q?vojFBgdd9+ec5tANnty1S0xtq4wqFKI4zMyfVHn160PCkKaKvQdzfN/A451t?=
 =?us-ascii?Q?6TF1PmyHOnT1eoSaDhwoOabny2AUlN8lnKtgxJKSn5bpn8iAZYxWw1gNZHTa?=
 =?us-ascii?Q?bZMQzJ5ySywJUMP3Tf+l9sl0tCKTXB2Oxmg82fQMndQ4mR54/1R+a4jZK5Vi?=
 =?us-ascii?Q?JHsG/NMktobRechtIaZX3F3bzBVjL8yh9hOxqcvFWvybe1XDCS5XgjXWcvE8?=
 =?us-ascii?Q?QCtbVI/cKTTqsL7a2cclpsRLLQIrEv3iWkXpu1BsL9x28xZjtC1slGEhCG6a?=
 =?us-ascii?Q?fVjPDtSQhKtEY7ySUM6R2R7IilpIAtqVkva5jJPF5Sd791Ols45ROI8x/KwD?=
 =?us-ascii?Q?18alxVIivRAGZPLxsp5nZe6/ysRWPGr3G+nq4fvGian4nOppL0q5Y0+jByZw?=
 =?us-ascii?Q?di9D27te5n7KG3S1okxuJ0jSHz6jnCGbJ0Wfz838F9DW3zaWVkMZ7rirnHKf?=
 =?us-ascii?Q?tZ2POuaFY8pxZZvlZD/Dmn2ElduxTi6f7Iqii9gRzVINC9+BUl46FR7ga/Nh?=
 =?us-ascii?Q?L4sjgMQvlMJAXlLyik+XkXs4vI1Sbw4HGWaD9rVHjWMgn02BwJTNVvj7IOfY?=
 =?us-ascii?Q?VcGvE3HdomniELsDoUB7Z2hhfDL3nPB6zYMquqLa65LNggcmvgDhnFa5H7oh?=
 =?us-ascii?Q?WtigGfpE8MlC6zz5pMzI8mNhICZ+kuE=3D?=
X-Exchange-RoutingPolicyChecked:
	tYCcCRDyKBd8lC5W5yO5S3bIESSoXd0Fv+XQ5SSEs6raFVLOKmSPA1kdM9w+iHnBwntJWFpOppqkwatCRLngpTP2vKM2Me9bYa0i2mLsuyT6Dp06NEb3JJN9VsjaxQ8frj2VC3ClMcPwJ8IatYJoJbUJpu4Z1XLxdxeD2xYSuEfl8kzNAoBJpxrDS4r240h4lLPaEvMidqYq6CkR7lfrr4eqN2VuVA5hVQbP9oOlJUTEAKADjexnmUBKsqswmBu/d5nMiDXYBgEoXHiERN8riBb2gIt6vE+W0se008SxotbsvhlPEsWFJZKVD+ZW/pC/UJ9LfGL5/iziH0Yh9yVesQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	S3Jv4yQJfUMvBGcb6Ew2LE1ptX0h4Qrp88Fih5D6rn17Z4hUfcDfk+ph8s66swc8ikegLzSF/o7S2+NBVFxfjr0+0xPKfl3No7W3Bg8JjzsYNhdbOll5LCSTMr5iKLk9MCnrsgVS0O0kgI1uOPFDf7iz/4fXDzOELt9oOC2G1xf51dIfiQcoYnBiqVrNTSDIBUEy4r4w7XLqIWJacf5YQbOSd7qVD2WARxkA0Sci0URWekNMyJ/PECIm+SMt17jPT+pmHWUbuzLdPvxOzcjLLIk1aAtf0/YvKFgIXyDbmB1A8Ea6sabLlTWN6cKE/Smrx/q7pG0QimR0j06+LAmAc+C2dKFcydB3+us1raEjia1sZtCTxrfrWpdlDUm32VGDoSm9AB3PVyCR9VS4+20dPOPY1ChisLlbPgHXkNPXDqIkqyifjqS/qMdpWy+kNo1Rxwj9EfWANvBQXZOoL7nlsO5+iRrpBcJ28QlCov08cFCrymUHmBnfd26NYJnnMDPsU/I1MfkAt71Sc1B1eEEMWyru6MXi09Ef+ycMCn7FRM5YPKMxaTc6xi26a9V712PmdtfrAvAzD+IvgZyqVMTIXck3jtDPGhMjj5rX3tbtYhc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ca4f179-b08e-4d0d-924d-08de903e716b
X-MS-Exchange-CrossTenant-AuthSource: DM8PR10MB5416.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 22:31:40.2128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p9x+4YAIm8lRWNYgXdOwmdEnt72bJwrubNjF5LHN6oaRlzjBxzGTO8AtTxSu3QIGxsW4JJi+VF9wFc3CuijPuH3VatHEkigULwrCEGQd48A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6743
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_04,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 bulkscore=0 malwarescore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2603050001 definitions=main-2604010212
X-Proofpoint-GUID: j2mqLq9iqQh_Mcl3O-ZMH3vBzwKo-4_I
X-Authority-Analysis: v=2.4 cv=G7cR0tk5 c=1 sm=1 tr=0 ts=69cd9cd2 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=EIcjfB9IiI4px24ztqRk:22 a=7CQSdrXTAAAA:8 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8
 a=yPCof4ZbAAAA:8 a=pnmuM6TG8pbiPne0lAMA:9 a=a-qgeE7W1pNrGK8U0ZQC:22
 a=1CNFftbPRP8L7MoqJWF3:22 cc=ntf awl=host:13825
X-Proofpoint-ORIG-GUID: j2mqLq9iqQh_Mcl3O-ZMH3vBzwKo-4_I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDIxMSBTYWx0ZWRfXwYjBCb3npq1f
 F+SuJAZqZpxaQGciZx7ygZ6887K5DK0GChUqB+Ae8gNpRYPKk7NtPeXNetbkUotiTDrrvTjnIg3
 /gDrlN7y/ZA6jju6BycONuZo6e5pkiFeFp+eCpmUmi4K23wEYjWciKGr63i81S38YaK5/GMCI+O
 jV4uWK/r7/j8idAQD4Z/ouXbTYEkaXg+wdkSWQwz72cOqbmpVaryL5bolDHWxojVUMdvNUZERU9
 UHA7V3WwmCyqhYPicVduWGuIKlDtQ1wnABIAL7CIFJ/fNN0Zwpp5y9ZCuW9m5RZTL4HpukLbZ/N
 cPitAVCOlYCxF7s0Iu1hQeM4hMFlZ8NeG19MuXyeZ9cXglzisf0q+TyVLURereURa+zODH3cNCo
 z1FGQq4DK65AuaS8gnzaHjZ7MUnwXVCk/Wigp6GMw8r6AcCS+S24q1U+C7KGFS6Yx3KbVjbt+LA
 DTSMF8Z72byjxWOquVMOmXV5kak7FY5H7FDrRbxA=


Catalin Marinas <catalin.marinas@arm.com> writes:

> On Sun, Mar 15, 2026 at 06:36:43PM -0700, Ankur Arora wrote:
>> To handle WFET use __cmpwait_timeout() similarly to __cmpwait(). These
>> call out to the respective __cmpwait_case_timeout_##sz(),
>> __cmpwait_case_##sz() functions.
>>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

Great. Thanks Catalin.

--
ankur
