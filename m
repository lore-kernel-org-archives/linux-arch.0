From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCHv7 00/14] x86: 5-level paging enabling for v4.13, Part 4
Date: Thu, 22 Jun 2017 12:07:36 +0300
Message-ID: <20170622090736.l5xcxazkeicughyt@node.shutemov.name>
References: <20170606113133.22974-1-kirill.shutemov@linux.intel.com>
 <20170622085744.wetigtzctyzukbs5@node.shutemov.name>
 <20170622090422.wbbaw6pm457i7cbr@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <20170622090422.wbbaw6pm457i7cbr@gmail.com>
Sender: owner-linux-mm@kvack.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Thu, Jun 22, 2017 at 11:04:22AM +0200, Ingo Molnar wrote:
> 
> * Kirill A. Shutemov <kirill@shutemov.name> wrote:
> 
> > On Tue, Jun 06, 2017 at 02:31:19PM +0300, Kirill A. Shutemov wrote:
> > > Please review and consider applying.
> > 
> > Hi Ingo,
> > 
> > I've noticed you haven't applied last two patches of the patchset.
> > 
> > Is there any problem with them? Or what is you plan here?
> 
> As they change/extend the Linux ABI I still need to think about them some more.

Okay, I see.

Let me know if any action is required from my side.

-- 
 Kirill A. Shutemov

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
