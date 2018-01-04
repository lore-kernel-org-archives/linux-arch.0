From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RFC PATCH] asm/generic: introduce if_nospec and nospec_barrier
Date: Thu, 4 Jan 2018 11:47:32 +0000
Message-ID: <20180104114732.utkixumxt7rfuf3g@salmiak>
References: <20180103223827.39601-1-mark.rutland@arm.com>
 <151502463248.33513.5960736946233335087.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CA+55aFzSYExr33w849=3o+2XGr9pUKpFucc5p-kKbEy20VVLPA@mail.gmail.com>
 <20180104010754.22ca6a74@alans-desktop>
 <alpine.LRH.2.00.1801040221070.27010@gjva.wvxbf.pm>
 <CAPcyv4ic=X3nMz7deg9NMyvj994+SM9XYoP0u7WvgKaAFSGAYw@mail.gmail.com>
 <CA+55aFx7eJqRA8EWwSCrC+Lr1ZjUvRXSuhrxo+af_Dx3YWKbOQ@mail.gmail.com>
 <1515035438.20588.4.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1515035438.20588.4.camel@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Williams, Dan J" <dan.j.williams@intel.com>
Cc: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "alan@linux.intel.com" <alan@linux.intel.com>, "Reshetova, Elena" <elena.reshetova@intel.com>, "gnomes@lxorguk.ukuu.org.uk" <gnomes@lxorguk.ukuu.org.uk>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "jikos@kernel.org" <jikos@kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

Hi Dan,

Thanks for these examples.

On Thu, Jan 04, 2018 at 03:10:51AM +0000, Williams, Dan J wrote:
> Note, the following is Elena's work, I'm just helping poke the upstream
> discussion along while she's offline.
> 
> Elena audited the static analysis reports down to the following
> locations where userspace provides a value for a conditional branch and
> then later creates a dependent load on that same userspace controlled
> value.
> 
> 'osb()', observable memory barrier, resolves to an lfence on x86. My
> concern with these changes is that it is not clear what content within
> the branch block is of concern. Peter's 'if_nospec' proposal combined
> with Mark's 'nospec_load' would seem to clear that up, from a self
> documenting code perspective, and let archs optionally protect entire
> conditional blocks or individual loads within those blocks.

I'm a little concerned by having to use two helpers that need to be paired. It
means that we have to duplicate the bounds information, and I suspect in
practice that they'll often be paired improperly.

I think that we can avoid those problems if we use nospec_ptr() on its own. It
returns NULL if the pointer would be out-of-bounds, so we can use it in the
if-statement.

On x86, that can contain the bounds checks followed be an OSB / lfence, like
if_nospec(). On arm we can use our architected sequence. In either case,
nospec_ptr() returns NULL if the pointer would be out-of-bounds.

Then, rather than sequences like:

	if_nospec(idx < max) {
		val = nospec_array_load(array, idx, max);
		...
	}

... we could have:

	if ((elem_ptr = nospec_array_ptr(array, idx, max)) {
		val = *elem_ptr;
		...
	}

... which also means we don't have to annotate every single load in the branch
if the element is a structure with multiple fields.

Does that sound workable to you?

From a quick scan, it looks like it would fit all of the example cases below.

Thanks,
Mark.

> Note that these are "a human looked at static analysis reports and
> could not rationalize that these are false positives". Specific domain
> knowledge about these paths may find that some of them are indeed false
> positives.
> 
> The change to m_start in kernel/user_namespace.c is interesting because
> that's an example where the nospec_load() approach by itself would need
> to barrier speculation twice whereas if_nospec can do it once for the
> whole block.
> 
> [ forgive any whitespace damage ]
> 
> 8<---
> diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
> index 3e7e283a44a8..65175bbe805f 100644
> --- a/drivers/media/usb/uvc/uvc_v4l2.c
> +++ b/drivers/media/usb/uvc/uvc_v4l2.c
> @@ -821,6 +821,7 @@ static int uvc_ioctl_enum_input(struct file *file, void *fh,
>  		}
>  		pin = iterm->id;
>  	} else if (index < selector->bNrInPins) {
> +		osb();
>  		pin = selector->baSourceID[index];
>  		list_for_each_entry(iterm, &chain->entities, chain) {
>  			if (!UVC_ENTITY_IS_ITERM(iterm))
> diff --git a/drivers/net/wireless/ath/carl9170/main.c b/drivers/net/wireless/ath/carl9170/main.c
> index 988c8857d78c..cf267b709af6 100644
> --- a/drivers/net/wireless/ath/carl9170/main.c
> +++ b/drivers/net/wireless/ath/carl9170/main.c
> @@ -1388,6 +1388,7 @@ static int carl9170_op_conf_tx(struct ieee80211_hw *hw,
>  
>  	mutex_lock(&ar->mutex);
>  	if (queue < ar->hw->queues) {
> +		osb();
>  		memcpy(&ar->edcf[ar9170_qmap[queue]], param, sizeof(*param));

>  		ret = carl9170_set_qos(ar);
>  	} else {
> diff --git a/drivers/net/wireless/intersil/p54/main.c b/drivers/net/wireless/intersil/p54/main.c
> index ab6d39e12069..f024f1ad81ff 100644
> --- a/drivers/net/wireless/intersil/p54/main.c
> +++ b/drivers/net/wireless/intersil/p54/main.c
> @@ -415,6 +415,7 @@ static int p54_conf_tx(struct ieee80211_hw *dev,
>  
>  	mutex_lock(&priv->conf_mutex);
>  	if (queue < dev->queues) {
> +		osb();
>  		P54_SET_QUEUE(priv->qos_params[queue], params->aifs,
>  			params->cw_min, params->cw_max, params->txop);
>  		ret = p54_set_edcf(priv);
> diff --git a/drivers/net/wireless/st/cw1200/sta.c b/drivers/net/wireless/st/cw1200/sta.c
> index 38678e9a0562..b4a2a7ba04e8 100644
> --- a/drivers/net/wireless/st/cw1200/sta.c
> +++ b/drivers/net/wireless/st/cw1200/sta.c
> @@ -619,6 +619,7 @@ int cw1200_conf_tx(struct ieee80211_hw *dev, struct ieee80211_vif *vif,
>  	mutex_lock(&priv->conf_mutex);
>  
>  	if (queue < dev->queues) {
> +		osb();
>  		old_uapsd_flags = le16_to_cpu(priv->uapsd_info.uapsd_flags);
>  
>  		WSM_TX_QUEUE_SET(&priv->tx_queue_params, queue, 0, 0, 0);
> diff --git a/drivers/scsi/qla2xxx/qla_mr.c b/drivers/scsi/qla2xxx/qla_mr.c
> index d5da3981cefe..dec8b6e087e3 100644
> --- a/drivers/scsi/qla2xxx/qla_mr.c
> +++ b/drivers/scsi/qla2xxx/qla_mr.c
> @@ -2304,10 +2304,12 @@ qlafx00_status_entry(scsi_qla_host_t *vha, struct rsp_que *rsp, void *pkt)
>  	req = ha->req_q_map[que];
>  
>  	/* Validate handle. */
> -	if (handle < req->num_outstanding_cmds)
> +	if (handle < req->num_outstanding_cmds) {
> +		osb();
>  		sp = req->outstanding_cmds[handle];
> -	else
> +	} else {
>  		sp = NULL;
> +	}
>  
>  	if (sp == NULL) {
>  		ql_dbg(ql_dbg_io, vha, 0x3034,
> @@ -2655,10 +2657,12 @@ qlafx00_multistatus_entry(struct scsi_qla_host *vha,
>  		req = ha->req_q_map[que];
>  
>  		/* Validate handle. */
> -		if (handle < req->num_outstanding_cmds)
> +		if (handle < req->num_outstanding_cmds) {
> +			osb();
>  			sp = req->outstanding_cmds[handle];
> -		else
> +		} else {
>  			sp = NULL;
> +		}
>  
>  		if (sp == NULL) {
>  			ql_dbg(ql_dbg_io, vha, 0x3044,
> diff --git a/drivers/thermal/int340x_thermal/int340x_thermal_zone.c b/drivers/thermal/int340x_thermal/int340x_thermal_zone.c
> index 145a5c53ff5c..d732b34e120d 100644
> --- a/drivers/thermal/int340x_thermal/int340x_thermal_zone.c
> +++ b/drivers/thermal/int340x_thermal/int340x_thermal_zone.c
> @@ -57,15 +57,16 @@ static int int340x_thermal_get_trip_temp(struct thermal_zone_device *zone,
>  	if (d->override_ops && d->override_ops->get_trip_temp)
>  		return d->override_ops->get_trip_temp(zone, trip, temp);
>  
> -	if (trip < d->aux_trip_nr)
> +	if (trip < d->aux_trip_nr) {
> +		osb();
>  		*temp = d->aux_trips[trip];
> -	else if (trip == d->crt_trip_id)
> +	} else if (trip == d->crt_trip_id) {
>  		*temp = d->crt_temp;
> -	else if (trip == d->psv_trip_id)
> +	} else if (trip == d->psv_trip_id) {
>  		*temp = d->psv_temp;
> -	else if (trip == d->hot_trip_id)
> +	} else if (trip == d->hot_trip_id) {
>  		*temp = d->hot_temp;
> -	else {
> +	} else {
>  		for (i = 0; i < INT340X_THERMAL_MAX_ACT_TRIP_COUNT; i++) {
>  			if (d->act_trips[i].valid &&
>  			    d->act_trips[i].id == trip) {
> diff --git a/fs/udf/misc.c b/fs/udf/misc.c
> index 401e64cde1be..c5394760d26b 100644
> --- a/fs/udf/misc.c
> +++ b/fs/udf/misc.c
> @@ -104,6 +104,8 @@ struct genericFormat *udf_add_extendedattr(struct inode *inode, uint32_t size,
>  					iinfo->i_lenEAttr) {
>  				uint32_t aal =
>  					le32_to_cpu(eahd->appAttrLocation);
> +
> +				osb();
>  				memmove(&ea[offset - aal + size],
>  					&ea[aal], offset - aal);
>  				offset -= aal;
> @@ -114,6 +116,8 @@ struct genericFormat *udf_add_extendedattr(struct inode *inode, uint32_t size,
>  					iinfo->i_lenEAttr) {
>  				uint32_t ial =
>  					le32_to_cpu(eahd->impAttrLocation);
> +
> +				osb();
>  				memmove(&ea[offset - ial + size],
>  					&ea[ial], offset - ial);
>  				offset -= ial;
> @@ -125,6 +129,8 @@ struct genericFormat *udf_add_extendedattr(struct inode *inode, uint32_t size,
>  					iinfo->i_lenEAttr) {
>  				uint32_t aal =
>  					le32_to_cpu(eahd->appAttrLocation);
> +
> +				osb();
>  				memmove(&ea[offset - aal + size],
>  					&ea[aal], offset - aal);
>  				offset -= aal;
> diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
> index 1c65817673db..dbc12007da51 100644
> --- a/include/linux/fdtable.h
> +++ b/include/linux/fdtable.h
> @@ -82,8 +82,10 @@ static inline struct file *__fcheck_files(struct files_struct *files, unsigned i
>  {
>  	struct fdtable *fdt = rcu_dereference_raw(files->fdt);
>  
> -	if (fd < fdt->max_fds)
> +	if (fd < fdt->max_fds) {
> +		osb();
>  		return rcu_dereference_raw(fdt->fd[fd]);
> +	}
>  	return NULL;
>  }
>  
> diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
> index 246d4d4ce5c7..aa0be8cef2d4 100644
> --- a/kernel/user_namespace.c
> +++ b/kernel/user_namespace.c
> @@ -648,15 +648,18 @@ static void *m_start(struct seq_file *seq, loff_t *ppos,
>  {
>  	loff_t pos = *ppos;
>  	unsigned extents = map->nr_extents;
> -	smp_rmb();
>  
> -	if (pos >= extents)
> -		return NULL;
> +	/* paired with smp_wmb in map_write */
> +	smp_rmb();
>  
> -	if (extents <= UID_GID_MAP_MAX_BASE_EXTENTS)
> -		return &map->extent[pos];
> +	if (pos < extents) {
> +		osb();
> +		if (extents <= UID_GID_MAP_MAX_BASE_EXTENTS)
> +			return &map->extent[pos];
> +		return &map->forward[pos];
> +	}
>  
> -	return &map->forward[pos];
> +	return NULL;
>  }
>  
>  static void *uid_m_start(struct seq_file *seq, loff_t *ppos)
> diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
> index 125c1eab3eaa..56909c8fa025 100644
> --- a/net/ipv4/raw.c
> +++ b/net/ipv4/raw.c
> @@ -476,6 +476,7 @@ static int raw_getfrag(void *from, char *to, int offset, int len, int odd,
>  	if (offset < rfv->hlen) {
>  		int copy = min(rfv->hlen - offset, len);
>  
> +		osb();
>  		if (skb->ip_summed == CHECKSUM_PARTIAL)
>  			memcpy(to, rfv->hdr.c + offset, copy);
>  		else
> diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
> index 761a473a07c5..0942784f3f8d 100644
> --- a/net/ipv6/raw.c
> +++ b/net/ipv6/raw.c
> @@ -729,6 +729,7 @@ static int raw6_getfrag(void *from, char *to, int offset, int len, int odd,
>  	if (offset < rfv->hlen) {
>  		int copy = min(rfv->hlen - offset, len);
>  
> +		osb();
>  		if (skb->ip_summed == CHECKSUM_PARTIAL)
>  			memcpy(to, rfv->c + offset, copy);
>  		else
> diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
> index 8ca9915befc8..7f83abdea255 100644
> --- a/net/mpls/af_mpls.c
> +++ b/net/mpls/af_mpls.c
> @@ -81,6 +81,8 @@ static struct mpls_route *mpls_route_input_rcu(struct net *net, unsigned index)
>  	if (index < net->mpls.platform_labels) {
>  		struct mpls_route __rcu **platform_label =
>  			rcu_dereference(net->mpls.platform_label);
> +
> +		osb();
>  		rt = rcu_dereference(platform_label[index]);
>  	}
>  	return rt;
