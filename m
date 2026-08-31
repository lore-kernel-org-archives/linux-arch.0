Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA3C38D400;
	Mon, 31 Aug 2026 20:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788207820; cv=fail; b=Nf6uMY4IJnRQfFXg07oqqJ1yRnEuqvaKJAHlGmxAM7WP3a5DneFnDwZKfA8V1B0smTpZS+DA29CkAignMSP00+J4EYGHFL5QmF54zH2q7ISoN+dy51aFsEhnLVNskJxgkkz/3tJ7wjcLHDuLIH5bvYMZeKDykakDQk5bWE4yVSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788207820; c=relaxed/simple;
	bh=8t95CQy+opN0++rZOlkAFyo2ok2sdrdUqSjnK1XLeRw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kr8ZZ5TMe+nquFsmMn5Su4nhBmRQq7oqhGrV07HoDoHsbe483x1RizcO5pF9afv0S13wS6OvyT7s6HHPLQCV59K6a67e3O6+0++yNymH+aWzmnvozugdDNQRydK9kbNUetpMMHOC+lzPTNkzUe+bfrZSdKuCcBW9Ri927ExLCcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=q5q9pXCc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=e/i5Imot; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="q5q9pXCc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="e/i5Imot"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VGBi111783695;
	Mon, 31 Aug 2026 20:23:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=lFVh8jbQtaCVf3OE5e+LK2Bz1wakk4bJToBOsSDi+sQ=; b=
	q5q9pXCcP92cFFOmKbymfzuj0Rgh7NLtFmFZZQrDEHyQaG/4/hiMdfsZAxq5D2Rx
	+8CD1SYQVRyqQvkE5Wiot/toh1mCKgkqdSEObbRl25MltKdG1q/qRuIjp0F/SY57
	3ykFq6LdtU8pPGpPnseU+dC+eCFMuIHwJ/Xeftdd6oeiJSgdPnCTdln+K/8UrfZv
	NTvzAkJ6u1Lc6uwrxbgcAx0R7b6RKKrqw4265fqW6aCYSc1sRwmjc4UukIlk3tLo
	JDDvcnGZgjrSQxWo/Zj4mh23ihm/vHkt2dKPYjlg2pVg6bEgu5IyFEO3sUJnT7Mt
	0AAIuYPLwUr+8U19xip6TA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gbp0xud59-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 20:23:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 67VKK9cg038828;
	Mon, 31 Aug 2026 20:23:12 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011022.outbound.protection.outlook.com [40.93.194.22])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4gbnvdgjs6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 31 Aug 2026 20:23:12 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TNhN3mo1hHmzI4Kvncdoxlx3xVZCL6vwId7r/icHqlUdpjKLXnWGWO6RJ9uQT59EQfjC18INggr/juB0Cb07qc0VBX8b65aB9rBtdfuDg3B4ra3/sJYbFNGnbUJsR9yBOlahoWITMZtJptta0xHWqewcVXRM4VEdBffojQQ+vySw4NYuvX4H6vF5KhJhcZPi4aCQCMNI9QuFRIA6Q9tXvE3LBqiBN7UlulTU1VVA3Ihbjql81i1FjIyZeek60Ws/NgmQ3FMgSKRHNfevZ2EYePu9NxeDPghaE0ABkSwTQzOvrYiwjupiWnWt2MdlxBvjNNNBDbnBLHn3l3JuyI3qTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lFVh8jbQtaCVf3OE5e+LK2Bz1wakk4bJToBOsSDi+sQ=;
 b=q4ibvWCc4jYsUKl0nlZNKrtOu/07zn/wkMNoL2QRLWLZk+ATv6EAdFfL4y9O0Q6NVnP7wLqTUauJfXFSoSLzPnhrZavvfYDYlosct/nHwX2QVMJjthcgHXaTlpngse+cgHBGbZ/NS6ZYBFfta8iRHocMyrboF+vvzwiBIhaz/P2BBTj3pRxp6jhVg+PeiEdRiTLkG2VnRACjv+UjWIvbjTtTqjwzAQskEKbkJjht70WzEnm+ActQqKgg8B4ub+2YzJG2qCDH91WTJS3L/iBoY1jfBYR95CS+nktQxewvKTaxnParauhRjachQvRaAyhz8Fq7dhIkpsV2lMCg5kscww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lFVh8jbQtaCVf3OE5e+LK2Bz1wakk4bJToBOsSDi+sQ=;
 b=e/i5Imot8zzyx204GE/thP4KsTe9xPIOfCD+WD9Nt6Uu2cVvWQssa2tqMApSVa1DOILg4vIgKBOmtr3B+yGN3+BHWp2s+Uy+aZh40gZVJfiHuD79qWGZVNnsbknvDalETKc1yu71ggV08pWm2BFI7vDhVCwpcq1sfqSy6MfmBUA=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by PH7PR10MB6179.namprd10.prod.outlook.com (2603:10b6:510:1f1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Mon, 31 Aug
 2026 20:23:08 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.21.0382.007; Mon, 31 Aug 2026
 20:23:08 +0000
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
Subject: [PATCH v15 06/16] asm-generic: barrier: Add smp_cond_load_acquire_timeout()
Date: Mon, 31 Aug 2026 13:22:41 -0700
Message-Id: <20260831202251.305046-7-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260831202251.305046-1-ankur.a.arora@oracle.com>
References: <20260831202251.305046-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0348.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fc::10) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|PH7PR10MB6179:EE_
X-MS-Office365-Filtering-Correlation-Id: 2223981c-4c0d-41d0-4c23-08df079dabc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|7416014|376014|1800799024|56012099006|10067099003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	M28H3ZHXzOgWFIOIQH4QF9r+ISi4uggDQD4ZOuWz06fL8erSIlW+gzeCQMZuaLlqmjzQ3TMY3QD54SIzxVhUgAoXHWSC6obYkCMWndy5viaV4khbGr9ZqQY1k2PAWX0MzKRqdEBSfl1/gL2dBhEQbWKgR4hqSSFUlaSPjWQdd7sVEWyXUkAsZ504/HJIs25h2pWEdCg5AD9DEkNAB6ykbic/nDKwsipsi/DXuyWVsnJgmvSOn2Ra9vcQ8mtF7Tarek7mihMiQLOUT7YQl/EVkZ99wTZtxjgXlFsb3MfdQohUXi8yDPlAVt+I8KddxG+Y/dvm2YG/PU9cjz+goc8PC87pemgfxieq3fWS35KmoyBNNdUSTJWzqcnL/4WckqD/sZKpje62s+/KfPrimfRprTG/Hbjj0cMji2A7NADFyXswnjS2ECwy6SXCGTZmwXSmRdB1QposqMoIM7rCnMG4ySkrK0CdEwHVdWDj0aVRNi3um5FGjR3wdXP8Kd2L1z75Dvalu6wcJcxf8v+HQ0y6X3PTBa4MNUoobmoy8qHQBE86TtlGeRIYE/kxc6y91eV7if7o+/X6NiY+xvi74Of9EvtXVlmuOhMVjVLp6RJoD7uxuXndq27q7bZTUEyMKx2MBIktGYUEabOujPefgSrmjVTzWXJI4WtfYuTUnTPsq5s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(56012099006)(10067099003)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AzSXRI7yR1KsofyZ1j9bwW+c2StQnY/1vZU6n1W8vTAQXK9HusdkBvTkmLvx?=
 =?us-ascii?Q?VzBZVhE1poSGZIxd1cZm5L938uKf7SHFc4bQZZ/aX3fkdffjpnDlrcmzke1g?=
 =?us-ascii?Q?iaWhCmThgY422B6O5SE9+JhUQU0dG3KX2rOgAZKzENE/tfIZzEKlVPOvRPge?=
 =?us-ascii?Q?Zk/3ZJDFjLJNawivvCpWx3NZkOEjQnkgjGkc6IyAQNNAYwj1TZ1B8H5an+Xc?=
 =?us-ascii?Q?jxVtYFfzwUygLP9eGCdp5djlFlMaDp3Kq2HtXkr+nkPcVHlQXA8cAF8KVKf8?=
 =?us-ascii?Q?atQ8pGvvNkTGwN3u8YrvLppgeZw7AtbQs4yi+4YSl8rzqhaQ4+cMH4Qvfk7t?=
 =?us-ascii?Q?VBUCgUrf+Bb7Q4ImljL/X/KnxaV5LZ9aWUiSQFyULZ/NxND39VRJOYnwnFfo?=
 =?us-ascii?Q?RVGJ1I0Kk5h13oiP4p3WUetSWPe9XWGHqjWFGX+04GuWJ16FvUZQZyMIuY0f?=
 =?us-ascii?Q?XWoboBFpWYE1jLZ3vdLHAjKtfMGfFwp7zM+92mPxucy/lcH+7W3fsfC6yPfm?=
 =?us-ascii?Q?pzChNFJl7AR/SQwPqQCMqwEFjUaVSpnuZ8vZSnDGKdQqwUUyzCiubms2pzl7?=
 =?us-ascii?Q?GQrShk97TQ8Mj/QFCq9U905CUB9XJb5AKasWtgpue1G3wmvODT2nWfBj8bNL?=
 =?us-ascii?Q?wB6IZbQugIjJpopJNjbjgBc2oTs17e5997qghVRV7mGVYcpqlOvMiDtiSKjI?=
 =?us-ascii?Q?eHzQJzX6J/nTYTnXXnaETDEKPQxG5Sxygm6Z2ZQTsifGqgeD+G6EBFPSjVZX?=
 =?us-ascii?Q?aCbPMDirgQgPbnyu2Lr3VhQpp0sRJyflBhG6jql+UEKOKrLoN9WOS+DnxqDr?=
 =?us-ascii?Q?tGblzKQ+s5zR6wWkyiV5UjsMAM4C9//S87+B76N25fjnnWzN21qTRF5nuaX+?=
 =?us-ascii?Q?FP3ch58bh8RgOAm4mO7IPP1itoZSxTv6gddljU9E5vFUO+PpHKmsjSS7+yu2?=
 =?us-ascii?Q?bn9a56d/p1M5paS31r4FDui6gK+Q9VbAf16Czdbdoku71NT2T6h9byOIkaCX?=
 =?us-ascii?Q?3g4ZuPURjgzNGVw6+z4c0yyQwCYv53g7bQhF5xEscA/Efw23EXWQMmGUY1nL?=
 =?us-ascii?Q?a5Ut1cxPXDRvc6D6nx4Iv44IFpigAeET3VDGYw33Oq8diyBuNOo+EtDd2aFG?=
 =?us-ascii?Q?DOKmVIAHr5VFtTLzo+5mG5YYIJ93MbXGBK/qoIUSZ1KyR5j5R171TmVOAHN7?=
 =?us-ascii?Q?bAFo+F3vyZ+kOcm0n9yslppeiixzG1akxcVew+SVdt8tkcc2zqJfCByZiyqE?=
 =?us-ascii?Q?1I9HOR4Zh55LVqlwbhGZTn+LtzZ6wjphq6IVKPLrnyLcQNJ3gnEAFuDbQdFk?=
 =?us-ascii?Q?6KSzeAy0uQ6DV5PjJ/p2mPvuNVnxP7uF1urSmS6vJPiEm7ovxRdt/KXrH41I?=
 =?us-ascii?Q?DvpjJ9381fm4KLiFP9PcYe3LfvsQV9mbJoPDROHjauHZcN/O5Qam1mXx5JG+?=
 =?us-ascii?Q?/DjW7ra4LktBZrCzBL4mEEqm1eA38JT91k8NZ+dBKV3JsKkya7pk20ooTP92?=
 =?us-ascii?Q?QdKvGZpJCAZaWrHhe386FyCOu7I4q3F1YWdNk7cwr53oEkqWz6x/hPhJ7SrE?=
 =?us-ascii?Q?b18PKH7zDioQSq1lVt3D1h8nCeaSnVl5NnJwVEZwnhtY60mIluQyjERmHT9W?=
 =?us-ascii?Q?bakYWmRJe8chpD7+nBkfXttFp6W0G9g7V4UlIYNu5b8O5hyrdrhv9bybwVqc?=
 =?us-ascii?Q?PLw7jiI4B2vJrt9fQiV5V05hONqqgQ5WtdSKkGEaoULgWPCARm2MxclT2GSB?=
 =?us-ascii?Q?+d8WxqyMcd6fZCWm//4/fIS8IOZaDS8=3D?=
X-Exchange-RoutingPolicyChecked:
	W1PgjwlZKJIcnT3MWFlAjID+XNbW7kt1tWYc25Auy3nWJrmqgdzR3Ilj9ZPQYZvO4cs4BMokEsPmwk4JtkZtDiLYuL0NawOEcNNqueffjpq67ikkORWmbaBB2qkTx5YydNTn+Fy3yzCxDGp7btmh4NeogdLk7CctdJRYGkcoMFIWUFYkGzLbsU+mY3ejT/7kwB4aMrWjQbbowGDsu8V/Ya4tdCOWiLgxKramfniGZ1v1ODcqsr/iZfnE0IXm/xpRibgFhyNcTGtviskH1dhnR7YJplT/vKWyISeL5eort5xPWoyiNYyP3xb2CbOjYcwPkg6xiyIdiT/wS1Vyezm0Og==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6RzHOrVYt8mf+8ztDJs1VVzt1JtrAjDqSKgdPGkmAb60qOv4mnxMXS6uO9z38T++FTrQe6mtmlYXNnPEa8lkRN2v0p6IeNWukCe5D+7vti5/JxVCDF6r4GOM1wd/XKxTcwQsBfsUFx1FkwOjHnHK99GMB8N7e+nwd58we0u+k4vD5dLf0awD55q8a4fuqlco9Mo/tN1oLzk+LLS7AgY3Hk4LBY+ExNtjk71lujA9f9NStJDDujCuEJG/0dJzPEAWfBn1G3IB+CxAdHUOO0/pm89c+loQ6z/6vcnEY2N0xNSVBbzUEbrvl7DkxHcbWwKOXdv2SVuMT/78QzsAPPZ+fF2/CSLjjcUpLlXsUi7au8zs97CFo9OuTqc8Nt7EnvRz0UdUH2WOiOxIbvXl7XM1hb557QG19EOijXuDQiPVujn/suSiaUb2Pb0MocpvsTzCC9jp9bvZWhbBcPPiSZ+xd08a3d7iMbR743l1qpXk1rRZvYlA8OW246r/YsAhcMvAOlQKXXoH9EK6sbmHYykBIjeQsH46EmWw9fXBAz0vlfFa+P9mFg7zntG6b9b1+oBL71tKyOj+/dndB00ds5OJfMDKEeCSeTaL2vM7ZlvwAw8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2223981c-4c0d-41d0-4c23-08df079dabc8
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 20:23:08.5073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ed8w8F0MVw7lIz/6vILUSAXoLGxMownDi364y4EKQE0W4ENYwUJpJt07Tr2SynlsjQiAw92tj6+RpEPlhCefveBgZ0c+GSAZT6hsKjd6bFI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6179
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_06,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 bulkscore=0
 malwarescore=0 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2608310176
X-Proofpoint-ORIG-GUID: Iej98bZYsTiT7xbI4XgLQEtXhDnsfSew
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDE3NiBTYWx0ZWRfXyLBggHOadDD9
 P4bSQnqu3D/vUe2965F/CqGWQ5/gtm6wdJKPMH2EEqADZ7umK4LWQerfWP64Iddz8CSDcdl39v8
 YxlKYRHxpmAH9Le+89J1jKTemBicbMqQJ1PQIRVuDYlkptGwP8LS2mK72EGOChea5DaSC8KXw+S
 TdO1aMAIj3WQtE6HtZRs3o5nuTgYPkq+0zRF0dkaybML+g/MH65LvLN2j2IncDkozv9SPvc4TdJ
 CJklmUUeHBhPmE4YJM+0wGJWD1NkqavfTJ1WYPLTkgkjKacp/Gv2rmK/knOi79lqntZNSSp/wZZ
 r2YiG/6LtDj2ERDHm+azPB0xjB9KQF6Ruu/ENtWmfP0Z6RaDUlADlZetj4R+ClYqSfEeUrGw8TH
 QaVN8982OCcIG/gFYg26YAkp1KJ1hd3AXI0fRlIy0veeuVOLk1/D7pfyPLORbTffmK1nvzLxriz
 h8wxsO3Ndj9G7AK5k+A==
X-Authority-Analysis: v=2.4 cv=Ebb4hvmC c=1 sm=1 tr=0 ts=6a95e2b0 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8
 a=JfrnYn6hAAAA:8 a=vggBfdFIAAAA:8 a=yPCof4ZbAAAA:8 a=3l0D1vn9HKlqLe7D3jMA:9
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-GUID: Iej98bZYsTiT7xbI4XgLQEtXhDnsfSew
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDE3NiBTYWx0ZWRfX3ltNxX5jGJwe
 /6v1VD2yKcW7XQQRHKR5YvUWRYzEUA2C4bKPNSeI1iWkse/hm8JlTyf2z9j0uLu0m4V8hHFd/IY
 +K47JUceoZC7kpoAy49t/fCcHtH0WNtjpiXR8wmE0VJn8jzRi7so

Add the acquire variant of smp_cond_load_relaxed_timeout().

smp_cond_load_acquire_timeout() reuses the relaxed variant for
the actual wait. This has two paths out:

 C1. "if (cond_expr)": loop condition evaluates to true
 C2. "if (__scl_time_now <= 0 || __scl_timeout <= 0)": timeout case
     a. cond_expr evaluates to false
     b. cond_expr evaluates to true

C1 already provides LOAD->STORE order via the control-dependency.
C2b does not. So re-evaluate the "if (cond_expr)" branch in
smp_cond_load_acquire_timeout() to provide that, and follow that
with smp_acquire__after_ctrl_dep() for the additional LOAD->LOAD
order, together providing the full load-acquire order.

For the pure timeout case (C2a), we have neither, so just go
with a straight smp_load_acquire().

Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org
Cc: bpf@vger.kernel.org
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Haris Okanovic <harisokn@amazon.com>
Tested-by: Haris Okanovic <harisokn@amazon.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
Notes:

   In earlier revisions sashiko comments pointed out:
    "Does this standalone if block fail to extend a control dependency to
     the macro caller's subsequent code?"

   This was a problem for the timeout case where the "if (cond_expr())"
   was missing.

   My solution in earlier versions was to not provide acquire ordering
   on timeout -- that looked okay for BPF and we have similar semantics
   in other places as well (ex. try_page_mte_tagging()).

   On second thoughts, those semantics were unnecessary special for a
   non-performance path. So this revision just provides a full
   smp_load_acquire() in the failure path.

   Also update the comment in smp_cond_load_acquire_timeout() to describe
   the barrier semantics for the three cases.

   Catalin, Haris: I've retained both your R-bys. Hope that's okay.

 include/asm-generic/barrier.h | 48 +++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
index 4437d27c46b9..81db4da12f5b 100644
--- a/include/asm-generic/barrier.h
+++ b/include/asm-generic/barrier.h
@@ -379,6 +379,54 @@ do {									\
 })
 #endif
 
+/**
+ * smp_cond_load_acquire_timeout() - (Spin) wait for cond with ACQUIRE ordering
+ * until a timeout expires.
+ * @ptr: pointer to the variable to wait on.
+ * @cond_expr: boolean expression to wait for.
+ * @time_expr_ns: monotonic expression that evaluates to time in ns or,
+ *  on failure, returns a negative value.
+ * @timeout_ns: timeout value in ns
+ * (Both of the above are assumed to be compatible with s64.)
+ *
+ * Equivalent to using smp_cond_load_acquire() on the condition variable with
+ * a timeout.
+ */
+#ifndef smp_cond_load_acquire_timeout
+#define smp_cond_load_acquire_timeout(ptr, cond_expr,			\
+				      time_expr_ns, timeout_ns)		\
+({									\
+	__unqual_scalar_typeof(*(ptr)) VAL;				\
+	VAL = smp_cond_load_relaxed_timeout(ptr, cond_expr,		\
+					     time_expr_ns,		\
+					     timeout_ns);		\
+	/*								\
+	 * We arrive here once the loop condition is hit, on timeout,	\
+	 * or, if we hit both the timeout and the loop condition.	\
+	 *								\
+	 * For the first case, we come here having already evaluated	\
+	 * the control dependency.					\
+	 * In the last case -- low probability, possible in the last	\
+	 * iteration, especially on architectures with waiting		\
+	 * cpu_poll_relax() -- the control dependency has not been	\
+	 * evaluated.							\
+	 *								\
+	 * So, force it to be re-evaluated before			\
+	 * smp_acquire__after_ctrl_dep() to provide ACQUIRE ordering	\
+	 * for both.							\
+	 *								\
+	 * The other case is of pure timeout, where again we don't have \
+	 * the advantage of having the control dependency. Given that	\
+	 * this is the slowpath, we go with a full smp_load_acquire().	\
+	 */								\
+	if (cond_expr)							\
+		smp_acquire__after_ctrl_dep();				\
+	else								\
+		VAL = smp_load_acquire(ptr);				\
+	(typeof(*(ptr)))VAL;						\
+})
+#endif
+
 /*
  * pmem_wmb() ensures that all stores for which the modification
  * are written to persistent storage by preceding instructions have
-- 
2.43.7

