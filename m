From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 00/15] wire up renameat2 syscall for various archs
Date: Tue, 15 Apr 2014 09:45:38 +0200
Message-ID: <CAMuHMdVAR5he=PkMSQwSgJtT_u0XPP4j0dBeJxF-buFFhfv9iw@mail.gmail.com>
References: <1397211951-20549-1-git-send-email-miklos@szeredi.hu>
	<CAMuHMdVRUyo+PAQ8XUXuhZn1jk7T645aC=E274OjUOgNktBEJw@mail.gmail.com>
	<CAJfpeguwO_vkqHzk-UDooDdanGZoB3sr0pmJD5hGh2VAW1S5Dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJfpeguwO_vkqHzk-UDooDdanGZoB3sr0pmJD5hGh2VAW1S5Dw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

Hi Miklos,

On Mon, Apr 14, 2014 at 10:11 PM, Miklos Szeredi <miklos@szeredi.hu> wrote:
> On Mon, Apr 14, 2014 at 6:32 PM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> On Fri, Apr 11, 2014 at 12:25 PM, Miklos Szeredi <miklos@szeredi.hu> wrote:
>>> This series wires up the recently added renameat2 syscall for archs that are
>>> up-to-date in the sense that they appear to support the latest syscalls.  I
>>> haven't touched the rest of them..
>>>
>>> Plus three NR_syscalls miscalculation fixes.
>>
>> Do you plan to collect acks, and ask Linus to pull this series later, or
>> do you want each arch maintainer to take the patches for his/her pet
>> architecture?
>
> Whichever works best for you.
>
>> Note that I don't plan to send another pull request for 3.15 for m68k,
>> unless Something Really Bad happens.
>
> So, if that's okay, I'll send it off to Linus sometime later.

That's fine for me!

Thanks, it's been a while someone went through the hard work of adding
a syscall to all architectures ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
