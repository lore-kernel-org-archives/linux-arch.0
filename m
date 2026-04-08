Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D0C3BA24C;
	Wed,  8 Apr 2026 12:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775651193; cv=fail; b=SqXD3Dyvgk8xf1CD9VksLREIp6LvKFfPYeQZv7tq5DRe8yJ/23Qxakw0JWwrqrO/xOtHMdlIK30IqjTLSPDiZW5CO2gGenlLWr2iPOobG+S0hH85kpwTyUjVZ79x+WJaV7CGGoceyAbykudvR8HpJmqhgBVQT9Om3OL09TmNIYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775651193; c=relaxed/simple;
	bh=LJfzRBBaIZCZ/jL/gUXlAN9r/jj3mOmaa/pg2GpjcQU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TBQkJBOI6HSNjGthmp2EXoxLFjJQpNJqOLQqpGoPDeGOKDHL2qqYet8LiwkxItKfmTRvw1hoDC+V9rt7+QTsY8dN7bP/35ern90zhDFq+gSExR3O8ZZ6VY5y+75sybycnvaIJIjkI3k/e6rRHRVDRAy/sxHaRSON4dEBTVGA4nU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WwbzaG00; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XN5mMkb5; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WwbzaG00";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XN5mMkb5"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6386e47B3637494;
	Wed, 8 Apr 2026 12:26:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=VORiZj7iTNWER3jAODAi4dzQAjBvC91iLzpRv9YCmn0=; b=
	WwbzaG00w/jaCu+ktIVl6x9f/6PToXTq7dIdHVi2y2LrrBScHNMnRpfkm1Wfy2GH
	qgOvCcXkmfG/WG+9gZU+xPbksWoXJkUIAzPgrLGLqThASmKbgczF0FCiGM8GAdA/
	dYmD327f1CD2nDHzI8DvpAodSqSpjyGv17OMX9GGz0jUZfLpxSZQEeZGKWhObfXA
	pTTMUdJ9MrftQZ35TTzfOXgIHYFqKxusBnunbSMu1t7030WPXMGoK65EvjUuIK7S
	q7feK1Y+kRwibyL4S8QZTpiz5Upcqess+BpkTraI9SsbhQ4P/ZJqTmD2TKqeOayL
	qH3geVTNzQHkiw/CcMbazA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dcmqakfcv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Apr 2026 12:26:07 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 638BItuV011596;
	Wed, 8 Apr 2026 12:26:07 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011014.outbound.protection.outlook.com [52.101.52.14])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4dcmnrfjkm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Apr 2026 12:26:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=okWSbkPireUVQo/oqH/rQZMBI7MO/a9Xy1amdKzVEGIDvd7/ixoMx4vm55nNVyi8vYo2i5PqSnoZbW7BhP+zbxADOj6xxtwqsI6qYyU7QYw1SlvPbKXWKw2kn6GcKs9xC2NRWJHpn0P99CuGIxGs7X25e7QWT4w8+2tV/T+BiPLp3If77CcQhkZNMV4Zk2jEIdNWg5TZVryiNiPGVt8kTihCpYH9InyshlN/fvsYQeBQkFlBMXWYT2hMZ97K+mx+LeWT5XxbAhOWs3DLRBk1q88RvZ3juSGfPa4oNoLWcjFA5dwKRiGwTV/z77RxxYy6RpepbyizK8H2uMWWq6EwdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VORiZj7iTNWER3jAODAi4dzQAjBvC91iLzpRv9YCmn0=;
 b=gI0FH7N1qGxjYkumVvVFmggRXIHgfukTkz91VPIOGPOKf9DTFutT2xIi3q0DsfPd2K6e805xBfmw0QxbKsBFoZOq02TjrAPd/nT6332kq5Vqv5Goz9HPS6rou58SY8nUzpdvIIswd24pqRQG2ruWZeQZ7MdDaw89ZwlCCOAKA4BxOoD7xZNEU6dY/Lkfnn4HbxAKM+TNIc61hZZ/Rpe/9NTsVEQrnqlOJ4ypys+YXh191T84JcnAerkz9Vvofv37OWYLlamhX6hiJFxAw+R3o2eOO5tOXCFQvv+pqOImT24dvyULlIQXajCVyzL2HHiypwWq/25Wv3aXBY9AWCZqJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VORiZj7iTNWER3jAODAi4dzQAjBvC91iLzpRv9YCmn0=;
 b=XN5mMkb5wZtZzucbeCsboKhs99a6PRp9xcII0T+lu0/St+3qZWVFhVa2d4bfCFrUd5n9gLlgSACJHvW6w3KvNiILPutzW+85xKEkkRJFIaIF62ldOjwR0m6ktplcrYNdD+3lH13EWHwOl+Nb5EqqEI0VPjTz7MZCF4dmGT4pC0o=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by PH0PR10MB5778.namprd10.prod.outlook.com (2603:10b6:510:12b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 8 Apr
 2026 12:26:02 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.20.9745.034; Wed, 8 Apr 2026
 12:26:02 +0000
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
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, ashok.bhat@arm.com,
        Ankur Arora <ankur.a.arora@oracle.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Christoph Lameter <cl@linux.com>
Subject: [PATCH v11 03/14] arm64/delay: move some constants out to a separate header
Date: Wed,  8 Apr 2026 17:55:27 +0530
Message-Id: <20260408122538.3610871-4-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260408122538.3610871-1-ankur.a.arora@oracle.com>
References: <20260408122538.3610871-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN4P287CA0001.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:26a::8) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|PH0PR10MB5778:EE_
X-MS-Office365-Filtering-Correlation-Id: 2abef44d-861a-4162-f664-08de9569feff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|7416014|10070799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Rf0g3Kk13DchHQtKeELiD07LyAon6zwGNmya4IQCklY363zEH4IB91lIZGi5x/NXtjqgLFD1fo62cveLcIrzbkWw5j6Z1bHrKIb4okVCVVM/avUxzh/pJaHL8PRgobPVKTCvlM3aw+ayWfHP4iBSe56HIlEdtXeme2rnHpMudlE2HEBnRVKY66PmrTAxOn2Zw/uGWdwq6cahW2VGA9BZFIFgRMDTe/5e8uHjbK0eKU9Lj4vTiBekBlwDcrGKBlF6Zy6uMmxf3RhUADAG4uzoun8Tp4IrJm1c0T7N2O59P2BzsCd9zeQaAceWFiClgi2YTHF2YeGSrTcZ2yjP3k9O6bovlP3/v61qLNwjhHd9PMeWGb70RRnrftDpm7icsGPUidjxnbXeISbOxL9iRFMqIrEMuB4Zv0GdCWvVggxD+xq5YdDytCcJEoUdLv9z4euzO5D6L3zfHkjDBNAZ3yO9aJCgHAyGRDdniNMAU9/WlcoP1a5ta6RlBhDDdqkQKsmqlzXSbv82kGBK05eMTTkvxJY5mNyjmFIL/YZDUhoGHLY72bIZtzPuFM6hd6Smp9xMsNab/Q4gzfH4I6wYeQ7XP4o+/6zkDvXM8zcoIp41gxMbzmDnWvT7Y8gjm4/bw/cojBXSfXzDj5odgCVbpfalRe7HVBDn4fGvTBTVMclDJFhvHJ26Zalh7TL3yik8lM41cK7YcdKARiwByP8XF/briivyiiCfCokQ8Fp1Qw7FjeI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(10070799003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?P2BNKb9uAgreP2r+y3j9lTsL8wLjGuvpZIde0kdSuUtd/rxnkNxMHQPX87Gt?=
 =?us-ascii?Q?DWX+0YbU3PBzl6Ioe4Y+V1KLu6iYrkUcHWfKKhWQ9H5n+YRapgRKRx7lbQ9J?=
 =?us-ascii?Q?/RovY9mlRwgSDY5RhopOIxS8CXY/3mNqg+Uw8VBt6MGv6/FTcG+AXe8DbyyO?=
 =?us-ascii?Q?dNL29iFEbQgOsjozsJGnsx2SaEfvuK98O5l5DDPIjUVMCjQYlzn4OJsucj+Q?=
 =?us-ascii?Q?LJAFPZjmOf/W633JjgxjKeA7obg6feLsnFbOWc2T/lxNerEPwmJ2G8NKnNxA?=
 =?us-ascii?Q?7+HT26ZvKsk1Y17W6U9m3wIA61DKAjRbr/sJLx9ghP5x+InH72RNcZufMb7m?=
 =?us-ascii?Q?RIKR7hz1pW+SQ3z9ubQi3yAwJNiK4CJ1crN72CtvyvdI8GDVbGKU3q40K1yW?=
 =?us-ascii?Q?/o04rBI4nGyDcAKPy8TUYFrUK/qcFHT3AC2fiBeXyoxg+A94imw9vtFRPSrp?=
 =?us-ascii?Q?X8NvXaXB9vLMiQ3QkZv0U8eRmsWm7YTECOicRqAIFMUEJG7U3opLWCO1JyZu?=
 =?us-ascii?Q?dpbSX7CBtHgK470XWUVoMm0tiEXNTqayUwSJwky113pKoxvXeadOsang3Kc5?=
 =?us-ascii?Q?ABDKZulymm8Iu5LCMpGXayo4h/ajnV4jzZ9wj5LNnyxn0DHLKk83UOQf4v9j?=
 =?us-ascii?Q?q32EwbtFf6oV80A+jGoCZpzxUiCcVYsK9/qMuwWl9KfTnbyKEJCXd3MFMIZS?=
 =?us-ascii?Q?oEbZGl84dBeEiFhR06FUZqoTqaTk4955qIaZ7hwa1/dS6bLzYqnrv9tZa6y8?=
 =?us-ascii?Q?DJZHZTN0SxyHTohlzFbE1SlaSLpdPzCqpo+LrV5nDBMOCCVlPMMsC/uoQTPC?=
 =?us-ascii?Q?Yofy866FkGcQun2+ItvjoHkcKM5WeABzNaOs3OgZm8Qom0t3AS9Dr/G4lIpm?=
 =?us-ascii?Q?7zOzlWocJuOrI/7Mhw6gusyrgWqmcybKmzyT8Sy/MAKJP5XKsDpJTviFxCEN?=
 =?us-ascii?Q?9hvkuM14vX20VsQPJCmO2EgLJOEpF3yBxl+w1Dq/0fXKMc1vSj2mTN+9+ZgM?=
 =?us-ascii?Q?LkY0C4KCnn8eqJoGY8wVi92RJ1uDUpvFtDwTGS03WUqt1Af2JAMHokE6Sgjd?=
 =?us-ascii?Q?g8tSuCuZosM4bxBfBvrcU537mnRyn8vOtcRokHQ1V76eAMMpeoaHs1lEg1XA?=
 =?us-ascii?Q?AaupFGR7rAmwsgl5fT210hLm8XX8ayvejm8RlU2eWFM/lAnwTTneCGhsG2HY?=
 =?us-ascii?Q?dpTwzo+g2Qr5EgsA0rnLpobjR8iTrDEoRCKioi3Vn+X09NvCoUI2EXO7G/ct?=
 =?us-ascii?Q?6jieWnMMa7fU9Y7a1z93+g68quVhO6T3buQmYwSWFmFwatUeSkOHXtde4s5j?=
 =?us-ascii?Q?6eaxkldldePsbd6p4C1kLc2ePMpA8SJrq9JG/HKDSaf1Dp8T67T9ni8rrooQ?=
 =?us-ascii?Q?dEXGy3T2V9H0fIZutRkxy+gFS0QbrScqPbfQbxMMtd4622EkX7qiHGd0XXfi?=
 =?us-ascii?Q?FmxCkiOOuR0sBA0m7tK+LV2ZUJOxI7SG3KBOtKswVfxqX556wF+iq/NP5FYe?=
 =?us-ascii?Q?6UrUzeyJUbsQ3IOpprmlYrw9slKoG7lZ7L5u2LaGUdJqXwi0d+OqDNTQR3G0?=
 =?us-ascii?Q?lSxgHdGCwlDRT+rX1bPv7dcm65aqP7BVeDwGO3RIQBdh5apqMhPBNwt/AWeT?=
 =?us-ascii?Q?gBIAVmweZYZ3o7zCS0MqaVYPSGu9wG9HffD6UvcZR/gtMFJK2yN2d7lwsgF3?=
 =?us-ascii?Q?t7PdDlojZrKSBDSgng0thKcGuOJjCCJkR59xT5HmZH87HLL2CZ7JA9TlFZjc?=
 =?us-ascii?Q?UJthtDrmkQFQsYwRM6z9F5V8CIJuqxAp3TbTQDMxsXJ7QkTBZ16KjVSBJ5d9?=
X-MS-Exchange-AntiSpam-MessageData-1: dGx5l4CRXUKn0HV7h68mg/PU9xqcN3OLGuk=
X-Exchange-RoutingPolicyChecked:
	XmmIhz9qply39/Xv3/FjBg7VyoLKCkLkB4sA8jG/TqvdkoGl69XndIX42J4U/9iQ52ItYclpXa3E1zvfQgeP4FrRU9I8LYnODSAtq7i4+nWFH2BEe8oh3XUo1nTfpM8UergQUvDO1g2hupi2LMj4mf7vjOcsfHD6SlhwGzxcmfzcK8+5XtNtgkah7m1EDc9uZOc9rrmLFGmkYKP4TZkI87fsFeNEmtZaohtGrgnjiWzrMReNq2y4i5PfuUxhsID4W4no1bXy+BDyVmk8Ak/98p0aDYF/0kYRk0OieevJpDdoHEGXC8Cx1W6uCF0LIVjNHs8bR9454L9YHwwpGJNIjg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mVeuorIE7tyymrIbnOeeNjInMh37HKBcrwVuIMTs8I8WniMyajVjkpplR9ibIpOUtqJGCfGy+4rgWi1sgUOMA1kjJxynL4ZdSuA2ehQ2pCq3uHsZD1LeZ1pkcNgq/JY2Bq2/4YU2eIX0FiYdq9SxAqowyruoi9GGabDSwxU54w8+iadp8eho0eAuJLEULZebjn/JjsHjC0FYpzPYWbJCm38u9Is33w6HZUnniAKPkNbLVMzboL2zlUy//W17f4fsTMH8ni245RkLr9+Ac/F1LBbV/P5l8nhrQVjz2JiureDdLrD6YZmj9GVuYPmc+7ZH4IkrBAUoOkEBpoTfOWenRFmVCtVUvBYnBSEHPjWnZfvxOa+zhNkY+D1n7PSbTWbjK3i+uFd068tyJOp+mWssp2Eg8ihc1/sBg3CKu9oIv9XxSvE2nkw4wGaClbp6/2+L+2fZANDBz5/lGsyy/dYUYxIqMdx1VnNcAt//tDRvIi4XtdVID4kYdfZhzfntE6EDCr3zhlkJHBnWMPuWptME0s9nV7FhZPsDn/wyeJ5bj6dIqLx6RtaRK01hfDIFxw8tigjIaGE8JuDK1PTCX8ttLWVjlEjEVPEG/D1e7UCwcF8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2abef44d-861a-4162-f664-08de9569feff
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 12:26:01.9176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +isPuCN/UDWzu6TWE+fBs+jwj7pL0eQzjt+v16FRsstbe4HravxFcyWdmP3SDFBqlcqukfbBA+2XE6Q6ThV6bSehrXoG+sP/uuTaxRfkurY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5778
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_04,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 spamscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2604010000
 definitions=main-2604080115
X-Proofpoint-ORIG-GUID: TSHthOk9sp0N4MNTq8u6idNmR_vJQpa6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDExNSBTYWx0ZWRfXztzsBBKN99F5
 Z6X4GZXz44CTVctlOULm6nbkhiwwkiDqW0aluyjpgBVF2gAX570mIsLHNzLNBQjMMg+XWpaTvLE
 tXO3/pz/iGus8yjTOJJzN1nw1jGN83aFTiLp55rk1aE09IkPUZ+ivfDTxDMWrkqgok3n/8oMNf9
 /l0SQ4lrS7eNy1ZUcdXaA2m4L7rSVmQikqPDusUKSASa2qBAEDGL5HgZ/8r4DNrQjAc9Wn2eJCx
 AXPXKx12P9LOYAJzuz1EEv7838joGJhy4Nd40RuW32ZpX/jAJ/wogOKqTArrSB2f8yxMJ1VVJnE
 YzvCOpUG3ukj3z0iSj6NTldiTXmw1gYNE6FZV7UlrC9y6w6XoPF5w1xh0AMcqpQujuQTS/1B9ID
 y0j/wSJARyuYOlKro8nkLVhVu4KjFqbW9Kq8AyKFDouboZeXyMAOrd7iiVEvwE6ulHtoEsTcB1d
 9SNOU7Dc0gE+c5Retww==
X-Authority-Analysis: v=2.4 cv=AsTeGu9P c=1 sm=1 tr=0 ts=69d6495f cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=7CQSdrXTAAAA:8 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8
 a=NufY4J3AAAAA:8 a=yPCof4ZbAAAA:8 a=gQgDrPkycQ706KZxoKkA:9
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=1CNFftbPRP8L7MoqJWF3:22 a=TPcZfFuj8SYsoCJAFAiX:22
X-Proofpoint-GUID: TSHthOk9sp0N4MNTq8u6idNmR_vJQpa6

Moves some constants and functions related to xloops, cycles computation
out to a new header. Also make __delay_cycles() available outside of
arch/arm64/lib/delay.c.

Rename some macros in qcom/rpmh-rsc.c which were occupying the same
namespace.

No functional change.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Reviewed-by: Christoph Lameter <cl@linux.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/arm64/include/asm/delay-const.h | 27 +++++++++++++++++++++++++++
 arch/arm64/lib/delay.c               | 15 ++++-----------
 drivers/soc/qcom/rpmh-rsc.c          |  8 ++++----
 3 files changed, 35 insertions(+), 15 deletions(-)
 create mode 100644 arch/arm64/include/asm/delay-const.h

diff --git a/arch/arm64/include/asm/delay-const.h b/arch/arm64/include/asm/delay-const.h
new file mode 100644
index 000000000000..cb3988ff4e41
--- /dev/null
+++ b/arch/arm64/include/asm/delay-const.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _ASM_DELAY_CONST_H
+#define _ASM_DELAY_CONST_H
+
+#include <asm/param.h>	/* For HZ */
+
+/* 2**32 / 1000000 (rounded up) */
+#define __usecs_to_xloops_mult	0x10C7UL
+
+/* 2**32 / 1000000000 (rounded up) */
+#define __nsecs_to_xloops_mult	0x5UL
+
+extern unsigned long loops_per_jiffy;
+static inline unsigned long xloops_to_cycles(unsigned long xloops)
+{
+	return (xloops * loops_per_jiffy * HZ) >> 32;
+}
+
+#define USECS_TO_CYCLES(time_usecs) \
+	xloops_to_cycles((time_usecs) * __usecs_to_xloops_mult)
+
+#define NSECS_TO_CYCLES(time_nsecs) \
+	xloops_to_cycles((time_nsecs) * __nsecs_to_xloops_mult)
+
+u64 notrace __delay_cycles(void);
+
+#endif	/* _ASM_DELAY_CONST_H */
diff --git a/arch/arm64/lib/delay.c b/arch/arm64/lib/delay.c
index e278e060e78a..c660a7ea26dd 100644
--- a/arch/arm64/lib/delay.c
+++ b/arch/arm64/lib/delay.c
@@ -12,17 +12,10 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/timex.h>
+#include <asm/delay-const.h>
 
 #include <clocksource/arm_arch_timer.h>
 
-#define USECS_TO_CYCLES(time_usecs)			\
-	xloops_to_cycles((time_usecs) * 0x10C7UL)
-
-static inline unsigned long xloops_to_cycles(unsigned long xloops)
-{
-	return (xloops * loops_per_jiffy * HZ) >> 32;
-}
-
 /*
  * Force the use of CNTVCT_EL0 in order to have the same base as WFxT.
  * This avoids some annoying issues when CNTVOFF_EL2 is not reset 0 on a
@@ -32,7 +25,7 @@ static inline unsigned long xloops_to_cycles(unsigned long xloops)
  * Note that userspace cannot change the offset behind our back either,
  * as the vcpu mutex is held as long as KVM_RUN is in progress.
  */
-static cycles_t notrace __delay_cycles(void)
+u64 notrace __delay_cycles(void)
 {
 	guard(preempt_notrace)();
 	return __arch_counter_get_cntvct_stable();
@@ -73,12 +66,12 @@ EXPORT_SYMBOL(__const_udelay);
 
 void __udelay(unsigned long usecs)
 {
-	__const_udelay(usecs * 0x10C7UL); /* 2**32 / 1000000 (rounded up) */
+	__const_udelay(usecs * __usecs_to_xloops_mult);
 }
 EXPORT_SYMBOL(__udelay);
 
 void __ndelay(unsigned long nsecs)
 {
-	__const_udelay(nsecs * 0x5UL); /* 2**32 / 1000000000 (rounded up) */
+	__const_udelay(nsecs * __nsecs_to_xloops_mult);
 }
 EXPORT_SYMBOL(__ndelay);
diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index c6f7d5c9c493..ad5ec5c0de0a 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -146,10 +146,10 @@ enum {
  *  +---------------------------------------------------+
  */
 
-#define USECS_TO_CYCLES(time_usecs)			\
-	xloops_to_cycles((time_usecs) * 0x10C7UL)
+#define RPMH_USECS_TO_CYCLES(time_usecs)		\
+	rpmh_xloops_to_cycles((time_usecs) * 0x10C7UL)
 
-static inline unsigned long xloops_to_cycles(u64 xloops)
+static inline unsigned long rpmh_xloops_to_cycles(u64 xloops)
 {
 	return (xloops * loops_per_jiffy * HZ) >> 32;
 }
@@ -819,7 +819,7 @@ void rpmh_rsc_write_next_wakeup(struct rsc_drv *drv)
 	wakeup_us = ktime_to_us(wakeup);
 
 	/* Convert the wakeup to arch timer scale */
-	wakeup_cycles = USECS_TO_CYCLES(wakeup_us);
+	wakeup_cycles = RPMH_USECS_TO_CYCLES(wakeup_us);
 	wakeup_cycles += arch_timer_read_counter();
 
 exit:
-- 
2.31.1

