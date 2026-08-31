Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798EA394EBA;
	Mon, 31 Aug 2026 20:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788207828; cv=fail; b=bxrz732GXK4rAxSTZ9CwtA7RPp6z9pcJNpJSzdDrYv1LQRPivStutxehHS9mXHc/K53ryCS9URiMhCXHUG//Eg+tSoHxc5VN2f4FFnpVieGO7mWtokrl1/H6hPDKgRo1akZjwar0/68cGmda2dz/vl+QQBK1MIL07cwN/BQ9kXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788207828; c=relaxed/simple;
	bh=yw6zIiZnrZULSOqxioCTns/sFf/1ZCpWDOh9BSaA/CI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cAuyPf49mV0zPK3LtfLXRfEMO37Y/127J4/XLCObwsmyHqwzERl/bEpbHI1niSoYsT2rntQIrCDBEp7pPUwdXyVOKV5UkuZ2L1fuKn7nRFXehRb3HCSjWswaG2kS19VkwygbL95Q+I2r73P4MtKVZhtN/edjswBAg3GSFJfiQTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FRn0XvRw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NtnSuIFJ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FRn0XvRw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NtnSuIFJ"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VGBnHA2332825;
	Mon, 31 Aug 2026 20:23:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=6+mT8x38yrV66x073641HB2W6EifwrcZYnsp3oa/7t8=; b=
	FRn0XvRwTdjspstsd6RYiDwMNfmUNUJnpMHK7dUfaQ8UAUsyJFJAtOsbdkXio3rb
	BOZ//R1gng6CFRwP42oVQciQxJP0ZOK7oz0JfT5/ojvM+lOod7paaO6OgnNG5YBM
	dzfjJAWSTJ7shMqtHYRTN8X4cuKIKZdkUn+d4J0HaCeSfjho6b3uMUKs+WrxdtQp
	nk8JLr0WZyFQg/vXvWLsHuZu6tX9Z7VtBsOH6c0LmdgGG+pZsuwyrYwnzf1i0YRv
	T6wwLQQPAZnXTf+7+mUKlp883dOk36Lqkf5k17CS2P+5muPep/mxb06MDbV0Jedj
	pmZbtpusdQ496czx6ZHHkg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gbpbaudy1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 20:23:07 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 67VKFXd7003016;
	Mon, 31 Aug 2026 20:23:06 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011044.outbound.protection.outlook.com [40.107.208.44])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gbnvpkd8j-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 31 Aug 2026 20:23:06 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=StNXpTuk/Dc70frZL6KA9vleXw/42brcKrydgTWAOKQUD+apR3brjMuzt5V41To0zhPxPXC6HtuZjnsTZce4efLgh3wXwL3NpSqMvKWToUSUOVd+u77hCyZlrboDwMdWtjKT9OmQSqwbOVIxsS0L73lQbg1geudWZSGjHjdX2PjnmMrAWkijilR35Ql4F+5x74eR0NtnyqMzEzpthZLKGf9oiLB8cHzBVZEV6d/7/8z7qThMBLp+WDkKsoRrvMX6gf3dckwEvY3gUZOYYgpmVMC5/B/T8QWh995wcUDZbn3757juX8saNtB3M6Ydr1mxH3IN180LfqtFdwZIo0TBpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6+mT8x38yrV66x073641HB2W6EifwrcZYnsp3oa/7t8=;
 b=lJKtuyWcqsjX59stQZ8GLA1hAfQQsb8ibkV7kyPrI76t+JX8Ye/fSK20ZWT5qOgRAsOT2Bwa3NOxWTtRZBWzT81wR+6d9PgMYCEGf+JzZwrW7ZCWmCjmQozedDLXjy8q7dqfKLhEEfgEjmSorR/iFtaJJ+O0JDzu9v2hdw+yH8tdsWLiPrZgbg5U2aMF/4o+QD8fpA1lqhc95qlK1bC/e0DG0E537rH85M2DKyNJXGebwO9dq2nu/xQDMao8lK5MYxuIObBHInJJKcXqJFif4Drsz2ysyzlyXNVfQA8Kk532eLgqtMEvPS/hV2tW+ZkDztlqThxqYf8i1oxgejz44w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6+mT8x38yrV66x073641HB2W6EifwrcZYnsp3oa/7t8=;
 b=NtnSuIFJng1mfv0TUjAh3t/juYBS+6b/knwmzgTiX8UPNj67ySaYye+hUvh2zqU+VpnQ5pxYB6luSJ4fImk5FvzEavZSIDjpHsWQKwKMOeQzI9XyHm8rbd/eIvvDP15/RSNaOSd1U/93+97aDWWaV48osiDiR+pZv+DKjTPxcgo=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by PH7PR10MB6179.namprd10.prod.outlook.com (2603:10b6:510:1f1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Mon, 31 Aug
 2026 20:23:02 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.21.0382.007; Mon, 31 Aug 2026
 20:23:02 +0000
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
Subject: [PATCH v15 05/16] arm64: rqspinlock: Remove private copy of smp_cond_load_acquire_timewait()
Date: Mon, 31 Aug 2026 13:22:40 -0700
Message-Id: <20260831202251.305046-6-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260831202251.305046-1-ankur.a.arora@oracle.com>
References: <20260831202251.305046-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0236.namprd03.prod.outlook.com
 (2603:10b6:303:b9::31) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|PH7PR10MB6179:EE_
X-MS-Office365-Filtering-Correlation-Id: ad22f88c-c04e-46f1-3f7c-08df079da870
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|7416014|376014|1800799024|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	qFG83riT2OiWT8+cjEhMP5C6tXj4vKiS7TYoI6lbjHDI98Jda1MCMO/qErILM55xFKl32gqGDJW5iw6aNxDar0dFijPmeCrRfA+CWZEOT0bnnk97SUUO5KA8PcV5P4MaWMAwa8TzSR3MtyEMEcM6METcubf8N7//CPi7bJRyKK0oG2HJ9tt1ADpMT0Of9dk4S2YS8yDyPqXA/jOM3+UCAymMnxglj+lox0L2n4ou70tJXAWGtz8+tVley/uCoyXXsdgFKjbbd2P9b4gbzVLaIiQ8KP9LAI2Oe1aDeWRGNVGojzaekbuwHdTkuvdARYcQW6EbZprc/TgntapwYl1IgLBL1ApLM1hWzWXggtUUf7JYXZuHI28wFDeLVv5cyItYfNSq/nAbxcBTUyt82Sy+XcIZBNz5V6vj3FtyI3C7mwklTdqHYFcZv2frh4VZepJZhpfZli25I5DJUQ/7etpqzZTJ1cP0nTznFyg9RtZM5Bp0w6T4GVrCRD6GeZVmsCXKiSssG7rdZUXPJPKVBTYzFYrVs4iQJiUICRPuVcuvhVqVZUE+W44MC8jvOkM2pjfNuoFFs+aw1KSSht9hzS3vLECQirvMk6rfh+0v0n8WcwqCBZjxX18bKBqNkueEH5GRuJraGAYjX89+wCzsl+qGMtK4xLJ//Lv1RZdFjnOvM/w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KlC0yvrFpPvN8JfQPilUWa/lNtqM4JmNdcIRZd6B1KmdTTNEMxkO0mOsge/R?=
 =?us-ascii?Q?pFjXNeF5D4WEvs0NCd49TxuaDmDEJ1fJZ57VoMkPIDerz/MJBY9afvIEQjjz?=
 =?us-ascii?Q?L2f1ZnkEs8ho+qQI7b81yPbfVwztNWraNm7r9tjrLU9EhiXrQHumf2kaxGvM?=
 =?us-ascii?Q?pirJZe/GLLxr1j3KeU36OdJ3HniDjbpAMsfLFyA72xhaBxNoHnE3XU9MbzS/?=
 =?us-ascii?Q?947iZrE6sbgZnahch2T2Ua8X/P4ptZILNzY9kBRWm1M81qixGenvvBFzdBhQ?=
 =?us-ascii?Q?kgTXQKVUKNe+uYGNwQcM7kz4x0xCV/B82dGdtiJWz+3X2jlkd7AfSm8gywrY?=
 =?us-ascii?Q?89dPU4yGfFOln3wguX+zBkuUKJ5QB6v7g1440SIAULyWrMlCVrGE0/45YXiR?=
 =?us-ascii?Q?AvgBD972X9BFrwK4K5SH9npfk6wL0ja2hIkrdzBHPuYYC9pb1P/DTWORhlCW?=
 =?us-ascii?Q?DsfFCiolGtyRdQ1QP7LMpfxEtYu4ho8CDFgVAE4UfswucL0Urh/TWbZr6C/3?=
 =?us-ascii?Q?OLCzXs2E+36uNn08LSeSwYFXTOd+muJMiaA8xu+6R2ZNeXi7zraglOl6sesa?=
 =?us-ascii?Q?CPvU8ZZkDZYu0KCi1DaL91e5WWikLkrbAQsOQ/+JuYmtZwTPAgqjcsaD5Ofj?=
 =?us-ascii?Q?Xjz3HC2N2upkWRkH7NHy11/KhMhYgyTTk4pcgJorlexzvn7vTc0ss34p3Eoa?=
 =?us-ascii?Q?dAJQN7P0CFF3zR+WROBZC2Aj+nRKOyjSiG3raQn+871miQxeAe7sN83luRkQ?=
 =?us-ascii?Q?HRCgghBAiYQMWuxfcSDVLkOt5OJVwyH8G7iy6WIsnlhpfUDP3fXzO7FZf35R?=
 =?us-ascii?Q?yPFmHOCDehix5ddgUQsVtVY9DoTTPKNrZqSzE9mG+IrJaP7LNHGv3giEQepY?=
 =?us-ascii?Q?dRSnzlbCtX8WS7YU+WLOpr+YXMuBlp0ZgRc30HXQS4QNuU1pWZAcqZKmZfa7?=
 =?us-ascii?Q?LYW1IylkxWmtsTc9pRhRHGzj9eDwqkknLKrsV//X7mOSKzCEc+f8LxMshaTu?=
 =?us-ascii?Q?1XFjpfNZuRpPoGwf9KFC6Lq90UAOuvx/L7x+JGlqsbx7MCF2gAT0q/Vo8dRY?=
 =?us-ascii?Q?3qAtoKrYS1/sUKSs049ZXubLKEX6WfQf1fN+/LvZMQiRPIk4nbALNHubAIUY?=
 =?us-ascii?Q?CqPRZbBV6BjhoshGp+chsnEjkxy+dNHL3a2nErVh21pVoC6m95M0rRDhZD+/?=
 =?us-ascii?Q?uSIifmwvavSoa1kNC/i5R4Rwk4lTLSvWYJlDQhOkMLgDtBYizcBzPfGpJ5Cs?=
 =?us-ascii?Q?+K2NWTCGUw802SFWGs71K/nTjiojNRhlD1O0gesTo7r2G+cX7MAIRO4IUhoO?=
 =?us-ascii?Q?q7HYbGfDYxjrGtnPDJTOtldlqUuYAX5cYJlA2+M6stNTru9C2VB+CxUDzuhx?=
 =?us-ascii?Q?8sIg7zM5J8f2AQfrByw68ks35KDP0zxwzbQ2jtkM8vnlhxTUg8jNsvSEqhfe?=
 =?us-ascii?Q?g738vcWyF3e4uZrJ8M1MpmolVpM64scjb+3GsklKO38AYg5RfuTHduTpYVbI?=
 =?us-ascii?Q?6C3RTTf4aqAp0gRyM4V7zysgLO+tJ/iQoffAayhaF+oJQun7qi+6s1IAnfBF?=
 =?us-ascii?Q?9uzFPPJ9DTlh20EeCfPKkyPxxJfNVdDnIQA71e5UgG1n3qcunLV4miCUzwdL?=
 =?us-ascii?Q?EJ72LN8ArUhDMYxnJ1fvTzDSyeDZ04BIOmw4OS4a18KSKl2tDOWJQHPe+Y+u?=
 =?us-ascii?Q?x3MbuqSEaspL2iAhJWz7ER6vyCE0grcdwbLYN6/9zU0US6GLX13257VB1n/f?=
 =?us-ascii?Q?xaXbU1tcDpLc2vFfSymkS+t1wdH4m6U=3D?=
X-Exchange-RoutingPolicyChecked:
	vP2yz3C1iWS6EA2vSGEP+J7r78/ASTV05kJn6UmMvN2x135e2uAj8+WQupZE7J31F7lOGD9Dpozmw7MfxtFERITV+Fx8gMX0OY4ylM9AxPlC6C4HCpPgbvlqdZTdN3Wu4fh5CT1+xN9wRmJuDYXrxJEOpEPtFHcUaF60U1ZgzjlrQl2WzvwF5cgWwD7+N2ul5iGpk4yYjcmACGM9K4sAXURUURH3sV33Q0FyxD/fj0hzw3Xj+XX/IjBtvospByqe/gm7YcvIdkNHqrBkbaggTFSDjEfsiajp/+MTNjzmT0OTnPU0i/avyrH/q+pGJ4D0DePG27vuozPZ+KAr21NfgQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xghsxVfWIQFIVztRPm+th10IkoAu/Y4OFQOT/nj+Gei/IajrO0X4O+sq/yeLQB0Y1R2G+WXrNSZuMEL7fVeuK6R8PA9PQSIyJ22lGCIzZyY6DMy8Ow1eQ1N4AHb6+3Zj8qJjGqxd6H6iocPP1NEexg3BictuTLD/OO1TfHiPYEoC0jIGH49IgVZWWZjp1qLu6zSIi29WwpumUOLj+6aOGeUMIY3jO5ucEErn+usfm4xfGr4tjaBW8PN4OKgtXDIfQVlFjNw8bME6R/hzUjgOJlh2bNBDGsoR33y2xLEU4lTHMWz+VUHR+wQZDOvnb6+5MQKPyv7a3pYXEWvFtlr7kveoHjLJwjQvmB4TWErvfG79x086nRlfCLrnY8eDo24UzDQIpEyi1InwRG4vnqFeJBB6lWJJaWmcS5hGgVDH1TifQNbj1PkS4LuvNEoJjJLabwdqEccctWzYlYvht36bP2+89dROGX4vgPdcytqoKPaxXqDayG/lkSbaQRW1uf5tg+6Y2NJJ2SALXaxrRDxd7B0zy69U0KCvNzuuibiVz2pBEFlGFgm9JVnu2Vn1uu170ep3YTo4aZp6rKzIg5maAta1qeFD7UcCSBCxljXQGvI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad22f88c-c04e-46f1-3f7c-08df079da870
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 20:23:02.8013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VykbuUWUER7PWCsACi7Eny9zUS7L8vfpur2Ng/faa/7VcquhVc/vSZlPmaZoSo0mTOrOqJB+TvKKicF93yuglmuxji8ixMgfyI93bjCamhw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6179
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_06,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2608310175
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDE3NiBTYWx0ZWRfX+vIajX0A+m5T
 tsWKlREIcqubesaXuFSI+YHToHskaHNqjEFXHJIuNEhDMuFpfqIqfw09boD4gavrY/MnRkMixYp
 Gt06JpGk2JFJpEsS8KOinVdipXCwETOS05zXAWPQdLa3+kIKDPGA
X-Proofpoint-ORIG-GUID: wMscpygXWz6eHd3J5hubafG1UEMrz2F-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDE3NiBTYWx0ZWRfXxsq6pONCZAcF
 Ut6VF58bloUdSWts4x7mynlOiGaIjos1epxXVXz2ZhSwyhXUUS9Zj7eQWM647OIFNOll399N7Yg
 Ha4Nuam0wfGbwJ4RycAYn7X/Dye+OU8d5ClUsLreooQtPb7sb5ElP7IKHGAmAKcoBnDtw/8maa4
 8/9/qg+uUtiX4SiQhvF3clhzpnolojiRL4hHn9HXPeQa2zi82W6+KZn5SFq5y5wl42udhq0s6my
 zSeSHLNmd0Kk9qSxZacsQNawsV4MyFOwkCq+oxlY1mKXe++Jbgpkdmk4A97NZrsduhRFqGpkF4W
 64cv1LPhiByY6adSM6PHYQ9CcdyRuXCHiWw8zUm4InFzuSLzYblDEJxTdeq36ECwSJs6ZtU7s0G
 iFOfgJOIMBb4kEHvbj9BStTJpayGn+nPb4bx3N0cgl/Ij2C71w9Fv//LwsghxPOMxHGBIzBks2X
 WqjsmQN64ZJGtuu3swkWJBHmUP/lZQzlmx1jap5A=
X-Authority-Analysis: v=2.4 cv=DMi/JSNb c=1 sm=1 tr=0 ts=6a95e2ac b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x0eKOSpe3m1H3M0S9YoZ:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=pGLkceISAAAA:8
 a=7CQSdrXTAAAA:8 a=vggBfdFIAAAA:8 a=PuvxfXWCAAAA:8 a=pMBjG9WjWPNDpSeUJj0A:9
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=uAr15Ul7AJ1q7o2wzYQp:22 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12102
X-Proofpoint-GUID: wMscpygXWz6eHd3J5hubafG1UEMrz2F-

In preparation for defining smp_cond_load_acquire_timeout(), remove
the private copy. Lacking this, the rqspinlock code falls back to using
smp_cond_load_acquire().

Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: bpf@vger.kernel.org
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Haris Okanovic <harisokn@amazon.com>
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Reviewed-by: Christoph Lameter (Ampere) <cl@gentwo.org>
Tested-by: Haris Okanovic <harisokn@amazon.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/arm64/include/asm/rqspinlock.h | 85 -----------------------------
 1 file changed, 85 deletions(-)

diff --git a/arch/arm64/include/asm/rqspinlock.h b/arch/arm64/include/asm/rqspinlock.h
index 9ea0a74e5892..a385603436e9 100644
--- a/arch/arm64/include/asm/rqspinlock.h
+++ b/arch/arm64/include/asm/rqspinlock.h
@@ -3,91 +3,6 @@
 #define _ASM_RQSPINLOCK_H
 
 #include <asm/barrier.h>
-
-/*
- * Hardcode res_smp_cond_load_acquire implementations for arm64 to a custom
- * version based on [0]. In rqspinlock code, our conditional expression involves
- * checking the value _and_ additionally a timeout. However, on arm64, the
- * WFE-based implementation may never spin again if no stores occur to the
- * locked byte in the lock word. As such, we may be stuck forever if
- * event-stream based unblocking is not available on the platform for WFE spin
- * loops (arch_timer_evtstrm_available).
- *
- * Once support for smp_cond_load_acquire_timewait [0] lands, we can drop this
- * copy-paste.
- *
- * While we rely on the implementation to amortize the cost of sampling
- * cond_expr for us, it will not happen when event stream support is
- * unavailable, time_expr check is amortized. This is not the common case, and
- * it would be difficult to fit our logic in the time_expr_ns >= time_limit_ns
- * comparison, hence just let it be. In case of event-stream, the loop is woken
- * up at microsecond granularity.
- *
- * [0]: https://lore.kernel.org/lkml/20250203214911.898276-1-ankur.a.arora@oracle.com
- */
-
-#ifndef smp_cond_load_acquire_timewait
-
-#define smp_cond_time_check_count	200
-
-#define __smp_cond_load_relaxed_spinwait(ptr, cond_expr, time_expr_ns,	\
-					 time_limit_ns) ({		\
-	typeof(ptr) __PTR = (ptr);					\
-	__unqual_scalar_typeof(*ptr) VAL;				\
-	unsigned int __count = 0;					\
-	for (;;) {							\
-		VAL = READ_ONCE(*__PTR);				\
-		if (cond_expr)						\
-			break;						\
-		cpu_relax();						\
-		if (__count++ < smp_cond_time_check_count)		\
-			continue;					\
-		if ((time_expr_ns) >= (time_limit_ns))			\
-			break;						\
-		__count = 0;						\
-	}								\
-	(typeof(*ptr))VAL;						\
-})
-
-#define __smp_cond_load_acquire_timewait(ptr, cond_expr,		\
-					 time_expr_ns, time_limit_ns)	\
-({									\
-	typeof(ptr) __PTR = (ptr);					\
-	__unqual_scalar_typeof(*ptr) VAL;				\
-	for (;;) {							\
-		VAL = smp_load_acquire(__PTR);				\
-		if (cond_expr)						\
-			break;						\
-		__cmpwait_relaxed(__PTR, VAL);				\
-		if ((time_expr_ns) >= (time_limit_ns))			\
-			break;						\
-	}								\
-	(typeof(*ptr))VAL;						\
-})
-
-#define smp_cond_load_acquire_timewait(ptr, cond_expr,			\
-				      time_expr_ns, time_limit_ns)	\
-({									\
-	__unqual_scalar_typeof(*ptr) _val;				\
-	int __wfe = arch_timer_evtstrm_available();			\
-									\
-	if (likely(__wfe)) {						\
-		_val = __smp_cond_load_acquire_timewait(ptr, cond_expr,	\
-							time_expr_ns,	\
-							time_limit_ns);	\
-	} else {							\
-		_val = __smp_cond_load_relaxed_spinwait(ptr, cond_expr,	\
-							time_expr_ns,	\
-							time_limit_ns);	\
-		smp_acquire__after_ctrl_dep();				\
-	}								\
-	(typeof(*ptr))_val;						\
-})
-
-#endif
-
-#define res_smp_cond_load_acquire(v, c) smp_cond_load_acquire_timewait(v, c, 0, 1)
-
 #include <asm-generic/rqspinlock.h>
 
 #endif /* _ASM_RQSPINLOCK_H */
-- 
2.43.7

