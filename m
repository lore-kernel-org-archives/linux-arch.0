Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209023AE718;
	Mon,  8 Jun 2026 08:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780905960; cv=fail; b=l0TWXXEguWH1XJA3ULL0gnfPloKFRAMm776EF2hx/DC8axj5WxApOhxiiIBhq7UuC0NmDEGGTyCd7UJ/Oevm2r68PkCmqiR9GCL3Dii7iH0bNAW4IO/ARKl2CE92+WZekVxvErlISjo8dRCfW/A44fdXLKf1f4keH4HYs4S5alU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780905960; c=relaxed/simple;
	bh=MYshbieWQnP0tYWq2yV2v8uPqi0VCMZk3YuYFERR/pA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pIoaDFvPsWb94zBMOZ9rPpRrYJsc382YcsOluFwXw3VlBZYIJ92F6zB2uhZ+pE/2ChQrINHP0m9QMGO9PAT/iFEBMpyRTuBE121k1dZ2FBuOCYTtnnMiQV/lj+z0fHlh0Qnxl3DLddGpqghiKJar8a8Kzur9eAcJCiRxJAP8vUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ViSbNSOJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=e8ZHYfM0; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ViSbNSOJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="e8ZHYfM0"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6580r9iY2285698;
	Mon, 8 Jun 2026 08:05:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=NxiYtykFdSzVQMiGjeYMTLioAPuSw5F2JzJBDcdDhRE=; b=
	ViSbNSOJ5RyK7vlsI1tMcn2FJ+8DwUXVaid6xs1gUX+0GU2ASXfilSUEhV/QriT+
	L+yo4dENQx4Hq/zShNdPW6mx2sm/uixnsnDhHwFsqWXzthiHlchr436spABRVVDI
	yGvUZi8PulODa6Cz+AGLSPxPSVL9woMOEtzc0bHxh0tZ2VuRJnQEfYOEPQc0erUs
	5zsZ0UekMf1JIXhydlPUZNu6KuHm4BRJxjtWSdDd+i4ZaSJNV2Cy+4Wo6kb9LnLL
	/c/TPcbQb4oPdKCK02QtoBg/FOG7xbuV1k/XrKLchYAm1sfmMTG7xPJbpAMkfISG
	oflrUtPj/LNZm8A2q84sCQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4embkja0ss-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jun 2026 08:05:13 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 6587w6CZ036652;
	Mon, 8 Jun 2026 08:05:11 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011031.outbound.protection.outlook.com [40.93.194.31])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ema0d8a4n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jun 2026 08:05:11 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GwczVF6yNA/td2+dwsdtm7RsSozgI3uV1KTH/278hReDmm9Y3E28n+oQS7CBwlviACT97HdJWmqxUuqyRIrZdRiG/Re0kuosSR2NPd844xBsuQRvErA5mw0fgYddJCxA1z/mvyW1a4cD8Pgx4SRRBdPEEQkhO28PukTq9oDJ6nXp2JDaCtB1btevv913rHWm3q4Td7Mi/inLwSjbYvu3732Vk8Qb7XaoiOVDo8fBuQbsHH4MMmpEiDxeZRFhd4xltWC8EosLWNZ+NZpFyT+hqvH8vi7m78AQaA7DvubwgEHBsjb3vX7VzHanZ8w4K51u7lWD19GPrezNtENrZwQfcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NxiYtykFdSzVQMiGjeYMTLioAPuSw5F2JzJBDcdDhRE=;
 b=FdwDjbuyXW2Negr/L9RQHM7IPUOEKHZ2ep+Q84Tmj+odl6WaaDRSoJ6nr6WWrDTbz1Wk1FWM/gB2sNOjFen2aZYQz1Nz9/zYf/54m+yWOO5y+8I2DyWhNQuzOD/Ze9a/C5JAVqpo0pNoDXtfTS6/BSn9vd48/Oi5zMsJMxB1NzGBUHBOqIDFq24cul/rxPwPR+fDC8lkbF9w9Q2ZiVrvi4/JbeIOClp3ymtLOyARHIrGIeAFDAaupt94jLtJEpjrWsLpqRmYr55qf53lBgofEBAkaNdE67/W5H0mIvc8v9gZqUmYSWt/9DZ3AeiIgVQXrqdI9jscUUlkFnMSAPIzdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NxiYtykFdSzVQMiGjeYMTLioAPuSw5F2JzJBDcdDhRE=;
 b=e8ZHYfM0XoNH1nFhuQrAodAkXOtuFqZ1AZABFz06f1ECa1BjRaivscAQSOG6SjnsskstE+UGSMLoIx6kLBoORAO59svMkxFj24zLTcN8V5mbh3XaRu1q9fGbzEILQuWk/cenNvxy7ohihcyeEKGruE956dOESpkvGr3BVdStWzM=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SA6PR10MB8133.namprd10.prod.outlook.com (2603:10b6:806:436::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Mon, 8 Jun 2026
 08:05:07 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 08:05:07 +0000
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
Subject: [PATCH v12 09/15] bpf/rqspinlock: switch check_timeout() to a clock interface
Date: Mon,  8 Jun 2026 01:04:34 -0700
Message-Id: <20260608080440.127491-10-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260608080440.127491-1-ankur.a.arora@oracle.com>
References: <20260608080440.127491-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0381.namprd04.prod.outlook.com
 (2603:10b6:303:81::26) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SA6PR10MB8133:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e4af27e-93b9-4ee3-0732-08dec534a7b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|6133799003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	DYWKhnzgE132QrzmWKeOdxfK32nO/OY+3Ipfux7CPDJ6+aCuKZluXBQK2rgMQXRq3smtbC5tPQLz4HknSInNSvAs7RJ7YhMNAHQdpWRjHyc+g8JtGEncU63PBU5AMKaER+Hbbee/tHpRveSUcY1nZUV3Oj8d2EMLzeYxXYmX7sA45MiOYr6xFMDFnrhnYfp4w33AgTxORAleKgMyTmUJUCbbGrzcDiK/uEcPwxeZRREXTWRjLlOiAUHvGfdHcvNC+O7pj9rvT2EoOlO2RtBt307dQEu2Pdmm7c195CJFHBAHTUNyelY/KZrUEZI2g1zEOwnjuSGn+liuzEq5RhcN0RDsLHgvFY/MKfQDHFKWRk92UNHkl6/P+gnUqIUTt5C3eAWTcz3x4MVrzdu4dv1GM9yOAeuiKGqJa4W/Txa9+lKnhDyvyjgTya0t4ztpRnePP0pFIGPqwGdUMx/KgbG8hsAYULxlocNsn4OBz099gEBfWtn12JH1hiO0cm6BjOPndjORsRtU0bQlFEQUhMawh9rNgdtVLJHd881yoRBcdTbf5ChqXjQ8UsbNSMu9jaQLAHEGh2R2VnVjK10wuQiKOIX3iLpDv/M3ZpLYm0aM9jwlhr78GIt86D6hD0zJCHT1N0wFGtKczb+I9APH0JsRBJ7y9fmV6O8RUhCUiIFTapo5vVM/Fn3mwo2U7X8lu65c
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(6133799003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SeXlc4wcPSJKacIA0LNTZeWilZ1Xv32ATb99eJl6immcKS/lLcPtXiF8IU22?=
 =?us-ascii?Q?wujfQO0ziZ56lNhotw4xDRi+Zi0pPHG5R7xLwWuvZMIc5LRu7fIpcwwOwjBh?=
 =?us-ascii?Q?we6c/MmQp+QmhZeNQhfZLuMiJKS0FyVsdo+5pbJbmCF8+4HZgRKMkym4rJSJ?=
 =?us-ascii?Q?3vHFY3K/yyYudByY0GR7aG4cBi0ievNkWCirEr23MQbY/y/bmtwy5JS3QoRw?=
 =?us-ascii?Q?Kb+KbY2OV0iO9qQulNSlQ5SpW/NYvSzuFcqC1Uw32hrFlDX/J5g5KJBeCOj/?=
 =?us-ascii?Q?QRrAeOUHl6GapDmm1sjLVHB6CVIdp76by6zsLwBaU/12oboPmiY1vqafaEJh?=
 =?us-ascii?Q?mtd5pgiC8sDJSypSZf0yMXM7vI61enCDfp7WiRak/bkgQckfgYuobsLzg3Uv?=
 =?us-ascii?Q?GMptPof9NawE8m8PmPoLgCJOpSXWXgWed1gAHPNnXGyik3RDF3pEDBih2TYP?=
 =?us-ascii?Q?m9VvU4/pD+Lh8TlKN94bAW4hDuTsrWgJ5WSq1RdM9ylH1ysT0nwJwySD5dmH?=
 =?us-ascii?Q?CZuBSqZbEaF1m8fnK2Q0gy3t8M0s5PbisMcddSbOjD6ftUnW55k9rUVQJyo6?=
 =?us-ascii?Q?6ryn2xaLLULn8DqV+P7PEnr+ifHJB+SlogeZO+ss+mhYPNEyX99q6LvTv5a6?=
 =?us-ascii?Q?EXpoqFq01xdV5qBirx1ujpnMb0zsy046lciJ++KaWGlVRxfUbwBYGJdvI0pr?=
 =?us-ascii?Q?I/ZNhH7KInhwHEUslQohHALKpza18qT5MV0K7PiC8vIrlKG5SoV82PJmS/tu?=
 =?us-ascii?Q?GEQWs/drV43uIV7UulW27sxTfpKyZgfFuhMqkek8Q1n5X4hUZVbfuNhCtd+i?=
 =?us-ascii?Q?CcGID5DKJxSgCztaTd8pLsl95DH/eahuDcxlx/kaEZrmSvcyVceTtK7BFZx1?=
 =?us-ascii?Q?WjX+lh5t1GaTlySuIWgPQYGdeofzn9y4Z75YbCXrngDLQ87hwRX7gjXWRmSc?=
 =?us-ascii?Q?yfInFSFcFtsIQ3xbgFIWGkWypdzHK41oH7n0uCg3/YeaqbMzpBlRFsydj8pY?=
 =?us-ascii?Q?YYRgf4D/aLFs+wlzxH43L6+noKwnVgLQYtqs1ri/5qHZhCw1ZZHZNE2l/3tv?=
 =?us-ascii?Q?S/KmeYy43IEBBXrXuvnm06hpCIW3Owd82k1+HszhgBGT1kjP9pOzaTE2uh8U?=
 =?us-ascii?Q?r+5VxAnU5NcY7nn3lAgYupCdVUWnRVtKCylRa6NcxjtiGy7J74qWqUJW6KLY?=
 =?us-ascii?Q?+AbjWqZU548Fy4h5NNSo6EPYDKbVjW2qkIPahdp/GR64cdME0M0F2ns2prgI?=
 =?us-ascii?Q?DCUDwiCFSbHSLw3CDX6lV0pvxFq3Yj5mZQVTyKIfmmHnKY8CxUYZxDYESeW9?=
 =?us-ascii?Q?KnXb42iBLPi5HNjkALqFals1i7KS3KiaYIjhcKs3SCLFeI79qTHJ+QxpI0Q4?=
 =?us-ascii?Q?DGzolcTijHXo4BrgboCRR5bEoB0GIFwajJ+DIl0IkrA/OuInN/itXO4zHKZG?=
 =?us-ascii?Q?AZsS+sD+XDX4HmP0Awydr7zOvU30syCbYGEGVSE38DDL4N2YcrcUwH1KZaFt?=
 =?us-ascii?Q?KjwwpVjiRKDnbmFvMfaHvXjAU37rBs2NE8MTXkmdQ0eOKP/DTItanqIyZ6Rm?=
 =?us-ascii?Q?diJfzaGAFGDD9o02kxgrdyBrpooRY6MMuzmxWuOrGdcBiPexbeL8HebK6RW4?=
 =?us-ascii?Q?qffNNejpdSoUToVGAU5VYvKm21JKYqEk/yvF+ivtNekX2rxlRTcAC/uYaRGM?=
 =?us-ascii?Q?On9TBfIlmrH//NkSVz8+Os7KkJirFVwooZ3SgrBBhMpzE2umcaAy7B0ig//7?=
 =?us-ascii?Q?3Qx+Cibe9g=3D=3D?=
X-Exchange-RoutingPolicyChecked:
	YXK24g4WF9NnsZpcQnqN/HkuO5mzHei+M0tl0rTVOgI3vhUJKE8jP7rSOvGvWp0jA3/VfhXlhjZh5YiERXDu0J1a8hd6OVAy3S1tAdhcjJ482D9COvmwfHWEidek2HgHwKUpaEwe3F2iZSmbKXzPGoqNDeX9JzEh55s3+zVCAeNNVVVMPW6hEn52J7JEIiA9JJ+JalPFzKgBYZaz0X1ahgpXBDtg/o7zP1lc/lTrXbE3RCVQF1wUgGOEMH9XJUlybEDC9KKsc7DFewsyaAh795uoU+CEUVPLb+2+bu53ZOVZvMk9SZI9UIqpI75GmoRLF+qQuVgwk1S5doX8bOjtaA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	z0H2nAa5zdQa3z9jytx4WyRlK1GSIQEJPtTxE3wxbWXH1U4f3aBgrRB1JFw+BWu+dgYZTNrm708zL4O0GF7xBz1xYBS/JuzlOHdIZwkd5KMlJQgVnOI5NkGkLc6l81mdVJtAC3+s/HwxipIdSMC+CgbjbUciQMbHAdrTIVdW09WLjM0M3lpvKP4xFGqlHoDpVOJSJBoJIMyHyCjPRH5g0QwwuUvZJ2UoEPQ03WxpqRZnXfSfyJQbi41AjNi1T34T0HgBH2dGkpCrk2Jv9vKbS3jWVG4vQifxeJba9lG6EbKmb0glZ2FKzfGn3wLGINvDKVn8gre06KCd89MEAlENX5luPleZHNzkE9NlVNQLtww/uKxNeEttxO3p2qZajwwTEZr/UR1fm4ctQBCDaIID76X4p3H3dlxM7NcNw6Tnw9y35kSVV17b2VHMAZEpnb468eH6KcOZGiMtefGz9Xa70l8Fvsnv04iWO0FpXvX3OSvHtxSFZTGQ/iegeVC/xB9mhSEXPUuCUhhXSz3m3YbL8vxPZwfPKvSXwUp+VyjVlyQXfbym9YJVffBC3VwWJ7kSY/HVGrtHuwyi8JRHRgtXdZZJ6aaJnpAHialRXbRTglU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e4af27e-93b9-4ee3-0732-08dec534a7b0
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 08:05:07.6919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wnrmeACqgOBnFlg2bQgVhHCrkkvqJJFhdI635EVAvFhQ2+lstWGj72alEbe7KDIpf5YBQZR0cou2ZHdkqD5AkN9gX2DkT35Cc6R+NMcR2yE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8133
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 malwarescore=0
 mlxscore=0 phishscore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2605130000 definitions=main-2606080073
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA3NCBTYWx0ZWRfX6y5NdNgFfkY6
 vq2bOnxVDyH104R6nM0iKhb7/4BEL3oyirlk3csO4ZFWQk5VP2sHh+3CSwe8XlMPL4q1nL1olUU
 dZdxD2Hz6EzkM3Tgad8xvjpubQ4rihw8sODFDYfDb52eJjYjmhWmHB5YmsjJ0wNo/TD53DH9BTf
 xx5OM04iW/inNnPVNCtTmPF4onYfWcpHIURV5FwwLCT69PGhtmoShzS3hJ1eqkZ05kLNd+vU4Rm
 tADlkv++Be/4cJTi7U7Nrg93nNeIreZFpDp6kwObgo3ZhBFOvKgao9pcITPXxNnWQDt6iqT5Uqn
 Js5hngSWqbvbCz1oSu694LmWRbX2xcrqpwpnSfZxBTLSogSO4QtGfpJ3XbA3983gnONR9fRN2NY
 h1wh6B5wg/J8cv+cptkCeHLTDCCs0TSt3/2kfNnABapRY8BACcaVnfBk3M06VjYs0ZyLnp/x0io
 u/sosQQJbp/K4qNXGcA==
X-Authority-Analysis: v=2.4 cv=ROSD2Yi+ c=1 sm=1 tr=0 ts=6a2677b9 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=FelO9ux0wxsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8
 a=LqkqbBbWekfmbT-3qckA:9
X-Proofpoint-GUID: MycJBKV74Xi6yi50QKvkbowtM8Pn29yP
X-Proofpoint-ORIG-GUID: MycJBKV74Xi6yi50QKvkbowtM8Pn29yP

check_timeout() gets the current time value and depending on how
much time has passed, checks for deadlock or times out, returning 0
or -errno on deadlock or timeout.

Switch this out to a clock style interface, where it functions as a
clock in the "lock-domain", returning the current time until a
deadlock or timeout occurs. Once a deadlock or timeout has occurred,
it stops functioning as a clock and returns error.

Also adjust the RES_CHECK_TIMEOUT macro to discard the clock value
when updating the explicit return status.

Cc: bpf@vger.kernel.org
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 kernel/bpf/rqspinlock.c | 45 +++++++++++++++++++++++++++--------------
 1 file changed, 30 insertions(+), 15 deletions(-)

diff --git a/kernel/bpf/rqspinlock.c b/kernel/bpf/rqspinlock.c
index e4e338cdb437..0ec17ebb67c1 100644
--- a/kernel/bpf/rqspinlock.c
+++ b/kernel/bpf/rqspinlock.c
@@ -196,8 +196,12 @@ static noinline int check_deadlock_ABBA(rqspinlock_t *lock, u32 mask)
 	return 0;
 }
 
-static noinline int check_timeout(rqspinlock_t *lock, u32 mask,
-				  struct rqspinlock_timeout *ts)
+/*
+ * Returns current monotonic time in ns on success or, negative errno
+ * value on failure due to timeout expiration or detection of deadlock.
+ */
+static noinline s64 clock_deadlock(rqspinlock_t *lock, u32 mask,
+				   struct rqspinlock_timeout *ts)
 {
 	u64 prev = ts->cur;
 	u64 time;
@@ -207,7 +211,7 @@ static noinline int check_timeout(rqspinlock_t *lock, u32 mask,
 			return -EDEADLK;
 		ts->cur = ktime_get_mono_fast_ns();
 		ts->timeout_end = ts->cur + ts->duration;
-		return 0;
+		return (s64)ts->cur;
 	}
 
 	time = ktime_get_mono_fast_ns();
@@ -219,11 +223,15 @@ static noinline int check_timeout(rqspinlock_t *lock, u32 mask,
 	 * checks.
 	 */
 	if (prev + NSEC_PER_MSEC < time) {
+		int ret;
 		ts->cur = time;
-		return check_deadlock_ABBA(lock, mask);
+		ret = check_deadlock_ABBA(lock, mask);
+		if (ret)
+			return ret;
+
 	}
 
-	return 0;
+	return (s64)time;
 }
 
 /*
@@ -231,15 +239,22 @@ static noinline int check_timeout(rqspinlock_t *lock, u32 mask,
  * as the macro does internal amortization for us.
  */
 #ifndef res_smp_cond_load_acquire
-#define RES_CHECK_TIMEOUT(ts, ret, mask)                              \
-	({                                                            \
-		if (!(ts).spin++)                                     \
-			(ret) = check_timeout((lock), (mask), &(ts)); \
-		(ret);                                                \
+#define RES_CHECK_TIMEOUT(ts, ret, mask)					\
+	({									\
+		s64 __timeval_err = 0;						\
+		if (!(ts).spin++)						\
+			__timeval_err = clock_deadlock((lock), (mask), &(ts));	\
+		(ret) = __timeval_err < 0 ? __timeval_err : 0;			\
+		__timeval_err;							\
 	})
 #else
-#define RES_CHECK_TIMEOUT(ts, ret, mask)			      \
-	({ (ret) = check_timeout((lock), (mask), &(ts)); })
+#define RES_CHECK_TIMEOUT(ts, ret, mask)					\
+	({									\
+		s64 __timeval_err;						\
+		__timeval_err = clock_deadlock((lock), (mask), &(ts));		\
+		(ret) = __timeval_err < 0 ? __timeval_err : 0;			\
+		__timeval_err;							\
+	})
 #endif
 
 /*
@@ -281,7 +296,7 @@ int __lockfunc resilient_tas_spin_lock(rqspinlock_t *lock)
 	val = atomic_read(&lock->val);
 
 	if (val || !atomic_try_cmpxchg(&lock->val, &val, 1)) {
-		if (RES_CHECK_TIMEOUT(ts, ret, ~0u))
+		if (RES_CHECK_TIMEOUT(ts, ret, ~0u) < 0)
 			goto out;
 		cpu_relax();
 		goto retry;
@@ -406,7 +421,7 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 	 */
 	if (val & _Q_LOCKED_MASK) {
 		RES_RESET_TIMEOUT(ts, RES_DEF_TIMEOUT);
-		res_smp_cond_load_acquire(&lock->locked, !VAL || RES_CHECK_TIMEOUT(ts, ret, _Q_LOCKED_MASK));
+		res_smp_cond_load_acquire(&lock->locked, !VAL || RES_CHECK_TIMEOUT(ts, ret, _Q_LOCKED_MASK) < 0);
 	}
 
 	if (ret) {
@@ -568,7 +583,7 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 	 */
 	RES_RESET_TIMEOUT(ts, RES_DEF_TIMEOUT * 2);
 	val = res_atomic_cond_read_acquire(&lock->val, !(VAL & _Q_LOCKED_PENDING_MASK) ||
-					   RES_CHECK_TIMEOUT(ts, ret, _Q_LOCKED_PENDING_MASK));
+					   RES_CHECK_TIMEOUT(ts, ret, _Q_LOCKED_PENDING_MASK) < 0);
 
 	/* Disable queue destruction when we detect deadlocks. */
 	if (ret == -EDEADLK) {
-- 
2.31.1

