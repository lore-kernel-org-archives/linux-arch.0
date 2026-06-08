Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D400439E6F1;
	Mon,  8 Jun 2026 08:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780905929; cv=fail; b=myOO3979QmohMNikrhWpSqwLiEn+RTCy3THYRP5+e4nMsQPKggR1ay9frujszfpZsCY9vmdtCy9VjK0laIWL0bgSIKsflRc8DDSnLQHQFUwwRS6mByEwEpqVEuvwidcAYj7bKgTw5qZpLown057DzdDonb+vO5obSvNfNoyLeF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780905929; c=relaxed/simple;
	bh=asgTkgPsd9HphHuIip99cadtzMo9f6eypJEX4o4rbQ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U79DpthqYZfyx4se48Aoq9Rb2OFRYHmnsp5hsHGFVrWf1+tYBdYKa3gm2FYlHeT2ZXjBBeAg4FvpqL/MOyMnUtIN7m5LwKs1QNgj1JDngp0LYIxAWaqP+QSy/Rl1txPbaqYl9SWrT/dJcmJCAIEIq/WWWfmuZjT7Mf6PIEjrNzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=D99nzias; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wq6gnlrE; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="D99nzias";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wq6gnlrE"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 657NoYIl3643931;
	Mon, 8 Jun 2026 08:04:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=70PY6iFpeqklAK5RoqZXQ2jStsx9gEGG7INLaintPbU=; b=
	D99nziastLa1AheBhY1MjoWSxqjwu8VEnm66xoM91fLS72zW9lSWPjOhJYJi8HEG
	ayuHDPSfG9ilsBjdJP7QAZJ9WY8Xo17Qg2zy9ozWmUotvSgLvei/YXfzRBTpXlgU
	gZwXtACfKmywIFEfREuuwV+106x98vTBtunsy40/mXQ7C0SB6CL2Z7ZBB62RCwfZ
	z2aAhYhwtkXGJqX0ySQpwtCmsV4PfPLT2GoMLy0HEaPVlkMvDL306zizPUXMCNh/
	bx3RIOv/g+DUOVzi74SYP7Cf5UI76+mRTu2pRURjVAz7IqtO86IHdauTBApf0UCQ
	aFv0YveaTau4VDunk/AzXQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4em9yba1c0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jun 2026 08:04:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 6587wTYh005906;
	Mon, 8 Jun 2026 08:04:50 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010026.outbound.protection.outlook.com [52.101.85.26])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ema0ngg41-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jun 2026 08:04:50 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pxoh5HWDhl6tfrBhiHaZkbDc5p0fqMxXVc4Tx6WAMUClp5iAj+B4zoxvnoA4MpRTqA9xcnYiIZXdpEJbnwV7kT3lO1UhhUz48OzpAU1hoJBjFvaE7By4RedVNtRomwiZkGKfszYESEaCNWMbUy4VBRUHFbke8IgH1/CmJT7ZdCFTiSG2dtyLa7USL3/b6CeY0Q+g89bDqh6+GZX0tsM0nKjI+Luc/m2nfMgAp+10noWyoFMi3mIhz2aezxbD4d8pxC2oNNSpzJqbHw3tDHbhITKAhmihycxhuvp0TS5mWTUSlF76b2nqddPjsdNTvX3zxb5Ok8XU+fx5duTplRbQ5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=70PY6iFpeqklAK5RoqZXQ2jStsx9gEGG7INLaintPbU=;
 b=njxTJvwFvpSlST8+3gcCY3G3sJd7lDk3tupDHQNhkJFh+zJQK4NKrKbXM+oX0iZb/NaXY4UEIj5ziO5Lm9CrG2Rr4PEm78Y4x3Id2kdivdSQyL5am3FJxTqgbCJWGlp0vVWzEcs5myMICeWUR8AIhLKqse6yj4HE0RkolDk0YDbS0OBqfX1uLVI4dErlNl4OWdpkxzMponcHpBDgZPvfP1HzakIcu9yEqcTzQn25YPbeZWL3MlHrXJYd13uk+lno8pX/Uu+xYX91Y++1yEv06yt8yI2Y4n12vbCR6uOAV+OBeelT8zdiqLPpbfn+Mi05zo2vzz9QeOWG2ei/ruuvUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=70PY6iFpeqklAK5RoqZXQ2jStsx9gEGG7INLaintPbU=;
 b=wq6gnlrEwD6DhHaQdji8nXaFGN5hMwhyDuREiPnDruyTXXWxB7nYY2p/A5RSR1364zDlH73PivKOTCpF40RZd/5EHG53ucWVLJPsHBKZOamdLTCbka4nmxANjNoR06zP6i0dX7FKe7d3Ms+Qp3GC8IxFCzHvrLBBBUpnLJfSyAI=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SA6PR10MB8133.namprd10.prod.outlook.com (2603:10b6:806:436::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Mon, 8 Jun 2026
 08:04:46 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 08:04:46 +0000
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
Subject: [PATCH v12 02/15] arm64: barrier: Support smp_cond_load_relaxed_timeout()
Date: Mon,  8 Jun 2026 01:04:27 -0700
Message-Id: <20260608080440.127491-3-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260608080440.127491-1-ankur.a.arora@oracle.com>
References: <20260608080440.127491-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0252.namprd03.prod.outlook.com
 (2603:10b6:303:b4::17) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SA6PR10MB8133:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b956133-ac79-4367-5454-08dec5349aec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|6133799003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	uAK0Jwxt8yWvEHq9EaBcYk7yGSJ/MGfQQ2wUO52zmcahL2lfTsHRdtUsL7jB3WAi7MsAWDg1bDF6vo2JlY226jDqdMnbCqBxHEul8EV4GJZZ6zFGkSmDyPMyIN1H/F1C4OW6yXNytyEAYU9eToiz1sP5N/MXY2aeqnW23pTfVlGm+TjxeZpmP3nhq953tlvMWStyN/DbQ64NG3/TUsZ5VreQQ8NKAHiEwXLr66WQuC4ebd44gTP9ex3KJSE9LcmBoubrS3/sQgRcsgaWjx85U7iaMV/+e7xkHmTZpoeT7zlOa4o8T3uoy/rQ+PZG2WW4eyjvHSZbnrijGbjNPXMY4vgIMlRbteUHasKa7ffnufHuQZpesNECHRizf9cKVFzZSDfVx36dEEdaAVtfNoesEldlAnK+OvTiBkb2VZmVT1o+n0mSirGqDvcEYSIfLxvWJt3cBD8XJk1WcW+ojuas/N6tlZ1g3L2U/G9EuckWSeWxvUYR1WE802yi+W18ZMnmYUfq805DE58VdzTrdxdK/IgLYWC5knfuqmUALW+se9KCXHwJmppUVH6qnbrh9mRWPzKx+/+ZUDxMf4KcmnsiE9/JWOjD7+1WPBoAc+EHAdOeFUp2OCsJ/7aZGLjkWXgmKG6wmdeod9yKFcAxeKqGvw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(6133799003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gXMUkx9zRnekngQSlq28YRO9yjDjfUbqu/fwWSxQJ5sX13VJa9QgF0KJJAlE?=
 =?us-ascii?Q?XsRgae5lgwZcLgBHPGp8GZK6Ru4NSspU44Y7P+n7JHU69hb6ZT2WW8eNlAxB?=
 =?us-ascii?Q?bQIe277dGEPSsW1h7iwFI26NJdyjYQmhUTPU3PBepAYwScbvnqDYfV4qoT+8?=
 =?us-ascii?Q?bWmKmri5GrnF1sD361s77roEigf+g6PH8CW1GEExNn0CtO3GUBI+0uWY/rjP?=
 =?us-ascii?Q?CkhCOAZoMEBb2nFP8wZCU2R8m+ZrgaLS64gwC5yWQ5X8CHtZTQxGVwptoiDH?=
 =?us-ascii?Q?TNU0UbiHJOj8B274TMUtsWBN/6b4Wws5O5YuZ40Kat0a2xlF9zndKZ0u+u/G?=
 =?us-ascii?Q?JMTvDkbN3oVRcDx9dCpVdjZ7wBWTG6eekwRfS/iEePB5W1kUol10yJ2ILJBo?=
 =?us-ascii?Q?oKMlrCbuvGm/5Ocd0xvGNTIhA9IzmwLtsZU3aYvbzh4VLI7gLUxpmmllcjmX?=
 =?us-ascii?Q?F1FeRbQnWuAT5j9HV3J7MMMZ4CiqepNkEPm18KvLZEIPGGknRpc1sy+Gci1z?=
 =?us-ascii?Q?PhoMgU2e/CQGihn0pNVBh+1S8OhhY2o69U9GNwHdkULLnel++TEeRwaKpS8R?=
 =?us-ascii?Q?em9zVbXVTYNnCiRUOXTIFFCViHRpwL1HVHpBo3Psb5vDHCwOCbGcNTmfKoAU?=
 =?us-ascii?Q?48MgdRIzZObj4H7VhDoV8m8o6T27vGLAlQ0uvYzVRq+wGMDnjeMm0SuzYQ3f?=
 =?us-ascii?Q?13SDMPZtotyE4o0QLUYImJMTP8jKWcvpMLdfdk9yYHtWy+yC1LBMii/vNp3f?=
 =?us-ascii?Q?8/0vS/ATs4RGLNtG+TJ4Qez/BEQFHi5g3OUcgXgXPObM0FRvw7rdj4iU2zNO?=
 =?us-ascii?Q?xeuBwvbwkpIj8hgPIys5xWkz2pRivz6DPANTMT+YcrgnfMZO5adpYT3SV6oQ?=
 =?us-ascii?Q?QaQwkt4eq8RWnAgeohTkCWoPfGi7ktc6UiRPRR9X5BXewThyrttS3ueIVi32?=
 =?us-ascii?Q?uKjJj7UVpTEzvnjLpORkFPgjQWn923S7v2dErwDZKpBDBcJN9yf9Vpsfv3YZ?=
 =?us-ascii?Q?tQIUVikxqRWOp8MwHrrRp8sJG4gOMIiaQEnx9cDW3spy+iNa7y5Pf7ySOmqZ?=
 =?us-ascii?Q?j2bAPMkaSNbA9+mVnEJCmoxrqE8vDnDbKXLMcq+4Y0y6OM1kQZfYBFAu96GK?=
 =?us-ascii?Q?Pji2X5xdotNL1ekqABkKufKk/viEqvpG1QofxUKaByoVevf++7CwaOV/kCcx?=
 =?us-ascii?Q?MwTW6wcByVn2BYgpkP2/+AKJbfFbXHvfdz70JDjqjUyqmIXSMMUV91Naav84?=
 =?us-ascii?Q?XSjOMCxdd8mTLazaDUp3AX31eU+iO3fJfQm05rVkrSfn5UfxQiD5TkQ3yw6t?=
 =?us-ascii?Q?NS7nXo5q/ykTxJoMcKt8NUGBcISFAdxt4PsfKojk6lL+dGyYanuJCeFNMpyP?=
 =?us-ascii?Q?pV1CMU9G0ggYCgAfN5lQo/Zp+ptsHYbtdZr7UEm2kMiRbx63NEfpFiOGeug0?=
 =?us-ascii?Q?kp7ANkFrJGjuYw4hP4iI8+n4G5qt15pt4XNyKI3oXfm9eXlqCER4KKxZveLk?=
 =?us-ascii?Q?4XG8D0DcFkmm2xguRP94EIcjuejlyL8IBNi8Qk7JsSJmNopi+1vjVcQ7Rk1+?=
 =?us-ascii?Q?FeFlPowe/3PtBFA6XqBLcL/p/b/CS50l94BNB02EQ4hnh+cc7cBdN1bMOXfh?=
 =?us-ascii?Q?bZiR4HAeSzVkFZ+y6TY0sTpetIryB1KGlvzBoKmGd6ipi03d9XKPVoCYKqcJ?=
 =?us-ascii?Q?KnZrpZmW/BsgvfX/ofskwKkC3NJbq/YBE6ZScDNpjoJ9RzlN0dRoE5HKZWcZ?=
 =?us-ascii?Q?WLhOblW6Fg=3D=3D?=
X-Exchange-RoutingPolicyChecked:
	KjoiHcwtLT0DS3znSxnyUq51Zqeuj1ypHxLSdXqcgNoIK/6ICAbF7BV+kn6AAarBC3YnFPYhDuSf/kQk6PC8ZoqiG+fHlSoaL5ghng7c+StdTn9fORropG6hjlyM2Qt8xruiRy1mxvaO6qy8fUCWI4O6WI2gw6j3sIb60lP8jRK4O0VxgQ5IGIxDjKnw4Rr+DszT5doYjf2tLq4CTF+sNy+Gz0eZ3JhOm/2psY9vymP0t5oReF4+drcV+Mj9eCCXK/JZc+M+A5ECIpNGOb27PjyfbnlZ/ZHP1NbEz4tzt+NW8Hp0YfvxEqJgUcNeoYNoanok2VMTG9UQyujwENDAOA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+VFIAaRINdrK9LFrofvJom+Zd7+cf+sHhiOr9vc2N2IHuK2lJ6rQ847JjGUSXGkPZIzaJWvqyhGxYkYArLJcoNgUAp4dVXHlrnfbAICW5UMu3sC88Y8/NtGu0Ub1NAzmdIAhEs0JyGohrMICQmMw5PupHq1vZ2KwcQ2nzPqdW72iAH4Pm31DqZcxxFY/DDZyCp0Di94lALDa1/D1T/8UoyZfjW5k1WjGLQkCxYDc3G1lgXbFHQpUTXn1rgEAtQGF1MPmKkYUB5HzayXCD9Ah+R46QBxDeZI4UqMzbToM1PdVjxgXQReV5posLhFuq9EjRXCBdHWQ4nck68Dfv6kVJwTva3NyyCIg2bOofD0ekekURjvvmeT9gXDyHVW4E/a/b1ECQXvXDF9K3HPAXzqRr0kJxdAnycZ25KzNLGEbN/J+9ki7wTtj5JccxblZ214AJ23+QRu+Mjt9Ge12zU4J2f71tHzqNiYzgrqUHeO1oNc7IfwmF8pNvvYPqL1nvYbkrd8wBWP5WyZWXJRSpeHTIz8UuItDFtxfLJ8EH4UaChi2UG/PrIg3pcnEJiFJErFbi2YKYdT9TZFQGf98sul44mtO4ZCNi8agq4T2PA8zn88=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b956133-ac79-4367-5454-08dec5349aec
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 08:04:46.2814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xnsCvYAcJqrawfPxg5kf8h2jo1DxCb/ATnOQHYP8wCef794OVE+IicByR5iU4pYfSWHbqviMk2kLc7SrUI83HleMuvxRF1Zt4NoOskByFcU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8133
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 mlxscore=0 malwarescore=0 mlxlogscore=830
 adultscore=0 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2605130000 definitions=main-2606080073
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA3NCBTYWx0ZWRfX6LQqCmtcy9nu
 gLhTjK3MklY5vjjwX9OZm/XLh5cXO7c4fBX8/2QQrVF0wkPoXKV+4kTWUFMv7KryPGnsIPBZVsX
 5uPFtzY/JextkfROEWwrGQ6Hwqabfg7lHMVBwemd0CkyEM9yinuamT8bFR4ZH5R4bJ7ToaY6uRd
 XFd2NxKoba/qes2OHx1k4VmxOtKYw9Qd+sn/OgEUv0vLDDm3PWF+lUCs81K/jZ9bPfDHKpfFJom
 kzf5RCvsbNCNNWXIa5bmfxlQ4+t8v/gYwa7fvgPVj7wHJUZKUP+9OHSTX66gme44IezDUI6iXPa
 O0fs7+YTjxyCuuTdwi0M2aMooiHASPg4m8LPGT4Wu6OYH+d2Febxxd1KvNK6bXyJfyRQQyvjuVg
 KTAqeDsHq4zADnIrogjREHVBk+TOcFDX23T2aP65ptFGQN+E2lXI76VFreU3Ar+pcvBXty9ZtLm
 nOrozih8ZHS/PN4FqAVZK2g8+wj0UAvWEH2iZ+0E=
X-Authority-Analysis: v=2.4 cv=IYK3n2qa c=1 sm=1 tr=0 ts=6a2677a2 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=FelO9ux0wxsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=c92rfblmAAAA:8 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8
 a=7CQSdrXTAAAA:8 a=JfrnYn6hAAAA:8 a=p7msl0-MwrJJe7Mg_5MA:9
 a=GvGzcOZaWPEFPQC_NcjD:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=1CNFftbPRP8L7MoqJWF3:22
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13723
X-Proofpoint-GUID: EEJQHsCjJ14i4vrKFe22Mohgx7bWSbG_
X-Proofpoint-ORIG-GUID: EEJQHsCjJ14i4vrKFe22Mohgx7bWSbG_

Support waiting in smp_cond_load_relaxed_timeout() via
__cmpwait_relaxed(). To ensure that we wake from waiting in
WFE periodically and don't block forever if there are no stores
to ptr, this path is only used when the event-stream is enabled.

Note that when using __cmpwait_relaxed() we ignore the timeout
value, allowing an overshoot by up to the event-stream period.
And, in the unlikely event that the event-stream is unavailable,
fallback to spin-waiting.

Also set SMP_TIMEOUT_POLL_COUNT to 1 so we do the time-check in
each iteration of smp_cond_load_relaxed_timeout().

And finally define ARCH_HAS_CPU_RELAX to indicate that we have
an optimized implementation of cpu_poll_relax().

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Suggested-by: Will Deacon <will@kernel.org>
Acked-by: Will Deacon <will@kernel.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---

Notes: Doesn't address sashiko comments [1]:

  - event stream being disabled or broken: the event stream being
    disabled is not a production use case; doesn't make sense to
    add a fastpath check for this.

  - arch_timer_evtstrm_available() isn't exported. On arm64, this
    means that smp_cond_load_relaxed_timeout() won't be available
    to modules: tight now the use of this interface (and others of
    this ilk) is fairly limited. Not worth solving until there's a
    use case.

[1] https://sashiko.dev/#/patchset/20260408122538.3610871-1-ankur.a.arora%40oracle.com
---
 arch/arm64/Kconfig               |  3 +++
 arch/arm64/include/asm/barrier.h | 21 +++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index fe60738e5943..fa676428ec3f 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1606,6 +1606,9 @@ config ARCH_SUPPORTS_CRASH_DUMP
 config ARCH_DEFAULT_CRASH_DUMP
 	def_bool y
 
+config ARCH_HAS_CPU_RELAX
+	def_bool y
+
 config ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
 	def_bool CRASH_RESERVE
 
diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
index 9495c4441a46..6190e178db51 100644
--- a/arch/arm64/include/asm/barrier.h
+++ b/arch/arm64/include/asm/barrier.h
@@ -12,6 +12,7 @@
 #include <linux/kasan-checks.h>
 
 #include <asm/alternative-macros.h>
+#include <asm/vdso/processor.h>
 
 #define __nops(n)	".rept	" #n "\nnop\n.endr\n"
 #define nops(n)		asm volatile(__nops(n))
@@ -219,6 +220,26 @@ do {									\
 	(typeof(*ptr))VAL;						\
 })
 
+/* Re-declared here to avoid include dependency. */
+extern bool arch_timer_evtstrm_available(void);
+
+/*
+ * In the common case, cpu_poll_relax() sits waiting in __cmpwait_relaxed()
+ * for the ptr value to change.
+ *
+ * Since this period is reasonably long, choose SMP_TIMEOUT_POLL_COUNT
+ * to be 1, so smp_cond_load_{relaxed,acquire}_timeout() does a
+ * time-check in each iteration.
+ */
+#define SMP_TIMEOUT_POLL_COUNT	1
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
2.31.1

