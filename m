Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022090.outbound.protection.outlook.com [52.101.96.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0358946A;
	Sat, 13 Jun 2026 21:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781384743; cv=fail; b=t8y6QBZCeLgleLNlpvrJ5x3K7ved/eNBtfTLIGb5jwdr8jFV1RU+i7w/sgQN8wiVz2hgt98nhD85aoDprRbFFVrbiA1wNdLT4b05Glf3QXJSBFoUX13tlkJFcVQupF9H/o2Wae+0K9nDxkM9t+jhivB3suUE3bqyo0o0fqFYFvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781384743; c=relaxed/simple;
	bh=GmxvOy3gilMJji4HF7YJgruNiXlywVeyKpzWfGg2bPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CbIq4Ec4f/5GIRyrfQm93BPHZssrZJTLs76oWpmlq3BC6VMHDLdnon2KlIWXbpSgjlCwkuRj8ehcZJHEyCLrgyPmAwLPWoWHC0t3GRL6P3E5vTHBYV9q9ENmO+33K/bk4V///h+QNmOKPZS64aV4bzoe2kWCCovLXU93z7qW1/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.96.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cfNV+OK4kNd7vDtkTruS5LqPfiJuUUc48k3vdPzaoJwwukuA2WBPdNHAqnFe2AuqPUuOCrkD7Dx2fk3sCZucZQGsVb8rNriaQUgPVlu1VismwcJm642ohO7V/0cPFdBQ1UX2CLZOnRNMKtZrqEUaE33RWc7yQIU+ScBecXS/HFHPOUEyVAOS7bKruzl/6n3bP75D0o3PhiUFNHbnC3lFLDH0gtpgFu5qoKlBuRvkvxDASj1YNe8AfvvRY2XaZ4zvDiox7FXFF7U51VXHelRKu4tKxjZ+wC6aWY6Hw3swq1BgHdHFOsO1eLMclQo6wGA4T7Xy9lwgju+u/Baz2zmNYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=GmxvOy3gilMJji4HF7YJgruNiXlywVeyKpzWfGg2bPg=;
 b=tTEci1h4HtRi32/Wfdrvvxq0AYbfPq3rxIH8L8WW0x2ohbO7smAyNbpM8GC0YdXsjdWsgGCnzwZj+K6PkiKVoXYFP7YhaWEbZVOF1Khf+Nl4sv+/atvhMGnokL2P6Lm6P4q8vpLNVPOdGE2eaLcFLjPgvFmOINHBOUb2JTWQKyoc5OY8lch/n15VH+4CLnd8bzU1Ig8r5pT7TYKjFj/cb4XIBDEfM6/RAHEkmBV0ggSu2e2/54fPCIRanKEjZXU/gwW8EU7nXa4M0IxOKPU8ZAHL3yHeptUGW7Zcb9oRT/MUDZA0ITqJkQmdtXrjPERz39Owk5ZDtPDBkRpVb8zQOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CWXP123MB5860.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:193::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.16; Sat, 13 Jun
 2026 21:05:37 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0113.015; Sat, 13 Jun 2026
 21:05:37 +0000
Date: Sat, 13 Jun 2026 17:05:36 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: arnd@arndb.de, mcgrof@kernel.org, petr.pavlu@suse.com, 
	da.gomez@kernel.org, samitolvanen@google.com
Cc: neelx@suse.com, kees@kernel.org, peterz@infradead.org, 
	akpm@linux-foundation.org, sean@ashe.io, chjohnst@mail.com, steve@abita.co, 
	mproche@mail.com, nick.lane@mail.com, linux-arch@vger.kernel.org, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] init/main: Expose built-in initcalls and blacklist
 status via debugfs
Message-ID: <a6dwfvpf2wydlapc4bokawooq6ib4t7p7uonpr6yqwennbm2fp@2hxs3fxcx2wp>
References: <20260510061301.41341-1-atomlin@atomlin.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4fxukb2vahzizgfc"
Content-Disposition: inline
In-Reply-To: <20260510061301.41341-1-atomlin@atomlin.com>
X-ClientProxiedBy: LO4P265CA0122.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::15) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CWXP123MB5860:EE_
X-MS-Office365-Filtering-Correlation-Id: 5aa91687-d2fb-414e-c5ea-08dec98f8479
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|23010399003|1800799024|56012099006|6133799003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	iVxjdtsyR2NCIZ0UFNZbaVOPYNSTYPkMptVciYS4UQUVHnO+sgFrnx39MScxYSfEHQNgZDUbtNJpsFd9I2bT2mPUrMP02Zoh6fL+jG+hExxtXXLXVHiidE4ts4/Sgy/MoThHX/H7Fh/B+Osgze9Gsom9fUGpYQfaRYnnlFo4QES9C7wJREw8vIxb8yuHuecQMaP3472kjZx/AD9XBUnXfa0Ftin401trd2Qabqo7z/x1kb3uzN6fSNkM7wy3JqQMbZmBrteuEzwoBs5srAk9nMG2tSDZMthFc1ZqAbwG69V0AFyd6KXciuoLYwjxXK3i8Gs/UI4vv0kcpqAmwQBzlLQX3aENvX4Xhp5HUGxCpSGq44ea0RcPrPh07nJmSTsjKKtVrzKzILJei/Aj4HNCkbT9CDJuP77UW6WR2oUukHRcQKHyjFk4UXHDqcdqZWCiauS3rbUxpY5PSYz8i/Y9BPFZuB8xnsSfHYu/49wEWw/sQKiZe6lRkamk6qa1Xjudwb+rDQJapHRSvyv37Z73PUilYnqGFSxDZcRlhWUJW0JibDjRpUcEt7L2+dGqxYkC7bE6+dIIgnpd4QUDqXVf7WgYR2FDd55Zx52iN7kNNnSQRli5D43FskB/C7PgAuv0y5AKwp3SSFE0HHM9mK8/R8fMs2WKtfJZheb5vQSlNt9s+lLRBmPaTzElO5oTFDNb
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(56012099006)(6133799003)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TjlabG8zYmtwelp3bUZxSXhGQjJLcUJhRUhaay9QanhnK2hucXZ0dExDTGZL?=
 =?utf-8?B?eVJRNjdWZWFCSjVzSTVpUlphSzdUd3lobEFSdVVJMnpyb1NsaWVEV3p5Q1E4?=
 =?utf-8?B?WmZvM0dzbGoxQk5Ed1hIV2VoUkxHZ0Y0cFdwUVo4dnBGWHg2SlRlNGFIeXdX?=
 =?utf-8?B?YThwYTkwTXJtazNTVndYbmdhckE2SDZ5OWxOU1ZwSWVPL2RzRkxlMkhkOS85?=
 =?utf-8?B?dVRNd3RLQzV4VDNyY1VvbTJsQWVRRS8rK3BHcmtGdXR3d0hHWVVpSUM2U0Yx?=
 =?utf-8?B?QlpCUlFlbEV6RW1VdE9EUGg3d2tEaGU5RER2c3I5MXhMNHNEV3RRNDBleHVj?=
 =?utf-8?B?dWQvRFQzdzBLMlRHeWVqS1lJLzZjb1dyYnhyL2FmTUNTdkp5Z1Zad01IeGZB?=
 =?utf-8?B?aGMzd0xyY1ZldWRYU1MrSUVreUFnakdMVGhNMXJmcURBQUZLYlF0SnZZYzlC?=
 =?utf-8?B?VzVQMW9aM3U5d0pZbTRIcXpMVFhaZm9TWmZ1TWYyMXNYOHc2dHBLUk83UTBB?=
 =?utf-8?B?WVV4SHJ3RnEzMGhIdENrcEdyYjlqdE85SG5VRk5tNzJEcjdPMWFUTHh5RGZa?=
 =?utf-8?B?TXFBVHdkY3p0Wnd5NkVaR3BJZVA2TWlyOWpRN2c3ODBvUml1TjdXekYrL0p1?=
 =?utf-8?B?UmNSV1g4QWwrdE5xbnd2NktLWTFUcmZUN3lQbGUyNGZnaEQrN0U5SFJ4cmJr?=
 =?utf-8?B?cVVCbkxXZGttSVVySnZFbHNMUDBBWjZUMGVuVzh0aTRJandmSXM0NjJZL1Vs?=
 =?utf-8?B?eHNiWFY3RlFKTHFYTlhQbjNYZEZqVlhGeTVPVlFqeCtKTlFLdlJuaHptTmhq?=
 =?utf-8?B?dksxYU5HK08wd2FsTEhWTVQwakhjWFhTQWVxajFLZWFVZkNtMFRtQXFlY2xx?=
 =?utf-8?B?THVXU1V1ZUJ0WmJIa3NyOWdCekl2Wm9XMXo0cWxEbG13WWw3SjJnbVlKT3dj?=
 =?utf-8?B?M2x2YkZ6TlhMM3JnYXNUZ2NoMGJNeVR6VENFaGQwOWJoWDVBbmIvY1E3M2xU?=
 =?utf-8?B?TjlQSU9PTkJlczV5WEdiT3dpU2U3NEovQ0txWXhYdy90L20zSnlKRkR2NXM1?=
 =?utf-8?B?WHdmZWVsd2svM21qTmNqT3UzbkdSb2J6QjBkdnhKZ0JBbHg0WVhiTmY5T1Vl?=
 =?utf-8?B?TnplREVaSlpCclZzODJEalg0VTdMSXNsQUc0UUkva0NqSS9nTmZqOFJRWDZT?=
 =?utf-8?B?bWp1aXg3S2NFcUJTUTNMYmlUK0JNaFVBamJwbGRpdWRYYnFkclZ5cVUxSGQ5?=
 =?utf-8?B?TEdtY2VOejRkcTFHNWlZWk5POStVdmJXVXNiK3h1Y25OQzRyeGJmMVRqQ1pK?=
 =?utf-8?B?NjJsanZXL1FnRXpsVzArM0lwN2FuRnlOeUNYSmNKV05Dc25USFowTVZxT3BH?=
 =?utf-8?B?cjNLZ3JpSVVwUkJ0d0ZxOWU2aTNxV3pWck1wdG0raGhENUFSdzV2VXlCSHBm?=
 =?utf-8?B?M1pxSG9lRVhFL2pGU1d2dy9MSTJVTEhicUZkN2ZMZTdzSHYyems2d01RM2t0?=
 =?utf-8?B?R3hiaEpVOTlUY2VUNHZEUmYvaXpldVR5cGdabGFoWmhJSlN5dkkwc0FEZVdw?=
 =?utf-8?B?bDNGRWJUTVEwM2xoT2JxNjF6dWsybjJsOHJJRkJMZnV0dnRFbW9YbXMwbUpB?=
 =?utf-8?B?T2tUSnluRDZDQnZIZnhDQjRHOVZXSHJYQWcwTUV4bndVVGRPOWM2WTFlQVJ6?=
 =?utf-8?B?WDluL28zMy95TFBIUVQxRHZKcEpiTWtwZlR2UVk4Nk1BZzlQMXEvZ1FUZ3lU?=
 =?utf-8?B?VUl0SGcyR1U1NklaT0MwbUh5TXpkMlRBdWNoRExpRnhOZ3ZwU1R2YW1qUk9M?=
 =?utf-8?B?MlA5UTRwTklEUVhBbGJMMlR5Ny94Y0QrY3pucGhhUm84ODJXNHJWWGxTWGR2?=
 =?utf-8?B?VjFpbk91cFJaa0tZYlRhZHEycy9JT2RRcnVhajRmOExNRWZOSUNXNGhUMENt?=
 =?utf-8?B?bDBYY0dkNHVmUDJZeW9LQkZ4b1J4MzdaN0lKZzJXeS9WUnZEWWMrRXJtSEl1?=
 =?utf-8?B?ZjcwQ3pLR3I3WUFSTnZCVXkvNGZzVHZ0c1d1WTIwTFNYMDBJMGNKelBrTXg2?=
 =?utf-8?B?em5UOWJMUmhST0RHdXpzc1BGNzV2ZFFGaEE2NjlxOExHL291L1kxanc3V3RX?=
 =?utf-8?B?aEdQRkY1UUM3bEQ5aGxXZFJpblBManNuNktxaWcxOEpWNTN1aVBtcGNlZG9a?=
 =?utf-8?B?L2JLMUg2S1orV2ZLaVRIRWQveEROV1c5YThDOUp1b2k1Rkxacmo1b0MxcEF5?=
 =?utf-8?B?NUdmSGtKeTVxVk1xYXJXMldSQ09LTnJWN2ZybGNOUHpTNVJIZUJNMEFQd0xJ?=
 =?utf-8?Q?JwrqTZmnsrvED6LbLG?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aa91687-d2fb-414e-c5ea-08dec98f8479
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2026 21:05:37.5369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I22xTIKmB7Xp8e1YVnwaFfA95Dtqp/9tIQjZQjedJc5gUPelpFKj2Cvz3pUXrw0dCz0JfM/nfgB1jVzUIsMUjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB5860

--4fxukb2vahzizgfc
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] init/main: Expose built-in initcalls and blacklist
 status via debugfs
MIME-Version: 1.0

On Sun, May 10, 2026 at 02:13:01AM -0400, Aaron Tomlin wrote:
> At present, identifying the correct function name to supply to the
> "initcall_blacklist=3D" kernel command-line parameter requires manual
> inspection of the source code or kernel symbol tables. Furthermore,
> administrators lack a reliable runtime mechanism to verify whether a
> specified built-in module has been successfully blacklisted.
>=20
> To resolve this, introduce a new debugfs interface at
> /sys/kernel/debug/modules/builtin_initcalls. This file enumerates all
> built-in modules alongside their corresponding initialisation callbacks
> (e.g., those specified by module_init()) in a simple format:
> "module_name init_callback". If a built-in module has been actively
> blacklisted, the entry is explicitly appended with a " [blacklisted]"
> suffix.

Dear maintainers,

I am writing to politely follow up on this patch, as it has been just over
a month since its initial submission.

To briefly reiterate, this patch introduces a reliable runtime mechanism to
identify built-in initcalls and verify their blacklisted status, thereby
significantly improving the usability of the "initcall_blacklist=3D"
parameter.

I would be most grateful for any feedback, or to know whether any further
refinements are required for it to be considered for inclusion.

Kind regards,
--=20
Aaron Tomlin

--4fxukb2vahzizgfc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEeQaE6/qKljiNHm6b4t6WWBnMd9YFAmotxhUACgkQ4t6WWBnM
d9Yk8A/+PCINpDZKb+K0QUNMfnX7/Yha4jTaGf2i73QLDZ7Cj2csIhoKrwZUu/7t
03wd3v80K4rCluBr6MJsUC0VovKjxDY9uJ6/Nwsj/Zsa5biNqUOh7Ve62f+kBD+7
ufCyTr8XdZ7KBWTg/8zhk+d6ryUz2zTLBu4OHUarl/Dfj7aji62aIb2ngF2+OKNz
N6+2ZrV9/d87wr3szZx7ENrrLd9P+YwOIbXqQ9FriNui5XuVl2X9l37stSoyNvml
wRv9z122FsOOAs76FTY2JTN3dmmxF5fkXPZcwlj+VQ6Eg10JkdzBUYEPEsMm/FsF
vkJwjjPzUCP4jDC8vYxVQ1RlmtBp7ZI9wPQB7vcy3UliHV453T1RFwdOhk/h/HW2
LrfP12dW38HFYb8e44u8yVsEvCfgefHGgd/UmTA8foHQEOakdasUXId3ZvMn1Mj9
3/B9luRYskjk3lyBso5gWmqM6zcaeNvdvx0SPo5XzkMOdBM3sRpKsWVB+Bl2MaRb
JaE+W3oBJjBCOkdbfwtq1tnRXpVkAspPAeP2Z2sGkcTM7L9za036Jo7D5lhuMO/y
L/g1ZYzK2FNpO5n442fj9hbMfvJDCIHjOgcqU89+dN5k3pp8G8KxB7OEde8pR8iF
hS1EBJbfw3sB0AljLf8qHcJsMOuTrYQgH/GGX2bFDWDm6O9LjQM=
=zn5Z
-----END PGP SIGNATURE-----

--4fxukb2vahzizgfc--
