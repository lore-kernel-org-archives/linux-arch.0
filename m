From: Don Zickus <dzickus@redhat.com>
Subject: Re: [PATCH 3/4] watchdog: Split up config options
Date: Fri, 2 Jun 2017 16:15:00 -0400
Message-ID: <20170602201500.urllmug33bjtuzen@redhat.com>
References: <20170530012659.16791-1-npiggin@gmail.com>
 <20170530012659.16791-4-npiggin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55688 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751150AbdFBUPB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 2 Jun 2017 16:15:01 -0400
Content-Disposition: inline
In-Reply-To: <20170530012659.16791-4-npiggin@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Tue, May 30, 2017 at 11:26:58AM +1000, Nicholas Piggin wrote:
> Split SOFTLOCKUP_DETECTOR from LOCKUP_DETECTOR, and split
> HARDLOCKUP_DETECTOR_PERF from HARDLOCKUP_DETECTOR.
> 
> LOCKUP_DETECTOR provides the boot, sysctl, and programming interfaces
> for lockup detectors. An architecture that defines HAVE_NMI_WATCHDOG
> need not use this this if it has a very basic watchdog or uses its own
> options and interfaces (e.g., sparc). touch_nmi_watchdog() will
> continue to call their arch_touch_nmi_watchdog().
> 
> HARDLOCKUP_DETECTOR_PERF is the perf-based lockup detector.
> 
> HARDLOCKUP_DETECTOR is the framework for arch NMI_WATCHDOG hard lockup
> detectors that conform to the LOCKUP_DETECTOR interfaces.

Hi Nick,

Sorry for the late response.  I did some sanity testing on your patches on
x86_64 and it seems to work fine.  I don't think I have any real issues with
the patches (without making time-consuming cleanup changes).

My last concern is wrapping my head around the config options.

HAVE_NMI_WATCHDOG seems to have a dual meaning, I think.

In the sparc case, it uses the HARDLOCKUP_DETECTOR framework (hence the
original split out of watchdog_hld.c).  Actually more like the
SOFTLOCKUP_DETECTOR framework for which HARDLOCKUP_DETECTOR is a part of.

In your ppc64 case, it means do _not_ use the HARDLOCKUP_DETECTOR or
SOFTLOCKUP_DETECTOR framework.  Instead just the bare bones LOCKUP_DETECTOR.


If so, the following is a little confusing to me..


<snip>

> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index e4587ebe52c7..a3afe3e10278 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -801,10 +801,27 @@ config LOCKUP_DETECTOR
>  	  The frequency of hrtimer and NMI events and the soft and hard lockup
>  	  thresholds can be controlled through the sysctl watchdog_thresh.
>  
> +config SOFTLOCKUP_DETECTOR
> +	bool "Detect Soft Lockups"
> +	depends on LOCKUP_DETECTOR
> +
> +config HARDLOCKUP_DETECTOR_PERF
> +	bool
> +	select SOFTLOCKUP_DETECTOR

Perhaps add a 'depends on (PERF_EVENTS && HAVE_PERF_EVENTS_NMI)'

> +
> +#
> +# arch/ can define HAVE_NMI_WATCHDOG to provide their own NMI watchdog
> +# rather than the perf based detector.
> +#
> +# The arch may do its own thing, or select HARDLOCKUP_DETECTOR, in which
> +# case it should conform to HARDLOCKUP_DETECTOR interfaces and settings
> +# (e.g., sysctl and cmdline).
> +#
>  config HARDLOCKUP_DETECTOR
> -	def_bool y
> -	depends on LOCKUP_DETECTOR && !HAVE_NMI_WATCHDOG
> -	depends on PERF_EVENTS && HAVE_PERF_EVENTS_NMI
> +	bool "Detect Hard Lockups"
> +	depends on LOCKUP_DETECTOR
> +	depends on !HAVE_NMI_WATCHDOG && (PERF_EVENTS && HAVE_PERF_EVENTS_NMI)
> +	select HARDLOCKUP_DETECTOR_PERF if !HAVE_NMI_WATCHDOG

Here is my confusion with HAVE_NMI_WATCHDOG

It seems like you can only select HARDLOCKUP_DETECTOR if !HAVE_NMI_DETECTOR
which would break sparc, I think.

And then it always selects HARDLOCKUP_DETECTOR_PERF because of the
dependency on !HAVE_NMI_WATCHDOG???

Yeah, the config options are confusing.

If the above is right then we might need something like

depends on HAVE_NMI_WATCHDOG || HAVE_PERF_EVENTS_NMI

(to replace the depends on !HAVE_NMI_WATCHDOG.. line)

Cheers,
Don

>  
>  config BOOTPARAM_HARDLOCKUP_PANIC
>  	bool "Panic (Reboot) On Hard Lockups"
> @@ -826,7 +843,7 @@ config BOOTPARAM_HARDLOCKUP_PANIC_VALUE
>  
>  config BOOTPARAM_SOFTLOCKUP_PANIC
>  	bool "Panic (Reboot) On Soft Lockups"
> -	depends on LOCKUP_DETECTOR
> +	depends on SOFTLOCKUP_DETECTOR
>  	help
>  	  Say Y here to enable the kernel to panic on "soft lockups",
>  	  which are bugs that cause the kernel to loop in kernel
> @@ -843,7 +860,7 @@ config BOOTPARAM_SOFTLOCKUP_PANIC
>  
>  config BOOTPARAM_SOFTLOCKUP_PANIC_VALUE
>  	int
> -	depends on LOCKUP_DETECTOR
> +	depends on SOFTLOCKUP_DETECTOR
>  	range 0 1
>  	default 0 if !BOOTPARAM_SOFTLOCKUP_PANIC
>  	default 1 if BOOTPARAM_SOFTLOCKUP_PANIC
> @@ -851,7 +868,7 @@ config BOOTPARAM_SOFTLOCKUP_PANIC_VALUE
>  config DETECT_HUNG_TASK
>  	bool "Detect Hung Tasks"
>  	depends on DEBUG_KERNEL
> -	default LOCKUP_DETECTOR
> +	default SOFTLOCKUP_DETECTOR
>  	help
>  	  Say Y here to enable the kernel to detect "hung tasks",
>  	  which are bugs that cause the task to be stuck in
> -- 
> 2.11.0
> 
