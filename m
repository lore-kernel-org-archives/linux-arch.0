From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 1/5] kbuild: thin archives final link close
 --whole-archives option
Date: Fri, 23 Jun 2017 01:50:21 +1000
Message-ID: <20170623015021.58f74316@roar.ozlabs.ibm.com>
References: <CAK8P3a0NT42HKOU+ZDRg_-1hA+RzYnL0RtzqbMsLbY=yTUxGRA@mail.gmail.com>
        <20170621203824.719ffdc5@roar.ozlabs.ibm.com>
        <CAK8P3a1o91guXimc99sY3UOUjKTX5QxhQyOfY+j-x7MMCdRbdw@mail.gmail.com>
        <20170621211002.44525d9b@roar.ozlabs.ibm.com>
        <CAK8P3a2A9fMrNZPWJft2t+52kmGkGgm3gv_fxJntjevWtJ69Zw@mail.gmail.com>
        <20170621220213.2b33d56d@roar.ozlabs.ibm.com>
        <CAK8P3a0nVPz=eLV8ET6BYR2Qs0H3PQZuhYsu4Cb_kJSPACrR9w@mail.gmail.com>
        <20170621161913.GY4493@codeaurora.org>
        <20170622040838.1c63ebb7@roar.ozlabs.ibm.com>
        <CAK8P3a2vV10+ymS7vHybfhRf_DVvACOW4O2OZzyz+v75y2Ak4w@mail.gmail.com>
        <20170622061838.ljlmk4enzpvdlyyu@flea.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <20170622061838.ljlmk4enzpvdlyyu@flea.lan>
Sender: linux-kbuild-owner@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Stephen Boyd <sboyd@codeaurora.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Michal Marek <mmarek@suse.com>, Linus Torvalds <torvalds@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, kbuild test robot <fengguang.wu@intel.com>, Josh Triplett <josh@joshtriplett.org>, Nicolas Pitre <nicolas.pitre@linaro.org>
List-Id: linux-arch.vger.kernel.org

On Thu, 22 Jun 2017 08:18:38 +0200
Maxime Ripard <maxime.ripard@free-electrons.com> wrote:

> On Wed, Jun 21, 2017 at 10:55:06PM +0200, Arnd Bergmann wrote:
> > On Wed, Jun 21, 2017 at 8:08 PM, Nicholas Piggin <npiggin@gmail.com> wrote:  
> > > On Wed, 21 Jun 2017 09:19:13 -0700
> > > Stephen Boyd <sboyd@codeaurora.org> wrote:  
> > >> On 06/21, Arnd Bergmann wrote:
> > >>
> > >> Ok. Can you send a revert patch to the list with some information
> > >> on why we can't do the hack anymore and also Cc lkml/kbuild
> > >> lists? The commit is in linux-next now as commit 06e226c7fb23
> > >> (clk: sunxi-ng: Move all clock types to a library, 2017-06-02).
> > >>  
> > >
> > > I grabbed this patch and applied it to the kbuid/thin-ac tree. I tested
> > > with thin archives enabled and disabled with arm defconfig which ends up
> > > setting CONFIG_SUNXI_CCU=y.
> > >
> > > The patch makes no difference to vmlinux size whether using traditional
> > > incremental link, or thin archives (there is a small difference between
> > > inclink and thinarc but that's unrelated).
> > >
> > > So this thin archives change does not break your patch, it's just that
> > > it doesn't really do the right thing. I like the general idea, but we
> > > need to work out how to make it properly supported by the build system.
> > >
> > > With the patch applied, this is what the build system currently does:
> > >
> > > arm-linux-gnueabihf-ld -EL    -r -o drivers/clk/sunxi-ng/built-in.o drivers/clk/sunxi-ng/ccu-sun5i.o drivers/clk/sunxi-ng/ccu-sun6i-a31.o drivers/clk/sunxi-ng/ccu-sun8i-a23.o drivers/clk/sunxi-ng/ccu-sun8i-a33.o drivers/clk/sunxi-ng/ccu-sun8i-h3.o drivers/clk/sunxi-ng/ccu-sun8i-v3s.o drivers/clk/sunxi-ng/ccu-sun8i-r.o drivers/clk/sunxi-ng/ccu-sun9i-a80.o drivers/clk/sunxi-ng/ccu-sun9i-a80-de.o drivers/clk/sunxi-ng/ccu-sun9i-a80-usb.o drivers/clk/sunxi-ng/lib.a drivers/clk/sunxi-ng/lib-ksyms.o
> > >
> > > This incremental link pulls in all your lib.a objects and links them
> > > into built-in.o. They can no longer be selectively linked.  
> > 
> > I think the ARM defconfig actually needs all those objects because it
> > enables all the high-level drivers. You could try disabling e.g. all except
> > CONFIG_SUN8I_DE2_CCU if you want the objects to actually becomes
> > unused.  
> 
> You can also disable MACH_SUN8I, it should disable a significant
> number of the clocks driver.

   text	   data	    bss	    dec	    hex	filename
11655078	6018736	 418944	18092758	11412d6	vmlinux.inclink
11655078	6018736	 418944	18092758	11412d6	vmlinux.inclink.clk
11650534	6010288	 418616	18079438	113dece	vmlinux.thinarc
11650534	6010288	 418616	18079438	113dece	vmlinux.thinarc.clk

Same result for me when compiling defconfig minus MACH_SUN8I, comparing
+/- the clock patch and thin archives. No size savings. As I explained
already, I really can't see how there could be any saving if the lib.a is
incrementally linked into built-in.o.

