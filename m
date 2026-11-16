Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.165.32
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794817528;
	b=BLic54adm+C+TlfOeTRrLY7sbSEhBMVQlgpJRD3gWKTK2BPfVgNDOSw8M551dZDRZwci
	 Nn5cb2vB9RKsePSOt3/ZpjhQqbYR6gWVRZO2VeI5JvpfaLJVJJfc1yFiEKtZfP2lzbf3x
	 IblSlnRdNWpktyfns0w0ZbqNoGylg2K7r77izOF+gsjkwof7r1tSr2+j45pWul1ODRNQ2
	 EUshUkgtTO/GO7L6RaOzcDuBUH3RePG/KVhoW4ymUJqk9GTxCctdspI3NPFKvP1NJ6aPg
	 uieFvoB7nF6KhD7MwZpsvhO0KL9fwZa4JruaIb82s8xc3jqgj3vvjSbpiEE84eyhSaA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794817528;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info;
	bh=FFUufafLgbdtn6+6RYF6DhZaLathwRv3aY2o0IAW3hQ=;
	b=erhhHvUYRbHenE9n46Ok5AOW2B3bv1PX8j0GVSWlTlVYwwcSrcLCl9qRzppg7gMG9cD9
	 NO1eZqSISzIbMXlJJmAjIbHbwcLyqsVukpP1k+EP+4880v8EPHFMt9aIv7EbDudDjeK00
	 P2M2qjeqg8E8ZUk3HDanMQRQ36TtBa5N9j9zxbkvaQhXtjOG4A3/kL5PIhzj5F3xBCV0b
	 P0U96+djPdrE4nIbRSNkQOZbCHFkOLFhbxxXwnUgHF7gCvfZN7z48tYWZnQeo615uwKEx
	 xif0Oe07IuZk3wbWpQ23Z6aNq/ihIOPltSSSrMK7R2RnnI5X6YdOA6XyA+NHAYFqU5Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oracle.com;
	spf=pass smtp.mailfrom=oracle.com;
	dkim=pass header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=RgRdBwZs;
	dkim=pass header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=Jnnwt0xE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.165.32
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6EE606A33B;
	Mon, 16 Nov 2026 08:25:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC6EE606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=RgRdBwZs;
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=Jnnwt0xE
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AFNdGAF1817008;
	Mon, 16 Nov 2026 08:25:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=FFUufafLgbdtn6+6RYF6DhZaLathwRv3aY2o0IAW3hQ=; b=
	RgRdBwZsX/otoRWDbNxcpgvABDLAIyYvJDEWLnxrwtRf24SkEREJS9o3lbpe8o4+
	PCUIU/eHPGqelzf6/rlrlJsH2fOIy043TOxlnX1Qky+j+mKox4V3neYwdcl2JCvc
	TvUcVQMsS2NAeoQJ1k+ODt4L7v0nwYmTwjzeD5ORVmxXatfMKb+JdMbdPDDMYx5Q
	rOzhHg8Etf/HFFH6MKYAWn0Egaq7vBWpRbgtvAGA8a/WutCETySyLzC0lRgc9bb3
	M3296zp4pp3k6C1pLBlEkxPKt5Z7cx5XHjod2pw8z1hd2nA2+hTl0Wk9JOJHicYz
	0K51viegZ5RcL+CkIuJ9HA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4hxfh9hksx-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Mon, 16 Nov 2026 08:25:05 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.11/8.18.1.11) with ESMTP id 6AG7cKZq925543;
	Mon, 16 Nov 2026 08:25:04 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011038.outbound.protection.outlook.com [40.107.208.38])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4hyvc0c0y0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL);
	Mon, 16 Nov 2026 08:25:04 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gOlzbyUkOllhpvf40W9hghEzkrO6Qaq+U+bNl2wFTPPR1ZuwSKwxWpLD1uyZI0YwV1yuJD1eeFhG0pa337haaIRnP5CEWORQ9ZW3HNRrV8Ir3UC4tElqSYPOYtJXKB+67jke8PPVt2HcueFMnZMJWjLWgktKKsHG1WhpQQy0SnVKzrO51BV+z5LxdqXdV5Xco+gXeW/iEv5jS0BB33zCXbfi78gQTapD7PVpPg029LDmYIz78fYbl3rCatn8xdt9zC65decQsWDMLVOZKONrjOTe1IcplKowPtkhh6J7ZYXau9XgOnYbknW2GInvCYqX5EqA69cM1ILzhWoS4sEfuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FFUufafLgbdtn6+6RYF6DhZaLathwRv3aY2o0IAW3hQ=;
 b=lK5cTXeBw5pCVLf6TFuUqe88aScvUtzELs79GfdWhCTXK6Fe3mKAysnYqVGFJIu22tEBFYiqUKYEwnc89rN7NNldMbqdlXNAgzJ6/kT1+bMdFgPuNzfHCUOEktxfLA/m2+XcYtiwv7D3/DQP39gAHqUmYkkLSV7U48pGgckKFWPE3SxzYXSOJi5pn2cXpP2ba6RCfzZO7QTuXHpfQ9zQzFckyryTqq2ckYc9PbhJ7xHkNIURRMnAiKbVqIJnezU4f7T12oHFSZ3FS/DEpISkpsKqAFtM9BAm9DmJc7abhgvnsSYsdhZl4zXVORnTrRsM3NGYqh8UIJ1bDT5KnpxY5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FFUufafLgbdtn6+6RYF6DhZaLathwRv3aY2o0IAW3hQ=;
 b=Jnnwt0xECj5bLJzXXeiuAqd0T2d3MUMw/FFJcZzMIhAdyubz10Q+ZBw0bL5Z3sQiA0LmDNSAbw7S4sdoERV9shQd+6YV6uoETYBLgbdNTPzKAoJbDx+NilrOifwweCOCuf/MqFUTr78s6IncF/XgKYUasCAAvUuBHu+GiLsGDs8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CH3PR10MB8216.namprd10.prod.outlook.com (2603:10b6:610:1f5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 08:25:01 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%5]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 08:25:01 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        bpf@vger.kernel.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, sahilchandna@linux.microsoft.com, cl@gentwo.org,
        ast@kernel.org, rafael@kernel.org, daniel.lezcano@kernel.org,
        memxor@gmail.com, zhenglifeng1@huawei.com, xueshuai@linux.alibaba.com,
        rdunlap@infradead.org, david.laight.linux@gmail.com,
        broonie@kernel.org, boris.ostrovsky@oracle.com, ashok.bhat@arm.com,
        Ankur Arora <ankur.a.arora@oracle.com>
Subject: [PATCH v17 09/16] bpf/rqspinlock: switch check_timeout() to a clock interface
Date: Mon, 16 Nov 2026 02:24:30 -0600
Message-Id: <20261116082437.66739-10-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20261116082437.66739-1-ankur.a.arora@oracle.com>
References: <20261116082437.66739-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0166.namprd03.prod.outlook.com
 (2603:10b6:303:8d::21) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CH3PR10MB8216:EE_
X-MS-Office365-Filtering-Correlation-Id: beb0fff7-2a54-46d1-7c10-08df43bb1bcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|366016|22082099003|18002099003|6133799003|261009223027099003|56012099006|261102123227099003|261028144727099003|261026121527099003|261026140227099003|261021123027099003|261022105027099003|261021121427099003|261022075727099003|261021135927099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	zBB8vCyoeLzyvfJwtFwmVG00LwfbQgCS46rLChM1L4tDvpkc2ILMxFIir0LQV+hOH07jf/3Vim3siHdClEqK9uKZelUZ6KOGVtwB22lTpP5h3hzic7Uh89PJi4GOTJGm7ceLRqu3uYf5hAorSR9O0ipFw+KvS4HMpqbAh3DdHDvdztZLHzIJLEFed67o011iK2NZMcx6iXFGy2pdiZJcLBZSHXvU2IlIXFD3TAf9Cvp+SYhrnJeoj0ZcZpTwkKFKhv4OVHAFmfsDWtbRW9wBziy1zRb73FfqeTDLSnseQNofVyLY3r2boqUsQ42Ji3MRMVgbS1+q/5nCrAfdf5X0L2VqzrIM7SkmkWyKc4USkitRYAJkuN8UIYn1wI23pKMhoKeV3mDDF6NXBJZmkHyBCoZw82PHc/iVs2em69ZeXn/7i3jcc0O4fgV78YOD4tEUkEgm4kVoAJCVIlOvP6S2kowf0qdeddXDWERIu9ajjnOf0WnZejNHMhCgre+VvWn8tegm8+zuI5c+VgZRsd5tW5+s56VZAB1VZQgfLBCguh+Pj2VBDwLGSVa7u7ONMoGgjcApHgwBnDF9Gx4I91wuLLq643wwTIDLV3eUnTtXj4JqsjK0wycSgUMisQFqLanRxLb+uqAnVdRm2dLAm8fmYspdUPvMwHFZUu4LyZmZk9Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(22082099003)(18002099003)(6133799003)(261009223027099003)(56012099006)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021123027099003)(261022105027099003)(261021121427099003)(261022075727099003)(261021135927099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U5oCqjdcz9TW1HxMEUF+hppiYBwf+F4oBhFYCozOiQ88oLzmjF3E7ODfkdoz?=
 =?us-ascii?Q?Mkr9GUrNOzwQlJMPbbN2UVIlZLr+QPNSivOrk3tp6lH8RKjKZuL8Da6dtaeM?=
 =?us-ascii?Q?29dVKmvKjgrMNYidjQOmUcpyMsls/8YNN07Wy1Hd2B6GKtY2SyVS49Jic1U4?=
 =?us-ascii?Q?Lufx8zHsg82PaZoDV7aeSbEkoTDY19/CZ5haWQI1PGONA2KwJ3+5dWk61rtE?=
 =?us-ascii?Q?c9x+aBm1xOLd2TWwQ0tTU/+UHc3dqcLRxOC18/pej9IRahQyDgFlqW6JIsb+?=
 =?us-ascii?Q?LuZ8MLT5yrmTXcuBPdMMxktgAQ3Ped5O1gkMqNt764EgmauqsW9FbS/QSDaI?=
 =?us-ascii?Q?TLU4kIFg8HORhT9WsUkrpHWnhWktIOmy+RP3D3O7TmRUsKRgnAOD+0JLSN5l?=
 =?us-ascii?Q?J1iX2klYBUOwCKRw8akh8HNLsX9CMGFXrguGBBUsKe92NviRn+8BLK6ZgRx/?=
 =?us-ascii?Q?Nt6BTTyFfKSMKG6TgAgm41+Sba6lEoej/D8Yrtj8eOs+0298ThSVwALxqnCf?=
 =?us-ascii?Q?4356pK10IAukbyAEPoGV286DtXL0CIW7oa8g/5mbYa1ti6LbLlRzp0QzLS+/?=
 =?us-ascii?Q?Ts1NEhxUq8/Kof1A4A8auh3J0ceuyjCv6jFmwHoVpc9JH+5xHQ7e1V+pEYNG?=
 =?us-ascii?Q?rAwAUoMXBz/aIQ8u3iasMlZtAhojwV6k1dY4SKA3Nv4hJMlt/H0Yx3Xf+1Wf?=
 =?us-ascii?Q?gtcsMMYBupGeT1xouZHF5nbRPk198dbotnIH2ph9swdgOffHanSql0cCSR7Z?=
 =?us-ascii?Q?gyaEcw2CIl2Dgg1/PXDHQIpctL6jugVqgYd7HVYD/Q44ND32Ea3g6Isy8G6R?=
 =?us-ascii?Q?fPrM5PpphD6rQOtE1zRJqs1WirsiZwV/V6vVpfNbM8XHEzBw6azS0dZHPtEc?=
 =?us-ascii?Q?EfqeXX+r0RLpR9lTvCY9JQBIM6pSfNkmdV8CrbJWSb+Lbgx+GQSFI2nI+E4C?=
 =?us-ascii?Q?NDb2bHbDkcSWjfOgH2hzRXKZrRqolwGWplmyXr2LdV95UjOQMeuHg3iuTac5?=
 =?us-ascii?Q?lr9m44B9X2WwRxp5mN9Ubdr6+OaYD1hNIkA7HaFSUieLB1Hx2Khfcu/R4Jnt?=
 =?us-ascii?Q?cHOn/bJI138JIpnLK8G55dRBpYUjB0YH9QnY26SfAUQJncofKtzYB1DlTiC8?=
 =?us-ascii?Q?YfFhBb3hJzzswLRv3vc3vbRtqUOycwceKZq54kgXupi8LoE9R4p2j25aFBCG?=
 =?us-ascii?Q?5IK7bM3dDYrEfim3i2KuyyFarH9MjbUuBTCI5apY+SRORCYLiG5XBxML1qpc?=
 =?us-ascii?Q?EwAVfaePWPUX5pVw4Yc34Mg7yTRvZml/WQltmu/TCjWGtYGIDdiOQLa7t7Yp?=
 =?us-ascii?Q?FlzShyOxTiob5hPM2xNKk3f3oSw45+NZmMjNaTkPbKuShfBxlYp3FVmIQQtG?=
 =?us-ascii?Q?bvUb7WDzco/qHE+CkS4FpJB13mLGjUa1ONDID/T5dEaLfOVjgmgyOM6AHHQU?=
 =?us-ascii?Q?6Q+jfTmJN6cfYjk4n2DSrgoUsGdiPDpVdvczIpS3aMSSF9hdBPOfpuiUEl+5?=
 =?us-ascii?Q?1Un+lomJ2igQL1kMj6bnRIQlIAF+12mYBnPPZpz+zfN87IRT5q5IoFnxVYii?=
 =?us-ascii?Q?IQgOgtQwQYWPMktrWIiGVZW1GagXBZZBez1/91puoA/5gRZJA174H9XcaX+o?=
 =?us-ascii?Q?fa3Op2s9dPIa003pMV0xsK6VVTGqW4IoTsYmMxB9Q4C4uwQSpK5FF3L/SawT?=
 =?us-ascii?Q?TGsL7Szw6+OJkN277HbR+ERtcRndZabA0P/5noUJWL1paAAex3r0yVEEOaw0?=
 =?us-ascii?Q?1QcdEv1L3uWijy44NwXmktWi7up4yVM=3D?=
X-Exchange-RoutingPolicyChecked:
	jBnW0V8mVoMUn9DTG9XLx1ZVBboUEthwvdmALAzONd2i0RCVK0M6wvRKmEYH4q0M37YcXPWZQ9HZLC4xSeT7OPgk4IfyBP+Kxledhii/S3VW1zXGRBqFgqJEBpcE4aBc/VjoAhFBI24yXbu7zx18unkCdVpovzC22UjcbMKLvG7cp5UZTM5GjCN8GKIFbayDQ2LRFogB9DSlwZQU8X/P7l+llbNctGO3Tv9Jp/0icE/XrRmuaXKO2VjR4HAx86HH/nx7ko1KR7S8CJnfQrQ5cwCmtCobbrqHF2wU7OBiGzIIqNHpm4vy+orut3Prj31D4YrKWYoXITn+CKAFJbWG9g==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GACF9dO6+3j/6OK3uWOu2lXBQ7li/hOZCFpYmQVqgI2Fd8E5mQNOIFXjeuyDqwY5yXu8GfZKZWdWqrwkTwTWCIhAJe8sCXla2MvVQiS2+FaN4t6JpgMwili18GIFy+pkis/Mvo6p7Fwweg0zEOMfGa6Zwxnx1kwh1D/RcIUaf+Mcg6NuB9ccGvn6CW9UW75yWsUZqBxPpNdUr5JgcfF0lwq5b0de1KZlpIoiOuLoo+K0lc1jEoKgvmYdNxHL0lj2+cm/JTDcN8lplH1CRo2IcuaCWHZO1gmZ4tkpW1FN6MfX9p7jT7iW7CtlUpXruEf5yAWWc39beFdN25/FTGSI1NLhQReLRR27WM58h8vNftJ+hN8YHvM/7+Yb4BPLnDqANWUUOuK/XKsofbUgdN2EfUUHmGiX3o5LVnKLHfRaS1WxNTIcCpHqkbiS+DDXb01cSyuq0HwpkbuwKzx7U8DwgKxZehe4G0p5bm2F8zpggrk6ITl+khKlsCuR+TAaaGi56XJ7jToEQdkwY7sW1XxPQGfkHtplkxK097QT07cTNhAQXhVs0LnqRnLyDse2RGUXTHsw5J+K/9PoxE3VabREYTDmOPvHbYl1v3cixjGaBqc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: beb0fff7-2a54-46d1-7c10-08df43bb1bcd
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 08:25:01.5961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3VOnBlOceF/jaxPwI5S+jH6wESZzRIaxh1ZF7G1o+b8ACOevWi9wcuExVS80Q8jLRV85YMU8yZY5qlk2C3VLEKOSXtK25Us/N8QNWWUZt00=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB8216
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160033
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDAzMyBTYWx0ZWRfXx2hpX+f2sIFx
 w+Nmtl08P3y6PowXLJueUwgEl1iQxiXwUhoH5YXiJZmfwIUP55K7KomfghAtJTHz+lmRGSe43ZB
 YaVRTWdxoHSmQHXNBQEXuHlhrSRNgaMLXsu07qw0GbV3Gdr+hrnOE9aOHo0rwHVNmOTctEdCe/i
 M0sYcrfe6c1IEbY7+pnSJqbj65Tt44DUH7uZ5Fi/wN8ELrBUk0Y7Y9Ab0cmhSa7UrRrfQtMmJcc
 /F3wm+701anxCApNU2ObbZx4Cfm+xxyoUHgG6KG/idTEYC6xwJTZ1IQ1R1w7TE4K4gxu+zTteZq
 a1dBt/Td/MoDEvu1QE9hc3cGYI3K24WUwSIsDeX9e8BY3sAEMwa23pUb/9ACUxNCmG+KPOZlBrM
 fJ5rjWMUD2oLhhCnchjrSgsqxx5RXZQaIcEbjyeP8dsB6Eyfqe2IBrerM4b+whq/66cJ7U/vfcA
 yloUhpSL1yE0ixSkE3L8KpO6EUqAz1DNGDtK7VKI=
X-Authority-Analysis: v=2.4 cv=BtAIUoX5 c=1 sm=1 tr=0 ts=6afabde1 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=EIcjfB9IiI4px24ztqRk:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=vggBfdFIAAAA:8
 a=yMhMjlubAAAA:8 a=yPCof4ZbAAAA:8 a=LqkqbBbWekfmbT-3qckA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12100
X-Proofpoint-GUID: UB13JWBxdLgpwbSjF5v3eX_Pjsj4Uukv
X-Proofpoint-ORIG-GUID: UB13JWBxdLgpwbSjF5v3eX_Pjsj4Uukv
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDAzMyBTYWx0ZWRfXykBPxYycWDyB
 FM5F5B3pThxv1uLTslAaQ+PQObvf0SfP9tPnWFwqSm1zRriLlNGv6qChXiYJUBxQrMeqm0bUEa6
 dygO7SKVLg4K31S3bJp3X/GC5H9Q0bMvJldjtlgfAcEivzqP4rGh

check_timeout() gets the current time value and depending on how
much time has passed, checks for deadlock or times out, returning 0
or -errno on deadlock or timeout.

Switch this out to clock_deadlock(), a clock style interface, which
functions as a clock in the "lock-domain", returning the current time
until a deadlock or timeout occurs. Once a deadlock or timeout has
occurred, it stops functioning as a clock and returns error.

Also adjust the RES_CHECK_TIMEOUT macro to discard the clock value
when updating the explicit return status.

Cc: bpf@vger.kernel.org
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Tested-by: Haris Okanovic <harisokn@amazon.com>
Tested-by: Sahil Chandna <sahilchandna@linux.microsoft.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 kernel/bpf/rqspinlock.c | 45 +++++++++++++++++++++++++++--------------
 1 file changed, 30 insertions(+), 15 deletions(-)

diff --git a/kernel/bpf/rqspinlock.c b/kernel/bpf/rqspinlock.c
index 111ec80ea958..0c624fcdc988 100644
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
@@ -219,11 +223,14 @@ static noinline int check_timeout(rqspinlock_t *lock, u32 mask,
 	 * checks.
 	 */
 	if (prev + NSEC_PER_MSEC < time) {
+		int ret;
 		ts->cur = time;
-		return check_deadlock_ABBA(lock, mask);
+		ret = check_deadlock_ABBA(lock, mask);
+		if (ret)
+			return ret;
 	}
 
-	return 0;
+	return (s64)time;
 }
 
 /*
@@ -231,15 +238,22 @@ static noinline int check_timeout(rqspinlock_t *lock, u32 mask,
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
@@ -281,7 +295,7 @@ int __lockfunc resilient_tas_spin_lock(rqspinlock_t *lock)
 	val = atomic_read(&lock->val);
 
 	if (val || !atomic_try_cmpxchg(&lock->val, &val, 1)) {
-		if (RES_CHECK_TIMEOUT(ts, ret, ~0u))
+		if (RES_CHECK_TIMEOUT(ts, ret, ~0u) < 0)
 			goto out;
 		cpu_relax();
 		goto retry;
@@ -406,7 +420,7 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 	 */
 	if (val & _Q_LOCKED_MASK) {
 		RES_RESET_TIMEOUT(ts, RES_DEF_TIMEOUT);
-		res_smp_cond_load_acquire(&lock->locked, !VAL || RES_CHECK_TIMEOUT(ts, ret, _Q_LOCKED_MASK));
+		res_smp_cond_load_acquire(&lock->locked, !VAL || RES_CHECK_TIMEOUT(ts, ret, _Q_LOCKED_MASK) < 0);
 	}
 
 	if (ret) {
@@ -568,7 +582,7 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 	 */
 	RES_RESET_TIMEOUT(ts, RES_DEF_TIMEOUT * 2);
 	val = res_atomic_cond_read_acquire(&lock->val, !(VAL & _Q_LOCKED_PENDING_MASK) ||
-					   RES_CHECK_TIMEOUT(ts, ret, _Q_LOCKED_PENDING_MASK));
+					   RES_CHECK_TIMEOUT(ts, ret, _Q_LOCKED_PENDING_MASK) < 0);
 
 	/* Disable queue destruction when we detect deadlocks. */
 	if (ret == -EDEADLK) {
-- 
2.43.7

