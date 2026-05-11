Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022125.outbound.protection.outlook.com [52.101.101.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9170A3A3E99;
	Mon, 11 May 2026 20:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778531654; cv=fail; b=sG7M2faD9ckeWnp8aJz2BgL1kJpxorZ9h4WOcCnbisaF6KknJMLz/z+dluJy/gaM6U4JiXSTnmMTX8V3SmyP9lpi45ViiIp6Aa+Ipyv66YplWyW0sBHi7dlBLAo2PmFKnLb/zQKeXXRrNSaJq5oUQ0W5yz1F4IJUIzU7eFNje1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778531654; c=relaxed/simple;
	bh=bUcd6uBkeqPB00XkHzPs9/C7ipOIS41DM36UqEYyqnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cTRD/1UJmW8+yjj00fHslR24PW37bPpQCBQ6z5kyLrCBpsxRho5IkeqakzSYAtL1MFwG1YmfQxynfkcOAkNuBbvK0XuEagdyum9uLdvsLlxYCevN9MVksixW/e1JQncUSK+Nlb2d94uMfYVWm5//Rq1/1XfNOnqXrREbBMEKhLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eJulWN6ETiYQ4013up8oKXImJo+614wnCV1s2VVoNrU8U344DU+ZywRgyu9OP0o3LBhYl8moiXOnj0aHAIGBOVqSNdfQyK8/TjK8ynLQxOxwEbT77XYIhsT/z/Lk6jZ7cabT4jaL8+S9V+q7jcGdQWD5HroLzMwnDMBZie3eKQwhZy8QaMDq5E6RlPUzoRi+d8CrosBNY9WAxNup6MM4CShZGppcwP11p9tRhsFUxSYVNI6PUa7bXAOIJqYRv3cVKY9/pxbzUwdHfweeEOZCCHgpOQPHMS6Pfifqsf1IVycTKCU6bGxmRiXcgtgfGsO8i525IjhdMhiQ5GqSQE1wQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=akOJjVszhkCDcj/JYnUqvHu7AQ6Ex0Ves+3e6U2A8G4=;
 b=LY1KeugTyHZ7detG4Qx16p6wRlbvofKT+lXWr69QqWbhPXAuO+GiZankq4e2vjFfgbyirfBaNdub+Y3xFIp4QEvW5mw3DmqRl06u7ac1Zl8IEfhDjiFT+vmhfWXcPrUIdLrcBkUdhu5QeFMRyPApDWDBkWbgmqrOQ94inJehIg2UjAKklZ6I77VVqb+j6BOlnP/mhkui76NkbNBMPl8tUUISrvT5p3/drIP/I36oK3y0S5/K4sE7I84xKLM2mxmiOAHa44DyUBq5NDcQLnHTZGfHiGvrwz2nIuS8MiGOIonyREi7Lp9o8/qhtNJSc0FcYRVvKfDDpRYezPx73kde7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LO9P123MB7883.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:3e3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 20:34:07 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9846.025; Mon, 11 May 2026
 20:34:07 +0000
Date: Mon, 11 May 2026 16:34:04 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: arnd@arndb.de, mcgrof@kernel.org, petr.pavlu@suse.com, 
	da.gomez@kernel.org, samitolvanen@google.com, sashal@kernel.org, leitao@debian.org, 
	akpm@linux-foundation.org
Cc: neelx@suse.com, sean@ashe.io, chjohnst@mail.com, steve@abita.co, 
	mproche@mail.com, nick.lane@mail.com, linux-arch@vger.kernel.org, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] init/main: Expose built-in initcalls and blacklist
 status via debugfs
Message-ID: <gkvmkpkhesd225sqdwoepjazhmqli7cqc5ut7czo3b453fd7aq@qer3g3oqhoou>
References: <20260510061301.41341-1-atomlin@atomlin.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ya4r6ktjheu4erdu"
Content-Disposition: inline
In-Reply-To: <20260510061301.41341-1-atomlin@atomlin.com>
X-ClientProxiedBy: BL1PR13CA0026.namprd13.prod.outlook.com
 (2603:10b6:208:256::31) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LO9P123MB7883:EE_
X-MS-Office365-Filtering-Correlation-Id: 79eb42a6-e5f7-4ad0-4dd1-08deaf9ca677
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|3023799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	aNXfHMeLwKtV8Tfor868wbs/c6V4pjGgXrWak6yfRRZ+9W8zPFoMnAK/rxLzx/hgFA+A0YsKv6vGVgkMd6cD2ZwMqtaMMx8sPdNi53PpXE+zknQRo8AFlEHv0xfhVUJ4n+UGumqOcQFwl3qQhzvP+G3G3b8rRW8kBYU91ddq6OlaaeF8Rq5jbV8GfFxi9gSN0Jaf++eR+gdz6c3lDETF22q5oAarEtoyk1n8YjcMel1Sec+TC4lbgjuFIhDP1sm/bpy0N4BtKQDMzYxFpvBjka3x3JOGJry+3HBIWtCxRXP049ndm4DoYMB68qWj6TAbC3OUGpim/yJEQtTGsk7z5spv1LUfOn77my3FQziwjY1Kp/sWGdnXmvGLeegSGn0Yu198AisjqVh+D4N9kLxvJEdlr6JGuoOwUdAKu77FNvfpR8UhGOPuJ5JU4Psr8vp7HYXcf+ScNNUXsEgC08tst7g60GnX/VyXXMEgnf3wipM5okQClT/dvgexrgbOwpMRMaCSJsZ+P37U1QAvnyxRAMBAt5JVFP7kG7LYb1X6xxedLTup3LTZXYDhhzw/zoWqhhl7JrzZZLTHrNCNrimmCsIOMwSHfq2G9/O4jT5Pt1mo8uKuCu2eME3blHH3TaT7JSa7/f0nllZDtFWGjcgWi2hqe3vgTjpT2WZQPmFKyGkxbcySnJnQ3mIa56QXi/QY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(3023799003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MFB2eEx6di9HY0greXIrZGtSc1dQTnZEMm5SRjFZZkJXeGRKVnBPa0d5aHBO?=
 =?utf-8?B?Q2YxREU1eSsvRCtmeXVtaFdBT2xBSFgwc05nRnV5cWNCak04Ynl5S1hsb2NF?=
 =?utf-8?B?Q2hKRTlYZHBWM0tqK09GT0daeGVXVnE5L2ZDUkRWbkdxclV0eGsxT2RXNlBM?=
 =?utf-8?B?cGkvS05sVjN3R0dqdU0xelFodVVkRWN1eWxSbHJFZ3E1MFJPNitvZnFSaWJC?=
 =?utf-8?B?YmFJODkxSk9vRmZ5bUo1WUlYMVR5eFFkbXM3NGFjTkd2Y3ZFQjA1Q2JJbVN5?=
 =?utf-8?B?YWVlYlh4bTFyNU5tVFA0dXV4TnpjN0QvMGVrZlp5THhWdFMxc05meDJvcXQx?=
 =?utf-8?B?KzN2alp2L1ppYUV2RGt3RHVuTENFWHhnbDNFZUo3Q1MxQXVEKzllQnlSbFVp?=
 =?utf-8?B?U2VtY1JnZUtpc2xzTS9tY0lBWmVHdXpNai96RFZGT1VyT3M4Vjk3Y2hhbFRS?=
 =?utf-8?B?QWVZZnF6Rk0ybm1oUmJ3ZW1kMlZRMFcwV0xDWEFCeEptYTZRUTAySFNEcG5P?=
 =?utf-8?B?bmZrUkpZSTZ6MXF2bzZZYlozSWZmWHJpSUlabVA3cjQ2djhuTzZKRnNWdlRw?=
 =?utf-8?B?MkhWK2h3cFFqM2l4R1RMbFVQVjhiRlV3RjJMallqMEpsaEZUSWpMa3FRQXl1?=
 =?utf-8?B?U0ZsaDFza1ZBN0htWGRxVU1GKzNEOGU2ZXY3eHNrdGt4ZDdFQVBoSXpXKzgx?=
 =?utf-8?B?bWJpYXhPVnp4dkFLY2pxRk50NWJkdk1UczE0TlFiY3BvNS9uU01lUXMrRE5Y?=
 =?utf-8?B?WW4yWEZ2U01nSXNqOUZCNW5DMkxvRjhFSTZjTkZjOWZKUTZpaUJ2Nlo1Q2ls?=
 =?utf-8?B?THF4TFpPZUlkTWRoMlBGWS8ybjlyUzlHbzVQQ1JuNGxEOW5yb0x1a0didjJE?=
 =?utf-8?B?ck9zMXJHclcrU0RtWWNtVURjSlFGVmkySGFYb3M3OFdwR3N1ZXdxZXFsRDBQ?=
 =?utf-8?B?YldrMFVNZ2dXWEJvaEduZ292eEZHaDMrU2pqMlpXcDRoSi81RzZoQXduT1A5?=
 =?utf-8?B?QUZZVzB3ZHhpYnV0VUlqZVlQelVrNjF1UWZBWmVFVjZ2VlVIQlpaUGcydGU3?=
 =?utf-8?B?TCs2aENIUjFiZEdrNTU2ZFF0UUczK3JjWGhBdWFHTlZSU2FLWVk1NEZ4K3Rk?=
 =?utf-8?B?S2ZNdm5iajg5a21rUFBzSXozK25PaDFZc2ZLL2NWSkczK25tK3pVSHRFeWZq?=
 =?utf-8?B?TFA0bWxja0E3MnRDSWI3OWZNMTFXc1IwKzhDY0xjYnVvbmxDTldLdEdiaU85?=
 =?utf-8?B?NDMxVVN4cE5telVDWjY1bnc0ZnNoSldCVndkVjlQakl1eHkwZFQxTitHb2hh?=
 =?utf-8?B?RUFqNHcvUS9CREh6cE16VVN5cEdXN1c1SUN1dExYWE1pQjNsRXVvU2RoRE0w?=
 =?utf-8?B?L1NUQ3MwREJxQ0VFL0dZUVRxdkdpbitWMlk5aTFsN1RiWVZ1VVNaNmQ1VzhG?=
 =?utf-8?B?bmxjSFJ6T2ptN3AzVkhGTmEzV29nZWVpTTQvRkErR3BnVkVxMnI5N2FxWjRI?=
 =?utf-8?B?bitrVmtmYXRSMkdwdlNzWkN6SzQvTWx3Qk1MUXIwLzJidUpEUDR3bGdZT3hT?=
 =?utf-8?B?d0Y1a3pCbkdYcDlsZWlrNHZKS21ldmdBMkN6b1N3ZDJKVll6WUNIblJQTTlY?=
 =?utf-8?B?d2daT1Nybnl3ZCs1TVg1WTV2dDkxMDBmTGxKVE1yU1dzRU5wbzNVVHppck5U?=
 =?utf-8?B?S0Z2RUlNUzkycUlnWWRxeEQ2NUJCL1BlTGlqZk1UR2ZYYkQyaEJ3eTVxd2s3?=
 =?utf-8?B?d21oUC9URHNaOFpVcVBkbmhmMmpXVEl0MFBneWRXVWdCMFFmSlJ1NVlIbUlW?=
 =?utf-8?B?UTZxa0Z4cFB2dlczQURKMTRMNFd6MkxiRzBucFk2ZmpBNGowQ1BGNERWVUxS?=
 =?utf-8?B?WkdmVkZQZHphMCt1eXV3VmducWgrU2JqVEM1R09BUWJ0cUwrTlNrZmxCaGd2?=
 =?utf-8?B?Z0wxNGVWUCtkNEVnVmxwemV6TGNMTkt2VmJPL0VpdVdrbVhKdWNEMWxYT2F5?=
 =?utf-8?B?cElTL2pYNDFvZTgyRDZ2WnE1ZDNHbGxuOXpySE5IUHpBa1M2d0JzdDY2WWF1?=
 =?utf-8?B?T3BmNVlDQU5GcCs2bUpRY2E4OUVZTU0va1FGQjY4eUpSVXpWcG9OaC9kVzFo?=
 =?utf-8?B?T3d2aUhsT2ZPZzluM2pwVmU3dFQwYXZZcDQ1NlBVN25IZWNud2UzcXRWSWZv?=
 =?utf-8?B?OG1ydXcxNDg4dlR5V1JESkJxVUNJb0c1R2UweGZtWmllelN3dVhWWUl1KzJx?=
 =?utf-8?B?SUZGdXJFRmMxNDhUZkRIYThWR3JXeThROXZRc20yY3RvMlBnRHBPWmJjUnBo?=
 =?utf-8?B?TnF1Mk9GemJKSHVkdUV4eC81VWZFU0N6ZzE1SUZaR0c1Z3ErUFVoUT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79eb42a6-e5f7-4ad0-4dd1-08deaf9ca677
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 20:34:07.7074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vpmlMUtdiDL1fC075AtIwfwaCqup9UaozjnY9CNJU8DmXxcatuA+4lVBaFRXR6OwCyfHZBjoovKoHYz1fCHxjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO9P123MB7883

--ya4r6ktjheu4erdu
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
>=20
> To achieve this without incurring runtime overhead, the
> ___define_initcall macro is expanded to statically allocate a
> builtin_initcall_record structure (containing the module and function
> name strings) within a dedicated .rodata_builtin_initcall_records
> section.
>=20
> This implementation incorporates several critical architectural safety
> measures:
>   - The custom section name deliberately begins with ".rodata" to ensure
>     KASLR (Kernel Address Space Layout Randomisation) relocation tools
>     process and update the string pointers correctly during boot.
>   - The structural alignment is explicitly forced to 8 bytes to prevent
>     the compiler from inserting silent padding that would misalign the
>     linker script boundaries.
>   - The blacklisted_initcalls list head is stripped of its
>     __initdata_or_module annotation, ensuring the list remains safely
>     accessible in memory when queried from user space after early boot.

Hi Sasha, Breno,

I thought this might be of interest to you for review, given your recent
work and interest on the "killswitch" proposal [1].


[1]: https://lore.kernel.org/lkml/20260508195749.1885522-1-sashal@kernel.or=
g/

Kind regards,
--=20
Aaron Tomlin

--ya4r6ktjheu4erdu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEeQaE6/qKljiNHm6b4t6WWBnMd9YFAmoCPTwACgkQ4t6WWBnM
d9bEIA/9GZUgSibxIL1AapPHNSDH2McFG2tYAiTJo/c3lhaqdu5MeWq7My5yVEMZ
n2PkD++9mbHKxYOHsP9IK7BpBbHi4DrW2gIeYFTcMsxIkFtc2uaxrI0zZAZA+p0E
rDA+rhoGGIvBabM8D7RFgbP9zEZ5SIL5GOXfXPOC3RKcWakYKQ5dpomCwSfSSKkb
DBd5QJmeqYibo2VjvlD+ZRFgkRjHZGX/mBYpO8p5O9WbgwiaNSphgsxSHkS0UVAG
hHRqTtZLvU2a059cICWTYMjJcdAMPr0s4uhZdS2T2KanuJ2DmXq0qWfew8+PRO8H
F9leUtCZyasyAm3JoeIJhhqpOkbn5MQLbu1ldVYYtNkxmQPJRFKSKGriutnA9DgQ
oequjiWPSnzJ8Jm4GGek27+TA/cprlMa4PUefoGv6h9y1dNReIhVYSplZiNbWFyO
jNvIO/19jJauDeU48DvUrexRRdTkASQS269Erbz26ETN+b77SrUBuoxPPBdI6WdZ
RYjNgIfPuIRFTrNfRqJxKZfoLuH3hg5ZeBfEk6LIS+G8dJvktTnBbJK1AEie7qol
lCCjhOdh6pBI5OW66yEygaMsA8aHv2Z9mlxKDZikGU4AgDM4qVAy20etlS1eeCIW
P5Tj8uDRt/gYC6LFOfVOb+q6qIbODyKD/NApenskyysB3m1gnhk=
=bxOW
-----END PGP SIGNATURE-----

--ya4r6ktjheu4erdu--
