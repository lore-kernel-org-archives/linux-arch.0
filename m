Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0F53806DA;
	Wed,  8 Apr 2026 12:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775651211; cv=fail; b=b4pmBZObSbDYMN9xBRuFZeL8MnFKVL7rLR5RK3YI9kpUVbi9f7qDS1AmoQophtD6HEGxnYE5UinBUQOic/Xt+fxxI2tfy7A6miLoOj2bU3VZ45OVrKloRWaGxCu9yqfXfBf9ormTFEBOIpjpZNLBgB59c2q/M5ru/4HKNMsrLZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775651211; c=relaxed/simple;
	bh=9TiLGXL+eMDKH/l1AV2MS1qMQWG1nXkKpIjl+V3bNzA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=neL9Eud3iA2l9VntZfF3DAcCL96p7P5+8k5isa1p8ylHUOl4y/PQCCU9pRz0CSIJaRNKI2D37pgn5/JtamCNGvjT0zByi/F1LzM84YaZq00IX2ZFIx1/QbnmScsLlinxxzmiAky3LUGy8qdSRYzHCQ++2d6KlbuOse8aCl+LBeg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UDFxH6NL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MWLXeTdz; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UDFxH6NL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MWLXeTdz"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6386ilBP172692;
	Wed, 8 Apr 2026 12:26:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=IR4V38zxdlkGAAqrvg/mEnvK/KSPtOtt3He235jhq/U=; b=
	UDFxH6NLFoeDbmwye+U5bEGfFDS8A5jRicCiWgPI2QUALTmgtlftM1DBbbZ0JoGL
	rzf4m1k9ZRUwaRHiQF6Urf9Rsxt8QmT4PotDu8od4ukooIOGTTHPkZ3YZMGLfGz3
	hB3oChrQmE+Ve6h9oXklhKGfKLsd12+R8ge4vAzKmRN/hY9vmV+SIh1lr+cFGOha
	RgRfEwjuvq85R2KaIshChebns7ItunT7Y4qzLDB7gZguKGBE/z4rO6SAqXNaiUoH
	qCsvrguadqKCleA1C/2QXLoC+OOYX0A/6wJ7lxEG5RRGSiZWd6iQp84Y7sn14FsF
	hwi56By+URFiMnrKb3cJxQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dcmqaudk8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Apr 2026 12:26:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 638AGdCD011564;
	Wed, 8 Apr 2026 12:26:26 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010019.outbound.protection.outlook.com [52.101.56.19])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4dcmnrfjwm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Apr 2026 12:26:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Own1EXxr8F/a2GfvWtptf43+GT6J+o/onXiEuqvfMD8ehp2xABsPNeG32PGH3SHYimKAQe6KG9rjRmnO1w8eqNlR08wRIgQ5KZKboNJ5febZ3BPimJpphzAo3+o6olqDg7k7r1BcONZ66HrvuZHW6RiVhSrmn2jK+vXBc1XjX9k9AgHnC11jgyRlsDPU07ptV1aTsTcElknUNAaPn84NsjGAoewk+F8ByIp1z2pGBoq45V0LgaZ+AJUlItKE7o7OURP5p6cHfktLZ+8CblzOzK+m84PFM4tgI3ItuUmmp+YiyBR4s0oQ/XHeYLJJP6kqXomgPPIG14bcHNXZeJg73g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IR4V38zxdlkGAAqrvg/mEnvK/KSPtOtt3He235jhq/U=;
 b=TXlr0PpVQTcpHML6maWBy6nO93k9RXkDp/T3tdECTIh96M9TKFM8z5oULUVefMc8FzjadPzr4T71au4rSsgEXUbWtzw8elKnz2lkAAo5PeMh008joZMW/7spva2Qq+Kd5wAbvoQ6AIrjEtUPgZrY4aVu4EM6BQTiMovByeX+GzO3ofgzOoHdXevGrW/X9B6a/BOLxXUHb+LIWSE6gOmbiZv8pdna1DIvWZlmS1nDxHZnAO+s2KKY9pUpNfTAMyCsmjSclVmgrLx84sOpveTiNjUUhm21fUOTTD/LfoeTEuqdnJ08nJb3ULWM0A5swdAh41bI+Kxlv0wqn+7WLDXAfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IR4V38zxdlkGAAqrvg/mEnvK/KSPtOtt3He235jhq/U=;
 b=MWLXeTdzmOb4mvadc4BEjUjyK7GuCoN8DQ8xTuBhF8HA7bcLwiMVDMN0Hr2oayk1Pyl7g2K+mx4LVZu7novevEWtXQCKEpMbqukl5lxEvU1qmYxNGECw2B9Yor9K6WYp79qFwHhaj/nV2krRsurqoSns+nBBrMo7Log4aIp3oSU=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by PH7PR10MB7036.namprd10.prod.outlook.com (2603:10b6:510:274::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 8 Apr
 2026 12:26:20 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.20.9745.034; Wed, 8 Apr 2026
 12:26:20 +0000
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
        Ankur Arora <ankur.a.arora@oracle.com>
Subject: [PATCH v11 06/14] asm-generic: barrier: Add smp_cond_load_acquire_timeout()
Date: Wed,  8 Apr 2026 17:55:30 +0530
Message-Id: <20260408122538.3610871-7-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260408122538.3610871-1-ankur.a.arora@oracle.com>
References: <20260408122538.3610871-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN4P287CA0132.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b1::8) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|PH7PR10MB7036:EE_
X-MS-Office365-Filtering-Correlation-Id: fc848a9a-d4da-4242-c654-08de956a0a5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|10070799003|7416014|366016|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	B001HlsGMSvxam6aSiv2NUbqA9jznF6ZLzzNx/LzpIHgTcMuWO4bKg4zJhpIytsufytcIHgNJttk/yI15L93s+aNwb+0Fug1KWDaoXBQLHeMyMN53WFuWrH/gj6MJ1+OZ1l7epSKnjoIeID1LxOnCTvlcJH/flikXlFIrrmuSugL9nHbz30NGcB4LELX7doyqv7LQjV9O2W1WtTleAzNzKFxkUZPxAtUDaWi9hwXcaNyh0S4DLaGfLovjoeiFZ3UMeubb3Rs9Itdpw5e5LJWaYwxODtJ+hweal2i3zjvEs0wqMo54Ycr6HtSPGxbRhwLSy92Tse0kEzXflawqOXLQt0A86cbj4hSCYUgN3AMR2M0HRHho5sVWNp2YJ/aWgncl6j76sgBY7KMsAaDAnJOZhu0vK+ZRsPxbjKFu9OIh/218MvqjZqepaWui2H8YJjxAkV3rcrellTpnrJzLmqfJDTbZs2Ktrb9/E8I6b/T4SL3Y8HgdRAjZ8fTCY3zYFFwQVof+TaUDMxpUOfDyjw/QskPmW70ROqDbak8JVkD2QnmXhgxHYCJi6ICiybEPae5Rc+zNVEGuoN3rhRzaR4AyD2zvlbk1RuJzK89wPnBLQZkiDFUypb8KcKfsMJTV7XA5EH+g7iCfJ37jPc0jpjSNE3e4A9RS1vTOEU4Gz8lqBJXBYf4UGCkiYMSKPXXNsahMl3g3O4v+qID0x2ViBzqvKwBlKvMofhO7GWtbTw/r4g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(7416014)(366016)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jKttPG+c2C/yaDtEr3W1AXUBaPDzVHM4j5/az3QMRts1NDL8SWkZuZDoL2k3?=
 =?us-ascii?Q?t5by+jPTEZ1XYbglsvMUu3O8PKZDnYiXuAgcaX4lsLFMr9yI+YlB06odOtSp?=
 =?us-ascii?Q?izmPrHP5IXmyRSciR06l6Wc/FQbPi/CepK3Lxa3CTG8S3vMHOpk1eUlLE2An?=
 =?us-ascii?Q?yioLehoP4nCPCiMUtTqnjBW3zePuroUDxUYc1l3NdoQW9OTcz7USO7FM3U47?=
 =?us-ascii?Q?7NUSjqay0Zq5HcojvRfX+tvGKqOXa5vvu+IiKQd0vUEGsCxsPkfDcXCGwAHQ?=
 =?us-ascii?Q?TlYMvcX/3/IqjGRLLFbmHUf8s0SC5bLzonPDvuS+EvF0uce34sDwnZ0faTmm?=
 =?us-ascii?Q?i2S+seKeJj2W115HVnWimHpcjfHqoq9WHC5XgImgXWy+7LxJxzJM/LMVKOoR?=
 =?us-ascii?Q?+jdzmvk2/D6C7QNMmTubm9pGOj11aMLrndp0tvyf1Pb7C0gAMeYyqlCJmdKw?=
 =?us-ascii?Q?dVna7YdNg5psQmse6eeQ2l4a30XiNoDtWUBp7KnC/hU4nuWMXKdb8E8BisAM?=
 =?us-ascii?Q?4Wm4N7VHjxTcSwiVZAhQ3YhKbywguO3AWWs6aexCfdzbgnFaNPQyV4UQ7FRO?=
 =?us-ascii?Q?EKreWGyAsXN/YuaT938WkgkT2XwCsSCG8qBaEaCDAoOhvJ7eHSfsSjXrloM0?=
 =?us-ascii?Q?RnXxFp8KTZrc5VsdhRRq5xtUyrimCrm0AJK07JcmdkhhhRYufbx8gXKX6BmD?=
 =?us-ascii?Q?xGMDolgbI8yGd0NkmFz8tfnyAyOSfjgVwUrDyr/AWpDUpcouPra2X/PbvRvb?=
 =?us-ascii?Q?MY67FgbGjajiEALEvCjERVmrYEfqQtCdbpdzMQe9uSD8aqF2eAIaVW2jB5V/?=
 =?us-ascii?Q?Q+NRewhIJckylwmvdfQEu0m7ebraGaDg5xQyfYWQbZw2HvOfEM6zTOUBda+B?=
 =?us-ascii?Q?nHM7MnaoBluVq/rLh0ZPl5jLuNLZyl1Z384PT5Kpv5prT4Jl1fT7PkQInBIE?=
 =?us-ascii?Q?1ssUzUzZn1l6PDmbDX8XD9jjYcUT2Ijl0qh9Vhl46GNvAQixFG07DFVCZLRl?=
 =?us-ascii?Q?dLrDGOuGqKybP/ieF7l7WvYwnJPoOx9PeDp0pFyzcZpf3mfC0vhh6aO/PWX8?=
 =?us-ascii?Q?iErP1CKAKRRjUJswHJTZpXdwORWZv1lrfA+TXgAF9Z5CCrF/lQACBWegWNnN?=
 =?us-ascii?Q?aSSt+alKjx/Uadz5c/d2aEnHMVj9RZTWhd5MIo4MEY1r74blVzVfTjHQQvmB?=
 =?us-ascii?Q?J1Od4QYcrBstpzc1PxiqD+CuYdgGVARly4jlJgXA9IvYj6ghQWvFzztDKsN9?=
 =?us-ascii?Q?sdIG7L1Xvkhx6UhMH9MD02Ak/si/5/HHWnarbIGL7RDewEmkTXpKXL+nODcy?=
 =?us-ascii?Q?eyJjT2qt9tHl9VOF//53jWoWdrArYwTPG304fwn1Ycce+3eamJ/n2Dv614wE?=
 =?us-ascii?Q?Ku3NYFxy9bmaGnxrr/kRXOARpeK+JoAsORYnr1ANo+bCh+qpb7ITOVtGllfI?=
 =?us-ascii?Q?Fv6+xv2tORJKBNa9Zol5TunusD9JjUrMOqCC6WH6q5FKPOA43/Melvpkd3Mm?=
 =?us-ascii?Q?JY1QtgOiY33wqF4Dl3/JltJ4ZGrjNZ1gF5+zDBWwUGw4/OpkTCG+A9+SC+K8?=
 =?us-ascii?Q?JLf1IGKlSu3hFwg542gpAqOgq7HMKRMqTwRq8WPSLF9hO0XpXJnG3IIPGpr6?=
 =?us-ascii?Q?nGYQkPzKMUuwK1Lj2gSTWoAcczCJaYir8KCOmP9kvOyZUAdUFCM5CEQtYI5q?=
 =?us-ascii?Q?L4hu96J6skd6NFyC9mIPaChFMorgbn+O9du+HNs/2T4JSW7r3jhnRNH6ckiy?=
 =?us-ascii?Q?EPDkhL0PDMdLB2N2qEhebVy3iO0DIyVzYpWduIoOfXfWp/LXmCp4felDky3L?=
X-MS-Exchange-AntiSpam-MessageData-1: FuOJJKOe4RybVghBiwpbysIXMF1fH3KlXDc=
X-Exchange-RoutingPolicyChecked:
	RUouvKX87X88LQjoqshdaQG2yvWWPvyE6vjejiKaS1Bjm453M5nE0gXpcWP9okSzU9tdVHThPaLOYRvMaw1D4Hk95gSFAhGEXUQ0gzdV+7buDfGAunOmq9pOnicur+U0P/XQ2fXlsApNndmhGifRdhQXhhcyjo9Gg+PJOwkjYrY42cniHbq6cKxetyrmNM07SRWU6GTCxesocg1J3DSH4XocMMb8+Hpj3N62Vu+9V6QNdGCMEAhkvj2K4iZwbX+DZ5NTO5zEzfYogSkJtrmKxpS843a5yOHxISuRB9LoUMdi6RgxXmFU20Vd+KaOIhkLyKY1tykurHjbNlMtpowPOg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ChWj0iAireB+hMXL9vcE6SnKLfDzdYAs1rA/Whylxf4hBHmPeioA0ExoPgpKYvxmWlAhobQ/BFVUE7yVKdjiplpGY7xB2ka63Xj1rRTJGPFyEvg90N/n8VgbVGeZzcK6kFYxecdCLq/v6IWR4096qOsOB0t/JRYBYIQ/9/scWfqZKCcqkVA8STXzaa0tuSLZ9EnHTdifTAVsLGK9ux/tXPPeajBNudsaJ29t4Usc8fMRjEBK8wSh1mZuVtHClEyTSoXAO0YJXg4+LC87oy1dPl+n+1jyO+7iCFeUxFZkeE2XCzBbjmjThIcqVi83u3dZq9LHQ9uQZupjjIXLgba4XOqNz6A3Ld7pogoLnhhsMVOedM7uZ/0WGkxRSbo8UZL5PesthAMhYcTeknT4OnjZL6+tGw5tul74A+VV+EjVCDi3nxD/SJkDAXb94sMhedSXiloSQDWtk2fp5z241p7z/3CReUO5oZLCoDBrlpLNuyFqkzMohAt1T4oPa8f3XtPK6nSEY74WOQtlE7ZZA1OgcxefC7Eb9TnalM2XxxDhM2NiwOZIlHgoU1Ber8NujWnq10ZsBBlfbq+JplvvyWQkKc5/akRvRXYiixNPLiNfP8c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc848a9a-d4da-4242-c654-08de956a0a5f
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 12:26:20.7648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0KHksf5dGb9vNK60bznf4nqKkfGeeM7iQO15/tEJzr8ButB53GIEUf2cfAuyCKhfiusGuO/JebkiRiGeaXbjna76J4WDW5r9rXoS4WLXpQY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7036
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_04,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 spamscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2604010000
 definitions=main-2604080115
X-Proofpoint-ORIG-GUID: zo6LaMb_AhuBpbQFVbxHlPn1uAUX2Ty0
X-Proofpoint-GUID: zo6LaMb_AhuBpbQFVbxHlPn1uAUX2Ty0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDExNSBTYWx0ZWRfX7sYWNq1i7by2
 5si4M42vneNToH1t+nMjD7aw6YpOSdhB/WUGS9f1pMizVqj/axs2ebaISJo+6lQHF66l3EC6htQ
 1unwlOGWNbG+E6SE2YaSuvVAfmCb3gO34WoiqShkPc/Q6ERTbHEOf7U2VzeiunEH36zMVufNhxt
 ombHPY+frXqxkBM/Kv1VRr3E0tjLZoo+SM4mapGMaCl7vh1pmDn7d/Pux8uctB6BPE78oufwnNx
 5n5Gd45VIAQU4+7+nTFqQOXpmi/JRO2LABUTFdPscN5kQUuAEEgrAtVVukGB9lxYMzHvFL4XhMK
 Mk3LuShpEz4sTPxDNxRAf1ZZPymPkddUYUSIz9Ms9JoJYjCsspdE0izV6LJcvU/sKfbfJQxsr35
 qm9pgfbBTV5nAx85NjTX2MuYIPm1T5BoeUdAl0Bv4w87/KYKqMzR1gHJ1VRscUhboLnKArxbk5+
 CEFszEnCVKwg+BSkRGQ==
X-Authority-Analysis: v=2.4 cv=NZXWEWD4 c=1 sm=1 tr=0 ts=69d64972 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=EIcjfB9IiI4px24ztqRk:22 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=JfrnYn6hAAAA:8
 a=vggBfdFIAAAA:8 a=yPCof4ZbAAAA:8 a=9GcLsRiznYava-zPbe0A:9
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=1CNFftbPRP8L7MoqJWF3:22

Add the acquire variant of smp_cond_load_relaxed_timeout(). This
reuses the relaxed variant, with additional LOAD->LOAD ordering.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Haris Okanovic <harisokn@amazon.com>
Tested-by: Haris Okanovic <harisokn@amazon.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 include/asm-generic/barrier.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
index e5a6a1c04649..68d9e7108f4a 100644
--- a/include/asm-generic/barrier.h
+++ b/include/asm-generic/barrier.h
@@ -342,6 +342,32 @@ do {									\
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
+	__unqual_scalar_typeof(*ptr) _val;				\
+	_val = smp_cond_load_relaxed_timeout(ptr, cond_expr,		\
+					     time_expr_ns,		\
+					     timeout_ns);		\
+	smp_acquire__after_ctrl_dep();					\
+	(typeof(*ptr))_val;						\
+})
+#endif
+
 /*
  * pmem_wmb() ensures that all stores for which the modification
  * are written to persistent storage by preceding instructions have
-- 
2.31.1

