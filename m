From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V7 2/2] csky: remove irq_mapping from smp.c.
Date: Mon, 24 Sep 2018 22:23:14 +0200
Message-ID: <CAK8P3a2WLCZNZ_A1qPQuEQdxEyLKZj2EY2oHzG+_GTGiWEna7w@mail.gmail.com>
References: <cover.1537276837.git.ren_guo@c-sky.com> <ec95f397f52b8b5d9191b85d0d907a1a43d2e2c1.1537276837.git.ren_guo@c-sky.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ec95f397f52b8b5d9191b85d0d907a1a43d2e2c1.1537276837.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Guo Ren <ren_guo@c-sky.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, Greentime Hu <green.hu@gmail.com>
List-Id: linux-arch.vger.kernel.org

On Tue, Sep 18, 2018 at 3:48 PM Guo Ren <ren_guo@c-sky.com> wrote:
>
>  - remove irq_mapping from smp.c to irq-driver
>  - Add set_ipi_irq_mapping api to irq-driver
>  - update asm/smp.h
>
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>

The patch seems ok to me, but please try to improve the changelog comments.
Generally speaking, use full English sentences instead of an enumerated list,
and explain what the change is for rather than what you are doing. The text
you have here can easily be derived from looking at the code changes,
but I still don't understand what caused you to change it, and why this
is better than the previous version.

       Arnd
