Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB26125AA;
	Tue, 14 Jul 2026 07:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784014291; cv=fail; b=QA365WFrRrHfk1StteSabrgSVVWAu9lrWAWcR00lGVKGKi89O48v709Sf0k2tY9R17e/a2tt3pCtCVJjLlejBl3Zi0s8RGqmaHKvo9TYcL/ogbSdZkRwgJ4Fg8/BFr6xMZx2EqEtnFNY5ELT0R5SX8xBhQcUmK1bbXUf/aMWfkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784014291; c=relaxed/simple;
	bh=Ku1Humhz2rRlyd6ygJvgwRugtdSxhievK5lV3D3ycNg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=duHVLiRsDXWuS0w8vCNYtrb3S0iJa91QEetQk1pc4HRtRilvvjaqdPhrpogQ7iE3wBbuI1kfEF199KWJf7+djHzsWBcMXvMXE5JS0Gkq+q5hCLAGq8DN/59h3zgG/tGyOzajxxhLpNC8R+mpBPHyMEA0m71zALQ9onr5rq+qm4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UPXLboOE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CPxQhztw; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UPXLboOE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CPxQhztw"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DL2qeN1391898;
	Tue, 14 Jul 2026 07:31:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ZfrZ2H0ZYkbiiIk3hvcnwPGTWjz48nkw1spPigIOxME=; b=
	UPXLboOEwylcCAHg8V+p62Yosj3Cf6fjHA7WQQ+kprUvSzsUYZ8enarvBnnGMSXr
	EEgMH5t19apDjHFaOkrEdpuMlex+al+T8rA+6vl2Rhkra7jHL1xqE+Ts5ZDTMbVi
	U3mfvVyXA5p6yPMq11hf3ZQsdhX2bgYQVUQWGx1SQPQi5RRhUQ9BDhIgEVW+rHwr
	XCGbVlWz7XelppCtqyinIW4UqyE/s1HEV/9jpx3cq8+PhkXv1h0MKPnMwjyzAjtX
	vWwhpqH8UbvxgLBQHKfOSXMyBV5NIRqSgWXksYbEQqGoOjh8dcAWvJDHKLeNOqXz
	yZ4wxdobSSgP0qm8byNyuA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fbepn3pab-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jul 2026 07:31:06 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66E7SbRG007789;
	Tue, 14 Jul 2026 07:31:05 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011040.outbound.protection.outlook.com [52.101.52.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4fbc9qur8v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jul 2026 07:31:05 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qiq2ZBMugFzMidY1VymLQTcgyIRB5tOdHKP3GkoBeL92BGAXCJpO/DG+A+tsnDyyn1GVa4j/wOOcn1wFigRU0d9Evfu1izD0btsl76VaNcOId6RdTpWi7C0PenSvgYqQO/2ia8Xf7Ol62zci+IDkQi1go+ZMCGpZ5oY0gKuf1XsgZacrehH5X3tw3/7H5jHFQicQmxPRwnn3xxCm4rLxB82O2GZL3u9kf1K5l2dwrg9uFym1O4JClCMvKQW0CGFrTHy+rHP6HreuWt5KlbC9mJijULXqr6jHUZVQEoXnV29wrxHnk67h7To2MYUS2seomgaOXIhm+5I+IZPlaxjL1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZfrZ2H0ZYkbiiIk3hvcnwPGTWjz48nkw1spPigIOxME=;
 b=ZDRrC1XkhNFc+/KP9DIWMACGtSAboAOy5DnaHHvGl+SEx0sIXX21dkuX5mXaDikv9IJB09M1Y1ft1WmtfRaNuTU36ig51Su8oRCIk3d6r3nSYjAjZZqUbl/Ffg9PsDhWZi+9uXEJwgEQNzmrjLzXBQKGcJnMSU3s9KbQu1+yWrS0QYg44+lcuzEBMyqWSjQTP4Ol2hO36emIwlbpJdn3gnK528cv+fToPgQ7UUu3AsXXHMEkOh6/RhJNUtQRel5IY+XFzOcPEsjlSv3LWTmO+H2rdMP3C2QMzHKwOO7UdUQL2lsIg4TItYKapeTBW8LCMXQ50avNttp9I52zyvJAJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZfrZ2H0ZYkbiiIk3hvcnwPGTWjz48nkw1spPigIOxME=;
 b=CPxQhztwEKviUyYqaAwd6rssU5YMCLm9m13dWCiVBEqCc3+NEUkvTaTmAt2h8UiyUgS1WxGcItW+mlhlqzc0hlYJD/Q8+0+wWMscfDESZueKUZE1QQ24yDDhPsgN5xqAnZNeP6fygm6auCxL7S4ORSDFkMW74iXFzj6Gidg1Z5U=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CY8PR10MB7124.namprd10.prod.outlook.com (2603:10b6:930:75::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 07:30:58 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.21.0202.018; Tue, 14 Jul 2026
 07:30:58 +0000
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
Subject: [PATCH v14 04/15] arm64: support WFET in smp_cond_load_relaxed_timeout()
Date: Tue, 14 Jul 2026 00:30:30 -0700
Message-Id: <20260714073041.40250-5-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260714073041.40250-1-ankur.a.arora@oracle.com>
References: <20260714073041.40250-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0391.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::9) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CY8PR10MB7124:EE_
X-MS-Office365-Filtering-Correlation-Id: 20e201f3-f452-4a5c-7f93-08dee179d8f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|6133799003|18002099003|22082099003|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info:
	ljcjzfpk6MoXL1pnYMgfNqJU10tfa1j433UscgPpUnLA4qG8X4y5UZ0c7xX52qtiw7HA3k1bxAK2eHy7Kj6GNO/AHIU4vEwWsa7R+th2WHb+lq+v7yzCd7yw/u/WUzJdlYMQYsQvGSeRtca8XgV8JvVu/liRDMQ/ybxXiUN0RIvRno6RBzCreUgeDqJg6xCtCeTAevrzgxjRCvvv7Pn2nnXGghNE2X9mxrfDF9vdqvypw/jkaVUZy+xdY1R9/s3w9SRyrkB3g0gJcKgqQ+tb+Me9GfULDWF9X71e8utKKDy9ccM+fAliaLbHzlG+FeJ4MskW06aD+modJrFx26VsDjCv1xCauLcyqqrsUb4WSA7Sh6wBu0RfPneusuZ+XHAspCE1z2K/rbneUOoTtvIEQxhRCxS1uAxDt5PKnWb49SRH2CeFv2JQTeSN38cRXBeCBuW8FWFYUAG44wr4w5kgz84ZMOQRHoM3uqteIfEHgRt+yoTSsuL24Iu9lueQuQELa5Abatc62AyIfBXjUl+tVzuhED/GyBP+BAMtd1cbK7HSAnXZ3tyQMsZXye7UhiKlogkTiHIp2t2kwoEgM0Dz2DjDCr7pipI8QWu3E6FvrNMyt0005ymDVoVWsG0rUxvZ7KBLe6d04WRERSukgXR6ZNp5EDkA+TiVBqBzCiHOt4o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(6133799003)(18002099003)(22082099003)(56012099006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6PLJRvWkNKcKVl75E9M60E/J02NVfeSc2wQAh3h3GO+hdl/euHW6kv+enCYm?=
 =?us-ascii?Q?I7+KTx3Pi2ehHd0+DKrmFzZMt7ibsKXNeMBDEltZ8iZtfdSOlr9blcVjLHCQ?=
 =?us-ascii?Q?K0kP5a9l9FMpbU/VV92NFdnUtjtNGW1Ew0AN9/e94k6g/OOWnOunzfsB+7OM?=
 =?us-ascii?Q?3K3baS+UUkNXXHWV1jtt6vO6tAkrVrBfe8JyI6UfDpAO9VYtPJhNoMiViZFk?=
 =?us-ascii?Q?bOTLUHNS1gIoVS0mCfCrWoY4XuaB+7Nz8oJfKiR8f7YfxGHCjk03VX49E31y?=
 =?us-ascii?Q?JCD6On1WpX7YiazESqt2DxqR6du3X8dOcwaP+47SQm7I3nLT1Erlp4C06+Jj?=
 =?us-ascii?Q?iKbAso6iUfNX5ycOuBLulTcN706+cHQzz35SnMYKlnizkH1PZQVUs/edLANt?=
 =?us-ascii?Q?IN17Bg5Gj2P99SojhAqdQQ0t/jm8RPVkN6y0KMfcI/S10SVqYhK4wAt1tyyV?=
 =?us-ascii?Q?92Q2uURPsqzKUDOZmLKjs5s5MhH6QI4PAZbUvTqcwEdcdukWLKdso6vQ1SCK?=
 =?us-ascii?Q?Cy/7QEqI2g4GTcalvx61Q72JL5IOODdLJAqlaXXXbu8CJNYzL3/6Nn2kfB3k?=
 =?us-ascii?Q?kWzKIci8DdMSlEFCbsZiKfABTQxaBytfT0IXKqSPpw6wl54Scu+9x3bzgV12?=
 =?us-ascii?Q?fn3Ji/dMCgIZyuwyGCTKzfFjKsTbGRPqCDqWGH5qAVybk/mzkALpdE68mtbk?=
 =?us-ascii?Q?mJXmDgRukZ41+O6l+8lCQYQCTPQ+bV0Tpr7xJ2CHoRyr1rfxPFyJkpVBl/tf?=
 =?us-ascii?Q?AmhGSRgIlZGlGuU0SO+jrfg/q4VwUhA07rZzJWll0rmC/uYO5ITF4hvFG3rt?=
 =?us-ascii?Q?xyPlvR/QDLvjCOmXBj3dOSQYq9ClnNHAnYlZwEkJtLHuI0V3+FlN5jEMtWbe?=
 =?us-ascii?Q?NZgTYeQzOFc52xiD5sNcqNBPdJZwmXFrDjn74IdzPCDzB23/6hCUEZVCjR5D?=
 =?us-ascii?Q?5YkQzdUCGQxcFxMLhbGuIZucTsyMfwc1G8TJ1ZxKsAZ1t5eNDQjF8tgNTIpt?=
 =?us-ascii?Q?VILOC1M8yVZVsmjwAOpMCGGUmU6UJjIc3TzGHUWTd97hdDIJ9eXhRsYNO8wK?=
 =?us-ascii?Q?hEdN4W6tAwiItzfzDTt/BnLAUW+XzPULu59l3p9Q//FcqCaJ9QajAG0B8bp8?=
 =?us-ascii?Q?aRFw/pt24gpdq7MAFcpwe6jwUSik1ncxw/PhinCMcnhcE6F7ndTkHFm+bK83?=
 =?us-ascii?Q?Jm4vvpjsUVyL9ClHew5qGaI7gqYsTj+PAix22LFFZ2FzOMe/+xEcKTPD4Qer?=
 =?us-ascii?Q?mLlBteuHz8S73L9wEEwRgt1gzeenJ0SJcyZbXpphLENuZbMJsvH/hDNcngPa?=
 =?us-ascii?Q?bAgC6K3qkiNDt+IlWBOJNbZiVdEwdrqYDn2qFmDMVU5BUZL00xQcxM34tgU7?=
 =?us-ascii?Q?R9fYdsLgSM6aayZooW6TsQzMoQryB+ll4AMGdVocFNTnU/oz1Xt8XwZzaqnd?=
 =?us-ascii?Q?ePAKjIKImtE68Wk7SyZ7uNys7GoAmoJgr2+CzL19NaP/ujDlhxOF56MwhpjB?=
 =?us-ascii?Q?joStEMfEEDU6N/JzKWyNAUKktnjTxJsvVVcjAJY3i16AmUd5x6S+YRCNy7Nv?=
 =?us-ascii?Q?QEtTyxf3gFC/w5rBa6dlK6E2WHifPv44Xv2h5zn59JnWAJWs8CHCzj8jTuWk?=
 =?us-ascii?Q?wYNgqdxCgc9cNIL8Nu1DsBzvqixeiKOdeh8qdDryhe/bV2a5W9w/JdVVMRiD?=
 =?us-ascii?Q?fegC/YA6BI5q6lDZiq8D+5+ZrRZdqKMPfgMaKf5IJg2UcRCjzvibNiXt52ZW?=
 =?us-ascii?Q?5m6qwaV1lvr9grb3imUVklnHzV3bMHM=3D?=
X-Exchange-RoutingPolicyChecked:
	LOiU15XUtic2NiOG7QtMFD35YlTpFQ5mpxxT2KvsK8XS2g3uCHEdToeVomY5Ll1HGRSeUm2E0+jvSBVvNxx6AR4V5YaByNFdhaG3Wk/iPYdUDlrMsvl1+ZygF+PV40fdo+UsNsNfgbij8EGatle6zUl1ltL8vL8/IJUtaN8rNjJKfgwT1e4kZ7+YtWNUFhFmBseqURtvBlMA+aa7WVbv6i2jdU8IDk/LPVtyN2qNRVWAWhmWUFOH1aaMmLlyZdoe+4gOzIt+gFW8lEvCGYGep5YEUB0QSjDGg+zl7y8psBYhZ9MzF8Xnk8OXww1ctSJimPWl0z+Hs2ehJupt4ZtyFA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bs2ghpGVNW0zMmPxgBORF85BFRt0X9lx6/u2ygDDG5BBUCweMDyHBkdTQxrweEXr1EF/Kgeja5E1/o5w1P8qvQtsJkmuf0KEwxYgac+6Ysk9d0b537MvPIpXkm0ast5PN1+/nJlq0mHYeafXJuM1qqtRLDLivSCIu2/o18y8/Si6drX20BUs3kh3KbjwIAwG6Ue8aobFknM0r6v/DiReE7TcnbnOwHycgUkkai6prruvd48fYsPhuNB2kgzJCGDz/12XS1uUYMFveRbfnOxmb5mWXYqDkwcJgVxJ6fZPSjyvPaR2dMcX3nIu6kgrgk5CYKPJtJGITHqYe2DqBfORSIy4qGDNbxXPeWUDfDOgupnVimtXgMeEYnN4hVxiq9IvHXaEvbarmIJ1j9I8aEXkRIy24YW6wZfEOOYj6niWYRKNCPrG++THkPyxRkww0oH1gvREdDvGZrI9vrnlxTLnS1W3Z6vzBD5cFulHlMMnoI56T9RsjNNGOcvPbm8GDvOW1+mhBEeIx0006FPy/ltHFJfY9cGKbREQ9uHQk807JKEfpNIqKaNAXstgLT62vbXXAtA4KX5bzMqtsp/UKhgab92snl/UkrC9QLq9EE9Hd9g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20e201f3-f452-4a5c-7f93-08dee179d8f7
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 07:30:58.1731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4gWgf2QWUTlS3tov0bk2xSeQhy0FiGo9LYK3ym0pZeEp7/PDxtCf3Nfz8f799jVTNArafiC9wPAgJqfHyqHjlqxmXvF1eoLKbBgaJh3I0gs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7124
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=999 lowpriorityscore=0 malwarescore=0 phishscore=0 adultscore=0
 spamscore=0 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2607140076
X-Proofpoint-GUID: 4A3sO6K7YiOHEp68MKyBeyGDQZ3NxJ_r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDA3NiBTYWx0ZWRfX5LhZly1CcKvG
 ezVWo+ZD4Ed6dxQu5reIHmQH+yY49CcAMW/ZpMorRjqqz7f3VsKwZODVviDrJ7Bb4AMDurxHakA
 ENVHa1/Aqdqme/+jlVxX1unuHqmNGZNZDfWIMEyGqeUSpGIf+uh2Ob1diQtuKTdygN3jTm4hhik
 zCYIlKLMXi0fne/+mqt8TRU6c8pkiwSHT3lke/7184yRgX30k+mRN1LsLEvk+Vs6Cqb1gohEMsR
 ttM/DUA0KHL1YwLbq+4b0yBfVntLXJvn+xYPXly3SXReSgn7cbXu8ykcK9YhQdbcjBsQn9MZ/GT
 fx6+MzMyU4QcROnOMuW9geL7lrPCnGbCWQb7LcHwI6FuGdsQyZ+jLzRV4r0kJxdOLqoNsiqoZ9A
 BxhWyzxmXxqbyQ1nroZVrNGYDo0ssEVBkCmjFkWR7jOoCLeEk/3HTh0/6QqEb7I12hHGfSMmtKv
 dSstjw2bgVpccqPRO7N6D5pfyvYTJP9LkncAQMx8=
X-Authority-Analysis: v=2.4 cv=bJom5v+Z c=1 sm=1 tr=0 ts=6a55e5ba b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x0eKOSpe3m1H3M0S9YoZ:22 a=7CQSdrXTAAAA:8 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8
 a=yPCof4ZbAAAA:8 a=Or_-VBqfnECsjC7ky4sA:9 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=1CNFftbPRP8L7MoqJWF3:22 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13633
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDA3NiBTYWx0ZWRfX232p7iGOa1a4
 gjGetnNzdo/bqnkW1Dr1G7cQ3yPJsHZ48MyRFeEygsPr1b/K8fyekW4+XdfM7sT29Sg38C8lGC/
 a4m5/e4KgfQwstzLN1ZMyvPAdPqCLokdRXB1BQGXU860tLzZz8Rs
X-Proofpoint-ORIG-GUID: 4A3sO6K7YiOHEp68MKyBeyGDQZ3NxJ_r

To handle WFET use __cmpwait_timeout() similarly to __cmpwait(). These
call out to the respective __cmpwait_case_timeout_##sz(),
__cmpwait_case_##sz() functions.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/arm64/include/asm/barrier.h |  8 +++--
 arch/arm64/include/asm/cmpxchg.h | 62 +++++++++++++++++++++++++-------
 2 files changed, 55 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
index 6190e178db51..fbd71cd4ef4e 100644
--- a/arch/arm64/include/asm/barrier.h
+++ b/arch/arm64/include/asm/barrier.h
@@ -224,8 +224,8 @@ do {									\
 extern bool arch_timer_evtstrm_available(void);
 
 /*
- * In the common case, cpu_poll_relax() sits waiting in __cmpwait_relaxed()
- * for the ptr value to change.
+ * In the common case, cpu_poll_relax() sits waiting in __cmpwait_relaxed()/
+ * __cmpwait_relaxed_timeout() for the ptr value to change.
  *
  * Since this period is reasonably long, choose SMP_TIMEOUT_POLL_COUNT
  * to be 1, so smp_cond_load_{relaxed,acquire}_timeout() does a
@@ -234,7 +234,9 @@ extern bool arch_timer_evtstrm_available(void);
 #define SMP_TIMEOUT_POLL_COUNT	1
 
 #define cpu_poll_relax(ptr, val, timeout_ns) do {			\
-	if (arch_timer_evtstrm_available())				\
+	if (alternative_has_cap_unlikely(ARM64_HAS_WFXT))		\
+		__cmpwait_relaxed_timeout(ptr, val, timeout_ns);	\
+	else if (arch_timer_evtstrm_available())			\
 		__cmpwait_relaxed(ptr, val);				\
 	else								\
 		cpu_relax();						\
diff --git a/arch/arm64/include/asm/cmpxchg.h b/arch/arm64/include/asm/cmpxchg.h
index 6cf3cd6873f5..9e4cdc9e41d1 100644
--- a/arch/arm64/include/asm/cmpxchg.h
+++ b/arch/arm64/include/asm/cmpxchg.h
@@ -12,6 +12,7 @@
 
 #include <asm/barrier.h>
 #include <asm/lse.h>
+#include <asm/delay-const.h>
 
 /*
  * We need separate acquire parameters for ll/sc and lse, since the full
@@ -212,7 +213,8 @@ __CMPXCHG_GEN(_mb)
 
 #define __CMPWAIT_CASE(w, sfx, sz)					\
 static inline void __cmpwait_case_##sz(volatile void *ptr,		\
-				       unsigned long val)		\
+				       unsigned long val,		\
+				       u64 __maybe_unused timeout_ns)	\
 {									\
 	unsigned long tmp;						\
 									\
@@ -235,20 +237,52 @@ __CMPWAIT_CASE( ,  , 64);
 
 #undef __CMPWAIT_CASE
 
-#define __CMPWAIT_GEN(sfx)						\
-static __always_inline void __cmpwait##sfx(volatile void *ptr,		\
-				  unsigned long val,			\
-				  int size)				\
+#define __CMPWAIT_TIMEOUT_CASE(w, sfx, sz)				\
+static inline void __cmpwait_case_timeout_##sz(volatile void *ptr,	\
+					       unsigned long val,	\
+					       u64 timeout_ns)		\
+{									\
+	unsigned long tmp;						\
+	u64 ecycles = __delay_cycles() +				\
+			NSECS_TO_CYCLES(timeout_ns);			\
+	asm volatile(							\
+	"	sevl\n"							\
+	"	wfe\n"							\
+	"	ldxr" #sfx "\t%" #w "[tmp], %[v]\n"			\
+	"	eor	%" #w "[tmp], %" #w "[tmp], %" #w "[val]\n"	\
+	"	cbnz	%" #w "[tmp], 2f\n"				\
+	"	msr s0_3_c1_c0_0, %[ecycles]\n"				\
+	"2:"								\
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
@@ -256,11 +290,15 @@ static __always_inline void __cmpwait##sfx(volatile void *ptr,		\
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

