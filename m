Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7F141836E;
	Fri, 16 Oct 2026 07:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792134591; cv=fail; b=bIg+B+htZ8464kSX60oLu52WEg3pkKiFCYTflnETw4V/MDTqkrGNEFaWsSvuiTwcUzAfXQ8we+boYENRNl9PTlP+53Jm5+anxBooIPsaV3+HJ3E/BkmWj0DwlHnkhggf/GQnBcITKbsTf0XjPc794wMg8YwxH2X7XUA3IunnSkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792134591; c=relaxed/simple;
	bh=vRUb/5YwnunJPyTSe624UbwauHMqU5fgvd5cJafQdcs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Peb6Nash0UBWad6DLdvK+EZI6o3mB+R8iVZj2gpOhCz7mRn96bt7x0qx5jZBhxX/SQdJNu9N9HZsXwjTepkWG+gx3RHRG59Hh+oVEr5rRgY1TmPhrxtN6cAeBmz1Y2kZrdR/V4CDE23jFPl2aVX8IpBzhofy/dIjdgS/WpaihGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=S6TCk/Di; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MTk4ncQY; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="S6TCk/Di";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MTk4ncQY"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69FN6tX0052586;
	Fri, 16 Oct 2026 07:09:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=B90kc30GqnOmU62keXJFn3O2j9wg07VXDZENGKIEStU=; b=
	S6TCk/DiyMV4gZkFjSGyKGjrb4Rf3ENn9ItEHr5s3mfIXSjs4XQU348RVa/yWkFq
	+wsKCNGEKY+pJPAji1OLwaqe6SqYowKk/DhWW19vKTnWEF5SFIhRcg1NkBfhH2MT
	iS4lzJ3FfA9NzBtitVuXN8q9f8IcsfbyMbTn+1xdCiHrwOzUCQmYGP+3ag+zlQTm
	t42WNqDo8RC5+VAKkqvB1dkG6kQ4hDLyaSh9E2nD8LH842/IceBweILw3mo5zHuw
	SPRazasEqLJYZu0ls/qUSqqthU0ch/a05XxwcV6cUlH9uXu/exCKU68L9u3pUgHJ
	SD0G91P6P/De9mmPwisWoQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4h7df81eku-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Oct 2026 07:09:11 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 69G76B9Q027808;
	Fri, 16 Oct 2026 07:09:11 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013067.outbound.protection.outlook.com [40.107.201.67])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4h7btd3mam-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 16 Oct 2026 07:09:10 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ea071NRcLogpyKOUXZOgENuG8AK0xkCFu6HpzNJpo0iJY9N8bAcKx5XnOdrzJqgMOpeQXvrWryR6mFsXBjKgCM8fXtTADFpokakvl59S/aT1x2w2DFdvLFmHm83MZM0usM2xVuaDzKUaCawCT/HBti8MXLO67Ab5bMbwTaoqNGbB2IRtVvvDoZ7UuPOFYeifBP0we69ksiMGddmvHih+FHLLwhHt/A34oWfeZPS9moKdzb9ZLZQndJnFsyAkiVx5oEdwHvBdYnMPfbgx1FIoDuMvgqAxCryaCrk4JPMEu5WYmuDCqdg7HtVJbWV+9p9mVJlqJKjEbxwAlxk98m7Y4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B90kc30GqnOmU62keXJFn3O2j9wg07VXDZENGKIEStU=;
 b=q2wSImolljI+JzukhQOlRDt0S3F5YLhOcJhy4+QVSZyF/6xtjB5GRt7qeUnFkGVJ9KixbmaxDktd4Qt6bkYZMXaAI94J1Dql08h0J940ixp+MnuTiCb5pcq53uLLjv8LyJdetrE607UHVnIKMvwY/rLfwtTylPgE5Dqhbzh/ArPiDkAlYvrgOp40c4iZfPKYmnpQn1Lo5Yep7TMdK9SMNpKihDv5P27yzHfNgfmShHmQjVk/4iJgD23TjxWiO5Xj3AR+NXCNVz6jnnQ7v1W9wP7y/mdcOrylSQaumBa9oyv8tbmrubY+PV6m3S5jrL9+ipga6u6pOvCaaRmEcWWS8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B90kc30GqnOmU62keXJFn3O2j9wg07VXDZENGKIEStU=;
 b=MTk4ncQYdN3BAYDCs5LqbdITkIRD/18h/byhlffD3IJxyyDV6vsu1mF0nv2ODFl71m/RetZab2mcBPM/lDGdv7AUqAK9taHuIrF045LsXeUXjjgC8iXFdaBI3KRU/70/Sw7m52blrcDPmTng4fDU6lycuKa0L5vESU3mqTf0VO4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by MW5PR10MB5668.namprd10.prod.outlook.com (2603:10b6:303:1a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.7; Fri, 16 Oct
 2026 07:09:06 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%5]) with mapi id 15.21.0546.010; Fri, 16 Oct 2026
 07:09:06 +0000
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
Subject: [PATCH v16 06/16] asm-generic: barrier: Add smp_cond_load_acquire_timeout()
Date: Fri, 16 Oct 2026 00:08:27 -0700
Message-Id: <20261016070837.440748-7-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20261016070837.440748-1-ankur.a.arora@oracle.com>
References: <20261016070837.440748-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0126.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d5::14) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|MW5PR10MB5668:EE_
X-MS-Office365-Filtering-Correlation-Id: 8516e8cc-e721-478b-2825-08df2b545df7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|7416014|56012099006|5023799004|261009223027099003|261009221227099003|22082099003|10067099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	Qac7+bDITad0vHKkwrcrsS1cEqOkKiedeaJLTZliPzg07Jhbh3Kuh4KNK6UPSdGFQWRSAEGMjK2A6g2wO/7Xs9/EQ6m4Wq3Yr728KWpKyIevFHawXtskgsI7qfZoVzLTea69Z1qvOqe1OMKIqYjB16upuorNImMlQOCrnTkcAjzRco1J2yaZE5HmN0b5yMxN1ti5u2epql8/U2qugiMEf/wt+zDfJOYP2mvzCeqkEyxJPWRGlS7yasONgHa/bZP8AO7qwYItGXs3VMMXKdssUIX1YEr0shVY5PDLl3ZHlv0u6LFsvh9JfPmsCW4nNjuO4JSktCvzHbaIhBxAHZ8ab1ThKsRsdLCGk/l2hipFhGevYLxjmxicQLs98Bo3Y259B+0T9n4epK7hLu4raYeF/m28w2iEibntgSlIbJIol0t4XbfMxxnnGgz3cJOavT+NNRelUOivJ1LvKnl9YNN5+OYn7QZU5YyOeazCvAZj9sSlRO+KJk+urAzXVU26LeNoD8nrDIiiOaBXy1Y0PO5kCaoKiHDAPS72Y1Z0HOC6YP+BJDwchzibjndoDzYuZ+pyQTg8uRL1/umtPGJO+XKNR9Alt5wtQQ/9Eus5BOudQfliEkr0dmeT6ERhfZjNPKWm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(56012099006)(5023799004)(261009223027099003)(261009221227099003)(22082099003)(10067099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Qg9ox5OpYMDmSalWNmO4b+DEFqpEPh23tGP85wVgjN99LUbAw2qsh3/tYj9+?=
 =?us-ascii?Q?Q4/zZxP3qn54BXTrJHF7SIAC+F+WTEgIWMLbxK9pe7FOaciqqJt+VgQdNEuk?=
 =?us-ascii?Q?iNTlJtz0mvbKRBJHPNX325xy7nZnTCLK2Qj45Nic7Ql4LTgd+4Lmwzd13+lO?=
 =?us-ascii?Q?knkZi4iaZtCBPGH1GMafnowl3xXwqurjSJ4wJ5M4PU51KoiElJ3iOyR1g8eB?=
 =?us-ascii?Q?MJaAW+hNqHE9Y3k6DMXAJDS3IJhEp8MLIpkxFQiabJoMNzW6HKx8CSmYydt+?=
 =?us-ascii?Q?elvPLo6LFeZLxof1pteHZqIKNUToClCY+USTkdpzod93y5UWxwsUPfolNaed?=
 =?us-ascii?Q?fkgrG3A/AJd5+bTRLty6O8dnEhnLeYKcfPKPQGfKaHLaJ0MfcwDDdu2vvRxg?=
 =?us-ascii?Q?cVSqXPHiquJj+3bupvP7mjUKbd0FqPiEMt9PouL7a3IBNxicH/wGvSRUqE1a?=
 =?us-ascii?Q?2t+OdGTn5aX1cP+9LZVjZInwQhyzj+3WoGlNRoMpb95gs8BFF+17pSMZcVEb?=
 =?us-ascii?Q?x6Mn6B61OaXa2J/oa/+VIsRxHVCG0moOEov6T48eAbIfnw0pK+VKQTYzm0aq?=
 =?us-ascii?Q?M/m9ytlk8rIL5slVQtGD5VIKPQRtwo2Rl/WIk0wtorWHxuyA5J+B8RiyEH5o?=
 =?us-ascii?Q?rRhu+1xNh9IprHe6fK3vQWZ98oGgTwNFQEGmHDUWYFo3MtdyEhcY70L98awE?=
 =?us-ascii?Q?/771KmlGCbOLGxKTgAZe83v8s0/kLG1gqD5mzXhReiy2ATcn2rF0VRxvLyR/?=
 =?us-ascii?Q?eYkrWptgrp6lqFAvQ4Mym355l6jmbxRzqbMi1KpjxNUD1EktnPfJa5kDlP1U?=
 =?us-ascii?Q?0LxTYyILBEd0F1n3PuqKs9irxyqmXd5Xbwboiok2l+e050GhyWufKZQ9UPp+?=
 =?us-ascii?Q?bCKzwKqrCn6MrdChzNsIu2QaNceuEiYqqWjKMWC0DzqtyyqzU4QKsbFbewmR?=
 =?us-ascii?Q?0CfEymJutXLTwP20rVjUbHb9qb17FYOfTOk0UHQ0BFiUhQpMQ0zItzYXOzvH?=
 =?us-ascii?Q?WxngUUBMH07SSq+2INyQ8cI4Jmwb9UHiJKNEhpU/LQVyufwy0feDx+GaS4ls?=
 =?us-ascii?Q?KdR+2+oRDUYA8BLJMNRGvrOGpRteuVyJmJ1OjQ+EcRR98fKKuJUtKNiL/0RB?=
 =?us-ascii?Q?NlOX9ps4tgyMOlJ5JzhB5oDMOUVAsZiFi8R3/OxGj3b0JSJai9ZlC06z4kOQ?=
 =?us-ascii?Q?/AZEEF4qGPoqwUKrfHPGFsC4wMQZMM67uxaKtJV+VXHkYUlrlVNWmnree+0T?=
 =?us-ascii?Q?abh3YAfYjdzibGPrW9bUEFz4A+t/A7U+4pl1/qy3oTQwITzruM9gFMdvjlcg?=
 =?us-ascii?Q?EbY4Cu2uEbOSZn+X11zsIeb/Sm7o4sQKgu9GGS+cFYhyiy7ow9O60frp4iJ3?=
 =?us-ascii?Q?DexYXtrpPRpc4HQJSin8IsHKT4Ki/YV67n3w9jIm1UhEQX/fIzRK6j+g/Equ?=
 =?us-ascii?Q?9tuI8zsu+gGuFUB/7/xh2cwZBcxdnoKoMGy2UU2SGm0REGznBm0S1dkPocY7?=
 =?us-ascii?Q?J4Q60u4YVBfWSBP3zXTlhJ1TTWuvjdWSUxc3SBuziDmqgf3CrQPtwYDV+0t8?=
 =?us-ascii?Q?soHrqkB4AE2CBmVJh8gvz1TIEKDpqq/QyBjnE1U424XUJUXUKpRP+mWafAAn?=
 =?us-ascii?Q?IKA6z+x8o934mSpSbEraITZ+LjzaosmFrtaNB7+DJE0hnTw4/Z/KKWXlVVhs?=
 =?us-ascii?Q?Xy0FYHQfPXcEYih/W0dbYSJeotWe7t5/ECOZ7PDhxNU1fOdUvcXKC0EW0xOI?=
 =?us-ascii?Q?KPXTkcvu8OYeLrUlB3MZ66q8XKSbgWY=3D?=
X-Exchange-RoutingPolicyChecked:
	lcy6Twe3j6YYipE880vFItGBc8n4/e0lloFXulInQt9WRpm/GBWV8G/TEVbXK+EiG54gomzs7GWtEhzDP4eS10180C3Phdm6Vbt2Tqcxi5BdOdHR49wXMWZn1RkT/RnIF0qmEQdSReSCTvtU+QnYcElW0lga4+fZp4Vvqttu4OfF4wLPmSVgMVkXU9cXwKFMrZNGeab7hfBS59iO5a97xGteeM+k5n2I0YK8zo2IM6o8tC9tpbxt94MNvMSBH3KV8WXqERtgamWkkeFVy3AzF6k3QVnsCM+obVIiWe5T0bR/rMXifNI/uYyBsev1+lGusxoru4M83xuveuTu+3u2/w==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	y7CFKpFFZc5y2tSJstQiadHyPVoqhhaOe9vXluY8B7sBaYRPxZ4v+HqtjchHhOD7ToXdRepYkiKjgu+l8FJIfoAc/EuXvLsyx2I/8jyT3UZ0KKxq595Awqxw4cdeJC7d4TtcvVVRcppka4jz3GSRhfwqLvd0yvZs6QZtTnIikjhQ8j+cc7Rwm3ymQBlZOidjfOa/jXbi865EKTbeoghMjWokSnP4M5o3QWv1xPBwjpym0pFDbhnD9DYyKdQ2XvJIq0bv07O7u5TVFfBhYOYKAq0nNm+ufBw9dxQIv3/MFguOVQNXg78YmCktBU6ByTlsx1mPf5X40M94CNwSyst3bWmfezwr5UUnX6BQHERQPf090rFaXY8qDloBf6hS/S4wFUuTLUdEsCW0TTvsW8L3UGMSIG24JZyXX71C9HCkMna7/lA6ZTOaVz8+E5SLxNM/E6K8cb5q/n4Lfnp0Ylo7aIfzEmjCNuYojM166TTzzFomeJ8GqZsM+GqdqoW20LPJgCJ61LSQB6skWVL2MNuzgDQodRiHGVr9lwpxt2yUeYR5hlB9XZH8n+OaGqvHzRFSe0sNMUncNvwFwUWL7yGk4/KmYVraC2d5XvG5EY9EO54=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8516e8cc-e721-478b-2825-08df2b545df7
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 07:09:06.5218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZcrCd3Yj5uhh2WgdM+Eb9EmZLNAtA3GlXFnXPJA4dMHKFlQyP4Ft4F7XnGChXyIY4X2hbFgVnougYTgILPCzMI2Iw+fQ7qBpQGXiVJsXjXk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5668
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 phishscore=0 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2610020000 definitions=main-2610160028
X-Authority-Analysis: v=2.4 cv=N+a8hG9B c=1 sm=1 tr=0 ts=6ad1cd97 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=pGLkceISAAAA:8
 a=7CQSdrXTAAAA:8 a=JfrnYn6hAAAA:8 a=vggBfdFIAAAA:8 a=5BZhMJ7wGK5rjWweno0A:9
 a=WmVTiCyuxqgg3mnwYu6p:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDAyOCBTYWx0ZWRfX3F4wDxKnIntj
 +Ca2ov/Uyu5/siRT4vJmU77uDVIKvaPphd3BLKAnGHYfukiqxHDlobf1qek01vKt1wTo8w65R52
 9220tHj83swXYvo4qmYltjLsulhoLdhe7ZsKdfD3X4OtVy2ZE4qatZasqHhzimuVU+reXs9XEVT
 wuRff3GDJ0CtW9Tpe8wYU9MfIi12GQvqmTp1agPWiU3MemJNcpbCeDK4Zy0h8LCEZkSeVCkVB7n
 JL3pk/HnX0hyGiDaHNlJIYIKOLj8r0Q3C7bNHRGGwiK5AATTuBPkFxNymwkc86MXT1JbCi9U6KO
 0KnL5Oq5fNFbGIEoWncw85OQ3zcvGjGKngrNzdyjwbCL8cHId6MBh+Ul4RrddwGkuPB3sp3HMM6
 k9UQz4JHHO+2Xzu3v0nprctR6n0GStP75cbFlbkwyoJbwgILjsvMiMd9Ri0p4rnzn0IZCX5BiAA
 YsAegffE+cih+jqevIQ==
X-Proofpoint-ORIG-GUID: Q3dukkSC-Gx4U7FHVfGGjzef1wflLR5Z
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDAyOCBTYWx0ZWRfXxSDf81x86pCN
 2C9GcqK7zTbC8HOUMxMosnNGQKbxRiruLN56eI+s8c2xIGdiaXevILmx8UF+5gcAf8fxb//Kchu
 1QTGLt86pDiOb2eTTIP5u+O8N9DAHoC3krs6ljnNIuLHw373GV79
X-Proofpoint-GUID: Q3dukkSC-Gx4U7FHVfGGjzef1wflLR5Z

Add the acquire variant of smp_cond_load_relaxed_timeout().

smp_cond_load_acquire_timeout() does its own error checking but
reuses the relaxed logic in __smp_cond_load_relaxed_timeout() for
the actual wait.

Since __smp_cond_load_relaxed_timeout() already provides LOAD->STORE
ordering, we only provide the additional LOAD->LOAD ordering in
the common case.

And providing full ACQUIRE in the error case.

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
Notes:
    With a small change in __smp_cond_load_relaxed_timeout(), it
    now provides LOAD->STORE ordering. (Earlier versions provided
    that only for the non-timeout path.)

    This simplifies providing the ACQUIRE ordering because now we
    don't need special handling for the timeout path.

    For the error path (__scl_timeout_ns < 0) where we just use
    smp_load_acquire().

    In the non-error path we use the control dependency to provide the
    LOAD->STORE ordering with smp_acquire__after_ctrl_dep() providing
    the remaining LOAD->LOAD.

    Unfortunately I couldn't see a way of avoiding the goto label 
    because in this more natural variant the control dependency
    on line 6:

  1	if (unlikely(__scl_timeout_ns < 0)) {
  2		VAL = smp_load_acquire(ptr);
  3	} else {
  4		for (;;) {
  5		   VAL = READ_ONCE(*ptr);
  6		   if (cond_expr || __scl_timed_out)
  7 			break;
  8		   ...
  9		}
 10		smp_acquire__after_ctrl_dep();
 11	}
 12    ...
 

    likely runs afoul of this bit in memory-barriers.txt:
     "control dependencies apply only to the stores in the
      then-clause and else-clause of the if-statement in question
      (including functions invoked by those two clauses), not to
      code following that if-statement."

    IIUC if there was a store on line 12, that would not be ordered
    wrt the control dependency on line 6 and a weakly ordered CPU could
    speculatively execute that earlier especially if the timeout was
    extremely short.
    (An earlier version [1] had a similar problem.)

    So this change disentangles the conditional on line 1 executing
    the if and then clauses sequentially.

[1] https://lore.kernel.org/lkml/20260831202251.305046-7-ankur.a.arora@oracle.com/

 include/asm-generic/barrier.h | 47 +++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
index a03e3b26384a..7a59bee1e693 100644
--- a/include/asm-generic/barrier.h
+++ b/include/asm-generic/barrier.h
@@ -383,6 +383,53 @@ do {									\
 })
 #endif
 
+/**
+ * smp_cond_load_acquire_timeout() - (Spin) wait for cond with ACQUIRE ordering
+ * until a timeout expires.
+ * @ptr: pointer to the variable to wait on.
+ * @cond_expr: boolean expression to wait for.
+ * @time_expr_ns: monotonic expression that evaluates to time in ns or,
+ *  on failure, returns a negative value.
+ * @timeout_ns: timeout value in ns. A timeout value of zero is treated
+ *  as the minimum wait so we evaluate cond_expr at least once.
+ * (Both of the above are assumed to be compatible with s64.)
+ *
+ * Equivalent to using smp_cond_load_acquire() on the condition variable with
+ * a timeout.
+ */
+#ifndef smp_cond_load_acquire_timeout
+#define smp_cond_load_acquire_timeout(ptr, cond_expr,			\
+				      time_expr_ns, timeout_ns)		\
+({									\
+	__label__ __scl_out;						\
+	s64 __scl_timeout_ns = (s64)(timeout_ns);			\
+	__unqual_scalar_typeof(*(ptr)) VAL;				\
+									\
+	if (unlikely(__scl_timeout_ns < 0)) {				\
+		VAL = smp_load_acquire(ptr);				\
+		goto __scl_out;						\
+	}								\
+									\
+	VAL = __smp_cond_load_relaxed_timeout(ptr,			\
+					      cond_expr,		\
+					      time_expr_ns,		\
+					      __scl_timeout_ns);	\
+	/*								\
+	 * We return having waited on the control dependency,		\
+	 * (cond_expr || __scl_timed_out). Since we break out only	\
+	 * after either of these conditions are true, the conditional	\
+	 * separates the execution stream into two happened-before	\
+	 * and happened-after sequences. And since STOREs are not	\
+	 * speculated, this takes cares of the LOAD->STORE ordering.	\
+	 *								\
+	 * Provide the remaining LOAD->LOAD ordering.			\
+	 */								\
+	smp_acquire__after_ctrl_dep();					\
+__scl_out:								\
+	(typeof(*(ptr)))VAL;						\
+})
+#endif
+
 /*
  * pmem_wmb() ensures that all stores for which the modification
  * are written to persistent storage by preceding instructions have
-- 
2.43.7

