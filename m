From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v3 00/16] genrtc removal
Date: Mon, 2 May 2016 10:45:52 +0200
Message-ID: <CAMuHMdV3ZHEKgv-LPPQdZzP8KBY-yiSoeJ-cAXy54qD04--LgA@mail.gmail.com>
References: <1461796470-1291527-1-git-send-email-arnd@arndb.de>
	<CAMuHMdUcrB38jL1_estfq5aK55UFUeF=4JciVGFqcE17pY9X7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdUcrB38jL1_estfq5aK55UFUeF=4JciVGFqcE17pY9X7g@mail.gmail.com>
Sender: linux-m68k-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Helge Deller <deller@gmx.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Rich Felker <dalias@libc.org>, David Howells <dhowells@redhat.com>, alpha <linux-alpha@vger.kernel.org>, Alessandro Zummo <a.zummo@towertech.it>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Parisc List <linux-parisc@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Linux-sh list <linux-sh@vger.kernel.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, RTCLINUX <rtc-linux@googlegroups.com>, Linux-Arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

Hi Arnd,

On Thu, Apr 28, 2016 at 9:48 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Thu, Apr 28, 2016 at 12:34 AM, Arnd Bergmann <arnd@arndb.de> wrote=
:
>> I ended up stuffing the two patch series into one, as they are now
>> more dependent on one another. This now thoroughly removes the
>> genrtc driver including the asm/rtc.h headers it uses. For all
>> architectures that still have a meaningful asm/rtc.h, this goes
>> through two stages:
>>
>> 1) make the rtc-generic implementation independent of asm/rtc.h
>> 2) remove the asm/rtc.h header and disallow the gen_rtc driver
>>
>> As the last step, the driver itself gets removed.
>
> In general, after fixing the minor nit:
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
>
> For the m68k bits:
> Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>

More build coverage uncovered two build failures on m68k due to "[PATCH=
 v3
02/16] rtc: cmos: move mc146818rtc code out of asm-generic/rtc.h":

bvme6000_defconfig:

    In file included from arch/m68k/bvme6000/rtc.c:19:
    include/linux/mc146818rtc.h: In function =E2=80=98mc146818_is_updat=
ing=E2=80=99:
    include/linux/mc146818rtc.h:138: error: implicit declaration of
function =E2=80=98CMOS_READ=E2=80=99
    include/linux/mc146818rtc.h: In function =E2=80=98mc146818_get_time=
=E2=80=99:
    include/linux/mc146818rtc.h:189: error: =E2=80=98RTC_ALWAYS_BCD=E2=80=
=99
undeclared (first use in this function)
    include/linux/mc146818rtc.h:189: error: (Each undeclared
identifier is reported only once
    include/linux/mc146818rtc.h:189: error: for each function it appear=
s in.)
    include/linux/mc146818rtc.h: In function =E2=80=98mc146818_set_time=
=E2=80=99:
    include/linux/mc146818rtc.h:279: error: =E2=80=98RTC_ALWAYS_BCD=E2=80=
=99
undeclared (first use in this function)
    include/linux/mc146818rtc.h:290: error: implicit declaration of
function =E2=80=98CMOS_WRITE=E2=80=99

mvme16x_defconfig:

    In file included from arch/m68k/mvme16x/rtc.c:18:
    include/linux/mc146818rtc.h: In function =E2=80=98mc146818_is_updat=
ing=E2=80=99:
    include/linux/mc146818rtc.h:138: error: implicit declaration of
function =E2=80=98CMOS_READ=E2=80=99
    include/linux/mc146818rtc.h: In function =E2=80=98mc146818_get_time=
=E2=80=99:
    include/linux/mc146818rtc.h:189: error: =E2=80=98RTC_ALWAYS_BCD=E2=80=
=99
undeclared (first use in this function)
    include/linux/mc146818rtc.h:189: error: (Each undeclared
identifier is reported only once
    include/linux/mc146818rtc.h:189: error: for each function it appear=
s in.)
    include/linux/mc146818rtc.h: In function =E2=80=98mc146818_set_time=
=E2=80=99:
    include/linux/mc146818rtc.h:279: error: =E2=80=98RTC_ALWAYS_BCD=E2=80=
=99
undeclared (first use in this function)
    include/linux/mc146818rtc.h:290: error: implicit declaration of
function =E2=80=98CMOS_WRITE=E2=80=99

These do not show up with a multi-platform config including Atari
support, as arch/m68k/include/asm/mc146818rtc.h provides a definition o=
f
CMOS_READ() if CONFIG_ATARI=3Dy.

=46ortunately the fixes are simple: replace <linux/mc146818rtc.h> by
<linux/rtc.h>. Will send patches to fix...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org

In personal conversations with technical people, I call myself a hacker=
=2E But
when I'm talking to journalists I just say "programmer" or something li=
ke that.
                                -- Linus Torvalds
