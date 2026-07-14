Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C45D125AA;
	Tue, 14 Jul 2026 07:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784014303; cv=fail; b=NLTQsAXvzn+/U4IBkn/pFnV5IMhRy+g20brCwYMLAtYtpb8R2oAwHBytlfSCQgGQo4h06yjRKT1EKwpDw2l/sof+BPFZS/jS7pmhkbl78VOjTAoKGVjkmDGeqeP64l+kAHju1taLtjjTGPLDt2M0ge/GEeSK8hMCuLJQoPg87IA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784014303; c=relaxed/simple;
	bh=ojN6rotIbIAfJKlO1MyqmeOi1zWc2jY+tGVwNQ7lr28=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IY2XnBRbVHg4ONeNe802Dgs9M5lndXPRaXXYZLDlZ5khaUc8LU1sqLMOcihLP118u0lQtkid8Devf/8AP5CfnlFRvDdrxGpdJuUkegQpdRxHo1y3NNxgn49ujX6qqPdZZE8q5JEhA5abYy/tu0iJnbmBs+LsMgcUBnRcwQYOWvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aQe3ugmH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OfkAPD7q; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aQe3ugmH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OfkAPD7q"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DLDpk41346058;
	Tue, 14 Jul 2026 07:31:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=S20dGHKKS4wRGthBkiO1JlrzyRBsuGiJ35trtoHHkDY=; b=
	aQe3ugmHeFJJ6aYn1a00TXQfUwgOlNAPhNhF3+AIivFHvAd9yN/+rUlpy5KzdQuW
	RHV+D9c9+ZVnXDng5ao6SZVW13T1BTDQxA4TUbP2GwhYoyBOVa58FSIBFcaTvjOE
	qVTVlmruDIQvCl66pqrucAttiF2hM2GInHz8z0o2jihG7ioZEKXlP8XXD73QJGQ9
	viBVWcu6wjw63P+eta5Uqo95nI5FDBKpX2beC3YVux0tRIwGBTsEsH1tBds2VpQ7
	WMjsOusuYvdZy1mIunt/tgim+GJhzIEbcx1WK2vVt1JTLTZS5WWqAdzcqQSK+v45
	BiztkWK2Uz41b8xIuEvLDQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fben1kmtk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jul 2026 07:31:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66E7SaAA028504;
	Tue, 14 Jul 2026 07:31:16 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010013.outbound.protection.outlook.com [52.101.46.13])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4fbc9r4gfn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jul 2026 07:31:16 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v7gCD+U1jeDRhL2DaWoK2vm0FxGakzw9ysm+a3oPMq7A/RZq4Mim7tgAsuek8cyOghevqKXfNyLSZ44ntAhYQl3Zn56a8Cl28KosgvPCer/VQapaudrBaYjooH6J06CYTSz7AZRCC3WdJFFHnlA3Q7LxBhlqycMoM/+kqHgpbGlnMIQSQxShOSy/EGOH5AiPl4n6wdoJn4SKPtX4Df5k4lNMGl2ZpyftPpc/w+ToOetX9UUV3+Dp5wNXVe7VuSTJhQNx2y5ff3BEZvSIQ2VPqtvzAYu+CzAhsRK54b8vApwVjy4C0FPMJMSQ+7uph1V4aSKguWB9kol0Y49mRYgVbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S20dGHKKS4wRGthBkiO1JlrzyRBsuGiJ35trtoHHkDY=;
 b=pCnNDgbKDPX+HSnhvq8MBfDAE+o0vy/zOJwFXfnFs4POqhr/R4UrBoFCskXdWadHa2J/GYxoglhgANBAjmOIHIyXr1Zsv3KjKlDwkIEXLxjaFsUj3l5QHdOnS2ebgCOHovfeWE2jaoKT1FlybuVvsyI/PF9gZnVVJVEoxhmB2RmApqw8TlTbyV4rmii3qbcXh7Xsh9MZN9xPWJcfaxlujDvzxp3QKL9tcI9H946ll22OoBBbGUIBG8PQakW22PyWh5KRjHUq7Y+O142JAkCyczSO7sE7DnsXCadmc3MuUlKY3vhzlR6/YIOdBTUNJoH++7riy36baaziBZIVfxi5jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S20dGHKKS4wRGthBkiO1JlrzyRBsuGiJ35trtoHHkDY=;
 b=OfkAPD7q6uOFZTmJnuk5J63cvhmJF+V5c76vPNQpuBFZRV+Cmt45wsMnAdFq0VsLXvIF19Kmq8qstLvNL0FGDJRjTmgOVYxr81SkabvNqLGpY+SXExj3Zd489SPrN6CbQBeMIKXAifTmVvzT4FS5Pk1lsBMybcKuB/5GUzamNEQ=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CY8PR10MB7124.namprd10.prod.outlook.com (2603:10b6:930:75::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 07:31:12 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.21.0202.018; Tue, 14 Jul 2026
 07:31:12 +0000
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
        Ankur Arora <ankur.a.arora@oracle.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH v14 08/15] locking/atomic: scripts: build atomic_long_cond_read_*_timeout()
Date: Tue, 14 Jul 2026 00:30:34 -0700
Message-Id: <20260714073041.40250-9-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260714073041.40250-1-ankur.a.arora@oracle.com>
References: <20260714073041.40250-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0458.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d6::11) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CY8PR10MB7124:EE_
X-MS-Office365-Filtering-Correlation-Id: deb1e932-d5ee-4715-c1fe-08dee179e175
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	uY5oAe2xewh8fkddASE7fRQPqvZ1bI6jMG85r7a1QNzKxxx+GNQCkhskrrIH0R/ZHoJbizqmE2uCmYFHVmKcmnHzh9t447NQmvw5+ERgXt002wN1rnHsSBRc/so5eku093l/uqhKIlmWRwRvORZHjDW7XltT+Bl41hqqv2VILsbQ25qZlIvpgUDYphGjIQgnKyFLc72E6j4gaI8LnJ+++iVjnOHNs0+JxvYX4cNlp6YsSz2+XXelSXHC/0dIEIxYbNEEpXnRIVGT4o8ZQLK/X/3dUTZ4qpWcjANedPa/0GvoM/riBUOpnoC4GNWOVQIvZjhAnsjMYK+WYs813QoD7NDxatM77w8Nv1QxhW4oQ1+kcrkGaDaxIDFHfTB8i3LXmjXqyMdwDHzTLtKTcesIIKveUKfeeCjGXPgmbqHkrmYM6EtPaMIj2/YSu7T8wplF1f0sSTABD6t9p4oBFkpOo4gKPVO9p98geaqNwV+GRAecF5EVsR0qftcFt1ZAYYaWHZ9kUNzwhPANcm3RFYK9hDYzh8FHf+MRAsfOjTcaOTDqMneZefC7OxUg0lFxy1noQTlk8RpjkD9uiRqSX4F4WpOHXFqn1atrutGXPV6QBVbTZkHToJV61EqMclCVQnQtcgAD3FTNYr3ellabStytgmJRv1w3yiTeTrgcKjtNzgI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NNF8xFfraqs9u2DOMVItnRCXIvye7h2dFiSOsxHu4lL9qkxgQpC8pHqhZaE6?=
 =?us-ascii?Q?ALcDCsMWp6l/mXNtY9A0tGLOMXokW/tWUGsKKwGF1hQu+rknPxAF1nAaaKAO?=
 =?us-ascii?Q?lTybM1X3AJJKKJPj6+EeXIpZk5B/wRgXswKHOyL+Rpww14Z2recp/t2lHV+i?=
 =?us-ascii?Q?u6rX8EvcqoIn6EGIgssfWwboUFsAXq7WM1FuGfhwGAleq0gZDzlU6yMriWiO?=
 =?us-ascii?Q?2wNt/tDOtjeowpP7xQHq4IWGjBpUnrQO2iFXL79AkEhdfC93RNSsCmUWctLs?=
 =?us-ascii?Q?x09sfmG1bogbWFqR/T/YRiOk+nfRmfAjnTIlaV/EWBP0M8vdwgudAviWfJoa?=
 =?us-ascii?Q?GsPp/kRstDql1IylMrH4s8cJwoXdh19Ut1KeCbQvogql7XUoSKD9+sVbO10d?=
 =?us-ascii?Q?bmRbqT0RDdKC/PCY4QCh5xy0q8M5nDeBQCzEnkDeTyk/OQjobZ90aAUnE+7g?=
 =?us-ascii?Q?yWk3uW7SBXikWoOBkCt0drywiehrbxQnF0jfGggmmmkRgCtNtsBl6JGqCj+q?=
 =?us-ascii?Q?TaN0XCFfC/Y6w7td308wrJmGMSABsTruREmNYw7rmc+yxhNZ/aG4DfIWIvet?=
 =?us-ascii?Q?5aaFNny0jC6IInPgf81lmVkTENhO9y9GZ2hryaOWlr7gTqMzeE8AjTL4SXTO?=
 =?us-ascii?Q?YyMCPtItByRD8FGya8PgsROv/JlcG3YQoNwyohyV791qldFCIKuHMtuixRJ4?=
 =?us-ascii?Q?Rkjrqpbz75mmHAeEJqqKtnTsgleOUoTpqruEpxt7SsJb9ymyNot8sLSZOTQr?=
 =?us-ascii?Q?sdw3EQTFAk5nhfvum38LcCL/kfbm73BFIS/OG5dUOForsPYLUCesCSdP51hg?=
 =?us-ascii?Q?hgmjxz2ty3AWNGzn2Z+MWj7r5NeE8x+Spd4kGWOqnKOdESolzD5qKQTW9Lk8?=
 =?us-ascii?Q?Emh4dxXyTks2/qiv9ur5wGQu+sTx43zdhwMZmUMFodvISPOcIqB7lI2UPl53?=
 =?us-ascii?Q?JNm61bDrV9nTGmyKnSPIw1NR6L5b5HAF1YFzXR1jIxvqnyNgGDR8it7h1dmt?=
 =?us-ascii?Q?8jQfHcZjzL+7TWuWYiQABhLRyz6MkbjiM3XjLOzq9hkzztdKFiNh0JZk3o0p?=
 =?us-ascii?Q?gj2klKqQlhPCuvAoGumXvyenbObekdYRQtNLTT+eqlrh7K97ZeeV2cM/NGKC?=
 =?us-ascii?Q?yr32dJBo0mVnoQc/PcAlD0dX7IyMQimKOMSnu5Xoc2NfD37uFgbKPcqPZUp4?=
 =?us-ascii?Q?Sz7c9BPZoYY0GgP2G5lHrSEJslqeLwYMtQAxjPjOU9VPxFS3WIF2qUaQ6OmR?=
 =?us-ascii?Q?YkcEEYYCLBnGRGSnnhuOHRN74RDl1pLHQGfgERllNxYAE2VrULmOa039JWQt?=
 =?us-ascii?Q?Dqr7YRZri4onzJGKVQd0XIdQMWdyj2hTJ8mR3KTLlHMHHjsRGce4FNZg1NKd?=
 =?us-ascii?Q?J+ri2fcYBdJB3wMwFnnLudXpbNWVZV7EW6l2oCUmiO2dchvw8YfQdF0nXtrO?=
 =?us-ascii?Q?TxuAu9v56lko72orkh5ClJJAzc8C3UQkUarzYadKIl0UMuxgxmGkBxkwm0LZ?=
 =?us-ascii?Q?t7+Gp6HpgbguZ6ckxIifZ+B0Ou9aZ0euOBVUiec9UkzGDoAk26gkwqP5VOrq?=
 =?us-ascii?Q?4Z6wY+FbMQIr/bWerml7GzbKl+xkobH9oLoLl6aTWTL8OXNEdyOKlgD+AZgO?=
 =?us-ascii?Q?LN3emB8TkxMg8WqK1mX1Y/B9SUEHiNpNeWcaX699NqlJeg2sVN8GWB5ajLc0?=
 =?us-ascii?Q?+rGXeIt35yPYNdLpX96X6YeFffbp1amo2CdJC+OPBbqfebtDun2YrPEvmpfC?=
 =?us-ascii?Q?vMAEaRA+Ww=3D=3D?=
X-Exchange-RoutingPolicyChecked:
	sBAdQ5z1hxcfwnq7Byr2V06P4e1JYhjIHRGUzLuiSLlY0rJbsJg47mczEoy7aeJ+r9b0uVr0CeupwBUcbyMgJ9wqvS7Ah+GyKkt6PeQiR4iAMmE/ucB0AaZ8mENNeUfbWH0HoMtUGToIOlkrNdqKg8SXn02AY7JXy1uN6UW4qplWCivGeJ4VYhtYIrYVwhS2e9Q0CjM+NsBvzvekuWIrLea65L0/b1ALI5Pp6/pn0bEV3Y76BWy5Rhog4nhtEG/NhckfojWmzAK55G7LP9dr91ko+a5clsGuQmMzNp4fElPSPzSvQTxVI7+6HjQYebngXkBjqxXD0USFXn3sqjBy7A==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	iyYujxI9iv/Ej9Xv8pG2xMlX+SE1MnOrxuGMS9CcfWETdpgcIINa4VPsrb21S5tdpyzn3+UBtH0E+u0AK4CerTPU6dchOqHVdlY6GFgRUE5GEtsXsLnlhKfScBXLZYFE/YVyjjnkexuTsgPvHF98S3bV7dc+iVo1NTABbIZaKJJNil1FFooysztX+7tByHvPsgunFLyh6oIXQ8mBkYcb+Osxf0fpw5VQA8O2d0khCm5/FLkYiZozQAVNEqQOx98lXSx8r85L5RW+706E5lzTAx+avZKNXGXKHJVEjrpS4OGkqI15DddCzkLFSCso/8rSr0q4ops6YL1SUcDidrkl9Jq4MYo2GDV41e3CrgQMjJW6PjAVfj+Qmq3YJG5urVzZXlC7WkBVm8NI4TJ4NQMWBS7t8oHGCUMcnsMUXz8RG/4ZGKPXr6uTo5U/FwbZJnSFFiBouV69fr5Lk7E9FbJyRVx8F0gKRDlcSyuZeJucPp7i7UUQPjxo0SoY+iw0Aub8KP8cx2tDiLoxxEtxI1TOqh0ku9gkYE+FY3eCBPu4sr65D/H3b/p8OUY2yjdwC91GFMZhGEhi6t0Z8UotZU0uiZPY/kIaoKswMahaQubirFo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: deb1e932-d5ee-4715-c1fe-08dee179e175
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 07:31:12.4215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GZN0VJiRfgdL1SJAOwLybnmdrYWSzpIaSPfsbepscdMb6QbIKi2aWbBJiKPNiJ8U2y0S75ZWuQA8BOwZ1PKT+gzfwBt8LatdUIpxCuLw31A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7124
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 spamscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2607140076
X-Authority-Analysis: v=2.4 cv=d5nFDxjE c=1 sm=1 tr=0 ts=6a55e5c5 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=pGLkceISAAAA:8
 a=7CQSdrXTAAAA:8 a=yPCof4ZbAAAA:8 a=LKnZA62imwlViN-40TMA:9
 a=1CNFftbPRP8L7MoqJWF3:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12222
X-Proofpoint-GUID: mKzfPJLO6Vho2vBqpg7GvgsVQL9yF8WP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDA3NiBTYWx0ZWRfX6AVwxhsBs77A
 7aEeTDgnWKrfh8HIfcAKMTXuALcb/WgvSYOiHIL/ZMbteLlwAP+Z+5Y7SqffWYj22IdRjaqMg0k
 eTeBRuugXBRIStZtvpTeiOtE8oJbYf3oYly9fW2cOCCi0EyQFQIFYNawc9EqfUR1Lx/z5Px0NNe
 Iys/yJg/uxOCVo1jvgpuOg6XAg0GZYGdqj6ZaJOQJZxxjVkRiy+DlHIa7nweBmJ1S8vxlQYIj+o
 1ZUX9YNaLtI0TNAwWHa1QnNZRRH+E/VT7cQS8QFtpu/1DL30pBAYZ5KZxD+eXbAI6HLp0WInq3h
 ckvLM1cFTtbJCBl5M6uYIguXTk7c1L/HHLQLw11RTB88CojwA0c+VU9xQpSYdJ9byuucmmNF0WY
 XSp5QhqN8M8skxE1zchjVQx7JHX9bg09WOz71J3tPZpCL6ofKa7fvqEEKAqGp+rXLMcEOIGEjzL
 wsJJX3Q+/5hHtW4s8/BfPrUEfCkrT3g5jvynxLaU=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDA3NiBTYWx0ZWRfX7llOlKkmvhe9
 X+a7e57kg9u5+1UvCemADdrvynQhuJ7oWDflQJKtCAJsE6FeKrdf8m2WCmjTNeHkLLVTYVOw8sR
 wUK5CkNL7tVkyqB7Oxb77Z7mPlIhsoST8q2WTY1MkLsMdSzZRSh0
X-Proofpoint-ORIG-GUID: mKzfPJLO6Vho2vBqpg7GvgsVQL9yF8WP

Add the atomic long wrappers for the cond-load timeout interfaces.

Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 include/linux/atomic/atomic-long.h | 18 +++++++++++-------
 scripts/atomic/gen-atomic-long.sh  | 16 ++++++++++------
 2 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/include/linux/atomic/atomic-long.h b/include/linux/atomic/atomic-long.h
index 6a4e47d2db35..553b6b0e0258 100644
--- a/include/linux/atomic/atomic-long.h
+++ b/include/linux/atomic/atomic-long.h
@@ -11,14 +11,18 @@
 
 #ifdef CONFIG_64BIT
 typedef atomic64_t atomic_long_t;
-#define ATOMIC_LONG_INIT(i)		ATOMIC64_INIT(i)
-#define atomic_long_cond_read_acquire	atomic64_cond_read_acquire
-#define atomic_long_cond_read_relaxed	atomic64_cond_read_relaxed
+#define ATOMIC_LONG_INIT(i)			ATOMIC64_INIT(i)
+#define atomic_long_cond_read_acquire		atomic64_cond_read_acquire
+#define atomic_long_cond_read_relaxed		atomic64_cond_read_relaxed
+#define atomic_long_cond_read_acquire_timeout	atomic64_cond_read_acquire_timeout
+#define atomic_long_cond_read_relaxed_timeout	atomic64_cond_read_relaxed_timeout
 #else
 typedef atomic_t atomic_long_t;
-#define ATOMIC_LONG_INIT(i)		ATOMIC_INIT(i)
-#define atomic_long_cond_read_acquire	atomic_cond_read_acquire
-#define atomic_long_cond_read_relaxed	atomic_cond_read_relaxed
+#define ATOMIC_LONG_INIT(i)			ATOMIC_INIT(i)
+#define atomic_long_cond_read_acquire		atomic_cond_read_acquire
+#define atomic_long_cond_read_relaxed		atomic_cond_read_relaxed
+#define atomic_long_cond_read_acquire_timeout	atomic_cond_read_acquire_timeout
+#define atomic_long_cond_read_relaxed_timeout	atomic_cond_read_relaxed_timeout
 #endif
 
 /**
@@ -1809,4 +1813,4 @@ raw_atomic_long_dec_if_positive(atomic_long_t *v)
 }
 
 #endif /* _LINUX_ATOMIC_LONG_H */
-// 4b882bf19018602c10816c52f8b4ae280adc887b
+// 79c1f4acb5774376ceed559843d5d9ed1348df99
diff --git a/scripts/atomic/gen-atomic-long.sh b/scripts/atomic/gen-atomic-long.sh
index 9826be3ba986..874643dc74bd 100755
--- a/scripts/atomic/gen-atomic-long.sh
+++ b/scripts/atomic/gen-atomic-long.sh
@@ -79,14 +79,18 @@ cat << EOF
 
 #ifdef CONFIG_64BIT
 typedef atomic64_t atomic_long_t;
-#define ATOMIC_LONG_INIT(i)		ATOMIC64_INIT(i)
-#define atomic_long_cond_read_acquire	atomic64_cond_read_acquire
-#define atomic_long_cond_read_relaxed	atomic64_cond_read_relaxed
+#define ATOMIC_LONG_INIT(i)			ATOMIC64_INIT(i)
+#define atomic_long_cond_read_acquire		atomic64_cond_read_acquire
+#define atomic_long_cond_read_relaxed		atomic64_cond_read_relaxed
+#define atomic_long_cond_read_acquire_timeout	atomic64_cond_read_acquire_timeout
+#define atomic_long_cond_read_relaxed_timeout	atomic64_cond_read_relaxed_timeout
 #else
 typedef atomic_t atomic_long_t;
-#define ATOMIC_LONG_INIT(i)		ATOMIC_INIT(i)
-#define atomic_long_cond_read_acquire	atomic_cond_read_acquire
-#define atomic_long_cond_read_relaxed	atomic_cond_read_relaxed
+#define ATOMIC_LONG_INIT(i)			ATOMIC_INIT(i)
+#define atomic_long_cond_read_acquire		atomic_cond_read_acquire
+#define atomic_long_cond_read_relaxed		atomic_cond_read_relaxed
+#define atomic_long_cond_read_acquire_timeout	atomic_cond_read_acquire_timeout
+#define atomic_long_cond_read_relaxed_timeout	atomic_cond_read_relaxed_timeout
 #endif
 
 EOF
-- 
2.43.7

