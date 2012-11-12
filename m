From: Greg Ungerer <gerg@snapgear.com>
Subject: Re: [PATCH v3 00/11] m68k: use asm-generic headers when possible
Date: Mon, 12 Nov 2012 14:19:24 +1000
Message-ID: <50A078CC.7080406@snapgear.com>
References: <1351578277-31882-1-git-send-email-gerg@snapgear.com> <CAMuHMdXbwBLhryrcJ5Ln3uvBJL=_ZCYBErXyZzGznBirobU1kQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from dnvwsmailout1.mcafee.com ([161.69.31.173]:24185 "EHLO
	DNVWSMAILOUT1.mcafee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751526Ab2KLERD (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 11 Nov 2012 23:17:03 -0500
In-Reply-To: <CAMuHMdXbwBLhryrcJ5Ln3uvBJL=_ZCYBErXyZzGznBirobU1kQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@vger.kernel.org, linux-arch@vger.kernel.org

Hi Geert,

On 11/11/12 20:30, Geert Uytterhoeven wrote:
> Hi Greg,
>
> On Tue, Oct 30, 2012 at 7:24 AM,  <gerg@snapgear.com> wrote:
>> Quite a few of the m68k asm headers are identical to the asm-generic
>> versions. So switch to using them where ever we can.
>>
>> v2 is rebased on top of 3.7-rc3.
>> v3 keep those in uapi/asm in uapi/asm (not moved to asm-generic)
>>
>> All defconfigs build. Run tested on ColdFire (with and without MMU) and on
>> ArranyM.
>
> Thanks!
>
> Do you want me to queue these for 3.8, or take them yourselves?
> In the latter case:
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

I don't really mind either way. Happy for you to take them
if that is your preference.

Same goes for the mm/init.c changes too. Happy for you to
take them if you want.

Regards
Greg


>> ---
>>   arch/m68k/include/asm/Kbuild          |    4
>>   arch/m68k/include/asm/hw_irq.h        |    6 -
>>   arch/m68k/include/asm/shmparam.h      |    6 -
>>   arch/m68k/include/asm/spinlock.h      |    6 -
>>   arch/m68k/include/asm/termios.h       |   50 --------
>>   arch/m68k/include/uapi/asm/Kbuild     |   17 +-
>>   arch/m68k/include/uapi/asm/auxvec.h   |    4
>>   arch/m68k/include/uapi/asm/msgbuf.h   |   31 -----
>>   arch/m68k/include/uapi/asm/sembuf.h   |   25 ----
>>   arch/m68k/include/uapi/asm/shmbuf.h   |   42 -------
>>   arch/m68k/include/uapi/asm/socket.h   |   72 ------------
>>   arch/m68k/include/uapi/asm/sockios.h  |   13 --
>>   arch/m68k/include/uapi/asm/termbits.h |  201 ----------------------------------
>>   arch/m68k/include/uapi/asm/termios.h  |   44 -------
>>   14 files changed, 13 insertions(+), 508 deletions(-)
>
> Gr{oetje,eeting}s,
>
>                          Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                  -- Linus Torvalds
>
>
>


-- 
------------------------------------------------------------------------
Greg Ungerer  --  Principal Engineer        EMAIL:     gerg@snapgear.com
SnapGear Group, McAfee                      PHONE:       +61 7 3435 2888
8 Gardner Close                             FAX:         +61 7 3217 5323
Milton, QLD, 4064, Australia                WEB: http://www.SnapGear.com
