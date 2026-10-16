Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C70C41BA98;
	Fri, 16 Oct 2026 07:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792134589; cv=fail; b=FQXQwnM8a6fKnG1nrx4dA3XNcX+6fxW3cYCeBLWLibG4h5ZerZjo+JThQYrB/KSaP1CjHgSKhaj3TihonMCdFroFGoUQvbDpzXOofoUNmKMxX8adx+Wjk5/ZsvbHtdjMI4667ZcF9pmaoy9JzimkBjAbJVc08a7DGZlrdKLFlWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792134589; c=relaxed/simple;
	bh=yw6zIiZnrZULSOqxioCTns/sFf/1ZCpWDOh9BSaA/CI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Tw8tX2IVTzFiXOKCB1wZTze9NRcOCh0XoI4tH2LY4RKcSmdzz1gc7snlTRJ7PWOwLHWbE/OhiT+OQ3D5MtMp4RCSSR+ITQz3+qEOqU3yM1jkZ2cIB7z/t+SyKIXpgOrSn/oSBDfp4uQLpx5jMHbGznM4FKNF8hh5dR5sSe6r87E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KPjjJZZs; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OAssIzrm; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KPjjJZZs";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OAssIzrm"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69G0GfR61569569;
	Fri, 16 Oct 2026 07:09:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=6+mT8x38yrV66x073641HB2W6EifwrcZYnsp3oa/7t8=; b=
	KPjjJZZs+28gYbbxLI7gARzdSmLsLyu8fgPEUNd/9W5c5iI8HxlR1CjiEjj5+uFT
	jZ852iNkAot88tf6yZJl03RZCiO7oY+GdAPE++mFR8pa2ZJChp4abAk24voXHPrC
	7Fkq8Ka2LDsmmhz/py3zErntJ/MzTSlO+xdbSIPAcFLSF83O3puqxZKcTowmuVp5
	O2S8GMV0og7NwJmswKU0tNJibR8xRHentzqdSjnTBm13fp5GL9GmoPoayjvyt2PW
	r6ZCDqmihtFE98L1DRO9fWhKTxsa8WxpV5zn7Q+jWg0uj0cYtgyTdnNjiudJ7irs
	3yEePl+POkQhF9hpNPNWPQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4hautdsrpu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Oct 2026 07:09:04 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 69G76i6u025580;
	Fri, 16 Oct 2026 07:09:04 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013043.outbound.protection.outlook.com [40.107.201.43])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4h7btph3uq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 16 Oct 2026 07:09:04 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QYDMwhbyURe25fbfcOKLLiKzuWNasehTQXDfvLtZiLQ5ii8Za54baKrD1Vw/Qm7+7SqgPGDEMSFG6/KkTMGoBZxpfXRUozyLJw5+/18nDH5m+h/fPSe/HdoP89Orb6GZS8gQMonli72WRNA38dljrJYM5KONoBo+CsSOiHZTT3dpVcb7lUsZCVRB4XDCZjNDUAfVHiQ7JWvbNcVXJXNMPaFP/X/AOqAvvqYkDFrSVsbCKIR8kLcgi3NIVoNXHgiPQx0hCGzaPqD/qVkLm4Z23Xt0Uu9G9NiKqACO5Kw1IIuLBY5i/ZOGj0XX0Y4qDAURkM1YiuM45XkdDkBpBbAtGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6+mT8x38yrV66x073641HB2W6EifwrcZYnsp3oa/7t8=;
 b=HW8CSgM2YW4Fs8APx7ugjAtkRG4K3Y6a3Jxkqhl7kn/IE1K7vtYY0CXggqtBXMihBFzc+dOY/YsN0x0woSKitUyKXJfRKX3nyBoJrVSq3SkRuWBwPzmb8dKmDuxi/8ij6G41P6ew9F8SceAGJazGIoNYaFea1GljJA/eodpIs5bjQoPuuebU1fHP1Qod9gfqp1Eeb+oXSulZ+Xr028KarLSKYn/o9A4IsFWWAX1MrkeYNcig31ePzk0GzTEaozFMur4PLfQbO3l24ihFgO4XUxGmed0kkyJGpvbAid/H5dHdbQRAItsnAXLPv9pCkZZSTKJxfhWxkhdGRjkXxpta7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6+mT8x38yrV66x073641HB2W6EifwrcZYnsp3oa/7t8=;
 b=OAssIzrmypgZkx93RwlsqG+hQNQ1wiRLIpyfHn0QS+tMpemPb2yW/z6fHJ8bzgUi3CAPyqrb6bfnFOeLI6I4+PUwYxo25Wgmk4pb3E4rezty6h9BDW6/S31niy0ErITu12LuByC3Vqf7CfwN7oXeledrYka8XfQIwCQ+OnzJeds=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by MW5PR10MB5668.namprd10.prod.outlook.com (2603:10b6:303:1a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.7; Fri, 16 Oct
 2026 07:08:59 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%5]) with mapi id 15.21.0546.010; Fri, 16 Oct 2026
 07:08:59 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        bpf@vger.kernel.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, rafael@kernel.org,
        daniel.lezcano@kernel.org, memxor@gmail.com, zhenglifeng1@huawei.com,
        xueshuai@linux.alibaba.com, rdunlap@infradead.org,
        david.laight.linux@gmail.com, broonie@kernel.org,
        boris.ostrovsky@oracle.com, ashok.bhat@arm.com,
        Ankur Arora <ankur.a.arora@oracle.com>
Subject: [PATCH v16 05/16] arm64: rqspinlock: Remove private copy of smp_cond_load_acquire_timewait()
Date: Fri, 16 Oct 2026 00:08:26 -0700
Message-Id: <20261016070837.440748-6-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20261016070837.440748-1-ankur.a.arora@oracle.com>
References: <20261016070837.440748-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT1PR01CA0106.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::15) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|MW5PR10MB5668:EE_
X-MS-Office365-Filtering-Correlation-Id: 264026ca-43d1-4117-2255-08df2b5459fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|7416014|56012099006|261009223027099003|22082099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	2jZtnIcdDnOl9PreQiM8Sxt4n91hybpL0b8H+MRKYJiy33HFgpr1BQsMCYbC1fa61xw+Kp+05YgfcTr5nMCi1mkE+ycyBevMXAToNuAa2JI/ozRkMFUeYg6LfhRBnU95SMF6imczsdtHHxTCLcNGT3b7EOSEHeF97sNM3djXYeT7fHFCR8tX15js43CMb2fDASaJXR0pW/Bqmtxv/yEQX9Phiwe6Vn3QWjpNCcZXONUC1OMD4NhzpNt3+JoBWzbEG6yOfZrPDjkRVGEC/uYQU5X+YyrLRk3KxwKFi1Z3zdcgmG9WBKbNSldsp6B6jAl4FITGekz2rBUUjYPdSxcR+1bLVYbQMhGHabLlIlO9ZGc2KLIXIeYAdqR/9ivPp2inWBe0npoxqxPMF+KuFF6n2As7qGyyREjqFFGRpnYItvZToOxw/mKna6JFCSmgaYhml/Qa+FBV28Qm82omqXMT4hVxXvLsKAkHfeDQBP5dA4+PAiJsC8ALSXoB9xyaR1JVb2JYJ/4mplfIyYaYxLCReERl3G6Ey4ffuUrTplFE05gILmBKAcytimnvEJRoMB2f9dkFFn+ZwyGJcYXmsu4nxnG/mJhbOpY9swm/a/pYMzI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(56012099006)(261009223027099003)(22082099003)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?V7m962KKnTpzmO85vNKpsnAFcnTL4CZWddGDGrTy4BdesVei5RYI8bA1su7R?=
 =?us-ascii?Q?JgIpBnIwnQwsNHCep01Hjz+S6HKF9pNZDqkO+BB8tBG9Fei5J8fd05bulN/H?=
 =?us-ascii?Q?sL0urCz5FotJaIkuOt+XeB9Xq5yPDivi/eJN9At9e0IXG5f8GzrHBu1cEHx7?=
 =?us-ascii?Q?B/FmjJIUNxDEQw5+B5/VwJh9E5yc3SvM33YWUnkvlI1xUumgTZx3asLdIgGl?=
 =?us-ascii?Q?3oVbipWBG9McQwPAJZ72dO1rSd5zIrPTvhFChszhkhXr1IlD6V2PHuo0VwjJ?=
 =?us-ascii?Q?QAjDHBqThu4Nx3//VP+D5jsr51jbKwnuoAnh2nnH6K55yXP56xxXCmofU8b1?=
 =?us-ascii?Q?egZWxtNnV96Jn2OBGsHM0bg/MjhCwisXFyicfIhvg/MLPDmKpRUkJMs/WVHG?=
 =?us-ascii?Q?0iw9XNFMIlyMpUww6VQNXiRqp5/S0ZeeeTjY9tt5G7FWZVBkVnI+bX4VwFRu?=
 =?us-ascii?Q?oCjtTtURHhfXuLIlM5aVjrwCOhgmtjkzJpqbNxsPD2fYMQ0hYZrjEJKAYKBa?=
 =?us-ascii?Q?dP0a2PKbr0fddCK4PwWBnpyl3Js/N+CnufIFjV+of8uXiguILhBe/7zmySqH?=
 =?us-ascii?Q?wZajjUYnOd0ucNoaFmq9T78Lsj9ZEWFh+NyQt9bZvJ1MpMxns4wisuLDh0D3?=
 =?us-ascii?Q?oztw0y+CLPdWM/+kvmhSJf9vhJMK6lpOXyOt/ozXp4jwv8jmqokBEMIX6vb2?=
 =?us-ascii?Q?AhSst/wt86F13dS5y72So7OaraXNqGuTsc6NUflVY2xdVLmzMDIYwxbKiOiG?=
 =?us-ascii?Q?Lp9ff1d7Lu/ds6Xd5yCfCWgAh41WUPnrcl7DvbpfF/En0Wpg/s8O0wRcXZoK?=
 =?us-ascii?Q?ew1c1nZYGX0GzVhnMix2C3R9cimwY8gys8zl6dp5358x79oxG3vLaoaaJL9B?=
 =?us-ascii?Q?9dQ/fCYAC4U1wBm8Bi7HwjPQq65BO8oSodFqn3E/mKiPFgnH6AxWBu08sVqZ?=
 =?us-ascii?Q?4x8oojBNsG2FWq4QyPCNGS7iEIo1QHxIcXCZvt9rTDco3sff8En71kZrroVI?=
 =?us-ascii?Q?t9L7oWLcVk+7SwvL0Ip6SfpLM7UdC28T4umlH3uFl4PrSZOA/OeqW3lXHqu7?=
 =?us-ascii?Q?xgtSDYz6CgmnIHJtraCYAAUIjmQCDqqYxM0b1gZ8qUjEaoSxRJqzM0MPglzL?=
 =?us-ascii?Q?JAdHj6QLAJpY5H7iGnPWecsOByxTHfU3vZXtARybpIYrcaFheJ3M+K6AzFdv?=
 =?us-ascii?Q?BtrBvMDfCXz3W3Q+GxRmknLzKXkDSMkUDEVXV/53oYXInRVXWiuYBhfv7Rg8?=
 =?us-ascii?Q?NWo9dv4a52UZGIYw71D0cmAV6KzfyFcIRhIjPnGx+GMr+67K3DQPigdw55y7?=
 =?us-ascii?Q?cACok9Gl0w/zqF4+BLUb50sSBB73xn4365Fyk8jyborgeHIAAZoHZ6jxl5rv?=
 =?us-ascii?Q?5r2AKVjn7NtWAgWnRed71VyboFfkWTM9rfj3XIP82UYwBdNm1Lg3923lsd4u?=
 =?us-ascii?Q?+h4ZDD4j1nJZs8OZ91gYu/dNKixNIEyl5NV8QpqDZudzZF0bWSySylaa1b4X?=
 =?us-ascii?Q?0ZNypuU6H+TMPbzp5o+anDH+BKk/aeZ2+4DzqFnt9aNwdGajVylJWJvrsQXB?=
 =?us-ascii?Q?0qIlNclYBEb0NfTaubdQQziw0AZ/sQ+LCzA+ZsDpQNuuSWFnJtlZ6lFcXSQB?=
 =?us-ascii?Q?WU+OcW7FkNFVgDMkUgvWJFSYkaIFtTxpxQe2HdxQ68ss7HlUbfis4zyXKQDR?=
 =?us-ascii?Q?j3V4FcWkMryagRpwm95H7Oi5hhE/RQpUJYfLS/jPnIzyREZX+Op95h9GC2Ku?=
 =?us-ascii?Q?j0ppLqSV4iG8IxwCumSYeCSAjHHv29M=3D?=
X-Exchange-RoutingPolicyChecked:
	csoClqe9qLyuNv3x9dXsommGbMkzcDtaKPCapdqcFZuJiBssBC2YAiXwYj2EqZr2fy5ZFLCvXnIOTbRXK8Fe2n2mZ+6axL3SvPkyh92KI/6ZyjoPbI86PF0U4LPRv5UfR2J9mpiNEMHZlsDUWMcFySWrQsjfxaQ9RgehooJUDL6vE3JSCCYCbCiosKW72LQ4M0Dx8uhn5N6IXtm1iwPYsA0UN8k5DblTq7qzhidMHSxFf1omY6FsfltFhSWuEwnk1Y0gprDChf94zWuJn6/GAMvageesWMCXxbOVNmJ1XQqkw8VXWCjvFN/wdf1/6aKkmacfIccwrrT34EWGcwOdiw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5+mo9yGsnbBWU8GUOCpp6SsGWv1wpcMf4OZCpsBX6PWYo0ZDgwmHvdWU9c9roYS9Trob+nkFbgJCfjWoR71x5iOJbohDif+xX0fQbNJUwCJqYla+N/djrTbHxPiTEd88XiNf+R2Ha2Vck2lm/A1n4teq9COKOV67L+rJkHdC6qmt/1qw9N38/Yn8ccsSyJ4kzIasLkJEGX1TBAO4b8R7111vlwIMC97D99umHcaDqfTlEzdano6ad+O+mb+SEXYsVnFvEW2oi+dwdEhjzC+fvMSlXFHy1Y3Ff48fkq4jVy6ZhKjn4d28sIoTdy8K+vYBE1966gBQj2s67EXVeNgKqgOOP1TgIGH5H74BwtWTJinRHvkqCIAYOdSeofpS2YHmUBFiyMzXUToBLCB2z72iMhdMsr+5i4Fxol8aFK+1BJ6Gu7StO1Uzlvsg4BymfSCS4rh2gfraUi8G218K3QBAw8DZlewkYsPxZjhZmErJElxQlHALW2J0ABxLKJZXn7RuAoj7FlnGiyPcGaPtlMwCwqTRMN2ktgDBRdBTOH+lDo5YtKjYPpgTA9akMUEZHXx+5dP5IoUuIkiFsK/YKM3TNizlyDi0F5J4Iq9QvhsAhwU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 264026ca-43d1-4117-2255-08df2b5459fa
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 07:08:59.8692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g8jW4n7ixqtWEXeUxbdPNnmOO+5TIOyugKFr1Akl6Lo/1cEHf73x0lCzuEKcHa8C1cJKwIor/aWxY7RmOfo52IsqlxLb59y4TfVUsIXkejw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5668
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2610020000 definitions=main-2610160028
X-Authority-Analysis: v=2.4 cv=eK+GH3p1 c=1 sm=1 tr=0 ts=6ad1cd90 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=pGLkceISAAAA:8
 a=7CQSdrXTAAAA:8 a=vggBfdFIAAAA:8 a=PuvxfXWCAAAA:8 a=pMBjG9WjWPNDpSeUJj0A:9
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=uAr15Ul7AJ1q7o2wzYQp:22 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12108
X-Proofpoint-ORIG-GUID: Vs_MEKiupxAK7AttH3p1IsLqYVkUjgHz
X-Proofpoint-GUID: Vs_MEKiupxAK7AttH3p1IsLqYVkUjgHz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDAyOCBTYWx0ZWRfX47h2GONhbOkp
 bdkJHhMMSBA7nbL/z6EB8Y13i99ghlH6B9APt2Mxwfe4EoIgy/P4cLWxrOUh0jmGNs20g2iw2RU
 pCk8gF0OoNwQBeU7qUFhlL2j9VCTgMfrNbZeTV/9IafodM/3kXDoCPzg9HmfNKFqabw5Xh7Rqqy
 KAQkpXube0wAZc8+cYXJM6grL3tTj6RBA1doEagDmBmJAXx5LhmaSg/2h8Xf5READZpCVx95W9g
 aomFZIQsB4iYM/4AXyjvEvofzFS5SrlaMIUGR70RQ8GI/+xkW4haxYM+7j1QLCkx+NLBZJ4Fmiq
 Mp+sgLD58mXYMRlIl/zndRmXb01fJH3MQiCFIlKVFsI+s+fvzWnQOa5L0DG/RWcac/5GRUx+jgQ
 S2Dj118mW/UxGGvgVRkEaBV5jA3jU4dVZO8V+BCkSuhkr74GNbh+nIv4iV+WmPNJCYjGeQK1NVs
 COB4WJlcu6f9yiNNiZYDp7xga3AnOE5EgKMlSPv4=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDAyOCBTYWx0ZWRfX9kDXz+LrckHM
 3cznKjQYShiY26efZshXeORrLYMDzfKjmh9oE0tPrUBQaeefAo4EPEg9tpcb5o5pbffBIFH+4Hr
 Hwv2J3Ac6NhStzZpT61896JxuKdBEsKFHFQV2if2u/rjElodyX9k

In preparation for defining smp_cond_load_acquire_timeout(), remove
the private copy. Lacking this, the rqspinlock code falls back to using
smp_cond_load_acquire().

Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: bpf@vger.kernel.org
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Haris Okanovic <harisokn@amazon.com>
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Reviewed-by: Christoph Lameter (Ampere) <cl@gentwo.org>
Tested-by: Haris Okanovic <harisokn@amazon.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/arm64/include/asm/rqspinlock.h | 85 -----------------------------
 1 file changed, 85 deletions(-)

diff --git a/arch/arm64/include/asm/rqspinlock.h b/arch/arm64/include/asm/rqspinlock.h
index 9ea0a74e5892..a385603436e9 100644
--- a/arch/arm64/include/asm/rqspinlock.h
+++ b/arch/arm64/include/asm/rqspinlock.h
@@ -3,91 +3,6 @@
 #define _ASM_RQSPINLOCK_H
 
 #include <asm/barrier.h>
-
-/*
- * Hardcode res_smp_cond_load_acquire implementations for arm64 to a custom
- * version based on [0]. In rqspinlock code, our conditional expression involves
- * checking the value _and_ additionally a timeout. However, on arm64, the
- * WFE-based implementation may never spin again if no stores occur to the
- * locked byte in the lock word. As such, we may be stuck forever if
- * event-stream based unblocking is not available on the platform for WFE spin
- * loops (arch_timer_evtstrm_available).
- *
- * Once support for smp_cond_load_acquire_timewait [0] lands, we can drop this
- * copy-paste.
- *
- * While we rely on the implementation to amortize the cost of sampling
- * cond_expr for us, it will not happen when event stream support is
- * unavailable, time_expr check is amortized. This is not the common case, and
- * it would be difficult to fit our logic in the time_expr_ns >= time_limit_ns
- * comparison, hence just let it be. In case of event-stream, the loop is woken
- * up at microsecond granularity.
- *
- * [0]: https://lore.kernel.org/lkml/20250203214911.898276-1-ankur.a.arora@oracle.com
- */
-
-#ifndef smp_cond_load_acquire_timewait
-
-#define smp_cond_time_check_count	200
-
-#define __smp_cond_load_relaxed_spinwait(ptr, cond_expr, time_expr_ns,	\
-					 time_limit_ns) ({		\
-	typeof(ptr) __PTR = (ptr);					\
-	__unqual_scalar_typeof(*ptr) VAL;				\
-	unsigned int __count = 0;					\
-	for (;;) {							\
-		VAL = READ_ONCE(*__PTR);				\
-		if (cond_expr)						\
-			break;						\
-		cpu_relax();						\
-		if (__count++ < smp_cond_time_check_count)		\
-			continue;					\
-		if ((time_expr_ns) >= (time_limit_ns))			\
-			break;						\
-		__count = 0;						\
-	}								\
-	(typeof(*ptr))VAL;						\
-})
-
-#define __smp_cond_load_acquire_timewait(ptr, cond_expr,		\
-					 time_expr_ns, time_limit_ns)	\
-({									\
-	typeof(ptr) __PTR = (ptr);					\
-	__unqual_scalar_typeof(*ptr) VAL;				\
-	for (;;) {							\
-		VAL = smp_load_acquire(__PTR);				\
-		if (cond_expr)						\
-			break;						\
-		__cmpwait_relaxed(__PTR, VAL);				\
-		if ((time_expr_ns) >= (time_limit_ns))			\
-			break;						\
-	}								\
-	(typeof(*ptr))VAL;						\
-})
-
-#define smp_cond_load_acquire_timewait(ptr, cond_expr,			\
-				      time_expr_ns, time_limit_ns)	\
-({									\
-	__unqual_scalar_typeof(*ptr) _val;				\
-	int __wfe = arch_timer_evtstrm_available();			\
-									\
-	if (likely(__wfe)) {						\
-		_val = __smp_cond_load_acquire_timewait(ptr, cond_expr,	\
-							time_expr_ns,	\
-							time_limit_ns);	\
-	} else {							\
-		_val = __smp_cond_load_relaxed_spinwait(ptr, cond_expr,	\
-							time_expr_ns,	\
-							time_limit_ns);	\
-		smp_acquire__after_ctrl_dep();				\
-	}								\
-	(typeof(*ptr))_val;						\
-})
-
-#endif
-
-#define res_smp_cond_load_acquire(v, c) smp_cond_load_acquire_timewait(v, c, 0, 1)
-
 #include <asm-generic/rqspinlock.h>
 
 #endif /* _ASM_RQSPINLOCK_H */
-- 
2.43.7

