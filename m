From: "Du, Changbin" <changbin.du@intel.com>
Subject: Re: [PATCH 2/5] regulator: add dummy of_find_regulator_by_node
Date: Wed, 2 May 2018 17:24:09 +0800
Message-ID: <20180502092409.ymjoykektm5kxgfc@intel.com>
References: <1525179614-14571-1-git-send-email-changbin.du@intel.com>
 <1525179614-14571-3-git-send-email-changbin.du@intel.com>
 <20180501204033.GB2714@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180501204033.GB2714@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: changbin.du@intel.com, yamada.masahiro@socionext.com, michal.lkml@markovi.net, tglx@linutronix.de, mingo@redhat.com, akpm@linux-foundation.org, x86@kernel.org, lgirdwood@gmail.com, arnd@arndb.de, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Wed, May 02, 2018 at 05:40:36AM +0900, Mark Brown wrote:
> On Tue, May 01, 2018 at 09:00:11PM +0800, changbin.du@intel.com wrote:
> > From: Changbin Du <changbin.du@intel.com>
> > 
> > If device tree is not enabled, of_find_regulator_by_node() should have
> > a dummy function since the function call is still there.
> > 
> > Signed-off-by: Changbin Du <changbin.du@intel.com>
> 
> This appears to have no obvious connection with the cover letter for the
> series...  The first question here is if this is something best fixed
> with a stub or by fixing the users - is the lack of a stub pointing out
> some bugs in them?  I'm a bit worried about how we've been managing to
> avoid any build test issues here though, surely the various builders
> would have spotted a problem?

This is to fix build error after NO_AUTO_INLINE is introduced. If this option
is enabled, GCC will not auto-inline functions that are not explicitly marked
as inline.

In this case (no CONFIG_OF), the copmiler will report error in regulator_dev_lookup().
W/o NO_AUTO_INLINE, function of_get_regulator() is auto-inlined and then the call
to of_find_regulator_by_node() is optimized out since of_get_regulator() always
return NULL. W/ NO_AUTO_INLINE, the return value of of_get_regulator() is a variable
so the call to of_find_regulator_by_node() cannot be optimized out.

static struct regulator_dev *regulator_dev_lookup(struct device *dev,
						  const char *supply)
{
	struct regulator_dev *r = NULL;
	struct device_node *node;
	struct regulator_map *map;
	const char *devname = NULL;

	regulator_supply_alias(&dev, &supply);

	/* first do a dt based lookup */
	if (dev && dev->of_node) {
		node = of_get_regulator(dev, supply);
		if (node) {
			r = of_find_regulator_by_node(node);
			if (r)
				return r;
	....

It is safe we just provide a stub of_find_regulator_by_node() if no CONFIG_OF.

-- 
Thanks,
Changbin Du
