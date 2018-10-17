From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V9 14/21] csky: User access
Date: Wed, 17 Oct 2018 17:37:38 +0200
Message-ID: <CAK8P3a363-ucdqEtrkUah9NPrFtQV6eH=4G3fcQtHMyMStME5w@mail.gmail.com>
References: <cover.1539655731.git.ren_guo@c-sky.com> <1c0d8cddcdf15e5f397b3e42b76461e97d6e34ad.1539655732.git.ren_guo@c-sky.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1c0d8cddcdf15e5f397b3e42b76461e97d6e34ad.1539655732.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Guo Ren <ren_guo@c-sky.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, David Miller <davem@davemloft.net>, gregkh <gregkh@linuxfoundation.org>, Christoph Hellwig <hch@infradead.org>, Marc Zyngier <marc.zyngier@arm.com>, Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Rob Herring <robh@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, c-sky_gcc_upstream@c-sky.com
List-Id: linux-arch.vger.kernel.org

On Tue, Oct 16, 2018 at 5:05 AM Guo Ren <ren_guo@c-sky.com> wrote:
>
> The patch adds "user access from kernel" codes.
>
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/csky/include/asm/uaccess.h | 416 ++++++++++++++++++++++++++++++++++++++++
>  arch/csky/lib/usercopy.c        | 262 +++++++++++++++++++++++++
>  2 files changed, 678 insertions(+)
>  create mode 100644 arch/csky/include/asm/uaccess.h
>  create mode 100644 arch/csky/lib/usercopy.c

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

The 64-bit __put_user() is usually what everyone gets wrong, but
your version seems fine. Also the access_ok() checks and
the copy_to_user() result value all look correct.

        Arnd
