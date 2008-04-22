Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:36578 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1763611AbYDVOoV (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 22 Apr 2008 10:44:21 -0400
Date: Tue, 22 Apr 2008 07:43:44 -0700 (PDT)
From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/11] Add generic helpers for arch IPI function calls
In-Reply-To: <1208851058-8500-2-git-send-email-jens.axboe@oracle.com>
Message-ID: <alpine.LFD.1.10.0804220735350.2779@woody.linux-foundation.org>
References: <1208851058-8500-1-git-send-email-jens.axboe@oracle.com> <1208851058-8500-2-git-send-email-jens.axboe@oracle.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jens Axboe <jens.axboe@oracle.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, npiggin@suse.de
Message-ID: <20080422144344.thTJjCHeP62nMPN7J-fDha0kckRIic9WdXz8zEfROBY@z>



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

