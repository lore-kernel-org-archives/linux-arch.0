Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022128.outbound.protection.outlook.com [52.101.96.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F982DF138;
	Sun,  6 Sep 2026 13:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788700529; cv=fail; b=O9fvO71essU2te1o32sEv9gp/Njr/attjOx9qOtOZgFsc+EoofCbpNq4tb2ebG4rR12viYCtRz5rvJYLfwTSxu99cAQgVJuE48Uh8kmWGwcYWnjwlti4VLr7P0y5wLG9LfPYW6cCdtlPvrMfMVQyzFengx/KedvjSrq15L6ZL5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788700529; c=relaxed/simple;
	bh=csYH0kKga7G3mHIh88FMdLuLmQ3r9T04Ue6xwKcKDWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EjKs5divDQ8yLGN3M90kqFgZ3iHLLaqOKfhKHhEvWEk2Ztjd8Z/R+3LG1xTGPKwXTIkIFV9sWDCJLrVynpgcss46VqOs32lVX3bNxxmuJxla4PsEEIeq+FS1pu6+p+zLcv/8boSJTz6w5JB7oOi8PCgLxy0sjJJYqapwjtTQbzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.96.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ykkZcAFAqsQKUZ+ckrKWiHL11zAhaAwTnqLfhsoJstZFeV64xLkpZuyOcYVF/ZbFA43N/c4lUfg5rdXYqkXU4ibu7+Iwe1WdHsxPu7eEo6RbwLhUyZHDNJ8OThFF00x8i2pF8qJuPNyYaq/9lOkjbY8aCqbZTeJXsdvfFUvmCHxXeKj6gHsT4D8164IIzBQi2e3EysY9O3/G1/k7kPPqsg6U5LnEFwROQAm61aAuobz4VS2/J9sK6+hzG18zz7ylVID9QJ5RXMHEV4L170BohZvuzZCpAJ/9dzCEH9N45cpJqFBMeYjTOuVRxK/Q8gl3fxraqvOssXEFb5qOn5Y0rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=Tb0B4aSEKBji3BjLZufaHjoAJZjag/rQ+oSrMYhGVxA=;
 b=Wz8dA9TBqYytW/rOSrrOmzg3+T8TZewFL1XgCZ5F7IKU+1nC713PTMIs2A7atRs70SyPF9acgWyu7VlaqFlJpByWVpflSRUkF5POf2+HCHo5g5XkDAGi0ox7LiPIyNEml9zypXItJvXh7QrHXtjx841pUPLaU2cI+1rdGyRzxgfeNC6K4IYiHWoWI3fN9YsiUUNwm32yueVGyr1Rpn21eOVmFpvrehBc3l9vCPoRhpNWpvO+QG1ti+Adu9V7DWT95iZfWQrtCk7DF1eohNftKPwv+NJr2PdsUEx1Nv8EkDjsxbG2G7nyeuBlsvMWktzs1H5IxREly3htlc6FSmHetw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO0P123MB7829.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:429::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Sun, 6 Sep
 2026 13:15:24 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0382.014; Sun, 6 Sep 2026
 13:15:23 +0000
Date: Sun, 6 Sep 2026 09:15:19 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: arnd@arndb.de, mcgrof@kernel.org, petr.pavlu@suse.com, 
	da.gomez@kernel.org, samitolvanen@google.com, peterz@infradead.org, ojeda@kernel.org, 
	mhiramat@kernel.org, boqun@kernel.org, neelx@suse.com, da.anzani@gmail.com, 
	sean@ashe.io, chjohnst@mail.com, steve@abita.co, mproche@mail.com, 
	nick.lane@mail.com, rishil1999@outlook.com, linux-arch@vger.kernel.org, 
	linux-modules@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 0/2] module: Extend module_blacklist parameter to
 built-in modules
Message-ID: <yo5ga35f2uaefjbq4tpk45u5nn4pqcp2gpbthzzxxpim72wj3n@dahra4yg4tej>
References: <20260903185557.183224-1-atomlin@atomlin.com>
 <20260903132924.7a4d1b84791d30c706b394a1@linux-foundation.org>
 <ultg4rym4phqwqrbuz3hqtlse2lgafxebx3un7s3tdht7rz5xy@3ckauomiwqsy>
 <20260905172817.e367c940d750ca3e8484fef9@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260905172817.e367c940d750ca3e8484fef9@linux-foundation.org>
X-ClientProxiedBy: BN9PR03CA0970.namprd03.prod.outlook.com
 (2603:10b6:408:109::15) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO0P123MB7829:EE_
X-MS-Office365-Filtering-Correlation-Id: 15c10e85-6457-4a5f-9a72-08df0c18e8c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|10067099003|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	HTVzBPJJI7kWBp9jAPHLx2Wu/7wVque6oMNXc5sxMEE+qCUQtPSZsjZkzPLJ3UjH5yRqGedD78e0gUVU6ZXKjayvg5hTem2/5jJKh1xdnR/da2blckGnURAKkFqyAGKzVkOewofgetJ8N4WXdVdVJOAQgOu5mjRV8C7dXNUsnZROTF0CekkJMnVhYu+9E4AI+6ezV2Q0VHqyzsMVxDCQEgqzOQF8Uo8C2gA4KduEmJtKwdRLAfxUGVlkPIpBVDf0RuuBtF9Gy84GYE264QW9SGLITN1PN7fLB3iOMSOfj2gTZOh0HhPmpKQxr8c7SeQebt0Uym5C1Kq0ng3pV7BUNhpe2X+9o3xKwfi/odLXrbLgbilsuuVV+VW67cxGrqKVkiHWHBvAfXGr2+c5p+aXWpUIk+Qz4PtoNZhlTlZrhdRoQcHPru/wsch416ax+nd/w7KNLN/dumQZe9xQPYwENuNi37sWXLwscJuiVMNsOFCB/RQdZA6tbDDK/j4uhmMi6xX3KSop/e9amxSpeoeI5XQXzFOSmct7HWNabBplyGmTNADGdgWWZkJTJq90kmRjPeW/yxFd0Ntg0PEMCr36FSBmCEDdC1TDfav1p1y6/CZSCwKifKZRbsg7rbKG6TUGScshKkONga/96S2vhTdmAcLCulQ24LV0bwzvLSOQ1QE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(10067099003)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L0E5ZU0yM1h1ZzJ0c0RUVDZXTVNGZm1XM3YydHMxR0lpc1hPQkl0K0lxV0JU?=
 =?utf-8?B?UWpYUGZNaHZQMFl5NE1tc0NzSTZ1SVV6eE5qTTJYWVR3SGFCdU8xVm1NcXZP?=
 =?utf-8?B?ZlJQditma3hHY0NXdnR0THQxVElrYkRFcW5OcUdoMWt3alRGcThwTXNBUjVs?=
 =?utf-8?B?QzBZMHU1WE1PQjdrYlkydE9lNzczTXlZanlpc1F3U2xHc3ZEODZkK1V0cVBH?=
 =?utf-8?B?ekZNZFlHL0FQYW9oRU9wUElZdHVCc3hBV2RKdFlCMHJuRHorRDZscXkrMysz?=
 =?utf-8?B?RUk5RG8vK0x2N0lCM3Q5K1laYi8wMzZBMGpjRVZYNmJLeXFPUWdlbHpsbXAz?=
 =?utf-8?B?bTZjam1PNlJTTHkvSmtDZDBPSGpUaHRxZ1VpMDE5d2lOSitwd2JWaFh5cjR5?=
 =?utf-8?B?V0hmcTU2dWNSZHIwcXFXQW1YWXFRTVdoTEVvZ2NZakpNb21FbHFlbmVpR1ZB?=
 =?utf-8?B?V0MrRmlYdE9JR3phQXdJQ1BlRHpBVkEzbmxJZVhlOVRqVXBCeTRHTUJLL291?=
 =?utf-8?B?d3JLNWZQNUQvekkvMzdJUlh6RzJWUGRZcWdmMjF6TmNobEJSaXBZdEQzdXBV?=
 =?utf-8?B?Zmx4ZDA4NWFqNGdxcGU4Y3NqL0FvUjJ5NkFUWE9jd0dHeEhwajUzWkxySW9u?=
 =?utf-8?B?Z05ORTN4UXZqdXhRRk5VaTBhWkdiSHlZcXkrZzIrS0NNT0l4K3RzL3RrbG9B?=
 =?utf-8?B?YzRJUEJ5TWljaTVyYjUvbU4vVFFCMEZCT05OUkRsKzJjTnF6WnJKSUx1ZWFY?=
 =?utf-8?B?cHdUZjFMZU9venFkZStiN2Jzc09rWW1yZ2VsbzFUczIyMEhPa3BoVjNPdmY4?=
 =?utf-8?B?RHFSdlE1Q2pzdkdRZmV0TTFLTW8zTFJLblNtalBHZGp4dzNpaFhReXRvSWFX?=
 =?utf-8?B?NWJVWVYwVkwxc01QMHhrYzlxdW9yNCtqTzYvenp0SHFENzlna1ZJWGYvekd1?=
 =?utf-8?B?VHMvMWwwUFl1SUhzNHY0YnUrbm5YUktwN3VYNkNpN2wvMUM5aGV2WHBvb3ZE?=
 =?utf-8?B?M0NOOCtRRFhnRjVTYmNhQUgvYk9aVXY5eEVLRlVsTHcrV1FoK3NCeHNvSzl2?=
 =?utf-8?B?NUl6V0lhUVd5VUJkOTdOeG8wVVFEdDdVTnBPcHZzWlh2d3ZyK25TSkJRendK?=
 =?utf-8?B?dGhCeit1NGVMcFpYbGdJeU1Ma3BvdHdYaTE5blorZ1RoR2xZd3RhZTJaZGQv?=
 =?utf-8?B?N3owWTFPZ2tTK1JaNzJORlRzclZ4U3BOWmhGQjRHY3k1TlVyVVdveXF6c3ZW?=
 =?utf-8?B?emdjN2Y5UnY4ZUZUaE5lc2JhOFR1d0pqdWJTZXJjY2ppdFo3STRBM3JtSnVJ?=
 =?utf-8?B?NjVYN0huMEZZczRuUWtESkNVK1JyVGs2VE82K05ETDlzaDJLWkhIKzlhT2lN?=
 =?utf-8?B?cEMrQ1JuSDVOakMxc0NMZHRkMGd5UzRhRkh2TTAzOFhSNDlpbEtmaGt1Z3Fx?=
 =?utf-8?B?UUJ1Um01VitGMnJpWmZWL2VQQnhPUEZXUzBxQlFUNUFOMStIOFlaaktyRHll?=
 =?utf-8?B?Wlc5VUk5a3IvY25WaU5SdGljZEcwTXFxRnYwUXowWnFPZEpmWk11VTNnSzRv?=
 =?utf-8?B?K080NC90dFpSUE85UCsxN1AyQXoyOFpBU29taDN3TERHTDZydThOQWNCU1lQ?=
 =?utf-8?B?QUxncFJwbW9pQ3hwTDFyNUJJOHRhRkgrcHh2SVlNVU9FdWZITThyN2gyNnFK?=
 =?utf-8?B?WG9hN2Vyc0QxM3I4Z3lTMWJxRkY3NUwrL3VZUFBCYnVHaS9LUEllZ3l4eGpy?=
 =?utf-8?B?MEJYbzVkc1RkbDBmTkdNYmFaZGlVMWF2ZkpxMmErTlJ4aHhDbXBKM1h2aUN0?=
 =?utf-8?B?QWhHbXNoamUrU095bTdiTDYvZi9XaUJpTGM4d1NTQnU1eDJwVjZYMm9Ib2Yx?=
 =?utf-8?B?eXh5RW1qMmhWVnR4VC9XaUVWQ1c4TnFqczlMQ1o4c0N1VjJOa2pQVUpNNm1G?=
 =?utf-8?B?dElwQmV2VXVDdzJzb1lKNVdzRHRTdG9PKzB3RDRsUU81OW5CRGM4dERiR09L?=
 =?utf-8?B?YndwN3FWRlN5NnE5dWVPT09FMFFxWThZZWpLUEZSNUh3RmR5WXdFUkJobkly?=
 =?utf-8?B?TlRtbVovVHBkMkE2TDNNRFovZmd5aENKWExqU2EyVndtbGR4OUtBSjYzbVZB?=
 =?utf-8?B?dmg0Z2tITDZnMk1lbERMQmowcnROSjlpQm4zY3lmTmF3SUhkSzNld1RQUlhQ?=
 =?utf-8?B?Y3Y5cmdweHBsSGQyRkZLRkcrU1ZsYVU3ajh2NzdvS1MyRGZwN29LMStiNUFj?=
 =?utf-8?B?OCtmdGhRclpaOXI3eEQrSGNhdEdBYnZ4NnIvZ25uS1A0MS90QjZkeUNmblBR?=
 =?utf-8?B?Zm1qREpWWGk5OGppVEZRVlMwZVhDZXlFb0Z4MWFSTS9TdjFOK3ltdz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15c10e85-6457-4a5f-9a72-08df0c18e8c3
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2026 13:15:23.5092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OFJc5q6UqIFq3jlmIhOXZzdvVW272+bU3ZySRWMgKb3TMPk5R0vu7Qn9MdC9hMjg5H2FvJm80wAGF2SrVQHdXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB7829

On Sat, Sep 05, 2026 at 05:28:17PM -0700, Andrew Morton wrote:
> On Fri, 4 Sep 2026 10:59:38 -0400 Aaron Tomlin <atomlin@atomlin.com> wrote:
> 
> > On Thu, Sep 03, 2026 at 01:29:24PM -0700, Andrew Morton wrote:
> > > On Thu,  3 Sep 2026 14:55:55 -0400 Aaron Tomlin <atomlin@atomlin.com> wrote:
> > > 
> > > > Currently, the "module_blacklist=" command-line parameter only applies to
> > > > loadable modules. If a module is built-in, the parameter is silently
> > > > ignored. This patch series extends the blacklisting functionality to
> > > > built-in modules by intercepting their initialisation routines during early
> > > > boot.
> > > 
> > > Why?  What are the use-cases and what is the value of this change
> > > to our users?
> > > 
> > > Important, so please don't skimp on the details.
> > 
> > Hi Andrew,
> > 
> > Thanks for asking.
> > 
> > Here is the rationale, concrete use cases, and the value this hopefully
> > brings to users and administrators.
> >
> > ...
> >
> > In summary, this patch brings parity between modular and built-in drivers,
> > removes a pain point in boot-time disaster recovery, and provides users
> > with a predictable, consistent interface.
> 
> Really helpful, thanks.  Please add this to the [0/N] and maintain it.
> 
> I don't really know who are the potential audience for this change, nor
> how to attract their attention.  Greg might have some insights but he
> wasn't cc'ed.
> 
> Let's leave it a week to see if there's feedback then resend with these
> adjustments?
> 

Hi Andrew,

Sounds like a great plan.

I will incorporate the rationale, use cases, and value proposition into the
cover letter and keep it maintained across future revisions.

I will also make sure Greg Kroah-Hartman is CC'd on the next iteration.

Waiting a week gives us good time to collect any further input.
When resending, I will also incorporate a few other refinements raised
during review i.e., a prerequisite fix to treat hyphens and underscores
interchangeably via parameqn() and as well as a Rust specific issue and
linker alignment cleanups [1]).

Petr and Gary, when you have a moment, please let me know your thoughts on [1].

[1]: https://lore.kernel.org/sashiko-reviews/xuj6okhlofl4cboopwjzqe3jyfmaxgvdpf5a3ek7bubew4vcbk@nkfqgoe53533/

Kind regards,
-- 
Aaron Tomlin
