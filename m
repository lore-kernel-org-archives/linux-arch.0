From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 5/5] m68k: add __IGNORE* entries in asm/unistd.h
Date: Mon, 1 Oct 2018 14:51:59 +0200
Message-ID: <CAK8P3a3_NjWWPnoNjg0cgoAMyYCuG4ABqy-z9CyjROjLGxeG3g@mail.gmail.com>
References: <1538397477-4003-1-git-send-email-firoz.khan@linaro.org> <1538397477-4003-6-git-send-email-firoz.khan@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1538397477-4003-6-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Firoz Khan <firoz.khan@linaro.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, gregkh <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
List-Id: linux-arch.vger.kernel.org

On Mon, Oct 1, 2018 at 2:39 PM Firoz Khan <firoz.khan@linaro.org> wrote:
>
> Add __IGNORE* entries for seccomp, pkey_mprotect, pkey_
> alloc, pkey_free, io_pgetevents and rseq in the file
> asm/unistd.h as it is correct to keep __IGNORE* entry in
> non uapi header asm/unistd.h while uapi/asm/unistd.h must
> hold information only useful for user space applications.
>
> Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
> ---
>  arch/m68k/include/asm/unistd.h | 7 +++++++
>  1 file changed, 7 insertions(+)

I think this one needs to be dropped, as I commented on a similar patch for
another architecture (I forget which one). We really should implemente all
the syscalls below, with the possible exception of the pkey calls.

Note that we even list pkey_* in architectures that don't support the feature.
See also the commit text for a60f7b69d92c ("generic syscalls: Wire up
memory protection keys syscalls")

     Arnd
