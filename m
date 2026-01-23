Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25682638BC;
	Fri, 23 Jan 2026 17:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769189988; cv=fail; b=gwXYudgTj54nir7r9ZqdBMh33Lso/QZ++DDXkhjesOW0Mk8ZH//KUcytTZ1EgjehO+UXHuttAO5o7lxJmeQ25HOYcgtJvOP5KHP93kxnIDbK5zl2BuwvbpliElaurVSTCB2s8a+ovywx/I1YlcTGwhWQL1LMewJOrZn5kTLyaYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769189988; c=relaxed/simple;
	bh=gvmxFHF1MkOORyD2rPU/CRw3wwmZczeQrL/HINJ6oB8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=S3eIr0v8/FT/pXkNfY9nrqKDEQUxrzJJWuf1vt+utDjXEbg29c/RhpfKXIh4myJaX3AmdqyygXwG09JLCxjCrFBf6xCqdqEDSPYnNcVtZBCsQ1YgUYcaiSftwBxartSleKUcUjYIcMzBSqlkanrDGRq5XoK25KhYi6MAcCYyqmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GyhER8zP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YEEvF812; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GyhER8zP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YEEvF812"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60NA8XxI2270710;
	Fri, 23 Jan 2026 17:39:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=gvmxFHF1MkOORyD2rPU/CRw3wwmZczeQrL/HINJ6oB8=; b=
	GyhER8zPCo7uUj9ksZLvcQeYQx2BD2sbbTy2W005A6zF6rShE4EMwNVYWQeW9waK
	t8sZ+cgnLd7CeVovu96/ZJ3INuK2ho7RaAaraVQPjAmdOGx/nQeLj08l8NxdIuKd
	laSc8rUKiLU+8GzLwxxhcqDbGr/MgQeUa4pYtpKm0MN9ru0kva1xHchFpan8bAfn
	r66QnTq6fhWSGPGYrJtw/DgcnO53kttyz6gpE4txL+JUxktICi81cV0Mt0MWndzU
	tR5dZWUdGL4z9I9QrxtBZ9lNFk2prHxGZKBy9sLXeDbxhQNrVFb7BOFXqd5x968H
	jiJKBrg5qJXlIDVfWZ1IRg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br0u9twyx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Jan 2026 17:39:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60NHJTUL013629;
	Fri, 23 Jan 2026 17:39:17 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011009.outbound.protection.outlook.com [52.101.62.9])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4butv0phwj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Jan 2026 17:39:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vUOzg4S+QXK6t9lPStynLeTUJqR/uZQfLq4ScRsgz1tSy2O11yx1JGTY5xsec5T9hVGSp9zlAUXQi/nOOLK9bMGMHZWn+pMGM84EmZHDHFzOPJEIHSKhJhUQgNY3qSaiMHOoUk5HHqxhSU4xVKPpC/IsQPjjQFiaL9/Gcyc3CU/iTKo1v9mEmuhgfnQzKta+v4NU6OosMi6g7kCnpZfrKezM9w0SLb1wVxKvqYtI/utobBMDJCEcKPmsee27N3arArJEb2Ks7V9UFdZ2E8ovv+eflEWKBTLwjKsXbyfJFokZ2z94iqRx40ymOgizn/Ngjh7ATH7+UlQZMpNIBpVVUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gvmxFHF1MkOORyD2rPU/CRw3wwmZczeQrL/HINJ6oB8=;
 b=bcWY/pPvAwvjA3Gc1Jzr/d39ogiDvAdn99t5iTZFN2omDQGtvRHGrLvh1W38G5KpzpPFyD7fACFU7adURsbbfNWw/PmD8OkZkvYryYUn2P49DqIkNe6AKP46sKPWwsPVhlq1UPDm68bXsaKqco8gz1U86Z9rYzS7F4hm8/t8y4Mdn3AC/t3ge4/7EseEDZ7qr44Gu9ysh5bTu0LmYckwbYEEvAgnWvgz1qpz+XQddulGKZGmtcWgPCKYAFAMaqmeQHNcLaTK+P712iXYnhs2yL/Zf9bslCQt4L3hSBQ+2J0oVZRGkjB0fD3wzADJHYi5LpGSpN+gtgvs263y8EFjQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gvmxFHF1MkOORyD2rPU/CRw3wwmZczeQrL/HINJ6oB8=;
 b=YEEvF812fb3Bg7Nmisgn1rka3ZLD4fPLF544aOSWh/reIpysx7W9BL8JHkIVGK4bx0meNO0XWL/1vgEcd/nPZ2yiUp3q7pUcv13bfQ3udsveQlgzOgFvGs1FhggEyJw3qglKk+p3+52WHQHF5HPlVb67DKbMuDSj3a09CxtFIjU=
Received: from IA1PR10MB7309.namprd10.prod.outlook.com (2603:10b6:208:3fe::13)
 by IA3PR10MB8420.namprd10.prod.outlook.com (2603:10b6:208:579::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Fri, 23 Jan
 2026 17:38:30 +0000
Received: from IA1PR10MB7309.namprd10.prod.outlook.com
 ([fe80::5f79:36e9:a632:d010]) by IA1PR10MB7309.namprd10.prod.outlook.com
 ([fe80::5f79:36e9:a632:d010%6]) with mapi id 15.20.9542.010; Fri, 23 Jan 2026
 17:38:29 +0000
From: Prakash Sangappa <prakash.sangappa@oracle.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney"
	<paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>, Jonathan Corbet
	<corbet@lwn.net>,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
        K Prateek
 Nayak <kprateek.nayak@amd.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Arnd Bergmann
	<arnd@arndb.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>, Ron Geva <rongevarg@gmail.com>,
        Waiman
 Long <longman@redhat.com>
Subject: Re: [patch V6 07/11] rseq: Implement time slice extension enforcement
 timer
Thread-Topic: [patch V6 07/11] rseq: Implement time slice extension
 enforcement timer
Thread-Index: AQHcbeM1s6qyBIihnESRGS2iLgLXNLVWU6SAgAnuroA=
Date: Fri, 23 Jan 2026 17:38:29 +0000
Message-ID: <1C89BAF2-A95C-44FF-9F5A-7078BCC8A571@oracle.com>
References: <20251215155615.870031952@linutronix.de>
 <20251215155709.068329497@linutronix.de>
 <20260117095737.GG1890602@noisy.programming.kicks-ass.net>
In-Reply-To: <20260117095737.GG1890602@noisy.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3864.300.41.1.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR10MB7309:EE_|IA3PR10MB8420:EE_
x-ms-office365-filtering-correlation-id: b9afe395-7ebe-4509-02bc-08de5aa638dd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?WkViSWxtSVNxQmNZaktJeXJBb3Mwc2tkZXFRNGRZT3E0OWcxNXBkNkYyL1h4?=
 =?utf-8?B?TDdjNXhwSWJKUnhDTXZJQ3RaTmJuZFRWQXNmbk1rS1pjeVFkanRpdUpPZ3BF?=
 =?utf-8?B?dUdRS09pWGZyNllEdVJUdXNML1hqOGxWZSsyMzBCRjlNcEM3ZlBrWE9vUkdq?=
 =?utf-8?B?L1dmMFA0ZHNhV1VjQ1Uzb1dMb0lUN0xoSWlpaStIckhBTWR2NFdDVmxzL3M5?=
 =?utf-8?B?UWVNRWNQejh5ZUxYcUlFaEorVlA4MS9MYlhRcldYemxVOUVrbWh6T1hMaTdR?=
 =?utf-8?B?NDk1ODBHZXhDaW9LeHZxV2srT05PUzJPRUJlc1Jib3kwWGF4WmE3ZGRxai9G?=
 =?utf-8?B?aDJsd1FncEZGMXMrWXpPeXJVS2JmbWtDOWF3L2RQZGQ1QjE2dm15ZzlyakpQ?=
 =?utf-8?B?aG1hWXYxendhemhiald6Q2JCZlJHc2ZwYnVOaUttcGdTdkcrVVNLTXpDY1B4?=
 =?utf-8?B?WlJrRzFndEpYSmNwY3NxS2tNc1ZsVk1hbjZFMnpDSUdRK0ZjVXhaankvN0Nk?=
 =?utf-8?B?ZGdZVDVmOG1EQUJySTEzL1cybG1UZzVYTEZUZmpuZjF5M3p5K1VlME1JYzVo?=
 =?utf-8?B?YnJ4YXRwV1V2SUlhbldnWDNmYVNpNGpEeXB1dEJTWEtiQ0trc2hvNG4yVms1?=
 =?utf-8?B?TGkzZldCNmlxZ2pIRGNSdkFtelpZWVQ5NDFxdHpaQXZpaVZGN1dQWDdGSGRi?=
 =?utf-8?B?NWdxZjJyREp4by8zZ1ZydDQxMFMzemk5Y25LZEkvYmduaDBEMjdlNmpSWlZp?=
 =?utf-8?B?V0dFTHpiOW9jU2RTZW9lOW9jZmFsUXM2US9vaGFsZ3R4VWE3SlFXdTVrcDIz?=
 =?utf-8?B?S3JnRFZRWDZzOCswaWtuQWxwZWVuaTNjUGhGTHMrWC9JV0UyWE0xcWtpck5P?=
 =?utf-8?B?YmxtM290NXNjUExhSFFabkdZZW9sbTdISDM1MGsrTWhvbHVGTVYyeEhhT0NW?=
 =?utf-8?B?VnYxYU5nZVpGaHpEcW5RV3VqMUZRYnR0aytJMHMxVlJVOFFaWFlwZDZNREkz?=
 =?utf-8?B?Q1hmcVZ3Q0dDVExqRzZXbkcwNUhaVVE4aVEyQjRKbmozbU1LMk4rMTEycTJo?=
 =?utf-8?B?ZjRaeExiSWdJdUYzcFBET2p5N0hkQzRXbXlraWcwQm5CUklZYU5GL1M2UEpS?=
 =?utf-8?B?WmdyK3FXWHBWYk8zYlloSXNXTmFkNnJZbWZyekxGbDhtTkdabkxHTlZtK1pm?=
 =?utf-8?B?Vkt0S0dKclJySXRTN0ZyUnk5ODdSUFg5TEg2MW5uc2hoZEN4OGtLSWw3NGxH?=
 =?utf-8?B?dEt0UFp3Z1BFN3ZDMllBd3ovOFB0OGhDTExFVjB6Y1lDTFc0Y2JPRFNGY1Ft?=
 =?utf-8?B?eFM3TXVIOHBYYkVwS0pJMEU4OU1BL0F6bXdDbFZSU1RNZm0rcGxBSnFWNVlC?=
 =?utf-8?B?bFZGU0tld3NmTWY2NFNxT3BFeEJPWU1VMlFOMjJCbHV6clZmeHIyYzR4clNp?=
 =?utf-8?B?dS82d29ZalR5S2h2Sis5RnR0ZnBhT1dwRVlsSFNqQVpCL2o4ZGcyZzIvcG13?=
 =?utf-8?B?OWo3S0FmWC94ZXJ3YldjR1FicVZCNWxRVkpEMmtZbHRkTEErWHpXcFZydWRE?=
 =?utf-8?B?RjVKSkoveHVLcHdDcGh1YlZDNFVBVTF4WXhHbHc4b2FWT1JScnkyTW1lTWpN?=
 =?utf-8?B?SkhuSTNiMnQwZnJQNFZhcWY0a1J0N3ZmcW1UMk94dVFJUmZUZ0VhVm95cDd1?=
 =?utf-8?B?RGNvbkdZSXV3RlpSQk9wbXVwNHdDOSsrSk1sMG43NDg2eVAxTDZzdm9uaWhM?=
 =?utf-8?B?NTVoamNOWnlLM1FTS2g3Rk1uZFFUOUpjd2RjYXpvQncwby8yekx4dkI1NmhM?=
 =?utf-8?B?eFNYOE9vUUhwcHhaWTFVM3pYUXAvOWxLcnBHT2xsQldoRWNIN1hHZ0R4MURi?=
 =?utf-8?B?djlCME1qdFptZFVoU2Vha2l2OTVpSDhuWU1XVUNIQkYwYVluVUVvNmNUN3FH?=
 =?utf-8?B?QU9ieDhnUE8vZGVBYmZRNVlzN09WVjRXL09ncjAvWWdIeU9DL2tDaFVRTE12?=
 =?utf-8?B?ZERPSTdLb1NFak05SkV4bGZBVzNaeGVWTnNMY3NFZHNRZDNHMmg4UUxGZVJj?=
 =?utf-8?B?c3l6QU1hMko0YUFzcjJLZnYwOXdTaHpST0NCWm4wSk1xM09HRzFzWDhOaStZ?=
 =?utf-8?B?Rzd1VW9MbTdpSzRKT3B0c3ZnWHpqSGFlZGh6bWs5UUt6aVk1NUQvb2RGRGdD?=
 =?utf-8?Q?cZEvB2cK/9n1pvVn1VGmaqQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7309.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZXZmQjJjSTZnSFp5MC9FT24yU2kyK04yVGg5aC81RVJ6MVJKRXpyNjU1QUhq?=
 =?utf-8?B?ajlwRDc2WHhVaTVhMDRnamtJaUNDZmV4dkFQRTJncUEvZTZEeTk3TmNrQjhH?=
 =?utf-8?B?ckI3dlFPTjJ1dktqQTJKYnJEWlM1bmEzWVdDZUtkZTh2cW9JZHNCTjZxMTdF?=
 =?utf-8?B?VXRjbXNvYmFZbXFtV0dkdktwMjNEdHJYekZ5SFU5Z3Z6OXFvY0VyMHBDRnpQ?=
 =?utf-8?B?TWdaSysrUnVVZVIyQ0hNNXBvazdDcWhxejI3Tm90eTFPYTlzdWVwbXVWdWNa?=
 =?utf-8?B?cmh2U09ORnphZFpsNDR0NlRla3ZPYnVjQzJ5UkVEbEdMWEJjR2RUWDR1em9U?=
 =?utf-8?B?dFpKRnQxVG9CVEhYeHY1QUN4SSszZkVkQXBLc3gyNmplRVVVUHRLQk9PNzUz?=
 =?utf-8?B?L1Vqai9VOGZvbld0QThYbC9NK0RoNWRmT1JTVWlybFlBcXlTMm5pdHR6K04x?=
 =?utf-8?B?V3pveS8vcy9ZOHVVaVpxOGFPNzBieUZNdlRlMGYwUWVXaXZoZS9INUVCOGR4?=
 =?utf-8?B?UHBkL1FiMy9YL0EzY2pKeHdCU0VyaUEvOTlmaGdGcURxMlhLc0dUYll0UVd4?=
 =?utf-8?B?eHk3WVkrU2c3NFpCRjRNbHhIMzlsVmM3QjZ3THRMcU1ZV0dNMitpSW1Qa1Q2?=
 =?utf-8?B?R0dUUCtYYU5iM0xaL0xFd0xjYmowZnVYNWdiZWVpelZ0M25tZDJOdjRXZjll?=
 =?utf-8?B?MUMrZ3o2d01KYmF0YmNvTWxBRmpvaUVQK3JOTHZueUpYMG9GUGpzMEJMd1ha?=
 =?utf-8?B?V0NmU3lmYTJVWW9BNEZPN1BiQ2Zaam9kdHlwZmljWDhsZlJMdmRpNTRKVmN5?=
 =?utf-8?B?T3dEY1RZSEU4Wi9hZW9nTHplaWtCTnYvMFJGOVRXVzVaSHFraTU1TEZCbnVq?=
 =?utf-8?B?TUMrYWpPN29ielFTQSs5OWRmWmJmcjhQVVhKUkYzOE5EMFZZYjROdVNQSmRz?=
 =?utf-8?B?WDZweHJ5UEhkRDdQTmZHdEpvNVRmWVlRZ2Q5TG9TTmxML3dvNmYvaXA4KzQ2?=
 =?utf-8?B?Q3h1V0xWRmtYZnZQL1EyYjdJQmppeE5UeHB4ZzBZOHBzV2hRMThSc0lkbWx0?=
 =?utf-8?B?dWxXQVJpa3M0SFN5cktianJVNGl3ZkpoUTE3L01aYzJWdEVOQkQzTk5NVHor?=
 =?utf-8?B?NVJXSE0vb1FlaTNFdGdXbkRTKyswTzFDRDFvS0EyVjN0YTluNUhBMXVlSytK?=
 =?utf-8?B?Yi9XbXU5K3lURm8zdmlWd2N0bVBhQTZpcXVtQzNPTmJNRW83cGRubmZkQzFa?=
 =?utf-8?B?SnNxYTBKRzB1NU5RUkRDUCtIeTRKMDBBVThiZXJJR0t2RHBvTU1SSTVxeE81?=
 =?utf-8?B?NjN1S0hUazRZZFJRSWtCWlFnR3hhVC9Mb1YzZTd1MHpZcEdCUVlPaUgvN3FT?=
 =?utf-8?B?c1V6WmFoUGd2c2Z0NFAySVo2ZTM1VEg0WUFpZkQ2Rjhqc2NNYnppMHFVejlY?=
 =?utf-8?B?TkNvdzBzb2JyOHFHSk9hSGhqcTFObHkyTWtlZEs2U0ExUWtsMTlrMUZaQUR3?=
 =?utf-8?B?TnRhMHliOTJTYXg3dDF0SW80djNPMy9qdUU3cjZQenhWVnNMS1g3QjVFemJD?=
 =?utf-8?B?ZDVlNEsxTTJVWXZKNkdXYmpWMndRZGFPejdGL1dacU00SHNYbmJHZ0l2cnlC?=
 =?utf-8?B?eTJyTTM1WnA1Mmw5OEdGWW9IMTdHUWU5QmhYTURndTFZM3ZiR0V2bFJaUngw?=
 =?utf-8?B?UVRCU3NIWm5Kc3QwQnRnTjNpVGlGK0U4K0hvNTBDUHBPcGwwU2orRkRiZVNT?=
 =?utf-8?B?eGtIUUJrUzR6aHFGdlM5Y0pFL1VXZ2JFZWpUWGxoS2lvSWFFTWNLNEVuT0pw?=
 =?utf-8?B?S29lT2dKV29LdWdSdmdNUVhEZnNiUSs5YjMwaGFud2hZK3BqeEVHK3B2ZjdS?=
 =?utf-8?B?WGFiZktxVngxRG40TGp6U3plZ1VsNGZWNXpDWVpsNGJqbDlwVytGVWF1RmZW?=
 =?utf-8?B?bUtLWkMzV2s2VzMyRUZCZWlqNlVKYzlCQlZGK1ZwaXlUd00rcGorMVZtNmV4?=
 =?utf-8?B?WmVYVjIzUEd6T0JKRzNwUVdqVERBdnNMN1lUQnhjbGlEMFZjd2xLc1RwY0FB?=
 =?utf-8?B?V3Y0aDYrc0xiaWoyTXJ0UVo4RWVCZnJKZTMzd0RmYzNwNHdyNFhLNW9yU3Jy?=
 =?utf-8?B?TjV0MG9rRE9UblJVSWl0Q0s5WFlHVUp2NlVLNUZVZkcyYnBkUmQ3OGtMNUNv?=
 =?utf-8?B?UUYrRkRqaklBU3REK2wzR3Z1cFErb0IwM3RvQUlTM0FWZU1qcVY0Tnh6d0xx?=
 =?utf-8?B?K0wzRzZIYnRJQWd4bXVVK1o0KzV1cmIvSk8wN3JkaVU3MU8xVGVJTjZubElj?=
 =?utf-8?B?SzA2MTYzTk5UaWI1eDVNR2ViZHRyT3JlQzRTbnpPaXN3NHhFSEtOVUwrWGZN?=
 =?utf-8?Q?Bjb+iDU3oeCen3F0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EA9C8FA4853B3942AB08F468E99EF305@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	azYvk9M69cOez3SpJZuRU4mobMSWi+VKJG0NH1AmIGy/iC6LhegRGw4ijm3j3DAzWPvhFugRIFuCv9PdIzLnbVfVOR/mqkWMUXVo2f8IslZpb3h+soqak45/Nv+/cOEFUO/vJLqPvIwIe1Tw6BeGoL0EylFNNiQa0DsqIpWtW3YDRQyp7sMWG1E5d6+uol5Bnu8f7UZUNGD2C4CLf0QvYQqHQc1t5d1owSTC5s5frj6DZ5JGVwo0Tdx1DcnYB1ecKR5fqSGHqs8zcPjhsA9IYS9c/KfPEhdfKSerj4IHvCAZfP30JXb0YqUpmUvJw9jAfCgBoF1DjnUX27MMUQBRhFJlR3cVz9caSRoaB7v57Wr8NW0Hm7M4P2udqWvi+nPcUA9QUNjpTifrl3xHAielHrfs9OLCppV+iudTe8Yx68RtZO0jSufLd4Ls5GKhMWv2f/r4xpECiP0d1VroBOeyj4DvmNfvo+cAw6fzSQ3eWNlp6zLMfJ0VgJtZzlXqG+GXS6VdtRQkOi72RoMMOYyC030KOjzbxdHXaR/KxsrUlGjsfz7CYpwDz8Rf5zFxHyPYfn2iSLP12bWrd0yJGQ1EfuhlCnv048Te3xLERPvWtDs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7309.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9afe395-7ebe-4509-02bc-08de5aa638dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2026 17:38:29.7655
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wD5Rq9fIq594/gVOhvM6UD3NcbGrfqQMpBbBAP4+gncaHzrUyaOrviplhD8ADfRu+WV0rR9kR2EmYH1i88rghoF4bvCxx/D+FxItJG6xzhw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8420
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-23_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=872 adultscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2601230133
X-Authority-Analysis: v=2.4 cv=OJUqHCaB c=1 sm=1 tr=0 ts=6973b246 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=JfrnYn6hAAAA:8 a=S-EUlXTdV4lnZN8OWTQA:9
 a=QEXdDO2ut3YA:10 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-GUID: nBZILtlfAwTDCeVN2NfhIpbVvlU8g1GR
X-Proofpoint-ORIG-GUID: nBZILtlfAwTDCeVN2NfhIpbVvlU8g1GR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDEzMyBTYWx0ZWRfXwzjS/4SkEVIo
 2ajiRPe6KbrXMB6pMGGPFisChckXJ3BaZGWTj4NlKYdwZiCXKA7mOjrcMe0RBtIUF6unDlzxjoJ
 NdNLYwznobb67AVrgbRa8S6f6YOMFVOdImFNTwXyQuR2EYs5k3uDQ/Gy/KTSPklQQmOG114ZPlb
 KPL8IticE7G1dCoHZD/Z+1Z2RqEtvreCdF3JJbXXKYvhDh3uUog/1pSFPdIx37VJu3urhN3+vlL
 wI8sfe+LPsjxr/TcBm2Do4RRFQyMhUbWiM8zuTyJpjWF/JazdPj2Gh/50MeoAFneWq6BxorGoNT
 YnlJZ0S2WPc8mTsg4HZ/edBfMe0jonTMhFhDqqZe5WbyAYCS2kZif+0AsFIyY8xxJNjcZscT2mm
 ndaPlIahlEDGkNNUVu/Cv9Sjivwv3TDZLw7iXZscqi+Wi/QBYRpYv39d4QkU+C5u8Xl6cRxLifs
 l8M/VUiUFTtYmEZJ3sg==

DQoNCj4gT24gSmFuIDE3LCAyMDI2LCBhdCAxOjU34oCvQU0sIFBldGVyIFppamxzdHJhIDxwZXRl
cnpAaW5mcmFkZWFkLm9yZz4gd3JvdGU6DQo+IA0KPiBPbiBNb24sIERlYyAxNSwgMjAyNSBhdCAw
NTo1MjoyMlBNICswMTAwLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6DQo+IA0KPj4gK3JzZXFfc2xp
Y2VfZXh0ZW5zaW9uX25zZWMNCj4+ICs9PT09PT09PT09PT09PT09PT09PT09PT09DQo+PiArDQo+
PiArQSB0YXNrIGNhbiByZXF1ZXN0IHRvIGRlbGF5IGl0cyBzY2hlZHVsaW5nIGlmIGl0IGlzIGlu
IGEgY3JpdGljYWwgc2VjdGlvbg0KPj4gK3ZpYSB0aGUgcHJjdGwoUFJfUlNFUV9TTElDRV9FWFRF
TlNJT05fU0VUKSBtZWNoYW5pc20uIFRoaXMgc2V0cyB0aGUgbWF4aW11bQ0KPj4gK2FsbG93ZWQg
ZXh0ZW5zaW9uIGluIG5hbm9zZWNvbmRzIGJlZm9yZSBzY2hlZHVsaW5nIG9mIHRoZSB0YXNrIGlz
IGVuZm9yY2VkLg0KPj4gK0RlZmF1bHQgdmFsdWUgaXMgMzAwMDBucyAoMzB1cykuIFRoZSBwb3Nz
aWJsZSByYW5nZSBpcyAxMDAwMG5zICgxMHVzKSB0bw0KPj4gKzUwMDAwbnMgKDUwdXMpLg0KPiAr
DQo+ICtUaGlzIHZhbHVlIGhhcyBhIGRpcmVjdCBjb3JyZWxhdGlvbiB0byB0aGUgd29yc3QgY2Fz
ZSBzY2hlZHVsaW5nIGxhdGVuY3k7DQo+ICtpbmNyZW1lbnQgYXQgeW91ciBvd24gcmlzay4NCj4g
DQo+IA0KPj4gK3Vuc2lnbmVkIGludCByc2VxX3NsaWNlX2V4dF9uc2VjcyBfX3JlYWRfbW9zdGx5
ID0gMzAgKiBOU0VDX1BFUl9VU0VDOw0KPiANCj4gQ2hhbmdlZCBkZWZhdWx0IHRvIDEwdXMNCj4g
DQo+IEFsc28sIGdpdmVuIHRoZSByZXN1bHRzIG9mIHRoYXQgc2xpY2VfdGVzdCB0aGluZywgd2Ug
bWlnaHQgcG9zc2libHkgZ2V0DQo+IGF3YXkgd2l0aCBhIG11Y2ggbG93ZXIgdmFsdWUgc3RpbGwu
IA0KPiANCj4gUHJha2FzaCwgY291bGQgeW91IHBvc3NpYmx5IGNhcHR1cmUgYSB0cmFjZSBvZiBo
cnRpbWVyX3N0YXJ0LA0KPiBocnRpbWVyX2NhbmNlbCBhbmQgaHJ0aW1lcl9leHBpcmVfZW50cnkg
Zm9yIHlvdXIgT3JhY2xlIHdvcmtsb2FkIGFuZCBydW4NCj4gdGhhdCBweXRob24gdGhpbmcgb24g
aXQ/DQoNCg0KDQpUaGUgZGF0YWJhc2Ugc2V0dXAgaXMgb24gYW4gb2xkZXIgZW52aXJvbm1lbnQu
IFRoZSBweXRob24gc2NyaXB0IHByb3ZpZGVkIGRvZXMgbm90IHJ1biBhcyBpcy4NClNvLCBtb2Rp
ZmllZCBpdCB0byBnYXRoZXIgdGhlIHN0YXRzIGJ5IHBhcnNpbmcgdHJhY2UtY21kIHJlcG9ydCBv
dXRwdXQuDQpNb2RpZmllZCBweXRob24gc2NyaXB0IGlzIGJlbG93DQoNCkhlcmUgYXJlIHJzZXEg
IHN0YXRzIGZyb20gdGhlIGJlbmNobWFyayBydW4uDQojIGNhdCAvc3lzL2tlcm5lbC9kZWJ1Zy9y
c2VxL3N0YXRzDQpb4oCmXQ0Kc2dyYW50OiAgICAgICAgICA3MDc1MzANCnNleHBpcjogICAgICAg
ICAgICAgMTk3MTcNCnNyZXZvazogICAgICAgICAgICAyNjU0OA0Kc3lpZWxkOiAgICAgICAgICAg
NjgwOTgyDQoNCkhlcmUgaXMgdGhlIGhpc3RvZ3JhbSBkYXRhIHNuaXBwZXQuIFNob3dpbmcgdHlw
aWNhbCB1c2FnZS4NCkdhdGhlcmVkIGZyb20gMTAgc2VjIHRyYWNlLWNtZCBzYW1wbGVzIGNvbGxl
Y3RlZCBkdXJpbmcgdGhlIGJlbmNobWFyayBydW4uDQojIHRyYWNlLWNtZCByZWNvcmQgLWUgaHJ0
aW1lcl9zdGFydCAtZSBocnRpbWVyX2NhbmNlbCAtZSBocnRpbWVyX2V4cGlyZV9lbnRyeSAtLSBz
bGVlcCAxMA0KIyB0cmFjZS1jbWQgcmVwb3J0IC10ID4gdHJhY2UucmVwb3J0DQoNClRoaXMgaXMg
d2l0aCBzbGljZSBzaXplIG9mIDMwdXMuIA0KVGhlIGtlcm5lbCBpbmNsdWRlcyB0aGUgZm9sbG93
aW5nIGZpeA0KDQo+IC0tLSBhL2tlcm5lbC90aW1lL2hydGltZXIuYw0KPiArKysgYi9rZXJuZWwv
dGltZS9ocnRpbWVyLmMNCj4gQEAgLTE3NDIsNyArMTc0Miw3IEBAIHN0YXRpYyB2b2lkIF9fcnVu
X2hydGltZXIoc3RydWN0IGhydGltZXINCj4gDQo+IGxvY2tkZXBfYXNzZXJ0X2hlbGQoJmNwdV9i
YXNlLT5sb2NrKTsNCj4gDQo+IC0gZGVidWdfZGVhY3RpdmF0ZSh0aW1lcik7DQo+ICsgZGVidWdf
aHJ0aW1lcl9kZWFjdGl2YXRlKHRpbWVyKTsNCj4gYmFzZS0+cnVubmluZyA9IHRpbWVyOw0KDQo9
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQpSU0VRIFNMSUNFIEhJU1RP
R1JBTSAodXMpDQo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQoNClRh
c2s6IG9yYV9kYndyX2xtYi02NjYyNTcgICAgTWVhbjogMTU5My4wNTggbnMNCiAgTGF0ZW5jeSAo
dXMpICAgIHwgQ291bnQNCiAgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQogIEVYUElS
RUQgICAgICAgICB8IDMNCiAgMCB1cyAgICAgICAgICAgIHwgOA0KICAxIHVzICAgICAgICAgICAg
fCAxMTYNCiAgMiB1cyAgICAgICAgICAgIHwgMjUNCiAgMyB1cyAgICAgICAgICAgIHwgMg0KICA0
IHVzICAgICAgICAgICAgfCAxDQogIDcgdXMgICAgICAgICAgICB8IDENCg0KVGFzazogb3JhX2Ri
d2RfbG1iLTY2NjE5NiAgICBNZWFuOiAxNTQ4LjY0MSBucw0KICBMYXRlbmN5ICh1cykgICAgfCBD
b3VudA0KICAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCiAgRVhQSVJFRCAgICAgICAg
IHwgNg0KICAwIHVzICAgICAgICAgICAgfCAxOQ0KICAxIHVzICAgICAgICAgICAgfCAyMDMNCiAg
MiB1cyAgICAgICAgICAgIHwgMzMNCiAgNCB1cyAgICAgICAgICAgIHwgMg0KICA1IHVzICAgICAg
ICAgICAgfCAxDQoNCg0KWy4uXQ0KDQpUYXNrOiBvcmFjbGVfNjY4OTUxX2wtNjY4OTUxICAgIE1l
YW46IDE3OTcuNzk2IG5zDQogIExhdGVuY3kgKHVzKSAgICB8IENvdW50DQogIC0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLQ0KICAxIHVzICAgICAgICAgICAgfCA1DQogIDIgdXMgICAgICAg
ICAgICB8IDENCiAgMyB1cyAgICAgICAgICAgIHwgMg0KDQpUYXNrOiBvcmFjbGVfNjcxNTcxX2wt
NjcxNTcxICAgIE1lYW46IDMyODUuNDI1IG5zDQogIExhdGVuY3kgKHVzKSAgICB8IENvdW50DQog
IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KICAxIHVzICAgICAgICAgICAgfCAxDQog
IDMgdXMgICAgICAgICAgICB8IDENCiAgNSB1cyAgICAgICAgICAgIHwgMQ0KICA2IHVzICAgICAg
ICAgICAgfCAxDQogIDEwIHVzICAgICAgICAgICB8IDENCg0KVGFzazogb3JhY2xlXzY3MjI3N19s
LTY3MjI3NyAgICBNZWFuOiAyMzYxLjYwMCBucw0KICBMYXRlbmN5ICh1cykgICAgfCBDb3VudA0K
ICAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCiAgMSB1cyAgICAgICAgICAgIHwgNA0K
ICAyIHVzICAgICAgICAgICAgfCAzDQogIDUgdXMgICAgICAgICAgICB8IDENCiAgNyB1cyAgICAg
ICAgICAgIHwgMQ0KICA5IHVzICAgICAgICAgICAgfCAxDQogIDExIHVzICAgICAgICAgICB8IDEN
Cg0KVGFzazogb3JhX2Rid2JfbG1iLTY2NjE5MiAgICBNZWFuOiAxNTQ4LjE1NyBucw0KICBMYXRl
bmN5ICh1cykgICAgfCBDb3VudA0KICAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCiAg
RVhQSVJFRCAgICAgICAgIHwgMTANCiAgMCB1cyAgICAgICAgICAgIHwgMjQNCiAgMSB1cyAgICAg
ICAgICAgIHwgMTgyDQogIDIgdXMgICAgICAgICAgICB8IDM5DQogIDMgdXMgICAgICAgICAgICB8
IDINCiAgNCB1cyAgICAgICAgICAgIHwgNA0KICA1IHVzICAgICAgICAgICAgfCAxDQogIDE0IHVz
ICAgICAgICAgICB8IDENCg0K4oCU4oCU4oCUDQojIS91c3IvYmluL3B5dGhvbjMNCg0KIw0KIyB0
cmFjZS1jbWQgcmVjb3JkIC1lIGhydGltZXJfc3RhcnQgLWUgaHJ0aW1lcl9jYW5jZWwgLWUgaHJ0
aW1lcl9leHBpcmVfZW50cnkgLS0gJGNtZA0KIyB0cmFjZS1jbWQgcmVwb3J0IC10ID50cmFjZS5y
ZXBvcnQNCg0KIyBwZW5kaW5nW3RpbWVyX3B0cl0gPSB7J3RzJzogdGltZXN0YW1wLCAnY29tbSc6
IGNvbW19DQpwZW5kaW5nID0ge30NCg0KIyBoaXN0b2dyYW1zW2NvbW1dW2J1Y2tldF0gPSBjb3Vu
dA0KaGlzdG9ncmFtcyA9IHt9DQoNCmNsYXNzIE9ubGluZUhhcm1vbmljTWVhbjoNCiAgIGRlZiBf
X2luaXRfXyhzZWxmKToNCiAgICAgICBzZWxmLm4gPSAwICAgICAgICAgICMgQ291bnQgb2YgZWxl
bWVudHMNCiAgICAgICBzZWxmLlMgPSAwLjAgICAgICAgICMgQ3VtdWxhdGl2ZSBzdW0gb2YgcmVj
aXByb2NhbHMNCg0KICAgZGVmIHVwZGF0ZShzZWxmLCB4KToNCiAgICAgICBpZiB4ID09IDA6DQog
ICAgICAgICAgIHJhaXNlIFZhbHVlRXJyb3IoIkhhcm1vbmljIG1lYW4gaXMgdW5kZWZpbmVkIGZv
ciB6ZXJvLiIpDQoNCiAgICAgICBzZWxmLm4gKz0gMQ0KICAgICAgIHNlbGYuUyArPSAxLjAgLyB4
DQogICAgICAgcmV0dXJuIHNlbGYubiAvIHNlbGYuUw0KDQogICBAcHJvcGVydHkNCiAgIGRlZiBt
ZWFuKHNlbGYpOg0KICAgICAgIHJldHVybiBzZWxmLm4gLyBzZWxmLlMgaWYgc2VsZi5uID4gMCBl
bHNlIDANCg0Kb2htcyA9IHt9DQoNCmRlZiBoYW5kbGVfc3RhcnQoY29tbSwgdHMsICB0aW1lcl9w
dHIsIGZ1bmMpOg0KICAgaWYgInJzZXFfc2xpY2VfZXhwaXJlZCIgaW4gZnVuYzoNCiAgICAgICB0
cyA9IHRzLnJlcGxhY2UoJzonLCAnJykNCiAgICAgICBwZW5kaW5nW3RpbWVyX3B0cl0gPSB7DQog
ICAgICAgICAgICd0cyc6IHRzLA0KICAgICAgICAgICAnY29tbSc6IGNvbW0NCiAgICAgICB9DQog
ICByZXR1cm4gTm9uZQ0KDQpkZWYgaGFuZGxlX2NhbmNlbCh0cywgdGltZXJfcHRyKToNCg0KICAg
aWYgdGltZXJfcHRyIGluIHBlbmRpbmc6DQogICAgICAgc3RhcnRfZGF0YSA9IHBlbmRpbmcucG9w
KHRpbWVyX3B0cikNCiAgICAgICB0cz0gdHMucmVwbGFjZSgnOicsICcnKQ0KICAgICAgIGR1cmF0
aW9uX25zID0gZmxvYXQodHMpIC0gZmxvYXQoc3RhcnRfZGF0YVsndHMnXSkNCiAgICAgICBkdXJh
dGlvbl9ucyA9IGludChkdXJhdGlvbl9ucyAqIDEwMDAwMDAwMDApDQogICAgICAgZHVyYXRpb25f
dXMgPSBkdXJhdGlvbl9ucyAvLyAxMDAwDQoNCiAgICAgICBjb21tID0gc3RhcnRfZGF0YVsnY29t
bSddDQoNCiAgICAgICBpZiBjb21tIG5vdCBpbiBvaG1zOg0KICAgICAgICAgICBvaG1zW2NvbW1d
ID0gT25saW5lSGFybW9uaWNNZWFuKCkNCg0KICAgICAgIGlmIGR1cmF0aW9uX3VzID4gMDoNCiAg
ICAgICBvaG1zW2NvbW1dLnVwZGF0ZShkdXJhdGlvbl9ucykNCg0KICAgICAgIGlmIGNvbW0gbm90
IGluIGhpc3RvZ3JhbXM6DQogICAgICAgICAgIGhpc3RvZ3JhbXNbY29tbV0gPSB7fQ0KDQogICAg
ICAgaGlzdG9ncmFtc1tjb21tXVtkdXJhdGlvbl91c10gPSBoaXN0b2dyYW1zW2NvbW1dLmdldChk
dXJhdGlvbl91cywgMCkgKyAxDQogICByZXR1cm4gTm9uZQ0KDQpkZWYgaGFuZGxlX2V4cGlyZSh0
aW1lcl9wdHIpOg0KICAgaWYgdGltZXJfcHRyIGluIHBlbmRpbmc6DQogICAgICAgc3RhcnRfZGF0
YSA9IHBlbmRpbmcucG9wKHRpbWVyX3B0cikNCiAgICAgICBjb21tID0gc3RhcnRfZGF0YVsnY29t
bSddDQogICAgICAgaWYgY29tbSBub3QgaW4gaGlzdG9ncmFtczoNCiAgICAgICAgICAgaGlzdG9n
cmFtc1tjb21tXSA9IHt9DQoNCiAgICAgICAjIFJlY29yZCAtMSBidWNrZXQgZm9yIGV4cGlyZWQg
KGZhaWxlZCB0byBjYW5jZWwpDQogICAgICAgaGlzdG9ncmFtc1tjb21tXVstMV0gPSBoaXN0b2dy
YW1zW2NvbW1dLmdldCgtMSwgMCkgKyAxDQogICByZXR1cm4gTm9uZQ0KDQppZiBfX25hbWVfXyA9
PSAiX19tYWluX18iOg0KDQpmaWxlX3BhdGg9Ii4vdHJhY2UucmVwb3J0Ig0KdHJ5Og0Kd2l0aCBv
cGVuKGZpbGVfcGF0aCwgJ3InKSBhcyBmOg0KZm9yIGxpbmUgaW4gZjoNCiMgZm9ybWF0IGRlc2Ny
aXRwaW9uIG9mIHRyYWNlLWNtZCByZXBvcnQNCnBhcnRzID0gbGluZS5zcGxpdCgpDQoNCmlmIGxl
bihwYXJ0cykgPCA1Og0KY29udGludWUNCmlmICJocnRpbWVyX2NhbmNlbCIgaW4gcGFydHNbM106
DQpoYW5kbGVfY2FuY2VsKHBhcnRzWzJdLCBwYXJ0c1s0XSk7DQpjb250aW51ZQ0KaWYgbGVuKHBh
cnRzKSA8IDY6DQpjb250aW51ZQ0KaWYgImhydGltZXJfc3RhcnQiIGluIHBhcnRzWzNdOg0KaGFu
ZGxlX3N0YXJ0KHBhcnRzWzBdLCBwYXJ0c1syXSwgcGFydHNbNF0sIHBhcnRzWzVdKQ0KY29udGlu
dWUNCmlmICJocnRpbWVyX2V4cGlyZV9lbnRyeSIgaW4gcGFydHNbM106DQpoYW5kbGVfZXhwaXJl
KHBhcnRzWzRdKQ0KDQpleGNlcHQgUGVybWlzc2lvbkVycm9yOg0KcHJpbnQoZiJFcnJvcjogUGVy
bWlzc2lvbiBkZW5pZWQgcmVhZGluZyB7ZmlsZV9wYXRofSIpDQpleGNlcHQgRmlsZU5vdEZvdW5k
RXJyb3I6DQpwcmludChmIkVycm9yOiB7ZmlsZV9wYXRofSBub3QgZm91bmQuIikNCg0KDQpwcmlu
dCgiXG4iICsgIj0iKjQwKQ0KcHJpbnQoIlJTRVEgU0xJQ0UgSElTVE9HUkFNICh1cykiKQ0KcHJp
bnQoIj0iKjQwKQ0KZm9yIGNvbW0sIGJ1Y2tldHMgaW4gaGlzdG9ncmFtcy5pdGVtcygpOg0KcHJp
bnQoZiJcblRhc2s6IHtjb21tfSAgICBNZWFuOiB7b2htc1tjb21tXS5tZWFuOi4zZn0gbnMiKQ0K
cHJpbnQoZiIgIHsnTGF0ZW5jeSAodXMpJzo8MTV9IHwgeydDb3VudCd9IikNCnByaW50KGYiICB7
Jy0nKjMwfSIpDQojIFNvcnQgYnVja2V0cyBudW1lcmljYWxseSwgcHV0dGluZyAtMSBhdCB0aGUg
dG9wDQpmb3IgYnVja2V0IGluIHNvcnRlZChidWNrZXRzLmtleXMoKSk6DQpsYWJlbCA9ICJFWFBJ
UkVEIiBpZiBidWNrZXQgPT0gLTEgZWxzZSBmIntidWNrZXR9IHVzIg0KcHJpbnQoZiIgIHtsYWJl
bDo8MTV9IHwge2J1Y2tldHNbYnVja2V0XX0iKQ0KDQo=
