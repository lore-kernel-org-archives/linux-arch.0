From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Subject: Re: S3 resume regression [1cf4f629d9d2 ("cpu/hotplug: Move online
 calls to hotplugged cpu")]
Date: Mon, 7 Nov 2016 18:45:19 +0200
Message-ID: <20161107164519.GA4617@intel.com>
References: <alpine.DEB.2.20.1610272035180.4913@nanos>
 <20161027192006.GF4617@intel.com>
 <alpine.DEB.2.20.1610272122510.4913@nanos>
 <20161027203745.GH4617@intel.com>
 <alpine.DEB.2.20.1610272238390.4913@nanos>
 <20161028155603.GI4617@intel.com>
 <alpine.DEB.2.20.1610282049500.5053@nanos>
 <20161101204737.GB4617@intel.com>
 <20161107114937.GX4617@intel.com>
 <alpine.DEB.2.20.1611071406320.3709@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1611071406320.3709@nanos>
Sender: linux-pm-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Feng Tang <feng.79.tang@gmail.com>, feng.tang@intel.com, "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Steven Rostedt <rostedt@goodmis.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-arch@vger.kernel.org, Rik van Riel <riel@redhat.com>, "Srivatsa S. Bhat" <srivatsa@mit.edu>, Peter Zijlstra <peterz@infradead.org>, Arjan van de Ven <arjan@linux.intel.com>, Rusty Russell <rusty@rustcorp.com.au>, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Paul Turner <pjt@google.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel>
List-Id: linux-arch.vger.kernel.org

On Mon, Nov 07, 2016 at 02:07:43PM +0100, Thomas Gleixner wrote:
> On Mon, 7 Nov 2016, Ville Syrjälä wrote:
> > I didn't manage to find a lot of time to play around with this, but it
> > definitely looks like the SMM trap is the problem here. I repeated my
> > pm_trace experiemnts and when it gets stuck it is trying to execute the
> > _WAK ACPI method which is where the SMM trap happens.
> > 
> > Maybe the SMM code was written with the expectation of a periodic tick
> > or something like that?
> 
> Can you try the untested hack below, please? It should confirm that.
> 
> Thanks,
> 
> 	tglx
> 
> 8<---------------
> --- a/drivers/acpi/acpica/hwsleep.c
> +++ b/drivers/acpi/acpica/hwsleep.c
> @@ -269,6 +269,17 @@ acpi_status acpi_hw_legacy_wake_prep(u8
>  	return_ACPI_STATUS(status);
>  }
>  
> +static const ktime_t time10ms = { .tv64 = 10 * NSEC_PER_MSEC };
> +
> +static enum hrtimer_restart acpi_hw_legacy_tmr(struct hrtimer *tmr)
> +{
> +	hrtimer_forward_now(tmr, time10ms);
> +
> +	return HRTIMER_RESTART;
> +}
> +
> +
> +
>  /*******************************************************************************
>   *
>   * FUNCTION:    acpi_hw_legacy_wake
> @@ -284,6 +295,7 @@ acpi_status acpi_hw_legacy_wake_prep(u8
>  
>  acpi_status acpi_hw_legacy_wake(u8 sleep_state)
>  {
> +	struct hrtimer timer;
>  	acpi_status status;
>  
>  	ACPI_FUNCTION_TRACE(hw_legacy_wake);
> @@ -311,12 +323,18 @@ acpi_status acpi_hw_legacy_wake(u8 sleep
>  		return_ACPI_STATUS(status);
>  	}
>  
> +	hrtimer_init_on_stack(&timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> +	timer.function = acpi_hw_legacy_tmr;
> +	hrtimer_start(&timer, time10ms, HRTIMER_MODE_REL);
> +
>  	/*
>  	 * Now we can execute _WAK, etc. Some machines require that the GPEs
>  	 * are enabled before the wake methods are executed.
>  	 */
>  	acpi_hw_execute_sleep_method(METHOD_PATHNAME__WAK, sleep_state);
>  
> +	hrtimer_cancel(&timer);
> +
>  	/*
>  	 * Some BIOS code assumes that WAK_STS will be cleared on resume
>  	 * and use it to determine whether the system is rebooting or

Doesn't really seem to help. I did get a few random successes, but
mostly it just fails.

diff --git a/drivers/acpi/acpica/hwsleep.c b/drivers/acpi/acpica/hwsleep.c
index 3c9c10bd49e9..950319b619f1 100644
--- a/drivers/acpi/acpica/hwsleep.c
+++ b/drivers/acpi/acpica/hwsleep.c
@@ -44,6 +44,8 @@
 
 #include <acpi/acpi.h>
 #include <linux/acpi.h>
+#include <linux/pm-trace.h>
+#include <linux/delay.h>
 #include "accommon.h"
 
 #define _COMPONENT          ACPI_HARDWARE
@@ -275,6 +277,8 @@ static enum hrtimer_restart acpi_hw_legacy_tmr(struct hrtimer *tmr)
 {
 	hrtimer_forward_now(tmr, time10ms);
 
+	TRACE_RESUME(0);
+
 	return HRTIMER_RESTART;
 }
 
@@ -327,14 +331,17 @@ acpi_status acpi_hw_legacy_wake(u8 sleep_state)
 	timer.function = acpi_hw_legacy_tmr;
 	hrtimer_start(&timer, time10ms, HRTIMER_MODE_REL);
 
+	TRACE_RESUME(0);
 	/*
 	 * Now we can execute _WAK, etc. Some machines require that the GPEs
 	 * are enabled before the wake methods are executed.
 	 */
 	acpi_hw_execute_sleep_method(METHOD_PATHNAME__WAK, sleep_state);
+	TRACE_RESUME(0);
 
 	hrtimer_cancel(&timer);
 
+	TRACE_RESUME(0);
 	/*
 	 * Some BIOS code assumes that WAK_STS will be cleared on resume
 	 * and use it to determine whether the system is rebooting or

Tossing that on top shows the trace before the _WAK being the last one
executed. Adding an msleep() before the _WAK does make the trace from
the timer handler show up so at least the timer seems to be ticking
up until some point.

-- 
Ville Syrjälä
Intel OTC
