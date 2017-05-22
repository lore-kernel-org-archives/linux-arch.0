From: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH V4 3/4] ACPI/IORT: Ignore all errors except EPROBE_DEFER
Date: Mon, 22 May 2017 12:31:16 +0100
Message-ID: <20170522113116.GB10449@red-moon>
References: <1495119257-26724-1-git-send-email-sricharan@codeaurora.org>
 <1495119257-26724-3-git-send-email-sricharan@codeaurora.org>
 <20170522103730.GB7553@red-moon>
 <ffb088d6-e40f-7a7d-dafb-e52dc86704fc@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <ffb088d6-e40f-7a7d-dafb-e52dc86704fc-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: robin.murphy-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org, hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, j.neuschaefer-hi6Y0CQ0nG0@public.gmane.org, geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org, magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-arch.vger.kernel.org

On Mon, May 22, 2017 at 04:35:43PM +0530, Sricharan R wrote:
> Hi Lorenzo,
> 
> On 5/22/2017 4:07 PM, Lorenzo Pieralisi wrote:
> > Hi Sricharan,
> > 
> > On Thu, May 18, 2017 at 08:24:16PM +0530, Sricharan R wrote:
> >> While deferring the probe of IOMMU masters, xlate and
> >> add_device callbacks called from iort_iommu_configure
> >> can pass back error values like -ENODEV, which means
> >> the IOMMU cannot be connected with that master for real
> >> reasons. Before the IOMMU probe deferral, all such errors
> >> were ignored. Now all those errors are propagated back,
> >> killing the master's probe for such errors. Instead ignore
> >> all the errors except EPROBE_DEFER, which is the only one
> >> of concern and let the master work without IOMMU, thus
> >> restoring the old behavior.
> >>
> >> Fixes: 5a1bb638d567 ("drivers: acpi: Handle IOMMU lookup failure with deferred probing or error")
> >> Signed-off-by: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> >> ---
> >> [V4] Added this patch newly.
> >>
> >>  drivers/acpi/arm64/iort.c | 6 ++++++
> >>  1 file changed, 6 insertions(+)
> >>
> >> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> >> index c5fecf9..16e101f 100644
> >> --- a/drivers/acpi/arm64/iort.c
> >> +++ b/drivers/acpi/arm64/iort.c
> >> @@ -782,6 +782,12 @@ const struct iommu_ops *iort_iommu_configure(struct device *dev)
> >>  	if (err)
> >>  		ops = ERR_PTR(err);
> >>  
> >> +	/* Ignore all other errors apart from EPROBE_DEFER */
> >> +	if (IS_ERR(ops) && (PTR_ERR(ops) != -EPROBE_DEFER)) {
> >> +		dev_dbg(dev, "Adding to IOMMU failed: %ld\n", PTR_ERR(ops));
> >> +		ops = NULL;
> >> +	}
> >> +
> >>  	return ops;
> >>  }
> >>  
> > 
> > It is getting a bit convoluted. Is not it better to propagate the
> > error back and let acpi_dma_configure() make a decision accordingly ?
> > 
> 
> ok, I was trying to keep it in same way as DT, where of_dma_configure
> (here acpi_dma_configure) calls of_iommu_configure(here iort_iommu_configure)
> which ends up doing the check. So will have to be changed in both places
> for symmetry.
> 
> > Something like:
> > 
> > -- >8 --
> > diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> > index e39ec7b..3a10d757 100644
> > --- a/drivers/acpi/scan.c
> > +++ b/drivers/acpi/scan.c
> > @@ -1371,8 +1371,8 @@ int acpi_dma_configure(struct device *dev, enum dev_dma_attr attr)
> >  	iort_set_dma_mask(dev);
> >  
> >  	iommu = iort_iommu_configure(dev);
> > -	if (IS_ERR(iommu))
> > -		return PTR_ERR(iommu);
> > +	if (IS_ERR(iommu) && PTR_ERR(iommu) == -EPROBE_DEFER)
> > +		return -EPROBE_DEFER;
> 
> In case of other errors apart from EPROBE_DEFER,
> iommu = NULL should be set, before passing it on to
> arch_setup_dma_ops.

Ah yes, sorry, that makes it uglier :(

Point is, it does not make sense to me to have of/acpi_dma_configure()
check a return code with (IS_ERR()) whilst we know the only error
code you are allowed to handle is -EPROBE_DEFER, while at it it is
better to make the -EPROBE_DEFER check explicit (otherwise it may
seem that of/acpi_dma_configure() can handle an error code that
is different from -EPROBE_DEFER - but they don't), no big deal either
way though.

Lorenzo
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
