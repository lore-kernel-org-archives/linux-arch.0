Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE87C3DDDC1;
	Fri, 16 Oct 2026 07:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792134576; cv=fail; b=L5BGvcJgZd1MupJjNDsuSEXm1JcmgcQ8Z+LyM5Js0Y0KGdTAQfZReCj/izrzrlXgEMZ8kqDZfrJ0dX5sgH27rR1xetivZLnfPhBTVg4fqYxvof7b0UK8pWj8ee6zsxX5y7G8mkcronyEr5w55kuDR0/fgj7jtjvaAERCPzbzsCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792134576; c=relaxed/simple;
	bh=clGwjuV+gNSykjR4xEb9MdxufTTw9tefde62nktxz+A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M8FRLg3BBijkZDYry04VsHLQKPBKZLyMZmA0/cSN/PMpJAIhVelOW9hIA1l3T2qUFAX8JKV0nt5cRUQ9wCpBWN6r+zpR/GzueyaX+uxFkPp3MGj2x7izraQM1xnrCPfiBgtsI8BRixmInFxhF6rsLIphBhulBLilG7f+y9ySG5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oCuNfhH0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uk+F/rqJ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oCuNfhH0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uk+F/rqJ"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69FN6oUQ2066091;
	Fri, 16 Oct 2026 07:08:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=GIMjd7Ztx5xAAHElrMSq9bEL8YkhluBc9/ovDPrPtio=; b=
	oCuNfhH0TNiDLGznM5DgDQi76J9MFrTGXGOtZShsQdz8Yu93uzO3woRTzeLxMVTM
	VCyma52Ouf5BfxZ2jqFRy49AshqrH0iCeXnjSyNVsVoHw0M1oCZp2+PFwv8aTEV5
	Q6w+rR+e+PVFRsDU9JvJpvmM4TWSiGG3lArfF6QqOafFIoTw0uRzJRIN3KQsJdtk
	f3L+XnMznyYLEochCy4Eza+OpoQYQmD7Sdu/aXC/eNCbDOOKavdxe8GSy8FZgSDZ
	Wwyscn/7H61L4v+z0Cuu9OmyYYlHFNjAGZWNscPClKQq6etVE4SbTzvcIhJmx8/D
	2/RHk2z2DrvkVAZJqX0eeQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4h7de1sc58-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Oct 2026 07:08:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 69G76mN2014563;
	Fri, 16 Oct 2026 07:08:49 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010058.outbound.protection.outlook.com [52.101.56.58])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4h7btt1vhr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 16 Oct 2026 07:08:49 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rtkDwhtfrQ7A7oBS3RbXGhLuQ+YWHK/oDQ0UF8q4dzIoqekowf2FJp7t7SZxkU8bAk+QKUyEiPrsXbR1iSj+aOGXjKFY+OVl9mDBCrH9x987klN0Qa4TYj4icm+yDKnthDshj3CvdQMf/4jSrjsIgM3zytrh7dTjAOmJxzxJuqxoCtE3iIC7DYhSby7F5yJ/3d9JCa9HAcQngPBmcYv0KGpAzgqM5ZSwNPARCFVAUxF9rhPymRvpW+Uo739taz9O3XlDbwhppdbNQUh082/FCYMZ/XsTqCTG4hp7+uoUW4H+wnRavm02Q7d0hO+BdDTStpt+HkCtItW652RPp8g8wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GIMjd7Ztx5xAAHElrMSq9bEL8YkhluBc9/ovDPrPtio=;
 b=p9t9Nh2BHU4ugxN8QzIp/jhijIir9fioa4UkC7l9VydgMNY7yfyWsXx8VDkrkyvMa+ei/9kGI+lZyhXWeKOL5PsrnxI9hxD3sk/BuNnOseLcBot6yWWoaYoDiHBctO43UON1PGd+nTL8nsFN9covk37bnSHIhlNCNF3PYrkjd4MSI2AR6AKGhrJ/cbCRF942gbPDIrJELu2QNv7WcZ1hCO4z+6kzvyX25Jof0Z8BTkYhBQWdGzJ4wlsh5RqdARzqsfnKRfycX6Y320BWF9DObjk5mPPSruBrvRI27LOg9hk0N2FulUIOzMOqQXWQ8g9r0Rk0e8fBFX89s7PpjkKYwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GIMjd7Ztx5xAAHElrMSq9bEL8YkhluBc9/ovDPrPtio=;
 b=uk+F/rqJzIw8h4J/GoA6ZstMr63ZJif9hpUcaNkNI7yUL9P1NxaQN31GPPU3rX/5VF4D/MJwkT/MXcSEIQVu5r225IFMfu1ST87sLpAnXbENjKXkVHwaZWvB3aqtnE5TYFO7d4Vik2rHDNhH6mJRib14fOsYZjEBzKY3GD+jiLY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by MW5PR10MB5668.namprd10.prod.outlook.com (2603:10b6:303:1a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.7; Fri, 16 Oct
 2026 07:08:46 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%5]) with mapi id 15.21.0546.010; Fri, 16 Oct 2026
 07:08:46 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        bpf@vger.kernel.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, rafael@kernel.org,
        daniel.lezcano@kernel.org, memxor@gmail.com, zhenglifeng1@huawei.com,
        xueshuai@linux.alibaba.com, rdunlap@infradead.org,
        david.laight.linux@gmail.com, broonie@kernel.org,
        boris.ostrovsky@oracle.com, ashok.bhat@arm.com,
        Ankur Arora <ankur.a.arora@oracle.com>
Subject: [PATCH v16 02/16] arm64: barrier: Support smp_cond_load_relaxed_timeout()
Date: Fri, 16 Oct 2026 00:08:23 -0700
Message-Id: <20261016070837.440748-3-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20261016070837.440748-1-ankur.a.arora@oracle.com>
References: <20261016070837.440748-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4P222CA0006.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::11) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|MW5PR10MB5668:EE_
X-MS-Office365-Filtering-Correlation-Id: 54ba6e40-e85c-4a72-f583-08df2b5451e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|7416014|56012099006|261009223027099003|22082099003|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	B6liS3Udpcjc8Yg+ELG4NlFjIABkJVaH+CgwEpu+jdcjXnQwGEsbJ4SRh5ixH2s5SNtVmMq9YNbGTk8DuZFYHxTCTY2ezBj7B8WgqgfcwEqogKdFaXAZkwlFStXjMWwSTBtTDauhfnkL4Ipzb2gV+iem9mA/2w+nb0XORq6Om9FZD5l5oBNeVAARC6dC8JPfVgASDB7bvYwDggO7EFTiZb2lSDDGQrdudTn4gJGiXhMFpgFNpCi979sozxe36exMjM9DFeljHB3T55upjMQ6e1C4r4gtQRI27iFShY2TrQbWI7f5ApeQLvyz7kDO0Akh37SZjE9oI7voM/GdfkqtKkNfuj8uMU8k49/56C0kK2q4uyDocFoOIOxHy9RDiKOcz9kfp1FsrT7nzQilj9hu6Blr+FZ95RtE979876yCNZpzwQAohSqdQwmkpAN610/xx5c9bwsd4/9P9m65OEQum2G+HCIBHR+/A5fbCgXJOgLwntIuW/bfsDxBLeJGD/71eukMUM73imaAzN0X4f5U+c5Lrb9BhuoKyIPGVHVxtulEC8o64eavr765aZ8ktOUDFX/iuWARxZztTnvET3+yNDxp6N7A4oc9g0mImY9eOlMDGgHIDT8udHO7vUIFkON+vq2MvnkZEKpPQeO3APTzhr+Yocuq/IMkvuEpbI7QF6k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(56012099006)(261009223027099003)(22082099003)(10067099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D7BqIacpc/y8bdX4Tfe4cb/mbKs1mm9T0Ppd7IrD8NAcwrpkrDOOiiBSp3Dz?=
 =?us-ascii?Q?uXHZsjcXXJ2BHFnI7AD53B7HSQr7xeruXAH0r/li+2hvMj6mEXlAUhOSTgX1?=
 =?us-ascii?Q?hsRzLoAb/mAO9SwKsNHHVve6gxq7wHL4EwO2oCGK9m0WICsJ9sJtZKtDSFIi?=
 =?us-ascii?Q?wTooSLF94gngJmOKZGvbLPLVtyzen8fScN1tx0r6tPsPplexwvUBhTRWHhk3?=
 =?us-ascii?Q?H6iKGQio2HEGNDE9nwJ94NttUomCo++bY0Ppe5AOXVSEbgwDBrHulbhvYyy4?=
 =?us-ascii?Q?E1+5kqn3dI0+HFtOECCplSo+Q5pUIbZmnPDfG/kLPZuK+TN5wK8eUXCb8lIj?=
 =?us-ascii?Q?3RR1mKU5eUb6JEhWHNsU+o8rl2X6Zo9agfbs7s8APBI3K4Q/ccsCX6SjKP08?=
 =?us-ascii?Q?mLOI0cXkumuIjNoPVg0FawbpoMKfBrHjKT02ru/4+czMpL7NrAZX/gQNroyq?=
 =?us-ascii?Q?ea9tiwZkLL2q1oDjOUSYmTGjXmZlArQHkMMRC5Lit3q0Km52Up8fgC2zegj/?=
 =?us-ascii?Q?Hq1P+hlrAwfK921TZ6WdeqTN/Gu1ceFiy4lWkEJUQMf6Dc98JSoTQU/1SceZ?=
 =?us-ascii?Q?6tamlJEd0WxofoZTcg2dGjY1DJZ07ONEs39iZ/a3bOWd43wz8aox1yDw/B+9?=
 =?us-ascii?Q?zXahT6nLrhQBYkhUjTjkmLdt+0HC9MOB081QajMZuZWwjVQfZlXO44+st1cN?=
 =?us-ascii?Q?3Q5Gm28Msp5ob/ff1uZuGDyUPga5FJFaxlbiLEy0lsSiCNwWpJicpNnYeJQh?=
 =?us-ascii?Q?Ljd8Se5iAuXltw+GcxYLGl69LavP7U79gwv/q8sn5jNkWlhueU+nP+YpMLJi?=
 =?us-ascii?Q?mgiXJneK/4X8gHad+0uLxwAgk7AqmK5Rhkn/ED7P3OaImEV8HrVfgLxEaboN?=
 =?us-ascii?Q?+PT5oU7Y2+wAPMLt8hQcLD3XV7gH+z6WfSKC+wv98LJRNtk53NCg9cbKkFs9?=
 =?us-ascii?Q?HbgtPEA+TDQQbDbqKap/IRjmp3hRfDJD/G/ijAGUnVubcrXWDcn6rmLcboAA?=
 =?us-ascii?Q?ITpuZ4prq7juwtaeIdtXUJGzJRQUN21+kGI3RBcN+ip/l0Mn/wJtUu9/C/xg?=
 =?us-ascii?Q?cSz3Oz3BME5gixcFudtg3mNTADIRBUiAfztNljJQ+CmRBdaj9ShOWNauQDQ+?=
 =?us-ascii?Q?s3cNQ2cO1grYDoW+0aV0V22b+Q2rC/8xd6jKOl3e+91MxmWcNI3XprsUKr2X?=
 =?us-ascii?Q?OL/kCLUWI1mwgyNUXWWsOOagl8Vcb2/et7pJDPDGrpo2CRLhw7RFtPSwI7Pc?=
 =?us-ascii?Q?ay6HSIY9YM6urKZl3AJVxSlMF7yAVy+pZRufXyj1agRor1tNumAm6qPbmV1p?=
 =?us-ascii?Q?Xo+8N6X7YVaXLdElHExZc6Ah7nv6n6Xd4nmTL9IY5dYXlcKmBmXRpFmG6p2k?=
 =?us-ascii?Q?PvX9LrWxcLciyodyFb/5rtXaDCi8Gyq9Ht9xpovRMlUSLF8ezUzDIQ4Sq8fz?=
 =?us-ascii?Q?NJWW/HsQUjIWC1aIHuU8uh5H5J9BL6t3Xy7c5rKI06jL4DsTUSRCEKoM7CMe?=
 =?us-ascii?Q?fVLtc2B0m7ea+FcSetv314s4QziyRRaqxIAEYt/jbS9nNhwmu19FicTbV8hs?=
 =?us-ascii?Q?WitoBBJhl73jUGplFsLHMM3Pu+gT3jMxwwCQfpckBQtxeaCE3LOy1BU3G9FR?=
 =?us-ascii?Q?PF0P+32PwfV+AywC2cQP2TX586L4xAz3zthLm8YYHHnY1pKLrYXTef2hWCXA?=
 =?us-ascii?Q?pjypQTzvqg8u3sT9H1lnONfKn62rQ4sB1F4CenTan4CeSXZOAZ0UJrdYvsMi?=
 =?us-ascii?Q?y4B4vlhgyush20zyTyf6UDu1yOGVjQ0=3D?=
X-Exchange-RoutingPolicyChecked:
	bL6mH+EFk+JdGWEg8Rrol+0fSnvV1Z7zC6ovTSHdxktIMP62mSVr+Sqfa40yZAmT3dKwjwi232ULsiZHtRnaFDX+CdnecbGhFt3b3APhiVvQ45F7VrEutnBovChCa4UuuIORtQ/GLjX7gLw51uVjQNvYZnvXPSVznG4mgGuL/5mbex8HG+AtgJc01pwSBN5xkiuF21vRZUIc6ZlCKq6FZWZiNJw5VUSO3rqEarphS/HD+mIAqr69bBmxmbVzzskQJT+u/KHSgkvQo59YjoC8WH0wCC1Sff8OwSqrqmpZndSgf0MbVS7E+HDnWNGS519AvhrN5nTt4BWZaMvkmeebZA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qICrUeeNMU2O4lTabNXDx/k+FMVwXH7Fdv9R46DfABzHLsAuuWAEreU1P9zBtsh4BXuZ+7X6qVe2+Swv77zE8odKi7eRVvbzcQ2GeECZr///ecPFlksKsqsJBfg1q/Thjn6uL3rv0ZSWiSWa6r4Ka5xbJaiaURkdfHmyLF6JHqEddlfVRChtIDDWyYkOo2OwpjMjvozIe3qB/3vxHqHnrXju0rDZHe8SkaRIVv+3wYRBqUJSbWqe1MidesbczotCpEzM3uYswerjvf7o/F7Y1BKdQ75QzjbN2FC1WS9N4vSvCqrP4dy4LB/JCvekTqFhDRwr4aGi5qz8Ug+2p7OX8VZ25YSJ1CnZGu7xtTBxApIcqZrKZgFia+S5rVFnQ4RltmCmaAVyRx2rtZbqyVn4K/dgqKwzSmq3he9KEU/CKDRGUyOVhf24v3RduKfkMHmLk6szdA5El7RhRjeJkJ+GWc+0+EkJcMEmLQvQ6pvExDtsJJLY/F/MHBP4vBh+7+/3R8755VNMxH5cRP5+kT+IqMMPmCMMF26zaXk/N/nHITKYIFEOA9szTD3FQPstipQSpT7aW596Vk5TwTEF+1769F6HKhzoYatjnKElwdzalBk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54ba6e40-e85c-4a72-f583-08df2b5451e0
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 07:08:46.3220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1VFGSefrLOgk+47ruiHaXzrnUsoDgGg3aKdfWBcVNIJz8uqdK81U9UeTzhCIHeO1puMD9psXqjCw2QqyhZXPVd2HMFtx4GGe+bx2L7uXN+Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5668
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=985 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2610020000 definitions=main-2610160028
X-Authority-Analysis: v=2.4 cv=O9SsLx9W c=1 sm=1 tr=0 ts=6ad1cd82 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=EIcjfB9IiI4px24ztqRk:22 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=JfrnYn6hAAAA:8
 a=yPCof4ZbAAAA:8 a=hR4SQ0wyJhDrZCoruAAA:9 a=a-qgeE7W1pNrGK8U0ZQC:22
 a=1CNFftbPRP8L7MoqJWF3:22 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22
 cc=ntf awl=host:12107
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDAyOCBTYWx0ZWRfX8lt5xzq5Z1G+
 ovJLUk/+o6wR4Xyrbd9KCDD07L6WqMrDTmr8jgNty6OiSHO6xnRZq+p7aK+Z12eTiqrK6uGWxor
 G4XlOtIx+B/OIe859nKRtmVrqEsUJEXbddi2kjJQe4WeI+sFqw61
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDAyOCBTYWx0ZWRfXxlK2aXL/NwO2
 BxycrSwIVwpbbDOZz9EFsTEGfLbcC5m/reGMZq6gH5xzM/CjAdLRUnee6eJ54RV1x2oNs2zCJ7Y
 nO98WximiG+PQWaK0rFxtOfHoIF2oOVPAp4iRahlGMhgVbTJB7gfJR4IKEeZk+jNPmo9C4baE9V
 +Wqa2lDhAJQYx04GJ+prPGOW2GNnLoXj0QyovdohEiwuJnKOHfTZml4O5cm4rmnoNrdduWjXGvF
 HCKY4QzrtUDvtZn9hslFgVXZEdisgdqm8kzjCWgQszx6ClrC/g5NG94RQVBQFQt4rM3b4s0lArV
 IvXkcJlBL1Bh+yHUicJj/lpSK+n4Q7I3Cg2r89USc8OO1z4qe1bghLFBCG+t+TxiCUeOHAO1f6a
 JTR13fFtX0M6wmxE9Qn/g5D8ZMdM2FqBwzXdGwUQ+cC4YyHd/sUO8eNKuYyPF5gmckSBZ2D+pnE
 ekw7aJQUwl6rGvclLsSJYF4A/53FQHS3an5yuRPw=
X-Proofpoint-GUID: b_BQzx5wX6A4rTN4PRVobrBJcOUwJplR
X-Proofpoint-ORIG-GUID: b_BQzx5wX6A4rTN4PRVobrBJcOUwJplR

Support waiting in smp_cond_load_relaxed_timeout() via
__cmpwait_relaxed(). To ensure that we wake from waiting in WFE
periodically and don't block forever if there are no stores to
ptr, this path is only used when the event-stream is enabled.

Note that when using __cmpwait_relaxed() we ignore the timeout
value, allowing an overshoot by up to the event-stream period.
And, in the unlikely event that the event-stream is unavailable,
fallback to spin-waiting.

Define CPU_POLL_RELAX_WAITS to state that we have a waiting
implementation. (Non-production environments might not have
arch_timer_evtstrm_available() but we don't care about that
configuration.)

Note that with this we have enough to define ARCH_HAS_CPU_RELAX to
indicate that we support an optimized implementation of
cpu_poll_relax(). However, defer defining ARCH_HAS_CPU_RELAX as that
enables polling based C-state handling, which really needs
TIF_POLLING_NRFLAG.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Suggested-by: Will Deacon <will@kernel.org>
Acked-by: Will Deacon <will@kernel.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/arm64/include/asm/barrier.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
index 9495c4441a46..e2263c754a55 100644
--- a/arch/arm64/include/asm/barrier.h
+++ b/arch/arm64/include/asm/barrier.h
@@ -12,6 +12,7 @@
 #include <linux/kasan-checks.h>
 
 #include <asm/alternative-macros.h>
+#include <asm/vdso/processor.h>
 
 #define __nops(n)	".rept	" #n "\nnop\n.endr\n"
 #define nops(n)		asm volatile(__nops(n))
@@ -219,6 +220,27 @@ do {									\
 	(typeof(*ptr))VAL;						\
 })
 
+/* Re-declared here to avoid include dependency. */
+extern bool arch_timer_evtstrm_available(void);
+
+/*
+ * In the common case, cpu_poll_relax() sits waiting in __cmpwait_relaxed()
+ * for @ptr value to change.
+ *
+ * State this by defining CPU_POLL_RELAX_WAITS. This enables a time-check
+ * optimization in smp_cond_load_{relaxed,acquire}_timeout(). Note that this
+ * is not ideal for the cpu_relax() fallback but that's not a production
+ * configuration.
+ */
+#define CPU_POLL_RELAX_WAITS
+
+#define cpu_poll_relax(ptr, val, timeout_ns) do {			\
+	if (arch_timer_evtstrm_available())				\
+		__cmpwait_relaxed(ptr, val);				\
+	else								\
+		cpu_relax();						\
+} while (0)
+
 #include <asm-generic/barrier.h>
 
 #endif	/* __ASSEMBLER__ */
-- 
2.43.7

