Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:33600 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725885AbeIFG44 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Sep 2018 02:56:56 -0400
Date: Thu, 6 Sep 2018 10:23:22 +0800
From: Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH V3 22/26] dt-bindings: interrupt-controller: C-SKY SMP
 intc
Message-ID: <20180906022322.GA30251@guoren-Inspiron-7460>
References: <cover.1536138304.git.ren_guo@c-sky.com>
 <a82f72fd77a6c06d23e6d08acc9df2a816d6235d.1536138304.git.ren_guo@c-sky.com>
 <CABGGiszOxskc_V1E8A4i34OWSUdOSVX-QSRrgG+NjTbashND_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABGGiszOxskc_V1E8A4i34OWSUdOSVX-QSRrgG+NjTbashND_g@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: linux-arch@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Jason Cooper <jason@lakedaemon.net>, Arnd Bergmann <arnd@arndb.de>, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, Greentime Hu <green.hu@gmail.com>
Message-ID: <20180906022322.Vt0MwiP_MldXEybeUUDPOI1_jT1pLCm-gAzKDl8owCw@z>

On Wed, Sep 05, 2018 at 07:45:12PM -0500, Rob Herring wrote:
> On Wed, Sep 5, 2018 at 7:09 AM Guo Ren <ren_guo@c-sky.com> wrote:
> >
> > Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> > ---
> >  .../bindings/interrupt-controller/csky,mpintc.txt  | 40 ++++++++++++++++++++++
> >  1 file changed, 40 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt
> >
> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt b/Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt
> > new file mode 100644
> > index 0000000..49d1658
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt
> > @@ -0,0 +1,40 @@
> > +===========================================
> > +C-SKY Multi-processors Interrupt Controller
> > +===========================================
> > +
> > +C-SKY Multi-processors Interrupt Controller is designed for ck807/ck810/ck860
> > +SMP soc, and it also could be used in non-SMP system.
> 
> How is it accessed? No mmio registers?
Mmio reg base is got from cpu-coprocessor register and I'll detail
it here in next version patch.

csky_mpintc_init(struct device_node *node, struct device_node *parent)
{
	...
	INTCG_base = ioremap(mfcr("cr<31, 14>"), INTC_SIZE);
