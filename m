From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCHv4 00/33] 5-level paging
Date: Mon, 6 Mar 2017 10:27:18 -0800
Message-ID: <CA+55aFypZza_L5jyDEFwBrFZPR72R18RwTMz4TuV5sg0H4aaqA@mail.gmail.com>
References: <20170306135357.3124-1-kirill.shutemov@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20170306135357.3124-1-kirill.shutemov@linux.intel.com>
Sender: owner-linux-mm@kvack.org
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, the arch/x86 maintainers <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Mon, Mar 6, 2017 at 5:53 AM, Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
> Here is v4 of 5-level paging patchset. Please review and consider applying.

I think we should just aim for this being in 4.12. I don't see any
real reason to delay merging it, the main question in my mind is which
tree it would go through. A separate x86 -tip branch, or Andrew's mm
tree or me just pulling directly, or what?

I basically think it's in good enough shape that future work might as
well be based on this being merged. No?

                   Linus

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
