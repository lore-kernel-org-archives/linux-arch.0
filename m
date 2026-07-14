Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CD73EFD26;
	Tue, 14 Jul 2026 07:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784014349; cv=fail; b=SvMNxZ6UkPQG5dQiPqNfbFVcT0RnAkl2Ua2xFsSkrAaBB7okGXX0Q2BokBZdJrJbhFQOLdkpo7FX1BdWhYfQaHSBWWtwTmXbS2uVNOOs5NlfuDsGdfypSSi/DJiIHW+zGjbPddtZHJyt2xc7piu2v4JNdIMJ3XJdn6pnkC26huE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784014349; c=relaxed/simple;
	bh=5BYiOnC1Ixgp/oifypn5D4dbaaoIwC0uZzfZ5kOGTug=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=InaysimBMGCmcAkxceVAoANVmOZIi4RNYguXG7hLV1jDkp7y05whDSjOIF1UzTO+f8iL8hwK2mZFmusr6k5UR2r7FElWRO5BYQdNnNeJQkGoFv2tXsMBeQwhB3RNGqzK9hiBfElyoqMA48L0bckHBSOIIXvkS1gFBg/b1Xv+RIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eoxd+wBR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=igyApXfr; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eoxd+wBR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="igyApXfr"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DKmj1w1347388;
	Tue, 14 Jul 2026 07:31:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ep2/C70DUSQ9O9477a40YlBRLiny5SByWbDGRjFJ4UM=; b=
	eoxd+wBRUkQACF4DaG78WSsnQy2t+A+Y6fve2B3Nbv5pn6KOEEuJAo4tJgKpFdzA
	drMQ6nWaaEQRkb+jhHzRPnI9A9/WjLWUk54Ourj4duzzD5TBn55pESvv3wB8ko5K
	MPRv8tRTYseqJewkHbTNxqLGMknwCcwVm5Q4GUdgO2PTG+phRnhtEKj05O7Z4M0o
	wSSLMfwCKrX70ekj4aaZSR39zjg2jXLg3jMJpAtuCgQSdNXhs5St95AAVX/nepjE
	yup9lgTa7quwS+w0vSaghOT6QvBVTIwFM/DOq6kSEhUlRBQcMBi69aBZH6LpGopM
	XHkuGMYwwWQrlnejVwswew==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fbep33p3k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jul 2026 07:31:11 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66E7S9da017551;
	Tue, 14 Jul 2026 07:31:10 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010063.outbound.protection.outlook.com [52.101.46.63])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4fbc9dcwav-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jul 2026 07:31:10 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OUEK9//jWQQ1+J7SPMtqE9ipadQZGv1tNpDF11q2umJ3DMAuDWqvjbx9YhNu7skWdjeTrjeMI5gxZjVjFso5QFwS609LaUJeXYqeVBzGTz5K1wjfAzkCbilCvZVkLijiXLV0IniIovasN+Vq1m4C5WdPiu8r58srtErEVpciOShH3uspStRzQMYkdkexH0B2rF40goaaRDG220sgStPyFKG1yP088MsVmrQi1K67ZG1rTCSA9tobBfXwjgSTzc/45fklExMSmsO9ZRGJqSDkK42fTbLHN1PtNjsb0zd2riWcejWq+y/mGmATWD5du2Eh5j8qXZERapVQ9estMVtkXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ep2/C70DUSQ9O9477a40YlBRLiny5SByWbDGRjFJ4UM=;
 b=wI6c+6Y2EGQMbhXx8Xg+YnktdRIvKoJEFa+aQ9q2inXqMOEMTIYKLwIIcMqMGIy6bP7qhimHtXnUJOH8kXujNenVI9ONC58fWnQ91elaW1eJjaL+qMHWcEBgLVQ0mi4YNiMemEBflBYKHBte2RdfITRo/r+XfTG/+xo8aovWGiAqIi9tJPlcxTGFt4nG9JLYqPWc2WzEOieS7II364lwGsXEjUWVxJwI4QRQxdhX6Y3LcYSLJtinIh5p5XpicbQkw7cAxNSjuCpSkD5YY7qa+gclyki+QUwn4V5svbs2nJAu0+Wqs+Z8kWRVq1HGQFWlbbeseMf849lMJ06UeTAnSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ep2/C70DUSQ9O9477a40YlBRLiny5SByWbDGRjFJ4UM=;
 b=igyApXfrSm0ObeMZ0I6a25Ezy1WF+F1IP+IPGokYntdj8Fsetp1tupXuvDvVcAu7ruJG3X1+GKVxSLxIeQ/I/4Q1EObmGqrDsAhqEp80twGeHA/C8W3qznJLJDgGOSQOI8CJf+8SfE9bNJGe0jz2PQisb8g7jX70CbjSkfwDfT8=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CY8PR10MB7124.namprd10.prod.outlook.com (2603:10b6:930:75::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 07:31:06 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.21.0202.018; Tue, 14 Jul 2026
 07:31:06 +0000
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
Subject: [PATCH v14 06/15] asm-generic: barrier: Add smp_cond_load_acquire_timeout()
Date: Tue, 14 Jul 2026 00:30:32 -0700
Message-Id: <20260714073041.40250-7-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260714073041.40250-1-ankur.a.arora@oracle.com>
References: <20260714073041.40250-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0058.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:111::8) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CY8PR10MB7124:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fd3e53e-7448-4275-d93d-08dee179ddd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|18002099003|22082099003|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info:
	+7NGVHl6nd2rubTBP89rSt7aEWlUwqhhF7Qk8JowVhSekGPnoqTZsM0NQ1AWIXP8Ekw+cHz6ckCYgbwx0+NcFflJqp9zkZUxP+al/UuXPz2CqeNTNDLPWVjvaqtK0FfiCuHQ/bmwHbI+mLiU2vT6fi2+SSZ9MLw+9fR8/LkbQbSGqfzW0d5rTWLmrm18E7wWb3WK1zO2HUla37D2MYL+0vJvDb+qPTMk1NKnTHxSs9X2pK1Ew2K3a3EF8szwuYm8w4vB+9XoAXlxwxhKsrMW1T+42ot5dv8XvnHHjO3i6joARKQqg8RZTAx4VlcHi72Fd4MG4h6UCr+Q9rWWA45Ew//ZYPEnntwqQgVVJIz3I9dl0UZSyDtW27KLENFnc/XWMo/M9+5ZxE5SnPB0PHKoAYJhzqnCb9fhWk/+5IOEK2IYvA9NjjYXLAGLhydXyPLyr1AN8hsUbQv/Qoqz5rsbK3RZF0QOPg1hT9Gc3ZQwTMnr6dRDIdQZJY6OHBPU0G8Flzr6RwF8fSRzGSWggYKmeft2nG3QVMkrMU9z4gC5hiiPZVABLihg40KmRI6gUN72Sk80RBlCTW1XUaon9hZdpQNfBDwQwep3FkLjwEZELLpN9HS9CBxO/DhdqqfdD9HW08F2Xo6TWIN4da74IziCf0HhuR8rqF1BlCkd3XT4d+o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(18002099003)(22082099003)(56012099006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fCwCriq/ClRvJP6JCCFq4FSFAIHnVARVa0xminEw9TdQzw94Hn+/z3aLxD0L?=
 =?us-ascii?Q?UacXyytbDyiGCcQLeLVn24EdLRXiOVBV3vPg3JYzYkuDHK3m6srBTat1/NzS?=
 =?us-ascii?Q?4yDO7pV3G4BcMyqizwOEKUllhpTSk1P9YJmEeC5IO1HOVJrjwaQG/n0AUrHM?=
 =?us-ascii?Q?6f0VHpjR/HRsc4NfsCXgH7JhHBuY5qkqW8MnPCOJGccCy/R+vtv4/uvgRvvi?=
 =?us-ascii?Q?rrgeYtlaZ4+w8J7BLHRCErLazsFRy2gb9d5KRt2e3n5uOUkNLOqevD2F7d9z?=
 =?us-ascii?Q?fBA4ZsPdPDPy0uUrFd3QmdpwQiteDtsyhVo/3t4JHq2WzmBywIYympMeRLzD?=
 =?us-ascii?Q?G03qZ6PtW7rvzQsDnBcpo4wny61CIJLzjtI9A4uiNDoOlEM/q/DnNusMNNSv?=
 =?us-ascii?Q?exk7T2dRAVpJjPBakqjzSJ+WjeGv0GNQ+PVfYTdFnnB613iLPU2Z1bKynb4s?=
 =?us-ascii?Q?12o2/JcZbaEGlnJ54wDcR7YUYAs3E+5UHBKP+KClUvSu0xyGTHoufwUPmaHK?=
 =?us-ascii?Q?1wPVHArS0IK4ucb10QcF/0KghJxYZ1HVUCTT4opRMuW9Wt+PedCAedrreaaf?=
 =?us-ascii?Q?BGckFV+wB/vKaDTk/L+sXO/zrT+YmVMi1Wtzp7S7ZmSVlQI4QYwRrp+AZax2?=
 =?us-ascii?Q?26EHapo6SZqJuK+NPavr8oIkjE/BueOwF6uFJiAHFd1IeJjLgJ/FKoJtQ53h?=
 =?us-ascii?Q?xGisA1EeImp5u6L05saiJJl6b0fAcr0ky40oswuHxu1z8P9e1z3zQV5W8/AA?=
 =?us-ascii?Q?54/t5kaYjXV/yFvkaPI0c7sq0rsS1idsmEXux2BkxyJ8KRfLfpckeg85KN57?=
 =?us-ascii?Q?bk9elLmBOdkDOo237PkdTjSFlc8YHaisz7CP/XfqZRHai93RWD/9WGqQhyju?=
 =?us-ascii?Q?9CwKZmrQdlZf7/y8OZAGUdrud1vebsbmuLWHPrqdTA/ySmVRNz4Y1R/x9fpC?=
 =?us-ascii?Q?OMxbqWNcMWgVSaS9NtpPSDCtgwQDZC+n6d630hkw6LMFQ6d1oBYuWsIKxcvt?=
 =?us-ascii?Q?3kQbq1ttqrh6+7jp3OpHcoxhf3CFEeBdgEzm4m842VCizK8Nxzp3qeablrQC?=
 =?us-ascii?Q?ZXDuCnFWTyTzHbMxPl5AceY+9KUH+Jp/KVmF8YBjXKWSIJAiB3gbki0FpUEa?=
 =?us-ascii?Q?ZQiP2DiOygg/gtTR7KGiYOfKkxUg48/zlTwD232wfV7XlWyPImsEdP0uk13Q?=
 =?us-ascii?Q?h7OWqPXqCi20nuCD2oKxcf/Df56kpwY+NbSZWkvakXmWtbeVjrGyXcTNkeTP?=
 =?us-ascii?Q?C2TjZG0f6OwUcmKKGCXMXyTep6DlLBDlSKyQskx6UyScRIOFl01YELtQmopq?=
 =?us-ascii?Q?ruaJs5sj96+J6h7z2IyY3GrYNQg77LvOqe8DHEgxu23j3Utvi2zlr5U8MMJQ?=
 =?us-ascii?Q?zECb+SHr5e2pM+Jfm/ljVmGzsKQL0KN6UMdd3Mk8L8u9knSK4OhIOBVF5gd9?=
 =?us-ascii?Q?/0Kb58DEikdR6rjuZ4ELnyA7E6esZFFG8yYQ/qj/uZY9MQe1Mlx8f+8UZneg?=
 =?us-ascii?Q?AEsPyvZISZSfJ07JnapANHlbEDjOgN3wjhm+L7kYCgUoSGR46BNxSFTmMHol?=
 =?us-ascii?Q?VYHscfLV/3scKvUuIuv7jg0FWgxI7SsVOpCkPH3bTZGayZUCCS5CJ6GAebQS?=
 =?us-ascii?Q?2AzwIEsA/Tqm6aA9m9l33I82aqqyfYKQb2fDBA0up2MmtHg2tijG1RBw11T6?=
 =?us-ascii?Q?UAmY2SuLiNBl8dHOmIJ7415GupbLzoR3yxG9spjaJbIcMTgehXzHWnslMHlp?=
 =?us-ascii?Q?waTYUdd6x9kBkhqMLRan025bzjh+z1k=3D?=
X-Exchange-RoutingPolicyChecked:
	Ep7TEanCA3MEV3oPIzY7Bn2l4xK0XLSyVAPUmTKhOJ3UUUvJEEMEwC5ZnxaB0aL0ceYfBscscr/MOASgS4Z0g2hYco14zs0E3Am2n/6AoBG3ul5woiPNL0x40N4h8cVfDSm7tmSra/COuPHV8zCRN0iS9GeRngg2LbEgkTYbY+kbNYTXJdKGPr/YNob5ImMGpr3aHK4Ck/J8Fmj/bNrBalKATN8Blo62ZqnS168Ai6DuEqVaAW9BWNfStSTyUFS9bX04uZkQ3DxK+Lt+OM04D+XLHLPyCIAn5zxcquxcnYUNFdK+gnrG9MNXYeramAALTbBcqnUXnaOL5rYV8YT1tQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aKV0WJUtFoIN7qwYiTitqUAtGnnuqrcACDl5z76BMGiMJfDmZjO/syPlSWpl4SyP4pC+QESHTeg0X4AyRG8BgeTJO0+XCod/vCTMNBEayNgAlhOLobCf14E8XxRdO63SkA+d5lSwJPrO4QkWaNA6jikeaZ5WkNtydmzFu/il5V5l7B+rsUHV+Ogq9RgEMuimTB8DxVuv7uAjRoLv+mnWJmXSqwSNtcxOjeacvukKADDzQCIkACaSDkCgZyHlodALBTgJHCOr613CX0bnlTisPLaAr4Varn4MANl2t0ZAq/CnTDs7C9kIl9XeQApUXxg/l0YLkERB0KQS93raXQHD5KAOcwQ6nb79v7DNL21SvDVJm5RfA5HagV4I8YodHDzG+koz+XBOY5+zApJGRbt8639Nc3ixqgVtmhPsbiqJxOogb1nd5EUWzqAhZaCBC//bzIcf5V4SKiqMVbwVaqVn52QimmGxGw52YChn70goxfMKJUc89XYsNcwsOikA+BGTHXbcRaTX0/7ILyzBQQkuHewcTYIYBcvwIq5SNTXcYT5kGzolPNHeDAsnJEiDYSvig0IlaTbiGysiXrkkmoBTmyD/j8KBXYrCUUQPu2XQilo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fd3e53e-7448-4275-d93d-08dee179ddd9
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 07:31:06.3640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p7kFHNCYV43qRxBFxRoIyp8J17UWWJH2/T3Fv7sf0nq3JtVZcWRmz61wKbfdzhHIzQpo5vcKqDggbj+du0b/QR+j96PPDFPTWQ/UbDytAgk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7124
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=999 bulkscore=0
 spamscore=0 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2607140076
X-Proofpoint-GUID: zVj4zkSPllfRfNJ5T7Nz8HQFHW_ONVKU
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDA3NiBTYWx0ZWRfXwpyyTUUv7kWw
 z2nlWPeBWJtNpbownXg8mBrMiIUqSJVLjXJh4gl7HQgEe9QBANyQZxEwqLnSFbBWz/S9zC5c0nb
 j7wrSgoCo815eDhpXfN/hUrtgjwXBXepI7//Rd1lkgEk4QB3JkWS
X-Proofpoint-ORIG-GUID: zVj4zkSPllfRfNJ5T7Nz8HQFHW_ONVKU
X-Authority-Analysis: v=2.4 cv=dYawG3Xe c=1 sm=1 tr=0 ts=6a55e5bf b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8
 a=JfrnYn6hAAAA:8 a=vggBfdFIAAAA:8 a=yPCof4ZbAAAA:8 a=OqgJ4t1VicKPTwnfwEAA:9
 a=WmVTiCyuxqgg3mnwYu6p:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDA3NiBTYWx0ZWRfX2QHNU9w2jLDS
 Vg3bg+sIusjIl4VPd373Lwf3HtFX0CWEEULCeOnWsfUMcQfW+XslyI5cRvuUKy4wd4twFAM1AbR
 yEAEn2p67F7amj7DoQGNisZSLEmxexIRG45HMhHXirhm8KRdb1uqqG+GFWW8/FZgXEK8OKwwMBr
 zDTTedPJ4ZklfoMMfoxqJZhNT/obJi0E8msITujVqE7jUWji1lEf1Zo9FLCfFwatjrVQHvs1SOf
 DY9H9dZZVeAXe38IAyprfi2JxhnbARlvyzVzIZrkO5rjEEG93UuNT5g/aO5pHFZiNMOdZa96UkG
 375HnU52XF3ZHv0R8aHft/3a9d5jHPf1DcqgOGD4Gyi5eKFGK8kWP6k1WhmlVdtS51A3zOVJq+u
 3M0Pf0wvGZ7IEn5s5YriRbSrU62asjEeQoqF+UjkuzBpnhwRGrlKXC9yzenl/fZ3uRjT7vXGRXe
 Am2oij4t5xkc67HW7BA==

Add the acquire variant of smp_cond_load_relaxed_timeout(). This
reuses the relaxed variant, with additional LOAD->LOAD ordering
via smp_acquire__after_ctrl_dep().

To ensure that the necessary control dependency on the dereference
of @ptr exists (which does not in the timeout path), re-evaluate
the cond_expr branch.

Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org
Cc: bpf@vger.kernel.org
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Haris Okanovic <harisokn@amazon.com>
Tested-by: Haris Okanovic <harisokn@amazon.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 include/asm-generic/barrier.h | 40 +++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
index d1e9ed15bbfc..b2b260a41122 100644
--- a/include/asm-generic/barrier.h
+++ b/include/asm-generic/barrier.h
@@ -352,6 +352,46 @@ do {									\
 })
 #endif
 
+/**
+ * smp_cond_load_acquire_timeout() - (Spin) wait for cond until a timeout
+ * expires. ACQUIRE ordering when @cond_expr is satisfied.
+ * @ptr: pointer to the variable to wait on.
+ * @cond_expr: boolean expression to wait for.
+ * @time_expr_ns: monotonic expression that evaluates to time in ns or,
+ *  on failure, returns a negative value.
+ * @timeout_ns: timeout value in ns
+ * (Both of the above are assumed to be compatible with s64.)
+ *
+ * Equivalent to using smp_cond_load_acquire() on the condition variable with
+ * a timeout.
+ */
+#ifndef smp_cond_load_acquire_timeout
+#define smp_cond_load_acquire_timeout(ptr, cond_expr,			\
+				      time_expr_ns, timeout_ns)		\
+({									\
+	__unqual_scalar_typeof(*(ptr)) VAL;				\
+	VAL = smp_cond_load_relaxed_timeout(ptr, cond_expr,		\
+					     time_expr_ns,		\
+					     timeout_ns);		\
+	/*								\
+	 * We arrive here once the loop condition is hit, on timeout,	\
+	 * or, if we hit both the timeout and the loop condition.	\
+	 *								\
+	 * The last case is low probability, but possible in the last	\
+	 * iteration, especially on architectures with waiting		\
+	 * cpu_poll_relax() implementations (ex. arm64).		\
+	 * Now since the loop condition is not evaluated on timeout,	\
+	 * we have a missed control dependency.				\
+	 *								\
+	 * So, force a re-evaluation of the control dependency to	\
+	 * provide an ACQUIRE ordering for that case as well.		\
+	 */								\
+	if (cond_expr)							\
+		smp_acquire__after_ctrl_dep();				\
+	(typeof(*(ptr)))VAL;						\
+})
+#endif
+
 /*
  * pmem_wmb() ensures that all stores for which the modification
  * are written to persistent storage by preceding instructions have
-- 
2.43.7

