From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH 3/8] x86/mm: Define virtual memory map for 5-level paging
Date: Wed, 29 Mar 2017 01:47:20 +0300
Message-ID: <20170328224720.7ir7godugb6eqzm5@node.shutemov.name>
References: <20170327162925.16092-1-kirill.shutemov@linux.intel.com>
 <20170327162925.16092-4-kirill.shutemov@linux.intel.com>
 <1ae86ad3-deae-1b27-d7a9-ea6b20edc039@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <1ae86ad3-deae-1b27-d7a9-ea6b20edc039@zytor.com>
Sender: owner-linux-mm@kvack.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Tue, Mar 28, 2017 at 03:21:39PM -0700, H. Peter Anvin wrote:
> On 03/27/17 09:29, Kirill A. Shutemov wrote:
> > +fffe000000000000 - fffe007fffffffff (=39 bits) %esp fixup stacks
> 
> Why move this?

You're right. There's no reason to.

It's accident due to ESPFIX_BASE_ADDR being defined using PGDIR_SHIFT.
We should use P4D_SHIFT instead to produce consistent result across
paging modes.

I'll update the patch tomorrow. Thanks for noticing this.

-- 
 Kirill A. Shutemov

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
