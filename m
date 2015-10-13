From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [Intel-gfx] [PATCH 09/20] i915: switch from acpi_os_ioremap to
 memremap
Date: Tue, 13 Oct 2015 10:24:16 +0200
Message-ID: <20151013082416.GF26718@phenom.ffwll.local>
References: <20151009221537.32203.5867.stgit@dwillia2-desk3.jf.intel.com>
 <20151009221625.32203.74117.stgit@dwillia2-desk3.jf.intel.com>
 <20151012070102.GV26718@phenom.ffwll.local>
 <1444684376.9780.5.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:38668 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752679AbbJMIVX (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 13 Oct 2015 04:21:23 -0400
Received: by wieq12 with SMTP id q12so19688353wie.1
        for <linux-arch@vger.kernel.org>; Tue, 13 Oct 2015 01:21:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1444684376.9780.5.camel@intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Williams, Dan J" <dan.j.williams@intel.com>
Cc: "daniel@ffwll.ch" <daniel@ffwll.ch>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "Vetter, Daniel" <daniel.vetter@intel.com>, "airlied@linux.ie" <airlied@linux.ie>

On Mon, Oct 12, 2015 at 09:12:57PM +0000, Williams, Dan J wrote:
> On Mon, 2015-10-12 at 09:01 +0200, Daniel Vetter wrote:
> > On Fri, Oct 09, 2015 at 06:16:25PM -0400, Dan Williams wrote:
> > > i915 expects the OpRegion to be cached (i.e. not __iomem), so explicitly
> > > map it with memremap rather than the implied cache setting of
> > > acpi_os_ioremap().
> > > 
> > > Cc: Daniel Vetter <daniel.vetter@intel.com>
> > > Cc: Jani Nikula <jani.nikula@linux.intel.com>
> > > Cc: intel-gfx@lists.freedesktop.org
> > > Cc: David Airlie <airlied@linux.ie>
> > > Cc: dri-devel@lists.freedesktop.org
> > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > 
> > Assuming you've run sparse over this to make sure you've caught them all,
> > and with the nit below addressed this is
> > 
> > Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> 
> Indeed, re-running sparse again found a few conversions of ioread* I
> missed as well as moving the force casting out of validate_vbt() to
> find_vbt().
> 
> > Feel free to pull v2 into whatever tree you think it's suitable for (but
> > you can also resend and I'll pick it up).
> 
> Please pick up v2 below.

Queued for -next, thanks for the patch. Aside: Attached or separate mail
seems easier, somehow git apply-mbox can't auto-eat this for of patch.
-Daniel

> 
> > 
> > > diff --git a/drivers/gpu/drm/i915/intel_panel.c b/drivers/gpu/drm/i915/intel_panel.c
> > > index e2ab3f6ed022..c8444d5f549f 100644
> > > --- a/drivers/gpu/drm/i915/intel_panel.c
> > > +++ b/drivers/gpu/drm/i915/intel_panel.c
> > > @@ -387,7 +387,7 @@ intel_panel_detect(struct drm_device *dev)
> > >  
> > >  	/* Assume that the BIOS does not lie through the OpRegion... */
> > >  	if (!i915.panel_ignore_lid && dev_priv->opregion.lid_state) {
> > > -		return ioread32(dev_priv->opregion.lid_state) & 0x1 ?
> > > +		return *(dev_priv->opregion.lid_state) & 0x1 ?
> > 
> > () are redundant now here.
> 
> Yup, fixed.
> 
> 8<----
> Subject: i915: switch from acpi_os_ioremap to memremap
> 
> From: Dan Williams <dan.j.williams@intel.com>
> 
> i915 expects the OpRegion to be cached (i.e. not __iomem), so explicitly
> map it with memremap rather than the implied cache setting of
> acpi_os_ioremap().
> 
> Cc: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: intel-gfx@lists.freedesktop.org
> Cc: David Airlie <airlied@linux.ie>
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/gpu/drm/i915/i915_debugfs.c   |    2 -
>  drivers/gpu/drm/i915/i915_drv.h       |   12 ++---
>  drivers/gpu/drm/i915/intel_bios.c     |   25 +++++-----
>  drivers/gpu/drm/i915/intel_opregion.c |   83 ++++++++++++++++-----------------
>  drivers/gpu/drm/i915/intel_panel.c    |    2 -
>  5 files changed, 62 insertions(+), 62 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/i915_debugfs.c b/drivers/gpu/drm/i915/i915_debugfs.c
> index e3ec9049081f..15989cc16e92 100644
> --- a/drivers/gpu/drm/i915/i915_debugfs.c
> +++ b/drivers/gpu/drm/i915/i915_debugfs.c
> @@ -1849,7 +1849,7 @@ static int i915_opregion(struct seq_file *m, void *unused)
>  		goto out;
>  
>  	if (opregion->header) {
> -		memcpy_fromio(data, opregion->header, OPREGION_SIZE);
> +		memcpy(data, opregion->header, OPREGION_SIZE);
>  		seq_write(m, data, OPREGION_SIZE);
>  	}
>  
> diff --git a/drivers/gpu/drm/i915/i915_drv.h b/drivers/gpu/drm/i915/i915_drv.h
> index e1db8de52851..d8684634a31d 100644
> --- a/drivers/gpu/drm/i915/i915_drv.h
> +++ b/drivers/gpu/drm/i915/i915_drv.h
> @@ -444,14 +444,14 @@ struct opregion_swsci;
>  struct opregion_asle;
>  
>  struct intel_opregion {
> -	struct opregion_header __iomem *header;
> -	struct opregion_acpi __iomem *acpi;
> -	struct opregion_swsci __iomem *swsci;
> +	struct opregion_header *header;
> +	struct opregion_acpi *acpi;
> +	struct opregion_swsci *swsci;
>  	u32 swsci_gbda_sub_functions;
>  	u32 swsci_sbcb_sub_functions;
> -	struct opregion_asle __iomem *asle;
> -	void __iomem *vbt;
> -	u32 __iomem *lid_state;
> +	struct opregion_asle *asle;
> +	void *vbt;
> +	u32 *lid_state;
>  	struct work_struct asle_work;
>  };
>  #define OPREGION_SIZE            (8*1024)
> diff --git a/drivers/gpu/drm/i915/intel_bios.c b/drivers/gpu/drm/i915/intel_bios.c
> index c19e669ffe50..f6762a5faee8 100644
> --- a/drivers/gpu/drm/i915/intel_bios.c
> +++ b/drivers/gpu/drm/i915/intel_bios.c
> @@ -1231,20 +1231,13 @@ static const struct dmi_system_id intel_no_opregion_vbt[] = {
>  	{ }
>  };
>  
> -static const struct bdb_header *validate_vbt(const void __iomem *_base,
> +static const struct bdb_header *validate_vbt(const void *base,
>  					     size_t size,
> -					     const void __iomem *_vbt,
> +					     const void *_vbt,
>  					     const char *source)
>  {
> -	/*
> -	 * This is the one place where we explicitly discard the address space
> -	 * (__iomem) of the BIOS/VBT. (And this will cause a sparse complaint.)
> -	 * From now on everything is based on 'base', and treated as regular
> -	 * memory.
> -	 */
> -	const void *base = (const void *) _base;
> -	size_t offset = _vbt - _base;
> -	const struct vbt_header *vbt = base + offset;
> +	size_t offset = _vbt - base;
> +	const struct vbt_header *vbt = _vbt;
>  	const struct bdb_header *bdb;
>  
>  	if (offset + sizeof(struct vbt_header) > size) {
> @@ -1282,7 +1275,15 @@ static const struct bdb_header *find_vbt(void __iomem *bios, size_t size)
>  	/* Scour memory looking for the VBT signature. */
>  	for (i = 0; i + 4 < size; i++) {
>  		if (ioread32(bios + i) == *((const u32 *) "$VBT")) {
> -			bdb = validate_vbt(bios, size, bios + i, "PCI ROM");
> +			/*
> +			 * This is the one place where we explicitly discard the
> +			 * address space (__iomem) of the BIOS/VBT. From now on
> +			 * everything is based on 'base', and treated as regular
> +			 * memory.
> +			 */
> +			void *_bios = (void __force *) bios;
> +
> +			bdb = validate_vbt(_bios, size, _bios + i, "PCI ROM");
>  			break;
>  		}
>  	}
> diff --git a/drivers/gpu/drm/i915/intel_opregion.c b/drivers/gpu/drm/i915/intel_opregion.c
> index cb1c65739425..41d44a5ef626 100644
> --- a/drivers/gpu/drm/i915/intel_opregion.c
> +++ b/drivers/gpu/drm/i915/intel_opregion.c
> @@ -239,7 +239,7 @@ struct opregion_asle {
>  static int swsci(struct drm_device *dev, u32 function, u32 parm, u32 *parm_out)
>  {
>  	struct drm_i915_private *dev_priv = dev->dev_private;
> -	struct opregion_swsci __iomem *swsci = dev_priv->opregion.swsci;
> +	struct opregion_swsci *swsci = dev_priv->opregion.swsci;
>  	u32 main_function, sub_function, scic;
>  	u16 pci_swsci;
>  	u32 dslp;
> @@ -264,7 +264,7 @@ static int swsci(struct drm_device *dev, u32 function, u32 parm, u32 *parm_out)
>  	}
>  
>  	/* Driver sleep timeout in ms. */
> -	dslp = ioread32(&swsci->dslp);
> +	dslp = swsci->dslp;
>  	if (!dslp) {
>  		/* The spec says 2ms should be the default, but it's too small
>  		 * for some machines. */
> @@ -277,7 +277,7 @@ static int swsci(struct drm_device *dev, u32 function, u32 parm, u32 *parm_out)
>  	}
>  
>  	/* The spec tells us to do this, but we are the only user... */
> -	scic = ioread32(&swsci->scic);
> +	scic = swsci->scic;
>  	if (scic & SWSCI_SCIC_INDICATOR) {
>  		DRM_DEBUG_DRIVER("SWSCI request already in progress\n");
>  		return -EBUSY;
> @@ -285,8 +285,8 @@ static int swsci(struct drm_device *dev, u32 function, u32 parm, u32 *parm_out)
>  
>  	scic = function | SWSCI_SCIC_INDICATOR;
>  
> -	iowrite32(parm, &swsci->parm);
> -	iowrite32(scic, &swsci->scic);
> +	swsci->parm = parm;
> +	swsci->scic = scic;
>  
>  	/* Ensure SCI event is selected and event trigger is cleared. */
>  	pci_read_config_word(dev->pdev, PCI_SWSCI, &pci_swsci);
> @@ -301,7 +301,7 @@ static int swsci(struct drm_device *dev, u32 function, u32 parm, u32 *parm_out)
>  	pci_write_config_word(dev->pdev, PCI_SWSCI, pci_swsci);
>  
>  	/* Poll for the result. */
> -#define C (((scic = ioread32(&swsci->scic)) & SWSCI_SCIC_INDICATOR) == 0)
> +#define C (((scic = swsci->scic) & SWSCI_SCIC_INDICATOR) == 0)
>  	if (wait_for(C, dslp)) {
>  		DRM_DEBUG_DRIVER("SWSCI request timed out\n");
>  		return -ETIMEDOUT;
> @@ -317,7 +317,7 @@ static int swsci(struct drm_device *dev, u32 function, u32 parm, u32 *parm_out)
>  	}
>  
>  	if (parm_out)
> -		*parm_out = ioread32(&swsci->parm);
> +		*parm_out = swsci->parm;
>  
>  	return 0;
>  
> @@ -407,7 +407,7 @@ static u32 asle_set_backlight(struct drm_device *dev, u32 bclp)
>  {
>  	struct drm_i915_private *dev_priv = dev->dev_private;
>  	struct intel_connector *intel_connector;
> -	struct opregion_asle __iomem *asle = dev_priv->opregion.asle;
> +	struct opregion_asle *asle = dev_priv->opregion.asle;
>  
>  	DRM_DEBUG_DRIVER("bclp = 0x%08x\n", bclp);
>  
> @@ -432,7 +432,7 @@ static u32 asle_set_backlight(struct drm_device *dev, u32 bclp)
>  	DRM_DEBUG_KMS("updating opregion backlight %d/255\n", bclp);
>  	list_for_each_entry(intel_connector, &dev->mode_config.connector_list, base.head)
>  		intel_panel_set_backlight_acpi(intel_connector, bclp, 255);
> -	iowrite32(DIV_ROUND_UP(bclp * 100, 255) | ASLE_CBLV_VALID, &asle->cblv);
> +	asle->cblv = DIV_ROUND_UP(bclp * 100, 255) | ASLE_CBLV_VALID;
>  
>  	drm_modeset_unlock(&dev->mode_config.connection_mutex);
>  
> @@ -519,14 +519,14 @@ static void asle_work(struct work_struct *work)
>  	struct drm_i915_private *dev_priv =
>  		container_of(opregion, struct drm_i915_private, opregion);
>  	struct drm_device *dev = dev_priv->dev;
> -	struct opregion_asle __iomem *asle = dev_priv->opregion.asle;
> +	struct opregion_asle *asle = dev_priv->opregion.asle;
>  	u32 aslc_stat = 0;
>  	u32 aslc_req;
>  
>  	if (!asle)
>  		return;
>  
> -	aslc_req = ioread32(&asle->aslc);
> +	aslc_req = asle->aslc;
>  
>  	if (!(aslc_req & ASLC_REQ_MSK)) {
>  		DRM_DEBUG_DRIVER("No request on ASLC interrupt 0x%08x\n",
> @@ -535,34 +535,34 @@ static void asle_work(struct work_struct *work)
>  	}
>  
>  	if (aslc_req & ASLC_SET_ALS_ILLUM)
> -		aslc_stat |= asle_set_als_illum(dev, ioread32(&asle->alsi));
> +		aslc_stat |= asle_set_als_illum(dev, asle->alsi);
>  
>  	if (aslc_req & ASLC_SET_BACKLIGHT)
> -		aslc_stat |= asle_set_backlight(dev, ioread32(&asle->bclp));
> +		aslc_stat |= asle_set_backlight(dev, asle->bclp);
>  
>  	if (aslc_req & ASLC_SET_PFIT)
> -		aslc_stat |= asle_set_pfit(dev, ioread32(&asle->pfit));
> +		aslc_stat |= asle_set_pfit(dev, asle->pfit);
>  
>  	if (aslc_req & ASLC_SET_PWM_FREQ)
> -		aslc_stat |= asle_set_pwm_freq(dev, ioread32(&asle->pfmb));
> +		aslc_stat |= asle_set_pwm_freq(dev, asle->pfmb);
>  
>  	if (aslc_req & ASLC_SUPPORTED_ROTATION_ANGLES)
>  		aslc_stat |= asle_set_supported_rotation_angles(dev,
> -							ioread32(&asle->srot));
> +							asle->srot);
>  
>  	if (aslc_req & ASLC_BUTTON_ARRAY)
> -		aslc_stat |= asle_set_button_array(dev, ioread32(&asle->iuer));
> +		aslc_stat |= asle_set_button_array(dev, asle->iuer);
>  
>  	if (aslc_req & ASLC_CONVERTIBLE_INDICATOR)
> -		aslc_stat |= asle_set_convertible(dev, ioread32(&asle->iuer));
> +		aslc_stat |= asle_set_convertible(dev, asle->iuer);
>  
>  	if (aslc_req & ASLC_DOCKING_INDICATOR)
> -		aslc_stat |= asle_set_docking(dev, ioread32(&asle->iuer));
> +		aslc_stat |= asle_set_docking(dev, asle->iuer);
>  
>  	if (aslc_req & ASLC_ISCT_STATE_CHANGE)
>  		aslc_stat |= asle_isct_state(dev);
>  
> -	iowrite32(aslc_stat, &asle->aslc);
> +	asle->aslc = aslc_stat;
>  }
>  
>  void intel_opregion_asle_intr(struct drm_device *dev)
> @@ -587,8 +587,8 @@ static int intel_opregion_video_event(struct notifier_block *nb,
>  	   Linux, these are handled by the dock, button and video drivers.
>  	*/
>  
> -	struct opregion_acpi __iomem *acpi;
>  	struct acpi_bus_event *event = data;
> +	struct opregion_acpi *acpi;
>  	int ret = NOTIFY_OK;
>  
>  	if (strcmp(event->device_class, ACPI_VIDEO_CLASS) != 0)
> @@ -599,11 +599,10 @@ static int intel_opregion_video_event(struct notifier_block *nb,
>  
>  	acpi = system_opregion->acpi;
>  
> -	if (event->type == 0x80 &&
> -	    (ioread32(&acpi->cevt) & 1) == 0)
> +	if (event->type == 0x80 && ((acpi->cevt & 1) == 0))
>  		ret = NOTIFY_BAD;
>  
> -	iowrite32(0, &acpi->csts);
> +	acpi->csts = 0;
>  
>  	return ret;
>  }
> @@ -623,14 +622,14 @@ static u32 get_did(struct intel_opregion *opregion, int i)
>  	u32 did;
>  
>  	if (i < ARRAY_SIZE(opregion->acpi->didl)) {
> -		did = ioread32(&opregion->acpi->didl[i]);
> +		did = opregion->acpi->didl[i];
>  	} else {
>  		i -= ARRAY_SIZE(opregion->acpi->didl);
>  
>  		if (WARN_ON(i >= ARRAY_SIZE(opregion->acpi->did2)))
>  			return 0;
>  
> -		did = ioread32(&opregion->acpi->did2[i]);
> +		did = opregion->acpi->did2[i];
>  	}
>  
>  	return did;
> @@ -639,14 +638,14 @@ static u32 get_did(struct intel_opregion *opregion, int i)
>  static void set_did(struct intel_opregion *opregion, int i, u32 val)
>  {
>  	if (i < ARRAY_SIZE(opregion->acpi->didl)) {
> -		iowrite32(val, &opregion->acpi->didl[i]);
> +		opregion->acpi->didl[i] = val;
>  	} else {
>  		i -= ARRAY_SIZE(opregion->acpi->didl);
>  
>  		if (WARN_ON(i >= ARRAY_SIZE(opregion->acpi->did2)))
>  			return;
>  
> -		iowrite32(val, &opregion->acpi->did2[i]);
> +		opregion->acpi->did2[i] = val;
>  	}
>  }
>  
> @@ -768,7 +767,7 @@ static void intel_setup_cadls(struct drm_device *dev)
>  	 * there are less than eight devices. */
>  	do {
>  		disp_id = get_did(opregion, i);
> -		iowrite32(disp_id, &opregion->acpi->cadl[i]);
> +		opregion->acpi->cadl[i] = disp_id;
>  	} while (++i < 8 && disp_id != 0);
>  }
>  
> @@ -787,16 +786,16 @@ void intel_opregion_init(struct drm_device *dev)
>  		/* Notify BIOS we are ready to handle ACPI video ext notifs.
>  		 * Right now, all the events are handled by the ACPI video module.
>  		 * We don't actually need to do anything with them. */
> -		iowrite32(0, &opregion->acpi->csts);
> -		iowrite32(1, &opregion->acpi->drdy);
> +		opregion->acpi->csts = 0;
> +		opregion->acpi->drdy = 1;
>  
>  		system_opregion = opregion;
>  		register_acpi_notifier(&intel_opregion_notifier);
>  	}
>  
>  	if (opregion->asle) {
> -		iowrite32(ASLE_TCHE_BLC_EN, &opregion->asle->tche);
> -		iowrite32(ASLE_ARDY_READY, &opregion->asle->ardy);
> +		opregion->asle->tche = ASLE_TCHE_BLC_EN;
> +		opregion->asle->ardy = ASLE_ARDY_READY;
>  	}
>  }
>  
> @@ -809,19 +808,19 @@ void intel_opregion_fini(struct drm_device *dev)
>  		return;
>  
>  	if (opregion->asle)
> -		iowrite32(ASLE_ARDY_NOT_READY, &opregion->asle->ardy);
> +		opregion->asle->ardy = ASLE_ARDY_NOT_READY;
>  
>  	cancel_work_sync(&dev_priv->opregion.asle_work);
>  
>  	if (opregion->acpi) {
> -		iowrite32(0, &opregion->acpi->drdy);
> +		opregion->acpi->drdy = 0;
>  
>  		system_opregion = NULL;
>  		unregister_acpi_notifier(&intel_opregion_notifier);
>  	}
>  
>  	/* just clear all opregion memory pointers now */
> -	iounmap(opregion->header);
> +	memunmap(opregion->header);
>  	opregion->header = NULL;
>  	opregion->acpi = NULL;
>  	opregion->swsci = NULL;
> @@ -894,10 +893,10 @@ int intel_opregion_setup(struct drm_device *dev)
>  {
>  	struct drm_i915_private *dev_priv = dev->dev_private;
>  	struct intel_opregion *opregion = &dev_priv->opregion;
> -	void __iomem *base;
>  	u32 asls, mboxes;
>  	char buf[sizeof(OPREGION_SIGNATURE)];
>  	int err = 0;
> +	void *base;
>  
>  	BUILD_BUG_ON(sizeof(struct opregion_header) != 0x100);
>  	BUILD_BUG_ON(sizeof(struct opregion_acpi) != 0x100);
> @@ -915,11 +914,11 @@ int intel_opregion_setup(struct drm_device *dev)
>  	INIT_WORK(&opregion->asle_work, asle_work);
>  #endif
>  
> -	base = acpi_os_ioremap(asls, OPREGION_SIZE);
> +	base = memremap(asls, OPREGION_SIZE, MEMREMAP_WB);
>  	if (!base)
>  		return -ENOMEM;
>  
> -	memcpy_fromio(buf, base, sizeof(buf));
> +	memcpy(buf, base, sizeof(buf));
>  
>  	if (memcmp(buf, OPREGION_SIGNATURE, 16)) {
>  		DRM_DEBUG_DRIVER("opregion signature mismatch\n");
> @@ -931,7 +930,7 @@ int intel_opregion_setup(struct drm_device *dev)
>  
>  	opregion->lid_state = base + ACPI_CLID;
>  
> -	mboxes = ioread32(&opregion->header->mboxes);
> +	mboxes = opregion->header->mboxes;
>  	if (mboxes & MBOX_ACPI) {
>  		DRM_DEBUG_DRIVER("Public ACPI methods supported\n");
>  		opregion->acpi = base + OPREGION_ACPI_OFFSET;
> @@ -946,12 +945,12 @@ int intel_opregion_setup(struct drm_device *dev)
>  		DRM_DEBUG_DRIVER("ASLE supported\n");
>  		opregion->asle = base + OPREGION_ASLE_OFFSET;
>  
> -		iowrite32(ASLE_ARDY_NOT_READY, &opregion->asle->ardy);
> +		opregion->asle->ardy = ASLE_ARDY_NOT_READY;
>  	}
>  
>  	return 0;
>  
>  err_out:
> -	iounmap(base);
> +	memunmap(base);
>  	return err;
>  }
> diff --git a/drivers/gpu/drm/i915/intel_panel.c b/drivers/gpu/drm/i915/intel_panel.c
> index e2ab3f6ed022..efe5424b290c 100644
> --- a/drivers/gpu/drm/i915/intel_panel.c
> +++ b/drivers/gpu/drm/i915/intel_panel.c
> @@ -387,7 +387,7 @@ intel_panel_detect(struct drm_device *dev)
>  
>  	/* Assume that the BIOS does not lie through the OpRegion... */
>  	if (!i915.panel_ignore_lid && dev_priv->opregion.lid_state) {
> -		return ioread32(dev_priv->opregion.lid_state) & 0x1 ?
> +		return *dev_priv->opregion.lid_state & 0x1 ?
>  			connector_status_connected :
>  			connector_status_disconnected;
>  	}
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
