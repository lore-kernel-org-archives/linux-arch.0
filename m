From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC][PATCH 0/4 v2] sycalls: Remove args i and n from syscall_get_arguments()
Date: Fri, 29 Mar 2019 10:24:58 -0700
Message-ID: <CAHk-=whtDB2HiEgyKcJPN7m8c83GrY=hQ=p-m-um1N6eSqxczg@mail.gmail.com>
References: <20190328230512.486297455@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190328230512.486297455@goodmis.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@amacapital.net>, Roland McGrath <roland@hack.frob.com>, Oleg Nesterov <oleg@redhat.com>, linux-arch <linux-arch@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, Dominik Brodowski <linux@dominikbrodowski.net>, Andy Lutomirski <luto@kernel.org>, Kees Cook <keescook@chromium.org>, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: linux-arch.vger.kernel.org

The whole series looks fine to me.

I still suspect that we should just remove the syscall_set_arguments()
thing entirely, but even without that, the cleanup of the calling
convention is at least an improvement.

                     Linus
