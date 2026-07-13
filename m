Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021136.outbound.protection.outlook.com [52.101.95.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F4633A708;
	Mon, 13 Jul 2026 12:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783944818; cv=fail; b=tR8fRj1TUHqaoLqdhpn3aFci8JxMD5BKh009OeYtqFR3X/6/CUpiPbS3Q9xqkHl3bTSNr/tJGQ9ul9OxJbSwjygVcFqju8o/ktnH01IhlF4z46ja6YneHRFppyewKRlyHlwqgw2Fc7odO53YN3BGIxKypTsvJUI3nEuIJipPRYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783944818; c=relaxed/simple;
	bh=taUgO+5rB4+Dy57bSkXQFXGut5quVfVAVRQ90sYdswE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Urum7ovoKKR31u+kJx23U9KU3pFDZlTO7X0i1EMYgDE4EaiaStjlYvkWyuT1hyr6hc0r2brRSkLZRyqSTtYZYRi/mmQwG3qpl3QGMdYSzQHiNNnnyB6DCWDwUkb4LWphSEp+seGumMTQJPHvADHefBVpiwsgM48gLSDIiC9bXeo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JCq4sPm0aorg2Qlce/Mc6KALN3zLlFgROlp5ZPWzmKGZv9+/KepLEcIE/41gKE7f3WqsPxiytlQOCm3ZNkWIZ+TxFmu7U/NO9NM4A0Otg2Hb6VqZ+yBc5sty+bSZyxXKha896UIoKNYSY3abQmDNvJ0U9NEse5Kdt+hcUkBxx7sVMwGKil++EBZO2nhOD/wM1GXInlnPZlEK5waDc/top16C7T/ca4/q550ZOh/lhoKAz08gGptaw73TjoKP0sg3qy7w+HSGNX6pydK9XRYQYIPariBh18Syw2mzl9zoa/dSnK0cCPTxjObJaDcpBDPruEmsBVF5bjJ+ftyhI+Kanw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=ll2oz5U503hPxFQQ7GdCwE31jTpf8NA4iQID/EpTBAk=;
 b=G7diUHklCuFFlr6gWBc91NksXAtkW+zirlL9ClYsrtJLwAcNME1SkKN42M1SDivOeMOvgFPE6NSGzzdfzq0KWfrl5hg9cAVMO9g5xJXq82VdtyhYG5xDUBLBxg0TOne9emsbNIkPYg68Gva+uhVGnK8P4QwS3gRFVgzaJL6tC0kPC4eUWu8+Vn9PyH5ON41GPG468kO2y3wBEdfaWth7bMJBNwfTib7fFc9AjKY1l0aBGUBRQdXF5nQ4kd5eMmbvaVpb49Oqefk2yclioC40Xcn0TR5Wa2XnwK6AaPr6D9YeTEYb/aYb4HukoveUU/X6o6ZJWCIc4E+JOt5OW8k9vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO0P123MB7261.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:336::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Mon, 13 Jul
 2026 12:13:31 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0202.018; Mon, 13 Jul 2026
 12:13:31 +0000
Date: Mon, 13 Jul 2026 08:13:26 -0400
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
Message-ID: <ea7kdjwoucecvetzf73ce5dpda3l3etb6i75bks6deekfu6mb6@ooptba3x2oh3>
References: <20260708020007.55728-1-atomlin@atomlin.com>
 <33171ccd-038b-4bb8-b796-f104a131c0ee@app.fastmail.com>
 <in7aczdvb22suqhao6uzsjkh22tgyx2qug4i6efdxyfiuj72ba@k6fr4oc27kim>
 <78ec1da5-11ae-4c35-a08e-cc88a5d083f4@app.fastmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <78ec1da5-11ae-4c35-a08e-cc88a5d083f4@app.fastmail.com>
X-ClientProxiedBy: BN0PR04CA0072.namprd04.prod.outlook.com
 (2603:10b6:408:ea::17) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO0P123MB7261:EE_
X-MS-Office365-Filtering-Correlation-Id: 044109e0-9483-48db-b10e-08dee0d82714
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|18002099003|22082099003|6133799003|56012099006|5023799004|4143699003|3023799007;
X-Microsoft-Antispam-Message-Info:
	s14csgBQpwM5pNV5V1/PABTUm62dPnEZh7S+ktoczqG5xxe72EiylWTQlmO4CCF4IwpDvZCf+MnEDeXkYc4ZNLHtLa1MliQ3WS3fmmMIwJwagugfzVFaEFfjrvc6mvjJwPOMtVbto+qP7xixZ6eAEtkkwtvoKkZAkvyRBVFTs+mizKsEinjtbanot0a2v3Cg5ZDcZQjDZk0Mgm7mxaVtx/CjxxPW8RD+IbyuiuVZ/N4rywOf70dGha3iBCOjHF4OiwQGtJVhQd6HLfGRG+/endv58907p336vRP6amqp9/WK3XSiQcOI+v6/YSE6jf9gB+/az5IWN1j1c0jSHjKhlf+/07oOnuDAzRtN4M/W4TYrrvu2NF7BCVfKiJqjyQfvNAu3AXi1S8c24p9u7Jzb5887h9EDQlbxP1s//nt325B0vxGFwb0GriaefMZyvPs0b36UJYrsyhoyvXyIv5mwbP6DnzPMFtp5O0VtSDxabkCsmiOgtHkZsBpxGmmmw3LcYrSuNWYXEY98WQPD0wfTkAxLThSKcdI/F81phprUPvVgq6v6WVXwxzJA5uS1UKENkzFW1qu3Mvz8NLIPinrg06/xHFJh8B/YsjJd+C8sHb5dwSv6RYdbMr1SSxOAWkHTPO/pjdAUeFqwCmK2/UyRCCNtSvSfcw4zVEnlhsRgllI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(18002099003)(22082099003)(6133799003)(56012099006)(5023799004)(4143699003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dE5jVG5CeUU3RlhkeUIwWWxObDBjVmgxUlkyRGVzKytxZmJjamZ4RzJjMG9s?=
 =?utf-8?B?dTN5K21ZV2paQjcrdUxPdmFway9JUUI5N3ExQkNaaWRXQXp0d05PZmV2bFNB?=
 =?utf-8?B?alQra25jaVhuMlpJVzRiMHZ3d2k1MHNzWGpsdXl5ZE9pa3d6eW5kemR0b0xp?=
 =?utf-8?B?VEhDdmtiN3VIay85TFMxbVN6NmtHSWlEdTVqekl3d1c5NTluWllLUVk2aUcw?=
 =?utf-8?B?VVRNMUs1MlhOQS9mMVBzNUFxb3ZOMHlhUlp4ekJMV1hSeEwya2xqTFhyRjF2?=
 =?utf-8?B?VVZFdlYvVmZkaWhMS004YjRreWVNYmxuY2JVeTM0eVRKWU9JVys4dUsvZHlo?=
 =?utf-8?B?UElhM3llcHV3elN0Tk9NeVJQTW00VjJQeGNKMHF5b1M1MExRM05wVDJuU2s1?=
 =?utf-8?B?L0JnTkVrUXZFTGdobG9nWEdEWnkxR0lNcTZ2THl5N3VmR3JiQndJUElidThw?=
 =?utf-8?B?VUJSRExwb3RaNHgvTHVhNXBsOTM3QW81ZnRYN2VsbENheFBTbitWb2JPaG5w?=
 =?utf-8?B?V0VFdDFmSGE1emFXUlFNYmdqZHB1dVBRVkQzQVprWHd5RGhyLytCZGtnY05I?=
 =?utf-8?B?VU02VW5uQjVMb2JxVUZKZTRMV3dUbDYwZDB6UnNIcWVQKy93YXVaYjYzRVh5?=
 =?utf-8?B?V01xZDNMbzB2NU1wVzNwMlhEVTBkYVgwby9HNSszSnM4TGtLY21WMXhJa0h5?=
 =?utf-8?B?M1NpQWtsdkFiUmxyVEdpVVUySCtCeDVQVWljbE84emYxVmc5QjR6Z1VxQzZ6?=
 =?utf-8?B?b01xOFdhbGRQSDlFcnl5NUZZRVNEanNFbDlBMjdnWXdBclhublFTMmFVdHJ1?=
 =?utf-8?B?ZlZWRU9iQnpWSDhZMUoxMHFLLzE4MzdWNVFRd2tycW12K3IyWDlBb3RTcm5o?=
 =?utf-8?B?eForcnMvSTcvZ0NDWmtBZ0lMajd3VEdab0JzMnA3a1hPM20rMFpjWlNBWG5B?=
 =?utf-8?B?TU9Fb0tHSGg0M2RlVVF3a0tVRGVsVWJ0ZmVGekpvYmlMMnNzZFNwZEtVbitr?=
 =?utf-8?B?MFIvZ3dJaUwzTHFHOUhKc3o0VDRSQ0h0aCtUZUI3M1NXU0xnNDBmMjN2L1NN?=
 =?utf-8?B?U2toc3RUUG9yWG55Wk1XR3lsRE5MSStiSzdyU2pxTWM5UGd2RkVGTHhZV0Jy?=
 =?utf-8?B?bUxBZm9rWEhJVnZUWXhVdjJpQlN4RE05aVZoN20yYndLUmROMTg0eFVXbGpa?=
 =?utf-8?B?UCs3Y3pVN0szaldWbzZzOWx0NHdDcFpmWVB5ME1ra2xUcXhoZ2czdVpLaE1h?=
 =?utf-8?B?aDFzUW9sbEdLcURIcmlNUFIrd1ZoMVJzNTVMRXJjUmdPYXQzZ0dNdnJqdkQz?=
 =?utf-8?B?blB0OS9JL1lha0JMLy9LUHBLNEI0aGZQK2xFdlBtSXM5c1d5eUtyb3djeENN?=
 =?utf-8?B?L3ZUTUVpTGUxOWlxTnAwMjdqRnhuUDdoZVN6L1YrK0V6OWs5cHl0ZU55TCtj?=
 =?utf-8?B?YzljcHZKWWZkREZJRzhKVjA2eU1JVGFTMTRQZFR6T29VMnRaek1tV1p0YWlO?=
 =?utf-8?B?Ky9IbmRrV2pNZVk1dFpnTHBxblpwakpFVzV5bW1zTHgxRStkTVMxVy9RbGhC?=
 =?utf-8?B?MVlUdVFmSUxocHVEYjZDTnh0dHZQd0JsRk1pb0s2SlY2YUFiQnN5OVN4bisy?=
 =?utf-8?B?TDJxM291Tithc0lBVDM4TmpORW90cXpUTmYzUjNDRkIrYWdiT2lINlk2MFFE?=
 =?utf-8?B?ejVuWTFkaEx2eHUveHcvRXR3VzRyUWNPYmEreVF3SG5aNVIvNlF2Y0I5RW1R?=
 =?utf-8?B?d0xFQVI5RDE2Y2VEUnN1WHJmU2VSUWxkTm96eFpZMzlIM3BESkhCYTQ2Kysw?=
 =?utf-8?B?eTFMcUtwbTkwRXY1SDlnbHdJeS8yV0p2Q29JYTdpbXZTeEE3dG0wRDg4OTdz?=
 =?utf-8?B?UjVUcG45Q3pqOVpOeXQvTTNEYUMrTWVmZ2Yvdk91N3RSQWhqQlV0cG1FeGtu?=
 =?utf-8?B?NGprZGhVOThuM2d6dVJzMis2Z05wOHlXNGJJcWJ6ZTFsekVaZTk4OGRWd1dW?=
 =?utf-8?B?TW1XUXJkZ2ZGVEZERmJ4YjhuWjI4T2lsK3Q4NHN6azVLblRXWjl2WFpqdWZR?=
 =?utf-8?B?Q1p3Q0JzMzY0ZFBmaFJqdGVXVHJLVHI1NmJJdTNxMjBzMHBOdUZtTXl3RnFM?=
 =?utf-8?B?WTF3OVRFQzRWSi9RbjhGNlBLSTBLZkY0YWRDNVAvSEtmUGJVMTdKVjNaZXpq?=
 =?utf-8?B?ekVibEg0bjgyc3F5V0pVWjdsbVFlVFA4MGZaSFRaUnF1OWJ2SFdLam9aRncv?=
 =?utf-8?B?RjN6ekdHWTJ1SGtFRHhXV3VUTks0UjNSZ0NXNENzTTc0ZkxtZVJDeWhOME1V?=
 =?utf-8?B?ajB6am15L3dmVlJOS2FNVXI3enN3d0o4S2pVQzBwK0NRNzdEeWtnQT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 044109e0-9483-48db-b10e-08dee0d82714
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 12:13:30.8742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rhN04NJooWxl8dAA9CE6Vo5iyYmMmErxOp6tRQWRrwiNTeoqoHgJ0OMu9cg0piJJayyKlss1LPmWlOxQnk5K/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB7261

On Mon, Jul 13, 2026 at 10:32:14AM +0200, Arnd Bergmann wrote:
> On Sat, Jul 11, 2026, at 01:13, Aaron Tomlin wrote:
> > On Fri, Jul 10, 2026 at 05:59:59PM +0200, Arnd Bergmann wrote:
> >> On Wed, Jul 8, 2026, at 04:00, Aaron Tomlin wrote:
> >> > Currently, the "module_blacklist=" command-line parameter only applies
> >> > to loadable modules. If a module is built-in, the parameter is silently
> >> > ignored. This patch extends the blacklisting functionality to built-in
> >> > modules by intercepting their initialisation routines during early boot.
> >> 
> >> Andrew already asked you to provide more background on what you need
> >> this part for. Do you have a specific driver you need to disable?
> >> 
> >> Can't you do the same thing using initcall_blacklist?
> >
> > The primary motivation for this patch is to provide consistent
> > administrative control.
> 
> Ok, it sounds like you don't actually need it then.
> 
> > Regarding your suggestion to use initcall_blacklist=, while it is certainly
> > a capable mechanism, it is fundamentally considered a debugging facility
> > intended for developers.
> 
> I don't see much of a difference here, it's clearly still only a
> debugging tool to me, not a general administrative interface: turning
> off a random built-in driver likely causes undefined behavior later
> if there are any other drivers (built-in or loaded) that depend on it.
> 
> Overall I don't think it's worth the added complexity.

Hi Arnd,

I appreciate your candour, but I must respectfully disagree with the
assessment that this is merely a debugging tool with no practical
necessity.

The requirement stems from large-scale infrastructure management and
configuration consistency. System administrators rely on standard
provisioning scripts across diverse hardware. If a distribution arbitrarily
alters a kernel configuration, changing a module from loadable (=m) to
built-in (=y), the administrator's module_blacklist= directive is suddenly
and silently ignored. This creates a severe policy enforcement gap.

Regarding the distinction between initcall_blacklist= and
module_blacklist=, the difference lies entirely in ABI stability.
To use initcall_blacklist= requires the administrator to know the exact
internal C function name of the initialisation routine (e.g.,
foo_driver_init). This is an internal kernel implementation detail, subject
to change without notice, and entirely undocumented for users. Conversely,
the module name is a stable, well-known, and documented user-facing
identifier. Providing a stable interface for administrative policy is the
very definition of a general administrative tool, rather than a developer
debugging facility.
For example, consider CVE-2021-43267. A system administrator can now use
module_blacklist=tipc which would cover both built-in and loadable module
configurations.

To address your concern regarding undefined behaviour, disabling a built-in
driver carries the exact same dependency risks as preventing a loadable
module from loading via the traditional blacklist. In both scenarios,
dependent drivers will naturally fail to probe or initialise. System
administrators who apply denylists are already expected to understand the
hardware and software dependencies of the modules they are explicitly
disabling.

I understand your hesitation regarding added complexity. However, with the
fast-path optimisation suggested by Sami (which bypassing the scan entirely
if the parameter is unused), the overhead is essentially zero. I believe
bridging the logical gap between how we treat =m and =y modules is well
worth that minimal footprint.


Kind regards,
-- 
Aaron Tomlin
