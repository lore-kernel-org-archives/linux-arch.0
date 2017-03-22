From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 4/6] x86/kasan: Prepare clear_pgds() to switch to
 <asm-generic/pgtable-nop4d.h>
Date: Wed, 22 Mar 2017 08:31:36 +0100
Message-ID: <20170322073136.GC13904@gmail.com>
References: <20170317185515.8636-1-kirill.shutemov@linux.intel.com>
 <20170317185515.8636-5-kirill.shutemov@linux.intel.com>
 <218853b4-3498-dab9-d1e9-02caed4d9322@virtuozzo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <218853b4-3498-dab9-d1e9-02caed4d9322@virtuozzo.com>
Sender: owner-linux-mm@kvack.org
To: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, Michal Hocko <mhocko@suse.com>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>
List-Id: linux-arch.vger.kernel.org


* Andrey Ryabinin <aryabinin@virtuozzo.com> wrote:

> 
> 
> On 03/17/2017 09:55 PM, Kirill A. Shutemov wrote:
> > With folded p4d, pgd_clear() is nop. Change clear_pgds() to use
> > p4d_clear() instead.
> > 
> 
> You could probably just use set_pgd(pgd_offset_k(start), __pgd(0)); instead of pgd_clear()
> as we already do in arm64.
> It's basically pgd_clear() except it's not a nop wih p4d folded.

Makes sense. Kirill, if you agree, mind spinning a v2 patch?

Thanks,

	Ingo

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
