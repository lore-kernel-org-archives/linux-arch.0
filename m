Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from conssluserg-06.nifty.com ([210.131.2.91]:40465 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbfKMIzM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Nov 2019 03:55:12 -0500
MIME-Version: 1.0
References: <1da2db04-da6a-cedb-e85a-6ded68dada82@163.com> <20191112123125.GD17835@willie-the-truck>
 <CAK7LNARA99UUTY2v6rS=Nb4Cg5pB4RsR0PogLqdT9uNLcH20ew@mail.gmail.com>
 <32a3b660-f4d2-268e-2206-d50073298c0c@iogearbox.net> <CAK7LNASR=R=gyuaMO=VzdXrY3gaQ_FVE4es60bzXf=9ASR2qUw@mail.gmail.com>
 <021e7b46-047e-d381-9dca-bd61db08e4f8@163.com> <CAK7LNARKh3-cAqsYgcxFwq9CGk-CgBfkiQgfNSULkxwO0xa2vw@mail.gmail.com>
 <ac4577d4-c0f2-9596-df6f-3fcc563bde3e@163.com> <CAK7LNATfK2pFnO2YV5zMLMxJGYyaj+f8w-k4K8xaoGbJ2Bd5eQ@mail.gmail.com>
 <50602386-68b1-be38-a022-0bcf9df6a54e@163.com>
In-Reply-To: <50602386-68b1-be38-a022-0bcf9df6a54e@163.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 13 Nov 2019 17:54:21 +0900
Message-ID: <CAK7LNAQ8h7zxhfndBqYRWXkaWVynH7GpBvDPLcVMZ1VEyUUX7A@mail.gmail.com>
Subject: Re: Question about "asm/rwonce.h: No such file or directory"
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Xiao Yang <ice_yangxiao@163.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Will Deacon <will@kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>
Message-ID: <20191113085421.0t3MUM6htH49ppWnxvWU0R21pfsAAV2wEjLNynsE1JA@z>

On Wed, Nov 13, 2019 at 5:36 PM Xiao Yang <ice_yangxiao@163.com> wrote:
>
> On 11/13/19 3:53 PM, Masahiro Yamada wrote:
> > On Wed, Nov 13, 2019 at 4:17 PM Xiao Yang <ice_yangxiao@163.com> wrote:
> >> On 11/13/19 2:57 PM, Masahiro Yamada wrote:
> >>> Sorry, I really do not understand what you are doing.
> >>>
> >>> include/linux/compiler.h is only for kernel-space.
> >>> Shrug if a user-land program includes it.
> >> Hi Masahiro,
> >>
> >> For building tools/bpf, it is good to fix the compiler error by Daniel's
> >> patch(i.e. use linux/filter from linux header).
> >>
> >> linux/compiler.h may be used by other code in kernel.  Is it possible to
> >> trigger the same error when the other code
> >>
> >> including linux/compiler.h is built? Is this kind of code able to find
> >> the location of <asm/rwonce.h>?
> >
> > <asm/rwonce.h> is also kernel-only header.
> >
> > The kernel code can find <asm/rwonce.h>, but user-land code cannot.
>
> Hi Masahiro,
>
> Sorry, I am not familar with it.
>
> Thanks a lot for your explanation and I have seen the LINUXINCLUDE
> variable in Makefile.
>
> I will try to send a patch as Daniel suggested.
>
> Best Regards,
>
> Xiao Yang
>

Hmm, digging into the git history,
this include path was added by the following commit:


commit d7475de58575c904818efa369c82e88c6648ce2e
Author: Kamal Mostafa <kamal@canonical.com>
Date:   Wed Nov 11 14:24:27 2015 -0800

    tools/net: Use include/uapi with __EXPORTED_HEADERS__

    Use the local uapi headers to keep in sync with "recently" added #define's
    (e.g. SKF_AD_VLAN_TPID).  Refactored CFLAGS, and bpf_asm doesn't need -I.

    Fixes: 3f356385e8a4 ("filter: bpf_asm: add minimal bpf asm tool")
    Signed-off-by: Kamal Mostafa <kamal@canonical.com>
    Acked-by: Daniel Borkmann <daniel@iogearbox.net>
    Signed-off-by: David S. Miller <davem@davemloft.net>



I am not sure how big a deal it is,
but it could be a problem on old distros??



-- 
Best Regards
Masahiro Yamada
