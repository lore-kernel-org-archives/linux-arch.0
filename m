Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD90D2F8EB1;
	Mon, 15 Jun 2026 07:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781509304; cv=fail; b=eJQLCtCrgTOIygjJ/aKcyeYv+dbds7HhxvwvsReG9iCkQagWoqCJbPWF+dl4NR2UeJ0xxZit81nyrVksqwkqGNPo3yyLQXxhrH6WszcXNqdr6DLd8qOuTOW3Pb5MLBZppY1cvF2yjUzgpboyAIxE90xZ2liWZfUkD51jlA0ygAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781509304; c=relaxed/simple;
	bh=pAVSQhGD68uj4tN1ig4mkEPjmJF1WpOHb4qosWAiwW0=;
	h=References:From:To:CC:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=XiNfu2uQHujnTxxAScVJZcwMFxdvbHmirEYBKYB6JYct45CBbyG9cmtZEjdka+N+Wx8hXkfxRdTWh7qVKVROzlOfxz0NAEowd4qd5v9qxhg5UVW+rAiwCi7xEect9/BRCOolBZiR6r+bRDa+UpmwmOoPZUnqftGL9J7Nj9nZbMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iDD4v4R8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Yss00F6o; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iDD4v4R8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Yss00F6o"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65F0DNPJ128192;
	Mon, 15 Jun 2026 07:41:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=VIqr2lLNzws3Vp7Esb
	t3NL7r84XXe+ErVl1Fgh8eHs8=; b=iDD4v4R8BAJWG4lhFLKHLJbfBtOLd3QXTH
	XiP5eCGezKhGNh8CszazO/RF6y91wgRmevNp/jeUN+7HSJw/yWAQceJeuZ9TQLAF
	YLg+5TjYnNvq+jKdpcnVqCJJ6V6HmQKpr97+9DGT4CiwuF8RAQ6zSXcGnsXuiDq1
	bnlPt45Fsfyuk9QhLz85HUaf8PjH1XGgmqrZBHZzk2MtHtQoeaXXoRnwnU36lMdw
	2JMGn2lZAFobbqYq1P+KweMk9odKsaK3CEa8WIgqdRzMBIb/IrpIX2q0a5DbGAXt
	uzPCSYI+kZH3E15ByWFvrp3s9bbXiWCyHHKG3gSKula0MSUHXogQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4es182a0na-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jun 2026 07:41:11 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 65F7c59r025633;
	Mon, 15 Jun 2026 07:41:10 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012008.outbound.protection.outlook.com [40.107.209.8])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4erwnaun9p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jun 2026 07:41:10 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZxBuAh4F4FgeQ38VRpTUnoyKXwptR1qchkZwDBDdr7566z9eMJGOPskEpu3OEKOjwbHYg5FULGP9MkxJLAtP7fPZY6T0cotuvpB4BKEXf6x5Z4j1cJkw39/ZACUOZmtD59axcqLOlONJz69C7XdZjt1qbOd1/BFPbKWDgg0f/CzuVlYUKlNutqkjKSFDq9aDi4MyicXjaV2N+eAZ5FRuoNXTBO5EwDYs3M3QHoHqpAaIzJbwdTPtxyqMyLVcqSx11KthYd1LqapvRpuK117S8zZXJOHtWaaBvzqlqKsRl2zA/4vt8g//J6XAZ7bzIfRFLjE4T8cg/kq7gfDbrUyv9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VIqr2lLNzws3Vp7Esbt3NL7r84XXe+ErVl1Fgh8eHs8=;
 b=g2xNuCrXjgbg6DKeacZq27UsWi6IbSS/VcSh1M+CgF62UpIhOo4fQft963IsoGaUIJT0p7QQAj+moH4yy1z6FwuiPDXkv5Ki3dWoeNXb92BU5pfl8RFY8M307+G3SzZUEwO4fGlC+OSGd9i/dnG8dgfeTzqr2SgyjyZFhuduYMqpORHtQmkZ9pArerkTXvsY53PSy85ODQwbR/R6biN3ksJDCxRfjI8DBnMZ/taw5GACXTpwlHzAGxkJNrJTpI01+e0k0Vy66g7psqeO+4vI+arCaVA305NMsn8Qg1xwpTSfY9aD5XXAyb1ed4OLkprN1dKv9JkuM4wa8o/VRQpuEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VIqr2lLNzws3Vp7Esbt3NL7r84XXe+ErVl1Fgh8eHs8=;
 b=Yss00F6o2K0PKV5O5o2NUHsedf/jPqu6sS+pV0uMwtpmWZiosZ8alZJXzv0sLl6oD1/o6kokfjTwFZyeDgvDH08PhRxtRFLLxUMeqt91HoqJ9MH2ORBjJ2ReilT63AJ5334lUDJ4LitOIrJQHUlK9/5FhPiSJu1XQpN+po3u3Wo=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS3PR10MB997702.namprd10.prod.outlook.com (2603:10b6:8:346::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.18; Mon, 15 Jun
 2026 07:41:07 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 07:41:07 +0000
References: <20260608080440.127491-8-ankur.a.arora@oracle.com>
 <20260608082304.ADEA61F00893@smtp.kernel.org>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <bpf@vger.kernel.org>
CC: Ankur Arora <ankur.a.arora@oracle.com>, <bpf@vger.kernel.org>,
        <arnd@arndb.de>, <catalin.marinas@arm.com>, <will@kernel.org>,
        <peterz@infradead.org>, <akpm@linux-foundation.org>,
        <mark.rutland@arm.com>, <harisokn@amazon.com>, <cl@gentwo.org>,
        <ast@kernel.org>, <rafael@kernel.org>, <daniel.lezcano@linaro.org>,
        <memxor@gmail.com>, <zhenglifeng1@huawei.com>,
        <xueshuai@linux.alibaba.com>, <rdunlap@infradead.org>,
        <david.laight.linux@gmail.com>, <broonie@kernel.org>,
        <joao.m.martins@oracle.com>, <boris.ostrovsky@oracle.com>,
        <konrad.wilk@oracle.com>, <ashok.bhat@arm.com>,
        Ankur Arora <ankur.a.arora@oracle.com>,
        Boqun Feng <boqun.feng@gmail.com>, <sashiko-bot@kernel.org>
Subject: Re: [PATCH v12 07/15] atomic: Add atomic_cond_read_*_timeout()
In-reply-to: <20260608082304.ADEA61F00893@smtp.kernel.org>
Date: Mon, 15 Jun 2026 00:41:06 -0700
Message-ID: <87ldcg45f1.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4P221CA0011.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::16) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS3PR10MB997702:EE_
X-MS-Office365-Filtering-Correlation-Id: 38c16f26-a80e-4951-c142-08decab17648
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|23010399003|1800799024|3023799007|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	WZk8Pt1DVZUE5xomvkSOnTg9bPg2Q1pzW/QqrGczllKKPExe0DUKUZQJWgFqtn2JIFeZFCu/MOItTuY3vHdsBvi2iqHfKUgxQRZ2kUIC1Rl5n+8L56zC03oZ0ngQe1fdRqmv5e9pBYU7sHfecoDbeo0qrsgfXTg2RDwI/3Ct7H7sgrybOV4owq1c9/1K+qhKlaKo/rEmZ0+I9MnhgB3FhDEScNCkfiY59xWz2nHKhHLyGAFJ+qosT78CDmDFto+waUTQ1TISHTFIEwY2hNxMNfjt1/+ilmbE9VLbbAKZXGc43bOuIPaiFbPEc/5g2w6bsUghiSEGKgk5TFLe0CJ+2s9lKmlXNcSqVJHTHBMZuwTRBrmgCobr/PIVeUPGu6z9FMemlynZclv2wZxD9GLTcOArYLjL3QSTecabsxEca2KBpiUCbc6LmtSjlsyRClOgDMr/585qlVSHLM21/i/TyaOcikSfeCQMFWQ4eIdcXMdAHid5hNscSblxfCy9It1UhhJiPRbYdQ9WVYXn4YeOp7kAQYjBFVPTRLYsyW/qIXk+kuJw3Nk0B0rLO7XLvkaL5zzy0xh/DaJnueRl8lJQd5vYamkKM0U4H7HvJI9n8sOCSjxhjecZqnf2RLkGio7jpVzxD2XpeR0Qh3X859kPM55PwaZe8Phpdsi2s8m5KPpYm1bodj1nCfk6vxpCFvzH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(3023799007)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hEqp3qa63Kq5MOoRuQ1+T05tVRJt9xQcB641Do80Q9XOnap1Mhdc9ZTmMajT?=
 =?us-ascii?Q?ohPKL8CK1yD+zR1oUnztXUoMMMBtR/F6NlDDYY6H8QDTYB0R4uLoB5jvYdZw?=
 =?us-ascii?Q?9DtELGxA5VQ2FXrkRTuIOy1d8IgNi+HJRfVM4h89yoAa+w77c35mkRN9NE+c?=
 =?us-ascii?Q?dic2v513mUycriolhuceHS6uW/tZLW12CDr7eNLb5XMUMOQRUXKOVQ5FCUSY?=
 =?us-ascii?Q?S3PX5BAmAL5GqreHmhh7IJn1Mv5pZgiTmcuExBp5aB5+CXgHI+w8+AmcV3zB?=
 =?us-ascii?Q?79mC4zU+s9JZptG1Qt0Sd68ihG51013wjvj+n0Yz0kDoOoXcTAx7rv5y5AOm?=
 =?us-ascii?Q?IXaHJsb2Jd5MQSQBVFBCYYQWE+fJxEUwy3oks4QEGyu6bQ3hcZ4JR19DVDqw?=
 =?us-ascii?Q?LkWuNljqC1KsDOwlgVjBJ/lii/93qAQN7pqT8O114fh7qLwUyZaL/eNs5p39?=
 =?us-ascii?Q?BkezMnr7QCdXOxNWualAiqx79/fckkDRAvnen2wszCNTtn8PfqEgljGpSmpx?=
 =?us-ascii?Q?GCUJlBERjkOD2IZS3vKcg97E4AQiXPxtLr/DIrUknU4lKFiB/COd11aWTbiV?=
 =?us-ascii?Q?jni6FEsyyTyl3/pkjcU5Au+kkyhF3XWM0C+JtcJKgjVE4XH4q6ttGrCCEt2m?=
 =?us-ascii?Q?0WuZmezg98imGqoeMM/pwppIFJHm5XdPeA083U65qi6NQ2pscKDhtUBnU7hq?=
 =?us-ascii?Q?kE6d2j8skuZA6RNAb3Xoud+NvH+2HV1kS4ksWR2mbBLqc8+LkXakhNBUfPhY?=
 =?us-ascii?Q?Vadnj6x8FR2MpMkolReii7cTxsLOxM9qxzK6KFyJ6NokbLsy05TnUWocKMnq?=
 =?us-ascii?Q?A25b49xcs65lWhDdy7D8ypGIqTElq0QC9voUF7IUxWwbAkFsCFNCCQdvyay4?=
 =?us-ascii?Q?qaemgWKkpDEZfg2xAca5ita9UPyUzwqcmfLNL1J+p2xoR2iyYYAJjdNvaxLF?=
 =?us-ascii?Q?28o7qjqpD9ueo5QqIowaUacz/n3LDwww87qR/iMMDyi9rcoAg7HIfc5oTzDO?=
 =?us-ascii?Q?fGqmiRjZ5ATKERtgV11Ck12HFUvJX9Fo7QJ5OT44taUVe7m50Mstg5mfxq9A?=
 =?us-ascii?Q?5+shXhpBnLMYcaVvTaBVd0OUzl764eQ9LpKF1lCBpNFqjeXSfYk6YktWuxgX?=
 =?us-ascii?Q?BdChGHwjd9Qqj3pMdBc8t1PWpyTIevMDtIUGmqL9TvWJrBBLlol3fio5IB9b?=
 =?us-ascii?Q?cLKVb0+PmOjQsahlL20yUF1CKYQXjxn5HQKcgwSI2KS3igU0xGda5EgVufqm?=
 =?us-ascii?Q?n3R+rOxZzW1JvjVhAALzpqTbsScPve1kMYlypsARW/sMXt1L0yq9Zo4i5gng?=
 =?us-ascii?Q?CEQqBJ4nPrNaD6CMP1Qc4Mlaaka9WVzVY5ZMtPMqNoWx1+5t/vgSCCG6YNxO?=
 =?us-ascii?Q?zelll+ejiWHqTQ+cskM3xmsEynza3bw8R6Uh1kyEM5vclJrWvsWr8ZZPG3tV?=
 =?us-ascii?Q?EOEN5jPUu37olBdrQ1xWSnbu+TFuFaEbWCANvP/7OG9NfRaDZRo9N5SuoGXY?=
 =?us-ascii?Q?MiYvZ0O+McZPPBYcxax71UUMrKPP+/qZtI1X78tqfL5kG/MFyVXNXjJ6QUd0?=
 =?us-ascii?Q?HoLG3cCk7jPnrCXAdwNfAJqarsi4vpP4IRxqwc2pAshjr3ppXukZcLGqT9cD?=
 =?us-ascii?Q?PODccu4hMuyinG5FuBRlOmRkhzkVEOTRt0xNKbzL8wH80fI87OYwniz5cJQS?=
 =?us-ascii?Q?zRNmgmNrvqvo3KN2J0TJDDCJK68C7fSo8u3yS9kfXKf5aUDTqBYissyLptRb?=
 =?us-ascii?Q?MNNJKx6C+A=3D=3D?=
X-Exchange-RoutingPolicyChecked:
	Z3v7vWk/tlUgFHjV4PcicmGA6SqpNngquL28XecGLNThy1Ya4vM4vf8LtqE3ezC3SJlB2i/411xNQhJyf0xvrwZm7mRRP7OUiS9pcbJkCKHIxaF8TfVBcnUj1CvGMlkM5iVjPJcPeb4BpqoR6BUToQV+CwsRFali9QJhfZlv5niXone2P5BWlP60E/zjI7giMrFznzhsRMxFfH1SndDI45lNApMytotU/h4vk7Hjy7kItJ+bfwGIgtcTGqF4iK+Nt8WPwNy3IWA7tvLNj2b0wKP1b7zATcHMhBHSyeNVbL6rREWoQISQVrRaAvQ0bljATt/PH7woHgKUKzw7c2YpOw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XKI2vKQ5Nywb8Dduj7QR6MykhwQN8vYPLu/XbusrEmAhf0uV+hMCmpj+QcNdkiFSUzOwIjSZhKXcTvHQT07MG/VjjFTQ86c405+wmQwgWO4UDDlAVoB5VF+hCEGtUw5as4NhL9d6C3+GmHZj/xGsBRVJvKIBydCZdt/v0xRDefxfS34VPSxbijKeZ/PC+wtBog4lSoyrZEc6JpuV0WswMCOSsiEXrsgUjDKE46SHqZ+5Z/gELdMuPJhb3wT7b/t1poFNOkRkMC4PdQPU+8AbEF7K8/qpOKZU7rm2lIJYdCuJNM0aRqL5scfHWMnAVluyx7Ex54eiRKkGODnrrk7wW0W9goHMa6C1qrzxPCXLmdJ6pGkvJwZVYe6MR+6T79q6IV3Xz+0K7Qp1XyaXIFRAEdKa/WJcMyRmQPfl75MkTbi9n9E60xdq8B5C78wauijDJbKEut0QptkVbZFomwTok6pdLe58ctlDOIM++LBRgtcX6IpkszC1s6bUYHrc/6GwITwgWzamrI7sBCAo3CWalca1BhzsXjlIsfK0cgetFwA8/l4exXhFNydpbydab2Pa47Kq99pyTalRJih/xt6Vr41nlLGz6KRhzIf1DDq8C04=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38c16f26-a80e-4951-c142-08decab17648
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 07:41:07.7259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I1IZqoz9fjA9PYYmOve0I8TplLIitZ+jsRsOqsNWW25dm8mHbm+H3FifBT5OqcnowffY4VtKSmNbXDdSGHs5JFTmNzEGNL9N/OodjG14ilw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR10MB997702
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606040000 definitions=main-2606150078
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDA3OSBTYWx0ZWRfX3ALEzD2Vkmr0
 RdirRJq1v57OE55Gn3sR9SCNp1jBPJsj72NjYOekgNWqLTc2s7nFMP83haiB1lcteeij2YZ3C91
 2KTe4OHr1VMH0jrCzRBi0/W8+jydoKJPtoLqjB2jwBZFfBWRdGWK
X-Proofpoint-GUID: qZ0mzsSjYG6wVdIQUs-Y0N9kJsxTuXAc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDA3OSBTYWx0ZWRfXxf1DUKQOvRNQ
 gpLqwHY9wupw8sVBQN0eJ7oTDOCZ2hMilGK5Rzo1/rjPVmIvrPLhNcEKL6S8aFWLCI/qLjP199w
 +c0uLRZ2pbvjdgdeQsMeRw5kaOm6nCdxYbYuHtzdb4uPGowhLH8KjPReRJJ7GsXqVHM+zXsp/rM
 FEBwqT+Dwa4K5wkpTk+PwnLEyz2qBcs4gEn9kfmyhZS/jXwSP3SqRuqhTP0KwKDMkxUedofNfa8
 k8P2OD725HGKLaS5Pzvn9TrsmTjPECl+gutdow7T2aLzCnsHpNz20OjeOI7yGLokoCDpj6OFLJe
 HG79dN5X+1473BF3UvvS6zVshw907A57OMnXFmahuPPTlI9F+/S8OPUimf5NQ8EcNYDK88xjsAw
 XlUhc+dxGlcVgsMfX7VZpxg+JIuPSDcjwxFwvtY6f8mnsKTNnwpWTxaDxhzCh4SxdsKH9RrdWRB
 FgP/aVB8o4YBsOekpmg==
X-Proofpoint-ORIG-GUID: qZ0mzsSjYG6wVdIQUs-Y0N9kJsxTuXAc
X-Authority-Analysis: v=2.4 cv=Rr/16imK c=1 sm=1 tr=0 ts=6a2fac97 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=FelO9ux0wxsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=ZWAEARqisQ1DyculvbcA:9


sashiko-bot@kernel.org writes:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] The `atomic64_cond_read_acquire_timeout` and `atomic64_cond_read_relaxed_timeout` macros can cause torn reads and synchronization failures on 32-bit architectures.
> --
>
> commit aafb3af0335d368d82aaca86bf6b2a18f8ae6033
> Author: Ankur Arora <ankur.a.arora@oracle.com>
>
> atomic: Add atomic_cond_read_*_timeout()
>
> Add atomic load wrappers, atomic_cond_read_*_timeout() and
> atomic64_cond_read_*_timeout() for the cond-load timeout interfaces. Also
> add a short description for the interfaces.
>
>> diff --git a/include/linux/atomic.h b/include/linux/atomic.h
>> index 8dd57c3a99e9b..5bcb86e077845 100644
>> --- a/include/linux/atomic.h
>> +++ b/include/linux/atomic.h
>
> [ ... ]
>
>> @@ -31,6 +31,16 @@
>>  #define atomic64_cond_read_acquire(v, c) smp_cond_load_acquire(&(v)->counter, (c))
>>  #define atomic64_cond_read_relaxed(v, c) smp_cond_load_relaxed(&(v)->counter, (c))
>>
>> +#define atomic_cond_read_acquire_timeout(v, c, e, t) \
>> +	smp_cond_load_acquire_timeout(&(v)->counter, (c), (e), (t))
>> +#define atomic_cond_read_relaxed_timeout(v, c, e, t) \
>> +	smp_cond_load_relaxed_timeout(&(v)->counter, (c), (e), (t))
>> +
>> +#define atomic64_cond_read_acquire_timeout(v, c, e, t) \
>> +	smp_cond_load_acquire_timeout(&(v)->counter, (c), (e), (t))
>> +#define atomic64_cond_read_relaxed_timeout(v, c, e, t) \
>> +	smp_cond_load_relaxed_timeout(&(v)->counter, (c), (e), (t))
>
> [Severity: High]
> Will this cause torn reads and synchronization failures on 32-bit
> architectures?
>
> On 32-bit platforms, atomic64_t operations typically rely on spinlocks or
> specific instructions to prevent tearing. These new macros bypass the
> architecture-specific atomic64_read() and directly use
> smp_cond_load_acquire_timeout() and smp_cond_load_relaxed_timeout() on the
> counter member.
>
> These macros poll using a lockless READ_ONCE(). On 32-bit systems, a 64-bit
> READ_ONCE() compiles into two separate 32-bit memory loads. If concurrent
> writers modify the counter via spinlocked atomic64 operations, the lockless
> polling loop could observe torn (partially updated) reads.


So, yes 32bit would run into torn reads but it shouldn't really be using
atomic64_cond_* interfaces.

Those interfaces are typically used via atomic_long_cond -- which should
be using atomic64_cond_* only if CONFIG_64BIT is defined.

Ankur

> If a torn read spuriously satisfies the polling condition, the loop might exit
> prematurely with a corrupt value.
