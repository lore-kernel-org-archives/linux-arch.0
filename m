From: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: [PATCH 1/11] Add generic helpers for arch IPI function calls
Date: Tue, 22 Apr 2008 07:43:44 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0804220735350.2779@woody.linux-foundation.org>
References: <1208851058-8500-1-git-send-email-jens.axboe@oracle.com> <1208851058-8500-2-git-send-email-jens.axboe@oracle.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1208851058-8500-2-git-send-email-jens.axboe-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Jens Axboe <jens.axboe-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, npiggin-l3A5Bk7waGM@public.gmane.org



On Tue, 22 Apr 2008, Jens Axboe wrote:
> +
> +static inline void csd_flag_wait(struct call_single_data *data)
> +{
> +	/* Wait for response */
> +	do {
> +		/*
> +		 * We need to see the flags store in the IPI handler
> +		 */
> +		smp_mb();
> +		if (!(data->flags & CSD_FLAG_WAIT))
> +			break;
> +		cpu_relax();
> +	} while (1);
> +}

You forgot to free the "data" here? The waiter must also free the object, 
since now the callee does not.

		Linus
