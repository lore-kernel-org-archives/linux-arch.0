From: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH 5/5 V5] Add check for suspended vm in softlockup detector
Date: Wed, 07 Dec 2011 16:38:42 +0200
Message-ID: <4EDF7A72.5020703@redhat.com>
References: <1323116344-17911-1-git-send-email-emunson@mgebm.net> <1323116344-17911-6-git-send-email-emunson@mgebm.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1323116344-17911-6-git-send-email-emunson@mgebm.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Eric B Munson <emunson@mgebm.net>
Cc: mingo@redhat.com, hpa@zytor.com, arnd@arndb.de, ryanh@linux.vnet.ibm.com, aliguori@us.ibm.com, mtosatti@redhat.com, jeremy.fitzhardinge@citrix.com, levinsasha928@gmail.com, Jan Kiszka <jan.kiszka@siemens.com>, kvm@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 12/05/2011 10:19 PM, Eric B Munson wrote:
> A suspended VM can cause spurious soft lockup warnings.  To avoid these, the
> watchdog now checks if the kernel knows it was stopped by the host and skips
> the warning if so.  When the watchdog is reset successfully, clear the guest
> paused flag.
>
>  int watchdog_enabled = 1;
> @@ -280,6 +281,9 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
>  			__this_cpu_write(softlockup_touch_sync, false);
>  			sched_clock_tick();
>  		}
> +
> +		/* Clear the guest paused flag on watchdog reset */
> +		kvm_check_and_clear_guest_paused(smp_processor_id());
>  		__touch_watchdog();
>  		return HRTIMER_RESTART;
>  	}

Won't build if !CONFIG_KVMCLOCK


-- 
error compiling committee.c: too many arguments to function
