Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([65.50.211.136]:60644 "EHLO mail.zytor.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932173AbdCTSJl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 20 Mar 2017 14:09:41 -0400
Date: Mon, 20 Mar 2017 11:08:41 -0700
In-Reply-To: <CAFZ8GQx2JmEECQHEsKOymP8nDv9YHfLgcK80R75gM+r-1q-owQ@mail.gmail.com>
References: <20170313055020.69655-1-kirill.shutemov@linux.intel.com> <20170313055020.69655-27-kirill.shutemov@linux.intel.com> <87a88jg571.fsf@skywalker.in.ibm.com> <20170317175714.3bvpdylaaudf4ig2@node.shutemov.name> <877f3lfzdo.fsf@skywalker.in.ibm.com> <CAFZ8GQx2JmEECQHEsKOymP8nDv9YHfLgcK80R75gM+r-1q-owQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH 26/26] x86/mm: allow to have userspace mappings above 47-bits
From: hpa@zytor.com
Message-ID: <95631D05-2CA2-4967-A29E-DB396C76F62D@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Kirill A. Shutemov" <kirill@shutemov.name>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@amacapital.net>, Dave Hansen <dave.hansen@intel.com>, linux-mm@kvack.org, x86@kernel.org, Andi Kleen <ak@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <20170320180841.jTJFismVPtg7IJWFbYZKNTcrDtVXIznwmUWO4qDGE8A@z>

On March 19, 2017 1:26:58 AM PDT, "Kirill A. Shutemov" <kirill@shutemov.name> wrote:
>On Mar 19, 2017 09:25, "Aneesh Kumar K.V"
><aneesh.kumar@linux.vnet.ibm.com>
>wrote:
>
>"Kirill A. Shutemov" <kirill@shutemov.name> writes:
>
>> On Fri, Mar 17, 2017 at 11:23:54PM +0530, Aneesh Kumar K.V wrote:
>>> "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com> writes:
>>>
>>> > On x86, 5-level paging enables 56-bit userspace virtual address
>space.
>>> > Not all user space is ready to handle wide addresses. It's known
>that
>>> > at least some JIT compilers use higher bits in pointers to encode
>their
>>> > information. It collides with valid pointers with 5-level paging
>and
>>> > leads to crashes.
>>> >
>>> > To mitigate this, we are not going to allocate virtual address
>space
>>> > above 47-bit by default.
>>> >
>>> > But userspace can ask for allocation from full address space by
>>> > specifying hint address (with or without MAP_FIXED) above 47-bits.
>>> >
>>> > If hint address set above 47-bit, but MAP_FIXED is not specified,
>we
>try
>>> > to look for unmapped area by specified address. If it's already
>>> > occupied, we look for unmapped area in *full* address space,
>rather
>than
>>> > from 47-bit window.
>>> >
>>> > This approach helps to easily make application's memory allocator
>aware
>>> > about large address space without manually tracking allocated
>virtual
>>> > address space.
>>> >
>>>
>>> So if I have done a successful mmap which returned > 128TB what
>should a
>>> following mmap(0,...) return ? Should that now search the *full*
>address
>>> space or below 128TB ?
>>
>> No, I don't think so. And this implementation doesn't do this.
>>
>> It's safer this way: if an library can't handle high addresses, it's
>> better not to switch it automagically to full address space if other
>part
>> of the process requested high address.
>>
>
>What is the epectation when the hint addr is below 128TB but addr + len
>>
>128TB ? Should such mmap request fail ?
>
>
>Yes, I believe so.

This *better* be conditional on some kind of settable limit.  Having a barrier in the middle of the address space for no apparent reason to "clean" software is insane.
-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
