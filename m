Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A016D34AB17;
	Thu, 21 May 2026 08:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779352290; cv=fail; b=OnGzJhFmeYTSeV+uzldsub+A9fW9wNE8B4R2kVUIXASo4kCS6qd4nRTmKq2Adsi3VN1lR8avtbTsf/lvGL9CcsAZfkGYN0sm5kCtA9UZs/NBGPFK6d0utN0L3tHmmW7wyzvYw62kPhzjQ8OT4p7kBB20SKZnf6Mx373YDg+R90Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779352290; c=relaxed/simple;
	bh=yePhOu+CE4Na7X4DUhYWmdDF/FK3lIqv1To2D87Q1jY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dAfTeBINcuSqvKOpoNhQp4AFTpDo2Yu/x764Lf9ubKtRwLFYPdL+cEZA9aAaZCXtcbSr43k1Afc1xICHBrw3In5vFEl5iOmtPWpJ5pNdRFMyjry6Q+jDvnooiijdMmOjCCfBF1ZG1b6fWNhAZY1s2EpprPma5yLo9/mhmmyA5js=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MLqcBQ2h; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lmuHw5gk; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MLqcBQ2h";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lmuHw5gk"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L3TMsx1623648;
	Thu, 21 May 2026 08:30:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=kMny+xo6EfloNnu4C5ePhyuBFckOhcPSEZCAvItDzUg=; b=
	MLqcBQ2hk2AerOfOwRA5z+eT7efBLurAKahRAq2ohxXl/8FiDP2S3uicSi8j+6c4
	Me+Q+KzHTLgudul/5B7YsUAedebhosRg2+wGuFWCZuzOQf+031/mr84rt58hp8rI
	mUDbjdw1BHAU7VqBZz2AJ37UHQQUW5SeWlIlbMD0gXg5NCpq5FyUGU/WzUIUkHNF
	z8ZUMiwNV4h8DPOyfQNOUYwYr/C3Smm3sj+O8dWf2PmwkydDCeyuGIExQ0MMCy4c
	kiv4DBcSSpsce3M4JcBYRdkMaLV4LcuHDaswyPUgIZxXxyxtFQAHFpiCFRymmuo6
	P3FEElwNSCVI46brekxU1Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4e6h2sgnsx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 May 2026 08:30:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 64L8KGUU036537;
	Thu, 21 May 2026 08:30:47 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013032.outbound.protection.outlook.com [40.107.201.32])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4e6f1j4p6n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 May 2026 08:30:46 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iYV4kxRk0iDHjcTtFcCaPvpHQ/DcyAG37u7zCfhYmTUZmHm/RuhFoeaihIT8arPZXEIZuTsDrObvEvb8wtuTqNUqRUXkVEnqJqDTJ70zQX/XkoTlsjNXhfHommuSYbym1TjxbNkCd4pNg6wO2je++y+dP13we84AqOJg+hMyIVAXZgokP3PwfOMIGJLDocpU9uBuoFdw/QysqDJo/3cgJS2+KzTKmKiKFQf5GeEF2xE/w9DtCX3QBUfom589MTxJQ/lLzq5kWMWblhXTWadFrbwkYi76waaOsR/oDv+QjL6Cbw4kiWQOc2vi4OLevobaa9NW6MSwy32HOb0kI1zX2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kMny+xo6EfloNnu4C5ePhyuBFckOhcPSEZCAvItDzUg=;
 b=nykcmrZgfZfiaVI1i49bJtfuo8O8PHnrvQ4QRUnfK3t52iwX99BHLPec84/EE11Gyg7Es/FG86rbEff2/QGgYQRllbnb1J+4mFw59IXC5znYpBrioPRdwrzywCfjjEiRLZcc0sFsak7lCMtcRF09G2uBh8QLpwCQojxL/0YE2ynRrkOYShrH6zEd4L5iFHFpyKw31I//F0QknKNnDSKkQzzcMKUOouYuv5mQ1BY4huoK8g2xDjIpaViwgPzwwAcVNqhc2hpc/wmmc+R36IHAU/+w2kAC4fnLx2PZ+7M0sNK881AJBBqDBW8tBfKbc0OrRrzMVxzvEtmRpw/kxNiM/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kMny+xo6EfloNnu4C5ePhyuBFckOhcPSEZCAvItDzUg=;
 b=lmuHw5gkVGCsROh31sYgeBWNzqol3t8MlUZQg3OIZMaMF53B+Frg6285wfbifOfX7Yq2T2xHIM/FGJkLV7B/mKOZjYNxyIHdVgP/g75/xqJL4wuwOmQgCDGhYF5uQMIvUEkij/zFyUl6ABM8YYDUnEMEuQEB1tMiTPGzfr+9AWI=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS7PR10MB5055.namprd10.prod.outlook.com (2603:10b6:5:3a9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 08:30:40 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 08:30:40 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-next@vger.kernel.org, bpf@vger.kernel.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, memxor@gmail.com, zhenglifeng1@huawei.com,
        xueshuai@linux.alibaba.com, rdunlap@infradead.org,
        david.laight.linux@gmail.com, joao.m.martins@oracle.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, ashok.bhat@arm.com,
        Ankur Arora <ankur.a.arora@oracle.com>,
        Boqun Feng <boqun.feng@gmail.com>, Boqun Feng <boqun@kernel.org>,
        Christoph Lameter <cl@linux.com>, Ingo Molnar <mingo@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v11 1/2] kunit: add tests for smp_cond_load_*_timeout()
Date: Thu, 21 May 2026 01:30:37 -0700
Message-Id: <20260521083038.134260-1-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260408122538.3610871-15-ankur.a.arora@oracle.com>
References: <20260408122538.3610871-15-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4P222CA0012.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::17) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS7PR10MB5055:EE_
X-MS-Office365-Filtering-Correlation-Id: 767427d4-1fca-4eee-f78c-08deb7133d9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	PwQBphNAKEjYdSLGZP9IP+B4syWCzNTK7N12ndDFbetXkliLxNCSlv/89lpL5Xc6e5Db2otCBFpCYc35p+4uRLmW1uUi+TPY7T8P66+23fBhh5KF9YizcndGu9vYXIPIcS/BM2ufZ8h/qJ1OG682oKzxZIltCLPsfZ731KWvmY+2lT6VBY1cFqkHFpTm2FlEWEZkquPpoUNrWyI0LxjJgzJvST5/2gkFdDnYgB0KC3eH8Sf9QFEgD5B3ZnIju9SsLTGugL+neOowarQ7h3EQuCjj0g5LkWBCSylP+vMDn1vQrB/zx0jKZoyAtrsHpbBXd2X8n/HIl2XqSsEexzBuNu2L+NgpQlwS9N+XUarnJn2+cu/0yomoY7yl++pdui9gKAMD8iO1a9oKRjHX727cDX4Q/CAiHRVQixghzqEdkGk3A9vafTarUDkZ0D/qo88FbV6MyTIH7oIIQxflUnyC5BxN5PdY9lLQD/BRSTPPVLA7CNrfkLRSXmtWNgIggSwQiSjpfpzBHVYnT7wfccgMrmzBrWx00ZNTSYOxM4ngkX2WiiwJdWJWf0xNbQzrOwmHh/H3VH44WwwaORIkqADsAti93ERJ9nvU++G3kUf5GPE8KbMfbvpHd5j4iCO5xYwgl/lBXyOSzKxQ6BkXVi9Fqgimt2QnrEAY3KKzwIZNBAm2glbcn9HIDIk4ue5jbJGt
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TgJWH9i9cMEnlZxcrinvi/jM0v+zlAEe715KdhWLW2DOgRKXrAWCXg8GfX98?=
 =?us-ascii?Q?pLUkC0so9NinXNeu+2nc8EhXkuN/nEceg/81fpDGak18bzMzwQV2NyJFFwGs?=
 =?us-ascii?Q?mK/dCIqtvBKRmukdfV8uM7kYQtuHKORg6BhOjVNvvWU0uPglok54iKgjsrOA?=
 =?us-ascii?Q?KpNibZmyowhwX6fs10J+WvEq7f93OqZgwOyvIAIgmAvi5Lge1809E9ctyw/0?=
 =?us-ascii?Q?oFSQL/CrQ9nbbjvdVsD12XXca5JUAW4yyGqPfvYToQhEASF929Uq8EWFj7od?=
 =?us-ascii?Q?Xb5msGyTWDykrwKjyr+nVmIb6UMyyUD32N8TSwExwCHGrsvo6MaTdJLqnuMx?=
 =?us-ascii?Q?VE7FZHN5ziAYtkvEzgy9sHnb3eaRp9keYWR2OmuAQB15aHwtIyuJ9W0qP1Qt?=
 =?us-ascii?Q?naotscHDC4mvndgcf3HX9J9kegdtI+nqrCZ/k8OIqIy4j8WgpSTH3QOkyoT7?=
 =?us-ascii?Q?AHhhY+C5ACOQ4Tz+rrTPx6MkJgEn1uX/kkmvKeu+oljKFG3f3KWx54FnNV3S?=
 =?us-ascii?Q?PHSzEMWv1QjIQpY0LQ2WstM/47M0YSv9xvUGQbJQgZu6Zv2dUUcuAa86g76G?=
 =?us-ascii?Q?1rh33Ylg748WWYVbmiGvgLK4i5ulCUeorka+jyBaKXlB9tM3tmjTqpX9q/i4?=
 =?us-ascii?Q?HNNwZigCjKBnlk4NzeyaFhNatEckhsnKVXlJ+B+x9Uz68nRIvWJT9FfvLjgt?=
 =?us-ascii?Q?3ZyIicFUIgL7LwxdatN/VvP6o1x+ADDat1bufcNOAlNWmyJYubxT6PnwHnfQ?=
 =?us-ascii?Q?fE06DrUr816M6P7Sphywyq7qcQ+qP8o8ELlTKkzyNxWp37uXkpDpfm/6/dlF?=
 =?us-ascii?Q?xjYiZIh91hOvkeapN3//aEJtce8jM1+biFCJfcIuYRQ6oy59T4V6GV99hwa7?=
 =?us-ascii?Q?OrOm3PD81h3RfigYkmUl8wwPef0+1vUjEEXsMADzhBcrBPEUIwou/P93ZAZD?=
 =?us-ascii?Q?QK/mcsC2xqSsee684TekaBSTp6umIvg/yX2Jk9XYwplSZy+CW/1TmCd4KiCe?=
 =?us-ascii?Q?kQyrgbTUh1/Sz5KIH77jsMOPP18kK/bvFZgkk1cYEQMJakhV4FV7mSfQpwTI?=
 =?us-ascii?Q?5B26ZrdkLWeN3StkiHhohqOloumcnB1vFIfGm+RhxzuwMJgQWD9G6oddrEnS?=
 =?us-ascii?Q?7vhATaeG9g6MFn5aUrCQP/jrgWKOvQjbj75TcCzcmw4dVmK3KDnC+IPNohg1?=
 =?us-ascii?Q?bFWEo0G/B8AG5brCrmOaIvNo6AvRvY4ZTIXHazq8tVaVl8WnwmseJSfIrIAz?=
 =?us-ascii?Q?AUHntFsw1FNLAMUuZdEtgUA3uyyr3jVDv2occkyItSyWDU9uTeIQRjIgxyJE?=
 =?us-ascii?Q?WfzKKFfSZnWxQC7h+XN6c2Zjys5fxNkOis+Z90UzV5wWuRI2qhs/5mgo36Nj?=
 =?us-ascii?Q?U0puBfNKWLVgznrUb2kLjEHz8q8XxuR322GIItUASFXL/gX/6WRav/yqvTgd?=
 =?us-ascii?Q?0sGIUWWF9vkEWInAolbUXZOJdhQA5k+l4JDKqQOx/+nx8emme9c80Zb3l+7l?=
 =?us-ascii?Q?lVoff2vqYtGKLpqSgMwL+CTLOVgIZGspLkCMk9U5yMQZ0EeDxv8JeElXYeij?=
 =?us-ascii?Q?omOTiGvbc7S6fyfuL+DlWJfuDOFbxHzTBjP+7TeFDmrsC/cCgeX5vn8diwtt?=
 =?us-ascii?Q?8TIIZsvKMETg3ViKIm0SN3SJYmhdi3iGvuIU1UbKpQpuPps5TLp1tx2NR803?=
 =?us-ascii?Q?HeWwb+N0RR4KDMohEboK6/voSiGXK7DvRBFhDFOTlcg+WHEvIrv5NGnWZQet?=
 =?us-ascii?Q?MXujmG4akKC57aKKkaCcARm83Bo/yj4=3D?=
X-Exchange-RoutingPolicyChecked:
	pQqYKCsXCzcjvaNeHWWXzvXdAZdLPiTIY3BTRaKtyEHigRptrSb7V6xFqcdHHXw8hyyhTde1MXowDRyGvSSCS3K4eoDuzrFGBBHsMlB0QSUQq7AlOo/mlwKbHxYe+mFZhtF/QLk8cvsbx57eKQqq4uW13Q8Kh2TL5DrBI+FKQlC+tn88x6dZWmJwYsR8kOKO8znR2FxGjRJTONDSvufJCwkl7LkLupw8Jp6qiul5hrxppdRt6Qr/h14AxLOABiAGncQ7UNKzhif0rpehr8nn1QPo1pwsykmLXiKs7oRdhEkHpe3U75CMXMBwI9h+PZBHAkLyqKhcYdbRtEElE5IYxA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	S+XkUGGpGkfhzPDFEJwvP1Y/cu3RRrpJRp7qkFLXWSATOi324ztuHuydCWQb2TWURBm8Afn2h0WGf2YOeE5NBMmsu3qOmJH5uWswnlJBY6EYkU+SL2HHHAifKVB6fJUGl2GTnPyhQCjg0b20tsbsLdz3a4OOc8D49zAwJUEQobuufeOP2VUV6pYaMfs/HWY907yk2KnrWMnwa2WwjXIadecEUz7/8raIM+RWs84qgZp1iWPvO67QAaM9DZKAH27hdQ12Ueh2n4KZiry4ro5+d8JQVTtGXf2rzMMaIbMqY1TAzeXA3ihIoLQxv02/7ZIyTf4whPrwncACZ3D/3ZhsVk20Qe4h70onl30l6QtK1E5e2r1zc7WN0LIlX0E+Je8FsRaU/fnqSxb4UxaWKqnPAPj94ipHUOrqaDdP2L4vaJzLV+nVtawGmzNJNyVUKFXwhy3S82N83+ew1Lj/mKX5kvgk+JMPvREu8vOiFA7aHgMbw2bemKgxl3jmrl6GOgZSRtkb3472pKP1NEb+Pen/xeMe/VhDP8h2Cp4GdrA6auGWW1du6HuFAinEFqztvfQ6aQxcwI5qfo43NruxyCTr9NRlOiNDIeoQZeJTyLeevM8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 767427d4-1fca-4eee-f78c-08deb7133d9f
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 08:30:40.2128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FFaHOCFUsNdjO1aM5O/tYrYHtK2vT9QyrbBIqjQMcKrN/yUMvSXiWlLKvqP35u9GJ8t7WlBhrOgVAjnF/1j6N6uivTAlTSJfUzvWFJLuoJk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5055
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 adultscore=0 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2605130000 definitions=main-2605210081
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA4MiBTYWx0ZWRfXxYixBchRhwCs
 PApDUKul93QI/de99IZupX/RqOh0R7bQOBFf9BauoYActquJziGzCkYZUiTVDKJmeUzBcJ4Zgqb
 DdCxTN635h0MDVkARivB0Sa605EBYvo6u39HtW9Ec1C8AvGY/JzvW7dvTk/+xMmHCxfxuvA0aH0
 VX80CzuS8ROnw+qUjbx0PcXsp4nEmjOTkuLWJgqVUlm8LIracSIFxhftkRw+fHQ5vbEbu0nESzr
 KGL5hd6it/SVnwTroID0DC9a9HvhnwpS3DLLgaHfKbWaBKMT0ernP6A0NZ5Pw73X1ZbLWjLSPBD
 GYOEAgFYG6BURRF4CPeg1Nz68U+HzLXMz7znUxQ+rx/Fjcy1oLNYyNuvmi8Lh/fjOpJEQdJ8n3p
 olUq4qxyzCekqw8sZzZ2SIsImX44woPR16ylyYvJg9LnwsW3gwUGFre7WqBmujN+6rwzCLQc8YR
 N3pyx5vccbKlm4cBcq6KgR8FcM2h/de+a7OIXQjc=
X-Proofpoint-ORIG-GUID: 3pUWIj6tmhy4CBgawQ2oA0OppMHSXxot
X-Authority-Analysis: v=2.4 cv=dc6wG3Xe c=1 sm=1 tr=0 ts=6a0ec2b7 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=VwQbUJbxAAAA:8 a=qNABUOcEAAAA:8 a=yPCof4ZbAAAA:8
 a=Z4Rwk6OoAAAA:8 a=pGLkceISAAAA:8 a=7CQSdrXTAAAA:8 a=NufY4J3AAAAA:8
 a=vggBfdFIAAAA:8 a=JfrnYn6hAAAA:8 a=dxJKRP51JkTsrzIwPSsA:9
 a=Ytm653ucTKQjCvbzLygB:22 a=HkZW87K1Qel5hWWM3VKY:22 a=a-qgeE7W1pNrGK8U0ZQC:22
 a=TPcZfFuj8SYsoCJAFAiX:22 a=1CNFftbPRP8L7MoqJWF3:22 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12298
X-Proofpoint-GUID: 3pUWIj6tmhy4CBgawQ2oA0OppMHSXxot

Add success and failure case tests for smp_cond_load_*_timeout().

All of the test cases wait on some state in smp_cond_load_*_timeout().
In the success case we spawn a kthread that pokes the bit.

Success or failure cases depend on the expected bit being set (or not).
Additionally in failure cases smp_cond_load_*_timeout() cannot return
before timeout.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Boqun Feng <boqun@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Christoph Lameter <cl@linux.com>
Cc: Haris Okanovic <harisokn@amazon.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Konrad Dybcio <konradybcio@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>

---
Note: This fixes an error in the test case reported by Mark Brown
in https://lore.kernel.org/lkml/agr_RxvNtfASfevg@sirena.org.uk/.

There are three changes over the old version:

  - One of the test conditions used in the test was much too strict.

    The test was treating success as implying that the
    smp_cond_load_relaxed_timeout() call has to return before timeout.
    (runtime <= timeout_ns).

    However, all that we know is that on failure (!success), the 
    smp_cond_load_relaxed_timeout() *cannot* return before timeout.
    (runtime >= timeout_ns).

  - The test can run in a wide variety of environments including in
    emulation. So to reduce the chance of failure due to timing,
    remove the kthreaded case.

  - Parametrize the test cases.

---
 lib/Kconfig.debug                |  10 +++
 lib/tests/Makefile               |   1 +
 lib/tests/barrier-timeout-test.c | 128 +++++++++++++++++++++++++++++++
 3 files changed, 139 insertions(+)
 create mode 100644 lib/tests/barrier-timeout-test.c

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index ce25724be414..9d54c48d7d98 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2413,6 +2413,16 @@ config FPROBE_SANITY_TEST
 
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
index 7e9c2fa52e35..19c1d6b17856 100644
--- a/lib/tests/Makefile
+++ b/lib/tests/Makefile
@@ -20,6 +20,7 @@ CFLAGS_fortify_kunit.o += $(DISABLE_STRUCTLEAK_PLUGIN)
 obj-$(CONFIG_FORTIFY_KUNIT_TEST) += fortify_kunit.o
 CFLAGS_test_fprobe.o += $(CC_FLAGS_FTRACE)
 obj-$(CONFIG_FPROBE_SANITY_TEST) += test_fprobe.o
+obj-$(CONFIG_BARRIER_TIMEOUT_TEST) += barrier-timeout-test.o
 obj-$(CONFIG_GLOB_KUNIT_TEST) += glob_kunit.o
 obj-$(CONFIG_HASHTABLE_KUNIT_TEST) += hashtable_test.o
 obj-$(CONFIG_HASH_KUNIT_TEST) += test_hash.o
diff --git a/lib/tests/barrier-timeout-test.c b/lib/tests/barrier-timeout-test.c
new file mode 100644
index 000000000000..2160844b27b8
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
+	{ .clock = &mocked_clock, .succeeds=true, .acquire=false, },
+	{ .clock = &mocked_clock, .succeeds=true, .acquire=true,  },
+
+	/* basic-clock doesn't update flag. */
+	{ .clock = &basic_clock, .succeeds=false,  .acquire=true, },
+	{ .clock = &basic_clock, .succeeds=false,  .acquire=false, },
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
+		p->acquire ? "acquire": "relaxed", clk, update);
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

