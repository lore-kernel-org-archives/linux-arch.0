Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011035.outbound.protection.outlook.com [52.101.57.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E15390229;
	Mon,  6 Apr 2026 18:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775498477; cv=fail; b=e/inv+ZZQN0/DtXxpKKwi+6MEjlaexdymWnTzUCgo8gzJJBR9OkxGXmpDxP13OxWey9AanGUyyV5UjkcTyWzLzLVAhznGJF4xSN5RWULr8d3HQlIgY5R075PMehR15HMAJN0Ddf8Ss2Aol2vQ6x/iZkNnOqgTXVOCSHLoARjXjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775498477; c=relaxed/simple;
	bh=QCXHy6OgjfO7tdd8JTkeHWxtJf4YXu08XLzqJDCXLcw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=REHJmWS7P75YTGNRglkyaGDFMoUoVo04zIu6DT2fGeO7+krad/ew+pk6pTmxkkehhuE2dfVnAdr4966MNPoAj0Pc0b6rznsJDYXZxohAXRdJWRjks4Spyeimccnr8zWXl0gCA1/O25VXPVmiHPV61oUeoNjZaRC2V/6/keaYqEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PbDYu3ks; arc=fail smtp.client-ip=52.101.57.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PbDYu3ks"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SOa0aqqxSpGDOWxha+2Fv+ZWI2+5YN8JtZpDghaydYivrXxbMiFUy37amWJhzyG1Na/B4MltwMcNeCxYhGVMpBFzt7GzKQhNX4w23btsrVHtbDYcBE2DgsetRpuboHW5oPpv0BDhnEsAJgDogU2CBItwZO01iRZeMHbNB9o7B7kUZKjtoorFRkvG1bSM5OMl5Fkn3I7W47P1SgasROvriyGdUOaEy6RGtfutGEwiAYaGnxkxp7qtJT/UDnnQrhOZA3AFqbK2GAzASntutL92NInSOYwB676ZTa706CRCRq6dhGAzVTjEJQEr2rpBmSHiFxE4yWevncZMmnDXpY0Jsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QG5of/48IkWW7oD+j5u6E0avq2z9ZLdATxQFBKxw00o=;
 b=FcumkyUTL1YEQHI8o8QTcHDuYnZSLSHoZM4V8TKzong1mVd69Bt2ihq5uYndcE9BR0YXqx+zFR1uWrUlDkuE9n4cjiR1B5x01NjhR+E2yYizr6GS3q1vynCnrTmTI6cnd0ENrv52wd2ps/1VmWikVXeiK28T0Iq33FbXm0h/aAJRE3paL9YpKyr5u3IqthiuIR9ozz3amOeJLz6kMpuWf+pYCzLLJ+23y1Uh5TnEMd4DGRdHMacF3Lq6NU9QvwSq8RJco+VOAStZIvri53/uik2RM6NrYo98Mp9coS1KKVHdAVm3JVPgCxuIaOHMh7oj+k8u7m45WwRJ2EY8EEsPQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QG5of/48IkWW7oD+j5u6E0avq2z9ZLdATxQFBKxw00o=;
 b=PbDYu3ksYZFRGNB+QbVSGXzIdsCT7tQ1fhe05XqRnwnIJPomSh15gPiWNFFGWJ4OfDr87Z8mYxA7E/KUYCKVGmStmRTJ1B5njvF4xvrq2R6fcwoH6QcQQNxRB2t0a8vBj4RF6MlX3JgH82YlKdxGhGPbh0e2h8/gU6zPe8BCnznC9mQkP85mJvYNVpQCBCPqUmo52B/i4e/B0JVarvoFas2Azx6rcUn4PM89QSkUwAVYjTZCqFqJLX2iMk1NFqlCl3ORjf2NvBdgI7wvvgfChZNYgDHggtbvCLIomxlKmp1tdIcfyPKOfPmTxfuJBQzSAckLLbVGlBPzDbX8FUKhsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 DS2PR12MB9638.namprd12.prod.outlook.com (2603:10b6:8:27b::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17; Mon, 6 Apr 2026 18:01:02 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9769.014; Mon, 6 Apr 2026
 18:01:02 +0000
Message-ID: <e430a8c1-2dbc-4433-a9fd-976740e275d5@nvidia.com>
Date: Mon, 6 Apr 2026 14:01:00 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] rust: sync: generic memory barriers
To: Gary Guo <gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Mark Rutland <mark.rutland@arm.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
 Andrea Parri <parri.andrea@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>,
 Luc Maranget <luc.maranget@inria.fr>, "Paul E. McKenney"
 <paulmck@kernel.org>, Akira Yokosawa <akiyks@gmail.com>,
 Daniel Lustig <dlustig@nvidia.com>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 lkmm@lists.linux.dev, Alexandre Courbot <acourbot@nvidia.com>,
 John Hubbard <jhubbard@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Eliot Courtney <ecourtney@nvidia.com>, Alistair Popple <apopple@nvidia.com>
References: <20260402152443.1059634-2-gary@kernel.org>
 <20260402152443.1059634-4-gary@kernel.org>
 <620eaaf3-0569-4633-afd9-74ec18dccbf8@nvidia.com>
 <DHJ2YICMLZBL.1GJR8TQHG4A8C@garyguo.net>
 <00c387ea-d49b-40ca-bd82-89dbed6ef3cd@nvidia.com>
 <DHKDNVH3DGV5.TP0X6143JHG0@garyguo.net>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <DHKDNVH3DGV5.TP0X6143JHG0@garyguo.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P221CA0040.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:5b5::15) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|DS2PR12MB9638:EE_
X-MS-Office365-Filtering-Correlation-Id: d962c50d-497e-4138-4914-08de94067728
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	CBIYKqqtIWF2+ilmgTfO9kGJWCYK6gsCDIBcAI6lSv5M1x4kWyvapnEWuCHXXW+BLDxinAyhVbAXDXFk46oMC2E2BNqcxKtTDZAfaZ37O+aCcsohU1UVyPz87fnT+wjyWiAxILuYOUC2ZUSkp/OZ8OGS0kNa6t24NMr3XoVS9ZEVHYvuevuSe0v2DsYBhkG4LjzZlGIg7mR6u4NHUbJdkYh+qP3TnD6MU5/9RpzviAFT5sndqNoL+gL+V8UVwU9BmsPEcThUb0ff2PXQljVdYTWhcuv+vEXzXEadDUSm06vgVZmSTd7ILNCM9Lwz945HQwRtEYZF6+7fq2U73dwBcFNJvuZTri52/oHByS4iSflC+mSUhPpOkvDNagQG/E1lyhC2n7rD9erwzsF4D0SY81HgNFAZP77nnrspOI7uLDB9o/FzKFdJWQr/WCvzTtg+14RkYchMcLiQ+Krfy3mGc4dKxQzbVxCLVSrMXrcNzIIQwQDV8djcJR/ENIFXSouIkadvWqBBM7qJRope37kW2cuSPRVAUVzKm+jFswK+h483NZiYCxo84roBLXwX1/YSJnDEtd6Z4ejX9gxcQvO2JTFfuBWToJ6J62UuSkB5NUNYvUQ+DMqxU+6hv5tW8aVJOhh8L4nnjQLddMTICig3b9MYMhL5e0SjVyd8YCkBpo04lNMh5RhRhrtxOgL3NKeOkp0+ZDmTq3Vm59FcNv1QKh6YRKlGhpL95WtiJojGxNADv03ND9l+WB+vttdj6Q9SKj2pbJKr1UN+QidZMyDPOA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SUZHa3YvSUdranpzVWU2bFdEcjFleTdtVmJ0STkvZTRlTVUyQjdmYkJOKzhm?=
 =?utf-8?B?SXpEN0tQT1FXa1h1ZVA1dWtDcTZ1MStQQW1XV0VzSW9NRGRGdjlLRENsRDZT?=
 =?utf-8?B?Q2JuNk5QWldsVFlhQ1QzRlg3aXU2NmFYRWxRalduNHFNMk9EaitKRnplY2tX?=
 =?utf-8?B?MFBKOUFDekgzSWo2cXI2LzlLVXBPcW1kaE9RbDMzZU95cm5zdnRNaHFqYjY1?=
 =?utf-8?B?TDZnSGpwdkd1c1RmVUxWUDVkb2JpQThlUkRwYmRpL3N5NnZvMzY1aWpnRkxK?=
 =?utf-8?B?dzF2NTFOaHY0TFkrUFU3OHFRcWpJZGhIblVmUDVwK1NCRmswUHp1bWE3YzZS?=
 =?utf-8?B?ZkFiVVR3bE9VWjBKRTlSYVpqR3lONnlrTzk3NEVGNVIwZ09HbmN0aGsyK0J6?=
 =?utf-8?B?SHBBVlVmWXRNZ0NUOUcwTkVaWkx3WEFRUFUybVU5a0tLVXN1R0tjeG5uSlFG?=
 =?utf-8?B?M2RaMDRtNWlQTlV0QTNxek5YazROTUpFTU82bTVkV3JraGlxZ2U2aGxyRHph?=
 =?utf-8?B?ei8zYXJVTHU0d0FDTlR6SjgrdHFRRkNYc2xqNVNJdkdxc3UzdGxiM2hSWi9M?=
 =?utf-8?B?TFNOZ2IyT2hjeUtkelN2WUJPREVkNElyTkViUFhNZmtmU1RHNDNmbm1jK2J4?=
 =?utf-8?B?UUVLL1BLbGJjRTNvQ25OaFAybGR2OFhvajdScDh5KzBDNEFNL0pGN3R5VXVw?=
 =?utf-8?B?OGxOWkoxNE1WVWtNMS80eFRUNHFtcm1UVHUzMEdKYmYxYVg2eFRNRnBEcGEx?=
 =?utf-8?B?cnE0Tk9UQ05sTVlrajdUN0N0aFkxZ05RS3phREM1YmJBb00zbnQ3Lzh0Q3Rr?=
 =?utf-8?B?Sis1MldhTHBORk5iSGN6M1N0RzBISFNIV2U2QkdHNmF4bVN3NmIvRmd4T3hU?=
 =?utf-8?B?cm53U2tUMndSOHhESGZuMTYvZmxnd0M5eWJ5NUlLQzdITXJndWdaOEpkWUUw?=
 =?utf-8?B?UmgvWE1HanUxa20zV2NUR2E3NVBmZ2t4OE1ZdEZqc0RrSCtHekROMG0xR2xs?=
 =?utf-8?B?L0RMSHJ2NnZoUURlNTVXT0R4ZlRyVnRWWWtrSmdrMGVNZWREdkoxMFU3V3RI?=
 =?utf-8?B?SE5zZ3d3TzA3aDVWQVFBVmR5T1E1MytiRXpETFVDdThqWWZsUm5EVEdWdys5?=
 =?utf-8?B?VG9QWHUrL1BhRmJUZloyKzg3SzNiYVJFWWhEMkRGNWR4RU53a1BWdzlGdTA5?=
 =?utf-8?B?akxiOHowY3d1Q1lhWFpJUlpxUVh2UkttN2NEeU1BR1F0OCtoc0hKZ3A4ZUVi?=
 =?utf-8?B?b1dLelcwNGNwMDhPSFZ3SmFIU210NUR5TUgyWk5GZGF0S1FhQ09UOUdHY1FE?=
 =?utf-8?B?WERHSkJEU3pmQk45VG92YVJhR1dxUHdxU3lSZGswK1pBVm4rb0hxbDAyRDFP?=
 =?utf-8?B?Ry91bDYvTlNrdElnT1QxazRUTW5CZ0pucjY3Z016RU93NHQ2aWlGK3ZhaDBW?=
 =?utf-8?B?WnhZWDliRWJ1bjhNeHRkYllBWXlHUyt6amR3L09ESmJxWlhteXlXU0ZZK2lj?=
 =?utf-8?B?dUk2RTRsVkVVeXFUNlkxdjU2YmlBaGZTUkczdVlZZXd4VTA2T29ZRjJlR1Qv?=
 =?utf-8?B?WVJ1R1NJaGI4WlE1VG9kSjdvRGJoVlU3Nlp3bnA4NUdRSXRNdUtrckw3TzN2?=
 =?utf-8?B?WGJ5Rng2djVvQ2M2Y0V0Rnl6OVpDTFZBYy8ybkZRaGpOQytVbVViVzF4cm5n?=
 =?utf-8?B?VVF4dkZtZW95Z2ZOQkdxNkZnOVRNbW5uNjRSZmN4eUx2RzVsN2JIOW8xbTVF?=
 =?utf-8?B?WEFKUDEvekUvK3pmRGtSeERDUFNhaktiZ3BMbm1jaFFDTHdrcklnWFl0dk5J?=
 =?utf-8?B?M0FtYTMwY2l3SFp1MHZ5OEVBS215M1paRnRuNUYzUWxSd3NlZnpuTjhhVlk5?=
 =?utf-8?B?blVvT3JWYzl6VzJic1lwbk44enF5RmlRTXBoNFA2YnZSWmg1bzhYYTJwczVO?=
 =?utf-8?B?SEwxV0tyamNxam1JT3ArTHJlOElSdENSclBCSEtWdlBGeHVsNTdrLzZVeVht?=
 =?utf-8?B?UTlJeGk2VmlEZHlOc2M1MWRUNGQ1L1dURXF0dERncUtrZE9WeTZvdFI3T3Rt?=
 =?utf-8?B?Rk11dytOdzR6c3IrOXFCZjJQUldxY0VEem8zLzNNRGlQYWdUMDFOMWJUd0U5?=
 =?utf-8?B?L0RqV0tHRGd6TGtqTFg2ckhQTFcyekdrSlBmY3RRNFNqUTdjTU5kUFdxb2Jo?=
 =?utf-8?B?YmhHYlhYVmVuem0vVllXV09rUktUa1NNb2JiNk50YlNuWVMzT3NHa1cvYjhL?=
 =?utf-8?B?enJneFRySlBsTWhkdWRNU2RyTkJNamZKRHNoS1hsVkFMMHhTM1RwVE9HVG5E?=
 =?utf-8?B?UTRnZlRnMEdiQmtMOUFSTFpCbDRMVEtjdStQVXhwTnZKOHk2R01HQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d962c50d-497e-4138-4914-08de94067728
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 18:01:02.5767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eOd7OQ/Le5SrLdfUwHMAfBjqVo9EV6oP2uxtS/Le+jKvYwijglLqByjfw4qukbboAvRSTTUEL6T+Wj5l7SBqHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9638



On 4/4/2026 8:43 AM, Gary Guo wrote:
> On Fri Apr 3, 2026 at 10:33 PM BST, Joel Fernandes wrote:
>>
>>
>> On 4/2/2026 8:07 PM, Gary Guo wrote:
>>> On Thu Apr 2, 2026 at 10:49 PM BST, Joel Fernandes wrote:
>>
>> [...]
>>
>>>> See also in Documentation/memory-barriers.txt, ACQUIRE and RELEASE are defined as being
>>>> tied to specific memory operations.
>>>
>>> That's what we have today, hence the implementation upgrades them to full memory
>>> barriers. But ACQUIRE and RELEASE orderings doesn't *need* to be tied to
>>> specific memory operations and they can still make conceptual sense as barriers.
>>>
>>> C11 memory model defines Acquire and Release fences, and it looks to me it's
>>> relatively easy to add it to LKMM. I was playing with Herd7 and I think I've got
>>> it working, see the attached diff.
>>>
>>> Another thing that I'd like to note is that in all architectures that we have
>>> today except ARM and PARISC, the smp_load_acquire and smp_store_release are
>>> actually implemented as READ_ONCE + ACQUIRE barrier and RELEASE barrier +
>>> WRITE_ONCE. I'm planning to propose C API and corresponding memory model change
>>> too, but I want to gather some more concrete numbers (the performance benefit of
>>> having dma_mb_acquire/dma_mb_release compared to full dma_mb) before proposing so.
>>>
>>> Note that marked dma_load_acquire/dma_store_release (and their mandatory
>>> versions) don't make too much sense, as AFAIK no architectures have instructions
>>> for them so you're implementing these as fence instructions anyway.
>>
>> Ah, so you're proposing new memory barrier types that don't exist anywhere
>> in the kernel yet. I thought you were just wrapping existing ones so it got
>> a bit confusing.
> 
> Well, I am not proposing new memory barrier types in this change, hence I
> mentioned that these are annotations about intention and documentation and not
> about their *semantics* currently. Perhaps I didn't phrase this clear enough?
> 
> How about change the wording in documentation like this:
> 
>     /// `Acquire` is a full memory barrier, but caller indicates that it only
>     /// uses it to provide LOAD->{LOAD,STORE} ordering. 
> 
> or do you think even that is too much?

You are conflating lots of terms here, a "full memory barrier" is much stronger,
has stronger cumulativity properties etc (even stronger than Acquire/Release).

And I do think it is too much, because you are using the name of existing memory
barrier types (Acquire/Release) with specific definition, but saying "This is an
acquire lets pretend its a full memory barrier".  So you are in effect defining
new types IMO.

> 
>>
>> My suggestion: fix the nova-core issue in patch 3 using dma_mb() directly,
>> without the new barrier types. Adding a new standalone release/acquire
>> fence semantic to the kernel is something that will need broad consensus
>> from the LKMM maintainers IMO, independent of this series. It's a bigger
>> conversation that could delay your nova bug fix.
> 
> Something like this?
> 
>     // TODO: Replace with `dma_mb(Release)` when it's available.
>     dma_mb(Full);
> 
> Or not even mentioning that? I really like the Acquire/Release because they
> serve themselves a documentation on why the barrier is there to exist.

Sure that's certainly better, once the Release stuff that you're sort of
re-defining is accepted by LKMM maintainers and others, it can be replaced for
sure. But I wouldn't even want to mention a comment until this type of
"Standalone Release" is something everyone (LKMM reviewers) agree with and is
upstream-bound.  Just split the patch series into "Bug fix" and "New memory
barrier things".

> 
> When I read a full barrier, I always need to think whether the code really
> relies on STORE->LOAD ordering or a weaker ordering that could be used.
> There's a conventional wisdom in userspace C/Rust where when you see seq_cst,
> 99% of the time it's wrong.
> 
>>
>> Once smp_mb_release() / smp_mb_acquire() (or the DMA equivalents) land
>> properly, updating nova to use them will be trivial. But the correctness of
>> the fix shouldn't depend on semantics that don't exist in the kernel yet,
>> even if they currently degrade to a full barrier.
>>
>> That said, I find the idea genuinely interesting, and thanks for keeping me
>> in the loop. Standalone acquire/release fences that are formally modeled in
>> LKMM and A-cumulative is interesting as you showed in the herd7 code. You
>> would want to update Documentation/memory-barriers.txt too.
> 
> Yeah, there're more works to do on changing the semantics, hence I want to limit
> this to not be about semantics.

My gut feeling is, by calling it a Release (something that already has specific
definition), the marketing of this is probably going to be one of any hurdles.
:) But I'm curious about the take of others on this thread.

thanks,

--
Joel Fernandes

