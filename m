Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7F33E00A9;
	Mon, 31 Aug 2026 20:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788207850; cv=fail; b=VoFU2YmVone4OSSCytPXrVZH5RmqA0xvxHGqUjFmLuJu54UinEoX4Q+fVpK8J2xkDYpeVntYlX08RC82Bvgmyibzw0+4RlnnD1x0iul7pbOOeus/LchcgTRoZaxlN7sI/2NYPtW4Va5Slm+WsluGCGsiAZgUPnA55PT+vJXLUcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788207850; c=relaxed/simple;
	bh=G5GCQuVzGKbe5KoJ1F5MlA4nZfDQDSXFOu+FySVF+p8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pzONOd7hVqjkh8WZzhiiASUrRx7vzJOY4ujOF4r+ZmTEA6EfBU1p6RdtqbqO8ITKnukCJEHOnVTIOU2eheKRm5CHV8BkGlRvO7T5oK2IrRSF3NBUM4fyndnFjX0aEOEwXNQ6oDYe9CvLhSkwhie2pjK0KQhifsztLnbUrrxeM1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZoBIArMY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JK3w9HYB; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZoBIArMY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JK3w9HYB"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VGBmTf1799615;
	Mon, 31 Aug 2026 20:23:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=D18Td6UqLYF7W2RgXJmnbeiv3Kx6CFYMsI1i2psCFLg=; b=
	ZoBIArMYzJoWwQ1nB0o8f2drEdTzRnsE2SZAY3d+PjVHMCWDsulz59ul5S0nbnrL
	NlzIQlJMK0RI0V9fpYdBiZxzshddV6CnGO6VW7vm/c/CoYIh/nQl9A+EaPfYjEJA
	7lZWES7QX5ONpiQHCIEQx3jHxYhN6PpirxyShMrV9MLcW4CZrJqNCTsnLNlFbMVL
	5FgK8MAiqw1KzxO3M9a/eK1zv0lMEV+YSAfOA+2ROiZtcQS1fgvm5mJ4ft33m0eQ
	pa6dx1dzq25lPwlUs3WHD17E4WzadCqfOEOGVD1Zj8diypsn0UbH2fBwjlP3yQqO
	96nvAIL5bBjvjePvvbwWxQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gbq1skb3p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 20:23:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 67VKK7mG038727;
	Mon, 31 Aug 2026 20:23:41 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012066.outbound.protection.outlook.com [40.107.200.66])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4gbnvdgk1u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 31 Aug 2026 20:23:41 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ylJdRPPvCoC0fYJ8fiGUjSUMA1vbGHMVbxztIAgxrWFU7KkxXtaDqb7JDuylkQRE6xdn9f7lU9HB/cX1HWeka0tXdJloLHBDznOAO/01MT3fjKIGWif5/j58gtksiLUOBL8ufDqrhCZu6fsOq3lGNEl5YZpqMqhHTh5A/AX4zC6YZljSij7gR1UcdPWr4/wlqFWUvHjY00FvkhHMjckC8P9OJpX6usPnIh070lHGy0QwkS7uRdxqLJM9zif4YvIdN2IGkKXA72fR1m/DlWmRvvxZJvzlGY8Iqtmuy0I4rKZHoHRezXSeQFimv3ZOu8mM5ZrIS70XU06NlnPP/QTQ/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D18Td6UqLYF7W2RgXJmnbeiv3Kx6CFYMsI1i2psCFLg=;
 b=BE+llCtyJRHtTXX8SBA/1jBHT92m4RpTeHTcMU2saMIogNpQ3O0Y7QKYbGteOynVQ+d3B9JWmCJOLaPizMfgulXz1a68tykmUrPL7UIN/bPmnDaHzUnt3VARa/dhUFeekJjmbeF8+dYR6/ey51J3Fu7/RWRMFeFvdKOTyE68rk0SHHIrEFUmVi/B/19N6Iaeb1PR/Wiakf8ThBJ59Cb17dBYR2mg+CtK/Nc/Ikcm/3rlfeqYwfdl+6jKUPhNuEmeYY9E4ngTyJKdCLTz9mLqIkLZMT6kYYvnZM4CP8Tq4QajZJxWGh5Lh+cvaPjSBY0hbDFBFUQeoKQMIy7d0KcIZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D18Td6UqLYF7W2RgXJmnbeiv3Kx6CFYMsI1i2psCFLg=;
 b=JK3w9HYBcr4GFWdDtt10LzspwsGb04bA8//g4I2sQeVrgjSm3Wr0esPMTBMPiU/1aQy00VzQNgdBj4Sq+lbV692KUO5p+pDeDZbIba2nLCyy1bhq1EOFrKNTQxSJxv7QODhe8UBEiM615dDPS4VeFeeGfZVM6xu0X+wqEKPcuE4=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by IA1PR10MB964822.namprd10.prod.outlook.com (2603:10b6:208:5ac::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Mon, 31 Aug
 2026 20:23:38 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.21.0382.007; Mon, 31 Aug 2026
 20:23:38 +0000
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
Subject: [PATCH v15 16/16] barrier: timeout validity checks for smp_cond_load_acquire_timeout()
Date: Mon, 31 Aug 2026 13:22:51 -0700
Message-Id: <20260831202251.305046-17-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260831202251.305046-1-ankur.a.arora@oracle.com>
References: <20260831202251.305046-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0289.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10e::29) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|IA1PR10MB964822:EE_
X-MS-Office365-Filtering-Correlation-Id: 104c5913-cd3f-4080-e1dc-08df079dbdd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|366016|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	WkMsZr7ZFetsQKF8oxY2Ht71bMk4ubJSTHjr+YjxzOyyYXSwvTOoD/dnPeG/Q64SVQv9Oie81h8deo34Oo2CwRgQuzp4kBLGDopKHrW7YhtVc6i8zUutTyvu5QnNryLhlKlgxd2hpg7OHpxbsJaHcmeXG6X46OBxO4wlBV7We/Z97YDUbaKTfvFmcJRykonlw/kn7V/0SKcDL99W7lnMwvNKoilwM6z3e69OPETcc6QvYCKyxTLXGKf5A0XA7TCUs/8NVjSZRrt4jPSsz0fmFqKAxj+nqoTDLB3gKghaUOMpH7RNepcPKefc+Vo+PT9qMBV7REt7ixkzpSGFcsaUQU6Eq4aXjNSlUmythHg8Mq3uj8s05WGCGGeY9uz4SspwMRAfm1n83WKMEcWP1/LpZw0mZrvzAbOyQPCDk99PnNz6I2uCDhbeV1nNUAt4L0dWYqbnLA2lfGuaCBuZWAirskpKIje1PW64ycNfxfNnNfNd21dZ/2JfumpGekGLaogOF7pYFTbo8i+EfmsYRbSteBuvvGs5vjh5e18WrxOK7RNAOdyRPiCA4O3OOjC2I/68sHUofN32z5ysC9n+sfx6oSAk2D+rrsOMZ+C8iiIwRpHn/LPkqPTXwOGVZKFsn9pN1a2VE2cFO92ZGPh8IpeoJdLcJ4q0EKSL736gdzbkD7s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l0TKDYf42p59eBGLIKN7xTmaDPyYOtV+5SfDI85ispKLLYB8hsI0EwLbTJEb?=
 =?us-ascii?Q?y06gtvu8WqeN1RWClWMYOtCZ+9Rl0yCEEgAesZKw75aTOsXQCipQKg0RjHSu?=
 =?us-ascii?Q?WWerbIQv2MpXrY76MNrZL2RTB+QutUsMUWgYgt6q9OmdgxoP0SrsxD1wSSil?=
 =?us-ascii?Q?Ox7pgS3eVWi5QG04XG6mcmoctAe4Ao1apL78GMBtNGRd2sbQaRY8DbGnaGen?=
 =?us-ascii?Q?ix6E02E+UFA6ebh4pORcpBSyrspC/UI6QqD/XFq+xDOmKxjXwxeJfhdkzCxX?=
 =?us-ascii?Q?67Rm9P+ktvtjx1cNdKI5TfHlB0mGVhOdVwwrtaK+HEtF8Vm7pIBTbtbWYEoM?=
 =?us-ascii?Q?Ins0rdJDl/l+F1UP1pZFKi8yDSg9Gi69Nz9GRgYjP727dfiwC9lRIsdCc46i?=
 =?us-ascii?Q?5RXuxenYAlTDuR9EFK2ci/7VSlU6WgvYGyxxXqtELifB7hh2twXmEBVSqqa5?=
 =?us-ascii?Q?+Lfeg0mYSxJ/P2MoZTBxe9wCoLmAWJHDa5IjZf/alQAjH5Syii2pRRWqSvtY?=
 =?us-ascii?Q?N1vXOOpCwBNmiY72F7sZdTCLfkJtzr4eRzCSiUyD3+Sg2obLDRtnA4HB52HR?=
 =?us-ascii?Q?AVzUoAzYM84x/oABYSs2vWiwsbsdnWDAyA/iJZDYKrXyyp0YaajMENXU0J7H?=
 =?us-ascii?Q?JrPdRa4VW3EvQwN3D/Lqcil0g/BLyEX6s/G+e2oEIZb6uKHFeUj2wTAGyKaz?=
 =?us-ascii?Q?TUBaNWNqIGKGJ0RPyyduETVPzSHiXEaZd82Ea1QZGFbp3rC8Fp3iunW6ZSTE?=
 =?us-ascii?Q?369aaGnAM+QBmOX3pafvDZ9GTA73BIJY20XrfM7rYHlgX8XE6sZa1ZWjCjvJ?=
 =?us-ascii?Q?8FQZ6vbJxpiv9F6kyBeYrFRb3bM3VUwr3aOS6D7nsIBHqHio5IZqSgqv8tNW?=
 =?us-ascii?Q?Dw4mxXaiXxX0NavOnmmr5QLhmXCxmGzBLI5A4T3GM1rGtm3EGyIFQp+L7rEO?=
 =?us-ascii?Q?Bp4IBLcjsPOGYZ/YlSgL0mmQui6HXJDhKHtZ50f+asPnFOYN6164moaSls/h?=
 =?us-ascii?Q?jGWn778BYetlJEEYnb19KLlzGFAa0z1vAksrUma8mqUoNOniZQnmLIoO4pN4?=
 =?us-ascii?Q?bMj7H9XgsoQPYRwlGNT4w1dkYKP4oA08OEaYNOaRWPesmXc7VVV9YxCcKQUx?=
 =?us-ascii?Q?hqzsHRd3bPI23STqWvKBemp5as46BGw9MCe8N1u1uqE+Yya/NLjJ9wWk8J+M?=
 =?us-ascii?Q?VKlRPeVI9vEFfiIQRinkwBs+x82cn3wDTTugVIszn3InSonjPLmB2b9ytKwJ?=
 =?us-ascii?Q?tev4Vk7G57mhZ/Uk8pJxi6QgowsSss6C926psuKlBLrNkbxa6iF13OhdXViZ?=
 =?us-ascii?Q?JUh7roIqp1W6uR0w7TR3PqDy0J53912VctYamuvga1b0cow5jMxdFWcAPB1N?=
 =?us-ascii?Q?pxPTbHbDnRYhOix09+0aBoLbYgiOX2zBHDkN6OovX9njnteu0a602r9Qcsbd?=
 =?us-ascii?Q?VtdG6n7vcXeVoBVO2bvX+KwODpdbCdfKKryIjcw7qNdr9ukvXvFbTN2VoJNB?=
 =?us-ascii?Q?NenHkOMWlBWE7F4FPtdFolv1QqR/I9Vue/SOJEmueqOqMaWnt0hbPMtQd1l0?=
 =?us-ascii?Q?sWtMC869qPN7zCyiTCMv05/uF5qej5dx5BsvXZwyMTM0xWDHehBYKE70uzpE?=
 =?us-ascii?Q?Szr9NrmRsmdDt+DyPCZo0Nd5bed76/gIRw8HyY2v1oNcJxFaj9di9jeOQ3kX?=
 =?us-ascii?Q?fF5yawwjExH6awOMjtgWf9/RrNy24ZdNyMaIUeFGKNLBmTSaOdCyC0VQcmx6?=
 =?us-ascii?Q?XZkmyrucz7Ziwg5GmrOv88IxinEXqTU=3D?=
X-Exchange-RoutingPolicyChecked:
	zAPkhHNCQ0iWJJcOGNV3o5NScsLwFneoz6KQZGxIvXbdvuO/tOXUw7+oaY0jWKUNngjO7d5+GYlSvDVjyG9bA+tEDXdBlhZpBJ2eOAXvkoYE43eClzXW2ubLb7digqVmj0jG2TP04svdlMbcT72pYSxpt56N8rFg5y6NR/ZgGg5JwIwXrBdyzBEcCFLEHCO9BDXftSzWMT+mLBSke/u+5+vGLKLWL2tbj97JPE5lck0lriD0H2jcVTQL8WqKfR4P/UBzsja+RVf1nCDDhyjGgkKhgL2j+EUMiT5srvKWVA2jHdoU425/ivn5fi9dgv1i+2/41FDvp0I8PHyuUetZAw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0Tl5xdUyRx15UMnR/VVbQR6GyO9/ZrQwDtGTdcz0mGb0CCQVr2ldl7vH3r1mjkQ+KgscoBFDElG5FGx6QYFI3mLYRcAZBvUuIt/b4cVFz2miJ57fKaKRRsS9A7+B8HBfBXbkhpJKMQPI50YSXFd4p9rDwI+eDTFVzwnstIAjIzQjlYBf6pGvKS7OHt9kVP6VLVOi3cWBzCS28lfT2mDONAbFL7YlVxOhkJn2WChw4ZhkRWH8N85DHPf2wMtumIZtzsYI0HG08VmCW3kK52ZawFqdp7afHzV/7bpVMOAKR34aavxcUTOqDqyJg+z+n7utQSymK+Kv2jtMrADY99nfcXu2uG068RSMkh9K2HPWtRdayUOvAYU+8cx0CxxhJ0MzRb0xVeZJiF7Vw73vysG3fbhwCsxGMA3PQvaN7aXwlmKhCg+spIGiIC7GKNXY5X+0tHrLQayemkjri+BucCoKbCptfSl5z8x204HdE4nZmNmi1WnyCpVNXAUWjXlIEbTe1dp350P2rmvQjDDJxK1bkNhatdF7LaGRjx/dHpWc+ltRmyaN8gjfbvULgRjzEmgULhy+3L2ggrcS7K2Sc8Zz8R/VlDwP/ZKmDQVWqyPgxTE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 104c5913-cd3f-4080-e1dc-08df079dbdd1
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 20:23:38.6751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XquMSCvzvfv3o8hScy3mFnXjmHK6R9Wf4qbK7Kuo4VTb5Rj5fg4YtnvuGPRraIfiD2U1gBP0pfVAEhgLVl1o/QA7jPqwK8i2r2Z/3rYqzzc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB964822
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_06,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 bulkscore=0
 malwarescore=0 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2608310176
X-Authority-Analysis: v=2.4 cv=Vp0Txe2n c=1 sm=1 tr=0 ts=6a95e2ce cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=yPCof4ZbAAAA:8 a=ZPAOx-6ZxAKxcsEDc8oA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDE3NiBTYWx0ZWRfXyc5WtCViGJ60
 4U1e3FEMdlhIVdngm3sSBBXI9iZIAskdzuN4+sCQL2dvbAyVmKRroEPq1xor8hylBKgj9IP9S6F
 UpL/NO0BVLcGr7WmcDnn1BJMO2GU6i0O3o39g+Edd4VC8RbpM6HDVEJK29S5Z4BcpxvaREgIyQh
 iijU5FcXkLg9xCr9NatnQtEkywx4Z7zRayhwvq7XkWJz0/6BufrWyBWiQgIZajiW2WXjxsVlaAF
 NVatvt5Prlu7PmcLlADfNYDNt38vnSnqyG8FKAjsC/msyoH87023iJWn3/HySO+bHE2UN6NRH/w
 uZ+53VFl2KDiI3zfU1zTnRIFAeDn7pCW2OqtzUU0k8UDpxZFE7Hoa9+01mRR9LKWWSXma2kmlQ3
 ByRqU0tUeiKNYyXmt8nHwlHh3ly6fAs8jKjDTUHodyya4KiZ2o852NK2k70u1ajkajSXiLdZA+T
 P9lTXBsD+H88Q2/0Kdw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDE3NiBTYWx0ZWRfXwmTpYhBN/sl4
 ZjgWcturTvN83fUQamDfaT0zcCKyywDs7ua6GN7Qy+XRRmv9PMxDB1O5gzzuWKZfSR934A+XwgL
 pwOCmnGrxxNGGMRUignGKe0iB9Co9iQIRhQXnaE1nVpQxJWy2gVQ
X-Proofpoint-ORIG-GUID: b174_eDnPyG3wlS7T6YrIWGz0d2O3m9w
X-Proofpoint-GUID: b174_eDnPyG3wlS7T6YrIWGz0d2O3m9w

Extend timeout tests in smp_cond_expiry_params to also test
smp_cond_load_acquire_timeout().

The interface supports clocks that can return error on timeout.
These are used by rqspinlock. Test that by using a similar clock
that starts returning error past timeout.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 lib/tests/barrier-timeout-test.c | 48 +++++++++++++++++++++++++++++++-
 1 file changed, 47 insertions(+), 1 deletion(-)

diff --git a/lib/tests/barrier-timeout-test.c b/lib/tests/barrier-timeout-test.c
index 9b16ad6f5514..ba5b6820d0b6 100644
--- a/lib/tests/barrier-timeout-test.c
+++ b/lib/tests/barrier-timeout-test.c
@@ -156,7 +156,7 @@ static void expiry_param_to_desc(const struct smp_cond_expiry_params *p, char *d
 
 	snprintf(desc, KUNIT_PARAM_DESC_SIZE,
 		 "smp_cond_*_timeout: clock=%s,  timeout=%s, iterations %s",
-		 "synthetic", p->desc, iters);
+		 "synthetic/failing", p->desc, iters);
 }
 
 static void test_smp_cond_relaxed(struct kunit *test)
@@ -194,10 +194,56 @@ static void test_smp_cond_relaxed(struct kunit *test)
 		KUNIT_EXPECT_GE(test, runtime, p->timeout_ns);
 }
 
+/*
+ * Use a clock similar to the one used in rqspinlock where it start
+ * returning failure value once it goes beyond the timeout.
+ */
+static s64 failing_clock(const struct smp_cond_expiry_params *p,
+			 struct clock_state *clk)
+{
+	clk->end_time += clk->extra;
+	clk->niters++;
+
+	if ((u64)clk->end_time >= (u64)p->timeout_ns)
+		return -ETIMEDOUT;
+
+	return clk->end_time;
+}
+
+static void test_smp_cond_acquire_error(struct kunit *test)
+{
+	const struct smp_cond_expiry_params *p = test->param_value;
+	struct clock_state clk = {
+		.start_time = 0,
+		.end_time = 0,
+		.extra = p->clk_unit,
+		.niters = 0,
+	};
+	s64 ret = -ETIMEDOUT;
+
+	flag = 0;
+	smp_cond_load_acquire_timeout(&flag,
+				      0,
+				      (ret = failing_clock(p, &clk)),
+				      p->timeout_ns);
+
+	if (p->miniters != -1)
+		KUNIT_EXPECT_GE(test, clk.niters, p->miniters);
+	if (p->maxiters != -1)
+		KUNIT_EXPECT_LE(test, clk.niters, p->maxiters);
+
+	/*
+	 * flag is never updated so the clock should eventually
+	 * hit the timeout and error out.
+	 */
+	KUNIT_EXPECT_EQ(test, ret, -ETIMEDOUT);
+}
+
 KUNIT_ARRAY_PARAM(smp_cond_expiry_params, expiry_params_list, expiry_param_to_desc);
 static struct kunit_case barrier_timeout_test_cases[] = {
 	KUNIT_CASE_PARAM(test_smp_cond_timeout, smp_cond_update_params_gen_params),
 	KUNIT_CASE_PARAM(test_smp_cond_relaxed, smp_cond_expiry_params_gen_params),
+	KUNIT_CASE_PARAM(test_smp_cond_acquire_error, smp_cond_expiry_params_gen_params),
 	{}
 };
 
-- 
2.43.7

