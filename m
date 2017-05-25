From: Don Zickus <dzickus@redhat.com>
Subject: Re: [PATCH 4/4] watchdog: provide watchdog_reconfigure() for arch
 watchdogs
Date: Thu, 25 May 2017 10:08:33 -0400
Message-ID: <20170525140833.3qkuvoiavlf5ra6d@redhat.com>
References: <20170525082856.21685-1-npiggin@gmail.com>
 <20170525082856.21685-5-npiggin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52836 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934257AbdEYOIf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 25 May 2017 10:08:35 -0400
Content-Disposition: inline
In-Reply-To: <20170525082856.21685-5-npiggin@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Thu, May 25, 2017 at 06:28:56PM +1000, Nicholas Piggin wrote:
> After reconfiguring watchdog sysctls etc., architecture specific
> watchdogs may not get all their parameters updated.
> 
> watchdog_reconfigure() can be implemented to pull the new values
> in and set the arch NMI watchdog.

I understand the reason for this patch and I don't have any real objection
on how it was implemented within the constraints of all the current logic.

I just wonder if the current logic should be adjusted to make the hardlockup
detector, namely the perf implementation more separate so it can handle what
you would like more cleanly.

The watchdog_nmi_reconfigure is sort of hackish, but it is hard to fault you
based on how things are designed.  I am going to poke at it a little bit,
but I will probably not find time to do much and accept what you have for
now.

Cheers,
Don

> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  kernel/watchdog.c | 28 ++++++++++++++++++++++++----
>  1 file changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/watchdog.c b/kernel/watchdog.c
> index deb010505646..d2996f5bf551 100644
> --- a/kernel/watchdog.c
> +++ b/kernel/watchdog.c
> @@ -120,6 +120,11 @@ void __weak watchdog_nmi_disable(unsigned int cpu)
>  {
>  }
>  
> +void __weak watchdog_nmi_reconfigure(void)
> +{
> +}
> +
> +
>  #ifdef CONFIG_SOFTLOCKUP_DETECTOR
>  
>  /* Helper for online, unparked cpus. */
> @@ -597,6 +602,12 @@ static void watchdog_disable_all_cpus(void)
>  	}
>  }
>  
> +static int watchdog_update_cpus(void)
> +{
> +	return smpboot_update_cpumask_percpu_thread(
> +		    &watchdog_threads, &watchdog_cpumask);
> +}
> +
>  #else /* SOFTLOCKUP */
>  static int watchdog_park_threads(void)
>  {
> @@ -616,6 +627,10 @@ static void watchdog_disable_all_cpus(void)
>  {
>  }
>  
> +static int watchdog_update_cpus(void)
> +{
> +}
> +
>  static void set_sample_period(void)
>  {
>  }
> @@ -648,6 +663,8 @@ int lockup_detector_suspend(void)
>  		watchdog_enabled = 0;
>  	}
>  
> +	watchdog_nmi_reconfigure();
> +
>  	mutex_unlock(&watchdog_proc_mutex);
>  
>  	return ret;
> @@ -668,6 +685,8 @@ void lockup_detector_resume(void)
>  	if (watchdog_running && !watchdog_suspended)
>  		watchdog_unpark_threads();
>  
> +	watchdog_nmi_reconfigure();
> +
>  	mutex_unlock(&watchdog_proc_mutex);
>  	put_online_cpus();
>  }
> @@ -693,6 +712,8 @@ static int proc_watchdog_update(void)
>  	else
>  		watchdog_disable_all_cpus();
>  
> +	watchdog_nmi_reconfigure();
> +
>  	return err;
>  
>  }
> @@ -878,12 +899,11 @@ int proc_watchdog_cpumask(struct ctl_table *table, int write,
>  			 * a temporary cpumask, so we are likely not in a
>  			 * position to do much else to make things better.
>  			 */
> -#ifdef CONFIG_SOFTLOCKUP_DETECTOR
> -			if (smpboot_update_cpumask_percpu_thread(
> -				    &watchdog_threads, &watchdog_cpumask) != 0)
> +			if (watchdog_update_cpus() != 0)
>  				pr_err("cpumask update failed\n");
> -#endif
>  		}
> +
> +		watchdog_nmi_reconfigure();
>  	}
>  out:
>  	mutex_unlock(&watchdog_proc_mutex);
> -- 
> 2.11.0
> 
