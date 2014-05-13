Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:60422 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760253AbaEMJa2 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 13 May 2014 05:30:28 -0400
Date: Tue, 13 May 2014 11:30:38 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 01/25] asm-generic: Change time_t and clock_t to 64 bit
In-Reply-To: <CAAG0J9-ieBNfyRa6kf22TNd_3mg57GYuGHagQ-pPLY41iM3Zyg@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1405131128010.6261@ionos.tec.linutronix.de>
References: <1399971456-3941-1-git-send-email-lftan@altera.com> <1399971749-4004-1-git-send-email-lftan@altera.com> <CAAG0J9-ieBNfyRa6kf22TNd_3mg57GYuGHagQ-pPLY41iM3Zyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Hogan <james.hogan@imgtec.com>
Cc: Ley Foon Tan <lftan@altera.com>, linux-arch@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, lftan.linux@gmail.com, cltang@codesourcery.com, Arnd Bergmann <arnd@arndb.de>
Message-ID: <20140513093038.xkJgBGH7fN3nPs77K7JS5EDx3AnDOqsolDMnmRvDl8o@z>

On Tue, 13 May 2014, James Hogan wrote:
> On 13 May 2014 10:02, Ley Foon Tan <lftan@altera.com> wrote:
> > Use 64 bit time_t and clock_t as default. 32 bit users can provide
> > an override to define these as "long" if needed.
> >
> > Signed-off-by: Ley Foon Tan <lftan@altera.com>
> > ---
> >  include/uapi/asm-generic/posix_types.h | 14 ++++++++++++--
> >  1 file changed, 12 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/uapi/asm-generic/posix_types.h b/include/uapi/asm-generic/posix_types.h
> > index fe74fcc..3f0e613 100644
> > --- a/include/uapi/asm-generic/posix_types.h
> > +++ b/include/uapi/asm-generic/posix_types.h
> > @@ -81,12 +81,22 @@ typedef struct {
> >  #endif
> >
> >  /*
> > + * Use 64 bit time_t and clock_t as default. 32 bit users can provide an override to
> > + * define these as "long" if needed.
> > + */
> > +#ifndef __kernel_time_t
> > +typedef long long      __kernel_time_t;
> > +#endif
> > +
> > +#ifndef __kernel_clock_t
> > +typedef long long      __kernel_clock_t;
> > +#endif
> 
> I think having this as the first patch in the series will break
> bisection for existing 32-bit arches. This needs to be done in such a
> way that at no intermediate commit are __kernel_time_t or
> __kernel_clock_t the wrong size for existing arches, e.g. by having a
> first patch which makes the typedefs conditional but leaves them as
> __kernel_long_t, and a final patch that changes the default after all
> the arches have got their overrides in place.

And instead of having a gazillion of pointless include file changes
which all do the same thing, this should simply use a config switch.

Thanks,

	tglx
