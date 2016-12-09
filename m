From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [RFC, PATCHv1 00/28] 5-level paging
Date: Fri, 9 Dec 2016 20:21:18 +0300
Message-ID: <20161209172118.GB8932@node.shutemov.name>
References: <20161208162150.148763-1-kirill.shutemov@linux.intel.com>
 <20161209050130.GC2595@gmail.com>
 <20161209103722.GE30380@node.shutemov.name>
 <20161209164011.GL8388@tassilo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161209164011.GL8388@tassilo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@linux.intel.com>
Cc: Ingo Molnar <mingo@kernel.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Fri, Dec 09, 2016 at 08:40:11AM -0800, Andi Kleen wrote:
> > On other hand, large virtual address space would put more pressure on
> > cache -- at least one more page table per process, if we make 56-bit VA
> > default.
> 
> The top level page always has to be there unless you disable it at boot time
> (unless you go for a scheme where some processes share top level pages, and
> others do not, which would likely be very complicated)
> 
> But even with that it is more than one: A typical set up has at least two extra
> 4K pages overhead, one for the bottom and one for the top mappings. Could easily be
> more.

So, right, one page for pgd, which we can't easily avoid.

If we limit VA to 47-bits by default, we would have one p4d page as the
range will be covered by one entry in pgd.

If we go to 56-bits VA by default, we would have at least two p4d pages
even for small processes. This where mine "at least one more page table
per process" comes from.

That's waste of memory and potentially cache. I don't think it's
justified.

-- 
 Kirill A. Shutemov
