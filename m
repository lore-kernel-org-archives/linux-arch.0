From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCHv4 3/6] byteorder: add get/put endian helpers for the
 aligned case
Date: Fri, 30 May 2008 15:05:21 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0805301452270.18142-100000@netrider.rowland.org>
References: <1212090961.28403.50.camel@brick>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:2449 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753375AbYE3TFW (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 30 May 2008 15:05:22 -0400
In-Reply-To: <1212090961.28403.50.camel@brick>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Harvey Harrison <harvey.harrison@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-arch <linux-arch@vger.kernel.org>

On Thu, 29 May 2008, Harvey Harrison wrote:

> Add a set of endian helpers for the pattern:
> *(__le16 *)ptr = cpu_to_le16(val);
> 
> put_le16(val, (__le16 *)ptr);
> 
> The argument order follows that of the get/put_unaligned_{endian}
> helpers.
> 
> The get_ helpers are exactly equivalent to the existing {endian}_to_cpup
> functions, but have been added anyway for symmetry in the apis.
> 
> Myrinet had a put_be32 helper that has been changed to myri_put_be32 to
> avoid namespace collisions.
> 
> Private helpers in the usb-gadget drivers have been removed and switched
> over to the common ones.  Note that the put helpers here had the args in
> the opposite order from the common version.

...

> --- a/drivers/usb/gadget/file_storage.c
> +++ b/drivers/usb/gadget/file_storage.c
> @@ -1551,9 +1521,9 @@ static int do_read(struct fsg_dev *fsg)
>  	/* Get the starting Logical Block Address and check that it's
>  	 * not too big */
>  	if (fsg->cmnd[0] == SC_READ_6)
> -		lba = (fsg->cmnd[1] << 16) | get_be16(&fsg->cmnd[2]);
> +		lba = (fsg->cmnd[1] << 16) | get_be16((__be16 *)&fsg->cmnd[2]);
>  	else {
> -		lba = get_be32(&fsg->cmnd[2]);
> +		lba = get_be32((__be32 *)&fsg->cmnd[2]);

You need to be more careful here.  Since fsg->cmnd is aligned on a
32-bit boundary, fsg->cmnd[2] is not so aligned.  So this needs to be
an unaligned transfer, although the first one above is correct.

> @@ -1684,9 +1654,9 @@ static int do_write(struct fsg_dev *fsg)
>  	/* Get the starting Logical Block Address and check that it's
>  	 * not too big */
>  	if (fsg->cmnd[0] == SC_WRITE_6)
> -		lba = (fsg->cmnd[1] << 16) | get_be16(&fsg->cmnd[2]);
> +		lba = (fsg->cmnd[1] << 16) | get_be16((__be16 *)&fsg->cmnd[2]);
>  	else {
> -		lba = get_be32(&fsg->cmnd[2]);
> +		lba = get_be32((__be32 *)&fsg->cmnd[2]);

Same here.

> @@ -1920,7 +1890,7 @@ static int do_verify(struct fsg_dev *fsg)
>  
>  	/* Get the starting Logical Block Address and check that it's
>  	 * not too big */
> -	lba = get_be32(&fsg->cmnd[2]);
> +	lba = get_be32((__be32 *)&fsg->cmnd[2]);

And here.

> @@ -1933,7 +1903,7 @@ static int do_verify(struct fsg_dev *fsg)
>  		return -EINVAL;
>  	}
>  
> -	verification_length = get_be16(&fsg->cmnd[7]);
> +	verification_length = get_be16((__be16 *)&fsg->cmnd[7]);

Likewise, fsg->cmnd[7] is at an odd address, so it isn't properly
aligned for a 16-bit access.

> @@ -2078,7 +2048,7 @@ static int do_request_sense(struct fsg_dev *fsg, struct fsg_buffhd *bh)
>  	memset(buf, 0, 18);
>  	buf[0] = valid | 0x70;			// Valid, current error
>  	buf[2] = SK(sd);
> -	put_be32(&buf[3], sdinfo);		// Sense information
> +	put_be32(sdinfo, (__be32 *)&buf[3]);	// Sense information

Wrong again.

> @@ -2089,7 +2059,7 @@ static int do_request_sense(struct fsg_dev *fsg, struct fsg_buffhd *bh)
>  static int do_read_capacity(struct fsg_dev *fsg, struct fsg_buffhd *bh)
>  {
>  	struct lun	*curlun = fsg->curlun;
> -	u32		lba = get_be32(&fsg->cmnd[2]);
> +	u32		lba = get_be32((__be32 *)&fsg->cmnd[2]);

And again.

> @@ -2099,8 +2069,8 @@ static int do_read_capacity(struct fsg_dev *fsg, struct fsg_buffhd *bh)
>  		return -EINVAL;
>  	}
>  
> -	put_be32(&buf[0], curlun->num_sectors - 1);	// Max logical block
> -	put_be32(&buf[4], 512);				// Block length
> +	put_be32(curlun->num_sectors - 1, (__be32 *)&buf[0]);	// Max logical block
> +	put_be32(512, (__be32 *)&buf[4]);			// Block length

These are correct, since buf[0] and buf[4] are properly aligned for
32-bit accesses.

> @@ -2775,7 +2745,7 @@ static int do_scsi_command(struct fsg_dev *fsg)
>  		break;
>  
>  	case SC_MODE_SELECT_10:
> -		fsg->data_size_from_cmnd = get_be16(&fsg->cmnd[7]);
> +		fsg->data_size_from_cmnd = get_be16((__be16 *)&fsg->cmnd[7]);

This is wrong.

> @@ -2791,7 +2761,7 @@ static int do_scsi_command(struct fsg_dev *fsg)
>  		break;
>  
>  	case SC_MODE_SENSE_10:
> -		fsg->data_size_from_cmnd = get_be16(&fsg->cmnd[7]);
> +		fsg->data_size_from_cmnd = get_be16((__be16 *)&fsg->cmnd[7]);

So is this.

> @@ -2816,7 +2786,7 @@ static int do_scsi_command(struct fsg_dev *fsg)
>  		break;
>  
>  	case SC_READ_10:
> -		fsg->data_size_from_cmnd = get_be16(&fsg->cmnd[7]) << 9;
> +		fsg->data_size_from_cmnd = get_be16((__be16 *)&fsg->cmnd[7]) << 9;

And this.

> @@ -2824,7 +2794,7 @@ static int do_scsi_command(struct fsg_dev *fsg)
>  		break;
>  
>  	case SC_READ_12:
> -		fsg->data_size_from_cmnd = get_be32(&fsg->cmnd[6]) << 9;
> +		fsg->data_size_from_cmnd = get_be32((__be32 *)&fsg->cmnd[6]) << 9;

And this.

> @@ -2840,7 +2810,7 @@ static int do_scsi_command(struct fsg_dev *fsg)
>  		break;
>  
>  	case SC_READ_FORMAT_CAPACITIES:
> -		fsg->data_size_from_cmnd = get_be16(&fsg->cmnd[7]);
> +		fsg->data_size_from_cmnd = get_be16((__be16 *)&fsg->cmnd[7]);

And this.

> @@ -2898,7 +2868,7 @@ static int do_scsi_command(struct fsg_dev *fsg)
>  		break;
>  
>  	case SC_WRITE_10:
> -		fsg->data_size_from_cmnd = get_be16(&fsg->cmnd[7]) << 9;
> +		fsg->data_size_from_cmnd = get_be16((__be16 *)&fsg->cmnd[7]) << 9;

And this.

> @@ -2906,7 +2876,7 @@ static int do_scsi_command(struct fsg_dev *fsg)
>  		break;
>  
>  	case SC_WRITE_12:
> -		fsg->data_size_from_cmnd = get_be32(&fsg->cmnd[6]) << 9;
> +		fsg->data_size_from_cmnd = get_be32((__be32 *)&fsg->cmnd[6]) << 9;

And this.

It does take a certain amount of concentration to check which sort of
helper is needed for each access.

Alan Stern
