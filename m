Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB3E28726E;
	Thu,  2 Jul 2026 01:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782956065; cv=fail; b=ByeZnLKTDC0fTrtjQdPwAf6WYSKYNhMVSa1WdQZhURksD3jFE2YvjoPeUDyuCRa02XmEAr/M6nbv610p2nGJtSUg6h2FNgFYelKrBpdl0PQIHAkqUPMr+8NLmLKjMEFsU1Nmup6VI1ZYrTyXQ5VbLKSR4wwDyNMPVe2bS5UvZ54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782956065; c=relaxed/simple;
	bh=TBY4J8ZQyerQnr6/x3E6r8gq8h1TUKotinQ6zFagEjA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=clw7EoFsHjNy7OKG19CY4EEO1Og653wwCcfA1MZuQrFUJQ8MoVpzKKpsdqhLy5kTQgsQbVY4X3FDriftpxQA8ySBCcKkPkgp+6MnMftufFUowQJbeU6XDL+38UJdIhPiXwuKd2vyQvtUGCw1KtAba9wtENRYPVCNyFwnnFys8Kw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SZL3A0dn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ayk10vCI; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SZL3A0dn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ayk10vCI"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661EL1GS3057523;
	Thu, 2 Jul 2026 01:33:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=s2pUthQ5F5s3dDpr4wkTxK9dVCwB9eZpxrgf11Vs1mU=; b=
	SZL3A0dnLXEbD472gkgyI7WbEnbwAAtwm3/QeeXGqDlVl9maTmN2t4Q5ztE5VdbG
	9ZclApKZWQ0FUdANweonqNiCLVBsXW87Lhcc+jFg3FdqGdIqzwh4fnIX3JcED6V5
	wFB3yQV1N9DD1cHWR5WMrUJGvAnrgbRYSTKb9wX+6rA3wsl1+nF+rkbBS9FnfqMe
	X3e/q4fKrRY9LfKZKq1MyqpWGGB/o/98FTDw5H3N4qpbDS/Icbe1Qd47vcTyCujG
	MPXTFhi4dMVRQfpl5jFiLiagEeuq15uJ3CBqdhphyiWDMviMkYdjZETMGkLh1FeC
	GkIYczYot6lREOpD7so5/g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4f26mk77k1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Jul 2026 01:33:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 6621OnAl032524;
	Thu, 2 Jul 2026 01:33:45 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011049.outbound.protection.outlook.com [52.101.62.49])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4f24ysf05j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Jul 2026 01:33:45 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jLT8FWGgOLSoqyXBXaDdnaJ95T8PyWTF7iFR0gwv/HvhuG+EqyleZ0Ttn72DVK/qZne2p3amFakM/FZXb7wTEayxqAhMgK/dRQZvGDJY4TZbnOhL3wX0DwaQRd492JMsJ15DmOY+OT/fMldgS72fSZGUWO9xLl5kFFZkFKlWf/STv3+rHw8OoAKFmEatjA3SQALR2d4XExpZgPi7qaaQXntQgs2NHktjCTdmX90HrFUCO6icG6fvZsO2EqVlgjdw1+kn54UgWr6IDXJrUrYixipcBpyGpjyYG290BvOdTlh752ItnZ7KphwWpYkefyLyKhmCfjiMIf5Wz7xFxsJZ7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s2pUthQ5F5s3dDpr4wkTxK9dVCwB9eZpxrgf11Vs1mU=;
 b=lzy7Hx6nONSer0t5CVlB7Iolbf+qnIT76QofxudMy3/oI36fdmUiCsuVXENeoCV1eDFIfkHgW7bFT6JwcruTDTHWDzin6GJ0Z6vBSauNKpnFCcSeH483CvgXaqwtb9DwbBSjTmwJ7UNHaFgOKmpQ4d40wEiv1LRRDqjOfdQJW1mgAP4FEKilh0EAwu+ViXZZXgherxQxMnfY1WjIlQHHysftHK5tvUs+eMkjoffdSLdEYAMf2CrV+PQlhgOHae2cmNQJeQaPBMeOQfklY5CBFq4dr51wfuSGUjeL2pwJYtOwbUNAs0BGtfZUyHhJ1QkxeTwke/uFsQ9ZoQAVIRYm1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s2pUthQ5F5s3dDpr4wkTxK9dVCwB9eZpxrgf11Vs1mU=;
 b=ayk10vCIZQ9D2vOz25D9GqHeGqj6Ewg+nc1omzswLeY5ycGBsu9tTu/xsW5GyEnrppeilRkLeW/UHBVNC+2qAIBNcgU+jTr4fhSGX9kzQg36LhuWbfTxeZD1j0T+HUs/q7Qy/OLpSE5NctQT+HRRwDPyjMT4uMyS04mkEwhnxmI=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CY8PR10MB7314.namprd10.prod.outlook.com (2603:10b6:930:7b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 01:33:41 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 01:33:41 +0000
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
Subject: [PATCH v13 01/15] asm-generic: barrier: Add smp_cond_load_relaxed_timeout()
Date: Wed,  1 Jul 2026 18:33:20 -0700
Message-Id: <20260702013334.140905-2-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260702013334.140905-1-ankur.a.arora@oracle.com>
References: <20260702013334.140905-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0146.namprd04.prod.outlook.com
 (2603:10b6:303:84::31) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CY8PR10MB7314:EE_
X-MS-Office365-Filtering-Correlation-Id: d522d824-9114-45a0-9900-08ded7d9f271
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|3023799007|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Oxn5kFUjT2w7bd9zBaCtFn3R7IFzV27hifA4jqVi5sbn65WFOo0w/ioNA4ecJ3euUBqQ0nN4WvCB0fNf0iDVYFf6CkclBryDojUhKuKa+OndFxY0dpkC5PIXrXztUUzUu6Thz/TEm8XfVx/WEt6zwLPZtmtQuXBKIkhDJaP6TUKXwVRsjLclU6S/rIUk0EjLgGyoKl4lpdcWA3lvMUpYB2jD//LLR9Srr1zBfoTjeJJwR+koIaFLVcQ/MJ3fvRGh1eZikIMNPdqE45P4xUSqVXn8xp+6J1qJ88kG1Rtp52wRaQbccYxzvCaZwqFnoxDOFeI4U5UCyYnSi+UyTXLl0j7x0/sRV81rH51MbqYAcEpNuLJF7TWUQeneycmnhkSa9rRG0EpqWnN5ZVlKs1H91StTvDX+E4UFdu1B9+qdiwnGeKc7/7A9QqpMRvQtFPbAYnAehax3nEu4LKo7lXBjGYjNJVM2+gUk9dhxrIqtKExHRra60xsXTEg23ykCUgiN8br/k9BBgXXGw4NeqnLXx+Nnx1MQ0ki92fLgamRA+uEO07LJiOk7U/AtuucgEWF4b79pxkDglpNKxGDHk5/aLO17THjLVl4lWMIzvAuW6aibIgCdPFcVnYHAhi3sv0Jt9UxitA8D5VI0yxnXx05CAukcnCQAEMsfYbblT1Fy0BY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(3023799007)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1jQCZdzwDilvRFUH7qbFZxGeTCSkuCWqS6rWzxQaIzldchxzwx8l2AoRhw3f?=
 =?us-ascii?Q?RR3ECv4IewrXmbfOUFy3ONK+xOCkd45/MFVHlQtIQsaJnzDfPc7dgwvWQovt?=
 =?us-ascii?Q?jBtsSIMxxRo1UgeH8oQMQc3maJKCGgDHE6xS8zdgCiTvA9dFd3U3poV2fWw7?=
 =?us-ascii?Q?AhHAndvkBq2sCm5d+fqIHP8C9+X0nKobdNY+gbgEBPP2Yp+f6vxU8I/Cq+ia?=
 =?us-ascii?Q?hyTLXYomGsVfb5cW9qNDkkoO6Pwfw1m3ZTNsB81/tSQLujP6JZ3KkWfjdT87?=
 =?us-ascii?Q?sqWH/FkC9dQF2tHPZpsccx5nbIs/o9G/jQpkG/sQPiNT3NngbMxltdsYmGas?=
 =?us-ascii?Q?Tds0BLfC8ExOXaXD8o9RG6MwcpFiS2AbvDomdkRzsT4v7dBM/PgwpFep2gKo?=
 =?us-ascii?Q?s6OhVxdOm86pHWj6+LuuTcC04+Hc2KIRthenn2mUYNoItAe+1QGyTXNuIkM8?=
 =?us-ascii?Q?689jLRRx3exdkc8fb/hFb3A9LKr+Z+cayFWb+NI5tNBQp8YoXupmpJPJS/8Z?=
 =?us-ascii?Q?X7Ic2zw3J1IH36e3oWrTlbNGj+JguiDvDt7IZo1D5I3aYkV6UcN3mYECPik2?=
 =?us-ascii?Q?k6EPGuz9d8GFMPWKI4CfLHk0mkPpdrx2+idjHUxrchFnN1A47tOMv7/Fx76N?=
 =?us-ascii?Q?QBSJn5+nUo4YFqUR5hnMVh+cG/PiSJWW44mUCjwqTHkBmUd9yPTJ3VG7jFV3?=
 =?us-ascii?Q?xnv+8kZDTEtGSbZLObmh1Y0ecaexN9QZ0kgfu8zVstnoDYtedQxY+dsvoSFv?=
 =?us-ascii?Q?M2GYJDPv5Plo+jTGvMW9Uh0QXTWw18HBU40ctdxaUvmb6fyp97J3KlqVs0Cp?=
 =?us-ascii?Q?DSERk7BNjpQQSUR3wOGNq/5b6aO33joNbDVzNthhZhR0pWk59BQz+a+vp/Y8?=
 =?us-ascii?Q?EI0cEIPGh89FvRSQfrV/TVAd6IaWptajsdmn45zfDnYukI2T5wrAtFW2sosu?=
 =?us-ascii?Q?qgY/Ak31zRXYN+Ti+muGURbDxohak//3B0fSs43rN1N0P6x6XUXWtA7yLoHz?=
 =?us-ascii?Q?T79BrQxDRhFTkYMEi8C4vcA8zkPkouG+VZHfAmozXyMvh9CkIapBBTkYU4Uv?=
 =?us-ascii?Q?KA2D9hX4RyV+2Z+aYM7WQAugsiJ5sCxAgZA5GML0JcflSUDg5upZnquPIDXq?=
 =?us-ascii?Q?HdW7Tc6blWdJu4INHlrkqJ11bxR0BNnSh5ub3aN9rRR2pqIUPE07E0KPgkME?=
 =?us-ascii?Q?7z+uNGHAP0PfSaKyd5lYLXcBWqXm0I5mE+RdJRUliTdh9gIYRTkTWGBQJMNc?=
 =?us-ascii?Q?PU2joIn0geOnPSJD3cmARvbVQ1bfaFix+Xb1LV4oNZrZI9r9+InCkvmsWqne?=
 =?us-ascii?Q?3oPi4/gYo5X08hblnf/MbP9L9WsYcMgeNUJsNI/upuTVev2egIviBK/n+mn0?=
 =?us-ascii?Q?oiiv/xTMJK6Ut7vgWmhwtLtE9x+JbXQq030iaO6H5qkHxHTyP5gbijhzXB3D?=
 =?us-ascii?Q?9x/eemIVkZ0jmJQ0+Sg2Q8ozlEkQy7OdrQfOrvn6rbHtDvq5sRP4tv1SmMtD?=
 =?us-ascii?Q?s6h016gQYRIKTrnOnkpknXbIYi4uWJfQCsPNwO9oOV7yIEHQ0FXWBagjpo8+?=
 =?us-ascii?Q?bQbp+fx93Sy+IqntmLaGjRLmAZc2tiZIQRD/GNJmq7Uv8T0Rvjx275/KsfRb?=
 =?us-ascii?Q?7vfkus/HCvzPa5LM4rezcCQPw2q9i4OoFeXoB296DTSs5m3fXekeHZxOMbuu?=
 =?us-ascii?Q?5lexpBe2kDQW9Gtno7gcIJSDoH9WXMnzcUD7QGNi/vIWOrn2eS2hvBARyE5C?=
 =?us-ascii?Q?sFypPu38aulA63zdpyKBWUalRFXW4Xc=3D?=
X-Exchange-RoutingPolicyChecked:
	sA8O1Zu6ngvdIDv/aqDXNps+2L1g5EUFNOYQWUbPLMTl/of/Erpfu51zehUNp73Zf2typaJe7v3YaDmCLLM6q4yqYlgxbS7LcSs0sHyP6ZZj7nUi82Q+P31ov9AyJuGFX+MYfnqW/yKSYJy7k/P8sKbKZErgRYzN1885CFzU3gSChrdl8/UCAMz9b8VI7L7Z01lsvM5PG8QMaLaCgHYL3QCQoiz6wcIVeBqgACsCwGc1QOVEhqaRVcnEPycpvIR2utu38EcfbruWOBT6aKNcDcMhs3xgHS3kjHM7Qfwx+Rp8lunhbcYa2/50Dd8/I/NhQLW4HN2D23og/DNW5vShew==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mFK3i8Y9YlShubkmOG/7OfAiDaZH5WH+mWkae1ZbS5P8RXRqbGEAuHh3pDIdphOZ2YmOhuOAOowvST8n2FcHJGVrmmV/YrIpJqLut4dYDo+1oZm5SYr1T2rCymoi/ywZOpj5n/aJEgz72soEnIScaMZ7TK+iR5V2ke03I1SYfQ2G6lUDeSV+EbfSQvoKQfP5OBD3EQBWwLKddSADe3qJ/gQym1IycT1hCtu390UKzzTagpmpo1/gt1j/gsM6RZq5CXuxzhVzr+k/Tq5Cfn8NI2G84MGllJ3kDWz+94gWJcNDib+u4HPUfqA+UZzBL163LR5osmzYkE0BdtYC9NI1qA1pKMZaVZpZ7miP4d/3p5T3woYKEaTfpggbCzcADEqwy0qLsafImxtEeoQZdn9wVRt3X9vJN2DA2s4Q8PCmBup3CnRYKm/TBBH+gJ1x83RxuZhy0/HLUqnntKbY0J6UpNAHy6u2xApSOVVKwjgK6yHk4oQMh07JRZUtENkpyulzoEbXQCJMRVibR6M3gupT60h7yhhPiC4ZE/z3OVpsaKIXSpmOB1Z5EYipzjB15yQVjz0jk/fBt7LOMOnjVxiKPjZBdsft5E+VEyAMazrNijY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d522d824-9114-45a0-9900-08ded7d9f271
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 01:33:40.9772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9K9oX5EryUzVSO0elfqkkBfIvD0MYxQhdZVv1vdfrRWStaH3omMANBq73YhuCy6eZ9m11rIPsB0VPbptmgfeOVwDSfKoscGh3ckY5SsRu4Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7314
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 adultscore=0 malwarescore=0 mlxlogscore=999 lowpriorityscore=0
 spamscore=0 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2607020011
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDAxMiBTYWx0ZWRfX0FbnN52JE59x
 +dIjKdAeRzWypiGDcgHOcXRKCoDkE/Ie/PJBltR6u64rRYxu4zXUfjSowZL9nQb465Rot7bo6xB
 keegWyFfh6E87sKnmsGihdvGVLovkfF8eNFZoGh+xWA8wUuqg9tK
X-Proofpoint-GUID: oQX6RfyjE4ukXlUsB9ziyACWRqwN3mBg
X-Authority-Analysis: v=2.4 cv=OKwXGyaB c=1 sm=1 tr=0 ts=6a45bffa b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x0eKOSpe3m1H3M0S9YoZ:22 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=JfrnYn6hAAAA:8
 a=yPCof4ZbAAAA:8 a=1Vp-6p46HJp4oqU_kr8A:9 a=a-qgeE7W1pNrGK8U0ZQC:22
 a=1CNFftbPRP8L7MoqJWF3:22 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22
 cc=ntf awl=host:12312
X-Proofpoint-ORIG-GUID: oQX6RfyjE4ukXlUsB9ziyACWRqwN3mBg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDAxMiBTYWx0ZWRfX/7H2w3YIiyGC
 Yu8vwWuZYuCH7ZmbJGweftqXDhLDW2IgqA0s7Tz5VRKmuvCPQvLqzYEHDS9EtpZtltUR4zuSNPg
 3fop/uzsTwJWhzV9Nrd87aIK4DTQlU5NjeFFpXE8nsUxoa+Ady1slQh3CtaWGAmTDOfEMp2zVs/
 w+NN2R4G2NParhHiI6jSvBZrQmB1ODikToOaVioo3+t41/QmmJ56emQ/Lc16z6brAlS9vmr4BZd
 dhQbaJUre7rNP/LxRObiuUrUuvUKiKJuZyBt9x7227ECUN+7LIwnNxOv077YXHSB3e3I7wqcwkm
 hPmoCRxJT8pNZx1ayPkf3URJVBaIVbaNtAh710ftWWebUVAeCPXmm+2I+btCRSOeSHvNxYE1Bnr
 rZc7VMCfsDv2wrXFVFwEMoKBeNne1KI4AHI80dAJ6YYOp+rm+f/WC/6c3d+UisNi+Zw7IFFty3N
 7qybI83LAxUuDIc5yC28vItlKQj59gmJWkruZP5A=

Add smp_cond_load_relaxed_timeout(), which extends
smp_cond_load_relaxed() to allow waiting for a duration.

We loop around waiting for the condition variable to change while
peridically doing a time-check. The loop uses cpu_poll_relax() to slow
down the busy-wait, which, unless overridden by the architecture
code, amounts to a cpu_relax().

Note that there are two ways for the time-check to fail: the timeout
case or, @time_expr_ns returning an invalid value (negative or zero).
The second failure mode allows for clocks attached to the clock-domain
of @cond_expr --  which might cease to operate meaningfully once some
state internal to @cond_expr has changed -- to fail.

Evaluation of @time_expr_ns: in the fastpath we want to keep the
performance close to smp_cond_load_relaxed(). So defer evaluation
of the potentially costly @time_expr_ns to the slowpath.

This also means that there will always be some hardware dependent
duration that has passed in cpu_poll_relax() iterations at the time
of first evaluation. Additionally cpu_poll_relax() is not guaranteed
to return at timeout boundary. In sum, expect timeout overshoot when
we exit due to expiration of the timeout.

The number of spin iterations before time-check, SMP_TIMEOUT_POLL_COUNT
is chosen to be 200 by default. With a cpu_poll_relax() iteration
taking ~20-30 cycles (measured on a variety of x86 platforms), we
expect a time-check every ~4000-6000 cycles.

The outer limit of the overshoot is double that when working with the
parameters above. This might be higher or lower depending on the
implementation of cpu_poll_relax() across architectures.

Lastly, config option ARCH_HAS_CPU_RELAX indicates availability of a
cpu_poll_relax() that is cheaper than polling. This might be relevant
for cases with a long timeout.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
Notes: adds a justification for arguments taken in cpu_poll_relax() [1].

As mentioned in v12, I'm not addressing issues with potential timeout
range issues (around S64_MAX, or during early boot) [1][2]. These are best
handled in code review instead of overcomplicating the implementation.

[1] https://lore.kernel.org/all/7d2189443a0181a123e53e5ea93f3a905b1cb4d71d5d6bdfa27a77ed4be65448@mail.kernel.org/
[2] https://lore.kernel.org/all/20260608082501.BC5A91F00898@smtp.kernel.org/
---
 include/asm-generic/barrier.h | 83 +++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
index b99cb57dfccc..d53e75a92598 100644
--- a/include/asm-generic/barrier.h
+++ b/include/asm-generic/barrier.h
@@ -273,6 +273,85 @@ do {									\
 })
 #endif
 
+/*
+ * Number of times we iterate in the loop before doing the time check.
+ * Note that the iteration count assumes that the loop condition is
+ * relatively cheap.
+ */
+#ifndef SMP_TIMEOUT_POLL_COUNT
+#define SMP_TIMEOUT_POLL_COUNT		200
+#endif
+
+/*
+ * cpu_poll_relax() stitches up two kinds of primitives: ones that provide
+ * a momentary blip in the pipeline (ex. cpu_relax() on x86).
+ * The second support waiting for @ptr value to change, coupled with a
+ * with a precise (or imprecise) timeout.
+ *
+ * cpu_poll_relax() keeps them together, because its utility is in minimizing
+ * expensive operations while polling on @ptr waiting for it to change.
+ * The arguments to cpu_poll_relax() are only needed for the waiting
+ * primitives.
+ *
+ * Also note that platforms with a suitable cpu_poll_relax() are expected
+ * to define ARCH_HAS_CPU_RELAX.
+ */
+#ifndef cpu_poll_relax
+#define cpu_poll_relax(ptr, val, timeout_ns)	cpu_relax()
+#endif
+
+/**
+ * smp_cond_load_relaxed_timeout() - (Spin) wait for cond with no ordering
+ * guarantees until a timeout expires.
+ * @ptr: pointer to the variable to wait on.
+ * @cond_expr: boolean expression to wait for.
+ * @time_expr_ns: expression that evaluates to monotonic time (in ns) or,
+ *  on failure, returns a negative value.
+ * @timeout_ns: timeout value in ns
+ * Both of the above are assumed to be compatible with s64; the signed
+ * value is used to handle the failure case in @time_expr_ns.
+ *
+ * Equivalent to using READ_ONCE() on the condition variable.
+ *
+ * Callers that expect to wait for prolonged durations might want
+ * to take into account the availability of ARCH_HAS_CPU_RELAX.
+ *
+ * Note that @ptr is expected to point to a memory address. Using this
+ * interface with MMIO will be slower (since SMP_TIMEOUT_POLL_COUNT is
+ * tuned for memory) and might also break in interesting architecture
+ * dependent ways.
+ */
+#ifndef smp_cond_load_relaxed_timeout
+#define smp_cond_load_relaxed_timeout(ptr, cond_expr,			\
+				      time_expr_ns, timeout_ns)		\
+({									\
+	typeof(ptr) __PTR = (ptr);					\
+	__unqual_scalar_typeof(*(ptr)) VAL;				\
+	u32 __count = 0, __spin = SMP_TIMEOUT_POLL_COUNT;		\
+	s64 __timeout = (s64)timeout_ns;				\
+	s64 __time_now, __time_end = 0;					\
+									\
+	for (;;) {							\
+		VAL = READ_ONCE(*__PTR);				\
+		if (cond_expr)						\
+			break;						\
+		cpu_poll_relax(__PTR, VAL, (u64)__timeout);		\
+		if (++__count < __spin)					\
+			continue;					\
+		__time_now = (s64)(time_expr_ns);			\
+		if (unlikely(__time_end == 0))				\
+			__time_end = __time_now + __timeout;		\
+		__timeout = __time_end - __time_now;			\
+		if (__time_now <= 0 || __timeout <= 0) {		\
+			VAL = READ_ONCE(*__PTR);			\
+			break;						\
+		}							\
+		__count = 0;						\
+	}								\
+	(typeof(*(ptr)))VAL;						\
+})
+#endif
+
 /*
  * pmem_wmb() ensures that all stores for which the modification
  * are written to persistent storage by preceding instructions have
-- 
2.43.7

