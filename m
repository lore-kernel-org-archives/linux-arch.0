From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 2/5] m68k: Replace NR_syscalls macro from asm/unistd.h
Date: Mon, 24 Sep 2018 09:02:33 +0200
Message-ID: <CAMuHMdW3pdx13sdDv3=7WbTt5Hse4MrGDHoCwhA3w7iJ29eAcw@mail.gmail.com>
References: <1537455973-12468-1-git-send-email-firoz.khan@linaro.org> <1537455973-12468-3-git-send-email-firoz.khan@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1537455973-12468-3-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: firoz.khan@linaro.org
Cc: linux-m68k <linux-m68k@lists.linux-m68k.org>, Greg KH <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Deepa Dinamani <deepa.kernel@gmail.com>, marcin.juszkiewicz@linaro.org
List-Id: linux-arch.vger.kernel.org

On Thu, Sep 20, 2018 at 5:06 PM Firoz Khan <firoz.khan@linaro.org> wrote:
> 1. Update NR_syscalls in asm/unistd.h manually by counting the
>    no.of system calls. No need to update NR_syscalls untill

until

(scripts/checkpatch.pl would have told you)


Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
