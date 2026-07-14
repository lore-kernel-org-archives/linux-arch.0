Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289263ECBD2;
	Tue, 14 Jul 2026 07:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784014290; cv=fail; b=b7VmPSiZLEqXFabbJmzKKnTLBW2ui23rc5DUSc5A8zclqjGzSvpLPFST2jRQHE21EFXiwjBssunkxNgeq6JimJ3JuCJp62ETnSGJ56GC8/oH1rK3QXwIeA2z4UlUs9KQZlDLkylq9OnnGpnIbae2L8ZHRT3zvuynrbBziSJ8Jdg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784014290; c=relaxed/simple;
	bh=9GcRTgbykNsExvkZxIaaWoniBRTV4HwSn+HvHMo+neE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Kd+ofKnQy8s32HPAQ2BX7ANTB1dC9HuV0exMdPsBVQTLR2dIwzRlFXTVJhTUcvm1Ndgv7AEJN8mWfUXwDnl0UU95Ki2yqdqtbDBOKU4887wptzwpf83Ha6jGEGp78bufbF+Noa96zn2yLncMpULLhhU7cWMYjwkXi5Y/0mKHtjY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bVR0IRfv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZalMXMPt; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bVR0IRfv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZalMXMPt"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DL4eUX1376588;
	Tue, 14 Jul 2026 07:30:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Vy+sZHvCqbz2rjud1siu5xhtA8wo+NrImTyrXA/BF/Q=; b=
	bVR0IRfvSgIYJRnZ07AbhbM3v8cXuhM7ANmvuVlBIesAx5rkGnJUSipIlS/VB2A/
	S5SXyo9yeIWUkofFarYIELm9Jsy4pBRv9z6X6QujZojjeYkJ2r2IcqfHJIo1MpLL
	JaJlTnGDPACaQpa4V6DXo/F9hjCmDVbgk85ZfTDqRSJnYXvnjSjg3FS5bbV4O2xL
	X3uXSzktFWFRIzkWlAi+FhQxlY3O/12RkKuzwG+FL4OP0VZa2XCnSxZJCjzMOoC2
	YVL9DeTHkZPegmhLzyc1V1ImrKjwbiZeYRT1Ue6CXlhsGreZuEPVBZc+ScNrH2wK
	kINY5hiPm7OTAKNT0BMJhg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fbed2bnhe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jul 2026 07:30:55 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66E7Hxa6016417;
	Tue, 14 Jul 2026 07:30:55 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011066.outbound.protection.outlook.com [52.101.52.66])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4fbc9dvjg8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jul 2026 07:30:55 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hskG8SMIoGSXkFn93rEa+xTaYiwrztRhL1LDBTS4rZePjGh1rPn3C901ntzRN95z5PHAmDlWFZhav8Gr2msWOcV0O7R4C8Rrue+dGLNwJXVgM2uZyW3eZ9gK3PUPCPQG3wTnPSScImdsQBMbHWgvh2IYEeQuQlGdXXNhxTIXSQd6zFv8aI7tm36aOtEx4qo27eW7G2DBOKIV03TyRO4mJfhBSNJQIkhx7TMZMaXpPFEjY9yK8UV65buto+rRkP3gcSd8fhlGD09miQzA0Lb1h2rai8c7dUafJEN78lqY4aJacgSwN4+ekobQ1EejasApkNu91UdnWcpWQ/eUeQvP4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vy+sZHvCqbz2rjud1siu5xhtA8wo+NrImTyrXA/BF/Q=;
 b=PN9X4LYQXmgy8qm2U4AXXAhkjstsF+s3/PyqmtUQvSawUy8xpsWwATV3jH/1iAfmHyK0l89b8MDvO6CDlBKEaeJx3htyKR1EIK1VYTwko09FDsVJgKVBBxt3DWH0IVviEC92il5H+rpJZnj62xBWknt/zfc/1Y9otBXSLRn6d+eCE8njFHEg6oyCTl0NFDmlX6dJrdJg4ZdKqdaAr8RXH7tndu6JZCkDd+4vI6FTCATc+JAooCat3GvUoWdym5d2xe01M7MsSw8KH51P/p4iUM6D1UKt6tvE+y4LqP42gILx70LVrN/hKjg33ic4ntuUy2wyQx3rW2vVWiyyjg6D8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vy+sZHvCqbz2rjud1siu5xhtA8wo+NrImTyrXA/BF/Q=;
 b=ZalMXMPtwyIKrjqsqp7kS67lhg9UXfnmvAHZyxIg1lHI0Dg7UtbRO7/QeNKbF4f21Cz4ddRKjqfpK7/at7/iWzCFUa5xddUSp6llzhZrlFxzl9PQjUy7blRlqFGIp0Y1xVevU6sLoCv3N5sgP3wGrz2zTTPL10WxIKfBjWZuRos=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CY8PR10MB7124.namprd10.prod.outlook.com (2603:10b6:930:75::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 07:30:49 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.21.0202.018; Tue, 14 Jul 2026
 07:30:49 +0000
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
Subject: [PATCH v14 02/15] arm64: barrier: Support smp_cond_load_relaxed_timeout()
Date: Tue, 14 Jul 2026 00:30:28 -0700
Message-Id: <20260714073041.40250-3-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260714073041.40250-1-ankur.a.arora@oracle.com>
References: <20260714073041.40250-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0254.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10f::9) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CY8PR10MB7124:EE_
X-MS-Office365-Filtering-Correlation-Id: 8737b890-09e8-4b94-3905-08dee179d3b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	c285lz/GVoL5ZXuI1JFaqSs6yRX3/hOqtOqAuWqrjE4pdKw2CFp8t6LMA1oBcQyPjnXD6wLjTcUm7bZHC++daWKKo84Inmc9nPEo04x/TLPyncwsWz2LiQL0H8p05OhLxySADqTHWAuK10WEQJRl/6ozgMqE9ch8eNM3iDBPd47nUzs1ZoE8ySrG+pmESVVTHEeLA2Vbz9+0bzg7OWJR8tu2rS/0d+yKxIblvd9lgXzPYkAHaV+SxS4t7cmSoQf6utHBJ2eA5795tfLiyEutteo1h4BYNYznMTRrtO0GKzhexsHurwzmJrjuSzTCY1qeoIBowO5ToIoYwaqYSNWFCcgs7dYrfU3N9JV94FffQlPb2pe6lnTGHlfwo4qe2w2pCfiT3EZ0DI4oGCPsJXS4yoYNhRCRJNpPwDz3PYzIQyfZzIHPxhkYgP7On8n+5MwdCOLRd9VyPSwoAsGvUmUUeF1Q4YxMqhyFjNHI0W6CIr5LXvu0yrSfs1Pd8eU9Xw9CFaJqMTBVFTaV7z6KoOFzgg8BzKNFNxNedx5gZkq01yLvO0CzxE32FA2p/lmQHzWHPdZRebPTJ9ZKdL9YfOJ5N/FsRSLbCaRamdKqa3bMSSdq9UkL/2GbkN1cu6nVxJNtMIR70grDq1B+Diyo+b9kJIGOGpE6ZohV/3YiCSgCr4U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fM48I7D/EljYY4C/1avPbck+cqPBiR7cO49cGAr6mqMzFyRrznDdct6PSKIt?=
 =?us-ascii?Q?FX7KZ3H9oz+iLaToZbH6wI9WOWadxu89+QF1eLsmx0pnpDFJejxdtrfqLAtL?=
 =?us-ascii?Q?8W8l4C7IGGfjEmz+89rh58l3nHTAvyjn6jHfuUOPT9cWqb9IoDcyZ42RJsgJ?=
 =?us-ascii?Q?TIbuLDTGg63QfTjy1LzRrGGxEhHuDmhe/et+1MYV8tYxVFkIWmp+jlnDZsdc?=
 =?us-ascii?Q?ITTg3WeNQkVTYW06P4ZVL5cjEgvUOuM8xENXwS8sxJlUN8WZSJN2NqQav6sa?=
 =?us-ascii?Q?tI7HQiIHKruVZKvfhMsr6po9HAY4GK1qF/0PssAbxMYRU337DCVc3B6W1RPE?=
 =?us-ascii?Q?UxvWY2W1H91RIBqcklIRFsJN2YBcvZ0gOOeKBuy6dfel+khqAWOkMq9suoQ0?=
 =?us-ascii?Q?z+9lZLoRqTrCevfQpIj0eL/keuRjnNtvHMDYPzC5AXriySnhMs6K1Mz+TMjZ?=
 =?us-ascii?Q?RbH+dWwtkL991cB31NDzCL2e4VbQrzHXsegTxKDp8vT7Oo9MPfItBYyKUPWO?=
 =?us-ascii?Q?g7eOjxu80/LO5ZfRU0zEBfvbIJoGOtqbRT4gfpbH7cEYuVmApKMqyE3/ezCY?=
 =?us-ascii?Q?9W8jec56C4T6dI03+UAm5oKLQqUccSslF5+RT5CFjvauU7BivggxTSz+Zfhg?=
 =?us-ascii?Q?SXeMo4ny+2qkDCj/Z8nIi8dBPNLze49lpygOKjdhkn6o5FEWtHYKW3YRV9FS?=
 =?us-ascii?Q?aI27k/RePUq7eXuM9SMMEOHZBmKLcyX8Cj5MK+U3m0YFYy0w8YXpip6GINyb?=
 =?us-ascii?Q?uwR7KlqNKgeWKDaGjwPAo+zvYjhA2FkuwF07FGghCevm30Dq1xPlSrO9eMEt?=
 =?us-ascii?Q?E9apTMFyrBeLno0mLcHJi74vDfXAmZ6PTmPI+8j5e/+nmhgTOD62H3JSplL5?=
 =?us-ascii?Q?1aJXYksA0xF2Ou0hQLwfqwUCPEm+79z/BCTUHyGOcA7m/Qm3AmdPBCpi0lN0?=
 =?us-ascii?Q?Yrq1fkapB+1BBiwnIcZfGSNGlzztlhfPdxPk7y20/HCiJAX5sakLlscXRMVl?=
 =?us-ascii?Q?tJxSBsTCOp0jsme5WKFDUvq+mPo9y70gtk0mE3+XWfe9xpZ4iLHSDYTiTOTE?=
 =?us-ascii?Q?sBRzbVuQgLZBw66BT+SJ7QW+ZZV0zv8LtWOQENO0Wa3DOO/38N/6NvK0rPRv?=
 =?us-ascii?Q?EdJGJYuaIQTYy72jRh/D7xSedd7GDuH4HK4qEvRXreqCQJHpbkzFu8qfRbOc?=
 =?us-ascii?Q?2adID15XL5ugqo2dt1fuKqVdeSRsP0Nebi7lW/HN3VOUhkiNar7+eK8YE49e?=
 =?us-ascii?Q?LFb+WyYJP0zZt0JKqlfAozGFcFo+5TrzbcF0WdExwBA0oF4hDgl/CmJvwiFY?=
 =?us-ascii?Q?Y165IPtIOMhaJXHcJaE5WElBBaBkcr/GL28tsGofkPNFuIuWegUg1091xEkQ?=
 =?us-ascii?Q?HKk/JZkfG3CXHcZgXc9GQ3+XM4j0UWRoSye9dfPvYimOnCfz0yFFxm9Ixish?=
 =?us-ascii?Q?lRz3teXMZXXhrHZfZ9dqmH8++51AnGJ+hRQ0s9dYYeEzXKJNJUkLkBQb71Rb?=
 =?us-ascii?Q?v8AUDUVlhu0i6MsdLKS2JFeLqOQn9xjbeuUUi/HPBOQtmCybErronx27pSej?=
 =?us-ascii?Q?HyfGh2nbbxrQOLc+QWIh/dw2E3TpHLgzgWxFpD2fXjABm1KlLdxPTJ5rf4hp?=
 =?us-ascii?Q?QC5AWcX4sgcCLgbeoaQupJafkUSl2ZENRJ6+LzFESfFYVSWwA0cFS4q09up4?=
 =?us-ascii?Q?6jRLHoeHWrUZz711XzKDcL9ROUF0gSgVNmD3OfhTUgmelkoLi+dbjYjoWJqM?=
 =?us-ascii?Q?nco82g8FAa5RUD35tF+exL8ACJWEz6I=3D?=
X-Exchange-RoutingPolicyChecked:
	MksWwMv4kbx8BRnYppZdQTyS+btw5JDJnJAas+07nYDc9lQ3jNSzyho8a5YFrDniolf+S+v/a/DlX56OUwluAYBrtJsPB3B6jy7ITnLbvwL30ZRQaCw+D6WgXjkthoJWaha/DJy3dCHx6X8jt2Lquq34+KH5mKGPoO/rdk9DxXmQB/xODgd+5mP4atSTajXUzZY45ST105CL4SQCO17tlegAsgEOZqkTV885RQpRtr6YtzmQzg/8Cx50gAwvNE/CSxXlE2N75akbrpyfYz0i6R5D277XGqTr3zCcJRpTBdTRWzGUkdh2ZHfNzG6SIaC6C+K3Ebbzjf1S9krIgrp0+Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mqAoNvwSSpVNwB/kNE3gVvjeKyvslyu4BEfR7funxd7P8JXxXVuYJMNd+JQU59y1rBj8oi35oMZTiUv+8tkE74JPdtAQjliiKY00nyzqYjJfuuvxA6pYbLnHtWepIqOyCUQrJd+7GLUCVY/X388k5UV1VJrGJOeewi68avtIjgyNrRvBYz2DtxK8SNIPHYtdfKiOAlxJ94HmYRljYTpdTFfE+OQz+1QNq26sRk0oCcZsdeg+EECYJyaBDlqk37dnK/VqqpvqSt1xw65Vj+q0jUPr/D7E0a7+hvnok9CqUutwXFwyaP4f7ve740yulT+9XrXpiwPzjC7idnYu4iJvoebQPRlwSp/bbUCo94Ztw0KCeah9sWQ4UI9Y4turA47dVmQrk/IcUb7ymOGrmn9NOk4nbaLKVDazDqJndGLL03G2x2qVfnFLPFntJqT7qwIDYYOndGgUAmTq2muDEhnRUWiVWOCoxJ1awLTQWIQ4DBSW1Y6jl480Gc4pFQn0/pATpaFq77OuI5lzUkapw8Xzrqj4aGSd0jRU+yCVlzhvgm4FQg/BtWkS6b12jYG44BPZMPFZ4YhR9whkz/H3zaQ7TZSwd8gDz4q8OA8ONnBjRO8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8737b890-09e8-4b94-3905-08dee179d3b2
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 07:30:49.3939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mITVuO7v2EOVdUyMMuSyjJmhI7bAvuDpDJpaxM7Y9kwTpTLTywRTmhEB3gFIl0no2lXsZIDFg/h3NTcQGZ7FFah+9Pu9xoSLFH7Vtqzhuy0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7124
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 lowpriorityscore=0 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=729
 malwarescore=0 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2607140075
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDA3NiBTYWx0ZWRfX7cANYyPSXh0X
 VzvjFyxJEDYr51FPyKhwe4OvtvIFJXD7hVnr0i0KGllPAGwsJhaGf6EsHhp/okYA3/f1T+QKmie
 +/WyjlQAhXlltvyeEPp3j90SMRi045gj9KGsLF8OUO6WwL8eFzft9qlMcSZrpLJyJZ2+JaNQKgU
 EAEpaIQ3VJgQJV3fbU8eCU/ULhKAK8pRNBi1QCmCtwPrIGWTb/M/YOSCAJyzPKbHuBP7xmV/Xaj
 AQxVmjK383APMvYCvVMZduIAITXBTUhoXrELvVnUyE8/ZhOi+CfLf2hkxxgI2o4BScUGpNiIluk
 zSPYAiozs/NbXoSQh8howNx/xAcZUlDLICznwnoxHogQVUDg6WdAseR6nSnQ2pzozKLjBlXYkda
 Q7ZGL/5NFaOBIjtenGyC/OHCZoKOwX3bhoa6rGtQPn1wXJ4H5Oz9Nu5mQ1RvqtKAwyX9a452YpM
 XAo1B7ZPK9JoPzGiv6w==
X-Authority-Analysis: v=2.4 cv=GcknWwXL c=1 sm=1 tr=0 ts=6a55e5af cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=JfrnYn6hAAAA:8
 a=yPCof4ZbAAAA:8 a=x6ygOChz5MOYKFFXTgQA:9 a=a-qgeE7W1pNrGK8U0ZQC:22
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-GUID: lbhJk66Q-b5LitCSMFKVtKEcLFblyubI
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDA3NiBTYWx0ZWRfXy1JP2BrcTSvG
 8UL3KxIM7rmhPCwzWHPDJB186r4gwwWZGivE07jJE2Xsha6B8BP0pOIiwdrRZ0HrvWEhtx1+9XO
 qU7UFLz6GKUL41aOCm8+glBiedXlH6r1vjP8WSaIw4kts+2Uxg0j
X-Proofpoint-ORIG-GUID: lbhJk66Q-b5LitCSMFKVtKEcLFblyubI

Support waiting in smp_cond_load_relaxed_timeout() via
__cmpwait_relaxed(). To ensure that we wake from waiting in WFE
periodically and don't block forever if there are no stores to
ptr, this path is only used when the event-stream is enabled.

Note that when using __cmpwait_relaxed() we ignore the timeout
value, allowing an overshoot by up to the event-stream period.
And, in the unlikely event that the event-stream is unavailable,
fallback to spin-waiting.

Also set SMP_TIMEOUT_POLL_COUNT to 1 so we do the time-check in
each iteration of smp_cond_load_relaxed_timeout().

Note that with this we have enough to define ARCH_HAS_CPU_RELAX to
indicate that we support an optimized implementation of
cpu_poll_relax(). However, defer defining ARCH_HAS_CPU_RELAX as that
enables polling based C-state handling, which really needs
TIF_POLLING_NRFLAG.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Suggested-by: Will Deacon <will@kernel.org>
Acked-by: Will Deacon <will@kernel.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/arm64/include/asm/barrier.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

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
2.43.7

