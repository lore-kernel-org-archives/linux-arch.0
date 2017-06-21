From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH 1/5] kbuild: thin archives final link close
 --whole-archives option
Date: Wed, 21 Jun 2017 12:29:33 +0900
Message-ID: <CAK7LNATPyoVcsDtFjRhdmFh7v_HE9F=2GVX=z+XVWV2fXsEukA@mail.gmail.com>
References: <20170609052417.561-1-npiggin@gmail.com> <20170609052417.561-2-npiggin@gmail.com>
 <CAK7LNASxuE-6eMk+Y-vyrMfibtYoD2JkjNS2z8QF85x9NdiiaA@mail.gmail.com>
 <20170619165100.3ce26d00@roar.ozlabs.ibm.com> <CAK7LNARuuQzGkYBdzoy3bVpBuNPZEMGerHSEdmrH+PqK0Gbyzg@mail.gmail.com>
 <20170619182714.2cb60e17@roar.ozlabs.ibm.com> <CAK7LNATznx=5A1KnhkFHpjencsJj7AGUsHtDUu6M-Qkw=jvpPQ@mail.gmail.com>
 <20170620015205.329519b2@roar.ozlabs.ibm.com> <CAK7LNAS6zucv54-XwqfTbm=y20eFVQYLwgsVCdtS7mYknsYK+Q@mail.gmail.com>
 <20170621124708.6bce7692@roar.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <20170621124708.6bce7692@roar.ozlabs.ibm.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Michal Marek <mmarek@suse.com>, Linus Torvalds <torvalds@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, kbuild test robot <fengguang.wu@intel.com>, Josh Triplett <josh@joshtriplett.org>
List-Id: linux-arch.vger.kernel.org

Hi Nicholas,


2017-06-21 11:47 GMT+09:00 Nicholas Piggin <npiggin@gmail.com>:
> I wonder if the names could be a bit more descriptive?
>
> libs-y-liba
> libs-y-builtin
>
> ?

I do not have a strong opinion.  Either way sounds OK to me.
If you like, I can fix it up.


I think you mentioned LD_DEAD_CODE_DATA_ELIMINATION is under way for
ARM and x86.
If we can switch all architectures, lib.a will turn into built-in.o.  Correct?
(I am not sure how difficult the global conversion is.)




BTW, I saw abuse of lib.a in
https://patchwork.kernel.org/patch/9768439/

I see it in linux-next.

commit 06e226c7fb233f676b01b144d0b321ebe510fdcd
Author: Stephen Boyd <sboyd@codeaurora.org>
Date:   Fri Jun 2 15:30:06 2017 -0700

    clk: sunxi-ng: Move all clock types to a library




Now drivers/clk/sunxi-ng/lib.a
will go into thin archives.
The result might be different from what they expect...



-- 
Best Regards
Masahiro Yamada
