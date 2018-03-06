Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:60234 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753554AbeCFLq3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Mar 2018 06:46:29 -0500
Date: Tue, 6 Mar 2018 03:46:32 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v11 7/7] ntb: ntb_hw_switchtec: Cleanup 64bit IO defines
 to use the common header
Message-ID: <20180306114632.GB16784@kroah.com>
References: <20180305190824.847-1-logang@deltatee.com>
 <20180305190824.847-8-logang@deltatee.com>
 <CAHp75Vc41MwtDr24-z3po2nx3Hr7_=tFUD0odcrbnVTP4SnJ1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vc41MwtDr24-z3po2nx3Hr7_=tFUD0odcrbnVTP4SnJ1g@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Logan Gunthorpe <logang@deltatee.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, linux-ntb@googlegroups.com, linux-crypto <linux-crypto@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>, Jon Mason <jdmason@kudzu.us>
Message-ID: <20180306114632.hnqy2PgOqOB5zbF9Sctk7200ZN5EtcMmRfZXhduHq-g@z>

On Tue, Mar 06, 2018 at 12:48:29PM +0200, Andy Shevchenko wrote:
> On Mon, Mar 5, 2018 at 9:08 PM, Logan Gunthorpe <logang@deltatee.com> wrote:
> > Clean up the ifdefs which conditionally defined the io{read|write}64
> > functions in favour of the new common io-64-nonatomic-lo-hi header.
> 
> >  #include <linux/kthread.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/ntb.h>
> > +#include <linux/io-64-nonatomic-lo-hi.h>
> 
> A nit, can we preserve alphabetical ordering?

Ugh, why, it doesn't matter at all :)
