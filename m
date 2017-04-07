From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH 8/8] x86/mm: Allow to have userspace mappings above
 47-bits
Date: Fri, 7 Apr 2017 18:59:45 +0300
Message-ID: <20170407155945.7lyapjbwacg3ikw6@node.shutemov.name>
References: <20170406140106.78087-1-kirill.shutemov@linux.intel.com>
 <20170406140106.78087-9-kirill.shutemov@linux.intel.com>
 <8d68093b-670a-7d7e-2216-bf64b19c7a48@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <8d68093b-670a-7d7e-2216-bf64b19c7a48@linux.vnet.ibm.com>
Sender: owner-linux-mm@kvack.org
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Dmitry Safonov <dsafonov@virtuozzo.com>
List-Id: linux-arch.vger.kernel.org

On Fri, Apr 07, 2017 at 07:05:26PM +0530, Anshuman Khandual wrote:
> On 04/06/2017 07:31 PM, Kirill A. Shutemov wrote:
> > On x86, 5-level paging enables 56-bit userspace virtual address space.
> > Not all user space is ready to handle wide addresses. It's known that
> > at least some JIT compilers use higher bits in pointers to encode their
> > information. It collides with valid pointers with 5-level paging and
> > leads to crashes.
> > 
> > To mitigate this, we are not going to allocate virtual address space
> > above 47-bit by default.
> 
> I am wondering if the commitment of virtual space range to the
> user space is kind of an API which needs to be maintained there
> after. If that is the case then we need to have some plans when
> increasing it from the current level.

I don't think we should ever enable full address space for all
applications. There's no point.

/bin/true doesn't need more than 64TB of virtual memory.
And I hope never will.

By increasing virtual address space for everybody we will pay (assuming
current page table format) at least one extra page per process for moving
stack at very end of address space.

Yes, you can gain something in security by having more bits for ASLR, but
I don't think it worth the cost.

> Will those JIT compilers keep using the higher bit positions of
> the pointer for ever ? Then it will limit the ability of the
> kernel to expand the virtual address range later as well. I am
> not saying we should not increase till the extent it does not
> affect any *known* user but then we should not increase twice
> for now, create the hint mechanism to be passed from the user
> to avail beyond that (which will settle in as a expectation
> from the kernel later on). Do the same thing again while
> expanding the address range next time around. I think we need
> to have a plan for this and particularly around 'hint' mechanism
> and whether it should be decided per mmap() request or at the
> task level.

I think the reasonable way for an application to claim it's 63-bit clean
is to make allocations with (void *)-1 as hint address.

-- 
 Kirill A. Shutemov

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
