Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022101.outbound.protection.outlook.com [52.101.101.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2573E39902D;
	Sun,  6 Sep 2026 14:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788703746; cv=fail; b=SH0aokpY89dE+ijGkeyrv0yyG+hI+VuXq4qJ7C1nfB+xPsMTq+y1FblA9akjFAHv7uYAkUsxIoYZP/2qYTi+YY1/5HXgCwTbDGY2He2yxJLAkvxWRexUAxaeOR2quM/nLa+MGi1NQeWiee/+P+m/NToPdYkWoHQ6Q7XGNRd+yYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788703746; c=relaxed/simple;
	bh=kbqvZpGEL2WuYhVAPaoYGmK/31e1gC9Fg8dFxoT5414=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=T5FHmQNEe1OKQOdlFPAkeH5zyoqemLWqKHXOjlqotj/pxeQ4osVnyudUze5Y/lEJjoKCyH+x5fdz+ugm9Ijk/xVoUoLIbVTRiyDsmuwmi7ebqdvW5GlfjY/0tspyVCbauez5+O/Dg2BakwPtPgtXMi57k/201czVNHKi2MCl610=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JVSXbLtmAkfC5FlNuzp8Mwi0SseAqXlyYL+pn43j+JZbiS5UFkJcDC3mqHJvtiuE0UcF6dVERbY0NPLYvjEZUxWWo1rDbsGTEgue1QdrLDfzDMCM1E7AFJ1Y7wcapIUxdwdZy4kviZgGFqLSS4V7W/qW+EdD7LryqygG5AFJqtr4hlfd6Bp5VunD9CDYPwrj0ypwR+qbmSDYZsyuYXKr8iaan/65VdZDV9bxiIAiZxRbXTRYZDl/vME2Cl67q1+DLV1XZWTyOLjI0DO1kOdZHj+CcGnlpANcEilSUwXezX6nx0k5qbsHUjKhH7tmOqtJRKF87ZZHeW5iq8ifcYoPVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=X9bLiTq2RUZVuo4ycwMHLscTIN1ONw7Uq/up2JtKV8Y=;
 b=lgnBj72k6DJ0nhJ0lX/dr3Px/9ofABJCJeTPS63UsD3XVImC0vOBMuw/yR51YGJoZidTm2pyGmPjKp4L/1uHV0cFz12qPtCVOr6riABuP1xuXRn9phfnyKO/JlVVKXC6FdcW7qXGe4dfSDDZyCR90VLQTRUeMz3bavI1Z6oLUgJImpaLydD4pQS3fOF+voYJv85DbdDkxa5KL8+Djpj6jmAKn7t5WNg20guoUF0o6DbZMNnI5J5ccZtp5tYTDZfkwT5a3VLu8s1UJQ3bL6L2RsYeE/Qt4Extv851BGDlatVF+IaCx1GKwGnmt0xW5idjdpFvbSvfEtJhbs5tk8KuRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO6P123MB7427.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:33d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Sun, 6 Sep
 2026 14:09:01 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0382.014; Sun, 6 Sep 2026
 14:09:01 +0000
Date: Sun, 6 Sep 2026 10:08:57 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, da.gomez@kernel.org, 
	Sami Tolvanen <samitolvanen@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, neelx@suse.com, da.anzani@gmail.com, sean@ashe.io, 
	chjohnst@mail.com, steve@abita.co, mproche@mail.com, nick.lane@mail.com, 
	rishil1999@outlook.com, Linux-Arch <linux-arch@vger.kernel.org>, 
	linux-modules@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 0/2] module: Extend module_blacklist parameter to
 built-in modules
Message-ID: <3gyxhudb5zwrrevc522qjpddnzxbsyxeeqair7tvii6jhfu6kl@f63vlxgftjpl>
References: <20260903185557.183224-1-atomlin@atomlin.com>
 <20260903132924.7a4d1b84791d30c706b394a1@linux-foundation.org>
 <ultg4rym4phqwqrbuz3hqtlse2lgafxebx3un7s3tdht7rz5xy@3ckauomiwqsy>
 <20260905172817.e367c940d750ca3e8484fef9@linux-foundation.org>
 <3cee4548-0ae7-46a7-b437-bf84e5c155ad@app.fastmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3cee4548-0ae7-46a7-b437-bf84e5c155ad@app.fastmail.com>
X-ClientProxiedBy: BN9PR03CA0551.namprd03.prod.outlook.com
 (2603:10b6:408:138::16) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO6P123MB7427:EE_
X-MS-Office365-Filtering-Correlation-Id: c56899a1-d588-4eeb-9242-08df0c206672
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|366016|1800799024|376014|10067099003|6133799003|3023799007|22082099003|18002099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	aV4oBb20Yv65xZ9DF7gNt0OkNT8Fw4oMm+LAIILBMcp8jV4fvtUBzG1jzUjzYcbtfUmJdq1TiN38hHcDojn0n8Oe0ftizyCT/UwYjscDQn9gWmGTCBUkNqiTTD5iAKlhTyJ2hNCD7CiVWQIt5gzwk+tmyDkaZzhhVFULyiwm6gU3LeUz1egHOs4zhN00POqXwKuns5M3v4QkVW36rGo7RQi60GG0t0HiTZjxzMQlXLz3I5CGGb79VF8T8lHX1tp3GVwRyaI6MSRZUtecswbbwUNx8Lq/BzDN+SOYdiLtYIpY0FiKI/Ne2FpZI1IMTmLiKlv3nJEnnYReBolHnGnlDa/t+Oll7hwPqgeimVzy4lioKxZeKMWuh1AYPzrRd1Re8hSBeGrIFRqIvZU7+8ZbYVg+W+YbnsPVWGeRGbrNpHnTq5HM5+p3wxuTENFqoT+nBqWwv6k6AHY0PKrF2EMXeC0SutxYeV6EGB2MRce/bguuC95Bu4R1wpywoT31ykBbQavtpMbSfRVudt2+lm7rsUxRQdk+dmfyQk0VWuM1VCIM9a32mALoelPRhX1DV35MSxucAElnW1Gl2QUZD/Q+N/cVtwl+kjYzW1dxOUCwbtcYl/E0mkTosCpKIKGElXEbKdXMl6EPAcEgJjg18TgPRebDTd5LG4OYzoYr6dbBjVs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(1800799024)(376014)(10067099003)(6133799003)(3023799007)(22082099003)(18002099003)(56012099006)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SzU4eW9HYnZJakJpdzJkUXhWa0VWcmFFRFRQeUVnTnRVRWJ2RzNRcENHbE1G?=
 =?utf-8?B?T21aT2NOQlp1cGo5L1VwbHhlR21HQVpDMVR0S0U2TTFVM2wzSElPSEdKcGhr?=
 =?utf-8?B?Vmh5Wnk0S3RVL1htWlhscFRPWHJkZGJPeU0wZ1lsRFIrMkg4OHZ1ZWd5R0Nx?=
 =?utf-8?B?R2Nudk00NTZRTXFBZ1BabmFBWkdnaHZWR3Z3SUhmcEFaUUFWb2lBcUhON1Bj?=
 =?utf-8?B?cUQ4aE45dnEwbDFrQWpXZ0F6Ym42M0tmWjRUQUxDcy93YUV3VE42d3BFWG0z?=
 =?utf-8?B?NERDUzF3OFI2UW9SMGxOREUvbGlvcHNFVEpoUEJLaHliYWprYk5pbnFZVlRh?=
 =?utf-8?B?RkFISEdUSmw0OGhKSTlrUVRDMmlqdkVudUxCUVlTWGtHc0svQjhtUklmQnlX?=
 =?utf-8?B?VTBSd3ZlMXNQWnBaZkhDZXphRTVZZXg0UUxJUnpZR0dLNkx0NThyelduL21V?=
 =?utf-8?B?bFNJYkUwMHVBR3VBOHhFWWJmRnNhelc5OEo5OWZ5b1dQaGFtcTlETTdJbDZ1?=
 =?utf-8?B?SitXN3hIUmF0MGNJakE3b0l0RStFblNxekcxMHdIWEtSNm0rNnJKajVXMVdz?=
 =?utf-8?B?TnV4WDNSZVAveDlCNG52TEU1VlZ1QUVwMjJrZ09QZXBWRkFDY3VGUFJIN2N5?=
 =?utf-8?B?SnBUSnByc3U0QTNPZmwxUWpaOGZLODlXb255WG04cDdWY05Sd0hlUFEyUUlK?=
 =?utf-8?B?YlJML2xiR2ZHY3NSemxTc1Q0UW9EZ0xDWmpUenZTaWdQMjFLMERzUGFEaHZJ?=
 =?utf-8?B?dWJaV2tsOVp0alVzZU5TYUhJM0hmUm5Cd2srVkMvUE00ZThwR0hJeUdVZTVI?=
 =?utf-8?B?VkJnMjM2aHhDWkdaSWJSOWpLYXQ5dUh2dDZyRjhvbzQ4ZzQrWW9kb09kdTJx?=
 =?utf-8?B?S01UTFUzMmU2OTdRQkJ4RFNRaS9tand5ZkY5bU00M2U1V050VUxjVUo0N2dQ?=
 =?utf-8?B?Sk5GRGs4dWxaVlVnYUs5V3dDVlFkZFc3UWtuR1RRdkpMQzYxb0dLN0ZPZWxZ?=
 =?utf-8?B?cVpzazZqVWhzTFMzTjdQcUZXUmR3cEdROCt2ejRMVk5rYlhuQW1EVmdLVlBH?=
 =?utf-8?B?dzdUeitHNnF4QXFLSnZ6K1crcGFkVkM2dlcxcm12YTQ0TWg4RTRZVWdveS9h?=
 =?utf-8?B?Tm45bHA3SVBIR2VFbFh3Zkt1R1JpVmhVYzBpcWNseHIzaXljVkFab0dFUEdR?=
 =?utf-8?B?ZFpMTmJoRDZNT21xRGo4c1pZWi9JYVdNd3kzdWRVY0RDcDg4RHo3QjF6UDZh?=
 =?utf-8?B?OUNEL1dPL0pCOVoxSWxQTDJZZXFPSnoxb0gzN2E4ai9KOGpnTGpLRVR3MFBM?=
 =?utf-8?B?c2tmNnJoOFIrVHR3Smp0NW11NXdMMUkzSWE1NUZEM3Z4bjN3YTNDY3YzTDlV?=
 =?utf-8?B?b2xqQWpGMm15RXB2TWxHb3N6SEJsckkrZDdVQjFKMFlIamhrdEhocGYzRVRB?=
 =?utf-8?B?eXNlWE96L1ZUM1Z6dlFaS1pZRjczbmkrNGYrTi8rTmVtV2lGWDlUVld0Q2lO?=
 =?utf-8?B?YytkMDYyK09yMUhYZENUb1MxWEJ4ZlFHT1MvR1hFdGlEeGtVUmpqWDFQMnJN?=
 =?utf-8?B?YWVCM3l0SWI5QXZCcTdwZk8yZVd6UTVlN3lFQ2dpZ2ZuUnZDS0NVRTFaTDVz?=
 =?utf-8?B?Zkw4eFBQVnVvZG1nTDkrVlNaR3RnNkJOcndsNFI1ZDQvMXZLS0ZHMlMwSU5m?=
 =?utf-8?B?U3IwSExhOUwyclVDZ2M1OWxxblpncXFsc21wMUUrNExtU1hIb1JxMTl6VVlW?=
 =?utf-8?B?RVJyTUlFamVjSWdiMzRXblVpeHpOUEdQaVdtdGlIMVFsUXljZXBveXVSZnho?=
 =?utf-8?B?MGo3S0NHdnB2bm9NNGtiQnY1V0FRMVNiOFp3UURiTHRiSmdERGprcC9SSWJN?=
 =?utf-8?B?UUt6bDhNYWdyOE15Q1lKK2hyVysrQ0pENVljODNEQmYrd3BITllxdXdLMUpW?=
 =?utf-8?B?MXNiQnRLSzNWOCtXNHNCSWpiWm12YnNob3NORlRzWFpuZEZUOWF3T3FoaDdl?=
 =?utf-8?B?MXJOeVlKbzZmK1ZjVzBOM2s0ck9pbkJTUFVnMkhxcmttbElCTTBXODNsMFhn?=
 =?utf-8?B?aWhqMlltcjNodDZiWkhXbDZ3c1hjREozUGlEQXpEenJwOW4raW9BY0VQSXh3?=
 =?utf-8?B?ZGhBdDdqam1RTk5LUXB5WHNjcWRhUHdiQ2VYOGVrdVhEclhJWVZpRS9TUnJI?=
 =?utf-8?B?Mnp1cktYV3h0MGdqMnI1c1ZrZ05RdW1oQjkvZjdXNTZWb1U3MysvZUtmVXUx?=
 =?utf-8?B?WWpGYnZjYW1qMXdGTG85OEVmang1K3JXQXhuOHBsRXhWNEFhYXlJaXU0bEsy?=
 =?utf-8?B?OE5RMG5mVVU3VVdNeW5HbE1kR2xHaG5jNFE1L04yRTFMbTF5RHFZQT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c56899a1-d588-4eeb-9242-08df0c206672
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2026 14:09:00.9013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oCrM6ijfYhy+B6BeaCeiYomDDcvU7ddLWQ4sdSfSINlUMSTWFQS1b5hBaqI2zDqug1iktg38om2FsrVB5sK/xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P123MB7427

On Sun, Sep 06, 2026 at 11:56:04AM +0200, Arnd Bergmann wrote:
> On Sun, Sep 6, 2026, at 02:28, Andrew Morton wrote:
> > On Fri, 4 Sep 2026 10:59:38 -0400 Aaron Tomlin <atomlin@atomlin.com> wrote:
> >>
> >> In summary, this patch brings parity between modular and built-in drivers,
> >> removes a pain point in boot-time disaster recovery, and provides users
> >> with a predictable, consistent interface.
> >
> > Really helpful, thanks.  Please add this to the [0/N] and maintain it.
> >
> > I don't really know who are the potential audience for this change, nor
> > how to attract their attention.  Greg might have some insights but he
> > wasn't cc'ed.
> >
> > Let's leave it a week to see if there's feedback then resend with these
> > adjustments?
> 
> FWIW, I previously asked the same question on this series
> and still don't find the explanation lacking. Obviously,
> consistency is good, but the added complexity doesn't feel
> worth it here, given that this still has most of the same
> problems as the existing "initcall_blacklist=" option [1].
> 
> I think patch 2/2 would be fine on its own, but for 1/2
> I have yet to see a single example of a real-world problem
> that could have been solved by this but not using
> initcall_blacklist. In distro kernels, almost everything
> is already a loadable module, while users with custom
> kernels could easily turn off the drivers they don't want
> or disable the initcall by name.
> 
>       Arnd
> 
> [1] https://lore.kernel.org/all/78ec1da5-11ae-4c35-a08e-cc88a5d083f4@app.fastmail.com/

Hi Arnd,

I understand your skepticism.

Let me provide more concrete context on the operational realities and why
initcall_blacklist= does not solve this for users.

First, regarding dependencies and undefined behavior, module_blacklist= is
indeed not intended as a day-to-day configuration knob, but as a boot-time
emergency recovery and triage tool. In terms of dependencies, built-in
drivers face the exact same behavior as modular drivers: if a blacklisted
driver provides resources to other drivers, those dependents fail their
probe or defer cleanly via -EPROBE_DEFER. The Linux driver model handles
missing devices without crashing the kernel. Moreover, this mechanism is
strictly restricted to drivers using module_init(), leaving core kernel
subsystems (e.g., sched and memory) completely untouched.

Second, regarding why initcall_blacklist= is impractical for users:

    1.  Obscure and unstable symbols

        initcall_blacklist= requires the exact internal C function name of
        the initcall (e.g., crypto_cmac_module_init). Typically,
        administrators and users know the module name, not internal C
        symbols. Furthermore, these function names are not stable and
        frequently change across kernel changes.

    2.  Mangled Names in Rust

        For drivers written in Rust, initcall symbols are compiler-mangled,
        which makes initcall_blacklist= virtually impossible for a user to
        specify at a boot prompt.

Consider a hardened appliance built with CONFIG_MODULES=n.
Should a kernel update introduce a panic in a built-in driver, the
administrator currently has no means of circumventing that driver using its
documented module name. They are consequently compelled either to
cross-compile a bespoke kernel on an auxiliary machine or to recover the
system via external media. Extending module_blacklist= enables them to
suppress the offending driver directly at the bootloader prompt, thereby
reaching an emergency shell to gather logs and triage the fault.

Andrew Morton suggested incorporating this detailed rationale into the
cover letter and looping in Greg Kroah-Hartman for driver-core perspective,
which I plan to do for the next revision.

I hope this helps.

Kind regards,
-- 
Aaron Tomlin
