From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] seccomp: Use -1 marker for end of mode 1 syscall list
Date: Fri, 19 Jun 2020 12:53:46 -0700
Message-ID: <202006191253.B00874B22@keescook>
References: <202006191236.AC3E22AAB@keescook>
 <CALCETrXM5gneAC40RLWyjnCeHE6JFVOKnM0ooKLooGGaVV1KOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mips-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CALCETrXM5gneAC40RLWyjnCeHE6JFVOKnM0ooKLooGGaVV1KOA@mail.gmail.com>
Sender: linux-mips-owner@vger.kernel.org
To: Andy Lutomirski <luto@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Arnd Bergmann <arnd@arndb.de>, Will Drewry <wad@chromium.org>, "open list:MIPS" <linux-mips@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Fri, Jun 19, 2020 at 12:42:14PM -0700, Andy Lutomirski wrote:
> On Fri, Jun 19, 2020 at 12:37 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > The terminator for the mode 1 syscalls list was a 0, but that could be
> > a valid syscall number (e.g. x86_64 __NR_read). By luck, __NR_read was
> > listed first and the loop construct would not test it, so there was no
> > bug. However, this is fragile. Replace the terminator with -1 instead,
> > and make the variable name for mode 1 syscall lists more descriptive.
> 
> Could the architecture instead supply the length of the list?

It could, but I didn't like the way the plumbing for that looked.

-- 
Kees Cook
