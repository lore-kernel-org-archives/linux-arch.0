From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 10/19] csky: Signal handling
Date: Mon, 26 Mar 2018 15:04:01 +0200
Message-ID: <CAK8P3a3p2nbBG-NM9X-DHc6U61s65M8-3XDyx0CRsADSZ+prqw@mail.gmail.com>
References: <cover.1521399976.git.ren_guo@c-sky.com> <f482eb9ffcebaf12595d5d6043953de221fda024.1521399976.git.ren_guo@c-sky.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f482eb9ffcebaf12595d5d6043953de221fda024.1521399976.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Guo Ren <ren_guo@c-sky.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Jason Cooper <jason@lakedaemon.net>, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org
List-Id: linux-arch.vger.kernel.org

On Sun, Mar 18, 2018 at 8:51 PM, Guo Ren <ren_guo@c-sky.com> wrote:
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> ---
>  arch/csky/include/uapi/asm/sigcontext.h |  33 +++
>  arch/csky/include/uapi/asm/signal.h     | 164 ++++++++++++++
>  arch/csky/kernel/signal.c               | 379 ++++++++++++++++++++++++++++++++
>  3 files changed, 576 insertions(+)

Please have a look at arch/riscv and arch/nds32 for this, I think it can be
simplified. This is an incompatible change of course, but when we change
the system call ABI anyway, that is the right time to do it.


> +#define NSIG           32
> +typedef unsigned long sigset_t;
> +
> +#endif /* __KERNEL__ */
> +
> +#define SIGHUP          1
> +#define SIGINT          2
> +#define SIGQUIT                 3
> +#define SIGILL          4
> +#define SIGTRAP                 5
> +#define SIGABRT                 6
> +#define SIGIOT          6
> +#define SIGBUS          7
> +#define SIGFPE          8
> +#define SIGKILL                 9
> +#define SIGUSR1                10
> +#define SIGSEGV                11
> +#define SIGUSR2                12
> +#define SIGPIPE                13

In particular the constants should come from the asm-generic headers
rather than being duplicated. If you need anything special, it may be
better to modify the generic headers.

        Arnd
