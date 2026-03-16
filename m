Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9FB242D89;
	Mon, 16 Mar 2026 01:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773625071; cv=fail; b=HPdZek7SUFD30PflsAnzMx8SRGFTeuEF6bwHJX5LpWxh0c/nl7CcfOFh3OVlSE2/Jil0qf7ex4fHwJgGe9elpUcJpTeVe+aczmxlUkwF7iHzmvuIgTGjaVnlkwL0byZxWUvOO8lrDarawEDhQUav1IT63U2L8ur6seoYdUFleCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773625071; c=relaxed/simple;
	bh=ddDQUstGPfCpw9VielCXeEbHWISOrBDeo0ioTRi+sB0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oAGlxbvfBDWKXTnmSw6z4ERZztM5UxDFWP3JMVsoFT+zvRTAdOdWSw2I3C6cwRl27hnXHjJVNcOT29vVawsIUjgDdJCw3gv1hY2gw+4yTUyWrh3X6kE30mSlpZbe5AlMTvuo7au2j7BlAgFwF16M/Ll01KvDwx4y0nfeDXkAH5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cQcUBqN0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vMWHPbwz; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cQcUBqN0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vMWHPbwz"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62FMwfjL1206614;
	Mon, 16 Mar 2026 01:37:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=f/oncL/JS2UoPqdPeIQEv0Ruy36MiTkFJvqL9baTQhQ=; b=
	cQcUBqN0XqLhUmn/gBdsOurfJr8M4tc11gH8TfIUm9MX9yCdOvY8+v95nS8xtxRy
	uG0CGu96dql9N5GtwiJ/CGISYpumOiBo2qqHBLYFW8xpTA1mkvJx5hDChy2wbi6+
	cN80+v3FqiQJ6LhOFmsPpAsl+kX3joy7qHlkI8NS6VUO1mA09gG9/kWl/q2Svmbs
	0eCUo3eVLUbSZUsxrqmBqQOx22+FOiJU5buvhJqUAXjYx2mVz8vHbng3fDrL2Hfd
	eXKG8JlOQ/07tDC94Qksfr71pfA82YkvDr3uBlYp0ClZ8UwzXWD5akTIbgy+ol3M
	3hvTeF7i6/RoCCWBQuPELQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cvx3b1bhc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 01:37:06 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62FLlQHV002861;
	Mon, 16 Mar 2026 01:37:05 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012018.outbound.protection.outlook.com [52.101.43.18])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4cvx4j84md-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 01:37:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zn8NC8+TnFy3GcVSAPTf8ORh3OvYm9rK3h/Xcie8cDJO7lDDkYt1Ji7qKMiokamL1XMaCoXk1lOa964rCRyolUj2xVVOjBUQ4do+3M2XanSzFbIkt99u9+iTjach680I3nIdpAvYUb7oCHhRj6PvpAczMQm2Z6rtLikkPFWp+L3dPjwJBCwK7Ik/8V2BCT7y05ujCVK3svSFKiuob0pYCigHGjWqugwQCAkC/xa47szH7EtyNWJzQSfA6EcXZcm8rvEhiKcWOXykHwTWgXuubymeHQOaYMjwBq1TG0M4K+l65XGosK09/CDsbIYDAvOJ+YHr5VNs4I5THz1/swKhoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f/oncL/JS2UoPqdPeIQEv0Ruy36MiTkFJvqL9baTQhQ=;
 b=TszvZ778CZEivuCztOVICmXYCI9wDkSg3iOWcCVeD9qc10tH5DsFSa4fAms04NWh8KNE1CO1BseC/mYwnPO5k6jzkgTFA4z0pNgZ+Hrf+lw9t7FYRaNHMdXcoYNGDB0OUqI8qfY+hayWKWAyVzCj6KBy0STaonf7KO/n7OX/fdkXiYjxbz7Tk07+iSlBvLGCIBGhuQ+1/k1f5fCSmhUN9bPFkgKyxRPqAOko9ZED5BZe7QaAm+IMp5+pSw8jEF7zZxe05pQVS0TKpHH+YHURyr3w40dC7SbG2yG+S0Wrwkm/g1NkcjWpLZhocCOKNtQtumI6XneTHWYK9h9DpxMVqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f/oncL/JS2UoPqdPeIQEv0Ruy36MiTkFJvqL9baTQhQ=;
 b=vMWHPbwzgWV2JUD5qKlCQTaDHQMi5pwL7stRgpaVjKSZP7u68BOdKytm2HgtlfeCn3ZwxvRrPuqYO+2v4pTOPK0AUS9+1xbXnu4LN8tszZWqZeQP5D+/Myw5YlkPu4wRTnBFCUymsfBsywCCsddOPirfJdLgi0D0gd05SrL2MY4=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by IA0PR10MB7372.namprd10.prod.outlook.com (2603:10b6:208:40f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Mon, 16 Mar
 2026 01:36:57 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.20.9700.022; Mon, 16 Mar 2026
 01:36:57 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        bpf@vger.kernel.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, memxor@gmail.com, zhenglifeng1@huawei.com,
        xueshuai@linux.alibaba.com, rdunlap@infradead.org,
        david.laight.linux@gmail.com, joao.m.martins@oracle.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        Ankur Arora <ankur.a.arora@oracle.com>
Subject: [PATCH v10 02/12] arm64: barrier: Support smp_cond_load_relaxed_timeout()
Date: Sun, 15 Mar 2026 18:36:41 -0700
Message-Id: <20260316013651.3225328-3-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260316013651.3225328-1-ankur.a.arora@oracle.com>
References: <20260316013651.3225328-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0308.namprd04.prod.outlook.com
 (2603:10b6:303:82::13) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|IA0PR10MB7372:EE_
X-MS-Office365-Filtering-Correlation-Id: 1707bfb5-9a99-4848-1384-08de82fc82c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	XDTdeGsNn/KnEGmxDk91Rh7gdM5Y4j+NeoDNVuwt41tBKdbbJDYmGdsthQrZyfxHYR0RRYAAHKK2qefR4SHYdIY/5L+nEfT+4/XELJX8HDzSdYElFlcxLpXTBs1EL+vomx9q5cLHuSrsGQTzcJEgPuX6reJc8NLt0rrlSRniZfpanWBIh0La/NPSqBFN3vX2KA9sLXleObZYcfvQ/1P9Hpf5sXxO6sw+uzYW9VwdMlxRsXBPHEwozliG9i8Vuigp6wEqswyrI5jqY2LVLnmFlNmxvNEQpwu3x4zYfycN4Q/sSVkFTD6OnNOANLwCKKOyPpUYJlwbpOdjpOIi6mEBNHWUG1YmMSZB13OBIC6AYI3W6DFSoikui5xRfVAPMZOemVHs4Jn7xJD9Vx2SuPAoN/zl0/wo5EbCK8noX4zioiANCrSNDFJa+8YHZtbumuLSXPnTw4Mo05FPnXwzggWCbgtSYv1OrKBIp0HxGXBneAk7061BGZ7nJZzNGen+991SyfHSffxTmMh/B37P6K2fzixlO6SCioHt7FeL6hFa8P3Xy9MiRQQgpy4m/bOLbXtEYvcxYzi2M9nQQJRzI1Cb+m30i89fFxvZWgwsnzza62qhvd18PDyjf2/srwJdV3Jr6afKce1Yae1mtOBXp6FlHT/Gb8aQDQJLkgH7FFqWsQkEZvBx1kIaFck+h1P/Np8ZaGfr98Ol0Mbsot414i2XBmLeC0D8aQwvamHXR4tSv2M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TlSvyz65vnqmlEkX0HlgGYgAJ5SpcYMX63405hQS26a9T9tAWjpAKgXpSK90?=
 =?us-ascii?Q?5vsFGSD8Yrg8vqCXkZot5UjSvqOZbKUE/LODl40MmSI+bMhw1e7sEHp4Ha0V?=
 =?us-ascii?Q?E2wQYZklE0EPhh4c+IMYaLb6Ci8arJk2Fir4JAuAfDzmQZo8KpXZczKRfqbY?=
 =?us-ascii?Q?CkdqkLAOqUjFCVL16elrSkRvCp+8LGwboO9Mz83coXO8fSeB6pNY+xNkZ1Q8?=
 =?us-ascii?Q?mlbx9Qa4HNIYgMwsxSXtSfw2RmOduG5mGCp0k7Ks2Ga1XIcmIjrw8+CtHFrV?=
 =?us-ascii?Q?qUasEeWPPnGWO9ac5do6n/i4YnccMdea/y1HbJ3/xSeYvIDUWQD9ANm2E7Vh?=
 =?us-ascii?Q?eDKWDwPR9BF/vdv1Y8Xf55GQ5MUW/7iwzSiDSQlscjIluYQxpBcAVeZXj78g?=
 =?us-ascii?Q?Nv9Sniluta9TLFsJVlWrADs1W4wYUkkE495ne4iabNhuI0CZp+m3IWfApM1c?=
 =?us-ascii?Q?dVIi0o9Agk2k21ryXxZPvpmPHKF+QZrX7HwFi1GzdYSuPlrQwCzYBX/TW1b/?=
 =?us-ascii?Q?uJtp41OlxWV3g8/fBD6Hi80z5E121X2zPJre1afyzp4REPhyKruT1jtvHPQT?=
 =?us-ascii?Q?Iw9xWRoZ4r+pHxiERlYe68Kqr4m30EOikdX2VLicL8GQxbHjDrTaXPqaXsbE?=
 =?us-ascii?Q?wn80HUpPtKgFNdWkWxQTNWvhA/ac3u2TUjCcORkBLU91TdzaNwjMv/mOrvAP?=
 =?us-ascii?Q?AOC5KLfWtZ9xAPFGuyF4DV51kvkjgDzy+eIysWEFpbHfJTol0p7aT6rnG3Zd?=
 =?us-ascii?Q?E5ieRN7xR1OoACY0eU8YPK7mo0ekRlAjGLS35sJP+yYTdBR2NdElQqhwssT3?=
 =?us-ascii?Q?xcKBSvK/PooKnOVK3jbImvyr68q4lNVgX8m7qQHvynr81gJoXCYXNMQpX76l?=
 =?us-ascii?Q?B/jxG4F9mByGZa82ZELXyZ5eJcLT3zY3THBqo5Yr+zwEl3dp8PcaqPdAntaa?=
 =?us-ascii?Q?HnOxQh6CaOYqJ0uaypdvvPIRxVL+JER+ZTa3jxwAz/z6Tb/SBWzBB7/56/lc?=
 =?us-ascii?Q?/ZEyu2pD0GsHzwa5QQFCGstsb+iYppkbdc2o7nx/4jzGrKOseCZnKKeixGNs?=
 =?us-ascii?Q?CXTskYNRNP4kt1I3K0RuARJDYJLC6kUtz+8lvkUeS7tsE0JsD83Y4E3TWCtB?=
 =?us-ascii?Q?LVzVHeEUf+CwN0OidhPDj93uoih1sUjH8DRChFIr94ybD6nkzzUrHz4sXbMD?=
 =?us-ascii?Q?Xk4N42yTVvVdlZdbtuFnh1Xb3T6rpRo/VjW7nLVwHYIa9miPVdsQD56MQwt/?=
 =?us-ascii?Q?Opu+k+LAE8m5Z704pUMYQ60ClSafg7YKf2nfIy7x9koNw0xEkSR7ywBlP381?=
 =?us-ascii?Q?4A9hVY/TzE+IJpcF3j/yGWAsA/x/I3mhqrLj3TCCUSyHEz6/H8YzGGX8KOsH?=
 =?us-ascii?Q?H35l6RxtPwg/gYhnrC0YQKSkIv7+EsV0lYOkcBJgmUkpTEM6XdE1CXORzX92?=
 =?us-ascii?Q?Mxg9qGUSEBXVmDsBxpSn4Rup0a/HCcIcXPeG3J20rxrODAcmkihKRgkfhjgh?=
 =?us-ascii?Q?/gJtcGyk5zQS/DN4E3a1fHZwIdzkUKYl+xNJs7ev9paFvnRXdtsWEbLNrZ89?=
 =?us-ascii?Q?NWsz/BIBZijUYeayl2oDet4kyAWGNrzLKxbSrI87/DzdrScEQnLhgVKAgM3d?=
 =?us-ascii?Q?yyKafbYtxiwHVDXrUc0cHtqj9UEwGLvfTK4OVtdOawWcphhxvsoX946GdA8y?=
 =?us-ascii?Q?FTm455Dgl/3QD/Tqpq3JQ6ob5MIUAqJwB4mBgFZKJmygCISvG2lPvP7l0Xlk?=
 =?us-ascii?Q?UQaAp6cV/lfteEfLNgSWHX3g4VzWS7c=3D?=
X-Exchange-RoutingPolicyChecked:
	p8N1gE4kNm6JJffRObiX9eEgwZRhLNnWNA0VZeKQTCuS5pTPeIXw2KNBvvrt8ZntWHyKu+Z2ruZbICuPLy4mbNMtEHXcP7pZ8USEk2M6RI8nEpR7QDvNFy51zZ8J745tKzwlE6TKGxcQFAzcCrTDDgpzGsFZXX2xiKBJKdIA+dYTviIggIcpCi6EaoboR9uVKVcqNWLDV2HBlcvKD/8DE8gJ/xq+AksuuN2u/xyaN5NbP4KzDNFq9a6qhA8rEwNrNgKnkqxFzBz6TUXMyMckGesphGXSSkAxZgHb3dhURCyMRtFRalhEDmvAwvfDSNcYYZidikKHxyTtl90v4Qrxyg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	X5XbbHns0/cnPYK0vT2ljPHHbuNxyjJRkk0fWt7y0GbUNhmhDEAG2Rf0Mt60X8/9375JnLSTg0+/7A+RUxOvIFAb1IJmMWpV65KcGn6Ab+NkuqF99jQv/9DkhzGl86NUwsoJx4BI+kq3/v3nWpN0aHbVrWu6gLGKcIqRUITrm1yXrizjYcNyMfbjGXpjLO0OUfAQ35EIEvy3CyqFGliwR0Znn+7eiSCJK4yhEHZPFWX4p3JeQGUedbH7snai0bd9K4UzCeGIL4dbSVppuGAPaKtN+XrAEnaoKnmwT6uIDEzLAvclaIAJ9jw52WtxKXQgwdXW05j5PpsGP3vTRBCa8vk6mfGOiJ3cqe3aVsyfePV/80jtZ/r4ryNk/P5yViW85pcqvyMMS4vBnvLM2s2vXHCNysrQ+EWRyecKwghxKD7PBLM3+vpNvDpNrZAbuado5N3DTmE0/b3axhLRyYdE18teMDzft0k0vvanQ6sXgFNfbqWwLm2Y7Hm1m+dCTVvQ3jTIX8Hv/iaq5jmA3Qu5NBWSsenhBB9mIJ40nhoVx6wDXVtQkZlO2aH6H/HIrUWODGQdInImYdp+mHkslw/u6pu0OAVyNfN8sUJMliTLEiM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1707bfb5-9a99-4848-1384-08de82fc82c3
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 01:36:57.2002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dqv5uQfoGYVt6ivOf0yHRGAkfSS0kW47LYhOAIfkzGBVZWyrXMe65EcxQaKVqcTNZjq5j0TTbOBE5yK0wJ22eFLzSwa6IjLPcPXdlzF68g8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7372
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_01,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 spamscore=0
 adultscore=0 malwarescore=0 mlxlogscore=902 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603160010
X-Proofpoint-GUID: adZSnvkL5tZJ8g4oPzEXQfFf5geemfzD
X-Proofpoint-ORIG-GUID: adZSnvkL5tZJ8g4oPzEXQfFf5geemfzD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDAxMSBTYWx0ZWRfXxjq+5hHW/gW4
 SXrFAVl8uiGtp17mN5G0e/dbCoAzD/SW/SuLjDZzKslPSVMinbCWKm/1VNAsK91ULU4J/O3KyEf
 HkMHLjutcvhWZq0Fa9UhZegOmAmXT/UwFSu3jpOhRJoq2U1pUsd39yDgAURo9l92V26IRFltKwB
 IZuh7xWXS7Dsh62UTaHDlwdh+kaCuPuN9YoaOo32AKMbGW48hSJKpAo5+WrvnbniraGXVdVqmg/
 izLLjwpxJZXZxtzeMqmTbfcJ06iiUgT0jxUehBqU53W8yWK0QjZ9CI+Q0cAHbLno9ZVmHDNkZ8N
 7lkm6gYB/DKLcJeyXkhh3nm9GTGlDwv7B8Gsj8Lofc1nTTCktpGBPVAykBqw6KbHgKtwEHU1a6+
 l8wLszEh5mvPGHzkYLWyFzAw84+0AmRyEIFTRYlPFepHuKgVqzTT5Z76N+wHbxgPdJjQtIK0/li
 gj4CGAwLbMWa9fasgL5eBIqOOD0aRjjKMutmH724=
X-Authority-Analysis: v=2.4 cv=IN4PywvG c=1 sm=1 tr=0 ts=69b75ec2 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=JfrnYn6hAAAA:8
 a=yPCof4ZbAAAA:8 a=yKa5MwykXiZg5cSm1iIA:9 a=a-qgeE7W1pNrGK8U0ZQC:22
 a=1CNFftbPRP8L7MoqJWF3:22 cc=ntf awl=host:12271

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
Note:
   - Add the missing config ARCH_HAS_CPU_RELAX in arch/arm64/Kconfig.
     (Catalin Marinas).

 arch/arm64/Kconfig               |  3 +++
 arch/arm64/include/asm/barrier.h | 21 +++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 38dba5f7e4d2..a3b42d9beed5 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1627,6 +1627,9 @@ config ARCH_SUPPORTS_CRASH_DUMP
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

