From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 00/19] C-SKY(csky) Linux Kernel Port
Date: Mon, 26 Mar 2018 15:30:34 +0200
Message-ID: <CAK8P3a3KwvNpYUXG-CqfF7V0GQ3sv_CoPmajq_+06aqkLiUFXw@mail.gmail.com>
References: <cover.1521399976.git.ren_guo@c-sky.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1521399976.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Guo Ren <ren_guo@c-sky.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Jason Cooper <jason@lakedaemon.net>, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org
List-Id: linux-arch.vger.kernel.org

On Sun, Mar 18, 2018 at 8:51 PM, Guo Ren <ren_guo@c-sky.com> wrote:
> This patchset adds architecture support to Linux for C-SKY's 32-bit embedded
> CPU cores and the patches are based on linux-4.16-rc5.
>
> There are two ABI versions with several CPU cores in this patchset:
>   ABIv1: ck610 (16-bit instruction, 32-bit data path, VIPT Cache ...)
>   ABIv2: ck807 ck810 (16/32-bit variable length instruction, PIPT Cache ...)
>
> More information: http://en.c-sky.com
>
> I'm from Hangzhou,China C-SKY Microsystems and responsible for C-SKY Linux
> port. My development repo is github.com/c-sky/csky-linux and use buildroot
> as our CI-test enviornment. "LTP, Lmbench, uclibc-ng-test ..." will be tested
> for every commit. See here for more details:
>   https://gitlab.com/c-sky/buildroot/pipelines
>
> You can try C-SKY linux in a few steps:
>   $ git clone https://github.com/c-sky/buildroot.git
>   $ cd buildroot
>   $ make qemu_csky_ck807_uclibc_bt_defconfig
>   $ make
> It will download "linux uclibc-ng gcc binutils qemu busybox" source code and build
> them into one image. How to run, See:
>   https://github.com/c-sky/buildroot/blob/master/board/qemu/csky/readme.txt
>
> I've finished uClibc-ng.org upstream and "gcc glibc binutils qemu ..." upstream is
> on going and the source code is here:
>   https://github.com/c-sky
>
> It's my first patchset to linux and any feedback is welcome :)

Thanks for your submission. I had started reviewing it over a week
ago, but never
completed since I was travelling in the meantime. I've completed my first pass
now and will wait for a new version before I take a more detailed look.

Overall, it looks nice, but changing the rest of the system call interface will
take a while, this includes several points I've mentioned already, but
to clarify,
every file in arch/csky/include/uapi/asm/ needs to be carefully reviewed to
contain only the minimum required additions to the asm-generic version.

Changing the ABI will obviously get in the way of testing, but this should
be over as soon as the port is merged.

Another interesting question is the status of your toolchain support. I see your
github account contains binutils and gcc repositories, but they are not upstream
yet. Are you working on getting those included in the respective upstream
projects already?

      Arnd
