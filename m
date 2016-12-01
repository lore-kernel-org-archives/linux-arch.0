From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] x86/kbuild: enable modversions for symbols exported from asm
Date: Thu, 1 Dec 2016 10:26:07 -0800
Message-ID: <CA+55aFxg_s8k1LBmsXjpVYw=BKh8sNEuL3n6MhzZGTuUPKMOwg@mail.gmail.com>
References: <20161129131922.GA31466@angband.pl> <CA+55aFxCKgTrh1gS-cMyhBa0QoLW2DL2+DYxOAcA-Bd15H15vg@mail.gmail.com>
 <CA+55aFw7G1QJ0dwMXJKJqFVhVsWGsAdxZTOsmcCD7POUde2+dA@mail.gmail.com> <2899250.iZaPagXLk8@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <2899250.iZaPagXLk8@wuerfel>
Sender: linux-kbuild-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Adam Borowski <kilobyte@angband.pl>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Michal Marek <mmarek@suse.com>, Ben Hutchings <ben@decadent.org.uk>, Debian kernel maintainers <debian-kernel@lists.debian.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Thu, Dec 1, 2016 at 5:58 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>
> WARNING: EXPORT symbol "mcount" [arch/x86/entry/built-in.ko] version generation failed, symbol will not be versioned.
> WARNING: EXPORT symbol "mcount" [arch/x86/built-in.ko] version generation failed, symbol will not be versioned.
> WARNING: EXPORT symbol "cmpxchg8b_emu" [vmlinux] version generation failed, symbol will not be versioned.
> WARNING: EXPORT symbol "empty_zero_page" [vmlinux] version generation failed, symbol will not be versioned.
> WARNING: EXPORT symbol "mcount" [vmlinux] version generation failed, symbol will not be versioned.
> WARNING: EXPORT symbol "cmpxchg8b_emu" [vmlinux] version generation failed, symbol will not be versioned.
> WARNING: EXPORT symbol "empty_zero_page" [vmlinux] version generation failed, symbol will not be versioned.
> WARNING: EXPORT symbol "mcount" [vmlinux] version generation failed, symbol will not be versioned.
>
> Out of 12 randconfig builds that had CONFIG_MODVERSIONS enabled, all 12
> had this problem, though not always with all the symbols.

Well, the good news is that pretty fundamentally, if it's just the asm
symbls, those really don't have ABI's that change (or if they change,
it's such a fundamental change that everything else will likely have
changed too and we don't need to worry about one asm symbol crc - the
change will be caught by other symbols).

So I think the whole "we don't really care" approach should work fine.
The "let's make every symbol always be versioned" may just be too much
pain for no real gain.

            Linus
