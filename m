Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0AF3EEADE;
	Tue, 14 Jul 2026 07:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784014302; cv=fail; b=rHV5gzK62Dy0chbw+XmAspxcSccoCrec7CLYs+fDrFlQxEzWF9QLco7Q2ozfWnGRGdnxtr0I8sGq/7ULxIxvJilDZOyA4N9pqE+YGgdHgHNHfwNr3OBTtYzKlpDVIn7dHk3MQhKGleqpvL5R+5JrenZIk0A65p8Twmw4dWYJFi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784014302; c=relaxed/simple;
	bh=rUMYliG4l8oZdUHHnMaHYXaPviR8pu5Oo2Ta5S4creA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hTYvQPnIfRTdo4pe6RFPzuBNYoFvEG+TjwCZpwBaLnm9BweQgpVjHMaz6FSqRD2pmNjcWhMdbC0/mfcl4TqC4d42ik3E11CYV3+uOsp9+cdcgPa4NgweExU+f7pnmM1X8Q/7iHOKnSWDiei2Cfk/RZuVfkAx3i3ANhjvBRqScl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hCr7WUCl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=f1enme8m; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hCr7WUCl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="f1enme8m"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DL3FKm1347283;
	Tue, 14 Jul 2026 07:31:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=QsHyDwbZDt14FavL1G1amq1dUCjoYT5O4o88+Pn2YyM=; b=
	hCr7WUClW1RXe54ke855hqwjWePKg0ZT3aoGti0quCldb208mBfxEZqKPlA6CZUe
	1urG52WpkdadCN3BiEjS6hL7+3yjG7mLLYB4KuUjX8ffTB1MeOYbm3DCq2O0iOac
	+o1STQN/N8iVrneBq0GWbmFK3hpU9X7IhbcayqjhNtSVShCJUDJ+Ehc44YuQQpN0
	OJR4/XHg301HVw1PE3bli0Sxk8nCu6sGtWOW0jXmJ5lnP9lcv//clxmJMEIVrW+j
	ng6Nx2aVh3EbiIZpdecAjCdXyspSuFGcXw4h9ik2m1oYCfIWPJN6TOKL8TP+nPfi
	3e4ubwa3WN9mEsooLA6Rvg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fbep33p3r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jul 2026 07:31:15 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66E7SAFK018837;
	Tue, 14 Jul 2026 07:31:14 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010065.outbound.protection.outlook.com [52.101.46.65])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4fbc9dg32r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jul 2026 07:31:13 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nlraNFB4DxaasLB+Rm8OwczHJ1O9+fDFVVcxV6rlwsAz4LbYvoo/MXHesBrYFBYEZM1AjGdlfXsdulR8CLIVWHFkXFveQOm/dOih+Ci+DlisQ7kQNQgMcCefDtSCLYqE3ZM9nQjeiEr/dgQKwsplOJzRrm1nrCdMiyt8BgKsWG3o2aWCU1GY3HJHFMMQafspcTt9t6uEk9qYlFRUJ/xvj+6A2uWR9CYSdGdcCLDWcvSExIsvJHkmi+Wqa1M/Dw2YdOjsVrdr/LcE+PYSSeC+/IRzyH72jorL/fThWqoxRUN6OkDSjski1HYHvfLPPdSTogmvrtdDnew3Y1eaW/vGBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QsHyDwbZDt14FavL1G1amq1dUCjoYT5O4o88+Pn2YyM=;
 b=HXqr4X3f1YG3HzU2ebl7qXJrPi3jv92DZLR4BDTqaYthWd4yruz8rgPfMnDvfxvuk5MhBe75UFNJ7Wz873mlC3gVrZQT4Qu2bgThF1DWTLNm/AIzSz7I9ohsTVCD28p/ojLGu1bi5rEPCIjhkqF0Hpb6d5k36xZEyQLpx1spFtpLZsehPA9Mr5zWAeQek17uW2OvKD3QMr6xmh0i8sHdlc24Bi6/nwUU7R/k1hpXjxS7Bd0y87UcEtmTKW5CYZNCzKh9F3EijETofJI812oOjT9Vu0dTcLv9OO6LXIvIHpAKWmnVZMChfOLL8fQ1uCyP8EYP2gypxoYmbMJkZXShoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QsHyDwbZDt14FavL1G1amq1dUCjoYT5O4o88+Pn2YyM=;
 b=f1enme8mKLbyz3YhpTwdfe0NjvxUokWxy6pJpj7pEVjiZu1Cy9hiAFwtq7206k7x4V//8lkOoVDAqitlMuIA1b9o9l8QmY46Fei5FGICidMMzT0kCIGgj3yc04dlZHYJKZ2p3Go5NBorQaBrt1cFyKO8pCFu7HlHDAa2XNRdlVk=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CY8PR10MB7124.namprd10.prod.outlook.com (2603:10b6:930:75::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 07:31:09 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.21.0202.018; Tue, 14 Jul 2026
 07:31:09 +0000
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
        Ankur Arora <ankur.a.arora@oracle.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH v14 07/15] atomic: Add atomic_cond_read_*_timeout()
Date: Tue, 14 Jul 2026 00:30:33 -0700
Message-Id: <20260714073041.40250-8-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260714073041.40250-1-ankur.a.arora@oracle.com>
References: <20260714073041.40250-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0107.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::20) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CY8PR10MB7124:EE_
X-MS-Office365-Filtering-Correlation-Id: 40fc4a7f-3267-4e68-c154-08dee179df89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	cFRTqhA7CsGpQrwc6h39XowRdZ/YC+cwOhfoZFRhGHme5WrS5tfieCFjLQZ06prQ2/8PmFc64jRW7mhoKI4p39omUJkm1b9JrUi4aWClFmfw1qWTU2xyWwM+lWKiWvR7hmNKf9xDB461noNXK2J19KPw/saiFOykOWy3Uba1FXoxu1L8tD6vy5/i7DTrcwIuSsBKraHOG0jT1JzETN7A9n5oFxDM+LoUQiUt0uuS9BMRzZNZiytHa8MgjFVhHyFoZqCUZFxXVW01pPxU1wIt3Mf4nBqkahj75QUg2HTRgYwJYnnQDI3+sI/uLBZFWW89ClLjaMsGl5kzvzSas76CDXx2z82IeYKy/zaWPnIHmc8RJvu1DuSWFR1LlgJQ71DmQZM9V3fPz1S5loDyuki+eOFQn5GqZvifLHCrvlgCcjOcRYw9jUE3IY3tqsHz+QzhFJSehJudj7Yn3Vu5z54s1MFG5m8qIhm8uYBAFSu0O+jeBifzz1d1LqxpH0zfK0ByoyOq2z/A9TYg5Y6LGjUr1hjUj98pIjJEl3a6S8wkcVJ0zQe2C1dDrl4qEzS0ZxoAXEPRN48i4qL057t6BxdN4WXe7sR/g1dm/E7DGKaQsss86UB7JSl7dYTvd5Ynjr1jeukM0HHMUggOkxMqWsYDIRDkbx37xmSctdFw3apj2wA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Cwr8GRAzDRl/9gfX9dtmhe9thD0KVwG5FULSIQ69pKu1psNxzl1cwbtaOZJu?=
 =?us-ascii?Q?uQlCN9eQF6fRlSupadzMnsc3QEx9LOYT3zoPUkDi6YVlt6vK+zFeKp+3A32M?=
 =?us-ascii?Q?au54AKVEp9xDDmeymuCcxeQsj/SbiPiqLx6jIVYlMkUdkEh46lU7FdC2eHWy?=
 =?us-ascii?Q?aZJcvHif+sK8HbLMa/m1LIi8JJuDijx0UhWYOdRU6eSVSC+BUR+cODCJgDEu?=
 =?us-ascii?Q?Jcx68Tg02zTYG8VfSkkc+DaUpY0s5deBWrlen3qs2X3OtzyDa7rkaxaLg6sY?=
 =?us-ascii?Q?XvvJf78x9hvffYB6Zgtke0WlKD1xHA/iwzhPJrGHX7R8GKEzkAVe5fFZh/D/?=
 =?us-ascii?Q?Xzk/ZWjhptUeVBdnXTVdqggOezgl49qo6xj85CQtBGWqT881gsOHAULN9Vr0?=
 =?us-ascii?Q?5JZKM4OpqeyM08eYTSeYcSOpPhMu4AddVITIgGkYEOQfBwzPUhhT7Fr+s8Ma?=
 =?us-ascii?Q?6RHx0YyC4R8P1jhntwp7n5VVglWuqQO3uhzNilq4himQP7GwFe+so3bpgFzm?=
 =?us-ascii?Q?7GYCrOp8A91ZWlqryXkZOptOvV1qB4AExRPKlAjgW+GwmKKFrgl25lCk0YL+?=
 =?us-ascii?Q?kmCqmwsqgmQE6W3+rYzp0XegHjPbZ4gW9SZuM7AUqIgX1jgBh2r//LBk7HQt?=
 =?us-ascii?Q?25asYdxIMIb5dGQ2i1/MJjyDVlU59a96TBDfOC9MAvYJVLa8rbmbN110wxrL?=
 =?us-ascii?Q?McvT27Yec+6IPMlknUh9vt2tkQRlLcJDPtZl8j3QRKVIyBvgZS6Vqbi/I+Vb?=
 =?us-ascii?Q?0JerUA5O6Ch99pN0r/v1rNnM/OQOleU3E0ejoT3FHz+zL2yQA4yPUkapaWVn?=
 =?us-ascii?Q?9G0q4VNmf72DyBshauH8yuETP2lCqJ4iaL+cIAAIDDhWewPWmI6NYB9hvJt0?=
 =?us-ascii?Q?YctJ5Do9CIYnlUo4Ko1DaQlMH46PqZRRpYIn9GZdAAvH1RF41rLQZq2dHVPw?=
 =?us-ascii?Q?eHT2QziorEZPlLj+W0fHknGD0ZqTbN3hwbIUKIXzUWXhHksS+GhoTBR/Xpwq?=
 =?us-ascii?Q?ajf5qKnKn++gSV+AdSGNWQAKeoAJNKHH5LHEoFl4DPAr1iC5wCLbnkJcPI2M?=
 =?us-ascii?Q?MIrLAXlga8OcbAu4FCXzlVmIen1zP4r6y2QK3T4GEw89tmd8IEFwyvMQ4rL4?=
 =?us-ascii?Q?lCQlpuI7XXzWHq/1BoG1OPei9C8LH/rHGAlmi+3H9FgF6D2EOHVldByr5jRO?=
 =?us-ascii?Q?0sDBF7H89S1q6lDfOs4uPRBx+2C1Tvxdnu8oGMfKcU1rF1gVTk6CjhJ8psI/?=
 =?us-ascii?Q?lsmGkOQU3NA7UH7ihtneC8FDAtIVt5AMrEYCacw9EIw4Xkj7uOQodSYPhYeu?=
 =?us-ascii?Q?smrZBVMAe05MP7KXeD9xWTO+2PNvTW2BTxec3YcCsQoeb4KW4B6VEH5GKtAI?=
 =?us-ascii?Q?ixL9xROsaEtToneW0EGS/GUM+u66NfI51E9hxNKcJ/J6GpmTHE1cgnTLjBce?=
 =?us-ascii?Q?6iQfd2ZIoMSw3627wX/zfBm6cjYlkDAqUJbEeIKK92skCW6/9PfxG21uk5Wy?=
 =?us-ascii?Q?bHFmOjDphPp1CElhu5G7bndvsxJflktEfvPXv2qNcPmZSoOmiw5iTZLMEn6f?=
 =?us-ascii?Q?zQByAYDOFvJk57ufi4hKhqYLFUkIxwcRZO/o1tSocIqrUn9m7kjKkHSKuvcU?=
 =?us-ascii?Q?FMcMIur+a9FbRPMfx6tPYHItw6l7af6B2vW6IjLgf131E0Gv9fNziZ3WmogP?=
 =?us-ascii?Q?D7spqwSOIELDkvna0MuHvqvgXBQZ5IwjmFhD200sM3vZAsIKRobelLYB9r7w?=
 =?us-ascii?Q?VgaDTYTFW8d/xkOk7pn4aO5ZTsMNt/w=3D?=
X-Exchange-RoutingPolicyChecked:
	D++y7SscGFhXGyqdk8hCTJVvuElBkTpezKjGttY134pMM1Sa7hr22ptgGakX6x/FH5DzvgPHTnfSfrNpGqdWlP9cCAIuTChKNZIdALJhWIwitOg5hD8afMQEYKEkmiW5n12a/LMdG0nAnydwWxT6jkR5JEnfIQMVFMgjxVOuq5HOb8Gzf7pu6pqpoJzsbnrjEcWYU/oW6xpcNpYEZGrNp9N0n+JPRtmSA5jqKWaOCdxCTmGFQKnvsXUO5x9s/LNlYPAQsiQ5XlYuaEevhMQ0S7pBecoGNp25n+tS5La9nZarb4uqLiEiW3leG1xtMJDlmaGI8BWddPgwX7gygsliog==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DB39HeTyFJjgb+06LpnKmObIZhJ65nzvPmRCxkCINjI973mhScnI5NkJ9xh4d/FeR33pGVM7rhW/jEo/LwuZTtay+6x5+RUWftqMv1nme0bjYz7+BAJ1vnNJhyUQSdk9EA6CYA+SRF/2dQO3oLjKW9Pt1gzeAhmMNZnRL+XFCZPcUBoUa8bmD3U9bRwxKHqayA7179yd5fzy02DYhZNit8A/t8qCFJjGzjmoVIqRtutfxstrbci1NVKMGgzwyfm4NVPDlIC4XUWxVqfPvFC1vJA2UcpSx45+ELbdOoCdT+18Rna8iPm66dkFanThBGIGRit5zav9PwQ8JXNjLWBoxwYHoUfmZDrdftMhxdigZYKGHBd4bzlN36CSQv3KqiGGi+JI5v7ai+9j9YIYDWswyJREBAti5ZKP8tBkW+W96ogptZqC2mwQeR+93ZdQgeVbGeHyYKEEHBNZSRr0y8bOSR/Ut/DhneGlod8z3jchFzlmG1Bh2pPAfvu14JS2gZmA/W2ZOeUKZzC2ricSEZV4dJTYPlAn9lddTsk2r8axQ7twIIgP3ycBMWtUxzvEt+CTYDtxnNjziks8frerlTpyHQZMYrIqBv3QmkbULOYL3G8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40fc4a7f-3267-4e68-c154-08dee179df89
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 07:31:09.2587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: whhOT1R8JYEAyr020GaKlWTy9t9JiqYrF7o3R1SHYGPn/S2zpweLgsgnINTuhb19GBGIwHqZdmm441gn5GQ6tr+zvbG0wxMqXRZEsreDqPw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7124
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0
 malwarescore=0 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2607140076
X-Proofpoint-GUID: y3JdFC5T-SvmajI9z3AqTFBGrn1VpVo2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDA3NiBTYWx0ZWRfX7WkbdeCxW3DD
 QCq2XsdD0qNgnh0HMb5DDpup29hnfd0K3cSqpWuRsylpBpS/lTod+hZ7q17f0ZggcPiLS1VFHtJ
 ZOxfqCcc7IWra2JzrvzHVXaC7UtaHQ4w/ZU3Im0Ea13RQSZ7ods5
X-Proofpoint-ORIG-GUID: y3JdFC5T-SvmajI9z3AqTFBGrn1VpVo2
X-Authority-Analysis: v=2.4 cv=dYawG3Xe c=1 sm=1 tr=0 ts=6a55e5c3 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=pGLkceISAAAA:8
 a=7CQSdrXTAAAA:8 a=yPCof4ZbAAAA:8 a=RgR6v_fFY-8vhBXvnRcA:9
 a=1CNFftbPRP8L7MoqJWF3:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDA3NiBTYWx0ZWRfX3fDYhQj9L2ro
 xNP+2JHoDQPddiRSpFSa8eD5tKsVC4/FOMlYksQYyqdEyyaGZVVwwL6yZPUpDx+PeHfukeWprfS
 AlFJayWo4F2LSlWk+jTYzq5TS4b+89o3hZWsH/J8dcuOMX+Yl1g4MwdsTGQv5EGaSV9a8Pq1zi0
 aOLzvyqfqoQo7OG7WtbFmvQAiAPbYqI+/ZWt2Glki2jGdwcwG5wdm50n0+BQuIbIStH1sekrTOS
 SI2IZrkiCSB9DmNPcgYP1Kx5EpF1dRpbv8yOSMAtnjtBoGtAYNqmaa0yM3Ws5NOs1aLLIIHIoIG
 9D7SZ9yZRbzRj/uubEpfhy8nzmzKb/S99LVvXaFIESHc5FfMINON+DRnl0/NFHa+bCy36YFT+6D
 GqCR3BcYMtSpPtK/jMcaq5hezbmDm4K9dGHR3eXPQixlPkwd8XK1YMuH6mQtd3Tb9MiDQNiusF+
 xJdwivh84wGAaGA1h+g==

Add atomic load wrappers, atomic_cond_read_*_timeout() and
atomic64_cond_read_*_timeout() for the cond-load timeout interfaces.

Also add a short description for the atomic_cond_read_{relaxed,acquire}(),
and the atomic_cond_read_{relaxed,acquire}_timeout() interfaces.

Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 Documentation/atomic_t.txt | 14 +++++++++-----
 include/linux/atomic.h     | 10 ++++++++++
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/Documentation/atomic_t.txt b/Documentation/atomic_t.txt
index bee3b1bca9a7..0e53f6ccb558 100644
--- a/Documentation/atomic_t.txt
+++ b/Documentation/atomic_t.txt
@@ -16,6 +16,10 @@ Non-RMW ops:
   atomic_read(), atomic_set()
   atomic_read_acquire(), atomic_set_release()
 
+Non-RMW, non-atomic_t ops:
+
+  atomic_cond_read_{relaxed,acquire}()
+  atomic_cond_read_{relaxed,acquire}_timeout()
 
 RMW atomic operations:
 
@@ -79,11 +83,11 @@ SEMANTICS
 
 Non-RMW ops:
 
-The non-RMW ops are (typically) regular LOADs and STOREs and are canonically
-implemented using READ_ONCE(), WRITE_ONCE(), smp_load_acquire() and
-smp_store_release() respectively. Therefore, if you find yourself only using
-the Non-RMW operations of atomic_t, you do not in fact need atomic_t at all
-and are doing it wrong.
+The non-RMW ops are (typically) regular, or conditional LOADs and STOREs and
+are canonically implemented using READ_ONCE(), WRITE_ONCE(),
+smp_load_acquire() and smp_store_release() respectively. Therefore, if you
+find yourself only using the Non-RMW operations of atomic_t, you do not in
+fact need atomic_t at all and are doing it wrong.
 
 A note for the implementation of atomic_set{}() is that it must not break the
 atomicity of the RMW ops. That is:
diff --git a/include/linux/atomic.h b/include/linux/atomic.h
index 8dd57c3a99e9..5bcb86e07784 100644
--- a/include/linux/atomic.h
+++ b/include/linux/atomic.h
@@ -31,6 +31,16 @@
 #define atomic64_cond_read_acquire(v, c) smp_cond_load_acquire(&(v)->counter, (c))
 #define atomic64_cond_read_relaxed(v, c) smp_cond_load_relaxed(&(v)->counter, (c))
 
+#define atomic_cond_read_acquire_timeout(v, c, e, t) \
+	smp_cond_load_acquire_timeout(&(v)->counter, (c), (e), (t))
+#define atomic_cond_read_relaxed_timeout(v, c, e, t) \
+	smp_cond_load_relaxed_timeout(&(v)->counter, (c), (e), (t))
+
+#define atomic64_cond_read_acquire_timeout(v, c, e, t) \
+	smp_cond_load_acquire_timeout(&(v)->counter, (c), (e), (t))
+#define atomic64_cond_read_relaxed_timeout(v, c, e, t) \
+	smp_cond_load_relaxed_timeout(&(v)->counter, (c), (e), (t))
+
 /*
  * The idea here is to build acquire/release variants by adding explicit
  * barriers on top of the relaxed variant. In the case where the relaxed
-- 
2.43.7

