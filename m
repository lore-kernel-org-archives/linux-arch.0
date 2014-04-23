From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 04/28] nios2: Exception handling
Date: Wed, 23 Apr 2014 09:20:42 +0200
Message-ID: <CAMuHMdX1xxuWhhBH0TKMtSEek5QDYchNVtC9QKoFQGr454_GVA@mail.gmail.com>
References: <1397824031-4892-1-git-send-email-lftan@altera.com>
	<1397824031-4892-4-git-send-email-lftan@altera.com>
	<201404221433.17861.arnd@arndb.de>
	<CAFiDJ58oeUtXR_gqud9pw55wojY6PJRQp8PAyEfpDL_Let7u=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <CAFiDJ58oeUtXR_gqud9pw55wojY6PJRQp8PAyEfpDL_Let7u=Q@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Ley Foon Tan <lftan@altera.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, cltang@codesourcery.com
List-Id: linux-arch.vger.kernel.org

Hi Ley,

On Wed, Apr 23, 2014 at 4:47 AM, Ley Foon Tan <lftan@altera.com> wrote:
> On Tue, Apr 22, 2014 at 8:33 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Friday 18 April 2014, Ley Foon Tan wrote:
>>> +static const struct file_operations misalign_fops = {
>>> +       .open           = proc_misaligned_open,
>>> +       .read           = seq_read,
>>> +       .llseek         = seq_lseek,
>>> +       .release        = single_release,
>>> +       .write          = proc_misaligned_write,
>>> +};
>>> +#endif /* CONFIG_PROC_FS */
>>
>> We really shouldn't be doing new architecture specific procfs files
>> any more. I suggest you drop this one for now, and add back the
>> functionality using perf or ftrace at a later point.
>
> Okay, will remove this.

MIPS and powerpc handle this through debugfs, cfr.
arch/mips/kernel/unaligned.c and arch/powerpc/kernel/traps.c.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
