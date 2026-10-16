Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA223E49C2;
	Fri, 16 Oct 2026 07:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792134615; cv=fail; b=kxWLoK2W2n9AOJ8v9hP+oUblRNIWSZ1q3dE1Tt4gszzBQmXR/rvkEb6hAGpKV2lKUVX0NCYr0oE4Fkapp6iH0Zs0wbAY8reEwtO7y7EemFA1Ogo32VS+EF9I3plNayxjMw0WbCPDME9P66SxqzoeOpZdtHbLvII0Qn3cms+RQCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792134615; c=relaxed/simple;
	bh=niO7PAfIdXDL7aZlntcSTrB1Fo9s2AauYzQjLovqEjk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P1vhu3pBYP6TvBrSDgtnLWb7bwyAp6vScd2UXfZoA3kAdGSbqlD54YlsnxyZ5NeVDw505q5WLH5ymuLgTdbLmKcb7h650FhBKh5YCLCeag0HvHcGKEgRSw+Y+NEuPSEJvkIAWmYEdZPOCC/w+0GZ6Yh8hTGpM3Tx0DjsLHYeL9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oSdsgwzH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SJ+RkiBi; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oSdsgwzH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SJ+RkiBi"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69G0bO783626294;
	Fri, 16 Oct 2026 07:09:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=5dm1iIxZ2G4ktHr2O9UfmJSWsMnbl2svdmCo6KaK/bM=; b=
	oSdsgwzHEKL/YQFU18+ee0mvMP/FacA/LlvDkHBhDk0D8wyWDd9dZHYf/6dB7m8b
	OtTT7rWmg+3eFag+A6Ejtsx6OEbQRqmXgpjgVe21ChtOfU0MYDZGfYuUyI5lVIIq
	EJupnG8VbNaXOZqzij5ibbFYlxvcJ/yKf9KIVHLJ0K5ThmZ3gRq7P8TfVzDzCIoT
	ncLVaMu1+GdYH70Jy87oTdBN8npYZJHiZtmNRD5XUmYMFX+Sdoa9h3vmAbXTegXR
	zjmnyqSCfkiSm9faEDASqcEWAdwVVR1cAdSdMDDW9M6WHDBkpBj368hz67adC5Pe
	zLTd5g+d5fGWVDqvLILCXA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4h7dde1mem-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Oct 2026 07:09:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 69G76CQC027851;
	Fri, 16 Oct 2026 07:09:37 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011014.outbound.protection.outlook.com [52.101.52.14])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4h7btd3mnv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 16 Oct 2026 07:09:37 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nu9lKSIG7pcmc8z7cA0THsUD/v/tKulq9PtClItvCl3Sqr08FmZ7H8LogWBsvHu7JXpk5P7OaQ+5ohttunXBX3X5Yz43AMidCOVkAmKMFsDAn+6ElMA9oSTDL3hLb+woIP7T25ibzNMWJWb3jRTKgp9wJ1PG+6JY+ckjPzYKEhbwS5vf1bJvgJMSHh6Ds9RmlVpETet/urlOOLgwH44Hu0UkhBmX3tpbFObSvQZXHWmBZytdjJd5Gnz3WGkKFYJa8uHQok3lM6QpVMeNs1ikxRtW2TpjkkqhNayDOrnw+0J6YkK+tW77F+T65xHwrDlk2xHNeuHZSsz1DVhEYg6DKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5dm1iIxZ2G4ktHr2O9UfmJSWsMnbl2svdmCo6KaK/bM=;
 b=UjutVUm3kC/6vZ4pYFX5NGrmnr7He2wVxZrxqY56dpEVT+iJGVizJBg/AI4nnsh53+XUBfbjZpbrB+ETIuZATdHfUXR4f4eWtloeD8+DQNNIAbAKRr7XPzn9lcGVpr2GnK2lPMN/cx0ZkztJWekmch1koU2CgHdjKNAz2OEiSzIQX+IvUZQ2PwXFLejY/v7z5S6S31RBpzATEG5tHON2O9RmkhTYS/aVDgWHufrKWToWjUtwhCYqk1CHxE8u1T3B2gDfFheld/jk1eo7QABaJEqFZhhcM5KsBtoW41AOVWSJpNURJSdUTvI/QiAKL8sT/dLQAOKrwpVIeAqN++cwkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5dm1iIxZ2G4ktHr2O9UfmJSWsMnbl2svdmCo6KaK/bM=;
 b=SJ+RkiBiPtRiY4+Dc4/KZHkAOjwzvvV2wjeLRroewhXnh32EpTREdT62/RwjinbbGye/CAdQpjZcCWvLeA7WD8Yu7lLM11mZSA4K/uen2Fz+SbFD1npRwfdFi0PEAwzMDaafCT3lDyCE9QYrn6fNVi+BjqX8wOiJ+doqpRVFOdE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by MW5PR10MB5668.namprd10.prod.outlook.com (2603:10b6:303:1a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.7; Fri, 16 Oct
 2026 07:09:32 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%5]) with mapi id 15.21.0546.010; Fri, 16 Oct 2026
 07:09:32 +0000
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
        Ankur Arora <ankur.a.arora@oracle.com>
Subject: [PATCH v16 12/16] cpuidle/poll_state: Wait for need-resched via tif_need_resched_relaxed_wait()
Date: Fri, 16 Oct 2026 00:08:33 -0700
Message-Id: <20261016070837.440748-13-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20261016070837.440748-1-ankur.a.arora@oracle.com>
References: <20261016070837.440748-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4P288CA0064.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::19) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|MW5PR10MB5668:EE_
X-MS-Office365-Filtering-Correlation-Id: 4022d183-eeb9-432b-90be-08df2b546d82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|7416014|56012099006|261009223027099003|22082099003|10067099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	1NGm15XkBkVNfJNdhnnDjmIHatXHSpvfPENbWKJYcH8gXlxeL20eX7SvThRMp8qO7zleZ8nBZJIYHiie4GJIABwv4mot0ebzqnt4xx9H4k5CrpF4YS4CJWe8a9RJe2urdrWmsX/caxN+kSApHmfaoPNQSx5tXym+wRxCR7ox0ZxEwBscfx365zMZyzIE6UxAbgWr82u6fb6EFSK9ylQ7GKXTNv26cd/Pje2h4uuYNogq3DKIFCFlo1mJJdDg2tohgB4jMfNh3vXIfXcc3DHXBHMuOQZLj1co06b0N5BE7IC1NTgWM/faKBmVft7YL4SwgGRmakWNkZFlDxigyCuF0GhqJXfEcY6uquwS3Tt3fGdoCq4hQSsQvlcUTpMP1Q8QyFVHrNiAMF8ZjmFf0ae8RHlddW28WnZlzDlNHCoCepU06GXBDxhPV3LtHi2GfZCXAtLGWZ+o1nPc8KDY5dNbwSQ4jIvGBeEvapzkv8gCcsSm4QJ46+QYPf4Xq4GMqX8tqSieMNYeclcf4aHhpl+uiBTZZw1Llfxk1PR48lx7s/gGlZT8KChqLV4gqsDeZJbkTP63rFrgaDte2mHYkF8//Azmbxkkho2t58snZTg3mVHzu5rXuMEDA53+h8X60fEIgYaiv+NkrCHTltYa/KKgj+DnVP85LYsdirkhi4u8mpo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(56012099006)(261009223027099003)(22082099003)(10067099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+CSOTK+L94aqpwQEhu7Ihz+awgB+W5n7MmCQOtEBLCkeWYYGLD23cOKmTS+8?=
 =?us-ascii?Q?jVpJFleEh5JeGZvVnP63hPFpmQOxU3U3Wh6307QHkQP87Y4UKdxQq1vnXZq2?=
 =?us-ascii?Q?Lh16Qvv1SQTr/EIUMIWHM931BvcpTCybb4QBuHxAnfOesmRpXMwriGaIqg9i?=
 =?us-ascii?Q?wL1/M68sVqo+RiSZ9kbR+ZADzAfnhZsiviT4Z3Ig/k17yoxqQq7Jq8N6dRVe?=
 =?us-ascii?Q?uXXkFW8PBRlclz0sU4Kj9z+ODke2hjjv3ra0+YpiWxcLI+ZvkWTvFOviH3JZ?=
 =?us-ascii?Q?6sM8lpdOH+5Sl6J6IJM2T5JmaDje4CUpr65ZrYRdpOu4p6e597L+79MnUch/?=
 =?us-ascii?Q?4atQScQ3pqOaIHnWaz7YOuTw9TI2eFvNL/YtSqnXAvc95h35rXSgohHN+K6N?=
 =?us-ascii?Q?I8M3a60gWHmnvqQpcPOLflWy+d1bFsYYhbwzCzQPP38YB7711gaxQrt/TNm0?=
 =?us-ascii?Q?6bNqTKafAc45fa0fBtGgoGqwbrtdg/hzUEORKnbt/Oi+KkNqAqAdPlRfTqL8?=
 =?us-ascii?Q?VhmaA1FpuEfwB2cyzgeG+3YCnn4AGeMtgrZxYaC+y6JwlT+TrZik+c6DtMkQ?=
 =?us-ascii?Q?XgsvHFt1ua33xMa3+r7RPPg/TwQxidN7nmD8dv2C9amIzKXoysPdN6ECkb6O?=
 =?us-ascii?Q?D9jiRzvc47q8cRchGuElnw8FwfPcllK/8wr2QJjiJtJDNyR4h3nNxO2gZdFG?=
 =?us-ascii?Q?kb2FyDfNxpl5jeThbwawIBLTUWlF5IJQJhlGz9Rw3zsLv6Kfrs/gdwAIUajU?=
 =?us-ascii?Q?le09QrvvhxKCOJ7LYd+wG1cD08PL+bdFmoi6UZCIMfOfmWhXM8d9Yorp2HFe?=
 =?us-ascii?Q?9+Hs3cKRbrVXXDzc0TuKUOqdfP6O+6cwpKLODYX5caHTmI0Hs3GmJyCpjdN0?=
 =?us-ascii?Q?RTt1UrKfu64NXMrBUQ14UqrvL1SwQB8qMlSWYBFblAy7selLIffeD+bnpIsU?=
 =?us-ascii?Q?PCKEnTA/oW+UkbwpDpM5s9yCYzMmUCMmM8B6f75nOfHL8nHlKvqoRS1AcA4l?=
 =?us-ascii?Q?sDQ81B9CAhJkQDFR8QbqA63tbZsfmuJhhMJjDgwYxZ7kKHsT29mwIfcxHVW6?=
 =?us-ascii?Q?BMPcSVay6RRs6tF564NLHye9F8E2SnPKVHTIXsSbD/MvfwW/dJlXF8I1mXSI?=
 =?us-ascii?Q?bQmWDiQZ5L+YU52/iABik2KDKY0l4U1knmZqy6bKz7HTerYLDmEPXAyjV9uT?=
 =?us-ascii?Q?fZ1TxH6aRJMMwZGrPGrw35qNLwUPeMLijVS8W8sSMr7D8PtX0dAdncRGC3wc?=
 =?us-ascii?Q?2OWqoySCLnLFuAch/N3qRhG2pLmvyon3cPhNXF2J1lLOXs4oA361nx+w8ry/?=
 =?us-ascii?Q?3z1ZGVnUXQ84MZeQcEi/lij0xlqeuRmuA+4lVaSlAK/t6/Vtota3xQowArzd?=
 =?us-ascii?Q?xWSNcQPmx43AyOy47Hy7qxbkfkAQnvP0b1cAdEDTSWfLAdQ8fw2D9ON3JqcK?=
 =?us-ascii?Q?laqJXd9OY06lycYemOnpecoeF2D7QB3kJ3XWWFFmGDl6w/n+N5Vfdlq2QuZj?=
 =?us-ascii?Q?tUL639Bymf5RxFe0RahRq280tXm5oEJqgG5m6IeCggnzI3kSUYRdQ5nEhxdV?=
 =?us-ascii?Q?DN2cZhNMsGmBCvb8c61+V2xU+ErUxsz+hMSFLDVne0yIcQK1Ja5OdhR+eQ/q?=
 =?us-ascii?Q?cOsjBNtb2E8pu4iySQXbyjB6xlDY2fUPbuRodaYA21pUeVrdSZBATrQsrOQy?=
 =?us-ascii?Q?TFQtIwL9aziPkBIcRR1DD+5PyipXNNHjLyLHTgv+3uTZXLvRXf2fDILyhVi5?=
 =?us-ascii?Q?95X9gyo/OnCFJmCFaeh/W+iQSkvOoDk=3D?=
X-Exchange-RoutingPolicyChecked:
	rc4CRLAoAWdx1NcVpNDovXoCtuWNTI/Etm+ufLl7CJs64UO6AY7Q5HSACobqxRB2lE3VTKyrIkjZfEnXzpzFUYJdk+ejaHfTobxovWGO+iaYgNmBzbW+a99gCMQ703EvNZbJmr8V4uKoppGVkpmGlbIxOESqO+1b78S35ezZgJb9TORqIjmBhMsnPMDvy4d8+7YRKrCIZgoD3ewF422guaPBDzc3Vdr8wmDlmaucoIaNXWbqPNLSSspTsM7vcsv2fmx1OyN+7QqSDXjXRLoxsBsNJKBZpC7YyS31B1fw74rTd+m5sU6esX4UhbmyBiQe0QxxxA8PX2gOpdswtj8mkw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HyDOLGe++WBHw+cORZH5B7XYY9H3f21doGJ8y3aVglOgHFqX2nuXEcePFY6IRUimX90KvePGLbUWv8LX9Rq3/AMZab9wvqWX54UQc+bGi+NNbf/pVw6EShEiJVAcD1JRy7XslCX1RCeBAVeCCtM8zGBf4GKAdcJTLPRBWC9sRGjCPgtGEqbTk5oSRgiQ3mBGBMLfv9U5g8Pz/ftLARDXqWDEy+Ls5ArV8gdzv4YCBmc2HpjmLc5mqx2eJUXCqyGRCUWFOgQC1L/v8TcLbdqG9lDIHGvksMa1ySRydk/cmzFe6T4n6auX1pa1SxjP/c4UQI2yBGCc34dEtjc/Hjj62y4BjkQ+ylBg9M8KGAWQOdvnzcT6Jlwh4KTD4Ydta20gZU9zVQn/IotoXpWSiNknN0Dh7aArCPYMTzQHnORpf+BVJO4KnWBWr1urxJoHPK9/af/O8Olw4s8m1REEEfia0mwnuwgNrTQ/MqSg5Ku8hOIRLvLXLqDD7RVqRupQllTt44rEe2ayIskngnAwQ+7pyUur8IxeSB4jrVPdCOW4kVgp16mE6sVKxjbgJRPxXcZ5UfC8ywxJaM+KKW/u0uPSMZK0lumEi0N+7HiWDTcjLlY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4022d183-eeb9-432b-90be-08df2b546d82
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 07:09:32.7219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qHt9ylodtHpIQLfnIhJklVqOIP9ik1TViddmYyjASRCOKAuaDrhUn6pXrFA0JDjDbsb9F+SyszxuEj4+tCC73D5Jaj+Ap89sH7RNgknPXUU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5668
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 phishscore=0 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2610020000 definitions=main-2610160028
X-Proofpoint-GUID: tfxOYAX4qxCjwxivxk5nUdVBJFm9fMjg
X-Proofpoint-ORIG-GUID: tfxOYAX4qxCjwxivxk5nUdVBJFm9fMjg
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDAyOCBTYWx0ZWRfX0j6sdZdijLY1
 nLqOVygJV24G4WZxrTHgIFwwPqfBrlFMUTS9NGd6BaLqtUOJmKhjOGVYBoG3WXU8sVZcXXeKNgU
 TTAxK5KELDw3l9EUgZ5i6hkqNCHDu8J/mNsoi677Wu72AqUm2Yll
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDAyOCBTYWx0ZWRfX13u1hu9pJBI0
 ffTZIvlVl0xyfA5lStGk6hvA/E1gqHmowwYzApHGuBHDDxuNtAz5qWI5PYjwiFoD7qIfiom3WpY
 zfKda8augNDAIuC/xV5mYp+3Cok1hOJ21WhA1M0/1535KXOAMufug2MQLoVM/b9NlCAt2pdHVKM
 j1YYSCKAxU1YqjkoN1sH/BkQ1o1EdmxNyS3USwnPWoXeKyDTSVJiZJidh8HWE58AYpKe2yzU/Sx
 hkp1vUZdJPSzSIlDeBz1x7Qs3i+K13A6kB/cD0KF7NT+UEM3O6bDd/ww4KrKybX5/4yl+vHr4r5
 VIu7D6SEMC56XGyMeEVxaDCMFaF7OM5EYms0B2LnBV5Wu7eE2l56z1k29EmNiK9fFCXsFS14Pb0
 RfigRV7O8VRrao+VRByCRIlNv5JE4BXFHN1GC82Y1eSISYgJhtvZcu/YnlEdET061zFBHB+rMOt
 EdKqyPhzGTXGH1fwxeg==
X-Authority-Analysis: v=2.4 cv=J/8/fwnS c=1 sm=1 tr=0 ts=6ad1cdb2 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=VwQbUJbxAAAA:8 a=vggBfdFIAAAA:8 a=yPCof4ZbAAAA:8
 a=7gr8-LgUhGOHEYCj_R8A:9 a=WmVTiCyuxqgg3mnwYu6p:22

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
Cc: Daniel Lezcano <daniel.lezcano@kernel.org>
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

