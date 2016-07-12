From: Brian Gerst <brgerst@gmail.com>
Subject: Re: [PATCH v5 18/32] signal: Consolidate {TS,TLF}_RESTORE_SIGMASK code
Date: Tue, 12 Jul 2016 07:57:31 -0400
Message-ID: <CAMzpN2j2F9gQCRGmzVb0LjQT9mmU9m=HRG2Vbf-g79+i57dvdg@mail.gmail.com>
References: <cover.1468270393.git.luto@kernel.org> <dc84a1b979d800049bfd0629ed9380238cba2807.1468270393.git.luto@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ia64-owner@vger.kernel.org>
In-Reply-To: <dc84a1b979d800049bfd0629ed9380238cba2807.1468270393.git.luto@kernel.org>
Sender: linux-ia64-owner@vger.kernel.org
To: Andy Lutomirski <luto@kernel.org>
Cc: the arch/x86 maintainers <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, Nadav Amit <nadav.amit@gmail.com>, Kees Cook <keescook@chromium.org>, "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>, Linus Torvalds <torvalds@linux-foundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Jann Horn <jann@thejh.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Michal Simek <monstr@monstr.eu>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Yoshinori Sato <ysato@users.sourceforge.jp>Rich
List-Id: linux-arch.vger.kernel.org

On Mon, Jul 11, 2016 at 4:53 PM, Andy Lutomirski <luto@kernel.org> wrote:
> In general, there's no need for the "restore sigmask" flag to live in
> ti->flags.  alpha, ia64, microblaze, powerpc, sh, sparc (64-bit only),
> tile, and x86 use essentially identical alternative implementations,
> placing the flag in ti->status.
>
> Replace those optimized implementations with an equally good common
> implementation that stores it in a bitfield in struct task_struct
> and drop the custom implementations.
>
> Additional architectures can opt in by removing their
> TIF_RESTORE_SIGMASK defines.

There is a small typo in the subject, should be "signal: Consolidate
{TS,TIF}_RESTORE_SIGMASK code"

--
Brian Gerst
