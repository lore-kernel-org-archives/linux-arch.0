Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5DD26D4CA;
	Wed,  8 Apr 2026 12:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775651185; cv=fail; b=f1iR8ZY1IgZLGa0uYSlH/M0iMFn7wH91YUocnW5MYj017SMBKe80Z7Hm/OYvhqQ+nAcmuD/dQ7cxtZMOfetKdfPt/a3rbzu8rp6zkMKpBT4QlaLeJxqrzaFihPlvB3pD0ihvQRpF5aTS453D6gSgLQ/wmOJmN64NDJMu/DUcZKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775651185; c=relaxed/simple;
	bh=JUXziXj4Gn10mkmuYM7dzxU5hPd4HPksSSuxwsNdYls=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=r+bzt1VZlNLVLlrj3xidmb7AaQaZLjX6UgHWDu3aebfEPUFz9KilJb2x7A5ug6LLG+NhgoIL8LgAT/NT9Dm01VnW1eIa6h6jkdzZBjb8xrUoHF889KoWKhPHONKxgIgv/u3VFko6xDTrUEahZM1Kho16OdaovVQ65nu8K7uuyIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oqlewTfk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gu8cQIco; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oqlewTfk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gu8cQIco"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6380GYw61587303;
	Wed, 8 Apr 2026 12:25:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=A9O+ilP5Rkg6jwNV
	bobpf6Fa4j0SRjPdwv4Utq+wChw=; b=oqlewTfkHYkFx45IjpeQOZmpXI1GFQtJ
	Bl60yJ0qMaN6Ia0gSuswYJ5izFNlcEooCuGcN+FayytDw4Frfw3gacQAjg17RxdE
	mst+H1K8vcJq9sue6UWii4exbNihtn8wPkLEiJYaSzRILQimL8ZirfXj2GVatpuG
	59nTGfUOzcO+3vTeDDLW66FK7523uwCyd/ZYzBZxqGzvRemDlqfhrw0E4EN+3nSD
	V3LCuN7lrBgmZTvBfDm0a4GvzorbJ5Wej64Sz/ho5cwLHry/H6YZdFWslhQ55poi
	eoEZSTawH7CU0slXTM7uuX8xgDV0CjIDC+1hhX9GmMhi3II9z8XNew==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dcmqa3fkk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Apr 2026 12:25:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 638BMiCm026139;
	Wed, 8 Apr 2026 12:25:47 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012017.outbound.protection.outlook.com [40.107.209.17])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4dcmeb7meh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Apr 2026 12:25:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=omXGFU5+ZwbAxiTn4l83g5WJfX2a+TiQllVRjaDQYAEL1Ich8jKP1KrSFzKAJMT0Fmu3HXpExt0//ASEL0HAnMAkf4mUWyq1Cr4Lo52im8isAgUATP/FxWtGH7+JAKhUnMCdQY89Mkqn8pZKSY5IXfiFzhZqe1AGyjy9udOX41wl/+zdaWZFizTyym/xgpgjJwBd0Can/6+VPdcspTNjdItkXqRDYkLOpgeU4T0ptqLrpsveeIzw7KjDlD+yt16GBatDeZvqHboIgao2quRK9b7a30GsYgi3ML1hsQwhgd2ObWHsBzl3umntJkAcu91t2j98plz5X3vBXCOlLwOGkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A9O+ilP5Rkg6jwNVbobpf6Fa4j0SRjPdwv4Utq+wChw=;
 b=y5df27AEr/NIE0SPaDh/9ovueisg9qk2fd0CRFpgUivhlT5LXJT6cHjwqkS94U5DU4rfrmX7LmK19g8uWD68tOnH67fm3T3TLmfZJrrmw6px/z7PEgJMzbRrX/zR2P/Ph6vPQLn9S0tmwr6OPwn3xMXD3JMKXM5HEqbdve2UmmN54BcXbBe5DNacCfgq6ceL/UEOLpDdWsTiqZ+72bRivKUBG+9CldCgVGAXMQob5oRcxlrdV/9MwIkojWySGqZJI43CDLDoAfvye4APEBQ3uTj72P+Q+2yvLaQhXdbaxefj+k2U3SVnGLTNbdgugVriDXDKZVbdSBT792p6xHkwAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A9O+ilP5Rkg6jwNVbobpf6Fa4j0SRjPdwv4Utq+wChw=;
 b=gu8cQIcoNNUz/V8QUsskiLegRJfzbw/73b/hE8WkogRPlTr7REofAZ74TqydyCuuKU6YK0xF7sD0TLem3F5cl3E4RYX2XxobO53r4/xS5hykcO/x6tUL2LWaBhvBkZbSpxiyaX0sLtt/L66+8RvwXYyhz2Rhld25dWPgBksOE9A=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by PH0PR10MB5778.namprd10.prod.outlook.com (2603:10b6:510:12b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 8 Apr
 2026 12:25:42 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.20.9745.034; Wed, 8 Apr 2026
 12:25:42 +0000
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
Subject: [PATCH v11 00/14] barrier: Add smp_cond_load_{relaxed,acquire}_timeout()
Date: Wed,  8 Apr 2026 17:55:24 +0530
Message-Id: <20260408122538.3610871-1-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN4PR01CA0070.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26c::15) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|PH0PR10MB5778:EE_
X-MS-Office365-Filtering-Correlation-Id: b6fb47da-b112-48df-0e41-08de9569f387
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|7416014|10070799003|56012099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	LB92ReHHPsKI6HXYKGmukjD4tyrpaCAJxp6nXZ3lVGG3PZAHBeUYnzjOHGpJZAdeGt9IcjxK9hGXwHI1cLHaLISGbmaTdJnFiLtrAQBof4ZwRhEUIltTreKVvhOWkBNEPrSxpmfiJNWvfQpTiXTJwhjfmaC3IpYW4TyNMvxwg6T2W2rkWymaSf3hvH/TnY3FYUTrnwjX1Q7UgEufVgpi0WwLpHLnV430mQckEDCSbUO+TCpH144kdDBrKKKj4KabGAW24UN34tX2SPd28ogH38rYGWbhNQfuuklCqYmmixcuu+QLqx1F5WWd9lEiJ7d90cv7i3QSAQ+L1+FSyctxT56VAA9mCTk3pW2gI1TGA8IrXkwvNVedVarexcTNPARBqXGha87Zg/RJtCyRLPBW5z7CxcFJfjaNKunjvKf43A0aEu0AhrI9yVNJIxTUVl0RY19kctG45kCOTn/Il0lVeAMT5007DSZ0rQ2iLio7aaO8bKLVAZIeac93BgD+OTSXQ0Vx9GrgFtaMtDtTRh5SbbIR5UIIVdX1d4FZK33v1c6thf3e1ahwoX0aTFL112G3vvqFgqQuMRwUsUIBIQQkaWFLQZY0vf7MVbLljY02YefZXpgGiNXqx3hfZ8MN9n8CcfM93isFrsdG45vmSSi+EC+pWIQjc9MBbe+Ed0gLbVoA27hvfwQGmy/GmdC5qQwFvS9xRp5xGNpY101k5Gk9Q0GOnLTKT6v1pVsfzC8qAHjr9PCi/Pxzro8PGArTLpff
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(10070799003)(56012099003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sTa3fY2sn2kvP8pMuUxiGQVdwXjsCNNNMN+yB56Q00ZTD4/Tpl52zAiU0Dp0?=
 =?us-ascii?Q?hhp/BuMgtvnjpqnTvT0ir0Np2/p3DFy4EHZz687/1vVmnRSEi84EPYGh9Gwt?=
 =?us-ascii?Q?uQJAuANxUiUB7s2tVqQIjDN0xjS/xlsfQ4rmLLNIdqE8mT1nEkqcB6oNKfFl?=
 =?us-ascii?Q?1zQLsYdafl43l8ckILs0DG0ihFLLQKu7Hhqv1ZcoYR6S4cGp0pbMiE23BP21?=
 =?us-ascii?Q?zUe/BeHP5qglHd5o/zM6JEVuDyQoGPHDeKMFw7ZAOydy+HWpRjLJ+87cbT6Z?=
 =?us-ascii?Q?EIrFpQ/aSC00JaYd4N/HvvBVR9VbyHC3xHr2PUWdOG+lxXhImY4TwBLEQpHW?=
 =?us-ascii?Q?0BKM8D+ka6DaOBdyclKyDv7bXsadM6+Edemopb8Lk+FGQNu6UtUICqnks9qH?=
 =?us-ascii?Q?LyoxlnGvx2FwiA91cR4P/1bu83AK/WRbLnljrfDam/Iwt/hlGaV52tMYZURu?=
 =?us-ascii?Q?g8voQASU1ius8PfXBn0IHDMSepYALNxG3us8QTI1bOUvPHGeg6C/Jbmm3yXo?=
 =?us-ascii?Q?yyt7BjGvyfQHkkqfBXQ7Tf2fpfRgEheSwAELnqnkU0t9UAC0RMB99Kek+Bcv?=
 =?us-ascii?Q?BeUe54zVZvNRLT24Xcls+yvRu8u1fBYFqPN+DkCmu6kYGhBgK4Gvg922s3Gd?=
 =?us-ascii?Q?U4I7inonpmI440gIo+N4c5dQBbmyEK3f+q+GU3xbyMfAVzY198SFryj7FJXs?=
 =?us-ascii?Q?772ee6sqT83Ie8IRvu4dD5PplUU25YS8dOuzjsUAMvVl/SAmzjNqgjFvUTXw?=
 =?us-ascii?Q?NYtOnH8a0Z2oshQxxQWkHjl9wUKGENMA6ekD10S+q7Ue05foXyS5xhro+EFr?=
 =?us-ascii?Q?S/gYTeY7PmiAOIsMhJRHsJupnhti94Rt2x+zZLvRRDp2u3uJFkQBYczGzuP5?=
 =?us-ascii?Q?4GwUCiCWSHixxrj1yRenmLs/QLV+mg6h2bHE8L74IXh+OLpOppTmwHXboUd+?=
 =?us-ascii?Q?MFH44oN03UpnugdRNl8KgAfOQI6Su+Pnp3KSNF9oQYPjccrO1F1WA7Yx9jgE?=
 =?us-ascii?Q?0qekNdgtvWTXGoOuwDIIWjHZLN+WxzLvqpWg7Tm0Jpx3ooTCdlIoNg6sjzfF?=
 =?us-ascii?Q?8mfnnw2/b7KnlghNjzVVnyQeit9xXJQQAhraGALtgd5aRH/zTrHLLMWcuA5c?=
 =?us-ascii?Q?yexsMv6gRIzUhLMPS5ZVIhFlpiP6HjsuhyZjqp8V4ZFDtvjDv50poVI9mMvk?=
 =?us-ascii?Q?nYCD4VdCapqCCFZURZcdSrUPNkERwbFKnZobagOntbNgQ57j90VLKOxm/2dM?=
 =?us-ascii?Q?k8bI0JHfRW2ryzvnUuTix/EmrJnxsxw/byccIumHf/yhm0hewfTyT3V07etP?=
 =?us-ascii?Q?C0eT++F+LHLVNHVQLLJRTcEAJiXBU2G/CWjvkXgqqqUiCIhNgLRkw5vBylIF?=
 =?us-ascii?Q?DjHeeIrYqzut+dYKGdqy/AElEQl5uLPDU+B5PNa2onM5V7iHt1ml1wrpvDBq?=
 =?us-ascii?Q?Vl8PD4ca7sHST3c6GiukFLgOckl8KuQhW3JbgsOScWE+HXiL+4N9zQVNUPmn?=
 =?us-ascii?Q?EsLCN2x573OUHzr/+J22Zj/8ZC96ziPGHJc7fkfjyy0ndm0d4bXB7fwfZli0?=
 =?us-ascii?Q?YeJMhZtFFxdzc6y3x+gi5xEsfsqdFH1nXDnQSHOxYZIp5Z8i7jGikCm8DuwN?=
 =?us-ascii?Q?Kb3XBes6q3Y49od55vX79xDlqjq0ckobsYHd2LGWZuBUnrzGlJSRYLvYwEy0?=
 =?us-ascii?Q?tc1gNK9Nt3jqdzjf7BvnQmujqwz/gm4kA3McNFLmBRrkqmJS5b2hTyjuFx3L?=
 =?us-ascii?Q?iEVf/vrSFn3tfRqid4kcnF4jLADhenRR7493eu2KGuQ9Ukv7CFV0kr36gmYM?=
X-MS-Exchange-AntiSpam-MessageData-1: w2nb09X7R9d7ggQBThE1T2mMBd0PqY1++BI=
X-Exchange-RoutingPolicyChecked:
	ZiVbwejWbZSdaAb9xdmapMGgkNv6ewKFTo1bNMiT8XH73uUlk7hemvAjIeVoikOjwgT/+9LBKvSIEKS3k9gE7gnFI81joBsZLEboohSvmuo96FroMmxi3PhWXPa4e+pwLlJIDt3qbAvYu3gXumw19NSiAkKtM0tJ9jA0Q2nh9XAlvkJ8sX3DBssQcH5//66tVAg8hmWCP1W5h4Q+15C2RnlH4gDHrnaGHG+inKx0qT142oEXlsDEIBIykT1GKtmKOjBO6qQcdCkKu1MctH3PJxBLiGKb0x8k7eCv2YVfljQLR8KMRmrIkZn9/eDlhAxbpwsos+RcwOIKnZAmCrkcag==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NR13QkFb4YfyPNudyjRTZbLnpBw3h5dkTTsTAtNwOAxFdSeDRRQtTsmv4mnHTxlQklL0MdgImRx19q4gMy/ORbhhTYYWTRgXhSYpD2cqT/aN2401bTJn99Mqv7W0+YnHCiUmEw69pmkkwNSDV+0maF2mjzX+v8RHCuWKUb6D8VWZf6W5JovHU4NdJ4tFZjnoGYL+6dfNdSR9syD2yk6txIAXv8J5Dvi+QaRn4bxFDdygnoxuFdLVTEZETNEItbjZ0MY0Md9R8Syd13W5bl6ehccl7HNQXjzdBmXY4SwZDTozS6KMQ3CKiej/gy957/KJVp1ymqOZ6QEIrn3BJL+/owu0NINVZg80Ua8oM9KSVpw7BeIq8N2Hsp7Gdi3ckWrfyX8RvSqEIurznP0Lbfye5t12NNA+4TKuQVqpIj4ekPAj3HIb/kA3q7vcqbwLby9AntttlC05Sp8nxVdvw4USYNzGTn3dbmUnKT1/9vK2/oA9MUwF78TTYYuBidxRmyeDF46AoRNbk/Er1x2m0uhTBDw9UInimar8/uUKwIkshU4+XXtjq3yc2eV8OvK5W9tUfXChuGijg0PW5b1Q2DjDInzJMaySCx2P3rLOdhrsuvY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6fb47da-b112-48df-0e41-08de9569f387
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 12:25:42.5078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f6tiL0ieXQsbQ5EiCeGr/xETm1Yto4i9/tBoc8DtjhBo/iDJ7mNkU7O7vy7e38GmlAS0f7bbWBzngFHN3pjBCGP1NiyjIg5YKt0uXggH4fI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5778
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_04,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 adultscore=0
 phishscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2604010000
 definitions=main-2604080115
X-Proofpoint-GUID: ArPylUJSALldsuTjLmJPTCcEhGsICeyC
X-Proofpoint-ORIG-GUID: ArPylUJSALldsuTjLmJPTCcEhGsICeyC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDExNSBTYWx0ZWRfX6K7ghFVK7SEP
 ye7Kb1fqGurSnwUYtGQL2AXidLIfxwlW4fC+Jmt4uZK0mxRoNG87d1/gq65zNzhSokSUieIYJDg
 t8RmSTNni35YWiPmb3S+Iqp3nfdEWXP9V73JY9g51irjdBckvndQcCx9vj9A9SVsVDpjxqeanr+
 FQsnEoz+E7vxBhOICuGVrRVHSgm+zfMZimKbTIGDxQH+dNWbbYeoN0qyx974vLTUGZhhFb8mcib
 SNy8T62Z/sm8vmMeere2hR0sjlXldXyf1LrZ177rtVIH9Ik3bUdheFSchMTMZZ/9ua1s1NXXVvn
 7p/7gYJQ1obvlhl2rHIuMSjLx7jdTBXW1Vt7zXwR8XtsM0m3NMCCGA6xFgJBaziZ/XcGL4NrBzf
 5fzocQDbRTXq7jYrfyz0XYUjvMTaTIWvN27hugfEfzOb+x/atXF5WfSHQ7rcEbB+1H8WTBo7DOz
 dVeh8g6teFbwu/KNq36mPTm7HD1cytrvZ064jGm0=
X-Authority-Analysis: v=2.4 cv=DLS/JSNb c=1 sm=1 tr=0 ts=69d6494c b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=vggBfdFIAAAA:8
 a=WsHKUha7AAAA:8 a=7CQSdrXTAAAA:8 a=JfrnYn6hAAAA:8 a=KKAkSRfTAAAA:8
 a=pGLkceISAAAA:8 a=Dxs9ILoNsXMxDuzj_eYA:9 a=H4LAKuo8djmI0KOkngUh:22
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=1CNFftbPRP8L7MoqJWF3:22 a=cvBusfyB2V15izCimMoJ:22
 cc=ntf awl=host:12292

Hi,

Main change in this version:
  - adds a kunit validation test.

What remains?:
  - Review by PeterZ of the new interface tif_need_resched_relaxed_wait()
    (patch 11, "sched: add need-resched timed wait interface").
    (Peter had originally proposed using smp_cond_load_relaxed() in
     poll_idle() [11]).

The core kernel often uses smp_cond_load_{relaxed,acquire}() to spin
on condition variables with architectural primitives used to avoid
hammering the relevant cachelines.

(This primitive can vary greatly across architectures: on x86 it's a
cpu_relax() to slow down the pipeline. On arm64, this is a __cmpwait()
which waits for a cacheline to change state in a time limited fashion.)

Regardless of architectural details, typical smp_cond_load*() usage
does not allow for termination until the condition change occurs.

Beyond the core kernel, there are cases where it is useful to additionally
terminate on a timeout. Two cases:

  - cpuidle poll_idle(): wait for need-resched until the cpuidle polling
    duration expires.

  - rqspinlock: nested qspinlock acquisition that terminates on timeout
    or deadlock.

Accordingly add two interfaces (with their generic and arm64 specific
implementations):

   smp_cond_load_relaxed_timeout(ptr, cond_expr, time_expr, timeout)
   smp_cond_load_acquire_timeout(ptr, cond_expr, time_expr, timeout)

Also add tif_need_resched_relaxed_wait() which wraps the polling
pattern and its scheduler specific details in poll_idle().
In addition add atomic_cond_read_*_timeout(),
atomic64_cond_read_*_timeout(), and atomic_long wrappers.

Structurally, both the smp_cond_load_*_timeout() interfaces are similar
to smp_cond_load*(), with the addition of a rate-limited time-check.

Usage
==

These interfaces drop straight-forwardly into the rqspinlock logic
since qspinlock already uses smp_cond_load*(), and the time-check
extension can now be used for timeout and deadlock handling.

Using tif_need_resched_relaxed_wait() in poll_idle() removes any
architectural details allowing arm64 to straight-forwardly support
that path.
(However, for efficiency reasons cpuidle/poll_state.c continues to
depend on ARCH_HAS_CPU_RELAX since that is defined on architectures
with an optimized architectural primitive.)


Performance
==

Apart from simplifications due to this change, supporting polling in
cpuidle on arm64 helps improve wakeup latency (needs a few cpuidle/acpi
patches):


  # perf stat -r 5 --cpu 4,5 -e task-clock,cycles,instructions,sched:sched_wake_idle_without_ipi \
  perf bench sched pipe -l 1000000 -c 4

  # No haltpoll (and, no TIF_POLLING_NRFLAG):

  Performance counter stats for 'CPU(s) 4,5' (5 runs):

         25,229.57 msec task-clock                       #    2.000 CPUs utilized               ( +-  7.75% )
    45,821,250,284      cycles                           #    1.816 GHz                         ( +- 10.07% )
    26,557,496,665      instructions                     #    0.58  insn per cycle              ( +-  0.21% )
                 0      sched:sched_wake_idle_without_ipi #    0.000 /sec

       12.615 +- 0.977 seconds time elapsed  ( +-  7.75% )


  # Haltpoll:

  Performance counter stats for 'CPU(s) 4,5' (5 runs):

         15,131.58 msec task-clock                       #    2.000 CPUs utilized               ( +- 10.00% )
    34,158,188,839      cycles                           #    2.257 GHz                         ( +-  6.91% )
    20,824,950,916      instructions                     #    0.61  insn per cycle              ( +-  0.09% )
         1,983,822      sched:sched_wake_idle_without_ipi #  131.105 K/sec                       ( +-  0.78% )

        7.566 +- 0.756 seconds time elapsed  ( +- 10.00% )

  We get improved latency because we don't switch in and out of a
  deeper sleep state or from the hypervisor. This also causes us to
  execute ~20% fewer instructions.


Haris Okanovic also saw improvement in real workloads due to the
cpuidle changes: "observed 4-6% improvements in memcahed, cassandra,
mysql, and postgresql under certain loads. Other applications likely
benefit too." [12]


Changelog:
  v10 [10]:
   - add a comment mentioning that smp_cond_load_relaxed_timeout() might
     be using architectural primitives that don't support MMIO.
     (David Laight, Catalin Marinas)
   - added a kunit test for smp_cond_load_relaxed_timeout() (Andrew
     Morton.)

  v9 [9]:
   - s/@cond/@cond_expr/ (Randy Dunlap)
   - Clarify that SMP_TIMEOUT_POLL_COUNT is only around memory
     addresses. (David Laight)
   - Add the missing config ARCH_HAS_CPU_RELAX in arch/arm64/Kconfig.
     (Catalin Marinas).
   - Switch to arch_counter_get_cntvct_stable() (via __delay_cycles())
     in the cmpwait path instead of using arch_timer_read_counter().
     (Catalin Marinas)

  v8 [0]:
   - Defer evaluation of @time_expr_ns to when we hit the slowpath.
      (comment from Alexei Starovoitov).

   - Mention that cpu_poll_relax() is better than raw CPU polling
     only where ARCH_HAS_CPU_RELAX is defined.
     - also define ARCH_HAS_CPU_RELAX for arm64.
      (Came out of a discussion with Will Deacon.)

   - Split out WFET and WFE handling. I was doing both of these
     in a common handler.
     (From Will Deacon and in an earlier revision by Catalin Marinas.)

   - Add mentions of atomic_cond_read_{relaxed,acquire}(),
     atomic_cond_read_{relaxed,acquire}_timeout() in
     Documentation/atomic_t.txt.

   - Use the BIT() macro to do the checking in tif_bitset_relaxed_wait().

   - Cleanup unnecessary assignments, casts etc in poll_idle().
     (From Rafael Wysocki.)

   - Fixup warnings from kernel build robot


  v7 [1]:
   - change the interface to separately provide the timeout. This is
     useful for supporting WFET and similar primitives which can do
     timed waiting (suggested by Arnd Bergmann).

   - Adapting rqspinlock code to this changed interface also
     necessitated allowing time_expr to fail.
   - rqspinlock changes to adapt to the new smp_cond_load_acquire_timeout().

   - add WFET support (suggested by Arnd Bergmann).
   - add support for atomic-long wrappers.
   - add a new scheduler interface tif_need_resched_relaxed_wait() which
     encapsulates the polling logic used by poll_idle().
     - interface suggested by (Rafael J. Wysocki).


  v6 [2]:
   - fixup missing timeout parameters in atomic64_cond_read_*_timeout()
   - remove a race between setting of TIF_NEED_RESCHED and the call to
     smp_cond_load_relaxed_timeout(). This would mean that dev->poll_time_limit
     would be set even if we hadn't spent any time waiting.
     (The original check compared against local_clock(), which would have been
     fine, but I was instead using a cheaper check against _TIF_NEED_RESCHED.)
   (Both from meta-CI bot)


  v5 [3]:
   - use cpu_poll_relax() instead of cpu_relax().
   - instead of defining an arm64 specific
     smp_cond_load_relaxed_timeout(), just define the appropriate
     cpu_poll_relax().
   - re-read the target pointer when we exit due to the time-check.
   - s/SMP_TIMEOUT_SPIN_COUNT/SMP_TIMEOUT_POLL_COUNT/
   (Suggested by Will Deacon)

   - add atomic_cond_read_*_timeout() and atomic64_cond_read_*_timeout()
     interfaces.
   - rqspinlock: use atomic_cond_read_acquire_timeout().
   - cpuidle: use smp_cond_load_relaxed_tiemout() for polling.
   (Suggested by Catalin Marinas)

   - rqspinlock: define SMP_TIMEOUT_POLL_COUNT to be 16k for non arm64


  v4 [4]:
    - naming change 's/timewait/timeout/'
    - resilient spinlocks: get rid of res_smp_cond_load_acquire_waiting()
      and fixup use of RES_CHECK_TIMEOUT().
    (Both suggested by Catalin Marinas)

  v3 [5]:
    - further interface simplifications (suggested by Catalin Marinas)

  v2 [6]:
    - simplified the interface (suggested by Catalin Marinas)
       - get rid of wait_policy, and a multitude of constants
       - adds a slack parameter
      This helped remove a fair amount of duplicated code duplication and in
      hindsight unnecessary constants.

  v1 [7]:
     - add wait_policy (coarse and fine)
     - derive spin-count etc at runtime instead of using arbitrary
       constants.

Haris Okanovic tested v4 of this series with poll_idle()/haltpoll patches. [8]

Comments appreciated!

Thanks
Ankur

 [0] https://lore.kernel.org/lkml/20251215044919.460086-1-ankur.a.arora@oracle.com/
 [1] https://lore.kernel.org/lkml/20251028053136.692462-1-ankur.a.arora@oracle.com/
 [2] https://lore.kernel.org/lkml/20250911034655.3916002-1-ankur.a.arora@oracle.com/
 [3] https://lore.kernel.org/lkml/20250911034655.3916002-1-ankur.a.arora@oracle.com/
 [4] https://lore.kernel.org/lkml/20250829080735.3598416-1-ankur.a.arora@oracle.com/
 [5] https://lore.kernel.org/lkml/20250627044805.945491-1-ankur.a.arora@oracle.com/
 [6] https://lore.kernel.org/lkml/20250502085223.1316925-1-ankur.a.arora@oracle.com/
 [7] https://lore.kernel.org/lkml/20250203214911.898276-1-ankur.a.arora@oracle.com/
 [8] https://lore.kernel.org/lkml/2cecbf7fb23ee83a4ce027e1be3f46f97efd585c.camel@amazon.com/
 [9] https://lore.kernel.org/lkml/20260209023153.2661784-1-ankur.a.arora@oracle.com/
 [10] https://lore.kernel.org/lkml/20260316013651.3225328-1-ankur.a.arora@oracle.com/
 [11] https://lore.kernel.org/lkml/20230809134837.GM212435@hirez.programming.kicks-ass.net/
 [12] https://lore.kernel.org/lkml/c6f3c8d3f1f2e89a9dc7ae22482973b5a51b08cb.camel@amazon.com/

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: bpf@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-pm@vger.kernel.org

Ankur Arora (14):
  asm-generic: barrier: Add smp_cond_load_relaxed_timeout()
  arm64: barrier: Support smp_cond_load_relaxed_timeout()
  arm64/delay: move some constants out to a separate header
  arm64: support WFET in smp_cond_load_relaxed_timeout()
  arm64: rqspinlock: Remove private copy of
    smp_cond_load_acquire_timewait()
  asm-generic: barrier: Add smp_cond_load_acquire_timeout()
  atomic: Add atomic_cond_read_*_timeout()
  locking/atomic: scripts: build atomic_long_cond_read_*_timeout()
  bpf/rqspinlock: switch check_timeout() to a clock interface
  bpf/rqspinlock: Use smp_cond_load_acquire_timeout()
  sched: add need-resched timed wait interface
  cpuidle/poll_state: Wait for need-resched via
    tif_need_resched_relaxed_wait()
  kunit: enable testing smp_cond_load_relaxed_timeout()
  kunit: add tests for smp_cond_load_relaxed_timeout()

 Documentation/atomic_t.txt           |  14 +--
 arch/arm64/Kconfig                   |   3 +
 arch/arm64/include/asm/barrier.h     |  23 +++++
 arch/arm64/include/asm/cmpxchg.h     |  62 ++++++++++---
 arch/arm64/include/asm/delay-const.h |  27 ++++++
 arch/arm64/include/asm/rqspinlock.h  |  85 ------------------
 arch/arm64/lib/delay.c               |  17 ++--
 drivers/clocksource/arm_arch_timer.c |   2 +
 drivers/cpuidle/poll_state.c         |  21 +----
 drivers/soc/qcom/rpmh-rsc.c          |   8 +-
 include/asm-generic/barrier.h        |  95 ++++++++++++++++++++
 include/linux/atomic.h               |  10 +++
 include/linux/atomic/atomic-long.h   |  18 ++--
 include/linux/sched/idle.h           |  29 +++++++
 kernel/bpf/rqspinlock.c              |  77 +++++++++++------
 lib/Kconfig.debug                    |  10 +++
 lib/tests/Makefile                   |   1 +
 lib/tests/barrier-timeout-test.c     | 125 +++++++++++++++++++++++++++
 scripts/atomic/gen-atomic-long.sh    |  16 ++--
 19 files changed, 465 insertions(+), 178 deletions(-)
 create mode 100644 arch/arm64/include/asm/delay-const.h
 create mode 100644 lib/tests/barrier-timeout-test.c

-- 
2.31.1

