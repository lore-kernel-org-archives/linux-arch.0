Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10CA396D2C;
	Mon,  8 Jun 2026 08:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780905953; cv=fail; b=H54qTOIgp4b82iebl2nwYLwTgAfglnuoz3oR+b52sr+4yMSV89NYdxE9vYz0A8sOYxFgOGe9F1ZX2elVKuhpucfI9MvI6Soe2NlO/8r+1XHp3wNMi3q5xp1ppdx9CI2DyXx0syJKeGDjDFlQryfmwFu8MQHUqBn7n3sgLV+qi7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780905953; c=relaxed/simple;
	bh=PFT5rG5/F+SHTERKtv0STIs3QyoahP6Kvg5/BO7yjhw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kPSh2ce8tH9xfU+rOHZNr5OicceIa+TjRWxAb6K61pU+rk/pU7yjqa1wozlHsnG0XfnH1wZwlvBba9nDOe5vr1KJrmk+DTO0TgS5pGT8WvkHpoyVzGcYo5n5jtlw7Gj+davrZZgu2liUpqW9KDtMVFnxNURlwP3UhS2UywXA4Tk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aSJywQZQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XOh6b+rH; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aSJywQZQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XOh6b+rH"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 657NNmh22141400;
	Mon, 8 Jun 2026 08:05:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=4Lg9Ao/NY7+O+dHBfbLTCASHr6xXDLmXSvijPaYixZc=; b=
	aSJywQZQiQ12pnDebGfNk38eUBIZQ9ti3RdNztawf4WmrkLr8L2nNlvY3F+/s3Wn
	VcvDayst3L2Hh9gOv4AFIhgHxAKET5duw1oR3JUYeoT9jH4OVZrYmXynM/IuEggP
	irnyzRQCcZBkYAwvqTe0/tJQ86opRNKU4o7GT86BMg7CQSz4Tgkamyu71w9HhHTj
	NB1+xUORKq/MrkeX59EadQBYEZql3IXKff9bbDlfpDPvf4l8vR5u0Ne4U0SzHts1
	TL4R06bCfp8wrdyCRKDPWZmR7JcUGJ0bSmu4EYNmdeX2WvZZ0iAGsq7PkvGQddh+
	mPLufEokfjFqtxvfcKLhGA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4embkja0su-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jun 2026 08:05:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 6587wNn7026343;
	Mon, 8 Jun 2026 08:05:13 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011069.outbound.protection.outlook.com [40.93.194.69])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ema0d2dc4-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jun 2026 08:05:13 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MGsKWrLtM7xjleB5lMlgXtQ8rAL32Hsssz34IjJlRpSk/A5T35/nJFrZG1Gw8Y5jCFn9TPn/mqfnUHRU+bGGzq1QBEn4s7XpUp15xj+z3eOIEScxKEdOKN40uik78a2qKSdQ9Ez7pLug1KulcWehlqlLNgdpt4mkX3TEsY4yjHtJe1QmlVfBCS6Nw43Bs8YzqeCZUHKmdw+/bHfoDLTVvO6qmAOx/hes7bbHl19wWovxKtK5HhRwuTK60MaOlEcJYXlao66kIc4lDFcUvyiJAPIEbyw4l0S1ZHPc/H8C9lQhfUOFrA2Nz34V2QAmE80GAMg1s6JmiKBVq1FaEuY6AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Lg9Ao/NY7+O+dHBfbLTCASHr6xXDLmXSvijPaYixZc=;
 b=eM2ZOni9Z9xxptMY+/I2WlUkv9Fa3QBhUtaMSA4dVi8BzP8mFEVx31tvboAsiMUvR20gQCchLyceMsAPEXM2RTMiRoMEI8GOi5lGArE1VhPjFwj0bmAP6DRAFrwCSZNwxbHJoqNWVdEmROr2jFvT3tDRCUAe6iElI7de00Q0iUer6ZVhnFGTOaXIwwG0ql5QmGyT+cXbcecsqMMjx+C9eHg4l7bnKl4vlurYkalSje2OcefeyD8J7TXQVYYuje6WlDc2udWA5+qAkGOrk4uGFQnwSvAi2UwCNs10zz4H/xPGwz28SzT0+N7eAPEigTeXonNa1pB+w0f/qlewrjCu0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Lg9Ao/NY7+O+dHBfbLTCASHr6xXDLmXSvijPaYixZc=;
 b=XOh6b+rHmyD3s7cz6JaOpOk7c1u/mIPbYioWaWSv85X8r9OWGX1v31naWsUq5WlMPMCcI+SLT8zdc5qrp6idzpb9/NvPXnChI/zB6TswlRY+8sMQHCQsDV5DclaWL0UDXgz6XL3Vf1r6iyUl4NIv6S7LZ+wAwxRv7ToB0M8WXAE=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SA6PR10MB8133.namprd10.prod.outlook.com (2603:10b6:806:436::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Mon, 8 Jun 2026
 08:05:10 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 08:05:10 +0000
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
        Ankur Arora <ankur.a.arora@oracle.com>, Ingo Molnar <mingo@kernel.org>
Subject: [PATCH v12 11/15] sched: add need-resched timed wait interface
Date: Mon,  8 Jun 2026 01:04:36 -0700
Message-Id: <20260608080440.127491-12-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260608080440.127491-1-ankur.a.arora@oracle.com>
References: <20260608080440.127491-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0324.namprd03.prod.outlook.com
 (2603:10b6:303:dd::29) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SA6PR10MB8133:EE_
X-MS-Office365-Filtering-Correlation-Id: 30e842e2-7f40-4444-a32f-08dec534a946
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|22082099003|18002099003|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info:
	N+C3IwaJiY+C7MVvXET2us35Zu5xxRrmw8CCwmefpGP++nz6iEQTW9N/ERyVpPGcNWDEJ0J3VhezBsQGJqJd64ACQweBP7RIG2ZdqEvbjW3p35Z7KbxJgKA4B0Ibkkm/+YAXX5cja1kVWcuTrY/FeJVfJGr8uS+gGUanKWG4yQC/Q49CNue/jlUKg77QshD974fYmKO0ldE3A27Wc9MzQmNxUeYBXDPAGSW26wjJvnFSDICCGSeZJyhkPrCI/WZ9CpJLq64WMlPLKYfsOjYXpjlcTL7ooHB/i21tUZoHBM94ur8h5rtNOyswJIhnPo3ASxf6+HktQQLjRpZm97aCSHYuLJAD2nLIWs6ddVUECEP9cQ2HiCAxL4mhZqSTO9Yvz+xwCTnEsQ6RtfFMqxoS4GJlZl4joMSS+p+F5+xeNS/jOdVo4YSkdDdosgoph5bnZBKhr/qvesAj9KF26o/SB5FtpzGYxlw13Bz43gpGFeJmAE7oKoCv7Rz/qJa04bvibNCUraeIoTUqhUlzMjRKL6d/AP17GlWa4TZQGiCcL5czjpBLQ/tuH/FWwJsCI1Ium5ntnx+cMqM/WI7MtaMxlDfFKOIPs/Hv4ay+5mb5zU5aBMTGL/0cYMdQPQ0oKprzW1m+QGhug/FnEYGAHyX9KLLU0W+pgEDWPYQteEE3zwxXuPMStDBViyCTju6zQ5xE
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(22082099003)(18002099003)(3023799007)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EhTpAG28KBrSweF4/NnReSksK8jpQms+queBqWk1h0GhwXUuvLeDkrIdd/QF?=
 =?us-ascii?Q?YxZBRQA8/cSiI49KKBO02P7+LE4xtr+Ld64gdd7lXg+aLnOs7bqkLA/ovyvY?=
 =?us-ascii?Q?9vlAlhjCBSbNWzroXHCPb2CeVxz70u7ueghOfHytNfSFLIZkGzCtr+aI5PRd?=
 =?us-ascii?Q?CEPO7KzhaZE7qHomVoh6yy6+5n093vziyK47KXNXDlPaapnZXfL2Zi3KpfHm?=
 =?us-ascii?Q?jJl8w2qbsCjppVv8ieIkWwGYKc/e2BMIX5XDNDS3Xbo1+K6LvA9M0cIq/9HG?=
 =?us-ascii?Q?J0Vup6R/rHJM1gEua81yj+00uKXauyP2yW7HwKms7y9KFPryEjR1BN+KiQW1?=
 =?us-ascii?Q?pwmX3l7gaoHRRD7omhW1Bqqhx0+dwp72MMcLDhSW5+choxmqBU5Z3hqIy3af?=
 =?us-ascii?Q?i4xF+B/EopkzBGSNvcXzjW9bWV4aS0fLEwA0n4dROfLEgzd+/PLLrS+n9WpE?=
 =?us-ascii?Q?Lb+s8pdg3AWFLTVySj/Uzo42kH7hpquhRh9SECA88TLNxFWGPu2IL9FHWJbx?=
 =?us-ascii?Q?aQ5SaHx+ZCWRr+tNo49ghrqqmTz+rBBaqLhJEm17j8l3v7B5/n79FeKuN2hM?=
 =?us-ascii?Q?q+hbPtMe5SCeaDyat0F2FSm2B9EvjGlYJIlaVS7MAIITGqUYeLyzhTwe82P2?=
 =?us-ascii?Q?5MwYznazY1bdtHCqVvyYuXW+5Fsua/TF5DyUHvQWWQ7b9MMkdUKvJhyAjZsN?=
 =?us-ascii?Q?z82l552Vw8WsQOUPBNJEg9vFIvT7sozGkF5jqgz56OOnRSCxShkDRJ8HnmOW?=
 =?us-ascii?Q?++4tQgvCLkafoHyN9jneF5LZIB+p32eIbJJN7YRC8dqtKZigM2elj8zDqCPb?=
 =?us-ascii?Q?ndONsYa7TFbghBeB5pt1SLP31Sk80VkTckkZKyYrPJZImQ/GkteCDLc3/qsG?=
 =?us-ascii?Q?JeWkq6iqAz3RWZr2Rgn1OkSzoqaH7vh1HiXfrC7/lP9vVcthw+cOHJGUMkBX?=
 =?us-ascii?Q?3OSAhq6fTK8wcnn4Sz7xuaKYWYD9rSCWN6wdsrg4c7iA+4zmfeHOBNjQHDbl?=
 =?us-ascii?Q?T8kd63fAB+o37BJe08og6YCKa8BDbGQOk/aaYzsBNdNmRQlvftI8WqH/Ws60?=
 =?us-ascii?Q?uWzC0DT/buIJRH3TV6Ch3QLHZ/tnhWT/JVuvlAp+H6bEztXuZspN2gwHbNuB?=
 =?us-ascii?Q?50fy+WkQH9JqY2CjzKW0i6wSTmd7QnsJubZX34245Ptj4RrRBwYewc6rRX1a?=
 =?us-ascii?Q?aOu0Ah7cTBQA5Vwx/rWvMCyOsfdv10ZwXCIiM2LxzWp9Cb+WTeDj70fd/Isf?=
 =?us-ascii?Q?DUYpXGu3Jdk/UYn2LFIs+VnbqQoYPSRo1KhlT6+6lC2JS9a55lgJ8EuxvGSW?=
 =?us-ascii?Q?7Q0d10k51dW+CT3rckvAkrMzdc2BuikvKMC/VTxQpNsWKJ//i84HJ0igFoFu?=
 =?us-ascii?Q?9D6/qh5evYsTQgC21g6ocZdShs9IsbSkIYTr+OSpEaExcBfYVUgvB20FMSCH?=
 =?us-ascii?Q?dlYhrPNWel0Pi1EuVhfmvudlrQAik7rQM3YvGExr048CWWKAdBlJx8a/RAsu?=
 =?us-ascii?Q?obkzS5JLd81rvOA8XJbQ3whliZV8mwxdoQhxv5YoeRPKzuFK+T/afLrzKDkz?=
 =?us-ascii?Q?8AsvWg6f4aoMkNMgjkJ+oPw37pbvfZbl32fuzaImZ09Ga/vZgpAd9C68BZiu?=
 =?us-ascii?Q?avWs926/blyJbMSljsnAIISlV+w1a8Yvcy9TsiWwDMGiJ65JWCIiPi3MO8Js?=
 =?us-ascii?Q?DGKjQyOGihv6hz8Oj0rv8d8M7UMnkVWB+Ybn/Eqx2komcj7ItpJyt+mXGjt8?=
 =?us-ascii?Q?pOHBpb77Dl1ruMj9CNRonu5wsmZrhNo=3D?=
X-Exchange-RoutingPolicyChecked:
	RO1m8x9UyRQfpILeC9vzwhf79kD174PupoYSgjOkUCtJ+OYAdNqp4P14T32pLzFmwSQPQuIgHqbo2HRGqBNXLEFn94iejWRHT9G6VBZV5IlWixy0hhoIyIfBx1iqz2nJvhieDwpQvadSsPrkYcMH/AQ8MEDLgMiJenF9pwySQQDRLmJpmZJS33DBzO6O0uLKK/w0PQDlIekwmRFNopTFGSNcUT9K5FLtbz4r//pug2rDFn6PjtTnNevu7GskyPQXagT3l9Zi9W3oisbUuWCVL5n6bLeUjQeV9xjKUOaSe9c42aR3Z20baaz9Kp7hxOt6szc4Efh53TNqL5t4j4RBrw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	v8o7YMb7ylnuUlaR/YCpspEYCU3CHYwHhMRKVEpoNkRxsCFVV2xzzhNAN0hG86yNRNa9BI42bmnpg2FHekPYwK0iRoSJg7sAVODKn/jddH61jUc+4lp1go2CuPNTwVtoPdXq8z3xy26rY1H5i+/LB+7ziBSHRFknIXbh4qjCGCGJVO1Xx5NKQ2Hx2weNsWw2/NE4G6qrgdoth0u5CPHyxcG/87U8HdLc2Hu2OKJX1i4FXct9nhtRemu/Jzj5aq1KmvqN9/6pEwjiCYi9WuMRIatrRCu71wl8VDwpLCNNwCtohiNW5A9wZkT8xaLU8EYzMC+tSo4Tm1pmx0k6yhzbN74gkqT8WnslYPWCrE/BC6UnCv53psWKJTBGijMynq94M+yJo2Uv/ZSkkFkDic5DA6rTiTCJIl4zh2jTVfqucaBgsR0DP5sUYmyv8enPNCSGQFBH5RWHDueNn9TcjtBDpvIBitnhFIhe/Wmyp/vaL0VCfKJ//GC2KkvSXaTDbm7wdkkZa7XKr4HdUVzNpy3tMuNv8qTj28NWkvZckpl4vFMqG5Vd+GfrJzl24Jj74Qm8mgn6AlhIqbyaJLuVnTRhT2lOHOsdnRFOQ1PnUVSeg7k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30e842e2-7f40-4444-a32f-08dec534a946
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 08:05:10.3398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fX4NS6SlJd5NtdmGF1ZSmbukmvwpLs9MoEfyZxpJWvHOZQCMVCPvHsEhLd2f/SOVCIhMwfb30Jc/TKJB2Vt/9cOmDm4K3+Xlt7FsskRnvjs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8133
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 suspectscore=0 mlxscore=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2605130000 definitions=main-2606080073
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA3NCBTYWx0ZWRfX6bg9rPY5GQk5
 wmBb9jMZaofV2ImBPg8vVSOqG+L4YEhyWl/uQB0qmcogedgB95m2Pu9l7IDTww+U4GCoF8Ycf2J
 AOCZ3a02TI/16hVTkM325wEGhbEfPFnz45JEL4cCRf9v9jSRO6VRdyhqKcq8TbgacWWVu2374dC
 F1k2beEadNmLbxTBBAnRoxPg3hWc9Stg6XFCCAcmK1G4vjtIEOjm2L2DTH+D+Mx6csen+tmbT74
 vQzoL/3F39DB/U87cmSa2yyo3pK4fmh1NH6aD2f2z5wm0hZXZfmC5Qz129j8ntHq0g5tYL+ocAi
 r9IjKyXFIG8Ov0rnK6ZPGTDBXQebKCBpv+rNgQb5tn6NIlItygtoVYymoFYTNt4rK9TJwim8lr0
 h8+bGBbV0gt7RRznxKUWRhllyrWoTEKMHz2zjW8eHHPjQez33g+jeDaizUXJqgR159JewfWaemB
 Bwdb8ws6eZZrA3jcqHw==
X-Authority-Analysis: v=2.4 cv=ROSD2Yi+ c=1 sm=1 tr=0 ts=6a2677ba cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=FelO9ux0wxsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=KKAkSRfTAAAA:8
 a=yPCof4ZbAAAA:8 a=DC2jtUcBNbVnd9lHvZoA:9 a=1CNFftbPRP8L7MoqJWF3:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: -7TzJiW-1zjDDTAdkG-Cq6qV4IIA7gDc
X-Proofpoint-ORIG-GUID: -7TzJiW-1zjDDTAdkG-Cq6qV4IIA7gDc

Add tif_bitset_relaxed_wait() (and tif_need_resched_relaxed_wait()
which wraps it) which takes the thread_info bit and timeout duration
as parameters and waits until the bit is set or for the expiration
of the timeout.

The wait is implemented via smp_cond_load_relaxed_timeout().

smp_cond_load_relaxed_timeout() essentially provides the pattern used
in poll_idle() where we spin in a loop waiting for the flag to change
until a timeout occurs.

tif_need_resched_relaxed_wait() allows us to abstract out the internals
of waiting, scheduler specific details etc.

Placed in linux/sched/idle.h instead of linux/thread_info.h to work
around recursive include hell.

Cc: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 include/linux/sched/idle.h | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/include/linux/sched/idle.h b/include/linux/sched/idle.h
index 8465ff1f20d1..ddee9b019895 100644
--- a/include/linux/sched/idle.h
+++ b/include/linux/sched/idle.h
@@ -3,6 +3,7 @@
 #define _LINUX_SCHED_IDLE_H
 
 #include <linux/sched.h>
+#include <linux/sched/clock.h>
 
 enum cpu_idle_type {
 	__CPU_NOT_IDLE = 0,
@@ -113,4 +114,32 @@ static __always_inline void current_clr_polling(void)
 }
 #endif
 
+/*
+ * Caller needs to make sure that the thread context cannot be preempted
+ * or migrated, so current_thread_info() cannot change from under us.
+ *
+ * This also allows us to safely stay in the local_clock domain.
+ */
+static __always_inline bool tif_bitset_relaxed_wait(int tif, u64 timeout_ns)
+{
+	unsigned long flags;
+
+	flags = smp_cond_load_relaxed_timeout(&current_thread_info()->flags,
+					      (VAL & BIT(tif)),
+					      local_clock_noinstr(),
+					      timeout_ns);
+	return flags & BIT(tif);
+}
+
+/**
+ * tif_need_resched_relaxed_wait() - Wait for need-resched being set
+ * with no ordering guarantees until a timeout expires.
+ *
+ * @timeout_ns: timeout value.
+ */
+static __always_inline bool tif_need_resched_relaxed_wait(u64 timeout_ns)
+{
+	return tif_bitset_relaxed_wait(TIF_NEED_RESCHED, timeout_ns);
+}
+
 #endif /* _LINUX_SCHED_IDLE_H */
-- 
2.31.1

