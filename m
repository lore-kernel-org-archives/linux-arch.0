Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:50333 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752285AbYDVMFT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 22 Apr 2008 08:05:19 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18445.54284.194023.553595@cargo.ozlabs.ibm.com>
Date: Tue, 22 Apr 2008 22:03:24 +1000
From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 3/11] powerpc: convert to generic helpers for IPI function calls
In-Reply-To: <1208851058-8500-4-git-send-email-jens.axboe@oracle.com>
References: <1208851058-8500-1-git-send-email-jens.axboe@oracle.com>
	<1208851058-8500-4-git-send-email-jens.axboe@oracle.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jens Axboe <jens.axboe@oracle.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, npiggin@suse.de, torvalds@linux-foundation.org, anton@samba.org
Message-ID: <20080422120324.R1eU8D8_PfO_XNaSMaJGo6W_HaZEL46JSBI9SAytdxU@z>

Jens Axboe writes:

> This converts ppc to use the new helpers for smp_call_function() and
> friends, and adds support for smp_call_function_single().

Looks OK, and runs on a dual G5 powermac here.  I'll try on some
bigger IBM boxes tomorrow, or maybe Anton can do that.

I notice that you have changed the semantics slightly in that
previously, the powerpc implementation would wait for the other cpus
to have taken the interrupt, and print a message if they didn't all
take the interrupt (this was different from the function of the `wait'
parameter, which said whether to wait for all cpus to finish executing
the specified function).

Now the generic smp_call_function_mask doesn't wait for the other cpus
to take the interrupt.  I don't think that's likely to be a problem,
but I do think that's worth mentioning in the patch description.

It's probably also worth mentioning that smp_send_stop no longer has
the behaviour of doing its stuff even if someone is holding the lock,
but that is OK (presumably) because now the lock (call_function_lock
in the new code) is held for much shorter periods and there doesn't
appear to be much danger of other cpus getting stuck or panicking
while holding that lock.

You can put Acked-by: Paul Mackerras <paulus@samba.org> on the ppc
patch, but please extend the description a bit as outlined above.

Thanks for doing this, BTW.

Regards,
Paul.
