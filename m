Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E25374752;
	Mon, 23 Feb 2026 20:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771876852; cv=fail; b=l6Ll0a3p7/ZyDiS7BwYN32q/+M6AbVp2iLuUR7xdBTTxpXwVsHTAwMvWFFwhsQKx/P8p0nHwRP4rFdmewWWEmswR7o/g/WWwyZtJlZXaKNrnnXUnbhu1FcR+/XjhdqN3n0JiAYacFae4/u53oU8P9lnUecWlGh8JR5JsuyiEjn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771876852; c=relaxed/simple;
	bh=lE1EXCO4x4W+EYV+s3eyBOSG6DUoLYSfUK+U1k4XGQE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=k/eW2D00Gn6lvSVI8FuEXZ3zdf9mQx8qA6EWgeRen7/N0kc0pyC1yM70Aqth+bhAV9wvN/hFYej5TsF2j0gG9Uplp9WtiDW/9COvq2GrXuthU8jQma6N8bQJhjMpu+6NQjTh6Kzif5n0tq1aSVbh0E6gU3mfi+OlhV2wi+t6acs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=r9HMiM2i; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AavaBqI/; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="r9HMiM2i";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AavaBqI/"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61NEuxFB1959001;
	Mon, 23 Feb 2026 19:55:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=FlwcTEU15t9/fokiPpiNiyFhEqeMycKoedl7ZXcpY38=; b=
	r9HMiM2iBnyV+FAPGLFCxeeDqUdGNbih3vdBVUxXnHg2PCjsk7BWZkt2p8U0FQLa
	vm2CEed7snjzvroNebr09hFJtLxjihxoBINwfvw8+tWx1Zy4Y3IbSPa7g222ItBn
	Nm/L86/2kEd6wsJgR6l4c9jKTqHPRrNKzLbAWn2I8ZMeA9afhFrrofzo+z/nz3Hh
	E6OLSN/ygiwtcX/1ZUFdJssHrO3kG3CE/neEnGjJA5xojdOU9AH/biKX/Ir0pfPn
	/Y9UzMNBKIvGTO1aZsgOd7lpyqNxliHox3KaKcTVhjD8MlRVdEOeNLED6htKDAtl
	6iwFSHER5Qdvlfz5mhnEDw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cf3g3k2j1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Feb 2026 19:55:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61NIc1Lp015659;
	Mon, 23 Feb 2026 19:55:17 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011000.outbound.protection.outlook.com [52.101.52.0])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cf3592gh1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Feb 2026 19:55:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DXVzvTjJ8ZlVLdV0KjS5mRV8e/XMXMwXFB6B1b3b0k6p0eM9Yy+vSDd7erVCd0DP2X1oJ8UP+bKXGKeuHhQ5cYrtyxWjp+/KUHdwDJrmhDZPXSql6XNb+tJCvbO4ZmLEW2yJV0xpVMVxBSQReF71XTfJIX5jqLPG9Vwe2FzZ3D4LDsga1Mj0fuyuwxO77HZZBeJa1M4l55L2QVjelY3niPKptwh/UiuqYbCCzuCUBrCNmKbRBq3JrI59no+3kkMOO61tgDEWyDtUEeIOCAAtyL7qKjPIH+yZIg6qBHWqJXE1T9ZUGfEw3vXcpZ/yFC0mlKYcJnXy7aLL8oH+qFnnxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FlwcTEU15t9/fokiPpiNiyFhEqeMycKoedl7ZXcpY38=;
 b=v5zK4QULaoOdtqKgr6WPe0ksWXGKhGMdJHbnoNIzZr/xt/z/FLFcoSC0Uuj0NPUyYt0sBtI19e0Dxdigt6nVJ5kquUT3Gr4OHkHULO5yXKBPWjFtjbCY8oIAP+SIfZAgYuEOBMLwb7zF1pXEm6MzeBTuKE22abDV0GSs6vYJw1KIAjnK832vFnKDujDCPuQUQuxK4ZwNx2WJsAxkDmd+YkgTvzbxu4iS8gytna30sQIT8norvSQIHp1OdpSSFATCRHVgYUKlMeOFfuKy5f0WsiJQOCgT6YKmpa3ifRLXQn4cV/I1qtJa8IaE2ySCGZnXqlydWNqnJEoXrc/ZPNkY9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FlwcTEU15t9/fokiPpiNiyFhEqeMycKoedl7ZXcpY38=;
 b=AavaBqI/irCV7PTpAeK2jkjaZ7hAmBXeDEFoqtAgqMCFTh/yRHqqZ2s62ghrQESC93qS6krLZ+y6rlhve2ZRFAYWJv/TlwaMyIHHyb/c8Pu2Vk12m6hVMXNY+XImMjkC4d+DR4ZH+tIgT/x+/CkXd8uJjpa/AOyHMaI7qOmXyi4=
Received: from MW6PR10MB7660.namprd10.prod.outlook.com (2603:10b6:303:24b::12)
 by BY5PR10MB4289.namprd10.prod.outlook.com (2603:10b6:a03:20c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 19:55:11 +0000
Received: from MW6PR10MB7660.namprd10.prod.outlook.com
 ([fe80::c2dc:a34f:6987:1230]) by MW6PR10MB7660.namprd10.prod.outlook.com
 ([fe80::c2dc:a34f:6987:1230%5]) with mapi id 15.20.9632.017; Mon, 23 Feb 2026
 19:55:10 +0000
Message-ID: <7302e25b-dfcb-4117-85f9-870632999dc3@oracle.com>
Date: Mon, 23 Feb 2026 11:55:06 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/22] Add support for shared PTEs across processes
To: Kalesh Singh <kaleshsingh@google.com>, Pedro Falcato <pfalcato@suse.de>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, andreyknvl@gmail.com,
        arnd@arndb.de, bp@alien8.de, brauner@kernel.org, bsegall@google.com,
        corbet@lwn.net, dave.hansen@linux.intel.com, david@redhat.com,
        dietmar.eggemann@arm.com, ebiederm@xmission.com, hpa@zytor.com,
        jakub.wartak@mailbox.org, jannh@google.com, juri.lelli@redhat.com,
        khalid@kernel.org, liam.howlett@oracle.com, linyongting@bytedance.com,
        lorenzo.stoakes@oracle.com, luto@kernel.org, markhemm@googlemail.com,
        maz@kernel.org, mhiramat@kernel.org, mgorman@suse.de, mhocko@suse.com,
        mingo@redhat.com, muchun.song@linux.dev, neilb@suse.de,
        osalvador@suse.de, pcc@google.com, peterz@infradead.org,
        rostedt@goodmis.org, rppt@kernel.org, shakeel.butt@linux.dev,
        surenb@google.com, tglx@linutronix.de, vasily.averin@linux.dev,
        vbabka@suse.cz, vincent.guittot@linaro.org, viro@zeniv.linux.org.uk,
        vschneid@redhat.com, willy@infradead.org, x86@kernel.org,
        xhao@linux.alibaba.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
References: <20250820010415.699353-1-anthony.yznaga@oracle.com>
 <CAC_TJvcaJdEzK8n9BK0qgEXdzjzXtbA_Zk-ybfmG8kjNExVCzw@mail.gmail.com>
 <fqabaahjjlmoc2xh4cwh4ykbqyu3rnzvjw5epxi5wwpmgqth7f@d3mqpjozwmo4>
 <CAC_TJvdRsfzYohiKW=82N8Ofi5V26rX1GS0M8HeaX6CEsgc+PA@mail.gmail.com>
Content-Language: en-US
From: anthony.yznaga@oracle.com
In-Reply-To: <CAC_TJvdRsfzYohiKW=82N8Ofi5V26rX1GS0M8HeaX6CEsgc+PA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::27) To MW6PR10MB7660.namprd10.prod.outlook.com
 (2603:10b6:303:24b::12)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7660:EE_|BY5PR10MB4289:EE_
X-MS-Office365-Filtering-Correlation-Id: 651c1f4f-a83a-42d8-458c-08de731573ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TjR0TlkyWVlaNnVVVHNlaDJCWm5FUGZUWkdCeklMczE2WDVtbUZKVStHcUhL?=
 =?utf-8?B?VU0zcDhldlRxUFV1SGJOd2trbkJoS01EaENPMStwRGs3SWxtMnpHdjFtNHBV?=
 =?utf-8?B?OVUySXAvVWdJNERZMHJZNmliU1hHYTJLVUVpUWpGVEFoeDhrMFppa0w1M3Yw?=
 =?utf-8?B?R0FQY0g5U0R2N0xlNGgvRlk5SmdNWFBtZHJoVzVQcUxnOG92MTdscDNZV2hw?=
 =?utf-8?B?dERCcjdtbFFrcHFPemxBbW14cU40QU5tNitET3AxbjVMOFk0NTlpUlBSMm5n?=
 =?utf-8?B?THIyQnJVN2pyQ0xZSWZyYzhLZjQ4YWxnejRYREpEZmlGWVQzYWkydmJqTU5E?=
 =?utf-8?B?RUltMUMvUnNON2R4WE92WnVWNGQ3N25zeC9BUTc4ZmtuMlMvQXA2VC91aXJZ?=
 =?utf-8?B?aHBrUzZvVHdWdStBbm5ub1VMQ2ZaYlZVU2FCd3puNHBydkF4ZjAwRFRscjJ0?=
 =?utf-8?B?YkVCWFZLNVJDRXRrd0xyeXFRc3VRbDFJT3l3dnZrM0JBa21ldHBrY25GQU00?=
 =?utf-8?B?WlRhU25Wek4vTTZERE9xSTcwWVd3MVAwU0VEcUdBNlBxUytFUUVBcnU4NWVK?=
 =?utf-8?B?clMvOXpkQnM1TnFuNjFEZDUxVDRyYzAzNFBHVURsL3BGSWhDZHNLTkFTUUl0?=
 =?utf-8?B?b2pRU29wd3ZUa0lUL3l1bC9QNXdxSUxLTXlXMEFrbVFFTlpNQitqZWp5NWlh?=
 =?utf-8?B?VUsrS2lpUHd4RmY5azJtWE1XTjRlZGVkVWxJU0o1R0tRR1BOb0xQN1FoYlBl?=
 =?utf-8?B?WGRCRSt3UkVMa0hyV2dDMVJReHN1K2J5S3p6ZEtqaTlheTZFdGZoMzQvamVx?=
 =?utf-8?B?ZjJtSUVJSXdvc0dnc1VLcFlaajI4OThqU0tPSkdGMW14eVNqT29GcmV6VnpP?=
 =?utf-8?B?YTRBUWc2emlPSUlNMUdJRUZNLzdkNThMeUF2b3Jzb1VlSnNwbzB6bzN5Q3VO?=
 =?utf-8?B?eFdydGJhM05nV0orRHZIL1dwM1E4RCtPVmw0ZGJKU3RLbjVveUhwWldIR1lm?=
 =?utf-8?B?S3Y1T1czTDBtQWgyZ282OVNOMWJqUGRkM29QSHJDUWZzeURFd0R0Q3l4aXUz?=
 =?utf-8?B?RE9mbS9VSjBKT1YrNEVMSGJhU0JOcjBuSDhrVm8wUGlNbU9yVXFsVWFrb0VJ?=
 =?utf-8?B?S3MvZlk0MEc2ZjladllLK1hRbElOWFppTzA2SkkyalVjSEliN0NnRWtoS0ZJ?=
 =?utf-8?B?Mmx0QzhwNGlLeWJpbHIrOWJTRytYSFI4OTlnYlVFQUlrZzRQWUJHZG9FWUhN?=
 =?utf-8?B?b0dLUUk2Zk9rM2h2aS9DYkRCUlNtbHdTMmJYc2dnU0dSSHlBN0F3cmd1eEh5?=
 =?utf-8?B?UXkwTE9LS2N5YWlVVWkrQUdVWEZNRGU2cnNNOWowRUlWQWxxVHltRTlkUFFa?=
 =?utf-8?B?eW02T24vMVFjbElpS1ByQ0Zvbi9JSzJaMkw5cHZsbVJHY0J6WDdyS1VrV1ds?=
 =?utf-8?B?Q2IwRTF2QWQ4ZzRPUElBeldBQm9qeWFVd3p3MW53dHNBSUp1YmxSVmFzZU01?=
 =?utf-8?B?ZVZjK1pLZEk5Vmlkc3RDMUw1YUt6dWl4bVppeVNTaTVRdEJWWXJSVDNEdHlz?=
 =?utf-8?B?b3k3bWt2V080TDg3SUlLTzYyRHh0WkxEd21SNUpUOXN3Mnk1ZzVDMFhmNkdU?=
 =?utf-8?B?a2llVHJSRHZYMEFYekRrL2tJeVU4ODhCTm9pOUIwSDFNRHdXWGlQRVlZYzVX?=
 =?utf-8?B?UGU0QXJUaW9pUkQ1OXV3Y0puUEN1LzR0VTlSZjRSMnBhTzREWTk3d2dJOTF0?=
 =?utf-8?B?NkYyNCtOMGJncys2UVpaVDlNR0x1bGEzQkNLdkRkQVVIR3M3R2VScDlKK1dI?=
 =?utf-8?B?YmtQTndtMmI3dkFRN090Y1I4U1FzN2V0OCsrdlNCU0NvNUN6dmR0QzZwdy93?=
 =?utf-8?B?dlhFRU9GVDE2QlkwZThvYnFxY1ZoendoZXBlaW9HVFdudnJPWklZUWpvSWJC?=
 =?utf-8?B?WitoRlovUHdjMWNhUms4cGtCRlpZU2pYODFKVGtnZnpaZ3djZDFVdEVxeHVz?=
 =?utf-8?B?NUpRUC9rVDJQeHdPZmU1ZHFra0hpeTcvbTN6bm1TbXBhSlhVNTQ5YlBWNUUw?=
 =?utf-8?B?REtvYURFRnVWaFNUYVp0VGVPaGtKYkluTVNxenNqVlVMUnBGaWgyVU9nOWpr?=
 =?utf-8?Q?871Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7660.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZkdlNzJnbHNENXZCQ085a1d4ODY5aUlwNTEyYWhwNW1qRmpnOWl3dndnRml2?=
 =?utf-8?B?RDVQakVDc3ZpcG9tUFlJWTVjS1E3SVMwZHB6MFpQNjhsVmw5ekxVSEJQSElM?=
 =?utf-8?B?R01hNlB4V0FmOFJBdkNvZDNHZklOQ1FBa2lxZXErZW11bTZQTEVYV29wOHd4?=
 =?utf-8?B?dTNXL0UrM3ZPTjV0b0g4MFpjSHkwYzcxK2pWeHJGWDJtajdpREpQN3ZadXRB?=
 =?utf-8?B?VGJIUFBiMkpZSWd1YTFRY3luc3I2M1VkSGNpK3g3RHpoTUZtbTV2R3pkekxh?=
 =?utf-8?B?VytXKzRGa2h6dG1GWmdzT2lTOUtwMkRaeTNXdWRueVJ4ZHdmTzA0V2owMkdP?=
 =?utf-8?B?ZW1nWGNPSjlWVzl3RVlncTd1UG1hMGYxRVRqbFA0cExrQ1ZrL2svOHVYaTlL?=
 =?utf-8?B?YndHajBkd091TGl1WVp3UDBzcWlld0Fvem16WDFHcHVKNzJzM2hxZGRBMG1k?=
 =?utf-8?B?Y1J0K0l1ZnVSZzNJRE8wZ0RWOGFES3o5NzI2UEFnZjZjVDFyOWVBM0lleGFE?=
 =?utf-8?B?UHBYcVBmd2RSSjExUHZUZkFFamJYek80Z0EzQU5HZWF6Z2xGdnhMWUQ3Q3Fh?=
 =?utf-8?B?NnRhSXdaVXlQZ3RPRFZEWXFudHhwWTFSS3BwNlVUdFpGSC9RSkdqRDRQRVdG?=
 =?utf-8?B?YkU1NDVySnk5cW9MRXd2SXJMZUJmVVNmcExlY01Jc0JLbDlhb2hmUURlVm96?=
 =?utf-8?B?SGNObmIwYURYbUFvMEU4ZkJXaHI1dlVSWlR2ZmxGcHJRWG85NFY1N0VrVjZE?=
 =?utf-8?B?eTYzYmUrUHk4Rys5UXhDSWlrMythV0tibkFWVldzdVpWeCtKTi8wa0t0SVBl?=
 =?utf-8?B?WjkvWTRMTHNCN1Q0UzdDa2JzSVkxYXhOU3c2OVdGOS9pZTl3RHRZaTE4VFl2?=
 =?utf-8?B?REI4UlFTUG01WWFmUW0wMmczMVlyQ3h6UFVDUnRrWm9kQ0J6a3FhY29GbUZk?=
 =?utf-8?B?N053UndRQmp2dkR2Q0hlOXF2TW90T3NYTW81U1YyUCsrYTZmdWhjYjh6S1dL?=
 =?utf-8?B?ckFYSmtLUUpybWZuZ1kwSXN5VlhRak5oUm9uditZdW4yUHpnVVhMUmsyTGJa?=
 =?utf-8?B?Vmw2dlV3ZytseWdSTUxYVzRMdkNZWm5Wd2kvUGh1YVJlK001dWVFb3dHWHlm?=
 =?utf-8?B?bWpUS2dRclR5YlBQSVlJZ0diTDl2SlFzYTBsbm40cXdua0F2cWVTaFFURnNH?=
 =?utf-8?B?N3RRTXVSZUFLNDNuREE3MEd1S1BEbzVYSlpuMFRvWmZKNEFnb2ZBYnExaEJp?=
 =?utf-8?B?Uk1hMXZ6RGNLZndKaGdGakM2aWJoTlZvbWIyZjhkL0hMbEE1OExCN0NnYUd1?=
 =?utf-8?B?cHJONWJGZWF2MVNTSzBRbHpwanU0eU0vcUdjRzF4a1A2VGZmKzE4S1Z2MHBZ?=
 =?utf-8?B?RzhGVlg2Z1UvQTJFa0tRMmFvUUZhNi92cHJySTFxVzZHMmlRQmFlL003NXlJ?=
 =?utf-8?B?RkJQa2cyT3VnbG9sQWx1VkZDaXFkVDVod2djdU9taWpDVHdjUG1vaVNUeDMy?=
 =?utf-8?B?Z3U3N3pJVE93b25hc0NnMEF2anMxSit0cGtobWFyZVM4V0FsYVExN3MyL3Ux?=
 =?utf-8?B?VEN5azdJcWtOQ01GQnRMdzJhMXRXZmhzOFBOTC9IWUQ1MUJNeVBlOEJTRng0?=
 =?utf-8?B?MktSK2EzY0RDYVJXajhJenNvN1l6Mm5hWmlWTlNUWXprVnFEdll2K2doNFdH?=
 =?utf-8?B?L1dOTFRnMEFzQVVSY09vdXZPVE1xbUhsdHJSRVhLSGNUTStGdUtvZmx6UGh6?=
 =?utf-8?B?RTZHUEt4ME01RERLaTU1WU9VTFJodkdiY2VXanhvRUh0TlZ1OWxLelplT3J3?=
 =?utf-8?B?OVJXczJsekZBekZMYnp4di96dVlzSEZCUVBvbHI3dC9JYmh1VnBseHJFY0Rl?=
 =?utf-8?B?YWorcEFhYTRlSGRZQTl5cHdEWFRra2NsRHhSUHYydFlvNk9SS0E4YzY1dU1m?=
 =?utf-8?B?Sk9iY2tXeExjazBBdlMrVDJSUUtvMmRZbGVCS2Y5QS9xZTgwQ2hBWmZ3eVYr?=
 =?utf-8?B?YzQvZDdOb0d3OCs0dUwwMlR3eXFhTWVhcFYyTlBTZ3NadXpVYXRlbGZhVkVJ?=
 =?utf-8?B?ekxzMXhyY1FCdGRjckt1aitvREJ2bTlac0taNDdyL2EySVVDQUo1SWVVUXF3?=
 =?utf-8?B?SzRVWWdHM3RwNW5mQnpPOFllcVFXMGhzblAzRFBFVCtTSmtuVzBjMDh6OXFG?=
 =?utf-8?B?bG9ndm1jR25nYW9MQkU1VDErQitkUmZ5K2lEQWNmVHpXZjFndlY4STk0eFZi?=
 =?utf-8?B?WTlqQURiekMyQ1J5WjlYenBNSFVUSE9SQkczSzFESXJKNHh1WW53c0dqdXVF?=
 =?utf-8?B?bHlEYWp3SVdYOE1Wc1c2aFdidTEwUXpORzJacytmK0FvUEYxS2FmaWxpK0dV?=
 =?utf-8?Q?r2qjbzj+eh8XmEdM=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XD2eMUxg0SiBOE53NUruFbQrs4tsBUHIcnY2HvGRjE48n1oYF7x5Jw14AdljroBB7ILTGSZvVuicjz1SG3E2OtBFUbXoAuRVnNZYUlmz1f0g8iROaZ2IWm2EhpRsmmFjrvIoB5Rr3Y+1dbR6r7tDQ7pQ1kmrdsf7Qij/haX6t0s6Yfjoq+drwe98+0nUsiRGVAoDRDLARZtIHd+GplV++UmP53FkotFbe8ooBecVtxfshf3v50mgTfUi0XhSq2XToVDS8PBL8wGqaOma4rQbPbabYRg5xuPK5DmSw9JAxyjm2d/VDh70v4D90YLUisTsuuYyRogjrAbeXIaKJBZalt13MogG+bUQrocEZqlAQbs4fpsqf7I1PkRV//Viz54PyyPaw6WQX+x0tN0On5DVJfhNbVcR2SJBv5fn9q2JPIl6G7J8WvNgXvNOYcEMo4qX5AUeN6U52HT8gEaqyjP6stRJisYczbffVPIs95P3N8ZZicvwoQ6tkccwCoix+l2InyMDvM3Z4l/k+hi+wQOFJZ8HKVzMqMirTo4OA3Jmej7xmsAUOi7QkdqcvAaXMIE3UxrFi2ElHmy3AAs/BuaViCHEWixzE1NPA2hARCFZ+W4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 651c1f4f-a83a-42d8-458c-08de731573ac
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7660.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 19:55:10.6898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uOynaGTAhSDnMQJ7C2DiJ/HEEi2afJlxQ3lY/iVbZhRSCd5jSbXMH5Qc4wFFSjfsGRxokDKsQhDcGPftNdSAsTX+bWPCE0iVLobSdl5X9Mo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4289
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_04,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602230173
X-Authority-Analysis: v=2.4 cv=Y6r1cxeN c=1 sm=1 tr=0 ts=699cb0a6 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=yPCof4ZbAAAA:8
 a=aErTLmgu16iPnjBBIpoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 6PIU1LrYgTr_kR6tNYx1zdoNMoSAi8oS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDE3MyBTYWx0ZWRfX4qKnKJbui7a4
 vnw5H8s+25gep/FOoeNyNgY7HPmM+TEtWNx9t9tBGKUtUw28Gjf7XKoOUPQkh/oisk6yfqVSoRN
 DB5fOncBAB0fhAT0B7mw6ouO0BR7uNA/3bC3dvou4vcdboi3/Ep1irfl4B45yaRL8an2s7Lpr4F
 o+KKn5NZPvK/yyT5eM1G/izwn4ScgxcY2m/+WoBf4+DugRw3CM6evMNU1LaFgnK+rApyTD588HE
 EbDI3JeEt2wLyOFBV3AgN52e8D4gPh0RJgaGQNzWN6qHSRxe/MfCkHUoA7ylQfkbjrUZFhuceiH
 0uO5NBMa7551teH7rir2IELn08LKbo22LPp5XB13LaGIM+zJ7Evd0kkzvdam05EoWZDGjCc3vLF
 2c5RqeflMBhqL93aXxfgqOBEG+/6fs2+9k97HlVgRYMKprVFRS9dIlFutYlhsGz0SiNxQn7+cUY
 T6e6eVB5ywzTyn8jb4w==
X-Proofpoint-GUID: 6PIU1LrYgTr_kR6tNYx1zdoNMoSAi8oS


On 2/23/26 9:43 AM, Kalesh Singh wrote:
> On Sat, Feb 21, 2026 at 4:40 AM Pedro Falcato <pfalcato@suse.de> wrote:
>> On Fri, Feb 20, 2026 at 01:35:58PM -0800, Kalesh Singh wrote:
>>> On Tue, Aug 19, 2025 at 6:57 PM Anthony Yznaga
>>> <anthony.yznaga@oracle.com> wrote:
>>>> Memory pages shared between processes require page table entries
>>>> (PTEs) for each process. Each of these PTEs consume some of
>>>> the memory and as long as the number of mappings being maintained
>>>> is small enough, this space consumed by page tables is not
>>>> objectionable. When very few memory pages are shared between
>>>> processes, the number of PTEs to maintain is mostly constrained by
>>>> the number of pages of memory on the system. As the number of shared
>>>> pages and the number of times pages are shared goes up, amount of
>>>> memory consumed by page tables starts to become significant. This
>>>> issue does not apply to threads. Any number of threads can share the
>>>> same pages inside a process while sharing the same PTEs. Extending
>>>> this same model to sharing pages across processes can eliminate this
>>>> issue for sharing across processes as well.
>>>>
>>>> <snip>
>>> Hi Anthony,
>>>
>>> Thanks for continuing to push this forward, and apologies for joining
>>> this discussion late. I am likely missing some context from the
>>> various previous iterations of this feature, but I'd like to throw
>>> another use case into the mix to be considered around the design of
>>> the sharing API.
>>>
>>> We are exploring a similar optimization for Android to reduce page
>>> table overhead. In Android, we preload many ELF mappings in the Zygote
>>> process to help application launch times. Since the Zygote model is
>>> fork-but-no-exec, all applications inherit these mappings, which can
>>> result in upwards of 200 MB of redundant page table overhead per
>>> device.
>> This can be solved by simply not using the Zygote model :p Or perhaps
>> MADV_DONTNEED/straight up unmapping libraries you don't need in the child's
>> side.
> I think that's a separate topic, but that model is used on billions of
> client devices :) The common runtime for apps and other core system
> code is preloaded to significantly reduce app startup latencies.
>
>>> I believe that managing a pseudo-filesystem (msharefs) and mapping via
>>> ioctl during process creation could introduce overhead that impacts
>>> app startup latency. Ideally, child apps shouldn't be aware of this
>>> sharing or need to manage the pseudo-filesystem on their end. To
>>> achieve this "transparent" sharing, I would prefer Khalid's previous
>>> API from his 2022 RFC [1]. By attaching the shared mm directly to the
>>> file's address_space and exposing a MAP_SHARED_PT flag, child apps
>>> could transparently inherit the shared page tables during fork().
>> So, we've discussed this before. I initially liked this idea a lot more.
>> However, there are a couple of problems here:
>>
>> 1) mshare (as in the mshare feature) isn't really aiming for transparent here.
>> There is e.g a specific need to setup an mshare region, with a few files/anon
>> there, and then later mprotect/munmap parts of the region - and have it apply
>> on every process that has it mapped. This is why we're aiming for different
>> system calls (not ioctls anymore), doing munmap(mshare_reg, 4096) is ambiguous
>> as to whether you want to unmap the mshare VMA, or a VMA inside the mshare mm.
> Since we are interested in sharing text here, how does this play with
> stuff like symbolization for call stacks? I believe this is another
> reason where we might want to avoid mapping the pseudo mshare file
> wrapper?

I haven't explored shared text, yet. There may be dragons there.


>
>> 2) Sharing the page table at all (even worse so, Transparently(tm)) is a huge
>> pain. TLB shootdown becomes much harder, and rmap as-is isn't suited to deal
>> with this case. The way things are going with mshare, the container mm will
>> have one single entry in rmap, and then actually doing the shootdown is a
>> huuuuge pain (which, fwiw, will probably need a per-mshare TLB workaround),
>> because you need to find out and shoot down _every_ mm that has these tables
> I agree the TLB shootdowns would be a pain. Perhaps, if there was a
> concept of a shared ASID/PCID in the hardware, that would make things
> less so ...

That would certainly help. sparc64 has a secondary context, but that 
doesn't do us any good here. :-)


>
>> mapped. And then, naturally, since you're sharing page tables, doing A/D bit
>> collection on these becomes extremely useless - and that will naturally pose
>> problems to the reclaim process if you abuse it.
> I think in the use case I described, it would mostly be sharing
> MAP_PRIVATE stuff, and the access bit should still apply for global
> reclaim. However, I agree it becomes difficult to reason especially if
> you throw memcgs into the mix.

mshare won't support mapping objects in it with MAP_PRIVATE. Sharing 
PTEs to memory that can be COW'd is problematic. If it's something that 
can be adapted to use MAP_SHARED then maybe things can work.

As for memcgs, the current idea is to have an owner associated with an 
mshare region. Currently this is the process that creates the region. 
Mappings in an mshare region will be evaluated against the mem cgroup 
the owner is a part of.

Thanks,
Anthony


>
> Thanks,
> Kalesh
>
>> 3) other misc problems that make it hard to work transparently (VMA alignment,
>> levels which you may or may not want to share, you need to revisit most page
>> table walkers in the kernel to get a completely transparent feature, etc)
>>
>>> Regarding David's and Matthew's discussion on VMA-modifying functions,
>>> I would lean towards the standard VMA manipulating APIs should be
>>> preferred over custom ioctls to preserve transparency for user-space.
>>> Perhaps whether or not these modifications persist across all sharing
>>> processes needs to be configurable? It seems that for database
>>> workloads, having the updates reflected everywhere would be the
>>> desired behavior. In the use case described for Android, we don't want
>>> apps to be able to modify these shared ELF mappings. To handle this,
>>> it's likely we would do something like mseal() the VMAs in the dynamic
>>> loader before forking.
>> mshare_mseal!
>>
>>> Perhaps we could decouple the core sharing logic from the sharing API
>>> itself? Since the sharing interface seems one of  the main areas where
>>> we don't have a good consensus yet, perhaps we could land the core
>>> sharing logic first. Keeping the core infrastructure generic would
>> I think the core infrastructure is relatively generic (at least the
>> small core mm modifications to get this to even work) already, but
>> perhaps Anthony can comment on that.
>>
>> --
>> Pedro
