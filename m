Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A634C16F0FE;
	Fri, 23 Jan 2026 17:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769190103; cv=fail; b=ijWSrx14yCYwPafesIS0p/QDqSnQ1uV6bMxCq5mUawKDRNoie7qqUlWm1usYvFK45BCD+yU9XZ8WK03FPfT7TQkclpj+MRyl4Ue6ZG/DJmCnLbRmaevyVUMa3SycEmYzRGj65W8Hx/N8Wn5jXSLo0TZdHdq4kioLtHoeCxaP/i8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769190103; c=relaxed/simple;
	bh=gvmxFHF1MkOORyD2rPU/CRw3wwmZczeQrL/HINJ6oB8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=R4y1NtxCnkI/uFOOsYjnLzjdYgURdTbf2eEYsnrgEwzTHeN6kh1vigwj0/UhuQtCnePz14O4a9/h8+uF1vluVfaa6HkPDtckE7tC/gzyAmf5tvFOV+g+CtzyxR8DSrMcYEbt3esdo798Fq2OLNhTvr9ycV3Ig2SFb/wWJmLKM8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cWlPRe3m; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YYcPn9IA; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cWlPRe3m";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YYcPn9IA"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60NFPKB31631817;
	Fri, 23 Jan 2026 17:41:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=gvmxFHF1MkOORyD2rPU/CRw3wwmZczeQrL/HINJ6oB8=; b=
	cWlPRe3mAqKF3Hu7WwvKUiHpgAdQTPfjWT9MeuV51S1acNuYl2Tz3hNl4MXRaxbi
	gFAMHqxK8alLBjxIPz3hQfHATHzqrdqyFpFcmMzpOMzIDL6/gXWXUPP5YmCdR+4y
	BX9lAkOCn7847GItql7LhlxGsFeZHCR3JYqP+YmO4g7KUKlF/LTL7RqLebtRZSFY
	HoOC7r/Mzwcgw83R7ldfdpye3YGRfCCadc9YyZ3E9xWJSgoVZYJL6gIAzBNM/QEf
	2yH0maFVv4YaBhzb8TeMtjYKLmMTTbF+ERs/vd9ad/Z2m7pMSGrPkIfEYJmATXQM
	9fLti5kTycPpF/6j7k0EEg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br2yq2qqu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Jan 2026 17:41:21 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60NGQOYf015079;
	Fri, 23 Jan 2026 17:41:21 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012047.outbound.protection.outlook.com [40.107.200.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4butv0pnjs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Jan 2026 17:41:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b2lzABgZU7b6zKi6aJB8C82JUAGCKKJrKFCyqm3R/pRjyboR9MrOrMeeZ5kOBFxZur7a+wJpKkBSd/ZhXwhqyGwn7RdOcFt3fiKhh0SQ08nsRU5rP2XFf+DBGoRXcjhrLDOXVYrJWtwgDSYtTFkQjI+cQ6zRJkNFBSjZN9NQzP+1pNE52A2hBeJzCh6ZVWgMDjXVd/mmQTGGCUSWri9yEeK207ZRcVFQWLUMLVkV9lIW/upfB10mAg+UJHdp+fkeft1+ph354P6ZNI6ovhIgyRDhjuCOzuTE84pCHEQQt/zSKApqI8LJSrl7LkIXzRr67Aq0JJmyhMR5JnEhpFXAnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gvmxFHF1MkOORyD2rPU/CRw3wwmZczeQrL/HINJ6oB8=;
 b=ygylfCtFu0Roi3Lb6IEUdMNn7FN3k0JMnO/tGFankit9KNaE/b6fLpa6iSjRn+S1rug400L8QBPSewupGQl1t7x4Zs5LqSXvq2ae3iMLEyVt3sxFsRfYmy87IkDklbwcxLQPVBuDw5xigm2OVHtxInFsNQoKIn3ds9BE3uTdG2Zsl9BRcUS/ng2nDha0HpXWhSbeeAgj9qwKBfIHIsBPRozVJlu9JW9usptKrvbEukE7FSybdiKZQkKjBuLldovaCxsIulQEbuinDYU8c7maKfJoo+h57cuui/mif4ANTqJI9H9fbzJXET6+0UpKTOonp/A3bvRnQ4T49uMbm8lz2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gvmxFHF1MkOORyD2rPU/CRw3wwmZczeQrL/HINJ6oB8=;
 b=YYcPn9IAO68ZNEt/Jc2PIDe3dOGdl/lTa1Ms6ze10XMa77ngsOpRZbBrDXlA+Imzsg4QCCUN8caCZlPa9KuKrndwC39rChZ42fE7LUI8s71VJcpXhzn4FzWhAwaQ7Nn0Mv6RYZpx+oYRM+wklJj9M21qU+Bw1qFvxEZhvqGsARw=
Received: from IA1PR10MB7309.namprd10.prod.outlook.com (2603:10b6:208:3fe::13)
 by IA3PR10MB8420.namprd10.prod.outlook.com (2603:10b6:208:579::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Fri, 23 Jan
 2026 17:41:17 +0000
Received: from IA1PR10MB7309.namprd10.prod.outlook.com
 ([fe80::5f79:36e9:a632:d010]) by IA1PR10MB7309.namprd10.prod.outlook.com
 ([fe80::5f79:36e9:a632:d010%6]) with mapi id 15.20.9542.010; Fri, 23 Jan 2026
 17:41:17 +0000
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
Date: Fri, 23 Jan 2026 17:41:16 +0000
Message-ID: <3FF1C1CB-ACE5-485A-8BFB-AFE561CA6EC1@oracle.com>
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
x-ms-office365-filtering-correlation-id: 42637ec9-1ca0-420c-42d7-08de5aa69c93
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?bmsrR3huRHZWeWZacWpXRk1rblliU1AycFFJeGg0dTFEVks0endOQk5YZll0?=
 =?utf-8?B?RnAyb3dUK29TenptYVFjcnExS0o2V1ArZUpmZGlEZEFUSG50bERNSGUzcDJy?=
 =?utf-8?B?bkd1aTh3Zjh2dDlBYlN5RUUyZFVFazU2aE5BNEFrV1hXc0haSmEyVjd1RWxo?=
 =?utf-8?B?aGZUQ2tZUXpnVEtxMkNYdmN5SU1MLzVsZkk2U2xOSS9iWHNDQmVkNm1iT1hH?=
 =?utf-8?B?cFVvVnFPSzNxei9pS3NZc1JzaVYybzJnN081c3RSc1I1cU5PSFpTN2M5T1ZE?=
 =?utf-8?B?eldZUjRKYkJ2Ty9GMTA1K3Vrd3E3YXRLVk9UM05MK1hkOUlOYjU0aThXVnE0?=
 =?utf-8?B?bDlwWmZZVTdqbWRkSzdiTTJTaDJFT3NRdnBNclUvYkhSM2hML0xlZlVUZzZa?=
 =?utf-8?B?aGZMZ3BvYkhqSXlnMFJMWjl1Qzh3L0ZwalQzNUFZM0liTmQzdk9zYzdiVFB6?=
 =?utf-8?B?aE9XL2MraXk4RHBjSWdOZDZyTlBDVUt5d0Jvc2M0am92SjY3eEJXWVNWZDBQ?=
 =?utf-8?B?eUNkUUpOdjJ0amQ1VUx5K0E0Yy81UlBpcVg0ZmUrM2dBTVVBdU9PWTE0WTl6?=
 =?utf-8?B?dThQd0sxc2VPU1Zxa3g3bXd2bFVuQURwRE5SY0E0bzJwSGJ3a3hlSGNwVnFE?=
 =?utf-8?B?OTRFa2JNa1lpMFBkV1JoY3FuV3ZSWi8xZ29qYXFZNkRlamVoQnZMakVhUWZu?=
 =?utf-8?B?T1F4blRwYWtadVlHQWNoY0RtMzJoSU9uK0M1Lzc1SWNBZzRYZDlRT1g5eXpz?=
 =?utf-8?B?ZFg2QjRYOW9wZ1FjbVJNZGwrNzJUM1lnUnpkVVFqdnJIT290YzdnbUJrM1hh?=
 =?utf-8?B?ZEViNWJ5dkF6MWdSRzM4ZERMU2VuTm5aWWQ5S043QW44NVpYNGpreEdKSXhj?=
 =?utf-8?B?VkVRMVlmanIxZzRaVENPeWpIQnVBZnlzc2Uzc3JKNmkvZTFPMzgvU0cvVmRl?=
 =?utf-8?B?TEVrRkMzamxBZEtwQ2dROFdoM2sxMXFBZ3lsbkg5MzUxbExieEpETWZiUGxT?=
 =?utf-8?B?U3JTRHp5emJmWE9OL2ZnNkR2ZlRTK21rQTNLTmJhV0xmSlc2aTVPeW16K3dw?=
 =?utf-8?B?WC96MFl4U1phdW1FVkt2U1c0OFA0WDRkZXhWYS9hQlYyNlpGTm9Cc0JMMnQy?=
 =?utf-8?B?ZklydXRLM1AzbCs5NXA0M3phQWFqQ1Y5UHY4Zlp1d3FqMzdyRWhIN0RzSi8z?=
 =?utf-8?B?S0UvVlF4Nml1SUh2UVJ1S3dJU2ZMWFdtMExmUmowS0x4Z0RBdGZkV094NGw1?=
 =?utf-8?B?cTVoZmlSSXNjQ0xCenBicUpqMzh2RXVmcGJ4dmZ0ZzlmZ21oU05BWk82Qnpk?=
 =?utf-8?B?S3g3L1M4dzdYMXFvTlFtdVdDNkJLSUd2d1g2QVJNOTBJQi9iV1VPckE2UGd3?=
 =?utf-8?B?UWtGNU8vZDMxUmgzMmh5N1FBVFIwZE1PTUtFSThUN3NkY3AvenFqTmlHdDJs?=
 =?utf-8?B?d0dmcTRZVi9HMithMmZ5SVhENFhSQ3pKdzh1TUZFSmF1V3ZKdm8rbDF3V1Fl?=
 =?utf-8?B?YWV2VUNTYmt1OFUyNk02aXVxN0ZOc3JjTnU1R0J5U3RkdnZGaW9mSml4UlJj?=
 =?utf-8?B?SFc4enI1Y0IrYUtMYWlyS3YySlhiRi9aSkl6Q2hZLzdXOGtyaFlvRnJITWV1?=
 =?utf-8?B?azZidVRFc1lwcjJmbzltMmdxaVY1cE8yUmdqcjh6bU1Ka1pIMForMnFUWXhB?=
 =?utf-8?B?RkdYaEJiR3J1RlFISW90cU56VVNWcHdPeEovY0JqUWJqZmxCN01ZemN2S3Mx?=
 =?utf-8?B?TDQ2NEZXWkhsSzFUbENYYUMxN1RTRjZmbmxVNmFLTHBmMGdiOC93aTgxMmR5?=
 =?utf-8?B?N09QSjc0aW9xNlQzY2NueldGTXoxRVV5SVBvODFKays3YXd3ekRDek9RYXlP?=
 =?utf-8?B?dC9LSnp5RXE1cHBVSXJ0djBDdnVYM25rR1pOTVNsTUFYZ2tOTUdlM0FrZ29m?=
 =?utf-8?B?RmwyRkFkNW12K2FOcmVBOEoyb0hjU3ZvQ3V1ZmgybEZwdFBtaVNZSngrN294?=
 =?utf-8?B?U3VWL09vbnlyOC9TNXVqZEtuNitmWEJxNkNobmdxd3Vna3FmbkcySWxXUFZq?=
 =?utf-8?B?MWY2RHgxd010ZXlDQ21nUXNZOG13UE9zTlF4UHdvVkxmVXMxS3ZhRmx4bUtR?=
 =?utf-8?B?emJmT3dIMFpxVGlTZ28vN2pzdi9DTmZuSVFzejdNc0RtZWNGRkRhQUJDdXZI?=
 =?utf-8?Q?xYRppWY8/n527tf1geUPH84=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7309.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MEVOZDB0M0FUVFlKMXczS1RpVXFvbjlBMkxoVFVjZHdlOUp6Q0FCR0NnM3Zx?=
 =?utf-8?B?TjJkRTdoeG9NN2NRN29ueFVQa1UwOEhuWk5OZ0hDb3R0L0JGWXBjSWkvekQr?=
 =?utf-8?B?RURRMG9WNFR4TVNYbm5xcmFIbDRRV1krWHNNcnpQRlNzRW92ejJxN3l0cFNE?=
 =?utf-8?B?a1ltTEdzcW1oNWgwT1gzd1ErMjVNLzI4VEFZNFoxYk5IOFkvQmZGMU5FQnJ0?=
 =?utf-8?B?a0NyaTBEMFVkbTArSkR0Q0o4QWVObmtZNllTZE05dnR0Mk1rQVZzNmhZWHdV?=
 =?utf-8?B?bWdLRG4vV3dkaEJmMHlMMkM3ODZMSFFQVTI5THc2R2ZoMTFkdXE3RE05SWZz?=
 =?utf-8?B?cU5YNnQwYmxvNUlNUURJZ1NJVmM5Sk9uNEdWaVlENmhPcFhxZ3c1WDU2Skpx?=
 =?utf-8?B?NmdxZStQZVBFTGpUemliWWo2V3ZnWXM2OGJWUHNFQ1E0azk5M1JKQnk2ZVNG?=
 =?utf-8?B?Uk1XWHYwY2J3MEg5OVJUZ01OaEk0b1EydGZZOE9mdVpzVnlLVjYwQ252ZU92?=
 =?utf-8?B?VEwvTWRkNEpncnhlcERaeW82OEtCY2JWRkhDNEhkcnZ2T0xQaTFhSkloM0Y2?=
 =?utf-8?B?blZaT016VmxzVE1QRHkwTEJCSzBlVzArRTgrb2lMNmxZdzdjaExNTklJNmZo?=
 =?utf-8?B?aGFwaHRWcUwvS1dUS3lla2NDZ2R3bFZxekZnZ2o2V0ZnVjJHNkREZnAwNGd5?=
 =?utf-8?B?YXZPYTQzazZnTjBhTllmd3RrbXJBcDEzcGlvenJaNlFSamlZaUw4Y2haajdB?=
 =?utf-8?B?QmwvdVkzbWtqTVBhVHBSZTQ1Zkw5Q0VIWDFlWSthZDd2akZtZy94MFE5aXh3?=
 =?utf-8?B?c2xQWWhPWG0zMUdUUElodmxwdmZzeWhCTzZ2M2t4N1hjUDNNbmNiMCsxTVFu?=
 =?utf-8?B?RWdmd1krNDR4Wk9jK1VKUitFUm4vQmNEM3NtL0dRTDBCaXM0VGVsMGp0WGZm?=
 =?utf-8?B?K1RKWXJrZ3NEWGtUWC9JVlZWRm4zeEEydnYxcmFXT3YyMlFYaDBrR1FpZjJo?=
 =?utf-8?B?dWVjcUNtUnVBa3pZZDVjL0Q1N3gyKzBFZ0RPdHJuS3R0SnNjbER1d2I2WENh?=
 =?utf-8?B?WU1wVGRCakVrNWVpVCsyVnpYOEdqeDhKNnp4RXd6MXFMZTlNUWlXWEYycllB?=
 =?utf-8?B?dW1WRjZMTUdMaEdRZ2FaQTdQQWo0VWlLU2cvVlhBeDYzQjJDcnBnSm81N1Bl?=
 =?utf-8?B?aGFMRlBVdXcvMXFRQTVnalo2eHlxYXN6QW51ZzdXYnVnT0VSY3NuRFZvM3VJ?=
 =?utf-8?B?MkdwUXIrcDFxNndPMnNzejdFZ2hTNVBMMTB0TkpKVm0rOWFIS0owUW1wM2dz?=
 =?utf-8?B?SzMrcWx0OGhBZGRNN3JFUmRON3VwRy9YODd1WDVSWkE2bjMwUmdYYTRTNUp0?=
 =?utf-8?B?bzVtRGNSM1JjVjdWeFlUci8vU2ZZb3RUN2hyb1h3dFQrYXZSZWVBSURON0xZ?=
 =?utf-8?B?NFIzdFBEYTJoZ0pYeC8ydzdIWG1mdmhDODZzSTNxQUoxTEJmeTVFTVNkLzVY?=
 =?utf-8?B?U0cvd2ZnNWpxSFJHVFlpd1JWVFFPU3liZ1RmYjBBbVZQUDJzTE95UXhpWlFh?=
 =?utf-8?B?WWs1QzkrZks3UkMwekVmUW1lS3YwbitvL0ZHUjliTWV4TG1pNkxSUllUdkJC?=
 =?utf-8?B?b3RtTjRZQnpndjdmd3BKUlgvcW03VW5EYTBsTnJCZmRiWU5FQVcxUWY0R1pv?=
 =?utf-8?B?Z1h6TUZiLzVMTWd6ZVBpVTVMeE8va3JLY0Y2MitrYm1ISTkzU2NBbUZkTVF3?=
 =?utf-8?B?VnQ4QWJkTmN2NTB3WkhTQllhRmFVaVY5MC8zellCOEtpbGIrWUdXZmsyUGdu?=
 =?utf-8?B?eVhPUTJldnhHVUFaMzhoSXV1L21uKzhqQTNxcElqcCtOaWN1Mmp1SUpEeGVo?=
 =?utf-8?B?R0toVWxXVDhralJtRmRmL0puQ2JVZzNLc2dRdmdLZVI3aHJaNktFT3VHK2pQ?=
 =?utf-8?B?Mnc3dlAvVWt1V0VnQ3hmNk03WWZPNkZBMjFaQmNKbjNYaWZSQlRKN0NKUGlm?=
 =?utf-8?B?VVZpZE9TcVpMWGwvOGFzMzRTOHpCenhuQU9IcXBCWDNPL1V6ampqcjYwVVB3?=
 =?utf-8?B?YjJncVhHSW5Fbyt2eHNzcEUrRzB0YmVrcW51Yk12NWxKc3BsT0cxY1ZpV1Vs?=
 =?utf-8?B?RkJGTlEzUG9rR2NHb3FaaVVJRHRhbm9uRG85dTRBRW04WVh0amRmbTk2dHZB?=
 =?utf-8?B?bVZYWkJYakJjS3B2bUFONFNvWGtuRHJ1TWpsTXJUTDZmTFljQmh6WHZDL1hN?=
 =?utf-8?B?T0dEKzluajFuYWZmK0xTTWNsUzh6S0lSMWdpYUtuNmdGN1U4MDJ2ZlExUVdt?=
 =?utf-8?B?dW4rT0NYcnpFRHJPVUdnMTVxazNXRjRYcVVhTFgrVTZSVlVYWVc5VU90WnRJ?=
 =?utf-8?Q?8ym1Qu4jMPyKSizI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3F869FDD37F1364A818D860A497685C2@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Wbci2YTAjKUmwyLTLgdmAM3EqZZMWslDIzqO+LRzk/7zuYEMXE8DtrckWNfyZlq89tjCFk3QJN2bJEZGmUi2wGvXPKAPQtpnlE6dZDfYhIe1eBC84CT700byRrC/iyLdYZoFGtFo0wpIwvVPtenh3zx5aZABBWXBUvSWDYl7rSz0GbOEJFzLoz2NHxHBIY/z6koTND21UuScEW5hbErwNVKRkDhTk6Fshse53PVLlojAKEEx1u7kHEQWrlSFRqLd1DRvQhfi9SRxzqi5BlTWIk3MhZZfZ1I7V7gA8QAhFr76REr9wXROsWNFYUbK5G5vWBQlos015ceyiqjo4TdwFtF3gtz3e/Y0rnf2dlYAwxAGvpRzEfP4/mpmYb9JUG8brpL1yweBIXf7ebeOCKEgac9AAlMGpJNshUNYaYdYOiiMGWxYYupqTuPDXhyXeKFPe+wFNxITh2c3IUjWsU8K4t82Eyf6a+GPm1hR/Jo9eER8uxShTdR5VS2m0hMJRy+/y9jrY7mfjhgcFEKD/TJDRp8aMEfwfpQ+SHVG9EAXdloFm8kRqez/bEVd3DpKEXxwkeCpSmP12EOme7ZlHt2XODGrqkDsEKEFAzgsN9gtq3o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7309.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42637ec9-1ca0-420c-42d7-08de5aa69c93
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2026 17:41:17.0404
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7W8vThmiLKhBD9Pmug1e8Mbv56437orQBqoFOwYyo4KW9EeSUKtp6HCAZJDmnSE8nveGQ2EH6TNaPdxG1UPF5aqh/9ht9Y6y97hYvKUb2V4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8420
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-23_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=872 adultscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2601230133
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDEzNCBTYWx0ZWRfX5KmcVTdgTKH/
 GcowYGvW8/+eZ3fVzwpelmvjYhbarFMH8BqcLI0yKQP0zXhwREFX7J+Z2PT7KYKUSuOTkUp8CcK
 Ukqt7L1zoTr7Y1pUERbmApJZJeY7ZgsnKeurTVLTev3mHq6K1Q+whrU70fuvYVSrXKRm8G8cdHU
 djxWrnuzHPx7VBiytREx5VbGCHBZKN3Kv3xAscR40OOa+cfanM6OptNCHY6k4KWV5WQPf5xbOe4
 Gz7EXqC1NOt9aYAjQTcZfguztBpYqF9gQN8Iq87eHblhEds3F1EnVDoZtFkwZrPe5LnNW2/kRR9
 digp8Ci5cHU97YgPkUlsxfQQWsUeViZ6J/SIh4qC2Y4Jr4xt1V6tMHLxDrWtuXFKnquMvR3YQfJ
 duAmHWmUn8Lzs6Rfg0pR+mLH95yPU2U/wBoeka0hx+72Ql2vqoIR4v8KutcNxMdw1kh6NiPaWIk
 CtGJAjj5+HXTWRJCzRQ==
X-Authority-Analysis: v=2.4 cv=de6NHHXe c=1 sm=1 tr=0 ts=6973b2c1 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=JfrnYn6hAAAA:8 a=S-EUlXTdV4lnZN8OWTQA:9
 a=QEXdDO2ut3YA:10 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-ORIG-GUID: Qjbotdf80CqTs3Q9OBzcHhILjSXeIT-r
X-Proofpoint-GUID: Qjbotdf80CqTs3Q9OBzcHhILjSXeIT-r

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
