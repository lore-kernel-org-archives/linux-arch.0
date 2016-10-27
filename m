From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] intel_idle: Don't use on Lenovo Ideapad S10-3t
Date: Fri, 28 Oct 2016 00:22:28 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1610280021410.4913@nanos>
References: <1446499360-31984-1-git-send-email-ville.syrjala@linux.intel.com> <1477591814-10985-1-git-send-email-ville.syrjala@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1647712833-1477606950=:4913"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:45178 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034039AbcJ0WZa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Oct 2016 18:25:30 -0400
In-Reply-To: <1477591814-10985-1-git-send-email-ville.syrjala@linux.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: =?ISO-8859-15?Q?Ville_Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc: Len Brown <len.brown@intel.com>, feng.tang@intel.com, Steven Rostedt <rostedt@goodmis.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Rik van Riel <riel@redhat.com>, "Srivatsa S. Bhat" <srivatsa@mit.edu>, Peter Zijlstra <peterz@infradead.org>, Arjan van de Ven <arjan@linux.intel.com>, Rusty Russell <rusty@rustcorp.com.au>, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Paul Turner <pjt@google.com>, "Zhang, Rui" <rui.zhang@intel.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-acpi@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1647712833-1477606950=:4913
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 27 Oct 2016, ville.syrjala@linux.intel.com wrote:

> From: Ville Syrjälä <ville.syrjala@linux.intel.com>
> 
> Lenovo Ideapad S10-3t hangs coming out of S3 with intel_idle.
> The two workaround that seem to help are "intel_idle.max_cstate=0"
> or "nohz=off highres=off".
> 
> At a first glance quirk_tigerpoint_bm_sts() seemed promising, but
> even when moved to early_resume it didn't do anything.
> 
> I have no idea what's wrong here, so let's just disable intel_idle
> for these machines using a DMI match.
> 
> I sent this patch originally about one year ago, at which time I was
> asked to file a bug, which I did [1], which was mostly a waste of time
> since no one actually did anything to fix the problem. In the
> meantime even acpi-idle got broken and then fixed again [2], so at
> least there's still a working alternative. As intel_idle has never
> worked on this machine, and it looks like no one has any real
> intention to fix it, I'm going to suggest *again* that we simply
> disable intel_idle on this machine and get on with life.

Please put that patch on hold. We have some new data on this.

Thanks,

	tglx
--8323329-1647712833-1477606950=:4913--
