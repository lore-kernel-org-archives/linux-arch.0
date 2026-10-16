Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C5B3D890F;
	Fri, 16 Oct 2026 07:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792134572; cv=fail; b=a+0bpPYC4yw8XQxqUY7HUvCZacI36HOv0sC0Bc9Bhj+73OAAJ9XYSDwDcSReX4ARCFAfsOh1xnTVlFv8AmgmUlSNwwoLSvjZg1ycea+oJNMhttzcpgkK8lJUSw6AEonc3YUxa543EM17zSIpXObMTfoqNfqi5TB+PMuhVkkT3Ac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792134572; c=relaxed/simple;
	bh=EcxkNzNmYl/W+lZdc5eU0fa3pB5EXhmY7/3mEczdv94=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GpRE50e0kiVozsqyJR0oJTTENaY2fTbAHzb+1wAr7z+uwGQh4dMvX0qbhUEKCtLwi/w+VvB5iv16p3zfxAR5L7xf3m7MdEWH4LMQTA7dGv79YlMSbY8A18H/1Wz72P8eM1VpPaFMJd7PLrrtwOU/Was7Adxp62lpO2Ydi6iBOjA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=e3EwEm1J; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=woWS/lfO; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="e3EwEm1J";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="woWS/lfO"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69FN7Nck053213;
	Fri, 16 Oct 2026 07:08:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=NYplhooZb6iKsc9fnez74zudxNhoiXIPMv1ZVdddasQ=; b=
	e3EwEm1JoBu9XrG+I7eQJvYU0LfVzf38R+aCcHnekhVNSWUcbNOWfaan4gR7MLbp
	bmagDyd7WZCfVQNJNeCFXY6Onjzvs3g5xiddxEWMMqDdxeijnmj/4Q4CV/BkyQe2
	BPv6LdINXeanCyONReE2l3Y1mj5qMBgyrL6CNQ7m9d7P9swLTJ8uiODAapGDhZ72
	VZUVEbLS2fbD4ql+u8DlSvn0YAAaaDW8X8kBkZtKV43UZ9CaLxDHcWsGFPrU7KJ3
	52Z3ZElgR01YnHkyndZYUBB6ocOpBIOiZvveFjkWjWQ4wsp9BFztL1nkOclTNzGL
	njTsIwONpC721dP2f/6GNA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4h7df81ek6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Oct 2026 07:08:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 69G76fec020911;
	Fri, 16 Oct 2026 07:08:47 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010055.outbound.protection.outlook.com [52.101.56.55])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4h7btss0ng-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 16 Oct 2026 07:08:47 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gKcXWKKIgUoOHapI6E8w2aevAM6gjD48vJ7WGVOQH3lCqYhbZRPRDp1MGonOS4QRSvTFJzZ1UHZ+pv4G/T4j1vbKsKpz51UnpOPdvPgxc6u2X9yDRh86HPcoR7bGQoeIwyZE1sByuQeMoJprVATtXiHGNsapfcNvFpPukhmMvZepyMXSOV6gyJdFRd1YfmgjEuPM2XxlByXV0iRH6mOzZrTwu21bbs83el4TB/LKKUsVHxqpH8S0tQUEqMwg6lRti80NdHqMaqrHeXpR55yyLbV3W1ryCvZiuIoQYyz5EAqJKUmcgyQZFHeTLnlI2YB4tSpZUGwDXQK49+dUk+C7Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NYplhooZb6iKsc9fnez74zudxNhoiXIPMv1ZVdddasQ=;
 b=NAXNdhCXcrM1QZj4KVnTdD4dUUDOFGitHMAXs8ZBzqmDhjDY7VcuTTiSpNjiZRad0fIYKJwjwZVRHg/hhkMptRR1hnClA/XBXapGH4k10HFsTqaDgNqvBsJcwZJSbof9yFCS7vHzhVhK7F4yS3cb8h5MWodDtTtIjXgtPp0I1r2ecRqr4co6oKijW/gv4PThVjMB41o6epWdfo18zVO8Xovn9uD6WeD1LRB9Lp9Pp7QR8BIYknQxc+Da9P4O/pir9OQPRO5W9NK9Y+Fo2eZAEDBFVCtodKnRvGBtl3wqFf5kj7Ac9sfYvVn6BnS0ByKA5TYTRuFvh+JCKH7gWJVX4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NYplhooZb6iKsc9fnez74zudxNhoiXIPMv1ZVdddasQ=;
 b=woWS/lfO/shT1kSqM3vPHpSWWgQ9qQV0ozOT8IjZUYzZvQHre3s0qmWeVjxwkC2K1R+LguGnEiH4knwOV9/T4gjsYCX6jv1Ea9xHYKZbWl+4Ati9twUG7K3tpLKQJuXp+qRoeR0RGF1m/86pl7X6wF7nkIsUPNbOoVtNqyyQWB0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by MW5PR10MB5668.namprd10.prod.outlook.com (2603:10b6:303:1a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.7; Fri, 16 Oct
 2026 07:08:44 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%5]) with mapi id 15.21.0546.010; Fri, 16 Oct 2026
 07:08:44 +0000
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
Subject: [PATCH v16 01/16] asm-generic: barrier: Add smp_cond_load_relaxed_timeout()
Date: Fri, 16 Oct 2026 00:08:22 -0700
Message-Id: <20261016070837.440748-2-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20261016070837.440748-1-ankur.a.arora@oracle.com>
References: <20261016070837.440748-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0003.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::23) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|MW5PR10MB5668:EE_
X-MS-Office365-Filtering-Correlation-Id: 5978b28b-3a50-41e0-7690-08df2b5450b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|7416014|56012099006|261009223027099003|261009221227099003|22082099003|10067099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	EVoxLuXDWO1v2yHhKVBkDSvrBV11aQvpawtbvA4PAIRZ6J9sKR/0KiuQuCTl3IDmXc5jHDy9jzwenwoazSaVGc9jNEOZy5QxnTX6fVQRljk0uSwZsllEZ5Og5S3P5vks8RD0QpdCTaF+rus/8Sc7PQQfACjVOzTUrOCABAp1sbWba+5PcRNrFwXXkR+MuFDH2nmLEePHkQfYaePW7Y6D7W6JLa7sjxiT9pYz9XuglTd6ElCMRYf08lBsEwyErDJWEUpeFIMH3gDyGbgxL+hh9+pxS5KRFl8w4mmS8ptsXD0DMvTaIHr/6n5/CrJCGM5KNYc6Sy61n86e5T3r1AFtZ/JJnAIqgkxLLF5uRjK7AwfEqc1WwKlkg4Svdc4aX0E0spFFMnXXpSEGdW2O+oXdqj5DduZRTQyg/AFrctbxsQGVoJMhpb3gQEloDEvYtWP4q6FjvGkeSiwFkSw7QVFVy2gKkQ6CNRoHGU4YRgjoNT5VtPNTWLZWbRXVqZdjfXuVSxVxXpiwyuao+W5FRUkCZPWImVhzAAG6s/UOgRBoPpUs7YvCKrOIST7H+ZUE3cx7T3SvvKe9Ujd8UulS2BBggy9Cbr3vb8D8vwE5A0dbWLc7u6EgMV+RsoEafYfxY6M+Y/xi+XEBDrwiOzg89N2QlxOKaPdiQCVHmaPqZGx6nbM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(56012099006)(261009223027099003)(261009221227099003)(22082099003)(10067099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MZdfa+01GWCC2sj08n2O+coxzs069/D0ZK1YuKGDYDkg6aU/05zs0tZxFvRE?=
 =?us-ascii?Q?UVi4f5Y6txQ82g9JKTWeVYVRtqzjH5aKJrZMB+TzJ1M5Cs9IdeEmhog+sX6o?=
 =?us-ascii?Q?ZIzG+INhLl8EgjpH/IvM1C43jrOO6YlDqbEMQG2yukpQLS1069fQy8/dHO2E?=
 =?us-ascii?Q?gS4quRI4ghSsvERBvcZa1nt1vIP1tU6MIDJBPyusXwsMYORPXiSsqrQEaWQR?=
 =?us-ascii?Q?4BUhIUhLYEIFqyFdvL3mbBwBdh38XhA0HXup9mH8mCCB8879gjWn+Abgy3BY?=
 =?us-ascii?Q?oismBM+YPyDs4dofXQHcRIDTzqTVg7oZKiRSy98RQCRmFCU27+iGMqBSBrVP?=
 =?us-ascii?Q?+g/udVEdtYRLKJpPpOxsJ9j9yH1Eo2I1yPJQrb0ULrNClStrLUox9qrxsM3e?=
 =?us-ascii?Q?+DkIxELr1EeJqmirVw9+JhoRjDuvBesIts/iSAcUz2FJak1VMlTG5WOyshF5?=
 =?us-ascii?Q?zaKuqZQqCDyG853HvdyOM8UMZdIS4eMqnT6MNErDTcHfkLh8e8i1UgHug8Yc?=
 =?us-ascii?Q?bEsa92pF9wwoDUpCfDKckFvVdJjkJ1PbTilz3WE7YBHqVLpW/kGZLu5ujzST?=
 =?us-ascii?Q?Z6ZNsUxk+10C5r4D3359IedqHMmd/kxeVwmHlCr6Ax6ABY+Yy9oX6INmmOg6?=
 =?us-ascii?Q?lpg0Gl9DNFDOwgBx1eiA6x4uV7yPaz0lGkp04q3CFEYuefZvqfn0bbx+wc9D?=
 =?us-ascii?Q?+7VSIq2TeNllQD1kIi1CK1De8l/6UYgHeAEsk8aCQ+VZXszbCwQCchJ4+pGf?=
 =?us-ascii?Q?uVrUNh3ULajHsAABVsJ8Qi0I15Aj2KFHJr5ZVr2zpwNBJljtK2Zpzrz/9nfw?=
 =?us-ascii?Q?pTJg2HSNuqZGH1HXYSTVHYblm1NJpqePtwC/0iWjNuonmH2GwGcl8SoKyPoV?=
 =?us-ascii?Q?+e0oDuU3KjcAFPYNhRuZhThot9n2qjBb02LcW4BUARimpOQbSKD8uYf5108N?=
 =?us-ascii?Q?NfvcFtCxBeT3SFq2Gh5E4ATtRcuWJfW4adLMxXZAIcsYJ88l4iUwLANMH++V?=
 =?us-ascii?Q?R4wwhPGiGKv3jnQnFkJd6Z6KW7lE1rf20PV2rzkYO/LfbmAwkd0UU5euP9Wo?=
 =?us-ascii?Q?dnNOGJqmpuHa3XXnsJnT5AlHiDcZ6YR4vBZnwe2rvwdHpOPAvsOCRbdy54sw?=
 =?us-ascii?Q?qgHAou2Rlyca/n782WyHq0hvkNNNO6tNtmMP/JFg9eOTzxoj/dReNamMjdvG?=
 =?us-ascii?Q?DIkUfzyi/8TbfK0x8cWKFschtaCGzyKRwRTtWOOIR07x97/bPzWY9ueaABXk?=
 =?us-ascii?Q?1OXosFjed4hqWXZfYf6fNpSw4YkPyDtV9NnedssZd6A6l64kseMA1O1fHKJ5?=
 =?us-ascii?Q?VmODiTMsj4pqE0LIlIY+yviKK/PZM/1eQXfu9Mt05lbCGYxHnDh6tROl7E6u?=
 =?us-ascii?Q?ZO9IJPHt1dIQqp9+AXnMu95YfS0E081iQy+1OMKfPo09s328KeBpVzxNwwcH?=
 =?us-ascii?Q?nfBXbmSTLE9G6w0uZftFxh4F7FZMnut4SOReEipuI0zIKxDfqqfBaMqi29Oe?=
 =?us-ascii?Q?oalmicIYMZNyxwg02rqOM6XZJUgIZ6hAxc7F1yRqmNJbhOVVNfsY958X7OEz?=
 =?us-ascii?Q?L7pRcD0Ibhkj/S6h5fXNb2Vo8jeUAgN/BQ5SczVzAzvAlhv42E/4rcVSuJTF?=
 =?us-ascii?Q?KjDUTYhL+3oJNO0Rt4XabjSE95QNb9pshrKSJ8LOYXC5KOTpqEqmcdxGCthb?=
 =?us-ascii?Q?Te41YIkmGNmpGPjhBEJjB9FWSodHbqK0K44cQw6jq64gcaR7xjOrnF5id9vO?=
 =?us-ascii?Q?Jjwo5dKNMP30ki9rXYGjR6AL8RnFj1k=3D?=
X-Exchange-RoutingPolicyChecked:
	EbO3EVOEyOi/ceSJeQwb59Zx5sq+/Q9lEH1ubAjdnbDmyxk+zFK1FuFPe7qeI3Ge07bRM3P9/vQozWmMGsOJN8xLbQ7xZY7904fc8OJcYrbPInu+gED8ArZAVWN/1/8+zbFLqvfyDqSh8mO6HUOg00W4FpefTxXtDmJNqUN5B2jR4gLBvW+c8rHykSUmQzj/tNWvasW3XO41+6zIxInVzTJawh19pATIRj90J82ZohUzT9a+POw3McOiA3clBLCdtM3TMehIZ8R50RRtehSSOI1zZ4aT6uZNJSHi21wyl/65WTP9AQjh6OnNRjpv4u9mE/kXGp91l1K9CwvcOROHvg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YF6NTa251+D+bb4hoIs4KtuE5PK5ZYVBiTSB1kdFy8tCZcFCxFMozTJvcKajhBPzHjubduz60R28uy3oYVQvxg9jZwWIEOL22Wv4dKyeTze9BChaBpXSJfjuHdKT2ZMAdYFeUeXpObg+Rseq4+oxniY+PhMS1tvrrQ3DK6IUU56e5HfqJtEsT8JT6m0ynZIDGW+vEjTTUQhZQ+lCfx8p5PQ0PGPIQJ7uP/C46Y1NJgePc4d90r3dgxXMc6rMWsvIZyBLipf/n+DKff89/J5yMkcjuVTDay2WJkx4mtVY5ubGu4NPbrdPX5dZ+2o0cCrlNyrmvLQAeMZ0nbsoykWDS4O9qzoI1zNaizaLpbZnIVoSqF3KJfLYZBzrtACdvUumyyp0oTgye9aTjMf4YAOtzSVCvA6teJ3HXMYW/k9/PaTE8SHXpKqhqke1xzN/Yx/3Ld/fj+k2WEJei0t0vZvSZ4axIqSopqahOO6QuLw99SuridDJpI06yQKGc+hwOx8GKxS6sclGngEmpEtRn67X3t6b+sfgD2WSioSXs+n7ArVeJpLT/jEs4IR41IKW8K9/Sb7iA1Wvlcx2KdKp0urRjNe35mQEUeMmveav5NZPLVM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5978b28b-3a50-41e0-7690-08df2b5450b8
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 07:08:44.3330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bY3nIErS6QFa0/qIlD5hZ68ifS2tvpSqRuLP569B/WuBg9Pie7vrmQ9ucvCelaBW5EThvL5CcfA5GpMCWQyZu9kMsNXakovQXmq546INZak=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5668
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 lowpriorityscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 phishscore=0 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2610020000 definitions=main-2610160028
X-Authority-Analysis: v=2.4 cv=N+a8hG9B c=1 sm=1 tr=0 ts=6ad1cd80 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=JfrnYn6hAAAA:8
 a=yPCof4ZbAAAA:8 a=xjBfvZVMSjtnnSOzluoA:9 a=a-qgeE7W1pNrGK8U0ZQC:22
 a=1CNFftbPRP8L7MoqJWF3:22 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22
 cc=ntf awl=host:13537
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDAyOCBTYWx0ZWRfX+bNbIud5eyfU
 lPnyqtkD48o1lhBCFqLMRDjmenki++9s0pU9bH+66a9XhIfuHqc+PFHcdKcQuu/Ygtzvhk7V639
 XzejYru6Muv+malkKGEQgcNa+L7AcicUmR2ypyRXnqsw1YhZ4i3BaKc+bobR+lnkgOgPxRGY08f
 wscR/9T/SDsimItTlYFe6Z0Ot74OoZoyhxkMnoFVGxD6QRRZTVAc7Ks1nU/B4T/QH7LIKfoxJuF
 K2GjBiIYiBbaidqcqI65TzfX4D512htMXmyeBaXAaK0bSHnq4sFaAGPd7f2fQf+8M8Yhyi4opqI
 aT4kaGJxL0JGGpKRNf1cjEYjZyyVeZMmg2ATYXlRAKSsUb5634Z244CHVC2IkbqTwcTVg2kQDxX
 31RkwACzTn27sKQ5jvPdl3Fwq9eQtJqDq/VANN234/ncRv6DH4uNN8zAzHMv5bXkQvGopdORTb1
 9dPKAJ1cV2MvDDDwzacfli+H+L+RHqxqqgIMgC2o=
X-Proofpoint-ORIG-GUID: fbFtcgCCZ3vH3BMbuaIetBd1j7wYqwFj
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDAyOCBTYWx0ZWRfX3/Gcj4D0/aBq
 HrAtjWB68oUzHkG0/wdd5wrgqQlHNFrqqkc0pr1xJYlPlCF2Kb4ztr/MqlmhQ4d4azD4/A3N0Kg
 CI77vgOKPAQjasLLVOpfcU2+t8T1nPwa95nlM732q+bBGhUAMe5H
X-Proofpoint-GUID: fbFtcgCCZ3vH3BMbuaIetBd1j7wYqwFj

Add smp_cond_load_relaxed_timeout(), which extends
smp_cond_load_relaxed() to allow waiting for a duration.

The interface loops around doing a periodic time-check, waiting for
the condition variable to change. Loop iterations use cpu_poll_relax()
to slow down the busy-wait and this, unless overridden by the
architecture code, amounts to a cpu_relax().

There are two ways for the time-check to fail: the timeout case or,
@time_expr_ns returning an invalid value (negative or zero). The second
failure mode allows for clocks attached to the clock-domain of
@cond_expr --  clocks which might cease to operate meaningfully once
some state internal to @cond_expr has changed -- to fail.

Evaluation of @time_expr_ns: in the fastpath we want to keep the
performance close to smp_cond_load_relaxed(). So defer evaluation
of the potentially costly @time_expr_ns to the slowpath.

This also means that there will always be some hardware dependent
duration that has passed in cpu_poll_relax() iterations at the time
of first evaluation. Additionally cpu_poll_relax() is not guaranteed
to return at timeout boundary. In sum, expect timeout overshoot when
we exit due to expiration of the timeout.

The number of spin iterations before time-check, SMP_TIMEOUT_POLL_COUNT
is chosen to be 200 by default. With a cpu_poll_relax() iteration
taking ~20-30 cycles (measured on a variety of x86 platforms), we
expect a time-check every ~4000-6000 cycles.

If a architecture provides a waiting implementation for cpu_poll_relax()
(and signifies that by defining CPU_POLL_RELAX_WAITS) we define
SMP_TIMEOUT_POLL_COUNT to 1.

Lastly, config option ARCH_HAS_CPU_RELAX indicates availability of a
cpu_poll_relax() that is cheaper than polling. Long timeout values
might not make sense for architectures not having ARCH_HAS_CPU_RELAX.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
Notes:
  - Unify the exit path out of timeout and hitting the cond_expr.
    This adds an extra (though cheap and easily predicted) check
    for __scl_timed_out in the inner loop, but allows us to simplify
    the ACQUIRE logic in smp_cond_load_acquire_timeout().
  - use u64 for internal arithmetic
  - document the timeout_ns == 0 case
  - includes <linux/time64.h> for NSEC_PER_USEC

 include/asm-generic/barrier.h | 110 ++++++++++++++++++++++++++++++++++
 1 file changed, 110 insertions(+)

diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
index b99cb57dfccc..a03e3b26384a 100644
--- a/include/asm-generic/barrier.h
+++ b/include/asm-generic/barrier.h
@@ -15,6 +15,7 @@
 
 #include <linux/compiler.h>
 #include <linux/kcsan-checks.h>
+#include <vdso/time64.h>
 #include <asm/rwonce.h>
 
 #ifndef nop
@@ -273,6 +274,115 @@ do {									\
 })
 #endif
 
+/*
+ * Number of times we iterate in the loop before doing the time check.
+ */
+#ifndef SMP_TIMEOUT_POLL_COUNT
+#ifdef CPU_POLL_RELAX_WAITS
+#define SMP_TIMEOUT_POLL_COUNT	1 /* Wait mode. No need to poll. */
+#else
+/*
+ * Assume that cpu_poll_relax() provides a small blip in the pipeline.
+ * Combine a reasonable number of cpu_poll_relax() instances before
+ * doing anything substantial like a time-check.
+ * Note that this assumes that the rest of the loop (largely evaluation
+ * of the loop condition is relatively cheap.)
+ */
+#define SMP_TIMEOUT_POLL_COUNT		200
+#endif
+#endif
+
+/*
+ * cpu_poll_relax() stitches up two kinds of primitives: ones that provide
+ * a momentary blip in the pipeline (ex. cpu_relax() on x86), or ones that
+ * support waiting for @ptr value to change, coupled with a precise (or not)
+ * timeout.
+ *
+ * We keep both together because the objective is to minimize expensive
+ * operations while polling on @ptr waiting for it to change. Either
+ * version allows for that.
+ * The arguments (@ptr, @val, @timeout_ns) are only needed for waiting
+ * implementations.
+ *
+ * Note that platforms with a suitable cpu_poll_relax() implementation are
+ * expected to define ARCH_HAS_CPU_RELAX.
+ */
+#ifndef cpu_poll_relax
+#define cpu_poll_relax(ptr, val, timeout_ns)	cpu_relax()
+#endif
+
+/**
+ * smp_cond_load_relaxed_timeout() - (Spin) wait for cond with no ordering
+ * guarantees until a timeout expires.
+ * @ptr: pointer to the variable to wait on.
+ * @cond_expr: boolean expression to wait for.
+ * @time_expr_ns: expression that evaluates to monotonic time (in ns) or,
+ *  on failure, returns zero or a negative value.
+ * @timeout_ns: timeout value in ns. A timeout value of zero is treated
+ *  as the minimum wait so we evaluate cond_expr at least once.
+ * Both of the above are expected to be compatible with s64; the signed
+ * value is used to handle the failure case in @time_expr_ns.
+ *
+ * Equivalent to using READ_ONCE() on the condition variable.
+ *
+ * Callers that expect to wait for prolonged durations might want
+ * to take into account the availability of ARCH_HAS_CPU_RELAX.
+ *
+ * Note that @ptr is expected to point to a memory address. Using this
+ * interface with MMIO will be slower (since SMP_TIMEOUT_POLL_COUNT is
+ * tuned for memory) and might also break in interesting architecture
+ * dependent ways.
+ */
+#ifndef smp_cond_load_relaxed_timeout
+#define __smp_cond_load_relaxed_timeout(ptr, cond_expr,			\
+				      time_expr_ns, timeout_ns)		\
+({									\
+	typeof(ptr) __PTR = (ptr);					\
+	__unqual_scalar_typeof(*(ptr)) VAL;				\
+	u32 __scl_count = 0, __scl_spin = SMP_TIMEOUT_POLL_COUNT;	\
+	u64 __scl_timeout = NSEC_PER_USEC, __scl_time_end = 0;		\
+	s64 __scl_time_now;						\
+	bool __scl_timed_out = false;					\
+									\
+	for (;;) {							\
+		VAL = READ_ONCE(*__PTR);				\
+		if (cond_expr || __scl_timed_out)			\
+			break;						\
+		cpu_poll_relax(__PTR, VAL, (u64)__scl_timeout);		\
+		if (++__scl_count < __scl_spin)				\
+			continue;					\
+		__scl_time_now = (s64)(time_expr_ns);			\
+		if (unlikely(__scl_time_end == 0)) {			\
+			__scl_timeout = (timeout_ns);			\
+			__scl_time_end = __scl_time_now + __scl_timeout;\
+		}							\
+		if (__scl_time_now <= 0 ||				\
+		    __scl_time_end <= __scl_time_now) {			\
+			__scl_timed_out = true;				\
+			continue;					\
+		}							\
+		__scl_count = 0;					\
+		__scl_timeout = __scl_time_end - __scl_time_now;	\
+	}								\
+	(typeof(*(ptr)))VAL;						\
+})
+
+#define smp_cond_load_relaxed_timeout(ptr, cond_expr,			\
+				      time_expr_ns, timeout_ns)		\
+({									\
+	s64 __scl_timeout_ns = (s64)(timeout_ns);			\
+	__unqual_scalar_typeof(*(ptr)) VAL;				\
+									\
+	if (unlikely(__scl_timeout_ns < 0))				\
+		VAL = READ_ONCE(*(ptr));				\
+	else								\
+		VAL = __smp_cond_load_relaxed_timeout(ptr, cond_expr,	\
+						      time_expr_ns,	\
+						      __scl_timeout_ns);\
+	(typeof(*(ptr)))VAL;						\
+})
+#endif
+
 /*
  * pmem_wmb() ensures that all stores for which the modification
  * are written to persistent storage by preceding instructions have
-- 
2.43.7

