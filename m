Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021098.outbound.protection.outlook.com [52.101.95.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561BA37E2ED;
	Fri, 10 Jul 2026 23:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783725209; cv=fail; b=X/YSvUxcr2O8/D44OVVcLgefKM1Tr01da8KlrDUe7A6thVaGSgrJ2dvA1yxdF40/KqtTJ/f2BfT2eCr7mBDpUK2Nq+qf7ffshLAigM4zjvBj5h0nhDFK4+0mtF8EJL1m+ZIj76cHebPTHo8Zzq9gT4eIUcmFu31hKpPSTVU/7Lg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783725209; c=relaxed/simple;
	bh=MzltSe4nBXOk1R0PZRGmeBOHrFd103IFpfAt8x87lXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ldk4Ds4QuE0ZsWPcSbSXaMMJh26ZR5u8LBspz0LOQNT0OrUTDzPau7wjdM06W8FG31y3rNTGOdQGBozy75YXcuqKzn/YsC40h6CJGbDwW4969CoPhdzW2P4iUmnrPpRmNbb2HDVz3Rmyckrxm5mtSDOVTGKY/q5OtJ8Pzp+/VDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pDabTpQkTJ9O64Bcm7ERkBiCELzd6OeMQoWSgGe4iApeekFrSI2ycFpJguebkUcHEwlYzZHUAfkvrpSTsTCcK1ZH83iijYJowC7/ux8AciZycnMhl9qOs6JKnQySH+7M4AAowwBJYHWFDKkrCLY7hy+lhHoxwys6+rZ2yX8dy3930Xx3twKezYTdL8vc+D7L0HnxY0XNx1sRbMi6Tp/jN8KmOAFUJU1ai/WrnwycAMJhExBkDEQDi/bRPWtvXGKj7mmZ5lLGw3XkUbt2VQdx0mHycM141kccRtiB8g0w2jRmQS3PO0btWrkLXGRfIIzwL+vr0GyBSTLaVcxQp09LuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=HpNOiHch1IDMcepdl49UkidrAAea01L5VPk0FKsngOA=;
 b=hJTytamP2WTddY2PmvlnlwHfFAyu/MhlhpQOA50z8SMXg3NiOwujE3YAqIVBWo4RXOlsXAaIeToqYeKjxAKrtG0mSRuJGQPcWEYFrwjMI/3Gxen4UJH3P42sRF0oOGt54Fa9FstJmnFe+XkNQk3Vb5k2HhZ9LkWsanjbHCoOuI1lGS9Sj3CMsuL/0zG5RFL9AppDAW/gD4YgI/W+EWQ8mi0ABvRSvP5G6TFDt/QRsBle0LlEJZmIAcxAVo5Td8NAresjSLwH8N9qwQPTJPIGxF21+beDLMuPO/CIW3O0INJMRIw1n6iII7W/ryOINSFHO+XNEZT/dIKPwt9KVd5Fdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CWXP123MB3494.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:87::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.18; Fri, 10 Jul
 2026 23:13:23 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0181.014; Fri, 10 Jul 2026
 23:13:23 +0000
Date: Fri, 10 Jul 2026 19:13:19 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	da.gomez@kernel.org, Sami Tolvanen <samitolvanen@google.com>, 
	Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, neelx@suse.com, da.anzani@gmail.com, sean@ashe.io, 
	chjohnst@mail.com, steve@abita.co, mproche@mail.com, nick.lane@mail.com, 
	Linux-Arch <linux-arch@vger.kernel.org>, linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] module: Extend module_blacklist parameter to built-in
 modules
Message-ID: <in7aczdvb22suqhao6uzsjkh22tgyx2qug4i6efdxyfiuj72ba@k6fr4oc27kim>
References: <20260708020007.55728-1-atomlin@atomlin.com>
 <33171ccd-038b-4bb8-b796-f104a131c0ee@app.fastmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <33171ccd-038b-4bb8-b796-f104a131c0ee@app.fastmail.com>
X-ClientProxiedBy: BN1PR14CA0025.namprd14.prod.outlook.com
 (2603:10b6:408:e3::30) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CWXP123MB3494:EE_
X-MS-Office365-Filtering-Correlation-Id: 12f4c5b7-5a7b-40a9-ec86-08deded8d693
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|6133799003|56012099006|4143699003|5023799004|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	+2JAauEaXximXmWeyRSJDC2iP0+qjX5RGRe1cNs/BHWQSWjq9HVFnuMhRyEiKjHbKOoe+E91PIlPvQbYzF2wUnzTNa3C7CMkPda49fFKsTBokYzr5nw/fr7zQO4doA+Eufr79+E56G9aCSPghGMVqm7bjypDg2XjpLnbGqbpBge3BBltPBTPwVeEtOvO9AyufY94RFQmQGmkVYqLuSrT7TOsKDoW1u7H9cXpURaZR3n3j7f6kx0nf80Mcfft9TBoxwnbvIeYEWjXvG/NruvjQPYdR1xIw8PafnTTbu1DIwoTXMDvliiYKgog134sJK2f8284VU2m6zzBuFGOv8ajMmWUduER+0tq3u7fEDXvEzGXwxJDOf4oeTORS2Q2KAQ++yG2XBQ+cP5fmsSS0pyVUqSIv9ipnlklIEQRKyaF9GjaTD6vYo3WAGkf1oM/Uf/WhiVt4VbClafhiu6fTCgCtgv6dlTXrXZ3P+voeM7aW0dDB+fSX17UTKQ4JE+aomWy+DQSnnojsY9URDlTrpHA30j36we8Zi7bAUmVT1VfMj4OVR+/vsW5Zcj0wMH73PZHMkYHqTwAfBrlW1bw03LSEheUWHS8Q2PzznXI4GOG/s03L1w8rcu0UgJ+Kv5XZDUiEnT3F3A9FVuXEvgKYeoki20/eCw4TzPiGxE2B8i5TuA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(6133799003)(56012099006)(4143699003)(5023799004)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NURveFZvZzMzd0U3ZnIrQkpVRktTV2o5OTFlUGpSRUhodWx0Q0FiNEkycGtS?=
 =?utf-8?B?RTRFaVIrcGhpMmNyakI2bUdxRCt5WUg3UGdXVytBQXpsd0Z1QW1PTU9kZ2ZP?=
 =?utf-8?B?Y1NmUVdpVWhWNUZQVE4yREZhajFBUUpKWmZqekhuSHZjakhjaUtVZ2YxdzNQ?=
 =?utf-8?B?M09iZE9QN1ZLSWNlc1NXN1pHVDZXUVJkTEJ1TWExY3lzNW1ZNlJZM21HT2ZU?=
 =?utf-8?B?QkdjalNYRU1peTBKVWo0UFBSYkdkMGpiczJsaWRoRnhGQjE2anVyeHhDc3Rw?=
 =?utf-8?B?T0doSlZEdm5HOTZhRGwxak44Y2xSRGlxVW9EdDE1dXNXQmFxK2xIRmFaRy9o?=
 =?utf-8?B?UkVFZlVGNEJDVGNxWVhRZFQ0RjlFL1Y5em16TU5HRWQ1eE1WZEY0VXhQUkdy?=
 =?utf-8?B?am5HTTE0Um9la2tsdUJKUXU3cXBocWE5aEIwQWx5T0VsNXU2cnZVZWNJbTR5?=
 =?utf-8?B?b2F2aFFWMGZEaWpESytOZnNLK1BJbDRxVmFyYnBERVNuN3VFOFE4cVhxMnhr?=
 =?utf-8?B?M3pLRXptWC9UbHVlUERtU00yYlY3YTREdUNZSHV6QTU5bDZWZW8yUE1QMzlQ?=
 =?utf-8?B?TEFPZ2tXSzhLUS9qdlZ6NTFVMnRaYUVldDBmamxDYU9IdmtWeTJpQk5Vc29O?=
 =?utf-8?B?MXVFdk9OaEJ6bWNuTXRvV1FqNmVSV2NMbVBVeTRQNERySHdjYjhTY1BhSXFv?=
 =?utf-8?B?ZWg4b0I0RUNuSm1lb0FkaHVJL1JyK29EUGw4TW1IT3Fjd1gvdkUzY2lIcVQy?=
 =?utf-8?B?STVkS0swREIyTENSVHJKWGlmaXVURlVETVNSQ1cwTHZZbTNYVHBtVjg1Tk5N?=
 =?utf-8?B?eU4rNjdOcTBQRVQzODBiT1JUcDlRMkhWczVYVk1nQmZWWkJJOWUwNTZvWXNE?=
 =?utf-8?B?Nmp3YkQrdVJIVVlkdFZJY0p1cEh1VmlocGtnaWNhUCs0U2NEMnpJVkJWRHph?=
 =?utf-8?B?VW84YVhYOHRiM1RUaFNiek83akdRZEhXMVR6OWNDZmQrME9SMWZLSC9vU3li?=
 =?utf-8?B?N1BEY1dVRUQ2OXpHZCtGdk51OXU2emhEMUprMVVRMzRyZEpOMy83N2IyYXVM?=
 =?utf-8?B?dlJtS1g3bWxKenVXSnpRc0lORFUraUhrMkcwZFRCSm50T0d1ZjA1cXp0eVpz?=
 =?utf-8?B?dDJMSFBoeUlSd0tjNngrRDVSUGgxRFdaZnlIU1hWYmxZYjJ4bDNwSjhydmdv?=
 =?utf-8?B?UVFPRUlLNzVNUkgvN2ljQjU0M0hDOTRWMnhnMFdUMGFkVk9UbWVnWXlsWGc0?=
 =?utf-8?B?SU54SHdSdWlZeE5PY01keXZQNE1wUDk3bHZFZW00Z0FIanJSTjBvanIyTTMy?=
 =?utf-8?B?dDZJd3dLSGhGYUZnazI4OEIzSFZHYzdDUjJ0czNUZmwyVVNUdkZZQWVSMlI2?=
 =?utf-8?B?TmE3SHRUSXFWVDl3V1hVelc3dENlWW5LTXRHYlM0Y2tUeU5RRFV0MDhSSks4?=
 =?utf-8?B?dlNITnBMM1RaaU5jaWwvYksyZzE0Q2lWczBadlVZV2ZXRWVFMlZETDBiNS9K?=
 =?utf-8?B?VnJzazlRa3ZtZmpjakIwTFBWQUZiT25vSU9LK1pIYWVuWUxacDQ5cmxYdTlT?=
 =?utf-8?B?ZEFtUFpTZUNldUtYa3llbDBpajNhRXdlMHdSa09SWmNLcXNiQjcrVUN2NDBS?=
 =?utf-8?B?NkVjbXUxMEFndHRSeDYzdmEzWEYxQ3FFMkJGUTNNd0YxOVVEMVdNL0lYeXdx?=
 =?utf-8?B?b2gwQjhyZHN5bnJvTURIMHJqY0JxNXpucUhHUlJlbmtHYU1nOTZWUThhelR1?=
 =?utf-8?B?YlJEZlZVY1czeDZ3cjlRRGlWRTFRVTk5M3dLYWNJblR0Z2ZVdE9Ca3ZTUGVJ?=
 =?utf-8?B?U3JBRjNXQnNuYlVVeU1MaDlLcnIyZ1N1L3g3RmZiQTVoVXcxSWhrcFA4Wmtr?=
 =?utf-8?B?bnJHc0R3MGRZdjVOQVVKSVRVYzFXaHZFRTBhZWdMekI3bk5UYUZJUUJCcXRj?=
 =?utf-8?B?L0RrY3YwZkpsbmVtNGtyUjMzSCtodE1ITnAvckRMcU4xWkNGVzM1N0NVeGJ2?=
 =?utf-8?B?bnFvakcwTlpQTEdTL0x6REtSQXNSYUtmcEpWVWlZcVZpVk5TN3JtNURUbldG?=
 =?utf-8?B?REtEWkJDb2d5Ymo2MEtZT0pPUkRENUFucW96cWI4endjRm1vSHc0V1dyZkVz?=
 =?utf-8?B?N2wyZEdQWVVCQUI3emxwZnBQbmRhYkJ0NDdhaDhWMkRPM2tWWVBwUVBhZjZX?=
 =?utf-8?B?L3NzRDdzNy9ZVVB1ajlkOVA0SE00TENodUtvU3Azb2RRRDZZQVZ5NVl0VmlQ?=
 =?utf-8?B?QXEvbk8ydkxHMTZWTUV6dDU2aGQ0RFB6My8rbHI1Skc1Zm9YZm44dG81enQz?=
 =?utf-8?B?Rk5zWVMzOGxseWhxMzg2VUFGaC9vb1VJTC9wa0Z6WmtTNE1EY2FMQT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12f4c5b7-5a7b-40a9-ec86-08deded8d693
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 23:13:23.0173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F120FfQ7jB0hdxBkzSpkEwInQhZYuBRk7DEMjDvtzhF10QY46MqP4oovMRd6RWiuP1PFtRDWl3ClXuDE1F53KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB3494

On Fri, Jul 10, 2026 at 05:59:59PM +0200, Arnd Bergmann wrote:
> On Wed, Jul 8, 2026, at 04:00, Aaron Tomlin wrote:
> > Currently, the "module_blacklist=" command-line parameter only applies
> > to loadable modules. If a module is built-in, the parameter is silently
> > ignored. This patch extends the blacklisting functionality to built-in
> > modules by intercepting their initialisation routines during early boot.
> 
> Andrew already asked you to provide more background on what you need
> this part for. Do you have a specific driver you need to disable?
> 
> Can't you do the same thing using initcall_blacklist?

Hi Arnd,

Thank you for your feedback and for highlighting Andrew's request for
further context.

The primary motivation for this patch is to provide consistent
administrative control. From a system administrator's perspective, whether
a specific driver is configured as loadable or built-in is often an opaque,
distribution-level decision. If an administrator applies
module_blacklist=foo (or the modern module_denylist=foo) to disable a
problematic driver across a fleet of machines, they rightfully expect it to
be disabled. Currently, if a distribution later changes that module's
configuration from loadable to built-in, the boot parameter is silently
ignored. The driver will subsequently initialise, which can cause
unexpected operational regressions or security policy violations.

Regarding your suggestion to use initcall_blacklist=, while it is certainly
a capable mechanism, it is fundamentally considered a debugging facility
intended for developers. To utilise it, an administrator must know the
exact internal C function name of the driver's initialisation routine
(e.g., initcall_blacklist=foo_driver_init). This requires inspecting the
kernel source code and relies on internal symbols that are subject to
change between releases. Conversely, the module name itself provides a
stable, user-facing administrative interface.

Furthermore, I must credit Petr Pavlu, who offered excellent advice [1]
suggesting that extending module_blacklist= to encompass built-in modules
is the most logical and robust approach to solving this discrepancy.

[1] https://lore.kernel.org/lkml/79ace94f-31d3-4a5e-9a47-3fad69304fe5@suse.com/

> > To preserve the existing user-space ABI, "module_blacklist=" is kept
> > as a legacy alias pointing to the same module_denylist variable.
> 
> It looks like the denylist is only introduced in the same patch?

Correct.

> That sounds more useful, but would better be done in a separate
> change, and also needs a proper changelog text.

Understood.


Kind regards,
-- 
Aaron Tomlin
