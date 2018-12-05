From: Firoz Khan <firoz.khan@linaro.org>
Subject: Re: [PATCH v3 0/6] mips: system call table generation support
Date: Wed, 5 Dec 2018 12:42:13 +0530
Message-ID: <CALxhOnhH8WmtBsJ_=qb03G-T4d+uZrc7xoOnjy9f8JunG-A-Jg@mail.gmail.com>
References: <1543481016-18500-1-git-send-email-firoz.khan@linaro.org>
 <CALxhOnjSEp++W5T3Sf0eX+8hPt08ER22M817M-Vhd24_96a_EQ@mail.gmail.com> <20181205063436.kzxgnvgexcgq572k@pburton-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181205063436.kzxgnvgexcgq572k@pburton-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Burton <paul.burton@mips.com>
Cc: "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Arnd Bergmann <arnd@arndb.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
List-Id: linux-arch.vger.kernel.org

Hi Paul,

On Wed, 5 Dec 2018 at 12:04, Paul Burton <paul.burton@mips.com> wrote:
>
> Hi Firoz,
>
> On Tue, Dec 04, 2018 at 09:33:08AM +0530, Firoz Khan wrote:
> > Could you review this patch series. I would appreciate if you can
> > perform the boot test on the actual platform.
>
> This is looking pretty good to me, so I look forward to v4 with Arnd's
> comments addressed.
>
> I've verified that the sys call tables are identical for both
> 32r2el_defconfig & 64r6el_defconfig before & after this series, and that
> both still boot fine.

Great, thanks for the update. will send v4 asap.

Firoz

>
> Thanks,
>     Paul
