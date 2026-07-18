Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020142.outbound.protection.outlook.com [52.101.195.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B31846F;
	Sat, 18 Jul 2026 01:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784338807; cv=fail; b=oQevTrEZ2sxKJBMlHIeKqG+MqSO7Jl7jkXCkcuUGx29naPuZr0GuApNioGnHpg9HrSL2AjKMPsscm2Xpq8qYhPMsvzpt1Q2xaw6gr4SmeXhjyJ07KI8n2yZOArfQjrBJRK+zYjgryZCZNlLe/CTi3UfEq7S2hZTvsxCD4Osl+rE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784338807; c=relaxed/simple;
	bh=C4QeyW/aVNPL9Mbu6hn1OIdI+HiE7jGd0++6rnaqx50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=os/1jrAaJoTD8wCnK/FnpkqjQsiz7b/fsLfEfonY1L6TdYL813raRKK8wVUm2V3Vvk2gnt8tzI7BPlaHhD2OSmlBJ8SHMg3hvwm8aGCabJq3XLZiVB/LMTVO8zhf4yub48Fa6NIvhqGGWVffWHMyn5SjAsoXCRyfOMZhmHE5xcI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.195.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mt2aDr7gf/8N4sEEvRiBbW9w69/R5oD0HI6pT1TDOfocBixS6VmRET13SI4ZeO20zx5aJQiQpa+ghUO7siv27qmQDppRaNhv+6rooFTArmkiRhkBDekgMr/QpXdhjpHVRWV2kq6AWZP8h5ztNsQIRVHnUuwrmt2oZ2TPUT9xWTgxY1D79moG5lT/ftb4bks63/jQxTOWkAGoQoEli9LoHWltEYrcpnt+u1KnGESF9KY1Pdvxw1OJduhaujEH1EmFpVwxaEcWlDDj3ipkOo91YTg5W7XIcL+yGPnXeLtcrkrj0q7EQw7GTPPy5u7Pd9FeEy7e0bn9ZggK6cjhaOvEcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=sDVKrfFHaG+88w9hFePfQuAWiNnAyVaBeOWrtmpxx2k=;
 b=DYGGNEFa3425bBbOhs+dSPHwi5tNOEB6xm2C6esKxZ475H3NuSBGenw7tCSaohiLq5sgnlh6ZV8HaPChv0eahLNIEI6Y3z/4DhdFtchJZWRxz1hkuLkf5OdrxVWcNPZ9Wp63Y/OYTqSJMXdLMa/Mx9rfkAftB7LcPQt2TPBPR7IUU4Uv3oq0+S0Zg+Nq1ZwBlc06jwi5MvlwMhBASuznE2hlWZJZ/m5i+KMc22SQEp6deSejWqn48F1hwYwazzWQKtVTJWtstwT54Q4rts4bDn7u152xWC5V5LP1FPxXmQEVATzM82lJQVZWQ+9FkmUP7W070hlM/qpf6nz2Rvj1ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO0P123MB8803.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:4a2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.13; Sat, 18 Jul
 2026 01:40:02 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0223.012; Sat, 18 Jul 2026
 01:40:01 +0000
Date: Fri, 17 Jul 2026 21:39:56 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, 
	da.gomez@kernel.org, Sami Tolvanen <samitolvanen@google.com>, 
	Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, neelx@suse.com, da.anzani@gmail.com, sean@ashe.io, 
	chjohnst@mail.com, steve@abita.co, mproche@mail.com, nick.lane@mail.com, 
	Linux-Arch <linux-arch@vger.kernel.org>, linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] module: Extend module_blacklist parameter to built-in
 modules
Message-ID: <ekeijdswyv5pnlntiypj4pmy4fpca7injkty6c5tzu5ikesgkx@2hqsv2q2mxgs>
References: <20260708020007.55728-1-atomlin@atomlin.com>
 <33171ccd-038b-4bb8-b796-f104a131c0ee@app.fastmail.com>
 <in7aczdvb22suqhao6uzsjkh22tgyx2qug4i6efdxyfiuj72ba@k6fr4oc27kim>
 <78ec1da5-11ae-4c35-a08e-cc88a5d083f4@app.fastmail.com>
 <ea7kdjwoucecvetzf73ce5dpda3l3etb6i75bks6deekfu6mb6@ooptba3x2oh3>
 <c54ab73d-8b96-4dcc-8847-63c54da6b799@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c54ab73d-8b96-4dcc-8847-63c54da6b799@suse.com>
X-ClientProxiedBy: BN1PR13CA0003.namprd13.prod.outlook.com
 (2603:10b6:408:e2::8) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO0P123MB8803:EE_
X-MS-Office365-Filtering-Correlation-Id: af2c61ea-c72e-4247-8a8e-08dee46d7b87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|1800799024|376014|23010399003|18002099003|22082099003|4143699003|5023799004|56012099006|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	VGXrxdZcwYewJ+QbvbitH2pOqpZNoNDGOnffSLRygMOMDpK3cXtubReoiT0xlq16UvRhzKTnhpSrNRg85+yKxiElWX6WCGqCzaIcj37euYbwGvUtZs4sAV1hQo0cnsfrCbrvQcB+QHCYeOipLrdqaQrMPPR+tEtEt6k8vbwyW2qkiM/1nBdq3CrePAUdmmG6Mks2sVnzaOuDLFaKQM/rBbJLItZs9+y1A+AajI0TUgGNEDpkc+xfPwYA0XzorQM/Y5u3KWfTmNKYbYFoP8cBjJBpkqKCMhjueypcFeQ+gEgQiAM4offJbVg6twosDMCHItepDeyPSiXFuz3aPJeM6wWEgbCsebOcZ/UFF4m8g9jVU7HDuWupSE/2hdbq3eLhb2KTPkwduJJ6J1qsVvQTSqmvjozYfHf3yGlkFt7eGzqM9Hy0n318Rclhg/9oOCLuua1fa8iWVnwoM7xo9HYBLLRbqu42uoRbZgpjKTqbDb89BqIqAWBplLhbyQkvj8PxjUcMOQcJ7JQ1hb3cH9nO3fBF5ZBpk5lT61Byd+2JhrQ2SiL03dsO2KUp9UuVf+U6ToHcEmIDCCtgExnwVNxfxv0iLtoUA1hmAIx8DJ15mB5EoHqZSBjM6DBr7aLfYTGTwChURYGccnOvsC2Ft/q+yYNRKVgKxgToLaQoPQC6WcM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(4143699003)(5023799004)(56012099006)(10067099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dGwwb1lwUndYZDRQQU5ZRnN2bVA5WkdlVG12UndkbmlmaG1RV2NtcE1WWnJk?=
 =?utf-8?B?dUd0UFpDUEFaWHRHMVVlOHQwejltalBSdHRrM2VJOUJuK3VlL1k1QmJROHFa?=
 =?utf-8?B?SVg4bzU5bnRYRk1pSlNsc1A1cXpxZlpwR1pFZlNOaHQ1KzN6NjJxOXVMcVVq?=
 =?utf-8?B?a2ltSk9LL1BEMnBJWjBOSHF5d1RyNVFtdS9BRUZKRXphRE5IaDZsY1VvMm1p?=
 =?utf-8?B?WWE1bUFNZEl6M3JFUzhvWVNxSVErTDZ6SmFGNlFoWTI5K2FrSVV0bG9sc3Rw?=
 =?utf-8?B?NGQ4NUVCaW9wTG5KYnhNem1yRXlSQnlqbU5KU3Y5YzdJbytrWkFxVHNRb1dv?=
 =?utf-8?B?RFk3ZEtHNG9lY1QrQVBEWTM3TjlMalpDVkRPMmJOMmRXZXJraFVRRnI5ZG82?=
 =?utf-8?B?MUJNWTdReXpGb2tZazZEN2xmMklmWWdXa3dtbnpLd3hwYnZ6a3oySFRvcFE3?=
 =?utf-8?B?TEhuRTdSZ0doL2p3cUh3eVc2RDd5WHErK0J2SU9EdDFPYndiZlo2c3JJUy85?=
 =?utf-8?B?eVVBMGdQSmQrNG5jL3BTZERrSUVJQ2VsU213ODhBSXNPa1VCWVoreWo5d3k5?=
 =?utf-8?B?d0hjMSttQU1hTzl6RHdkdjEvaFpNQUl1ZWVidWllTjlnemFWbmNGR1A5d1ZI?=
 =?utf-8?B?SGRkWm1Pb240V3c3L3dZd0pJOHFOblV1YnpwbTF1MlY4V2lnT1RTem96RUNI?=
 =?utf-8?B?c0dzeE9rY1Q2c0t0N1h5YmNQdUhxcHhScy9uWFdvdkVubHRpZlpCTUc0QnFY?=
 =?utf-8?B?TUNodEZoT05TbWVjSTRtcEdwOUZ1aEpQT0lyRjRQODMzcDZndk5yZzRyYlA5?=
 =?utf-8?B?MWNaa3F4KzMzdW9admUzYW83bkJKemxGc2w0V3FlRlBCL3V3U3M4RlJRVUJ1?=
 =?utf-8?B?OU9Wd2QwYXdlZmVQTzQzaHZXYWMxNDlLVzN3WmNwT285eWZ0bnVUWmNWT0lQ?=
 =?utf-8?B?SmE3aUl1NHBmQ2VqRXNhbFI2YnNHMTdRc0tOdEo5R3hpN1gySXQ3K3NCRVF5?=
 =?utf-8?B?a2thdlFGYTFoOWkzRlpyaHdnRUx5Qk52a0NpU1lIZFgva1VIZjljZmxNTU9K?=
 =?utf-8?B?OUVlWHl2RGRSNXlvTEdOV3J1V1BCZ2ptSGxTS1IvNWN6UEMzSDNOY1QzQS93?=
 =?utf-8?B?L3FoQVhYeWEwZU10bVFFNm9tK09Ic0tuWDBKeDlGbjAveXJVbFpWQ1FVd0hU?=
 =?utf-8?B?K1NVZjdUSmJhWi9ORjVtS0VWZGVGOTh2WUkvMHlzTTJBSVBaZ0cxODZxMWFO?=
 =?utf-8?B?akN4SGR5SS9GaWZQa0JCYUd4emsyMHN1a1F0VU45eHNKTzNXaFhienl5OFlk?=
 =?utf-8?B?cWFRV0R0RUZsQWtLZEp1Ym1CZ3Q5bzV5S3YyRzFhbE9YYXRyLzJTOUk0YWY3?=
 =?utf-8?B?TVFVQWRneFZveE11NTl4Qm1pQ2tNczQxMnhGMnE3SC8wQW00dDc3TW9QeTc0?=
 =?utf-8?B?anQxWTBZT0RhNjlSZ2FRQUVrTXFnS3hleThCMklGUWd1SXNVTHRYSGZDcW5K?=
 =?utf-8?B?SE4xOW5JL0haSW14cXNzdDhlZWZIL3JXUmZKT2cvZzJUcmQ3dngxUmJTYkQw?=
 =?utf-8?B?K3V4REpRUlpUYXlaL1BKTEp5MklSNVhiSnpDbFp1RHRwdjdFWWxsR0lpWVJL?=
 =?utf-8?B?cm05eXlvb2lUQjJYZzdWWSt5NWhkTUxoUEFpdGlPQTlXbkVSb3dISnJObUJQ?=
 =?utf-8?B?a3ZWRVJTWnM2alF5RE9zNmhYK3dBOFkybmkzZGNoMXNpNUY3U3ZwWmNEZUNH?=
 =?utf-8?B?V012WEFFeWl2NUo2L2dzTWUzZGI4WFk5US9LVWlIaFZ4Q1pZUHk0NzJlWDk0?=
 =?utf-8?B?MUd4TkJ1SkNSSlZuUmM1dEhqdGxUT1g4WFRGUmZ1WTlnbFNIa0x0ejBXaURL?=
 =?utf-8?B?NWE0cHRkcmhyNU5SaE8xcWlaYVZ2bnZWMlUwUkFPQWxoNGlWMDFzWFdNZ21q?=
 =?utf-8?B?WGVVTEVmamtxWU04bmpsemMzU3VkQUhyeU5KVDhvbmprTVFKZ0lRT1pMRWM1?=
 =?utf-8?B?WFJKMTRoK1R5ZW9FS1E3c1V2S1lKY2JpN0plSUc3QWEwQXJjQmpsdXVrY1Q5?=
 =?utf-8?B?Z2JDbmxJR0U1SWRLM3dSV3B0YjA4b2d3ZHJoNEQrSjVaNkhyT2R3UEQ1NVJH?=
 =?utf-8?B?VW1LZTAvdzhYU0ZjbXBnenk5b1UyQWtKdXV2c3RGbGhITnhCZEp4RFg4UFpC?=
 =?utf-8?B?bFNQQlM4Um1IRFRCcFMxSStvTDJGbGU0RHcvM2h1RE5MK0dyOVZRdE4xSjRG?=
 =?utf-8?B?eUlhTVBweDRJV0ptc3c2UjF1c1NDRU9oQ0dsaERYZXRVa0dMTzBjZmF6WTQ3?=
 =?utf-8?B?NDBSVzBHV0JkWFpSQk9Dam40MmFJNjk0QmpGWEJOazhNUi9NL1gvZz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af2c61ea-c72e-4247-8a8e-08dee46d7b87
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2026 01:40:01.0865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v4OtmerWmcAfAVR6VmBe+LJkCBVdkfCwatGOQRE5xIZVvERGC9f1yzmJUQCVs0xFLSpNl7m5xnNSgWO6MPC7KA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB8803

On Mon, Jul 13, 2026 at 06:02:04PM +0200, Petr Pavlu wrote:
> > To address your concern regarding undefined behaviour, disabling a built-in
> > driver carries the exact same dependency risks as preventing a loadable
> > module from loading via the traditional blacklist. In both scenarios,
> > dependent drivers will naturally fail to probe or initialise. System
> > administrators who apply denylists are already expected to understand the
> > hardware and software dependencies of the modules they are explicitly
> > disabling.
> 
> The dependency risk is somewhat greater with built-in modules. Consider
> two modules, A and B. Module A exports fun_a() that is used by module B.
> fun_a() depends on state initialized in A's init function.
> 
> If both modules are loadable, then B can be inserted only after A has
> been loaded successfully, that is, A is not blacklisted and its init
> function completes successfully.
> 
> If A is built-in and blacklisted, nothing prevents B from calling
> fun_a() and potentially encountering an undefined state.
> 
> That said, it seems the same problem can already occur today if A is
> built-in and fails to initialize, since do_initcall_level() doesn't
> check the return value from do_one_initcall().
> 
> > 
> > I understand your hesitation regarding added complexity. However, with the
> > fast-path optimisation suggested by Sami (which bypassing the scan entirely
> > if the parameter is unused), the overhead is essentially zero. I believe
> > bridging the logical gap between how we treat =m and =y modules is well
> > worth that minimal footprint.
> 
> I see the point from a consistency perspective.

Hi Petr,

Thank you for your insights; you raise two excellent points.

Regarding the policy gap with /etc/modprobe.d/, you are entirely correct.
However, this discrepancy reinforces the reality that module_blacklist= via
the kernel command line is the only single, deterministic location where an
administrator can declare configuration policy that spans early boot before
the root filesystem is mounted. Making this specific interface robust
against both =m and =y configurations is therefore paramount for enterprise
consistency.

Yes, while a blacklisted built-in module A could theoretically leave
dependent module B calling an uninitialised state via fun_a(), your
observation that this already occurs today when a built-in module's
initcall simply fails runtime initialisation completely refutes the idea
that this patch introduces a novel class of undefined behaviour. The kernel
already tolerates this exact condition because do_initcall_level()
purposefully does not track or act upon the return values of
do_one_initcall().

Given that the architectural risk is identical to existing failure modes,
bringing behavioral consistency to the user-facing administrative interface
seems a clear net benefit.

Kind regards,
-- 
Aaron Tomlin
