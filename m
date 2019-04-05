From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/6 v3] sycalls: Remove args i and n from syscall_get_arguments()
Date: Thu, 4 Apr 2019 15:24:16 -1000
Message-ID: <CAHk-=wh1wv_g2cW07OG1n5oHFXxZUc2192ZQ+6p5Cj+46FDQVQ@mail.gmail.com>
References: <20190401134104.676620247@goodmis.org> <20190404092803.1bffd135@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190404092803.1bffd135@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@amacapital.net>, Roland McGrath <roland@hack.frob.com>, Oleg Nesterov <oleg@redhat.com>, linux-arch <linux-arch@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, Dominik Brodowski <linux@dominikbrodowski.net>, Andy Lutomirski <luto@kernel.org>, Kees Cook <keescook@chromium.org>, "Eric W. Biederman" <ebiederm@xmission.com>, "Dmitry V. Levin" <ldv@altlinux.org>
List-Id: linux-arch.vger.kernel.org

On Thu, Apr 4, 2019 at 3:28 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Is this something that can go into this -rc release or would you want
> me to wait till the next merge window?
>
> The reason I ask, is that there's two arch patches in this series that
> have stable tags attached to them. But I moved things around such that
> they are applied before the global arch patches are and can be applied
> independently.
>
> Should I move those two patches up front and just add those to this
> release cycle, or would you like the entire series now?

I think I can take the entire series. It's removing code and fixing a
couple of bugs in the process. Even if not all changes are pure fixes,
it looks good to me.

I assume you've actually used this and can trace system calls with
arguments properly, so that it's all tested at least on x86-64?

                    Linus
