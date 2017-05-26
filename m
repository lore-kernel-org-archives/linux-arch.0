Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([65.50.211.136]:35055 "EHLO mail.zytor.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934404AbdEZUOd (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 26 May 2017 16:14:33 -0400
Date: Fri, 26 May 2017 12:40:17 -0700
In-Reply-To: <20170526130057.t7zsynihkdtsepkf@node.shutemov.name>
References: <20170525203334.867-1-kirill.shutemov@linux.intel.com> <CA+55aFznnXPDxYy5CN6qVU7QJ3Y9hbSf-s2-w0QkaNJuTspGcQ@mail.gmail.com> <20170526130057.t7zsynihkdtsepkf@node.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCHv1, RFC 0/8] Boot-time switching between 4- and 5-level paging
From: hpa@zytor.com
Message-ID: <91E86DF1-9814-444B-AD43-706246D768EC@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Kirill A. Shutemov" <kirill@shutemov.name>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, the arch/x86 maintainers <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <20170526194017.GgUmTNPZzF55R4v4vaO1UsMx9777OcZytmOTIC9HqEo@z>

On May 26, 2017 6:00:57 AM PDT, "Kirill A. Shutemov" <kirill@shutemov.name> wrote:
>On Thu, May 25, 2017 at 04:24:24PM -0700, Linus Torvalds wrote:
>> On Thu, May 25, 2017 at 1:33 PM, Kirill A. Shutemov
>> <kirill.shutemov@linux.intel.com> wrote:
>> > Here' my first attempt to bring boot-time between 4- and 5-level
>paging.
>> > It looks not too terrible to me. I've expected it to be worse.
>> 
>> If I read this right, you just made it a global on/off thing.
>> 
>> May I suggest possibly a different model entirely? Can you make it a
>> per-mm flag instead?
>> 
>> And then we
>> 
>>  (a) make all kthreads use the 4-level page tables
>> 
>>  (b) which means that all the init code uses the 4-level page tables
>> 
>>  (c) which means that all those checks for "start_secondary" etc can
>> just go away, because those all run with 4-level page tables.
>> 
>> Or is it just much too expensive to switch between 4-level and
>5-level
>> paging at run-time?
>
>Hm..
>
>I don't see how kernel threads can use 4-level paging. It doesn't work
>from virtual memory layout POV. Kernel claims half of full virtual
>address
>space for itself -- 256 PGD entries, not one as we would effectively
>have
>in case of switching to 4-level paging. For instance, addresses, where
>vmalloc and vmemmap are mapped, are not canonical with 4-level paging.
>
>And you cannot see whole direct mapping of physical memory. Back to
>highmem? (Please, no, please).
>
>We could possible reduce number of PGD required by kernel. Currently,
>layout for 5-level paging allows up-to 55-bit physical memory. It's
>redundant as SDM claim that we never will get more than 52. So we could
>reduce size of kernel part of layout by few bits, but not definitely to
>1.
>
>I don't see how it can possibly work.
>
>Besides difficulties of getting switching between paging modes correct,
>that Andy mentioned, it will also hurt performance. You cannot switch
>between paging modes directly. It would require disabling paging
>completely. It means we loose benefit from global page table entries on
>such switching. More page-walks.
>
>Even ignoring all of above, I don't see much benefit of having per-mm
>switching. It adds complexity without much benefit -- saving few lines
>of
>logic during early boot doesn't look as huge win to me.

It also makes no sense – the kernel threads only need one common page table anyway.
-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
