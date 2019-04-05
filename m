From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 0/6 v3] sycalls: Remove args i and n from
 syscall_get_arguments()
Date: Fri, 5 Apr 2019 10:07:49 -0400
Message-ID: <20190405100749.56bf86a2@gandalf.local.home>
References: <20190401134104.676620247@goodmis.org>
 <20190404092803.1bffd135@gandalf.local.home>
 <CAHk-=wh1wv_g2cW07OG1n5oHFXxZUc2192ZQ+6p5Cj+46FDQVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHk-=wh1wv_g2cW07OG1n5oHFXxZUc2192ZQ+6p5Cj+46FDQVQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@amacapital.net>, Roland McGrath <roland@hack.frob.com>, Oleg Nesterov <oleg@redhat.com>, linux-arch <linux-arch@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, Dominik Brodowski <linux@dominikbrodowski.net>, Andy Lutomirski <luto@kernel.org>, Kees Cook <keescook@chromium.org>, "Eric W. Biederman" <ebiederm@xmission.com>, "Dmitry V. Levin" <ldv@altlinux.org>
List-Id: linux-arch.vger.kernel.org

On Thu, 4 Apr 2019 15:24:16 -1000
Linus Torvalds <torvalds@linux-foundation.org> wrote:


> I assume you've actually used this and can trace system calls with
> arguments properly, so that it's all tested at least on x86-64?
>

Yep, and even tested it against strace. Looks fine. I also ran it
through my entire ftrace test suite (takes around 10 hours or more),
and it all passed.

I'll collect the last bit of acks and then send you a pull request.

-- Steve
