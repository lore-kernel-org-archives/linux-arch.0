From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] futex: generic arch_futex_atomic_op_inuser() cleanup
Date: Tue, 16 Jul 2019 14:46:25 +0200
Message-ID: <CAK8P3a208iz_Ra2CwsRvCmcDiQcUFyAO54SNrH3B+dRqpw9ykg@mail.gmail.com>
References: <alpine.DEB.2.21.1907151513450.1722@nanos.tec.linutronix.de> <12bdaca8-99eb-e576-f842-5970ab1d6a92@virtuozzo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <12bdaca8-99eb-e576-f842-5970ab1d6a92@virtuozzo.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vasily Averin <vvs@virtuozzo.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Tue, Jul 16, 2019 at 8:22 AM Vasily Averin <vvs@virtuozzo.com> wrote:
>
> generic smp version of arch_futex_atomic_op_inuser() always returns -ENOSYS
>
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>

I see what you mean now, I got confused earlier when I looked at the
non-SMP version of the same function.
