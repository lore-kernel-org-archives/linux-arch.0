Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020122.outbound.protection.outlook.com [52.101.195.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29C9E555;
	Sat, 20 Jun 2026 23:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781997115; cv=fail; b=Idoo/HGjzpvTW9XhxN5xqGLXqrD+Y6quxd831iK59kytwhdETSpfdusYMjO/bym1ZUB58lsRU8V89coRCjI4Q3ULdeItLtv2LSDLvMjF2M/ZQrCeWTe52joDxBYDhtIHiNlJNGRMebOC2c3S9TfSAuA+uIz4hZPCg9xRdpZBntc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781997115; c=relaxed/simple;
	bh=PfFF2lfMujKmiEfFuc6Qzl1FiKkFGSW7dV+SDLlbtwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oQkzr3WpT1E5E0CUG6tCAzO8eUnZFNMmkEOxMzvbSMeWpAs585WWJ8gt0A0v4ltTXuljM9KyaBTyrsQMVLjot5RN0jdcUw4R+HoU0+cbEzHDlq4qIxemuV1gnAN2w6vxx6xXyDsZk9dxkjewaf7/1OiDCEYnKPdujLkMYHT485Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.195.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WY5w9ZUxhN7OCuwuHZOKLRKIGRQ8TTnZQwzl9s4/f7xFzNFAGPLmZTaV6iZuRMrRE63Y8t3whSRfDdAwDb+Z9i/RCb1O43B6/IL25l+Tj4saj21v3kqN1bJiS7giUASXx0eIrXwUgTEqGs/XUo+VhjUcJttUkkqZV1L0SGOLHjBUvMwj5MxwnAKwnlISydMxHo1E6YSZogOr0usano8SO0b7AJNaNO9PMVuZidCJS0TRBwbrDP8kfC7B0bGoz6Mx/kOTUl/2yHXcs4uLHqOR5dmQhFtaoZhCv+IGjihiCDfaSjxvoplq5FrMeZ2S3lmROr+AN554LTXtZSIJl9EHog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=PfFF2lfMujKmiEfFuc6Qzl1FiKkFGSW7dV+SDLlbtwg=;
 b=uevgjaQpelFr0J/jLXhs3X11TBoinxpoeRvvaZLiu1mlr3DA0/E6+Q0+EdEA+kQltlo3hj4mjS2bQTBjgWfJS3sgH7g9rG+9rpBlSRUj8IAgEDfg5/1m3gO1Z0+EjFqcSpLaFzCkyG1Yw0VfyRtHp33FErdbO7Vzd2xDsiWkWNyFXF/1nO9hu50HGpyIAyhtvPILNbH8CsXc+Ar8xthw7vE+LMi2qV5bPSDQuJ+6C2oBE5fjGkPKIP1zHGkC23/Z/M2OaNKPHN89dhtJngAQOpP4suUCotY9b9aOkAPFH9d6czVeCVzN1ANhhf3lKRu6MP1qrCCZaf697YB6MCuF1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CWLP123MB6427.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:1d0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Sat, 20 Jun
 2026 23:11:49 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0139.018; Sat, 20 Jun 2026
 23:11:49 +0000
Date: Sat, 20 Jun 2026 19:11:45 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: arnd@arndb.de, mcgrof@kernel.org, da.gomez@kernel.org, 
	samitolvanen@google.com, neelx@suse.com, sean@ashe.io, chjohnst@mail.com, steve@abita.co, 
	mproche@mail.com, nick.lane@mail.com, linux-arch@vger.kernel.org, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] init/main: Expose built-in initcalls and blacklist
 status via debugfs
Message-ID: <hplhgfhifn2sgrahg3zxkugthqivdynwgsljjiudfxiggjymlk@uan6jrv2fcvo>
References: <20260510061301.41341-1-atomlin@atomlin.com>
 <79ace94f-31d3-4a5e-9a47-3fad69304fe5@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ymovtao3vlbisfdp"
Content-Disposition: inline
In-Reply-To: <79ace94f-31d3-4a5e-9a47-3fad69304fe5@suse.com>
X-ClientProxiedBy: BN0PR03CA0032.namprd03.prod.outlook.com
 (2603:10b6:408:e7::7) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CWLP123MB6427:EE_
X-MS-Office365-Filtering-Correlation-Id: eb2f90fd-0ac5-4922-ff9d-08decf214e38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|22082099003|18002099003|56012099006|4143699003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	oWoGdUh3F4NtsO0ivjQlb6ZR6eHX1UhrG4g0Kr8Z/B52NFpRc+WLssdV/ku/0J87i51KhjNcn3H8h1QAVAKd1WfLyHnrxq5C9UMvQDbBwtUXjGj6ywtOS2WjXaoqItc64+3hEKOIlBV1n9RUAb500cypVP/+dhbOWJH+wwPl+Fsvx/ks1FNUICDnoSepHEoGd425/dEtKeuSKDtgGpHcBaaNRqBZxpGufndUp1EBUGZHJ0lji51JdoOqiHZCQAtp0RvNRxPJT9rR0K0tDBR5CtwP00OGVP/wcf0vTvUVpOqnx2hkKVIqUIecJTgGgPMFKdmQBSlfxCMrbMUt+pXJafZVElZswRNRSO6sdF+KpVQIl9NiK+1RSO/Sxz1Hc8QoVHXY3pUapHjVlRsJ2geg6BWSCRgHLkNB7dRmnhxRBE2bwRYnDvfkd2C7/+3Jt1juvKrWFP2lzv+B7kx07xF0QOtpEiB997jqG8lAe2RXdvctI6zqTREq8dzh1VMsOw5QiE0OIttNTagQso1wpwt3JiGmjElX32lHU5bHYSApTzAhDDcEkejPNFsn9kTJFvtjBWwqWS7dfcN093p7aQx9+ghkoebHAEatSzpep+c/qQ5DtGWDTVIvAKeEx9EOBLVG88gvJ/zC5xhUl6cPxpo3VYatd6Sl4Y1QliJzJ+CTFrY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(22082099003)(18002099003)(56012099006)(4143699003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VmpCQ29mbXlhbmt6NmN6cHlnNFJ3NU5lRkw4c0JnZy95U1p5em5oRDZXeVd5?=
 =?utf-8?B?d21NR01iSUhzYkE3Q0JLS1I4aDBVcFBxTE5HODErTDVpS2sxekIyTnlCUlln?=
 =?utf-8?B?b3JtVlBnT2hSb3FLWlZLa2ptMlk3M2dOcEpwUTRrRE10NU0zOVFNamNtb3Zn?=
 =?utf-8?B?N05mdjBHOTdyNk0zc09JdkRCWW9LNW8xVVh0RVlXOWpFTUpTdGpMcEVmN2Er?=
 =?utf-8?B?WGxTcFQ2TFF0VHNTTnAxMXJ3TFBxVjBhejBvVVZORXpUb0o3U2t3S1o3bkpk?=
 =?utf-8?B?OC9SYTVOeThqQmFMK1EzOXdzWjU3cjVjWVg4SThKcVJsUEZmZ25XY01oQUQ0?=
 =?utf-8?B?bExQYmszYng2aUQrNk1wZEgrRmppYjdaSVNhUTY0SVBHM2dnaXJyREI4OGhL?=
 =?utf-8?B?RHRsUFY4cUZTWFhqN0ZzdkdtY0F2eEl4MVg3djVUVTlxRllCSmpCMTF1cWRk?=
 =?utf-8?B?aFJhS1p0SjUwNGYvd0dTWWxZS1VyVm9CNTYyaS94QkpZM1dYZlhGTTR0blVi?=
 =?utf-8?B?dWd6TmhVV3dSRXpUSzd2bWhTanhsYWxROGpmU3R1SmFEMWx5QjRHa3dkSkpM?=
 =?utf-8?B?dTloT3lFK2QyMDloVlgvOW1uZkQ5Sk0zdFU1NTJJMTN5QUtZbDlGYm1XK1dC?=
 =?utf-8?B?clRTMG9sUGhKcTFKN3ZMZWVtOUtZejJvb3JSQjFZOURGSjVsaW5iWDN3RjlG?=
 =?utf-8?B?NFFldzFuWjRCSUdKU3NDbkErcmpyT3lGNklzTFRJR1lNTkQ5Z21GbGpoOXdr?=
 =?utf-8?B?ZDJWRytMNGhZcmM4MmVyNXBaYThNUnRsUnZvMEVMb0NWVXBNOXpNOEpacnk2?=
 =?utf-8?B?WkZBKzFBYkp4bU56czRkSklOSHpoUmRWU0tjcVZmT2FiZjdCbGhreHNFMWo5?=
 =?utf-8?B?TElUeGwrVFRTdlhQRExINHBnTE1lTU5OckxvVUJpaWFaVWlDVUg5dkZ5anVJ?=
 =?utf-8?B?ckV1czlMLzF1aWxEYTA0Zy9hbWltU0k0VUpaUG9YRHczTEFpSlBqREZDVXRM?=
 =?utf-8?B?RVRqQkZjNUdQcUNwdFpGUGllK2dyQ0l5eG1PV28xVjNNS1QxMm1GbE9XS01C?=
 =?utf-8?B?a2V0d1NTcGp2MVUyNi93ZktoeTNEc0s3Zjd5VU54UElFbzdUeXUvLy9TV1Jl?=
 =?utf-8?B?U0lYZVlBU0NTazJiWWJjT3I3Zm51RHZGUzZ3NzBQNmU4eXdsdmFqZkdUTGRr?=
 =?utf-8?B?d29LQ2puSHhrbzk1ejNvc2N6eitCME84ZDNuOW1kVjdyYWl2NlhtRVJYTzdu?=
 =?utf-8?B?U0NlTEYwWmw4MTBOalVRdTk2cDFOeGw0bVlNT2FzYmhSZyt3a2dzSzZmUlJZ?=
 =?utf-8?B?empQYnB3Zkw0bXZlZ1d1WnFoMmJpSmxhLzZqQVp5RCtHRnBBM0p0ZXMrbkVm?=
 =?utf-8?B?V2RXMWZLaVNIMTNsWld1bkRrNUZ3RWFWRkI3MkZFQXNPWURjSGdIc21jcklr?=
 =?utf-8?B?Yyt6clljems5dEp5VUpodUNmczdDUU1aNXVPMmJ6cWUwREt0T2EvbHFmZFpi?=
 =?utf-8?B?VkwrelpMSW1KTnRXM1FJd2lJRGZDZGw4ejNFY2xCM21jeHR1NnFXb04zdUd1?=
 =?utf-8?B?bHcwRjdTbUdBZElMZ1UwZE9rWHIvM0IwYmhoUXp2VE5kelJVNXMrNjFzK2Jt?=
 =?utf-8?B?eHNzQU41TWFQaldGL3ByeXRXWjFQcUtmSWtIQ0l5Q3c2Tll5TUlsdzB3czlw?=
 =?utf-8?B?c0NOTFFlZ3dyUXlGUDhzRHpST3hxQjJlaEsrRkNkb2FPOXd2c0hqczNoSDI2?=
 =?utf-8?B?S1dQYUg1TDJsZmNIZlNQbytIenl2dVlTdk1iODhLZ1E5WDdQdFkzZmZ5NHEy?=
 =?utf-8?B?blpFWld1V3FpcnpoNVFIbUMyZGRHZTlEYjl6REh1eG9XaGI5S2ZBQUdsMmRh?=
 =?utf-8?B?UDdranR2MEJ1R3c3NjZ6UFJqSXVnL1JuN1MwekIrZGtLNENITVA0T1czMHds?=
 =?utf-8?B?aEdkeVlQYi9WcEhES0Nnc2JGbXZRQml4UHk1Sk41cHc2N0JpWkxMQjJ1a3Z4?=
 =?utf-8?B?UGpSQmtwU0NmVHhmWGpHcGN1YzUyRUdLRy8zNVU3OXVEN1pEVHNxTW9VRG9j?=
 =?utf-8?B?ZEFQOWZCem5aMlk4ZUc2U0NoTXFtd3FIdWNUWmVSZjdRbVJnbk9pVUQvanZ1?=
 =?utf-8?B?NEpYbGIxYzdLLzR4dUdIYnNhS0tBanRJS2h5ZUJ4WXdRbm0zSngxekhyUFhZ?=
 =?utf-8?B?ckllOXh5M1JOd05QTUthZjlLYlduTHNva21QcUFiWTRjN0xmanMyTkExN2M4?=
 =?utf-8?B?SUZ5WU1qSVloL0xDNGRWY3ZSL1ZqU0paM1REWFNWcGtESE1KSGdpWTU5MzAw?=
 =?utf-8?B?UFNyL0REQmpvb2REcnBDcFZEWmE1MkhSNnhSb0NwTk9aa01jZGNvUT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb2f90fd-0ac5-4922-ff9d-08decf214e38
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2026 23:11:48.9858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aMK1rm7TRnDQovxmonMkRCartbijUx8zMeND2yQTwdCMN+M71UnfBCqI4qtpEhREBSrA47WpuuK67Rp17swn3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB6427

--ymovtao3vlbisfdp
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] init/main: Expose built-in initcalls and blacklist
 status via debugfs
MIME-Version: 1.0

On Wed, Jun 17, 2026 at 02:39:53PM +0200, Petr Pavlu wrote:
> On 5/10/26 8:13 AM, Aaron Tomlin wrote:
> > At present, identifying the correct function name to supply to the
> > "initcall_blacklist=3D" kernel command-line parameter requires manual
> > inspection of the source code or kernel symbol tables. Furthermore,
> > administrators lack a reliable runtime mechanism to verify whether a
> > specified built-in module has been successfully blacklisted.
>=20
> My understanding is that initcall_blacklist is primarily a debugging
> facility. This is documented in
> Documentation/admin-guide/kernel-parameters.txt [1] and also outlined in
> the initial commit 7b0b73d76651 ("init/main.c: add initcall_blacklist
> kernel parameter") [2]. It is expected that to use it, one must inspect
> the kernel source code.
>=20
> If the goal is to allow specific built-in modules to be blacklisted,
> I wonder whether extending module_blacklist to also cover built-in
> modules might be a better option. Module names are more appropriate for
> administrators to use, while initcall names should remain internal to
> the kernel. Additionally, initcalls are typically "static" and therefore
> are not guaranteed to have unique names + using module names avoids
> a dependency on CONFIG_KALLSYMS=3Dy.
>=20
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/Documentation/admin-guide/kernel-parameters.txt?h=3Dv7.1#n2408
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3D7b0b73d76651e5f88c88b76efa18d719f832bf6f

Hi Petr,

Thank you for your review and the excellent historical context.

Your points regarding static function name collisions and the
unnecessary kallsyms dependency are correct.

Extending the module blacklist parameter to intercept built in modules
makes far more architectural sense. It provides a consistent interface for
administrators and aligns perfectly with existing kernel conventions.

For the forthcoming v2 patchset, I have completely dropped the original
approach. Instead, I am implementing a parallel metadata section. By
updating the core initcall macros, the compiler will emit the module name
string into a custom ELF section directly alongside the function pointer.
The core boot code can then evaluate this mapping against the module
blacklist before executing the initialisation function.

This new architecture performs all the mapping at compile time. It entirely
avoids the kallsyms dependency you highlighted, perfectly preserves the
original function names for debugging purposes, and resides securely within
the initialisation data so the memory is freed completely immediately after
boot.


Kind regards,
--=20
Aaron Tomlin

--ymovtao3vlbisfdp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEeQaE6/qKljiNHm6b4t6WWBnMd9YFAmo3HjAACgkQ4t6WWBnM
d9YTPQ//Yia6tUsKstLJqv8jNygWZfsROIrcAqs9RMYub+4ChsURVILSGeER8ez9
1GzB+hTds05ZzsqMi4rHErdKgCEL+4dyfOgJ5UCHnIElupdwe+Hsr2H75alkflNL
JR8vuX7GtZeLY4GIh2mIE7uSf3mauKB03fAlO43g5QbfWVvhQObHha09DUv73FLu
N1jm3QoQjOucofJVr6l6szkjSqCTzFAsReJNbjxRyHZWXbMlbF/PP7J8B6eKAuSW
UdTSYXfZtW5mGGU98BvnztGw7mHSXAJj8kV2AjpTqbJwiZKKXGzkMuePF+7uysJW
8t8Gz3++LNNp0N7ZAv+WoN/xTgHSp0bqp0STL3JSvoIEjYoK00FgwC+KOgIrM9XV
kHPLVIR1RZVKerJZHGW9eHVeXjVvBKyNcAsRqJr/VBqcOfk9Yf7cVzg/BIG+rQNh
IT4wvjaYXl6IdTNd9wr1OvIBxPzsSUMphAU9TqFY46bKSnQNsNh7XnyPYVLF/ywK
XCfJCONvnqw2cIwahtqL/ETX88sTTtvkH2zp2rW/KDdrt6oEdXUgvokwzU9Da0AD
gq/sQc/jfWJy+oLjaQrRKNG7MfsvyUCfdhLPy0Cm/qnlhAKLbzgqcY2oRHUiLBnM
PUot4bgcfBuyXRAuXi9Z0fALa2gZz/GgMtO6YwZRTjcs0cXJqWk=
=zNxD
-----END PGP SIGNATURE-----

--ymovtao3vlbisfdp--
