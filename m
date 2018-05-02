Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50640 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751616AbeEBRRY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 2 May 2018 13:17:24 -0400
Subject: Re: [PATCH] pkeys: Introduce PKEY_ALLOC_SIGNALINHERIT and change
 signal semantics
References: <20180502132751.05B9F401F3041@oldenburg.str.redhat.com>
 <248faadb-e484-806f-1485-c34a72a9ca0b@intel.com>
 <822a28c9-5405-68c2-11bf-0c282887466d@redhat.com>
 <57459C6F-C8BA-4E2D-99BA-64F35C11FC05@amacapital.net>
From: Florian Weimer <fweimer@redhat.com>
Message-ID: <6286ba0a-7e09-b4ec-e31f-bd091f5940ff@redhat.com>
Date: Wed, 2 May 2018 19:17:21 +0200
MIME-Version: 1.0
In-Reply-To: <57459C6F-C8BA-4E2D-99BA-64F35C11FC05@amacapital.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Dave Hansen <dave.hansen@intel.com>, linux-mm@kvack.org, linux-api@vger.kernel.org, linux-x86_64@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org, linuxram@us.ibm.com

On 05/02/2018 07:09 PM, Andy Lutomirski wrote:
>> Nick Clifton wrote a binutils patch which puts the .got.plt section on separate pages.  We allocate a protection key for it, assign it to all such sections in the process image, and change the access rights of the main thread to disallow writes via that key during process startup.  In _dl_fixup, we enable write access to the GOT, update the GOT entry, and then disable it again.
>>
>> This way, we have a pretty safe form of lazy binding, without having to resort to BIND_NOW.
>>
>> With the current kernel behavior on x86, we cannot do that because signal handlers revert to the default (deny) access rights, so the GOT turns inaccessible.

> Dave is right: the current behavior was my request, and I still think it’s correct.  The whole point is that, even if something nasty happens like a SIGALRM handler hitting in the middle of _dl_fixup, the SIGALRM handler is preventing from accidentally writing to the protected memory.  When SIGALRM returns, PKRU should get restored
> 
> Another way of looking at this is that the kernel would like to approximate what the ISA behavior*should*  have been: the whole sequence “modify PKRU; access memory; restore PKRU” should be as atomic as possible.
> 
> Florian, what is the actual problematic sequence of events?

See above.  The signal handler will crash if it calls any non-local 
function through the GOT because with the default access rights, it's 
not readable in the signal handler.

Any use of memory protection keys for basic infrastructure will run into 
this problem, so I think the current kernel behavior is not very useful. 
  It's also x86-specific.

 From a security perspective, the atomic behavior is not very useful 
because you generally want to modify PKRU *before* computing the details 
of the memory access, so that you don't have a general “poke anywhere 
with this access right” primitive in the text segment.  (I called this 
the “suffix problem” in another context.)

For this reason, I plan to add the PKRU modification to the beginning of 
_dl_fixup.

CET will offer a different trade-off here, but we haven't that yet.

Thanks,
Florian
