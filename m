From: Alexander Potapenko <glider@google.com>
Subject: Re: [PATCH 1/5] include/linux: Add instrumented.h infrastructure
Date: Mon, 20 Jan 2020 15:25:23 +0100
Message-ID: <CAG_fn=VyL3t0L-ZhRtc41+fcipmSWrhwb+QFkRZ+ZeZQ=X_dLg@mail.gmail.com>
References: <20200120141927.114373-1-elver@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200120141927.114373-1-elver@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marco Elver <elver@google.com>
Cc: paulmck@kernel.org, Andrey Konovalov <andreyknvl@google.com>, Dmitriy Vyukov <dvyukov@google.com>, kasan-dev <kasan-dev@googlegroups.com>, LKML <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, will@kernel.org, Peter Zijlstra <peterz@infradead.org>, boqun.feng@gmail.com, Arnd Bergmann <arnd@arndb.de>, Al Viro <viro@zeniv.linux.org.uk>, christophe.leroy@c-s.fr, Daniel Axtens <dja@axtens.net>, mpe@ellerman.id.au, Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Ingo Molnar <mingo@kernel.org>, christian.brauner@ubuntu.com, daniel@iogearbox.net, cyphar@cyphar.com, Kees Cook <keescook@chromium.org>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Mon, Jan 20, 2020 at 3:19 PM Marco Elver <elver@google.com> wrote:
>
> This adds instrumented.h, which provides generic wrappers for memory
> access instrumentation that the compiler cannot emit for various
> sanitizers. Currently this unifies KASAN and KCSAN instrumentation. In
> future this will also include KMSAN instrumentation.
>
> Note that, copy_{to,from}_user require special instrumentation,
> providing hooks before and after the access, since we may need to know
> the actual bytes accessed (currently this is relevant for KCSAN, and is
> also relevant in future for KMSAN).
>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Marco Elver <elver@google.com>
Acked-by: Alexander Potapenko <glider@google.com>
