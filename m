Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DF51E8826;
	Thu,  2 Jul 2026 01:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782956089; cv=fail; b=b4K8eJZ4YdVGsCdsj7l7hnoRP61bcz+xIF2d+nd2wt6NeyfOi3jPH+D0dkGHwLxHBsGjM/5SqTL82ONhdx2BoeOWWU4lmKvLgvdgMV2DOsW+A4oztcVf0ZQLNpT6SeT4F4+0G1bv4HLsGKJhfKiDXioL2LGCFjly/2uXxSwoYyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782956089; c=relaxed/simple;
	bh=Y2Jy6eSNqMN2npjcp4XTIR+/gWqCyB8TDdoducVIPfE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U5Fb/e6dNbSzL65KLiyQCwc9LaXrNTxlxFRVlIxfsKejIDDcwFPVo8nUUfdNQRBso9KRMK10VOrTPoRrHz3vtV6npEykqRh8EIjvFdsxCoHqC5V86lCl1ZoHJtaLGRTNBWGfljXGlHyQiTsPDec/zxRLIpOYZHqjzwIrDzQT2fs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QWEfQDcA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Kqe2kJEw; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QWEfQDcA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Kqe2kJEw"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661EGwKR2817300;
	Thu, 2 Jul 2026 01:34:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=bxZgC9EJVLAgClIsXqwpvBYn73BN9BCbO2UjQ8V1/fU=; b=
	QWEfQDcAwvsBKR+gzJI83ocaNziaMQ4k5pNe0MQtY6KoojzjkGJMsT8k7o3pe4lX
	CehaI8Sg9bXoNXEmtwmSU3CIns6Sroo1+U3gBftn3zIRB4acNKn+g+Fg5RXAKVu5
	mJQsnhVXHpF5Us4RC1gWobn+8Q8OL+JeyhPWa31TNMIPwUx25TdTMeYRzvKPs2bI
	FkSECCcdXfWTtWYdGTb3mJcd2BwljFPYXEY73PwunnsGGDtuWoQOwZVgDdJDOniH
	ryTdwKWnYMnHwbBx/jhmPcvn2SSUEgcel+piDhXNini37dUoYcFLteBxtos4JOPU
	VaRTWxN3EVKVUQid0Ukr4Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4f26jq79xg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Jul 2026 01:34:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 6621SCuW036164;
	Thu, 2 Jul 2026 01:34:17 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013026.outbound.protection.outlook.com [40.93.196.26])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4f24ygbxpc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Jul 2026 01:34:17 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cVO8n+yLbCBKoFiijAOR0SwRcAYtf3TJdbrTv2o05f6ThuoCwD//fiMQ/T4LPVf9Cq7Ku0ChMTMkKg4kwBZ/HUsqlDbhdA5Yi1s2c9DGeqLGCRw82ho9obcOEGvNjjDJ+ugxywdAb+Hza3yoSYb/ecW/0h5os9Z7V3g4Zaq9O1A99QGQmx7egTQkIEWfgJ5yIdml8shL9ymkFWW8WEdfmDBgovNyjTVtxl42s9Z9Ezv4qYc3uTQIMmHLY7KCKWPoFDpWrl4+7KIjTuMaVTtg8ox0bxjvuQ5dxGeIfH1i6EvxXJVPg0+LwwBRHvda5OMdPJ9lIgXGFsSthaNiQqIZAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bxZgC9EJVLAgClIsXqwpvBYn73BN9BCbO2UjQ8V1/fU=;
 b=fQIEAQ6JBJ0zgnbsvNDW4Rq7W5rleCg4v3HsSUvhc1EX2EEP0J/cQkpfmHyTPvhThbUsB3JvBhHb/a5jWXLe8nHF98XZ+KMeWhCmGavOKVVnoZ1DlXOhPLoNwJu7+smqrOcn21+xUCoJl1l/iHrK5t9OaZvi6ZH95AdUVx6ZMaSDS+ADBIMpPj0Jp1sByYEnOtxisNI5vpiVHTVSADmHQaDedRcm63CQd9yc/bwUnI4wlVNmDvuUtErAAT0ZtuwFmki/gFDuNzMQm1FvlUiTnUlGiSggQbqzhm1uXUWAlJGMJoi3OHjY13NXBmwjf8cN3E9+CsE/VYCwKYpr+1dawA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bxZgC9EJVLAgClIsXqwpvBYn73BN9BCbO2UjQ8V1/fU=;
 b=Kqe2kJEwMumzsjIZnjmPgykJJ0CDm5XI5Lnq0ECB7W1DAADAzzLOPRAARzzscpQjTd+obWRuSAPndunu2rIdHXAzhOWciXfLPjkbQ5oL5d1KmwRdKhlYhy+/iGTlmV/PxpYmHsP3lbneE+3uyxaZnQQ+xvQ7bfaIiHttHwlsPuA=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CY8PR10MB7314.namprd10.prod.outlook.com (2603:10b6:930:7b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 01:34:13 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 01:34:13 +0000
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
        Ankur Arora <ankur.a.arora@oracle.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH v13 07/15] atomic: Add atomic_cond_read_*_timeout()
Date: Wed,  1 Jul 2026 18:33:26 -0700
Message-Id: <20260702013334.140905-8-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260702013334.140905-1-ankur.a.arora@oracle.com>
References: <20260702013334.140905-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4P288CA0086.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::20) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CY8PR10MB7314:EE_
X-MS-Office365-Filtering-Correlation-Id: c49e4f51-6c5d-4ec9-2b11-08ded7da05a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	1uI1H3kFDszM0Ooy7Ld5mcif9Suk/2M4sriq+7/xl6g6PKY6nCe8BycaEi0QpwVzvhW4AIePvSU0uOc9syuc9u5MbsUep/cs1ceCJ8CIZxqE1MOpr5PBjcE3iCAMo8XI5AQIaHG9YIEiXy1mU4u6mqnJRPuj7UiWqdRWFW9Lop4GMf6uNRhYyUjn41YesVPA6bFrIQlpdjhM5D/til/2LJXjBss+2Ztn8MKK5IxqZBwXpFVcrm8TbvfbrCmNjbiiK9bRRsrQlLfCg8MWguBJYGpLpEHZAYzcxJjQUbZIdCU16as/XLsIJFFbYRBp0mCSob2i5aHazhmh9tm+Tv4JRUeIlPp9W73LdWjjeRS0XG3QBkizD72Cqgkbj4Qd8Wf018MsAgYmiEGj+uK6rBNhKp1UEJ92VpYF05FtkNzxR6SrpAFowi9l7MI0IkEgQCSmBtPXUmWWTQlStdmqMZ8bBLmOmR5mQYwgYcwFRgDqA6l0Gb0bNiup7x7rlGGJTnB8PtyuWMP8ZI85ypXgTDTR+NdP5qIp65UVO8fp9Y4P88+Y/p1kIQUBO0x8AyjtBQ9w5xS6ivUfKZyIwDyB4MdCOzE/BJr4ai4BES2krxttlh+iike4oPpN499FSSdr5fkMV0AiXX+6lxWVEFJQKjbBIacjhcSzsB4WJT5X1b4syYo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u1PYvmNpiHR+tn18Ocmhxw9ZtiQiHfB6zQb2pgQmHvvmxwiaSRj890RFfX2B?=
 =?us-ascii?Q?QNRA1lNHXGPqnyHQK//KZSlXR5zonghK2iV2MdVab9GlORMz+OvHJtQxGDPa?=
 =?us-ascii?Q?2x1cKXK6KYoCvMOmC62w3CSfaTZrC40PQa3wSn7aexQ4jOYMhSDgdoOYNY6J?=
 =?us-ascii?Q?+/TxsgE1EaodeNecZUtf+8CavOMadqHnsP2P6UJIRo2NxAYsgHzCKr48IS+l?=
 =?us-ascii?Q?da9DFZFP5m50a8Y0R+2SIeERQFtEQ3icy3xVUL9Tf/o4uCduq0StmwHbcqrQ?=
 =?us-ascii?Q?WE6pB3G0d4JmnfFM+krIxceQD3FnxhPEDx6All2o9qPjAgKk8qHDP/11PR+1?=
 =?us-ascii?Q?BlLuSQro9Xt9A4xbCeY3aZCHrK/+6+W9r/AYoQjQev8twP7u3qDfYwez+gIK?=
 =?us-ascii?Q?N9i9e9V1/SYgNIMoUbux8QcLsflzvLq3e0oNESnX8MTY044V5aSDGG7n/A7W?=
 =?us-ascii?Q?x8vXA4IA22qcSacmrwk7u4Nn48QZt9KD0CzjlUDc82HUEnqQL1X9AGMvovAz?=
 =?us-ascii?Q?HIk6jDLGbOL8ZUEzMWISPEqWKXpogWgHlsHW2YopGHy8+bevtjn4PKtkQnjz?=
 =?us-ascii?Q?zfpDaSdg2fJcXn2rbXw8iSmPHssK9f18eIbGenEVggQlJl/Xn9+KHiEitF6i?=
 =?us-ascii?Q?pIqgv/iPufLEvCO1+Bu236vWgibGKBVOMaNZP0x1SzxfSHxO8YpjZnyVMBaL?=
 =?us-ascii?Q?e6D55le1ejEHxq6pgvs5eZG0qNd07L3twxBLWV0NdLQsjOixlIqq+Vlw43uE?=
 =?us-ascii?Q?tYFiGb52mH995iiiRFsLsfusLNs6R64li13a1sn62bi+nStIvKC8JsdlDByF?=
 =?us-ascii?Q?/TPEXs78bOWJnewkMZr99AcnBVMegpaOh9BQXruE0gOYiYLMtdEanxM10/BK?=
 =?us-ascii?Q?LZixf2IA4EPIYjM0tkQaRza9J5j4u4Ya2FI2QRr8hytdrbU4NL+unu78eBDB?=
 =?us-ascii?Q?1mAHrebvruoNmXUTkWsdfTvwAytbs7PlI2qE8ZSobZG+s2Qjlr1ClWdimQ/s?=
 =?us-ascii?Q?q3TkV7vFAiSQBINdhzrhrEMytSU5auM/kn/587Kx4WOKMBUAOyleEfWpfQD1?=
 =?us-ascii?Q?XvRNgvHTJ+o/ejSrrDzcdnVX91o/FrqktJuKz+xzYA0CRVo71mva9KNFrZwS?=
 =?us-ascii?Q?C85BYqhwnOaB5pWc6x3y2kImBtMKhj4l2+B8LBUXwzSPmdMcng7xMlNPddKe?=
 =?us-ascii?Q?z5Rggkp7tGp+0d5Lgs3pvYt4WONE+E9io8DR10V/LrwQJ1+n4c1WmdeTm+CD?=
 =?us-ascii?Q?yyKr94kPKSps17/TTR+JYivFm5ox2QNLiRwUq6FUNLhAjrZpKDhn4pCXmOjC?=
 =?us-ascii?Q?UleZyXoo/oX9qErb+dtmfVoeVC44FFBT07sjqGmTPrJH7xFgNMwot3DwaYGW?=
 =?us-ascii?Q?MJ7na9gM70XEx3CyYt5SEmoAkx27M5Yfd2RIWCUAYAu8UwuoaIQSQMBqWZ2G?=
 =?us-ascii?Q?gbYTxZLvuaXe0V96jHQS/RZ56XRsg/DmufffDyM9yw/eMf/5WfFjcv6yPIwO?=
 =?us-ascii?Q?v8mWPL3rJiBQpwxjcDgSBu5x/3YplHrjNbblttxC8QcJW/ewjcfE3PzmPzKa?=
 =?us-ascii?Q?nqBYJ7RgT6n1GPC/RoFXVb65CDMYmbh+DsLP+bk4ZmBuNlQFb/MFuqVBZmLR?=
 =?us-ascii?Q?+iRctzQp/NloMFqq+nxJc/MvLbjfYltTQ1tGlwSpyDj3vGPHX6onNHaOelwJ?=
 =?us-ascii?Q?uLf3qWBALm8eb1ewtoYWb/B1SSc+o3TN40y2GjVteE00Q6D6k0KuFUIhloOx?=
 =?us-ascii?Q?W3H99lXk59DMI47t+B6u+nnjJ5CFraw=3D?=
X-Exchange-RoutingPolicyChecked:
	LtVRy98Wbr5sLeKBVDjGuVMEjt5+JfRUNe9dJ6uVTcHSzNgwv4xQ5LvQunbAS5xnA99upozcsbqxLrSX1sQ+1UZ2+DwMwWJS7Tc88Z+aTmOVY9wwkfIKF+y75a8m2PRYzIp1KURk6AKCNNDWi2uOCVTQ/Nekf0t6OkaMDy7b6gSM3eZ+OII4evDrD/cJJXCW3ZxaFzQYPq8Yi3AGvxEGeLp481qOwJzOhPczxNc2EC2WCDSeE3Yeu7gEeovcjZQGDRftdW9ue5LGK5xnvRSYecyFWpgrH0D1LMhdIaZm54jFRXheGvKTC1mmnqqPWeUBDL+GiLaCBP2rjWuIatmGCg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Jq6u+IOhNBN2laLr9g4jrQkdZMd4HoJZ2C3pGpbsepEQPqc/+qe0LJi9itnvjnBuqE/jqqWTJrqVUW7C4nJjnhJp0TNk8rIuhikpmxZob/Lgl62hbOn0Wq9inVZmnShjD6jm+BiZy6XkX5WGYC/P6VfYekWYYxzeJR6idHUg/dy/qkygZ4cp+syV/8EAhkUHZg5XUCgv/ReDjHjFywAQsKfqkrbxOxgHJtbibq2UWptTy+tdap6Rt+WymmcNxCAp9OgY+G1hGWO7bnID4YcgxKFImCLB7OgNa4XEPM3hy5uCrDaKIJkCcptW+wFXnpTTuKmPq2WbZ8uZZUq64Y8JDEY4k9Ry5IRDLbydDNPdZcZroWBxLN/A4a1qU4UlvIk9yag+XRhM4cQAR/IP1/DNKd7oKaZ+vrFsE+Bi+N5+nUwru52ylypI8xWsf1lSnZdGkVlkxz08jUR5dDkUYXqirIcsnyqmCtcI1dGz/trgO/xeYLQASwpQF6Ta1/yrcbPo+P3hotQnj85hIYOX1bjtI6XA5lPoblObSZYD+nMyakjzUIPfCnM4FKFo47gG2xDRp6qnNTCeEpgtAxr03KPq5AghJcL72cOGJVr7uKaTEz8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c49e4f51-6c5d-4ec9-2b11-08ded7da05a9
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 01:34:13.2067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wc9748qDPiv0tMIguf1S/OEalxTuwRgD8xZvdGhyYBJtB5WruAuCmz8Hyz4JGzCg9ozlEO2FcXqLnEIMEfdMvHWFHZ3BiOPrO6SE3y6ZCnc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7314
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 adultscore=0 phishscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2607020012
X-Proofpoint-ORIG-GUID: rrxbF5AOlLa4WCSSHCj_lQGfoU3-wm4q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDAxMiBTYWx0ZWRfX9z4DNjqperao
 wvWlfWw50ClcVcqvOGq1Wc0Z+P7iJQxfgznaTUgMllUFXy9KSM4ynxDv4lQ5kYg7zXEBQ6LHHa8
 pihPe5Whh5Fs1e2TbjVs4dfDbZc18leFmQjkfHLm+6qL4ZavNG23+hUKJpIWRv6gFiATOg8RCax
 LdXQuOh0TUwMbyDFgIxwUogvq02w+pKX2g3aa95/XpxWSQOjECt2cEUSRqzHon3Axq4IiOi1rox
 3ksJ9aa2BzLLuxCpvNFuxP+g1ufn/cJRvyA9YfTxYWSidgO72J2BM9KkA65miCr5rtmVI9vFjHe
 vxFTtmMXCZnRFhLCqYmQiHl4j7E4wK/qxEwjp8HAHbRZFa/gijD3L7FQm7bpM+IFG3IzLyUtfkK
 99QfDLP3EbdsJTzZA6v98YzbSoFr9zqIafCWXYkMpFQUCr9zkJ4XSRT8dl8QxoI6Gl1ffa062Ex
 e6Q9pN7Rrmw7UvevVkA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDAxMiBTYWx0ZWRfX96wIwnYMq416
 yObXojku8GTiY9sV0VtbPw3rLTSvSlY8Z4FcTd7RyczhX9cOAhRa30A2eiJlbirAaobXPfDzfRz
 rUdNuR6hzlzFtstlxTV8A4vwqG+8o0PaKPT8NA8/P7kxmas+zuJ8
X-Proofpoint-GUID: rrxbF5AOlLa4WCSSHCj_lQGfoU3-wm4q
X-Authority-Analysis: v=2.4 cv=XrbK/1F9 c=1 sm=1 tr=0 ts=6a45c01a cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=o5oIOnhZENCTenyL_yNV:22 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=pGLkceISAAAA:8
 a=7CQSdrXTAAAA:8 a=yPCof4ZbAAAA:8 a=1UcN1L2XLu2bZRAzp2AA:9
 a=1CNFftbPRP8L7MoqJWF3:22 a=a-qgeE7W1pNrGK8U0ZQC:22

Add atomic load wrappers, atomic_cond_read_*_timeout() and
atomic64_cond_read_*_timeout() for the cond-load timeout interfaces.

Also add a short description for the atomic_cond_read_{relaxed,acquire}(),
and the atomic_cond_read_{relaxed,acquire}_timeout() interfaces.

Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
Notes: not addressing comment about the 64bit READ_ONCE() in atomic64_cond_*()
causing torn reads on 32bit archs [1]. This is expected behaviour addressed
by sticking to atomic_long_cond_*().

[1] https://lore.kernel.org/all/20260608082304.ADEA61F00893@smtp.kernel.org/
---
 Documentation/atomic_t.txt | 14 +++++++++-----
 include/linux/atomic.h     | 10 ++++++++++
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/Documentation/atomic_t.txt b/Documentation/atomic_t.txt
index bee3b1bca9a7..0e53f6ccb558 100644
--- a/Documentation/atomic_t.txt
+++ b/Documentation/atomic_t.txt
@@ -16,6 +16,10 @@ Non-RMW ops:
   atomic_read(), atomic_set()
   atomic_read_acquire(), atomic_set_release()
 
+Non-RMW, non-atomic_t ops:
+
+  atomic_cond_read_{relaxed,acquire}()
+  atomic_cond_read_{relaxed,acquire}_timeout()
 
 RMW atomic operations:
 
@@ -79,11 +83,11 @@ SEMANTICS
 
 Non-RMW ops:
 
-The non-RMW ops are (typically) regular LOADs and STOREs and are canonically
-implemented using READ_ONCE(), WRITE_ONCE(), smp_load_acquire() and
-smp_store_release() respectively. Therefore, if you find yourself only using
-the Non-RMW operations of atomic_t, you do not in fact need atomic_t at all
-and are doing it wrong.
+The non-RMW ops are (typically) regular, or conditional LOADs and STOREs and
+are canonically implemented using READ_ONCE(), WRITE_ONCE(),
+smp_load_acquire() and smp_store_release() respectively. Therefore, if you
+find yourself only using the Non-RMW operations of atomic_t, you do not in
+fact need atomic_t at all and are doing it wrong.
 
 A note for the implementation of atomic_set{}() is that it must not break the
 atomicity of the RMW ops. That is:
diff --git a/include/linux/atomic.h b/include/linux/atomic.h
index 8dd57c3a99e9..5bcb86e07784 100644
--- a/include/linux/atomic.h
+++ b/include/linux/atomic.h
@@ -31,6 +31,16 @@
 #define atomic64_cond_read_acquire(v, c) smp_cond_load_acquire(&(v)->counter, (c))
 #define atomic64_cond_read_relaxed(v, c) smp_cond_load_relaxed(&(v)->counter, (c))
 
+#define atomic_cond_read_acquire_timeout(v, c, e, t) \
+	smp_cond_load_acquire_timeout(&(v)->counter, (c), (e), (t))
+#define atomic_cond_read_relaxed_timeout(v, c, e, t) \
+	smp_cond_load_relaxed_timeout(&(v)->counter, (c), (e), (t))
+
+#define atomic64_cond_read_acquire_timeout(v, c, e, t) \
+	smp_cond_load_acquire_timeout(&(v)->counter, (c), (e), (t))
+#define atomic64_cond_read_relaxed_timeout(v, c, e, t) \
+	smp_cond_load_relaxed_timeout(&(v)->counter, (c), (e), (t))
+
 /*
  * The idea here is to build acquire/release variants by adding explicit
  * barriers on top of the relaxed variant. In the case where the relaxed
-- 
2.43.7

