Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021135.outbound.protection.outlook.com [52.101.95.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E291A682A;
	Thu, 13 Aug 2026 14:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786632630; cv=fail; b=S/q/+z2BKuAdXgpuSWUnNvrV89OQbR8b4v0RLqdl4XCTJ+q/rxFSVU41WWskzJqn1eggK7tlj3gPxztUtvPS57wv0qzKjbwvsnXPt6tbWo6mWFsgkhmtdlRTTwNIrxcAqiyZSQAiJPhtw/+zJ3yzI2duzQEHWuY15QQnkkDh5tc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786632630; c=relaxed/simple;
	bh=yx+6Q2aTUOfIxVhENpVdxXAVn7scfsATsRk8MoXUvEc=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=L46+YfWqvkodl9XDEqNPqy452dnHx7pVtY/gKmc0X+CFBxSB5TpDlwerL+mS7whOeqlSgDrxP4GfdEcDFVo7z5xfG3mudQSEsom8BFU2v3byIKx50HYSm/ugbPhxsirMV/3p/7msBqL+ev+5d5sd/g3zYkDxgaSiKdi8RvPPZrw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=vp+DW5S+; arc=fail smtp.client-ip=52.101.95.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="vp+DW5S+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XZe1C/4aCxNYGUbpWWynouao1PhAmtTT6tV4segyKXDEmPDRNQJvNcWs2fKfDLWxB2xPKLpDSQBHBlof/O2yJedxPrRf1Xwz2bvTx7vOEM26Yf9qTjBK5hcvPQDcnIF7JP6qbGLmZETKiDtW+ADupOKcr8PSWAiS0XccvuOyYY/MYDye79BjQDObWMKCKIJGc6wPDZdgTk7fmAmhv4mbYxjtInd6bexkK5k957oxPlP5l2BP4YNB1QaOePmIMn/YRRo3X06NuuHcvwGmOR3D4J9kJXkhwNpBW0429LgbuDXV1o4RRaAJu/qfQTdxRRGoSnFv2E1BOccH79IXqqQrBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p08ljEOeNCLU4soyFKpM/I0rd81qhoVvx6/jVns4Sdg=;
 b=KnRbVy/0cQoaUeouJDEFXKwd2IAm2+VKlTN9GNbpnrBvbaxn89owUDjD6HJor0prFlOfF106wxSqF3C3ZP05nDu9joZjG0Jdmr53etYvMJb0jVlLsYB/8hD9ygCFAJyrwF6Rw5JXo12DcW8NjOvbEqq479dR0Jfaeeh5t4c/qcQ3H/dR00oKBCkzveqIFchJ11KopW0j6bRCmXoy8rRBcvW6k8lGIkDugXrSWFCs/OSwXfw8K7netbC6BZqqPTsB81L7eXC9DCKK0hMxN1GXKPewUGFjhrhLHvRCM17jHhyi1ehhe/O/+LP7hG765r4xAxwOE7uq1r7lvGwfF6+IyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p08ljEOeNCLU4soyFKpM/I0rd81qhoVvx6/jVns4Sdg=;
 b=vp+DW5S+LtiUX7hXdq7pLjFwYkFrnWSHwm3XOoZJWaxWqQlAFcJJsJkhWB7XaC4oSz7vCXG//2DCHS91UMUuzGBMXDNPBizoBoVz4RgYSJrYrSHtif07wAChc30vmjK2mmt4B4xkw/Aw8rnpdPbxFVDAAiLNOz2G+4IGGWamMPs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO7P265MB7937.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:40f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Thu, 13 Aug
 2026 14:50:24 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 14:50:24 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Aug 2026 15:50:22 +0100
Message-Id: <DKNWEO3BOUOL.9COZBXZIGS6A@garyguo.net>
Cc: <akpm@linux-foundation.org>, <mhiramat@kernel.org>, <boqun@kernel.org>,
 <neelx@suse.com>, <da.anzani@gmail.com>, <sean@ashe.io>,
 <chjohnst@mail.com>, <steve@abita.co>, <mproche@mail.com>,
 <nick.lane@mail.com>, <linux-arch@vger.kernel.org>,
 <linux-modules@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 0/2] module: Extend module_blacklist parameter to
 built-in modules
From: "Gary Guo" <gary@garyguo.net>
To: "Aaron Tomlin" <atomlin@atomlin.com>, <arnd@arndb.de>,
 <mcgrof@kernel.org>, <petr.pavlu@suse.com>, <da.gomez@kernel.org>,
 <samitolvanen@google.com>, <peterz@infradead.org>, <ojeda@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260807012601.360452-1-atomlin@atomlin.com>
In-Reply-To: <20260807012601.360452-1-atomlin@atomlin.com>
X-ClientProxiedBy: LO4P123CA0265.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::18) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO7P265MB7937:EE_
X-MS-Office365-Filtering-Correlation-Id: 02bb48fd-25ae-4010-c838-08def94a347d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|23010399003|376014|7416014|366016|6133799003|10067099003|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	Qf58u4WPC2T3d57ezfOrxKy3ZCfZZ72+D3WjcRYaEA6ntSBCpL6PiA7jSmVJrko/M2J5JisKVMs20iJ+gjzt/NboVQcFIKrVoGrS/gA4crNHkq83EhU0DaO8Lx96WElJsMpQFf8W+Vgf3fO7aL5pcsok/E4QsHQH9K0xPKmTxgp6MxCwx/k4uMJ+GbvHFKmiQ3rApuEOK7TEtmxy+T+zSFY7Eff8nqSfUOdQT4AATGn0ftG+k1OlXfZjb+YoqRjMWtMbQMgdn/0rNeffTk+BYfCaVg6T+7lLEUxx0xCM6dPeMkl3El26kNb5ZtsZPhrBDTOY7fQ1hB4kYyB57ddQLOowD8drlKnizyP8bHB8XAcPVtpy7ahL07VJRqzsTe9JmeCvBtCl8kSwIjfWQMPy2w1Tq/JCYjd/VQ3fCwekLawoAncfOekfDbS+ufHSJJO3BYIVt8M7lmNs8L/CgZ5jNU2Ba2gK67uurFAI9nhWtzejxdfJg2XPBVtZlssUTMcOvRigsqEYHHsAu/3cByvoloeeqlX+Ke/rEzEMe5XNkGwL6mwAD4C7I11SiyMV/SNkG7tSyAKW/V8W+HYAm5/uAJZKYhI03FaW3RsPqXE69xfuLHw9zysISjSQZrS9LG8tmo8HltqqRCpV573/+NByikq7/n2hrcwdjM0QmDdLKv8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(23010399003)(376014)(7416014)(366016)(6133799003)(10067099003)(56012099006)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WTlCakZXYUVtZmNLVlhyUldOM1E1UGNWZkhjYkE5QlpLNWlUVGF0dGt3c1Bi?=
 =?utf-8?B?NENnL2pvUU45Qk9ncGhyZHQyc1lVbDk5d1NwVkdvQ28wY1phbnJjWmdGQ0ta?=
 =?utf-8?B?VktYOE1IdU1qTGQxcUZwQk4zNzk2T1gybzhDYXZzbGhXL2lacnhSVE5DbzdZ?=
 =?utf-8?B?aWZhWmdoeEQyYzRDTGo4SlpxMklHSHhqZTJFT0tQOVlnVFhYdXhGdVZuWHZH?=
 =?utf-8?B?SW1OREpZekNFWE5FejdZNTE5UWZnNDNld0o3YXB5blFRMXIzZVU1MVlkRk9M?=
 =?utf-8?B?cmNhdmFsd2c3V1R5ZTBFRDNCQ0VFaTRUQUU0UFppK2xHVWlMYmx2NGdIMnRo?=
 =?utf-8?B?L0V1M1E3aElJZ1NNZEowbGo4dzZPZUZjQjcwZEt4aDEvSTBnVzZLV09xT1Nt?=
 =?utf-8?B?OHBvd0IrcExUaUZXUVlEU2tBTGVFTFFVWHZpNkZtUUVXRzFXZXRVa1dxbmFl?=
 =?utf-8?B?cXN1cXJXT3NORE1mQUdJaFovcGNSa05UdDZSNlFDZzZia2JOOEdkY0ZpKytN?=
 =?utf-8?B?OEtBZzZWdmdNdXp3d2hLQ3dZSlNTQmtLQXRhLzJ4dDJPVllYTXFQdWJnUDBn?=
 =?utf-8?B?Q3dySWVnZFV0TyttNnJTVXpWMlB4WW82ZXVGaDgzSEZQeVVZV29FTExwK0FR?=
 =?utf-8?B?MFBSbFF3Vm4yanQ2cVh3aWc4bnRLUCs5eVE5SGd4U0xCSzVFUzY2S1NOVHFl?=
 =?utf-8?B?R3AyL2ZBUWMwTXJsc0JVb2tCalhuNjhKNHFZdXdPSTVVdlo0NWM1QkhURjZX?=
 =?utf-8?B?Q2ZodmpIbEkvVUNLUlEyVFRqRkxSUUlEYzBqY0VRb0MrODJ5b1ZGNmpMSE1Y?=
 =?utf-8?B?a2VKbFE0RTJLbytKRWZ3SEJpemIyakU4aXFyWUFPZ1BuR2RhbkxMdzhLQ2N1?=
 =?utf-8?B?aXRNcHkwemtpdE5ZYXRwT0lxYU9ULzk1OTBUc1E2STc0aHB5bzQxYlBDTk9q?=
 =?utf-8?B?dFY0eThYc2lYYVhxNFQ0SkpWZTliVzEwVWV1R0YzRzBZOFJ0cjBVRW95YmZk?=
 =?utf-8?B?V0lCUHRramJsNEZnS3RGYXZxTUxJL2o0NUF2OStjaUZiS01keHNFZUdETFhs?=
 =?utf-8?B?K0FheDNWVzA1b01RVkVNL0JOc1RPc1kycjBWb0RhSC9UeDI0KzM5bnMyNVZi?=
 =?utf-8?B?SFRrWjF2bHNQNnA2SjRnM3NQSjNTQklKWHNNb0FxaEZZTzBGVHhkaGJWei9W?=
 =?utf-8?B?VWJFV3Vkak5kelZxMGtWRThYNytDMXA3TTc3eWxzMVBkcFdBZUF1N0hEQ0Zl?=
 =?utf-8?B?VmJoMUlCS0JRR2NKTTVueCtOOWdCcXFxeUxBRXlUV1ZJV1RHdzV4UzFORThX?=
 =?utf-8?B?UFB3Qm0yYlM0L3dYRm9GLzFZd0lMcHMwNkFZeXlzcjRvTUc1TEdtVnp1MnhH?=
 =?utf-8?B?eTI1OEw5UWhvNytiMnBuMWw4OEkyc01NcVdJaVg3VnFwNGcxdDRwL0pxa0lY?=
 =?utf-8?B?WGJrd2NFcjBqbS9lU1hSbzNOdndLYmJ0U1ZhUTF5ZXYzYUxsSFRyZXI2RzVL?=
 =?utf-8?B?SGlaUGtTWlNxODBlbW1ZOXFKMDRxdFdzdE5MSFcvaXlGbUNCRU5jaVNHaHhJ?=
 =?utf-8?B?OEFmMDdvcjRwSnBrOE9GWGlCQTRQQUd6eWRVcHN6YlJCNGgvMmNLQmQzSG5j?=
 =?utf-8?B?WSt0UktRNmVaOFU4N1pGRVhrblFaS3EzOSthYlZtRXgveVhsVG1PVWJwYjU0?=
 =?utf-8?B?cEw1ZGNFSHVIL0hzbkFIbW1SSHV1Q0ovZkxITnQwV1dxeWNCbUlMMmQ3d05O?=
 =?utf-8?B?T00wc1FZT28ycW1rcmwzRlIzOGVBRU0yeUNmWFJqY0RvYmtvR1haR3oyWk5s?=
 =?utf-8?B?OGNUMjhnUTB5WW9XRlRIWWxid2xXUWhMbmlkTVVTV2pNZy9KOHRsczdXVmtN?=
 =?utf-8?B?RGlQR0pHbEl3SUxMOWJwTlEvY29kNk9YSWxuMEFJVW1UV3UwYklQNjljV09w?=
 =?utf-8?B?TzlOM1Qvd3lRTURmdGdUa1ZCazRxczhTaWpkemIzQnA0WE8wZzczQU84bTRW?=
 =?utf-8?B?aEFDV3RPdjNQcVk4TlhDV3d1eTFQeDB0NmFzWXFvMm5tZkozb2ZQT0R5WHFN?=
 =?utf-8?B?R3k0QVNtRE9jUElzTWIwNitxYndoaENHaXdxcG03QmRxcWFLS1BvUmE3L0pS?=
 =?utf-8?B?bEExNGhkR05oeTBNdnlocXVnZnVTMXZvTGFGK3lIUkQ3eGE5VGhZam8xcnBY?=
 =?utf-8?B?WDU3SnFFbzE1amtzOVN0dWEwWXIrb3R0TUkzeGQ3NmFyaEJ5VmpyU3A4MW55?=
 =?utf-8?B?UU9OOCtlUXVqNWFHY2J1anhJNDAvMk96alE2SlNCSTVxeE5kMjJFcHl0ZVVv?=
 =?utf-8?B?QnZTUXVuUUNMV1RVdGtkbEdwNTNtam03azVlMFd4ZnhERTdGekQvZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 02bb48fd-25ae-4010-c838-08def94a347d
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 14:50:24.0286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W8CM56ivKNowcUWDtNVWox5o5KEjF76OVyZrZHy0pJ621mf5EbtqRMSkcKsZPbR0y91j+hw2ij+871H54dAuWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO7P265MB7937

On Fri Aug 7, 2026 at 2:25 AM BST, Aaron Tomlin wrote:
> Currently, the "module_blacklist=3D" command-line parameter only applies =
to
> loadable modules. If a module is built-in, the parameter is silently
> ignored. This patch series extends the blacklisting functionality to
> built-in modules by intercepting their initialisation routines during ear=
ly
> boot.
>
> Following review feedback, the implementation has been split into two
> separate changes to decouple the introduction of the new feature from the
> terminology renaming:
>
>     1.  The first patch extends the "module_blacklist=3D" parameter to
>         built-in modules using the original blacklist terminology. It
>         introduces the ".initcall.modnames" section to map initcall
>         function pointers to their associated KBUILD_MODNAME strings
>         (restricted only to module_init() invocations to save memory and
>         avoid matching core kernel subsystems). It also restricts the che=
ck
>         to a boot-time __init wrapper to eliminate Use-After-Free (UAF) a=
nd
>         Spectre v1 vulnerability risks when loading dynamic modules at
>         runtime, and adds a fast-path check to eliminate lookup overhead
>         when the parameter is not in use
>
>     2.  The second patch renames the variables and helper functions to
>         adopt the preferred "module_denylist=3D" and module_is_denylisted=
()
>         terminology in the codebase. To preserve the existing user-space
>         ABI, "module_blacklist=3D" is kept as a legacy alias pointing to =
the
>         same module_denylist variable
>
> Aaron Tomlin (2):
>   module: Extend module_blacklist parameter to built-in modules
>   module: Rename module_blacklist to module_denylist

I feel with
https://lore.kernel.org/driver-core/20260421-acpi_mod_name-v2-0-e73f9310dad=
3@sony.com/
and this we're really making loadable module and builtin modules less diffe=
rent.

I wonder if we should just somewhat unify these completly, so built-in modu=
les
just behave identically to loadable modules, just without runtime relocatio=
ns
and ability to unload.

Of course, that's quite a big change... And mostly likely people won't care
because almost everything is built as loadable modules in distros anyway.

Best,
Gary

>
>  .../admin-guide/kernel-parameters.txt         |  6 +-
>  include/asm-generic/vmlinux.lds.h             |  4 +-
>  include/linux/init.h                          | 24 +++++++-
>  include/linux/module.h                        |  4 +-
>  init/main.c                                   | 55 ++++++++++++++++++-
>  kernel/module/main.c                          | 25 +--------
>  rust/macros/module.rs                         | 16 ++++++
>  7 files changed, 105 insertions(+), 29 deletions(-)


