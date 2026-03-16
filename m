Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924FD24728F;
	Mon, 16 Mar 2026 01:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773625072; cv=fail; b=ceOzn77v8Ql06yr+p42TG9aZ1ep78C232Q4JY/eLJo1Led2iEN1MkhAGmiIrZMNchdU1Bv/RuwEgz/aYazu9FeVOwVkw9ZRj5NaCM7N2D9MOjn7hRa9pPrBHiMYk5YG2uIlqw7A/0mlRKWXIH6md1g8kZ5/xvgnLgubxzoYx6S0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773625072; c=relaxed/simple;
	bh=2vtvjsOlpr2S+8kit9DVM3u0fvLdjM0YRoev0RiH8oA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n2OsyiWTlSBgN/KKZwMZwXucdCaoM8o+6AwqqyO54fKZlFR0UI0MtSvEHBAJxWpHsGxvyYpiwlanDuYqem31kfSF/0sXcEjb0WPmsON/0Cl50GA2X0xHKSWyr4SAsol2RNh/i49K9y5arrKSk4VU8lfCNeQsPVtcaqXhvbsDDpk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PdJlxrtD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=e4s2Gz8z; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PdJlxrtD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="e4s2Gz8z"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62G0Bhhk1866514;
	Mon, 16 Mar 2026 01:37:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=trHRrOdEGaGNJ2shfnvMMpbGEzn6M+LOEMaNRH5VN+w=; b=
	PdJlxrtDuMf4mXXQpaiW/IxbELbfZXF/9KzS72Si+Pm5ccA7LfVoWwn8f5t1yLOy
	d0OreN1orZFavk8NIUWPkEkYt8RfdsfAsZbjTpmiEeUHkyu/pkAP9GMwCVFyLEM8
	ZZlyVWp5BPR0U2kpQ3yKl7h7oc7awwgUVnI50+VYMnAaAgVdcomHdnSA6OfVqtY5
	2RB0GOsTUeWaQmJGV5dhxbkha8blM7+gU5XD38VpbhyJewNu6WNa+ipbLf7gHXuO
	9sNa8xLCwqrvPqHn1xi+RxvVYU7wPyZpoz2DTlgiOAvJwMdFtXddieVZFiOZ76Yc
	VFU9y9nMk1tV2AxuytcKZQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cvxf41bdp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 01:37:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62FLQeFW014169;
	Mon, 16 Mar 2026 01:37:11 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012040.outbound.protection.outlook.com [52.101.43.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cvx4802ht-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 01:37:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GFTT3FLrnD/BkjR5XyvGf+O+KhpphaIRjXSNQzSK1PA0ljZkcYxLfrLiOsMRlLRehQ9Yjzkdd64Z7N4byKgpgTyFiZJLOmciD+sFSa/W7AEchZFUH4FKoCilOzFjMZawBBB6u+uYnhCTZqKjGZUbz0IZiK3Vm7AqkGNu5Dzp616OlFXlCIaXGAWyb0cNNUIlS8qnU11pKru7qNVKwWCp7wQQloRIUkJR1x2rPjvdoWAEeUFgx+SzHBi0zVg7v0WtTEj+gNDpkK9hoYFnNDP/dEbIQuNWoE4iSzQKM6o6DMsH6f5ziTKT4rwWX81oBrCS7AIByJqdd50c4w54ULUU0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=trHRrOdEGaGNJ2shfnvMMpbGEzn6M+LOEMaNRH5VN+w=;
 b=hKAcqaKK+jcttuycLjfJmgiiFK8nI4n2onH7fdxOXvhasWnkFhjLZGZRpzPSR3bxBEJaiVWQwnSAbYGYYKDHyAWczi0h4s+ETZXQKrwPhh8yxfcI+BGsfXZ49kK1zj9zyNIdwhJXI9qP8MY5ymmIPe3tIbJEPov/nQtBPM6JnmgclC6z5XlAkmLubB8qc9ImjdiK8uDrqdqt0Vk4iKvfA1JzKKurD5hoBggvmovfDGTsX6JALiRTcD9L7TR494cp8O1SlAgsmZBIaFUQnm/rz3qQwVqUcKLQ3K1TW91ewzx9eSfnj+qEg1NhjYrsX5YKabeFiU3b2t5C3XlhqvqqkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=trHRrOdEGaGNJ2shfnvMMpbGEzn6M+LOEMaNRH5VN+w=;
 b=e4s2Gz8zXmrf7GRURz7EpCieV3Cfy1r2NWYRn22hdVcpHBMYI3fYCPOD4/3ZTzTYhY9nk7sWV1N9T+SH87fN3x/A8Oc4K2sryai4m9w5MsEkWPDNUYdEQPu2CfF/6YNRhB8jjzXDMU/7u4Tw2umGfIU938oSHxyGPXWflIIk1bQ=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by IA0PR10MB7372.namprd10.prod.outlook.com (2603:10b6:208:40f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Mon, 16 Mar
 2026 01:37:08 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.20.9700.022; Mon, 16 Mar 2026
 01:37:08 +0000
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
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        Ankur Arora <ankur.a.arora@oracle.com>
Subject: [PATCH v10 06/12] asm-generic: barrier: Add smp_cond_load_acquire_timeout()
Date: Sun, 15 Mar 2026 18:36:45 -0700
Message-Id: <20260316013651.3225328-7-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260316013651.3225328-1-ankur.a.arora@oracle.com>
References: <20260316013651.3225328-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4P221CA0012.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::17) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|IA0PR10MB7372:EE_
X-MS-Office365-Filtering-Correlation-Id: d5478d75-e83f-4c30-82c4-08de82fc8996
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	3w+/2zMaeLWX3HnvD6CMFIWBGPrZZUHI6UI2w/cW86hgMRO4b6jeCz6z7PB8JyOyiWBL/O6NSuQ9XOVow4CimUeUL+6yUWqCvo5zgMMCG1Eh4LZCiZPYMjrVgEt6wYxGair94KKSQU4/fh+ZFfyfcjJTVk3PAC7bdq5vHeRO96J/vb1qB8sfRlSRNUgHLzDERpyqhKftU/kPH7j6V4neK7LKJB0bJOGxD1+4Jzqi8mjKphfC23Uwh6PIUYkVei+MNxp1YMpZcqOr3QFfkAVq5tkgWFcFDJFztSo8yGZs+mK6wZIQesLd3o6R66sH0jPtK3B05EH1GeCeQgK6pyJ01xbLBoNxRmXdjty5CSnpSv6RxJTDe6k110Np6t/pvYDGeK2wfXGS7GL+f6NrMrr7G9VUasAdWTaYLLp4kAgXByb9ajr+dtN6o/cskC/I+1/LRcXXN0ESQrkO6hq6RoHMG1MOEoW7r1dLAn+5vvbOkobufj+341r/mCrptaSB81hbOcgcm8DmTVwCB7lTtec/F/BESBD2U0yRMnE7oq+ueoVzlduu9Q5Elz0Mw9lu+jeoQqkYzl1cIssgXgtpfBdN1ooB92e00AWljNcgIcgdP4LP2mn+DBrZfZ24RK9x1u7kdW6uKM+H5WtnlJrpj/gmHx08GbPx5zdw+2/U/y7FdHQbEMZjMMZAwMagOOiC2Yije5TfWpf2g8Nf/HGP0XyhkPibjftR9pdaAHP93mvut+o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4TvZUbb1HItezzAMk3esYgjbOS+n6FGYVzZYXpM07obmLRA1AfT0XZDIrEj/?=
 =?us-ascii?Q?y3Y5X4LFxB+FchmDaSwuicJemP0u0YgIcMkh+lLY+oS5KC+ahppLh0wgxNkb?=
 =?us-ascii?Q?ER3j9b4c1pcTY+M0KnYL5u1Mr+9M8krh5r6a1yy7uxOMNT9qyMV6BmpbzmZ2?=
 =?us-ascii?Q?pL2BZXbFAOcT65zXWG41AmNl1aYXDR4b+Dg+DEYm5EMm2nOsq8l45O5q7hCA?=
 =?us-ascii?Q?rrUyuoCuVz3iDt9trkfPFVLhO/BiLeHDMCfejsoALt/SZd1HQLpPZ+xiOS63?=
 =?us-ascii?Q?GlMUWeYLbBssiIxCeqriXzBY2yMBU8G9u/a9AAkAkZdz+LuMnKMzkx9EFCrc?=
 =?us-ascii?Q?U/WqhuJ2GdLy7I5dHofkg0YxK0dij0zapbghbxvUorIZFQg4/Ar6+/wZhcfF?=
 =?us-ascii?Q?je4AJybtrmMLOjx7AoNiYYjG/cCekUkfjsgm2HBAWm0HlxeoqJrrwjMkpXp0?=
 =?us-ascii?Q?cxRZb/82TMtueqFFK0aCPyzIxi8ND6Wyw1KI5JzSBGvQPl4eC2z+rMQPH61v?=
 =?us-ascii?Q?W4pH0C9GsucjI8sNbX15V01dAUQpTHMXQJDlbXzWlDDACDFchnfOG9mNpoX+?=
 =?us-ascii?Q?TL8zNA89gsm27b3fwATDKGGBVQ3cjnRcFdQThd0O13vdUn/SnNf8gxlNAg6e?=
 =?us-ascii?Q?uV2p604hN0tmIGwyA3gsYzTKG6fU7tBkXssOFwcEshL3kQvX33kyNwK/oFAd?=
 =?us-ascii?Q?sVCurH6LyeXmQRxzu9iCKAf6GuYYSTDWMRiKFslrM2OI5OgzoAx7b+1oK3Sk?=
 =?us-ascii?Q?D/QH0LwQkmYxIegAUTiAC+0OZct1UmxjqgStZKZ8ZvEEkQwk0ozEROI9jc7w?=
 =?us-ascii?Q?O8+Gn3DtVRpdsuRdZ6m9mUv4Ucp0LCQzWX+JhAwIWPPizBXu5NFjUiDCM8G2?=
 =?us-ascii?Q?iYmSGfGL1H9Jx14UvkKegM5shvIdBxzjf07ncGy4eptVn+39tc1wA03Cwm3c?=
 =?us-ascii?Q?9wKYfVky+AObydjOaAphLWDyZ0wnniXkkx7oCC6lqYbWZ/PRp7h4JT9+BCUh?=
 =?us-ascii?Q?oSl3gi7IzmAQP0pD9j9e3NSEUPCxWR34NX4cXjXb7VmxR7RQLp5osRnwxSD0?=
 =?us-ascii?Q?xAes3jJ1jJkmS03noePGW1tJUMpACurcBhynauG+WyX6a4lHKEOWzi/jC+YB?=
 =?us-ascii?Q?3ME247L245EXTzHah3RthuQbLDuD/HgIssf9L2PJQuvgJhWKWDz0WV0lZxVo?=
 =?us-ascii?Q?6bQnTCx83MnVaaejXxOSuV4hHMN83C1igUdx1ES5xEQ4b0YomAZeZX0H2pgB?=
 =?us-ascii?Q?ZyrF8/45ouKhlkwfM6DvWH1vdy9taxWyFCfQwlMg/ArhXYXWD8C3DVy0z9uM?=
 =?us-ascii?Q?Em3Erat8UusD88DeX3EuzYVm0YtJFR4qT+nt/TXuQ3jeBuBvwgawvwEaRe6T?=
 =?us-ascii?Q?qw9yI+QCQZzojvkmQ2RrlExbzEmvC1ZGwwUV9d6jYQ/vizYMWdESeSU0rDu4?=
 =?us-ascii?Q?0XMuyKsh4FaeTFzN6YiHgU/bQGmvBr975YMwXVWMdaJjj1aRJ6jNDMbgscB0?=
 =?us-ascii?Q?GI7x3ZNzKfPbqMB2VO9zt9B4X5Xzo+L3YZammDsnP5EO0EYlJuGUALZT0RR/?=
 =?us-ascii?Q?k2kFzR+LFDAw1Gz1Wt5GcrgDqC6ptPUZlisIGpriv3GVv0uhEkehTmohS4Z8?=
 =?us-ascii?Q?hDTNN8E59Y/6DkvshfeTF14wLCWgTEBmsb9y0VVNVIfcsySgyAfVXqHMfOlM?=
 =?us-ascii?Q?+pHFRkDHcjq6BrOyJZfIGtBpUuSqNUIdbE5F3XLGPAmw7hIwR+OzOsR9jn4s?=
 =?us-ascii?Q?ksuZ+76B6thNZ2kx6UaGbrKCkI7iHww=3D?=
X-Exchange-RoutingPolicyChecked:
	FKglcXvP2J2rV96HndwhBFY+tc98xDmQVIygQE3TdbexoVNxPN2I8DIAOiGRfohmw5dkUkD+1AgM9msxv6oYf6mg/21wrtMG5dktM0fDZoqO0DzyvDm8XheAoEcBETqMwlwahzViajJCWh48UrgScm1VwUfbWzG04+f2cqbesw03HbYPXyNuL4HdL7VbSktH6CTtnWDpu79dxmHGHpEP5oyaqIFOHAehLxewSUj/xtw2MpOSG6ZQGZwq75xPEwUVo0P8ArfnN7RHGTJJAiUHuTHBLaP45TfXUb1a2KRr171qIn6Z+W+EDk4COcvmv8Pu3jZ6HEGvX36jcSHQDfefZA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vgNnyUTdKd2AbF2FpfPJv3uGHx/4Q7SNa0tDdt1gaA8VUxlJy01IflLfvivT+D0E2lFkMYHmP4jHZPVlbZahiO/nStRAV5MK42hdxInv7oXMu3oXLCBh4KCXTLMhdHK6esFvSTVth5j3bObXBSIu8M9kp6tlV7BVn5N0sefZwKUcV6LeEQCphezSGfClyv2/eXOoV+AJgQQG+NvBIvE0RBiTahQQ8puhn6jnvvaunAxGCzH/n+dh/LZ7RsPTzqxee1e0Rt5LzTOzMqUN9wSn4rgXxwEaEbeDnOKCWPG1qTsDQsYQ8mWcQ6vbJOh6O0RUKAix9E8JLVdYtcQ77+TAiIXeZwiDU6AQqpCASKnZUNq8QfOL9Mklu2C7lfFKFUP1v87k1CQZwNDTA5L8E42SnTZf8wl7gI4dSl84YXuRCgu4bj3tzT0MAShp92oWaFC4Mu2hmydZox2D4hKFybyP/Bm4+Zt9YsUnRO864hsrf9on87GmkY/yRNtfvcP2VHS+YpA5HdKE/fvRKDaTZa6FTcrcORgBxsnwjxngRllOBNtwiHeutAbZLFjbqgv4NeRYajuUUBkTHRBRYNjw2VJFmqRZwxbXKtqvwtShdF4X3dU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5478d75-e83f-4c30-82c4-08de82fc8996
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 01:37:08.6054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 48X4OzezVV07DDdQ+YuRTgHfWZLKLs0I0AUReUrW1uMIriljViCuUnVKED+9OxuCF/t8nqkJSsynjBW/hJM6de9YhoqOkp64wgi0CFmQCjw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7372
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_01,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603160010
X-Authority-Analysis: v=2.4 cv=ftrRpV4f c=1 sm=1 tr=0 ts=69b75ec8 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=o5oIOnhZENCTenyL_yNV:22 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=JfrnYn6hAAAA:8
 a=vggBfdFIAAAA:8 a=yPCof4ZbAAAA:8 a=9GcLsRiznYava-zPbe0A:9
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-GUID: h2--x2KvI2GQIMuyZT0BPkJn4XEYLxYu
X-Proofpoint-ORIG-GUID: h2--x2KvI2GQIMuyZT0BPkJn4XEYLxYu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDAxMSBTYWx0ZWRfX7xE5rBdPBtb3
 lWnA3LqacLWLa6C/L6zAljQoiRYXSs1VnNRTJBFUSIGmfsmgn1Udetk6SPto6Su5SiC2w+3Xfxx
 csZV53zTqxRjwkcaqNirTfh5C5a9PBmuJ4LzKsoGsgtTE0zoTKSma9clTiPV0y8Bwp65Za1HG6+
 3wTxGDREUVavsMyyptMyOoIIwKk/is/F5l0i6YYe7e01zgJLUNXy68T09KouTtAUaVwrS1mJp/X
 Bx0aCtwEZ6Tnz/ayr9GBGb6i0b18YLc76M8WfQmPn2Dl7A/KJoiE+ppIK26oHQlvE2va5rjhxTP
 TQ2SrKpfPFfVDZn3kX+RvrRFU3P/Tm/BTLTy+eT2WBg++GzUsbHidBCF5fc7oLbV7Q7mp/TVT5i
 +/CEPlGdgjDTDHeqcqZwO3ICiZMawwzvvbAVMaiuYSHIaY9E94BwvhknEFcIg8ii3kELHpjOdBB
 YY+E6yVmMQyKnwDJYDg==

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
index 8e6b85c3ed99..998270df6133 100644
--- a/include/asm-generic/barrier.h
+++ b/include/asm-generic/barrier.h
@@ -337,6 +337,32 @@ do {									\
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

