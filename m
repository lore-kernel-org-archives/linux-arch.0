Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38750 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbfEaCYs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 30 May 2019 22:24:48 -0400
Received: by mail-pf1-f194.google.com with SMTP id a186so4468317pfa.5
        for <linux-arch@vger.kernel.org>; Thu, 30 May 2019 19:24:48 -0700 (PDT)
Date: Fri, 31 May 2019 12:24:27 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [mmotm:master 124/234] mm/vmalloc.c:520:6: error: implicit
 declaration of function 'p4d_large'; did you mean 'p4d_page'?
References: <201905310708.EAdSCJKR%lkp@intel.com>
In-Reply-To: <201905310708.EAdSCJKR%lkp@intel.com>
MIME-Version: 1.0
Message-Id: <1559269231.3e5ttes2dd.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, kbuild-all@01.org, Linux Memory Management List <linux-mm@kvack.org>, linux-arch@vger.kernel.org

kbuild test robot's on May 31, 2019 9:42 am:
> tree:   git://git.cmpxchg.org/linux-mmotm.git master
> head:   6f11685c34f638e200dd9e821491584ef5717d57
> commit: 91c106f5d623b94305af3fd91113de1cba768d73 [124/234] mm/vmalloc: hu=
gepage vmalloc mappings
> config: arm64-allyesconfig (attached as .config)
> compiler: aarch64-linux-gcc (GCC) 7.4.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbi=
n/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 91c106f5d623b94305af3fd91113de1cba768d73
>         # save the attached .config to linux build tree
>         GCC_VERSION=3D7.4.0 make.cross ARCH=3Darm64=20
>=20
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
>=20
> All errors (new ones prefixed by >>):
>=20
>    mm/vmalloc.c: In function 'vmap_range':
>    mm/vmalloc.c:325:19: error: 'start' undeclared (first use in this func=
tion); did you mean 'stat'?
>      flush_cache_vmap(start, end);
>                       ^~~~~
>                       stat
>    mm/vmalloc.c:325:19: note: each undeclared identifier is reported only=
 once for each function it appears in
>    mm/vmalloc.c: In function 'vmalloc_to_page':
>>> mm/vmalloc.c:520:6: error: implicit declaration of function 'p4d_large'=
; did you mean 'p4d_page'? [-Werror=3Dimplicit-function-declaration]
>      if (p4d_large(*p4d))
>          ^~~~~~~~~
>          p4d_page

Hmm, okay p?d_large I guess is not quite the right thing to use here. It
almost is, but it's tied to userspace/thp options.

What would people prefer to do here? We could have architectures that
define HAVE_ARCH_HUGE_VMAP to also provide p?d_huge_kernel() tests for
their kernel page tables?

Thanks,
Nick

=
