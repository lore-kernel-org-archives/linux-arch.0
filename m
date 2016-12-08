From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [RFC, PATCHv1 17/28] x86/mm: define virtual memory map for
 5-level paging
Date: Thu, 8 Dec 2016 22:24:37 +0300
Message-ID: <20161208192437.GC30380@node.shutemov.name>
References: <20161208162150.148763-1-kirill.shutemov@linux.intel.com>
 <20161208162150.148763-19-kirill.shutemov@linux.intel.com>
 <24bebd32-2056-dd5a-8b77-d2a9572dc512@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <24bebd32-2056-dd5a-8b77-d2a9572dc512@infradead.org>
Sender: owner-linux-mm@kvack.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Thu, Dec 08, 2016 at 10:56:04AM -0800, Randy Dunlap wrote:
> > @@ -23,6 +23,27 @@ ffffffffa0000000 - ffffffffff5fffff (=1526 MB) module mapping space
> >  ffffffffff600000 - ffffffffffdfffff (=8 MB) vsyscalls
> >  ffffffffffe00000 - ffffffffffffffff (=2 MB) unused hole
> >  
> > +Virtual memory map with 5 level page tables:
> > +
> > +0000000000000000 - 00ffffffffffffff (=56 bits) user space, different per mm
> > +hole caused by [57:63] sign extension
> 
> Can you briefly explain the sign extension?

Sure, I'll update it on respin.

> Should that be [56:63]?

You're right, it should. 

Thanks for all your corrections.

-- 
 Kirill A. Shutemov

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
