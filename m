From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V3 09/26] csky: VDSO and rt_sigreturn
Date: Thu, 6 Sep 2018 16:02:42 +0200
Message-ID: <CAK8P3a2z2=0qNWZft6rokx0i=8E5ZbEg1WL5HMYg_DE1wPvZQw@mail.gmail.com>
References: <cover.1536138304.git.ren_guo@c-sky.com> <0f6a6aa2e458df2c3734cf60a68e6f69f0eb1e68.1536138304.git.ren_guo@c-sky.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0f6a6aa2e458df2c3734cf60a68e6f69f0eb1e68.1536138304.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Guo Ren <ren_guo@c-sky.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Jason Cooper <jason@lakedaemon.net>, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, wbx@uclibc-ng.org, Greentime Hu <green.hu@gmail.com>
List-Id: linux-arch.vger.kernel.org

On Wed, Sep 5, 2018 at 2:08 PM Guo Ren <ren_guo@c-sky.com> wrote:

> +
> +       /*
> +        * __NR_rt_sigreturn must be 173
> +        * Because gcc/config/csky/linux-unwind.h use hard code to parse rt_sigframe.
> +        */
> +       err = setup_vdso_page(vdso->rt_signal_retcode);
> +       if (err) panic("Cannot set signal return code, err: %x.", err);

__NR_rt_sigreturn is 139

I think you need to update the comment, and probably check your gcc sources
to ensure it still does the right thing.

         Arnd
