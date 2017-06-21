From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 1/5] kbuild: thin archives final link close
 --whole-archives option
Date: Wed, 21 Jun 2017 19:16:07 +1000
Message-ID: <20170621191607.33c8db74@roar.ozlabs.ibm.com>
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
        <20170621140445.4d6fd92a@roar.ozlabs.ibm.com>
        <CAK8P3a34gWKqPCFDAnWki4H-eyj50Xgar+YFT_+2Og-qJb_i8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a34gWKqPCFDAnWki4H-eyj50Xgar+YFT_+2Og-qJb_i8A@mail.gmail.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Michal Marek <mmarek@suse.com>, Linus Torvalds <torvalds@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, kbuild test robot <fengguang.wu@intel.com>, Josh Triplett <josh@joshtriplett.org>, Nicolas Pitre <nicolas.pitre@linaro.org>
List-Id: linux-arch.vger.kernel.org

On Wed, 21 Jun 2017 09:15:09 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> On Wed, Jun 21, 2017 at 6:04 AM, Nicholas Piggin <npiggin@gmail.com> wrote:
> > On Wed, 21 Jun 2017 12:29:33 +0900
> > Masahiro Yamada <yamada.masahiro@socionext.com> wrote:  
> 
> >> BTW, I saw abuse of lib.a in
> >> https://patchwork.kernel.org/patch/9768439/
> >>
> >> I see it in linux-next.
> >>
> >> commit 06e226c7fb233f676b01b144d0b321ebe510fdcd
> >> Author: Stephen Boyd <sboyd@codeaurora.org>
> >> Date:   Fri Jun 2 15:30:06 2017 -0700
> >>
> >>     clk: sunxi-ng: Move all clock types to a library
> >>
> >>
> >>
> >>
> >> Now drivers/clk/sunxi-ng/lib.a
> >> will go into thin archives.
> >> The result might be different from what they expect...  
> >
> > Yes I see. With thin archives, that is just going to cause the
> > same behaviour as built-in.o (everything will be linked). So the
> > build should not break, but they won't get savings.
> >
> > Does it even save space with incremental linking? If the lib.a gets
> > linked into drivers/built-in.o, I wonder what happens then?  
> 
> Ah, too bad. I thought we had found a way to use a library correctly
> here, but I just verified that indeed all the just gets linked into built-in.o
> 
> I played around with it some more now, but without success: if I
> build sunxi-ng as a loadable module (using a few modifications),
> then the unneeded objects from lib.a are dropped as I had hoped,
> but for built-in code we now always include everything.
> 
> I suppose that we can ignore this once we get
> LD_DEAD_CODE_DATA_ELIMINATION enabled on ARM, but
> until then, we have a code size regression.

I didn't follow the thread there, is it a regression caused by
thin archives, or just by removing the Kconfig symbol from each
file?

> Any other ideas for
> how this could be solved? We used to have a Kconfig symbol
> for each file, but those would frequently get out of sync.

Not really sure. Possibly the way to do it would be to plumb
lib-y through drivers/ as well (like obj-y is) so they can be
linked on their own for the final vmlinux link.

But that may be quite a bit of churn, so it may be better to
hold such changes until we see how LD_DEAD_CODE_DATA_ELIMINATION
works out.

Thanks,
Nick
