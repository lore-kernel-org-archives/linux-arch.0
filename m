From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC, PATCHv1 15/28] x86: detect 5-level paging support
Date: Thu, 8 Dec 2016 12:08:53 -0800
Message-ID: <CA+55aFzgp+6c6RhgYvEjor=_+ewMeYL4XY4BqER5HMUknXBDCA@mail.gmail.com>
References: <20161208162150.148763-1-kirill.shutemov@linux.intel.com>
 <20161208162150.148763-17-kirill.shutemov@linux.intel.com> <20161208200505.c6xiy56oufg6d24m@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20161208200505.c6xiy56oufg6d24m@pd.tnic>
Sender: owner-linux-mm@kvack.org
To: Borislav Petkov <bp@alien8.de>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, the arch/x86 maintainers <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Thu, Dec 8, 2016 at 12:05 PM, Borislav Petkov <bp@alien8.de> wrote:
>
> The cpuid() in cpuflags.c doesn't zero ecx which, if we have to be
> pedantic, it should do. It calls CPUID now with the ptr value of its 4th
> on 64-bit and 3rd arg on 32-bit, respectively, IINM.

In fact, just do a single cpuid_count(), and then implement the
traditional cpuid() as just

   #define cpuid(x, a,b,c,d) cpuid_count(x, 0, a, b, c, d)

or something.

Especially since that's some of the ugliest inline asm ever due to the
nasty BX handling.

          Linus

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
