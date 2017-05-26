From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCHv1, RFC 0/8] Boot-time switching between 4- and 5-level
 paging
Date: Fri, 26 May 2017 16:00:57 +0300
Message-ID: <20170526130057.t7zsynihkdtsepkf@node.shutemov.name>
References: <20170525203334.867-1-kirill.shutemov@linux.intel.com>
 <CA+55aFznnXPDxYy5CN6qVU7QJ3Y9hbSf-s2-w0QkaNJuTspGcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <CA+55aFznnXPDxYy5CN6qVU7QJ3Y9hbSf-s2-w0QkaNJuTspGcQ@mail.gmail.com>
Sender: owner-linux-mm@kvack.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, the arch/x86 maintainers <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Thu, May 25, 2017 at 04:24:24PM -0700, Linus Torvalds wrote:
> On Thu, May 25, 2017 at 1:33 PM, Kirill A. Shutemov
> <kirill.shutemov@linux.intel.com> wrote:
> > Here' my first attempt to bring boot-time between 4- and 5-level paging.
> > It looks not too terrible to me. I've expected it to be worse.
> 
> If I read this right, you just made it a global on/off thing.
> 
> May I suggest possibly a different model entirely? Can you make it a
> per-mm flag instead?
> 
> And then we
> 
>  (a) make all kthreads use the 4-level page tables
> 
>  (b) which means that all the init code uses the 4-level page tables
> 
>  (c) which means that all those checks for "start_secondary" etc can
> just go away, because those all run with 4-level page tables.
> 
> Or is it just much too expensive to switch between 4-level and 5-level
> paging at run-time?

Hm..

I don't see how kernel threads can use 4-level paging. It doesn't work
from virtual memory layout POV. Kernel claims half of full virtual address
space for itself -- 256 PGD entries, not one as we would effectively have
in case of switching to 4-level paging. For instance, addresses, where
vmalloc and vmemmap are mapped, are not canonical with 4-level paging.

And you cannot see whole direct mapping of physical memory. Back to
highmem? (Please, no, please).

We could possible reduce number of PGD required by kernel. Currently,
layout for 5-level paging allows up-to 55-bit physical memory. It's
redundant as SDM claim that we never will get more than 52. So we could
reduce size of kernel part of layout by few bits, but not definitely to 1.

I don't see how it can possibly work.

Besides difficulties of getting switching between paging modes correct,
that Andy mentioned, it will also hurt performance. You cannot switch
between paging modes directly. It would require disabling paging
completely. It means we loose benefit from global page table entries on
such switching. More page-walks.

Even ignoring all of above, I don't see much benefit of having per-mm
switching. It adds complexity without much benefit -- saving few lines of
logic during early boot doesn't look as huge win to me.

-- 
 Kirill A. Shutemov

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
