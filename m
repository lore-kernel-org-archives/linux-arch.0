Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.165.32
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794817535;
	b=oDD9u+ktfO+ZkqjOd6ZCO65DxS+Dft/lqXze2GA85CZ9OcxKWDdLCiM3jps/7s7rXGif
	 ln/cR/O2YSlvNd+Fjm5dM4pooOZq4NvDC9Dntflm3upSI1bYhSehWdnpP2SmapYfgE0S8
	 9UEFxVK5YI5Q44u6rtpmVH4I+1sxirHlune1YilYaRuBRb7U4484zJhDrb3O3fxKmPSij
	 k3suEBKV3m7JSjEeighK9ZDZGVbsD+/vL4j20305QwUGXJu9pmSZHK2lBTl7Nvg4n10tQ
	 LwuLhY8g1wEwAom3ooq7+Gc0L9XyJ34fK4d5/+dmEzEbBCt+PNdRiYqaOefnmM7K2Zg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794817535;
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
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info;
	bh=K+MKAL3tAcaqFHoK+gzgg0h6gumE1Nj3k6VlJ6QRMyc=;
	b=fQzFr8Qf+4hJT9vqw0fLnhat3wGLJM0Mex4Jo+QyKQOfvYCGov86lPxcdDd0w3gGqAty
	 eFHrw1uW3Ortu32qnrYmCeUBme4Rs4PMtZZnSRmojvBGHldq+whJ7i91WA9QUKIyCZf3n
	 hWiOxyLoq7TQYub3iDv/LjmIpOIzm3Jij5ggaF7XZm8cnsosHLJ5Tom7KaPvaQTXf1Zet
	 f7CQ8W7rMfPIrSa8M9D8qyls/E435o7U+lBo8P5XIKgjMK7urBTUC9jJaS6899vTo/d7Q
	 6TBxX9q+R9rWG54HzCld8fcX0A8lVyhHLVScOQcIgeAHPpWemxk5vEToeW6hSRNvogg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oracle.com;
	spf=pass smtp.mailfrom=oracle.com;
	dkim=pass header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=oJKaBH3J;
	dkim=pass header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=cokHhyYo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.165.32
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5663606A8BE;
	Mon, 16 Nov 2026 08:25:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5663606A8BE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=oJKaBH3J;
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=cokHhyYo
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AFNH4N81781579;
	Mon, 16 Nov 2026 08:25:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=K+MKAL3tAcaqFHoK+gzgg0h6gumE1Nj3k6VlJ6QRMyc=; b=
	oJKaBH3J96wIw+7ThXjRlBwl7pSWTOlTvWE6oBvN9+N9UjgRH2aTBhmu7q0FUzkR
	A/DKOETRzadvb2ouS96RJx7d7dLTKEnBW7xeEruiTf8a+B/qTvJyrKPBLKXtBaNn
	xIvr6B99S7GRI0lnkDWxwPTpsI6fVGOQotykU2mQj3sxNEGT0em05wzuDeHyqGEe
	1C8Daf/I/bITvLi7Lru6LpBYK3sLUIsX1OUrcGYEJb60nFAo24Ron+Mmp9tnF7pX
	svabA/uXRitK4ECA9nUUwSCPmJjf+cXmZLq65ZiNPPVW2ohczffm14/duNrxw+Zj
	URO9/1fNuc5eVBkONDxJGg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4hxfh9hkt0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Mon, 16 Nov 2026 08:25:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.11/8.18.1.11) with ESMTP id 6AG7cPI1962760;
	Mon, 16 Nov 2026 08:25:07 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011053.outbound.protection.outlook.com [40.107.208.53])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4hyvbyuxyg-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL);
	Mon, 16 Nov 2026 08:25:07 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mr7APKsSQ5LvtDKzqT4RtxmfqO9DI4JEbw7bLeVbGDLFS2Xv2heSHK49r/1SpXBuHlL7vdbfbNS2atIgy0wCi2aWLlDoMMzbSrSr10GtloBdMNMuhK37suEqIAjqF673tzQYaBEuxYTuwBa5cSjMQDb5NgVwUnh5GZAEDhWNTfmOxpc32cC7dIdsRriwgH9BAd12jmA479a6lTm1d77DD2J0gAeA65DJ9b98G6Sg7a3dOEP1m4s89n4finCgTLkF1p8u5OS9xRt7gF+cxY6X/r4puukOvdwYUSmKUUtIQK3ojST+tgsdp4GUB5+L8fiUw20rJ295Q/GRBYKPM8sDRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K+MKAL3tAcaqFHoK+gzgg0h6gumE1Nj3k6VlJ6QRMyc=;
 b=MUmGDr1qhpTHPxYKjxZKAr1WFvwt4YzNSpbvkcy698VjzAI09xaFmYg73R628/krlkNLAAyPzuWy8GTXLbm8yj+5qSXQs9/lCNldiBiJ3G2ev0wlZMTWBMNAfpDg7ZfkT33TyE5GhFN7TGis6bQ/QZq0Y7CfmLp2HowoKM0Pkf6gE/r0QeK0yfQfiywwvxcrbz4XDlFN7548N+3g5hGwSuyljMR2Y0UVnZnm7g5AOtI5LndVH3H31LdZ5lRlu2opRCiYV9MoWADWcO0cFIDK4g7A5XoLXn4Nmjt/DmbxV50Dy1JegePh0eziGpSYNlUVlRaB3QzlWmfoFJyFcrUCZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K+MKAL3tAcaqFHoK+gzgg0h6gumE1Nj3k6VlJ6QRMyc=;
 b=cokHhyYoOiB2TnpKhw6rqCseP3IuqLe22eLNPIR0qgCREqW2MgFQHe/Ra6tBzsQNV04nDoPGrbiHHBTCbAfsy7lB7MnV8o/120THlBT13CUS+KFHYq/HbxGatEcPc7na/P7cqge626G0pEH1pLDuGtrKw//8vxJBVd3gZV8NOHc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CH3PR10MB8216.namprd10.prod.outlook.com (2603:10b6:610:1f5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 08:25:03 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%5]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 08:25:03 +0000
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
        Ankur Arora <ankur.a.arora@oracle.com>
Subject: [PATCH v17 10/16] bpf/rqspinlock: Use smp_cond_load_acquire_timeout()
Date: Mon, 16 Nov 2026 02:24:31 -0600
Message-Id: <20261116082437.66739-11-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20261116082437.66739-1-ankur.a.arora@oracle.com>
References: <20261116082437.66739-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0211.namprd03.prod.outlook.com
 (2603:10b6:303:b9::6) To CO6PR10MB5409.namprd10.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CH3PR10MB8216:EE_
X-MS-Office365-Filtering-Correlation-Id: f8626822-e129-427f-4a83-08df43bb1ca4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|366016|22082099003|18002099003|6133799003|261009223027099003|3023799007|56012099006|5023799004|261102123227099003|261102130727099003|261028144727099003|261026121527099003|261026140227099003|261021123027099003|261022105027099003|261021121427099003|261022075727099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	MLH083VpxyoqqRFxTMG3FYp8GWlJlqDfC6SILXFm7gc80Q97Wus1XwXox/6dNBd4dUhFWrzRMMN1aot9ePPrihwySuHL8sn4/XaObW8bERZWIfb7hlZmQy37FKKA7jJbu/B+xQ8mHWOpymvwd9c2ud+Nn6nHuBjLbD0BtvfdHyFUiuT3Z7JZwdZ1ISo6p2aEgThMXl+q/IGqXaoiqx/8lsDWflANw9YIZgy8eDk0D6nbtXVJjTCJaMVv+k4ThjnFwnjZbe9NYmLg+rw0Ma2bmbQ8Sh2dEptaavo1SUyFXXml3uCTiLH1NYea8Itjn4YoQ9PdBnChCCKsd0mAhfae03k0ibljEEHkpBJkgK0ntovNTuzvXaDOuyykYhfCFZkcj3ak7DARbcJSszQV6Y5qQoPRXOh92wY2x9uTJCTw/mhUSokxu/YS6ahyBSEVHbNUw0GkP5B8qq71OqMs8TQpuyvFKS/ba4xvkfFYakrkV2z4A0nMQZYcWfplcNbtJyQXI++3T7wKcuEIV3xaW7gKyearl9hsZjlND7YPP3Rfw8VuzSlNRi63QCs+uQW+XLLiSxu6XYgZwX1gjO/zdC5RjV/HPz8wdwaM9cJdfohSNGXuzyAjnxZ3GTwAxdVcvRjBl9uIo7A+qzU2p7sXTzl73QABWh1FP/dwFe/nMTI7hwo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(22082099003)(18002099003)(6133799003)(261009223027099003)(3023799007)(56012099006)(5023799004)(261102123227099003)(261102130727099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021123027099003)(261022105027099003)(261021121427099003)(261022075727099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ed/i/ooZsQfqecOAdk42+2kVCDdSzGFZRI9+xveDgPzypmkiVZAN2DQCV7w0?=
 =?us-ascii?Q?H1SDk0CobeQXpWUk+y3WkjsvHCw+d6N0EF2AQhAGb3XK8Ew/Y53j1BhOqRgc?=
 =?us-ascii?Q?xvUSf38V50jIhDWWNzGqG6YTD8kNKo2ct5iWXo94BNpv1N6mkMfbIVP3oczp?=
 =?us-ascii?Q?1USSMUv8z9nDoBE7XLj6pSvtaC4Tigh43C9z7o6iY5awpm355L/y1GTTTsyE?=
 =?us-ascii?Q?vmpU/YnyI7qHC0kVQoifNujoGDkZKtiXHaXQnsF1ius9VtPdqpKR6k7TmiKj?=
 =?us-ascii?Q?/5p6U0UFgsgGmyk1+JNJvYz0iDVAQvK6G1ij/7qGBlW6u68qmGIT+7/LvU6z?=
 =?us-ascii?Q?lW4T6ic9avjihHLKsYO2XzU892MK0Z1MQBZyydnSqH+++43GV4XHvmnUOTQJ?=
 =?us-ascii?Q?9hNuQIZz1gE+OHbVqzRoP0CAs+1MhEI+79+bFEMRV1qAmc4YVaTk+gANlLxn?=
 =?us-ascii?Q?uGemnchpI4eO+Owuu/p+OHSAifZLZs/MAXMLFvWS7FNccfw7OAZlJoqSUK6T?=
 =?us-ascii?Q?DMCCg9GNCLMI48HsRAE7XpoKnRzviCpP58NtHDdOp/e3fOeUbs54z7ABz7y4?=
 =?us-ascii?Q?F0PWj/cvHKZqcAx+xcb9H0daqTAnaRQmBa8wolG/Cqunh3P2TgCFMiCDIBFt?=
 =?us-ascii?Q?oYIaa9Z6c/HaR1zEwNY9o7HAlJGMUmydAFK7ZPtEHuCvPL50JNqMOcWvoqnb?=
 =?us-ascii?Q?ZiJgeBU9x3FgRJdgCMIgIzMAsJVnj2bIyKSxgGE1EkuaGVPNu3NP3vipllMr?=
 =?us-ascii?Q?RkiL/G9ArDxMUY3TR6IpcBSJ3begxkFAQA60SjCDlPiAHhp1lsckEyQOuNnG?=
 =?us-ascii?Q?kQ8lF6GmgMGx3LERFNg524+N9F3UNl04ezxSqR69z8BbMtsMpxzpjo8XaRsK?=
 =?us-ascii?Q?4KSyvYRFuBaNFKAb+7hTqStGf6aGljzYFWkyRJ5Gqc3R5+r07Bn38e9IeKAd?=
 =?us-ascii?Q?y/FOAMA3p6vrOu4z+SdfQ0mt26HdktJpXIXz9zVldhOOPQvh87LYresSOP1u?=
 =?us-ascii?Q?H9uBd4cEp3miCVX1Gp6M2Xhn1TLqwiUdxXyuI5rUbxSIjgdd79iARJJDLufI?=
 =?us-ascii?Q?8TntA9OqKApIGFtah9KhVOzxx/iBEUYiTydxVGGHJoE9Z3a4Gv8tUhsZ5EX0?=
 =?us-ascii?Q?gMo3gFtiSwisK3O648Jp7I0TmN+lxPGWSDKieLA+wzMJbUO09yACKT+CRRgY?=
 =?us-ascii?Q?GoaLD7qbTB5HP84qZWneql2Lc/KLklPeAgogsyv5Z0MmWLxFxckygWWk1NpN?=
 =?us-ascii?Q?grEAmbuWLcUTZtC9oF2Z7Im4H2yA9GQN32J46hmZQI2mXA+IUgSi43TKoIH2?=
 =?us-ascii?Q?DGCM5XFkVG+SsssF4nTyMytCpFtLQMkD1vU5ATtA5Idwo6gXqxbvfR6kYkHU?=
 =?us-ascii?Q?rHX8LdbQeHgeWphh6lu2UdHQ/gpwrIkaUltgLidbnOLpJsO9f8bW8PBsTGyZ?=
 =?us-ascii?Q?gzlCYKdNS1QoT460W8cKAwacBofrXdHMZ/WhHvVKvE2oFEU5su1pjHI7tZ6I?=
 =?us-ascii?Q?GjH2sdZrze+ikDFbs8L59+YSf5/Xd0ZqYIzgLpDFk8OJBZ5aBP/oEblqYC8X?=
 =?us-ascii?Q?gIeiw0r8jjbMPxhjBCabGeCZjnaxGrOR55EJOylqGDZNGEwxYOwcfqRyhNqJ?=
 =?us-ascii?Q?P7Yd0xibXuC6Afr4jcC5v9ItC4iqV9dMmzmD40i9g85istIPuAc3BgOVhC09?=
 =?us-ascii?Q?cgcrRV1Zz+vRVtYdLrMrVlM+R4e23b32BP3AFgM3gCB8Wnzg2Pd9M3cY/QqC?=
 =?us-ascii?Q?q0kBAL4XrJ8IIbdbO+vet334XItGCx4=3D?=
X-Exchange-RoutingPolicyChecked:
	06kaaXYHPlJVxVqKsJvj4vBsuLGJ5N6C8V+OV3UTSgDY3uX4DCGGYWke04j6BuIOsuqYxidlmFs1vt0AEuxCWjHLWBSPjGNPDgYkIAIMKM7eUiiNzy+BmVi4AmTYNALTho2HQmuojonFxhEgoww9UxKc7PKFbf5/ZGYRJ0cJV2IgwuSk376cONqfKSJoxL0w1R47Ci/59737k9zPTczS6I0bXSRZdoQfqphIQOHGqRZceTk/kH3aoetDVfzb8YFxoyPVWtT6iFbc8cQwn1MnNnaDXbXu7Qbb+jQR4PyCxoOyOuXpamj1m45fuBumGw+sg5zy9RUqq9ubIDi9Judn8g==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XMVcERKIKuH4zldu3wVyDHdackKd98j31pC+KvVO4LlrFLNu6QJEsuM+dSk6WVa4k9dG77+HYjCB/DotmHTBuvOvtro6cotr4z2TMl6pkeaYpq63MbBWt6FMwzYqvm2q1OvSFziJARNI8R8lXrXokpQ+hAISbT560sFmIzc7zAiE3gLZd3ZKHEeZmiAgvnP5y63o1696d7MZVEi6wTUewxEhEoqlRHehtcmOWa0LvBy+zqtjvEd59YMX85fslG/t+RmHVDwZ8UhePJp3CNd7PPseLsenXfbypmGTCRf7y9pkDQqSL1c6Ls4E/TLxUXeDdyEjB0YqnKIeqnWB8oNirVggCX5Kddzf2Oa6nmAl6Ho1Lmr1smvEkkL16KnYtTNTlxhRrOJVjgSbN5ZITZAhes0p9HSFwQsX/xMajIM5nupun0/HN7WF4CK3W6zJlhUJTgBnx29coYNS7Wy7R67EEAVA8OYNbxz+1ezNnXXu7RA+q5+U5gqkYSa9a1tlbMY8/5aXxHLr2FaQA2YSw+XqRe4UhPl/z8XCsajyurOW7GOsHkoQvs9mNMhT/8fOdvN8zwfDFC7PnAMuc8LlVJVHI3EQeNIy4bz3yAEULT/5Hho=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8626822-e129-427f-4a83-08df43bb1ca4
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 08:25:02.9683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ElaCuENpDEvzbyVWspGiqCZpBeKxfzdeyO3SDaDjlPYlCUPQC6tSjNcX8Jzwt9GNhFPyvkE3tOIneJbrB5xInsWd2wl2JWh42cPZKJRL688=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB8216
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 spamscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0
 adultscore=0 mlxlogscore=999 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160033
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDAzMyBTYWx0ZWRfX0ZaMyoLHvGkO
 MFM9IhjWQqU5BrhEg+rG9pkay4OFi41BY3xOvDg/GvF/8++UXAmQ7LUW9OwB7MWTPbFH79LsvVV
 iFuJq4W8L7n5t5e+WS1kp0cKJ2kGK4f7uAfU6sOg68EROHHFhvwx3HCllTsQXtCs2gfMmrzkVWI
 Xbf+bUWUYM+lXpclJQhT2qEfJgIIprlvZ4ITZzYBNjqAYcaxxp6mqUVPx8jyaUtqFdYwdif1QCr
 h+ekeC4EnnDyL+521jAjWptNsMXWdinVHb8xFsUMgREeKgt9aBwkY2xsN2hbSnVkasCtQkw7uGN
 f5s78mk1JeWfY3TqXqDBtupnuhqJOvraanOmwBd2j5li3rTq8lDeEapoWEcjAKplCwNmjSbLrLl
 lHN4gONDhiCHMn2LqjW/DtB5JKKSOQ0yBLxuOiHI1x0tWQZG5J0F1jA/e+U8bMewrPPfJmImnwh
 cYzgp4jAHOLrQszzX2eic00RwN1DV83oD6bmpsa8=
X-Authority-Analysis: v=2.4 cv=BtAIUoX5 c=1 sm=1 tr=0 ts=6afabde4 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=EIcjfB9IiI4px24ztqRk:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=vggBfdFIAAAA:8
 a=yMhMjlubAAAA:8 a=yPCof4ZbAAAA:8 a=Ru_WXoCZngTtvYUXGSoA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12101
X-Proofpoint-GUID: g3MPyfKOsTv8TqZ1P4NQAWOB5PiDuQdX
X-Proofpoint-ORIG-GUID: g3MPyfKOsTv8TqZ1P4NQAWOB5PiDuQdX
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDAzMyBTYWx0ZWRfXw+Nytb0KS5+k
 dvOjAml9lILKP7zKx1VHvPNxqOTUfMMdBIQhelDv0ilrWz/qyFPvkdfEhuhiEJIaP+vVkqqmeEP
 49aDAl+RVZIgs6PAjx+iEni+hVKp7zo3MpSJ65hdBJQFFoIisEmt

Switch out the conditional load interfaces used by rqspinlock
to smp_cond_load_acquire_timeout() and its wrapper,
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

	if (__scl_time_now <= 0 ||
	    __scl_time_end <= __scl_time_now) {
		timed_out = true;

		...

This runs into a problem when (__scl_time_end == __scl_time_now),
which clock_deadlock() does not treat as a timeout condition but the
second clause in the conditional above does. So, make clock_deadlock()
check for equality as well.

Finally, redefine SMP_TIMEOUT_POLL_COUNT to be 16k to be similar to
the spin-count used in the amortized version. We only do this for
architectures without a waiting implementation of cpu_poll_relax().

Cc: bpf@vger.kernel.org
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Tested-by: Haris Okanovic <harisokn@amazon.com>
Tested-by: Sahil Chandna <sahilchandna@linux.microsoft.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 kernel/bpf/rqspinlock.c | 41 ++++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/kernel/bpf/rqspinlock.c b/kernel/bpf/rqspinlock.c
index 1b249c6f0674..9e8f19afd7b0 100644
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
@@ -269,6 +267,18 @@ static noinline s64 clock_deadlock(rqspinlock_t *lock, u32 mask,
  */
 #define RES_RESET_TIMEOUT(ts, _duration) ({ (ts).timeout_end = 0; (ts).duration = _duration; })
 
+/*
+ * Limit how often we invoke clock_deadlock() while spin-waiting in
+ * smp_cond_load_acquire_timeout() or atomic_cond_read_acquire_timeout().
+ *
+ * We only override the default value for architectures without a waiting
+ * implementation.
+ */
+#ifndef CPU_POLL_RELAX_WAITS
+#undef SMP_TIMEOUT_POLL_COUNT
+#define SMP_TIMEOUT_POLL_COUNT	(16*1024)
+#endif
+
 /*
  * Provide a test-and-set fallback for cases when queued spin lock support is
  * absent from the architecture.
@@ -296,7 +306,7 @@ int __lockfunc resilient_tas_spin_lock(rqspinlock_t *lock)
 	val = atomic_read(&lock->val);
 
 	if (val || !atomic_try_cmpxchg(&lock->val, &val, 1)) {
-		if (RES_CHECK_TIMEOUT(ts, ret, ~0u) < 0)
+		if (RES_CHECK_TIMEOUT_AMORTIZED(ts, ret, ~0u) < 0)
 			goto out;
 		cpu_relax();
 		goto retry;
@@ -319,12 +329,6 @@ EXPORT_SYMBOL_GPL(resilient_tas_spin_lock);
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
@@ -421,7 +425,9 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 	 */
 	if (val & _Q_LOCKED_MASK) {
 		RES_RESET_TIMEOUT(ts, RES_DEF_TIMEOUT);
-		res_smp_cond_load_acquire(&lock->locked, !VAL || RES_CHECK_TIMEOUT(ts, ret, _Q_LOCKED_MASK) < 0);
+		smp_cond_load_acquire_timeout(&lock->locked, !VAL,
+					      RES_CHECK_TIMEOUT(ts, ret, _Q_LOCKED_MASK),
+					      ts.duration);
 	}
 
 	if (ret) {
@@ -582,8 +588,9 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
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
2.43.7

