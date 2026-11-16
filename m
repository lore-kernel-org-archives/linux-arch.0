Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.177.32
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794817609;
	b=tlOnbuIXWw/ricnPiAkoSiNlpOiSxy2DUT8Rjj7gEdP6VF82+RKxEM6KddT6jmci9KcX
	 SFiWeqGUxNZPnFHQnDmGW8lsr8QxdeXO8nSZHHnb0jIC+RnPkW2ojmzpPgCTo9NhRMffp
	 3bXu+CsThyGvEOZJwU9gsNCxxLvi+BDk4PQa2JK5HcahyjpKNxAp0CONOXu6QGlNGwQq8
	 ieZ3A6tYsjb5TS4m74t9fh3GrShbXlEjurG1sxozSSUMXN8G6BN9bV85rH6O8964WsFte
	 06QQdCkzQwJkMdc4cVu8V1emR5Jw3exJy+wJvam8K6GBED95uwUXn/T505dc+uDP2zg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794817609;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis;
	bh=Dr6koJaHY6w+qnttehe9IrvMnpYMTB3B9LsEsU3jMkc=;
	b=pb+moYfWFxBAEzzoQdovUHu7mduGEDSWLBe5VPyifSddJIHBzpnmILzCxkzDnMtM2ulI
	 //NKPQoAh/1z1ZR+BbeqNzCWafba7VcJMj6Ihktp4PZv3OeBHgSw0X59vCXOvh6jgdBEp
	 PqQVw/Wcd6C32csd66pZ3NRZrPkEQK/kI4TbzwOEgj1N+i+dJYlI7LLWvi1j76mXbcDbj
	 8Fo8FY1j+7YsPM8mJEU0Ttl5JKBtQkvcFMh0/dbGoztVchtobFkd5oHwoSU0ilK+dTFTk
	 5rcRYvJzqmKtLQLUeM00+1VbX5DGXrOehbLYL56NL9iG4ETBzSM7wDcx4h4fpYQufGA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oracle.com;
	spf=pass smtp.mailfrom=oracle.com;
	dkim=pass header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=YYxQ+hIq;
	dkim=pass header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=rgQ3pshN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.177.32
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0E1606A884;
	Mon, 16 Nov 2026 08:26:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F0E1606A884
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=YYxQ+hIq;
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=rgQ3pshN
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AFNt7lU1174895;
	Mon, 16 Nov 2026 08:26:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Dr6koJaHY6w+qnttehe9IrvMnpYMTB3B9LsEsU3jMkc=; b=
	YYxQ+hIqJt9dp4BSTL8leLZPuw3JqT8J2KXtkHRd0CvxlVB+y6mkGfZUUGyPEuCQ
	LOErpXe2/96taX2FkHzZqFDdJF436dUb/9hgVMiSeCzY8KyzLXM/Tp5FbhW4Vap8
	K2wZ/isqhmwgmHgrygwBhB09H5KNK3f1obyeo35s8unI2fE99lEjpJex+jCuLoeF
	EcUHNB7bRzCdfCIGVPetXaAQVF1pZbKIdtRaSJi7spATvw60Y48DDd5fa9sM9UNS
	0VQHLSv/MMyx4l6QqDNi47aMj4vCzpPlH0C+zfrq89csi5P9HNqTlEuwgco+g+4N
	IQt5UibVI1mZr0QZIOfMKg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4hxg9jsqar-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Mon, 16 Nov 2026 08:26:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.11/8.18.1.11) with ESMTP id 6AG7c5Vs2871229;
	Mon, 16 Nov 2026 08:26:13 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010002.outbound.protection.outlook.com [52.101.56.2])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4hyvt1u5sj-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL);
	Mon, 16 Nov 2026 08:26:13 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I+HiINJiK0v1c2aClximOzZPBmQ0wJLsAtH0aP7R1jz5lEv4DAd3FZeC+x0Dw6V0do44JHtpt8iDwdnPcGZuEGdl2NVOvG9maH39VA2hj2NMC8MfAMERUtuY4SmubqA5CpPARblu99iEwadibeWtvzi5sX+i1bG74PvHgKsGZewsNL9PjXdIvNpfPoaSNpOmQYmqjQxa/UKbg5aMvPju+CCuvyoNVNUaoaiFoBL/DQSHYM6zQVcQ7DnLvaLVoSXbHmkwnHlJEh5Aayujt2CKKLS7vTXeFVszr7CEppu/gHmMgNlFailIJPG1loQ/PMer4UUj7LytyloTFkDz8nOSMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dr6koJaHY6w+qnttehe9IrvMnpYMTB3B9LsEsU3jMkc=;
 b=qBO3NZT3PMSKh8pGKW4cT09Qwe2Ru5kjHugI0A8gtHtaqtW7KVsNe2llfzSPwdZFWskVkem7vmqkbM767AO9jcTt7PUfXcZncJztkJveCYHaf4iFZ+lM2VJCIBNoKIUOvlPmeT/VXToE6PjSsLjqwai9KRAZ4sNXrySPXInO+Od5g0S2xrLkPMez5R5qUbJdh4ybS7lODo+el+I0Jm1bHLJYTVgRBHJHfkKdM5YOSYsTk5BH6mQ0/3iA7HQ8HNMhEx8fM3ydh7kN2H4kFRrxk1w6PaE9OrAc0SfQ11nritzJwaUSNdJmBZ056K4orNwIq1kSUF71qSUtT1ILBccXtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dr6koJaHY6w+qnttehe9IrvMnpYMTB3B9LsEsU3jMkc=;
 b=rgQ3pshNoeFRwcw7zc8xGgD26Ki6qrBw059Dq4CkgK42M5Xs+xkOlUf3z1VZmdhkS+CEvdTD+yVTuOmQQ6bV4akKpGTWe2fqY0RiDqwFZ8bP2AGjiQFJlencNsDZ6j5DxhWw6DuIoakjpSgw+EJ+Hy4ePpmzsjnGhh8ojs6/SHM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by MW5PR10MB5764.namprd10.prod.outlook.com (2603:10b6:303:190::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Mon, 16 Nov
 2026 08:25:11 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%5]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 08:25:11 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        bpf@vger.kernel.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, sahilchandna@linux.microsoft.com, cl@gentwo.org,
        ast@kernel.org, rafael@kernel.org, daniel.lezcano@kernel.org,
        memxor@gmail.com, zhenglifeng1@huawei.com, xueshuai@linux.alibaba.com,
        rdunlap@infradead.org, david.laight.linux@gmail.com,
        broonie@kernel.org, boris.ostrovsky@oracle.com, ashok.bhat@arm.com,
        Ankur Arora <ankur.a.arora@oracle.com>,
        Julian Braha <julianbraha@gmail.com>
Subject: [PATCH v17 14/16] barrier: add tests for smp_cond_load_*_timeout()
Date: Mon, 16 Nov 2026 02:24:35 -0600
Message-Id: <20261116082437.66739-15-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20261116082437.66739-1-ankur.a.arora@oracle.com>
References: <20261116082437.66739-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0129.namprd03.prod.outlook.com
 (2603:10b6:303:8c::14) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|MW5PR10MB5764:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a250762-8d34-40c0-b953-08df43bb21b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|10067099003|56012099006|261026140227099003|261021123027099003|261022075727099003|261026121527099003|261028144727099003|261102123227099003|261021121427099003|261022105027099003|261102130727099003|261009223027099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	akeDVWfunvs5RAKLwIS+KOFesF8IJOT9xMJmM22pmpt8mGFRcf9memrlrzIvQxcxIXgwaubkpCtDv+Vpi9jl6Ceru2wckcBv+ffWfb5NGxdo6YhmxyKVXaNZXMJeQgprHj7l0wrpdHZ5u1mTOQz1aT/k/rE8u86hurHUCEsPnBzFE4cBPVcyjCpuRUcNXQyd55fs5gUF3WFntwOqyBRE2/yLERI5QeRWnuUYkChYLw1f7KjDENJQKkEIJ1P4P3mN3XLpr4AnIYc7aYnCvxCjtlyN1U/e30TzhHReu+MixgFsbuBJSGQJjxeMyg87NJt+CGqUCddCGZRB/Bjp4H2mTSqVhh9RphQlqzP/hwHSp/9MH/X5kq+uBXKBn1cowkqPMY8ALs+8XIX2rC7Uqyq0Law1FvPnUqpqeGGhKnqa4Vn5bDWnknBkM1U5hMsr2RjaCuNaBWGK4yKYQkFn8eQqCj2Lst3h7JkGTksNTxHprKIpFKL3pQ1X/aZWC4Nx6iyMIUy2n0LmAoeiziR3ERkDn/ONWlOiGvj7tBKgFvmvdMoRvVjm2Ee4BWso57UV/AE7qOGqdOBK95vQY9ef1iaCxmyOUoLRflB2ibbAwPCVPYfBPsAeD+mFkFq6TZJpoFwgWcIaewca3MQ/+lsNhMG79eyMrxEBsmpCWfImBkO/1Eo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(10067099003)(56012099006)(261026140227099003)(261021123027099003)(261022075727099003)(261026121527099003)(261028144727099003)(261102123227099003)(261021121427099003)(261022105027099003)(261102130727099003)(261009223027099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d7gWixlYrI8sFD4TT9Q2laT1uq10O/sc1UhpXYUn1eKiOABS8ExE13QB6F3D?=
 =?us-ascii?Q?9KaPVCe11d3UqXHbTTEN5sZrYGR+f8wWEvmJnr2fWpqOzZOl+mW2FM1x226O?=
 =?us-ascii?Q?Pk4c6Lxs56240iQvSiyWxSuXQF5qXE5RaHJQ8slnyn4ixEGVm9kSNXwmiTes?=
 =?us-ascii?Q?/XgHJohhp4Lp+n11NMF6oH3NPxCx2tNNOJWBYkt675Bc/s1cW+v/TlzyCOIc?=
 =?us-ascii?Q?PxMfB95zT+wzgCfeQ33mKZCkQ/5PJHtfeRjXPNf/FI7qRxfjOnCe9Zn7hkoC?=
 =?us-ascii?Q?4WAGuwZUgMqicENFVW9z3hcCFsggdAAH+01cvTRcLzSYXnF++7QJJ9dt6z9H?=
 =?us-ascii?Q?YYOvljXjbhSDJZyr8AHkbglf17QefivIlg7T59YGouRHUrS89DJTqlQ7en8r?=
 =?us-ascii?Q?DkWIWwqwF5vy0ErSpechcNtPTIwXZ5ba0Z9j2TttlPaTjGDoMOqR8rvUEFQs?=
 =?us-ascii?Q?vMw97PQfHu7Mp4GPIYXBvFGtHWj5PjD1YOO97abVahPuCm6K8FOCttxvAwUP?=
 =?us-ascii?Q?yzT+rTdgLXoS2gxXpisD88EdIs+f9K3pJtOZ6VLYUYCdHGPfoMbpkk6V2R7R?=
 =?us-ascii?Q?/u2rDdLnbbLvyPlBauwznr2q2LW6udqsKXLXf7MspdqS8NPZv6TdRuXSzUcJ?=
 =?us-ascii?Q?IYgegGgzZGAC4jJWn3neGAQ8r09WQjbxrN0lHfrsjnr7kyvLMw7XDNNwyeoK?=
 =?us-ascii?Q?0HoXU9gYpArsXf3SWctt8Ue1zl23MKGfepzHohGzzWNBP6wTB6s/mwMIEw4X?=
 =?us-ascii?Q?DbDEvYhU8yNfiVW01LUmD1jJl0O3aX21+a0b9sHadHFf241kHTh3dve4BYRV?=
 =?us-ascii?Q?gBeiuAJmfe8TUsVFS7P05sMTLwKKYUEoiLFfiiLOtAuL540ukhPSlQQtn2IB?=
 =?us-ascii?Q?mNuB6ldAIzMgyzaoL7LPy2aQ75MzN0vO5V9wr+iHtoGn+EcHvUkExuayG9RO?=
 =?us-ascii?Q?RAWNXkKWlkKnQPU7szKzDkoIQ2bDIuqiAqPCqsMPBJSirtRvSJzi6AiH6vd+?=
 =?us-ascii?Q?QVlP2yWXJDxpq+ZChEcm6obKKCCw50XCYT+mjaX4WA8hwnlapi2h7mxpXxYf?=
 =?us-ascii?Q?UFAj0UrtOUTz6rcOptJ24vACyU6606wzVCaxEvJTvy3Q5t5I1hPeXdj5Ly0O?=
 =?us-ascii?Q?rzdCqmZT8Hojn8tHqCjCnZ0E2fqM6sfxyT51ylccuZ4UX4q1QtWp2kAjI0QV?=
 =?us-ascii?Q?FpaaM9fnNbNo340jXr5WUyVhmmORrTUJydDTeAuMRoQxdCHuHJbwL4Hpc6oy?=
 =?us-ascii?Q?ydBeGhfASx1ARbcdcvxE7B8fatDnqOTASGXcHjltCtqhRF2jHwmOpcQrhNFb?=
 =?us-ascii?Q?DRvzF2qrlNv4nrMdpAsBci0gFXZwRsUKI2RKCheE6rAZEgTH2cQMP6LPN/V8?=
 =?us-ascii?Q?X3OTL3TzLzOhd7sDoC67KVaLAjYsnh8NbILjtaTGTNiyFvF89wbP+uFpCxVh?=
 =?us-ascii?Q?QY3Dxu2h6pqIhwJ1he3EydvVvkqvGsDLISHrHHCyHKYFu5As89ShDb0rdBSK?=
 =?us-ascii?Q?yJPDMvQczCIISlm20Ar2EKhhWDFhk8juVS42+QnikWqCUJM65xXq+P3kbziv?=
 =?us-ascii?Q?Jg7D6zTexXSL4k5xY9UtKjW1hlL9EItUohAgPUZvCXuh9fLXOuX3H1GUrANY?=
 =?us-ascii?Q?b+winTvBLtHvss1RYy6IvyYWv4WDwezmPweCq/DfB8ThHt9uEq2kig0OVKiZ?=
 =?us-ascii?Q?jcgy5fnlqAkzPj64n6g1Byu0Ws1PsVs/iA54fRKNdbxcr6r5FUaC5YQ3Q9AU?=
 =?us-ascii?Q?lU3aDIPgRelqJajfX43Buseyks3dLbk=3D?=
X-Exchange-RoutingPolicyChecked:
	uwj+UNUTXGyFdgarNCpQoQkKRlHww8WL386TxXV+N+4Sa2ElGg6CQvFQMk7VkMl573UURyFt0wFewpyWtHFKEIW78cuzzdn1kFGiN3Q5Wvz/I6mxLqBudT3snGPIK+aKh51EFMSLQnCxydMj6Ta9YaoA6Fn/97v6ebp3MZ1uSOc0jACeywXlvoKrT+AcN8e/acRaSSNRsPkjXM8pk+nG/24O4qfUrPrkfoNT+M0E67KYQ6SDJzIRtGkQ78huuE1R7VjefABi+/bkDOFBqG05prZhkr19yRSghIvhXoLmkKqiNdeI/NBMRPxBw+LqOvoeDsb1KoTWp2PLCxLpTT/yEQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GuPWrIxY3yZTNHcwHcQ5SPc5KbJABviJH/SDcy+e2nhEzuw095x5q2xyqzU9cck8qKSklAGKmilwbE74/3k51tCajOE/nW7gg7IE6XSFpFjNVMsQeI4/hn48CNiKCswQ0Pay+2fdjCWV2mzklPhZhDntkgXP+t3c7SeaTwGRf/N/nudsdnJfa+ZEewQKF/1s7JVmKPd47URgWBY7v/yC9gNRN+EvoPD8fME3I4ni+VmemqpoNTxokl6+bhgQ0yy0zH/T7zaTG2RUOAzOo0bLIKwFNrvao2rNgn/OGUH92k6rACZ3rX8sQQUwLQOlJU7DoQOAyIlARm6rVQcH29kQw6WiqKEeCk1WeTHh6awdD0m4/GRE3y5nuLSRKdiSbXzsriOg7chYWW4bU7F+qCdD9S+R+8AFj7MgKxdnuYwz+lT12j4866MDgVF05OgrMOCst7eUu+cxatWHRcIshG9JMLejHu1me+uNfOo+uH2RtJFOb+btZBNgXeHnqRFGw5m7e4UYjqXQPfbyUjTruYmKyl/yu5oPjqRalV1/o2JmEicx5DIkj+RoAiBA7FcRq7Qa3mgx1DoUcJxVcntg0rib50SOykxDGOY1s99VN9h4VVQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a250762-8d34-40c0-b953-08df43bb21b6
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 08:25:11.4626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mDJG8Bt5z/yKSj09te3dVP/TUX5y6402fJnYtJuPc6/C0hbfwxMV8URpPao9BzBdc8jIGTW10SNZonn75LUEqGCN16C6lhacg9fsT4Ut3ZE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5764
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 spamscore=0 phishscore=0
 malwarescore=0 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2611040001 definitions=main-2611160033
X-Proofpoint-ORIG-GUID: gDIkx_bCOReFATT8YqEGgKRqLzZH8GAH
X-Proofpoint-GUID: gDIkx_bCOReFATT8YqEGgKRqLzZH8GAH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDAzMyBTYWx0ZWRfX6BgmJUINoWDo
 mNWwH0e187xfcaeglFWAvJisOkPUUZrxdVkQvBpXBKNhHVCS8SEtzicEXUrxPMz/ZPYAvM8I5Vw
 czBVRjYwhCJDhhDPHSdQEswlMhQYHGenReurxcUJqvkcjkCWEoRcva5vxrEgTzrguB/tnqEJHGj
 qe2FhEuTaKt4FxeKDSAerrQ/oEh+Hbx4XU/DCf2gB4yTDPBE6nUqrHkFSUNjcIQCWAyTnY4rfw3
 mUPNcJJ5qSd6DC7Ae66LAU72NAKSi8q9dv2ZP3k6fGKJbVkDvLATxLOgdz3o6bXwUgm3/YlhbHF
 VIp0K1eRlVJL0hZdCCbHwV11e3sdrQb7iycxWQRgBJzlIvt+1DwnIDPPxoPC+gz6kKUUfnl3+Nn
 504HhwLx3pjywCnQec1Mga9ho3B4Bx2YsAtAwIfl3HwIIPeWOaEHbZusrbgDHI44drs7SKowL7f
 0Fx9wORHVIUB4pjqPVQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDAzMyBTYWx0ZWRfX5w8OvcghgUv6
 MxUtQneCYAZbHPQnsR3AkVHmwhHG16gpnfZxCHI4eJusLwFdKhSTNRjhiV8kf9ma/edYtyWD2lh
 s9l/I4gPwcRaaeZzIVNftl6DG/5SpaaG+Vnheo18nuvPLn0SwiaU
X-Authority-Analysis: v=2.4 cv=DMoacCNb c=1 sm=1 tr=0 ts=6afabe26 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=pGLkceISAAAA:8 a=vggBfdFIAAAA:8 a=yMhMjlubAAAA:8
 a=yPCof4ZbAAAA:8 a=ckGIJSXraPChYtHAjnIA:9 a=WmVTiCyuxqgg3mnwYu6p:22

Add success and failure case tests for smp_cond_load_*_timeout().

Success or failure cases depend on the expected bit being set (or not).
Additionally in failure cases smp_cond_load_*_timeout() cannot return
before timeout.

Cc: Julian Braha <julianbraha@gmail.com>
Tested-by: Haris Okanovic <harisokn@amazon.com>
Tested-by: Sahil Chandna <sahilchandna@linux.microsoft.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
Notes:
  - rename barrier-timeout-test.c to barrier_timeout_kunit.c

 lib/Kconfig.debug                 |  10 +++
 lib/tests/Makefile                |   1 +
 lib/tests/barrier_timeout_kunit.c | 129 ++++++++++++++++++++++++++++++
 3 files changed, 140 insertions(+)
 create mode 100644 lib/tests/barrier_timeout_kunit.c

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 2d22638ec13a..dd9bcb0b539b 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2556,6 +2556,16 @@ config FFS_KUNIT_TEST
 	  For more information on KUnit and unit tests in general,
 	  please refer to Documentation/dev-tools/kunit/.
 
+config BARRIER_TIMEOUT_KUNIT_TEST
+	tristate "KUnit tests for smp_cond_load_*_timeout()" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  Builds KUnit tests that validate wake-up and timeout handling paths in
+	  smp_cond_load_relaxed_timeout() and smp_cond_load_acquire_timeout().
+
+	  If unsure, say N.
+
 config TEST_KSTRTOX
 	tristate "Test kstrto*() family of functions at runtime"
 
diff --git a/lib/tests/Makefile b/lib/tests/Makefile
index df0537e1b91f..a9c644cb6d78 100644
--- a/lib/tests/Makefile
+++ b/lib/tests/Makefile
@@ -60,3 +60,4 @@ obj-$(CONFIG_RATELIMIT_KUNIT_TEST) += test_ratelimit.o
 obj-$(CONFIG_UUID_KUNIT_TEST) += uuid_kunit.o
 
 obj-$(CONFIG_TEST_RUNTIME_MODULE)		+= module/
+obj-$(CONFIG_BARRIER_TIMEOUT_KUNIT_TEST) += barrier_timeout_kunit.o
diff --git a/lib/tests/barrier_timeout_kunit.c b/lib/tests/barrier_timeout_kunit.c
new file mode 100644
index 000000000000..63d82f05ca59
--- /dev/null
+++ b/lib/tests/barrier_timeout_kunit.c
@@ -0,0 +1,129 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit tests exercising smp_cond_load_{relaxed,acquire}_timeout().
+ *
+ * Copyright (c) 2026, Oracle Corp.
+ * Author: Ankur Arora <ankur.a.arora@oracle.com>
+ */
+
+#include <linux/bitops.h>
+#include <linux/types.h>
+#include <linux/sched/clock.h>
+#include <linux/delay.h>
+#include <asm/barrier.h>
+#include <kunit/test.h>
+#include <kunit/visibility.h>
+
+MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
+
+struct clock_state {
+	s64	start_time;
+	s64	end_time;
+};
+
+#define TIMEOUT_MSEC	2
+#define TEST_FLAG_VAL	BIT(17)
+static unsigned int scu_flag;
+
+static s64 basic_clock(struct clock_state *clk)
+{
+	clk->end_time = local_clock();
+	return clk->end_time;
+}
+
+static void update_flags(void)
+{
+	WRITE_ONCE(scu_flag, TEST_FLAG_VAL);
+}
+
+static s64 mocked_clock(struct clock_state *clk)
+{
+	s64 clk_mid = clk->start_time + (TIMEOUT_MSEC * NSEC_PER_MSEC)/2;
+
+	clk->end_time = local_clock();
+	if (clk->end_time >= clk_mid)
+		update_flags();
+	return clk->end_time;
+}
+
+typedef s64 (*clkfn_t)(struct clock_state *);
+struct smp_cond_update_params {
+	clkfn_t	clock;
+	bool	acquire;
+	bool	succeeds;
+};
+
+static const struct smp_cond_update_params update_params_list[] = {
+	/* mocked-clock updates flag inline. */
+	{ .clock = &mocked_clock, .succeeds = true, .acquire = false, },
+	{ .clock = &mocked_clock, .succeeds = true, .acquire = true,  },
+
+	/* basic-clock doesn't update flag. */
+	{ .clock = &basic_clock, .succeeds = false,  .acquire = true, },
+	{ .clock = &basic_clock, .succeeds = false,  .acquire = false, },
+};
+
+static void param_to_desc(const struct smp_cond_update_params *p, char *desc)
+{
+	char *clk = NULL, *update = NULL;
+
+	if (p->clock == &mocked_clock) {
+		clk = "mocked";
+		update = "inline";
+	} else if (p->clock == &basic_clock) {
+		clk = "basic";
+		update = "none";
+	}
+
+	snprintf(desc, KUNIT_PARAM_DESC_SIZE, "smp_cond_%s_timeout: clock=%s, update=%s",
+		p->acquire ? "acquire" : "relaxed", clk, update);
+}
+
+KUNIT_ARRAY_PARAM(smp_cond_update_params, update_params_list, param_to_desc);
+
+static void test_smp_cond_timeout(struct kunit *test)
+{
+	const struct smp_cond_update_params *p = test->param_value;
+	s64 runtime, timeout_ns = TIMEOUT_MSEC * NSEC_PER_MSEC;
+	struct clock_state clk;
+	unsigned int result;
+
+	scu_flag = 0;
+
+	preempt_disable();
+	clk.start_time = clk.end_time = local_clock();
+
+	if (p->acquire) {
+		result = smp_cond_load_acquire_timeout(&scu_flag,
+						       (VAL & TEST_FLAG_VAL),
+						       p->clock(&clk),
+						       timeout_ns);
+	} else {
+		result = smp_cond_load_relaxed_timeout(&scu_flag,
+						       (VAL & TEST_FLAG_VAL),
+						       p->clock(&clk),
+						       timeout_ns);
+	}
+	preempt_enable();
+
+	runtime = clk.end_time - clk.start_time;
+	KUNIT_EXPECT_EQ(test, result, scu_flag);
+	KUNIT_EXPECT_EQ(test, (bool)(result & TEST_FLAG_VAL), p->succeeds);
+	if (!p->succeeds)
+		KUNIT_EXPECT_GE(test, runtime, timeout_ns);
+}
+
+static struct kunit_case barrier_timeout_test_cases[] = {
+	KUNIT_CASE_PARAM(test_smp_cond_timeout, smp_cond_update_params_gen_params),
+	{}
+};
+
+static struct kunit_suite barrier_timeout_test_suite = {
+	.name = "smp_cond_load_timeout",
+	.test_cases = barrier_timeout_test_cases,
+};
+
+kunit_test_suite(barrier_timeout_test_suite);
+
+MODULE_DESCRIPTION("KUnit tests for smp_cond_load_{relaxed,acquire}_timeout()");
+MODULE_LICENSE("GPL");
-- 
2.43.7

