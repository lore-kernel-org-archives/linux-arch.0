From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCHv4 04/11] PM: Use *_dec_not_zero instead of
	*_add_unless
Date: Thu, 28 Jul 2011 23:43:54 +0200
Message-ID: <201107282343.54519.rjw@sisk.pl>
References: <1311760070-21532-1-git-send-email-sven@narfation.org>
	<201107272150.37962.rjw@sisk.pl> <20110727203604.GA8468@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110727203604.GA8468@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-arch@vger.kernel.org, Len Brown <len.brown@intel.com>, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Sven Eckelmann <sven@narfation.org>
List-Id: linux-arch.vger.kernel.org

On Wednesday, July 27, 2011, Pavel Machek wrote:
> Hi!
> 
> > > atomic_dec_not_zero is defined for each architecture through
> > > <linux/atomic.h> to provide the functionality of
> > > atomic_add_unless(x, -1, 0).
> > > 
> > > Signed-off-by: Sven Eckelmann <sven@narfation.org>
> > > Cc: Len Brown <len.brown@intel.com>
> > > Cc: Pavel Machek <pavel@ucw.cz>
> > > Cc: Rafael J. Wysocki <rjw@sisk.pl>
> > > Cc: linux-pm@lists.linux-foundation.org
> > 
> > Acked-by: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > > ---
> > >  drivers/base/power/runtime.c |    4 ++--
> > >  include/linux/pm_runtime.h   |    2 +-
> > >  kernel/power/hibernate.c     |    4 ++--
> > >  kernel/power/user.c          |    2 +-
> > >  4 files changed, 6 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> > > index 8dc247c..bda10d9 100644
> > > --- a/drivers/base/power/runtime.c
> > > +++ b/drivers/base/power/runtime.c
> > > @@ -401,7 +401,7 @@ static int rpm_suspend(struct device *dev, int rpmflags)
> > >  
> > >  		if (dev->parent) {
> > >  			parent = dev->parent;
> > > -			atomic_add_unless(&parent->power.child_count, -1, 0);
> > > +  atomic_dec_not_zero(&parent->power.child_count);
> 
> I'd like to understand... Why not atomic_dec in the first place? Count
> should be exact, anyway, or we run into problems, right?

Well, we'll also run into trouble if the count becomes negative.  We might
throw a WARN_ON() there if the old value weren't as expected, but that
would be a separate patch.

Thanks,
Rafael
