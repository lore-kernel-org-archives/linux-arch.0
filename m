From: Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH v1 4/4] xtensa: generate uapi header and syscall table
 header files
Date: Tue, 6 Nov 2018 12:24:10 -0800
Message-ID: <CAMo8BfJcUuC1tcrZNf+6_iRA0esj5QrGFViMMeR3NPw6G5GbFA@mail.gmail.com>
References: <1541080581-4072-1-git-send-email-firoz.khan@linaro.org>
 <1541080581-4072-5-git-send-email-firoz.khan@linaro.org> <CAMo8BfKaSUTMT0h2jRg2ysRnc2yvVT-3=-gq6pH-XpKm1iydQQ@mail.gmail.com>
 <CAK8P3a07Qtr3h0R83ec_7p6_tDxWtQ6qzUnAM=uR5RkGTkRkGQ@mail.gmail.com> <CALxhOnhN=erC=KpE55PHPx9u45QiAU+yxhGHZXGJ_7pV0a_=NQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CALxhOnhN=erC=KpE55PHPx9u45QiAU+yxhGHZXGJ_7pV0a_=NQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: firoz.khan@linaro.org
Cc: Arnd Bergmann <arnd@arndb.de>, Chris Zankel <chris@zankel.net>, linux-xtensa@linux-xtensa.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038@lists.linaro.org, LKML <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Deepa Dinamani <deepa.kernel@gmail.com>, marcin.juszkiewicz@linaro.org
List-Id: linux-arch.vger.kernel.org

Hi Firoz,

On Tue, Nov 6, 2018 at 7:12 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> My initial patches does have generated-y += unistd_32.h instead of
> generic-y += unistd_32.h.
> If I remember someone pointed out that this implementation doesn't
> look good. So I
> replaced to generic-y += unistd_32.h.

I've only found the following case, where you did the replacement:
  https://lkml.org/lkml/2018/8/9/177
and I'm pretty sure that Michal meant that only the missing newline
didn't look good.

> Sure, I'll change to generated-y += unistd_32.h instead of generic-y
> += unistd_32.h.
>
> Max, this looks ok. right?

Yes, generated-y looks goodto me.
Could you also please move the line
  generated-y += syscall_table.h
up, so that alphabetical order of the header names is preserved?

--
Thanks.
-- Max
