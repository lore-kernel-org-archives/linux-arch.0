From: Firoz Khan <firoz.khan@linaro.org>
Subject: Re: [PATCH v3 0/4] sparc: system call table generation support
Date: Mon, 19 Nov 2018 10:52:16 +0530
Message-ID: <CALxhOni2YmDX3zYx5a_MWvkfJic+UuMmZBV7sgppkXO5pZB_vw@mail.gmail.com>
References: <1542173191-24981-1-git-send-email-firoz.khan@linaro.org> <20181118.185913.65989390344960294.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181118.185913.65989390344960294.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
To: "David S . Miller" <davem@davemloft.net>
Cc: sparclinux <sparclinux@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
List-Id: linux-arch.vger.kernel.org

Hi David,

On Mon, 19 Nov 2018 at 08:29, David Miller <davem@davemloft.net> wrote:
>
> From: Firoz Khan <firoz.khan@linaro.org>
> Date: Wed, 14 Nov 2018 10:56:27 +0530
>
> > The purpose of this patch series is, we can easily
> > add/modify/delete system call table support by cha-
> > nging entry in syscall.tbl file instead of manually
> > changing many files. The other goal is to unify the
> > system call table generation support implementation
> > across all the architectures.
>  ...
>
> Series applied to sparc-next.

Sounds good. Thanks

Firoz
