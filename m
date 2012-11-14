From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v3 00/11] m68k: use asm-generic headers when possible
Date: Wed, 14 Nov 2012 08:56:43 +0100
Message-ID: <CAMuHMdVWaxjGYFXHwK6-CPUA3YFZ2x7k11FpPhMyudHt0xVa4g@mail.gmail.com>
References: <1351578277-31882-1-git-send-email-gerg@snapgear.com>
	<CAMuHMdXbwBLhryrcJ5Ln3uvBJL=_ZCYBErXyZzGznBirobU1kQ@mail.gmail.com>
	<50A078CC.7080406@snapgear.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <50A078CC.7080406@snapgear.com>
Sender: linux-m68k-owner@vger.kernel.org
To: Greg Ungerer <gerg@snapgear.com>
Cc: linux-m68k@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Hi Greg,

On Mon, Nov 12, 2012 at 5:19 AM, Greg Ungerer <gerg@snapgear.com> wrote:
> On 11/11/12 20:30, Geert Uytterhoeven wrote:
>> On Tue, Oct 30, 2012 at 7:24 AM,  <gerg@snapgear.com> wrote:
>>> Quite a few of the m68k asm headers are identical to the asm-generic
>>> versions. So switch to using them where ever we can.
>>>
>>> v2 is rebased on top of 3.7-rc3.
>>> v3 keep those in uapi/asm in uapi/asm (not moved to asm-generic)
>>>
>>> All defconfigs build. Run tested on ColdFire (with and without MMU) and
>>> on
>>> ArranyM.
>>
>>
>> Thanks!
>>
>> Do you want me to queue these for 3.8, or take them yourselves?
>> In the latter case:
>> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
>
>
> I don't really mind either way. Happy for you to take them
> if that is your preference.
>
> Same goes for the mm/init.c changes too. Happy for you to
> take them if you want.

I applied all of them to master, and queued them in for-3.8/for-next, so they
will be picked up by tomorrow's linux-next, which is the last one before
next-20121126.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
