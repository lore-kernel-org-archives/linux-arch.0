From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/3] syscalls: clean up stub naming convention
Date: Mon, 9 Apr 2018 12:13:50 -0700
Message-ID: <CA+55aFzB1+e+X0pWgNyyQXiU34RnTk8swaqewbzSYK29gu-_dA@mail.gmail.com>
References: <20180407074651.29014-1-linux@dominikbrodowski.net>
 <20180408083550.32d65b6ra6yca5p7@gmail.com> <20180408091536.GA10120@light.dominikbrodowski.net>
 <20180409063921.wkrqbnv4lzxb3isg@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180409063921.wkrqbnv4lzxb3isg@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Andi Kleen <ak@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>, Denys Vlasenko <dvlasenk@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, the arch/x86 maintainers <x86@kernel.org>, Maninder Singh <maninder1.s@samsung.com>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Sun, Apr 8, 2018 at 11:39 PM, Ingo Molnar <mingo@kernel.org> wrote:
>
> I see - so it's _not_ the same function call signature, but a wrapper with a
> sign-extended version, which is fair and useful. So on architectures where this
> matters there's type conversion and active code generated.

Exactly. Some architectures have that as part of their ABI.

On Powerpc, for example, when you pass an "int" argument, the ABI
specifies that you have to sign-extend the register in the caller to
64 bits.

And the generated code actually depends on that behavior, in that
maybe it first tests the 32 bit value, but then _uses_ the full 64
bits, knowing that the caller sign-extended it properly.

This is a problem with the system call interface, since the caller
isn't a trusted entity, and user space could pass an "int" value with
the high bits set to something that _isn't_ the sign-extended thing,
so then the compiler generates unsafe code.

On x86, this never happens, since x86 doesn't have that "hidden higher
bits matter" ABI model. So that part of the wrapper will be a complete
no-op. But some other architectures depend on it.

               Linus
