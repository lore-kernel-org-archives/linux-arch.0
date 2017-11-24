Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39278 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752926AbdKXIff (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 24 Nov 2017 03:35:35 -0500
Subject: Re: MPK: removing a pkey
References: <0f006ef4-a7b5-c0cf-5f58-d0fd1f911a54@redhat.com>
 <8741e4d6-6ac0-9c07-99f3-95d8d04940b4@suse.cz>
 <813f9736-36dd-b2e5-c850-9f2d5f94514a@redhat.com>
 <f42fe774-bdcc-a509-bb7f-fe709fd28fcb@linux.intel.com>
 <9ec19ff3-86f6-7cfe-1a07-1ab1c5d9882c@redhat.com>
 <d98eb4b8-6e59-513d-fdf8-3395485cb851@linux.intel.com>
 <de93997a-7802-96cf-62e2-e59416e745ca@suse.cz>
 <17831167-7142-d42a-c7a0-59bdc8bbb786@linux.intel.com>
 <2d12777f-615a-8101-2156-cf861ec13aa7@suse.cz>
 <8051353f-47d3-37a4-a402-41adc8b6eb88@linux.intel.com>
From: Florian Weimer <fweimer@redhat.com>
Message-ID: <e97e53a1-ba04-c62e-cc64-054b488d5394@redhat.com>
Date: Fri, 24 Nov 2017 09:35:31 +0100
MIME-Version: 1.0
In-Reply-To: <8051353f-47d3-37a4-a402-41adc8b6eb88@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Hansen <dave.hansen@linux.intel.com>, Vlastimil Babka <vbabka@suse.cz>, linux-x86_64@vger.kernel.org, linux-arch@vger.kernel.org
Cc: linux-mm <linux-mm@kvack.org>, Linux API <linux-api@vger.kernel.org>
Message-ID: <20171124083531.pZdhPPVS9tv5FLL7-wPUjR5GbV3L_QCMpYfwefb_JBM@z>

On 11/24/2017 12:29 AM, Dave Hansen wrote:
> Although weird, the thought here was that pkey_mprotect() callers are
> new and should know about the interactions with PROT_EXEC.  They can
> also*get*  PROT_EXEC semantics if they want.
> 
> The only wart here is if you do:
> 
> 	mprotect(..., PROT_EXEC); // key 10 is now the PROT_EXEC key

I thought the PROT_EXEC key is always 1?

> 	pkey_mprotect(..., PROT_EXEC, key=3);
> 
> I'm not sure what this does.  We should probably ensure that it returns
> an error.

Without protection key support, PROT_EXEC would imply PROT_READ with an 
ordinary mprotect.  I think it makes sense to stick to this behavior. 
It is what I have documented for glibc:

   <https://sourceware.org/ml/libc-alpha/2017-11/msg00841.html>

Thanks,
Florian
