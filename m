Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01F534CFDE;
	Thu, 21 May 2026 08:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779352290; cv=fail; b=WfnpXOp8U40ujcP+KzchaSZqDBYCD91PcNpRKMpdadt9hTnGgmZiHfVHXCbq4o8X3QQi5Pmu+OsbCwAB7b+gn3Jmno12arfXqPu9Foc/O6uMvD9nc5/v7/XSWwI+l92+Hvkdpgza3XlZ3A5Bhbfr/KFz3JYSLi+8PtPx2sBF2EY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779352290; c=relaxed/simple;
	bh=cwTK1NN4K0lTyKAl88JfKqy8g9p38/T3/PwegYBPjk4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LMrUwcKBfCzMDvmEb+HRVgB8JzTbJ5xvyyReBRoJql5vLKi6gsfzoOfJwGkAI7Tbltecl4knKsxXSinZYnspFf7AkvslXSfwxQa2kOosApXUX2ptOQxx5PILoOu36hsgPbZ97TKbOPQS3hRBq4Cj+E+YE5ENGfhUApdd7rJjNhs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MiH7FET1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=W+bEVJM1; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MiH7FET1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="W+bEVJM1"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L1NxoZ1644184;
	Thu, 21 May 2026 08:30:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Luv1mhUApC1bDcbseJBW3q9SU/UNuRsv2V6oyMXsHNk=; b=
	MiH7FET1rSoCTBKzyI+wYmdp4F9/1W1j52PhBn57T5MFagsGa1tOPZpZuI/hXp4t
	jX7Q3i5PhRF3CfuFI43nYA3f0DVK1/MjQFt2qboiphsp104kwAC93FMuAcNdKPtV
	+ppWAjdaThB9ptBPK5QHp8VE5aeDzDIKI+REZ7wLmTiM+H6uyuXsWEL32BqD5pAh
	Sh53x+EWJ6fSAWBONp1kCNx09nHDFEo0VyceL3osKFJp/kmx2h6hE/pDjRrWjd3T
	ymnUA9EhPw2aloIxSMqOBvnyS8yhH8EKde7XP2TD6wkHCUvGGg5bCjOs/20F4IjD
	o7vIL34D8c8KTeVE3ufLtg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4e6gxx0stq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 May 2026 08:30:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 64L8KGUW036537;
	Thu, 21 May 2026 08:30:48 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013032.outbound.protection.outlook.com [40.107.201.32])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4e6f1j4p6n-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 May 2026 08:30:47 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GG7B86XEcW88d0tO05PtimPALELIZog9N9aeTiPlV0eqzW1u87i6C/ZU2Xm+8Vxi6jmTw7IdpcZhVGKsu2snYItbdx6HeXvQn2QXhCHd7DDRcJcKeecrHkHqJEW+k1iafTkfaSYMVWM9hDrzNRCPOEFkrb/ZazlTitZaFuIfmeRIOEdMpTVpUiuxSZhGxeSQtDu4rV5386CMKDk2as0ChgJEth2POqLWVzPD1Vd7jhMEwQZ6dnXEIanwDidHKAD8KZOOne3nLyfmuO/qVcZfTF7cBqy2nQ1WeOmj5ozQEIGEzRtW2jNOiYDbl3+Fpnx9pjmkQm7LsjrXpNe33F713g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Luv1mhUApC1bDcbseJBW3q9SU/UNuRsv2V6oyMXsHNk=;
 b=ZJOaKMdZ24sq2NU1V5qLSMLSXiDYbP34T+cx4a5tvFLomZkJYBgPvwJ5FGpdOhHslXf2lmRTyyGSrHx0/fVVivhMXvYpDwzvNMquqsviV1qPOfnEA5FMt9lyo1Jtzl7O95f8QNG2bgfiz+Q282iKpcJxhjP4TQAJVFDAyJTr9PiI7VpyhWu1xazk0Gc7eYPdXZBvb/1qncdSEMY8YxS2zhhF0T8ZcS/rE8lQoahjJhn0ggFrmRukq0bjmzgOdXTfQBkj/1BIvQlsqPxXYlFmxAsxpR39cJrT8fsHfiJ5QyDMLRme7fgtMWwOF/GEGEM7cu/9ElOGBgFir3WcVHV6GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Luv1mhUApC1bDcbseJBW3q9SU/UNuRsv2V6oyMXsHNk=;
 b=W+bEVJM1CY/Scf2dUCRK3FRVAMIpR2E/0pdcFRnRrUUrA85mbfuhklLuDpg2vw+AWXKeHvlPyqYkd9FWGq+U4rb5NszEMbW9BwXeW8gvsIJeuV438N/aAsct7zdIRceP/EkPzxoqcsriOVsNSg+BV3n5XJKXNYzFixXOBLEpxBw=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS7PR10MB5055.namprd10.prod.outlook.com (2603:10b6:5:3a9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 08:30:41 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 08:30:41 +0000
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
Subject: [PATCH v11 2/2] kunit: add clock tests for smp_cond_load_relaxed_timeout()
Date: Thu, 21 May 2026 01:30:38 -0700
Message-Id: <20260521083038.134260-2-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260521083038.134260-1-ankur.a.arora@oracle.com>
References: <20260408122538.3610871-15-ankur.a.arora@oracle.com>
 <20260521083038.134260-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4P222CA0002.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::7) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS7PR10MB5055:EE_
X-MS-Office365-Filtering-Correlation-Id: 1177778d-8383-481b-20c1-08deb7133e8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|56012099003|18002099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	cEY7pZSy3rOyM1p+bfbOvdIu6yY67K5/7FOeBD+9I7t+frLGaPXFkuDpEgtp+mpv3Rgdk61Rl7zLXQRhqNLn6pkfdXrU71fHlV8bRgoZgmXyXoF5UD3/9t/Wwxsp7n/NhHrLfHAtF/GEVmFrhEUX2Qw9MkLiYN/WG6nPt+DO0a3hDW3K5AR8UgNQNZwLYQF7grY9bEmlyfVV9VuXCPznv9ifj8e2YwdzEd0P7tULbsJm7oBxNDJXoNVQiz7dsg8yYtfCRyRG9QRLIdih2ixLZd4maJsQV5yfDBJMS/sl4l4VzZBR2JqvhN4up6P5uk+d+DZ5uPqEtYLNZWNUAztBaNnvE8SdADuUQyqxJLzaYcPJ4kzRTvs53baYjzmN90cbJv0tTmgKjA0/FJYB2t9NHNwbVegowzaKVMGDf7YyzuZfAfuXtA8tBwzAMfF5oWjIDd+xWjY0sx6qjHxK1ahTUqlqm5FuFusJ/lzWdWq1OUluU3aiaPC1hWP3hNpo2dnAnjdLWPRf0c1Tblvw8IQep6MPWl7CIMKhmB3jJcCOKQrJkwZRptjpwiiRG4WNtVD9ggKsfTpTiqxO4vVa3yD0TMoOALGQLOSHQvZqcJbNOkDHjbfH7XoB2kpy/rteUIa4To3yqI0yEvJB7rPJTj0BlDF6yNuXqPUbZbupMUP9i7Vhc46efvxOpjPfHRL6UeYr
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(56012099003)(18002099003)(22082099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S/R5GWTsPtGVDlvq2c0ehNBfvC4SAWV8Tws8dvhUfHC1UnOG4hBBdvJOGt7+?=
 =?us-ascii?Q?Ss7UeT4LV7FYow3R32usz9yvAlbaRLX7mS8hIY8ISySG/Qm0SALfFfA4nyQ5?=
 =?us-ascii?Q?Ia7jE0YeG2Jdb/qEgO1dk/ylzBHpQpaHkV6Ivl0GqZ4fiX9eg2Znjy0Q9JVV?=
 =?us-ascii?Q?MSQ6F0430DEcyX1InuLgD6YEMjf0+BAzdzLJfIJqxU+MW3hkG699HCFhuVYh?=
 =?us-ascii?Q?8QEss5Sl5i8mK3dWOtyrMCE0c3+p2GOGqleIOJgu5zwCd7CrMiM44+LtxXOS?=
 =?us-ascii?Q?wIY5358DosWWSSojcmmTA+Jhnayk6zkKQvI6M2jAjQ2IgoQoYHONhM7ar356?=
 =?us-ascii?Q?EHTbocWFIG6MLhpknMdYlJlH7UNFGGNCPTd60T8v3znpeCVh84ESHqknT8ew?=
 =?us-ascii?Q?soh+Ou+hhT6yDCTgh4Y9ehsl7XZkbncqiWXmMEMi5qrs/9SRWAft3dYmioYP?=
 =?us-ascii?Q?Y/bnjeQevY8gJMvgrawtn6wNLOcRYZz2iKqX35u/HiDmYDpFY87rYliU8X3r?=
 =?us-ascii?Q?x3Suv9oXsKvTRlD/KacMR5MvY9ueg/1g/lBt6qxy5cnMB5egudxOCqgbaSYM?=
 =?us-ascii?Q?9v/fTjQNSho3CRw+hB/ufgCN5aOLCxm0h5ZI1Tm59sA0xnR10J4CwVVuWK3X?=
 =?us-ascii?Q?MV5Y5nZ0WDQ8C1pJND9NFRL5/s9zOPlVwOgz6ko99ClmUd5JkX2/xiIe8HYc?=
 =?us-ascii?Q?+d+ehwjAUbaixgcghnDfD16h8x3o+UacB4LMxT+hjs8RnzJD2V2qYRPej0ak?=
 =?us-ascii?Q?Qqi/xZCKAGQCc6I7Egtmhy4QOU/PP2zGHjTr9u4WWBM/+0FGnxAPsipbmMrS?=
 =?us-ascii?Q?amfBCSupD5vS6nJZrRxSEy/+ugsxXk7ps0JUVAZtqR7sNZEZe7fQRp4OiK3G?=
 =?us-ascii?Q?OY2K4Ys8exaQ7EEoFKz0vnskAnOgL5lsXC4QrZ6WRBiRQLreC3AreB5OpZHQ?=
 =?us-ascii?Q?JADIZEoQj1U75Yvvae6Wqlo94oxbkNxuqKh5EKa+9oSTBuXV+xXpiorj8FCy?=
 =?us-ascii?Q?vgVFd6DslmBOIyrsLs+VScskkRxTcSD+Md6sQQShHWdd4P0zXRkLhczNqFCs?=
 =?us-ascii?Q?TPSEsJBgtXMpaOBrveaaw5bLJ+Ebho664SBBrLwdqoSkSl6MWvzY1hh/d5bN?=
 =?us-ascii?Q?w+WXtxD5BDisz+5cy6zJFKCYiJUwMt3+BTC97yWl8shPP2A50c/tZ4K97Ud6?=
 =?us-ascii?Q?lKoIGBx/j4WW4oaLDZeZ0zCx3BFwZYucoF05r9S7QLzahVOxYmP0D/rBr3FR?=
 =?us-ascii?Q?QgEDnnaOZXJKd2rgsRzP0GjjaJ1AYlmfNpTTXdDAkqm33hV7Dw4JQ2GrGZ9o?=
 =?us-ascii?Q?/mwxnQUGX487tTuzP254vBdoGgz5AbCk/aA0IV/ZyN0VCGP6FPvA+OVDa8S6?=
 =?us-ascii?Q?jP0gJXKDc+iWZIHoE5iLbffwAcjbjT8bKNbYI17QG0l3FjvQnw+KudkHBAPv?=
 =?us-ascii?Q?dpqvzDkAgxvDrb1bB7QqdYwdgAE9MVcCYTWD2xyaOiIalk68b2on8QGrERRY?=
 =?us-ascii?Q?WX5nag0xCZ2O+T4Bz8n/OKt1K2gEsUQY5RVUuwDBdIRX6NdpZotfdK8FsYvj?=
 =?us-ascii?Q?XL+94qAWKd9UCqpqJq6XR+o1meTT8U97QC1ZlOtcQE6nWelGCZrNg/1Gq+G6?=
 =?us-ascii?Q?ISDCwGVtFL2iqE+dPFF6Y4dSv/7dLoUpB/6iy//gZA+7BXbIiC2Y0K7zHfmN?=
 =?us-ascii?Q?tMzrQcGcZ+H42ldx8pQQjPgx3ZGxJJcSYu2DnkzIhk3cGjVk0Efy5pNd2OWJ?=
 =?us-ascii?Q?0SRSdWdEjWnifQJ39cWifT60KTKSEv0=3D?=
X-Exchange-RoutingPolicyChecked:
	bmdfTWDH/wVV4f7U4I7vWAC8XuyI9rY2pndVdpdtV+WiJ6/3z+y+4HQId/NmDPzrADEtUss7k+Bqf3Fga7vFuh3wVZiKbEpcs0DW1zPXef+FN1UGVaTVGbg2xojWJu9QMY7RlhYVTuWX9GYFbIBNRbnA9HZIM+Mo4XlxQjfIORMU/YpuG9Cgt+UZLnthuqE6D0WYrb5GvxBRIRpmfCANk5BvEfuU1TxIkJn9JRfgRaiqLMEmXCXxawikIbtvZg7MhP8TbY48lGmMYYlC9E0tqPggF4lTGvNGwGNU9I0cfo1LQoUDuh72S4D6RJ3Qp7MrzOs2qojRtgScCzxFDQM5sw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	a+Wpe5Fhc4x9T9sGUeFEmXvIha5q2MCw8qfGOn+jMV+J4rYiaPiWNd9VAOVMZVJ6z59x4zlGnU7Vp/CjGRAdr8vZLxfdr+RJxn6BpM/uU+OOQdxCa+2WHs0nZsq+7vWD5RpDYWFpHVf3bNlpUiOIxAd+vq/nkWFbJuRdzDpd1IiScIkKJsKVh/sfEQLluPQYwRAJa6G2MSJFZppyLyTtlUjDqLuZZX2MpdykViWTM/WN6itU662Tb644PjLVGLbL/O0knvW7ap3lcYxsGLcXZtXVle8qZzdAo231Ukcica7INHYztNif+nLRKxZ9d2wSBrAQilgo2LxUMz+PRxPIheRyd8l0D9RRlyZ0wEOiLv54mOO/BGWVSCfI712dmpTNci2ZkTt5EpiO5KY3T34VWs846Js/Xnw4MGZcUI+tD9YxkZdvPgK/3v/ekG85V3pF8OACBeV0xpeIbwePlOoeza3oG1sljj9CCTElpC5MUR+92sBeQrbBxCvkwOGrQjDd4v/tBYWokl5N+BJN2WK76vSoCwkfLIdGCKaPiAqHUaR8iyc/RGfBhtUgmokXeL7nPYBMonwBtAVHiC0DUfwV9AGOFg5q78wZROc5fwqYX5M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1177778d-8383-481b-20c1-08deb7133e8c
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 08:30:41.6832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xViomLRkrvalLB4kgeBFMt/oQmEgcpjU4BPApwfSz/uVNrKqfHK+tp2/Pkd+ChJ3Q0O7CpqBEqSwAgiL9Y7LcparBlGOo5F2Waw4vcy2i7o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5055
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 adultscore=0 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2605130000 definitions=main-2605210081
X-Authority-Analysis: v=2.4 cv=UOjt2ify c=1 sm=1 tr=0 ts=6a0ec2b8 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=yPCof4ZbAAAA:8 a=Z4Rwk6OoAAAA:8 a=pGLkceISAAAA:8
 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=NufY4J3AAAAA:8 a=vggBfdFIAAAA:8
 a=JfrnYn6hAAAA:8 a=EAuR-l_fSTGrmbixSIUA:9 a=HkZW87K1Qel5hWWM3VKY:22
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=TPcZfFuj8SYsoCJAFAiX:22 a=1CNFftbPRP8L7MoqJWF3:22
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12298
X-Proofpoint-ORIG-GUID: TFt83dN3CDlxnq4k6_7RQRe7YSGdz6cL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA4MSBTYWx0ZWRfX7lmasb51exQr
 AJavdhbXuZKDMC2BRgyVI7fxTe9ehd5xo9lb+/5YZpdD/xeYSpl22eT3zYmY3nKxg3KoRI8y9pT
 8nchAWkaL8UZppLEehb4YONLmpTrrOTtT0vFL+op4UpYBywzYOW4QyKM5kLM+JpBjQ+C28QYYON
 EyA8fCn9aY3eHvQC1J17cR/urv0y6qOFd7Vh6/uWS59/DVo5saw+KCzTMdo2DjFZNqtZtebjiul
 8yDJbC2hFb27BNTf6RWXLRdEY9gyiJ4gI+vrg8Nf7NnyprB/oFghAKf5IlmQdBfAkAteEVbiBAh
 OzXV/whEAl1LVb1atv1kdy43Wrr/GaFmqVd7a8GljpJhDgKLgRSqGopAyjQvopX6pzcwKQgqBxE
 ymqyJzSuQqYNdPsLxyJarpsIWG229bVBHwIzNyl4gPrWgS1DTjOWV00vQxSHbEnt+L6KjCerpxe
 qI+cRWs4rhFNmleJRCIN3uEZyAYrcMWg6j5ACWls=
X-Proofpoint-GUID: TFt83dN3CDlxnq4k6_7RQRe7YSGdz6cL

Add a few clock tests for smp_cond_load_relaxed_timeout(). These
ensure that the implementation doesn't do any funny stuff with the
clock (like multiple accesses per iteration.)

Also ensure that edge cases are handled sanely. Note that two edge
cases fail: S64_MAX and U64_MAX. However, both of those are quite
far out and if needed, can be addressed in the implementation of
the interface.

Also, this tests only smp_cond_load_relaxed_timeout(). The acquire
variant uses an identical clock path and testing wouldn't add anything.

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
 lib/tests/barrier-timeout-test.c | 57 ++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/lib/tests/barrier-timeout-test.c b/lib/tests/barrier-timeout-test.c
index 2160844b27b8..6ce6c7b0fc44 100644
--- a/lib/tests/barrier-timeout-test.c
+++ b/lib/tests/barrier-timeout-test.c
@@ -19,6 +19,8 @@ MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
 struct clock_state {
 	s64	start_time;
 	s64	end_time;
+	s64	extra;
+	u32	niters;
 };
 
 #define TIMEOUT_MSEC	2
@@ -112,8 +114,63 @@ static void test_smp_cond_timeout(struct kunit *test)
 		KUNIT_EXPECT_GE(test, runtime, timeout_ns);
 }
 
+static s64 synthetic_clock(struct clock_state *clk) {
+	clk->end_time += clk->extra;
+	clk->niters++;
+
+	return clk->end_time;
+}
+
+
+struct smp_cond_expiry_params {
+	char	*desc;
+	s64	timeout;
+	s64	clk_inc;
+	u32	niters;
+};
+
+static const struct smp_cond_expiry_params expiry_params_list[] = {
+	{ .clk_inc = (0x1ULL << 28), .timeout = -1LL,		.niters = 1,		  	.desc = "-1LL",    },
+	{ .clk_inc = (0x1ULL << 28), .timeout = (0x1ULL << 30), .niters = 1 + (1 << (30-28)),	.desc = "1<<30",   },
+	{ .clk_inc = (0x1ULL << 28), .timeout = S32_MAX,	.niters = 1 + (1 << (31-28)),	.desc = "S32_MAX", },
+	{ .clk_inc = (0x1ULL << 28), .timeout = U32_MAX,	.niters = 1 + (1 << (32-28)),	.desc = "U32_MAX", },
+	{ .clk_inc = (0x1ULL << 28), .timeout = (0x1ULL << 33), .niters = 1 + (1 << (33-28)),	.desc = "1<<33",   },
+};
+
+static void expiry_param_to_desc(const struct smp_cond_expiry_params *p, char *desc)
+{
+	snprintf(desc, KUNIT_PARAM_DESC_SIZE, "smp_cond_%s_timeout: clock-%s, timeout=%s, iterations=%u",
+		"relaxed", "synthetic", p->desc, p->niters);
+}
+
+static void test_smp_cond_expiry(struct kunit *test)
+{
+	const struct smp_cond_expiry_params *p = test->param_value;
+	struct clock_state clk = {
+		.start_time = 0,
+		.end_time = 0,
+		.extra = p->clk_inc,
+		.niters = 0,
+	};
+	unsigned int result;
+	s64 runtime;
+
+	flag = 0;
+	result = smp_cond_load_relaxed_timeout(&flag,
+					       0,
+					       synthetic_clock(&clk),
+					       p->timeout);
+
+	runtime = (u64)clk.end_time - (u64)clk.start_time;
+	KUNIT_EXPECT_EQ(test, clk.niters, p->niters);
+	KUNIT_EXPECT_GE(test, runtime, p->timeout);
+}
+
+
+KUNIT_ARRAY_PARAM(smp_cond_expiry_params, expiry_params_list, expiry_param_to_desc);
 static struct kunit_case barrier_timeout_test_cases[] = {
 	KUNIT_CASE_PARAM(test_smp_cond_timeout, smp_cond_update_params_gen_params),
+	KUNIT_CASE_PARAM(test_smp_cond_expiry, smp_cond_expiry_params_gen_params),
 	{}
 };
 
-- 
2.43.7

