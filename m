From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] kbuild: provide include/asm/asm-prototypes.h for ARM
Date: Thu, 20 Oct 2016 10:23:58 +0200
Message-ID: <CAMuHMdUb+WKhYj7rB_4rut1Mi4ctLG+9ocjnYuv0c25uc75TqA@mail.gmail.com>
References: <20161017065131.GA27863@angband.pl> <6556201.qTG4Pa4aHk@wuerfel>
 <fafba13a-c64c-2578-534c-c344f18d0fc5@suse.com> <3114442.xCAy34UQCk@wuerfel>
 <20161019153159.GQ1041@n2100.armlinux.org.uk> <CAMuHMdXUJ2QcspSQrnWuCzQG7oJ6sCuAuHV0+ftB0oVTL3zeQA@mail.gmail.com>
 <20161020082004.GU1041@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <20161020082004.GU1041@n2100.armlinux.org.uk>
Sender: linux-kbuild-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>, Michal Marek <mmarek@suse.com>, Nicholas Piggin <npiggin@gmail.com>, Adam Borowski <kilobyte@angband.pl>, Omar Sandoval <osandov@osandov.com>, Linus Torvalds <torvalds@linux-foundation.org>, Alexey Dobriyan <adobriyan@gmail.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Al Viro <viro@zeniv.linux.org.uk>, linux-kbuild <linux-kbuild@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

Hi Russell,

On Thu, Oct 20, 2016 at 10:20 AM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Thu, Oct 20, 2016 at 09:37:30AM +0200, Geert Uytterhoeven wrote:
>> On Wed, Oct 19, 2016 at 5:32 PM, Russell King - ARM Linux
>> <linux@armlinux.org.uk> wrote:
>> > I'm not in favour of this.
>> >
>> >    +extern void mmioset(void *, unsigned int, size_t);
>> >    +extern void mmiocpy(void *, const void *, size_t);
>> >    +
>> >     #ifndef __ARMBE__
>> >     static inline void memset_io(volatile void __iomem *dst, unsigned c,
>> >            size_t count)
>> >     {
>> >    -       extern void mmioset(void *, unsigned int, size_t);
>> >            mmioset((void __force *)dst, c, count);
>> >     }
>> >
>> > The reason they're declared _within_ memset_io() is to prevent people
>> > from using them by hiding their declaration.  Moving them outside is
>> > an open invitation to stupid people starting to use them as an "oh it
>> > must be an official API".
>>
>> If they're not intended for public use, they should (also) be prefixed
>> with "__" or even "____" to make this clear.
>
> Tried that with the __cpuc_* cache flushing interfaces.  It doesn't
> have any effect what so ever.

it may not stop the deliberate abuser, but it hints the casual reviewer.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
