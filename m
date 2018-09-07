Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:59935 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725926AbeIGKTt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 7 Sep 2018 06:19:49 -0400
Date: Fri, 7 Sep 2018 13:40:01 +0800
From: Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH V3 21/26] dt-bindings: interrupt-controller: C-SKY APB
 intc
Message-ID: <20180907054001.GA16834@guoren>
References: <cover.1536138304.git.ren_guo@c-sky.com>
 <62dae1828ade759584bbf1507fe4a9e69d247a50.1536138304.git.ren_guo@c-sky.com>
 <CABGGiswB5OUU7JDP+-s3s8ONkXZY2AAvSijQedsNtZ6p8LqZeA@mail.gmail.com>
 <20180906021254.GC29405@guoren-Inspiron-7460>
 <CAK8P3a3h4KxkvAXZV+=7T6vdiQdOd0quos9BUtX-E=Q2H_0rfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3h4KxkvAXZV+=7T6vdiQdOd0quos9BUtX-E=Q2H_0rfA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Rob Herring <robh@kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Jason Cooper <jason@lakedaemon.net>, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, wbx@uclibc-ng.org, Greentime Hu <green.hu@gmail.com>
Message-ID: <20180907054001.Al-E70hHZRvTX-a0KxFO0fed20i6ChlFMxhlVs7q5QI@z>

On Thu, Sep 06, 2018 at 03:05:38PM +0200, Arnd Bergmann wrote:
> On Thu, Sep 6, 2018 at 4:13 AM Guo Ren <ren_guo@c-sky.com> wrote:
> >
> > On Wed, Sep 05, 2018 at 07:43:10PM -0500, Rob Herring wrote:
> > > On Wed, Sep 5, 2018 at 7:10 AM Guo Ren <ren_guo@c-sky.com> wrote:
> > > >
> > > > Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> > > > +
> > > > +       intc: interrupt-controller {
> > >
> > > Needs a unit-address.
> > Ok, change it to:
> >             intc: interrupt-controller@0x00500000 {
> 
> The unit address has no leading 0x or leading zeroes, so
> interrupt-controller@500000
Ok

 Guo Ren
