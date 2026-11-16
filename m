Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.177.32
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794817523;
	b=12VPPW/gmwCBg4wqk+wCKCFkVTIm7ZxRJlQfrdzYj3iLSd931UsB6FhOlTaBG5VQWVAV
	 D3TqLXnTkbgZQXWOXWkr71b8XqyhVBSbhCcMIctuO4IpXae1jyRLe3sM0jodvGhaanjBH
	 BTnLRpD57DfC5rpCS0XUQPjXXJ25xRiHyItIAEWDmyB3A+0Kchx9fd7uVWCVOaamC7CIN
	 b4xvJXrZZlwUjLBLMboPXVwRvJE2Ly68b2a8OqpNcEJEC9fjbEn895WMPDASBxQCvzWa8
	 At9PmSjGuBLTuENBwcKe4eVIOmpBwUcHJmkvwdjwc5ZqNR6JiRna/y08N6W80GqhSVw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794817523;
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
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID;
	bh=Q6lYnLtipO1iNYWIlDM9htMNBYxGI4olkRQ1ULwGQLw=;
	b=2v8u0bVJ4YLftcxYAFXv5Acm8oBQk2j/D/Bt9pcOPOkkgiIrHMl4wRjrknz3xkXm+pVZ
	 fpULO/xG7nWjB5wdTEq+lPB7HkFyZmbHAzs7yGYpKYlCpoTG/uXCRIZ5YkYbo6oYOmiQ0
	 JsCKzjDtWDytzxq+5TI+mHcl+9vaC1cvUHE6dU6kpaMbGfExUP8lsGBY035S/poiWhFAl
	 WC3ReLnMPpsBfmq6uK5COygfOs1devGva/PeaZCfDfFvRWeu8b8MYgKjE/4iYt2emLOMV
	 qLCoaEC+0zSyXP7l1RNaRpIwcFV9q4Uhw1n3dqGhQ80bX3Ok5ptY9NdoKfoHmJ3hWQA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oracle.com;
	spf=pass smtp.mailfrom=oracle.com;
	dkim=pass header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=d9hfgIqT;
	dkim=pass header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=AnHCmyyK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.177.32
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39319606A323;
	Mon, 16 Nov 2026 08:25:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39319606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=d9hfgIqT;
	dkim=pass (1024-bit key, unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=AnHCmyyK
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AFNU29s1336706;
	Mon, 16 Nov 2026 08:24:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Q6lYnLtipO1iNYWIlDM9htMNBYxGI4olkRQ1ULwGQLw=; b=
	d9hfgIqTUwW343z2vQNPlLg6O7nW/BvDLn1eFomZiXB3qAGyMsXe6LoSx7qh9OjF
	CZvtLKCl7vAqwu9npyMTEGNPr5GAXwkv6D5XgZhtv+DQhxr8Bdkjdo93EBJ7R6+P
	QL09RTyAej/kxZhGdEa05fV8Qm9c7QqIJXNktWEzz15z/4te+JUqktnlca/dlHQb
	w4MnAHE91pg2/sMDjq89vxE7rwH4O04l1npMZIObB4CfGln0zejz5p+S7v/KUqJD
	+zKWcvJUogtfnclTSdtwIBtXBlbB5E1eEHUagbMdoqPC/w4KHJp3Myts6iqCWzna
	l1MskUttxFCX1WoDzzKqrg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4hxee41mgr-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Mon, 16 Nov 2026 08:24:51 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.11/8.18.1.11) with ESMTP id 6AG7cN172844453;
	Mon, 16 Nov 2026 08:24:51 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012019.outbound.protection.outlook.com [40.107.209.19])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4hyv73vc79-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL);
	Mon, 16 Nov 2026 08:24:51 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VHGEv/NzSXhBG7WR0+4KAuYgfAThhjWZUljrjDju2MNI1bSRhfTav9tt8A5jZ8XP2bTX88gK1vq+JjTa66GVM0PhRw6PGtYdMmdqO+NNXbiKTSq3/Qchv7ihKn5hW4dhUFsWJYwmelRAJPhA1/1ZTDfs600eKkEbJeUNkCzooXJLuLoxS3/DNb1zuaB0q0DoSPlo9c2fWBZh7qEcj9OWWSlNzUPmKOcxWJmJqAu/zfsfm6ax9foZVBk/QURlhSL1mCSb161UQ4yCWM9OvEH8vpvaJ1ZzdIRNR0FcPMcMrBHKsSyPozxx0Viol8cWDwtD1OqGSS6KCKxfTsggpnIKxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q6lYnLtipO1iNYWIlDM9htMNBYxGI4olkRQ1ULwGQLw=;
 b=QAA+t0GckSb7REQtkJUQXzSDMOuDrjop7Kgl1vY5BjLmrLz9tT3JNbJAsjd8eRr6nDmnchA907VEH/3mcOJ4GZQO9uJ9/B+dt4WaTFvp9RBpIqPaAv5jgNbAAPaI9MPMBrTlWtLSmfjLuzZZAFK3q5ZnE5Y7cyYkMJW9mptsDdau7QHbsSTHdoMgis2ru1n3OlmvE6IxsVs8bgc7RoU/ohNYoVa3SFSwOvpFFlj295YcZhjScNcxn8r0lctaEOdpmw1W1K7Y9kkp/aYd72KHFQqUPgSjcwnW+ks1/s3llyPZyMyShhnTpLSgmr54vtOt1MItGNfL2LFD4OtAtv04DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q6lYnLtipO1iNYWIlDM9htMNBYxGI4olkRQ1ULwGQLw=;
 b=AnHCmyyKhzYX8zrxHihuPd37T+8gi1d/08exEDvQkhm95kwVqe6/lxwhAZ2S6Uh/QjX81xuE5ZFQIVlmYuNEErlReQEP2D7aXDAMdq4mX5rXyjenIJ38m16+CXXucIbU/hq7uyD9qXi+2OEycgDJ10C5NT2y1fdILwd8ssw+7U8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CH3PR10MB8216.namprd10.prod.outlook.com (2603:10b6:610:1f5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 08:24:48 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%5]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 08:24:48 +0000
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
Subject: [PATCH v17 04/16] arm64: support WFET in smp_cond_load_relaxed_timeout()
Date: Mon, 16 Nov 2026 02:24:25 -0600
Message-Id: <20261116082437.66739-5-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20261116082437.66739-1-ankur.a.arora@oracle.com>
References: <20261116082437.66739-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0372.namprd04.prod.outlook.com
 (2603:10b6:303:81::17) To CO6PR10MB5409.namprd10.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 343ef242-d412-4715-5dd6-08df43bb1429
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|366016|22082099003|18002099003|6133799003|261009223027099003|56012099006|261102123227099003|261028144727099003|261026121527099003|261026140227099003|261021123027099003|261022105027099003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	6LwEPBBn1tkrSschuindvjSw3+V4m9Cs08u/qxf6xs+Z+Arbcvd23LI6NORq7iCW+AMYs6pHIL5rUBEEag9IvqvCB4bXZZaBxDycmFkTDcUs1rF2EY/mcFbRXA3zgOg7XDwqMIAUX0c8oCJUEDLMhiSV3+ywEXyrjMnE/BB2PxsjDNZowR5eGz76HQO0iY8TjR0eH/kbNAaYlAGdGN7u3C1jyh/qQSsZGEa/IAdkdffIM9T/Ub0i5AdfG3SZdVuayrg2fnbN3Tm8MZ5c+D3xlJkZau/PSpBQkJwNq7FWg0wJsdRbyn1fh7HFzAKH7KQPm2GhHrVuZ1muxe0dnv4DT+272O/sIGNf5K8yNHSLcAOIBrrjuRRDVfwQhxchO7FysoIscrFajQYw1gnBoxisag9P063CaCAhBBTL2/b4YZIEWQLhLNAU0sSpo/rQ9b/875UwHWK26HD6tbN20Pj6rX17Cw2jgQvKG8xfa1zZ4otythTkNNqXX8WdV+7foX9D2m3fkXB3K2DdWIBbs82V2DLsG52F+n6BDWKil4aC5NGdP+d56WAZv1qfwTMIV//yoj31wQG55a6IhER/5re5sO15ykf4JG6utE3yEheX9773ZdJLbZw8fiI+VjvQVWmkurhTBjYm0b6htOWdCYZNTUMYf4nVVT1H5Qq4h3x9ULM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(22082099003)(18002099003)(6133799003)(261009223027099003)(56012099006)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021123027099003)(261022105027099003)(261021121427099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E/yfYZThjH+OrQB2jjfxGEb21Ndhgj6OYhWXTPfAE+PAs5VwDOnBVe1GpQcL?=
 =?us-ascii?Q?3ndU/CW7NxeVRDcin8lDFxvZRHLeOwR8C6ZGvP9nuefIAWK8KfLqR665BZBR?=
 =?us-ascii?Q?jIeloRqFHhjgFDisqMxh19pXm44kSfUEtXlUhEzZfDWfi0j90u0zmWuWvfw/?=
 =?us-ascii?Q?Gus2fSBvu7vG0v6gHarSqxlX22MRbAS3Wm061wzlGa8qTL7kBDjOKS3joLPM?=
 =?us-ascii?Q?ljw5dWpT6i5iOn+h6Sd9wWZQwEbsXx90r8nnJik9NHRk8zPK168Y4irGIECS?=
 =?us-ascii?Q?AWrY0NVIqlueylnEXrz64QM+HeqXZlB41aB2ZZHmrk0k/Uam0/u7ePNvedwH?=
 =?us-ascii?Q?XIuafqdhnSskMnJDKzlxA6/a+W2A7Nvtn39WqK4fxhFRsRQOLZJH8A0nVENM?=
 =?us-ascii?Q?XupW7SkkdQe9ZD4yHiRxqm9eahxviC2mRad8Uy9HVvHLQGeexfVTqURVjfvZ?=
 =?us-ascii?Q?FkZVuAfKdRrQXQyDvf0eCI+psDq30gpAVnmWbnObpIQJPBsR2bfUniGZ33Nc?=
 =?us-ascii?Q?C9LEE7QQrssM+3NClyT9+6fFqmdUzzeihuUY/h5NbYWGCow+p8jhI9vGcUko?=
 =?us-ascii?Q?3WlkqDuAS3oOyWsc87iGBJhUKY+RLsfzfUdGjlfKqK+EDkas0NvHEBx/h1bb?=
 =?us-ascii?Q?wivQx7/ZlnOIYhk8bKVuxeEBZGY2h00KSyxGlgY5Sd4ksPDueBl9MPaxxbr6?=
 =?us-ascii?Q?mGwctSAwLyr2CKb3PnPPQnG0qFas+ctnr5IPyIpG+gfl+mJp36BDLqVSXkmT?=
 =?us-ascii?Q?pNOGYSjXZ8hoF5etRQv4K0tLeLlAaQ5eB0snk53KEs78M5hnfNRktP5tOhpP?=
 =?us-ascii?Q?g6Ho1Rq4819Mkddb0acejNVoNVb+OEN2vJJgaVBLQTEBmGuhU7sJ2ePqTuX9?=
 =?us-ascii?Q?czo3+DuwKn5Nfc/bxqeoUTB4a403NRobxryqBUTwZp37ZvPPpfm16c/WDMd5?=
 =?us-ascii?Q?sK57tTbRvpRl1pPMdwUTvcB1om6s5mpsYOWHn1f0ASK8vs3Qx1as105LHWrQ?=
 =?us-ascii?Q?LdYBd9cYPL7SlEqymEI8Peg9nZj2nPjXwuMMkyfBmr8WJWlPVyF5ZW/uvfK+?=
 =?us-ascii?Q?9G9Th6aUeXAIhyMIO+Dm9H22bWoWET3iBVeOXuz6lMDQetnzWKQehVLHXDO4?=
 =?us-ascii?Q?mlZJVwUkTPX9G2iNJJZnFz/JUv9ng6Y4bZLI0LgqAco10s3oN/VjxtEvAZvu?=
 =?us-ascii?Q?Xh3K3pKv/KuqxpGwVDU3GZKeS+/AVmTmOykct4N2CsGFHVjfqBQ/tddKpbvD?=
 =?us-ascii?Q?zIL3VnSD7TBzqelkBapI7i697C+EOlhTfoYinkLZlmFtJsn8sF7c2HCQ90qI?=
 =?us-ascii?Q?S/dBPTK6gKK2sp7ddLx65Z5HhfSUr1Jj4tRKw3CwVTrWTtO3PNQsugqAv2ED?=
 =?us-ascii?Q?8dAjDEtZEICBeUF+3MvRosQGqyEGscwQ1vSFUA1bU4HOLuJTL8vNLuL0k+H2?=
 =?us-ascii?Q?XHXdkaJPmO5dtso8okJMKOuXoqSiuWGFwjQnRkusbtD4RolEJ6j+NSXrFgGU?=
 =?us-ascii?Q?gdy5+K2a5p42EshP0PCJ2Ui4mRgJ6JLZyvpkgNDHa5oFqHScC2ILAggHm3a7?=
 =?us-ascii?Q?sIVtGZ8/271aKwz6L5b2WyrjS4dZ6amNx9iqp9cwJPXh2N1esqXeK43z6imv?=
 =?us-ascii?Q?+hqvb3Lx0uHZ3s+fpmPGlWjh3zGAKge5nJtPNmBayDJ3g6rMrJnO47cv6Yhm?=
 =?us-ascii?Q?oFPIiR+k0rFDOvXZjzs5uYz0PmkTKzNGgYKfv9lFoOTTreH+3WWlz9mW5x2J?=
 =?us-ascii?Q?DX34sJgGA5PT0X5ytea2nJ7tTHhDY6I=3D?=
X-Exchange-RoutingPolicyChecked:
	R9RAiynHq0C81RZ9ocPatvaW7t1QfbyYqGKBMgTDNpcIcgkHMpB0aypWwYWQpahRZzIv0tVWLnHDVY8SMQZ4MIzkcLG99gyIBcFauP2u7zGuOYmpIo/SIex1R3/EcUJqrhiX3eKd5o1wfMlV8+5H5I2G3eGQZPrCtHbeMOshpRd2rPxcSgzy65vH8sCKR3GuQPEe1KN5MLk+e5NSRbVlcKbkXmFtqTEjgIyJXJfbB+qqS4F4iOqQef0/TkDH+Dn7///tDZLm1s97Exqb+TDL5cLkn0XdR5YVLDC0+1UCAei2A1kUD9HHS/UOsfZNEB3GVheqi8PkG5oVbhuWOqDY5Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZgF4yoXZ+mPKSMO6Fjff107/JsWAp2QxgT6r9Vl3TryZ00o2oWqmaptff1oj/+k4o/c6ir33UwwOqdWqhtK91dn6cAYRtHm7VkmIqHGPYUYv/gdCN0ZMUCQoTIl6jf0cCxOGJI/F4kLgj6JPVVh+arAjkmf5LJIPkeDmxw4h9Mm9q4apnB2XqhLKTss739Mir9gWIi0n9WnvbaX4zgHEDL9S3XesEtGI4eDYJ3EnripwMcOzDXn8V747uMXWpPrVb1fk/blEPPA5uhF1ZWrJg+DW0ZO1Es5NDwI1sMkNegTXqoDXUrlNqkVAUX5ooLjUlbQHimoySHtIpw4SHZ8TJV069g0ojQfMxfQQqTEhkY6cdlZybNDr54PU7p+XV9/Tbl9t+azEHI5ELy+VuVMNmB1uvpF6Yd3RVpdkDshTdbbPJyr5nF8v5Vaa1DXeGL4RZ6gLq501XZ7sRvw1C5CYc5++nQdgI/OGaeX+PQK3IlmOh0t06vz1qoz30MFjyeKexbUaT29Wg0BJDhl0ZIsyNs4djnHnlpQGQRF56yYbNy65N65sV6ZXUzehlpD4LQnYLRyvH23JFQcMz1iAiTub1JJG9LbTlWI2hl3Tgpv6pho=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 343ef242-d412-4715-5dd6-08df43bb1429
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 08:24:48.7217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hAvdd/cMizKnESGCgVoNQ8fxG+COglg5p5UIYiNYaIB/jaduzfGwCDyw3pLqqqd/FVmjSgfny1bnUkhOl10WR6HoM0kj/tzB+TV/AqsJCFs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB8216
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 mlxlogscore=999
 spamscore=0 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2611040001 definitions=main-2611160033
X-Proofpoint-GUID: j61josBcT-DswMZhovZO-ddhIt26P9fT
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDAzMyBTYWx0ZWRfXxvMMI4sjF7tx
 9h/Yj50j6x531ApRA0Iueo8/PjZ8n5PbI/qWJ0qJsSebzulv3YeAmW5/t4h7uNK3r0rqy+32pAG
 IMXgK52+ml98Qt1FTCBW7EOsoy46CXWq+Db4mlDcskGChhSesap/
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDAzMyBTYWx0ZWRfXw6ldwkZb/629
 ltpWrTVvm+GyUhCFRdcRP9miSvSoV/pGNYaGph9Ng+gk3NE5wNwpOH1rUrSxt0E6pVa6JtMDGZ1
 eDARZ6nifcaQM0TOGKIsFsU1i570t8mDhLvepZ2riCL1YH4ntnPoQ5RfwYYUConuxDdzf4UBCLg
 J1pGFtIauej8o4tvZPQASRN63+mE0uilysed7WAmA2GyJcsulNzRbU8wr+BwhOHbfcZ9Gveh2IL
 ide7zdbMmQJmDEXnBfrrnPUeHUp9zAZuhNLVxcwY+lcYDPakhZNZG1nEQqPhoFYGdoZMXlN+jDd
 cqJhog7cNCsCUVsJHb2JrK9jZ/7oDEoaB5CSzBN9wKrWw/wA3EGd9H0KnnADhFfuV5KImxg4TZw
 oVvXlECofkbavGyhW02Y/r4T5JIHJq5aLPbylfg3ssOfVbpQeCKZAAWjAo8spW8gkUvKhDskjPY
 +q6SaduqWxfAiSb95UQ==
X-Authority-Analysis: v=2.4 cv=W7utxhWk c=1 sm=1 tr=0 ts=6afabdd3 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=o5oIOnhZENCTenyL_yNV:22 a=7CQSdrXTAAAA:8 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8
 a=vggBfdFIAAAA:8 a=yMhMjlubAAAA:8 a=yPCof4ZbAAAA:8 a=ckGIJSXraPChYtHAjnIA:9
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-ORIG-GUID: j61josBcT-DswMZhovZO-ddhIt26P9fT

When using WFE we can go beyond the timeout since, lacking an event we
depend on the event-stream for wakeups when there's no event.

So, prefer WFET where available to take advantage of precise wait.

Handling of WFET is via __cmpwait_timeout() which behaves similarly
to __cmpwait() calling out to the __cmpwait_case_timeout_##sz() or
__cmpwait_case_##sz() functions.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Tested-by: Haris Okanovic <harisokn@amazon.com>
Tested-by: Sahil Chandna <sahilchandna@linux.microsoft.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
Notes:
 - use arm64_wfet_deadline() to calculate the deadline.

 arch/arm64/include/asm/barrier.h |  8 ++--
 arch/arm64/include/asm/cmpxchg.h | 64 ++++++++++++++++++++++++++------
 2 files changed, 57 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
index e2263c754a55..3b024058cf2f 100644
--- a/arch/arm64/include/asm/barrier.h
+++ b/arch/arm64/include/asm/barrier.h
@@ -224,8 +224,8 @@ do {									\
 extern bool arch_timer_evtstrm_available(void);
 
 /*
- * In the common case, cpu_poll_relax() sits waiting in __cmpwait_relaxed()
- * for @ptr value to change.
+ * In the common case, cpu_poll_relax() sits waiting in __cmpwait_relaxed()/
+ * __cmpwait_relaxed_timeout() for the ptr value to change.
  *
  * State this by defining CPU_POLL_RELAX_WAITS. This enables a time-check
  * optimization in smp_cond_load_{relaxed,acquire}_timeout(). Note that this
@@ -235,7 +235,9 @@ extern bool arch_timer_evtstrm_available(void);
 #define CPU_POLL_RELAX_WAITS
 
 #define cpu_poll_relax(ptr, val, timeout_ns) do {			\
-	if (arch_timer_evtstrm_available())				\
+	if (alternative_has_cap_unlikely(ARM64_HAS_WFXT))		\
+		__cmpwait_relaxed_timeout(ptr, val, timeout_ns);	\
+	else if (arch_timer_evtstrm_available())			\
 		__cmpwait_relaxed(ptr, val);				\
 	else								\
 		cpu_relax();						\
diff --git a/arch/arm64/include/asm/cmpxchg.h b/arch/arm64/include/asm/cmpxchg.h
index 6cf3cd6873f5..e543366801ce 100644
--- a/arch/arm64/include/asm/cmpxchg.h
+++ b/arch/arm64/include/asm/cmpxchg.h
@@ -212,7 +212,8 @@ __CMPXCHG_GEN(_mb)
 
 #define __CMPWAIT_CASE(w, sfx, sz)					\
 static inline void __cmpwait_case_##sz(volatile void *ptr,		\
-				       unsigned long val)		\
+				       unsigned long val,		\
+				       u64 __maybe_unused timeout_ns)	\
 {									\
 	unsigned long tmp;						\
 									\
@@ -235,20 +236,55 @@ __CMPWAIT_CASE( ,  , 64);
 
 #undef __CMPWAIT_CASE
 
-#define __CMPWAIT_GEN(sfx)						\
-static __always_inline void __cmpwait##sfx(volatile void *ptr,		\
-				  unsigned long val,			\
-				  int size)				\
+/* Declared locally to avoid recursive include dependency */
+u64 arm64_wfet_deadline(u64 timeout_ns);
+
+#define __CMPWAIT_TIMEOUT_CASE(w, sfx, sz)				\
+static inline void __cmpwait_case_timeout_##sz(volatile void *ptr,	\
+					       unsigned long val,	\
+					       u64 timeout_ns)		\
+{									\
+	unsigned long tmp;						\
+	u64 ecycles = arm64_wfet_deadline(timeout_ns);			\
+									\
+	asm volatile(							\
+	"	sevl\n"							\
+	"	wfe\n"							\
+	"	ldxr" #sfx "\t%" #w "[tmp], %[v]\n"			\
+	"	eor	%" #w "[tmp], %" #w "[tmp], %" #w "[val]\n"	\
+	"	cbnz	%" #w "[tmp], 1f\n"				\
+	"	msr s0_3_c1_c0_0, %[ecycles]\n"				\
+	"1:"								\
+	: [tmp] "=&r" (tmp), [v] "+Q" (*(u##sz *)ptr)			\
+	: [val] "r" (val), [ecycles] "r" (ecycles));			\
+}
+
+__CMPWAIT_TIMEOUT_CASE(w, b, 8);
+__CMPWAIT_TIMEOUT_CASE(w, h, 16);
+__CMPWAIT_TIMEOUT_CASE(w,  , 32);
+__CMPWAIT_TIMEOUT_CASE( ,  , 64);
+
+#undef __CMPWAIT_TIMEOUT_CASE
+
+#define __CMPWAIT_GEN(timeout, sfx)					\
+static __always_inline void __cmpwait##timeout##sfx(volatile void *ptr,	\
+						    unsigned long val,	\
+						    u64 timeout_ns,	\
+						    int size)		\
 {									\
 	switch (size) {							\
 	case 1:								\
-		return __cmpwait_case##sfx##_8(ptr, (u8)val);		\
+		return __cmpwait_case##timeout##sfx##_8(ptr, (u8)val,	\
+							timeout_ns);	\
 	case 2:								\
-		return __cmpwait_case##sfx##_16(ptr, (u16)val);		\
+		return __cmpwait_case##timeout##sfx##_16(ptr, (u16)val,	\
+							 timeout_ns);	\
 	case 4:								\
-		return __cmpwait_case##sfx##_32(ptr, val);		\
+		return __cmpwait_case##timeout##sfx##_32(ptr, val,	\
+							 timeout_ns);	\
 	case 8:								\
-		return __cmpwait_case##sfx##_64(ptr, val);		\
+		return __cmpwait_case##timeout##sfx##_64(ptr, val,	\
+							 timeout_ns);	\
 	default:							\
 		BUILD_BUG();						\
 	}								\
@@ -256,11 +292,15 @@ static __always_inline void __cmpwait##sfx(volatile void *ptr,		\
 	unreachable();							\
 }
 
-__CMPWAIT_GEN()
+__CMPWAIT_GEN(        , )
+__CMPWAIT_GEN(_timeout, )
 
 #undef __CMPWAIT_GEN
 
-#define __cmpwait_relaxed(ptr, val) \
-	__cmpwait((ptr), (unsigned long)(val), sizeof(*(ptr)))
+#define __cmpwait_relaxed_timeout(ptr, val, timeout_ns)			\
+	__cmpwait_timeout((ptr), (unsigned long)(val), timeout_ns, sizeof(*(ptr)))
+
+#define __cmpwait_relaxed(ptr, val)					\
+	__cmpwait((ptr), (unsigned long)(val), 0, sizeof(*(ptr)))
 
 #endif	/* __ASM_CMPXCHG_H */
-- 
2.43.7

