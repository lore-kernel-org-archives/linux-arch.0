From: Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 17/18] udf: prevent bounds-check bypass via speculative
 execution
Date: Mon, 8 Jan 2018 11:20:25 +0100
Message-ID: <20180108102025.kqi7pm4qhaeadzdh@quack2.suse.cz>
References: <151520099201.32271.4677179499894422956.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151520108644.32271.711751583164644933.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:49186 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754573AbeAHKU2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 8 Jan 2018 05:20:28 -0500
Content-Disposition: inline
In-Reply-To: <151520108644.32271.711751583164644933.stgit@dwillia2-desk3.amr.corp.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, gregkh@linuxfoundation.org, peterz@infradead.org, netdev@vger.kernel.org, Jan Kara <jack@suse.com>, tglx@linutronix.de, torvalds@linux-foundation.org, Elena Reshetova <elena.reshetova@intel.com>, alan@linux.intel.com

On Fri 05-01-18 17:11:26, Dan Williams wrote:
> Static analysis reports that 'eahd->appAttrLocation' and
> 'eahd->impAttrLocation' may be a user controlled values that are used as
> data dependencies for calculating source and destination buffers for
> memmove operations. In order to avoid potential leaks of kernel memory
> values, block speculative execution of the instruction stream that could
> issue further reads based on invalid 'aal' or 'ial' values.
> 
> Based on an original patch by Elena Reshetova.
> 
> Cc: Jan Kara <jack@suse.com>
> Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Umm, so I fail to see the user controlled input here.
udf_add_extendedattr() is called from a single place - udf_update_inode()
- and there all arguments except 'inode' are constant AFAICS. Also it gets
called only when block device or character device inode is created - that
already limits the possible user influence a lot since generally normal
users are not allowed to do that.

If the static checker is concerned that the inode contents is to some extent
user controllable, it is right but:
a) In this particular case udf_add_extendedattr() can get executed only on
freshly created inode so values are controlled by the kernel.
b) Even if in future we'd call udf_add_extendedattr() on inode loaded from
disk we do sanitycheck i_lenEAttr in udf_read_inode() when loading the value
from disk. And that would generally be way before we get to functions adding
extended attributes to the inode...

So overall I don't think this patch is needed.

								Honza

> diff --git a/fs/udf/misc.c b/fs/udf/misc.c
> index 401e64cde1be..9403160822de 100644
> --- a/fs/udf/misc.c
> +++ b/fs/udf/misc.c
> @@ -51,6 +51,8 @@ struct genericFormat *udf_add_extendedattr(struct inode *inode, uint32_t size,
>  	int offset;
>  	uint16_t crclen;
>  	struct udf_inode_info *iinfo = UDF_I(inode);
> +	uint8_t *ea_dst, *ea_src;
> +	uint32_t aal, ial;
>  
>  	ea = iinfo->i_ext.i_data;
>  	if (iinfo->i_lenEAttr) {
> @@ -100,33 +102,34 @@ struct genericFormat *udf_add_extendedattr(struct inode *inode, uint32_t size,
>  
>  		offset = iinfo->i_lenEAttr;
>  		if (type < 2048) {
> -			if (le32_to_cpu(eahd->appAttrLocation) <
> -					iinfo->i_lenEAttr) {
> -				uint32_t aal =
> -					le32_to_cpu(eahd->appAttrLocation);
> -				memmove(&ea[offset - aal + size],
> -					&ea[aal], offset - aal);
> +			aal = le32_to_cpu(eahd->appAttrLocation);
> +			if ((ea_dst = nospec_array_ptr(ea, offset - aal + size,
> +						       iinfo->i_lenEAttr)) &&
> +			    (ea_src = nospec_array_ptr(ea, aal,
> +						       iinfo->i_lenEAttr))) {
> +				memmove(ea_dst, ea_src, offset - aal);
>  				offset -= aal;
>  				eahd->appAttrLocation =
>  						cpu_to_le32(aal + size);
>  			}
> -			if (le32_to_cpu(eahd->impAttrLocation) <
> -					iinfo->i_lenEAttr) {
> -				uint32_t ial =
> -					le32_to_cpu(eahd->impAttrLocation);
> -				memmove(&ea[offset - ial + size],
> -					&ea[ial], offset - ial);
> +
> +			ial = le32_to_cpu(eahd->impAttrLocation);
> +			if ((ea_dst = nospec_array_ptr(ea, offset - ial + size,
> +						       iinfo->i_lenEAttr)) &&
> +			    (ea_src = nospec_array_ptr(ea, ial,
> +						       iinfo->i_lenEAttr))) {
> +				memmove(ea_dst, ea_src, offset - ial);
>  				offset -= ial;
>  				eahd->impAttrLocation =
>  						cpu_to_le32(ial + size);
>  			}
>  		} else if (type < 65536) {
> -			if (le32_to_cpu(eahd->appAttrLocation) <
> -					iinfo->i_lenEAttr) {
> -				uint32_t aal =
> -					le32_to_cpu(eahd->appAttrLocation);
> -				memmove(&ea[offset - aal + size],
> -					&ea[aal], offset - aal);
> +			aal = le32_to_cpu(eahd->appAttrLocation);
> +			if ((ea_dst = nospec_array_ptr(ea, offset - aal + size,
> +						       iinfo->i_lenEAttr)) &&
> +			    (ea_src = nospec_array_ptr(ea, aal,
> +						       iinfo->i_lenEAttr))) {
> +				memmove(ea_dst, ea_src, offset - aal);
>  				offset -= aal;
>  				eahd->appAttrLocation =
>  						cpu_to_le32(aal + size);
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
