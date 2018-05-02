Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:27022 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752072AbeEBP2X (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 2 May 2018 11:28:23 -0400
Subject: Re: [PATCH] pkeys: Introduce PKEY_ALLOC_SIGNALINHERIT and change
 signal semantics
References: <20180502132751.05B9F401F3041@oldenburg.str.redhat.com>
 <248faadb-e484-806f-1485-c34a72a9ca0b@intel.com>
 <822a28c9-5405-68c2-11bf-0c282887466d@redhat.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <63086671-3603-1a79-d1a0-63913855456a@intel.com>
Date: Wed, 2 May 2018 08:28:21 -0700
MIME-Version: 1.0
In-Reply-To: <822a28c9-5405-68c2-11bf-0c282887466d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Florian Weimer <fweimer@redhat.com>, linux-mm@kvack.org, linux-api@vger.kernel.org, linux-x86_64@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org
Cc: linuxram@us.ibm.com, Andy Lutomirski <luto@kernel.org>

On 05/02/2018 08:12 AM, Florian Weimer wrote:
> On 05/02/2018 04:30 PM, Dave Hansen wrote:
>> On 05/02/2018 06:26 AM, Florian Weimer wrote:
>>> pkeys support for IBM POWER intends to inherited the access rights of
>>> the current thread in signal handlers.  The advantage is that this
>>> preserves access to memory regions associated with non-default keys,
>>> enabling additional usage scenarios for memory protection keys which
>>> currently do not work on x86 due to the unconditional reset to the
>>> (configurable) default key in signal handlers.
>>
>> What's the usage scenario that does not work?
> 
> Here's what I want to do:
> 
> Nick Clifton wrote a binutils patch which puts the .got.plt section on
> separate pages.  We allocate a protection key for it, assign it to all
> such sections in the process image, and change the access rights of the
> main thread to disallow writes via that key during process startup.  In
> _dl_fixup, we enable write access to the GOT, update the GOT entry, and
> then disable it again.
> 
> This way, we have a pretty safe form of lazy binding, without having to
> resort to BIND_NOW.
> 
> With the current kernel behavior on x86, we cannot do that because
> signal handlers revert to the default (deny) access rights, so the GOT
> turns inaccessible.

cc'ing Andy Lutomirksi...  He was the one that specifically asked for
the deny-by-default behavior that I think is biting you.

The behavior we had before implementing Andy's suggestion was, I think,
the one you would want: we had allow-all as the default PKRU value.

The other option here that I think we discussed in the past was to have
an *explicit* signal PKRU value.  That way, we can be restrictive by
default but allow overrides for special cases like you have.

>>> Consequently, this commit updates the x86 implementation to preserve
>>> the PKRU register value of the interrupted context in signal handlers.
>>> If a key is allocated successfully with the PKEY_ALLOC_SIGNALINHERIT
>>> flag, the application can assume this signal inheritance behavior.
>>
>> I think this is a pretty gross misuse of the API.  Adding an argument to
>> pkey_alloc() is something that folks would assume would impact the key
>> being *allocated*, not pkeys behavior across the process as a whole.
> 
> From the application point of view, only the allocated key is
> affected—it has specific semantics that were undefined before and varied
> between x86 and POWER.

I'd really like to see it in a separate API.

>>> This change does not affect the init_pkru optimization because if the
>>> thread's PKRU register is zero due to the init_pkru setting, it will
>>> remain zero in the signal handler through inheritance from the
>>> interrupted context.
>>
>> I think you are right, but it's rather convoluted.  It does:
>>
>> 1. Running with PKRU in the init state
>> 2. Kernel saves off init-state-PKRU XSAVE signal buffer
>> 3. Enter signal, kernel XRSTOR (may) set the init state again
>> 4. fpu__clear() does __write_pkru(), takes it out of the init state
>> 5. Signal handler runs, exits
>> 6. fpu__restore_sig() XRSTOR's the state from #2, taking PKRU back to
>>     the init state
> 
> Isn't that just the cost of not hard-coding the XSAVE area layout?

No.  You unnecessarily take PKRU out of the init state.  If you don't
want to change its value, just don't do that when you run XRSTOR.

>> But, about the patch in general:
>>
>> I'm not a big fan of doing this in such a PKRU-specific way.  It would
>> be nice to have this available for all XSAVE states.  It would also keep
>> you from so unnecessarily frobbing with WRPKRU in fpu__clear().  You
>> could just clear the PKRU bit in the Requested Feature BitMap (RFBM)
>> passed to XRSTOR.  That would be much straightforward and able to be
>> more easily extended to more states.
> 
> I don't see where I could plug this into the current kernel sources.
> Would you please provide some pointers?

In handle_signal()->fpu__clear()->...__copy_kernel_to_fpregs(), we pass
-1 as the RFBM.  Don't do that.  Pass (~0 & ~XFEATURE_MASK_PKRU).
