Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE212396B96;
	Mon, 31 Aug 2026 20:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788207834; cv=fail; b=uwDoSd/A/sBIgxeuzTf6LqiBHhAVoWlOtWksiTdhS62QToOjSXd96yDQwtht+qOzYwZDKbp1gzbvvdpwnu8u1+Y3PVOG0VdYNfP67L+gMvPOKRgvAPrlYzUB9wqzmC3ZiXvsijEKJ0GKJIo0FqCmjFKr4rUmdiT3wL9ecCqlzNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788207834; c=relaxed/simple;
	bh=Z510VhTG0QMC0ztp4hVhqLPdusKvEceFRuNqCDZn8NY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JCyT5rwP8y03vWCVoXdu4jOo/EKxLukykuW/Q+lhJS30oj8Jk1jk0WOQUxf8AbB114U8qn+/Y7TFto829Kx4/8TPo0yNJPVKeRXosMkeKETFbu0tzXD0OXkGz/cmVDRE/2JUZZRpPSmYgXb9/+MNDoShgNIPwGwdf11R9hMb188=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VQyE4Kk9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UmRrjHCG; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VQyE4Kk9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UmRrjHCG"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VGBo622165320;
	Mon, 31 Aug 2026 20:23:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=5e5DGnlTUUm5bqIzdpftnmcC+Hjskr8o+zCI/SxdWQs=; b=
	VQyE4Kk9fKCHlZkOsLYzwg61wPzPEslw1KtVUmFeYAPVWHDrK/gDDMdGboRDAWcr
	3l4pIJuDQ296iaiC14sRdOKuxIOPqRx6kxiJ6fnw+COwcCfGwnqCXD0BympZ7vCP
	zRjjI1JBvh+bR4opSv0xB3IRmG/WcKbBZKFzjsnybLQZoaQ8NvaH92LWkHIQ5gu/
	SzzQ9YpFoRSj2o6EvwdmY3aWaisHqK8FEO5HRfkIPvBh40U5A1ofHZwfXPcMB/RR
	VUicFCwEN4kxVgpdSyfVgz79E7T6RtI0qJkt7S2wr+zjJE9lw9GyNYxBPDPHPJp2
	6TXLlmJyCIHuNoH//RyCKw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gbqa7kbkt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 20:23:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 67VKK5W4033249;
	Mon, 31 Aug 2026 20:23:28 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012017.outbound.protection.outlook.com [40.107.209.17])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4gbnvdc4u1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 31 Aug 2026 20:23:28 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DaLxv96OTQeTrVJhGSzVa4VaKBmMqZhbSSBVGrsLlbCKZHbT39o1cg7h96VotVob4DwMly662geK+1OiZ8fmKUBOi/IdHOtMI/kqyuFisfhogz2bzXrVR/49ov7YZKE1KXsefO/MvsDU/Lr4CZo7YEEHIWKYh2OfXgY8i/8xALyIvVlNjxRN4dWRhqS8Ea2WnZSXxRX26aD9f06dV6MmVHJ/FGyt0FKVMQxkDZxfVSpDsbT5cRdacL7iuIlgqI7MjePN/Dq0VWnmqryekNo4FZSOd+azdtAbhK/jb9OP8p3dSLr8vYwORa58Bp1Vw8JjZpMnceROkvAv+WoPt5xnkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5e5DGnlTUUm5bqIzdpftnmcC+Hjskr8o+zCI/SxdWQs=;
 b=nvpHMasqpN0qmEpOEvgRJwzfQqXtUijdNcYVg0Nel+J2xQXRB5dzi9x85QRSjdm5dpJSdRzEVBbmxcCrXYRl1ng7y5IiEe4UHCZiwOypmZmofsjcD7HpQohuXgx6c10RVyPf/sEvwmVZB6Iw4HcWdP0E6LsjocwcwbYZw4dq2GufopHiOkYTaymy72vPqsax40Ge0ZuR2IJQyUkYk3FWfy1uO4qorLGo9QvhEwl+nvpIqiTV4JBMORDI2BsFhEuIBrKE4LQ0MHFDFVlCGucfSbx+ryErERU8E/QitofIEiNdMWz7r91KRJHk4T+eZZM0oYNDDCHL86dUaIW0KPjyQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5e5DGnlTUUm5bqIzdpftnmcC+Hjskr8o+zCI/SxdWQs=;
 b=UmRrjHCGMT16QVNMynDQiLcfKjUUM5Ie12EKmVOJN0ps6PALBDFXBWKRoCCE3jWNMZt0Rs+IgC1CN6pafBPjrQQeltI/5X2DN4aMbdBQZOmvvZF+qz95QWD4n7t3Lr4WG9r2MJ7kPKpw3EcNBbT4i/fWgMDVKNT84lBdj3kBGWo=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by IA1PR10MB964822.namprd10.prod.outlook.com (2603:10b6:208:5ac::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Mon, 31 Aug
 2026 20:23:26 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.21.0382.007; Mon, 31 Aug 2026
 20:23:26 +0000
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
Subject: [PATCH v15 12/16] cpuidle/poll_state: Wait for need-resched via tif_need_resched_relaxed_wait()
Date: Mon, 31 Aug 2026 13:22:47 -0700
Message-Id: <20260831202251.305046-13-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260831202251.305046-1-ankur.a.arora@oracle.com>
References: <20260831202251.305046-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR02CA0004.namprd02.prod.outlook.com
 (2603:10b6:303:16d::19) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|IA1PR10MB964822:EE_
X-MS-Office365-Filtering-Correlation-Id: 4441a611-54f1-4aab-163d-08df079db638
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|366016|56012099006|10067099003|6133799003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	xJ4/0Qrmvm0wSW0jz4uRkJcnikmxsmLedgCWHokpBXmAAzVhd+GFiPfrq+Kijcx/+SQzYtkoFpL1xnrEvbmKWEbiYxqZOAss/lvIHwevl8k0uCaZwprwtCbaiLa3tW6P5ValbvgJqOVVkYuAwj+2DuuNeJmPFIEEOJkkrBxyTBO5Uw6SURwDsL/VguPSrzLE7uuuWkQRYmHpsW7LqaysJMHa8/3JYTUJLq6TE1KHimVi/7Akmgp/9XrpYBuUpGjWY8iehcPmeO7z1BBLqtFfaCX6V9ZMv+mxq14ZOFga1q+3/apLLgvQZcjXEJgLK9zlvR13/KPZ3JSI2S+uE5MlMzgyJ1N2agQenXZ52Hvzzi9D7fseBNermljWTX5mgOR/jEMVJyDZj5PhK7DKV4rLh0NZ9E43zTo2aJdmRapd70jkmfR61gAGPYDthItQzT55765OSr3xS5Den4jeg3BXbLxU6zN/WbIT4srWF4fJFi9xc4WymB3kDF30nkIBt/oBj/HbNojrAy55D6Er2XY7IoV6TFeiL6xxGiyPMHij1kKSs+5216IcjHG9vUyChwPAZ3zvjJB3DUWahHNlSMofuQyHlrlxOE+0F+pRMGJEDQCibsKx4+xqS23eFFO7bh3Oc9vn20Uiw5fOuNK66FzQGf+wcXFUPuE4xr6/fiTpNhA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(56012099006)(10067099003)(6133799003)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+ASF/y7jJBAUDA8Nw3rWjqSOIuxZY7Tt0aPaGx8800/hG8VIpye+in5HS8G0?=
 =?us-ascii?Q?3f3lCdMIFQJ0Sq6hvCLttqiCy3KE3+a7adAD5sossGuLU5bVadDnDUVZJXAb?=
 =?us-ascii?Q?5HsI4GFPWFz/1VNj3FBWAJ9p2G7bjTSC7uDU3mg+uosll86XBWa5UE9oo+BH?=
 =?us-ascii?Q?/LoI3qTLTxMGpLt7Ya5F0Dp4jR8QD0hIIa0UHG4BF4C8mRNjd8n6N2VDCFAK?=
 =?us-ascii?Q?EXQwrowNX0QXxbqUBHRa4y9XQr90F43EmZPO+NM0gzacWjWK3qFrOwLTXwOD?=
 =?us-ascii?Q?6N+q1PphwXqewpW8u/VvGAu5TGeqgjnEwmxSBmBsIeo42Heh+9RrTxtSfa7M?=
 =?us-ascii?Q?NHv/frnUre8CMBJdJkOK4e3RoLhH/NeDV2OqDhFIaw82RKDfGYe6NzP5S6Sz?=
 =?us-ascii?Q?g4cEgLbrzY29DQIh4f3E5Z52tOdgXrixuK3jkenj2w6LlFUX795uuOSqLOAP?=
 =?us-ascii?Q?at8WgMTqTvMmolH1857H7Su9n6B5JKYXu7jlTxEZIZ6/WU5IoOHhJCPVC1IX?=
 =?us-ascii?Q?Z+zuhfyTSs83Fr1Q7a/5pXmJO7tAr6/245IgMiUd3MVJxWUeJESI3aTf7him?=
 =?us-ascii?Q?LBMBg/66z5RPDbRNSGNga3Xb4MIVpfxuAs4f0DZ85DLmRQkrEYdTAY1qvW58?=
 =?us-ascii?Q?GkcpSoqeDq8O31hf5KZ2ERgODMpYZ6b+vqDnSJ5d9eI+FZ/5cZ12ejvyC993?=
 =?us-ascii?Q?XWuzH9jO2Mmfxs2TIa2to/lbc7a8Dn8M4KTveUgNcGSW7cSP6U44/7W1Ju7T?=
 =?us-ascii?Q?ybyeopg8Rp4KFZw5byLhGjeH9faIgfSLsmQudqDCKAbHEhs3N4wVP+tbVP7w?=
 =?us-ascii?Q?wSWbwK0dholMjbdIX+36Vu/YcUGRBQ+itICs850TJ/tRCIGg9TEZINEeVyyv?=
 =?us-ascii?Q?YZhIhRk9IkcKQiZkVJR0XghyaYdquCEvBLFXQCGBd9ceCUpIEr+s3LlyJZdx?=
 =?us-ascii?Q?pQ/giUv7Vd6SCnlYqZh4sGL/S1G+21KN+xxSs+Y/CvWHEbySn9zS1T7KrXOM?=
 =?us-ascii?Q?gSsg7rzcmnCTUzWstZfzkHiet8EqtJ3A4p/qk9bXGXONhbtdl9H8ApqXeFAO?=
 =?us-ascii?Q?TOcWdKYRhU5ve9z4qrhPDiYj2nQwXBYQd+1p5j/05WILebOmhAtokVfKU/OO?=
 =?us-ascii?Q?lryA9dFnkf6bFJOxoVrEQRmNsLTnZKp0mJOfWP3OsebSBBaqw7NgH1XED9mQ?=
 =?us-ascii?Q?SsG3zlG7Sco6KU68/sFt1i/6CXTmpc0xZrvkqb5e7CekGzfNhxGezjtspVGf?=
 =?us-ascii?Q?rDnsJBo2hchpVH+SYLPkQR9soEoJys2b6c8It4IsnFJrh7g7/E6d7NyUptrF?=
 =?us-ascii?Q?Xwvbii8YmSNo8oYCj03JuB6Wk5xPnK46/Dcm0FRJDSn0TtbFS9Up8a//tRjl?=
 =?us-ascii?Q?U+jU6Wkbj6SQVNLIb+3bHopdLnq1LBstDuDLWxXYTF+y9i0vUGcyLgbyfvM1?=
 =?us-ascii?Q?UBQp6HOWqEOhzUwZFVoTe5PveTkAfUBBdQUKvpfdF3rxIXzVxrGOHoY7AM0o?=
 =?us-ascii?Q?tGKHHyYaus4h6XyZHVYle59zOqKHuGhu+X/xUW97gagBVIlCTSr43JYhRrrH?=
 =?us-ascii?Q?6UiU/4gP/EczhavaVts9ZhsFo5t6GFYXx4RuxGa2oOSW96rIbowsQiRd7Pq2?=
 =?us-ascii?Q?3/0BJX/9dr0qRdayjQZ4lfz3rGytKZ0QZa1cw8udJzbywLwmNX8HhewnEkQq?=
 =?us-ascii?Q?jrJHD/lAgMtnKQ4pOVBRi2APPSUZj5GMDxI6ZnNJHX6p4BLRiBLNIvSIjy+V?=
 =?us-ascii?Q?IXlNrrbJOXVq6woA/wzGKSwY0Pt3WX0=3D?=
X-Exchange-RoutingPolicyChecked:
	nUhNXsbtX82ZFvCH1pdUVyPMtZLdCC6WW6zyHld2ZPgKlgu98BKFQy4o0TJGm5kB3RTS8xjtqOfczknI50qxSdTpRyipEd01EbfMapB+knlmbhIXHYkJSDEUfAXOrvSFvrzSZ0n/NYsAaKHBbZ9czWHvpg3uVJBXpJXO97SFlna0b1ruEWkrt3veE/PEQANWRvqF0s1f4S57iCJu/a2aW9J7+/d8dizltbw6HtuI6uNS9tJ+tOhbRcxe6jKuI8I+F9ZpO0o6XpM0ZjHM9fXKkE83Sf9CMFjDgR95e7/uoxjPlEpFxPAhMHDUWrN7c3acSETahWtQqUwaZo/V6v2/QQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xFtG0JPUrAhcnMgnt08P0J4rgti/PdFC4YwSrMaicmV76rNtD7LyasWlPyWZ+Bqkm0Y9gkHCKdDQDa1O8v9haFAiKRiwnZ69pyu2UkgHARZKHJ91Y/v1sJbuK/aFtZsipGI0vVSY7LBgX+7Dckwbi4j6qBuFj1ogkqfSJA9CW4rH9xFgX4x0RjGkwNehHpxiXvsWL0uXcwhQ5ZzF+4EQWcrd+JDV4+lSwcoWo1qgXX9vk9FYWyk7cEfAmcqKclBPPAxOr4gsZcp1IfliPA8sqIg2T6FYEs/WbUcUoRpduUo1MNLVsiCOPqVP/ZBpuMfrwUP/cmRc7UMIzYd8H0qFJYtrGRYQEUkDFkoHTCnIzGUM5cXgVd9kw9qyvC7QjsoNku+WJWocgmkTBsowQK+U6IsuyFKZ3qtBJX117D92iHuwZkM/aufQhSUcGsWOLvX+DQ6D/qB7ZUZhw6t7PlymFBTKeKcIMO0B1giWod6UOayhGBGEmSDq0hrebWa8H0wYKnL4VCqL4vOua5cdk95e1ipqapDgKmOcuRzAQfWyU3BlcC8bxSs2DPH+8rXK7Tm4RZOYVYJSI7TeEAO2CnRJh4dGM2uVlRfXCjRXQIGOTk4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4441a611-54f1-4aab-163d-08df079db638
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 20:23:25.9528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sme+Q9xEUWaPMSuAtjEJQUr0UUJwQOAJ7iWgfpGAxADMYTW+7/4mXuBj2kShmJ2e4gorMbbI6uJhxa0tkvbVAvNUa/HafGtmObJKyDZCwog=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB964822
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_06,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2608310176
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDE3NiBTYWx0ZWRfX5sei1LcfTZZ9
 MCpzC5aFzcnKWuMqKo6lPGUDi9YPykI8AMsggns/TkjCz01eId806gD8039GaJLd31bnc9UNjYq
 lK4ubaor3v7pqisTpo7oKzMsdKhZPyMV3Yk8ui3ubmkZMpQM25l/
X-Proofpoint-GUID: lcrJFGYVBzDGYNsDrBj0VZk36hGvb6LT
X-Authority-Analysis: v=2.4 cv=DPu/JSNb c=1 sm=1 tr=0 ts=6a95e2c1 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=EIcjfB9IiI4px24ztqRk:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=vggBfdFIAAAA:8
 a=yPCof4ZbAAAA:8 a=7gr8-LgUhGOHEYCj_R8A:9 a=WmVTiCyuxqgg3mnwYu6p:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: lcrJFGYVBzDGYNsDrBj0VZk36hGvb6LT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDE3NiBTYWx0ZWRfXwsFPbB4uxENt
 kkxYKZUyKZW8JP9UxnjW5Y8bnDyPl2nEdrOaXh/LbrJyLkW3RtK9IQ/YtPiFzSETqGmG+Fl+xCI
 f9E+T0c2QjwPCy/PmseFN8pnoqBwJPsD7ZTfqZ9XKizwDQVY0s40so/0H+qwHHXkgCaMOBytPz9
 LqU3wx/lPGMgzW5MbIaeP2jUz3qIg/faoITRuufI6KvRo7Vl1awCjBdoirSTt3m2Wcmar+vEP/0
 3OanlZM7ezMHHagPE0aLc7qonvFMce04JonwWs/cjxrjDIsZytumiw4mqDt7KecoOk0WdoYjV2+
 R8u1Hm72bGtOKB8FqMC6+e2k5iVPPo50WaYMA4/RWeQ3BeglJQxAPscLDJz1pK9q+mC+HUD561h
 ZOqLzbKqfxJI665tUIUkf8V2ZfttOTrvXnq92RAS6BPAzSm6BiJDDbMN+jnJGNTaw33D3vYKu6D
 nd6kJsVerl9fNURfx7A==

The inner loop in poll_idle() polls over the thread_info flags,
waiting to see if the thread has TIF_NEED_RESCHED set. The loop
exits once the condition is met, or if the poll time limit has
been exceeded.

To minimize the number of instructions executed in each iteration,
the time check is rate-limited. In addition, each loop iteration
executes cpu_relax() which on certain platforms provides a hint to
the pipeline that the loop busy-waits, allowing the processor to
reduce power consumption.

Switch over to tif_need_resched_relaxed_wait() instead, since that
provides exactly that.

However, since we want to minimize power consumption in idle, building
of cpuidle/poll_state.c continues to depend on CONFIG_ARCH_HAS_CPU_RELAX
as that serves as an indicator that the platform supports an optimized
version of tif_need_resched_relaxed_wait() (via
smp_cond_load_relaxed_timeout()).

Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org
Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
Tested-by: Haris Okanovic <harisokn@amazon.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 drivers/cpuidle/poll_state.c | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/drivers/cpuidle/poll_state.c b/drivers/cpuidle/poll_state.c
index c7524e4c522a..7443b3e971ba 100644
--- a/drivers/cpuidle/poll_state.c
+++ b/drivers/cpuidle/poll_state.c
@@ -6,41 +6,22 @@
 #include <linux/cpuidle.h>
 #include <linux/export.h>
 #include <linux/irqflags.h>
-#include <linux/sched.h>
-#include <linux/sched/clock.h>
 #include <linux/sched/idle.h>
 #include <linux/sprintf.h>
 #include <linux/types.h>
 
-#define POLL_IDLE_RELAX_COUNT	200
-
 static int __cpuidle poll_idle(struct cpuidle_device *dev,
 			       struct cpuidle_driver *drv, int index)
 {
-	u64 time_start;
-
-	time_start = local_clock_noinstr();
-
 	dev->poll_time_limit = false;
 
 	raw_local_irq_enable();
 	if (!current_set_polling_and_test()) {
-		unsigned int loop_count = 0;
 		u64 limit;
 
 		limit = cpuidle_poll_time(drv, dev);
 
-		while (!need_resched()) {
-			cpu_relax();
-			if (loop_count++ < POLL_IDLE_RELAX_COUNT)
-				continue;
-
-			loop_count = 0;
-			if (local_clock_noinstr() - time_start > limit) {
-				dev->poll_time_limit = true;
-				break;
-			}
-		}
+		dev->poll_time_limit = !tif_need_resched_relaxed_wait(limit);
 	}
 	raw_local_irq_disable();
 
-- 
2.43.7

