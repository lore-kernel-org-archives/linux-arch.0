Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5977B3BC673;
	Mon, 31 Aug 2026 20:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788207838; cv=fail; b=R2ZceX/gAeWGqI1gBHNF5I4prdJqXsqmZUE9w67cvN5njFKcazckcb1zotEYoOGuwXwRTCRiRrwJhGFcNt1d02uDy6VWn4l7YyWL1IS1Mo4rcfRrFXLbKQBZbNajJJQd3EpNG7bjaGtVhQz+yZtTatmdY/CjgM8JgCKiK/t6gXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788207838; c=relaxed/simple;
	bh=ilb2S2/siR2BPVjdInXeZmOhaQDJRujS2yUk1C1zIPQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VO+TIYjf6tGdLpfUL8Gg37/QpzejRBjOtIeyfkxlaRqVDpicDZmp6+ptvp0fbo5aDEruNsyf+JlNspw8xS22vKsK8l/z6sueEkxeFda6zE2upXYfY82dx8aUxuluQbUhhuW2Y/a8Sx/ESMZkw3ZoZ1IOzjKcXQISlPnCj4mkE58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IfqIG6C6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fB5WQwx9; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IfqIG6C6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fB5WQwx9"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VGBmRr1783787;
	Mon, 31 Aug 2026 20:23:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=NvAPWkFws0xttWoNUFocoBjnCK70udKzyncjMmMa7Ww=; b=
	IfqIG6C6lwZxGq2K73p/2hZmNW2FgETfssugBwrcpLFQSryJ1hg3Z/3euLZA/3Fg
	NwHJig3gGeZ01i1p4ttN9EVbd9IPKmMcpYNmnvYxVyWxIelNfefYiPaINpsG1Zif
	ObrN8WdKDDpVpNou6o2gTX9Imr3eLzHaQKaUXLPx1FnG1U3AeJIwBTd1vpAUTfho
	Ier28SI92943BfPGAfZXYYxHZbbzsF3LnNa+L5rweJ6DerN4j4NGksy6ntxNDder
	EM/2/5lf9UFv7sho4Zui8Jr84IdUheozMB+nFfrats1sCcl3vJW7yjU0Xi62qXOV
	1cFiwtYi6mZyMyZB1lyhgg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gbp0xud5n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 20:23:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 67VKK6mi033292;
	Mon, 31 Aug 2026 20:23:32 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012054.outbound.protection.outlook.com [40.107.209.54])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4gbnvdc4ve-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 31 Aug 2026 20:23:32 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hYEBXtif2CG3heaL4U6DB2cERPTSgFhjntw+661Sn59g6aLpqk1O3tWjfzxC9I8NTN9h0J0dGE0sx/7jdLKcH7r9moqBZDIaXddU4V4TN48cggUS8hdReDrAvMAz97zl0iw9VCnR3TtCqyV7+EkidzydI5hfJiS8EhLXof4HkZ6wwEMoGJYPsDG3PXR1VYcyM90jfJhOJy/dnLLlIVLnRljmHQzu0adjscPzMPstuQ3pKZuOjD4GaJ8rVN3jXWaZVejqFqFje9NZlL0p0YoKvcS3WMNcf3FiGU34knmJX1VxI1E7VWxQh4r2yV4uYoTH/uc/DaHVidLRYVFkayTqIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NvAPWkFws0xttWoNUFocoBjnCK70udKzyncjMmMa7Ww=;
 b=zPVR2b80qc4DV+ybWoiKrobd3H4ZIcgOyykDjLsvnGNj4u8O79eEpHEn4L9ayHSdajteXjly+zhJ7Rjtrtbmy2bas8coxqk7cAa/Pt9qBeUNxr+z9zTN2/Dri7sN8WQt8QcGycJ5+mSfJL1jgK8ddBXzeM7jl3H8xGlT9+WdhDRnkY8LSitZicKRtD8xAhzGQ4fHRths2+BMTwZ/9FYnwFa4gG7Rncvm2FS+C3T973fmRI4eAn8UYfFgOIlPObkziLwG6cngOdjRJHepp6Vi0gOnJ7xYcZSH1V5+tDIVWVxZqy5S5mK6NTWqnogIfuoToNXBC2m9QU2XoTduV2/3KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NvAPWkFws0xttWoNUFocoBjnCK70udKzyncjMmMa7Ww=;
 b=fB5WQwx97zuiuN3dlKnutnCNhbyo2Ln/oJm9ns9WDPpeQEd1U1TaSLXIBEol2Hjxr3JfkfiEa0BovCWHFvIOeQ5UDTvRsv2gROTwhn1FFXefirgqfdHhCYPijUPyqX6qgQ3d90jzBvFWuks0rcFp3goPO6ASx9nl34BcjrJiJ6Q=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by IA1PR10MB964822.namprd10.prod.outlook.com (2603:10b6:208:5ac::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Mon, 31 Aug
 2026 20:23:30 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.21.0382.007; Mon, 31 Aug 2026
 20:23:29 +0000
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
        Julian Braha <julianbraha@gmail.com>
Subject: [PATCH v15 14/16] barrier: add tests for smp_cond_load_*_timeout()
Date: Mon, 31 Aug 2026 13:22:49 -0700
Message-Id: <20260831202251.305046-15-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260831202251.305046-1-ankur.a.arora@oracle.com>
References: <20260831202251.305046-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW3PR05CA0030.namprd05.prod.outlook.com
 (2603:10b6:303:2b::35) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|IA1PR10MB964822:EE_
X-MS-Office365-Filtering-Correlation-Id: 195ab031-01a1-4b3c-32e9-08df079db7d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|366016|56012099006|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	l+juq5Y06xuplaBSRvCzyfTIyjEJ28lOM0AAHqd6lbVrtU/PJY1T1E2HRKEnWXu0K9obNLiZdRYrNU2/R/l2tUw7TDf765xDrUEuarntv4hShFHSgziUsWlQ3WjJPAySxqlMNuIbp1kAVieux2UE0q8bxGEAuTnbEfyN7Dm/kqFf9hNtmogafrBibFSJLg67vQMhmzNJIBkrxs+P276Wz/NqdCigyd/+IDXAtq5Pq93T2hAVRjb2H8+a/fUGB0LAvJIXfozjDptZEQjm52g4c4j1LSvHwCNtTFc/5saWJ/oCqbT646jSHVqqz48vipr6/Ux0wKyCxWq4I2N0Hps0gP+YTbOik/1XaCLIOmvPLnRFW7dTLgUhW4eQNfyqaFiVv1fEMt1BCQmzg3PEejz7gZyPiYmpnVI3u84LmU599ft9gHFGRK1eQvKuG9UcYrQJwAYxFFaYGnLAJZWZ4Qx+m7N54VXmq8PIhC2VCwdXsqHF9OzBONqd7jqt423h4xBE9Id8oL/NeRi7hOc+jSG8nMaQb/IQx3tCr4x19G026AxnuI2PG4iQ9Z35Jwm3LC12GUTqzkkQ92e3UkUGWZSQQ9ebBVwxJf6ZPt6hJmw/pYPdwBBjCIagGMPujJ1OXXJoBEwmDGzYun/qwBzJrQxzdepxweT4VTfzLF2evKBcUos=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sec+FPrLU2BWcQJswQ9hvZlaLk++RURE2sJUx0y4AgszhqWsz1XtcdBrv6zZ?=
 =?us-ascii?Q?J1BNJieiRIsWEq3uXA4SFU1DZ2kHDMGQWVUr1yfvRRubu8pZ/TOpX1X1BrBQ?=
 =?us-ascii?Q?A4W9vNbsI25GdIwWRZo+hG4VZGj1huG+JdP64fSE4g1BrDjcbD4EAd3cZpA2?=
 =?us-ascii?Q?VYVatleM70bOGiXD0ECKcGeV2WyWayfx4Qy6EPjOyuRKQrqLqdtFw1AvNPcZ?=
 =?us-ascii?Q?CofdKPyXeECW0oPkkdg97zVudgMV9OYmYp7GPI22EaabFyuDcbQ4zLk+zMgO?=
 =?us-ascii?Q?TSmDxSJPxEVKd0+DeVXNu2PV/y/INZsBy20/bXM7rsYg7dQBGunE2neYUVX6?=
 =?us-ascii?Q?e2kXV0wfciti8gXGnz5oGL9M8rLButwEFP2300g+zB9GKJNfpIMVSvvcTPhF?=
 =?us-ascii?Q?PlAnKaWsL7cIPK7Dzq+EDZJW4f08zHhwLB1IXnKdIQs5LAvMsxXSCYDjWAYs?=
 =?us-ascii?Q?EssiackC/iAbzRRwgTdrNY75v/UVR/Aj4qt67dUS5RF9gmHWE1bv2x91/6uT?=
 =?us-ascii?Q?/GfKOwGywuu/ssVXu1+sj/n0uy8Ezcz8bI56a+Dx1BReCtCDHvR/YVxpiJ27?=
 =?us-ascii?Q?9BZyJ8eHUx8yEF2mDEbLmuEgyE0llW03/5IK4jLyw560us6kgyMs3u5WD05L?=
 =?us-ascii?Q?Zb5RdfMeXL6QZhHKPeMX/qQ72K7VaX1JeG3oJpdRtwLTJxWhsBeRvoskShIW?=
 =?us-ascii?Q?aoReoIkBqnlqgqzqyT3O6Z4JJ/bMlyq2Lz0dOfsLM3RUER7PMjVXuaZDYSjS?=
 =?us-ascii?Q?6ma5ipyccXq1i9nOuzJ+HIDVoYkubF8GwShnesmpnKoxsSDL2/l1YD++Bx1Z?=
 =?us-ascii?Q?dl4kDxLCtf8+hbrgHhcjcQBr4fekG/lxo4kped9LsYAHA0ljn9cCJTIBpTgn?=
 =?us-ascii?Q?rhBEXtKw+ZGiSgRvC10YJMhiinjC1wKALVvOxa0aaLL01pG3B9Mv8Tx9DybS?=
 =?us-ascii?Q?K74gAbe2DHPH1YcX1ohTFkMaG4JIz/YasxVD08+pQyFJOz361atzzMBIaGus?=
 =?us-ascii?Q?LHbolOR4OTUd7gsYparJV+6jrqAuKCB7bbhjWuAPKXCGaTu9Fa1qIuzmGU/j?=
 =?us-ascii?Q?z56nnTmAa6FK0HQP5CSvOvwmPPDdyr+YBIP/4qaJ78KV3273wACQS9Ph8aYb?=
 =?us-ascii?Q?CHZWg2klzBaX272DSanEfXlJsWLegtiiDqUJmOd1aBPFTs/A5BgvieHMddbf?=
 =?us-ascii?Q?k+eFxDbw3uSs2nsJpc7nbtSZeC1RdiuvNQ2rRVNPGnDj1DYcq+J89tAKp+RH?=
 =?us-ascii?Q?scqajdyeHLMk1Gdk6B812sJFxaOj/v7UdpL361TnTQyq6s54yiqPNabVnP+B?=
 =?us-ascii?Q?WfBDw4mUuoK5DlRE0ZMlUOiDk9iZf7+DPc/7KKowpFuNSwsXQO6gVweOagC/?=
 =?us-ascii?Q?SsdKMFSCSK87bbBhZGE2z1Ne5z26nuIYgQbhOQzMMb5B6pBOFQytOdkKt8mt?=
 =?us-ascii?Q?pFHbxn0RWQxuNFeKqEl1Fk7NqhH4JnEZso9ju7Dj3OxEZPdSXIf8lJ8BZ00Z?=
 =?us-ascii?Q?PuBPk9z5JMmNpsXELs7CpxAqoxll7cQ03BpvlYTTHShrANYF1h+aT0C5MH2r?=
 =?us-ascii?Q?EZsJmdLP+JmOcfvCEHPBHUYKXvOAbFiHgl3z8LJl9KRlRIQkVmb9uIHPzP7H?=
 =?us-ascii?Q?o7EXvS0kxIxqoWXboZRthB0ZtF+mQRLidlNUf0CrskWpJhRl2h3+aMcRe3Qi?=
 =?us-ascii?Q?Y+GzIUoWXnCT/7tmVqjL7FtJlAWLuLvMhSVjwe3lJwUkfgz6qYjYn5lNBMOi?=
 =?us-ascii?Q?V5mMOIlLvP69b8a8tnmNQVXKUOU/Wig=3D?=
X-Exchange-RoutingPolicyChecked:
	FW4o07Q3o5Xq0ayMFMFEpKtmIHFhG0u7OH807ZvyevrI9r5ngs0+qUbytVEuNCYetdklvEmDiIkqDwRDneKJRXjBpguTifhpvdABFy8FSBsZvDUr813ZrOHyY3MkGvkox3Yz8pCK/S2KyxnH8bpzDMJklXordvk+J5pxB5FXpcUss52tgB98DRxbvH3+3Ns7KcFB/u8RzDrDb2CfXfbeq/BH8gu59Lr28eRE7DEvWGvt8F15NA+tFZigXMcNHfiAknwp8famDcy7E9pTpw3s9aK3VZCNO9cHpT9ylz+n31WFD4RLzHVyNOn+dzejlnZqRWY49PoR398RnFiRwntSzA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LbuCL/Ys/tAhyROxTf0LPp0ZW1/q1vSMrIWjpLHowQe/uan0fZpeMk+RrJCdormKiu0MMd8xPyPGKgWpDnj4bG32XYaD+eAByhOBZG1VjyiUmuvD7p6Q3wXwO2rO+wrENm+uIxMQGj1Nuv18nF+JhJTiUjSEV6pFo+0FLznK5MdscvS+4e4v8Dqns+MZnAQH1QTSxMlGHEDsMA52KHJ0UrNlp359Tv9Usttdoxd5l+pQIOeNNhrUAVgIC+S2+OvaCO6h2BFN1Xj3KXHpKmVA4OiCR0wGwnkQjcFVWQ8ag7tE6/24/Bctw77opHNAw7t0srKFd3YYMGJpCpxFk3islsRo27/Yru1GxY5Bsv8Ou4BexDFAqsQMZER8FEoeJOChNWPAVOF7rlbsmS+dXZpTRUN/Dzqfm6Cf0FZMcfqCz3RwTZO0l6JKEmCRNRtaNxKXQP42MJ+/RyE+bxojLogQ2M7G7T2ZbivN7UDjiUGSQ8rFRD7EtRBfvulV0v+LSoDQ52oh2soO4pwi+WUxud8GL98hJtsaUzSEO0j5tIzepM1B2s9DRTG4UfFage9oCvo8juM4taEH+uwhEGlYhIc8WOK1YLDx0YwiR8ez6+Ob7Ng=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 195ab031-01a1-4b3c-32e9-08df079db7d1
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 20:23:29.9191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hfo7/w/wp1cyrlaWwsL/wN1XExkschGoaaiidNKsnkH9j/F5gq1gHgUINATmTFUzWRPiIRiPL4y0LqKdlOfY0hVM0EvkhaFHY9C1nkIAjSg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB964822
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_06,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2608310176
X-Proofpoint-ORIG-GUID: 7jfqUWalg-LkRkIkJ-e43dirQM2m0xfj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDE3NiBTYWx0ZWRfXyfzCYvWNhBQL
 tBHkGFpy0FxDg2VU2ix0haG7/NkENnGt+vQ2vyAgkDPuh9sfF3PcTsaoQYpnn3xSOe8xxBBhcfZ
 ucsU9BFhmEme6mEUvGxsjiJPiuQf/VkoOp5GRsh0oOvYStmcP/fzCzr5ql9wpt9wOVoqNjy3sb4
 YzmkpDK0vpyPhXWlH2PLjx6akg72pzXE0v5IMR0KwygPLnhky3Hi7wOwrWBytMq7hFCK6KcQmB/
 NSV/wYzAhMK5SFW5nKE3qVaQauxhCo1mrrnmwPigE7L7TmJos9JSFT5FdjUBh02jaDe77fNLzjO
 SfSZg93b/8tl4PmyP1t5nowwY4NKjTo37E8rv+5vkIqH03E+XpSN0z3psrrKpjhP8cqS0eOhODK
 QGKy4C1wLhwwbTLPEs1p1qD6zkRImXjYhpKKEAqXXFZdu7ezRWQY17VM4bG6cBOIUf5AGqY5+Qb
 rwxXa9jv0kVWi8q2CMg==
X-Authority-Analysis: v=2.4 cv=Ebb4hvmC c=1 sm=1 tr=0 ts=6a95e2c5 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8
 a=RKR6g2HLBOl8dGFUrsIA:9 a=WmVTiCyuxqgg3mnwYu6p:22
X-Proofpoint-GUID: 7jfqUWalg-LkRkIkJ-e43dirQM2m0xfj
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDE3NiBTYWx0ZWRfXzGa1cG2PRiZw
 DFa8YTbIOdciKBDdssFRGvs8Z4ktnP8Uc/mlycMeR11UCmLBg1rM2vAexAZzQxr2KqBfwVwh1pz
 7D8fYFz2sZYsccSsvIhWPmmrOQ+JHvKokYMFADyP/URRveO5U1cq

Add success and failure case tests for smp_cond_load_*_timeout().

Success or failure cases depend on the expected bit being set (or not).
Additionally in failure cases smp_cond_load_*_timeout() cannot return
before timeout.

Cc: Julian Braha <julianbraha@gmail.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 lib/Kconfig.debug                |  10 +++
 lib/tests/Makefile               |   1 +
 lib/tests/barrier-timeout-test.c | 126 +++++++++++++++++++++++++++++++
 3 files changed, 137 insertions(+)
 create mode 100644 lib/tests/barrier-timeout-test.c

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 134b15a44625..c93d1747c014 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2509,6 +2509,16 @@ config FFS_KUNIT_TEST
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
index 3cac3b63a752..711302dd8ab5 100644
--- a/lib/tests/Makefile
+++ b/lib/tests/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_CHECKSUM_KUNIT) += checksum_kunit.o
 obj-$(CONFIG_CMDLINE_KUNIT_TEST) += cmdline_kunit.o
 obj-$(CONFIG_CPUMASK_KUNIT_TEST) += cpumask_kunit.o
 obj-$(CONFIG_FFS_KUNIT_TEST) += ffs_kunit.o
+obj-$(CONFIG_BARRIER_TIMEOUT_KUNIT_TEST) += barrier-timeout-test.o
 CFLAGS_fortify_kunit.o += $(call cc-disable-warning, unsequenced)
 CFLAGS_fortify_kunit.o += $(call cc-disable-warning, stringop-overread)
 CFLAGS_fortify_kunit.o += $(call cc-disable-warning, stringop-truncation)
diff --git a/lib/tests/barrier-timeout-test.c b/lib/tests/barrier-timeout-test.c
new file mode 100644
index 000000000000..60f121fe5472
--- /dev/null
+++ b/lib/tests/barrier-timeout-test.c
@@ -0,0 +1,126 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit tests exercising smp_cond_load_relaxed_timeout().
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
+#define TEST_FLAG_VAL	BIT(2)
+static unsigned int flag;
+
+static s64 basic_clock(struct clock_state *clk)
+{
+	clk->end_time = local_clock();
+	return clk->end_time;
+}
+
+static void update_flags(void)
+{
+	WRITE_ONCE(flag, TEST_FLAG_VAL);
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
+	struct clock_state clk = {
+		.start_time = local_clock(),
+		.end_time = local_clock(),
+	};
+	s64 runtime, timeout_ns = TIMEOUT_MSEC * NSEC_PER_MSEC;
+	unsigned int result;
+
+	flag = 0;
+	if (p->acquire) {
+		result = smp_cond_load_acquire_timeout(&flag,
+						       (VAL & TEST_FLAG_VAL),
+						       p->clock(&clk),
+						       timeout_ns);
+	} else {
+		result = smp_cond_load_relaxed_timeout(&flag,
+						       (VAL & TEST_FLAG_VAL),
+						       p->clock(&clk),
+						       timeout_ns);
+	}
+
+	runtime = clk.end_time - clk.start_time;
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
+	.name = "smp-cond-load-*-timeout",
+	.test_cases = barrier_timeout_test_cases,
+};
+
+kunit_test_suite(barrier_timeout_test_suite);
+
+MODULE_DESCRIPTION("KUnit tests for smp_cond_load_relaxed_timeout()");
+MODULE_LICENSE("GPL");
-- 
2.43.7

