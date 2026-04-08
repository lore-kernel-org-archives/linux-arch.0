Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7142B3C196F;
	Wed,  8 Apr 2026 12:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775651215; cv=fail; b=gdEmCFCGVZ0fv+BXcEUR5VuQgVIL+IRh3MrEOMBhZXqjKFawhBmyn99lfzU50j27AUgWGzR0SCZaBKaBguL1AdYRoNDOZqfKW000oOExsUDLeq4hhm/09eTGIVi9VzhLBtcy1WfztaLft676Hexv04GsO/DXdVWOFAUfQaxiTa8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775651215; c=relaxed/simple;
	bh=5x2tK/Ql+7Zqf48PmfkGIoyFtOYoEf2nKlcIq33DQWk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Vv4Srl1oDwyuyHf6hvKkLoQ6UC1Tw9vznWIMLgI+8aWUrhZowXx9birPuHVzuUdgtX8uAMpXLnuXFpHzsaFzqhjBBByBiNtWqcFf38ny8RhxtF98dnpvsDszVyomSTUHkEyCnQ9N+77jZ9bBx1eGAFLDIiFDvd4lAiE1Rehp4H0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YmptTRaz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lgt+Yx9Z; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YmptTRaz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lgt+Yx9Z"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6381VBcq1718173;
	Wed, 8 Apr 2026 12:26:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Fe7QSbuiQhAvxYsAtxLdlN/T2c5ItPvuopoCfg1hU9k=; b=
	YmptTRazyi5AJ5gRTKAg6+LzJ4OsuyUtc9r7qe5xCSbiqgfjKxMGTb5MS3L4UUHd
	9Ix/vAabZDSP1Y6xUKdaNyKRXGYJHDqOMdVoORgUZaa+gw89Q5MWxyW2Qit+cLzo
	2T70MRNYDl7FBfkWNe6Fzgcr0MuviWTIQBOhnLUszpsjEdK6XtmGuHXSzfK0z1PB
	6J8Fyyps5wEKSB8v6gtm1qAIuSE1idzSD5+hoYVjrHCqebVnaRV0WE2yHJEeYEzu
	ISUqmkMDmWg8afEsi2dIYehW2chVZDGYEzAup/1dRXDr2WOGJxVaGWSVFhFqbiv7
	ygw+xC3Gm7Fsf7feia5wug==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dcmqa3fnh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Apr 2026 12:26:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 638AA7NV005261;
	Wed, 8 Apr 2026 12:26:30 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011068.outbound.protection.outlook.com [52.101.62.68])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ddgxqd82h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Apr 2026 12:26:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fpn7NIq5FcZyfRLvBip2P+Cx8F4tuXDAo1BYteKkp/7CTLFY4DY39rFKuKHxYsl+nlmtBewm2tWeqcmanbSCUeUlpO66Ktm19xIiB4PthrWBsii025c0D/b+2imljHialMw8reR4K0ZYz/EvTbiOJfxFKQ0EE5cj7AwMJHd40+DTOZEXJetRqzh1OqIE6/GOhDi6As+Z73Y+9f3mkNkoJKwkF7wVXPNp6au5zYIX9PqFbAms/pnR2FfwI8XZBN53UXDF6wIxxRdo9J0Ep1vumYj2HHR7vhpTFYvBgLQKHCGmgpWyU6e/XiFvoDFwmxDUAXAaT6uYOO+GKdqlXNVthA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fe7QSbuiQhAvxYsAtxLdlN/T2c5ItPvuopoCfg1hU9k=;
 b=TCISjRu+OD6a0tSfazLQFFn22H1hzI9KKK0EPNbUigg+zMIPVxZojd6J+jnCNUvNTW9iGGlqrPbt+YJ2hxWsdFDEnxwJX952AUKV7dVJtrRRQNbjCw4TYSNIRnYiBS4L1ffm03DBDr2NjY778ED4LkI1UEM0Vej1lR+QNUPDIwXNkWmZT1FmlXQgts59/PwdnOZsxspofG7doVvgPRW7vAh34xSHQr2eRG2tW/XVLAhw8zN5c2miG+1JAVOBf3c+XuADhGk7jMt6dZ1dPGneJZcjSFs9m+k5Jzpx9b3rGo4qGzWY2FNfXszLmZPqD7EJqXUBbXpv8XVinaDAinyONA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fe7QSbuiQhAvxYsAtxLdlN/T2c5ItPvuopoCfg1hU9k=;
 b=lgt+Yx9ZKfwBSNc73cOO+Qa7ZGyJCcgoc/kROuXL1aCJMZ2fjdyJiG1Q3EiWb3UpcTH26yR+HjMi9ldwwenttsLNLLrrwO1NMN6/rybKnM5aUqyr7knLfm03g5hh3r6ar19JXybjnBnynSRa3Rm3fUY6xBtNnNbtvMHl1HYD8VQ=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by PH7PR10MB7036.namprd10.prod.outlook.com (2603:10b6:510:274::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 8 Apr
 2026 12:26:25 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.20.9745.034; Wed, 8 Apr 2026
 12:26:25 +0000
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
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, ashok.bhat@arm.com,
        Ankur Arora <ankur.a.arora@oracle.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH v11 07/14] atomic: Add atomic_cond_read_*_timeout()
Date: Wed,  8 Apr 2026 17:55:31 +0530
Message-Id: <20260408122538.3610871-8-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260408122538.3610871-1-ankur.a.arora@oracle.com>
References: <20260408122538.3610871-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BM1P287CA0010.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::20) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|PH7PR10MB7036:EE_
X-MS-Office365-Filtering-Correlation-Id: c1dbb9b0-0612-42b5-ae7a-08de956a0d28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|10070799003|7416014|366016|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Q10bUoKKc6eWPjLEts0glfa12j8YBKQ53hE8HCz1HUeu+FzBTJezbOggKe6yd0OvbCLPMl3dRmAWftthU5GiX+vGIjdy0zNV3u6ldbQsSwhrZjZor8qaOxV1h8MEEwXwA4vWcTfQQPQKJa7SyvrgmMEc9B17N5ET9x72+C6ixsJUNJrYd7xgA3xyIcZg9g4oWQ0XHFgQg/gFQSde7XNVlX7NIYmqDVOssuTPSfVlX61XMw0QT1QXY+8nIuyETY8k2Kz3JPqeFiu0CZpuCCU3Qbm+6qPrrEFcxAhVQ//DMeOaivQXc/LkSYB/1peD6cMDJGyZDqSRY+1PflHj3IdAx0RIbv+l5McA4fIP2sqI0svqeKuoAkmUSxjB8FaHm0IKa371bhblP55K87+HmZt8BNkeXzycz0BspI88RCQENi9KtBpMwM8bQ1U1SQUZ7pA6YQjNiUATaTlcRi/pkfSC0grjSNH+XrwUVZee5KMLusPNzWJ1693rfJOnxXN8QWOW2lJEZrbOYNQT/DmuhDDy2qAd0hLSfOoTK/PAlCbPdEM+sAj/0WFJTlj3IqeV0+bNAqNTu6aE40FDj73Pk/0CDdy/FcAEkLE5c5FxuLqHbqxTQDDJvlJyqibAIdC93EXrGiI3eX2uD4HqiYBW+ZU54JanM3lwqWl8yIRHsZKUCIEi9MmBeBRWQKMl9HHeH0tPm/2vSe2S70W4y849v/KO8hP3eB3jsxNTBQcA3x2kjlw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(7416014)(366016)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JSo1b7i+A3Ff1GDrayRiDY6sXJ0r3hdsWjR+OyA/MWzyIcwopkofVa7ZmQ6+?=
 =?us-ascii?Q?Fd039lot53kz8XpKOntwrfxHJMc4yDO5CEdHPmuYVms0jt99p1FrqrSVlpoj?=
 =?us-ascii?Q?hvzYjt5cmMXfOnLiLIG4tTxSpUlNpQgbgREBeFi12HHgLC5ncXkB4qtePlNf?=
 =?us-ascii?Q?L1ao0frKocpRbdJl0C8NOkKSuT8LPTtoCjZKKiHCHyHD+wSthvgvOvc79URC?=
 =?us-ascii?Q?VOF8emPNWyMwGI+zSlO7FB8CJqLwZ1YX22PfmH2GgczXdu7DV+ot0y9SOXyA?=
 =?us-ascii?Q?8vizhXUq7wy3opT62YvHY1z1vnKTsuu4034RN9eqi6eaTQrGtMldTepl2I5u?=
 =?us-ascii?Q?IIJkrFnxxMGbE58q9WTSa7WPtim19OC9yutJf5jkNjnrgvTwXxb5TlbxWIEu?=
 =?us-ascii?Q?hEQGYVCcM8t6mXcxsJRcoCHuaNAK+dsruDPozyTOfQQajLeSs7vYSS7D76W0?=
 =?us-ascii?Q?CfMwcE8Be9a9oEA3ImTRDUhJy+XYOHfNZCfP2YLw9Aiw5XyY0ye29pVtwBRa?=
 =?us-ascii?Q?4m6HtA6q7wqn7alauVUjKfXPOD8dQoj73kBqQ8zCkPBPS9tu3+8RwphnORVu?=
 =?us-ascii?Q?UGGtxB8LAueI6gB4MqMxWzfRdTBykwuaxD5UnWAh/Tzp69SR2LlR5QWkfr0D?=
 =?us-ascii?Q?FBjpcuk4Jc8rAtaF+L6fBhOmbLnEtyQPHTJvYTGXE+ogSX8fh/6AnM5Q1BtC?=
 =?us-ascii?Q?LJ/ivjWLv7nm7m7wR+0gpjT76wPhqLw0mpOw8gnW+zro5iZnjt/IianO64Zq?=
 =?us-ascii?Q?YBxDYR72MB7uZFMP55EMUN9bTdpqrM2J/pED/7MdeCcc9LrZbxgezJfz2/5a?=
 =?us-ascii?Q?PmQGPul9upT2cASDpoyUuNSsckv01J3URSvNJuDl2FHWNjkH5fD9MsGEynEU?=
 =?us-ascii?Q?YAgFOFlAuWqCL3kPdLsn6x4bac1sUN/8shcirrnHibuG/Qoi1tpvoXnEYIDO?=
 =?us-ascii?Q?ASlGl8sZadk7QDlADfjSlG1gi7ufYrMieu3P1jnmhbpiej0DG2G8JQXStm1Q?=
 =?us-ascii?Q?bNwsXlSEAn2lK3nwbIf729B4U7HJTBnXQHyr3uaQ15W97XpLDSCk+SYuFd3t?=
 =?us-ascii?Q?0hgdgc2PqJKu5soJ5zgtOosng4hM/7XpURFZm/BBR0qmfgqtBwTStHmuHqOe?=
 =?us-ascii?Q?lLc3nvYqkxFBziVwU66Fg68+efCzqKZuOfHkC5hnBaN4ESC8xmpgXD7FABf7?=
 =?us-ascii?Q?75EKE5B0eWlB0UW0O/mKHpoDH3htgTDUmARMQ6p5258EDrGNmuscqeH7SSrz?=
 =?us-ascii?Q?1x+CPWWJAR4zwtoJSz02wYDTZg+U+k8rO2RC5EDMPcC1LXDRnSL4Dvn48CAa?=
 =?us-ascii?Q?0AwpRadhvZ9dWopLfaVZrGYsb+csYt4S4D5dRi/FbDU+93EdAswngU2qnnYt?=
 =?us-ascii?Q?x6ghOwsqrPBVXQXVfeiunZTePa3bqm8mc4RUk3vhF1vba40ODOpN9A8eKCOx?=
 =?us-ascii?Q?oX+h65RqVl1uoeC0Excx6wvws6xq9mTnBAHrNBROCqqXw1/fycaNSj8eJk7+?=
 =?us-ascii?Q?wrSNI+MrKwfVu3qto4QBckRbUkrwxlaflXs+7HvAW2mnnLSLEtbWzRgu3SpR?=
 =?us-ascii?Q?f/UzKfvhtLEkJIayuYQM8a3pZpqUwOnnWadRp9ee5x8pF5It32F2Vfj+PtCo?=
 =?us-ascii?Q?OoZNIr9iZH/zpx6x4eVmSgb+arXzk93W+xr1oLALjjOMEs3hSF1whR4VuF3/?=
 =?us-ascii?Q?JdcQTDw8WUhcIvmh/gn8rqWURjoVSoxwBwghZQac3l+Eo60QIwGPrY1cFyLY?=
 =?us-ascii?Q?I1iai0srT8MKDmWBa7/aWNfWOaZPBwg/tGRcGvPLephyGJ+CNevtTZDUj1BO?=
X-MS-Exchange-AntiSpam-MessageData-1: uX0qZu1/8cwgzQQ5FqWCgbJ6k0gMTHyeIwI=
X-Exchange-RoutingPolicyChecked:
	kXEy2IPPstTOjWH6rWdFersOGIRKWeNAMDB2jEqTkkSV5H2mswM3h6y4N9nlrXisYKl7UCVIeo7bsE/osR7neKqcDPtfWeEN0nJSk7Pbvli66NmisIJpAQrGoI0PZqexhCTiZl1TgoDwF7fjjo73wnkF2N3SC6Trz8CwjkjSTIMp7JyBWM3w+PfIscLlXL9CvvEqA8Lr06zv0g0TSgUCdCnt443r+DyvdDEKoc9w8YRhMEd8Wj31klhkn8VZ23wnYb+Y8RQC2Yh3HY8xTT8fnDb2P3M0VEqm1ynZP910thtFI7HeeTM0w3sqD/GXvMoRbaXfGDJW01A0qCBeOWBcVw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	y6zryARQ21CVvrK1dvwwAneu01w+oEUGoBnx8fcRYzvJeWudQ6X5CdfdJW11bJBrMh/43FRqmSKnbSQWPT15NZbGuaRpf5zmExk0NoCi/UJS2C9i1YC9nwcz+G+sGAVCdHkq7gGhE/Ui0IDjqMARmIWDGWoeDDox3Fv3+HLC8XUbEdEbFFNqJaXYvpJ3eJK+ijUeMiCfvC0+txoe/fmT7COGsw9hGgE+L3Chec4rF4KHyxfoxdXGyodw6Ol9n9VeYaU7TF/9yuF4ueaH8oRr2PS4ppirAjdtK2Wv3TINch3WIDPldf2oThUp7s0NJzkP6eXvR4lIhvujx9tBDcPT8WN7EhHb5jHcO0JYolKRPHbyLz1+WPQeY952wXAOloHQqdms3PmoTKWiIV3u10yKD9EY95k7uQpZyZdV7RIXr7knvjCHmyi01GSG2Fi3J0CEFepMywY0A/Qh/FD6bTq8twJCK+oZZqPFuZAhY6ox7HAtOd8eJCd2r6Usk+wfye5zTz99GRSfGIpeoh0Iyajb5wfekgDp0lKWI9FfnksyxNnrnrM3wjxsQCiKlL6MgztXZbUAtGDnL21uqDuwuLa6gtQymteWOXL8YmxLpip9Gog=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1dbb9b0-0612-42b5-ae7a-08de956a0d28
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 12:26:25.6551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ivu9CsHG6NFUBczR/qsNtKlFJYr/Nl7fL9FdZtgPNE5VYHnuqVYV16KaDry4A3IFou0vJqJJhY5SwrUOcg7x1HwmNVghXDbcHxzN7nakYag=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7036
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_04,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 spamscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2604010000 definitions=main-2604080115
X-Proofpoint-GUID: xdKoVv8EIuyrqLUvYXPgaphloWPJGEnl
X-Proofpoint-ORIG-GUID: xdKoVv8EIuyrqLUvYXPgaphloWPJGEnl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDExNSBTYWx0ZWRfX2SsffcmDiX2Y
 R32rEM80QbWmABfINbLBww/Q30s1NuqpmSCmxOikInRlNNDQb8eX/sXYP/CPgbaW7a1K255DeP7
 2PLr7l+p2yfrZyE7KEch3zi+PArBbAvm/WFjHoV5PhnZ4F9epy9liiolPQm9+xOWolblE2+fquF
 bC9fw7bOqFIYH9oPyO5U+0la6nZboroYokpsNMRcIZ30OfPzwaBKCJ28/1XtdxfLcSkdDytSe0L
 +C8XVEFn63otmxzdazXsLRCQDpl4rkT0CO5hS+8ry/jNkEUR0w3YC5fQv1ZOgHiUJjs/cpBpqzw
 lgHC7jmBoph7LXXjpknBG70xINCL6/Z0EJbsO0LpOC9XW4cLNeL/USkrymEgoWxMbx9UCkOIJgR
 abFd7nmWD7TbpE6Pd9nh14k5ptAnpPk/K14tzCbcwSgLUzjn+rJfuYUIN0pj4VvB5/2rEnnP06x
 LYnxlwcFkB5DfBr675w==
X-Authority-Analysis: v=2.4 cv=DLS/JSNb c=1 sm=1 tr=0 ts=69d64977 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=pGLkceISAAAA:8
 a=7CQSdrXTAAAA:8 a=yPCof4ZbAAAA:8 a=RgR6v_fFY-8vhBXvnRcA:9
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
2.31.1

