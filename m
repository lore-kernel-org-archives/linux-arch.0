From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH V2 2/3] iommu: of: Ignore all errors except EPROBE_DEFER
Date: Thu, 18 May 2017 16:43:56 +0300
Message-ID: <26235811.RRFMmZMDyF@avalon>
References: <1495102030-10548-1-git-send-email-sricharan@codeaurora.org>
	<2111512.n9LmSLnVgL@avalon>
	<c3dc5e41-b853-9519-53a3-df870ab26230@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <c3dc5e41-b853-9519-53a3-df870ab26230-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org, magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, j.neuschaefer-hi6Y0CQ0nG0@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org
List-Id: linux-arch.vger.kernel.org

Hi Sricharan

On Thursday 18 May 2017 19:08:12 Sricharan R wrote:
> On 5/18/2017 6:00 PM, Laurent Pinchart wrote:
> > On Thursday 18 May 2017 17:26:14 Sricharan R wrote:
> >> On 5/18/2017 4:09 PM, Laurent Pinchart wrote:
> >>> On Thursday 18 May 2017 15:37:09 Sricharan R wrote:
> >>>> While deferring the probe of IOMMU masters,
> >>>> xlate and add_device callback can pass back error values
> >>>> like -ENODEV, which means IOMMU cannot be connected
> >>>> with that master for real reasons. So rather than
> >>>> killing the master's probe for such errors, just
> >>>> ignore the errors and let the master work without
> >>>> an IOMMU.
> >>> 
> >>> I don't think this is a good idea. Why should we allow IOMMU drivers to
> >>> return an error if we're always going to ignore the error value ? That
> >>> will lead to drivers implementing slightly different behaviours, which
> >>> will be painful the day we'll need to start acting based on the error
> >>> value.
> >> 
> >> The of_iommu_configure interface, before this series, was returning
> >> either correct 'iommu_ops' or NULL. Also there was no return value from
> >> of_dma_configure which calls of_iommu_configure. This means that if we
> >> block only -ENODEV now and let the other errors, the probe of the master
> >> devices can be killed for reasons apart from deferring. This would be a
> >> change in behavior introduced. All of xlate, add_device, of_pci_map_rid
> >> and others can return values apart from -ENODEV. So was thinking that
> >> restoring the old behavior, except for returning EPROBE_DEFER was the
> >> better thing to do ?
> > 
> > We went from a situation where of_iommu_configure() could return either
> > valid operations in the case the device was to be handled by the IOMMU or
> > NULL otherwise, to a situation where we needed a third option for probe
> > deferral. The way we've done this, through error pointers, allows lots of
> > other errors to be returned as well from the of_xlate and add_device
> > operations.
>
> right, this was difference in the behavior now.
> 
> > There is currently no use for returning error codes other than
> > -EPROBE_DEFFER from of_iommu_configure(), so your proposal is to block
> > errors returned from the of_xlate and add_device operations inside
> > of_iommu_configure(). My point is that, by doing so, we allow IOMMU
> > drivers to return random error codes that are then ignored. I believe
> > this can cause problems in the future when we will need to extend the API
> > and standardize more error codes, as by then IOMMU drivers will return
> > random errors (they actually do so already to some extent).
> > 
> > For of_xlate I agree with you to some extent. v4.11 just checked whether
> > of_xlate succeeded or not, and just didn't use the IOMMU in case it
> > failed. The exact error value was ignored, and drivers already return
> > random errors. Going back to the v4.11 behaviour is what we need to do in
> > the short-term, even if I believe we should standardize the error values
> > returned from of_xlate after v4.12.
> > 
> > For add_device, however, the situation is a bit different. The add_device
> > operation is called from the IOMMU bus notifier, and the -ENODEV error is
> > ignored by add_iommu_group(). Any other error will cause bus_set_iommu()
> > to fail, which makes IOMMU probing fail for the drivers that check the
> > return value of bus_set_iommu() (some of them don't :-/).
> > 
> > Fixing all this properly requires standardizing the error codes, and going
> > through the existing IOMMU drivers to comply with the standardized
> > behaviour.
>
> I understand your concern on standardizing the error codes from xlate,
> add_device, others and handling them properly. As you said there are quite
> some errors returned from them today. Also another thing is standardizing
> the behavior of of_iommu_configure itself. So that API serves to connect a
> device to its correct iommu_ops. When that's not possible, what should be
> the output and how should that be handled by the caller. The current
> behavior is to either 1) connect to correct ops or 2) wait for it or 3)
> progress further with plain/default dma_ops. Anyways as you said
> standardizing the iommu api ops, would make the of_iommu_configure handling
> more specific. Having said that i think similar fix needs to be done for
> acpi's iort_iommu_configure as well.

I'm less knowledgeable about ACPI but I think you're right. Would you like to 
tackle this for v4.13 ? :-)

> > While this shouldn't be very difficult, it's likely not material for a
> > v4.12- rc fix. We will thus likely need to merge this patch (or something
> > very similar to it), but I'd really like to see this fixed properly for
> > v4.13.
>
> When you say "merge this patch (or something similar)", is that about
> documenting the error values for of_xlate and add_device that you showed
> down below  (or) about the patch in discussion ?

I meant the patch we're discussing, "[PATCH V2 2/3] iommu: of: Ignore all 
errors except EPROBE_DEFER". Sorry for the confusion. One more comment about 
this below.

> >>> At the very least, if you want to give a specific meaning to -ENODEV,
> >>> you should check for that value specifically and not ignore all errors
> >>> other than -EPROBE_DEFER. You also need to document the meaning of the
> >>> error value. This can be done in the documentation of the of_xlate
> >>> operation in include/linux/iommu.h:
> >>> 
> >>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> >>> index 2cb54adc4a33..6ba553e7384a 100644
> >>> --- a/include/linux/iommu.h
> >>> +++ b/include/linux/iommu.h
> >>> @@ -181,7 +181,6 @@ struct iommu_resv_region {
> >>>   * @domain_window_disable: Disable a particular window for a domain
> >>>   * @domain_set_windows: Set the number of windows for a domain
> >>>   * @domain_get_windows: Return the number of windows for a domain
> >>> - * @of_xlate: add OF master IDs to iommu grouping
> >>>   * @pgsize_bitmap: bitmap of all possible supported page sizes
> >>>   */
> >>>  struct iommu_ops {
> >>> @@ -224,6 +223,11 @@ struct iommu_ops {
> >>>  	/* Get the number of windows per domain */
> >>>  	u32 (*domain_get_windows)(struct iommu_domain *domain);
> >>> 
> >>> +	/**
> >>> +	 * @of_xlate:
> >>> +	 *
> >>> +	 * Add OF master IDs to iommu grouping.
> >>> +	 */
> >>>  	int (*of_xlate)(struct device *dev, struct of_phandle_args *args);
> >>>  	
> >>>  	unsigned long pgsize_bitmap;
> >>> 
> >>> And add documentation for the error codes there.
> >>> 
> >>> If you want to ignore some errors returned from the add_device operation
> >>> you should document it similarly, and in particular document which error
> >>> check(s) need to be performed by of_xlate and which are the
> >>> responsibility of add_device.
> >>> 
> >>>> Fixes: 7b07cbefb68d ("iommu: of: Handle IOMMU lookup failure with
> >>>> deferred probing or error")
> >>>> Reported-by: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
> >>>> Tested-by: Magnus Damn <magnus.damn-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >>>> Signed-off-by: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> >>>> ---
> >>>> [V2] Corrected spelling/case in commit log
> >>>> 
> >>>>  drivers/iommu/of_iommu.c | 6 ++++++
> >>>>  1 file changed, 6 insertions(+)
> >>>> 
> >>>> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> >>>> index e6e9bec..f0d22c0 100644
> >>>> --- a/drivers/iommu/of_iommu.c
> >>>> +++ b/drivers/iommu/of_iommu.c
> >>>> @@ -237,6 +237,12 @@ const struct iommu_ops *of_iommu_configure(struct
> >>>> device *dev,
> >>>> 			ops = ERR_PTR(err);
> >>>>  	}
> >>>> 
> >>>> +	/* Ignore all other errors apart from EPROBE_DEFER */
> >>>> +	if (IS_ERR(ops) && (PTR_ERR(ops) != -EPROBE_DEFER)) {
> >>>> +		dev_info(dev, "Adding to IOMMU failed: %ld\n", 
PTR_ERR(ops));

I would turn this into a dev_dbg(), as at least the -ENODEV error returned 
from add_device has a defined meaning (see the comment in add_iommu_group()) 
and is in my opinion not a condition that should be reported in the kernel log 
by default.

> >>>> +		ops = NULL;
> >>>> +	}
> >>>> +
> >>>>  	return ops;
> >>>>  }

-- 
Regards,

Laurent Pinchart
