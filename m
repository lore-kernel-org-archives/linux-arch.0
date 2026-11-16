Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.177.32
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794817663;
	b=USrQh7sNcP9aZcbpW3mwk70DFrVx0AJLOtFVK/j3HPPoaLoMiAUKz8Qe+4K2EWxWV85n
	 brojGUF1GEqI89MQmRTt/nyCgmzcfzLd2oCCR2tGP3LZ6OtyUEjFBikBsYE5cvG5W4uLU
	 kne6ESFRJ2RSxZNKd+2PIb3fFtbzhPLi+OHOB6cdBHr3rt/gf+Mi5PgWYmd/EDt/qWt+1
	 P79xuZDBurUKtQ5bdDaUqDr7vwK867xO7jpfhOzRkdOUY2aHkqznpata8eGnY2kh8qoFw
	 PJ0XatXZ1ITQISl8qM9QnNWFlo4rwEpaPQ12pQ7RtksUGBDXp0wPZ39LEzm0trVOVWg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794817663;
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
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID;
	bh=Cd7Yh5NqiOJls/+HpDV7Xg745DPFap/JZe1pNZ35MLo=;
	b=siEQoVo4AC9KKpoc5/qooRGuBgLdgFHPJ7VtBwHt1hBGao5EDWGu5Yhyit/SZsPuIvtX
	 UuVTabbQDFrcLkC8mBIZxZm+ecvv04LY4/WMctNJANDv9cmRpYyry+nzzlndxPPJcpSHv
	 cnFMnOP++Pt4isWEZrTjo8oQZ0SMq4nyv0ioOcs2dEojpmwTUDUTCwcAJr+TsJdEzYYtU
	 QvNRNGh8ELQOQwHfPM2A3hXYuESFWTSotH345mVZLhkXGwsVsPBveIRyEQjLS8DHnQKX0
	 gzfYsIz+oWsTH/geTzp3A9TBv4RK/aOK7DcHTHYkY68vqy2WkkxiFa7xpC7oe1yr10Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oracle.com;
	spf=pass smtp.mailfrom=oracle.com;
	dkim=pass header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=CK5xLVxu;
	dkim=pass header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=oYrwVZG5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.177.32
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FADD606A332;
	Mon, 16 Nov 2026 08:27:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FADD606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=CK5xLVxu;
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=oYrwVZG5
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AFMe1g3115139;
	Mon, 16 Nov 2026 08:27:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Cd7Yh5NqiOJls/+HpDV7Xg745DPFap/JZe1pNZ35MLo=; b=
	CK5xLVxuCCuFGEHH3N996L0b+QCJSwNqOZzNF4iR8IAQwS39SOY+8XyUYaJBRe3f
	plSmWfu8PzcaYyDf/dT0d1WZhXKLz6afkhHhcT42mIR7tY6zEdE0I0SwpDdnw7wl
	omzrF1ApHXzl3iet+uhFbMneQqTKmRTiK63qTOjcTFYVoDh6tpLC8x9fmLrs0Efh
	lC/EubWY2DkmR/IOko2weUxWIj8DNTn4FGQmALHTiW0dwt6oTbkqMP4qW43C0mwE
	d6Oo7bAOBkacxpKxKZaJ/N4lJJz7Em9wpR5JwZ+5G3HFZrX8X6hE42+NCAIdQXwf
	aqN5+6+7PEQckhIhK1mccw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4hxfpe1kxd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Mon, 16 Nov 2026 08:27:12 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.11/8.18.1.11) with ESMTP id 6AG7ceGX1550659;
	Mon, 16 Nov 2026 08:27:11 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010069.outbound.protection.outlook.com [52.101.85.69])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4hyv5svngg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL);
	Mon, 16 Nov 2026 08:27:11 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l4uL7LdxxHiW8JZ4GFZOzRiCBL0N28+YzMajCaU6VZRiaHMWHgMAQipDgSNtQE2Xg6eIsVUIcv+hXSgik8WH4Coh2Zo8rrLIMpKas/VaDimWN5+uKM/AWmZltswR6LG07OtWbzrr45Kn9aYKWxl1rcKdzgiQlZImI8Nf7DRnLPyP0rethLua+lkbZQeyvkucb/nWBLyMkZei9jWqYIX+vyrDwYBI6K8AezXr1PmGybntxvhZuH89hnDCZIvEfGV3xqTyl9tDqmxGvL6HGUTxmBgtFhE5J2Kt64qdn/ptcxEv176zmcFsKpROaesrukxhKgsixIywOzWNfz8s9Jspgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cd7Yh5NqiOJls/+HpDV7Xg745DPFap/JZe1pNZ35MLo=;
 b=C/C+f568nS30UfBb6i26ASRl62PV2ajS9LMNQhKlar61dhnULAv9G8XvbZ1LvhxA3/cNMfpLA/CBcv3m0979QTXJMRpj3ITeBzLVk056pge5SYL0zzXbb3aqQxtj+oMgGSgYkW0uGUxCJv4GChYe9fKQkdmFGub9qkxEal0fmyzO34ho+g+STVPOXloRSS5mc+BSww+WuqfCHCQsjjAdT5sYDfGgV0Bl31wns6XDhodO03HsGOL1dkotCErDVaDi5MCJzXttWSS23a8DiAbM/ouqnHV/6gQE3OmqVukvQaMMMckZxkfrfYw9qE2cdR97KiqsB7UJfXFSNPQqldCZiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cd7Yh5NqiOJls/+HpDV7Xg745DPFap/JZe1pNZ35MLo=;
 b=oYrwVZG57Y5AYm919HTG8lDBhJ6vMEQPfW5tcp9Rv4NCq+hf2ZUwrXnb0TP76LVHzSJW/R+1JHTv+rEtlbtVXUWb48lOYP/pLNOpqq6BeY57E2lVuSwMDcKH/z4p2ggZd9HdonMKYj3XoTBjIfKaIj2qDBVQn6KPRPoIBnTUB74=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CH3PR10MB8216.namprd10.prod.outlook.com (2603:10b6:610:1f5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 08:25:08 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%5]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 08:25:08 +0000
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
Subject: [PATCH v17 12/16] cpuidle/poll_state: Wait for need-resched via tif_need_resched_relaxed_wait()
Date: Mon, 16 Nov 2026 02:24:33 -0600
Message-Id: <20261116082437.66739-13-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20261116082437.66739-1-ankur.a.arora@oracle.com>
References: <20261116082437.66739-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0233.namprd03.prod.outlook.com
 (2603:10b6:303:b9::28) To CO6PR10MB5409.namprd10.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: b94e9268-d384-4e86-721a-08df43bb1ff1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|366016|22082099003|18002099003|6133799003|261009223027099003|3023799007|56012099006|261102123227099003|261102130727099003|261028144727099003|261026121527099003|261026140227099003|261021123027099003|261022105027099003|261022113327099003|261021121427099003|261022075727099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	2nja2RvqHoLFEvFqPY7Gl3kjkIsL+Z2YccPVW99fcFXGZ36XamnuSNV19DrgV0rwV+NUIL8OmB4Xwvt/BW6vgxq2GjNDVWDs2wKrGe9wH45mc3cBSWoiwKJgXMkkPK6Tk4ouLAowIrHgKuzHNLKT45MaUIZHqIg1ftpXfvjt+Uso+uKBUyAa34iCNYdze/GdIt7SPZjamD4SoJfEcdr3GyfDkq/yHF7jY67CNKHRrjxu3gYTTH5Mm7dbLOgyIgRRnv2SarblOTbCLxX9xpfZkJp5v9+0KhrI2zw6XZrIOxi/nFbkHj+x/WnLrSB0gtARWt3Bhh1pd9pq7WRTcN4sAQ68tWrF9yctjS2gtMmrqbXHGHJgv+8ct/Roy+ngTC6VlLhbrbXFQaYIm1e8nJIzrPevhMgpJLWSQ5SO6SmcSos8u76lJiYPu7lC+fAjXjlCvq/42+KjUXxy8vKMvkihYHnI7kHSfZVcZOpkS2nxhOmkm5t81ZUiiTxXFtCBzOVMBDQAqpY/8bUMJSaQjJGQB3OiFPB7Vm3Sn2NaHzaICQ5tOIPfMvna4JTv4H8+5IWE8B4auD1SVKSjv5gQ1ex6IwQ7qVGleyC/pKYwSztGMmN/iBIrZZtSJ1AdkNSJrqk8XMUGHdAhZeSdw6CzcOA6FV04PvMgjC3GzygpaIxoLuQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(22082099003)(18002099003)(6133799003)(261009223027099003)(3023799007)(56012099006)(261102123227099003)(261102130727099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021123027099003)(261022105027099003)(261022113327099003)(261021121427099003)(261022075727099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eZ89aJomZ2XglBNvGyRm+a2w9PuhRuciV9WxfYpOKnhwBOXUmPrI2LDxaGHA?=
 =?us-ascii?Q?e4Ss5+at1XirwErQZ807mmh4yqT/kpW09u1rVev87m/Zyb7MvFA6wTikKlkU?=
 =?us-ascii?Q?LzH7hXc5aOYE7altQk4LL5Kv4UTA01Ov3EDAZHn2qwMEBLUAHUCtlcOiE/g2?=
 =?us-ascii?Q?sq8Vx0v6+RQDeorFP3Z0G103r+7cG14uwHVi0Bb/VodTEZV+Ra93Xueo9fK2?=
 =?us-ascii?Q?wogdsj0R0H2RRl6KZvCZ+kgAM4mQTgt0psl+ESHNgMBvFEeLd9VZkaGP3WFc?=
 =?us-ascii?Q?t51wtE/PSo2f2ApuYiYZheyLb1b9JwgPebQI3IpVb5lvCfSMZUEFGku/Ytmh?=
 =?us-ascii?Q?DYkOgPXZLOzK/RgQq5evdGwPcxmXVDdWlpFPH7Tl4Gd/3W1T39wdoEfqtDv3?=
 =?us-ascii?Q?kCUSch/JT53j2q9INN3QjvGEAdrZmOxNwcKInxB/sZ3kAjo1hKBixw5ca/qP?=
 =?us-ascii?Q?N2TS9tGZnkscEfDM7Jh6NWBnen1yeUk8Vamf+dvBvIAZw5k80UXwBxz7hKjT?=
 =?us-ascii?Q?MzkBEFCMLeG5wsjVkOF8yYXupQT2/rl0FC3e+mE1tsUTmva/B6+8kQ67urgg?=
 =?us-ascii?Q?PaRsT0STP0FIxaAr5Pzf0fypqgp0lEZT0kQ43Wf0YYZfT6U+gl0Mu2UOt5rg?=
 =?us-ascii?Q?luv7nAFjc/gFdkbqyoeINwuBk7c1Ldiyqc1X2NFBGre5ip9rCht7XWPjmwx7?=
 =?us-ascii?Q?zuSuJ6CjeAvRl3u2xEmfaSJmkEl6lxVkh47w6O0+DGFDD4sUrbD94r2png8y?=
 =?us-ascii?Q?dT/ed9z3G+PP9VQT6+HRMUvmF6E7t65S0NhhM2jZ7shYterTNlW+cuNOkxTW?=
 =?us-ascii?Q?x9MAFOf5upTu0B9ld+y3XDK63+3enNHTaqWS6MLjBUsQ0dj5y29YcgVtgFzg?=
 =?us-ascii?Q?7p1jCT0HBqOT2ZGezpj5KxgNkzjrrThkSTseboJztjUkohsXUauGcdFVAwSw?=
 =?us-ascii?Q?y14EC4yJaUdzHux74sbr7930vqEEvIu6VSpg/natBj5boA/TAxBStaYDUvGf?=
 =?us-ascii?Q?XelOwGJOyKBVh68rwGDydTVqWbC1/xo4A638JcdUOaWi2FxOZ9zslyhYctfw?=
 =?us-ascii?Q?pjMJ2wTHfNnZBkDJW5yoerXfshy0yue7wUa2BGSwLGeIH7u1lZkGD7jJQyTH?=
 =?us-ascii?Q?p/Ogx0DWYraed5ss8INh9cTtoOrgtfErHss1e40RtpcQKI1skZZ+iU0TAuI1?=
 =?us-ascii?Q?swdudBebxCmY4sWj6/uZujAS8yeh9fZ2LqmwmD2Fa5BxEubGzvZZbUGzuF16?=
 =?us-ascii?Q?uMEdvLsvT43VEJ3mTiOKRRkYkUZ0yEvsLkpimpMNaRLfhYJSKutSCe1NbTpK?=
 =?us-ascii?Q?F9PzewjusVbpPKjsD2jLqmHDdvnIUK3qvPFQgiHyAsH4DmpHEOzzsjR/IwL3?=
 =?us-ascii?Q?+1O4xVySbWEpCBgEq0a7FWzmC3K1wv+hvfF/+OAzZiW7WHv924Yfn5mC1lDM?=
 =?us-ascii?Q?yXz7rMxBR2PLAC8Skf7J0bBECzaDKmGwcVAtNBnkGdmw9kxDSYD4NShvHl70?=
 =?us-ascii?Q?JrcOIQ74TdLNF9WhB9COO1r3rpMMRnX+2VVjn7KlrcsbmTwXyhECFxkWojvi?=
 =?us-ascii?Q?6A+Pcwawj0HYscMDLBXK+GnWuaoozHpXr+jQEcv+giRV9Y4rbT6XLBHuqXJI?=
 =?us-ascii?Q?Dh1uYJCTemCOAk2GXV4iLigLt2+5RZtTUfGvCAfINvnj1SxanF+uUfDtegOt?=
 =?us-ascii?Q?qxy8mD7zUaS9yaIFLqnuy2dTCx12xFjPd+ueFs/gYrb2TAy7sntJ+rjsfijo?=
 =?us-ascii?Q?4WIm9kTQA+G86D8ijhG8RNM3S1Fa18Y=3D?=
X-Exchange-RoutingPolicyChecked:
	C1ytIMgUjXDLEhGnX+c0FG2HQBKqsG9dpge0sxwnALHsTEZnXPW3GcEFqG/OIB8hqk9xpZu4uVxOnX5HUSgTpziPJaOcI1DrtO/gZKnXlgvF+uNFIr/7p+9pIdnIIHiSSRafLtQJSCAF0IYTMsQJRingzscKrzNU9m6eCRswNtJjnTV9rt/6uX3tvguWCyZLlq2yv7OJ3xfNod7FjXhgBFd7ig+4bMyURvcrvIVt8nZdpRWRRWIMrZTmx+z/JFO++fdTIQF2Qk0GvZWvtjR+iPvSFFnLZx7QPw6uxq1yM6eaBFya3VOkbvm2vBZS3sfGWcEzGjYoTEeb+wAM0sfFQw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hEKD0qtPH1SzegmegGa3mfZAcAQQ+DZ4uWlcG3pE1/kaDIKTkBufCszSSJZPfBh4yB1y2NxnI5I/jSuenKhXPP9pV8DpJh2LEZmOstrFsDWEF695v0Qh30jRP7EqOV2aYfKbV7aUHKgzeUvCFTVY6dKBpRc5uc3KfphX0LF0XIx5Ka40HGPkViCHVk68ufvKmvXWG2X4S1JZY/v5l3wlVc50o4X9QW0PsT9/LE3VYlYJBN1ks2Y8egWIHKHB+PKstB/gib+75kDflcfOOAQy1pIWi5i4kFTuzoIpGZH9TH8+9K/+upgLEMAdmo2e9Y/9qKy1PeNDoP8HTaFce21+Huc/zcxD392jmKy3vNg2jZwSYn4TH0fMFQe06Qv80Evl2hhe7Xsh8AkGEh/dZXKfgLqYPpXkbIk43hau0Ui1SONlOMudvut7AGl8OZMl6Fa4Vb7Bzs7e79lVn2CFvZIl0ecliz4z5vyx8K8ksP4RqA4YqfQgpj9ozR7zK9Tk2Pjeb15JJN1QE6qP4VqjLY+0puhHBiWFIPd2Oy1ttyBfwwkNvMIWi0gCX4YOXWALohaNsEzQKfo4yLpFRoerb7U7bfUGWNvIZDXU9eSxIV0Nhz0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b94e9268-d384-4e86-721a-08df43bb1ff1
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 08:25:08.4960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ssMuMTg1IJWCbZFC9xri3TXizA3xNuW508b36ViQu1977KIyp683wk3CVCc9pmmiz/i0rt4yeSl3UF7zpAB94PIvLusEkgfCDvKTtsYqCSk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB8216
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 lowpriorityscore=0 mlxscore=0
 adultscore=0 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2611040001 definitions=main-2611160033
X-Proofpoint-ORIG-GUID: 0-Zd9Smp5Dxz32OAdh7T8Avc17C0vljP
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDAzMyBTYWx0ZWRfX221uAeEVdQJ3
 3WfgLw2yIMlLen/Q1dFenJcyfI7TBCnPv/rs8EkKS8wJrZNl/SvDetO9E03a6X1h6ADPZ2yBaoh
 X6LqMKWNYpX0aOG9/2qZnshYVm7AbXgKxgoWNipf9lQQLlL9qBx8
X-Authority-Analysis: v=2.4 cv=PeNqFShd c=1 sm=1 tr=0 ts=6afabe60 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=VwQbUJbxAAAA:8 a=vggBfdFIAAAA:8 a=yMhMjlubAAAA:8
 a=yPCof4ZbAAAA:8 a=7gr8-LgUhGOHEYCj_R8A:9 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13532
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDAzMyBTYWx0ZWRfX93aznMd3sQZT
 h2PMj6BlLd3aCeFNSqDKdMe6HRNpovP7JZLY/3wmit4umuuTCDaWXuwDqkSaCzj4K7CO8KXPT8C
 jLZMQGE3v4T6+Hlj8zz1ax4iyFFypsCp06UYEClnF/HTlZcW8Gh1joYoDeibaRa6bjyQoOucnAb
 miCnND8O9i1ulxZdxeCeEyzEQcTu9zEJWRnxQVrDcG/2okvgk/d6bYa7y0iCqUmKnVqCjB5gcMw
 ZJ9mMju6AscS7jNQEwRwK0uVxLTI/89Vd3QuExzNR08NIs/UB4gRwW0R99SiQtLHseMVQuj7nTv
 ZG+a8DWACBm74UL3N3uxlzbc76srahpMBsU88HWaN/8kK7L3e95QjU3ZjP2pqSbMpBXKWJrNZ8l
 iPoOOoL4kb95+Y/i8BH+cEOXEBlwpclIg+6tiuNf6gggumKe6BvCN+HtSERXbXzXmPSTkEgjQot
 S0Dc3y0UGqz47G4Vl6HTIBynKOdZxoEHRtcv7YNE=
X-Proofpoint-GUID: 0-Zd9Smp5Dxz32OAdh7T8Avc17C0vljP

The inner loop in poll_idle() polls over the thread_info flags,
waiting to see if the thread has TIF_NEED_RESCHED set. The loop
exits once the condition is met, or if the poll time limit has
been exceeded.

To minimize the number of instructions executed in each iteration,
the time check is rate-limited. In addition, each loop iteration
executes cpu_relax() which on certain platforms provides a hint to
the pipeline that the loop busy-waits, allowing the processor to
reduce power consumption.

Switch over to tif_need_resched_relaxed_wait() instead, since that
provides exactly that.

However, since we want to minimize power consumption in idle, building
of cpuidle/poll_state.c continues to depend on CONFIG_ARCH_HAS_CPU_RELAX
as that serves as an indicator that the platform supports an optimized
version of tif_need_resched_relaxed_wait() (via
smp_cond_load_relaxed_timeout()).

Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: linux-pm@vger.kernel.org
Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
Tested-by: Haris Okanovic <harisokn@amazon.com>
Tested-by: Sahil Chandna <sahilchandna@linux.microsoft.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 drivers/cpuidle/poll_state.c | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/drivers/cpuidle/poll_state.c b/drivers/cpuidle/poll_state.c
index c7524e4c522a..7443b3e971ba 100644
--- a/drivers/cpuidle/poll_state.c
+++ b/drivers/cpuidle/poll_state.c
@@ -6,41 +6,22 @@
 #include <linux/cpuidle.h>
 #include <linux/export.h>
 #include <linux/irqflags.h>
-#include <linux/sched.h>
-#include <linux/sched/clock.h>
 #include <linux/sched/idle.h>
 #include <linux/sprintf.h>
 #include <linux/types.h>
 
-#define POLL_IDLE_RELAX_COUNT	200
-
 static int __cpuidle poll_idle(struct cpuidle_device *dev,
 			       struct cpuidle_driver *drv, int index)
 {
-	u64 time_start;
-
-	time_start = local_clock_noinstr();
-
 	dev->poll_time_limit = false;
 
 	raw_local_irq_enable();
 	if (!current_set_polling_and_test()) {
-		unsigned int loop_count = 0;
 		u64 limit;
 
 		limit = cpuidle_poll_time(drv, dev);
 
-		while (!need_resched()) {
-			cpu_relax();
-			if (loop_count++ < POLL_IDLE_RELAX_COUNT)
-				continue;
-
-			loop_count = 0;
-			if (local_clock_noinstr() - time_start > limit) {
-				dev->poll_time_limit = true;
-				break;
-			}
-		}
+		dev->poll_time_limit = !tif_need_resched_relaxed_wait(limit);
 	}
 	raw_local_irq_disable();
 
-- 
2.43.7

