Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay0001.hostedemail.com ([216.40.44.1]:50856 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753957AbdKNPsf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 14 Nov 2017 10:48:35 -0500
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave02.hostedemail.com (Postfix) with ESMTP id E958918002295
        for <linux-arch@vger.kernel.org>; Tue, 14 Nov 2017 15:39:17 +0000 (UTC)
Message-ID: <1510673942.2006.4.camel@perches.com>
Subject: Re: [PATCH 29/31] MAINTAINERS: Add nds32
From: Joe Perches <joe@perches.com>
Date: Tue, 14 Nov 2017 07:39:02 -0800
In-Reply-To: <CAK8P3a0=KNN_GdA=PQfaTU1O2Un1K45FYZZScDZN42mqhEzRHQ@mail.gmail.com>
References: <cover.1510118606.git.green.hu@gmail.com>
         <16035efb78f70411998755693339471032743377.1510118606.git.green.hu@gmail.com>
         <CAL_JsqLe847Dhta2vkbaUqRdfaQnsPCncR2bZZNP-_kzvm25wg@mail.gmail.com>
         <CAEbi=3eSpeOCwpd=6_hcLx1wsWfAjQAPV-hdZ0R-gsznnnVziw@mail.gmail.com>
         <CAK8P3a0=KNN_GdA=PQfaTU1O2Un1K45FYZZScDZN42mqhEzRHQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, Greentime Hu <green.hu@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Greentime <greentime@andestech.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, netdev <netdev@vger.kernel.org>
Message-ID: <20171114153902.wn5JSxT0IZx4LEw8HRHFwhJ5PpkAoOa9Y9BBczfK-Jc@z>

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
