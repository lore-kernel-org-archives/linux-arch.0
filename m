Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2131D2C17A3;
	Thu,  2 Jul 2026 01:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782956112; cv=fail; b=k4VSGssbvxrHUPu0q6WmasP34aaEj3Ut4djGRkl0YuO24zXXu3kEm/ROENSoywUnMWqAJjE5M1XRxrYpR/QmZH47pQ/lMzEacFGD+4S+RtyEabUSZnx0Nul33TP1/PbJgKNWK7U4EJnDGvLkP798K1TBbXG30G/vuQIIxY6auaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782956112; c=relaxed/simple;
	bh=bZKut+D6baTggQkQ5BccLLEj5wfmguY2HhufDGBcnrw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XjmknI1xcsKwjNPn714tvOX0d7f0Lx36bq9Z5qUnJ953N9DtMgjbwT0hyW1GW/+yj/2hK794NE5dpfxN/SPsqxDDLzz+6I/nY/rTLh+UtUy7an77TaICj/lqlLf0Iz+YEvsmXERjKHLFytz9xAPAqjgAzYDu1w/vKmO63YDDzVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bsA7ScQB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RO9zfElg; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bsA7ScQB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RO9zfElg"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661EHG202817599;
	Thu, 2 Jul 2026 01:34:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=gB/bbdqh/0Sfqj/AUZ1l/h5lMgMMBqCVKXeuXLr0klk=; b=
	bsA7ScQBa6z4yZPSEGeFbXnta0iUWE0/XAxCUJA7YtHLep4i7tzfjvIhkTj8Dh7k
	77kagxi7k5EEDmnjlWBXAgHMvuaKclJoAWCWBvk2Rl36KArbJGXwkPG/5d2tUVZd
	i6aR8k9flbCfo7T95tsUayvYVZhBA800kaKS74Y3tpleT7fYV8WrpQYGRXFRv+f8
	Wj+b9JHAA1vpTNRCJ3m+KYFOL6g2iXkwaWEQ5V1zwYpoWXYi3QuY581+I2Gf7s8i
	AUJDNUFP+elDHD8MJpUi33Lti2UMKFlPIF8HPo/rxSC5YkVTn/F5Ay19dyf9X35T
	jHhg+X0Er7/Jl96IS1e3Rw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4f26jq79xq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Jul 2026 01:34:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 6621X6o0036152;
	Thu, 2 Jul 2026 01:34:39 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012064.outbound.protection.outlook.com [40.107.209.64])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4f50yt4gaq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Jul 2026 01:34:39 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xmtEQwGRWxo1Zu2g4GLfnQXdpMiIvgMURuK0SkXX8vrvgTWmz0Be/8pmaSGmG48OisccMWnwVcTKQlCI8mO0RwzlpkHPp+jJ8XPb+8lJhvvnllc7q/YWEKLU2++017Mkas4NsPFnrYUYnAnxIYAEKM6vrvaFqhE0NY3EmVWnibN2RQREDfh1UvwtJyjb891QTXLvdfSumr8Ztccvf6dxOeT1pYn+ln6XSKjO4G1qAUAC192VwwmtrzdwHVX5ofFgXk7QXOZn0rrXMctcUaW8gZ1HcL5OB+GQKwkkN9ALTP/QT4Xaa7It+wFPsO9qdnJq1NfnbGT6AqnNiIMcPfH6mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gB/bbdqh/0Sfqj/AUZ1l/h5lMgMMBqCVKXeuXLr0klk=;
 b=zMmtugERd/eLGNqgr5XdG+hRJ2SUR3rUcUhMJutTOOjdZDk4h8dNgGvZjBrH1F9DzWPinCNXasX6PWoiFcGB/2fopLs1MDWf48OqsOdyn1Qmjwu2nYg7JQvmDnkhFggTGz/igTHm+ncsxm61VZt8o2oOuNOLc5+nYj8t4z+V9PxN3wJSaZ75PoUSUqhWuYe5JrfsLM8fXXDa3M2ixlLz6HiQw7wNvvI5wTrWW64TNR1HtmuVPowzaI4AmrmWtsBhyGKFXq5NU8m2e+bthdqD3ysY+n3M04pOOkIvD2JCb+Lkov89E/3wUfO50GOV5rf1LUjyJavdfiRQHCBcMZIhaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gB/bbdqh/0Sfqj/AUZ1l/h5lMgMMBqCVKXeuXLr0klk=;
 b=RO9zfElg27cfFx1y4bw6JocD+hMRPKHR+9t0TGuItkRAdpmWlk9jbmnruz6/Vf+Gdc/qnYpI9iJrnd1EiftmFwYPeGtDlhEsr/bigMD4v5GJoDj9EwbAR0P71Ydk88WpJ4sBHRZm4FaH1V5P9ADOy8STszI4Me8KQAVqtkh0ASs=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by IA3PR10MB8760.namprd10.prod.outlook.com (2603:10b6:208:581::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Thu, 2 Jul 2026
 01:34:28 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 01:34:27 +0000
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
Subject: [PATCH v13 09/15] bpf/rqspinlock: switch check_timeout() to a clock interface
Date: Wed,  1 Jul 2026 18:33:28 -0700
Message-Id: <20260702013334.140905-10-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260702013334.140905-1-ankur.a.arora@oracle.com>
References: <20260702013334.140905-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0063.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:111::15) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|IA3PR10MB8760:EE_
X-MS-Office365-Filtering-Correlation-Id: 806e7423-09c5-47c7-1b0c-08ded7da0e42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|6133799003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	B05wIEVEibAl7zd1+v5sq/v9ux56ZyP95PKvCIAWO6xjKuETdVE79W3u1zRhPGiJPCR8Fpgzxi+ojpKg2hP3pKr5lp32/ex5lywBCXHUQqXh9egn8hRfVGjUBeCUwc20Cfm3WsaObiHJ752qdKEDyfbY/3BfmMqJs9gh7urUgMvM0hMwH5jAmdZ3UXd0/wGbX10hNYYtYN74D59clSNAEKqyWiyWIAvFv/TcHhqibBsfQyV73m/OjtbKXrQd177ua3iFyKtFE8JuHoLmvRDqmqcB+qe6ugy73z6bPNsG5bllgZSJb3t4zLg2e8d/ArYdp9I0Z+76qBsMM36FdhzwiLD+/1xsMnPp6nuSvCdVOoe8DopggQ3MybJqPqpsJruYa2LdgIlLA8qqaviOyOLU7Y4hy1i6WSKtK/ii18ygiWWM1+s77agH48AaS3aKEnR6Zs64dw9Y3xe1QTE3LsjewJgU1t5VeVUlAgCgardCbMHrX0wIBKSKVynI2GhzFO1H9s2QQ16ZzZ6fNJog2kWy8p2xudFpjDkKe/iTR8ozzZD29PmvOWVLuIcRP7zEOZXlQqljFaNcrKAAPHxx9eetarE+YXNqzmMMfQrEOTc3ZT1Dx2uOwkYCMM56gubax/SCgiA7mbNFu/igC01QdVR0Q4yexzPLQuQr3GVHpLCXJp4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(6133799003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OEM16LAw5mK/Q4sk0U1MkzQ4OVmLNlEy6xYvdVAPr0jsXpgmmi23/wff4Pzu?=
 =?us-ascii?Q?UB9U7DlQonFG4J7BZBo0+svd4nVRb9ZxouLOhrqUZu8CDuL8tPHffz3bTm1y?=
 =?us-ascii?Q?uG724wX/JuZiITE/uP1gqIm6mLCQfhMTx9wIbGNC1Pfqy1ihpn/6Cbfsiflo?=
 =?us-ascii?Q?RZCjhApJokON5vO9onOr99RtxnFhkYLb/1UcWVeiqbNSJg3dXDgwDQTJmuMF?=
 =?us-ascii?Q?VHwGM9sY4z2Bl55u7Obyp/57n61cDswCNeJKeBNhUIpbsVSNKeZRyOFyEnae?=
 =?us-ascii?Q?PQHFW54ycdbUlCn1DeGjlCXA+8J4VlkFx4GrjGLllQleuyI+lCAtzqSQAJYo?=
 =?us-ascii?Q?YlZhyxJCmaOxTpsDA4K5AstMiAeUrdxLBn6GkPRKcOOjc0y2STwqzD6b6byY?=
 =?us-ascii?Q?6e72XqRC4ZdW3BBf0REPAm7imCpZKY+IyAwD/J/b2fT58eQ7mEjiXDo49wFE?=
 =?us-ascii?Q?2HdmSgWPfVNO4c8JqOYioi8loGVCX94eSR26UUmtRY2Ig8Z95hJuW5HjxFL4?=
 =?us-ascii?Q?TTYNbrDX4WeGveXJZa4HC2CFfRd4wMHBP//UMdSIM+7Arz3f7bVXBXSCWUSN?=
 =?us-ascii?Q?ifK0AlNWHzAYAkYrueM8VTBC+MsgJ8feYFAeZksa5Bqf0IfXdDhkm3rUqw26?=
 =?us-ascii?Q?xcynOlnFvVo/FmMnO9DIRM4ie1H9BTSToV6M+Pm6oRvBfZRSmdIMYgYgbzB1?=
 =?us-ascii?Q?yB7LOpYp3WThZJbLC/iClpcF7HB1MldzuhRY8LSe7KxTZkrx6OJu0zXo72px?=
 =?us-ascii?Q?saYXas4hj7fl6mbUO4ShAn1zKpWl/9BrgAsFPs3GEcw1N/hwa9XewrPVDqtv?=
 =?us-ascii?Q?NjrCM+F3+VkHpZpjdsbY1hDiF82bf6ih5KRx5UpmGYauTnLo6eNgi8ikZIUX?=
 =?us-ascii?Q?+FzNObguXSXnJZwuvBOTQXRgD/AbdnLNjpdkiJ1SuJ0G3RGmOqCvizUVaEdo?=
 =?us-ascii?Q?a6kA1p0wUhi7qa1BsosrZC8IB52QvUxfcPG6IlECfQYfmMiKq79tMAhT2ci2?=
 =?us-ascii?Q?rcumng5XbeRUq/U3QvlmHl4WWPBcR2at+gRk+TT+fmWXBit2g5XnmcrueDfP?=
 =?us-ascii?Q?y4sDhE/TnUR/WzHR/NPVDxm82BJmgKHQTE5WimjpcqKnbMvhrKVdhnIdoS3x?=
 =?us-ascii?Q?Gz6rJlZE/MMBM+e5FuXx+oNReOEv2NPAs/ZhRdA5YkjAQBZ3bwAiIrbaifCf?=
 =?us-ascii?Q?rsrfF990VkAWA4vJFRQ0e9rPL959MGpwYKjQWlhgrsnvusEFtGyMHsXG/kNT?=
 =?us-ascii?Q?5YRlN8ezOV3Wub07tQZEDsafuYfwVaV4VrjR6UOK1aWu+QQE9lAVJFrD+VJy?=
 =?us-ascii?Q?ED/eUvnB4Iahu5esTeerIx0J4ZvNzOxiEmHBIf44gSLjJxXKBgeZ4iwa4X3t?=
 =?us-ascii?Q?sflEhpB22xb8AujOpEw/4ETdIyfCEa+DoA8MpQfmK6ft87qgg41urA7sWM+/?=
 =?us-ascii?Q?0OwVofLmBFMnSvcFd3nf6j07xYsT5WyhzaUA87NUiMzWIEdykEHkmr2ZUK5c?=
 =?us-ascii?Q?92fkFZqZscSRkh64xQpAK7fGs9IqPmef2wR2JZfRWGSFKP5sXNflSpeHBN5O?=
 =?us-ascii?Q?diiIy6pnVXoQTzMLdU73X/fAq1yB8f7/7GBYTx72Vq9yRBU7cZ7FHQNq5hDT?=
 =?us-ascii?Q?MBTqORxMA/MkB50Yt7WITlyvQ5cBF/K3AotF2h8ZZPXXFpIogmAtFkpbz1Ii?=
 =?us-ascii?Q?9vKJK61kFJ1WobDRNDQYDLRTNQapJMwTMb1jQqnn2w54Dkejy1hgj/a6kYIP?=
 =?us-ascii?Q?5xu2pGnjb5ZmBbKIPfiyZGIAGYXeqN4=3D?=
X-Exchange-RoutingPolicyChecked:
	P/OI4PbrmDuDt05uA0Xr7a9pe4qQzw2c9TJPgxvIXubg7YACDzeQBWE/Me/ygUzadrtsiMh/y+2NsWvlvIK/ZZZt9Oxk1Ne4hbSqgyEYVUqDSywQThgbEoYG5ZNENwRLtpuKsDCCukQHLKVsXUjlaeETRR/pIVaIVUd3QxJqCjiTdulvr3zh4T945jp3ZGKU+qj1AIugRxizu1l7YdcpUEnp4l7K/O9CvPAnUknfdFMdvcE4MZp7u8Si7MbLzWGXQr7lJzLhJbZeLNMzQTVdBCxTgehcUnhYUm7iShijon5/lgOvE+1lnGU28zCLrvLSYk9DzRJd3zMEWiJRJpxIJQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VEO5Sp8oa0KgLgpGnAXk3HJsokfkpOnVBc2qfsrpd1GAZDbq43OHOHG7vlNJodlVoMQ9CzmSivS3v8dWE4QyXy8o19e4y73kVsQ09BNGFfdRR5whq8LaZN0Q4iGYHE2dnu0h1E40TsfNsgXU2/cxlfA6S77PerLiEIPTghDUBGnj1wNqf+tvYHWRM2ZBvoIUUbl21t5FuZtuVvga+MPMJ9TNGEgp3oQb/MCNSakUnXxE0V/PxW8Ycv9Y/Wc2kDNNbo/OKdCM5BPlkzlFPx27zPlgugysk1OIvVgo35ShANLbuPeZZ/PQcsKh0J4DbmQ7D9tkhtBUEZelXteyJmdd+4N7I22GuhtMZGVReFYyuDLIAFbRLXj9jPBXqkL4bg21CcQHx1OPGMRGBmVc3rnzw50hFftwd32otae/7iZhlCfBgEqgot0vcM3PIpqZa90ByWDEQeBCbdslcpYhgFNx5UO8G+eWLnLFOe1YPTLmR5ESpCRd6bs5eG5E0UwDfGafV6wpyWtyjTOS+Oq8lZKjMaa2U3wIzHiSBzeUG+Z6gRTjLRlKxHoHD3Qg/6nkkHtaSeT+aqsS6ocFoi91vmffP4euOXdX22GXeV7qsgpamAs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 806e7423-09c5-47c7-1b0c-08ded7da0e42
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 01:34:27.7553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5/7E3KhdFYTUxs+8J9I7Tf2VVh1LNhvUyXxTH9u6sj+dldQbtuCrEK4WhZPXd+bYWTBv3/vSucBGq3p2wexdjgF/IXBLGS3Cf4gtYTyxMZI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8760
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 mlxscore=0 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2607020013
X-Proofpoint-ORIG-GUID: o5pvbjAIr15m9SXs_Kp-rqukylupGUnv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDAxMiBTYWx0ZWRfXyEQ/xsxQ5QTw
 YhUUR5Fg81p5O6rkOI9SEE3ofNX13uoAd9T7TXDF/gxKTXwLBG4GaDekZZ8PJRvRN8azxu9LNQI
 W+pjoOV54aLGgHlYygnbZ4lwUoJ6ymKUZMCgTh4p9sMF6+F4IT0RVWEQpcaUnetRGrIYy7VP0Ex
 b+BxWfZCQfOyLg0qN1tGGr3HWsQbXXs6gbkDtmkc067UJVARwFDMrdJPGDr2ioizsQwQdjurnIC
 qhicgwpGJyD+j8HSBjJcs38FEf4L3IBEffNDftE47VDVkxFAZv2lp/dQf1V3sC1KiWia3Rdm2iC
 PJaKNxghoTJFXAg0tPFq0Q9SwGv+2pfFnWo+XcxfLqGbNHyWFmuCrX6v5wBCJZlNQBFl2HYcYD6
 Asbl9IDoFIz2HZd7udZ/GRlQ6NOpPHFIZUCWt1Z6yxpCpgtbDNIlPltaYiHokzvrgo3cYQtsGmH
 ucxQaQvnlpKAnEGT2Ag==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDAxMiBTYWx0ZWRfX3+jwjOARP4zo
 sCHwHJ/Xe55saSnEiYsdtNKOFS/3sLGQY5S0ylNw6XG9i6tI6WHhFW9XBCSHSjo1UBs5G5mZqvL
 DmSJwaCe9ZVOe7Ysg/jDgGTu+xiM0kL1lXEfYUbK6DP9Nt5ZwUYS
X-Proofpoint-GUID: o5pvbjAIr15m9SXs_Kp-rqukylupGUnv
X-Authority-Analysis: v=2.4 cv=XrbK/1F9 c=1 sm=1 tr=0 ts=6a45c030 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=o5oIOnhZENCTenyL_yNV:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8
 a=LqkqbBbWekfmbT-3qckA:9 a=WmVTiCyuxqgg3mnwYu6p:22

check_timeout() gets the current time value and depending on how
much time has passed, checks for deadlock or times out, returning 0
or -errno on deadlock or timeout.

Switch this out to a clock style interface, where it functions as a
clock in the "lock-domain", returning the current time until a
deadlock or timeout occurs. Once a deadlock or timeout has occurred,
it stops functioning as a clock and returns error.

Also adjust the RES_CHECK_TIMEOUT macro to discard the clock value
when updating the explicit return status.

Cc: bpf@vger.kernel.org
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 kernel/bpf/rqspinlock.c | 45 +++++++++++++++++++++++++++--------------
 1 file changed, 30 insertions(+), 15 deletions(-)

diff --git a/kernel/bpf/rqspinlock.c b/kernel/bpf/rqspinlock.c
index e4e338cdb437..0ec17ebb67c1 100644
--- a/kernel/bpf/rqspinlock.c
+++ b/kernel/bpf/rqspinlock.c
@@ -196,8 +196,12 @@ static noinline int check_deadlock_ABBA(rqspinlock_t *lock, u32 mask)
 	return 0;
 }
 
-static noinline int check_timeout(rqspinlock_t *lock, u32 mask,
-				  struct rqspinlock_timeout *ts)
+/*
+ * Returns current monotonic time in ns on success or, negative errno
+ * value on failure due to timeout expiration or detection of deadlock.
+ */
+static noinline s64 clock_deadlock(rqspinlock_t *lock, u32 mask,
+				   struct rqspinlock_timeout *ts)
 {
 	u64 prev = ts->cur;
 	u64 time;
@@ -207,7 +211,7 @@ static noinline int check_timeout(rqspinlock_t *lock, u32 mask,
 			return -EDEADLK;
 		ts->cur = ktime_get_mono_fast_ns();
 		ts->timeout_end = ts->cur + ts->duration;
-		return 0;
+		return (s64)ts->cur;
 	}
 
 	time = ktime_get_mono_fast_ns();
@@ -219,11 +223,15 @@ static noinline int check_timeout(rqspinlock_t *lock, u32 mask,
 	 * checks.
 	 */
 	if (prev + NSEC_PER_MSEC < time) {
+		int ret;
 		ts->cur = time;
-		return check_deadlock_ABBA(lock, mask);
+		ret = check_deadlock_ABBA(lock, mask);
+		if (ret)
+			return ret;
+
 	}
 
-	return 0;
+	return (s64)time;
 }
 
 /*
@@ -231,15 +239,22 @@ static noinline int check_timeout(rqspinlock_t *lock, u32 mask,
  * as the macro does internal amortization for us.
  */
 #ifndef res_smp_cond_load_acquire
-#define RES_CHECK_TIMEOUT(ts, ret, mask)                              \
-	({                                                            \
-		if (!(ts).spin++)                                     \
-			(ret) = check_timeout((lock), (mask), &(ts)); \
-		(ret);                                                \
+#define RES_CHECK_TIMEOUT(ts, ret, mask)					\
+	({									\
+		s64 __timeval_err = 0;						\
+		if (!(ts).spin++)						\
+			__timeval_err = clock_deadlock((lock), (mask), &(ts));	\
+		(ret) = __timeval_err < 0 ? __timeval_err : 0;			\
+		__timeval_err;							\
 	})
 #else
-#define RES_CHECK_TIMEOUT(ts, ret, mask)			      \
-	({ (ret) = check_timeout((lock), (mask), &(ts)); })
+#define RES_CHECK_TIMEOUT(ts, ret, mask)					\
+	({									\
+		s64 __timeval_err;						\
+		__timeval_err = clock_deadlock((lock), (mask), &(ts));		\
+		(ret) = __timeval_err < 0 ? __timeval_err : 0;			\
+		__timeval_err;							\
+	})
 #endif
 
 /*
@@ -281,7 +296,7 @@ int __lockfunc resilient_tas_spin_lock(rqspinlock_t *lock)
 	val = atomic_read(&lock->val);
 
 	if (val || !atomic_try_cmpxchg(&lock->val, &val, 1)) {
-		if (RES_CHECK_TIMEOUT(ts, ret, ~0u))
+		if (RES_CHECK_TIMEOUT(ts, ret, ~0u) < 0)
 			goto out;
 		cpu_relax();
 		goto retry;
@@ -406,7 +421,7 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 	 */
 	if (val & _Q_LOCKED_MASK) {
 		RES_RESET_TIMEOUT(ts, RES_DEF_TIMEOUT);
-		res_smp_cond_load_acquire(&lock->locked, !VAL || RES_CHECK_TIMEOUT(ts, ret, _Q_LOCKED_MASK));
+		res_smp_cond_load_acquire(&lock->locked, !VAL || RES_CHECK_TIMEOUT(ts, ret, _Q_LOCKED_MASK) < 0);
 	}
 
 	if (ret) {
@@ -568,7 +583,7 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 	 */
 	RES_RESET_TIMEOUT(ts, RES_DEF_TIMEOUT * 2);
 	val = res_atomic_cond_read_acquire(&lock->val, !(VAL & _Q_LOCKED_PENDING_MASK) ||
-					   RES_CHECK_TIMEOUT(ts, ret, _Q_LOCKED_PENDING_MASK));
+					   RES_CHECK_TIMEOUT(ts, ret, _Q_LOCKED_PENDING_MASK) < 0);
 
 	/* Disable queue destruction when we detect deadlocks. */
 	if (ret == -EDEADLK) {
-- 
2.43.7

