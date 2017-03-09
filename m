From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCHv2 0/7] 5-level paging: prepare generic code
Date: Thu, 9 Mar 2017 12:26:10 -0800
Message-ID: <CA+55aFzwYvtSA-E+eKjPb3AdmziLeZ5y0vfMjVUoJVC=JrmnBg@mail.gmail.com>
References: <20170309142408.2868-1-kirill.shutemov@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20170309142408.2868-1-kirill.shutemov@linux.intel.com>
Sender: owner-linux-mm@kvack.org
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, the arch/x86 maintainers <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, Michal Hocko <mhocko@suse.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Thu, Mar 9, 2017 at 6:24 AM, Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
> Here's relatively low-risk part of 5-level paging patchset.
> Merging it now would make x86 5-level paging enabling in v4.12 easier.
>
> Linus, please consider applying.

Ok, I've applied this to a local branch in my tree for now, I'll wait
some more in case somebody wants to ack/nak before I merge that
branch.

                 Linus

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
