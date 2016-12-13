Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:27273 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932655AbcLMVHy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 13 Dec 2016 16:07:54 -0500
Subject: Re: [RFC, PATCHv1 00/28] 5-level paging
References: <20161208162150.148763-1-kirill.shutemov@linux.intel.com>
 <20161209050130.GC2595@gmail.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <a2f86495-b55f-fda0-40d2-242c45d3c1f3@intel.com>
Date: Tue, 13 Dec 2016 13:06:35 -0800
MIME-Version: 1.0
In-Reply-To: <20161209050130.GC2595@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Andy Lutomirski <luto@amacapital.net>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Message-ID: <20161213210635.KAdOCEzpYa175JOEqsN6NmrgDzZyVbIbDaa3DwN3Jcw@z>

On 12/08/2016 09:01 PM, Ingo Molnar wrote:
>> >   - Handle opt-in wider address space for userspace.
>> > 
>> >     Not all userspace is ready to handle addresses wider than current
>> >     47-bits. At least some JIT compiler make use of upper bits to encode
>> >     their info.
>> > 
>> >     We need to have an interface to opt-in wider addresses from userspace
>> >     to avoid regressions.
>> > 
>> >     For now, I've included testing-only patch which bumps TASK_SIZE to
>> >     56-bits. This can be handy for testing to see what breaks if we max-out
>> >     size of virtual address space.
> So this is just a detail - but it sounds a bit limiting to me to provide an 'opt 
> in' flag for something that will work just fine on the vast majority of 64-bit 
> software.

MPX is going to be a real pain here.  It is relatively transparent to
applications that use it, and old MPX binaries are entirely incompatible
with the new address space size, so an opt-out wouldn't be friendly.

Because the top-level MPX bounds table is indexed by the virtual
address, a growth in vaddr space is going to require the table to grow
(or change somehow).  The solution baked into the hardware spec is to
just make the top-level table 512x larger to accommodate the 512x
increase in vaddr space.  (This behavior is controlled by a new MSR, btw...)

So, either we disable MPX on all old MPX binaries by returning an error
when the prctl() tries to enable MPX and 5-level paging is on, or we go
with some form of an opt-in.  New MPX binaries will opt-in to the larger
address space since they know to allocate the new, larger table.
