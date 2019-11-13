From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: Question about "asm/rwonce.h: No such file or directory"
Date: Wed, 13 Nov 2019 16:53:40 +0900
Message-ID: <CAK7LNATfK2pFnO2YV5zMLMxJGYyaj+f8w-k4K8xaoGbJ2Bd5eQ@mail.gmail.com>
References: <1da2db04-da6a-cedb-e85a-6ded68dada82@163.com> <20191112123125.GD17835@willie-the-truck>
 <CAK7LNARA99UUTY2v6rS=Nb4Cg5pB4RsR0PogLqdT9uNLcH20ew@mail.gmail.com>
 <32a3b660-f4d2-268e-2206-d50073298c0c@iogearbox.net> <CAK7LNASR=R=gyuaMO=VzdXrY3gaQ_FVE4es60bzXf=9ASR2qUw@mail.gmail.com>
 <021e7b46-047e-d381-9dca-bd61db08e4f8@163.com> <CAK7LNARKh3-cAqsYgcxFwq9CGk-CgBfkiQgfNSULkxwO0xa2vw@mail.gmail.com>
 <ac4577d4-c0f2-9596-df6f-3fcc563bde3e@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ac4577d4-c0f2-9596-df6f-3fcc563bde3e@163.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Xiao Yang <ice_yangxiao@163.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Will Deacon <will@kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>
List-Id: linux-arch.vger.kernel.org

On Wed, Nov 13, 2019 at 4:17 PM Xiao Yang <ice_yangxiao@163.com> wrote:
>
> On 11/13/19 2:57 PM, Masahiro Yamada wrote:
> > Sorry, I really do not understand what you are doing.
> >
> > include/linux/compiler.h is only for kernel-space.
> > Shrug if a user-land program includes it.
>
> Hi Masahiro,
>
> For building tools/bpf, it is good to fix the compiler error by Daniel's
> patch(i.e. use linux/filter from linux header).
>
> linux/compiler.h may be used by other code in kernel.  Is it possible to
> trigger the same error when the other code
>
> including linux/compiler.h is built? Is this kind of code able to find
> the location of <asm/rwonce.h>?


<asm/rwonce.h> is also kernel-only header.

The kernel code can find <asm/rwonce.h>, but user-land code cannot.




> Best Regards,
>
> Xiao Yang
>
>


-- 
Best Regards
Masahiro Yamada
