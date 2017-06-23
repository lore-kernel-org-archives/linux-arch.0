From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 0/5] Last bits for initial 5-level paging enabling
Date: Fri, 23 Jun 2017 11:06:01 +0200
Message-ID: <20170623090601.njsmucxdy4rev6zw@gmail.com>
References: <20170622122608.80435-1-kirill.shutemov@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <20170622122608.80435-1-kirill.shutemov@linux.intel.com>
Sender: owner-linux-mm@kvack.org
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org


* Kirill A. Shutemov <kirill.shutemov@linux.intel.com> wrote:

> As Ingo requested I've split and updated last two patches for my previous
> patchset.
> 
> Please review and consider applying.
> 
> Kirill A. Shutemov (5):
>   x86: Enable 5-level paging support
>   x86/mm: Rename tasksize_32bit/64bit to task_size_32bit/64bit
>   x86/mpx: Do not allow MPX if we have mappings above 47-bit
>   x86/mm: Prepare to expose larger address space to userspace
>   x86/mm: Allow userspace have mapping above 47-bit

Ok, looks pretty neat now.

Can I apply them in this order cleanly, without breaking bisection:

>   x86/mm: Rename tasksize_32bit/64bit to task_size_32bit/64bit
>   x86/mpx: Do not allow MPX if we have mappings above 47-bit
>   x86/mm: Prepare to expose larger address space to userspace
>   x86/mm: Allow userspace have mapping above 47-bit
>   x86: Enable 5-level paging support

?

I.e. I'd like to move the first patch last.

The reason is that we should first get all quirks and assumptions fixed, all 
facilities implemented - and only then enable 5-level paging as a final step which 
produces a well working kernel.

(This should also make it slightly easier to analyze any potential regressions in 
earlier patches.)

Thanks,

	Ingo

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
