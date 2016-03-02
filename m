From: Richard Cochran <richardcochran@gmail.com>
Subject: Re: [patch 18/20] cpu/hotplug: Let upcoming cpu bring itself fully up
Date: Wed, 2 Mar 2016 18:28:31 +0100
Message-ID: <20160302172831.GA15335@localhost.localdomain>
References: <20160226164321.657646833@linutronix.de>
 <20160226182341.697655464@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:32988 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752478AbcCBR2h (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 2 Mar 2016 12:28:37 -0500
Content-Disposition: inline
In-Reply-To: <20160226182341.697655464@linutronix.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Peter Anvin <hpa@zytor.com>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, Tejun Heo <tj@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Rusty Russell <rusty@rustcorp.com.au>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Arjan van de Ven <arjan@linux.intel.com>, Rik van Riel <riel@redhat.com>, "Srivatsa S. Bhat" <srivatsa@mit.edu>, Sebastian Siewior <bigeasy@linutronix.de>, Paul Turner <pjt@google.com>

On Fri, Feb 26, 2016 at 06:43:41PM -0000, Thomas Gleixner wrote:
> @@ -1204,7 +1212,7 @@ static bool cpuhp_is_ap_state(enum cpuhp
>  {
>  	if (state >= CPUHP_AP_OFFLINE && state <= CPUHP_AP_ONLINE)
>  		return true;

FWIW, this test is superfluous after this change, because
CPUHP_BRINGUP_CPU is less than CPUHP_AP_OFFLINE.

> -	return state > CPUHP_BP_ONLINE;
> +	return state > CPUHP_BRINGUP_CPU;
>  }

Thanks,
Richard
