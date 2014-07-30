From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v4 0/5] x86: two-phase syscall tracing and seccomp
        fastpath
Date: Wed, 30 Jul 2014 17:32:59 +0200
Message-ID: <20140730153259.GA25478@redhat.com>
References: <cover.1406604806.git.luto@amacapital.net> <20140729192056.GA6308@redhat.com> <CALCETrX6P7SJQdgc0gTM7FLdwyT_Ld1MWvkLYpTO_2xsvBC9sA@mail.gmail.com> <CALCETrXHF5YzPQDvnJs=mFNm2Ff_FekGu_Y8-JyMaWh2hctR7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mips-bounce@linux-mips.org>
Content-Disposition: inline
In-Reply-To: <CALCETrXHF5YzPQDvnJs=mFNm2Ff_FekGu_Y8-JyMaWh2hctR7A@mail.gmail.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Andy Lutomirski <luto@amacapital.net>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>, Frederic Weisbecker <fweisbec@gmail.com>, LSM List <linux-security-module@vger.kernel.org>, Linux MIPS Mailing List <linux-mips@linux-mips.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Alexei Starovoitov <ast@plumgrid.com>, Will Drewry <wad@chromium.org>, Kees Cook <keescook@chromium.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On 07/29, Andy Lutomirski wrote:
>
> > SAVE_REST is 6 movq instructions and a subq.  FIXUP_TOP_OF_STACK is 7
> > movqs (and 8 if I ever get my way).  RESTORE_TOP_OF_STACK is 4.
> > RESTORE_REST is 6 movqs and an adsq.  So we're talking about avoiding
> > 21 movqs, and addq, and a subq.  That may be significant.  (And I
> > suspect that the difference is much larger on platforms like arm64,
> > but that's a separate issue.)

OK, thanks. We could probably simplify the logic in phase1 + phase2 if
it was a single function though.

> To put some more options on the table: there's an argument to be made
> that the whole fast-path/slow-path split isn't worth it.  We could
> unconditionally set up a full frame for all syscalls.  This means:

Or, at least, can't we allocate the full frame and avoid "add/sub %rsp"?

> This means:
...
> On the
> other hand, there's zero chance that this would be ready for 3.17.
>
> I'd tend to advocate for keeping the approach in my patches for now.

Yes, sure, I didn't try to convince you to change this code. Thanks.

Oleg.
