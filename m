From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCHv4 04/11] PM: Use *_dec_not_zero instead of *_add_unless
Date: Wed, 27 Jul 2011 22:36:04 +0200
Message-ID: <20110727203604.GA8468@elf.ucw.cz>
References: <1311760070-21532-1-git-send-email-sven@narfation.org>
 <1311760070-21532-4-git-send-email-sven@narfation.org>
 <201107272150.37962.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201107272150.37962.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Sven Eckelmann <sven@narfation.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-arch.vger.kernel.org

Hi!

> > atomic_dec_not_zero is defined for each architecture through
> > <linux/atomic.h> to provide the functionality of
> > atomic_add_unless(x, -1, 0).
> > 
> > Signed-off-by: Sven Eckelmann <sven@narfation.org>
> > Cc: Len Brown <len.brown@intel.com>
> > Cc: Pavel Machek <pavel@ucw.cz>
> > Cc: Rafael J. Wysocki <rjw@sisk.pl>
> > Cc: linux-pm@lists.linux-foundation.org
> 
> Acked-by: Rafael J. Wysocki <rjw@sisk.pl>
> 
> > ---
> >  drivers/base/power/runtime.c |    4 ++--
> >  include/linux/pm_runtime.h   |    2 +-
> >  kernel/power/hibernate.c     |    4 ++--
> >  kernel/power/user.c          |    2 +-
> >  4 files changed, 6 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> > index 8dc247c..bda10d9 100644
> > --- a/drivers/base/power/runtime.c
> > +++ b/drivers/base/power/runtime.c
> > @@ -401,7 +401,7 @@ static int rpm_suspend(struct device *dev, int rpmflags)
> >  
> >  		if (dev->parent) {
> >  			parent = dev->parent;
> > -			atomic_add_unless(&parent->power.child_count, -1, 0);
> > +  atomic_dec_not_zero(&parent->power.child_count);

I'd like to understand... Why not atomic_dec in the first place? Count
should be exact, anyway, or we run into problems, right?

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
