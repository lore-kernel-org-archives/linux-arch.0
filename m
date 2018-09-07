From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] asm-generic: bug: add unlikely() to BUG_ON()
Date: Fri, 7 Sep 2018 22:41:00 +0200
Message-ID: <CAK8P3a3u0z+Rkt0=UUG04o-uNC_K1+N=h+_Ucd23N-r2H=fTLg@mail.gmail.com>
References: <20180907192119.4931-1-igor.stoppa@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180907192119.4931-1-igor.stoppa@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Igor Stoppa <igor.stoppa@gmail.com>
Cc: igor.stoppa@huawei.com, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Fri, Sep 7, 2018 at 9:21 PM Igor Stoppa <igor.stoppa@gmail.com> wrote:
>
> Add a hint to the compiler.
> If BUG_ON() is used instead of BUG(), it means that probably the
> preferred outcome is to not BUG().
>
> The optimization is disabled, in case CONFIG_PROFILE_ANNOTATED_BRANCHES
> is turned on.

This sounds like a good idea, as this is one of the more likely causes
of false-positive -Wmaybe-uninitialized warnings with
CONFIG_PROFILE_ANNOTATED_BRANCHES

Could you add a comment about -Wmaybe-uninitialized next to the definition?
Otherwise that is easily lost.

Also, I see that the file has two separate definitions of BUG_ON(), and the
other one does have an unlikely() in it already. Can you change both
to do the same thing with unlikely() or not unlikely()?

       Arnd
