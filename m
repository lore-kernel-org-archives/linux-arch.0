Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021081.outbound.protection.outlook.com [52.101.95.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F0C2AD00;
	Thu, 10 Sep 2026 01:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789003967; cv=fail; b=dypCo62zrhmzS4l3tjKxSDN+iTo0MAZLuA6ELp7yrAkLiZ5e4mTcoLJH9Ehkd7fn/MjyHjIN5gCtDQ/kNfHiyewITNn/O2BbHNXZSO6QEGvBkIG2HexnJEJF0fY7G3XMMJqJCjk2oH94miRCQWZFDJ1Lq3y+N3zo4kSn1raeyHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789003967; c=relaxed/simple;
	bh=jQItyttPpMJEVtc3dhlatMiXFnk7WJRbltIYVcRe2R8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ldobSoQcXq4wryjfKYAkaISCOWV/WpJ8eu03Y03VyHxHtIF4KCq3ht9tlhvAxmFK1yEOPVloBkyhWVO9OA8Oz96vAqHfeSwTgT3SRSWWeLPwBFkPcM/ig3ZFegymHQaiM21p00v6YhGIOd0SiqfPy09lauNSxeot7PdSDuHh3V0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a9RJXrYVtjxk3ODiiUh5AytB1B1sBhdSTJoHZ3BVa37pyi9y148PTpwXo1QILAZhA2xNuCO7vudDyrYXl0lsNm4xWPu8E5ZB8Q4EcGrynr3e5hJ1AJ1tq7YxenCf7dOja4OJEagGzJOnBvhOJBe93hLUXFievIhQsX2r6dOiuXwqvnmRiLh9DMFeQPKjA5Sf8CuFg8iHUFEvtn/cJ6e+Mslji/rW17gPQBWElJYVakz/Qqmeh3fyQXJyEuhowwu/AopmDU+TMMF8W/y5kyxX6T8Y9Sr767P2Vda+9XUCQIQjAl0XBJGapRj7NzPjkjbfoj+kxGMh3T6kqeiEVBOe0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=+8qYb6OY8KTeBSeSTdgOCRNDXfmGdHNVCnxAqR303m0=;
 b=pcOLJgYILeK9Rvwl+hLd+9lfhRPZIU7n/2te9m6x206ZO9HooUAyxQuvW8gtcZD9twadNjmmgT6ZvOyUTCWD2Wz8xoVTD0paHGL9+33oPnGiYj87nS7i5axDPSaGNRJB5mAqIByXGID9ost4DjUup3ghW3fsaL1yEsloVB36TZJd2+nuLFL4DHouKxl0SVbwOtoxT4XbEh+gEkH5M0uonpXaOmsPUUUDDApVcP0jy2YoS6piVeLlCo9+teOExxqU4g06/CZO604T05VBtaLud6geJK7F/jKoqjS3g8Gf50CFGtn/pUrwUR/Pgn7wFfQCsMQ191dL+JLMYENt+39MGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO0P123MB7767.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:428::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 01:32:41 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 01:32:41 +0000
Date: Wed, 9 Sep 2026 21:32:37 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>, 
	Andrew Morton <akpm@linux-foundation.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, da.gomez@kernel.org, Sami Tolvanen <samitolvanen@google.com>, 
	Peter Zijlstra <peterz@infradead.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Boqun Feng <boqun@kernel.org>, neelx@suse.com, 
	da.anzani@gmail.com, sean@ashe.io, chjohnst@mail.com, steve@abita.co, 
	mproche@mail.com, nick.lane@mail.com, rishil1999@outlook.com, 
	Linux-Arch <linux-arch@vger.kernel.org>, linux-modules@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 0/2] module: Extend module_blacklist parameter to
 built-in modules
Message-ID: <ffac4ftjetrrnuprjwt6smmfuovehykses5npyg4phzhlvxqcx@nluoqy7nrwfo>
References: <20260903185557.183224-1-atomlin@atomlin.com>
 <20260903132924.7a4d1b84791d30c706b394a1@linux-foundation.org>
 <ultg4rym4phqwqrbuz3hqtlse2lgafxebx3un7s3tdht7rz5xy@3ckauomiwqsy>
 <20260905172817.e367c940d750ca3e8484fef9@linux-foundation.org>
 <3cee4548-0ae7-46a7-b437-bf84e5c155ad@app.fastmail.com>
 <3gyxhudb5zwrrevc522qjpddnzxbsyxeeqair7tvii6jhfu6kl@f63vlxgftjpl>
 <aqFdqQ5xCucwijsl@google.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aqFdqQ5xCucwijsl@google.com>
X-ClientProxiedBy: BN9PR03CA0282.namprd03.prod.outlook.com
 (2603:10b6:408:f5::17) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO0P123MB7767:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b8928e1-7dc5-4ce3-b484-08df0edb67ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|366016|10067099003|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	I+CFJfJe2nZiPB3Mxzoz9LgJvlm4zwIS0vMixjLYgLAT23vDBUMWuTSgCWCZN5Tmu09mlp8O5ERzeQakUoIcqUkjrH1fcIQXrLIKUrE/1HXdcnt6m9KNGwxZ3B5mh+lMhS6dVFwhH710aXQjskgipGkBYGn1AR8AG5t1Nywjijf9UGo8f8D0oArw9AqmRBbIs9zxpeMKElQswKTBByZppjGIDA1TEwfZx9JQ87mQJer2XxySbIJl5NidvNqpNczauracThko0ALvrRAFFR/QzXFoArvK8uCQ8hF0XXALBNQCoORQyCLhF59AhOakjHG/r1oYat1iJ2e5uqtVfUjxKt3ggMWnK+rs03897phIQ1LSM0SzetYxasrIP2K3yPgttlyZpuQaE8LNDj+g021YMc4XDrcWrnDBr50SUdRaucR9ayIG2vpqFzLIF11RTUSw3XGQ/iFwfSXHimF/SNqd/5VkGgpPnA5fT9FVi6IBjNUn/YdLt3ty7qOaqTCh68cfJNoYLBxpM3mn4jHuSpNRvCDvMAuQozH47lB5xtRO6MN+5WL3YYyCzCjQEXC9qUNNJOVOdfSTwW7+ESXj6XDc14ufGzMeS802igLBeGhmLUAVMlFeSPdugn/qKMfWysXZb8j/sKOcagVbynTnIQaPNw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(10067099003)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UlhnVk5KV1VNRTkyT3VkWkFseDR2SWRCTmZKbmtkZzV1Mlp1ems0UURaWVpp?=
 =?utf-8?B?d0pYUXMrdXZUbGJMVlBiVjdERVVybWY1NGxWTlpYQm9QYU5VK0ZXMjdrK0cw?=
 =?utf-8?B?ejlnNC9lMTUxNUwrcWJ6NE1rK01tWThpSERQbjNINjFONDROR0VBSXQ0YTdY?=
 =?utf-8?B?S2ZqNVVHcjNKTGlXU2trVklOV1pRaS9EZ29PSHZDQnpMekc0UU16ZW5JNyt6?=
 =?utf-8?B?OGRKQWRTVm1iVGVTNEpNcHZ3VkJKZFQwZHBTbk03aFpKMFMvMS83dnN5Ynho?=
 =?utf-8?B?ZjlVSU9jRVZ2SUVKd0xOWXZBZ24wbFNrZlZMTjlaNlpIZnpCUmJKR1g2UmhX?=
 =?utf-8?B?U0NIWkdPTmt4YXFhWVRnMFRyQzN3K2U3aVZwcWZsVGkvaytQOUh2MWZ1NGNM?=
 =?utf-8?B?aXlVTWNTMHAzbWQ2am92ZHVsY2NlazNabnhtbHFmK2NxOFM3N01na1ZBYU0x?=
 =?utf-8?B?d01Gajg0UlhSNkYzb2F1c3FFTGVlNGs5VlhLN3d6azhjUWNKcnkwaDNuK0Nx?=
 =?utf-8?B?eEdaRE5IYlhmSWFXZDZkc0JVTGR4RzYxYW44OVhwNXlJVFdxNjJMeWtaMHRq?=
 =?utf-8?B?Y0g4eVFzSFB2REtrbTNoL1AyejdzcHpGdEk3VUpCNXBCWDFBM01NQU9SVTly?=
 =?utf-8?B?VEpGelZ0a1RIcXB3VXJzT2tRSXlaY2FTOFVHM0ZTNCtmVG1NUzFKUUxURjFC?=
 =?utf-8?B?ZXlkUGVnbm40dmtxazhVN3hjNlFjNVplYjlSUU5Malo3SzBLQzJpaldNaDlK?=
 =?utf-8?B?TVVhcDJaM3QyU1FNZDdnY1RHdTBNaXJKQWZ2UVFmMllyRytjcCtnb3BrZWdB?=
 =?utf-8?B?dGF6L1ZzcnhnMkhSZHQ4QUxmL3NjZEhyNENjWk5ma2pXUkRXL2pRWFhXdXZt?=
 =?utf-8?B?VG1xQ2F3T2dWU1czU2pLSVJaMlJjR1dEYkdLRlZvbzZYL0swNHBidFYwUE5n?=
 =?utf-8?B?TXNzYjhRKzBPTC9rdm9nSmxsZzlDQnN2ZFBxbHJURjBWeW1vTFZnRkVhaWtU?=
 =?utf-8?B?QWh3V3IvTk1pUUtzdUs1ZjRBeXhJOHBDNFlBTlBxVGVQam1tK3BLaTQ3TVNI?=
 =?utf-8?B?bDU2NndEODhwQTR0U3ZKT2xSSmhZZTZkcEVEMmZZeCt4Y1hIK0E4ZGM4Qm5j?=
 =?utf-8?B?Y1E0NTRXQ2tzN0dXczh2VDcrRVlka05IdjQ5enVBd2FTeTBMN2hrajFpcksy?=
 =?utf-8?B?SlhKM2c2cExWODQ5L1lhSEhFd21CMjFhazBXbnN2WGFHOTk4QTZES3NDNlRk?=
 =?utf-8?B?enV4ZEhLZDBzVmJWNW0rS1VGN05ycVZxVmhOUE90aWJYelBTMUkvSm44NmF1?=
 =?utf-8?B?dUZnUzExS3psMW1NdTd6KzYxOHphSVNNQnY1aUtYZTVPWUl2R0NmK2w4Vm8x?=
 =?utf-8?B?TnRiWkd5SHJiZlhTVk5xWkxhVXBGS1FPSHBkUTN0WVFEZjVNSm95SG5XUTJy?=
 =?utf-8?B?Z0pCenNDT2duNWtBalcrcC8xcS80TkZncE1xNmFkNCtlczRZczRjT2w5Q0pP?=
 =?utf-8?B?WldjWDlGeVgyWjNkMFVZN1l2ZWtyQ2dnQU9FRTRRaEhSY0p2TDZnRE5KWXVM?=
 =?utf-8?B?V1JnMmhZNmVmcUxmdWh1WU9tTWYwY09ZZG9JN2Z3REtQVitJSFZrYWY2MmtY?=
 =?utf-8?B?QlZLalhsOTR4N3lyWjBOV3h2bVlOQXQ1VnVlZXMyTFNRTHd3aU45M3FYRk9N?=
 =?utf-8?B?NERZVGFYWUV6RUhidnRZeU9UamhWa090d2lyVDNMMHB0SW81TndqNS8vKzU5?=
 =?utf-8?B?ZlBrTSsrMjBHd3dmOWdCS3NKQU52akhxRW90b3l0Wjd5WHNlb1hBUnUxdWxt?=
 =?utf-8?B?SzQ1TkV5a2puVzZ5aE42UGJwTUp5MlJGcWJqK0xZR1RmNUxRSksvNkx3L0pJ?=
 =?utf-8?B?Sm9JSnR5K3ZVd3A3UTZvZXRLRzZKTUhTVk15MmVsbHAzMDRGTmg0eFAwR3Rq?=
 =?utf-8?B?WmtCSC94dlppcjN2U3RCU055bU02N25zNmlrWk5zVVB1cnl0ajdoUW5tRkl5?=
 =?utf-8?B?WkFhZXFLeWRZUUZpY3RtNG96Z1l4Vm81MGVIRWM2QlR0dzAzNytITmtSRVFW?=
 =?utf-8?B?K1pxZlVSVmMvRjVaVkg4NjRscGRMcFZtcmlOOW1KQzV6alg5S2tYUFZ4cVJ5?=
 =?utf-8?B?cmh3SHlCaGR3RFpZbm5WbUhLYkZjU2JtS0ZSM1JSYlJCZlQweHpHL1NVNWV5?=
 =?utf-8?B?MmRhWlovbjNKR3dOcnpZNXg1NnBKYTdNZkZOM1daTlIzeEtvVlRYV0dQQkhj?=
 =?utf-8?B?Z2JyVThSbE0rZm9scWtNODJtaER3OVhCSTJTWlBGaERiN1I1RDVCVjdOaHlN?=
 =?utf-8?B?WE1PWS9JZWdJbDQ0djZTU2xHUGVYV0tIeUNnc0tpWm5WNnQwekl1UT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b8928e1-7dc5-4ce3-b484-08df0edb67ad
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 01:32:41.1629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iAiUjlkxEdwJRQgkacSU6NFtPW65az9cQb/NsJtlduhT7J7SxTRz3k5GIlxX5/7mUOdN2yZLM8QThLWll2paGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB7767

On Wed, Sep 09, 2026 at 01:22:49PM +0000, Alice Ryhl wrote:
> On Sun, Sep 06, 2026 at 10:08:57AM -0400, Aaron Tomlin wrote:
> >     2.  Mangled Names in Rust
> > 
> >         For drivers written in Rust, initcall symbols are compiler-mangled,
> >         which makes initcall_blacklist= virtually impossible for a user to
> >         specify at a boot prompt.
> 
> Are you sure?
> 
> As far as I can tell, the Rust module! macro applies #[no_mangle] to the
> initcall, so no mangling should apply to it. Its name is the name of the
> module followed by an underscore.
> 
> Alice

Hi Alice,

Sorry, I was wrong.

Looking at rust/kernel/module.rs, indeed #[no_mangle] ensures the symbols
are named __{module_name}_init and __{module_name}_exit without compiler
mangling.

Thank you for the follow up!

Kind regards,
-- 
Aaron Tomlin
