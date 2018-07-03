From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH V2 01/19] csky: Build infrastructure
Date: Mon, 2 Jul 2018 21:33:51 -0600
Message-ID: <CABGGiswb+SmdAi9qV80Yum3Uf=ohrSMpZKWkvJXK8n=GjTzxhQ@mail.gmail.com>
References: <cover.1530465325.git.ren_guo@c-sky.com> <a26901aab87306c389e656a3ef200adfbc5195c0.1530465325.git.ren_guo@c-sky.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a26901aab87306c389e656a3ef200adfbc5195c0.1530465325.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ren_guo@c-sky.com
Cc: linux-arch@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Jason Cooper <jason@lakedaemon.net>, Arnd Bergmann <arnd@arndb.de>, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, Greentime Hu <green.hu@gmail.com>
List-Id: linux-arch.vger.kernel.org

On Sun, Jul 1, 2018 at 11:36 AM Guo Ren <ren_guo@c-sky.com> wrote:
>
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> ---

[...]

> +config CSKY_BUILTIN_DTB
> +       bool "Use kernel builtin dtb"
> +
> +config CSKY_BUILTIN_DTB_NAME
> +       string "kernel builtin dtb name"
> +       depends on CSKY_BUILTIN_DTB
> +endmenu

These options generally exist for backwards compatibility with legacy
bootloaders that don't support DT which shouldn't apply here given
this is a new arch. If we need this for other reasons, it should not
be an architecture specific option.

Rob
