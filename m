Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.177.32
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794817532;
	b=4puVu5VpVNROoQFsFqADTtP4BEV8NX6dbPX+JHQ2TbYfxoL5/H110pJ3kMEN2ohnh3YB
	 z96NvWO6vshxvNB+8SD7W9UJxNc41IO6cl9BcV+ETUuFA4AwQ0pB92F79Tx2Js5+0E6kd
	 0qPy6HImLIzibolx+BajUOGyL72YQOqwqgjo7UYCnxVptksXccmbblCBivyxKgEjaRMgJ
	 MQs89IPAIBWdIOxA/wWb49CyIV2ZIkgMtHQOq/43aGvVaAQefhUwJiQkvh9fwDxTqtJqO
	 rdyGXLMH22hKrWgBKGae04ystmQ2VMIjpi4H/tHXkNvzeIpbR5Y8V0/t+XU5Aqa8/cw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794817532;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info;
	bh=suuC1u8Q6jKbc6Mpc/8NwZfFZWSt0198/uQFIDxZK0k=;
	b=flPKMwJLREvUeF7y+qcV/zHkHvwDRH9tQIYi81/USbwrVu+P3MVxA8B2WSZvZMnC4SOt
	 dxnEUDaLeBG+cxjraXgx36CZyS+AOCbCiKRdobMKK3u0mSJB1efPrZON+XYm5r/kux9ni
	 7a9mbEkGGGEnG5k+IdKn+WmYdFvBNVbUXHKXpJKbM0o0C9JNHoQkz1wnf7KMZ1ZV0iFRt
	 Ve9RoqVO+42qQmf+6BWYr3zhwZbKH2T978ey8KuwgDlgMyqHU21laVAAAg3sOMkwDGRLl
	 b8AE3QhVc82wm7/2+VFsZtJ7pXmDD3m7ib+KHo+XCd0uRa0OCDNEbD8dLYiZkKJz3sw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oracle.com;
	spf=pass smtp.mailfrom=oracle.com;
	dkim=pass header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=cLTCxdBp;
	dkim=pass header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=N5dCwVMy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.177.32
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C529606A32C;
	Mon, 16 Nov 2026 08:25:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C529606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=cLTCxdBp;
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=N5dCwVMy
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AFNoE9x236297;
	Mon, 16 Nov 2026 08:25:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=suuC1u8Q6jKbc6Mpc/8NwZfFZWSt0198/uQFIDxZK0k=; b=
	cLTCxdBp362av5TsRLEgBSagvocm/1nYUaYbgOs4eQgXkgY0AO0yEa94eChY5BWQ
	R8Du6ESprySRbBjzqG36NrJxnoMeMKV8gkS5DExFKEIQwHaSOtwkn6dFKAEGQDv6
	KUX9Eg0mjhk1cKVEcZH8Z9RXwc4EdgWo9RfFncEB7cnloo3clE4pDZJlha3p+aOe
	xm67aI4l3bcmp4ENDWewl2WguAgLKTtu8GytvG3WJpYkw8nDeYFjQhhf4ZsnlJQX
	JT9K41Dkdz3acCIYDi9MVW13sMmZAltYLisA0nEUUsDA6bfwHrSSmCJ8dr9ppPt7
	LTP+3iJ0gyhc4VqQ2NvQrg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4hxe2e1mwt-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Mon, 16 Nov 2026 08:25:07 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.11/8.18.1.11) with ESMTP id 6AG7cPHx962760;
	Mon, 16 Nov 2026 08:25:07 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011053.outbound.protection.outlook.com [40.107.208.53])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4hyvbyuxyg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL);
	Mon, 16 Nov 2026 08:25:06 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ae4R+jCGHGzqDMMchFTVcBipp9bR8guUHRhcHZFf3ltol5ix24t0P71ywjbrfuJFQldF6wFt1q00Apa3CNXGFVvvAFq6lR/FY/9W1w3ameqGOYQuvHGJhCoeCn0W2MHrscKKQi4k2RRM1DSRENhH0pRgoVnbLda9bWpS9L4knSvJaH9bqHFhFb7VNXzbyxnFBVOOxon+1hD3RVO/Xhcfh4WAG5rv39w+s1R8iTwvcTXgnNGjtisqMfX97F/Iw+c3ljbqCQe4fXdTv69MA0SceBdVGGkIcZnzAY4oXBgq55FjpMW0XAwOPpRIOT0zj/YPFtbNTdXggztOTuuhI1+L7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=suuC1u8Q6jKbc6Mpc/8NwZfFZWSt0198/uQFIDxZK0k=;
 b=FMDF+qX3M4ZbHjuAOjTrtWOsfKsss247lTSQvjZL3WQ7M/so+WF1rUeAF1byV+xtgB0Fad+SyC+win9U6DF/f+N8wrNBOS+5qbfx04HdGH7U2FvRge1IVzf5V/z70kc8tXqZT8CMyzX/XNIfIxBv5iCoU0UEyOckLsYkfeS+8Gq0ssIkSiVOOyrGHHe4uMnqovF2Ghor+bicAxiOVqPmqT3Ve6AIb5D5h/nzwMORwCUaCrnHT9BQuM7Xb/9aeHt9m8MBj9cvHPBbtIamU/ccDR1Buk4rT40gGFdjJleuu2FkyRT4AF/FaiGeZ/GaesFAvmaj0t9afyZL4HjMihPmwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=suuC1u8Q6jKbc6Mpc/8NwZfFZWSt0198/uQFIDxZK0k=;
 b=N5dCwVMy5lCzRvOzSamk1DHuoUc2pSG045D9ChrkYngR0bN/t+HITJrgjxjgS2/UG4PyxfRzxpGHttkL3A1Hrvtk2HcHkfEq2xtRBYUo57MQAg34tfjIDGjRX4y5qjfQAYoMN8H02UO0vaMD0hnBf9tJA05TqwdpjfVWUaEJDG0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CH3PR10MB8216.namprd10.prod.outlook.com (2603:10b6:610:1f5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 08:25:04 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%5]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 08:25:04 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        bpf@vger.kernel.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, sahilchandna@linux.microsoft.com, cl@gentwo.org,
        ast@kernel.org, rafael@kernel.org, daniel.lezcano@kernel.org,
        memxor@gmail.com, zhenglifeng1@huawei.com, xueshuai@linux.alibaba.com,
        rdunlap@infradead.org, david.laight.linux@gmail.com,
        broonie@kernel.org, boris.ostrovsky@oracle.com, ashok.bhat@arm.com,
        Ankur Arora <ankur.a.arora@oracle.com>, Ingo Molnar <mingo@kernel.org>
Subject: [PATCH v17 11/16] sched: add need-resched timed wait interface
Date: Mon, 16 Nov 2026 02:24:32 -0600
Message-Id: <20261116082437.66739-12-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20261116082437.66739-1-ankur.a.arora@oracle.com>
References: <20261116082437.66739-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0226.namprd03.prod.outlook.com
 (2603:10b6:303:b9::21) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CH3PR10MB8216:EE_
X-MS-Office365-Filtering-Correlation-Id: ec211ec1-e1d6-4897-0db7-08df43bb1d70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|366016|22082099003|18002099003|261009223027099003|3023799007|56012099006|261102123227099003|261028144727099003|261026121527099003|261026140227099003|261022105027099003|261021121427099003|261022075727099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	hdG7mwuzZlSrhRt2NcIywZ8Q969OkIODBAQL7YdNNVG9zj6bS42A6Hm7ZWDmzelcVEWUApi9fSj3Vkp/6PMRvHIc/Tvj6zPuO3Y4Y6bND9CljzlP6XlEZP2Z2C9k0fetPFoOWzvB9ygtyyfvsrIQ1aKZ2UCjbwnNerqUPeynEIfMAUtdlVLdqav57msjLRRbDz1OrT93LggfuR3+1KxjDzHqo9u4MHFbyOfIYm1+A+0KShMpRx/lQnvmfmLgZhq6MPyELMkirff8AoLykAL/enaqwPIYyI2Jkt4YZULl8li20M6ZqPwgeog7RMImixLhBDrJNDD8UCkCrNjHptadzzAhwL+p7fCS3lEcLrFt6I42L33WxuSUpRS3dCkkEy4cSkCmGSjiIaidO0Hb7zcVvtYAhljI4lUwyL5RwPSa87mK8N5tg3wJANYtWzl3mXXGR2IlcD8YolkwyGSwifkQm1xRLzXd2ot3HOB9n/fVPgjHCVGJLmuFpuC9TGrVs900DA8+NOcoXufG5lSobV3QEWlRR4gK+bj/qC/OO+q4md1vWHAkrciXVliQOtezoMLkTb0kcOCgyGnxP3AiqFaw+fSyTYyNlUxC6Lq7D/SCwv/9Ysld+f5MPXr263tvcdmjIk3qwqr2wOGXuwI7yLrDqL1uRkj6qnn4pk34bT68w1I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(22082099003)(18002099003)(261009223027099003)(3023799007)(56012099006)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(261022105027099003)(261021121427099003)(261022075727099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A1IpKlYwT+3jZhT2txxPel3cZ+rsDdVg7W/V5djEqZpnTl3ouI8nhd2DVaJg?=
 =?us-ascii?Q?Yw6+GE66zeWNWq924RbQ4UorYVnB893TS3Zu41hmqtaMpA3mPPF1/rPzOZn0?=
 =?us-ascii?Q?pWpDdGHZVyNYuy9Vk2y7UqAA/3Q5Rq/b899WOkcstnbcwBEg0kR8gzyAKtlr?=
 =?us-ascii?Q?AdYSaNQLbMlm6qaSIVwKhkUMRLfkMy1jh8Crryup3FtSOa4xYaO9DNE12E5t?=
 =?us-ascii?Q?kIwZ++mI47dpYCVzT/VofuDs87Lx53qqqEMwJKg4WLd3Zc8Ifm7VCDCuir9C?=
 =?us-ascii?Q?meH8QFH1HSBVT4aF+5fLWPJZ1ZA7nstIGqA/W/Dfpaj+U1JD1LKfWyHX5L6o?=
 =?us-ascii?Q?CN0h/wOBWNWwaAehea0PExh1v1ggyk7LFiDPKjAkcMJK6nbAJq3ubhRInCHh?=
 =?us-ascii?Q?sy67fr7jTe6OXD42VhBWk4C01sY/W05WuufPT5cLhd+kSGiK1QgascXS/sDA?=
 =?us-ascii?Q?uRdc8KbsdMK3OahSOFMuY+3G6lVnlPVF0LaVX3YCI8LAQ9dhhCpO7CLz+Ofa?=
 =?us-ascii?Q?wjs7V+Y+/qbFAjE6YuxWnjjG7J1xsEzObjK8/2IdKyLYzPCwz8FPytvUvibu?=
 =?us-ascii?Q?Ecyee9mUnQIPTDq+d5te0hZxbADYQLpI4EjOJgIb162aXWhQ45+PEM2yHvZs?=
 =?us-ascii?Q?z2BvpADaMJn2zHjDUYubC4CkjchQwEqhyJq4i3vbl4wJLhrseITGK4u+SjAt?=
 =?us-ascii?Q?thxA8qLKBMrNMp3WtHiEDE618tEnCPb2V2O02g3T6bvUS+tb0sP6W9dI239Z?=
 =?us-ascii?Q?4eyFQF84tvJUUqBg+0u+3BIeBqJVf/jZsQ1vntm13cm+zq2csOnf2q5EKC8+?=
 =?us-ascii?Q?9od00exTr4c49Czf4WV4wMOE/bTduCtbDtwnLBnEnX8vsOEyO+kNS/3ebCGa?=
 =?us-ascii?Q?Hs8RdjNt/AoQTSDXVbRvnrfKP8DnwicO1W4gyAWkSjJJcKTPCsEwwX9MTtg+?=
 =?us-ascii?Q?uEZnN/o3AXyGmuRAySdEcRQ+cU7xQATs2rHfQs2gF+H7ULfWQH05Rv1KDDke?=
 =?us-ascii?Q?H+GHzt3cAm+W1Cv63KlSnvvDLegZqGXUk3MZnag+iZV+46jMFE5I9YAE0Uic?=
 =?us-ascii?Q?PwGMpuJtAGBErGBrjDN1Qrb8CavqJ4FrdQaoV8P4FfdB5U+HEDdf7Ry74Vjy?=
 =?us-ascii?Q?eOR0jH3w2rB9wSxi/VJIhYw4ycam6Sk1erxsHNCmbFGS3mP+TZ0qyLVRpXlx?=
 =?us-ascii?Q?Y7jWZB7gZx6xK6LXxjp/E19d/FIMTTSsdQzFZFXfSJzxt1U/4iW7kcVNfzZk?=
 =?us-ascii?Q?i9iIEIGY2fT87QYLyFW0OHpHY+mkSy1Bl08F48/HkV9su62gVT2edsFjZSw7?=
 =?us-ascii?Q?YMt9PH5uufWvBOfvCvpFkhZU72BLS4ymFqLnrt1dU+M/5XVe618kNQ3Ia9uK?=
 =?us-ascii?Q?6rztrrMo1+EGpa0FYZRz8JWCpU4wnBLfAkACwGOyDPgAftbT5J/cbiUEQib2?=
 =?us-ascii?Q?xAeBZHaqNf0MGXxzU+Em1znXpopYz8ypdumatowXCu1qibWy0h2uGAoBf57d?=
 =?us-ascii?Q?+xDbulXyLu2sgxm9BiJUgaspXTv7y/+HjxCWyIbttjGcdm01EFaTGbdv0S9L?=
 =?us-ascii?Q?6BIM8gSKbMB5lTGjBwtl8aasel0pG2UwCrODTTJr+7fcpVLE4taE0XFseiZ6?=
 =?us-ascii?Q?ZaypA7sl1xNfDV6pZX7sztauTynpMc/PP9RCiDcwgqM0Ei14qztcxY0ah3KO?=
 =?us-ascii?Q?EGXI5w4hHSnH/xnlg0Fbg1TT81rQ3123/uPy+6XzfonDQopt2ECkmmMvSeqt?=
 =?us-ascii?Q?zpI+26GexNgmuf/jNWD6RC8syjs6XAk=3D?=
X-Exchange-RoutingPolicyChecked:
	2RHFvl5TEWwIVN7Bu8kfamwI66QfAhQ8Bz/YW9VNZEJl5EpUy8nT96B7XcgvgXLk85zsxu7qUj9rVxJ0X8jfhomCtmottkit/zsXZjGiKUi5CN1HnJsq+Mb1K15spu0Wt5Wc3uvWRp1PqbXQee19hL2R4nUpLpzCDQ6WPdOrTvzFiM1YFsQDK2d+2YQCo/+Uubvf65haFuKoZO2IH85FxdduIUlaiPK0eypwBtdh/rMcIMlQy1ALU3pTvUuXmhv7SFRl/zCj9uT8KuQeBSu0QtW04JddRCwSpQLqvqlyCejE1Y9ZsaiVJFv3pgf/Gh/yk4cjVErM0i47jrRBQw+WWw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FUMrE2fNpvmyPqLi2WT/uHpYtbawaRVkmCHyTntnPOBI2lsLnEWS0AfVpxKjssT3g0JlGCeBKIrivKyKDrWVd7J/YcfgfPvPhN6L4iWgJWOiEdtYntIhXtqNu1Ash5STQNe28G+N6HPu/7szBXmOVV2Oi7zm59JjuWPycDd7GIoIarD3vOxPdjex2C2cwbTjNECYNyA7r1hmV+Zkfq2gU2zajKjia2XpRlYbb4aQDeJeQXZtX7ANwunSjmnlg7uI92Q33Hx/FeAhfvSW5bFm4YrQwH6qN85OR7i40QT8KWiLvG0o4BZ+COpoYaK2F6iK68VC4iFS0gwM60caMuLmVActBXNzw4penc6KU3SmhZHS9X+RZcMic27ME3F2/yamdoCvaIEuuAOHFf5MKjDbbTibKkO4AwEXxDF5Q/7xepwoa/pLh+1r7mrkzAnASoGo5UzyGSJsJ3UHPizCv69n4as/ZJtXn0eVgbaxeXqhQ/q/QfqKL7dniejUKLqp/ggKeEJxb6YqHrM2ek8xs9WSSmdPEwiqFH7nnVgGCSQ3108Yk7+jYpmaixmasXjM6JoGc81F/mMlpO1ZJUjSmAJvJmAg3ndfzHQVp6t0/BX0FF8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec211ec1-e1d6-4897-0db7-08df43bb1d70
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 08:25:04.2688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DB9LcoMjKkMCS1rHh4mdBr7dSTg3p5SE/A8+baH4RAeFJAH07WFFTXaxgtWgBe7SNGQ1jejIZbUqkhkdTVc9YCSgn7f2yvLJ3/+1yhnVwQY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB8216
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 spamscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0
 adultscore=0 mlxlogscore=999 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160033
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDAzMyBTYWx0ZWRfX6hVJxOiFBaMS
 IjEgHfRn/b7K8IHmzy97yOi2yZcRBnoOPMT0vX5mIEfnUBj8Z9sJFIp5nWA4u5IOK1HGDkjaaVt
 WjFc/GRFaOOwydJasyC3JE7lTLzW6ppbpI0i3lpfNXCUlunoQJJaZOLYJ8GvpzGQwuUJP0Uziq0
 gF2SN1ikQVEZtfJ5XfbAZk/0eLXdmNxIfRtpROk1r/78JrdOKoLTfqwDh7jNynn5MgK4Co9iaxS
 usiI/W665lPlJPOEEB4ofCW4AGUR0iCCGlbG2noEQM3e9YUJiqVNJ3yEeOZPTzETf/yQGoGgibn
 imLjO/VFjXLqrqZOaFK+sus7axmR6MWFasaKiEtEfBmlKl0rlZFLPbjdHkuHwNm6SE4T5AdVCwo
 FxWarC1TWjIlZu4LmLhtqVumBqrwJPnh3QvMbBDqA8xghYR9HJX0A1RJIwa3Tl66fOIvE3HJEmL
 fVFmg3Hx2MgjKtnnUPzDlf1KRQfvhdiZ4ASvYtFo=
X-Authority-Analysis: v=2.4 cv=BJ8mP1QG c=1 sm=1 tr=0 ts=6afabde3 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=vggBfdFIAAAA:8
 a=yMhMjlubAAAA:8 a=yPCof4ZbAAAA:8 a=Ze9yCt5EFHv8u4PATkMA:9
 a=1CNFftbPRP8L7MoqJWF3:22 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22
 cc=ntf awl=host:12101
X-Proofpoint-GUID: 1tU-IaBqjMHMQKEnExYjUSNiksBRpq0k
X-Proofpoint-ORIG-GUID: 1tU-IaBqjMHMQKEnExYjUSNiksBRpq0k
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDAzMyBTYWx0ZWRfX1cyoz6wmI/xZ
 uTdt+kydMIG2NZXIqL9oW4jQU1/TNMBduwQYY5gf5eSytSowKWs9pcNsgIeud6JzoxTaFy4LuCc
 UzEeWbXv8Dd3ZDqI/KIxiRoZagcz1SaUyVM8fYUcjj1U16RJLd6n

Add tif_bitset_relaxed_wait() (and tif_need_resched_relaxed_wait()
which wraps it) which takes the thread_info bit and timeout duration
as parameters and waits until the bit is set or for the expiration
of the timeout.

The wait is implemented via smp_cond_load_relaxed_timeout().

smp_cond_load_relaxed_timeout() essentially provides the pattern used
in poll_idle() where we spin in a loop waiting for the flag to change
until a timeout occurs.

tif_need_resched_relaxed_wait() allows us to abstract out the internals
of waiting, scheduler specific details etc.

Placed in linux/sched/idle.h instead of linux/thread_info.h to work
around recursive include hell.

Cc: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: linux-pm@vger.kernel.org
Tested-by: Haris Okanovic <harisokn@amazon.com>
Tested-by: Sahil Chandna <sahilchandna@linux.microsoft.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 include/linux/sched/idle.h | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/include/linux/sched/idle.h b/include/linux/sched/idle.h
index 8465ff1f20d1..ddee9b019895 100644
--- a/include/linux/sched/idle.h
+++ b/include/linux/sched/idle.h
@@ -3,6 +3,7 @@
 #define _LINUX_SCHED_IDLE_H
 
 #include <linux/sched.h>
+#include <linux/sched/clock.h>
 
 enum cpu_idle_type {
 	__CPU_NOT_IDLE = 0,
@@ -113,4 +114,32 @@ static __always_inline void current_clr_polling(void)
 }
 #endif
 
+/*
+ * Caller needs to make sure that the thread context cannot be preempted
+ * or migrated, so current_thread_info() cannot change from under us.
+ *
+ * This also allows us to safely stay in the local_clock domain.
+ */
+static __always_inline bool tif_bitset_relaxed_wait(int tif, u64 timeout_ns)
+{
+	unsigned long flags;
+
+	flags = smp_cond_load_relaxed_timeout(&current_thread_info()->flags,
+					      (VAL & BIT(tif)),
+					      local_clock_noinstr(),
+					      timeout_ns);
+	return flags & BIT(tif);
+}
+
+/**
+ * tif_need_resched_relaxed_wait() - Wait for need-resched being set
+ * with no ordering guarantees until a timeout expires.
+ *
+ * @timeout_ns: timeout value.
+ */
+static __always_inline bool tif_need_resched_relaxed_wait(u64 timeout_ns)
+{
+	return tif_bitset_relaxed_wait(TIF_NEED_RESCHED, timeout_ns);
+}
+
 #endif /* _LINUX_SCHED_IDLE_H */
-- 
2.43.7

