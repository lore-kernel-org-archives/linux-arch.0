From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v10 10/10] thermal: intel: intel_soc_dts_iosf: Utilize
 for_each_set_clump8 macro
Date: Sun, 24 Mar 2019 15:52:47 +0200
Message-ID: <20190324135247.GG9224@smile.fi.intel.com>
References: <cover.1552566113.git.vilhelm.gray@gmail.com>
 <a240216a143782e3cfecf6f963578067b68b6007.1552566114.git.vilhelm.gray@gmail.com>
 <20190322190243.GA9224@smile.fi.intel.com>
 <20190324033747.GA7697@icarus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190324033747.GA7697@icarus>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: linux-arch@vger.kernel.org, yamada.masahiro@socionext.com, linus.walleij@linaro.org, linux@rasmusvillemoes.dk, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, bgolaszewski@baylibre.com, akpm@linux-foundation.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Sun, Mar 24, 2019 at 12:38:29PM +0900, William Breathitt Gray wrote:
> On Fri, Mar 22, 2019 at 09:02:43PM +0200, Andy Shevchenko wrote:
> > On Thu, Mar 14, 2019 at 09:32:57PM +0900, William Breathitt Gray wrote:
> > > Utilize for_each_set_clump8 macro, and the bitmap_set_value8 and
> > > bitmap_get_value8 functions, where appropriate. In addition, remove the
> > > now unnecessary temp_mask and temp_shift members of the
> > > intel_soc_dts_sensor_entry structure.
> > 
> > One comment below, otherwise
> > Tested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Thanks!
> 
> Thank you for testing out the patch. I'll fix the bug your pointed out
> and add the Tested-by line.
> 
> I have a couple minor comments below.

> > >  	u32 store_ptps;

> > > -	out = (store_ptps & ~(0xFF << (thres_index * 8)));
> > > -	out |= (temp_out & 0xFF) << (thres_index * 8);
> > > +	update_ptps = store_ptps;
> > > +	bitmap_set_value8(&update_ptps, 32, temp_out & 0xFF, thres_index * 8);
> 
> I chose to hardcode a bitmap width of 32 here because that is the width
> of the store_ptps variables, but I don't think we necessarily use all 32
> bits here. Would the actual width of store_ptps be the number of
> writable trip count bits (writable_trip_count * 8)?

I think 32 is okay, but sizeof(store_ptps) would be better. It's easy to read
since no need to check what is the actual size inside this variable is used.


Same for below.


-- 
With Best Regards,
Andy Shevchenko
