From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 11/31] nds32: Atomic operations
Date: Wed, 8 Nov 2017 09:54:25 +0100
Message-ID: <CAK8P3a3w4gfO-VMM+L5J5+kSbBD_Kr0iv3BndF_3tt2QTuEFRw@mail.gmail.com>
References: <cover.1510118606.git.green.hu@gmail.com> <b13577a068afb71e87e21598f59733f127814f37.1510118606.git.green.hu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b13577a068afb71e87e21598f59733f127814f37.1510118606.git.green.hu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greentime Hu <green.hu@gmail.com>
Cc: greentime@andestech.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, Vincent Chen <vincentc@andestech.com>, Palmer Dabbelt <palmer@dabbelt.com>
List-Id: linux-arch.vger.kernel.org

On Wed, Nov 8, 2017 at 6:54 AM, Greentime Hu <green.hu@gmail.com> wrote:
> From: Greentime Hu <greentime@andestech.com>
>
> Signed-off-by: Vincent Chen <vincentc@andestech.com>
> Signed-off-by: Greentime Hu <greentime@andestech.com>
> ---
>  arch/nds32/include/asm/futex.h    |  116 ++++++++++++++++++++++++
>  arch/nds32/include/asm/spinlock.h |  178 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 294 insertions(+)
>  create mode 100644 arch/nds32/include/asm/futex.h
>  create mode 100644 arch/nds32/include/asm/spinlock.h


> diff --git a/arch/nds32/include/asm/spinlock.h b/arch/nds32/include/asm/spinlock.h
> new file mode 100644
> index 0000000..dd5fc71
> --- /dev/null
> +++ b/arch/nds32/include/asm/spinlock.h
> @@ -0,0 +1,178 @@
> +
> +#define arch_spin_unlock_wait(lock) \
> +       do { while (arch_spin_is_locked(lock)) cpu_relax(); } while (0)

This was removed from the other architectures in commit
952111d7db02 ("arch: Remove spin_unlock_wait() arch-specific definitions")

Please remove this as well.

Palmer, I see riscv has the same thing, please also add a patch to your
tree to remove it.

> +#define arch_spin_lock_flags(lock, flags) arch_spin_lock(lock)
> +
> +static inline void arch_spin_lock(arch_spinlock_t * lock)
> +{
> +       unsigned long tmp;
> +
> +       __asm__ __volatile__("1:\n"
> +                            "\tllw\t%0, [%1]\n"
> +                            "\tbnez\t%0, 1b\n"
> +                            "\tmovi\t%0, #0x1\n"
> +                            "\tscw\t%0, [%1]\n"
> +                            "\tbeqz\t%0, 1b\n"
> +                            :"=&r"(tmp)
> +                            :"r"(&lock->lock)
> +                            :"memory");

The coding style seems inconsistent here, the other inline asm uses real tabs
instead of \t, and 'asm volatile' is generally preferred over '__asm__
__volatile__'.

       Arnd
