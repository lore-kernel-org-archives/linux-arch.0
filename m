Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270EC3793BB;
	Wed, 10 Jun 2026 06:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781073917; cv=fail; b=sFc6pOlshtIInlW/HWrkueHypouv7keuKwAZLVYrhDzCUiqpGLKmAHLxHknARO1rr9KZ0koqgsX9i2p662/c/rLEk+tQqrKhDxfRKDTnruBZOilG4j3RO1KAmVpa/xxmsLFrhARW2SWcyKPx+oTyjtupjzb8wQlnDH0oJcVfm9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781073917; c=relaxed/simple;
	bh=hTSvNpvpxunYGbmkNxe6cT858Mc78iYEmio/w/pdp8U=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=TKC+jVgWhkhdd/UCJIf4BD4GzztdatJ+etMSltvRO1bUwtRLHwjdNy0DzTg9/sTiYt6V7YzaUsM7TooGoOnVnUIfJTlFeCoykTf+qJjbeRHxkD80jF3/0R025lwmshYRc1eShA6Rk5r3Bhrhc0EBeaPNrFRcyb1PKWl8YWzSmFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=p9eaEYWV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WmrbeLfd; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="p9eaEYWV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WmrbeLfd"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65A6Mdio1108171;
	Wed, 10 Jun 2026 06:44:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=UEPXwUACgZrnZy8598
	4ic3bpaGm2BFBY0E3Q/1GWWm0=; b=p9eaEYWVAdioMVrWsWuR2i7CHAbU38aRVC
	gUJygTz4358kjG55YcEV6ooYeLHrA/U/QsmtNefrJirDYwF2UUasTh6uRk76KDhj
	vDgKX/NhEg+Lq3SLO/lsGMfVsb8uaooulSLBbrbj8MidbUy8SMsnmnIcjifT2UZz
	KbnVYvJQB+Z6ERWmfOjsGIxskui8is5VnYQo7OgeshymlYaXnGQg0NRR+UR/Noa6
	QhViq0qyDE+WTwc+zJYwLbPBwxozzAyvd38B5tkZLb198s1L/5dECMEJrSMyYr4T
	7hJwroRjub6IuZN1kvC+HXAj7jj/Ru9qzykwpXhfY6cheszR5e1w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4emb5sx07q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jun 2026 06:44:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 65A6cQ0t015956;
	Wed, 10 Jun 2026 06:44:41 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013015.outbound.protection.outlook.com [40.107.201.15])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4eq2ncgmy5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jun 2026 06:44:41 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qu7XvqkFXbj9Af4y66ah0NthqbUPff9QtCNM5gNzOJAaAPKZwNu2yMOuq8wfrv6JdrBTU87ZT3LN8Z/pDuDsY1P5KXb6N+cTrf7ofZA7cKGKfkB6TIn1cZDHdHG8JdGS8c9Nx0KUY96YkJ/OrTcwFrliWGWTdeKiau36KpK5fzq+vX+jpVVzuxrh/Lkv5/lS56rydR8pq6kutXYPFl2z9tL9FIyVriWleLNNuT7F2s4469C+b5DOGavTynKczsigKc6hBQkgVAohq3o+AClX5psGLTw0fImzMsrSDhi1mTnBGNGkGVFhkT+HEbE+BS3dtV6oAJKyfFi+lIjHzxRTSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UEPXwUACgZrnZy85984ic3bpaGm2BFBY0E3Q/1GWWm0=;
 b=YXWB3C0/sQNwIRonJ699j+C0CV4IIa9KSfugJacqyCcaPrJc4Gjfng5DVX33v3NZt7i71a2fAfELamXwHWxYtz+yTjdTvH97mVzUTu6I8Hooz66UUsEBmWeF1Cd4ZBFB6kD2B3dILY8UfKl9bONq+KYhI8uwsb4WtOwrU9tSe2fdIeywpXqZYoEF3bWUOL+LtqnX1XGZrSXjYONRybhWCC/G1avr8ZiRZJ+afkBx/mWJM8LLTY6zZsWK5r+5s2NELAJ+evLjC5ozXKuigLoug+N0gUsKnPIgjyRPFJ3wEVUK2zbJQZws7nMfAHrv9IwGX2RRrxgBbj9B2yROzPYyfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UEPXwUACgZrnZy85984ic3bpaGm2BFBY0E3Q/1GWWm0=;
 b=WmrbeLfdFXD82eTrQhLBwSQNuQQZchBYXCkWQMFwmXx6JJl8aY+vZl+nLG6RPhTwgopJuPc+rT3OO5LeLizMqnEOOA2aplXjppRVREZXWw/4ijDJnHtVAO7YU/EPWl803pUYcGPHr7mPYNBaWhoqp6kUp6FeOUIsec5g53kU+b4=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by PH7PR10MB6377.namprd10.prod.outlook.com (2603:10b6:510:1a7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Wed, 10 Jun
 2026 06:44:34 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.21.0113.011; Wed, 10 Jun 2026
 06:44:34 +0000
References: <20260608080440.127491-1-ankur.a.arora@oracle.com>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        bpf@vger.kernel.org, arnd@arndb.de, catalin.marinas@arm.com,
        will@kernel.org, peterz@infradead.org, akpm@linux-foundation.org,
        mark.rutland@arm.com, harisokn@amazon.com, cl@gentwo.org,
        ast@kernel.org, rafael@kernel.org, daniel.lezcano@linaro.org,
        memxor@gmail.com, zhenglifeng1@huawei.com, xueshuai@linux.alibaba.com,
        rdunlap@infradead.org, david.laight.linux@gmail.com,
        broonie@kernel.org, joao.m.martins@oracle.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, ashok.bhat@arm.com
Subject: Re: [PATCH v12 00/15] barrier: Add
 smp_cond_load_{relaxed,acquire}_timeout()
In-reply-to: <20260608080440.127491-1-ankur.a.arora@oracle.com>
Date: Tue, 09 Jun 2026 23:44:32 -0700
Message-ID: <87h5na6gj3.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0142.namprd04.prod.outlook.com
 (2603:10b6:303:84::27) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|PH7PR10MB6377:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a471dbe-ab11-4f97-e7c1-08dec6bbbb6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|7416014|1800799024|376014|56012099006|3023799007|6133799003|18002099003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	xgU1CZf4cl/6D9/OLXBuh2kaoQBYbPZNK1nLD+iiZ3uEbkfQEQgdRsp44DJIqciWa2s/pG4z7SAzGfNOADIMIMdY69msD25VnolLMJv8JdaA1Syvi+VmEgNA38x2ko3AGxWX9Up+Y/VY8HGHWsIpC8CF3rfNGyVrONXW6WxM2fvlej9cJKuEpDzQW3VcBaFWoQ4vxnZ05GHakMQtrkOo5pyz4Tw+aNAvXhmNqKD/t/HtvVOHz4EnmUkgDw5bg+CGTWmT1mAMIUrEsQ6zxaSG+11T9ti7vIeKah8FBtL/kKFC4WaSV29c+WixzcmJzjXL+ZYJuvY8X3sgoAbgh9G8lQkC0Tmohjt3Zs+fV49wbGe2wVxuPh1TUUDSrQvPVA/peBXoaNCUE8LVgymC0WRO5kpV/DEVLWYQg9e0Qk62Z4LSRdIvGDAP95jBwvqnBjzwhDG5vqJWiwYZRxTFdhOzCUXQFwFB2oZNmcbxvBlObxHA1dpicGgRoqq/7qUhuT194SfylT/H/jeSddLfGGxbXjRM9TaehEZYgX7/H1qzBhKvIQBbzHKfmvegsKbl2ZMhmBs2gBO9eZ44FPSmsZalAFA3GO6ZN179N8jkrdTRcrAzTAkpZNoLu+3m54Dbwc7SlOlVrra2f/rucMl9kF9tFAI+pgLZWKuldsHI/vSejMgYVBj2CKw16UWG6Mi2SdbX1r51NlLaBiIG4z77HaqRxg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(1800799024)(376014)(56012099006)(3023799007)(6133799003)(18002099003)(22082099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4FjaYIYrFiqJV5uBeRVpk+/st0mwdyF88QCW9tXkZFdQaM47k8K9aQAZK1qY?=
 =?us-ascii?Q?qeWaVixCtHftAr9R0X5FfW8FjldKNxKEgecAVIR5QluQuvUfOv+dRZMFiZOh?=
 =?us-ascii?Q?jMv8Qv2T6FE5eLfMaRMGspnyObRuEiMTAxln/t1fsQbfrZOl26hZqpMYexJ7?=
 =?us-ascii?Q?dtEQfAQ00nM1mwq/nCLVMbLfpYSHf6ESu/y9FlESUuz0s4AVP6iIJ6kBNWVM?=
 =?us-ascii?Q?BheRSwqN6NKMHQACzB6BQLnHYEgv+AhOU9xwdNn+g3J0TnotyXTC8iHSrZIK?=
 =?us-ascii?Q?4u1YSq/Pnjv4TQJMWWhumTMjZMiE2V2AmeJkSjlTNOKgp2+WNDqzC/5o1c31?=
 =?us-ascii?Q?d0NUOQ+11PkMdcLd38e8v9M4AIRX2QQjdmBMWSu6t2xVSAGY3S1QOaqEh8bB?=
 =?us-ascii?Q?eTW9n4cTOMw5QtCLaQr09Ayect5vktKZBciECG0iDNdA7itvSysOKg78Jhdy?=
 =?us-ascii?Q?hu/Hyz210yctZNWiYaKMgSq5j+NsLwOJoR4juye7z9EP+yUMITGRnPEE7MK3?=
 =?us-ascii?Q?Ad8wDkSid/IaZhTwJGG/Ex0vtlPfkgXHPD3teR6ela5zbSdtBbUjLegUS0kL?=
 =?us-ascii?Q?nzVI93iLFT+2/ndJU1lQwO9sRii2ZakQxF/INNN420kCe6cOW+BkLmavAREW?=
 =?us-ascii?Q?wrftnoNj1Bg/x3hHi6+6dRnCipWuL1Rgi11fGP0SDltosNrD/tOWbjL0uoX6?=
 =?us-ascii?Q?fYe7f2SviXBkZK596l3omP9MyN8uwiY7I/6n2NEJv+06x4lMayoiLyj3cTKy?=
 =?us-ascii?Q?ggWD7hNAf6NA5FUs8LS/Zvva21D1ZzvPQZ/J+A8S36J6/8mzo5uMMTxIUQJv?=
 =?us-ascii?Q?RkBN/o/ANVJyZOXpSgYxLOYOE6YqgMGxgdgHd+vdx7pVwxvnWgBf/R3sEX4q?=
 =?us-ascii?Q?5ZVd75euG4msOKLQceFu94t02d6vd/Q0cSglAxTa0gz1qkT/6EKid3VJe61G?=
 =?us-ascii?Q?58ggW5SZRR78pVxwa+oU23qOvBCet2cEE8VINZsqu60VnZL2Ckm/S9SOaEVx?=
 =?us-ascii?Q?lBdk4B5RjavoEF+r9PJTw0TA0PlRwjL4DNncx5Qaa0pgPt9s+EIRtCpywj2w?=
 =?us-ascii?Q?7x/0+TiSUkjwntgTQTu8iqJeZKuyul88LL5NG3FhAuk0wg8fcwqeAha7bBgO?=
 =?us-ascii?Q?YITTeivplEcMMqT0n1ilSKZgXaph7D1qfDHAZ7J8DhvMQPmtfFO7/fyTJow8?=
 =?us-ascii?Q?WyF4yEhEcWZChA5iXan4syn5MdtkwWhuMV6qj5zB9uL+Wj1gWg7oXVkJCeox?=
 =?us-ascii?Q?SNU5/xWnlS+Ks7e5r+ZCn02DHLM5oAoyxHD7SqRpXl0fgSPhlXGL3Xwq0F0v?=
 =?us-ascii?Q?FrjZWOHewzCRrGugZ1r6zXdkmOKHgfXnasDtg6icEEvFaa+8JXEulK40Hx8w?=
 =?us-ascii?Q?p0DntwI1Ufj9MQk47Ou8XPucVskAm/9m8NM7mCsA2ghemHU28XcZc6VQj7BW?=
 =?us-ascii?Q?yyki655jN8hSXnENhCzfaCJy/6/q0e+5PSC7xi5796JKsIelQgLeyTH3Hmfr?=
 =?us-ascii?Q?z7yP4rLXQpPtS4l3Gc0mO/k8J2NOaOdhZ3E6H1FJ4PNvJMfwMs4aypH0aaHJ?=
 =?us-ascii?Q?BNikpD7S+DOiHGStKuE6HI5I6epohQk+6j9PBLb/i2mjxnbHgg3nH5USCBSn?=
 =?us-ascii?Q?7xWZ4PZ8Q6+0aTiVKjza/UlAbEUjvIHnLKaGTu7V9j168u0p/PsVXbX8Av2N?=
 =?us-ascii?Q?+WJfBNymPLO2qLaPLvm3inCFyixR5LIRpObA/wqiNlhZDSxl1EO+pZRM4npZ?=
 =?us-ascii?Q?cT0E8uTpjw=3D=3D?=
X-Exchange-RoutingPolicyChecked:
	rRsHqGNaVtq1OeQMrbsW/HcserKVGr7sWMf276pZG3jU9tgAFTHOmrmKicCfpPRG0eqpbpQUtRBxKUJrOKpY2dpeavnToQp1fahM8+pzynPfcMBHTaVV9Toee2GTMxkLLkS5sHnB5SAFGbyKP8vYkAnyD9wu82mh+sUlPOg24cTnvgfWNOpcYgbXV4RuHP2GV71R5cwupIUX4cJFYF6H05uID/oL2mJD1AC62wYoTCXnnLjpLBbnd2nxO7kO+HK7ONl1laXlxUxNQalZBFprLu6Wr00HzV0oV6y1bY2D5sHFQo8DskYcRbXn/sReGKpMjnXnQ2eb/0/zgX1ntk3CtQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qU3+02im8vCGfeeUHOGa36QYC/F5M+7F8AG5xKIHXbMuaxSJyhqh4enb3VZtXUedXfJ4bVxX8V+hQmn/OHmv7kr7erBsOi3msj6zVtJs5C/2tUE2dWt5kldB6jMLBebZYf+h2yhMZ0RX5J3mycO1eKCgIETr7zCzY28Vvodv3RNgnn29Br5yp8AYXk/WPeZ+joAWK5o3LdidFCNmXu41sR5uhzo3akhksPnwZikY4F7rVKYBDGmOHG4rHaPmkMY/09jQBAjhrGw3UJutHY2WbmrYtZDiLWMTXlLexUNuP6T8nTvr2ze+spolgJoaXqX0v5PKBgJ7je1jOCa5R8WGc5kkKOwbX42C+he5B7QYsPEaeiZntKtZnMlWfD7eag5qMNBoFruVRe5xRP+0to3PsdHTi/cp3TawDFOQaAw/WCpUQYFstmnahobXNzmhWhbMJf6OuOGri8P/5LCyiQ5ckb3K1MlXS9bcbaJyG52jIRXnPLaJUcgnY20F6We+v5Dchr3im1FLuZsWRgRaNbmtt8DbOBnPZkk0QBevloGF6+mxsZSEG1LPdmt7iQMkklG4CRaQF2Voltj6bLk+IZNHH/E46eRzmy5U2RvVuvr2XKo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a471dbe-ab11-4f97-e7c1-08dec6bbbb6a
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 06:44:34.0553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cXb1Rj/Vs/5HTdN49w6nV/U+fnBUc4fcGVOK0eFymJp+etdc6yoDNOQOiKAUJhZ4h3xyUFxrsgFUbXfOLzUfbK/LPVra6l3kcqC1J0z7Zxw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6377
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=999
 mlxscore=0 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2605130000 definitions=main-2606100061
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDA2MiBTYWx0ZWRfX4MCWjHv6j94x
 ODg+sg6/i7mvHyDdIo/3Hv85VLa4cZ/zR+PgzH0fzoIcVgUysX/ID75sEibLrXA9KCrslG88l0M
 dl/D/0U10/08eXWLJTLVoa1akljuf/tSS6+dcJ5U3bELCdD97fYHWwUYj6ms346Z81u1XZlAxdH
 g1/WlfCa6gzQ5i7jIustj3SJrdv6+TmhSr2oyAj8CdBXGUHsL8nvohpqbmd0HEyFy0AyLkNKdi+
 iNkdeB0yWFA4aqDCeWYXXCJBq5xVSPFYV7Kbs6hkMKdDTdQC3CVgHDpnRpotN8ECjZt/+bLvkc6
 eK3/IhwJ88TbbwmkrAHRMH8H3CQZFeeWDHc+YdKE0O/YJE/GvWgrukmbDkJD/pxP6jTku4DU5Pu
 IVVhX9o5olAoOMSDCsuAVy+PPozU1IDiib9k0rOsRyzu6riU11EOTYodM65o4lXr4QbLdrJ7tcq
 aN7D09As/2lu8LaJDKDrQZmNW7aEM5zP9gz26aho=
X-Authority-Analysis: v=2.4 cv=XeC5Co55 c=1 sm=1 tr=0 ts=6a2907da b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=FelO9ux0wxsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=vggBfdFIAAAA:8
 a=WsHKUha7AAAA:8 a=7CQSdrXTAAAA:8 a=JfrnYn6hAAAA:8 a=KKAkSRfTAAAA:8
 a=pGLkceISAAAA:8 a=Z4Rwk6OoAAAA:8 a=iZDFlVA-Fd3C0jwnJWAA:9
 a=H4LAKuo8djmI0KOkngUh:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=1CNFftbPRP8L7MoqJWF3:22
 a=cvBusfyB2V15izCimMoJ:22 a=HkZW87K1Qel5hWWM3VKY:22 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12312
X-Proofpoint-ORIG-GUID: Kir8B664HXglECOp3_tBHkJWfD2PtTVK
X-Proofpoint-GUID: Kir8B664HXglECOp3_tBHkJWfD2PtTVK


Summarizing all of the bot reviews (sashiko/bpf-bot):

Most of the comments are same as v11. Let me outline the ones I think
are notable:

  - edge cases around (timeout is -1, S64_MAX, U64_MAX).

    I've noted in the first patch how these cases are probably best
    addressed at review time instead of complicating the implementation
    like in https://lore.kernel.org/lkml/874iklm1uy.fsf@oracle.com/

  - as a side-effect of enabling ARCH_HAS_CPU_RELAX, acpi_processor_setup_cstate()
    enables a NOP poll_idle() unintentionally (patch-2). I've described
    it in more detail in my reply to that patch.

    Will fix this.

  - potentially missed control dependency in the timeout case of
    smp_cond_load_acquire_timeout(). Probably need a better fix for
    this than I have.

    Need more thinktime as the bots would say.  Will address this one
    and the one below in reply to patches 6, 7.

  - possibly torn reads with atomic64_cond_read_*_timeout() on 32-bit
    architectures.

Ankur

Ankur Arora <ankur.a.arora@oracle.com> writes:

> Hi,
>
> Main change in this version:
>
>   - addressed some review comments from sashiko (see commit notes)
>     - The one notable change is to the implementation of
>       smp_cond_load_acquire_timeout() where there was a missed
>       control dependency in the timeout case.
>       All the others are minor.
>   - fixed a low probability race in the kunit test added in v11.
>   - added a bunch of kunit tests validating the implementation's
>     use of the clock.
>
> Andrew, if the changes look okay, could we take this in your mm-nomm
> tree as before?
>
> The core kernel often uses smp_cond_load_{relaxed,acquire}() to spin
> on condition variables with architectural primitives used to avoid
> hammering the relevant cachelines.
>
> (This primitive can vary greatly across architectures: on x86 it's a
> cpu_relax() to slow down the pipeline. On arm64, this is a __cmpwait()
> which waits for a cacheline to change state in a time limited fashion.)
>
> Regardless of architectural details, typical smp_cond_load*() usage
> does not allow for termination until the condition change occurs.
>
> Beyond the core kernel, there are cases where it is useful to additionally
> terminate on a timeout. Two cases:
>
>   - cpuidle poll_idle(): wait for need-resched until the cpuidle polling
>     duration expires.
>
>   - rqspinlock: nested qspinlock acquisition that terminates on timeout
>     or deadlock.
>
> Accordingly add two interfaces (with their generic and arm64 specific
> implementations):
>
>    smp_cond_load_relaxed_timeout(ptr, cond_expr, time_expr, timeout)
>    smp_cond_load_acquire_timeout(ptr, cond_expr, time_expr, timeout)
>
> Also add tif_need_resched_relaxed_wait() which wraps the polling
> pattern and its scheduler specific details in poll_idle().
> In addition add atomic_cond_read_*_timeout(),
> atomic64_cond_read_*_timeout(), and atomic_long wrappers.
>
> Structurally, both the smp_cond_load_*_timeout() interfaces are similar
> to smp_cond_load*(), with the addition of a rate-limited time-check.
>
> Usage
> ==
>
> These interfaces drop straight-forwardly into the rqspinlock logic
> since qspinlock already uses smp_cond_load*(), and the time-check
> extension can now be used for timeout and deadlock handling.
>
> Using tif_need_resched_relaxed_wait() in poll_idle() removes any
> architectural details allowing arm64 to straight-forwardly support
> that path.
> (However, for efficiency reasons cpuidle/poll_state.c continues to
> depend on ARCH_HAS_CPU_RELAX since that is defined on architectures
> with an optimized architectural primitive.)
>
>
> Performance
> ==
>
> Apart from simplifications due to this change, supporting polling in
> cpuidle on arm64 helps improve wakeup latency (needs a few cpuidle/acpi
> patches):
>
>
>   # perf stat -r 5 --cpu 4,5 -e task-clock,cycles,instructions,sched:sched_wake_idle_without_ipi \
>   perf bench sched pipe -l 1000000 -c 4
>
>   # No haltpoll (and, no TIF_POLLING_NRFLAG):
>
>   Performance counter stats for 'CPU(s) 4,5' (5 runs):
>
>          25,229.57 msec task-clock                       #    2.000 CPUs utilized               ( +-  7.75% )
>     45,821,250,284      cycles                           #    1.816 GHz                         ( +- 10.07% )
>     26,557,496,665      instructions                     #    0.58  insn per cycle              ( +-  0.21% )
>                  0      sched:sched_wake_idle_without_ipi #    0.000 /sec
>
>        12.615 +- 0.977 seconds time elapsed  ( +-  7.75% )
>
>
>   # Haltpoll:
>
>   Performance counter stats for 'CPU(s) 4,5' (5 runs):
>
>          15,131.58 msec task-clock                       #    2.000 CPUs utilized               ( +- 10.00% )
>     34,158,188,839      cycles                           #    2.257 GHz                         ( +-  6.91% )
>     20,824,950,916      instructions                     #    0.61  insn per cycle              ( +-  0.09% )
>          1,983,822      sched:sched_wake_idle_without_ipi #  131.105 K/sec                       ( +-  0.78% )
>
>         7.566 +- 0.756 seconds time elapsed  ( +- 10.00% )
>
>   We get improved latency because we don't switch in and out of a
>   deeper sleep state or from the hypervisor. This also causes us to
>   execute ~20% fewer instructions.
>
>
> Haris Okanovic also saw improvement in real workloads due to the
> cpuidle changes: "observed 4-6% improvements in memcahed, cassandra,
> mysql, and postgresql under certain loads. Other applications likely
> benefit too." [12]
>
>
> Changelog:
>   v11 [13] (as listed above):
>     - addressed some review comments from sashiko (see commit notes)
>       - The one notable change is to the implementation of
>         smp_cond_load_acquire_timeout() where there was a missed
>         control dependency in the timeout case.
>       All the others are minor.
>     - fixed a low probability race in the kunit test added in v11.
>     - added a bunch of kunit tests validating the implementation's
>       use of the clock.
>
>   v10 [10]:
>    - add a comment mentioning that smp_cond_load_relaxed_timeout() might
>      be using architectural primitives that don't support MMIO.
>      (David Laight, Catalin Marinas)
>    - added a kunit test for smp_cond_load_relaxed_timeout() (Andrew
>      Morton.)
>
>   v9 [9]:
>    - s/@cond/@cond_expr/ (Randy Dunlap)
>    - Clarify that SMP_TIMEOUT_POLL_COUNT is only around memory
>      addresses. (David Laight)
>    - Add the missing config ARCH_HAS_CPU_RELAX in arch/arm64/Kconfig.
>      (Catalin Marinas).
>    - Switch to arch_counter_get_cntvct_stable() (via __delay_cycles())
>      in the cmpwait path instead of using arch_timer_read_counter().
>      (Catalin Marinas)
>
>   v8 [0]:
>    - Defer evaluation of @time_expr_ns to when we hit the slowpath.
>       (comment from Alexei Starovoitov).
>
>    - Mention that cpu_poll_relax() is better than raw CPU polling
>      only where ARCH_HAS_CPU_RELAX is defined.
>      - also define ARCH_HAS_CPU_RELAX for arm64.
>       (Came out of a discussion with Will Deacon.)
>
>    - Split out WFET and WFE handling. I was doing both of these
>      in a common handler.
>      (From Will Deacon and in an earlier revision by Catalin Marinas.)
>
>    - Add mentions of atomic_cond_read_{relaxed,acquire}(),
>      atomic_cond_read_{relaxed,acquire}_timeout() in
>      Documentation/atomic_t.txt.
>
>    - Use the BIT() macro to do the checking in tif_bitset_relaxed_wait().
>
>    - Cleanup unnecessary assignments, casts etc in poll_idle().
>      (From Rafael Wysocki.)
>
>    - Fixup warnings from kernel build robot
>
>
>   v7 [1]:
>    - change the interface to separately provide the timeout. This is
>      useful for supporting WFET and similar primitives which can do
>      timed waiting (suggested by Arnd Bergmann).
>
>    - Adapting rqspinlock code to this changed interface also
>      necessitated allowing time_expr to fail.
>    - rqspinlock changes to adapt to the new smp_cond_load_acquire_timeout().
>
>    - add WFET support (suggested by Arnd Bergmann).
>    - add support for atomic-long wrappers.
>    - add a new scheduler interface tif_need_resched_relaxed_wait() which
>      encapsulates the polling logic used by poll_idle().
>      - interface suggested by (Rafael J. Wysocki).
>
>
>   v6 [2]:
>    - fixup missing timeout parameters in atomic64_cond_read_*_timeout()
>    - remove a race between setting of TIF_NEED_RESCHED and the call to
>      smp_cond_load_relaxed_timeout(). This would mean that dev->poll_time_limit
>      would be set even if we hadn't spent any time waiting.
>      (The original check compared against local_clock(), which would have been
>      fine, but I was instead using a cheaper check against _TIF_NEED_RESCHED.)
>    (Both from meta-CI bot)
>
>
>   v5 [3]:
>    - use cpu_poll_relax() instead of cpu_relax().
>    - instead of defining an arm64 specific
>      smp_cond_load_relaxed_timeout(), just define the appropriate
>      cpu_poll_relax().
>    - re-read the target pointer when we exit due to the time-check.
>    - s/SMP_TIMEOUT_SPIN_COUNT/SMP_TIMEOUT_POLL_COUNT/
>    (Suggested by Will Deacon)
>
>    - add atomic_cond_read_*_timeout() and atomic64_cond_read_*_timeout()
>      interfaces.
>    - rqspinlock: use atomic_cond_read_acquire_timeout().
>    - cpuidle: use smp_cond_load_relaxed_tiemout() for polling.
>    (Suggested by Catalin Marinas)
>
>    - rqspinlock: define SMP_TIMEOUT_POLL_COUNT to be 16k for non arm64
>
>
>   v4 [4]:
>     - naming change 's/timewait/timeout/'
>     - resilient spinlocks: get rid of res_smp_cond_load_acquire_waiting()
>       and fixup use of RES_CHECK_TIMEOUT().
>     (Both suggested by Catalin Marinas)
>
>   v3 [5]:
>     - further interface simplifications (suggested by Catalin Marinas)
>
>   v2 [6]:
>     - simplified the interface (suggested by Catalin Marinas)
>        - get rid of wait_policy, and a multitude of constants
>        - adds a slack parameter
>       This helped remove a fair amount of duplicated code duplication and in
>       hindsight unnecessary constants.
>
>   v1 [7]:
>      - add wait_policy (coarse and fine)
>      - derive spin-count etc at runtime instead of using arbitrary
>        constants.
>
> Haris Okanovic tested v4 of this series with poll_idle()/haltpoll patches. [8]
>
> Comments appreciated!
>
> Thanks
> Ankur
>
>  [0] https://lore.kernel.org/lkml/20251215044919.460086-1-ankur.a.arora@oracle.com/
>  [1] https://lore.kernel.org/lkml/20251028053136.692462-1-ankur.a.arora@oracle.com/
>  [2] https://lore.kernel.org/lkml/20250911034655.3916002-1-ankur.a.arora@oracle.com/
>  [3] https://lore.kernel.org/lkml/20250911034655.3916002-1-ankur.a.arora@oracle.com/
>  [4] https://lore.kernel.org/lkml/20250829080735.3598416-1-ankur.a.arora@oracle.com/
>  [5] https://lore.kernel.org/lkml/20250627044805.945491-1-ankur.a.arora@oracle.com/
>  [6] https://lore.kernel.org/lkml/20250502085223.1316925-1-ankur.a.arora@oracle.com/
>  [7] https://lore.kernel.org/lkml/20250203214911.898276-1-ankur.a.arora@oracle.com/
>  [8] https://lore.kernel.org/lkml/2cecbf7fb23ee83a4ce027e1be3f46f97efd585c.camel@amazon.com/
>  [9] https://lore.kernel.org/lkml/20260209023153.2661784-1-ankur.a.arora@oracle.com/
>  [10] https://lore.kernel.org/lkml/20260316013651.3225328-1-ankur.a.arora@oracle.com/
>  [11] https://lore.kernel.org/lkml/20230809134837.GM212435@hirez.programming.kicks-ass.net/
>  [12] https://lore.kernel.org/lkml/c6f3c8d3f1f2e89a9dc7ae22482973b5a51b08cb.camel@amazon.com/
>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: bpf@vger.kernel.org
> Cc: linux-arch@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-pm@vger.kernel.org
>
> Ankur Arora (15):
>   asm-generic: barrier: Add smp_cond_load_relaxed_timeout()
>   arm64: barrier: Support smp_cond_load_relaxed_timeout()
>   arm64/delay: move some constants out to a separate header
>   arm64: support WFET in smp_cond_load_relaxed_timeout()
>   arm64: rqspinlock: Remove private copy of
>     smp_cond_load_acquire_timewait()
>   asm-generic: barrier: Add smp_cond_load_acquire_timeout()
>   atomic: Add atomic_cond_read_*_timeout()
>   locking/atomic: scripts: build atomic_long_cond_read_*_timeout()
>   bpf/rqspinlock: switch check_timeout() to a clock interface
>   bpf/rqspinlock: Use smp_cond_load_acquire_timeout()
>   sched: add need-resched timed wait interface
>   cpuidle/poll_state: Wait for need-resched via
>     tif_need_resched_relaxed_wait()
>   arm64/delay: enable testing smp_cond_load_relaxed_timeout()
>   barrier: add tests for smp_cond_load_*_timeout()
>   barrier: add clock tests for smp_cond_load_relaxed_timeout()
>
>  Documentation/atomic_t.txt           |  14 +-
>  arch/arm64/Kconfig                   |   3 +
>  arch/arm64/include/asm/barrier.h     |  23 ++++
>  arch/arm64/include/asm/cmpxchg.h     |  62 +++++++--
>  arch/arm64/include/asm/delay-const.h |  28 ++++
>  arch/arm64/include/asm/rqspinlock.h  |  85 ------------
>  arch/arm64/lib/delay.c               |  17 +--
>  drivers/clocksource/arm_arch_timer.c |   2 +
>  drivers/cpuidle/poll_state.c         |  21 +--
>  drivers/soc/qcom/rpmh-rsc.c          |   8 +-
>  include/asm-generic/barrier.h        |  97 ++++++++++++++
>  include/linux/atomic.h               |  10 ++
>  include/linux/atomic/atomic-long.h   |  18 ++-
>  include/linux/sched/idle.h           |  29 +++++
>  kernel/bpf/rqspinlock.c              |  77 +++++++----
>  lib/Kconfig.debug                    |  10 ++
>  lib/tests/Makefile                   |   1 +
>  lib/tests/barrier-timeout-test.c     | 185 +++++++++++++++++++++++++++
>  scripts/atomic/gen-atomic-long.sh    |  16 ++-
>  19 files changed, 528 insertions(+), 178 deletions(-)
>  create mode 100644 arch/arm64/include/asm/delay-const.h
>  create mode 100644 lib/tests/barrier-timeout-test.c


--
ankur
