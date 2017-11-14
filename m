From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 29/31] MAINTAINERS: Add nds32
Date: Tue, 14 Nov 2017 07:39:02 -0800
Message-ID: <1510673942.2006.4.camel@perches.com>
References: <cover.1510118606.git.green.hu@gmail.com>
         <16035efb78f70411998755693339471032743377.1510118606.git.green.hu@gmail.com>
         <CAL_JsqLe847Dhta2vkbaUqRdfaQnsPCncR2bZZNP-_kzvm25wg@mail.gmail.com>
         <CAEbi=3eSpeOCwpd=6_hcLx1wsWfAjQAPV-hdZ0R-gsznnnVziw@mail.gmail.com>
         <CAK8P3a0=KNN_GdA=PQfaTU1O2Un1K45FYZZScDZN42mqhEzRHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a0=KNN_GdA=PQfaTU1O2Un1K45FYZZScDZN42mqhEzRHQ@mail.gmail.com>
Sender: netdev-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Greentime Hu <green.hu@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Greentime <greentime@andestech.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, netdev <netdev@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Thu, 2017-11-09 at 11:36 +0100, Arnd Bergmann wrote:
> On Thu, Nov 9, 2017 at 10:46 AM, Greentime Hu <green.hu@gmail.com> wrote:
> > 2017-11-08 21:31 GMT+08:00 Rob Herring <robh+dt@kernel.org>:
> > > On Tue, Nov 7, 2017 at 11:55 PM, Greentime Hu <green.hu@gmail.com> wrote:
> > > > From: Greentime Hu <greentime@andestech.com>
> > > > 
> > > > Signed-off-by: Greentime Hu <greentime@andestech.com>
> > > > ---
> > > >  MAINTAINERS |    9 +++++++++
> > > >  1 file changed, 9 insertions(+)
> > > > 
> > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > index 2f4e462..bce1181 100644
> > > > --- a/MAINTAINERS
> > > > +++ b/MAINTAINERS
> > > > @@ -857,6 +857,15 @@ X: drivers/iio/*/adjd*
> > > >  F:     drivers/staging/iio/*/ad*
> > > >  F:     drivers/staging/iio/trigger/iio-trig-bfin-timer.c
> > > > 
> > > > +ANDES ARCHITECTURE
> > > > +M:     Greentime Hu <green.hu@gmail.com>
> > > > +M:     Vincent Chen <deanbo422@gmail.com>
> > > > +T:     git https://github.com/andestech/linux.git
> > > > +S:     Supported
> > > > +F:     arch/nds32
> > > 
> > > DT binding files?
> > 
> > Thanks.
> > I should add
> > F:    Documentation/devicetree/bindings/interrupt-controller/andestech,ativic32.txt
> > F:    Documentation/devicetree/bindings/nds32/cpus.txt
> > 
> > I will fix it in the next version patch.
> 
> Better make the second one the directory, in case you add more files
> there later.
> 
> I would also add a "K: nds32" line to catch all files that have this
> in their names.

That's probably not what would be desired

K: looks for keywords inside all file contents
N: looks for filenames matching a regex pattern

See the header in MAINTAINERS for more details
