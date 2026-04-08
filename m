Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87053265621;
	Wed,  8 Apr 2026 12:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775651493; cv=fail; b=XbyH1v+h7p+m1CTS5XBJWVZDCHJ79mu0SNg69VMsMnVG67JwiRHFc146NXVamDefw6lcuzA4A37OKDrXbBwzeBrSGKWc0euBfR6GcbnrcCl0CwTtiW9XXQnlCzQMGDwcRWW8Vk0/y5Lm6J5u9gr6tuNwh39uiQWXC6XrIyp0oFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775651493; c=relaxed/simple;
	bh=wNmAFlQgxACPuetylPc0daT8yjzeXh/0ZMlMsVZ47CA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ab/vJ/CMLQnljrDpPzMyNbTVaYa1cPZ8gUzcH3sDCt8W2RQaWqEwqiw2Sx3DVxlw1aGVgwfKc1BbddRpGXH7hwn0/iEB7bad1DXE86fj/76zX1pSj0YIGD4d4muxguxBvYN2e16vkTotje1nmmIDpizjOE3AvWVxVkfoHAGc/u0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=g9//USrh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=r1v3hcLC; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="g9//USrh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="r1v3hcLC"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6386pM4u212770;
	Wed, 8 Apr 2026 12:25:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=1r2617IWt1k54SfmffadGss+Y+9HyMA/WIpicF8pF30=; b=
	g9//USrhL+XCt6LO2d2AYxpNqA/YGZO92JB9j7lwL9bbzv8Qs1fEN4UvMwMGnfpk
	rTodoKgbSrMxcb7Y1MKvWDOWNJmKsisdJoUtWMkYY6kkiPKvPv4wlyi8XXC5qlOu
	ksZrFKAIH+D48MrYZNGxMdb2858MHNc9mIH5X/BfJ/obEfJy6AgewG33otnBNtqL
	zu/0oYZfLdLbID0R5UjQiNW0BGj7hQnXODKXtPybDZ+fsakA4Eece2gAhR+Mdqm+
	ZLOF9uUnL/yjlyoJLV9SGC7f2aTm9r9hpUT2kiKXnhG8S5eDBmTjaJ55g3maS9NH
	rVlba0O5eh7RPUpYWswR+w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dcmqaueyh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Apr 2026 12:25:59 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 638A6qab007013;
	Wed, 8 Apr 2026 12:25:58 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010052.outbound.protection.outlook.com [52.101.61.52])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4dcmejqmk4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Apr 2026 12:25:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o11IT/b6vEUOXK8qy6Pbdbq5nyQ3iA4ZXukdeUVp6MRfR5kaD/htdgLJXtW/z81fBGW+H9YHBTeYH3SJpbIl/Tl6zrq4bXGBUdrXn7NDYltJAipJ0U6RmBIP2j86oMJ/PF9iEPAMN1XgiH920oTufjwvEeIEGIJEdndkLHxW+dM3znGgGNJepTjVdHl2PLSyDuMwA8GYMTxknsqP22zcYXZIiqSmxIGCZeub3BVotXueJ6VeotTGbAPhj00WjVONuqtShxEfgad6z7lN59VqUsIMCZfQBc8LEJsiIaSz2EOMSQ+9f4YxJbZlAWVVkSs0JYp9fc1Cy1Tnpf8WYrxL6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1r2617IWt1k54SfmffadGss+Y+9HyMA/WIpicF8pF30=;
 b=vn/YEDR/+uHy9gbq+lbYyp64F+Dz3IvwU3HFRXDeOveBoLe0gwIShgsnIOSKCyyyETojIXExKn/3a5CHZYwgiOqZtZqQYAlg9tHcWZco78dbb7gskFjxvKl6au6JGAhPL72u91wIxL9n9TuqkFrHhfUIp76R791XtJKg6OnKg6BzcUelPc2to9hVB44MdG/CC11yDZ+Y0pXo/WIXSVvZbqR6jJxStxGSVglTvgIW0HN0dz/YSMjDqVVlh/a9LtO7pJlzFgSZlR2YdBb38V5mzNVucSYZpJrC7wLRVQFzI5NsPHgHar8BgGBVF/RhicWZZtspdGfc2qwKVw51teXAig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1r2617IWt1k54SfmffadGss+Y+9HyMA/WIpicF8pF30=;
 b=r1v3hcLCsZ4nrVNCKBuBqOJQhGQTJrhjFvn8CB7G6xlWA9s5dwji6/3ADfSVkEyDjehLMMQ2F7hsS5rxiQ5cC9GAVdPFFzkJ7beQ8ZG3p2aAgh2saSjEvhJPjlM16cMnjVoCz8uj73vfpVrX+oCn8aw9m/9Do92y+JeyLN3di2k=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by PH0PR10MB5778.namprd10.prod.outlook.com (2603:10b6:510:12b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 8 Apr
 2026 12:25:53 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.20.9745.034; Wed, 8 Apr 2026
 12:25:53 +0000
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
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, ashok.bhat@arm.com,
        Ankur Arora <ankur.a.arora@oracle.com>
Subject: [PATCH v11 02/14] arm64: barrier: Support smp_cond_load_relaxed_timeout()
Date: Wed,  8 Apr 2026 17:55:26 +0530
Message-Id: <20260408122538.3610871-3-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260408122538.3610871-1-ankur.a.arora@oracle.com>
References: <20260408122538.3610871-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN3PR01CA0008.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::20) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|PH0PR10MB5778:EE_
X-MS-Office365-Filtering-Correlation-Id: b025a213-7c7e-4575-a8ed-08de9569f9e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|7416014|10070799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	/Z7TgFaLB+8Q32+esuKB8aY3Lm8Hptxfh/AvAoiv4zooHckRq/6kqLsSQ1IKwr6jMjH/6pB54CiDeMYavF8Vnw8iajGH6HbuYIM/qWbz1DHX2DEkbHenW9N6LuHpAItoexO2wuKSHTHalhEr5o2w9pSXvHXN7qbXmU4n8g6WO3PsIhg1eoQzbxpmztYdsbn5w3fbps6CfqTJo1m7cEklWsNPsJ1iQgjJ6E1ak+i68dNNYCKOPpFj4CCRcSLUFpP8IQOxRD61IKWL7V7hDGh1zAerp8xcxftKkkEnQ3g9OlGEt3CmIQvWruc1QBBa+xnru01fv+0xidDLUNe0J7JOJ4MgljyJjQ7a2J9BY99w2B/NgaNRx81Psh4+D1sE2u+C4vQWmYqEBSwC96RQKcejd6IY1x2XCvUatG8JHgw1JSsVqmSVyNnLTsiCnrTVsSOOzQYKahIubg7PkBSyyYeWvkSl7eOYMvxvmcTKBFA43ip2RCOv4fWf7j3m3iSxRpHe85TvYJ8EPZ65sfm2rV6V0u7j65iKNKNLxu1HnonEmLPzTcPKSLJuu7lrkx7aK71gYRkA9DnPS5gggwNiHrtWEyEWEPBKyErzrLpEuA9zNxaafaOSvTNB+9MnMlPXWDlNenxNLXJ8mG492kWbF+rkFhgc5sTg8vCriJRl2x3jxALUArL26hTh1eKMGHpvgghct40XUdnoTVZvjX/Q2nZlwYx1DhYREu1OINcZK6+LsAU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(10070799003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HRkgKd7tmzRM485hppgiEHxnMHYsVtbeLFX/nM4wb+d4YntHhJNMBLVX8v6A?=
 =?us-ascii?Q?K2JBLYTp9KTmh0/kUHM+CRHP/qQAE9bYLN2ko4LkSz1zHzGOr6h5JpH35nqc?=
 =?us-ascii?Q?hz7/ecazkGsShI8mu0JToy/P2vprQik2oPYiggglaqB/QCRnLdPS73wnuTNg?=
 =?us-ascii?Q?MGeEf37YHV8SDqe7cNB2XHXuN9VWR9aURX/qOCYv/gDcJFefkQwy9s0spkFl?=
 =?us-ascii?Q?hKmLnkeDLxEDb1ILDCDSPAtWlB/vW9Ropwwt1W2sruo/27k4HUPO7zQgFMph?=
 =?us-ascii?Q?gwr/82BXhrs/v47l+UBBH03L/yGCsWq1moqN1xcIqfPVgRQmZ8QWOFWOdCpe?=
 =?us-ascii?Q?iEQ9hh/tgIgdNrQ517F9d7LeQRiCJLL1HK4iupQQEEUhAG+7ziaV3g2Z5MqY?=
 =?us-ascii?Q?F9fb6PbNIQXkIokRypEpUaZ1VZ7tJVu/b+WD87taaeMNlS92dtTeg8R0oyo1?=
 =?us-ascii?Q?7tGjQndc8r+Fci7PWj9ry8Gqpn3AmmCt4bFB9gD3fhCs16xV5ScR0bFeaXYD?=
 =?us-ascii?Q?mVHblmB3RrQpn8tnpkUGAXPixsReI5cMVSr9O+nLOVG+XFS3HybV7yGjH6Yv?=
 =?us-ascii?Q?aFncKKGJlPH4r/3XHx7uKpY39IsbhaS+B2fbQvH3SBgZ4OgZzqp6V+ED6dF1?=
 =?us-ascii?Q?nFFYuJ8S/VKdQjOl3FJjmqQQqBpN5MqsqOQRrSJmXx/KPn+f3MOnlubGWk6d?=
 =?us-ascii?Q?AiR0JT8a6klJj2hTrB2SO4AKMbfouhIVDN3zI1FtyNqweF77qOflRL6vmjfg?=
 =?us-ascii?Q?qGdG3tt1FzrMv0Ln7wUPRFb8bx0cUY03dSb5yBE88VBW3lyUBW7/C38ZbaRZ?=
 =?us-ascii?Q?q+ttMWd2hvuXWY7ZBQOBeC5kSkUQMfTJOr/mJ9fnZRd3dNMLRiGnKMcHOK9R?=
 =?us-ascii?Q?PrkclTKUaqI1AiX4y7s2guyroLQS+JA2mKfvQjg4WWimPzw0lCKln8LRNi0O?=
 =?us-ascii?Q?cKQaRjFAWwaonN2Lf8YG1KzOuScV0OG1nxIWSEJfZ3g59eebK36DRPF4DtoP?=
 =?us-ascii?Q?OYRVC9fcanuDWMVEkEDpbVV5xzWxjre7bEl6Monu3ySzuvgDf508u2bwU2SR?=
 =?us-ascii?Q?6xpAWuJos9EglCgorobAdSbdt5iDcYFYkwP2AbmjBgI4NTa81r5MQg6jInVJ?=
 =?us-ascii?Q?dQ+BlWSpfyhDcqh9mzQ+vrKzuTZJvqyNyOfdFI9iNOSTEyxb4zQyVsm/BEUf?=
 =?us-ascii?Q?SqdCrEgPUH96t1TpGD5gzh8pQwxdf2vWT7xi6Re0ostYNK9vpPTJAZHjp5ue?=
 =?us-ascii?Q?aUAClfEU+FnaO1pirNdmixy15Wc9XfZM/CNQGtlscNhTG4Pfy8AIBxkxCdn5?=
 =?us-ascii?Q?xu+0oeEnAFBhMx3iqlv+CoFtmIb5HjMaFZ2v7ODWh4Bo/byuwmaL7QUC37Bu?=
 =?us-ascii?Q?XqFde8cdSEqTcKgahGJxAEWXVTIAANXkSNM1PswauRCjYTxfjWEVy8O2QEht?=
 =?us-ascii?Q?KK1tuQH6jp8T24FDUGZLlNfLCUid5e2EDu6ietJxzEO/zcL9SwsZqtJDxtc0?=
 =?us-ascii?Q?u1qGT+wBBhmadc42dOEwPtwlCuKf1ETMOgry6M8aoqbJcDwYWX0rmXZdDspE?=
 =?us-ascii?Q?9GcWEP8JJHCdDmW5jmaH1nB9k49ScMdsSSIH29WKBt3zlEb54CoxYshTQdSU?=
 =?us-ascii?Q?r8c60jxWn7h7eTliR+vMtDMuc3iX0F+nptajY7T0q2ef1KvU1thmzazGJEHx?=
 =?us-ascii?Q?Wa5tZaU4agsd1odI/isjIktuZCF/v+vqNPB9vxlJfxsDN9+OzkulAFfjhxMr?=
 =?us-ascii?Q?x7XF/3p1N9uGASgqL7qrpvtnmCWeaKDsbveAYi/uAxv8QCrTWigyDh2Ceawq?=
X-MS-Exchange-AntiSpam-MessageData-1: XggDBiYmTOsobUdZz+mJXb6kBlhOJcWv+SM=
X-Exchange-RoutingPolicyChecked:
	uG4kbXtH4/Gvwic93G3lKzeHi8S489d8wL9qrBvXkjItmlFcbw1tajlDH/aZtH80XT/tzMyfEUeqhOJVrxkKdXds85FiPG5KvxhBLmxVBk2lcOC8QuLx54BPwiaHea4RsShPCci6DNO6lXz7jUFMIeEPcd0tRtf2/mlWAyERw361mqH+K7udt8s/Ke/2KI6ZZ3NEZHrAEr1u10z8yT+jxCyU1W+esoSUrMWfQrKXgnkYeplb0O51bNy2bHbsFWmBuJGyvavjPvu0h8V8G7N59W4HmlI85RIARZ/1EPhI1L4a9dcIayBXRKm6QEXB0/YTBnDbPAETviB7mVW02hHkXw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ecclB+BTN6gRhBfpRnYKCmgZoVcTMDBwn3XxEHiqrw8gEXiMYJzmu/jRSfnU9n6IP+PgtdV1NoquHYz+QklUvXsS0AjPsmf43H3joTRCjLdQyuWBjKvDIdoHvGFxU+W3lZZykVQjbeHQfVOQTooioERTN3rxpIzp0GZ/L/LX3DHFISxeZwAFk04HWNiNdDT3WrrHoks7euHX+GMMn+WkMWgjKwPYfa3mSPQwOUe2o8zjW6+bbqjF9QXiz/GJR3Eehr9nNfPQuWPIvt2dPkgs91GZjLfxDaZ1q2z5GI865ZapooYwzpl3DfE4aLOWuZH1j2LqV4ik9eAqg31RpU56Ewgi1JMQeO0k7OgltXza50ARqrOkC9W2DybLHzTPmA24pS595XmFpfLASihT6+vZJTsSpNpQO9WBcPCD8tt0z333KlzUE4Hj5tOm5ud6uQ9Bli5NblVIEvQKYpQFOEEGdpkaaT59lV8LGLrKijLWUJ/EJGdmC/Hmcl6LSZlFcmJMCx50cbOGBaF6Y43i0/IlXn0pgnsdKNLVSCTH9/l5mg5Ti9l+51oSQtyy1b9WAik1eRSzHYf5yrjEIR96CLNMQkFZcZJdw00MseH3+PfCTf8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b025a213-7c7e-4575-a8ed-08de9569f9e0
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 12:25:53.4379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4SlD1DhbVXoQwk6pLmSP0YqYvXt9SwP/5E+40QCWCXIGdfiEN9AAkaq5T2N0G0G7NkdhURXpEYNpFmiVcO2w1DZVB/ETq63AJ9/qUufx4eo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5778
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_04,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 mlxlogscore=877 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2604010000
 definitions=main-2604080115
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDExNSBTYWx0ZWRfX4XfnpjfG41yM
 N97v9hqeK8/KS2zPaC6ctniVTlwldSA+mVLg8343SaItvvfFKfkJPieFcWVZuSq4TEzdvFwMu/w
 eblbYC1SH2kkICHgPoxb/vEr6joZ+qSk1IEjaeUwDNMANBXpY0EMAISGb/OSy+9nXp09n+RT3P5
 GxF+YwddWW3Sj683NEMr6NQbjE8S9STHdo4HiS+S0SJ5mprit6XTfe6uMR29pQCcNTVgP3oyxQV
 8/DWLvBQ2FyB7vG50p+mO+xSj1NEUx/CUTlIfZY6CYUPyVgKn5wgZqJeqOobYa3nZ4OzT0JDMnV
 Ll5a/kzr8NttQfxxklNY1T2YzXFykL4jhxooiLJ9Kr/aiZCoE3yHzYCrrVMlpBbDRRDSB5snlQT
 +D04yfszuHZ0dApCH3lcmzlH8tzUte1svEvsvvZh2ere0h3TnFU9f5xzXE/YUnEW4M6OzE4CYoK
 +UC3+9TMGY8Yv9KqJXHwE1dB6dzAJYlnTZrpO40Y=
X-Proofpoint-GUID: CSbNfKu853hpUvFe-T1cDVKErzz20GRU
X-Authority-Analysis: v=2.4 cv=Oux/DS/t c=1 sm=1 tr=0 ts=69d64957 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x0eKOSpe3m1H3M0S9YoZ:22 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=JfrnYn6hAAAA:8
 a=yPCof4ZbAAAA:8 a=yKa5MwykXiZg5cSm1iIA:9 a=a-qgeE7W1pNrGK8U0ZQC:22
 a=1CNFftbPRP8L7MoqJWF3:22 cc=ntf awl=host:13825
X-Proofpoint-ORIG-GUID: CSbNfKu853hpUvFe-T1cDVKErzz20GRU

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
 arch/arm64/Kconfig               |  3 +++
 arch/arm64/include/asm/barrier.h | 21 +++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 9ea19b74b6c3..e3ce08276e9b 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1628,6 +1628,9 @@ config ARCH_SUPPORTS_CRASH_DUMP
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

