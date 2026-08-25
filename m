Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013018.outbound.protection.outlook.com [40.107.201.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBE62ED843;
	Tue, 25 Aug 2026 05:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787635677; cv=fail; b=KjxKk+fSL3DmX2bxLep1xZC+jQaOkmg1710i/dYbHoAaQ4aod4X7SARc6g24BuTY0FlhZEKeJ4XjcPKfP3rVN3/YsB2bS153BHKiTYkEy4/qG6R4fwDgypRmJQBBp3j4+PgQZMA7Piypmi4fQiFu4z8be+aEG363snKi10M1v+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787635677; c=relaxed/simple;
	bh=DeCFvXXeIWWb8zeFSLJUt8zIlK8p0z6VCqnHxvf7ZJw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d+bz0P+5e55syGUh8rAtr0/M83u5p+Pf+oLfqxTwvYtxoxHrjGkkoNY36tfFLRL9Ylm+ukf5q3YIs+sYFdeE2IWlBDb2HhrbJ5PMbpv24FsnzyElAIo3h+NM9jGgxGqV5ps5iNFi/qYKF49UvZ3sIuGW+t8guPeR5Njwg6qvQkY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=m0Xn+tz0; arc=fail smtp.client-ip=40.107.201.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="m0Xn+tz0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xb1tNRb59ZKzuXaQnTtZd+uJ6+ET6YoydetjcF5n6objFmhZzRH1pleJja7xxIr6qfsKifoZ0UGyFQ8xSXgWdHhecmNj7pum5nEcE/0D0xBOshaY+f7i8M4zg3e29zNnHE+O+IOwZdiwrF/Jn+Nnq2k9OeXjFxIdFVVbOTkWU3/zf4kohpxuq0oXbCkNfI7E9/OVfIVmxxWOkviOBAvmeEXjMbukPzZaKXB8YzGns3se1cQG2THNb1swX1DhY6l63trfEX9Vioks+0k9yjgKrgMsphoZjWKdhqqtWn4l4XKmWy17SiPXtEWBpeQKMw9/lb2zk0wkjDmlsV6EOvkpwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DeCFvXXeIWWb8zeFSLJUt8zIlK8p0z6VCqnHxvf7ZJw=;
 b=Qen3jrAqYfDZNUAvG77xFWff86mPaVKeM9dbrn+lApMcl7oepssJdbQyFBQAfUM0CAhsi3N2jndlZhm5mgiIW6NXKetnY6TCXhE3jrktBismG3EFXpWEIenDlmbj3kBL+83WiPCse2jIQ0MxHS9uphyWRsAroUwK+A9KgZ64YG1VupZnvyWdN4ZwLfbqdBSI01joF2mS3+ntVkW6LML7bQyONWPDCPEYwRmNz71BNOeQvcvms6OACPqbmy2jWEJyYIixeN59Budb2zvRpjHGbEewS8f9jsRh2+rc4mcH2UKWSu93yv6nSQ1YAL/THpLqpOeIV7NW3GZyXFyOQ/87AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DeCFvXXeIWWb8zeFSLJUt8zIlK8p0z6VCqnHxvf7ZJw=;
 b=m0Xn+tz0RRjzEzvVTELbVq+liOQ3pScoXHBCrXYpTkFUXg4d3ADTXvEmlBMsZpUssJtMkDNKeAOH+0zXC1KQF9z0a9UK2vEbZQk0DU9BAB+uxzBGF+keUzsNX27MBko+Y1ewWP6jFgTvLw6giCyfMZJArHm93eMoPZ9VZiPiyfs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by CH3PR12MB8755.namprd12.prod.outlook.com (2603:10b6:610:17e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 05:27:52 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0360.005; Tue, 25 Aug 2026
 05:27:52 +0000
Message-ID: <7b4281d4-5b10-461d-b914-38367f8120be@amd.com>
Date: Tue, 25 Aug 2026 07:27:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] microblaze: fix signal handling and the ABI
 argument home area
To: Michael Eager <eager@eagercon.com>, Waldemar Brodkorb <wbx@openadk.org>,
 Ramin Moussavi <ramin.moussavi@yacoub.de>
Cc: Michal Simek <monstr@monstr.eu>, linux-kernel@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
 Sam Price <thesamprice@gmail.com>, Neal Frager <neal.frager@amd.com>
References: <20260821151809.1233057-1-ramin.moussavi@yacoub.de>
 <aoyFBUZ8MT4-lWTL@waldemar-brodkorb.de>
 <0179b3cd-d6a9-41be-bf16-2772e27ce16b@eagercon.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <0179b3cd-d6a9-41be-bf16-2772e27ce16b@eagercon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0286.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::21) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|CH3PR12MB8755:EE_
X-MS-Office365-Filtering-Correlation-Id: b64dac9c-bb27-459e-78db-08df02699c4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|10067099003|6133799003|3023799007|18002099003|22082099003|4143699003|11063799006|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info:
	yGnbuLCO+IQ/Tm/okz3x/nM9oVeL0aO9A5Yd/cXQMK/ko+4MPiHc24WOwthDRXee3hfbkV1+gGLUuy5nWJLmBzKQc70Iu0z3BzLUcwLsYTKpBtx+wlbL1NvGuKgAqrGQnXj6mrdZpD3M+qrZvnmjr6oQ2kiZ9ngWDZzCWrXfz/YDjqc+t5jYdtmJL9iRMouJetebeaVg1vKQymlC8znOY+PmOXOjLqUHzwOL1hrmcuyqxJmhQngeO9ezGv2V6kaaBIPgy3MFizQ+o85iV5gVHPIL33r/O3Fzl4T3VlDrh9OoRJ6dryMr2bbckw13fv+GpcfRZg7Tb9J6DV5r+hYlycRbjPowpre1vPAYWZZ2AHA9/BlzR0hHT7rE1yLiyj8/aucuX2Kp7Hwil/DkV04IjGQEHtNWJintmwWMvS/70mRnBYtY8br4N+H4D8nVB/NVbV2O+NyCToAH8mi59aNRxkBsAaSRQDhntk2Aw8zIlJ6cSWWanidQTQkXGQ4dnyZ5z3p6LjU15SB6LOiOpMkf4HS0oD9EmTVUa9avEUJjKdXUcH8gYLeAvgu/u6rbWKq+UTmF+UQ3wNbm3FXoN4E6JRuWliO1daT32BgADLPuWRzjeTTgdbpaKOl9HdSCp2ee6/JUIHUzgJL2tHxCmifp9OvGkVQ/XcKvUWdvX0iDMEY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV5PR12MB9779.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(6133799003)(3023799007)(18002099003)(22082099003)(4143699003)(11063799006)(5023799004)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Yk41MlNFK0ZrWDB2YnpkbHh6Z1U4OUF4RVRPZFdQWEk3aGMrOU9XOWYvMVlE?=
 =?utf-8?B?VzVhMU5FYW9kV3FpWFdwZVpYc2hVVUdmVE1QOUtabjA1NGNaT1pUM1U3SU01?=
 =?utf-8?B?UWpNQjJ5WnBOODhxVXdGQ21WTFJnVUMrRTcwY1Y3YUhxLzdOTGcwRVllSUU0?=
 =?utf-8?B?M2NKUU55K1BBam1KdUlFWHNuMzNLY3Z2d28veGF3TkFHYWpudVh2NmNkQ1RD?=
 =?utf-8?B?d1lKektmSlZ5VXI2SDczZXFxU1dGYmFLUzhJY1JaaDIxM3g0aVBERE4yUXBt?=
 =?utf-8?B?V2VNNnJ3YnJJZ1VNM0gwRGpneEc1akxTZGhvdHM4R3VwRUtQQk1RMXIrdEsw?=
 =?utf-8?B?Qnp6TkdiUlc2RkU5b084UWdlRmZWaFdPTWZhWDlOK0FmWWZoQ01Lc2lNMkQx?=
 =?utf-8?B?Z05Ick96eWtwNFJReFQ5Q0RYbEs4eXBHUFF4clJPcHJLMjdSYkNMWDQ0djM5?=
 =?utf-8?B?TFZIMXJ4Mm4xaU9UUmVOL3JKWEFwYk5mcXFpVU4xYXJQeGN1dTFOY0lvQlB6?=
 =?utf-8?B?c0JtbVZIN2hDcnpqZnFzcTlzOEFwSkdEbEtvaVpUdThFVXFaa0M2VVZUSGlj?=
 =?utf-8?B?dFdaMlpZNmgwenl5VDgrTWJ0WHg3dUJWT0dTM0RQNHBPbHRvMWhHT0pEUXp2?=
 =?utf-8?B?S0NKOU1Ob2lRMHNoTjl6NFdTMUkzWjdMaUFQa1JJcC9qTDhmZzZ5S05MSG5v?=
 =?utf-8?B?V3Q2aWkwUGZaaC9lQ2xDUUduYU5jemlzY251Ynp1U21FU0c4cGtPelV3QlQ4?=
 =?utf-8?B?djBOa0xlcFRvMElMTjFCazVOMS9DVktXTWdxRUl5cnFkR2pEMklFbVkyckdL?=
 =?utf-8?B?QkRJc3VnQmlRZVUrL2xBZEVDYW9DTjVoWSs1Mm5iYUlDbEVhQnFBN3ZoTGx3?=
 =?utf-8?B?WmNGNTZ2VHN2R3V2Rnk2ZzI1S2s4NFQ1WU9vaWR3WWppTXpMN1hZNGhrMXpG?=
 =?utf-8?B?S0hOVkluby8rWUlEWlR5bVE5bzZFSFJtNXJtb2ZYSjRVU1dyRi9JcmV0Qkh3?=
 =?utf-8?B?TWVTZ3VZS3hFYmc5cTBHQk55dFlmcWdRME42ZTJ0b3dMZ1RLUXE3aVVuV1Vu?=
 =?utf-8?B?aVdud05FSXR1ODVMT3hieUZiOXgyOW9VQWtFSzlDRDRkWG9EWlpGTWRURkdE?=
 =?utf-8?B?MUJXU0k4RmlpYk1KN2ZxdzFkU08xR0FIdkYwdmgxK3ZibFh5dWlIckxNeTQ2?=
 =?utf-8?B?UTdBb1Y0R0laMGd4RGhtOVpscTZGMUZ4ZTl0NXhRc2lqZWxtRW1iRzlpSVZj?=
 =?utf-8?B?bGxkVnJxTnJlM2lBTXlaMFFZWFkrcGJZUmJVU0V5TEtabjcyNEFXSU5ONkwv?=
 =?utf-8?B?U1hlNmttQnZaMk8rcWovZDRlOWFHcGdIeWdXNU5Bc1FRSDNZVWFjUDNPOFJz?=
 =?utf-8?B?K3h2ZlYrQUV2YnZlb1RuQXJnMTlVV0NzUnUrMWxtcW4rbURaQW81NFphNWpM?=
 =?utf-8?B?a0hjbys0NnpIaFhRN1lFOVJGWDZZVFJCU2U4cXBLSzMwZ21BczlCUW5XVmVl?=
 =?utf-8?B?bDMzQzJNNnJWb0Zpd3o2WkVXdzRUdSs1elFKeHhXVEZqV0h2MUc0Q3owcGFH?=
 =?utf-8?B?Q3lWT3lwOU1QZEVPTmREQlFCTDZmcStMVXpTWDVwckZuc0kzTnZDV2I4YVdM?=
 =?utf-8?B?aEpaT3EvL241akFKQVhTYUJTMUo0NHpiY1NCRHByQUozMjdwRnRoOHpuaEsy?=
 =?utf-8?B?cG1kT2R6T3hwS2IzVkkybXNkMXVXc3JqNGQ1Q1ByUUQ2bGl1NUVpNFpaV2Vy?=
 =?utf-8?B?eVEzeVlNZnVnclY3Tm9xaXFvcUpTQzhGY0pHeDhWcENtQnZoUEVmdDZwdHhz?=
 =?utf-8?B?SERNRmp3bXBtczhiVmovdTNXZy9NNVg5MDhoYk9OQk1Mb2NJbitESVZLWUtF?=
 =?utf-8?B?ekk4dkpITWlnQXdGRkE3bHM2cStONG1lNFdpQ1E3d21oQitiWFVHc0NnVUcy?=
 =?utf-8?B?S2pVV1c0clRsaFhnVTFsT1RYK0VKbXZNLzZVaGhDc1M4MXllS2ZaUGhuVWNR?=
 =?utf-8?B?TnA5S3grTS9PeWs5MkRIQ2QxN2NIdUEyc1h4Y1ZiSGFUMDRnNldCbjBRSjNH?=
 =?utf-8?B?WTRuemQ5cmRyQ2RNYUFDN0FBZkRrU2RCbWVqUXRDMXR0czRrWHRERWdBbjlo?=
 =?utf-8?B?d09ZS2RwMTNxTk81cm1WREdzV2NVQmpqWG5wTFdyQlFEcFNJK3lKQkYyNUNs?=
 =?utf-8?B?V0RnMVFuLzJETEErcEtDTGNsbWxzc1NOaHVSK0ZKa2p6UElSKytaK0hYRFR4?=
 =?utf-8?B?bFNrekpkekgycVo3dlVQMHpiN25CNEExQVQ3YkFUMU4zZmprUHp4bCt5SXZr?=
 =?utf-8?B?SXJCQWZJNXZOdU0wVnpyVmg4QlNWYThZV0Y4ZmZ0WDBJZGd5TUNPUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b64dac9c-bb27-459e-78db-08df02699c4d
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 05:27:52.7867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sKcZDuZJ7ZSYNOt1YJf2AJNT7bNZD4fbsqN5baBJZuBekQmtg+fqs/pSS6X4yI0v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8755



On 8/24/26 21:57, Michael Eager wrote:
> On 8/24/26 10:53 AM, Waldemar Brodkorb wrote:
>> Hi Ramin, Hi all,
>> Ramin Moussavi wrote,
>>
>>> Five fixes to the microblaze signal-delivery path, found while bringing the
>>> uClibc-ng NPTL test suite up on microblazeel under qemu-system
>>> (petalogix-s3adsp1800).
>>>
>>> Patch 1 wires up sigaltstack(), which is routed to sys_ni_syscall even
>>> though the signal code fully supports an alternate stack; microblaze is the
>>> only architecture leaving it unimplemented.
>>>
>>> Patch 2 reserves the ABI argument home area at the top of the signal frame.
>>> A handler may store its incoming arguments r5..r10 into [r1+4]..[r1+24], and
>>> r1 points at struct rt_sigframe on entry, so those stores land in
>>> siginfo/ucontext and corrupt the signal state.
>>>
>>> Patch 3 stops ret_from_trap from writing r3/r4 back into the saved pt_regs
>>> after sys_rt_sigreturn() has restored the full register set.  Only r4 is
>>> actually lost -- the usual *rval_p = regs->r3 idiom carries r3, but a C
>>> function has no second return value for r4 -- which corrupts any register
>>> live across a signal, e.g. the address held in an lwx/swx CAS loop.
>>>
>>> Patch 4 restores the same reservation in the kernel's own frames.  The ABI
>>> rule applies to the kernel's asm-to-C calls too: with r1 at the frame base a
>>> callee may spill over the saved registers, and PT_R1 is the first slot it
>>> hits.  This was latent until GCC 15 changed register allocation
>>> (3b9b8d6cfdf5, "ira: Scale save/restore costs of callee save registers with
>>> block frequency"); a kernel built with gcc >= 15 without the
>>> TARGET_CALLEE_SAVE_COST workaround dies on init's first syscall.  The kernel
>>> had this reservation until 2011, when commit 6e83557c38b4 removed it as
>>> suspected v850 leftovers -- this brings it back, with 28 bytes rather than
>>> the historic 24, which was one word short.
>>>
>>> Patch 5 is Sam Price's: MSR is not round-tripped through the signal frame,
>>> so the interrupted carry flag is lost across signal delivery -- the same
>>> failure class as patch 3, through a different register.
>>>
>>> Testing: v7.2 built with gcc 16.2.0, which carries no
>>> TARGET_CALLEE_SAVE_COST workaround and so reproduces the allocator change,
>>> userspace built with the same compiler.  The uClibc-ng test suite reports
>>> 759 passed, 0 failed, 7 skipped, unchanged from a known-good reference
>>> kernel; without patch 4 the same kernel panics on init's first syscall.
>>> checkpatch --strict is clean on all five.
>>>
>>> Tooling, per Documentation/process/generated-content.rst: patches 1-4 were
>>> written with the help of an AI coding assistant (Claude, claude-opus-5) over
>>> several sessions and carry an Assisted-by tag; patch 5 is Sam's, included
>>> unchanged apart from a blank line checkpatch wanted.  The assistant was used
>>> throughout -- reading the microblaze ABI out of the gcc backend, finding the
>>> gcc change that made the bug visible, drafting the patches and changelogs,
>>> and driving the qemu test runs.  Everything was reviewed and tested before
>>> sending, and the numbers above come from real runs.  Two mistakes it made
>>> were caught that way and are worth naming: patch 4 first used 32 bytes with
>>> an alignment argument that does not hold (STACK_BOUNDARY is 32 bits, so 28
>>> needs no rounding), and an early version of patch 2 was folded into patch 4,
>>> which made the test suite blame the wrong change.
>>>
>>> Changes since v2 [1]:
>>>    - From: now matches Signed-off-by, and the series is sent standalone
>>>      rather than as a reply to the previous version (both requested by
>>>      Michal).
>>>    - Rebased onto v7.2.
>>>    - Added patches 3, 4 and 5.  Patch 3 was previously sent standalone on
>>>      27 July 2026.
>>>    - Patches 1 and 2 are unchanged.
>>>
>>> [1] https://lore.kernel.org/all/cover.1780647609.git.lordrasmus@gmail.com/
>>
>> Series successfully tested in Qemu System Emulation (little and big endian)
>> and on Numato Mimas A7 Mini.
>> Also works fine on 6.18.x kernels.
>>
>> You can add:
>> Tested-by: Waldemar Brodkorb <wbx@openadk.org>
>>
>> best regards
>>   Waldemar

I will look at it after rc1 is tagged.

Thanks,
Michal


