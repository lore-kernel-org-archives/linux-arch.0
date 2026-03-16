Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C7D26B75B;
	Mon, 16 Mar 2026 01:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773625074; cv=fail; b=a/oW9BKfNCtdCYGVVcPzxqNTMbmNFe+VNWjFJCOoz5JGHBG2E3zBOrR25EYS4UTolk+PbLtk+ZLGdX3AmKYH/XO7AuTJYDclyIQMNG7WWRl8xm+CwcivguOe9Yyu9SJARgiI6C0K5RBSqQxaVn+sm/CvILdTnKz+UjLYi5Zr7Pw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773625074; c=relaxed/simple;
	bh=bk2Wv/aP7r6jche36ugfoRnhJGn2oShw06NbtEHSMfE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=agSlnH12JgNvK+8W7x2KlmzbyUI8PLZr/MPiNnIMfMK19NnRJjsx3WNKMP0R+OLXHI+OxztXjNnoXuKYM9kahWx16BrU8e/dLl64VWd1ixqUwXcLoK3mqivwCVcBU9hfcY6jOPcB1YXV2oyrgT8vs0ebh7h9j0AVO/iGi+G0kGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Lc2kDK2M; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XUIsq/xX; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Lc2kDK2M";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XUIsq/xX"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62FMwfjN1206614;
	Mon, 16 Mar 2026 01:37:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=jjD/tVFB8W1lbSnwtj/S+wlgAj5rX8lEpL5uM8Yk9U8=; b=
	Lc2kDK2MFf51bjgk6FJD7uoGi/9YbDLBusLa6+g/GpK2RmAfZ8ZrGBT2OnqovQB3
	eg9i9NUvwk91DkhA8/gAO7ZINp6ZiBmvGqgPuPPee2c3zoy7HDrT1E7k0poDWzE1
	eF+rGv7Tv1hRLIrBCXC3SuWzX+L8EvbcZz8N4wnX2LtxGWN3qxq0a7mfu2z9SQgR
	mID/JYvJtNyKSZ2ewT0AieT9tc/IR1eoSi18D0OR2cKFnNaeKv7FTxCWl0hv8Sen
	0kpiKo2Uaws3FffNbYrivoCzO7lw85y6bSp4rI7kGDhlMHVuTeaxxt6cBoJhbaW/
	aNFzOuoSaiTTaQDrS6DpYA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cvx3b1bhn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 01:37:22 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62FLUv3s017939;
	Mon, 16 Mar 2026 01:37:21 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012008.outbound.protection.outlook.com [52.101.43.8])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4cvx4jgqbu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 01:37:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l7ecumjfmi5eEWKboa07IBAS/Sxx9IiekOOptn1Ul11wlUBkkUBi5JSgXEEaoTqIN/P1Kx4Ih5adHSpRD4ejl9scKxImu9eJzuT1G8WD4O0+F1sELXr2vscDhTwH0IEkTGAXskyfSqonPn4Gz0vqKCNnd83PEKnEq+JTb658Di1nBJbYooIgTSp/9fHjDeketk/0xMDw9IuYu9dEJ5QhpCO9h88XqQX/9VwCsgtIyzOZdxL0wBQbs/tmO2E1hi4JyH8rxK1RHRMcQVNf4uFWLkePneEU6/2ShybYs1s0hogszjTarjrw81FflCcaJl/9//EAcaQkyPFnPdvIqEWD0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jjD/tVFB8W1lbSnwtj/S+wlgAj5rX8lEpL5uM8Yk9U8=;
 b=Ekv3ygv5Ay8uvX/yZm1jY9g85+Ju4ZfyCGIfmpA2FSVb0XJNC0RENe7PwdNF+w4ES9biwiF+XtugVHdKC18l1F2ZJYKs69X+tW7JrSWt1WmgVu8lS4pg9fXD3K003qG0wHijyKN2QR2Thx2FVYCD3BAQ7oz3Rxq2LsMmnTKLhtT9KIBuZwdU/QZETeCtf49+X8qRiK9OwpZMJU6mkXHDvHLYBzTgcIjr1RElCL5ClsVEyitRT0LqurdSs8w+CHdn60AJa4dkbPzer9gS+1c+p2m6/dmWXe9dSOX9m4ogEOysjXUjGygOGZ7LqnsTXedP+TQCztznYYb7Jvoj2w0poQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jjD/tVFB8W1lbSnwtj/S+wlgAj5rX8lEpL5uM8Yk9U8=;
 b=XUIsq/xXBRCKHlQkKYsfLyAkG2J4VUmz3NHMU9b+HAvwlMhLEPFbAOWOsofC/1NaWc9peTK5JLimrCFnQag+gbVTrkTqxsmAqnI7aS1S3ZlZWz9fRpXlw+FIQHekb7EjmdhJ4d+PbXUpqziWkh0BhIEJ2Gql6v0eyxuQf3NTSEc=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by IA0PR10MB7372.namprd10.prod.outlook.com (2603:10b6:208:40f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Mon, 16 Mar
 2026 01:37:17 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.20.9700.022; Mon, 16 Mar 2026
 01:37:17 +0000
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
Subject: [PATCH v10 10/12] bpf/rqspinlock: Use smp_cond_load_acquire_timeout()
Date: Sun, 15 Mar 2026 18:36:49 -0700
Message-Id: <20260316013651.3225328-11-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260316013651.3225328-1-ankur.a.arora@oracle.com>
References: <20260316013651.3225328-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0090.namprd04.prod.outlook.com
 (2603:10b6:303:6b::35) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|IA0PR10MB7372:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cdd12bb-a699-4d1b-3fed-08de82fc8ea5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	N40LFVq6l+PevzmRho/MLGTjB8PUGZppyoAK4b1Qv4LUXFv/QVYklA61YYre2s1nxa03YOhPjN4QubU8WsbKKW46lAgea30xgYrsxZZmQn2Y8KxVz4JAc4bRq+8y1S6C76+Y8kjXdy9smDqOeN79fHMfWh3bj3tzb5u8pATosd4MlZmy0MIrgzVY6GUM2Am7MVjhTGE9MDIDGwVOWWL9ZVq89papxR5CiMk7Ec8OeMumlge/UGfnWJEg2pLSM2zb0mNo/8ocjgsNzawnbLdwF/1ZZYCJphRYcw/Pmx53/KkL6RSho+6b9f9GDd/QeIOoyiDhtO9IpR89XSrWAXgw1tdO4/Qq/GbaRN3XDuXNAX4QeJIEbsNqH1DjZxVcuik2ZWBd8Q3brenCVDBmAduIFXqtC/SGY/ld5C0UVPmaDhMcJZtS7yPr20rIj60Umuv0jkj3rXGhRDllSEeNZDeoW9TdrDdZXAGIo69ockX4uYt96W99Wl0WpdQ1n+nAm3x1fjzzT9tCc0v5XAlLL0O+4NK1szomxr+kagu0n07VzsZv+NYYYFprO+e8CBXNLrB98sJeIu3xGeW9HKEJCB1JT3eW2pX7wNzDRFl1BvDTCPcSRGrbNbEpE/QJqVyWfmDaO/y2j8sT1C+YR4X1Iq/yh9ip929GQytLKyrdooq+E/CD8eitVqrfloc/3UGGbk42TYSwiv3+z5tTr0DuKp4B+farlA0I9A2uWDqKWiA4Ozs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o2rwO5hIzP7Lzg7JX1xvfhqS6pMzyv+5WTPCEZ3GSiLtPGSSZNO7At4Z7qQM?=
 =?us-ascii?Q?6yjFSGkFrxL2NsxwT6rLnICxEwskyoCIeAMy6DoSv7BcsJo9nwUY6bMDo6Va?=
 =?us-ascii?Q?V5/1lVu2vAIJlHywQ+C+6fGbclQyRH8MfDNgycZyXk5p+QE3eY+5DHth8avZ?=
 =?us-ascii?Q?OfnsZE50jdqu/uKes0wAfXEUi9xYaSKjQD48gvbqsrJb06ra8ruEggaKbltR?=
 =?us-ascii?Q?yj6nNMoKo2m4d0UOmmlBp48dj3BOH/cCX4FrN5ebGR5/oN2u/+8WWpo8hkUu?=
 =?us-ascii?Q?4WRhiwyGxtOLwiK3Rp/zGg60rpqM0GvGTPaqxO6hHLoSIp6kKah5DFUUOGC/?=
 =?us-ascii?Q?T4xakxZYBC8U3Ym2tZ5BgYNsqM1UqoT3x306Wk/mLY1v4EjOyP1V++2RJCx8?=
 =?us-ascii?Q?wtRYofCXK666hJCm420H9XOFZJxscllSJaszNW7zVmDBlVfQYq3Kg7jKklMV?=
 =?us-ascii?Q?nft/uonOeAgOh9CQzhSPtjhnkG5k4KMV4Os2H5GYEENR/AOqSMUKXA8eK98y?=
 =?us-ascii?Q?n7QOEnS84ASwgDHh6W92ej0yEOdematboYxkBpRpPu0ndcsJ7BkdYuVHQXrl?=
 =?us-ascii?Q?dQrKnvBpkJn/2ZhYncjqJI2aqqOBvDZJGarGgeRBRlMhISdCHk9tygnAaQRo?=
 =?us-ascii?Q?6poJaY5iFPYqDLj/QLSdJKHF+fsv6LV6Cmr4uAAFh/E2lHf1p8/0RZEeJM/2?=
 =?us-ascii?Q?eqgPhkgKYUYzJWED4D04OZaxS52RnUpZG3+23R+iFAEiBLnOWfXoVaLp9Eg3?=
 =?us-ascii?Q?LVYQ7nx6Ueny8iX3eW01ySmSOFhio4d3baZl2hawKxRnPpMH8sDQQQRNo1ff?=
 =?us-ascii?Q?pXC4KW6siUAUBZIecOOGx8nBPah+gU0CoJha9TbfCxNl5zUNjYMkMAghLtvB?=
 =?us-ascii?Q?+7rPhvirbxVDZH7pC5LwZjeqCPskOGgjqx41JEhxhjimdrVJ29brkVMqUgvM?=
 =?us-ascii?Q?QvJppYUYICXwdfWUqZAh9jRO3u/mONU2LJuk5ZCMm3aBA20/45ZZnelzDF8o?=
 =?us-ascii?Q?cSrTwYsXgLb5I4rVuwCXyxz82SjSMDixgXbbYKl1Hs5whv4kiiygNix38VMp?=
 =?us-ascii?Q?hmrdMjvlZeKS5e8JAOHAOImNNXr1baMmWb7h+205oiphQjQDzjZOVOcLjNg6?=
 =?us-ascii?Q?BzD97KCVh9p/ag56cZ/tn+KNDmE2s3j7cY8axDDlhfISk/Gr7xKRkC0nv2gj?=
 =?us-ascii?Q?A1UR7Axh0fGkvGtAzoYi6toMBZnpu6MqwR9wbMxGMu3eHo7TKYt0gNdWj8OB?=
 =?us-ascii?Q?TWUrpS9NB38vQdt+03y9JZVyeGdqoWtmZCLDkum6VjvIseNOHras3GEekoLL?=
 =?us-ascii?Q?41oFvHSTL1Vriwg++wyFFeEg8IYV9L9InkmPpTjNkfqQXK46d4sVznxlCXBP?=
 =?us-ascii?Q?31lhOVpcYLBhWbZZuwECItFx2M2/lQFNI96mAIt1yOVEWh3Oc0d8P8NppoFj?=
 =?us-ascii?Q?JOnq3zVDDPMjbqMxs2+gfGtHVi+ylXwu4VTqQ/wWSIOl+Jq6CdduFrVVvVKI?=
 =?us-ascii?Q?9Vst86sIv1lQle6iQEsJhh3vs4OCjm757pvJZlp5TSqkyj5abMz/eJNP0sm7?=
 =?us-ascii?Q?C8NgJRVRBAgc9IXgiwyCU8ke+a651Gd5prUr3c+u2mSh348XFjFk5zzMZ8a5?=
 =?us-ascii?Q?WD/wHwuRpqht8711wd0qo2y934oM1zc4KJHHel9SNkOHl55T8pkJozEJrAzc?=
 =?us-ascii?Q?xOMAb4u6Twl9ZtbBvI/XORaqZqfvhwpF2UG/9q7lm6IwLiCSyUCDdMCVunMV?=
 =?us-ascii?Q?mlGBnbzABS/ztzN40r+5+IS2zGKB278=3D?=
X-Exchange-RoutingPolicyChecked:
	Q9LQTs9wAqva7K4zSypChpeBq8mJ1qMVgdgYBZVndKpolSG6lPLhAv8fWef5x9TBjKaj7lvJQl0+lFWJbsqzt9Xcjw5x5fOV9RFXuobsfIpaMCvlIhOAlMXBtXhaJVMS71UT1TjRbuAk3rdM2Evkf8EldU/NXu38vFX9omMPGllCzPlrNsovWPcZUa2599NzegAJx4ygPAjwm6kMUStQPtqv5sNZjgXLtFF1wQluvbsAO3Q/YVfO/xpaJXDX8RLjEjJI5V6LaDqwoux6+ABiYHnDH3FArQBckCi52kWGZ382H8NHtWJ3g8MZm5RGys0R16iyLLh6FJXt6DO6mHnH8g==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/fU2NeNH3Zacc2BAwlCZWlRlS9wQtFIue4XcqwOunqsVH9Y1jy7MEpoJOb/X6nX5pO5dbDx3ura4pn3xJ/bak7GvgwFTEGgcZfjXRYwkhVsz14rUioMETiPIac4t04jG1SQFT6FcrIzSG8OpB2X2tdzzfHoSu1275j+ujhuEq/WCYWOKv/JJ27QTZpx7S1QLNWM0GJHicxP/TuKWEh44hFnDyrR6YB2uN3jN1RChrNx/kLu5CG5zO6cVrTmqsuR/wfR3RRO/1MPPApHlFX4Bsl38ErNmn0Y6lZ2lcGZqWBd2ew1UnscVvNEheObvczfGrLTxAml/i3w2uV9Yy829Wb5syIHTNCeUBQsymXZztu3v9Rs7t70Hpj3euA+jyG+ctKix4uGuLb+yJNDHUtJFX434IGuZA9O2UAjSqWp8VtJ7meXFzZB6jG11f2MK45CRR4MtSJqfGa4eOYNTk3iuVWQ/710YXJz5TUhByWw+UiwGBcfddkHF9LZrLku3Wiy7fJpM5lcTqfvrFB25LybWwpnok9WAHDef6TTrCri/kf60C6XCcTnuq5MTvnFb2B0AWwzt9qx6l7byLraFA/2Yn0XwYN6QDhKsZx/24+s8z1g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cdd12bb-a699-4d1b-3fed-08de82fc8ea5
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 01:37:17.1150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WIlQcVkmFDY6U0EAF7lVK0+wbAJB9LAqYgjaTmQiT5k9ON5NOmuZT6W76lMuhJJke8lZl9q0hGYjxjochC26gOBHOP2c5n6ELahyJC+/Vxs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7372
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_01,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2603050001 definitions=main-2603160010
X-Proofpoint-GUID: nLMbS3fHAdd-9utz6AwYILnzuzq9S35R
X-Proofpoint-ORIG-GUID: nLMbS3fHAdd-9utz6AwYILnzuzq9S35R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDAxMSBTYWx0ZWRfX3lqaCCCLiSZR
 mHArjlObFJ9ioN9SjhFZVoiiBP1wvZrpfGBJt79dPYazsh7gxh3clbq1t8cw/3gI3OLD+B9lj/t
 BujgslyheNvHZy3GdHbC+6KydxrZ6OlHFC3SKHvcP/LplZHN2p9qxq5r/vOQs+I6DXPNnmsrhfm
 X0MUD7kxfD/Vxnp5Y+zi4qXDdyaAORJ5t60IP/mbcZogXv5GcojnORw24HE+tbrifFmQX6Yrgpf
 +YXcjOUrdk+sWzlr6jH9USf33TGgNj4YSSQyNMaSzU0TUIoXdf00+mtKZL+AeSc5f2urVOE52L3
 Z0c5SRLYYEgwxiz4sTQrPu/Yg5RwY46kO4vgjpZpaD2Q27RxirPegqyABo4fWmqyJ6TYaNdBfkZ
 6hNGl+bpcDD7Tl9uj9K5Z5PG3+JOHZKKLuaT1upvcov9DufoyDpcMRaDx1PiIolEV6dDcy/q1hR
 6+49C3PbqTNl+W0CXisBVLaco7FimD0Z4XUXrJA8=
X-Authority-Analysis: v=2.4 cv=IN4PywvG c=1 sm=1 tr=0 ts=69b75ed2 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8
 a=Ru_WXoCZngTtvYUXGSoA:9 cc=ntf awl=host:12272

Switch out the conditional load interfaces used by rqspinlock
to smp_cond_read_acquire_timeout() and its wrapper,
atomic_cond_read_acquire_timeout().

Both these handle the timeout and amortize as needed, so use the
non-amortized RES_CHECK_TIMEOUT.

RES_CHECK_TIMEOUT does double duty here -- presenting the current
clock value, the timeout/deadlock error from clock_deadlock() to
the cond-load and, returning the error value via ret.

For correctness, we need to ensure that the error case of the
cond-load interface always agrees with that in clock_deadlock().

For the most part, this is fine because there's no independent clock,
or double reads from the clock in cond-load -- either of which could
lead to its internal state going out of sync from that of
clock_deadlock().

There is, however, an edge case where clock_deadlock() checks for:

        if (time > ts->timeout_end)
                return -ETIMEDOUT;

while smp_cond_load_acquire_timeout() checks for:

        __time_now = (time_expr_ns);
        if (__time_now <= 0 || __time_now >= __time_end) {
                VAL = READ_ONCE(*__PTR);
                break;
        }

This runs into a problem when (__time_now == __time_end) since
clock_deadlock() does not treat it as a timeout condition but
the second clause in the conditional above does.
So, add an equality check in clock_deadlock().

Finally, redefine SMP_TIMEOUT_POLL_COUNT to be 16k to be similar to
the spin-count used in the amortized version. We only do this for
non-arm64 as that uses a waiting implementation.

Cc: bpf@vger.kernel.org
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 kernel/bpf/rqspinlock.c | 40 +++++++++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 17 deletions(-)

diff --git a/kernel/bpf/rqspinlock.c b/kernel/bpf/rqspinlock.c
index 0ec17ebb67c1..e5e27266b813 100644
--- a/kernel/bpf/rqspinlock.c
+++ b/kernel/bpf/rqspinlock.c
@@ -215,7 +215,7 @@ static noinline s64 clock_deadlock(rqspinlock_t *lock, u32 mask,
 	}
 
 	time = ktime_get_mono_fast_ns();
-	if (time > ts->timeout_end)
+	if (time >= ts->timeout_end)
 		return -ETIMEDOUT;
 
 	/*
@@ -235,11 +235,10 @@ static noinline s64 clock_deadlock(rqspinlock_t *lock, u32 mask,
 }
 
 /*
- * Do not amortize with spins when res_smp_cond_load_acquire is defined,
- * as the macro does internal amortization for us.
+ * Spin amortized version of RES_CHECK_TIMEOUT. Used when busy-waiting in
+ * atomic_try_cmpxchg().
  */
-#ifndef res_smp_cond_load_acquire
-#define RES_CHECK_TIMEOUT(ts, ret, mask)					\
+#define RES_CHECK_TIMEOUT_AMORTIZED(ts, ret, mask)				\
 	({									\
 		s64 __timeval_err = 0;						\
 		if (!(ts).spin++)						\
@@ -247,7 +246,7 @@ static noinline s64 clock_deadlock(rqspinlock_t *lock, u32 mask,
 		(ret) = __timeval_err < 0 ? __timeval_err : 0;			\
 		__timeval_err;							\
 	})
-#else
+
 #define RES_CHECK_TIMEOUT(ts, ret, mask)					\
 	({									\
 		s64 __timeval_err;						\
@@ -255,7 +254,6 @@ static noinline s64 clock_deadlock(rqspinlock_t *lock, u32 mask,
 		(ret) = __timeval_err < 0 ? __timeval_err : 0;			\
 		__timeval_err;							\
 	})
-#endif
 
 /*
  * Initialize the 'spin' member.
@@ -269,6 +267,17 @@ static noinline s64 clock_deadlock(rqspinlock_t *lock, u32 mask,
  */
 #define RES_RESET_TIMEOUT(ts, _duration) ({ (ts).timeout_end = 0; (ts).duration = _duration; })
 
+/*
+ * Limit how often we invoke clock_deadlock() while spin-waiting in
+ * smp_cond_load_acquire_timeout() or atomic_cond_read_acquire_timeout().
+ *
+ * We only override the default value not superceding ARM64's override.
+ */
+#ifndef CONFIG_ARM64
+#undef SMP_TIMEOUT_POLL_COUNT
+#define SMP_TIMEOUT_POLL_COUNT	(16*1024)
+#endif
+
 /*
  * Provide a test-and-set fallback for cases when queued spin lock support is
  * absent from the architecture.
@@ -296,7 +305,7 @@ int __lockfunc resilient_tas_spin_lock(rqspinlock_t *lock)
 	val = atomic_read(&lock->val);
 
 	if (val || !atomic_try_cmpxchg(&lock->val, &val, 1)) {
-		if (RES_CHECK_TIMEOUT(ts, ret, ~0u) < 0)
+		if (RES_CHECK_TIMEOUT_AMORTIZED(ts, ret, ~0u) < 0)
 			goto out;
 		cpu_relax();
 		goto retry;
@@ -319,12 +328,6 @@ EXPORT_SYMBOL_GPL(resilient_tas_spin_lock);
  */
 static DEFINE_PER_CPU_ALIGNED(struct qnode, rqnodes[_Q_MAX_NODES]);
 
-#ifndef res_smp_cond_load_acquire
-#define res_smp_cond_load_acquire(v, c) smp_cond_load_acquire(v, c)
-#endif
-
-#define res_atomic_cond_read_acquire(v, c) res_smp_cond_load_acquire(&(v)->counter, (c))
-
 /**
  * resilient_queued_spin_lock_slowpath - acquire the queued spinlock
  * @lock: Pointer to queued spinlock structure
@@ -421,7 +424,9 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 	 */
 	if (val & _Q_LOCKED_MASK) {
 		RES_RESET_TIMEOUT(ts, RES_DEF_TIMEOUT);
-		res_smp_cond_load_acquire(&lock->locked, !VAL || RES_CHECK_TIMEOUT(ts, ret, _Q_LOCKED_MASK) < 0);
+		smp_cond_load_acquire_timeout(&lock->locked, !VAL,
+					      RES_CHECK_TIMEOUT(ts, ret, _Q_LOCKED_MASK),
+					      ts.duration);
 	}
 
 	if (ret) {
@@ -582,8 +587,9 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 	 * us.
 	 */
 	RES_RESET_TIMEOUT(ts, RES_DEF_TIMEOUT * 2);
-	val = res_atomic_cond_read_acquire(&lock->val, !(VAL & _Q_LOCKED_PENDING_MASK) ||
-					   RES_CHECK_TIMEOUT(ts, ret, _Q_LOCKED_PENDING_MASK) < 0);
+	val = atomic_cond_read_acquire_timeout(&lock->val, !(VAL & _Q_LOCKED_PENDING_MASK),
+					       RES_CHECK_TIMEOUT(ts, ret, _Q_LOCKED_PENDING_MASK),
+					       ts.duration);
 
 	/* Disable queue destruction when we detect deadlocks. */
 	if (ret == -EDEADLK) {
-- 
2.31.1

