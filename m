From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 1/5] kbuild: thin archives final link close
 --whole-archives option
Date: Wed, 21 Jun 2017 14:04:45 +1000
Message-ID: <20170621140445.4d6fd92a@roar.ozlabs.ibm.com>
References: <20170609052417.561-1-npiggin@gmail.com>
        <20170609052417.561-2-npiggin@gmail.com>
        <CAK7LNASxuE-6eMk+Y-vyrMfibtYoD2JkjNS2z8QF85x9NdiiaA@mail.gmail.com>
        <20170619165100.3ce26d00@roar.ozlabs.ibm.com>
        <CAK7LNARuuQzGkYBdzoy3bVpBuNPZEMGerHSEdmrH+PqK0Gbyzg@mail.gmail.com>
        <20170619182714.2cb60e17@roar.ozlabs.ibm.com>
        <CAK7LNATznx=5A1KnhkFHpjencsJj7AGUsHtDUu6M-Qkw=jvpPQ@mail.gmail.com>
        <20170620015205.329519b2@roar.ozlabs.ibm.com>
        <CAK7LNAS6zucv54-XwqfTbm=y20eFVQYLwgsVCdtS7mYknsYK+Q@mail.gmail.com>
        <20170621124708.6bce7692@roar.ozlabs.ibm.com>
        <CAK7LNATPyoVcsDtFjRhdmFh7v_HE9F=2GVX=z+XVWV2fXsEukA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33040 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752786AbdFUEFJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 21 Jun 2017 00:05:09 -0400
In-Reply-To: <CAK7LNATPyoVcsDtFjRhdmFh7v_HE9F=2GVX=z+XVWV2fXsEukA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Michal Marek <mmarek@suse.com>, Linus Torvalds <torvalds@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, kbuild test robot <fengguang.wu@intel.com>, Josh Triplett <josh@joshtriplett.org>, Nicolas Pitre <nicolas.pitre@linaro.org>, Arnd Bergmann <arnd@arndb.de>

On Wed, 21 Jun 2017 12:29:33 +0900
Masahiro Yamada <yamada.masahiro@socionext.com> wrote:

> Hi Nicholas,
> 
> 
> 2017-06-21 11:47 GMT+09:00 Nicholas Piggin <npiggin@gmail.com>:
> > I wonder if the names could be a bit more descriptive?
> >
> > libs-y-liba
> > libs-y-builtin
> >
> > ?  
> 
> I do not have a strong opinion.  Either way sounds OK to me.
> If you like, I can fix it up.

I have nothing against it if you want to clean it up. You're the
maintainer so whatever you prefer :)

> I think you mentioned LD_DEAD_CODE_DATA_ELIMINATION is under way for
> ARM and x86.

Yes it seems to be quite successful. ARM and MIPS people are looking
at it, I have it working for powerpc and x86 quite easily. I will
send patches to arch maintainers if we get these thin archives changes
merged in the next window.

> If we can switch all architectures, lib.a will turn into built-in.o.  Correct?
> (I am not sure how difficult the global conversion is.)

Yes I think it should be no longer necessary.

The only problem with LD_DEAD_CODE_DATA_ELIMINATION is that it overloads
elf section names to pass data to the linker, so it's not 100% transparent.
In practice it's been very minor changes. On balance it will end up being
better than a whole lot of conditional compiling and linking workarounds
such as the one you mention below.

> BTW, I saw abuse of lib.a in
> https://patchwork.kernel.org/patch/9768439/
> 
> I see it in linux-next.
> 
> commit 06e226c7fb233f676b01b144d0b321ebe510fdcd
> Author: Stephen Boyd <sboyd@codeaurora.org>
> Date:   Fri Jun 2 15:30:06 2017 -0700
> 
>     clk: sunxi-ng: Move all clock types to a library
> 
> 
> 
> 
> Now drivers/clk/sunxi-ng/lib.a
> will go into thin archives.
> The result might be different from what they expect...

Yes I see. With thin archives, that is just going to cause the
same behaviour as built-in.o (everything will be linked). So the
build should not break, but they won't get savings.

Does it even save space with incremental linking? If the lib.a gets
linked into drivers/built-in.o, I wonder what happens then?

Thanks,
Nick
