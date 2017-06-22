From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 1/5] kbuild: thin archives final link close
 --whole-archives option
Date: Fri, 23 Jun 2017 02:12:40 +1000
Message-ID: <20170623021240.396b2f63@roar.ozlabs.ibm.com>
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
        <20170621191607.33c8db74@roar.ozlabs.ibm.com>
        <CAK8P3a0NT42HKOU+ZDRg_-1hA+RzYnL0RtzqbMsLbY=yTUxGRA@mail.gmail.com>
        <20170621203824.719ffdc5@roar.ozlabs.ibm.com>
        <CAK8P3a1o91guXimc99sY3UOUjKTX5QxhQyOfY+j-x7MMCdRbdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a1o91guXimc99sY3UOUjKTX5QxhQyOfY+j-x7MMCdRbdw@mail.gmail.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Michal Marek <mmarek@suse.com>, Linus Torvalds <torvalds@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, kbuild test robot <fengguang.wu@intel.com>, Josh Triplett <josh@joshtriplett.org>, Nicolas Pitre <nicolas.pitre@linaro.org>
List-Id: linux-arch.vger.kernel.org

On Wed, 21 Jun 2017 12:49:10 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> On Wed, Jun 21, 2017 at 12:38 PM, Nicholas Piggin <npiggin@gmail.com> wrote:
> > On Wed, 21 Jun 2017 12:21:16 +0200
> > Arnd Bergmann <arnd@arndb.de> wrote:
> >  
> >> On Wed, Jun 21, 2017 at 11:16 AM, Nicholas Piggin <npiggin@gmail.com> wrote:  
> >> > On Wed, 21 Jun 2017 09:15:09 +0200
> >> > Arnd Bergmann <arnd@arndb.de> wrote:
> >> >  
> >> >> On Wed, Jun 21, 2017 at 6:04 AM, Nicholas Piggin <npiggin@gmail.com> wrote:  
> >> >> > On Wed, 21 Jun 2017 12:29:33 +0900
> >> >> > Masahiro Yamada <yamada.masahiro@socionext.com> wrote:  
> >> >>  
> >> >> >> BTW, I saw abuse of lib.a in
> >> >> >> https://patchwork.kernel.org/patch/9768439/
> >> >> >>
> >> >> >> I see it in linux-next.
> >> >> >>
> >> >> >> commit 06e226c7fb233f676b01b144d0b321ebe510fdcd
> >> >> >> Author: Stephen Boyd <sboyd@codeaurora.org>
> >> >> >> Date:   Fri Jun 2 15:30:06 2017 -0700
> >> >> >>
> >> >> >>     clk: sunxi-ng: Move all clock types to a library
> >> >> >>
> >> >> >>
> >> >> >>
> >> >> >>
> >> >> >> Now drivers/clk/sunxi-ng/lib.a
> >> >> >> will go into thin archives.
> >> >> >> The result might be different from what they expect...  
> >> >> >
> >> >> > Yes I see. With thin archives, that is just going to cause the
> >> >> > same behaviour as built-in.o (everything will be linked). So the
> >> >> > build should not break, but they won't get savings.
> >> >> >
> >> >> > Does it even save space with incremental linking? If the lib.a gets
> >> >> > linked into drivers/built-in.o, I wonder what happens then?  
> >> >>
> >> >> Ah, too bad. I thought we had found a way to use a library correctly
> >> >> here, but I just verified that indeed all the just gets linked into built-in.o
> >> >>
> >> >> I played around with it some more now, but without success: if I
> >> >> build sunxi-ng as a loadable module (using a few modifications),
> >> >> then the unneeded objects from lib.a are dropped as I had hoped,
> >> >> but for built-in code we now always include everything.
> >> >>
> >> >> I suppose that we can ignore this once we get
> >> >> LD_DEAD_CODE_DATA_ELIMINATION enabled on ARM, but
> >> >> until then, we have a code size regression.  
> >> >
> >> > I didn't follow the thread there, is it a regression caused by
> >> > thin archives, or just by removing the Kconfig symbol from each
> >> > file?  
> >>
> >> I thought it was the latter, but actually it only happens with thin
> >> archives,  
> >
> > Is this including these changes now in the kbuild tree?  
> 
> I'm building on top of yesterday's linux-next at the moment,
> with a number of my own patches applied
> 
> > I can take a look at ARM and try to get it at least to parity with
> > incremental link. Any particular config options required?  
> 
> This is the patch I am testing with:
> 
> https://pastebin.com/HQuhCEmK
> 
> I have not looked at that in a while, no idea if it works, or
> if it has known problems.
> 
> I last posted the patch in March for discussion:
> 
> https://patchwork.kernel.org/patch/9626207/

Your patch needs the KEEP annotations on the other exception table
bits to avoid that error.

After that it builds and no obvious sections or symbols are missing
but it would take more careful review.

diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index 7b9a7058c32c..218ab698970a 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -91,8 +91,8 @@ SECTIONS
                ARM_EXIT_DISCARD(EXIT_DATA)
                EXIT_CALL
 #ifndef CONFIG_MMU
-               *(.text.fixup)
-               *(__ex_table)
+               KEEP(*(.text.fixup))
+               KEEP(*(__ex_table))
 #endif
 #ifndef CONFIG_SMP_ON_UP
                *(.alt.smp.init)
@@ -144,7 +144,7 @@ SECTIONS
        __ex_table : AT(ADDR(__ex_table) - LOAD_OFFSET) {
                __start___ex_table = .;
 #ifdef CONFIG_MMU
-               *(__ex_table)
+               KEEP(*(__ex_table))
 #endif
                __stop___ex_table = .;
        }
