Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020113.outbound.protection.outlook.com [52.101.195.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866F822FF22;
	Fri, 24 Jul 2026 02:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784860524; cv=fail; b=qp4uoNaOY17Lfpc1Uw29cdJH7FiJOlLh3+0Xuk8zsUTz4AolFW/3O4EFKUP+K/rl5E9GqTcPrPKByb0mrrt51QtTILSYTKKqlQFR+NCnMQxlsig+GES6ZvARc+O3PiPyiao6x7B1Iu9ZHDhoq+T24prJTYfA+flyDT3ORYkOato=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784860524; c=relaxed/simple;
	bh=f05pGE98RXrBiDbNtt/jcEhY92QaX+4g49TlQSVYwgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qPl6ioKdm4NPdl4bMFiNBdJAiIDbS96E2V8vjo36pt008Mg8Fdv9m+pxdzpFbyvccT1PHGkKytVQaxh5AebVrznzMC4d50nU2v73FVZpQhqHHYCBLZ5K62KsB4T8Pj4/uk1QQwrTywWiHwm1BgRTDGMxy9EuzZVFFynk9uV7Ma4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.195.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m/fhrQPM+YlCOFb53P5rpCYgVuRmp+SbWaO+aQ9jSV6KSmtPPclIYG6lz5ypmhTuEl0eh+k6jvOhch3dgg2tvmTANWjupvb/EuZbqfYrIwYGWnQnr9yNBHTL2HLQJNnRW30NJwXQ8oLpUoKABd9Ra38lHNT5S6kMN4oQkJlLJqotjTrjnRjcxWZG3EU5oroO3kBuTrmruB3Z17Gvg/GBqieVLe2Lq8hMcboRalUcyHsrngr6mTJpJ5W8yMnwc7LzuE6u1fYl95pESeko9QT124mieRG90YOcj7aGq0J4b8796rWiQ7qZSjDJWInJh+IK+yo5B3VI0W3neDCauLK1FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=6z6uG5KI34ky7da/YgfY7tCb2Sx9KIw0nj9qvrWhHbQ=;
 b=brSRkMrsMKbwvsK+o9QJtN4+vIhcu/9ODpOdJv08rxnUbwtX5gURmzTr88xPmFtOxfCUizb/hzy8shizbxXycR79j95TZn96yq0zRxuUzHgoa/8uQ0g+xBxyWCSA1176/16p+aECqYi2VXTrhBt5MijNDqDS3vXWkCVMOyMmaJEBd08Eq2ygKgbWccMzZ9aKBLprO1ZkL8dk50giBVnxY42Qv6KuyrobpZGZ7ruf3CKSpSliBkLNvtOs2KW20sPFfWWwm7OWZjxUISxmey7bM9L+bob+ky56AuRe8KAGyaMT1tVEnx8D9OgZKz6oh+3wslPH7F+RICnkcfo1ELkTgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO5P123MB9015.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:4ce::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 02:35:19 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 02:35:19 +0000
Date: Thu, 23 Jul 2026 22:35:14 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: arnd@arndb.de, mcgrof@kernel.org, petr.pavlu@suse.com, 
	da.gomez@kernel.org, samitolvanen@google.com, peterz@infradead.org
Cc: akpm@linux-foundation.org, mhiramat@kernel.org, neelx@suse.com, 
	da.anzani@gmail.com, sean@ashe.io, chjohnst@mail.com, steve@abita.co, 
	mproche@mail.com, nick.lane@mail.com, linux-arch@vger.kernel.org, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/2] module: Extend module_blacklist parameter to
 built-in modules
Message-ID: <4bxaoh2new6qcvfjjyuhjcwd656xx4zx6gttlpegtul4hyej4r@xaspgy5rxy5a>
References: <20260724014345.589326-1-atomlin@atomlin.com>
 <20260724014345.589326-2-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260724014345.589326-2-atomlin@atomlin.com>
X-ClientProxiedBy: BN1PR12CA0010.namprd12.prod.outlook.com
 (2603:10b6:408:e1::15) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO5P123MB9015:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a01e7e9-c694-4698-c14d-08dee92c33ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|23010399003|56012099006|10067099003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	BLZhNOPbsf/29eSh8ItSzJ8yfKPYmvMTTitjNk3ZSt0CvIZNQnRXl9YvIIdZBoz1sypV1A2f/9f/UXGBoFF0hGd9QfMsXxJJ84NcROJbhEpLlMY0+qe/tfaXxzs+ZZlzjmvjsBiyTF9//mu07Rr+ihs1aumuysrskgTODHMOq0L258YZrS9WRMwRt1IR5ptMHILyJY4fG05CUFj9wmvJIlSAu2kL1MeBcb+/P8LEmZyIcopV8eItvVYAFMmhZ9euI3i3sGgzlnmQKRrifYtM3o2KXS/odhT2AK7exd2oBiF50a+KejJf8NwuK9LdkQdhpYkjKzIdSUs7ab0z5k/po0jhDZeLe9D56cAZzLjWHqwA9cSXu+S3M/vE/tiN2Tu/BSoK/sgn77KF8mCBeQ+NiPDbwdCySCmaRTirbZMh6zJ+/MpYd6TLrw/uyd26mfvCOTHoqOWCsxz3+NWY7rdiQlPm9t2SLkG66AH/neL2vTk/oNrRUHfVBmp776+Mc89psfG+mqFnRUQPj5i2MuKtm98mzQ3zTC3Cr77V2M5o/0VdxZVT5li8AultrrF+IvZCrMbmZ0jaDRc0SuRWoAwrie1ONv9PvlQF8ALyEb+vTpXhEQ90PVaDQZ8LgTD9xLvjpNVM2DjMuLDu23AK7whdClABxJrGIGz0QNs/omlDIAs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(56012099006)(10067099003)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OVl0K1hZSnNNbTFpRlQwWG5pSU1weDFwRiswZUpPS0hHWm0xbWZ4TkpmOTB6?=
 =?utf-8?B?azUxWDlnOEEwNVdBMGZiRDFBeHVEUUtPM2xyYmFJQSsvbUVOQkN3Z3Y5Ylhm?=
 =?utf-8?B?RENUcThpd3kvemdhVnB3MFZhRGhKaFJCL3dVa3JadURoNUxyUmxzNmF1SGtL?=
 =?utf-8?B?NFRhWUVNcXljREY5RDBQWUhENHdsNDUxOEdUQno5S3o4ZWpwWGEwWm1SSmVy?=
 =?utf-8?B?SmhvdlNEeG00MW9oZ1UvMFRubzNaeWlZTm9oRkpLNXRsY0l4Qm1xdmVUR3hS?=
 =?utf-8?B?OEx4NzVSZEdiK01yOUUzaUNuZUtnQ3QvSUVwd0lEMGVXb1pIRzlvZnpOME9T?=
 =?utf-8?B?NUw2NDlOcFE0cWVKUEYvRzVLa0tTZFRzZkdldU9WVGI2U0c3MUJ3SnRCRWwy?=
 =?utf-8?B?TjMzR3l2TjRQWFNwbkQ2cjRIMDkwdVNuYTFkcjl0eDBnRmlqd1M4TFRMUzdU?=
 =?utf-8?B?c3Bvek96NXlkdzdFSkF6bkJXeHc5QTBRdXkwTzB6K3MvajJubTZpS2xXK3l3?=
 =?utf-8?B?aEVuQTJRTW1ScTk2b0RFdk93ekNSOUl6QUZ0ZEYzREFDSnBvc0dQMFhWTUtT?=
 =?utf-8?B?cVI2RjRzY05Xb1FxM0lUeFhYVnU5NlVQOGk3TU9jTVdybG9ZdUZzUlZiOGtL?=
 =?utf-8?B?aVVxK0hmcU5qNHZLN1RVeTU2enVWMlU2V2VmTVcvaFNjcmt1WnRSMk1YNTA5?=
 =?utf-8?B?RHYxKytnUTBDWnNncWFCVEw5ZjdETHhLc3FNMlhPcmVYN1BPTE1VWE5KVFZx?=
 =?utf-8?B?WTdySFdHQ1g0QjFJbVpGdEdQNmFtQlg4eEhPYzdMZ2tCRkkwWk9ZQm53YTQv?=
 =?utf-8?B?NUtMaTZCejlsajU5Y3Z2QjRqK2lBZTR3TmtBd0tjb0c5bEtNSlFCYjdUa3c1?=
 =?utf-8?B?Y0VQczJnK1RIdjhBamh0VHpnSThmVGxnbzlxWkY5WURzYzEvUDZ0TjFxWGU5?=
 =?utf-8?B?MkpNMW9GNHRHdkVhaERCMlBYZUFOSGVPRWlxWnZ1NzNYZVg4VEh3L0JRN0l6?=
 =?utf-8?B?Z3RudlNYRy9SUW40L00vd1dGMkpjQTZYZXRDMDJRY2liTVNyQ2QvNlNqZmIx?=
 =?utf-8?B?eXFHNXZ1VTl0MGZEUnUxWitSNVlFMEFRLzFHbnM5QmEzTDN3c0ZTQTVnd1lF?=
 =?utf-8?B?UVlYanE5Z3hyVlEwL2tOMFNMcnRZejdGaDV3OHRNMUk5aGhJYkRDODcwZnly?=
 =?utf-8?B?MDJQVG9DczA4OVZzSFpHTkdrYVZZYkFCeWZNUkk2WHNCd3AyYmlBaS93bXZn?=
 =?utf-8?B?UTJCTWtoaEtUSmFBZkIzRmUycFpxRnlvTTVnK1dQNXFyaFFhbFFtOWhQR1Z1?=
 =?utf-8?B?c3ZvQlE1bkxFZGFTdlNzMVNrZjRPNlpHd2NkRnVaVm1INkFscFNGUDB0OXhv?=
 =?utf-8?B?QXlXLzU3SS95U2Z6M2xCc1pFYUpKbk9VNDl5S0Nrdk9zMU0xdWtYRDJQWXBh?=
 =?utf-8?B?TjFoUnQ4eXpoK0EwYVlRZVBoNEVCMkZRVVBkSk96Y0EzWm0vYVNVaFA1b1dH?=
 =?utf-8?B?RDNTK3V2eXJNZjliSThSU21GcHJYNlhVb3Jtc3I0YkNleWVvYVhncEExSjY1?=
 =?utf-8?B?TktlbDJDLzVrQWZpenRIbWlneDQ4T2RlWlB6aWduWHhtVmYwNlRORmZJWjZq?=
 =?utf-8?B?QjJQS3pBVTdtUUtVWitCcXltTzZ2RnZSR0xCaEJLaUVFMUdYek1ITkQ5ZWhH?=
 =?utf-8?B?Um95d0kvdUV2NFlBZWtPS1ZZYVRtQ3FsSDBKZ3pkOEVlNERIZ0tYa0g4M1N2?=
 =?utf-8?B?UDhCV2ExcDludWJma0hwZ3p1dDM1eWdSMFg2UWdESWJVRVBoc2tiNjJ5aDhi?=
 =?utf-8?B?cFAwamJVZzF6eTBkMnBETHFNRUhCcXh6VVYzZy9WR2g2bXd4T3kwL0NHcCs0?=
 =?utf-8?B?NElxdnhrcFArd3pxRFRHUTVCRVZPbzIvMWhodTBuWFU5SlhkSTNjdUE4VUZQ?=
 =?utf-8?B?VU94VHlFeWJYckZKbGVBR0JkeUxyYjZVUDFtYVJZM2FUaThhaGt1Vzg2UzFD?=
 =?utf-8?B?K0dac3J2Yk5jSzRHVWVqVlNUOFlwN3RpVnRJdWtDRjFnbmZBOU1PRE5DZk8x?=
 =?utf-8?B?Tjh2NVpKeE1SY2pIb0RUWFRtQnhreXhlR1dvOEkvekhZbFZHMDdMTmJhOHFP?=
 =?utf-8?B?c2VLZ2t0MC9hYlZzR3RTeklmL2FzNGxrc3gvbzFLS1A5T0ZtTExMQW5MejJJ?=
 =?utf-8?B?VlBCN0xQdTl6Y0pyckdBd2lmbDhIMTBtMlVORzZPM0I4R3pjUzZlcWtHRExv?=
 =?utf-8?B?NHk3TmY0aUZJN09TaHpoYllQZ0VhR01vYkUzcUhkRkZEOUJNREVWZzc5T1FX?=
 =?utf-8?B?T01qdXkvcHVOQ1BBRkpmYWRzdTRadkFXY1h1elE2OXp0blg5U2xkdz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a01e7e9-c694-4698-c14d-08dee92c33ec
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 02:35:19.3584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lSewRCAZE8Fgc0TqxphN80wFBQgqrIadgFQXd5UVoSFyz5xX3w3QnO5ntKn5ahv5HaaSf5gcWDDn1lBmST81sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO5P123MB9015

On Thu, Jul 23, 2026 at 09:43:44PM -0400, Aaron Tomlin wrote:
> @@ -271,7 +273,24 @@ extern struct module __this_module;
>  		__initcall_name(initcall, __iid, id),		\
>  		__initcall_section(__sec, __iid))
>  
> -#define ___define_initcall(fn, id, __sec)			\
> +struct initcall_modname {
> +	initcall_t initcall_fn;
> +	const char *modname;
> +};
> +
> +#define __define_initcall_modname(fn, id)				\
> +	__define_initcall(fn, id)					\
> +	static const char __initstr_##fn[] __used __aligned(1)		\
> +		__section(".init.rodata") = KBUILD_MODNAME;		\
> +	static const struct initcall_modname __modname_##fn __used	\
> +		__section(".initcall.modnames") = {			\
> +			.initcall_fn = __initcall_fn_ptr(fn, id),	\
> +			.modname = __initstr_##fn			\
> +		};
> +
> +#define __builtin_module_initcall(fn)	__define_initcall_modname(fn, 6)
> +
> +#define ___define_initcall(fn, id, __sec)				\
>  	__unique_initcall(fn, id, __sec, __initcall_id(fn))


Please ignore.

This iteration has a double evaluation of __initcall_id(fn) in the built-in
module initcall macro expansion.

By passing the evaluated __iid down to __initcall_fn_ptr(), we ensure
__COUNTER__ is expanded only once per module_init(), avoiding mismatched
stub symbol names (__initstub...) and link-time undefined reference errors
under CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y.

I will share a v8 shortly.

Kind regards,
-- 
Aaron Tomlin
