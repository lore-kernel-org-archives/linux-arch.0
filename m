From: Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH V3 21/26] dt-bindings: interrupt-controller: C-SKY APB
 intc
Date: Sat, 8 Sep 2018 10:05:46 +0800
Message-ID: <20180908020545.GA29088@guoren-Inspiron-7460>
References: <cover.1536138304.git.ren_guo@c-sky.com>
 <62dae1828ade759584bbf1507fe4a9e69d247a50.1536138304.git.ren_guo@c-sky.com>
 <CABGGiswB5OUU7JDP+-s3s8ONkXZY2AAvSijQedsNtZ6p8LqZeA@mail.gmail.com>
 <20180906021254.GC29405@guoren-Inspiron-7460>
 <CAK8P3a3h4KxkvAXZV+=7T6vdiQdOd0quos9BUtX-E=Q2H_0rfA@mail.gmail.com>
 <CAL_JsqLhLdoGO=WNHZ0aRxXD4dqZhXHxB7Y1q651ABXi_kOXEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAL_JsqLhLdoGO=WNHZ0aRxXD4dqZhXHxB7Y1q651ABXi_kOXEQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, "open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Jason Cooper <jason@lakedaemon.net>, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, wbx@uclibc-ng.org, Greentime Hu <green.hu@gmail.com>
List-Id: linux-arch.vger.kernel.org

On Fri, Sep 07, 2018 at 10:13:13AM -0500, Rob Herring wrote:
> On Thu, Sep 6, 2018 at 8:05 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Thu, Sep 6, 2018 at 4:13 AM Guo Ren <ren_guo@c-sky.com> wrote:
> > >
> > > On Wed, Sep 05, 2018 at 07:43:10PM -0500, Rob Herring wrote:
> > > > On Wed, Sep 5, 2018 at 7:10 AM Guo Ren <ren_guo@c-sky.com> wrote:
> > > > >
> > > > > Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> > > > > +
> > > > > +       intc: interrupt-controller {
> > > >
> > > > Needs a unit-address.
> > > Ok, change it to:
> > >             intc: interrupt-controller@0x00500000 {
> >
> > The unit address has no leading 0x or leading zeroes, so
> > interrupt-controller@500000
> 
> Please build your dts files with W=12 and it will tell you this and
> other errors. And then update any examples based on that.
Got it, thx for the tip.

 Guo Ren
