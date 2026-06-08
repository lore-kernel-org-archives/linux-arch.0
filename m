Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA8039B960;
	Mon,  8 Jun 2026 08:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780905955; cv=fail; b=U0GW6rSP3rVpAPswd543yUdqhJZX48k09BikG/t0SRwEEAR/XxgGgPaDxy2/LQRof8MCGB58bci+hMPR/8MKm9vdjymhhTP+9y2Gl8RmlOK73KhGO7uuHAsDu7G48mtdeJSwmv8IXCNF++dyVTpDOehn5dXyEnqLev+CggdhQmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780905955; c=relaxed/simple;
	bh=lIvdq2ptReGCR1ITHOBzKBm4LMVb1Gv7EaE/NdSPZUc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i7Wf89cO1WcaQ7mLVTyAjdu5oP1dgQPBvjEJY7mDnm0stWRoQtymVze5DHTGL+TvsjqC3Z92yg9+lIXxb+ICz09etByWVJsNCL3Hlx4vuaLeaza5e5Bew7Cp3CO6ZCPEs+sed9Zf/BBVHjnyKSgQ1Scmkd79ZNlEP1/RY5HIvUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fm61THky; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oF13q8x5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fm61THky";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oF13q8x5"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 657NXGJC3617585;
	Mon, 8 Jun 2026 08:05:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=tuUS0TFhzqO341CoqvioBpprDqRr6Rg2beA96f0n6C4=; b=
	fm61THkyLUpi0i0EjiV+LIVdmXQUSutXEhgI1f18dKYm9CNF9j1IQk5yPkliPjv/
	2loMuP/oPlraboP8aEbSPPD71tiux97ZifIFub90fY+ZOwlwHtm6aQuZ2Uzajc8E
	IAflwhiTDmyRfHEGRK6y1k71l3+urgG7Vrqyv3BAf/fdaNzPmqd68U8dWSSHsmlF
	v7IFU67lC2pXujAklywKk/J+4GFIbpCRJ1cz9TLBY/JQ2YGXzvhMWCywnG1EIaIH
	OJ5GR4NOpgy8BkdsW23u55u025G9lje2r2vy2K45MGssR/psClWY1tONy04bWrA+
	vlbiAWErZNsMChL7l6tGQg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4em9yba1cv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jun 2026 08:05:13 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 6587wNn6026343;
	Mon, 8 Jun 2026 08:05:12 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011069.outbound.protection.outlook.com [40.93.194.69])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ema0d2dc4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jun 2026 08:05:12 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e2ZuEyZRJA5P+sBQ6f68iS0DhPide93058/2IgLQUtjxCQJg6tqZMZNto6Gj9dqRzklPCsK5xbYboWljYuJMLcGhz/f/x6CRW2JaYBWN9tvex+JQBOKos1HvvTd3/qvifBKJnzQqFq82pj1r4K21zTzq03ty22GdOzq3Yqn41trtWa1bZ2dE2ejw6H2IvpPw9wyOtHO9QN8xuL8Bcdyi+QL4SvqqDPIC4+bEm7o+080G5SrornPbG4jdJ6i4S1TI08iAVgGujUA+eiEBv6fDSKiSdcrOfVSNQTDJAEwXHlk7H+PcCBVtM4Zb7oEW3iH/swqFoZOVwFsHOfMcbFBl+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tuUS0TFhzqO341CoqvioBpprDqRr6Rg2beA96f0n6C4=;
 b=jBu431SXgcmt9h4isVap4vCUlilqNRSktb/iJwMoZbMP8B7hXmvjKe3utdHnMGdRnnw3+kqvzBsFB/AIr0NToMCFP7vVL4QDr6rWDGoXXJatmgj1hnb2ATvdWQpfKGSJkqF7lJXTSptOtHt/vubGL78v8Q3WJDWkaQJuLvyyVg91FBsiXbWKf/Rf4PvNFKYoEH/kBW9hNM65FTT6C4D/8fFzFejxLme+/ov2Mr7mOwW1N1/Z5Yl+LgRoM7SFhstV1a8ZZQZTv9sO/ceDqWprN/pko/iEJzyWrAMJPrf+zLhusieJgM8zEYqyGEAIDuAC4k/bfYrIoDK1OfTC3GGgEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tuUS0TFhzqO341CoqvioBpprDqRr6Rg2beA96f0n6C4=;
 b=oF13q8x5Mg2UqIavop/PIyTq5HhzSIP156I6hrR/uWcL5FvCRQz1xzAu1WvykYrb5w0v10jc3r/IBv7fY2QZjYkVv8Yb25N7r/KjKliBkQKmOUODz6hretOasa0WaL43rWihZC4ZETJKeEDfoWpAdBV62ZglBejEOkYynN6z/SY=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SA6PR10MB8133.namprd10.prod.outlook.com (2603:10b6:806:436::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Mon, 8 Jun 2026
 08:05:09 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 08:05:09 +0000
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
Subject: [PATCH v12 10/15] bpf/rqspinlock: Use smp_cond_load_acquire_timeout()
Date: Mon,  8 Jun 2026 01:04:35 -0700
Message-Id: <20260608080440.127491-11-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260608080440.127491-1-ankur.a.arora@oracle.com>
References: <20260608080440.127491-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0320.namprd03.prod.outlook.com
 (2603:10b6:303:dd::25) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SA6PR10MB8133:EE_
X-MS-Office365-Filtering-Correlation-Id: d1a61949-4579-4326-c604-08dec534a878
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|6133799003|22082099003|18002099003|3023799007|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info:
	Dz06Qt56whGRIUEdnOWAKvkklaegLj62eUV0pfb7Xy9FuELKfpYyiVrBHSNpxmZJ8JONsLJW3N8gzY/1Rcxoo9uVzwR9GYs3NWIThqJNo4rfLG//1GrJkBhj3JTMqwa3LsTwxSTvi6hx9rOXOTGMg0H5kvcypnX4bl4t7qqO01j2bc1qJh497zpjnIsAUK226TFICnDmtHaJzkIloY9n/DGss0Zd2dO5HJOcHZDmGSObH1nZrf6PwMcWNMhoW99WDaLuDbDj7IOMR3zK40JtTDOmOekG6V0Srbx4v3nN0LWw27lU9DKv0CGag8JAY3wEuct7PQ0P7zqzhU8flwKE8YcZtCdW/SvoS2t7hMVp9LBLaD2mOu+bTdwjjjrm0qfjrbvtTcPj1drow28Q5ma9rYQBaWfvipMxHHf4atFWttR1PaSwfkXfxk1zdhw48Y3riOBFz1T1YzuYqW4nYBTGtv8hzm5o8/Du/MHt6UwIrSDsrK2Ra+lv6U81BWj6drdZaJr657OWVUIPuNwDnetQxR3uWDO8UjbiySXKBl3W+ssuXufyLXrCu2h2GUOBw9gUsq3avqitmXqjZK/Pt7uPa64CWnJDGAwebc/T+0nWn06sLXgQ+B3o4VgEoOoOJjsoNJepseNYmNgsH1dfJfYePaCVLbrSuec+HKqLQVkV3DN2HfhvPbdP09lQrhEwLQ54
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(6133799003)(22082099003)(18002099003)(3023799007)(56012099006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Kb0T0dWyankLOirU8Nk7CjxEYmI5zLfHSpmDNtfaeSF+WhnbNLIAF78cUjKT?=
 =?us-ascii?Q?CKrScJ++Zd3PKgV9YWyHum72+Iw7dfJDEvlWZtorkvRypZCj0auT7lh9pZ4A?=
 =?us-ascii?Q?tO6XlCQYNYo8Aeb04RpUw8SqXJ95DWf11PNfLJ+iHb8aA8d8oPc7SmEWbF8t?=
 =?us-ascii?Q?6kQm707SCBjaAl+OkCF+fIPfGNLsisUzfeuXI3QMkxb+uwrEvSDkWXLw+jz5?=
 =?us-ascii?Q?9DNfihJz8BCwaGlwVlxVKNQu4hKfcPS3z64kNgBSCTxaJZGpajVoaKeXDaDg?=
 =?us-ascii?Q?TQuem5xpCtcVv8pflHgGB8/gHeHZjS/SYZMFoqBqSptpaUiFuqTi8MBbHwm9?=
 =?us-ascii?Q?Re4NNQhj9dQVfZrnfoFLaz7l0F+8mac79uXClmWvptKMb/OP7WTzfpccZ5eZ?=
 =?us-ascii?Q?RBSSAJTFkCYh8JlPh6hyenwZXyshpT2c1sn6yhXSfaioatLY/o/f0oFMLsJU?=
 =?us-ascii?Q?x0Png2QUjn56b176lSQSWSgztjfdksJZFuz5fWU9E/s2RHJkHJGyQds2V80s?=
 =?us-ascii?Q?qsY5l81Ei8BtNsVA0nWaKvrSSoc7zpR6/dXCMMnDn0Jb7ZGGUmqCOaYL6/Wc?=
 =?us-ascii?Q?DttTEslaGyolWApk7iP8U1xhM012JiRhHoH0JXLRxMtCOThcPjT2e9qZSpsX?=
 =?us-ascii?Q?FS2UWJO+r0iXCGM++l++UFlP2wb6Qi91/a/DyWyVeuUdgi9RSOdNlExcJYL2?=
 =?us-ascii?Q?gd2VYiUB2sEByca/34UMmIQcJzEZBfm2M46JJntkBw7wQaf3RqLfCfeFQNMm?=
 =?us-ascii?Q?reWjVpdo8p2gY3kCWFQJagU5zzUxQVqzTcLSldvVs0tL4Kx8hQlP56OS5UCN?=
 =?us-ascii?Q?fS/9j5rAxMd/xFVU9B4kRq4dElPoJKUJfRb63tKEj3GxBIXrZsKzJS9jt6nD?=
 =?us-ascii?Q?5fYYbmYFZ6mcbBivV95ROgtZamppljewSDDBW4b+78PbXqISERRcsMcCPCbj?=
 =?us-ascii?Q?vW637H+mBuMlK+qsFh+n+VbgWNA2WqT86iw9aqKK9qpMGdmZl8YDHC967GM7?=
 =?us-ascii?Q?JiGGjidftFOu3QM33S88qT09GXpIJvT1opb9cbMbLQcEIKhp0XZCEEGDD193?=
 =?us-ascii?Q?fsc1L/dcAkqLYeoAi3UUcSuYnbxFzkKM94FaE5PPmIicqmkOxT6Ih9T5qHfs?=
 =?us-ascii?Q?/QtxfYn76qur+MNMXzhsywAM1YUyXwXcuCtgNi8AuvbQdHL+PiD5RmRZ5r9V?=
 =?us-ascii?Q?6EMYeYTo1E230B3iTjf61qpNS7BrEnvwLHkuScp4uu1hKu8WYBNbrT8PPN3m?=
 =?us-ascii?Q?6JVsNabil3xBqGc3qW/F/jPZ9eRdYkPMMZMNMdKssE+4Cg+XvgCxrDErx8y/?=
 =?us-ascii?Q?mCTcO0C41MeO9UiuwFVSknlVtxG9jqmr8ttBs6PHJp+X5MQF5nxvaSTjddDM?=
 =?us-ascii?Q?fb79NlDfZ7vRIKZDJx3uMB74saPdCWMl4+Xgivq5UKQ1yLvhBSjp5w/x4SkE?=
 =?us-ascii?Q?R5wY+dmKU8xGcjLUcBI7FvlOjW2mtsD1hqY5FmmFZle9GlNXS1Pr8JXS3faf?=
 =?us-ascii?Q?2MdsyLaPsgwyfUd0/sk9IcfHag6FwIn3hossjquywtc3w0EJKEdFb5W8YF2a?=
 =?us-ascii?Q?E/e6cwBB/es23CMwrR8ZiIn6w+xPFTG9HReuXACvtpYo8vJs06pq080Ij3tm?=
 =?us-ascii?Q?d5QBZxvJzhxO4QRu5289L0G+3YUSGW5JLk9mEmCummgFx1vdiRlCFT1n620E?=
 =?us-ascii?Q?C04fWpjnIDSdfU1tGiTdib6RjZawx7bpnQQkgNbCGi+UhXz1mIsbM1woxdQ3?=
 =?us-ascii?Q?TpA15y+270eCHalaqL2hLFJZDGnf7KE=3D?=
X-Exchange-RoutingPolicyChecked:
	WxnWnijRue5QBIjYYTopiTMi7h/jCMYoSgof9TH+uCukCEsZLraHn3/1mRQnO0qff3qtGYtWzZ+Pjv6PkKCfB0vB13IHTB5pY8BpOipndY0XdZsBlPn/1EXcWibtTQAW/oixkUJiol39UZK1pcXWfRmvAYLN1CntYLHDLA3vRvFatGjqr3sbhl7NG1LG88UOUOIJb41vBhJHRiEE+BjKtTLzJWz74efogNmXY+dkOC4BW139hJKm4nnt9NSw1/f3ZAq5nKPLHqVtJhKBk9rfwotEuc5Na9/WiQg01hnpM0qntcgLpHhEmkW9wOzHqIyp0K6AVBC9MeCttzdNtVud+w==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	O0DkXCrhK8YmLsDFtgQ46tOWU13YogGePHYMHA/Pyv/B4A0MuJ/AKaEz5wX9D8JkEv/2nCAWNF9sPjSNLm+869y2rgVRm01RtPm2Kxu4LzUA5gTiNfMeNkGeOil+wceQkWNFHJ61U6EF4pzzgRFsGwtczWNbwKhCsHC8nMl1b51N1QNhcPf1z4nb7R0Vt6rjpwmqimR9v4RMOQZFw8pcwO5kc7FogVWyw2PGXICsb24+Tz6bMjE/USUqzXGyc15ildYeJYqKm4A2u+2uMOiGH7k8/OYIK2aCW/tpK9KYsHAbaHxwRqrKbBsNLEDl07HwNItVRMHOpyiwAE/PWD3NGioGnKoRyOvY0MgX9ogAZJ9aJtbQDbAt27T6Ydu3NwLVsjLOZKTCXfjpihppJL5vvBIDbc03JyoGtF4d74KAmK2ADh36BF9gPMG2sd4xSURHklt94sE9SUo/Wput5zvmHDqNvQUUqLx5zlKEUlSPolT+imjr2+LFNNL58UghucA+mRWYYl17aWZ85O02b60HN6Kx4gFLQ8pjByJ+4+sFfGy3GqtNuX79ClllhHUph4dYGXhG4v2vTy0IS2RSMVbkYAwCkglWU6rMzaissJo8tSA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1a61949-4579-4326-c604-08dec534a878
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 08:05:08.9902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5WTafLJXA/Pb1A1ghr/neFYxgWmxi9DSyfhKWFd0hUlFkHLDvlEOslwV2wYUMVpYEKJKqdoLtGcI/+8dhT4x3QGVxqCgoXSqQGxEREsrhBg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8133
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 suspectscore=0 mlxscore=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2605130000 definitions=main-2606080073
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA3NCBTYWx0ZWRfXxMYksVsBn+rJ
 svZJ4QUnFAI1wXGvVaIX63/oyZvmw/Dd+GKp2fdxur0q4OGe/LvB83OeBjB8GlUYr+jLLF7nyag
 W4r51YlH2z7us50ifCQ3P9ffp8zRpx/2C1tNKegug7ISGI6C+tgIhN2oBjYGBrCYb/DD5R16DbK
 kIfXus2HMMapKxQnkav+GXHCVdAARTByF3tC6iuhi305nNmoYuT0UCNbuWU11UsSito4wOAJepM
 SzoFTXPo6M5BjQcDgYEnAv0E7kJ975g86QBt+pr5Z+CtPbKre+MD89KPrQhys+3+BrOWHsKX+nC
 yDhAn3W2FTYuXgP4BjtJ1c8DuGNPea10ZMGQ7rKT+IXRxTAw3kA7/7Bws24n0O/S7RuFUKfTLUI
 FF5XB0YiqLtrLgl5k2ijb2N0hKZf0rfma0l+MNAdRqy4plkcXLantvt9FD5P+MvKeRBxHClwWkl
 /qdARnp0oQpzX8UtmMA==
X-Authority-Analysis: v=2.4 cv=IYK3n2qa c=1 sm=1 tr=0 ts=6a2677b9 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=FelO9ux0wxsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8
 a=Ru_WXoCZngTtvYUXGSoA:9
X-Proofpoint-GUID: 3E_6Sd97xRGSXh2E6CCl4MwagLpqe1au
X-Proofpoint-ORIG-GUID: 3E_6Sd97xRGSXh2E6CCl4MwagLpqe1au

Switch out the conditional load interfaces used by rqspinlock
to smp_cond_read_acquire_timeout() and its wrapper,
atomic_cond_read_acquire_timeout().

Both these handle the timeout and amortize as needed, so use the
non-amortized RES_CHECK_TIMEOUT.

RES_CHECK_TIMEOUT does double duty here -- presenting the current
clock value, the timeout/deadlock error from clock_deadlock() to
the cond-load and, returning the error value via ret.

For correctness, we need to ensure that the error case of the
cond-load interface always agrees with that in clock_deadlock().

For the most part, this is fine because there's no independent clock,
or double reads from the clock in cond-load -- either of which could
lead to its internal state going out of sync from that of
clock_deadlock().

There is, however, an edge case where clock_deadlock() checks for:

        if (time > ts->timeout_end)
                return -ETIMEDOUT;

while smp_cond_load_acquire_timeout() checks for:

        __time_now = (time_expr_ns);
        if (__time_now <= 0 || __time_now >= __time_end) {
                VAL = READ_ONCE(*__PTR);
                break;
        }

This runs into a problem when (__time_now == __time_end) since
clock_deadlock() does not treat it as a timeout condition but
the second clause in the conditional above does.
So, add an equality check in clock_deadlock().

Finally, redefine SMP_TIMEOUT_POLL_COUNT to be 16k to be similar to
the spin-count used in the amortized version. We only do this for
non-arm64 as that uses a waiting implementation.

Cc: bpf@vger.kernel.org
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 kernel/bpf/rqspinlock.c | 40 +++++++++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 17 deletions(-)

diff --git a/kernel/bpf/rqspinlock.c b/kernel/bpf/rqspinlock.c
index 0ec17ebb67c1..e5e27266b813 100644
--- a/kernel/bpf/rqspinlock.c
+++ b/kernel/bpf/rqspinlock.c
@@ -215,7 +215,7 @@ static noinline s64 clock_deadlock(rqspinlock_t *lock, u32 mask,
 	}
 
 	time = ktime_get_mono_fast_ns();
-	if (time > ts->timeout_end)
+	if (time >= ts->timeout_end)
 		return -ETIMEDOUT;
 
 	/*
@@ -235,11 +235,10 @@ static noinline s64 clock_deadlock(rqspinlock_t *lock, u32 mask,
 }
 
 /*
- * Do not amortize with spins when res_smp_cond_load_acquire is defined,
- * as the macro does internal amortization for us.
+ * Spin amortized version of RES_CHECK_TIMEOUT. Used when busy-waiting in
+ * atomic_try_cmpxchg().
  */
-#ifndef res_smp_cond_load_acquire
-#define RES_CHECK_TIMEOUT(ts, ret, mask)					\
+#define RES_CHECK_TIMEOUT_AMORTIZED(ts, ret, mask)				\
 	({									\
 		s64 __timeval_err = 0;						\
 		if (!(ts).spin++)						\
@@ -247,7 +246,7 @@ static noinline s64 clock_deadlock(rqspinlock_t *lock, u32 mask,
 		(ret) = __timeval_err < 0 ? __timeval_err : 0;			\
 		__timeval_err;							\
 	})
-#else
+
 #define RES_CHECK_TIMEOUT(ts, ret, mask)					\
 	({									\
 		s64 __timeval_err;						\
@@ -255,7 +254,6 @@ static noinline s64 clock_deadlock(rqspinlock_t *lock, u32 mask,
 		(ret) = __timeval_err < 0 ? __timeval_err : 0;			\
 		__timeval_err;							\
 	})
-#endif
 
 /*
  * Initialize the 'spin' member.
@@ -269,6 +267,17 @@ static noinline s64 clock_deadlock(rqspinlock_t *lock, u32 mask,
  */
 #define RES_RESET_TIMEOUT(ts, _duration) ({ (ts).timeout_end = 0; (ts).duration = _duration; })
 
+/*
+ * Limit how often we invoke clock_deadlock() while spin-waiting in
+ * smp_cond_load_acquire_timeout() or atomic_cond_read_acquire_timeout().
+ *
+ * We only override the default value not superceding ARM64's override.
+ */
+#ifndef CONFIG_ARM64
+#undef SMP_TIMEOUT_POLL_COUNT
+#define SMP_TIMEOUT_POLL_COUNT	(16*1024)
+#endif
+
 /*
  * Provide a test-and-set fallback for cases when queued spin lock support is
  * absent from the architecture.
@@ -296,7 +305,7 @@ int __lockfunc resilient_tas_spin_lock(rqspinlock_t *lock)
 	val = atomic_read(&lock->val);
 
 	if (val || !atomic_try_cmpxchg(&lock->val, &val, 1)) {
-		if (RES_CHECK_TIMEOUT(ts, ret, ~0u) < 0)
+		if (RES_CHECK_TIMEOUT_AMORTIZED(ts, ret, ~0u) < 0)
 			goto out;
 		cpu_relax();
 		goto retry;
@@ -319,12 +328,6 @@ EXPORT_SYMBOL_GPL(resilient_tas_spin_lock);
  */
 static DEFINE_PER_CPU_ALIGNED(struct qnode, rqnodes[_Q_MAX_NODES]);
 
-#ifndef res_smp_cond_load_acquire
-#define res_smp_cond_load_acquire(v, c) smp_cond_load_acquire(v, c)
-#endif
-
-#define res_atomic_cond_read_acquire(v, c) res_smp_cond_load_acquire(&(v)->counter, (c))
-
 /**
  * resilient_queued_spin_lock_slowpath - acquire the queued spinlock
  * @lock: Pointer to queued spinlock structure
@@ -421,7 +424,9 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 	 */
 	if (val & _Q_LOCKED_MASK) {
 		RES_RESET_TIMEOUT(ts, RES_DEF_TIMEOUT);
-		res_smp_cond_load_acquire(&lock->locked, !VAL || RES_CHECK_TIMEOUT(ts, ret, _Q_LOCKED_MASK) < 0);
+		smp_cond_load_acquire_timeout(&lock->locked, !VAL,
+					      RES_CHECK_TIMEOUT(ts, ret, _Q_LOCKED_MASK),
+					      ts.duration);
 	}
 
 	if (ret) {
@@ -582,8 +587,9 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 	 * us.
 	 */
 	RES_RESET_TIMEOUT(ts, RES_DEF_TIMEOUT * 2);
-	val = res_atomic_cond_read_acquire(&lock->val, !(VAL & _Q_LOCKED_PENDING_MASK) ||
-					   RES_CHECK_TIMEOUT(ts, ret, _Q_LOCKED_PENDING_MASK) < 0);
+	val = atomic_cond_read_acquire_timeout(&lock->val, !(VAL & _Q_LOCKED_PENDING_MASK),
+					       RES_CHECK_TIMEOUT(ts, ret, _Q_LOCKED_PENDING_MASK),
+					       ts.duration);
 
 	/* Disable queue destruction when we detect deadlocks. */
 	if (ret == -EDEADLK) {
-- 
2.31.1

