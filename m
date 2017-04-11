From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH 3/8] x86/boot/64: Add support of additional page table
 level during early boot
Date: Tue, 11 Apr 2017 13:51:06 +0300
Message-ID: <20170411105106.4zgbzuu4s4267zyv@node.shutemov.name>
References: <20170406140106.78087-1-kirill.shutemov@linux.intel.com>
 <20170406140106.78087-4-kirill.shutemov@linux.intel.com>
 <20170411070203.GA14621@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <20170411070203.GA14621@gmail.com>
Sender: owner-linux-mm@kvack.org
To: Ingo Molnar <mingo@kernel.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Tue, Apr 11, 2017 at 09:02:03AM +0200, Ingo Molnar wrote:
> I realize that you had difficulties converting this to C, but it's not going to 
> get any easier in the future either, with one more paging mode/level added!
> 
> If you are stuck on where it breaks I'd suggest doing it gradually: first add a 
> trivial .c, build and link it in and call it separately. Then once that works, 
> move functionality from asm to C step by step and test it at every step.

I've described the specific issue with converting this code to C in cover
letter: how to make compiler to generate 32-bit code for a specific
function or translation unit, without breaking linking afterwards (-m32
break it).

I would be glad to convert it, but I'm stuck.

Do you have an idea how to get around the issue.

-- 
 Kirill A. Shutemov

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
