Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681F62DA76A;
	Mon, 16 Mar 2026 01:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773625081; cv=fail; b=s9YySwC3ePl2Tf9pPGZ7eSvbqbeJsmx9bmswTP3/g+lHtFBLlQkkTGFI9uWo6imuxThSdWdRLtRzaljfoXfVWyDVQ71NXDZEkxLlmvYTMr39h1KMvYs0quv/2qngHqTSqkfS7VPRZib/XyCWqp1m4Qg5/tQ8JWl5IxQ2huYrXio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773625081; c=relaxed/simple;
	bh=9SWzbKvxRPpDDRkjzs67oxjSeECKGNvjh8Bj2l2a2oU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Jk+iEeKgeD/mqPFQQ9r+841G/WdarSqP5QDHMgMO43n8TbxhYi8H59UllKc6tu7Pv0r6vTPEjli7/3VpojJOJQLnuDoTqXfNOBxDI1Lwj1WmQ2cDeooGaeRAKzhI0ERzCEM8CEkDvqTnKaJ16BcPNews8+UGdFvwIiUU/aiWWKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nPL4Wc0m; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XJrCq0rM; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nPL4Wc0m";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XJrCq0rM"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62FN0gfQ003429;
	Mon, 16 Mar 2026 01:37:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=oJx8XxcPA7m1VnchLFYkD/RlNIejClEUvx0HblefbI4=; b=
	nPL4Wc0mV8iK6QfyP1/09xFjfzyIrVUo+/HPTkQKeqH73le/qzHAAayCJeuLdZd2
	Zqxl//4lc30RVMyeBeCatC1FAy2jop+G0ENjA8jmubbW6iFuXZo8G0PiXRLL8gS8
	BeNho6/Z4AYj+q4lILlFOxrDE9l1HCRtal62pU3xHY94aKrl1YzJTFbuc9IX4JPc
	06y/o+ZXu+IccHix3E+jKRXp3Ng3+cBVdzR0WOBTrLtz+75RvJVWKQ5QiHPluGSD
	zTpX9eWZHcy3weKxEBu+YHo4U3gTP3sHHK2xI7ikYQ2Y0bftzUUzIER+jKlSaBg0
	+A59Drz2OPTH+LTSBApcsw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cw07r9am9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 01:37:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62FMNVWc002825;
	Mon, 16 Mar 2026 01:37:19 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012060.outbound.protection.outlook.com [52.101.43.60])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4cvx4j84tb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 01:37:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZcQy5TSbR/rt61LbFT/sUPoKm4uQZbtS0Tvuv/tbU9H6RYLgqT/4bIei6RAOvD3YqPAL/98eyCyp76loMRZEyg6qyqjF8B/GZ9pDSOTduJyhD0xzsmfD3mPiaQBRjhIJTJYtFeSfsG9EVOH0ZxXflxXpczJtdnalv7JMdLXhNT/k1z5keJ71XMUG24sUvHBxjPcnxtTRldmyMeWgsHBoRq2nBkIS8T9OWXGLRnCqZ8rByWEb9wM1Le0YSFQ6ApAabxc+d+xxDLT0ShASnXu55g248msbw+MWlR6OF0y6apegVQmACrtrEdzE7Z3KkXrdK+abSP6ueJBqZGTIkClWFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oJx8XxcPA7m1VnchLFYkD/RlNIejClEUvx0HblefbI4=;
 b=mPTUFzxQ3zOd24IJu7j/AOkp9kfpCq4YE6SjU6LRjOKhSPo8HZjcDUhmC7uDjiJR/cxFWR99oAaAXH1ZrMdRPgWdmL8M+a9rbFwSMQ7YgLcJ1AT7wl1nmLnMIowOSGP0jgGCXlpifvZ841izqCc0EmCQDbBxUdYy3E0dT8WnQvwKo0a8xhTA4JIzgmuHTg/ENQeN5e34j2zdQ+5tHJLp2vfAdP80wITRv5JWugT07nzY7MuHPaJqiqAvjXLJhxoQNdru0m7sCDZXKiDRJp21e458vbG2LASZ7/pVKOX+NHPv+8y8I+QRUMk7Y3DhPZZvFtvPZqcipbTAaZzX1ccHVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oJx8XxcPA7m1VnchLFYkD/RlNIejClEUvx0HblefbI4=;
 b=XJrCq0rMnAPC5c9KpIYw4q8uDfjKd7EbX9Ut4THVraCCTCbDmQ5c9i14AtUkXyWVjp6WmnycUBfbnJd1OZVdrlf0YWJis3WQH3tCtpB3427Q+30InX77nBbX1LROdT0FnxlvbjD52MdDeNZ1s5BUSC4I5cNHU3akao5eRfvI7w8=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by IA0PR10MB7372.namprd10.prod.outlook.com (2603:10b6:208:40f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Mon, 16 Mar
 2026 01:37:15 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.20.9700.022; Mon, 16 Mar 2026
 01:37:15 +0000
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
Subject: [PATCH v10 09/12] bpf/rqspinlock: switch check_timeout() to a clock interface
Date: Sun, 15 Mar 2026 18:36:48 -0700
Message-Id: <20260316013651.3225328-10-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260316013651.3225328-1-ankur.a.arora@oracle.com>
References: <20260316013651.3225328-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0076.namprd04.prod.outlook.com
 (2603:10b6:303:6b::21) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|IA0PR10MB7372:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d2bf37c-3493-463e-daf0-08de82fc8dc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	iD3dOG5fKyGzE6rAVwy51lVShChdqW7CYWgOgt6WrwHKFOQ1yMkgSezfL+UNFMjTJU349JT1Q/ZTA0Davs7e9R/TsidA3+G8dMjZTf+NkkEAcJF/+jaB6pM2mQ+9mWCt2xIOAGYKVohpg8Ic3K4Vj1GUjc0zjjTe8DiQSq/ifvZgFiQ3N38ND1ZemHJVKedB+CRJG4Ac7C/Gva6W6XEfbx53ZmQVuHQ5+vKJAZyeT6TeYXNWD/xOxTS0fHH2/X73EF7D1g/bGHOa18pl/PQQD33F+7f2uttJxeh/bkmTB9xDHgInJ1eJ5wEqUft18yBIWkJ9JSa9KUCMxhL0X+BPJC2y+OMfemini7Fv5CeDXGhMq5N2FuqOLWdriEoeqpdtzYTxvXPIfmE0LtxL2g7klbLYpvziVyozr6ukzBb2KU5DrSwv3HOS7j8PxmL1cjvxHu+LegqLIQaF1QcDue1b9jLrjK7Za5H/ahleMSZyTvN8T9/0hAVFtCG4+nwW3IarVcVbdHEOnnMOOOsEetvRMFAAzkAINeZNyR0P2VVTX5U+XC8kYTEXRJxkvTtT3I92458XFGMSVp53BnY+3AQN5vG/FGOV2Tnl/FGx15YRrxqo4/UuVq/+nkJPdOTlbipMkVOe7sJV79ntYt1boryilb76QQrxE2sQNEljdgovUW0OFgJIWEE0niHSkYRy08MA90U7691A/+Z9tmMB0hSgdvTXZOJBUGc+WKulSm5p+aM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?44uCd8UZyo8ORTHGFOyJLyZTro/dQ0Cq1jzsg7oeOBtE3kIHsp38szg3+aBg?=
 =?us-ascii?Q?HWmjVFSszuwV8hgQTizAlYkb/caInAI8g0gTvOsX/aQU6MMYZB4IyLTL+sir?=
 =?us-ascii?Q?+SXuVVUB9OWxOyv39MZxR0oBsvwEaGf7m2JYwQFIWEyB/KZpIaC4/XzWErEK?=
 =?us-ascii?Q?O8RfXIRUVBGQLoFFnMbcdbieaqYM/GyFAQjlsXFPWlFhunyFqgYvMHsQGhFm?=
 =?us-ascii?Q?q1kB/i/+8zgq0ADXY8+Ws7XlcL11p+EVhIU3Eg8izoCSzU/hAb44UidZu2Mb?=
 =?us-ascii?Q?GWWY/YP26hLSZ9pfTlk6bCuozcifvPFlUqmSNaZYKnfVVCwTHsuZ3kDBXtKB?=
 =?us-ascii?Q?E5sciBC5k747KF30FgvfPn/70kxd3IcqDO7c0SGCRTScVo6ROZ+fysFWwxAg?=
 =?us-ascii?Q?IrYPmgdzpYjxpdyjj6OvOTH4VO5ruSfQvBg1CgFulT38gNlG0ziRa4uIGFjG?=
 =?us-ascii?Q?9zeP1n/W53SUNSQr2qtaeDPee2OgXM3Hnlsro/RcDsOWSgKvphuTM/ny8BsT?=
 =?us-ascii?Q?sRh2i3hqHOR6njlC6Y6DF439Zpiimx3S19RDEEbvazlC2Kqd3M/7Dq1LFM+2?=
 =?us-ascii?Q?uHg36UELlHCT3TTw3iQrjoqZvxfc39tD3uxITjZhz+Lz3kJJ5z2JIK7c8dDr?=
 =?us-ascii?Q?Pwbm7LliIWvG6xrVBpK7X77M6hxmzF/Zlxy+2G6wayzBPGWwJY5F/GLRn6TJ?=
 =?us-ascii?Q?onnTwxYtaZXnBzyHO9a8/nAbRz8JuNZJssWGz/WZ3MMeUVON5EOZXsR7VNGw?=
 =?us-ascii?Q?KskeQ5sPYUhPIO45ydURUaXP/DrzLlfW2KHQYzxZgtqdavpLOIOfTYQvSMDu?=
 =?us-ascii?Q?WMBQ5/ekfSZ8hdFc3S65B7gp2P3l+2EaQQ5pgsqNCndf0BdpzSzZMpv+8tnv?=
 =?us-ascii?Q?x5ONehAP76dV5Q6BTnG1z3DLh7fRgqAYFeyC/tQi+qSpSMJYvVok8Udp/GD7?=
 =?us-ascii?Q?hW4AW8Jjx8shN+Zh97jzs/cLnBk9QWqxcfc74zhODGIRjgAvxTU4a+Jx72JB?=
 =?us-ascii?Q?Z3HbD4xe7B+jiHpknJRKCwOwHuF7WjD+PZ9c10AVbSaSjfLiy4TxMRndsmaf?=
 =?us-ascii?Q?KJhcXrcM7NjBVaN1VTZOvOnGfoomC+M0cTMIjE2/0TvW2YID9uO2KhSY6Eph?=
 =?us-ascii?Q?bqEaRv7hxHrcd1vih7Z4DfMhqB9ru2KZB8Gpfc+/0d7z4MqNrfus33hSIXq0?=
 =?us-ascii?Q?5ULZapbWz62BwgCbuAQ1vKvGYDOLltUBK9W/5mY440IOLHRLdMyray0r5Yll?=
 =?us-ascii?Q?LNgi7Y5BWfsrDZL578xIOIep8idj2NArqEb6SjhdNCBiPOI6BdJLz2ykEYpu?=
 =?us-ascii?Q?UqpZkvQe4RoI8jxmWe9Rxlf0N7ODkzxkL78aaINoDfiTYONBHDpJH5U0r/WI?=
 =?us-ascii?Q?HhSqbMCEHAvbGE5SvetyGjE+miFGrqF240Ybr1m7qs+lch+73tVSaFhTk/EY?=
 =?us-ascii?Q?AVC+MMCMJp4pWfzdr3LSpKiwbdL8IsgAkW+hcUl1kZKkcO1ilcrZYQ1nfco4?=
 =?us-ascii?Q?msj3/Rinr9XHDQz+ZewgyyhLVdwK07lqCy3BRyHxwavkf3ujcEhfhM4YJFx0?=
 =?us-ascii?Q?wST0VJTCHGgraGDEldTNrN+lWxPm7V2I80DxAXvfa6EG1jC+o0BIW6+BUE9B?=
 =?us-ascii?Q?a1Mxnhxyun0UfN2GQY8748DiQifxodqfe9832+th54Gc4OOUb9Su3s+s2Roh?=
 =?us-ascii?Q?VlDb1jwQVxhxAZFvIdXPd8MmX8cp3RlSljwV8UyTlenw3bll4QeVcAjlUOK4?=
 =?us-ascii?Q?L0YV1NA3+wm9pFtPHX6aH9Pa4P0wWN0=3D?=
X-Exchange-RoutingPolicyChecked:
	O/z/LUuyFepZxQmJ32gfQM7q4m95ayCOw9akGjtE75/6tDPWwObocSxpIlWV4EOeLI64hM7LVJ20MW04BUkkqq5KCnCMv8PcNm07rk1LXOFQ7WQHgRCmKmBCi+8krlx0nplnTUF9wVihlYQyuEx65ny3fmfRBMjJ59a3bWQFh8PxR4YCUpeYHeRZiKdnGJCFktlw4mx5oNE0Qm5VzFr4zgeBf91d9uR2ZGMvt2L9XSlC5PpcWL4Sx4/hArftPaCe44eesZyhQukI6eSgkD5KBZXX+9L6rJ66orlPSQlywA8umY2+uEJVeyGhrk0NvlgfQNcjSrFaa2uWiXYzgRN56Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Q5CeiCth5W3sbJvTSzkElTplCNc1YI9QQU0WL1z/tUQvCfGiYM+V7tLz+iMoIsHtgheC0+txfihQU43TDxrsWV/4HCHEWoR+bnet4QXrZ6kQUjI+Mu1vrKlZy7N+/7L2DXO1ZDJ1tbyk98dRT++sso83fL7NNTivY4VWnrDSYpdXva8a+1LRS1ut87vR5ifwyqk8fe0ZnJr+ZoAF3zLRoBvSW5z9xFEFmHAoSoC89SYNc8Y/it/SKdYF4y+eb1fIKXIdeeeVs98Eo4tv5cg7pCOyA0nr6RFbfeIvHVB+2RyDrMbKOr1+SRB7YTghx7N8CBCcMbByBy4M5RWZPGgyHN6gLtbA/QttE/0utAn6jYJ8DJ4N4ElK0CE+xzSodHDiD9OHJPk/NSO1E0RSovBV8tkHAIxuXMKnn9Bvtb0WlZmxpMvwblHAk9Iugc6KJbNHF0SA6QXOCw0awwfe9LBh4oUuOWUQtlJ430ALhAkd11bxTLUwk/SrmAx7W4Hh79Xb4bQeZzZG7+ZPw9yxBrMKrNLx0rabIseiSedUf5Y/1ZL5iW6EVTqO3gGaXZwtZv1xenX8ll+gEHlWq/aWivQ0Ik3sOpmVsIaY2wO+V32wBXE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d2bf37c-3493-463e-daf0-08de82fc8dc3
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 01:37:15.6753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: niHshvR8BsU2YsbCat/KVUbJrIlfpr8hFx4/olNluOVNMb5uci0ExbEpgm5e0sOZr9tx+TG7m12DvgCnfklNVWuB0BQ460tKDprQmcfROrk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7372
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_01,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 spamscore=0
 adultscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603160010
X-Authority-Analysis: v=2.4 cv=HcsZjyE8 c=1 sm=1 tr=0 ts=69b75ed0 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8
 a=LqkqbBbWekfmbT-3qckA:9 cc=ntf awl=host:12271
X-Proofpoint-ORIG-GUID: T_qF75MDSPeJRC_e47typDmBL_KPPtgr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDAxMSBTYWx0ZWRfX/p16y1ve76mx
 sKeE9fK3ZbvhtHJ56wPs1sycEX8quKUbHRhBx+XqQjGFDkmJYwGTCNYDfzkdaDCt5Q1+3grao4r
 1Ex+MhW1C3hX1qutWai2DG2NDb+jDCg2YzqZ/MX2Cl20ID2rM5Zv2GlYkSmXUixtdyEwhFhRdAm
 WhJyi/b4C9w35NaL5faY7ROtBNiQa/x3kQRYByumDhkwzVAK1TFa1oANtQRT3iEGYIuUV7nyoWN
 q9qjTfy/jUHvLZk3xTZRZQlhhce+IGSDOd5uPoELWbFudOGeZkAg8f0fwTnrI9+EcjcsuDXUOT1
 8pdwf9V4fxzb6fBWI5k0RODOhUvGAVI0orD9IzqCWR7V1od4h5dkR9xu1rgSzTW6ddgyhCU+pN+
 hNKbftu6EkdAGUKa8OicfrE/uTYF2coO+tlMfskz5osklxU02JK/0agpBKl4bPQj/Z5V3ewiD2W
 ZZajNeax1/8N0bwHfNUBTLvEkFnO3Zj+MCBXLHAk=
X-Proofpoint-GUID: T_qF75MDSPeJRC_e47typDmBL_KPPtgr

check_timeout() gets the current time value and depending on how
much time has passed, checks for deadlock or times out, returning 0
or -errno on deadlock or timeout.

Switch this out to a clock style interface, where it functions as a
clock in the "lock-domain", returning the current time until a
deadlock or timeout occurs. Once a deadlock or timeout has occurred,
it stops functioning as a clock and returns error.

Also adjust the RES_CHECK_TIMEOUT macro to discard the clock value
when updating the explicit return status.

Cc: bpf@vger.kernel.org
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
--
Notes:
  - adjust the RES_CHECK_TIMEOUT macro to provide the old behaviour.

 kernel/bpf/rqspinlock.c | 45 +++++++++++++++++++++++++++--------------
 1 file changed, 30 insertions(+), 15 deletions(-)

diff --git a/kernel/bpf/rqspinlock.c b/kernel/bpf/rqspinlock.c
index e4e338cdb437..0ec17ebb67c1 100644
--- a/kernel/bpf/rqspinlock.c
+++ b/kernel/bpf/rqspinlock.c
@@ -196,8 +196,12 @@ static noinline int check_deadlock_ABBA(rqspinlock_t *lock, u32 mask)
 	return 0;
 }
 
-static noinline int check_timeout(rqspinlock_t *lock, u32 mask,
-				  struct rqspinlock_timeout *ts)
+/*
+ * Returns current monotonic time in ns on success or, negative errno
+ * value on failure due to timeout expiration or detection of deadlock.
+ */
+static noinline s64 clock_deadlock(rqspinlock_t *lock, u32 mask,
+				   struct rqspinlock_timeout *ts)
 {
 	u64 prev = ts->cur;
 	u64 time;
@@ -207,7 +211,7 @@ static noinline int check_timeout(rqspinlock_t *lock, u32 mask,
 			return -EDEADLK;
 		ts->cur = ktime_get_mono_fast_ns();
 		ts->timeout_end = ts->cur + ts->duration;
-		return 0;
+		return (s64)ts->cur;
 	}
 
 	time = ktime_get_mono_fast_ns();
@@ -219,11 +223,15 @@ static noinline int check_timeout(rqspinlock_t *lock, u32 mask,
 	 * checks.
 	 */
 	if (prev + NSEC_PER_MSEC < time) {
+		int ret;
 		ts->cur = time;
-		return check_deadlock_ABBA(lock, mask);
+		ret = check_deadlock_ABBA(lock, mask);
+		if (ret)
+			return ret;
+
 	}
 
-	return 0;
+	return (s64)time;
 }
 
 /*
@@ -231,15 +239,22 @@ static noinline int check_timeout(rqspinlock_t *lock, u32 mask,
  * as the macro does internal amortization for us.
  */
 #ifndef res_smp_cond_load_acquire
-#define RES_CHECK_TIMEOUT(ts, ret, mask)                              \
-	({                                                            \
-		if (!(ts).spin++)                                     \
-			(ret) = check_timeout((lock), (mask), &(ts)); \
-		(ret);                                                \
+#define RES_CHECK_TIMEOUT(ts, ret, mask)					\
+	({									\
+		s64 __timeval_err = 0;						\
+		if (!(ts).spin++)						\
+			__timeval_err = clock_deadlock((lock), (mask), &(ts));	\
+		(ret) = __timeval_err < 0 ? __timeval_err : 0;			\
+		__timeval_err;							\
 	})
 #else
-#define RES_CHECK_TIMEOUT(ts, ret, mask)			      \
-	({ (ret) = check_timeout((lock), (mask), &(ts)); })
+#define RES_CHECK_TIMEOUT(ts, ret, mask)					\
+	({									\
+		s64 __timeval_err;						\
+		__timeval_err = clock_deadlock((lock), (mask), &(ts));		\
+		(ret) = __timeval_err < 0 ? __timeval_err : 0;			\
+		__timeval_err;							\
+	})
 #endif
 
 /*
@@ -281,7 +296,7 @@ int __lockfunc resilient_tas_spin_lock(rqspinlock_t *lock)
 	val = atomic_read(&lock->val);
 
 	if (val || !atomic_try_cmpxchg(&lock->val, &val, 1)) {
-		if (RES_CHECK_TIMEOUT(ts, ret, ~0u))
+		if (RES_CHECK_TIMEOUT(ts, ret, ~0u) < 0)
 			goto out;
 		cpu_relax();
 		goto retry;
@@ -406,7 +421,7 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 	 */
 	if (val & _Q_LOCKED_MASK) {
 		RES_RESET_TIMEOUT(ts, RES_DEF_TIMEOUT);
-		res_smp_cond_load_acquire(&lock->locked, !VAL || RES_CHECK_TIMEOUT(ts, ret, _Q_LOCKED_MASK));
+		res_smp_cond_load_acquire(&lock->locked, !VAL || RES_CHECK_TIMEOUT(ts, ret, _Q_LOCKED_MASK) < 0);
 	}
 
 	if (ret) {
@@ -568,7 +583,7 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 	 */
 	RES_RESET_TIMEOUT(ts, RES_DEF_TIMEOUT * 2);
 	val = res_atomic_cond_read_acquire(&lock->val, !(VAL & _Q_LOCKED_PENDING_MASK) ||
-					   RES_CHECK_TIMEOUT(ts, ret, _Q_LOCKED_PENDING_MASK));
+					   RES_CHECK_TIMEOUT(ts, ret, _Q_LOCKED_PENDING_MASK) < 0);
 
 	/* Disable queue destruction when we detect deadlocks. */
 	if (ret == -EDEADLK) {
-- 
2.31.1

