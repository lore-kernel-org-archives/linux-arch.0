From: William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: Re: [PATCH v10 10/10] thermal: intel: intel_soc_dts_iosf: Utilize
 for_each_set_clump8 macro
Date: Sun, 24 Mar 2019 12:38:29 +0900
Message-ID: <20190324033747.GA7697@icarus>
References: <cover.1552566113.git.vilhelm.gray@gmail.com>
 <a240216a143782e3cfecf6f963578067b68b6007.1552566114.git.vilhelm.gray@gmail.com>
 <20190322190243.GA9224@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190322190243.GA9224@smile.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linus.walleij@linaro.org, akpm@linux-foundation.org, linux-gpio@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk, yamada.masahiro@socionext.com, bgolaszewski@baylibre.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Fri, Mar 22, 2019 at 09:02:43PM +0200, Andy Shevchenko wrote:
> On Thu, Mar 14, 2019 at 09:32:57PM +0900, William Breathitt Gray wrote:
> > Utilize for_each_set_clump8 macro, and the bitmap_set_value8 and
> > bitmap_get_value8 functions, where appropriate. In addition, remove the
> > now unnecessary temp_mask and temp_shift members of the
> > intel_soc_dts_sensor_entry structure.
> 
> One comment below, otherwise
> Tested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Thanks!

Thank you for testing out the patch. I'll fix the bug your pointed out
and add the Tested-by line.

I have a couple minor comments below.

> 
> > 
> > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> > ---
> >  drivers/thermal/intel/intel_soc_dts_iosf.c | 29 +++++++++++++---------
> >  drivers/thermal/intel/intel_soc_dts_iosf.h |  2 --
> >  2 files changed, 17 insertions(+), 14 deletions(-)
> > 
> > diff --git a/drivers/thermal/intel/intel_soc_dts_iosf.c b/drivers/thermal/intel/intel_soc_dts_iosf.c
> > index e0813dfaa278..b66f554670f7 100644
> > --- a/drivers/thermal/intel/intel_soc_dts_iosf.c
> > +++ b/drivers/thermal/intel/intel_soc_dts_iosf.c
> > @@ -15,6 +15,7 @@
> >  
> >  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> >  
> > +#include <linux/bitops.h>
> >  #include <linux/module.h>
> >  #include <linux/slab.h>
> >  #include <linux/interrupt.h>
> > @@ -111,6 +112,7 @@ static int update_trip_temp(struct intel_soc_dts_sensor_entry *dts,
> >  {
> >  	int status;
> >  	u32 temp_out;
> > +	unsigned long update_ptps;
> >  	u32 out;
> >  	u32 store_ptps;
> >  	u32 store_ptmc;
> > @@ -129,8 +131,9 @@ static int update_trip_temp(struct intel_soc_dts_sensor_entry *dts,
> >  	if (status)
> >  		return status;
> >  
> > -	out = (store_ptps & ~(0xFF << (thres_index * 8)));
> > -	out |= (temp_out & 0xFF) << (thres_index * 8);
> > +	update_ptps = store_ptps;
> > +	bitmap_set_value8(&update_ptps, 32, temp_out & 0xFF, thres_index * 8);

I chose to hardcode a bitmap width of 32 here because that is the width
of the store_ptps variables, but I don't think we necessarily use all 32
bits here. Would the actual width of store_ptps be the number of
writable trip count bits (writable_trip_count * 8)?

> > +	out = update_ptps;
> >  	status = iosf_mbi_write(BT_MBI_UNIT_PMC, MBI_REG_WRITE,
> >  				SOC_DTS_OFFSET_PTPS, out);
> >  	if (status)
> > @@ -232,6 +235,7 @@ static int sys_get_curr_temp(struct thermal_zone_device *tzd,
> >  	u32 out;
> >  	struct intel_soc_dts_sensor_entry *dts;
> >  	struct intel_soc_dts_sensors *sensors;
> > +	unsigned long temp_raw;
> >  
> >  	dts = tzd->devdata;
> >  	sensors = dts->sensors;
> > @@ -240,7 +244,8 @@ static int sys_get_curr_temp(struct thermal_zone_device *tzd,
> >  	if (status)
> >  		return status;
> >  
> > -	out = (out & dts->temp_mask) >> dts->temp_shift;
> > +	temp_raw = out;
> > +	out = bitmap_get_value8(&temp_raw, 32, dts->id * 8);

Same question as above: what is the maximum bitmap width here if not 32?

William Breathitt Gray

> >  	out -= SOC_DTS_TJMAX_ENCODING;
> >  	*temp = sensors->tj_max - out * 1000;
> >  
> > @@ -290,10 +295,13 @@ static int add_dts_thermal_zone(int id, struct intel_soc_dts_sensor_entry *dts,
> >  {
> >  	char name[10];
> >  	int trip_count = 0;
> > +	int writable_trip_count = 0;
> >  	int trip_mask = 0;
> >  	u32 store_ptps;
> >  	int ret;
> > -	int i;
> > +	unsigned int i;
> > +	unsigned long trip;
> > +	unsigned long ptps;
> >  
> >  	/* Store status to restor on exit */
> >  	ret = iosf_mbi_read(BT_MBI_UNIT_PMC, MBI_REG_READ,
> > @@ -302,11 +310,10 @@ static int add_dts_thermal_zone(int id, struct intel_soc_dts_sensor_entry *dts,
> >  		goto err_ret;
> >  
> >  	dts->id = id;
> > -	dts->temp_mask = 0x00FF << (id * 8);
> > -	dts->temp_shift = id * 8;
> >  	if (notification_support) {
> >  		trip_count = min(SOC_MAX_DTS_TRIPS, trip_cnt);
> > -		trip_mask = BIT(trip_count - read_only_trip_cnt) - 1;
> > +		writable_trip_count = trip_count - read_only_trip_cnt;
> > +		trip_mask = GENMASK(writable_trip_count - 1, 0);
> >  	}
> >  
> >  	/* Check if the writable trip we provide is not used by BIOS */
> > @@ -315,11 +322,9 @@ static int add_dts_thermal_zone(int id, struct intel_soc_dts_sensor_entry *dts,
> >  	if (ret)
> >  		trip_mask = 0;
> >  	else {
> > -		for (i = 0; i < trip_count; ++i) {
> > -			if (trip_mask & BIT(i))
> > -				if (store_ptps & (0xff << (i * 8)))
> > -					trip_mask &= ~BIT(i);
> > -		}
> > +		ptps = store_ptps;
> > +		for_each_set_clump8(i, trip, ptps, writable_trip_count * 8)
> 
> It seems you didn't notice gcc warnings, the ptps should be pointer, i.e. &ptps.
> After changing here manually seems working.
> 
> > +			trip_mask &= ~BIT(i / 8);
> >  	}
> >  	dts->trip_mask = trip_mask;
> >  	dts->trip_count = trip_count;
> > diff --git a/drivers/thermal/intel/intel_soc_dts_iosf.h b/drivers/thermal/intel/intel_soc_dts_iosf.h
> > index 625e37bf93dc..d0362d7acdef 100644
> > --- a/drivers/thermal/intel/intel_soc_dts_iosf.h
> > +++ b/drivers/thermal/intel/intel_soc_dts_iosf.h
> > @@ -33,8 +33,6 @@ struct intel_soc_dts_sensors;
> >  
> >  struct intel_soc_dts_sensor_entry {
> >  	int id;
> > -	u32 temp_mask;
> > -	u32 temp_shift;
> >  	u32 store_status;
> >  	u32 trip_mask;
> >  	u32 trip_count;
> > -- 
> > 2.21.0
> > 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
