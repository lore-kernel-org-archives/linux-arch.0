Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308C2419FDC;
	Fri, 16 Oct 2026 07:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792134611; cv=fail; b=s2Wl2Pp3maD5av5SGB4JSDbhN6KzJxFq/4sFRosAUNYN1+kAkb9ThpeQWme8ggRzvcw5YlS6iEcoIjWkeOnvHXHvKhvZlUHUQNcnfJWMBK/O9b713N3AQcK1cSNZicHaOHJ6hLxbHGNpHXqd4akv/Kg65O9P1sqE1x/XzQv3eEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792134611; c=relaxed/simple;
	bh=ioGrdvi/qPlvtnTF+WSatAhSq3aqi83y1gGQ+WNTYPc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EXvwJGu7hs3YTZ2SX73ztWe//FiA+xVWje1xRLC5sec+We7A6mcdJCVbiv2K3bMJtOf4pw3RrOrhU9NdNiFR82Rp51niepptjHUdseTTk3znzANtHYDwAZ/0kRnvBfod3uvQFh+7UNN2xDsBxoRGL3MuBx0c+46O4TbzhdgJ1Zs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eRhXQnTH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WbVPBOCA; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eRhXQnTH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WbVPBOCA"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69FN6vOJ1814089;
	Fri, 16 Oct 2026 07:09:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=vC8OYrtwjBrcoEx364f6FDXrkGBghos3INk/Ue8Yw5o=; b=
	eRhXQnTHccjPVqVxSfhnQPeCf+vAFw9HrkgCYohCxgLNC/5X3Nv1Hn4pxNW8flkO
	cUaFXiOCXm0GCfrKrol0CShgGijxRnvo048r/yRRdWB2+CMHRKyIVc/PeR4OwEOq
	wB3D1dJ72+w1hjg7vFgIDQJzaEjQjLcIEnjGrt16Gp7CsJgO48k0VxlReq+SpXxR
	8iDLvuSUfEG+GJC5nMwfYLyyMHg2IbDPur3rmAcy4/5BeuxoUXR2W5E5afoDcTiv
	BRJHSQgbneVBqHYaktVQPeK2jTbOv2TmbGwIS0OjV1gNp9Ss+nnEwFnoZy0HVwyT
	5yCWouj27EQExGbYY14qng==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4h7demsfuh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Oct 2026 07:09:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 69G76CQE027851;
	Fri, 16 Oct 2026 07:09:39 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011014.outbound.protection.outlook.com [52.101.52.14])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4h7btd3mnv-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 16 Oct 2026 07:09:39 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JpSAoHx994syBbxNDwOHBk+kZkOk07pVpSaldVbLD/uW7HcXXfoTPVFS8vb8bd953OUMM/4LRaa2zGTg2Xc9aaOWeThR4ryv4LL03A1sI8SSkJ0kpYKBuE08NyICzIhju+wayCqz/sUmaWHPJB8S8914yXmA1E1u7mQ8VqhDxZNzI56oOY2I53CY6zEKYqMpNpHhN2ydOy2JeBW5YXPC+ZVsJU82R6IUWz5g53pIymmMdbU/zMC3nyFoGrAPAu7EuaXbaq5cf+HxV73iQ5CYjkpfbCfnBa3DcpHzRwKDpertmsyF9/DUNUBVH8N5gCFFGgs8tDs2pYv+xDCls3UQDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vC8OYrtwjBrcoEx364f6FDXrkGBghos3INk/Ue8Yw5o=;
 b=lRoUtxfxlWVVrPurn5vxzwZn9XoS2SXOC34hteaeua49BHOElEzQAhjvwR1JBACuN8yq644tBZ2FWm8w3HYn+U65DfDHfOsapJyYnk7k5rWpvToK7GjIykcpHY6eMYfeQay5M1LJpIs1doaXhuwu3wAXVuGtOLU9WPjTvdWdHB1PYsDtCkmX5Qm1NJ6d0y5MilG5bsS0iKZ04GAO9BH/GYklI9pCiy5+KPwfMZclYThfFgfydEkMhNIuORKJ4ECGSscDz46bNqCgB9Vuwdmaiawyl7dhkltYFzGeWowF/sOBQ0HDGwzIYruobLnSqf7u2puQjzvhKU/ez3iX85zZCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vC8OYrtwjBrcoEx364f6FDXrkGBghos3INk/Ue8Yw5o=;
 b=WbVPBOCAAfp8e0X1gF+6qXP2xKQWzNLmU2a+ay9Yy9vZ6nANBD5SnBEMFK3L/SZDrl64PSGbLRp4tgF+Fu57wD+dBPtRml3gpLJ+UdCYZK4xC2F6z0roPI/sPtyDnxSwCAN/ZkvTdHtPaQ9YSMDtXbI8fLXChIHzAzNtS+HH114=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by MW5PR10MB5668.namprd10.prod.outlook.com (2603:10b6:303:1a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.7; Fri, 16 Oct
 2026 07:09:35 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%5]) with mapi id 15.21.0546.010; Fri, 16 Oct 2026
 07:09:35 +0000
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
        Ankur Arora <ankur.a.arora@oracle.com>,
        Julian Braha <julianbraha@gmail.com>
Subject: [PATCH v16 14/16] barrier: add tests for smp_cond_load_*_timeout()
Date: Fri, 16 Oct 2026 00:08:35 -0700
Message-Id: <20261016070837.440748-15-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20261016070837.440748-1-ankur.a.arora@oracle.com>
References: <20261016070837.440748-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0039.namprd03.prod.outlook.com
 (2603:10b6:303:8e::14) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|MW5PR10MB5668:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e42ace4-83c9-4c50-4e75-08df2b546f1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|7416014|56012099006|261009223027099003|22082099003|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	0p13zqewtHBVFIaceAK/F5Tjgt+U8kKi4mn1/InKsX5CZr4IKhuTLEl0nOFfwz1gLc+VLlA1hE7LeVZrySErk9PBx6cXqYVE0qBIdDMePTpI3l2F3eEL1krFnFJ2W1EHKkg2h/OTqqGyHzUeN9aZdz6jZgx2mmMZ/OoPnRRahF9PAgfG/8zbSbC9novlf3zc1CUqoxL22Awx4r9H6P7S5yqAThh75vZtHNv2mJa3egj6P8BohIOVKHU/yr7BUUP8MRNAi7GGQgLR/vFzLy54vlwitM62YUWChLv3uqKdT7KDXtAkoStkas/js2MoDlFcWrDEuWTQa/1fUI+mQ0E+jNN73dBMtuif8u+ADIKaQRaogtjBBq+4Yy69zWwIzae0Df58YrguN+b1Y8Y/vzoCavS8A2+gN4rTCxn2NPztLo9m3tHo1fdHU/AkXkI5J40NbnX6hhjDA3V4VNimknFbEbp00Go1EZEF9WTyp+b8PnkynYJMbHg/qsujewtWObmCKSPGjCBFd36q5NqaywARhvmHOw4VmUapkAbu5kCNnPrpn4tYrYpmK0DriqA1E0dff8vHgSeutpRO8CVSDXro5lnPOCo2Ivgv/Hii8QE0YbOgRXZMSHYk4yrqzzRDzrXGt6ZGX9dzh65PyqMvssAXKavtLqCDX863cRpyltpqqnk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(56012099006)(261009223027099003)(22082099003)(10067099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wUiE9lG18DM+ERhF9P7bLEWbI+TLrpUohHGZG6bbYXGItn/ra56CN58Jh/FU?=
 =?us-ascii?Q?tNry83T7dxwifYkNU3Tch0966cCGiQKW7cJmpG4W4U3Xn5tRe+7Vb0t53DDz?=
 =?us-ascii?Q?0NguY8vUzJxEQRmI+w5X+9ec1MG+b7U451be5oUr/UZ8Xb+5if8QzosnWS6J?=
 =?us-ascii?Q?jY6yAPj725lHlNJfdRh5u+JF2mXwVYqUqYc2XYkU88h0OKHlRmJIupAkD1e7?=
 =?us-ascii?Q?CNORNdBtEDqGbcVGFRh+k0TdLw6dT5V/jEcAwhJ0KxaqO1bsf1PqtYRNBHNt?=
 =?us-ascii?Q?oZMHWFLY/wRHsuVHgg2VZWfCXsCL+BD72OVc3nlSNM5atZT+lI7qMFzalwYA?=
 =?us-ascii?Q?aGdnB+3TMRnYsLa9URqQ3kQL8uFDwlNeTKSdNPAp5QGo9YPpwq5tDMFKOwmo?=
 =?us-ascii?Q?AEt+IqVUVa75k+xW6MXZYIaPEZQXfRLb4/8Xltcg/YhhktZ0Z6mTg4E4fNdb?=
 =?us-ascii?Q?LMNSEhiKA9TtTM9GQzKwA3cHvdiQEh4spLHkMFKhT6JsSqNdjc4p8a7VzRbU?=
 =?us-ascii?Q?buZYLlyng9xTYzdgSDbk310gDtwIIfd8WxqBGuc4cpAyDI8OQVLd9JJtuEWE?=
 =?us-ascii?Q?o6ISWlaQzNb10feOv8KR7dFa4+XanhBKXRg6uvEs3odCPKZsKPqTI1UTe5V6?=
 =?us-ascii?Q?9I0ffTW9/bxxQS2wRtzdqaQwicy6t0n0BFxbX8nFP7a3PoPo/h2NYkfSECuU?=
 =?us-ascii?Q?jILc9ugycS7lEEJU1tr0iTFJNso9FNWWU96LYCw6tv7FDWlinYtQtg3jWauQ?=
 =?us-ascii?Q?J8MKGIbFtbQ4LmIXfB+H8r0OL5ixFxxr3zSUsWNGMzcYHdr6KefEuugHkv2z?=
 =?us-ascii?Q?wLKh+vYuRL0DyqT+JYCyVQpBN0RtUIk0pXZA69R4SzMHl0GoGg5l5pUjslBH?=
 =?us-ascii?Q?WJbojUpNg6+Grq6ITojHUTyKOWe8yeWB1nf4WfLgC9huz/gmIBy5GPIHIiOl?=
 =?us-ascii?Q?hRPUSU2HXs+ktg+Buy64+r/9PZgUlRvVagIe9tFqkA+1bCwunSa7+7isnd07?=
 =?us-ascii?Q?Sivs0+hcfo+aDq8fkZ5z65LIEW0BQBRyQ3kgxE94VWpECZvJUkzfZ1O7Ss/D?=
 =?us-ascii?Q?TBkb1lKoP+3J5FcMKpd+XGZr6vzR3MtwGiAPCMzeobuuUpv6DWLLDbVfRfOA?=
 =?us-ascii?Q?0K2ja7sek0qCF/1763xeYREtdkbThXS2pr6ykVXVON3jL3UNEzwO5gZRqkNZ?=
 =?us-ascii?Q?6kp4FdHE5fjsp7o35ikFRS7CLaBYJ71l4h98J29Luw5EmSFXmIpUdqI0xsCl?=
 =?us-ascii?Q?nQWKu0AsSpkcdIzInxpiBCDfnIETxk2eC39dKh+HHQRWhmjn8rS/t2ZxVwJ2?=
 =?us-ascii?Q?kIx24imypBB0BVQ/u2QbamV7cq6xriqhvuMRBwNq+UmJPilDVw7WeMd3DAZf?=
 =?us-ascii?Q?/GRV//AeaoInPuqphTmiQ/ogFJYAcuNLetwoDorvDLQKxbgTAEKq0os4daV9?=
 =?us-ascii?Q?j4uWI3gqiIRBOwcLfWLe6KFRQTjtGL5b787cMxsYZM1stplmkPNSHzIZCLFK?=
 =?us-ascii?Q?qJzNgKlvCxgouqVGz0QIjYueeRgwZluNBaulov6m0tsJuD7oNWfjrs4mVKVR?=
 =?us-ascii?Q?7xKE6xYs0jlH8SbIHD4yZcBXuYlpWGthnjLUUUFhNGr4eUr8uIcvCc1OpkBi?=
 =?us-ascii?Q?p56wOm4ofLm9Mgzh/uAnD6Pd+YLn3/zse1unA0MB9CUqxEhoPs6UteSco3MH?=
 =?us-ascii?Q?TCzgTr3AwKoF5tt6X2WKvbn5c7Qtoceo7pNgAuy33jEYJFDMfrguB/XEVkJn?=
 =?us-ascii?Q?sNNYEH/SFCz0xkXQc8k6TKI/2/REqnM=3D?=
X-Exchange-RoutingPolicyChecked:
	WLqQLnwkdQMLU+HbMj3nipdPQ1o0CaIA+AHJqzrWIMAOgGUC0T51CW/nOB+STFP6x97/+GS5FaFeEUzm6WqFhc/tbO1dlK9QI+c6l7dVh8sjA9tFlRLUsMmlpsL+wzVjueM9LQFxk1dLTeLD5r8kaXZUphBaNDukYFMBm56F2jwrnLPMQUk2i9GJG2qCQT5CPUHzW1GnEy4GLQXHYngHE4lGl0UscPp5pRquabNXsBbG3jpOyEPGjW9YVABUGJs3WUCqNkgnpZuxITaeS9T25Vr7OSCaur38KWu4qR95LP/bYsewicMRQL22kCxNv3IVXtK2URXu4zG94Vec9cTS8w==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qXZXdBUWBqYtlsE2PpCGH4AcnT/XHBg3QW65A/NPoL0zU5i+rSZ8qjbgmYy/i9wHryBGDGdDsMoJvHFHGAyRQonC2c9TEAw0F4hlKx3dmsDCH2PfxoiRI9fMSuDGjlSIXVf+oh87N+6LAkfVoQNSIrXxoJOdPQnJKqJB76IymNlaUF3xI7liYL1DBrJG5ql/EwDvC+ZA6v1AADexZyQ6Qm/n/3MCktDpUQ9Y/T9KvQ/+WD9gX+dlMH0hvxJ6aMUjSlvghE+G1P7zyHg/JhHXD8z0FYWlLmvRhSUvDTQ4TeDWCU3IaDAnveeboywJxrvqNfMEavuLFXV4dQWZKY/2LtsmBIP0lMrjWo/H6ieWkojf4+rZJS8lKU9D6DZRi9QyuneTo5iOsYP53fyKliZsgx56Sgp3lE9RW0kP7GgLMQcD65IgxGOQlaQrvCe2AmgkG57Hzggi55imUR8pnSjF136txiLyd+6bkm4MdXD/1Cbw8p+KhqEqworJQ7fexRbf0vY9XGZhOnSXZAHXHMbh5ZYJN6srR/SFt2kWy5iaqpG/tfR5cXjVD125kKA9EREU9bRf05ycqGMvKfxNRCJBdlbYIbVf6MV5XjjPx8tviSM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e42ace4-83c9-4c50-4e75-08df2b546f1d
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 07:09:35.3093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jkokwj2w7+FSgt21YkhX3CVBMMxDsVrUIcNlDMctqVOtThbOBNbU9CLggtxizq5kNnYewVvygp7t1kMblCOGoleMOVOZ88IN5vwedgT3rZA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5668
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 phishscore=0 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2610020000 definitions=main-2610160028
X-Authority-Analysis: v=2.4 cv=CoEq4X4D c=1 sm=1 tr=0 ts=6ad1cdb4 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=pGLkceISAAAA:8 a=vggBfdFIAAAA:8 a=yPCof4ZbAAAA:8
 a=RKR6g2HLBOl8dGFUrsIA:9 a=WmVTiCyuxqgg3mnwYu6p:22
X-Proofpoint-GUID: ExvmIUrIATklT_3EBi88ig6Y1NDz3lrL
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDAyOCBTYWx0ZWRfX55cZT6PIMjJu
 txarr0XClAtdnd7J9oEyUpJjpBhlranXzMaOlWLOitVbT1Yjzi7fk6o1KInPd4HYx9GonkgrChY
 KYPFoKl1edEOGej80aGA5EbB4vhOUcDvBG9RfB7kljjRz75qhR6A
X-Proofpoint-ORIG-GUID: ExvmIUrIATklT_3EBi88ig6Y1NDz3lrL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDAyOCBTYWx0ZWRfX3PwYyOXxi0bk
 gvF2Tcv+9wAKolxYr33tSsBw/le+GaX8FYkAGYrUTe2St2yC3bO5YloaLSVuIP2A6cWecI2GJne
 izvXA9hr+aTGptCQyKFr1q+bc7p+gnVrsCa4CZeZAoCCYU7fYzNOFgDFrSeiofHuK628a6kxgz4
 nIKQ5tuiuvKYEIJyxOfkgFoto38E5t19h8S8YIVUaFaQ3vZQHotuuSR3U1wky4wUMCuXlhdF7qr
 QWvmJPlyUOxIi5CNK+JQgAGZ5fHaZObWfWx0YsRVHlV8Sa57Q8YlgkWsXKxZoZ0HIXLD/E5AQSv
 ZxEUBIng+p4+8pHzRQ9OyTEGh/vmlw58+rIm+Job8BkwBfQ6zf8u/umn/hNI6ul21CBsVQ+PX5V
 s2bpiZMytMWnDn7SRpyMEqbxmw1NKuUUPe/CMa0SEsSc1J9FxTKg+QcSsH4cv4pnneG1Tr1B3Zf
 tnBOMVoDpQfg73Dt1XQ==

Add success and failure case tests for smp_cond_load_*_timeout().

Success or failure cases depend on the expected bit being set (or not).
Additionally in failure cases smp_cond_load_*_timeout() cannot return
before timeout.

Cc: Julian Braha <julianbraha@gmail.com>
Tested-by: Haris Okanovic <harisokn@amazon.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 lib/Kconfig.debug                |  10 +++
 lib/tests/Makefile               |   1 +
 lib/tests/barrier-timeout-test.c | 129 +++++++++++++++++++++++++++++++
 3 files changed, 140 insertions(+)
 create mode 100644 lib/tests/barrier-timeout-test.c

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 6b24a2c89b84..672e1e920538 100644
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
index 000000000000..9c12cd36e7d2
--- /dev/null
+++ b/lib/tests/barrier-timeout-test.c
@@ -0,0 +1,129 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit tests exercising smp_cond_load_{relaxed,acquire}_timeout().
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
+#define TEST_FLAG_VAL	BIT(17)
+static unsigned int scu_flag;
+
+static s64 basic_clock(struct clock_state *clk)
+{
+	clk->end_time = local_clock();
+	return clk->end_time;
+}
+
+static void update_flags(void)
+{
+	WRITE_ONCE(scu_flag, TEST_FLAG_VAL);
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
+	s64 runtime, timeout_ns = TIMEOUT_MSEC * NSEC_PER_MSEC;
+	struct clock_state clk;
+	unsigned int result;
+
+	scu_flag = 0;
+
+	preempt_disable();
+	clk.start_time = clk.end_time = local_clock();
+
+	if (p->acquire) {
+		result = smp_cond_load_acquire_timeout(&scu_flag,
+						       (VAL & TEST_FLAG_VAL),
+						       p->clock(&clk),
+						       timeout_ns);
+	} else {
+		result = smp_cond_load_relaxed_timeout(&scu_flag,
+						       (VAL & TEST_FLAG_VAL),
+						       p->clock(&clk),
+						       timeout_ns);
+	}
+	preempt_enable();
+
+	runtime = clk.end_time - clk.start_time;
+	KUNIT_EXPECT_EQ(test, result, scu_flag);
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
+MODULE_DESCRIPTION("KUnit tests for smp_cond_load_{relaxed,acquire}_timeout()");
+MODULE_LICENSE("GPL");
-- 
2.43.7

