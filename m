Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9315C26B764;
	Mon, 16 Mar 2026 01:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773625073; cv=fail; b=qzSH4eb3Xvge6proDyyu4HVdrmlRyyFrzIxtrwakeiKohb/WfVJGtKOqgLP6FYFjZJlx+w9E7vfjUvsV/C+W05QsRE3fMY2X30/WtXpv2V6IbMO2cHk5a+BAxDwimreedZClwo6R8tsyCnJmbjTHEf7/8UkKQNjgqs9ZqHYbMmQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773625073; c=relaxed/simple;
	bh=PFT5rG5/F+SHTERKtv0STIs3QyoahP6Kvg5/BO7yjhw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VtyzOv5QQ2zT97lWnTTQ6MtStsZoR1Tmh72TUq93cxnxyrBLE5gW9x7yIkf77JAsDEQL8stOM+LNLkHZrk8gFBPBl3qQKOvsngpuC34ZCzql48XRtVYyXIP1YeVfIrtATqeJ5axmC4jA/2FbLoFdwv5ohNvKvjfs370mVluRtlg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=o4dMZzXV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=H0MP34CM; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="o4dMZzXV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="H0MP34CM"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62G0Tx101498676;
	Mon, 16 Mar 2026 01:37:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=4Lg9Ao/NY7+O+dHBfbLTCASHr6xXDLmXSvijPaYixZc=; b=
	o4dMZzXVF0jaqaUX/0iHyj5LNxuFfCVrnSQtaeWh9OSrPYDEEbLbQAxP9OexgdAG
	+AELcxui6C7fchc20xaUDhArZVi2+M+t5Vl+mDZVK+7kpTWpHhtUQ3fp0gVku2bI
	ITTIbTKuH2q8wjnakWRTGdYW2JB/b8CkLKLukkh93mI1OtumibZUGjRidMFbcYFn
	9w8iFjcnyZHeSP7NisuhZP+zpA4FF/4NStGhjHMsX7gaV6Bk9qaFYjSVt5dOB6Yf
	aRwGUV6Ucch6dNLjde2lEDc3o4R0RVx4kntMHz8d7IgzfUPgQZVMBvUKX/pf5KJG
	CRIXgEVMWuViiShEtpVvvg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cvy9rsau2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 01:37:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62G0KDMm017804;
	Mon, 16 Mar 2026 01:37:24 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010031.outbound.protection.outlook.com [40.93.198.31])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4cvx4jgqcy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 01:37:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x3VDWYFL0Oc3qez3G5Jy1WPXMTKjXlPmdb6NUWu8DHM/llJ8n6Ta56zOLZS9mSFLN7ShgVzo0HP8fxgQLc78+oYv62bfU4Us7wBdubVrxWr0CZfrE//hYcVjAQs7v6l13dZpCst0Gv/fqjoCpOLe0cZbhKNjlcVFmVzkXbaO5zQkkgIEJ3bnf3j7I5/1sQYdPkCnJpKrLywttIXrjYHzHcS8NDTYjGSLQ4NkuAIxLfnYXSLzb4sGYRGPsP44TWuYg7KlwOTwvrvO+Wi3nBSHV4/FtTgxwD+Wb54sfBjOt6RtOs9dfsDqtz5BoaFiEXRL5ePyHuJEhz/sjGN2X8HV3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Lg9Ao/NY7+O+dHBfbLTCASHr6xXDLmXSvijPaYixZc=;
 b=P9obF+R5r2e99DwYWerWNiC2fcEmL6hnigQcFT58w+Emc0ZPnEX/zmKpQiin5oltNvHzfw3offnD3n1HbvVW78bE+tU0+U8idlWi/PhOkeSPTR51qFQ4L2m970mHiKtJ2bXgds0pyy1lUSVjUmLJ8zKQIoLUFJGS4yOqhMSvwJEGQjQbN5bVsaX7PeoijfSr/ki4Bwbq4juRSDx2SDSF+TlnRKB+ZHnHmZC4syFjfA5qYPpCVcw7DWoReqbqqBkHEC7eiYPc3LGQUldqFTTxYaMhn7FDHoULyWufTzfy7lVFvlSb1ioKZg059nazZDRIs3Prd3prvRFGq07uuw30fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Lg9Ao/NY7+O+dHBfbLTCASHr6xXDLmXSvijPaYixZc=;
 b=H0MP34CM2NX4qr2VM1d36WGNENbXEd5F1DBK73p/CTWUfzz2qynTK9eiLmEntAtd0KL3zjHEkh5qmUuL0O29pr5QCF671hsFN8BiJhncVlp/TfyfariYrSx2NrshU99aCk3+52NolexH2qvZRDYX6NfsgS4+TTsgMA34JvKN5FE=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SA2PR10MB4571.namprd10.prod.outlook.com (2603:10b6:806:11d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Mon, 16 Mar
 2026 01:37:20 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.20.9700.022; Mon, 16 Mar 2026
 01:37:18 +0000
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
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        Ankur Arora <ankur.a.arora@oracle.com>, Ingo Molnar <mingo@kernel.org>
Subject: [PATCH v10 11/12] sched: add need-resched timed wait interface
Date: Sun, 15 Mar 2026 18:36:50 -0700
Message-Id: <20260316013651.3225328-12-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260316013651.3225328-1-ankur.a.arora@oracle.com>
References: <20260316013651.3225328-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0189.namprd03.prod.outlook.com
 (2603:10b6:303:b8::14) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SA2PR10MB4571:EE_
X-MS-Office365-Filtering-Correlation-Id: b149e4c6-1090-4bfe-4297-08de82fc8f64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Am5mmGvhWh45iWcsDRG3cHhhzsc2MkNYIHiihPx042rBl9PZ+GdnITSUgutG2VR/WsP97TJiDs0Fj/H830dsO241Z/VMJ9PL+w6MiKzhcLsviWNPCsuNar5J9zZ2ipxZChJuNkqyeFOzYNRRy7v19Ar8R1lj8nzXBLYg24jXxs5DQ7iuWuLCObjjPUMpzM+FfHwK6fsSf52LbrStiVZEj/kLF5Uu/tapVOSjFsypTvC+rj4F0tQven1QrTOXZUc+930fwF8s8jKcEhgSiBS1gSh7OGOgBRSpwV+llDhfW3bz4AmoFDq54BzyHylOMRXX27ncykbjLTuitD998yJTDumH0Q0dWniq/K8XjH0TRlKjIiuMVQgPhJAe+JcS7RPZMS/ib+YnSV4I8VG5z9gE2CPG2TvTwc73YaVdf03+gFnV1axBt7wWCoPx+IjNSYImftLYaDI1SlhmYztvwGoab7LL06Y63k/mZe5NV1VnAsnnFOfVV///1ZSODsPZZ0omhGJYewQ48pa/fAWlCrJFgmp+ADuh/HIEgpXfJ520GPg8LFylUtCmjSgc3pllz/3mqbJDaNNZe6lg1lx/hkyk6bqCBLorrh1g000rmatjNXpTEIxwiY3/WgcvCSkjrYOEJ48kv3qhI7h/kiHSQjCWHTk0yZYXuE7wtWtpwFetsC/1BquA6GPdCC4Z9rwQpjzO4dJl9kEL8c/OfwWUT8KTIvxBQOge1fMfq9FdQL6UJHQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oLekOY6x3HP24jhW4ykESi64NtDW+oHZwOzWkqch/D+DRfA3W6tOaYwBW9x5?=
 =?us-ascii?Q?M6bAiiSVM5dCyBbIuCAl68tv6OlBKe7BeYJaR881WajRyUTwmYidjaKo2ZKV?=
 =?us-ascii?Q?giNFcy8NTYrpblQlvFtcQcLG7rIuVh9PACBhm2dtf5SM2jyV0YWxKLrLZ4uZ?=
 =?us-ascii?Q?7AsykRuucT2nHKg2K4ELKhHMu6PwuttIcoRNs64ZgJNvUY8Y4jn21zwc/rH5?=
 =?us-ascii?Q?n8cegOa7d42hqr5mqIbaQtW7RgY/zcFyu7beqMGyDzEhPKGLPXx4ihjIzMId?=
 =?us-ascii?Q?h5l2a68NVvXN9ruq8M90PqOhtLpvURLLxd3C8UHRJeOB6OcAt+OPhFK1JmGK?=
 =?us-ascii?Q?P95lIagbh5DeHeMjIMqxnpsoQ61ctQ28hRqiLTMBEu2jRxqJTvTmOl2sQ6V+?=
 =?us-ascii?Q?qs7iwmI2XcZ9OvWnSkZWmAemIaoe0bHG3kO50la180n5lNhamyLIVva/kyz6?=
 =?us-ascii?Q?iTUtWhos6SLgR0k5KB29C+aLCKSjG41gIvEq24hd1/KEXwhpXoWrozkW5tB2?=
 =?us-ascii?Q?4wZYW5BtZvzv1Q4iE60SKCkavYK/BPrrGj4XPvuwlDJHO66QW1+chdNtT20J?=
 =?us-ascii?Q?+qWIXxXBAyOy0toGXCo5Zo2mfs4sDcF3/7tSOfsnknxR8LM6zOlm302e6yJZ?=
 =?us-ascii?Q?YDmPeL4AfLC6vUxhPsMl7IwJZUYsAq/BMrqbsHKRwItB3eSh01Zb9O5oTA/x?=
 =?us-ascii?Q?nbkO3oFsG0EOlwIkg2e4AscsGSVOFjBYK+LnuJk0cnHU2VlvWgQrx6Bn4+04?=
 =?us-ascii?Q?fPVbfM296npQL2jdCUkzz256BWQQw2MBhzCv1ae1BkCiEz2VtW1SqP03a2tz?=
 =?us-ascii?Q?vcBTbF2w8ZNLv+oHjmMZKD+e6L8zQjmUmrNRpxGhjjdaKQ/ZrNEINAn02GJH?=
 =?us-ascii?Q?Od2+FWODD+b65GoObgGiGVO8drY5r5l/4m4xixWDlqpY/fVUrI/5iqbwp9G9?=
 =?us-ascii?Q?l/1KnTUe0i/lxg8oKwkqwC5tRz+/wXY3m+ixPPnYO2IjnlCYzmUbsOE4M2X3?=
 =?us-ascii?Q?SsjhS9BY2xNuyQK92DL75RwiRoYxAcSSI6m9A6aq8eapx3nXB4cMrzaYP9Dk?=
 =?us-ascii?Q?u7h01+v2XbJFAHf5ShsWdMLtcgyKqb6XB6VTxm20WO1oR3q84K4fNUouQhNn?=
 =?us-ascii?Q?5A4tYd+H9dERIpXyol1LQvD6xq5pJMVn6MlNdEYCyFTnW2Jqz1sfa7gJlOJq?=
 =?us-ascii?Q?K+pcPfoKPkKYNoh9290tT/f51Ozqptg0qHSjr7Ur5kNQNozyVpxAYUqJrmGO?=
 =?us-ascii?Q?4K+6mLLjtcSEPKCgablzkDwY0poT02UERlIBWWpVk+ku0jRCBCnULk+7AH2P?=
 =?us-ascii?Q?oTOYj89Yvj3OisxrWW6FwUykPrssVXiYaF8u4KK76R6PBOYnqeycEPOqQfvw?=
 =?us-ascii?Q?qI+5oAoxolHdS4WuSeNKAQapkLYsUzNlEFc2/XK9xWY05AwCipWs5cFHZu++?=
 =?us-ascii?Q?WlhHuh0NJLhWm7eZaHIQnTEkF06+225qcSU2SjunvNDGoEpLpvMT1cmxCY0j?=
 =?us-ascii?Q?AlQmocpkangMVlpg88KFdyDR3vlKfvfprc5uzl2DVDZ0BJfzKrxf2SK2CUCf?=
 =?us-ascii?Q?SZdW+KOQb2kCFcpmQ7SoYz+YUJiAfXpmp5oSBJixutGwbSMn82k/lEqGqjA+?=
 =?us-ascii?Q?wfsKm6Bjyc79DL6A4dyVolQTtDej33W9W3Zl6XMyMEiv93IwShr4pOJ7hb7X?=
 =?us-ascii?Q?SQg8fxGehzqJN97ss2bDPL22vGzH1EB0Q54sRwO14d6CCyivpBHM7TKbYiAI?=
 =?us-ascii?Q?Sc2efv8iu8pJpW5xdvp3UE45hQ6MCNA=3D?=
X-Exchange-RoutingPolicyChecked:
	oHHVzcGHIOTJtxrYmIcdHwPL4DikukelEm43WkdY7rLmk+FghuodH92mkIDOxdE9dHsgEatM45yEGcaXJ8KgQ5QG0mb35+JwWx98oQqipdsCCP8LCQV3+kxaGWjWeiMbIqlAnzESfayg9D1xYIZVlpz9u52MivHyD+a/X1DLk7zXFi4m/ZllSPTwk60mE2z4R6ktTPVe/QrlTS81mJ8Hcqm/ZA6PEwkBWWUePcWhgu/c0T9WymQaiNCwAnupXPCCCuwRoKSvmH1kNgYNJAowjtelLSYeAL4yt7hP/Zhb8rmsCGkvZ+V9xLjDrLsv6W9uNQFRo0uzmK1BPoONn4om1Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	b2LT+iAnviBrwNPs+lRNwSZy527TRQsHRA+Uhk261FPK5DPYJ+egqspHjbTbf/YjrKqCHsyZIJ8AsN5h7Pl01EMjAxLsn+tQGLcrcEpC2FXR8K7tO87IjlMFGJgbdpKeQpR+Yj+I9WrpvBhaDt1lomfDStQLzJC1Bpcna4RR59ZlJHpebdExgmlGha1TRXsJUEyWmiPhP36yAC1Zh3e50bffU/d1JOxsHwmFEsGDp3pULVOWXJ8qSuOr0k3pemdzn140vHM6IPZ0a8XU0kAZcQKcVUVr1VQcGy/4ekZCKipTjxhnCqR5vw/MLBgpB+7Y83iSUqHE7w5fG4QMBCkylV1ZnjSzUaZ5m0JjesS5PeNXccOnMybQ15TgcpYb6BtBYXT6azw5nRZOnr5upmNwTrN83eX3FGhg1V6C/zSFct2kCATF0y/QWwf7WP5AwrbTQbrxaGl/UFYNdID14KC+xFMCehvL/JyBUR77fkGK2OIZrUPLhn6UDTC2xVSb3CPWij2QDYEwTtPKMirVf+zUbkZfDvuXg1wyuQDwFKUXUVQvwPh6FbQmdCLRjyEXcgoa8UJYJ61MtlbvHBKBFBkwK+0IEH3Xgb0CgBOt88VzXyg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b149e4c6-1090-4bfe-4297-08de82fc8f64
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 01:37:18.3984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D+cvLRM3COToVxbvyio4BXjwiKY5beqQ3GBy5eUAPuXKmDfpMco+eJ5udtWa60uyiZAjH7+t58UxgrfDQ3PZlj+h7kNgwUXeHkM+f0QVWeo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4571
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_01,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2603050001 definitions=main-2603160010
X-Authority-Analysis: v=2.4 cv=X5Vf6WTe c=1 sm=1 tr=0 ts=69b75ed4 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=KKAkSRfTAAAA:8
 a=yPCof4ZbAAAA:8 a=DC2jtUcBNbVnd9lHvZoA:9 a=1CNFftbPRP8L7MoqJWF3:22
 a=cvBusfyB2V15izCimMoJ:22 cc=ntf awl=host:12272
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDAxMSBTYWx0ZWRfXy9L3RVi+AcP6
 EOLPgPgK4k/pgagvlTcBD/Hdz/MVpszUuBAFSdjZPfNCvu0YQFA79hgcUBfJ3KS9+OnhBJ0gyxy
 aQTNzahCLXGvSxuMLdmSa2lvSLcdlxhGX2/mQFIoeHFHXCJ6m5dKxwLpBjTwzisYwfe9c2DegTB
 z/KtwPHrbB62i4qeFb/or3fFOU8ORWFZnCOfXUP4+Y/eyEvnDdVCxtEXdjuJuYZj+6m1sMU3wmF
 fuuKFCGXgyt2EnK3XmDbmTD8Jky16CiwPReHR0sEjcgjUHJ4ICf+3UwjUP1a3jUYX3vDAqQA8vo
 crwtXds/8XgUJiZnRo5qMi9jXIrugq3TgnLBQLt+vF55LAi9zXrgd/M5uwGGBBeWC0+7nlveugO
 56FVLpbU4fwUGic4PI3P7N4RIyc3MqsqHji6C5jQdo9ucQx1KhWdD0leMRYBOiwC6OCuPmIWRlV
 QQrXGeri+Jnd3AegMyKlrDhpWsg9w6AZfQw8Yyv8=
X-Proofpoint-GUID: MNjpX8SUywGX4qhusJGVruzugGNojQrC
X-Proofpoint-ORIG-GUID: MNjpX8SUywGX4qhusJGVruzugGNojQrC

Add tif_bitset_relaxed_wait() (and tif_need_resched_relaxed_wait()
which wraps it) which takes the thread_info bit and timeout duration
as parameters and waits until the bit is set or for the expiration
of the timeout.

The wait is implemented via smp_cond_load_relaxed_timeout().

smp_cond_load_relaxed_timeout() essentially provides the pattern used
in poll_idle() where we spin in a loop waiting for the flag to change
until a timeout occurs.

tif_need_resched_relaxed_wait() allows us to abstract out the internals
of waiting, scheduler specific details etc.

Placed in linux/sched/idle.h instead of linux/thread_info.h to work
around recursive include hell.

Cc: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 include/linux/sched/idle.h | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/include/linux/sched/idle.h b/include/linux/sched/idle.h
index 8465ff1f20d1..ddee9b019895 100644
--- a/include/linux/sched/idle.h
+++ b/include/linux/sched/idle.h
@@ -3,6 +3,7 @@
 #define _LINUX_SCHED_IDLE_H
 
 #include <linux/sched.h>
+#include <linux/sched/clock.h>
 
 enum cpu_idle_type {
 	__CPU_NOT_IDLE = 0,
@@ -113,4 +114,32 @@ static __always_inline void current_clr_polling(void)
 }
 #endif
 
+/*
+ * Caller needs to make sure that the thread context cannot be preempted
+ * or migrated, so current_thread_info() cannot change from under us.
+ *
+ * This also allows us to safely stay in the local_clock domain.
+ */
+static __always_inline bool tif_bitset_relaxed_wait(int tif, u64 timeout_ns)
+{
+	unsigned long flags;
+
+	flags = smp_cond_load_relaxed_timeout(&current_thread_info()->flags,
+					      (VAL & BIT(tif)),
+					      local_clock_noinstr(),
+					      timeout_ns);
+	return flags & BIT(tif);
+}
+
+/**
+ * tif_need_resched_relaxed_wait() - Wait for need-resched being set
+ * with no ordering guarantees until a timeout expires.
+ *
+ * @timeout_ns: timeout value.
+ */
+static __always_inline bool tif_need_resched_relaxed_wait(u64 timeout_ns)
+{
+	return tif_bitset_relaxed_wait(TIF_NEED_RESCHED, timeout_ns);
+}
+
 #endif /* _LINUX_SCHED_IDLE_H */
-- 
2.31.1

