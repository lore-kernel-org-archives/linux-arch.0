Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from conssluserg-03.nifty.com ([210.131.2.82]:59666 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726879AbeILUFY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Sep 2018 16:05:24 -0400
MIME-Version: 1.0
In-Reply-To: <2c5d00f99db07df1a8cc5168d62d5764544fb83e.camel@synopsys.com>
References: <0854f35e92c95e552721dc6a46f4ee2bc4020bc1.camel@synopsys.com>
 <CAK7LNAR0ghuhDXUqJ=nX0dtbtoOvFff9Eeu-hHWLkTONG09GAQ@mail.gmail.com> <2c5d00f99db07df1a8cc5168d62d5764544fb83e.camel@synopsys.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 12 Sep 2018 23:59:41 +0900
Message-ID: <CAK7LNAQy6FB_aeNmzmNbhk36i1kA+93U3C6i=XJJhz-=7jyuOg@mail.gmail.com>
Subject: Re: defconfig fails if CROSS_COMPILE is set while cross-gcc is not avaialble
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc: "keescook@chromium.org" <keescook@chromium.org>, "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>
Message-ID: <20180912145941.BCP0cgXd7r70w2X5GMiPy9XDGqHAXqom_2N_gdcn5Cg@z>

Hi Alexey,

2018-09-12 22:43 GMT+09:00 Alexey Brodkin <Alexey.Brodkin@synopsys.com>:
> Hi Masahiro,
>
> On Wed, 2018-09-12 at 21:53 +0900, Masahiro Yamada wrote:
>> Hi Alexey.
>>
>> 2018-09-12 21:08 GMT+09:00 Alexey Brodkin <Alexey.Brodkin@synopsys.com>:
>> > Hello Masahiro-san,
>> >
>> > Starting from kernel v4.17 it is no longer possible to install kernel =
headers
>> > for ARC architecture if there's no cross-toolchain in PATH.
>>
>>
>> Really?
>>
>> I can do 'make ARCH=3Darc headers_install'
>> with the latest Linus' tree.
>
> Indeed "headers_install" works that way but is it OK to install headers
> without previous configuration. In my experiment I don't see any differen=
ces
> though for example OpenEmbedded on configuration step of "linux-libc-head=
ers"
> do "ARCH=3Dxxx make allnoconfig", see
> https://github.com/openembedded/openembedded-core/blob/master/meta/recipe=
s-kernel/linux-libc-headers/linux-libc-headers.inc#L57
>
> That might be some legacy but I'm not really sure,
> worth asking OE people.
>
> For the record in Buildroot no configuration happens for Linux headers,
> see https://git.buildroot.org/buildroot/tree/package/linux-headers/linux-=
headers.mk#n106


Buildroot is right.

The exported headers should be independent of the kernel configuration.

The interface between user-space and kernel must be stable.
It is strange if it is changed depending on how you configure the kernel.





>> I see the following warnings, but possible to install kernel headers.
>>
>> ./scripts/gcc-version.sh: line 26: arc-linux-gcc: command not found
>> ./scripts/gcc-version.sh: line 27: arc-linux-gcc: command not found
>
> Right... that happens because we're doing 2 hackish things:
> 1. Checking if current toolchain is configured for ARCompact (ARCv1) ISA
>    or ARCv2. That's because we use toolchain's libgcc and so we want to w=
arn
>    a user if wrong toolchain is used early instead of leaving him to deal=
 with
>    final linkage failure.
>    See: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t/tree/arch/arc/Makefile#n23
>
> 2. Asking CC for a path to libgcc
>    See: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t/tree/arch/arc/Makefile#n82
>
> [snip]
>
>> I am trying to fix even those warnings
>> by eliminating unneeded compiler invocation.  It is WIP.
>
> And if (1) is not super important (in fact we used to live without it for=
 years)
> (2) requires implementation of libgcc in kernel sources (which BTW will m=
ake (1)
> obsolete immediately). We do have it on our todo list though...
> [snip]
>
>> > That doesn't happen for ARM and other arches simply because for ARC
>> > we define CROSS_COMPILE if it is not set by user, see:
>> >
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__git.kernel.org_pub=
_scm_linux_kernel_git_torvalds_linux.git_tree_arch_arc_Makefile-23n9&d=3DDw=
IBaQ&c=3DDPL6_X_6JkXFx7AXWqB0tg&r=3DlqdeeSSEes0GFDDl656eViXO7breS55ytWkhpk5=
R81I&m=3DzJsa5MrAtDiYEWr5PZNS1aGk21ETa-qXzLPIddwvoQI&s=3DBU0ltPPoRLn3np_ba4=
HRHfH9i141uZjoS8jsJrg8SNc&e=3D
>>
>> I do not think it is a good practice
>> to forcibly set CROSS_COMPILE that users may not have.
>
> Maybe so. Still some arches or random platforms do that.
>
>> arch/m68k/Makefile uses cc-cross-prefix helper
>> to set the first found compiler.
>
> Well I'm not really sure we need to mess with CROSS_COMPILE in kernel.
> I.e. there might be tons of variations depending on who toolchain was bui=
lt
> etc. So I'd better get rid of CROSS_COMPILE setup in our Makefile.


Agree.  Getting rid of CROSS_COMPILE is better.



>> > Still if CROSS_COMPILE is set before execution of "make defconfig"
>> > then the same problem happens for others.
>> >
>> > I was able to find a series of commits which cause this problem,
>> > here they are:
>> > ----------------------------->8--------------------------
>> > 59f53855babf - gcc-plugins: test plugin support in Kconfig and clean u=
p Makefile
>> > 469cb7376c06 - kconfig: add CC_IS_CLANG and CLANG_VERSION
>> > a4353898980c - kconfig: add CC_IS_GCC and GCC_VERSION
>> > ----------------------------->8--------------------------
>> >
>> > What happen is "$(CC)" is passed as an argument and in its turn CC is
>> > "$(CROSS_COMPILE)gcc", see:
>> >
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__git.kernel.org_pub=
_scm_linux_kernel_git_torvalds_linux.git_tree_Makefile-23n385&d=3DDwIBaQ&c=
=3DDPL6_X_6JkXFx7AXWqB0tg&r=3DlqdeeSSEes0GFDDl656eViXO7breS55ytWkhpk5R81I&m=
=3DzJsa5MrAtDiYEWr5PZNS1aGk21ETa-qXzLPIddwvoQI&s=3DS7zeHBpIp1P94XbyoMsaSnJW=
RqDGn69yGyeob-jzMJ4&e=3D
>> >
>> >
>> > So if I substitute "CC" with "HOSTCC" in a couple of places (see below=
)
>> > the problem goes away. But I'm not really sure if what I do is correct=
.
>> > I.e. when we're interested in CC for target and when only host CC is o=
f
>> > our interest.
>>
>> I think the log of commit 316d55d55f49eca44
>> is a good source to know the background of this change.
>>
>> Now Kconfig requires the target compiler.
>> So, it does not make sense to
>> do defconfig with non-existing compiler.
>
> Agree, so I'll check with OpenEmbedded people if there's a reason to do "=
make allnoconfig"
> if it's just a legacy code we'll fix it there.
>
> Thanks a lot for all the input, much appreciated!
>
> -Alexey



--=20
Best Regards
Masahiro Yamada
