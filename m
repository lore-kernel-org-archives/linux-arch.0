Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021103.outbound.protection.outlook.com [40.107.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E357211A09;
	Tue, 13 Oct 2026 13:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.192.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791896697; cv=fail; b=POsgHW7oBsiH9zqy6KrHw+jCZhlgbQ6jTYFFKkSiQdMM7oQ7gCYI+FdguR8ko04i/AS3K4yhQU7fkOM80Y5m3j+h6hWE6nc3o2Kh7z6szGXQQtt2b1gvLNbZJ6wBl49LAYh3r3VGx2IxYdzWLkFvIt5sUAF54rkA+k/PGQ3V6CM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791896697; c=relaxed/simple;
	bh=iJQByb/FGtIvqZEowcW2Ol8T4c8MLXForMorpqwwQUw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HJ+xYGm3m2G+XQqvL05n6xHt5i4qKw2HVhSRSVvHKw96VB+eqPQJc/c9Vjt7W95pnRToS9pUCt8jVpjdihz8g0yDsYYv65s0cXTZGjMno6ZXyKZR33St2kYzTTJ6c0SWNCeO1b7YnSEPQiM5VJA7QXzseTYftLsvRdw/FSdyUfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=XxIL5EHq; arc=fail smtp.client-ip=40.107.192.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="XxIL5EHq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qCC3Ujuv6lZnjDCuphaNQCnnaumL32SSRrAUUxZKyXF3pI5zjG6+qwwn2qdj+lfzKCwc6RRwB7MHHhVLIanZveGRA5ccpcbcoMpNsJ6fu5Nt85W1SiHlD12Tfl7BtFfFihfeb65l/Oi1v/0/tn6/gaiy7/3eZDc4kRiopm45u8qn61NmG0hDDx/0q6Bh1lMNyyDCuA3dLLyZ1Y3sF05/sq6cJc1bRWkTfcI4aVk1NzW3M6S5trFcidLDHr62g7TFZ3c/5UJGbPKZ/GNJSVKjibItI8I7ccaHFyOwrz3I6PsUxwBHRfWO0dZAOvJJ6p1u9OLeB/4OS1z4eLyevotHqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ppw/9csHXW4Hf416blW0GQFBukeiGeB7uSSv0wd2VMg=;
 b=OI3vXV/lJJaaxgzmZ6PHpkguuZccFT2XhlBs0VMUqDzJEaKFMgBWw0cSl6gpznSWchGvtk2+3fwPoDNvXMK7hauN/ISPddlLgTKELcSeebCQQcJ8XmzjqSMtrxSbmTAr30aKJL5EFzOAs9OQQjCEcr5HvK9YVm5OFd/ezc/G+667H0MZibNTjIeZUoFmUM5xWEIWmpso70oOoXEZzPqt9i/EV6FAlzPIdQKBCLZFa74w0sixxTwkFn/iMT2KcyOyNVn3bADXNvtwGl8Cyan9edhdtrNZuB1jgHYvWW+F4a31rT45TCLMj5gvc6BbW+q5d83D05JKwdf/2IIq3bwn7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ppw/9csHXW4Hf416blW0GQFBukeiGeB7uSSv0wd2VMg=;
 b=XxIL5EHqHOpOCJmF64W+driyI2oWqtgEnj1TpXGaNfDvdCVeWOrRgA/PRYQJ4P4vvuObWkZOwRR3vcSpr8p8AElPdBpg4KnyB2zQC62YH4nt6QWUbr2OME2kySuSSDp0rAwNl4AAwVlAzP4jy00bc1WRLi2GvC/FMwS38BorYjCAWLCrr14AgJ788mzQov4sw8lW13WwX2rd24d2K5NxRtk5rgN798SlsVsEHucjQnPyFNcMeyXw0R07oRDnvc5BNB8AzgV8I54W7wrK0JKSiU4D1vjW9rNkInI6f43rwUXXl3YBt5latgq9sxqpppzi1ZK4hcd7mRgfzLfmykh89A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT3PR01MB987975.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1c6::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 13 Oct
 2026 13:04:52 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0522.011; Tue, 13 Oct 2026
 13:04:51 +0000
Message-ID: <ef3fd68d-f35e-4071-9523-0cd14396d860@efficios.com>
Date: Tue, 13 Oct 2026 09:04:50 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 08/15] locking/lockdep: use hazptr to wait for
 dynamic key lookups
To: Boqun Feng <boqun@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Kunwu Chan <kunwu.chan@gmail.com>, paulmck@kernel.org, corbet@lwn.net,
 mingo@redhat.com, frederic@kernel.org, neeraj.upadhyay@kernel.org,
 josh@joshtriplett.org, urezki@gmail.com, dave@stgolabs.net,
 lianux.mm@gmail.com, stern@rowland.harvard.edu, parri.andrea@gmail.com,
 will@kernel.org, peterz@infradead.org, npiggin@gmail.com,
 dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
 akiyks@gmail.com, dlustig@nvidia.com, joelagnelf@nvidia.com,
 skhan@linuxfoundation.org, rdunlap@infradead.org, longman@redhat.com,
 rostedt@goodmis.org, qiang.zhang@linux.dev, brads@mainlining.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 lkmm@lists.linux.dev, linux-doc@vger.kernel.org, rcu@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20261005171529.1378809-1-kunwu.chan@gmail.com>
 <20261005171529.1378809-9-kunwu.chan@gmail.com>
 <as3aMmPdCHCXW6Ci@U-YXDQC754-96.local> <as4ooZSWA2lAIceu@tardis.local>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <as4ooZSWA2lAIceu@tardis.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4P288CA0024.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::25) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YT3PR01MB987975:EE_
X-MS-Office365-Filtering-Correlation-Id: 7199de45-24a2-4eeb-9a65-08df292a914f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|56012099006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	I1byIJCGpjxpVXbBr6X8z0v8cmhYOqApp6OjyeMjUzLMP8OQ+d5CrVuM2ABsUN3AAx5WZv6/HrUAnlhMyLwP79Fqb0aGZ0JbUbwmLs65x3YlxJp4UxrG/KGZK34sEe4Yv+4YJwpF6660NFdEE2IiDVPrC7Cq6OALGr2oaLEHiqMdl5lME8xCQ3ABnqv39sVRtph3DvrRLHtOiyz/ducTSGRghivtjl4VTMEKzet1i/+MKzfeKC8Kwy13SXT+pMyffsDfKz/OHfu8Vob85c+FW39Q+p8vgSpaBxaYLq7F8ZYQ+fcRqyPplk2Gkhwon34TvwnmD7YM7G83sLl05A+Sa4W9BLnYr7LlvGWD3TjlTBRfMrc8EDrGOy85XS3hxaTZ69HtpWyfMG5V2bZ0Eja01xsXtqn+e4pbKIO6KF1XfFHUORljijj+auspTGqFzW5FJGABh8HjHhW4AHVVF5o9JPAdbF606gjM5SlYmLnyWkV9zf/WhHZFZWIFrVdHrBYuq9C+zRyH58ylNHGyklrzSLNPpAKnUI/1a43KFgVtlqMDUhhHae/egaIOGsyo37eMeoiE+L1+9CGaTbyqTmOMhmruE/d4zA+wkPaOXpbTEgg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TDB4VGVDSmwxMysyc3BSR2MveDYya0FuU1JMQTNhYVY3Si9YZnhPMSt0YmE2?=
 =?utf-8?B?WkNKY3VxeHUzcnR3Rkt3VEFEZ1VESHliOGUwYVE2cGJtbG5VbEhWbVFNZ1NG?=
 =?utf-8?B?TEdnUTBCdG5XZ1FPeEFrVkJSODlVb0c0MWVhK1ZkT1ltRG9aN1h3aWRWQzZL?=
 =?utf-8?B?ZUJFN1EzTlFISzZ2bHJiWVFPaG5RaXIzMnd5aEZTRER3Y0pvbTVxcDJYaExW?=
 =?utf-8?B?bTNYcWZmbnBnLzVhRmtQOXU2S3hsNE9JUXdvZTVlaCt5Vm1Icnc1VWVFSExo?=
 =?utf-8?B?WG05c3JBeEdsYnoreXUrZW9xMEk4Ym40a1J0MGVTcEtSV1doYVoxUE9yalhH?=
 =?utf-8?B?ZDFsV2FDT2dFcGovM09odzBDM3dXSGpiRVpvRFl3djErWWgzRkh5WEhXUFAw?=
 =?utf-8?B?NWpNMHJoLzFjTlpvUDNHMVloMUQ5d0VPTmlZckJmdU52a0NCaG1ULzRSTXp3?=
 =?utf-8?B?NnBjbHZ4YVp0VzR2MzRtNFBUSk95V3BQcisyQWE4bjlBNXRtOFRJd1Q0QXdp?=
 =?utf-8?B?VWJra01HY0xkVnFlTjF5azdrSGtxcm5nd2w3Zyt1c3hxRG5USFpwbFBZZm53?=
 =?utf-8?B?b3FRNzBmclFBd2VEOEhvOFZoNDRjQk4xNmdPUFJtVFdhYzRUcG45NjRDUGc4?=
 =?utf-8?B?OEdVT1Y1MzE2MFc5Q21jV2tndXdlQlRFSmduQmFUWWo1QXFscENRaDhzOTM3?=
 =?utf-8?B?dVQ0Mndwd2Y1U2loNStPcHFnOHR4UGF3R0c5TDUrc202ZzJDM0JoL2dKc0VK?=
 =?utf-8?B?QXRGUFpGMzBZSml4VTJ1WnkwZGo0KzJNcERKNDBnVWUzS3hkNHFYNS9rTFNU?=
 =?utf-8?B?b2NQZXVVck9aY3VjV3grRG12aDQvVHhDOTI3YTlNNWdFcy96RjR1Wk8yRkR6?=
 =?utf-8?B?YVNlekM1UHhscWRveE5XQk4xZXErQlBadjdxZk9vUldZd3Q0ajNESDdJUFJT?=
 =?utf-8?B?aWVzbkMxa3lvUUJFSXVNUnY2WE1qNk9rNndBSm1VSlArZWRxQm1uME8xZkpi?=
 =?utf-8?B?OE1ZQzVsYWE4TGVUZHlnN2VuUllsWksyWUM4cHE0QVFkeU1mc0ZLNjBldFBD?=
 =?utf-8?B?MXg1RmhlVnRXSi83NkZYVTVhQ1hDRHFRZHZRUHM4OWlIS01YcEdTNWFsWGhD?=
 =?utf-8?B?MnRUVWw4QmRxUU5jZ1VmRFRlNlFuRTdMdGxRTklUOGVKb1BSZnovMlR4WUVs?=
 =?utf-8?B?RkxtMHlpTGpjSFI5T3dJTWZSZ3B1Z1dxUWlsOGlIbitpVmQxeFl2Szg1Mitn?=
 =?utf-8?B?UloyeHd0a0ZESU5iWnN1VktiRUNtZ2VRa1lSRHJETHhtWCtCV1kwS3RQUWRt?=
 =?utf-8?B?RForcXZtR1UrYlBndXRZSFlYRVBxY2lWQXZFL2xERXp1Y1V5TktJeVkvSGxS?=
 =?utf-8?B?cXk5R1UwMS9GdC9hZjlmNjVGZzdBbmdEMDZlWVVuYzdpalFkcmJNdXNqeEU3?=
 =?utf-8?B?M0p1M2ZyREF0ejdEMDY3ZHFDTjdVL1lZcGpiV2h3UkczdjVDS3ZrZmNZRkhZ?=
 =?utf-8?B?c0IyU1dZY1lZSkZwdE9KT08vczI5Q0pib0pCRGgxNWVMTTIzSEthM1hTajdO?=
 =?utf-8?B?Q0QrQXoxbWdVUkdpVHY4ZG9UYmRIWnl0YUxXcFU3MFJpMzkyNStjUlNaTE9W?=
 =?utf-8?B?YkFEV0ZUdGFMZVhGMnB0SGJDeXo2YmdITlRFZGtGcUxGdzRLcUprQlBmZkJX?=
 =?utf-8?B?bTVLRlMwSVR2a01qVGRHTU93MDYvNytKY283VTV6aG93ZnhYYzAxcEpjRlYw?=
 =?utf-8?B?YTZpVktBYXhMNjJhSC85a3FsVzFDUjN2SG9vZWFla2tHUVIzWFRrWUlDa3BE?=
 =?utf-8?B?cnFmbVpXSzNjNERpa0pKMnNlSjhZcTIvempvdFllenlHK0VTRE94Rk0zbzdS?=
 =?utf-8?B?MXZuYUJtUzZYU2o0SDh0QlJSdE1ndkxRK01DcGxDYTlQVytrenAvR1I3QXJ5?=
 =?utf-8?B?bFMvZjRhc1RMWTBKdDk0WTNZWDNBSHY1RDdHVTNaZ2FIemFURDNBY3lybVJH?=
 =?utf-8?B?d2xPNXVuSTdTMVBTNFB2ZldQeTNiK0hVb3poUTUwb3EvbW1iQnI5THlaVzhZ?=
 =?utf-8?B?ZGpzam0xQXBOSEZsM2ZIejlPaHNFbmt3ZW4ycmF1eWdHSVgzTjREaFJ3TUh5?=
 =?utf-8?B?akp6VnZWMW1PbmQ1WXp4Qm8yT3dnVVI2WCtZTGVDdldUclZHWVlwQytPb2RJ?=
 =?utf-8?B?NDJlVWVwMFh3dHlGS0dnZ1ovRVNCTzNUcnFJS3UwZllrbHIzQW5vV3E0RkVs?=
 =?utf-8?B?ZTh5aDg4aHU1Z2ZZSU5SdVdXYTQrekJLVmNhMFVyWTVmNXBuZ1ZNaFZqTE1s?=
 =?utf-8?B?Z3RYenYyYjFnYlp3TjExaEZYMzd1WlJQN0FwaGdSc3lzd0pwd3VFUCt4VEdH?=
 =?utf-8?Q?f7OX2JhGQSR33u8Y=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7199de45-24a2-4eeb-9a65-08df292a914f
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 13:04:51.7621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RG6+KS5/8sqxcPd9N+1hGMSDIzzBc0vBq1qqjcIX+8Bwd+WPcN/2UmhCaw79opLznWXKaVONxO0klNliMpbKHTRjCHkOGlA/JVWqlavg6dk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB987975

On 2026-10-13 08:48, Boqun Feng wrote:
> On Tue, Oct 13, 2026 at 03:40:36PM +0800, Lai Jiangshan wrote:
[...]
>>
>> This breaks the forward-progress argument used by the underlying
>> hazptr implementation: after removing an object from publication,
>> there should not be a continuing stream of new readers acquiring
>> that same object. Here, the bucket is never unpublished.
>>
>> For example, let B be the bucket containing key K:
>>
>>    Updater                    Reader                 Scan kthread
>>    -------                    ------                 ------------
>>    Unlink K from B
>>    hazptr_synchronize(B)
>>                               Acquire B
>>                                                      Observe B;
>>                                                      retain waiter
>>                               Release B
>>                               Acquire B again
>>                                                      Observe B;
>>                                                      retain waiter
>>                               Release B
>>                               ...                    ...
>>
> 
> This is more of an implementation issue,
I agree with Boqun about the point that this is really an implementation
issue.

If we care about forward progress in the scenario of a repeated
address reuse, we just need to wire up a "0/1" low bit phase tag and
make hazptr acquire pick it up and set it within its hazptr slot. This
will ensure forward progress in that scenario. hazptr synchronzie
would therefore flip this phase between 0 and 1, and check that the
pointer it's looking for is not set in the other phase, in alternance,
handling both phases within one synchronize. Indeed, this phase concept
comes from the realm of RCU implementations.

I think that the overall mindset so far has been "RCU does this" and
"Hazard pointers do this" as if those were entirely predefined
mechanisms. I think the way forward is not "one or the other", but
rather to combine the strengths of each of those mechanisms into
something better.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
