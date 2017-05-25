From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCHv1, RFC 0/8] Boot-time switching between 4- and 5-level paging
Date: Thu, 25 May 2017 16:24:24 -0700
Message-ID: <CA+55aFznnXPDxYy5CN6qVU7QJ3Y9hbSf-s2-w0QkaNJuTspGcQ@mail.gmail.com>
References: <20170525203334.867-1-kirill.shutemov@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20170525203334.867-1-kirill.shutemov@linux.intel.com>
Sender: owner-linux-mm@kvack.org
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, the arch/x86 maintainers <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Thu, May 25, 2017 at 1:33 PM, Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
> Here' my first attempt to bring boot-time between 4- and 5-level paging.
> It looks not too terrible to me. I've expected it to be worse.

If I read this right, you just made it a global on/off thing.

May I suggest possibly a different model entirely? Can you make it a
per-mm flag instead?

And then we

 (a) make all kthreads use the 4-level page tables

 (b) which means that all the init code uses the 4-level page tables

 (c) which means that all those checks for "start_secondary" etc can
just go away, because those all run with 4-level page tables.

Or is it just much too expensive to switch between 4-level and 5-level
paging at run-time?

              Linus

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
