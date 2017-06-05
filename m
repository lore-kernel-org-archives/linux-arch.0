From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] kbuild: provide THIN_ARCHIVES option for all
 architectures
Date: Mon, 5 Jun 2017 17:00:45 +1000
Message-ID: <20170605170045.11760813@roar.ozlabs.ibm.com>
References: <20170529081103.29999-1-npiggin@gmail.com>
        <CAK8P3a2umsN_fTLbRmMofFYBzfOSdfFTqYcKdtesAdXk9Dbwvg@mail.gmail.com>
        <CAK7LNATyoCkDgywEdvR1z5kaTR+Uur1gg7-FT-0fV_HLb7AxMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <CAK7LNATyoCkDgywEdvR1z5kaTR+Uur1gg7-FT-0fV_HLb7AxMg@mail.gmail.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: linux-arch.vger.kernel.org

On Mon, 5 Jun 2017 08:17:26 +0900
Masahiro Yamada <yamada.masahiro@socionext.com> wrote:

> Hi.
> 
> 2017-06-01 6:13 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
> > On Mon, May 29, 2017 at 10:11 AM, Nicholas Piggin <npiggin@gmail.com> wrote:  
> >> Supporting two different intermediate-artifact packaging schemes
> >> was only ever intended as a temporary transition.
> >>
> >> This has so far caused no problems for powerpc, after a small fix
> >> for how the arch invoked ar. So now allow any arch to select the
> >> option, continue defaulting to N.
> >>
> >> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> >> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> >> ---
> >> The next step will be to have archs always select THIN_ARCHIVES
> >> when they are known to work. Then remove the option entirely.
> >>
> >> x86 has always just worked for me, so that should be easy.  
> >
> > I have build-tested many thousand randconfig kernels on arm32 with
> > this option enabled, and did not run into build-time regressions
> > besides some initial problems from a broken binutils snapshot
> > (all released binutils versions should be fine).
> >  
> 
> 
> Please let me mention two advantages of using THIN_ARCHIVES.

[snip]

Thank you for the post. I ran it through 0day and found some issues
with a few archs that I'm working through. Some changes are needed to
the generic thin archives build scripts, and some arch tweaks required.
So it's not 100% trivial.

4.13 might still be a realistic target if I make some progress.

Thanks,
Nick
