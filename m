From: Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH V3 19/26] dt-bindings: timer: gx6605s SOC timer
Date: Fri, 7 Sep 2018 14:41:49 +0800
Message-ID: <20180907064149.GA18512@guoren>
References: <cover.1536138304.git.ren_guo@c-sky.com>
 <768ac390f9eee8acb4dc9ca85a489a1d2fd00628.1536138304.git.ren_guo@c-sky.com>
 <CABGGiszuo3gpjmutYzOpQUmGaNjq88_5pDj2TjXveX9x2+Rsig@mail.gmail.com>
 <20180906020229.GB29405@guoren-Inspiron-7460>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180906020229.GB29405@guoren-Inspiron-7460>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <rob.herring@linaro.org>
Cc: linux-arch@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Jason Cooper <jason@lakedaemon.net>, Arnd Bergmann <arnd@arndb.de>, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, Greentime Hu <green.hu@gmail.com>
List-Id: linux-arch.vger.kernel.org

On Thu, Sep 06, 2018 at 10:02:29AM +0800, Guo Ren wrote:
> On Wed, Sep 05, 2018 at 07:47:29PM -0500, Rob Herring wrote:
> > On Wed, Sep 5, 2018 at 7:09 AM Guo Ren <ren_guo@c-sky.com> wrote:
> > >
> > > Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> > > ---
> > >  .../bindings/timer/csky,gx6605s-timer.txt          | 46 ++++++++++++++++++++++
> > >  1 file changed, 46 insertions(+)

> Ok, change to "timer0: timer@0x0020a000"
  Ok, change to "timer0: timer@20a000"
