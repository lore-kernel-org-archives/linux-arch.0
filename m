Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33514 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757380AbcDLSBj (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 12 Apr 2016 14:01:39 -0400
Date: Tue, 12 Apr 2016 20:01:34 +0200
From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH 0/11] introduce down_write_killable for rw_semaphore v3
Message-ID: <20160412180133.GA4727@dhcp22.suse.cz>
References: <1460041951-22347-1-git-send-email-mhocko@kernel.org>
 <20160412093708.GB10771@dhcp22.suse.cz>
 <20160412154004.GI1087@worktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160412154004.GI1087@worktop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, "David S. Miller" <davem@davemloft.net>, Tony Luck <tony.luck@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, x86@kernel.org, linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>, LKML <linux-kernel@vger.kernel.org>
Message-ID: <20160412180134.7jbM6aoCIAeIXBDgfcC7Yn9YNcSWz1l3c3UhzN79MH4@z>

On Tue 12-04-16 17:40:04, Peter Zijlstra wrote:
> On Tue, Apr 12, 2016 at 11:37:08AM +0200, Michal Hocko wrote:
> > Hi Ingo, Peter,
> > do you plan to pull this into tip/locking or are you waiting for some
> > more feedback or things to resolve?
> 
> I am planning to take it; but I'm traveling this week.

OK, thanks!

-- 
Michal Hocko
SUSE Labs
