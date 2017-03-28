From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCHv2 6/8] x86/dump_pagetables: Add support 5-level paging
Date: Wed, 29 Mar 2017 00:15:07 +0300
Message-ID: <20170328211507.ungejuigkewn6prl@node.shutemov.name>
References: <20170328093946.GA30567@gmail.com>
 <20170328104806.41711-1-kirill.shutemov@linux.intel.com>
 <20170328185522.5akqgfh4niqi3ptf@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <20170328185522.5akqgfh4niqi3ptf@pd.tnic>
Sender: owner-linux-mm@kvack.org
To: Borislav Petkov <bp@alien8.de>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Tue, Mar 28, 2017 at 08:55:22PM +0200, Borislav Petkov wrote:
> On Tue, Mar 28, 2017 at 01:48:06PM +0300, Kirill A. Shutemov wrote:
> > Simple extension to support one more page table level.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > ---
> >  arch/x86/mm/dump_pagetables.c | 59 +++++++++++++++++++++++++++++++++----------
> >  1 file changed, 45 insertions(+), 14 deletions(-)
> 
> Hmm, so without this I get the splat below.

On current tip/master?

> Can we do something about this bisection breakage? I mean, this is the
> second explosion caused by 5level paging I trigger. Maybe we should
> merge the whole thing into a single big patch when everything is applied
> and tested, more or less, so that bisection is fine.
> 
> Or someone might have a better idea...

I'm not sure that collapsing history in one commit to fix bisectability is
any better than having broken bisectability.

I'll try to look more into this issue tomorrow.

Sorry for this.

-- 
 Kirill A. Shutemov

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
