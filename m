Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:52635 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728583AbeJaLjo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 31 Oct 2018 07:39:44 -0400
Date: Wed, 31 Oct 2018 10:43:38 +0800
From: Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH V3 2/2] csky: use common dtb build rules
Message-ID: <20181031024336.GA10756@guoren-Inspiron-7460>
References: <d7007cad85bb06e0f4e081bc4daf6f0f79c81861.1540921794.git.ren_guo@c-sky.com>
 <3bbfd02a59c0a9865cf63ac454408c87cd9c7427.1540921794.git.ren_guo@c-sky.com>
 <CAL_JsqKsx6OqbW+Z8q=2CBC+dU99ay5ggT8eONxf1eCh+Jwkig@mail.gmail.com>
 <CAL_JsqKE4Nzcn7CXJTCuPkSWWn3qONcU=3WMQLK6xWptJQUE_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqKE4Nzcn7CXJTCuPkSWWn3qONcU=3WMQLK6xWptJQUE_A@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, "open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>, devicetree@vger.kernel.org

On Tue, Oct 30, 2018 at 02:22:48PM -0500, Rob Herring wrote:
> On Tue, Oct 30, 2018 at 2:10 PM Rob Herring <robh@kernel.org> wrote:
> >
> > On Tue, Oct 30, 2018 at 12:50 PM Guo Ren <ren_guo@c-sky.com> wrote:
> > >
> > > Remove the Kbuild rules in arch/csky and use common dtb build rules.
> > >
> > > This modification is based on:
> > >
> > > commit 37c8a5fafa3b ("kbuild: consolidate Devicetree dtb build rules")
> > >
> > > Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> > > Cc: Rob Herring <robh@kernel.org>
> > > Cc: Arnd Bergmann <arnd@arndb.de>
> > > ---
> > >  arch/csky/Makefile          | 11 +----------
> > >  arch/csky/boot/dts/Makefile |  3 ---
> > >  2 files changed, 1 insertion(+), 13 deletions(-)
> >
> > Reviewed-by: Rob Herring <robh@kernel.org>
> 
> BTW, it's not very not clear what the change from v2 was. In the
> future, please include a change log in each patch. Also, Arnd acked
> v2, so you should add those when posting a new version unless there's
> major changes, but don't post new versions just to add the
> acks/reviewed-bys. It doesn't really matter in this case as you are
> the maintainer and have to collect them, but generally the maintainers
> only collect acks on the version they apply and don't go looking at
> prior versions.
I sent "PATCH V2" too fast and there is no need for "PATCH V3" and I will
pay attention next time. Thanks for reminding.

Best Regards
 Guo Ren
