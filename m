Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF85429BD9A;
	Thu,  2 Jul 2026 01:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782956081; cv=fail; b=EmJQP39esbjOmESSZMFekfiJ8urzvz+DM1/ERX2jP2FHwl1u8EjoQyp61f/IPKSUJQld57snXElrRcO8+b9krs0XQLrBpuGUazeS3b3lcIsvVdBlc4WLJ6T+qMwGq+Lsk3sh2TegNGKwwhOD6KRdFFM2g9Ujogun3ec3XCC81HU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782956081; c=relaxed/simple;
	bh=sZhUI/dDPdbRHKh6YZD0FH5cF+ABM0txhK8HM8sSXWY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AFmk+Den6B5p2Qs+2wa3xD6bFi2fExI/N2v5RNfr0zG2Vs5+GBEoPYfuPs5rkTQtDI2OAnauCRXgLCjGiZakRdCRRYk8KC/Dfab9KLRfHOGf+Jz5/5wnk80EWgyXXiuiVfTdy6CzDLsVIhaTBwnUKAjn46Cf4jadvmCSvrYvtIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VG1Pp71n; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dgRt/PVT; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VG1Pp71n";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dgRt/PVT"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661EKFmU2784219;
	Thu, 2 Jul 2026 01:34:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=NyEItK3t/VYf22t22UK9Szz9VxqFORUHcRXwKvM5OJw=; b=
	VG1Pp71nvopRyTjRs/LeAhboUCe8LXrNz/KF3lAfpGOV3aHt1//a3EaeXrgM8MwP
	n7s88z78eL5NfUwM8VDGjiM1T7iNIR4hwyt3jjqvtMkxo0ro2cSizMgPLsuT+DCr
	AH6fFCUvABHgCr7KJ87eJL0senD2eon+dmfIzC84fxDnCUlE++VYEugB6pBMjPLW
	+x80E+LblE37ULetsFLK9i6DwCH7dTr/3gGJ62QcC+sUt2RFp2PmTtZfkIRZjjcI
	9zrCCd+779nQNcq6zIvI2YSuiy7llk/p8sn6AYS/ext1DS0nl4i+99snRX3b7PtJ
	Tkgg/JjGQDlbHcm8EOT3Jg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4f272qq6sr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Jul 2026 01:34:13 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 6621X9nv012701;
	Thu, 2 Jul 2026 01:34:12 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013059.outbound.protection.outlook.com [40.93.196.59])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4f24yg6w91-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Jul 2026 01:34:12 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZoRAgorBUe7Rv8JnELSY0QhQ69ZrSEq8BSNodqvtC7uN26ORUYITBeeqAQ+NYKlllZ9JK5o1NjIkY/sUh8T6ngzXrIXflBfovW6/XwPXch9invu4o53xjjAXwJrB7JJS9EhWA5fK9qcCKBokRYDlR0tnCY+cfGZSqaNeGvxgui+XU+gm8w3rycchrn2unSwr02w4FrHY9gf5xApHprAdqTjW/H2Ukae64COo8dSr8PcVbwq7GmsAMJ7KAx5CE2iO2habYy7xDUSR5LONkJRLjfAOwbvpubF1Y6Ss9SbJtcDSV7oPA9euyl8JRVwYR0T3oHpp2zGbw9oM++QFfbr69Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NyEItK3t/VYf22t22UK9Szz9VxqFORUHcRXwKvM5OJw=;
 b=NHKRjTZomJKHjdklTB/u2VwBDCftZLlvCo67/NgSPDel7OLsiYVUzxpBqKN4R6Oyinz6JJSxWj9jLlakJvv9V5XogIwQ4PRzZUzenZ2MLYYWadg8yb+jNioUebYZbzvndE6OnO/TVffLqeRFgJVFmf+kPdWP+Lhq0uDIhBoI+Nl3WuCFsgJTWk3/T6xzWxkzD1fibczWFJm3AMrFH28XPe1zIKIoEEzJOKIaPzDFZ/YoORfF4GsVJiGqcJ48eTCc/YiC0duvSHdOE+4+Qz9cLJ+vtS4TRyJKuOkn6/5h/sMn9uVyoAVuAqIvgeebed2f4/8b8V1gya9/qmwy1IRzjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NyEItK3t/VYf22t22UK9Szz9VxqFORUHcRXwKvM5OJw=;
 b=dgRt/PVTGjoPJqTe48b2L4uYZyWgtk05WXhcV9PJv9DoeUhGuEIxZOe/jEo5Y6mFyAmFKWGrXPVdjV4T3eE/4J5UIgYn7zSfk4v5j4VP22wZCNkoj4Nf+eKCHWLFFk4S9r1/nK1nxerLBkmLYQM2zEKxs0zgvPU3fxIEP4OeA7o=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CY8PR10MB7314.namprd10.prod.outlook.com (2603:10b6:930:7b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 01:34:08 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 01:34:08 +0000
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
Subject: [PATCH v13 06/15] asm-generic: barrier: Add smp_cond_load_acquire_timeout()
Date: Wed,  1 Jul 2026 18:33:25 -0700
Message-Id: <20260702013334.140905-7-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260702013334.140905-1-ankur.a.arora@oracle.com>
References: <20260702013334.140905-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0259.namprd03.prod.outlook.com
 (2603:10b6:303:b4::24) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CY8PR10MB7314:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b543f3d-11b1-4fb3-3dbc-08ded7da026d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|3023799007|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	CbYbEBxdJET7AmKhgPHUhojACNN+CSQY7T15D1GIChLvohKZba4kqYqhzlqwMWhvxw26uBVutSkW/IYTNLqXJQBm9MBC6YzvUSUbT47wB8qbiDxXZ+V1pTmFoKSBEcGq6d3ELBbnnu67Nl7UUOWyQFnbRsHurLi2e1zvucGvkcn+FuXFRBTRpVrtbP/Kn+ztMfX55EXJajhbD5Ag/YCA7bvDYuNs4uyxaKONfI12J+4YncPSvfsrjFFua1kOc2BcTSC3DHSnfDByNzqqQgA3oJw6XGK3B/FxoFr75z2b1C3CSgPMkfNUKTVlixLvsXu+7myQGJEFoYCPJr2EzAdHDduGcBGEjQ4Xey9zeVNGDqOYvivWXYm82cMvt0rF7IR1jwl1+7eWn2EFWFwgEU8LPQyC0hsAuR06j0Ac2QIgb8D/tIBYaLm1+/TBDEO8xKM37tNYnXTFa3YjcFhi6Sqg/2Yac7F9459xmthlG7jFZgh36LSi+rX+WsNuV1y7tLRirW2Eufk8OxtlNXwrxowoOUotk+WZpU7lL3opkuB8yMp4DCDNY/ZknLJD3T9oO3Yr/9PuPQDs6n0nJtQUOvEef21YdLCQVshr3hHpmEpPSeayT8fbey0txCHadufulBUdhRxFGX2TAvHLXQGzDZ93pGNUTnlRm0FJudDQsJ46xX8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(3023799007)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DbCUQk6a4fx+E8U7FnxnD1sKo9FBotqQiJGNgoh4m74lAsCP7357vB29wcwb?=
 =?us-ascii?Q?04dbWdGXW6UPNXMRKqo8S/hydfXBn092OORT07uGMdv5PoQFBLxxhqngY/e9?=
 =?us-ascii?Q?JHZjpZGDSm2KUmxSCYxEb3NhJ+ymo92hvSJH01KKPzuim3Icw+IP6IRyvoG9?=
 =?us-ascii?Q?fw4EU5kY7ARKrCwm2DASnwxmPVh/u693fkv7n+iiyQh4arNemGRxX217wxm4?=
 =?us-ascii?Q?Te1mCzMdZcsJ4sq9sBBHsQVvfGgF1jcTBqNjAVxFuuC7xYR5d2l8nGKw3eQ9?=
 =?us-ascii?Q?1HxZESNVt0HbEHGPeE4aCOk+z1f5/7mWZzdOZFkJ6jXtnlWsn6ipjgC12W1j?=
 =?us-ascii?Q?23gSt3DQdu+3/Rf9k2TY6HgftHB6t5YvZkixxqPyPv6IJGI7SOAsJvXrrPij?=
 =?us-ascii?Q?AGQ52tnMSQlWa4uyistQBRJ2F+OKrQNaHIKj+pD1LT3dTidkdhQ7lJrxii8Z?=
 =?us-ascii?Q?ounJoeQvB88to+Sg38SFycLPIX+fyDvqNqnGbeLf5dOoRpxTgwmg7aBOVMTS?=
 =?us-ascii?Q?4XjzxjMaOclZcGeSC2HPgBTlz/TD0Ptx211Lh9wlJgKCmuHOtUus3ICZZlmy?=
 =?us-ascii?Q?e+cAouLTtL+eG/nplv9HXE2PUAJsJeDS9VNfXrQI/5UR8FygU8pVDX22SHnN?=
 =?us-ascii?Q?whxIxmA1B4Y52QkMOWG13gFggi+AVOPfvg6zN+uuA4i7zSEF1ZrXe10RvxsO?=
 =?us-ascii?Q?vVVXiipA8mT0Tc2G6S4k0gPFnVfFIPU0snhmACG1/xqqY5Lih4UrO+kVzZ/3?=
 =?us-ascii?Q?Yfx61l3BP4BjxmIwDd/0SFEmPvRxkZrXiJba+rX1iepn32OWR+sV8OB7KDN+?=
 =?us-ascii?Q?XnIuEgKv9EQvkQs/sQQeehA1tT8pjR8Ee/FBzIlCOROiRLlmN56sUFDs70uC?=
 =?us-ascii?Q?feEEUCg4iXI+tai7MIyBVIt5B8y4X0HNCgGMRmgSSgWWkmKk0UnrAALn/uaP?=
 =?us-ascii?Q?O94UdextWKGzIaIneeZ+LeuQRjZcQSfBpUeg4oM3JYc5X3pPpdtfZB5mRkQt?=
 =?us-ascii?Q?Xur5TiL2SoFMsRBhg1IcosJjb94NaOKVi+YBqa7O5OMV4SRCWbt/5A66dxVY?=
 =?us-ascii?Q?AEDvzK3R9jCey/tgzmEOyy97b1EJr68y8YS2Tu7AoGZwhTtPvB9hKBEvL3Lw?=
 =?us-ascii?Q?TKEdyDXnRoVfrPbjWWt4do3dXOkOuTZum01LAxZsHXp6tRjNmWDMZN5akNjU?=
 =?us-ascii?Q?W63QvXfiVwIbULcNw9iulfqi2fxRt/BGvRFo9XSDcQRttumGunuNW4QmFDeT?=
 =?us-ascii?Q?NnKgJkugiTnfkTNmPXaOzD5xbsoCb5Q50cCRrY0gx5fXkwa3Pl7/tRl1BFPp?=
 =?us-ascii?Q?xzP0yI3lXy7+7Ztv2Xb8wNnHydQpkc1XA5iol9fhLY7eWHutq+YvpFpV3tDv?=
 =?us-ascii?Q?IOHhUv9Vrligu9d3zjTbdNnZuPlkb7TnkyGhx2WzCdRxWShMWOwTXLkF/xpH?=
 =?us-ascii?Q?A0DrO8sNKgNnT5Yp8gRjLlkNnCT1u8Ybda1J5RHI1CPvJweG99zMVdFLx80Z?=
 =?us-ascii?Q?hxCaIsIC5y8XNHaDV3+R+qkEfQB0lIQ5aq9TlDlMoVzi372TMpzb9Ln76Iy+?=
 =?us-ascii?Q?ZQ2DaFFeuDQ/jq4NdCOyHnz+uxiZaDnn/Dfh2qK9lB0UuI/LW5+jY0D/2hZe?=
 =?us-ascii?Q?6HwadTXeGq9yjpFpGvJV1PhWFAzK3SbnX7srl/lv3yHwVW+gnu5sA0lkOc1M?=
 =?us-ascii?Q?zv6ZehfgEG//mPHffh4pQlvvi7tIWvnibJLC/yxxQWQAJzuUztknoRpbQBKv?=
 =?us-ascii?Q?YtrhcjZ+TYV8wjYZZMCfxR+AnulrAsQ=3D?=
X-Exchange-RoutingPolicyChecked:
	jNMyTNUbiZE80T/uv3iSjliDJ2MfIZsc8LDwOMXVJVU7Wh3N6GetGkhjVwqXYw+Y2jBaMS2fKDWWeCvhpTHl9BXyj06N276a3lFDYWWPWeYOoeB7xmiY3Ai8qxoUjmEOyy0ihW1j2s5Pppxp5yWARXIPgzaHhLw78gtWSBZ9AqR2i8LkZ4m5690IswtYUUekcNKkstVrnDRIL2t6TTiS6ZWMvhQ/31SdvOv8b+ingn9HMAtQDK9/ryDdXJLbNqB08BZ8niSyABJC1fdFvwPP5tt6gxt9KH2ON4LtIx5wj8uS8tpfqhN3QSZExV+Zh8bpD8IuZpJgVVzHFz/L8NsPwA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JalGT17TriAswHpsUkUS1prR/uWXYwZzvXK6PMoFGXbiI14drt/iu/uVDUnSF+idhwOym4wu7xKQ2jk48uMCvuvE0lEnqsO9OdGWSKlavu42iXJ3r1boqHdaEFCdY45TWzHM6OaPY2LNFqalCljtdCdm3GP7pY5WArm0Qa+AdY9W1RsugGjbYGp0JUFejAvFlLX54tgWYakvPf8bAnEe1j/gmxRagT+bcXjXGDW9J1f9AE0u5369C7CG+0pJ+Ua3O2VUSEroMKXJK1E+bYVZyL+LJGhWoq+N2jPeMm9e5IBirMWW90/Lmz/jfpbol7Kzm/PRi44Z6mHiwJHLinBNZg1Xhh8IjFfPBKxwMKhBBnXcsV9/q3ckozPRXMnIcZXcmiD8QywmT5Mf3w8W/6BSV8KMvkWAIFtldp/u+rjqngNpnJ271fdDERRgGwyUZwK9vOa9/nwwhI/yDZUdDfOI5GPOBDtuXqeR2I3JVz/LrRJrDLpF1b28XdSvCUqqyCGW/V3jPLtmcx/45M9wH9/MqfynTf3Fw8A4wvpHZkq5VE192iswSbEs6GTmo3a/atL4s/lC90Ke2VOZKTFZAVsAUjA5Y8hOrM1/o2jqNRm/uVk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b543f3d-11b1-4fb3-3dbc-08ded7da026d
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 01:34:07.7910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rekKsx54MQAyFhYm+H27BLNhtYOoWP2NzqMSh95iMEE69aQ1pBzRonaMB3oSwXzzphsZzWGL5WQJijxypqqvQiLscDknKXpEIbdu/aPdk8I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7314
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 adultscore=0 suspectscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2607020013
X-Proofpoint-ORIG-GUID: vQ9cfmOla7eV8kRtRXVbHONg2Ovt9Ou-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDAxMiBTYWx0ZWRfX+ZF7dAaBSsj9
 WRWSDzXoTZ9hiDCxfe3f5cfdnFiv9hkGbUY97ODQ5OGAuH+ttmkYFoJ/YfYMvu1b1SJCXUIP1qi
 XsCfX2T4c6eVyDLjbRhSuggSJFsmZD9mHbUXmrAQCRw7Kvcx9VMRqGaJ6vGIuKHF1qTkG1hv7CV
 /8aWMRpOnOKv3OS/o0soeIwERgD9fz38wT73U2vN1vqDcrFqDCL0Xf7SPGEohqcQsME9C6wJUZW
 ADll5cYsX86Iw0XxdFjRKXzevRLtCo0jc5U9wPV8f/G2SX2Ef8ksTEE4fzBnk+Qa3XoNm9+YewT
 KVEDV9td0BJDvdKmgCD5dL4GWB7gfYyfoNoDr7nvIegM0wQzPKDxNfTni72bV7xNkNvfG1zhFHj
 hnTMAueuD+h/qPnL0Ujslg0mj5PWkkOrnivhLDGYsbcLSBr8+d5Mo7a0LRP7qZrYnswtmqGo8kn
 Dp/O5t57jNEMmGU0HaQ==
X-Authority-Analysis: v=2.4 cv=LOxWhpW9 c=1 sm=1 tr=0 ts=6a45c015 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=7CQSdrXTAAAA:8
 a=JfrnYn6hAAAA:8 a=vggBfdFIAAAA:8 a=yPCof4ZbAAAA:8 a=RHMiYgDku2Mo8patKHkA:9
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-GUID: vQ9cfmOla7eV8kRtRXVbHONg2Ovt9Ou-
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDAxMiBTYWx0ZWRfXyDkSml89MDKa
 pmj4DAyP1vUzQuw62EZmmAECk4sZS+9aVrDC85c2YtatgH+J/L15SZuJIf8A3AiEns1nisICSAR
 XhXWf1LDPj2B1912hKjobw5DUfJQ+QMYfpu3E+Nf52bhLH5wn4QC

Add the acquire variant of smp_cond_load_relaxed_timeout(). This
reuses the relaxed variant, with additional LOAD->LOAD ordering
via smp_acquire__after_ctrl_dep().

To ensure that the necessary control dependency on the dereference
of @ptr exists (which does not in the timeout path), re-evaluate
the cond_expr branch.

Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org
Cc: bpf@vger.kernel.org
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Haris Okanovic <harisokn@amazon.com>
Tested-by: Haris Okanovic <harisokn@amazon.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
Notes: addresses missed control dependency in the timeout case [1] by
documenting that the acquire ordering is only in the success
(non-timeout) case.
However, we do need to re-evaluate the cond_expr branch to handle the
case where we hit both the timeout and the loop condition.

AFAICT, rqspinlock only cares about acquire ordering in the success
case so this change should be okay. 
Kumar, Alexei: please let me know if otherwise.

Catalin, Haris: I've retained your R-by on this. Please let me know if
you aren't okay with this change.

[1] https://lore.kernel.org/all/20260608082746.399BB1F00898@smtp.kernel.org/
---
 include/asm-generic/barrier.h | 40 +++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
index d53e75a92598..5d21ad9f358f 100644
--- a/include/asm-generic/barrier.h
+++ b/include/asm-generic/barrier.h
@@ -356,6 +356,46 @@ do {									\
 })
 #endif
 
+/**
+ * smp_cond_load_acquire_timeout() - (Spin) wait for cond until a timeout
+ * expires. ACQUIRE ordering when @cond_expr is satisfied.
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
+	__unqual_scalar_typeof(*(ptr)) VAL;				\
+	VAL = smp_cond_load_relaxed_timeout(ptr, cond_expr,		\
+					     time_expr_ns,		\
+					     timeout_ns);		\
+	/*								\
+	 * We arrive here once the loop condition is hit, on timeout,	\
+	 * or, if we hit both the timeout and the loop condition.	\
+	 *								\
+	 * The last case is low probability, but possible in the last	\
+	 * iteration, especially on architectures with waiting		\
+	 * cpu_poll_relax() implementations (ex. arm64).		\
+	 * Now since the loop condition is not evaluated on timeout,	\
+	 * we have a missed control dependency.				\
+	 *								\
+	 * So, force a re-evaluation of the control dependency to	\
+	 * provide an ACQUIRE ordering for that case as well.		\
+	 */								\
+	if (cond_expr)							\
+		smp_acquire__after_ctrl_dep();				\
+	(typeof(*(ptr)))VAL;						\
+})
+#endif
+
 /*
  * pmem_wmb() ensures that all stores for which the modification
  * are written to persistent storage by preceding instructions have
-- 
2.43.7

