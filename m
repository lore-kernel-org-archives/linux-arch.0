From: Mike Frysinger <vapier@gentoo.org>
Subject: Re: [PATCH 1/2] asm-generic: add MMU variants of io.h functions
Date: Sat, 2 Jul 2011 13:04:05 -0400
Message-ID: <CAMjpGUeMqVzcAWKpAojZVbj9ywH+4HmW4Hx-8D1WQmTqPSNqQA@mail.gmail.com>
References: <1309622006-28343-1-git-send-email-jonas@southpole.se>
 <CAMjpGUfZwZu-ZCJj2cmq1w6B71-gQ8G27FpYdhseyq3hoZRL+Q@mail.gmail.com> <1309625250.24186.1224.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1309625250.24186.1224.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonas Bonn <jonas@southpole.se>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, liqin.chen@sunplusct.com, gxt@mprc.pku.edu.cn
List-Id: linux-arch.vger.kernel.org

On Sat, Jul 2, 2011 at 12:47, Jonas Bonn wrote:
> On Sat, 2011-07-02 at 12:38 -0400, Mike Frysinger wrote:
>> On Sat, Jul 2, 2011 at 11:53, Jonas Bonn wrote:
>> > +#ifdef CONFIG_MMU
>> > +#define xlate_dev_mem_ptr(p) =C2=A0 __va(p)
>> > +#else
>> > =C2=A0#define xlate_dev_mem_ptr(p) =C2=A0 ((void *) (p))
>> > +#endif
>>
>> i wonder if we could do:
>> #ifndef __va
>> #define __va(p) ((void *)(p))
>> #endif
>> #define xlate_dev_mem_ptr(p) =C2=A0 __va(p)
>> -mike
>
> This seems to introduce an artificial definition of a "virtual" addre=
ss
> for systems without an MMU, which strikes me as a bit odd. =C2=A0If t=
his is
> what people prefer, that's fine... I think I prefer the former varian=
t,
> though.

this isnt a problem.  we do this sort of thing in many places since
people develop under MMU and use the API that exists there.

however, i see that we already have __va() in asm-generic/page.h.  so
you can assume __va() exists.  so just change the existing definition
to:
#define xlate_dev_mem_ptr(p)   __va(p)
-mike
