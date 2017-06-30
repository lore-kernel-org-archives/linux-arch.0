From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 0/5] Last bits for initial 5-level paging enabling
Date: Fri, 30 Jun 2017 08:59:26 +0200
Message-ID: <20170630065926.fcwax3odtla4dp4t@gmail.com>
References: <20170622122608.80435-1-kirill.shutemov@linux.intel.com>
 <20170623090601.njsmucxdy4rev6zw@gmail.com>
 <20170623144915.4d6esghvicnczuaj@black.fi.intel.com>
 <20170629150657.urgapbzmf3jy6jgp@node.shutemov.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <20170629150657.urgapbzmf3jy6jgp@node.shutemov.name>
Sender: owner-linux-mm@kvack.org
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org


* Kirill A. Shutemov <kirill@shutemov.name> wrote:

> > > Can I apply them in this order cleanly, without breaking bisection:
> > > 
> > > >   x86/mm: Rename tasksize_32bit/64bit to task_size_32bit/64bit
> > > >   x86/mpx: Do not allow MPX if we have mappings above 47-bit
> > > >   x86/mm: Prepare to expose larger address space to userspace
> > > >   x86/mm: Allow userspace have mapping above 47-bit
> > > >   x86: Enable 5-level paging support
> > > 
> > > ?
> > > 
> > > I.e. I'd like to move the first patch last.
> > > 
> > > The reason is that we should first get all quirks and assumptions fixed, all 
> > > facilities implemented - and only then enable 5-level paging as a final step which 
> > > produces a well working kernel.
> > > 
> > > (This should also make it slightly easier to analyze any potential regressions in 
> > > earlier patches.)
> > 
> > Just checked bisectability with this order on allmodconfig -- works fine.
> 
> Ingo, if there's no objections, can we get these applied?

Just this week, which is the final week of the development window, we had two 
fixes for the 5-level pagetables commits, so we need to delay the rest to right 
after -rc1.

Could you please resend them them (and any followup patches), in the suggested 
order? I don't see any conceptual problems, so this is only about timing and 
maximizing stability.

Thanks,

	Ingo

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
