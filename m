From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/6] x86: 5-level paging enabling for v4.12, Part 1
Date: Mon, 13 Mar 2017 12:46:26 -0700
Message-ID: <CA+55aFzo95ZYAW-M1uPp0Q0CJUVbc-FTCZuJQ-TtjL6S+E7hKg@mail.gmail.com>
References: <20170313143309.16020-1-kirill.shutemov@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20170313143309.16020-1-kirill.shutemov@linux.intel.com>
Sender: owner-linux-mm@kvack.org
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, the arch/x86 maintainers <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, Michal Hocko <mhocko@suse.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Mon, Mar 13, 2017 at 7:33 AM, Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
> Here's the first bunch of patches of 5-level patchset. Let's see if I'm on
> right track addressing Ingo's feedback. :)

Considering the bug we just had with the HAVE_GENERIC_RCU_GUP code,
I'm wondering if people would be willing to look at what it would take
to make x86 use the generic version?

The x86 version of __get_user_pages_fast() seems to be quite similar
to the generic one. And it would be lovely if all the main
architectures shared the same core gup code.

                   Linus

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
