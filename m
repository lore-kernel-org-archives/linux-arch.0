From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCHv1, RFC 0/8] Boot-time switching between 4- and 5-level
 paging
Date: Fri, 26 May 2017 18:58:12 +0300
Message-ID: <20170526155812.gdc6x6pz2howdpjb@node.shutemov.name>
References: <20170525203334.867-1-kirill.shutemov@linux.intel.com>
 <CA+55aFznnXPDxYy5CN6qVU7QJ3Y9hbSf-s2-w0QkaNJuTspGcQ@mail.gmail.com>
 <20170526130057.t7zsynihkdtsepkf@node.shutemov.name>
 <CA+55aFw2HDHRZTYss2xbSTRAZuS1qAFmKrAXsiMp34ngNapTiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <CA+55aFw2HDHRZTYss2xbSTRAZuS1qAFmKrAXsiMp34ngNapTiw@mail.gmail.com>
Sender: owner-linux-mm@kvack.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, the arch/x86 maintainers <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Fri, May 26, 2017 at 08:51:48AM -0700, Linus Torvalds wrote:
> On Fri, May 26, 2017 at 6:00 AM, Kirill A. Shutemov
> <kirill@shutemov.name> wrote:
> >
> > I don't see how kernel threads can use 4-level paging. It doesn't work
> > from virtual memory layout POV. Kernel claims half of full virtual address
> > space for itself -- 256 PGD entries, not one as we would effectively have
> > in case of switching to 4-level paging. For instance, addresses, where
> > vmalloc and vmemmap are mapped, are not canonical with 4-level paging.
> 
> I would have just assumed we'd map the kernel in the shared part that
> fits in the top 47 bits.
> 
> But it sounds like you can't switch back and forth anyway, so I guess it's moot.
> 
> Where *is* the LA57 documentation, btw? I had an old x86 architecture
> manual, so I updated it, but LA57 isn't mentioned in the new one
> either.

It's in a separate white paper for now:

https://software.intel.com/sites/default/files/managed/2b/80/5-level_paging_white_paper.pdf

-- 
 Kirill A. Shutemov

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
