Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A98F242D67;
	Mon, 16 Mar 2026 01:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773625074; cv=fail; b=s+pilh3x7nKZovA3dB4TBIOW2/0PuHTX13wvyCKRk+LaE17IWHZEzTlB7pJqHALSmch2ALSaTwK5/U/6uu8QsOduVTajrAWTM88X1paRFRS9+OnWBo0kS1UN7RT3vC5CAOebY+mBSmiLNS98XvdylhY2ojruQwI6jPvycK6rjCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773625074; c=relaxed/simple;
	bh=C5OH129u9PeuMPDVOuc5sFUubthBDzFHxqG2riP58Bs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e5UrlFreTsmFFhHShb7H5UMFT1hHxCLA43VB2JcPmYK4vgcZSVz7hvJkkAR7hTSsAe54zTwMdyl3JceGvMXRoxs+RxWt/q8olaNR3wQI5JDZ/IUezkIkERFTx4x2HhYRd0TrjTSzH0ncbnFAt/VvSvkSX9n+6P3GCFBVV39btII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TJxENJWn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=D5jk/0Kx; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TJxENJWn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="D5jk/0Kx"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62G0Tx0w1498676;
	Mon, 16 Mar 2026 01:37:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=AZg89TwpgcodJ5rBk+6SuHQH6e5wNQ4ORxf1iG/fxoU=; b=
	TJxENJWnhtlnPGStIHgN4HRIx9Y05o+yjSAgqhu4RUFbxYWTEDhcK/UXiTQwy7j2
	nhpZOs/8yDQm9rjJMVCY6hMKJrPeWcHLp/ygXjC2y6suHjncS5w1qML/qKkSWAVj
	7YwNWScCn3JN2zUB1+uW0859FJqdfMIv1Jg11Glw/vGPfW9ZEyk+ABfynrTg1DG2
	bdo78NFDCBUiG3mCiBT+1smRGy7/SdBamkKfqRylKXvUshXiHBqFGWHF3JVuoB5x
	ZvMf5Us4+vCnqAJOnHFgLI8OOfvPgoBy13gi4y/BG/BXsg0UPNsIHDBhjlXSt/qg
	0Qb6eQoeEge9OFycCz+Dqw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cvy9rsatu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 01:37:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62FLlQHX002861;
	Mon, 16 Mar 2026 01:37:07 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012018.outbound.protection.outlook.com [52.101.43.18])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4cvx4j84md-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 01:37:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eriSRk8mxpMe1kOeVZIGNpt2V7FuAOOFz8D3hDmHNpS+o7Fn1BSvY3oFdYpeV8/CfoUqWZ9cmEXz7BkyqX/MFNzJNIspq0Tap/wOnyNCtOZb8+8L+lVc5TZMZ78XGvgy34Z514lmhEa1dHcb334nSn1M4ji6K2APNDgWLWd8684gyzYvyvENDvDLrPWIEOymE5p1ckuPjP69ECLCwPxqE8PEU5ASdwYJszOPPNijMGavPqSX91+MFIoipmw9Huz0MQxJz8UnlYYbwjBEu0FQtsvhFaz6zlNIkas466VTph79E9GdZj4uh+2oewY/Bx7E5XHpIOJGIseiYpUGvEcC5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AZg89TwpgcodJ5rBk+6SuHQH6e5wNQ4ORxf1iG/fxoU=;
 b=FakZJ1eeDwtSLkq1ZIAKx8Ym0iz4DuCJajLtjIUcE4YCj5z5SR6A8emt1H1Epr3V8ZwZqP0ACR7s19Wo4xPfOgvD211Jm//96X8yLQsm2Yi29TbkTO0gUg4T70nk7Gz30oBmdPH5ZvBSlfW5RJl2QVT0Z41gN11O5PskxZtXCSsJr7Qj51AqoapnspQ6kqLoNkVqgz/nnlFRCbfFG1N1poo+ArK5iePoXvbXHl6r2YhVyFK8ct9wFdqyHGMtsfQOUJwN2keIX2XVfrqlAwH00u4g+kcbsW8VohQJ1x6IUWvsQMeKTriguHJ7i8/rONwFd84RUvU7RIGTtaSWxVXPKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZg89TwpgcodJ5rBk+6SuHQH6e5wNQ4ORxf1iG/fxoU=;
 b=D5jk/0Kx3xbL2ChAHA4QLFsevsM1SG1NMf92EWG/Y5P9sRtvzaaKk+SIy8Pa5j5iRSfGPl4u3Ha9xEnak8RtCdgpN2GAARtMo4fY3G+RfCMQKfqJ7OgEJti9QGbc0H/ogart4Yj6/8rIqIy/t6XLvx/H4B4Mrk3CxE2hR/B4Eoo=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by IA0PR10MB7372.namprd10.prod.outlook.com (2603:10b6:208:40f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Mon, 16 Mar
 2026 01:37:03 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.20.9700.022; Mon, 16 Mar 2026
 01:37:03 +0000
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
        Ankur Arora <ankur.a.arora@oracle.com>
Subject: [PATCH v10 04/12] arm64: support WFET in smp_cond_load_relaxed_timeout()
Date: Sun, 15 Mar 2026 18:36:43 -0700
Message-Id: <20260316013651.3225328-5-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260316013651.3225328-1-ankur.a.arora@oracle.com>
References: <20260316013651.3225328-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4P221CA0014.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::19) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|IA0PR10MB7372:EE_
X-MS-Office365-Filtering-Correlation-Id: 32014042-939a-46dc-45b1-08de82fc863b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	MMcnHfoLsrynifBImYTnaoQdj4rHTWetY61z2vyae5pI38hq7Z+90nsNhXBqWlTuRUEenhM+hgOH35AFB2wLlUK1X8lPxZVXEiUqyOJ1JuJI8IQ6yBYU5pCH5LIdm+MvpSPKXQl/luE2ZnwTT3mASQSnWXPa457mTW/ZOExRN40dgzXsZ3Kw/k3r6L9GVQd2Et+lQmPRjFoTShMz+Caa3OG31M5yvYha7EkBbQaxZncuR9M02hEcOeUxVLM1qvZkXuznOWMSF3jGv69wjarnI/qWxSfQnSiXFZcPnuKsn99dpn/9uBMaN5g0r+P+IRiAWPqgNptVbCK542q+Ce/B3Z2orFpcPTgBEjJCq422miMHkgGm+iYvWGXR9O2BBx/H0Gen7YKsgJCi4s07YiPB/uE2KV9JmsaQjrEZXBpUz+D5VLm778bV/eI3gcSHlmhJ/ox+n8ZldnrM1t5XGZY2HWCDuK/bv+NXAK09DZCZs7A9MrrY24fYR3i3+70O3IAgteL3EzWyPnvQRtgDlbzK7LebwRSYux7NXwaj70i41TVhoLnD3iDdkrpOvpzX/Trie1ieGi3Ny0tHjNl9synLaDJahghJz4hqmEIr7WqYuOn5/Sz+vE8KDYfpX6LEAV4d7wkaXiTIOvzyImC0oCK1cwAnyaaiwdcd9beta4N/Ifr46CAHDQsWp+KrFGCuptijGRV2cKAEUQUoMkfaKusHlXVsNLVWm6KnoBBFHums/BM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?agWqZnoLWVFXNJYonbsnsdpM6/cn3Lfg6iALaDlV+CGRlKyZYU71DYhHPVu6?=
 =?us-ascii?Q?4FPJ2Y6xDsunAbHCAmQkMjysmttAH/C3itvljTgOhSEQ7Khi4nCx2+H29whL?=
 =?us-ascii?Q?ENJjOS9EpQsh9WTI5CTXRR01UDFSZM/pQpEVQyzumOy8N8GBXIYME0rQb0Kv?=
 =?us-ascii?Q?uVMmiHE/srMeHObkzA2d8nI7kRG9uj23ju6REdLEWupN6jwj9oJfLOWWWH5U?=
 =?us-ascii?Q?U5McTq+bldFJjaiofoPhpDoIjqAUxSdQqAV1yNq49QlX90jzio3jmRG62yAR?=
 =?us-ascii?Q?2IZ19XjMETT7GaFpr8iHysbVCmT6vFE9VQZ+exLpz2h4ElQtT/7cGoLeCbe7?=
 =?us-ascii?Q?tzmTG81i+xZ7UpmLk2tgEU/5RxOZD2u+l0fDpjO20Spznymt0SUKlKzQ84ZT?=
 =?us-ascii?Q?32WcINEVEO0DpPEHW211PUfh5m37A6AI1gaWgqh4q6ryCJ8MbAxtRgIy7eYW?=
 =?us-ascii?Q?MlNlMnkKdgRccnDnI6aWd6hTqVL1tPl5ao1nrREGiMO82QUMQoNBfzUDuJqs?=
 =?us-ascii?Q?R0fVX2w74VzAJrAZN8i4wxS9z8NInfdCI7nz/yK28FT0s6L10aZy2AVCMVld?=
 =?us-ascii?Q?Tyqp2Q3po+sC91IJsGD9DJm10qSe5D1OVmvBvtrW5vyefCPci9Xi6jpG3a9z?=
 =?us-ascii?Q?1z0w/8FoJqlnPueUTKDtH9YosrymkEmnnf6ySkSTLPou0j/ylAiCBstqVgXR?=
 =?us-ascii?Q?10Vfa0YtHVHddzmmhOL9b5QPKa9Bv9ttLnKp0FCmg3MLc/T/JBy2WjURyNj4?=
 =?us-ascii?Q?HaXhrFFyNt8XlOsO6kqvbdA9TI8zxNpAZRLLpEE1Z0EvTSkc+N28V8TkoQVz?=
 =?us-ascii?Q?X5it7zFuLfQ99bQHhftoD+R7crGRGF6t15GB66uJ5BCpK1uFlHGXhG7XUKBe?=
 =?us-ascii?Q?KL8EqnFXQnxI/SzeCfy14B0dhJlh7THenRQv1JKl/J1YNfnJfEmH3H5b2Tvf?=
 =?us-ascii?Q?x+TbqR4h8ViTrHP1hW1AuxSN5iAeMzuyBFKJVHetmkrJ/OqdFX4G/ThXrPE5?=
 =?us-ascii?Q?V4kZqyw5KC4WSC22VK/ZPPmVXRUlx4fHzGdKajx+40+JC0KCcCWJZoSpzklO?=
 =?us-ascii?Q?Sx5KUMnfKROog7+1FI35g5if7tsld/Isg9rbTYmm75kvj54b95tL4RHIu/XP?=
 =?us-ascii?Q?lNZmtpbBGsAdPL2EZJ/n2q7146EQDFlOcNg4zVtRwqNXMRn9saLUYA/42Qxa?=
 =?us-ascii?Q?UssxsPc45UIuvDZ3+bgRYcHbtg04BK4CbHAYn3Y4YQfkKd5o8g9koS7mPIyV?=
 =?us-ascii?Q?OIAoD7w+7Z8dgW5BFfostZwBRM3JsoGTa8eSNNWWfF1147b0Idbmh3IzVtVi?=
 =?us-ascii?Q?LhkAVA1TAEy2WC19d0Bs6g1qUqtaSaBF4Vw4NOiVEu22MZWKB6F0Owr5srKO?=
 =?us-ascii?Q?vxQ4gA7kOKWGKON635d4PtYKMfRDjTQRfPTR6jcvEpH81QOn02FiozMz3Hr/?=
 =?us-ascii?Q?1yHTUe/+CBpwjlp/g2CDdQOU/WnGGDhrUbkvEFgSlv6bhdI28fohBU2NYP+L?=
 =?us-ascii?Q?akbIh55wxF2R3JvufDJ+V5nEI5jOYqQFugP9Jc523Fdyh3KrKfmDtFPoKrqX?=
 =?us-ascii?Q?omkgcCSM+sBRfAP1iczRmG/rekYz3Vo4bjy2bRudsV2H5YFMSNXyao4ePLVC?=
 =?us-ascii?Q?VARqtnjAn68y7op8sT+L0SfiTIF9/PobkhQIeBiOZ1Xo4p4SU73p6pIwFrec?=
 =?us-ascii?Q?qF8yh1Z7WRHd90X8vloiQfWjznwl1hPVMQagV0qHZNFCxbNLsQ/1I4b/EnOv?=
 =?us-ascii?Q?X9MCNaLiuw9U5COSIUEiOOF98uEUzHs=3D?=
X-Exchange-RoutingPolicyChecked:
	GWPpPFb4Oe1MSu5+RQOLapJ1S7gZpxzx1LvphjVTrNm+5CbEWrjfKLDVoOxjaZ6CKCEDWHMwTKQbijQCLISe5Ggjvv2SZohpAgfCkJTUHxW+kZ7M6GG9bOXQvTHUakjJvWAHplNtyDr8VHENtchlCHq3zOs9qQDKgjfw6GH56QszBmjACZRvZ2MZHKBmbC7OFCKiuqpH/CNZiajXLiodw3z2yOILN+h/h80GeJVvYlGSMkJ5GPWdT/uL9eC6IOuQ75ymxyf+wXzbzHe7NK8pj1xzsBHmo9R52Jk2HLgUJZcVmp+2cDw6SMNJglKY5PC47FUDgRUxvOYgbWyzJ4qmUQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qyteOrl2Yrx9O3a6tlMVDx7dMXCmt9YdIJc8Val+dZ+byX7warOB/dZd4wXqvp1EWTDGKCpSe8bfuTCccuEK1nmeqTHAUqBNs15tTHHmmHp7Er27LFdQCrXkn1DZCJycMTClnHfc6Hyc30uXCYUu1zp3SGQ4V1GNRPsoYnh6W9LAB0ReLEM3wzxd/Oe7x8ODRYEYXsOYhoggL/ijnqner3+fg3NTmWK7egIdW8rAp8kNwEeEirv0SPLQ9qsVOnLd5YXjsl5tnSnVkiNtWKWaxb8AvqYPlZ/LIYl4/OMo8h92qE/QYPrzhdIoE602eYU8ENhMtMY4hNjIA9WbdaTkx5dUG8DntxXhEppvSmINp/qFuucyQDExlv4mc4P+I+UiPpPGXpWMijkamgxlDow6PsGHdr0gukXzr2yLZQz/vcRlyqhoqGzgWyEPI9C+d7+U8KnW+rsiAdi4Wm6ZuZNpbtvnKvXuLXlej0LDbFiKPndKl/1QmXkLsMRBgJRXipxeDl9p6Dk+eDFIQHacdfIjRVtIQ1PDNfXFyI6VjOQ64RV4Q7g50FG6ovi/3tmrbObtDyVs6fqCL8zjXvSiEjLqGNsyGLnaz3mV47P7sYgMmLA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32014042-939a-46dc-45b1-08de82fc863b
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 01:37:02.9754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XGIVfji/suGgSYk/URysCPi2hkS03tTeWz9Nknfihq92fXbWWH0GAvEb2+YXY8dHddcksfDrqF4G9ybHyOg/lz2gdMnRJtIAakpmSjvorV8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7372
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_01,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 spamscore=0
 adultscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603160010
X-Authority-Analysis: v=2.4 cv=X5Vf6WTe c=1 sm=1 tr=0 ts=69b75ec4 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=7CQSdrXTAAAA:8 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8
 a=yPCof4ZbAAAA:8 a=h2j_Ys_cKJEXrGAlRtsA:9 a=a-qgeE7W1pNrGK8U0ZQC:22
 a=1CNFftbPRP8L7MoqJWF3:22 cc=ntf awl=host:12271
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDAxMSBTYWx0ZWRfX9rk3gN+tF1A7
 HF+u0qkACxwJNeP/kG5pGCJP4yOhgnjzk/eCD5ZcoRmAF2kbIT5FcOZZjUqm7rx5LCKbwJiBMK7
 QIumzR/nsUMZq2azoQqHTa1KYz1NrW4l+MAhckKXdV/IV3gQAdkGyBLNrRGMdCFqqXz/vYEF1Fb
 1jpoVV6o/D6e32AFzqfIbn4+M0j0CdKVbtadTyJIEF0WKLoiEmgPnsmAi6o82EnfD4h80EW7Qed
 8AesirCXIuF8KrxNosGcn6GqahyyBdimkiUCDthhSa4oQX7q66NVwSCe7XjlyP0TYc/uulMwD5l
 6yZkq/wGeppwhy1kCAaW2hd6qGAyxj0htYhd4Gkf/8eHw/uHmTq5ryYoUxTAOtVuMRF6s3bTUfi
 6pwNOXgYIj5budcchXKY//8kpBRvJYK65F0nmhUnkIdhg9HgHW/WDxbTJ+JJRZDkLQFKrL+wMMn
 As5jGzDBkmRVaT8dG7UT+GMPZxrvvodiD32ZSlmc=
X-Proofpoint-GUID: 4dPPKzuuu8-qp9lsCWEwCgJxTf1a5jzE
X-Proofpoint-ORIG-GUID: 4dPPKzuuu8-qp9lsCWEwCgJxTf1a5jzE

To handle WFET use __cmpwait_timeout() similarly to __cmpwait(). These
call out to the respective __cmpwait_case_timeout_##sz(),
__cmpwait_case_##sz() functions.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
Notes:
   - Switch to arch_counter_get_cntvct_stable() (via __delay_cycles())
     instead of using arch_timer_read_counter(). (Catalin Marinas)

 arch/arm64/include/asm/barrier.h |  8 +++--
 arch/arm64/include/asm/cmpxchg.h | 62 +++++++++++++++++++++++++-------
 2 files changed, 55 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
index 6190e178db51..fbd71cd4ef4e 100644
--- a/arch/arm64/include/asm/barrier.h
+++ b/arch/arm64/include/asm/barrier.h
@@ -224,8 +224,8 @@ do {									\
 extern bool arch_timer_evtstrm_available(void);
 
 /*
- * In the common case, cpu_poll_relax() sits waiting in __cmpwait_relaxed()
- * for the ptr value to change.
+ * In the common case, cpu_poll_relax() sits waiting in __cmpwait_relaxed()/
+ * __cmpwait_relaxed_timeout() for the ptr value to change.
  *
  * Since this period is reasonably long, choose SMP_TIMEOUT_POLL_COUNT
  * to be 1, so smp_cond_load_{relaxed,acquire}_timeout() does a
@@ -234,7 +234,9 @@ extern bool arch_timer_evtstrm_available(void);
 #define SMP_TIMEOUT_POLL_COUNT	1
 
 #define cpu_poll_relax(ptr, val, timeout_ns) do {			\
-	if (arch_timer_evtstrm_available())				\
+	if (alternative_has_cap_unlikely(ARM64_HAS_WFXT))		\
+		__cmpwait_relaxed_timeout(ptr, val, timeout_ns);	\
+	else if (arch_timer_evtstrm_available())			\
 		__cmpwait_relaxed(ptr, val);				\
 	else								\
 		cpu_relax();						\
diff --git a/arch/arm64/include/asm/cmpxchg.h b/arch/arm64/include/asm/cmpxchg.h
index 6cf3cd6873f5..9e4cdc9e41d1 100644
--- a/arch/arm64/include/asm/cmpxchg.h
+++ b/arch/arm64/include/asm/cmpxchg.h
@@ -12,6 +12,7 @@
 
 #include <asm/barrier.h>
 #include <asm/lse.h>
+#include <asm/delay-const.h>
 
 /*
  * We need separate acquire parameters for ll/sc and lse, since the full
@@ -212,7 +213,8 @@ __CMPXCHG_GEN(_mb)
 
 #define __CMPWAIT_CASE(w, sfx, sz)					\
 static inline void __cmpwait_case_##sz(volatile void *ptr,		\
-				       unsigned long val)		\
+				       unsigned long val,		\
+				       u64 __maybe_unused timeout_ns)	\
 {									\
 	unsigned long tmp;						\
 									\
@@ -235,20 +237,52 @@ __CMPWAIT_CASE( ,  , 64);
 
 #undef __CMPWAIT_CASE
 
-#define __CMPWAIT_GEN(sfx)						\
-static __always_inline void __cmpwait##sfx(volatile void *ptr,		\
-				  unsigned long val,			\
-				  int size)				\
+#define __CMPWAIT_TIMEOUT_CASE(w, sfx, sz)				\
+static inline void __cmpwait_case_timeout_##sz(volatile void *ptr,	\
+					       unsigned long val,	\
+					       u64 timeout_ns)		\
+{									\
+	unsigned long tmp;						\
+	u64 ecycles = __delay_cycles() +				\
+			NSECS_TO_CYCLES(timeout_ns);			\
+	asm volatile(							\
+	"	sevl\n"							\
+	"	wfe\n"							\
+	"	ldxr" #sfx "\t%" #w "[tmp], %[v]\n"			\
+	"	eor	%" #w "[tmp], %" #w "[tmp], %" #w "[val]\n"	\
+	"	cbnz	%" #w "[tmp], 2f\n"				\
+	"	msr s0_3_c1_c0_0, %[ecycles]\n"				\
+	"2:"								\
+	: [tmp] "=&r" (tmp), [v] "+Q" (*(u##sz *)ptr)			\
+	: [val] "r" (val), [ecycles] "r" (ecycles));			\
+}
+
+__CMPWAIT_TIMEOUT_CASE(w, b, 8);
+__CMPWAIT_TIMEOUT_CASE(w, h, 16);
+__CMPWAIT_TIMEOUT_CASE(w,  , 32);
+__CMPWAIT_TIMEOUT_CASE( ,  , 64);
+
+#undef __CMPWAIT_TIMEOUT_CASE
+
+#define __CMPWAIT_GEN(timeout, sfx)					\
+static __always_inline void __cmpwait##timeout##sfx(volatile void *ptr,	\
+						    unsigned long val,	\
+						    u64 timeout_ns,	\
+						    int size)		\
 {									\
 	switch (size) {							\
 	case 1:								\
-		return __cmpwait_case##sfx##_8(ptr, (u8)val);		\
+		return __cmpwait_case##timeout##sfx##_8(ptr, (u8)val,	\
+							timeout_ns);	\
 	case 2:								\
-		return __cmpwait_case##sfx##_16(ptr, (u16)val);		\
+		return __cmpwait_case##timeout##sfx##_16(ptr, (u16)val,	\
+							 timeout_ns);	\
 	case 4:								\
-		return __cmpwait_case##sfx##_32(ptr, val);		\
+		return __cmpwait_case##timeout##sfx##_32(ptr, val,	\
+							 timeout_ns);	\
 	case 8:								\
-		return __cmpwait_case##sfx##_64(ptr, val);		\
+		return __cmpwait_case##timeout##sfx##_64(ptr, val,	\
+							 timeout_ns);	\
 	default:							\
 		BUILD_BUG();						\
 	}								\
@@ -256,11 +290,15 @@ static __always_inline void __cmpwait##sfx(volatile void *ptr,		\
 	unreachable();							\
 }
 
-__CMPWAIT_GEN()
+__CMPWAIT_GEN(        , )
+__CMPWAIT_GEN(_timeout, )
 
 #undef __CMPWAIT_GEN
 
-#define __cmpwait_relaxed(ptr, val) \
-	__cmpwait((ptr), (unsigned long)(val), sizeof(*(ptr)))
+#define __cmpwait_relaxed_timeout(ptr, val, timeout_ns)			\
+	__cmpwait_timeout((ptr), (unsigned long)(val), timeout_ns, sizeof(*(ptr)))
+
+#define __cmpwait_relaxed(ptr, val)					\
+	__cmpwait((ptr), (unsigned long)(val), 0, sizeof(*(ptr)))
 
 #endif	/* __ASM_CMPXCHG_H */
-- 
2.31.1

