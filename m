Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ee0-f51.google.com ([74.125.83.51]:54151 "EHLO
	mail-ee0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755354Ab3DPJNE (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 16 Apr 2013 05:13:04 -0400
Date: Tue, 16 Apr 2013 11:12:59 +0200
From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 0/3 v2] mutex: Improve mutex performance by doing less
 atomic-ops & better spinning
Message-ID: <20130416091259.GC9569@gmail.com>
References: <1366036679-9702-1-git-send-email-Waiman.Long@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1366036679-9702-1-git-send-email-Waiman.Long@hp.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman Long <Waiman.Long@hp.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, David Howells <dhowells@redhat.com>, Dave Jones <davej@redhat.com>, Clark Williams <williams@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org, "Chandramouleeswaran, Aswin" <aswin@hp.com>, Davidlohr Bueso <davidlohr.bueso@hp.com>, "Norton, Scott J" <scott.norton@hp.com>, Rik van Riel <riel@redhat.com>
Message-ID: <20130416091259.z-5zxvgpS2T6DRwiCG7tsnltxyJ2IhBGQk6az8r4yHw@z>


* Waiman Long <Waiman.Long@hp.com> wrote:

> [...]
> 
> Patches 2 improves the mutex spinning process by reducing contention among the 
> spinners when competing for the mutex. This is done by using a MCS lock to put 
> the spinners in a queue so that only the first spinner will try to acquire the 
> mutex when it is available. This patch showed significant performance 
> improvement of +30% on the AIM7 fserver and new_fserver workload.

Ok, that's really nice - and this approach has no arbitrary limits/tunings in it.

Do you have a performance comparison to your first series (patches 1+2+3 IIRC) - 
how does this new series with MCS locking compare to the best previous result from 
that old series? Do we now achieve that level of performance?

Thanks,

	Ingo
