From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch V5 15/15] x86/kvm: Use generic xfer to guest work function
Date: Fri, 24 Jul 2020 21:08:34 +0200
Message-ID: <87k0ysu3wt.fsf@nanos.tec.linutronix.de>
References: <20200722215954.464281930@linutronix.de> <20200722220520.979724969@linutronix.de> <20200724142426.GA651711@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbgGXTIh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Jul 2020 15:08:37 -0400
In-Reply-To: <20200724142426.GA651711@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Kees Cook <keescook@chromium.org>, Keno Fischer <keno@juliacomputing.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, Gabriel Krisman Bertazi <krisman@collabora.com>, Sean Christopherson <sean.j.christopherson@intel.com>

Ingo Molnar <mingo@kernel.org> writes:
> * Thomas Gleixner <tglx@linutronix.de> wrote:
>>  		/*
>> -		 * Note, return 1 and not 0, vcpu_run() is responsible for
>> -		 * morphing the pending signal into the proper return code.
>> +		 * Note, return 1 and not 0, vcpu_run() will invoke
>> +		 * xfer_to_guest_mode() which will create a proper return
>> +		 * code.
>>  		 */
>> -		if (signal_pending(current))
>> +		if (__xfer_to_guest_mode_work_pending())
>>  			return 1;
>> -
>> -		if (need_resched())
>> -			schedule();
>>  	}
>
> AFAICS this chunk removes a conditional reschedule point from 
> handle_invalid_guest_state() and replaces it with 
> __xfer_to_guest_mode_work_pending().
>
> But __xfer_to_guest_mode_work_pending() doesn't do the cond-resched of 
> the full xfer_to_guest_mode_work() function - so we essentially lose a 
> cond_resched() here.
>
> Is this side effect intended, was the cond_resched() superfluous?

It makes the thing drop back to the outer loop for any pending work not
only for signals. That avoids having yet another thing to worry about.

Thanks,

        tglx
