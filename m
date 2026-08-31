Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD73D3939C1;
	Mon, 31 Aug 2026 20:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788207824; cv=fail; b=qxjc9zlnn79HVpQ+hW3CU3IkQ/+X90mawf5VQuhFg6Hj/4WbqPXl6kTF95dhnImNLPuNJ8bNLYbwSbm4o2EJ3xpHz9oxJZU3mIgEP4kvk+gwBnNJnx2VN0q6pGifl/NJSgYtyEbpxnBxChCe32N/OHrBW65wm/wD/7PkxhERwb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788207824; c=relaxed/simple;
	bh=kQjwNyshMB8qwiPzg4I6msK5snW7yndlyEvBHVr9oJQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Xo0X5G6BQNHg7frFA01fjmSFBeJQhL3nk4C97MoqdjomRFz+L59OW9jpSAhO5hWTjvkE8/IJOUXGSUVIrKN9Sa2EUtiZeETWPRmUaP6KxTNMRNvhNaSJbPFu49/Gm05e4eqQe9C4EDTfVXjrjuWq7jLThLhg8bJ5t8JrU3aqV9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oWWgJNYg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZRoqbpZS; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oWWgJNYg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZRoqbpZS"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VGBnc11775721;
	Mon, 31 Aug 2026 20:23:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=NNp3Mok5iuSH509wd3a2WX627KY9P4mKBB5/vFkT4lI=; b=
	oWWgJNYg9ChTIrig7cecNdVE6oNIcLA/pH2qyF6q1cgXC/J7PhJMvRawtd2xShSq
	/1zmEXHOIKJ4WJ3/NLNce5gVmW72tdFmgqwn6odCUb3nPbtZAD3XecESLwA85/V5
	taVKALDzxJRNJo5YhJvw6lYA4946oRiGa3P900DIa7W7DgjB6SSMrBXxSfkrVZeR
	4Wd56cigRE+ZDTz0zqBD5j1uqHyf9h9o+bPow7UcnHF5kaclEwleSHGNpKp8QD4s
	sY2RdanES3EC/xpWYGhW6M6d2yxqldSPUyx4uFXX/OEQb8Z1kzA9C9xo1SrKJDh2
	q7IQRhSgtN92YnMu6wJ4mg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gbp72bbhv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 20:23:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 67VKK8cu038776;
	Mon, 31 Aug 2026 20:23:01 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011020.outbound.protection.outlook.com [52.101.52.20])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4gbnvdgjj4-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 31 Aug 2026 20:23:01 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WIZhCoIEkpJCN0aotR+e6dr96VyzbCtRmUM/TknbXL/r+m51NCYKHG5V58HnszYscpk5ktwuqVmGKmkXS+EsJrDmil+HSetzN/0YGQhugn1dR1uIHC5F5/r2mmL90YIE5ymvkQhu4ejGv4XdD/G9JX/oM/74vhqwlqUOqHDyIouRRi3pC6oeOwNHyHmI11PbyPV29JM2yPciINJyqvSbBS8opAjArJ5Ih1myLRUNj6k8UdD2MMwMd7ZDwNjOHOUGBwyDAW8vB2ssl+gK1hmC1T+PaGONCRmI7/s0Wkmdc8CoTkxCKCMPsFL5E2E5/MDUfAws62dHT2diZ0iXqC8gXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NNp3Mok5iuSH509wd3a2WX627KY9P4mKBB5/vFkT4lI=;
 b=itcIYtmYeXqKcuKqodPLYLhQeIuO+DQg4oyZlRKTWV3tDd5ULMCW8XAKfBTx1qW4CJiuLQNBC35kSOO0r/9dVp4D/SvZ/p9kSGcWvQ6F1QZ1wpClXdFSGxa1ylSiRCDj1mkNAb7phy5TXbxzkpB+xLRSwVtEHckzRo+IBb5lbAdl3wkHpkcutUIR1vi/6NY/AKQDHBNkgO9nStGSzyxGZFPSBuHLITiONbuN+ep1coD3ZlhBtCg6NYXP1q3h9zzz9fM3sPJLuTRnuGQuLOktS/TKyzg9fTZpZrNRWYU7Y1qmaIreGLuYQoDKyxO310wxRCptoqclwKrmpHOsASDp1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NNp3Mok5iuSH509wd3a2WX627KY9P4mKBB5/vFkT4lI=;
 b=ZRoqbpZSFhQjjKsi0JjaQ5jdSp0nGbFTPVEtMRucV+pP3vN/hP02un8fqvPqDqztF6q/7KxXIEx2WZF9wEcRho8ZGZO4EBIfbkSJXp2StdZvkDfjppJUBaPoo6HOnkA41Ijb8rcdoL2zTP+VsGwx9pknyfuzAYDrS71iz4zlDf8=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CH2PR10MB4263.namprd10.prod.outlook.com (2603:10b6:610:a6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Mon, 31 Aug
 2026 20:22:54 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.21.0382.007; Mon, 31 Aug 2026
 20:22:54 +0000
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
Subject: [PATCH v15 01/16] asm-generic: barrier: Add smp_cond_load_relaxed_timeout()
Date: Mon, 31 Aug 2026 13:22:36 -0700
Message-Id: <20260831202251.305046-2-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260831202251.305046-1-ankur.a.arora@oracle.com>
References: <20260831202251.305046-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0109.namprd03.prod.outlook.com
 (2603:10b6:303:b7::24) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CH2PR10MB4263:EE_
X-MS-Office365-Filtering-Correlation-Id: dbc02fdf-7f4c-4560-6281-08df079da35c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|366016|6133799003|3023799007|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	oGfcxa25+hi2fibKcAQBa+LbKZ0Go3oOaps/4iB5uPRVx6oq0dBWV/4wMl5aEu09N25f6ObtcQCxNze0sAZd0XqBQSXTGYeokLWWwOs52+feieKG8xb3dYN7fopuniJBGA/+8ybSAfxdACtdwz86dcuJr7x17bt9PNDZ2gq+xjGk5ce1iVgNfeSuijst3u8JWpDMp2jcA2w+rrROyKthXpiUSpUVcIjkd+bRSOg06Au2ygpjPo1/57dR7+AE1F8NlO5FTvJ5mDRpLSnkk3alxcNb3xh+eovBAjARxfqcxeTKj+kn3EpG8qCTmtvq/umBKxkDVaKY49zx2MemLX1Phylo1RrSRq2ZGXtHspR36OlzDoYgv5dxx9cFJQ8FrdDUnt9V+np9q+alo5OXzG/ogbWHMwfCqKiRnPUnHb5ZHZJNoniziMi4GCKHAXXEpD8WGrWma6BuxE/8xhlZOGlzd8Ikwkfc5NneA0O3l4NYG4ozjKorLIR8lmLcPORqAbYDB7dT0MY2i0iI5z3jxjHLecbhdyL067K1n/GBDpUOoWAeUcrwI0whAX+WIMTCcvgIjTgKRI3XU9dNHnqR/gR023zdkMaXArY7rvp+7E4DgjWdK7YXx8vzynsxQDMFpu/UmJnhbjSXE1VFzAvmOAlqV1u40sitrZUC3ZTbqO6oNc8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(6133799003)(3023799007)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bnn1BLkGEklveBE6bZIG7MsaUMwgvprUD3e4ya4dsPTTvJwm3ekIjLCnCmeu?=
 =?us-ascii?Q?Qq3/5VZ0rECAa2T3x2/jIP4qR/p+5rQE2A4RP869bajLif8JeZ1VOr0qzMso?=
 =?us-ascii?Q?xJr3FUCbeeUsvrNBL8YlzC1I4fLiTHJPAtltYsGQMyaNYz7x51rQpoVweSVM?=
 =?us-ascii?Q?SRhH+0uV+lqMKqS5Ah5uRDgT+dZhC4gq22gFjZ24PHIMSzilML6ccgXoGxgB?=
 =?us-ascii?Q?Fuami6Zhk3SulJB6M7emQJoG0OoHLH/gohaJYRZMzA9zetvADZNGdc8Ak9pa?=
 =?us-ascii?Q?Uk+5Uh+HRwNJouTir96u8y6gxT8F6B3FIyxpTp4kSy8UQSzuaPTJ4cIVjFFA?=
 =?us-ascii?Q?tYeA0L3ghe5J3oUGenufdvTiwID6IHnXSLr17yd4mZXRZzC24fGGBiSua3zl?=
 =?us-ascii?Q?tRECvmb3UkIH8N26LNdxPaKYcIl1abocKb6oREBNSqWIkeFiMyT8tDp9pzSm?=
 =?us-ascii?Q?KdjcxsW9BDbio/K2BXHVzWg4i5JDDHcpUN4bwNM8MrltfwchRJ4QDIsoNqOz?=
 =?us-ascii?Q?7IUs8P93vhMQyz/RqbmwuQHC6cWkJTZKVT37lRacNvQY7kb2curbHvupAPku?=
 =?us-ascii?Q?8ouqlvIQnEGke5ccV7p7k63jbJk8XzoTY0y590CViyuyWHf0DpXkDTzT1ZNd?=
 =?us-ascii?Q?Xu3hEtz8pPLa6WMNqW2XvayFyvPrKlEuax2qjjn95WBM392gOVWEe17cZAIF?=
 =?us-ascii?Q?HbEvyce9Ax1fDZ1anm5+/zCUtSPq4fX80r3p33+ueUa0IeQ3zLSCEb71xBFg?=
 =?us-ascii?Q?hxivU61C1PT06izLegGsI28n/vVpA0+fJywBJ0ngUtWNP6G/g20U2KKO10NZ?=
 =?us-ascii?Q?P3L3DNwlCt4mt7wXa2WSQ8mWzEaouPzfuPVj823Du8tFUO7Tj7R6jRRtTaC3?=
 =?us-ascii?Q?3tzGOQ4TNY7p9zM8VZgjLRi+TX/pdG7lif/K/KoYQwh5fNMIaXCCAA22mDKC?=
 =?us-ascii?Q?rAOLuRvD3sfV5BLvHafeU1K51nu7B/zABv6uDkgMVgiAXBD7QeR8/vFrBP1i?=
 =?us-ascii?Q?OoZzMdmaLiraHcwMxRNUk/KlReRiGrH0hs9w5A/YghKrYq3IyLLOOZsI9K0l?=
 =?us-ascii?Q?9BfKaKSsjl7Xh2s6mE6NJFH3fcqjcsMXz2WGPRSsS6vC/0cHS+sVTQV9tOTF?=
 =?us-ascii?Q?Bz0ww+qXfDsMH83PCpt7eb3NPb3BqA21BrYNP80ZFyhPcyscLzl5YBXTNOJc?=
 =?us-ascii?Q?kDw4Vpqe54amEAVrO1/6n5jC1i6By0EyyQ4PPhq+ULRTJVh88716ezntTogf?=
 =?us-ascii?Q?PRuqifZn+AU+5UJz+PRvNm0u/VXgA537tTbczytSud3q0HCoeDrFvn8AFujN?=
 =?us-ascii?Q?WDFTWC+mGFAeVgJj8ivx5PdRrsjQ3Iki62qapriZCzkUHBcLRUQ8VXErtoX0?=
 =?us-ascii?Q?fLkIwUVrrmBkp5I2RoZADZFiAkNWcv5VWHBMdLJ2wCh52xafeqcnQEryV7Dc?=
 =?us-ascii?Q?2K7L+ZgCFIjHXjgUXTUX1PvhjQWW9uHD6/scc9uJiqCbD1KCfzPaH0HjoB/7?=
 =?us-ascii?Q?WbKqXJQxxdkH14lVizrAbp3AXm48B6pPrYdCFrbtv0jwQM2Np7HgkkFknoLF?=
 =?us-ascii?Q?P5zAr9xgLmPytzlHz9SFl/ZNnMSd40ZCoZODNNgOG95qvQOt5HO2dBOOmlRw?=
 =?us-ascii?Q?ImMYZT8ivC8EC4OGOIeVl1RE5jLBuF0bnYpfua/PWZ5j0wFVYBdoHI41mxIi?=
 =?us-ascii?Q?bmEqoT2foURIHcxTVVprLRKNnFsjjslb1TFYlrp3ZZwLqNPyjMz6KDEgEr1O?=
 =?us-ascii?Q?sQ6svf7JXonvVcANEoTbkajsfOOR6Jk=3D?=
X-Exchange-RoutingPolicyChecked:
	ZfXr4YRr+DViByaJIrV9Ln2ibEKIk58MgVFogbPxTbCgKFCYEhGvKUovZXmpAY59y9oCSibuDmso6c1NyrHYFLHDOxYmZcWPU2s/vGrv7uYYIaMkh7Q+uEIBrtrL3SPuOKv9MaLggbMtObYHlZ+g+liCMDBH816bKxmZig3dAEXjZgoIYWckeIdF79mM8iJIW0dHdrjIM/oZlsfcdQdHBPM7/RU3cT4tum/YU+W1nGv5ViJefXIdhpdHugA+6vpz1PkcHzN+p2CtWSDn3HmM9xPVWp89CxQA5SB7pqG+MyjS5xQS4v6ZFttklzU5lzdvfk6zF6XzX+qWz5oDnMRQaA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dAeA0bRrJZ8i1z5cSfVMfQB2Fz6+dHlBFMUeCKTcETS/2THI/HVu4eMKvPpmR9OImNhJ+i9YHcN7lbGz+UEzXErSNabEygruJzVz97NRt7WJQwtnmjzbfROwfrTj+1ejitgjvfzXhhF31P86ZgrHsfyFomh4jndCW40Io1yN+ErgkF4n99qoI5OM4y6g8o/u01OhOAQHORj42fNCcO7fUDmOV5x2bnk1z33PVcKHYeEZFlxlVL7FoMIMK0XyJc+aCF4le3HHwfWOBjCdoFSYBiayQUlFljAGf5o9UAR2UsN3ExUxLjZJbXGH32caoLqbzVPoj52Ztd+UlxMfeCDR3HQtAKFDQeOPvK4QA1cBDbeIJnFM5UCoNyKFjJ3+CKwxcyV2NSUBDLQX+csPp+rIgcYmLu28GqkMwC2UOUFsvLYdj35qbZbZ80u/rgJ1GZzpKPelQN8XwW3k3RUM/cMootyozwg55/kszRBOHKDUlmv4Moo9KNIDZRpuHxpKOuZrI284ROts28eDZ2S684ht9393ieXr7qZXW3drqtWBJcQ0gugZM/F78fbeJJ+U09ZgG7rjrGASRF6YK9yNZ5Af1ircB8I6OFNbOmFlKMvJEqQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbc02fdf-7f4c-4560-6281-08df079da35c
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 20:22:54.3423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yo2ZY6DRz0mPIQBfGNKHZlm7maMZz8X2BqUg0K/J/GlPT1E0aCV9Eh4HUiu5ywqGWLaokIKL5bAqC1k7jm/+tjhWP7T5pcAiTx6vVgs5MWY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4263
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_06,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 bulkscore=0
 malwarescore=0 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2608310176
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDE3NiBTYWx0ZWRfX+sH6K1GCKd38
 bHSKvidZoy/LXC+6drTAK+wdyyfr1G+EVU6x6H6dns7dxK+lDvElGaOu41mdtNm+TraBkuxmLbY
 cIf3whuoQ/IQGV8c2DAyOTwrbjLOf5ZINtyDuqWdBcwqPT2X19ED
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDE3NiBTYWx0ZWRfX/3/X22+bp+oT
 vvocoSQZY/UQ6yhDwYKXwa9RbwAQUiCmnEHBjcj+LBVaBOfJ4oAY7jG3Ip9fyJuJcBj/QYUKzu3
 rvVlMi7QITo3lh5cv08pFqj+TTZbQdrcBBroWW7U3aebdgJZ5VpOsex0Z9qn3pJPjU/PdH9QmVY
 kQnQKlL05WEFZFYvDMm4435vvrMgv26O+hdCv3OI4z7jqr5SEnVDOVblpHMVtFu8hK/ShQEFTo1
 W+Xn6M3l9MkClksPLurZnS3+pK/mOT+Ot4yGjOS5MkoJfDt18sG7RSHYE13O3ImFOMSQ1sxpo4/
 aFILzBs9HPpLhp7aAJRTsdAmQywwe8JxUbgQ9N6JQlIjBu1lhv2j9I6wepVCG1aLZ5Ak+EzFu0/
 wHGOxJ4TCSKLXkyV9KowiSroHcKKYbgKCgQz9aJeaW05yx19VFIrYz+I+n4mje+bwgHp7pSB2iP
 GmqhxxFrQ8taS6BSHog==
X-Authority-Analysis: v=2.4 cv=G7os1dk5 c=1 sm=1 tr=0 ts=6a95e2a7 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=o5oIOnhZENCTenyL_yNV:22 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=JfrnYn6hAAAA:8
 a=yPCof4ZbAAAA:8 a=xjBfvZVMSjtnnSOzluoA:9 a=a-qgeE7W1pNrGK8U0ZQC:22
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-GUID: TNrERx5QEyEQ4xhjzW23Y4qgUx9E702b
X-Proofpoint-ORIG-GUID: TNrERx5QEyEQ4xhjzW23Y4qgUx9E702b

Add smp_cond_load_relaxed_timeout(), which extends
smp_cond_load_relaxed() to allow waiting for a duration.

The interface loops around waiting for the condition variable to change
while peridically doing a time-check. It uses cpu_poll_relax() to slow
down the busy-wait, which, unless overridden by the architecture code,
amounts to a cpu_relax().

There are two ways for the time-check to fail: the timeout case or,
@time_expr_ns returning an invalid value (negative or zero). The second
failure mode allows for clocks attached to the clock-domain of
@cond_expr --  clocks which might cease to operate meaningfully once
some state internal to @cond_expr has changed -- to fail.

Evaluation of @time_expr_ns: in the fastpath we want to keep the
performance close to smp_cond_load_relaxed(). So defer evaluation
of the potentially costly @time_expr_ns to the slowpath.

This also means that there will always be some hardware dependent
duration that has passed in cpu_poll_relax() iterations at the time
of first evaluation. Additionally cpu_poll_relax() is not guaranteed
to return at timeout boundary. In sum, expect timeout overshoot when
we exit due to expiration of the timeout.

The number of spin iterations before time-check, SMP_TIMEOUT_POLL_COUNT
is chosen to be 200 by default. With a cpu_poll_relax() iteration
taking ~20-30 cycles (measured on a variety of x86 platforms), we
expect a time-check every ~4000-6000 cycles.

If a architecture provides a waiting implementation for cpu_poll_relax()
(and signifies that by defining CPU_POLL_RELAX_WAITS) we define
SMP_TIMEOUT_POLL_COUNT to 1.

Lastly, config option ARCH_HAS_CPU_RELAX indicates availability of a
cpu_poll_relax() that is cheaper than polling. Long timeout values
might not make sense for architectures not having ARCH_HAS_CPU_RELAX.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
Notes:
   - deferred time-check is now limited to a single usec. This allows the
     fastpath to not pay the time check penalty while ensuring that
     architecturs with precise waits (like WFET) don't end up with a
     huge overshoot.

   - smp_cond_load_relaxed_timeout() now checks that timeout_ns fits in
     s64. (This is kept as a wrapper around __smp_cond_load_relaxed_timeout()
     to avoid cluttering the core logic.)

   - SMP_TIMEOUT_POLL_COUNT is explicitly defined to 1 if the
     architecture provides a waiting implementation of cpu_poll_relax()
     (defines CPU_POLL_RELAX_WAITS)
      - this was the only sane behaviour from arch code but now the code
        explicitly encodes it.

   - __smp_cond_load_relaxed_timeout now uses prefixed names to avoid
     any possibility of collision.

   - minor language changes in the commit message; comment block around
     cpu_poll_relax() and CPU_POLL_RELAX_WAITS

Catalin: the changes are a significant number of lines of code.
Though IMO only minor updates to the logic. But I didn't want to stretch
your R-by too far. Could you take another look?

 include/asm-generic/barrier.h | 106 ++++++++++++++++++++++++++++++++++
 1 file changed, 106 insertions(+)

diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
index b99cb57dfccc..4437d27c46b9 100644
--- a/include/asm-generic/barrier.h
+++ b/include/asm-generic/barrier.h
@@ -273,6 +273,112 @@ do {									\
 })
 #endif
 
+/*
+ * Number of times we iterate in the loop before doing the time check.
+ */
+#ifndef SMP_TIMEOUT_POLL_COUNT
+#ifdef CPU_POLL_RELAX_WAITS
+#define SMP_TIMEOUT_POLL_COUNT	1 /* Wait mode. No need to poll. */
+#else
+/*
+ * Assume that cpu_poll_relax() provides a small blip in the pipeline.
+ * Combine a reasonable number of cpu_poll_relax() instances before
+ * doing anything substantial like a time-check.
+ * Note that this assumes that the rest of the loop (largely evaluation
+ * of the loop condition is relatively cheap.)
+ */
+#define SMP_TIMEOUT_POLL_COUNT		200
+#endif
+#endif
+
+/*
+ * cpu_poll_relax() stitches up two kinds of primitives: ones that provide
+ * a momentary blip in the pipeline (ex. cpu_relax() on x86), or ones that
+ * support waiting for @ptr value to change, coupled with a precise (or not)
+ * timeout.
+ *
+ * We keep both together because the objective is to minimize expensive
+ * operations while polling on @ptr waiting for it to change. Either
+ * version allows for that.
+ * The arguments (@ptr, @val, @timeout_ns) are only needed for waiting
+ * implementations.
+ *
+ * Note that platforms with a suitable cpu_poll_relax() implementation are
+ * expected to define ARCH_HAS_CPU_RELAX.
+ */
+#ifndef cpu_poll_relax
+#define cpu_poll_relax(ptr, val, timeout_ns)	cpu_relax()
+#endif
+
+/**
+ * smp_cond_load_relaxed_timeout() - (Spin) wait for cond with no ordering
+ * guarantees until a timeout expires.
+ * @ptr: pointer to the variable to wait on.
+ * @cond_expr: boolean expression to wait for.
+ * @time_expr_ns: expression that evaluates to monotonic time (in ns) or,
+ *  on failure, returns zero or a negative value.
+ * @timeout_ns: timeout value in ns
+ * Both of the above are expected to be compatible with s64; the signed
+ * value is used to handle the failure case in @time_expr_ns.
+ *
+ * Equivalent to using READ_ONCE() on the condition variable.
+ *
+ * Callers that expect to wait for prolonged durations might want
+ * to take into account the availability of ARCH_HAS_CPU_RELAX.
+ *
+ * Note that @ptr is expected to point to a memory address. Using this
+ * interface with MMIO will be slower (since SMP_TIMEOUT_POLL_COUNT is
+ * tuned for memory) and might also break in interesting architecture
+ * dependent ways.
+ */
+#ifndef smp_cond_load_relaxed_timeout
+#define __smp_cond_load_relaxed_timeout(ptr, cond_expr,			\
+					time_expr_ns, timeout_ns)	\
+({									\
+	typeof(ptr) __PTR = (ptr);					\
+	__unqual_scalar_typeof(*(ptr)) VAL;				\
+	u32 __scl_count = 0, __scl_spin = SMP_TIMEOUT_POLL_COUNT;	\
+	s64 __scl_timeout = NSEC_PER_USEC;				\
+	s64 __scl_time_now, __scl_time_end = 0;				\
+									\
+	for (;;) {							\
+		VAL = READ_ONCE(*__PTR);				\
+		if (cond_expr)						\
+			break;						\
+		cpu_poll_relax(__PTR, VAL, (u64)__scl_timeout);		\
+		if (++__scl_count < __scl_spin)				\
+			continue;					\
+		__scl_time_now = (s64)(time_expr_ns);			\
+		if (unlikely(__scl_time_end == 0)) {			\
+			__scl_timeout = (s64)(timeout_ns);		\
+			__scl_time_end = __scl_time_now + __scl_timeout;\
+		}							\
+		__scl_timeout = __scl_time_end - __scl_time_now;	\
+		if (__scl_time_now <= 0 || __scl_timeout <= 0) {	\
+			VAL = READ_ONCE(*__PTR);			\
+			break;						\
+		}							\
+		__scl_count = 0;					\
+	}								\
+	(typeof(*(ptr)))VAL;						\
+})
+
+#define smp_cond_load_relaxed_timeout(ptr, cond_expr,			\
+				      time_expr_ns, timeout_ns)		\
+({									\
+	__unqual_scalar_typeof(*(ptr)) VAL;				\
+	s64 __scl_timeout_ns = (s64)(timeout_ns);			\
+									\
+	if (__scl_timeout_ns < 0)					\
+		VAL = READ_ONCE(*(ptr));				\
+	else								\
+		VAL = __smp_cond_load_relaxed_timeout(ptr, cond_expr,	\
+						      time_expr_ns,	\
+						      __scl_timeout_ns);\
+	(typeof(*(ptr)))VAL;						\
+})
+#endif
+
 /*
  * pmem_wmb() ensures that all stores for which the modification
  * are written to persistent storage by preceding instructions have
-- 
2.43.7

