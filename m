From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC, PATCHv1 00/28] 5-level paging
Date: Thu, 8 Dec 2016 10:16:07 -0800
Message-ID: <CA+55aFz+-8RmOMqyqQOWSjJ82byy7BpJ791-gj=xO2rPKG6KFA@mail.gmail.com>
References: <20161208162150.148763-1-kirill.shutemov@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20161208162150.148763-1-kirill.shutemov@linux.intel.com>
Sender: owner-linux-mm@kvack.org
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, the arch/x86 maintainers <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Thu, Dec 8, 2016 at 8:21 AM, Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> This patchset is still very early. There are a number of things missing
> that we have to do before asking anyone to merge it (listed below).
> It would be great if folks can start testing applications now (in QEMU) to
> look for breakage.
> Any early comments on the design or the patches would be appreciated as
> well.

Looks ok to me. Starting off with a compile-time config option seems fine.

I do think that the x86 cpuid part should (patch 15) should be the
first patch, so that we see "la57" as a capability in /proc/cpuinfo
whether it's being enabled or not? We should merge that part
regardless of any mm patches, I think.

               Linus

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
