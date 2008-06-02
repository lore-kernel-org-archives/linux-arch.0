Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:41503 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755336AbYFBMfO (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 2 Jun 2008 08:35:14 -0400
Date: Mon, 2 Jun 2008 13:29:35 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [PATCH 6/10] arm: convert to generic helpers for IPI function calls
Message-ID: <20080602122935.GB27125@flint.arm.linux.org.uk>
References: <1212051504-12561-1-git-send-email-jens.axboe@oracle.com> <1212051504-12561-7-git-send-email-jens.axboe@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1212051504-12561-7-git-send-email-jens.axboe@oracle.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jens Axboe <jens.axboe@oracle.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, npiggin@suse.de, linux-arch@vger.kernel.org, jeremy@goop.org, mingo@elte.hu, paulmck@linux.vnet.ibm.com
Message-ID: <20080602122935.psqX-oVnxdEp-o-VdxymZbLvxvyS1G-Bs_evHEzMwZU@z>

On Thu, May 29, 2008 at 10:58:20AM +0200, Jens Axboe wrote:
> This converts arm to use the new helpers for smp_call_function() and
> friends, and adds support for smp_call_function_single().

> +void arch_send_call_function_ipi(cpumask_t mask)
>  {
> -	return smp_call_function_on_cpu(func, info, retry, wait,
> -					cpu_online_map);
> +	send_ipi_message(mask, IPI_CALL_FUNC);
>  }

Can things like the above be inline functions to be included in the
generic code?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
