Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6743A478846;
	Thu, 30 Jul 2026 23:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785455354; cv=fail; b=ceGT5L4hEiFXurFBq4xIsDgpHOgQUCaS6EfNCTd+6ugBzNVSz954Y6J/MVh8edL04/foHFodQ/r4KRaRg0YdkfYmJm5uBpEM5kF8+/NNmFPyrgPriHXWtQ/m4IJ861hvflxFv17rRTHFc8ntMkvA4BV9LuT5MF6zQfRbbAiiDhw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785455354; c=relaxed/simple;
	bh=3YZACoLGoRjY/ZOrdMhEkTLF4gSwneHH1u8wl9+Zpwo=;
	h=References:From:To:Subject:CC:In-reply-to:Message-ID:Date:
	 Content-Type:MIME-Version; b=COrcYmAsVLm5svEYf1aGFA8A744rq4iHoS3HNzdt+QNZAoZVuPB0x18lYKwjUzZ4cyufM+EbfQbCNMqgllAURK0yKG1dqzSq8uSP3urfEN4XIlftvwAPIQUerLAEDjV3MbAiwN8jU2eDdYgf3Pa9cEJLqwhS0lj8PJWLKbztOcg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KCa5KPi2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=m+YXyiHf; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KCa5KPi2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="m+YXyiHf"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UEu5Ei1780428;
	Thu, 30 Jul 2026 23:48:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=uEoFrFsUB4JKBI6wPr
	xWmac0Nnug7mbR9TDyKb84zoI=; b=KCa5KPi22OR+D7tz2DcvZVSrCyQ91HhzqU
	oFT3rOHfoYFKlOWbgD6js35TWaEilmkKjFSKwkj8LFD038WoB8URL8pzgKLxjMVm
	a/PG+qZDnqvooEADuDhd7DPFCLihppHvQtOIuQ147dh8zt/tOJfEoofGbUcJCp6X
	n9/gY82bX4+6PTvYKTvwh6B84W/pt4KyI5VFDXDYriRjV+SdJmsLbAt0RMBteIKN
	AzuwBb/VKuow9Qj/q3SmCWHt0BSvbkJHs+tS/izNNOvMcS1FiHjOl+rux3bcIqc8
	TPHOBilyXF6+6t2m60NyPLTHuQU23d5G7SNqqAsfha4vP/H0SjAQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fmr018nat-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jul 2026 23:48:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66UNj5XJ001680;
	Thu, 30 Jul 2026 23:48:38 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011035.outbound.protection.outlook.com [40.93.194.35])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4fnh6frrnj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 30 Jul 2026 23:48:38 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mWm+gtJ38X4r1FIInH1RUXMk4ypWwIVj/Ksc1mXRcxFmPWPTOfPeqrCun3l6DBYmsMzVZZCWeVqDb1Hd3x7UFgTPuvCmkyuUsF7yXTPx8LSHMmUBP30zmElBeuBebJA6CjirErvo4lvPlGCBr0ueQk7R3f5Irkl8engNAgpX9eiTjtN1+1LHUrUJ1ttDJBH5MrLet3QNbA3e9+SfG+Pp3hNquF+prioqpyT+EJZsf0AFdaTMEoOHJPE2raScz0Umjg3qvONkibtTQPFfyzLeRbrj8dE+lTob5OAxYPACsZYy9lgzcs8HroqtOSdm8SQjhhGk1QIBSTb346LXYsE1Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uEoFrFsUB4JKBI6wPrxWmac0Nnug7mbR9TDyKb84zoI=;
 b=FtXVmx8Psw2sMNG+EdnV1abZImaL9o7FgDI4/YIPAeSg2Z8eqSVr6ZMjzb0zyckV6JwOGXZGS3a2ty4v45T7Kz+CJiuDsCh9mnneOdfXzOHDcMnCbzAzTmsMnyKGZxJYrlc2shCZKjpDhmjY+mw0pB5yUwGjXxG6TiG7hgwxKs+aaHerGW8MziXSVwPXfnRH1h8cpBmWrS8T1gdbc0pjCgFm9ygf8gF7XnxQrsQi3fpuF2/b+LlDTCj/yJ8h/BMhJn18KSfnS/WbJpea6Ka/WDjMbpj1ZwStwiXnrFNe/x7kfPXc4J84mkfHA6kUFgvMmOgVv0kboXEe85i5/MMkxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uEoFrFsUB4JKBI6wPrxWmac0Nnug7mbR9TDyKb84zoI=;
 b=m+YXyiHfFscKVgSawuNBv9wpGCJSo11OG8qYID3HPb7jUvTC2kExRhc7KSFEK6QR1k4Ts7o8umrRfJOUkhT1mgDOi6677Tv6+e/2kP2LIZAxu/8pgW2UKeDsnaJBblpIzT8eZRfaeF9pJHL5ViBNM+/RTudhjMKlydkh58fCRhQ=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SN7PR10MB6545.namprd10.prod.outlook.com (2603:10b6:806:2a8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Thu, 30 Jul
 2026 23:48:33 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 23:48:33 +0000
References: <20260714073041.40250-1-ankur.a.arora@oracle.com>
 <20260714073041.40250-2-ankur.a.arora@oracle.com>
 <20260714074238.3989E1F000E9@smtp.kernel.org>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: sashiko-reviews@lists.linux.dev, <linux-kernel@vger.kernel.org>,
        <linux-arch@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-pm@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH v14 01/15] asm-generic: barrier: Add
 smp_cond_load_relaxed_timeout()
CC: <arnd@arndb.de>, <catalin.marinas@arm.com>, <will@kernel.org>,
        <peterz@infradead.org>, <akpm@linux-foundation.org>,
        <mark.rutland@arm.com>, <harisokn@amazon.com>, <cl@gentwo.org>,
        <ast@kernel.org>, <rafael@kernel.org>, <daniel.lezcano@linaro.org>,
        <memxor@gmail.com>, <zhenglifeng1@huawei.com>,
        <xueshuai@linux.alibaba.com>, <rdunlap@infradead.org>,
        <david.laight.linux@gmail.com>, <broonie@kernel.org>,
        <joao.m.martins@oracle.com>, <boris.ostrovsky@oracle.com>,
        <konrad.wilk@oracle.com>, <ashok.bhat@arm.com>,
        Ankur Arora
 <ankur.a.arora@oracle.com>
In-reply-to: <20260714074238.3989E1F000E9@smtp.kernel.org>
Message-ID: <87bjbo2g51.fsf@oracle.com>
Date: Thu, 30 Jul 2026 16:48:26 -0700
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0215.namprd04.prod.outlook.com
 (2603:10b6:303:87::10) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SN7PR10MB6545:EE_
X-MS-Office365-Filtering-Correlation-Id: 77bbc183-5b9e-4bbd-9189-08deee9510dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|366016|1800799024|6133799003|10067099003|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	XIopBKLGrYL0hCjA/ybW72zvh1JH05LNn7fTg5ZOVSGqssyTjdNbcYzlR5kysDrakCqEYaVO3FqwSGI17Pt+uqh1r3/QftT/1Yp9fzQuuQCvUAOECfwkFYHRE8cFE6+zgy9VOKF0QT5jQXSlq6qZXkl+t0Mue0fwQdA2czwrCOI+g43fp2NxNxF4LrDwGp7bw/uIZCUxOlE4+/z19ZaD0jRi0qoLHqntRfK8+UWOKtVtmL1ok6rTcLp+vugBi/5YhXdNfHaFwKqfwBaF1Qo/nbCuMgRdrOWHcx8D/KtR5ahEqj2l9rwWZse+nO/mMFdvFBxo4F/DNAxFu0Qgu5u2ikT8PdtvK6SiB9tpsJLqSQmA3/u4gv4I3VxsUsgB4KdRNuAN63wx65ErNPbVKi87TGhhT9E5yiRwtPieOooua1AL7vcpy64IQ8sIq/lmlkXZcBuTd/ir4ODzgzn3piakEWAo6nlINtbX+8ymySviq7Mn9w4gZQye4iC1BzccXWdT8Rq//VlIRwVOGwCGLaIMD4XpflEuvzByLfIMzPIfdjKIW3uaT2+lpPd6wWbWe7zduvyd2+fPpJJ80dKpA3F0Kij5XIzPsithXO7fkD8kCmZ6cNXxz5XlqIMzpbsJQzi7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(366016)(1800799024)(6133799003)(10067099003)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ufOX85MOMHt6XZSGtKUPTUCwP0rxu6Gtnh/6TX9C1dAOw9MP4oBtpvYKxXNo?=
 =?us-ascii?Q?drH/7+av+N37rXDhX3OZnqZakkO373y0yAF4rwqIa8+duyIZbBnztOFMUYxO?=
 =?us-ascii?Q?XwtnzsIEle5l8yDFpWdT3V4r9JG4RWoToP+RG4aV3rEYnRp4Pmm1GvTugv1V?=
 =?us-ascii?Q?xdM2yzGH7EXPqFML/bgs2tu48D7NDrdjCflfaHcE9kYq58GM28kkuyKXeppP?=
 =?us-ascii?Q?prCDFDPcMCG0eISlK4CFt326tcQEyahFx3FNgD6VZzp5RjBTkh5ItG5JEpAp?=
 =?us-ascii?Q?+I6w6mDZK2P3DJ50zTKCOMWuOlfTlmC4qlfskrSeJXNZuVN0awA8Qi6gPiFN?=
 =?us-ascii?Q?mSv51hmrs/y7/upgoJc4mWkPqvCfQGDMHauJYDkQG0+BL/4t7sF2r8RugAed?=
 =?us-ascii?Q?EHUKMP5D9C7AlIC2eziNcgju67RtPUaQVkLJUoaRX+qUlNiFK7qazWCAzY81?=
 =?us-ascii?Q?GcTw+wN0KlWcwgprrf8ejFHIwP9pjp7d2asFWOAkknqIgnZixiI8gXWJqaqI?=
 =?us-ascii?Q?de3uiEbb7kFe4QfjnQ6AkyJQ1PZFs5gniDvH++gXDSjBSlkMjmG/ac5xKyKQ?=
 =?us-ascii?Q?PI5VhzYlxEuwaAUPvVJQrmwxJCFh870xMiK6uHoftbYlJx7WXC9W5PD83+1H?=
 =?us-ascii?Q?iOgpj+ntxG3MVJxn/B1ZQMdN0b+RL5eRQWwDWdWWOhSbgPqGGNQ5DlEuF6gU?=
 =?us-ascii?Q?Uq6SayH9t8392DuSS06sgCJU+n1/3VtRohLvALefVvkdLnYrBOAMVf41CCAT?=
 =?us-ascii?Q?do5povSHHzvus0fmu2VQVW4GyKc5uEUBT8Lrdm2cvlny/YDxGbdN5CjNPl55?=
 =?us-ascii?Q?e8NnuO8qItuLN4XT/zfN1dKOEDVzha1j1CS1E/WbVXSAefOdDX//AZldPVs/?=
 =?us-ascii?Q?D9dtFU+wzv9ZLd6zW84+hKmsQ9X2EfnXW/0ukviwJfXPcG48XhbI5smhC8kt?=
 =?us-ascii?Q?xrbr14VMJbfk98e4o2Ij0rapiJU1JAcEWmQB1C1wfnNqX05NJRigf49USIl2?=
 =?us-ascii?Q?YY5SlzKaX4pk0c9ZQcSk/u5YhLsFdF5hzMepaU5FkZK4PK/wuIed8YGb/Wi4?=
 =?us-ascii?Q?OFAzeJSLjfMjYR04xc9FjYl1qwrmv6h4kwa83VilnhvRxf31yPiJuZFra/eS?=
 =?us-ascii?Q?F3YFyQGs6TXcCw6I8Lx6FsNZ8swtgls8ISn/uWf3pa08PTejkvkbW8ZGkiiF?=
 =?us-ascii?Q?uEIohSWldf8Nt3NEk34ekMBX2Onj+wgM4MogkL8ClbJFp5l5kx9uoL/vEpuY?=
 =?us-ascii?Q?8q31DT1pjYOTFYTnAXMKLw4xNZ4WEDLuiu6KsW4/fkvNMa3X7qwgVYmeX4/m?=
 =?us-ascii?Q?QTAjpFPkRJPUij6S0x21Bxfe1el6Rp22wA4bJmDvVNuRKZwGsB0RUroF/dx1?=
 =?us-ascii?Q?b9ynm1cKkdeTNhW64vJ+9vAUHnJ5kKI3ZQ+0fpbBexNKw8V43p5BHBvEqdts?=
 =?us-ascii?Q?HmMFhGY6tiyEiVY8KE5IieKbmw0+jr7vspx/2KBIS2pF9o64HXajVfHSrhNe?=
 =?us-ascii?Q?lZXBEmxAe1sQwN5w0sBAtySsTBzD336LB8VXacSerKxoqi4PioxnU919P93g?=
 =?us-ascii?Q?WbulGHPfD19GVAoG6Cx4qwqAtf32zsRzaeA0M7J0krlzk72pCq10fHAzbVNx?=
 =?us-ascii?Q?4fqN18cVnyzJoPGG6lGqOlcsUKBBIPD7ah2wbqDINb+UJ/wiAACkTqOG6cUu?=
 =?us-ascii?Q?qml0JyfimKEVTvwYZpizY2BaJ3yJd59WnevvGp87/+U8yARgTIUEKjihJnJS?=
 =?us-ascii?Q?Uhdb0XrIgdRJ6bBHyl4txKQ3og+aMW0=3D?=
X-Exchange-RoutingPolicyChecked:
	Gm9FSk47wR1YfiakA5ew5DfC6tZn1q6+zE6t0Akl14u9FSkXN9ux4e5s+OkXkZK/0t/AOIDfXlKhdUNf1M6k5+8TGKTqwI+Xw3/rVK0tM4Oof+UGlnUUoh2ntyYPSHIOP7NFd7+cOoAUFWBAjeJLCOZUbuo7UCNkJ7FqYsG3Xb1mg21AV3bkqewLSYiKxftYm1qK1IGNQW6awdeXTgiUTZZguNHDz4AGjjD7csFXixPi0toAHPpHtLxiGuL0lBsOGuwz8qcKqz8hcpKp4tlvKp5IP555BEXHnKEilhy/uiSSHTQNVFzfydsir22ezT5wCawzPxb588v+Gi2ti3rEkg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3Jh6RwYXAhKLshyOXbDNZsnWP5+EE4hLgE4GDJm3fpu2SZEVI4TuWW7JqMq3J4ecFcL9bY4jojVNGbLYcfH8R763+2hmZU/co8eQ5a7z+khG6O4wGswdcBYRb4JAAGeaDgXrAB3kHs2Hp7HCR+mHH4drbE2zpAaclws5wEHyLRExcbjDzNwkkBpfOW9l4//fZNNjCG6T+THYEtI/QFMXNL5bIknYPuGhvJ0GxvzxZlCFrLaxrZQcalGrNyTW+usasPeBkiBv0aKYp5AEydNIfaUlMZK3aB7US/oI8a2MjyJTbm9rWmemYjpwSxmo9w8vlbBTSrWQpGbLkAF81qf8iEjph7p01ctEedKwEgHk9wcyZacAH94vVK5qI0xkaMQ+Mt8025dhwY4mzY5MyyUdAeMndHYUqXEZtzgXLmk1KgCiZ0IxL+CxPk50j4+xttt6TJhbD0kb3x4nfDcQUjIJhQ01V+7RL/Vl7A1FNel/IOTtmjS7+pQj6HqYz4f8e/zK/fz7wKjXARM5M5EOksgyYkIHSOvOCUuZb/z4EWDoNlQLwJMnjfADqaz3BfFCWszsoWod4uj7uV2CNM7W/XzdgWoh1b2Fy6Q6VNTYvr7VRj4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77bbc183-5b9e-4bbd-9189-08deee9510dd
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 23:48:33.5020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Okxd2x9qzD+0hChKC1dIbQ++wLoaVao+rcjZCQOz8OU20B0+6ORgwK6+2Riygjoe6Hux+p1zh5vQYOi+H77B/7mjenA/94OIUtH1igwu7EM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6545
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_07,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 spamscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2607300168
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDE2OCBTYWx0ZWRfX78UfN8jMiIPw
 PeCuFWSGwZY99cBN/BvaAxyan6z0u1yqPE1kBPn/W/WWpIImsY/G4bwdO9eU2zEE4aZtUhpQt24
 l6ttIZi6i12n0PbG/k2ph0I8fkDpq6HVP6mgA0est904hB8fyXlb
X-Proofpoint-GUID: _1412NMMSiW8XYl2MycxjMOOuPzUINbG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDE2OCBTYWx0ZWRfX5rNtRSOKTM0U
 cOIgnba8up9ze/M7HqXYo6t0bNgf9m2B527tzygXqxkJQ3OrGoxxJleyQ8t2Qp7Gijv0bOEoK0t
 rSG+Fq2iJuqEXCpS1iMSeho3QEcHTFtCWYEtt/hOp1ykyHfEjI+W9iejYjxH9GbDHLxzV3CfmUV
 UApJov+/WR+w2LEDsA0RaTVx7KG2dki16vFl/KqZdXSdcR8zrGfupaGvVqCdBh6gy+ZDWKCfUWd
 VILpdJBCRWbX2UhbD8qVFJE3ufJphHKH5DM9tdm5zIhVpVWJiBPsGZxW9bIBNn4qOA7mNbgFcRx
 AuLi0hVAIeT6Et7J8zv/rsQLXeYWE/PCaT9H/65Pg6pna81L0O0niqUAKmCX7uOnuh8g25sgS4L
 EO3BVOQs6rE1JhQqhDHYG2lWXmSXl9hiy3NxDSzggg2uwoiwS/hrcywNHEh9D2yi06zMQYbA3Yd
 iipTIvP2eaNDHlkqPsRQYXdCluLyvIvo8r9poLUE=
X-Authority-Analysis: v=2.4 cv=KL1qylFo c=1 sm=1 tr=0 ts=6a6be2d7 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x0eKOSpe3m1H3M0S9YoZ:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=ioxSF_swaosVMKuJwF4A:9 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22
 cc=ntf awl=host:13517
X-Proofpoint-ORIG-GUID: _1412NMMSiW8XYl2MycxjMOOuPzUINbG


sashiko-bot@kernel.org writes:

> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> - [High] Deferred time check causes massive timeout multiplication on architectures with precise waits.
> - [High] Unchecked negative initial timeout leads to an infinite hardware sleep.
> - [High] Generic local variable names in the macro cause dangerous variable shadowing.
> - [Medium] Missing parentheses around the `timeout_ns` macro argument.
> --
>
> --- Patch [1]: [PATCH v14 01/15] asm-generic: barrier: Add smp_cond_load_relaxed_timeout() ---
> commit fd56d26a441207368c7c3704e10f44093698b198
> Author: Ankur Arora <ankur.a.arora@oracle.com>
> Subject: asm-generic: barrier: Add smp_cond_load_relaxed_timeout()
>
> This patch introduces smp_cond_load_relaxed_timeout, extending the relaxed
> condition loader with a timeout mechanism. It implements a loop with
> cpu_poll_relax and defers time checks to a slowpath to minimize performance
> overhead.
>
>> diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
>> index d4f581c1e21da..ecdaddbbd7b64 100644
>> --- a/include/asm-generic/barrier.h
>> +++ b/include/asm-generic/barrier.h
> [ ... ]
>> +#ifndef smp_cond_load_relaxed_timeout
>> +#define smp_cond_load_relaxed_timeout(ptr, cond_expr,			\
>> +				      time_expr_ns, timeout_ns)		\
>> +({									\
>> +	typeof(ptr) __PTR = (ptr);					\
>> +	__unqual_scalar_typeof(*(ptr)) VAL;				\
>> +	u32 __count = 0, __spin = SMP_TIMEOUT_POLL_COUNT;		\
>
> [Severity: High]
> Could these generic variable names cause variable shadowing issues?
>
> If a caller passes an expression for time_expr_ns or cond_expr that uses a
> variable named __count or __timeout, would it evaluate using the macro's
> internal variables instead of the caller's? For example, if the caller's
> timeout variable is named __timeout, might it initialize the macro's local
> variable with its own uninitialized value?

process/coding-style.rst does mention this case:

 5) namespace collisions when defining local variables in macros resembling
 functions:
   ...
  ret is a common name for a local variable - __foo_ret is less likely
  to collide with an existing variable.

This has an __ prefix, but I suppose a collision is possible. Will fix.

>> +	s64 __timeout = (s64)timeout_ns;				\
>
> [Severity: Medium]
> Is it possible for operator precedence to cause incorrect timeout calculations
> here?
>
> Since the timeout_ns macro argument is not enclosed in parentheses during the
> cast, if a caller passes an expression like a << b, the cast would apply only
> to the first operand instead of the entire expression.

Had missed this. Will fix.

>> +	s64 __time_now, __time_end = 0;					\
>> +									\
>> +	for (;;) {							\
>> +		VAL = READ_ONCE(*__PTR);				\
>> +		if (cond_expr)						\
>> +			break;						\
>> +		cpu_poll_relax(__PTR, VAL, (u64)__timeout);		\
>
> [Severity: High]
> What happens if the initial timeout_ns passed by the caller is zero or
> negative?
>
> Because the time validation is deferred for SMP_TIMEOUT_POLL_COUNT iterations,
> a negative initial timeout is cast to u64 on the very first loop iteration. On
> architectures that implement a precise hardware wait, could this extremely
> large unsigned value cause an infinite hardware sleep instead of returning
> immediately?

If an arch implements a precise hardware wait it doesn't make sense for it
to define SMP_TIMEOUT_POLL_COUNT to be anything but 1.

If the caller calls with timeout_ns=0, then in general it is architecture
defined if it results in an arbitray wait or immediate return.
(On arm64 it will result in an immediate return with WFET, and up to
100us delay with WFE.)

If the caller uses timeout_ns < 0, then this will result in a long sleep.

IMO something like this is best addressed at code review instead of adding
unnecessary checks in potentially fast path code.

However, in the typical case of constant value of timeout_ns, there's no
runtime cost to the check. So, I'll add a domain check at the top level.

That should remove a bunch of sashiko comments.

>> +		if (++__count < __spin)					\
>> +			continue;					\
>
> [Severity: High]
> Does this loop inadvertently multiply the wait time on architectures with
> precise waits?
>
> Since __timeout is repeatedly passed to cpu_poll_relax without being
> decremented inside the SMP_TIMEOUT_POLL_COUNT deferral loop, if the CPU wakes
> up spuriously, it appears it will sleep again for the full initial timeout
> duration up to 200 times. Could this cause significant latency spikes?

In theory, this could happen. However, as the comment above
cpu_poll_relax() says:

   /*
    * cpu_poll_relax() stitches up two kinds of primitives: ones that provide
    * a momentary blip in the pipeline (ex. cpu_relax() on x86).
    * The second support waiting for @ptr value to change, coupled with a
    * with a precise (or imprecise) timeout.
    *
    * cpu_poll_relax() keeps them together, because its utility is in minimizing
    * expensive operations while polling on @ptr waiting for it to change.
    * The arguments to cpu_poll_relax() are only needed for the waiting
    * primitives.
    * ... */

So, for cases where the arch implements a timeout it doesn't make sense
for it to define SMP_TIMEOUT_POLL_COUNT to be anything but 1.

That said, the deferral of the time-check (to ensure we don't pay a cost
in the fast path ex. the locking path in rqspinlock) will cause a delay
(potentially up to doubling the timeout.) That could be fixed with an
alternative like the one I posted in:
  https://lore.kernel.org/all/874iklm1uy.fsf@oracle.com/

However, after the discussion with David Laight I came to the view that
it just overcomplicates the implementation for no real gain.

A better fix is to just document that in the worst cae me might end up
waiting for double the timeout (this is documented in the commit message).

--
ankur
