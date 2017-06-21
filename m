From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 1/5] kbuild: thin archives final link close
 --whole-archives option
Date: Wed, 21 Jun 2017 09:19:13 -0700
Message-ID: <20170621161913.GY4493@codeaurora.org>
References: <20170621140445.4d6fd92a@roar.ozlabs.ibm.com>
 <CAK8P3a34gWKqPCFDAnWki4H-eyj50Xgar+YFT_+2Og-qJb_i8A@mail.gmail.com>
 <20170621191607.33c8db74@roar.ozlabs.ibm.com>
 <CAK8P3a0NT42HKOU+ZDRg_-1hA+RzYnL0RtzqbMsLbY=yTUxGRA@mail.gmail.com>
 <20170621203824.719ffdc5@roar.ozlabs.ibm.com>
 <CAK8P3a1o91guXimc99sY3UOUjKTX5QxhQyOfY+j-x7MMCdRbdw@mail.gmail.com>
 <20170621211002.44525d9b@roar.ozlabs.ibm.com>
 <CAK8P3a2A9fMrNZPWJft2t+52kmGkGgm3gv_fxJntjevWtJ69Zw@mail.gmail.com>
 <20170621220213.2b33d56d@roar.ozlabs.ibm.com>
 <CAK8P3a0nVPz=eLV8ET6BYR2Qs0H3PQZuhYsu4Cb_kJSPACrR9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kbuild-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAK8P3a0nVPz=eLV8ET6BYR2Qs0H3PQZuhYsu4Cb_kJSPACrR9w@mail.gmail.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Michal Marek <mmarek@suse.com>, Linus Torvalds <torvalds@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, kbuild test robot <fengguang.wu@intel.com>, Josh Triplett <josh@joshtriplett.org>, Nicolas Pitre <nicolas.pitre@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>
List-Id: linux-arch.vger.kernel.org

On 06/21, Arnd Bergmann wrote:
> On Wed, Jun 21, 2017 at 2:02 PM, Nicholas Piggin <npiggin@gmail.com> wrote:
> > On Wed, 21 Jun 2017 13:32:17 +0200
> > Arnd Bergmann <arnd@arndb.de> wrote:
> >
> >> On Wed, Jun 21, 2017 at 1:10 PM, Nicholas Piggin <npiggin@gmail.com> wrote:
> >> > On Wed, 21 Jun 2017 12:49:10 +0200
> >> > Arnd Bergmann <arnd@arndb.de> wrote:
> >> >
> >> >> On Wed, Jun 21, 2017 at 12:38 PM, Nicholas Piggin <npiggin@gmail.com> wrote:
> >> >> > On Wed, 21 Jun 2017 12:21:16 +0200
> >> >> > Arnd Bergmann <arnd@arndb.de> wrote:
> >> >> >
> >> >>
> >> >> I'm building on top of yesterday's linux-next at the moment,
> >> >> with a number of my own patches applied
> >> >>
> >> >> > I can take a look at ARM and try to get it at least to parity with
> >> >> > incremental link. Any particular config options required?
> >> >>
> >> >> This is the patch I am testing with:
> >> >>
> >> >> https://pastebin.com/HQuhCEmK
> >> >> I have not looked at that in a while, no idea if it works, or
> >> >> if it has known problems.
> >> >>
> >> >> I last posted the patch in March for discussion:
> >> >>
> >> >> https://patchwork.kernel.org/patch/9626207/
> >> >
> >> > Well I just mean the stuff now in kbuild/thin-ac, not the LD_DCDE.
> >> > Just want to try getting thin archives up to a point where there are
> >> > no serious regressions first.
> >>
> >> For my build testing, I have now reverted most of my patch and only
> >> left the 'select THIN_ARCHIVES'. I'll let you know if I run into problems.
> >
> > Okay. Currently with the patches in the kbuild tree, thin archives
> > actually does better than incremental linking for ARM (defconfig).
> >
> > 11651574        6090952  418616 18161142        1151df6 vmlinux.thinarc
> > 11656118        6095208  418952 18170278        11541a6 vmlinux.inc
> >
> > In mainline, thin archives is sub-optimal for lib-y libraries (just
> > pulls them all in). But now that I test it, even that is better than
> > incremental linking for ARM:
> >
> > 11653926        6090888  418620 18163434        11526ea vmlinux.thinarc
> >
> > I haven't grabbed that "clk: sunxi-ng: Move all clock types to a library"
> > patch yet to check. What tree is it in? I wonder if I could convince you
> > to drop that for now and bring it up on linux-kernel/linux-kbuild? I
> > think it's quite reasonable to reduce Kconfig hell of very fine grained
> > conditional compilation/linking if we can make the toolchain do it for
> > us. So we should consider how to support it nicely rather than having
> > such hacks IMO.
> 
> [adding Maxime and Stephen to cc]
> 
> Stephen,
> 
> The hack has come to bite us after all, with Nick's proposed change to
> CONFIG_THIN_ARCHIVES for all architectures, the entire lib.a file will
> end up being linked into each kernel that enables the directory.
> 
> I'm out of other ideas for fixing it, so it seems better to revert back to
> individual Kconfig options. Once we enable
> CONFIG_LD_DEAD_CODE_DATA_ELIMINATION (which is the
> next step after CONFIG_THIN_ARCHIVES), we can simply list
> all files, and the linker will drop all unused functions by itself.
> 

Ok. Can you send a revert patch to the list with some information
on why we can't do the hack anymore and also Cc lkml/kbuild
lists? The commit is in linux-next now as commit 06e226c7fb23
(clk: sunxi-ng: Move all clock types to a library, 2017-06-02).

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
