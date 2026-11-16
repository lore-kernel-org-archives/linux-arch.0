Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.177.32
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794817529;
	b=e2ttK/8kAiAsNRk6+R1reAQDwj2kE+3XzcwfY00UKaJwFM8hgqy8bflNfrmdxZ5T8HoU
	 Y6o+6i6crRHS1UA65DVBnpF45HM1OA0P677Nt+Yonenqw7+XXEB6o/OiSCfufXqZtdigt
	 fQpDJSHzvlGHnPo83lfj+pJ1o5UVmIafb1mUiqoJNp66glLYoNu0c8bv9FIEK8Z9Tmthc
	 wl2HToDXmMXg3OqEjqGU1OLjaavXo+SZe2O9vU8eZJ9Ke/ZWEasnWK0eM1pfHvcpXZ4a/
	 YRI0JKjS0Qr2MfIHPA2iSf5QARKjM8IZ7Pvn9XOgul43ie6FE4uCQCZm5sahpLgvQxA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794817529;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
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
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID;
	bh=QGQN/2sv6gJAg5QvU5ToDwY/HVpc5uevnhsJbw9MCj8=;
	b=yiATdC7yGnkfB7R+TeJOYHegUKiKxsncg4O6/YS7+ejEDN4vDnE8mhOsQmdln5VsXc7T
	 hwDyZ1kmACjOsuG1tXr+DF+XVP1y2o9t2IEKHKTv1SXcR8gdMxhUOoOUDFA+vnZ5hJXFP
	 D/ov9x+tqSfPh5AI124PiBMohMU4z0pwMTz7P6d43bnviaP+9Qcl/Wv6IES+Oy2qsRDiT
	 J79kw/38lznK3GepedDtgGYcyWEf81jxLhYElEGUCAsYHtCU7WdWldBFxl24SgKOV5U7/
	 6G90/O03XWHpG8J0amUhrdIjAkzVvGV8oU+pmZDrxSslzALfM954wselEVneAIx0bsg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oracle.com;
	spf=pass smtp.mailfrom=oracle.com;
	dkim=pass header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=SqL52DmU;
	dkim=pass header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=iMbtRkHO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.177.32
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DBD606A331;
	Mon, 16 Nov 2026 08:25:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91DBD606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=SqL52DmU;
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=iMbtRkHO
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AFNAVLC165529;
	Mon, 16 Nov 2026 08:24:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=QGQN/2sv6gJAg5Qv
	U5ToDwY/HVpc5uevnhsJbw9MCj8=; b=SqL52DmUJF7UKplJ0nTZRt0oJeI+6L4Y
	+6l3iW2di/4+9hrJBiYQ1zkDbt0M8INFg7pROmNjAORrZwrbwzqgMqCGIcc/fYeZ
	rgTU+RJBqWBX/kCd5VbrwlkJUgYPdJabscblhF9zdmUZDfJTcwGybbx8ATBwKoMg
	4AQcr9Arl5Ie64M2MkFL7r46xvpi+IHyuHUg9gw5O3znA+mOTw1FSclUaVH3ISwL
	mB8wRKleyO6z0BRW29IFt15s87HkVWEJcfu1DA4ibE0Sa8rpSq6SB7aIglVsBcNd
	LZO5KmWTg0bE0+GxWxpOgN6twzhq1Os6vSv/f+uj/j3I2yVChi+WnA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4hxfpe1kuy-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Mon, 16 Nov 2026 08:24:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.11/8.18.1.11) with ESMTP id 6AG7c5ID2871228;
	Mon, 16 Nov 2026 08:24:41 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010051.outbound.protection.outlook.com [52.101.46.51])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4hyvt1u47s-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL);
	Mon, 16 Nov 2026 08:24:41 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O0PrhE/u9N9BtOxWizpn0Kqen0d53I/noUp9LUdKjFpPW+NqRYLSeNUHHH7Jx1lqd2n002oDGjS8/deO1OjFfNyJ5GFnjt9j3nz3ZqTWeITj7mCXdQZlKbfu5j+uNoYrreI8VoqWZizdgpTvPZlu6aIhESC9k4076it/f5tkW/7v9rAI6ui9Cbbk9Yzp+gsTAi60uBVq0RZQWAVT0YDqBaRBcabijc2eqYlYBPoAGq9wsYD/8IfPHrkam5fhimKhHVGFtculb/oaxbzaAePitFbJmGQvPT7/x8BnB5kd6vVC8IEWLXMsNAnxhLitzTMJHfvWXKUtQSv8CdvSmAWO5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QGQN/2sv6gJAg5QvU5ToDwY/HVpc5uevnhsJbw9MCj8=;
 b=ahPANgy3RBaR9BiEHjBbKN8V2YmWMXiFIP2cToaIIfLlbm3vfDonTsJTUg9+XffziUaMiTiv3pmnLtcEWUn9FGQndVrTq2Xizz5+hrJf2QxQ+2d89HojfEi7WslGtRGdA8N8GyaTfUvyojPbdgyQGM6i6NIq+PnSv0QE3yllU//bBqEtXhm97av6dntrUTeEB3+w8FwuSa3NS+T8vdnH5rRavOzOG3XsbN29Dzvp5M5MrQ7O7eevR9M/IBg6bprnLf7zoOPcWEUFPIyQRDtUwrK1geguauoEsRb08WQ7zCSvKFaQioTuzZbsRVxBB+l/wgqxE5y76mzlyt8RruUk/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QGQN/2sv6gJAg5QvU5ToDwY/HVpc5uevnhsJbw9MCj8=;
 b=iMbtRkHOU3U2NLNjK00Gs+Hr32T36ozsW5NV+prS1zD+/DVytA8o0bjpWfX1DLXASP2UrZ6ZNBdHHr5/r7DJ7ofBndM0xH5Gcw/qWDm/m+4+TdS+DR2us1vxaFF9PSRJFGszL2FrQOdvueaYU7R0vEdQGO86zr0BnBkfrSfD8TQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CH3PR10MB8216.namprd10.prod.outlook.com (2603:10b6:610:1f5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 08:24:38 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%5]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 08:24:38 +0000
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
Subject: [PATCH v17 00/16] barrier: Add smp_cond_load_{relaxed,acquire}_timeout()
Date: Mon, 16 Nov 2026 02:24:21 -0600
Message-Id: <20261116082437.66739-1-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0091.namprd03.prod.outlook.com
 (2603:10b6:303:b7::6) To CO6PR10MB5409.namprd10.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 7eca2fa5-c40a-4ef6-15d6-08df43bb0e1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|366016|18002099003|6133799003|261009223027099003|261009221227099003|3023799007|13003099007|56012099006|261102123227099003|261028144727099003|261026121527099003|261026140227099003|261021123027099003|261022105027099003|261022113327099003|261021121427099003|261022075727099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	YV265chT7MGpl4JwVRROAFHrgCaWbij5dx1lJcUNsjzttt2vG9oOChp7r9xFW2yuI61654PrSBi/3xmSwVy0a5h+o+OrnBnl5VjOqMNIe9d5b6lFtJGYGanoDpyGR0DMoY62YDi9rJU4gEPPhqhAHvFaxLL6RlNPxz5F0aHtmc94WsEsxPfy7YsKyltT1IEDEyypRwEdWXqMFwEkbqnPc+xdpKkorrxCd/2lPgVA+wRriovIcdpjIhYk2Z9D6IvkNDBIVUhTsN2xXEYalzQW9s/k46lyfdAwGd1uHVNIUIaJ1lQ4gCNGwkdegFrKFvgzpgkCYEPWuQXLY90cJxQG6pjvxbwmfCUhsmBQdur51YmKqck580qF2PlYp9fphdfjcIAUQci6ru2+LHNTQ9mx+4Pt5r1S7tynlxNythu+uoRWkxTG6BOKwa5NiOlo4CV97IfE8BPKhBnZH6vi9g9Ftbp6DAczoebPYD7JGhaKfCMB63KuYGdWlhtvmrDh1fO/w2GD+WjlO6i8Jdwcvn+gLferNOXtu67CMAepl9dqo+1zwHqWhhrecix62t8Ci5WxXMMvLtfKe5Q1uGiCejRSj1s3InWCRhxL+p2ksjbwIPDWtxC9duyM9IX0aYWrcRZA
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(18002099003)(6133799003)(261009223027099003)(261009221227099003)(3023799007)(13003099007)(56012099006)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021123027099003)(261022105027099003)(261022113327099003)(261021121427099003)(261022075727099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Dm9ZgdwGny8L11/Na0XKrLRlebySkFoWvDcZqYFQFAyQy+nKmU0Ayu+6n9YW?=
 =?us-ascii?Q?9Iunpf8eeJGussTzC6h9Fpy5Yia4IrCZmacjYh3NYRDGPGDSDMBeiwKkJrdq?=
 =?us-ascii?Q?4eWyNzO/YAZQcv70rGG7kLSsaeMl+FO1c1eX0VwwHCdZIDir9GsJyRBbyBXi?=
 =?us-ascii?Q?mNca8YJ3Cv2DRYd7yaPNWXoUEtMEU8yrm7u5LKUn9uBBKU7YfihNeXkOWcLF?=
 =?us-ascii?Q?opw9Wf2m4zoWe1fBfd1Dz2xG6/3G5x+p7ijJ23APobrS/+vHgCYMOfl0ShGM?=
 =?us-ascii?Q?y7s7c9nr4qhNzpE+iG480q7kMoVW9X6GcHmQufokq3nSpiMrx6EuX2GJTK0a?=
 =?us-ascii?Q?KFua2EwfOKUMKPfEanbv98YpQ9+mKczKu2GbFI7I+CFwlXTUiIv2W2MeTKaO?=
 =?us-ascii?Q?Bt4Y1ohHByHav4nWuAu565raokJ+6crjGwVmv496OcmhKOJyMh/O56Yag0ui?=
 =?us-ascii?Q?dlVcM6iXVM47Vm8kg7p4Pk90zktaoYAimwObaZqxg2WEmHTlCdjwfQmV6I0/?=
 =?us-ascii?Q?nlaDp1bJLSY0DbF75C6lIW2nInHlbdi1BSFs7lUrQWnkG7X+c0vuVMi8l8wk?=
 =?us-ascii?Q?ER3ITuDIEugj4fXPof64h1sli5G1i6S7Nh6l1ZQccqmtuBRI78/tPM5SxPeE?=
 =?us-ascii?Q?0OKIwciUJTCxuQlvZBdHsAjumu/9v+825SIPjR6rITAi2C6YXIIuTjI9E5l5?=
 =?us-ascii?Q?YnAEyzaxgxIyj3hXBsjW938I9DI1ryhMQR/MDF1MjO9NuxLl0JMgDTUAHMbQ?=
 =?us-ascii?Q?C2WsRF0hAcVyUNUrWvKauTFldaziIwKJ2fjByg3V2lsJxsiOuD/yp+T9EJ8k?=
 =?us-ascii?Q?OXOhaMIvqI7LR81YCxcsc8pif0RxCkdDBsQeAOm0h+WPvgi1TJ1IyjCIkvn3?=
 =?us-ascii?Q?FNbSPyjQUsU8+OEQnbb450K8iWEazbK8JpjuF4b7UKoj1pqtqQUzBezrZVGE?=
 =?us-ascii?Q?8i3yetIqsnE1N6ccFKhD7TX2PZUFNsMGJmx1NvZ3P2ogaGQauaqpqV56Zdyl?=
 =?us-ascii?Q?Hz8GidnqZQvJxSDZJkvwwEY+N59o+JrYX054OnhDIDno/BIu9r6W8ZAVTmj+?=
 =?us-ascii?Q?4BwXnSGS5O/VtysWfN0A7rOT3/Ve4jLgh0Q93J8+tXyVvft/9qVH9NwoLTz9?=
 =?us-ascii?Q?eu7osVBbVRTNLOL4CLAsLtYdn0CvdHvNUbRZm083mLrJb13XOSsmbTibyNsD?=
 =?us-ascii?Q?fEBii4YmKz/TcMYWQvJk3Fi2mKvZvV1DJvLcBP/9nQApJzuJMvgYm3zcToPp?=
 =?us-ascii?Q?tRzcFJXNu/yv3/9J6DI4c79DpukSZAphZ2/FMh21B1V0DfngFloZgWygb7Ku?=
 =?us-ascii?Q?qZm98GufDPLdpRxwJcPvGJlzVoGXsPOjfErhiKfPWC5tTNGwQ77tlHPsEK/U?=
 =?us-ascii?Q?c060x2WCQYV/8PnkRkofaqoDd0KzsLIvBnGFw3g5ke1E/xzEzFB0j804UANJ?=
 =?us-ascii?Q?KH1xKjSp7jvadX5UDz8mbeG4T5E47PEiDc1Gz342iSqGRe3YIH33HPZ4u21+?=
 =?us-ascii?Q?AGeePkD4G6e6GTMFmztQhObSiID/vmJQWGK7RuMS/ZQ21NTzwJQuUnHDRr4R?=
 =?us-ascii?Q?GtZE806oMhfVk583WcNI2kFTBESoZw8yGIXBx8egYp4HetlgSOy1qAcNGDxW?=
 =?us-ascii?Q?Xzs95bfSYIPqETsm2t74rhMr2w7+G4RJ6pPB2LWdfzz+6MndM2+3ugKtiFKR?=
 =?us-ascii?Q?ao660732/jTmEvSO+AFlksO3g0GKHB3ZY2YgILWKJGF6dMVDIkOgOaS+WvwL?=
 =?us-ascii?Q?L8/l5lIwoezRjHU9zbrYJ6NJ98mzpm0=3D?=
X-Exchange-RoutingPolicyChecked:
	FAs5RPj7RCsk4ReJVMnsc9tBWCxPa13yP/s8dTEQY4PXQlaZtQLqpd/38zyk05mrMQTYjjJfY64xQBewq3zC4qAmB+D6H/BVdJpQTysNQvGk6xsu2oywnJCp9bYOTolNBTnoev8/2wgapmDXIiR6ztVAHhQqaA0x6vQC8ailpJjr9MXL/aCha03CFD5AWiMsjdO+owqaHXMowNeJ6Kq1PYCM9UlUYjkOcVTAVlfNqFjND2bC2Dq9WNwwgl6M4gv1GYGEvBs5waQDvMSzgILMeSwAO6qHPRRyLIwZ/yF4Jj8STQ14+gUzxopOMv7Jf74Rb+pSCZzlMLF+e8N9CGqPyQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XHaEaFUQOF+4qDDgFUNqKNRVsQaMOde2m88FZ+223cdnpECCpUxgXVZbzyMXUq6onY/HCs060kKcQJMnVil5EDgJWC7xOAHOvEkX/ueUFqCO+xy8E1k3dQjfab9jAyH1Jo08c4773zIJM0by5L0Rr936fP+KEescL/7K0d7tu5BB5BsgChFi1SCP/aYRHJjE836zA97oydzRtAW+WZjRL9qpZKBTe03JGG3vhwelvg4dvekfJOSTalaXSgllUe4/Y4nXoc1ihM2PqM5nGevFmToy06QXueUJJvHoNUa+x/qYVihNVB55tS/LD7o/k+PE5aTRIxWB9hvdLM3U4o6TqGhaoWm02G5MfPQk/MLU4e39GJfBzLaMWg865pZZv1+mTGj7fOGIoI1urvzviuW3Ic1RW6nOb5fOvXfM/cAIZySc2kcRzSxgU4ywhe+GT+Q95TN456gr0XX/0H/fG3H6augJZqITMHrCEmyCOm2Qwe4KQDy7kLH6BdLYQPIMi3dTrQzvaLH6Dl2LqDuvOxbyPZGalDEuABpQH4BFnWE+7pqmVkwJtAjDmljz0R8Hm7gqEE/WXymoyhP7lAsZgYhJKejJ5t93z/ljpcdO/ucBGKs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eca2fa5-c40a-4ef6-15d6-08df43bb0e1f
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 08:24:38.6273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hmPFtTNNedYjt4LZqruL6dQ+iUzLn5b/4wvHWcKjfVkvKNI3csecpqfM4UoXM1kjCqrrz1NOFheceJOswsL1Xi2Sb2EYoeKQxWb73N4bFG0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB8216
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 spamscore=0 phishscore=0
 malwarescore=0 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2611040001 definitions=main-2611160033
X-Proofpoint-ORIG-GUID: cU3wPOOd0cCcmDrUVIzgXmfNmKIm-J0w
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDAzMyBTYWx0ZWRfX5O5Cikvbc5ho
 16IvmY6gjFyfW11ujdO2zl9+Sybjjc8TvxbQe/iHvOVphLUS93v/aFE6k9AVMB0ouIJUzDO/5VM
 jaYbR7TKpdip+nMeAkd/jQgdTCA4Vik51iXpVfr7gtLQUH8XN922
X-Authority-Analysis: v=2.4 cv=PeNqFShd c=1 sm=1 tr=0 ts=6afabdca b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=vggBfdFIAAAA:8
 a=WsHKUha7AAAA:8 a=7CQSdrXTAAAA:8 a=JfrnYn6hAAAA:8 a=pGLkceISAAAA:8
 a=Z4Rwk6OoAAAA:8 a=8I-d0BQ2-ZR2kSsu7fQA:9 a=WmVTiCyuxqgg3mnwYu6p:22
 a=H4LAKuo8djmI0KOkngUh:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=1CNFftbPRP8L7MoqJWF3:22
 a=HkZW87K1Qel5hWWM3VKY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDAzMyBTYWx0ZWRfX7RnyAn5elW8R
 6/NTTQegY3xGr1Yc9NQgtbwzibLQ1NG4qY8/CwnBHzpXKfxMUidy3XnmxZ3Ws6jSfi8TCSy5JyS
 G01Jlbqi0mmF2tBAQHp0FaZn0urJJQzNX8PHQFLYkPg8ET0V+u0MSlTT6zIoRS108wjbha6UB1A
 h2aMYKcYsEUG+mLjFwW0nmNIbfsMUhU7aA40YFEdeEIlmGpj24M+VwT1PfYsnHLitcHFTJS/c5l
 zx7CU+hn3c69eRHlEgcESaJ2daoJ0S4IaziHdZekebp3Bb/4ZLICYdD3yHtBUuMCe7OlEHezR+i
 r2KjD1qg9fGTnlytWXO0spvf4cJauG8CmQzrzAzXi22N0aFlKAVair9g+sw4/t+1CkwRFuZvWno
 lnfeGLH4bnUEVABRLzJf6pgo95ruJLwE8CVBuQQN/N2fQWCgBdqf5KoId4qJ9gPzDYHm7iayGfj
 s9OdMwd7Cd2PT/zctRg==
X-Proofpoint-GUID: cU3wPOOd0cCcmDrUVIzgXmfNmKIm-J0w

Hi,

Changes in this version address comments from Catalin and sashiko/bpf-bot [19].
The major change addresses build breakage in unrelated modules and changes the
exit path in __smp_cond_load_relaxed_timeout() to simplify providing ACQUIRE
semantics in smp_cond_load_acquire_timeout():

  - patch-1, "asm-generic: barrier: Add smp_cond_load_relaxed_timeout()"
   - expose the timeout state in __smp_cond_load_relaxed_timeout() so
     We use it later to provide acquire ordering for the timeout case in
     smp_cond_load_acquire_timeout().
   - Associate the kernel-doc comment with the actual barrier, not
     the helper.

  - patch-2, "arm64: barrier: Support smp_cond_load_relaxed_timeout()"
    - mark arch_timer_evtstrm_available() noinstr. This is needed
      because smp_cond_load_relaxed_timeout() will be called from a
      noinstr context via __cpuidle poll_idle().

  - patch-3, "arm64/delay: define arm64_wfet_deadline()"
    - keep nsecs_to_cycles(), usecs_to_cycles() local to lib/delay.c

  - patch-6, "asm-generic: barrier: Add smp_cond_load_acquire_timeout()",
    - The change in patch-1 allows us to provide full ACQUIRE ordering
      for the timeout case. Earlier versions had a possible (compiler
      dependeent) hole around the case where cond_expr becomes true
      simultaneously with timeout.

  - patch 14,15,16 "barrier: add tests for smp_cond_load_*_timeout()"
    - rename barrier-timeout-test.c to barrier_timeout_kunit.c

Haris Okaovic tested v15 [18] "Tested again on AWS Graviton3/4/5
(ARM Neoverse V1/V2/V3) with haltpoll changes atop latest master
8ab1afb2e: still seeing average 6% improvement across various workloads
(mysql, postgresql, cassandra, memcached) in latency sensitive
configuration.  The new unit tests all pass on both metal and virt
variants of the same machines. -- Haris"

Sahil tested v16 [20] (with the arm64 polling in idle series [21] on a
guest running on HyperV) and saw fairly significant guest latency, TPS
improvements in database workloads:
"Workload: PostgreSQL 16.15/pgbench scale 100, client and server in
the same VM over a unix socket, with single run:

            with (-S)                         TPC-B-like r/w
clients  base TPS  haltpoll lat avg   base TPS   haltpoll  lat avg
   2       38658     +89%   52->27us     5299     +86%    378->203us
   4       72987     +99%   55->28      10305     +87%    388->208
  16      300895     +91%   53->28      42035     +83%    381->208
  32      590987     +93%   55->28      78319     +85%    410->221
  64      987749      +0%   65->65     130675      +3%    490->474"

Possible reason for the improvement is lower wakeup latency, where
polling in idle allows us to not switch in and out of deeper idle states
or from the hypervisor (when run in a VM.)

A little more on this in the performance section below.

Motivation 
===
The core kernel often uses smp_cond_load_{relaxed,acquire}() to spin on
condition variables with architectural primitives used to avoid hammering
the relevant cachelines.

(This primitive can vary greatly across architectures: on x86 it's a
cpu_relax() to slow down the pipeline. On arm64, this is a __cmpwait()
which waits for a cacheline to change state in a time limited fashion.)

Regardless of architectural details, typical smp_cond_load*() usage
does not allow for termination until the condition change occurs.

Beyond the core kernel, there are cases where it is useful to additionally
terminate on a timeout. Two cases:

  - cpuidle poll_idle(): wait for need-resched until the cpuidle polling
    duration expires.

  - rqspinlock: nested qspinlock acquisition that terminates on timeout
    or deadlock.

Accordingly add two interfaces (with their generic and arm64 specific
implementations):

   smp_cond_load_relaxed_timeout(ptr, cond_expr, time_expr, timeout)
   smp_cond_load_acquire_timeout(ptr, cond_expr, time_expr, timeout)

Also add tif_need_resched_relaxed_wait() which wraps the polling
pattern and its scheduler specific details in poll_idle().
In addition add atomic_cond_read_*_timeout(),
atomic64_cond_read_*_timeout(), and atomic_long wrappers.

Structurally, both the smp_cond_load_*_timeout() interfaces are similar
to smp_cond_load*(), with the addition of a rate-limited time-check.

Usage
==

These interfaces drop straight-forwardly into the rqspinlock logic
since qspinlock already uses smp_cond_load*(), and the time-check
extension can now be used for timeout and deadlock handling.

Using tif_need_resched_relaxed_wait() in poll_idle() removes any
architectural details allowing arm64 to straight-forwardly support
that path.
(However, for efficiency reasons cpuidle/poll_state.c continues to
depend on ARCH_HAS_CPU_RELAX since that is defined on architectures
with an optimized architectural primitive.)


Performance
==

Apart from simplifications due to this change, supporting polling in
cpuidle on arm64 helps improve wakeup latency (needs a few cpuidle/acpi
patches):


  # perf stat -r 5 --cpu 4,5 -e task-clock,cycles,instructions,sched:sched_wake_idle_without_ipi \
     perf bench sched pipe -l 1000000 -c 4

  # No haltpoll (and, no TIF_POLLING_NRFLAG):

  Performance counter stats for 'CPU(s) 4,5' (5 runs):

         25,229.57 msec task-clock                       #    2.000 CPUs utilized               ( +-  7.75% )
    45,821,250,284      cycles                           #    1.816 GHz                         ( +- 10.07% )
    26,557,496,665      instructions                     #    0.58  insn per cycle              ( +-  0.21% )
                 0      sched:sched_wake_idle_without_ipi #    0.000 /sec

       12.615 +- 0.977 seconds time elapsed  ( +-  7.75% )


  # Haltpoll:

  Performance counter stats for 'CPU(s) 4,5' (5 runs):

         15,131.58 msec task-clock                       #    2.000 CPUs utilized               ( +- 10.00% )
    34,158,188,839      cycles                           #    2.257 GHz                         ( +-  6.91% )
    20,824,950,916      instructions                     #    0.61  insn per cycle              ( +-  0.09% )
         1,983,822      sched:sched_wake_idle_without_ipi #  131.105 K/sec                      ( +-  0.78% )

        7.566 +- 0.756 seconds time elapsed  ( +- 10.00% )

  We get improved latency because we don't switch in and out of a
  deeper sleep state or from the hypervisor. This also causes us to
  execute ~20% fewer instructions.


Changelog:
==

  v16 [19] (as above):
  - patch-1, "asm-generic: barrier: Add smp_cond_load_relaxed_timeout()"
   - expose the timeout state in __smp_cond_load_relaxed_timeout() so
     We use it later to provide acquire ordering for the timeout case in
     smp_cond_load_acquire_timeout().
   - Associate the kernel-doc comment with the actual barrier, not
     the helper.

  - patch-2, "arm64: barrier: Support smp_cond_load_relaxed_timeout()"
    - mark arch_timer_evtstrm_available() noinstr. This is needed
      because smp_cond_load_relaxed_timeout() will be called from a
      noinstr context via __cpuidle poll_idle().

  - patch-3, "arm64/delay: define arm64_wfet_deadline()"
    - keep nsecs_to_cycles(), usecs_to_cycles() local to lib/delay.c

  - patch-6, "asm-generic: barrier: Add smp_cond_load_acquire_timeout()",
    - The change in patch-1 allows us to provide full ACQUIRE ordering
      for the timeout case. Earlier versions had a possible (compiler
      dependeent) hole around the case where cond_expr becomes true
      simultaneously with timeout.

  - patch 14,15,16 "barrier: add tests for smp_cond_load_*_timeout()"
    - rename barrier-timeout-test.c to barrier_timeout_kunit.c

  v15 [17]:
   - patch-1, "asm-generic: barrier: Add smp_cond_load_relaxed_timeout()"
    - unify the exit path for the loop condition and timeout case
    - includes vdso/time64.h
    - document the timeout_ns == 0 case
    - use u64 for internal arithmetic

   - patch-3, "arm64/delay: move, fixup usecs_to_cycles()"
    - While moving USECS_TO_CYCLES() into the driver namespace also
      make it a static inline rpmh_usecs_to_cycles()

   - patch-6, "asm-generic: barrier: Add smp_cond_load_acquire_timeout()",
     - use the change in patch-1 to fixup, simplify the ACQUIRE path
     - thresh out the commit message a bit more

   - patch 14,15,16 "barrier: add tests for smp_cond_load_*_timeout()"
     - enclose the calls to smp_cond_load_{relaxed,acquire}_timeout()
       in preempt_disable(), preempt_enable().
     - WFET makes it difficult to use a synthetic timer. So skip
       timeout tests on configurations with WFET.


  v14 [16]:
    - patch-1, "asm-generic: barrier: Add smp_cond_load_relaxed_timeout()"
     - deferred time-check is now limited to a single usec.

     - smp_cond_load_relaxed_timeout() now enforces that the timeout_ns value
       does fit in s64.

     - SMP_TIMEOUT_POLL_COUNT is explicitly defined to 1 if the
       architecture provides a waiting implementation of cpu_poll_relax()
       (defines CPU_POLL_RELAX_WAITS).

    - patch-3, "arm64/delay: move, fixup usecs_to_cycles()"
      - convert the 32-bit arithmetic to use mul_u64_u64_shr() to avoid
        truncating large delay values.

      - make usecs_to_cycles(), nsecs_to_cycles() static inlines.

    - patch-6, "asm-generic: barrier: Add smp_cond_load_acquire_timeout()"
      - provide full acquire semantics (via smp_load_acquire()) in the
        failure path.

    - patch-16, "barrier: timeout validity checks for smp_cond_load_acquire_timeout()"
      - add some tests for clocks that can fail (rqspinlock like
       semantics)

  v13 [15]:
    - rename kconfig entry for the barrier kunit test to follow
      the kunit style guide
      (s/BARRIER_TIMEOUT_TEST/BARRIER_TIMEOUT_KUNIT_TEST)

    - make the kunit test be visible only if CONFIG_KUNIT_ALL_TESTS
      is not enabled.

    Both comments from Julian Braha.

  v12 [14]:
    - smp_cond_load_acquire_timeout() now only has acquire semantics in
      the success (non-timeout) case.

    - arm64 now does not define ARCH_HAS_CPU_RELAX as without also
      defining TIF_POLLING_NRFLAG, in some cases we end up with a
      degenerate version of poll_idle().

    - kunit: removed the test case for timeout=-1 (not supported)
      Also add test cases for timeout=0, timeout=1.

    (All of these address review comments from sashiko/bpf-bot.)

  v11 [13]:
    - addressed some review comments from sashiko (see commit notes)
      - The one notable change is to the implementation of
        smp_cond_load_acquire_timeout() where there was a missed
        control dependency in the timeout case.
      All the others are minor.
    - fixed a low probability race in the kunit test added in v11.
    - added a bunch of kunit tests validating the implementation's
      use of the clock.

  v10 [10]:
   - add a comment mentioning that smp_cond_load_relaxed_timeout() might
     be using architectural primitives that don't support MMIO.
     (David Laight, Catalin Marinas)
   - added a kunit test for smp_cond_load_relaxed_timeout() (Andrew
     Morton.)

  v9 [9]:
   - s/@cond/@cond_expr/ (Randy Dunlap)
   - Clarify that SMP_TIMEOUT_POLL_COUNT is only around memory
     addresses. (David Laight)
   - Add the missing config ARCH_HAS_CPU_RELAX in arch/arm64/Kconfig.
     (Catalin Marinas).
   - Switch to arch_counter_get_cntvct_stable() (via __delay_cycles())
     in the cmpwait path instead of using arch_timer_read_counter().
     (Catalin Marinas)

  v8 [0]:
   - Defer evaluation of @time_expr_ns to when we hit the slowpath.
      (comment from Alexei Starovoitov).

   - Mention that cpu_poll_relax() is better than raw CPU polling
     only where ARCH_HAS_CPU_RELAX is defined.
     - also define ARCH_HAS_CPU_RELAX for arm64.
      (Came out of a discussion with Will Deacon.)

   - Split out WFET and WFE handling. I was doing both of these
     in a common handler.
     (From Will Deacon and in an earlier revision by Catalin Marinas.)

   - Add mentions of atomic_cond_read_{relaxed,acquire}(),
     atomic_cond_read_{relaxed,acquire}_timeout() in
     Documentation/atomic_t.txt.

   - Use the BIT() macro to do the checking in tif_bitset_relaxed_wait().

   - Cleanup unnecessary assignments, casts etc in poll_idle().
     (From Rafael Wysocki.)

   - Fixup warnings from kernel build robot


  v7 [1]:
   - change the interface to separately provide the timeout. This is
     useful for supporting WFET and similar primitives which can do
     timed waiting (suggested by Arnd Bergmann).

   - Adapting rqspinlock code to this changed interface also
     necessitated allowing time_expr to fail.
   - rqspinlock changes to adapt to the new smp_cond_load_acquire_timeout().

   - add WFET support (suggested by Arnd Bergmann).
   - add support for atomic-long wrappers.
   - add a new scheduler interface tif_need_resched_relaxed_wait() which
     encapsulates the polling logic used by poll_idle().
     - interface suggested by (Rafael J. Wysocki).


  v6 [2]:
   - fixup missing timeout parameters in atomic64_cond_read_*_timeout()
   - remove a race between setting of TIF_NEED_RESCHED and the call to
     smp_cond_load_relaxed_timeout(). This would mean that dev->poll_time_limit
     would be set even if we hadn't spent any time waiting.
     (The original check compared against local_clock(), which would have been
     fine, but I was instead using a cheaper check against _TIF_NEED_RESCHED.)
   (Both from meta-CI bot)


  v5 [3]:
   - use cpu_poll_relax() instead of cpu_relax().
   - instead of defining an arm64 specific
     smp_cond_load_relaxed_timeout(), just define the appropriate
     cpu_poll_relax().
   - re-read the target pointer when we exit due to the time-check.
   - s/SMP_TIMEOUT_SPIN_COUNT/SMP_TIMEOUT_POLL_COUNT/
   (Suggested by Will Deacon)

   - add atomic_cond_read_*_timeout() and atomic64_cond_read_*_timeout()
     interfaces.
   - rqspinlock: use atomic_cond_read_acquire_timeout().
   - cpuidle: use smp_cond_load_relaxed_tiemout() for polling.
   (Suggested by Catalin Marinas)

   - rqspinlock: define SMP_TIMEOUT_POLL_COUNT to be 16k for non arm64


  v4 [4]:
    - naming change 's/timewait/timeout/'
    - resilient spinlocks: get rid of res_smp_cond_load_acquire_waiting()
      and fixup use of RES_CHECK_TIMEOUT().
    (Both suggested by Catalin Marinas)

  v3 [5]:
    - further interface simplifications (suggested by Catalin Marinas)

  v2 [6]:
    - simplified the interface (suggested by Catalin Marinas)
       - get rid of wait_policy, and a multitude of constants
       - adds a slack parameter
      This helped remove a fair amount of duplicated code duplication and in
      hindsight unnecessary constants.

  v1 [7]:
     - add wait_policy (coarse and fine)
     - derive spin-count etc at runtime instead of using arbitrary
       constants.

Haris Okanovic tested v4 of this series with poll_idle()/haltpoll patches. [8]

Comments appreciated!

Thanks
Ankur

 [0] https://lore.kernel.org/lkml/20251215044919.460086-1-ankur.a.arora@oracle.com/
 [1] https://lore.kernel.org/lkml/20251028053136.692462-1-ankur.a.arora@oracle.com/
 [2] https://lore.kernel.org/lkml/20250911034655.3916002-1-ankur.a.arora@oracle.com/
 [3] https://lore.kernel.org/lkml/20250911034655.3916002-1-ankur.a.arora@oracle.com/
 [4] https://lore.kernel.org/lkml/20250829080735.3598416-1-ankur.a.arora@oracle.com/
 [5] https://lore.kernel.org/lkml/20250627044805.945491-1-ankur.a.arora@oracle.com/
 [6] https://lore.kernel.org/lkml/20250502085223.1316925-1-ankur.a.arora@oracle.com/
 [7] https://lore.kernel.org/lkml/20250203214911.898276-1-ankur.a.arora@oracle.com/
 [8] https://lore.kernel.org/lkml/2cecbf7fb23ee83a4ce027e1be3f46f97efd585c.camel@amazon.com/
 [9] https://lore.kernel.org/lkml/20260209023153.2661784-1-ankur.a.arora@oracle.com/
 [10] https://lore.kernel.org/lkml/20260316013651.3225328-1-ankur.a.arora@oracle.com/
 [11] https://lore.kernel.org/lkml/20230809134837.GM212435@hirez.programming.kicks-ass.net/
 [12] https://lore.kernel.org/lkml/c6f3c8d3f1f2e89a9dc7ae22482973b5a51b08cb.camel@amazon.com/
 [13] https://lore.kernel.org/all/20260408122538.3610871-1-ankur.a.arora@oracle.com/#r
 [14] https://lore.kernel.org/all/20260608080440.127491-1-ankur.a.arora@oracle.com/
 [15] https://lore.kernel.org/all/20260702013334.140905-1-ankur.a.arora@oracle.com/
 [16] https://lore.kernel.org/all/20260714073041.40250-1-ankur.a.arora@oracle.com/
 [17] https://lore.kernel.org/all/20260831202251.305046-1-ankur.a.arora@oracle.com/
 [18] https://lore.kernel.org/all/178908146776.2725577.2613699832033292946.b4-review@b4/
 [19] https://lore.kernel.org/lkml/20261016070837.440748-1-ankur.a.arora@oracle.com/
 [20] https://lore.kernel.org/lkml/auLHZnaCIajW1kxX@kali/
 [21] https://lore.kernel.org/all/20250218213337.377987-1-ankur.a.arora@oracle.com/


Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: bpf@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-pm@vger.kernel.org


Ankur Arora (16):
  asm-generic: barrier: Add smp_cond_load_relaxed_timeout()
  arm64: barrier: Support smp_cond_load_relaxed_timeout()
  arm64/delay: define arm64_wfet_deadline()
  arm64: support WFET in smp_cond_load_relaxed_timeout()
  arm64: rqspinlock: Remove private copy of
    smp_cond_load_acquire_timewait()
  asm-generic: barrier: Add smp_cond_load_acquire_timeout()
  atomic: Add atomic_cond_read_*_timeout()
  locking/atomic: scripts: build atomic_long_cond_read_*_timeout()
  bpf/rqspinlock: switch check_timeout() to a clock interface
  bpf/rqspinlock: Use smp_cond_load_acquire_timeout()
  sched: add need-resched timed wait interface
  cpuidle/poll_state: Wait for need-resched via
    tif_need_resched_relaxed_wait()
  arm64/delay: enable testing smp_cond_load_relaxed_timeout()
  barrier: add tests for smp_cond_load_*_timeout()
  barrier: timeout validity checks for smp_cond_load_relaxed_timeout()
  barrier: timeout validity checks for smp_cond_load_acquire_timeout()

 Documentation/atomic_t.txt           |  14 +-
 arch/arm64/include/asm/arch_timer.h  |   2 +
 arch/arm64/include/asm/barrier.h     |  24 +++
 arch/arm64/include/asm/cmpxchg.h     |  64 ++++--
 arch/arm64/include/asm/rqspinlock.h  |  85 --------
 arch/arm64/lib/delay.c               |  38 +++-
 drivers/clocksource/arm_arch_timer.c |   4 +-
 drivers/cpuidle/poll_state.c         |  21 +-
 include/asm-generic/barrier.h        | 164 +++++++++++++++
 include/linux/atomic.h               |  10 +
 include/linux/atomic/atomic-long.h   |  18 +-
 include/linux/sched/idle.h           |  29 +++
 kernel/bpf/rqspinlock.c              |  78 ++++---
 lib/Kconfig.debug                    |  10 +
 lib/tests/Makefile                   |   1 +
 lib/tests/barrier_timeout_kunit.c    | 297 +++++++++++++++++++++++++++
 scripts/atomic/gen-atomic-long.sh    |  16 +-
 17 files changed, 704 insertions(+), 171 deletions(-)
 create mode 100644 lib/tests/barrier_timeout_kunit.c

-- 
2.43.7

