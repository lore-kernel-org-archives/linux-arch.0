Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CF32264D3;
	Thu, 23 Apr 2026 19:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776972635; cv=fail; b=JcIPImE0JlQDSpTf1VK6+tpcnYubDZLPjndjA8ij30HqeV9vVj77qFH6v4pwbDbNokUnOU/MeBhBHahVz7m/2E8Pi1IDtGYCwv/mToDO+B/i7geyTjqsfzzQCY/TYk7/j2ZX/UULoajSIvg0d9j0WkwCOHvUns2JhNKD9NN0xEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776972635; c=relaxed/simple;
	bh=TJK631Sp2Gcd+lKbz72jsGsg+nSylE/lR+OhuqktrYs=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=eLRiprKVvoxfn353UHxikM69qeVdbC6KTiRVHYoW9+LwyvRYVdx3eHJCl6SnbwrONr4+CLVVJZnUlbgl3XCcyXibfbP901th2ZWCYD2p1YBS3VUw5YtZIjzDMOrxSgSjx/utT0az082Zr+ZVnH3uCFV3Y9F3aWKGKyR2ab5zGTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=c9e+Y9w0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ou3O1tow; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="c9e+Y9w0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ou3O1tow"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63NItn0v766302;
	Thu, 23 Apr 2026 19:29:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=eu0ncl3WQ/rMs373lT
	Q45QFDl0xbVJg+2WZKKi9/tZM=; b=c9e+Y9w0SbjeTsBRulSmqU9tzu0MMzyQvI
	qSIzqzt99IgXqac9fBocLnUuZdU37ZqqpA2oPoxe4wzVBRLL72ecqWL6xNCNUH0m
	dM2SlaCkhJWhFg5+AsmXcjUcnQ/Fol4MZFIt9usPvNtWG9G7fb/H8852QqzchmHi
	omTYH8wG58jRygNjEIN6xJUBYYWw/TIvQbxnY6Yt2Md51tqDn3gQFRcNHhVWRMjy
	v+q9RvO8IG/gwVpp3LbmPIOw84YEXF38/8VNULI1YZbwauRouNiRpsedGiWXYgCZ
	aEhlvRj06Wqh1oeZCRZ7gAc2y8c/gegzSQWWCtgIA6vORw7I8zVA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dpenm44ph-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Apr 2026 19:29:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 63NJQPDE027802;
	Thu, 23 Apr 2026 19:29:47 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011065.outbound.protection.outlook.com [40.93.194.65])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4dpjjjb8je-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Apr 2026 19:29:47 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wEsvMGDGZI4JuBSE2no1nzmiuGkgQNQ9y4XNag7jOMkB6UGhVgATGQHc21SlU6ev4BUGkKOh6lOL+1SoBO9tmPDNptcq1ajMvDptGFcbpkrFkC2KeUMy7fWwSqaS4Asrcqn4QCZcOFJBlk3JmlwWbGbhQPLJfDkSroXgK0Xn12Zjxzd9fNeBHOt75TSWVTlFFEDAmu8OZbmv7e72fXLHNVzcFn48weIVfgDYQ0xAuoTWhXorxWJCcRos9UQEPXG0TTROCH/hGXae7HiG0qS/YfgOvnJkaw6Nu3YY4SCOpQ3boAxJlV4BTPoMJSS83diJ0m4fVWPw2ILwbN22Rfdp3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eu0ncl3WQ/rMs373lTQ45QFDl0xbVJg+2WZKKi9/tZM=;
 b=i7EsBI3SbtSumdlyvqO4V5ooAmtBXUpzsy9KQpKOh5gdBoOVCJhnOKwEk2dkR27ITuk0ulu+XVPsBkBYZOqHLEYtW7WRtJBeiJAB5kT3VvWISYw26byFMiVGamgOPoh2tVbQ3j7B5uO8dvVEVyhw71UyZhNzPHFhNFj7VuyJq+t3UC955RkoYwjmjhTgatWIUGSca+ZvsVluFDvPS1TtyYRjgB6dKsst74qeyT7bJ11RCJ8fVE4X8zTGtcYEihpL/prWT1o/HcVcegkt++GQHHpXvwGgnORYsObGBK0BvheH46M7xsa7HgnIOHjS+VbxFitQQmsbwc6p0ECBIvVY2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eu0ncl3WQ/rMs373lTQ45QFDl0xbVJg+2WZKKi9/tZM=;
 b=ou3O1towkQBcXpfStKrARyCiDJWnFzywsKU/8dZ3ZiwGHw+hfjFJoPRMrgy3a0ne62z8pH6na9COeRPOmFllKgs4n6mn0q0weQ98Wrdb45Bu64CrhR08HyvLnBFHw1bzhX/h03yh1bPMBECzj15Rhev5XD82/hYMcyAcRGBdPP8=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by BY5PR10MB4259.namprd10.prod.outlook.com (2603:10b6:a03:212::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Thu, 23 Apr
 2026 19:29:43 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.20.9846.021; Thu, 23 Apr 2026
 19:29:42 +0000
References: <20260408122538.3610871-1-ankur.a.arora@oracle.com>
 <20260423101631.84f26592d629eee46fbde6f8@linux-foundation.org>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, bpf@vger.kernel.org, arnd@arndb.de,
        catalin.marinas@arm.com, will@kernel.org, peterz@infradead.org,
        mark.rutland@arm.com, harisokn@amazon.com, cl@gentwo.org,
        ast@kernel.org, rafael@kernel.org, daniel.lezcano@linaro.org,
        memxor@gmail.com, zhenglifeng1@huawei.com, xueshuai@linux.alibaba.com,
        rdunlap@infradead.org, david.laight.linux@gmail.com,
        joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, ashok.bhat@arm.com
Subject: Re: [PATCH v11 00/14] barrier: Add
 smp_cond_load_{relaxed,acquire}_timeout()
In-reply-to: <20260423101631.84f26592d629eee46fbde6f8@linux-foundation.org>
Date: Thu, 23 Apr 2026 12:29:39 -0700
Message-ID: <87tst1fpb0.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0324.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10a::24) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|BY5PR10MB4259:EE_
X-MS-Office365-Filtering-Correlation-Id: 580208d4-05d4-4187-80e7-08dea16eaac1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	7umE7xmc0J1dCIrCSfXGQs8vrLhLmdG1+K4r97c0SThNa1jUxviJJGW334LCw22Ex+r6y0ssENlmWyf4df58OzemYTkub8Nunsi2WIic9pGp/PWWVb7LaYiZpZrN6uj41matuADSt2AA2EY5+9PXA6rG44IoNJyHxynq9GSLKJiv0NsVQTSBmZkGWEZc29m7nR61/6F4ALBJVFKT2CNv1U/B9Jhrh0Yhv+h6G+TBglegPJ+vBsQ4RNxsoLrX44mdPNKaL+tHuhlrycFjv5nvV0jgEP+Ob5O0/kAgYtHfMiIjcECfL7JoXQyVhOiLtoC08RyLgUw9Yl8M8vtaDqUtjQY5YJicyjHevAFkM0u24DXZL2y7ARXyUqNVvKQPwuLYWUTJpb4BsdMslk9hxo9gC9a7/KfMjdgowfEvmyLTX4OeJmsUjN1RGlF+Io2DAvJaOH0RnpmSaXO/9vCNqzUdlZBE0f82TNX5Z8E6EffpOZ8A0CNmoUmBR7glNdS18NeGqzlOBonh5p1EurtFGiTSXFvsqp4B6E7elMOniv7eh/dO1JB5HCksapiBfulR70uafuofFJLf0Q3yBE8vPYcVbnYVE1L+MQxXSu4yqY/ug2j2Ks250xQycXtfnN8UtYUt5wnilMPCzEeGlyEALldrNbNVQ08GUcCy+Q6Sq73Fi+XLikT8LZTaPrRLq6G5r6zaM59pJlcW7nGdQcdgauFI1ahfOpgCthV0dUmR+WScczA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0gYw+06KKG3ohWRlQla9NuVnk9VgElc82FEFAXnWoiQwBVQCBFZxeCujwXne?=
 =?us-ascii?Q?mBkEOo5BEUYwse1Cc+SflSdmY/tnT0ea2cySpWwIucYvYtpD2dDMCwqQ9ci7?=
 =?us-ascii?Q?tDmmFr0qEd2KSQnwR73ZdKR9t7XS4XHOVqfLWtLWWoycgWCUMyY1s+m5b92R?=
 =?us-ascii?Q?TDYSjBPJgtXLFbAF/2dulJMuaFNx9Fcdh2/T3UTAtprMKKst/6iU53TCTYBu?=
 =?us-ascii?Q?TE9N5a9o/RnmfdcXQSsZu/2HBFLv1yEP2Kw6/wO/duZaE9mf5UgWuM4CEwS1?=
 =?us-ascii?Q?7DjR2yWlza8kK+HW/aT3PWAQUqsONILsfExyaUaG4QWtN7CLyf6/nc4qCTSb?=
 =?us-ascii?Q?Z90x0nz13mwq4GgdyLFtxWWj+0dpuFAagoUEJ8/Z83vE092+BW8jdPp/5QkH?=
 =?us-ascii?Q?B5pQAIZHqNvA0N7kzbfY70qZ7z7gKQUtJbKgYOwqpnlRCBRgjgx42zbpfne0?=
 =?us-ascii?Q?boAw000gK0yAtBwjhn1kNKsHmPyzyTZnukc8QVawEZ7xywX9LhJME2KLDYLZ?=
 =?us-ascii?Q?X+8LQlP2sEnpFM6Uz4KhmsmYWnPMMb741IU//46umnMq9Lag6X6mzgioGDV1?=
 =?us-ascii?Q?F5qOk38SM7EvhWuXgbgoW4TqJ9a2MsjN+oLR3M+m+hldSSlfkRnByRzcii+W?=
 =?us-ascii?Q?zNl9nR+ubo0BhqN6fNVAMFIQVzkeZ5rpDd0+Y3K0MXsrafpfvo8RJmUowUb2?=
 =?us-ascii?Q?yNfpztxvGv+y5x9VS9taei0k/fMse3w3WWtCvwdVfDAfWYxZlePjMeTuq/1J?=
 =?us-ascii?Q?MnTUYB4n48yp0drhkjqaZoK7s0weAC3G1Vak8h6lRVgBZ0DPUpnbcqrLzdHk?=
 =?us-ascii?Q?/2lGwPdusyVBQd1wBjK52X6ZcHKKRuqQD3bKQtFBtFh+MegCglh6ZsA0bziE?=
 =?us-ascii?Q?ezRGC8pM5q1OGBlPE60f29yDYeIq5yWcbkAhNvJ1mkHa9hgZ312LUTlO7rKt?=
 =?us-ascii?Q?3/N2jerp7zZ8u3uCR0Pt0AaJka2iIGWwUEfKQX+ytuAOYBja3wgVnnThDvLL?=
 =?us-ascii?Q?vcM7FYvB7m1eiba9U8oGSa5t3ErH9+bG3q9wq1i0vowBSHnjCWPzUpJyk3ID?=
 =?us-ascii?Q?3mkctMQvHJUtWo1f4ZySvq+diXj/caCC7cVynzbilgiepnf1x1iTZ0RYIW3k?=
 =?us-ascii?Q?UJkHUY9lbvxIYmuHJXNbd8c5hnD2ZooTqb54ZtWmoJDYjzpMjSXl0v+/+b/t?=
 =?us-ascii?Q?BiODIl7BvpP56JDnAxF9aMyNt61wQE0BJatLvtw0mwBBkDNb03QVmzu/k/gw?=
 =?us-ascii?Q?COgMx1hOeYp7ZTxxBhNLoeBuCBJGll3fVxuv2etbvHPWnHvm/jQ9u4xKJS4d?=
 =?us-ascii?Q?c2RI/Pg7EgLyS5Yf8jUQi7Td2VLBcOevX7zcIL7A/YExuS2R8qq8jQxyHQ2P?=
 =?us-ascii?Q?GNrtWqprz0zXjIaH55zIBSnhmf7+/yRZl84S+0sy1KLvmIV+CMLPKWYY4GwQ?=
 =?us-ascii?Q?J/D225njCidwjTWhs82gipcLjPbTbxMmvIMSul2PpqOceudB78H9erv/fr/X?=
 =?us-ascii?Q?8QZ4sgvpS7dXZSUtsSMz/QT4L/p1CK6QR5hJ/VLtL75o2PWRNBa8rn/GHShM?=
 =?us-ascii?Q?TV6R4pO+c0ITugcwTXKbZYMmFwEYRxktZHF+P74UFY8EV0MjgnKaOM36qwJm?=
 =?us-ascii?Q?vthGsQnJKw5W6PCUfd2Ax0UxCTFFcGSIIcIurmPux6B1nmHW7TmWA80P7Gig?=
 =?us-ascii?Q?JSS4K3d3fiYjfVcATz5knrOGjntlig+psmFm/tBwOq+T44QX/5O6VSxBNJWD?=
 =?us-ascii?Q?h3aF+N85PCcXOEhGeLnszLAYYGgftMU=3D?=
X-Exchange-RoutingPolicyChecked:
	EAbLw2TX+aEeLUhE5X9rqbPa0UOW9cmMqLCjumBc3JiEGNXg5HeR0kkMalSsR1krAQgnyMjewv74NV9iUcrFmeWSpAlMNEOn+N7It0fQr2G9+M4b5NTLiwlAbfAf4TsIkhhTVirlA70sMUVROxkwSXJClehiprWvDP31ZCYYNBgspnAhiiZojyOkc/lNKpJjefLm8Z8W7N0WLDTREJ1+VK9iYo6EO1Gb4TlNztxTLB4Z0p1K0FoS4DhxuQAUyjNjWND5qc8mO8MGO5+Z+PE9EhZ8JN+OnegR4CF08bBDNBZU7TBPiywr1FP5jJo1CEnOCCC0adBL583r5FAFyl+XAw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CdH5z04XShMRDSc2LKUfMzvRTcjxVWo7TmGukjtEP6kU7+v35CSNLAZA/1lwjo0XeTcnnhywQWNc6LquzobAQ6RV0WGMenWMPBfOrs7HmFF6bkf9aMLmUPAVzc61D2gCTKsC71znzpHBn9tWUKwZ7NKZoFsn0SLeqlL+gZaSN88Gx6FxZaE+y/CjmCMyJE64sXEiRErPQM4sM+GVr4Je86MSq2mmWcMz0/YmaFVBORdGZfCFGWWHUouD7jZsPsFULZQbFPBiH4V+inEILpqvkXS6vfm+HoDGRb24pS8CQIE5MExyACuiiOsiP3S06+G+WieQHbDkazonfOgGThjz6exTjnovK9RGgGj+PSHCpO3jSqfhJZq6yNAo4xghjgY3alsrI+VWb7sDaX/OeKp6JcYqwIB92ywfI7gPQbPYT/lnwDEz4X3lP+oecUuhbM0EvZtF3x4N7xSyX7OfbIKqJRnWQFY7E6Ai9igDHmpjj99ydgNOZnocbOpQHkpC1TZ4/gw4C2pp/8pL9tU0EOk/bY5ENALXDf+YwyfZSYxpEx8LSezv7dG4DhhmgjGN0kM9BNjXtIEmUXTcmY6ll4loSOSbI0GxXyL7abJKykVt4Cc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 580208d4-05d4-4187-80e7-08dea16eaac1
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 19:29:41.9696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eEIXsnaiSpv+h39ID0zLhYCBN55snTbNreL6JJAxQnZ/j/SW0j9UKagvEH807A2/IhrDtyMn8KvpETBPUWYx6BMkF2m/zgGMKXFf914ua0w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4259
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2604200000 definitions=main-2604230189
X-Authority-Analysis: v=2.4 cv=FNUrAeos c=1 sm=1 tr=0 ts=69ea732c b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=Z4Rwk6OoAAAA:8 a=yPCof4ZbAAAA:8
 a=cMS0faxKSLiuJPRkHcQA:9 a=HkZW87K1Qel5hWWM3VKY:22 cc=ntf awl=host:13825
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDE4OCBTYWx0ZWRfX5gJx+Gpa1Yg4
 3uGNRER4BkEMz7ZKzVzy/tmAv9SprOIvSMwDvwWT8+gujwf4vc1kEQiTrdrbR0IiEeznzxNvt6M
 4T72m7z6thf7Y1xmqvd1xjl3A2Cnz4PCuB8sfTKD9G9dsBCgztNPADSopuZ8z3YcztfMclM1boy
 t2yrC6f0NjjzciMAd897Acu3IIlMgWb2dWyBrL585+DdBaT7dL1kk9np+Kx/8LnnEa2rYd8PZRD
 WaP9k0M8XUl6ZhctxqsM7ifG4s1t8XE7XlY7oXjoWIFU6+ckYGL6yGU/Y+JtU9Bgd/uPAK4F+QR
 BLmyc6AVx1srUFBQ24c+efGGzN2khhdXYDyAT48S4M3DLr8WP3qq3iyzS4d6/NmpPArw90Tb5Ha
 d99DPLxthYK02VT4zoGiKng2Wc1cHI1hZgGuOpF+BAcWd8eiZVdZOZ7PqfP1W8mtNbQCEvwH4TB
 V3a9AhXvY0Lq9dpVAizXBKFILc2WIW6+WgzAY9Pg=
X-Proofpoint-GUID: M1ZU2qvD3NStKvcXRrJMm7CvChygp5i_
X-Proofpoint-ORIG-GUID: M1ZU2qvD3NStKvcXRrJMm7CvChygp5i_


Andrew Morton <akpm@linux-foundation.org> writes:

> On Wed,  8 Apr 2026 17:55:24 +0530 Ankur Arora <ankur.a.arora@oracle.com> wrote:
>
>> The core kernel often uses smp_cond_load_{relaxed,acquire}() to spin
>> on condition variables with architectural primitives used to avoid
>> hammering the relevant cachelines.
>>
>> ...
>>
>> Accordingly add two interfaces (with their generic and arm64 specific
>> implementations):
>>
>>    smp_cond_load_relaxed_timeout(ptr, cond_expr, time_expr, timeout)
>>    smp_cond_load_acquire_timeout(ptr, cond_expr, time_expr, timeout)
>>
>> Also add tif_need_resched_relaxed_wait() which wraps the polling
>> pattern and its scheduler specific details in poll_idle().
>> In addition add atomic_cond_read_*_timeout(),
>
> Thanks, I'll add this to mm.git's mm-new branch today.

Great. Thanks!

> This isn't am MM patchset, but mm-new isn't included in linux-next, and
> linux-next isn't presently open for 7.1 material.
>
> After -rc1 I'll move the series into mm.git's mm-nonmm-unstable branch,
> where it will get linux-next exposure.

Ack that.

> I see that further review/comment has been requested - hopefully this
> will happen over the next couple of months, but please do continue to
> chase this down if you feel the need.

Will do.

>> Haris Okanovic also saw improvement in real workloads due to the
>> cpuidle changes: "observed 4-6% improvements in memcahed, cassandra,
>> mysql, and postgresql under certain loads. Other applications likely
>> benefit too." [12]
>
> Those are significant improvements.   Three years :(

Part of the reason was that the barrier interface was part of a series
focused on virtualization via cpuidle-haltpoll. As that was reviewed,
the tale changed in the telling, and it made more sense to separate
the two.

Will send out the cpuidle changes for review which Haris is running
with.

--
ankur
