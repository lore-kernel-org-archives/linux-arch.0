From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 5/5] m68k: added __IGNORE* entries in asm/unistd.h
Date: Mon, 24 Sep 2018 09:05:57 +0200
Message-ID: <CAMuHMdVbxvQMT9qAaPx8GPjzdM5T52KQ2jTGB6bmA61q9BAXyg@mail.gmail.com>
References: <1537455973-12468-1-git-send-email-firoz.khan@linaro.org> <1537455973-12468-6-git-send-email-firoz.khan@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1537455973-12468-6-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: firoz.khan@linaro.org
Cc: linux-m68k <linux-m68k@lists.linux-m68k.org>, Greg KH <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Deepa Dinamani <deepa.kernel@gmail.com>, marcin.juszkiewicz@linaro.org
List-Id: linux-arch.vger.kernel.org

On Thu, Sep 20, 2018 at 5:07 PM Firoz Khan <firoz.khan@linaro.org> wrote:
> Added few __IGNORE* entries for seccomp, pkey_mprotect,
> pkey_alloc, pkey_free, io_pgetevents and rseq in the file
> asm/unistd.h as it is correct to keep __IGNORE* entry in
> non uapi header asm/unistd.h while uapi/asm/unistd.h must
> hold information only useful for user space applications.
>
> Signed-off-by: Firoz Khan <firoz.khan@linaro.org>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
