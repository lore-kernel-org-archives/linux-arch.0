From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH 0/6] x86: 5-level paging enabling for v4.12, Part 1
Date: Wed, 15 Mar 2017 18:42:05 +0300
Message-ID: <20170315154205.33hvpvkbjypgkd7g@node.shutemov.name>
References: <20170313143309.16020-1-kirill.shutemov@linux.intel.com>
 <20170314074729.GA23151@gmail.com>
 <CA+55aFzALboaXe5TWv8=3QZBPJCVAVBmfxTjQEi-aAnHKYAuPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <CA+55aFzALboaXe5TWv8=3QZBPJCVAVBmfxTjQEi-aAnHKYAuPQ@mail.gmail.com>
Sender: owner-linux-mm@kvack.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, the arch/x86 maintainers <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, Michal Hocko <mhocko@suse.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Tue, Mar 14, 2017 at 10:48:51AM -0700, Linus Torvalds wrote:
> On Tue, Mar 14, 2017 at 12:47 AM, Ingo Molnar <mingo@kernel.org> wrote:
> >
> > I've also applied the GUP patch, with the assumption that you'll address Linus's
> > request to switch x86 over to the generic version.
> 
> Note that switching over to the generic version is somewhat fraught
> with subtle issues:
> 
>  (a) we need to make sure that x86 actually matches the required
> semantics for the generic GUP.
> 
>  (b) we need to make sure the atomicity of the page table reads is ok.
> 
>  (c) need to verify the maximum VM address properly

There's another difference with generic version: it uses
page_cache_get_speculative() instead of plain get_page() on x86.
That's somewhat more expensive, but probably fine.

-- 
 Kirill A. Shutemov

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
