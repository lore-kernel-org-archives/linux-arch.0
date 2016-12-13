From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC, PATCHv1 15/28] x86: detect 5-level paging support
Date: Tue, 13 Dec 2016 14:44:06 -0800
Message-ID: <b393a48a-6e8b-6427-373c-2825641fea99@zytor.com>
References: <20161208162150.148763-1-kirill.shutemov@linux.intel.com>
 <20161208162150.148763-17-kirill.shutemov@linux.intel.com>
 <20161208200505.c6xiy56oufg6d24m@pd.tnic>
 <CA+55aFzgp+6c6RhgYvEjor=_+ewMeYL4XY4BqER5HMUknXBDCA@mail.gmail.com>
 <20161208202013.uutsny6avn5gimwq@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20161208202013.uutsny6avn5gimwq@pd.tnic>
Sender: owner-linux-mm@kvack.org
To: Borislav Petkov <bp@alien8.de>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, the arch/x86 maintainers <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On 12/08/16 12:20, Borislav Petkov wrote:
> On Thu, Dec 08, 2016 at 12:08:53PM -0800, Linus Torvalds wrote:
>> Especially since that's some of the ugliest inline asm ever due to the
>> nasty BX handling.
> 
> Yeah, about that: why doesn't gcc handle that for us like it would
> handle a clobbered register? I mean, it *should* know that BX is live
> when building with -fPIC... The .ifnc thing looks really silly.
> 

When compiling with -fPIC gcc treats ebx as a "fixed register".  A fixed
register can't be spilled, and so a clobber of a fixed register is a
fatal error.

Like it or not, it's how it works.

	-hpa

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
