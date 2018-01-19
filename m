Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from a-painless.mh.aa.net.uk ([81.187.30.51]:56129 "EHLO
        a-painless.mh.aa.net.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755949AbeASSRM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 Jan 2018 13:17:12 -0500
From: Adam Sampson <ats@offog.org>
Subject: Re: [kernel-hardening] [PATCH v4 02/10] asm/nospec, array_ptr: sanitize speculative array de-references
References: <151632009605.21271.11304291057104672116.stgit@dwillia2-desk3.amr.corp.intel.com>
        <151632010687.21271.12004432287640499992.stgit@dwillia2-desk3.amr.corp.intel.com>
        <CAG48ez0Y97-gyzWBmcVbUyLuzUG42To=Mm8PAKuzWma6XbFmew@mail.gmail.com>
Date: Fri, 19 Jan 2018 17:48:04 +0000
In-Reply-To: <CAG48ez0Y97-gyzWBmcVbUyLuzUG42To=Mm8PAKuzWma6XbFmew@mail.gmail.com>
        (Jann Horn's message of "Fri, 19 Jan 2018 11:20:48 +0100")
Message-ID: <y2afu71pwob.fsf@offog.org>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jann Horn <jannh@google.com>
Cc: Dan Williams <dan.j.williams@intel.com>, kernel list <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Kernel Hardening <kernel-hardening@lists.openwall.com>, Catalin Marinas <catalin.marinas@arm.com>, the arch/x86 maintainers <x86@kernel.org>, Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>, Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, alan@linux.intel.com
Message-ID: <20180119174804.ngq0Y3Er2lE5OY0421QntnGpkQmg-sSlnAPbZEP0bIA@z>

Jann Horn <jannh@google.com> writes:

>> +/*
>> + * If idx is negative or if idx > size then bit 63 is set in the mask,
>> + * and the value of ~(-1L) is zero. When the mask is zero, bounds check
>> + * failed, array_ptr will return NULL.
>> + */
>> +#ifndef array_ptr_mask
>> +static inline unsigned long array_ptr_mask(unsigned long idx,
>> unsigned long sz)
>> +{
>> +       return ~(long)(idx | (sz - 1 - idx)) >> (BITS_PER_LONG - 1);
>> +}
>> +#endif
>
> Nit: Maybe add a comment saying that this is equivalent to
> "return ((long)idx >= 0 && idx < sz) ? ULONG_MAX : 0"?

That's only true when sz < LONG_MAX, which is documented below but not
here; it's also different from the asm version, which doesn't do the idx
<= LONG_MAX check. So making the constraint explicit would be a good idea.
