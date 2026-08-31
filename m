Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8B7394792;
	Mon, 31 Aug 2026 20:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788207846; cv=fail; b=VG+WdST86cd3kutTSZ+RbWfeK9c4Im6RnJjzu3iRrF270gegBTWQ2Riou413xvkbFEwqFVYPTCY82KCYU2ukhBz9ArXxmwU5c5MIiQSY3QMR3xObPLdWDWZGeaI7QllVfr7+XPmiamhXIz4jBYDmbLJa0MhozX2z+oU981Cvpn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788207846; c=relaxed/simple;
	bh=yP4LWZscxIASWRj9G8N+R2uWMADlSmpMlTRMCdZzwUs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FDZXqasV2074mxq8BKjW6P61azWZvqdSlQs2CQbZXR3ia7yRYZOU4kxKaNYSvePIPY/kvYJsUwo8egXpwYyktgJh9WGyGNjfuaWJiW3t32spv15xzMgVnVvfLFKyb9mgttgbfxW2tMOeuBnC7CA3/6dnJ2uMK71E/iVv5n6BoBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZLULV3mo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SB5wgdM5; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZLULV3mo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SB5wgdM5"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VGBm7Y1783783;
	Mon, 31 Aug 2026 20:23:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=GiJINlLi+brQLwoeJ4A9P4xfXn49rT69C6yRChOPCbY=; b=
	ZLULV3moUJ6l2XTRF/vtFmmm82VNe3vV2X2mEimaO0A+ZGYDKf7sfUFcBsa+N/pQ
	R/AH2iWzuCQ8varcbUWg175grlmYHNGo5n79ejGVcoX17Ced3stJ60PuMnxZLDj/
	n4lPhBohCXgVi01sba4lWZNumT2GRYGfvTLp3LYSTsG2g+z/Wp09FReSox3fyN/v
	xPIm7gkTji1S5xLetoYQ65GWYtJa7ovPnIzRScjDr25WYfIv6pIVheVPH5ELiHYW
	NAl2V6CaltnjpbtS8GHitP1RRg857YG4i2EwbUf6FW9MTdOG/ZWzuSnMqrtkgKMJ
	zn6MbB3snTDyJNgIXlnmxg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gbp0xud5u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 20:23:40 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 67VKFb9A032781;
	Mon, 31 Aug 2026 20:23:39 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011069.outbound.protection.outlook.com [52.101.62.69])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gbnvpqu0r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 31 Aug 2026 20:23:39 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JOFKHjMkttuWvz09qDGJNK7qHv5Idj3fsJ1rwwuC0o0gqLjl0duTqRKZ9DOqyAaJbfBPQTD3iKGA5xLqOLXplKQboGuIQuRH7LdphgY794f1qSpUbjhKNl3BW7I/7fi8KQnyU5ejec36H7VHrlsmUOX5vAuoc6fGmfYperX4UfzXRHpnVYkBp1R4OWdb0tQ4QNPbTewSN2RysDC5A/5kKmhv5OKQTJ9LNjngzPohCdsEsWvnJU1NiwqPJF99V19ZSBD6GfkAWn9fzT9PQqlIuHgEbZUBh/PuR32dG51kHjdjrTe6Gfplg9a9FNN1K2Iazb/RlWX3k945XLriBC+5sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GiJINlLi+brQLwoeJ4A9P4xfXn49rT69C6yRChOPCbY=;
 b=UvodBtMSqWEIrK3SQk9nXvL7zUE3y8FbQH6rXdiwdVGAsIY7g3Rd0kRWI9EZPLyvjjp9ztTPduu3zVLdICQDasYj66EZyL9aLBXSRvEWl2ZXKfRUdDblOv7rZiAkbWOWK9tDFAcoX5B4ih3Goe1ucvUPIOxTFk/DDTvEld76ZTsP9YM6NUXbzxm1qNsd7QlGeklaLF6qmaxyDEL3ush8C27fQaccZa3YcGSYNAcx2Xm/wZkfFSGW1mSkWW88khKFwGjivfcShnzgpY9O46hnPiSsmiWb4ZQoQ3qPZd2PCpTfJvs0XOYCdSCDKzlR+U+0IoAL0KNoqphmeFT8YwTMBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GiJINlLi+brQLwoeJ4A9P4xfXn49rT69C6yRChOPCbY=;
 b=SB5wgdM5/Na7mYZ6/azp04gfrt/8rlVaImms213M2nkWHb6URxoEDX+k955oATAHuH4KQg7UUV7DNMnBEaSCHt4Oy/wAer/bDTENY+yUq1MCuPxK4AfVywUV2og/FzwFRJfHYUq3Gs+HCL3piaT6JouLc1z6lPdYZr2JvrHG5Tk=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by IA1PR10MB964822.namprd10.prod.outlook.com (2603:10b6:208:5ac::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Mon, 31 Aug
 2026 20:23:35 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.21.0382.007; Mon, 31 Aug 2026
 20:23:35 +0000
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
Subject: [PATCH v15 15/16] barrier: timeout validity checks for smp_cond_load_relaxed_timeout()
Date: Mon, 31 Aug 2026 13:22:50 -0700
Message-Id: <20260831202251.305046-16-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260831202251.305046-1-ankur.a.arora@oracle.com>
References: <20260831202251.305046-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT1PR01CA0136.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::15) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|IA1PR10MB964822:EE_
X-MS-Office365-Filtering-Correlation-Id: d180bca2-c1e0-4f60-a518-08df079dbbf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|366016|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	QUtuoHRVVBOn5gguDHZMoRcwMp9E+5ZCdHVXBpCG4jKqyMei1zxqjo5vnZkeFZwM0KeTWZOOgklez5DU9blVi6JCUvoEPdVf6evJ2X7w1Z8Y/j0/pljfLFojO//FhnXEQjow/TRYV6kSCviukg9xM/4pewFj3FIuGwLZ21CIHa3IkcULFOdAWdK02OyWaV1eAsbP5/hkvXIVnvYOkzY9bL4PiAdjc6d90EQlsyBXwC2wVy8z9hN/cjLBA6pGMp4ESCTUsWBfIIzS8Ik7k2EwEBe0grBGku9STOKuy8fKSyGgijLrVnG7q25MWlgfK3ftZg3+cWT65PSBUeKw5p65EF7eM7zKqgnki7b0buUxaIaq3OhoNzAdUlNHGOT7mHsHY3PUaYpqYNJ+yF5R0AOzxaBpyKVn6GUuWWN495wuQCWUgd7ixDCSWxpMGroFdC4xsmcZ31EJUdSCEqvCsOX8793ypbnLclM0Jpf/GdZohWLsj6Kq/kXEvb6zIKsDWlVTkQ9Xay3W75EqFtb6MARsQTMzfXkg0AVT+oeTGQLWW/MXa9AGyEPXNnHnWFMugboMwwIVKkmpfKLVqc/CwJ2vI2zI/ze82e0bWMxBZIJyS6M2ngPJbZgvoiGCuc9Qoqg7Jhe3gLB1Sc1PCr7FDBLbtKGh4kbRP7vHndTlMKK/klc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7Z/bPlbMPrFdo3jqh9FGnqNDdoMVGO1zcTf3h5l+UhJ0IdeTWtdaeNAih7aS?=
 =?us-ascii?Q?DRi6pXgCqHRwvG0joAUUhxUVBWMpiIIl5hXVPMV8/MrJufbPBkJxfgtm9fAS?=
 =?us-ascii?Q?E3GYPlNufZ3/zPtJ0xXaMvlj6gdM/noFUXM741y02P3ZW9RMytrXgNr5rbIy?=
 =?us-ascii?Q?uWTDyBJRTRHpL3RD8gQ45cUoobJ1Ppyce+Usqoxi/jAyF+DjyMVfvki+p5N0?=
 =?us-ascii?Q?y7StqMSy07c0I8M5ASwBgT0OjJGmqUb/HnmGtrarwdGHxKj/0j5p7KZYSZ7G?=
 =?us-ascii?Q?qNWF+pGVx3y91C+gGneQkRL+RAywfhMUsLsWdvCk/IhlmfQSRPYLKZ97gNwN?=
 =?us-ascii?Q?+BOXLCK1MipZJSJNRL+H9ALpIPj/Sj19v0+mDy7K+6Ah16qbXYCDLx0ir4/L?=
 =?us-ascii?Q?Rz95QvO8dueSvJjsRfwUOwT1xi6tGBLFKG2h7qZUIqIQ4xSIX3X0zesitbZ6?=
 =?us-ascii?Q?1KeCwsn8wwYq4KNNaQWZcEZi2I/QKB6/Gx5xkXBunZaAXDJp95rCoeyqOiy/?=
 =?us-ascii?Q?Cnu+Iphk9YmCmcZChB0ITGRrr8gfIWT1f81RdOMKwwl/DGdACt/EqFKEHlS/?=
 =?us-ascii?Q?Tlp6eFDDZU13x5XjQ2Ht+VXIzo87c48U0N0tHIPwzNDpaIzUX6kf/uWmHuVw?=
 =?us-ascii?Q?N/v/BWIyfWIHjWKrT+27sqyqnKP7XxtcSngDgM/Epk/3KhVOLe6BrrS+E9uk?=
 =?us-ascii?Q?MiklhfjjUxuZaX8zgfKFK+lWUs0xe2f7RIGWCNTV4Rl+bn8A+N+iA2go8pOy?=
 =?us-ascii?Q?ijd58rKz0t6K9r0f2We/FYGToeqqsixOmrMlslXdxJ3tmFqCTczBLJFzWDV/?=
 =?us-ascii?Q?mB5NcNk4spOHtV3ytDiI3MQnbBOSi8z2I4S+YXsv1/wMfrb7RzJtCVrolBFb?=
 =?us-ascii?Q?FJpuXH6b6/x5QFTgOBzTbYtRKr3h69/7Kxum6qX27QJVV4GDG+zAwNk3EWjG?=
 =?us-ascii?Q?v/372Q6q083XZFARP9zWrXFW0+guQR4kC3wpovGCyjurt0UAT4t4P59fTPdV?=
 =?us-ascii?Q?AVcIfhem5Gm5//NfMmJK3TgtiiU8bH58yeMv5Ok7YggR4mX1mIE9/uXebkGi?=
 =?us-ascii?Q?SyJMNPXMAPI7jHrbGIqnTrunEYRbHrrkmNsOFKMP/c9WlWE8H09KMMETh9sR?=
 =?us-ascii?Q?lQ7l7vDduJ3+aDCsouuT50+3KiUZlQgn+Hq1mZcAA14v5Q01L4xOLxNtuXC3?=
 =?us-ascii?Q?DAz3norkHaN8BFsz8tNlkqKVjqms+vT/gfp10W+aKFT664zzR2nTCAbU+vkg?=
 =?us-ascii?Q?yWK63/x9MOhzKM+eRdCIeB8fWajgWeSbiS5hky9u1z7Vj1MtdF8Df0ZBImai?=
 =?us-ascii?Q?zkUQ5hQ0IHjSTegNkIixpxM28GvjVI4UwN4HxzTQdTn7ZPlo38efIdqhCoMM?=
 =?us-ascii?Q?lSS/khoV57M2UikrH31RgqP8psTRq+9/beTcld2rn5XIBjtI7HXgcVvVz85G?=
 =?us-ascii?Q?22/Hnmg4HJIcPuT86Nad6yFDRma+fWLqqx/crFC1HB5RO+n1Nf8HO3c+jOip?=
 =?us-ascii?Q?gS2n1QysWAlYSg8/YdKFPx3nCbdKugWP5Te2EsE5AWR2wm/MrrpCGMQGsN2d?=
 =?us-ascii?Q?lHZ2myGoAnAztd7OCB5fIo+Gve6s9XvRT1NJ2rpxQE15710ZW8rrBcZPWQUV?=
 =?us-ascii?Q?XhcN5VkiJ3nbRXdUcfMfdOfc4H6Cj8lDQ3dOIXTrqeYWrNvVN7S5MSvX3uGN?=
 =?us-ascii?Q?BUYSvidS3lNp1U3SqmpsCn75pdkOaUJzXAZ7htPOpWFRi711L3XKIB5VJ74y?=
 =?us-ascii?Q?L5GAbZxXmKWZXlxngvV0/TFDJ+uyU9c=3D?=
X-Exchange-RoutingPolicyChecked:
	z5vm1nMDSG3a5K8oyV8nzL7EV3Ew3VnBLKv6mnWTCNg+mQMgKjZnSGRGoZqQuzB0y48aKc6qiukPBnB183yFKy+NY5h3XgkcFwy8nWuO47u9SVtK7EaoMuJTytTvpQJops9XlNc4Tp4iPV7j22WllDpiF5yP2Iwy5OHLOtzDUtSUmtTUB/IXl/S+/qQT3jcrV+HmS4gW2qmygoiQlJvyNlDc2i5bZ33fNpTsIvzyTy459VZRSXDWdvPoY+gcalC8aHQ0lJlASCxIMd18qm8j50Uga0dsqInSTY9N7Ph9ltR/wvLAczBAVDUoxslip+i3JKeMvXHAcWQVlJTFRBpxgA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bukq75TUgaXb+Y6MKI0hlWo7m9MKASeXIyGE93Sx1Ex0YqgcEmE0apjauhml/0EXlKSxYkluS17H8t7wff1vdbM23J7pX5Pva23l5y2ayIGouXQB5/I7mNnIExJV/uLQnCO7mqBwTUeDEaxdtN5lC+nBanDRkKVgAQe8Yasddj32HDglsLwmcycx4Bi6SZA+Wk/mNN3KDw/Sni8WKl9jv8tmxhAQyfY4sAY8fHI7TbzFDcPODyNQj2WDCme/8i6pBq6fp+82EJK5kIHF+ZmKNT6NuXKWuDyti2d0qqiLP8Lpw+pUnPQkARuXRF0Hf1TjwSrPH7/haDkucsXPmfElL2BU6gO99H7/8iei/Yl3v6NcenL0WUJy0rbxJXvGnQF+ycciVwFZaaUdSoVXH4TLV9ROnu9xbW6hQiW+hmK/YkDCeyDh8fXU27InbqwVns3tz6kX+R4E0Wufdw+4JQSdhdWTY/MIB1GpPE41B9toIBCpPSPMI+ArlCPO0gpy8MRjloyIR4/30MsDMOsSq2W3IGdeVbhyZBfRo846EUj55BIQPOqLLB4FsG75TxTVuHo7AdjF4lyWyNnvHSg6b06iCq4s1Sp/l6gyLJUi+Bk5M4E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d180bca2-c1e0-4f60-a518-08df079dbbf4
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 20:23:35.5904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tiDU7L20HqR9vq0lxPBy5JSvEDpPlls1K1RsvGpzK8xHD7SuJl+Vwiub+3ST7340QWomaL+Nl50qFeAo2RXZLTCRrBxeBN57hpEwlkTGVpg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB964822
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_06,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 mlxlogscore=999 lowpriorityscore=0 suspectscore=0 malwarescore=0
 spamscore=0 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2608310175
X-Proofpoint-ORIG-GUID: wCRq8OhAfKVe9i2_fehxi9QBzao1DHSn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDE3NiBTYWx0ZWRfX3Epbw62nzCyb
 YNqy3gVoWW0Dj8G0YfOzyc5d7JqSySeMxkrDEnZqThNhZASVsDtwC8wWe1ciW5Nkv5baMQejTvm
 cmglurIFJIEY5jygNLjS3cSupBy+vCP5BPVCXbTIGgIxoJBir68+JE758DRK5ZGngZ9T/iT0ESp
 r56zQIfVq69t+RZA6FJ+cqmVI73Lk3iO/X/R6f+/muxR5trVWq6Vs1B5KLIp0ISyIlxVr/UfXFR
 HL6SlnimLK1BzdrvjhsTDn9QAJYPlTDCdSEBqHd7I00iFSj0IoS7YzOej+ZOM5AZKHRrcXNHW8k
 mBJprqie/TprMxGfJgiQJwsq0qzJMhfF02dBFYbGvrrVnzFJHqtOdIuQy5SIXav0xN5b3uSNFbm
 hBZ4/mGC9UX7A/41z+89qfaZXzxTS8IjxSe8oCoeOJAg2VLIGJu8RpHpBQbffahmALCtT7WQbqd
 G0RZF4CBmhEbsLC5KrnMJon4sL1iKYsHDlaDcy8o=
X-Authority-Analysis: v=2.4 cv=Ebb4hvmC c=1 sm=1 tr=0 ts=6a95e2cc b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=yPCof4ZbAAAA:8 a=gJxQClgCQG0ChMIF28IA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13521
X-Proofpoint-GUID: wCRq8OhAfKVe9i2_fehxi9QBzao1DHSn
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDE3NiBTYWx0ZWRfX00QFjsLSIE9m
 ecYnUrd26MnHjTbibE+h4NtXZebnV6D9DZWP0x4NT1NSCjeHmmjrc+NdFzOGf6shua7RgpnZkuZ
 0IXdg8NjnoPOHj22vFxFBD5d8fCU8M1/dKjiBcjBLI6Naufznawm

Add timeout tests for smp_cond_load_relaxed_timeout().  These check
that the implementation returns early on invalid timeout values and
handles edge cases sanely.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 lib/tests/barrier-timeout-test.c | 86 ++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/lib/tests/barrier-timeout-test.c b/lib/tests/barrier-timeout-test.c
index 60f121fe5472..9b16ad6f5514 100644
--- a/lib/tests/barrier-timeout-test.c
+++ b/lib/tests/barrier-timeout-test.c
@@ -19,6 +19,8 @@ MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
 struct clock_state {
 	s64	start_time;
 	s64	end_time;
+	s64	extra;
+	u32	niters;
 };
 
 #define TIMEOUT_MSEC	2
@@ -110,8 +112,92 @@ static void test_smp_cond_timeout(struct kunit *test)
 		KUNIT_EXPECT_GE(test, runtime, timeout_ns);
 }
 
+static s64 synthetic_clock(struct clock_state *clk)
+{
+	clk->end_time += clk->extra;
+	clk->niters++;
+
+	return clk->end_time;
+}
+
+struct smp_cond_expiry_params {
+	char	*desc;
+	u64	timeout_ns;
+	s64	clk_unit;
+	s64	miniters;
+	s64	maxiters;
+};
+
+static const struct smp_cond_expiry_params expiry_params_list[] = {
+	/* timeout_ns is invalid/out-of-range */
+	{ .clk_unit = 0, .timeout_ns = -1LL,	.miniters = -1, .maxiters = 0, .desc = "invalid (-1LL)", },
+	{ .clk_unit = 0, .timeout_ns = ~0ULL,	.miniters = -1, .maxiters = 0, .desc = "invalid (~0ULL)", },
+	{ .clk_unit = 0, .timeout_ns = S64_MAX+1ULL, .miniters = -1, .maxiters = 0, .desc = "out-of-range (S64_MAX+1)", },
+	{ .clk_unit = 0, .timeout_ns = U64_MAX,	.miniters = -1, .maxiters = 0, .desc = "out-of-range (U64_MAX)", },
+	{ .clk_unit = 0, .timeout_ns = 0,	.miniters = -1, .maxiters = 1, .desc = "degenerate (0)",    },
+
+	/* timeout_ns is valid */
+	{ .clk_unit = (0x1ULL << 28), .timeout_ns = 1,		    .miniters = 1,	      .maxiters = -1, .desc = "1",    },
+	{ .clk_unit = (0x1ULL << 28), .timeout_ns = (0x1ULL << 30), .miniters = 1 << (30-28), .maxiters = -1, .desc = "1<<30",   },
+	{ .clk_unit = (0x1ULL << 28), .timeout_ns = S32_MAX,	    .miniters = 1 << (31-28), .maxiters = -1, .desc = "S32_MAX", },
+	{ .clk_unit = (0x1ULL << 28), .timeout_ns = U32_MAX,	    .miniters = 1 << (32-28), .maxiters = -1, .desc = "U32_MAX", },
+	{ .clk_unit = (0x1ULL << 28), .timeout_ns = (0x1ULL << 33), .miniters = 1 << (33-28), .maxiters = -1, .desc = "1<<33",   },
+	{ .clk_unit = (0x1ULL << 58), .timeout_ns = S64_MAX,	    .miniters = 1 << (63-58), .maxiters = -1, .desc = "S64_MAX", },
+};
+
+static void expiry_param_to_desc(const struct smp_cond_expiry_params *p, char *desc)
+{
+	char iters[32] = "";
+
+	if (p->miniters != -1)
+		snprintf(iters, 32, ">= %llx", p->miniters);
+	else if (p->maxiters != -1)
+		snprintf(iters, 32, "%s %llx", p->maxiters == 0 ? "==" : "<=", p->maxiters);
+
+	snprintf(desc, KUNIT_PARAM_DESC_SIZE,
+		 "smp_cond_*_timeout: clock=%s,  timeout=%s, iterations %s",
+		 "synthetic", p->desc, iters);
+}
+
+static void test_smp_cond_relaxed(struct kunit *test)
+{
+	const struct smp_cond_expiry_params *p = test->param_value;
+	struct clock_state clk = {
+		.start_time = 0,
+		.end_time = 0,
+		.extra = p->clk_unit,
+		.niters = 0,
+	};
+	s64 runtime;
+
+	flag = 0;
+	smp_cond_load_relaxed_timeout(&flag,
+				      0,
+				      synthetic_clock(&clk),
+				      p->timeout_ns);
+
+	runtime = (u64)clk.end_time - (u64)clk.start_time;
+
+	/*
+	 * Check if we do the expected number of iterations.
+	 */
+	if (p->miniters != -1)
+		KUNIT_EXPECT_GE(test, clk.niters, p->miniters);
+	if (p->maxiters != -1)
+		KUNIT_EXPECT_LE(test, clk.niters, p->maxiters);
+
+	/*
+	 * maxiters == 0 means that the timeout is invalid/out-of-range.
+	 * When not, we cannot return with runtime < timeout_ns.
+	 */
+	if (p->maxiters != 0)
+		KUNIT_EXPECT_GE(test, runtime, p->timeout_ns);
+}
+
+KUNIT_ARRAY_PARAM(smp_cond_expiry_params, expiry_params_list, expiry_param_to_desc);
 static struct kunit_case barrier_timeout_test_cases[] = {
 	KUNIT_CASE_PARAM(test_smp_cond_timeout, smp_cond_update_params_gen_params),
+	KUNIT_CASE_PARAM(test_smp_cond_relaxed, smp_cond_expiry_params_gen_params),
 	{}
 };
 
-- 
2.43.7

