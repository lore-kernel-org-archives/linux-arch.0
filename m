From: Feng Tang <feng.tang@intel.com>
Subject: Re: S3 resume regression [1cf4f629d9d2 ("cpu/hotplug: Move online
 calls to hotplugged cpu")]
Date: Wed, 9 Nov 2016 11:54:18 +0800
Message-ID: <20161109035418.GA18246@shbuild888>
References: <20160809172057.GZ4329@intel.com>
 <20161027172852.GE4617@intel.com>
 <alpine.DEB.2.20.1610272035180.4913@nanos>
 <20161027192006.GF4617@intel.com>
 <alpine.DEB.2.20.1610272122510.4913@nanos>
 <20161027203745.GH4617@intel.com>
 <alpine.DEB.2.20.1610272238390.4913@nanos>
 <20161028155603.GI4617@intel.com>
 <alpine.DEB.2.20.1610282049500.5053@nanos>
 <20161101204737.GB4617@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:25167 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750953AbcKIDrS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 8 Nov 2016 22:47:18 -0500
Content-Disposition: inline
In-Reply-To: <20161101204737.GB4617@intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Feng Tang <feng.79.tang@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Steven Rostedt <rostedt@goodmis.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Rik van Riel <riel@redhat.com>, "Srivatsa S. Bhat" <srivatsa@mit.edu>, Peter Zijlstra <peterz@infradead.org>, Arjan van de Ven <arjan@linux.intel.com>, Rusty Russell <rusty@rustcorp.com.au>, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Paul Turner <pjt@google.com>Linux Kernel Mailing List <linu>

On Wed, Nov 02, 2016 at 04:47:37AM +0800, Ville Syrjälä wrote:
> On Fri, Oct 28, 2016 at 08:58:41PM +0200, Thomas Gleixner wrote:
> > On Fri, 28 Oct 2016, Ville Syrjälä wrote:
> > > On Thu, Oct 27, 2016 at 10:41:18PM +0200, Thomas Gleixner wrote:
> > > > On Thu, 27 Oct 2016, Ville Syrjälä wrote:
> > > > > On Thu, Oct 27, 2016 at 09:25:05PM +0200, Thomas Gleixner wrote:
> > > > > > So it would be interesting whether that hunk in resume_broadcast() is
> > > > > > sufficient.
> > > > > 
> > > > > So far it looks like the answer is yes.
> > > > > 
> > > > > Looks to be about 5 seconds slower than acpi-idle in resuming, but
> > > > > I suppose that's not all that surprising ;)
> > > > 
> > > > Well, set it to 1msec then. If that works reliably then we really can do
> > > > that unconditionally. There is no harm in firing a useless timer during
> > > > resume once.
> > > 
> > > I narrowed down the required timeout, and looks like 25ms is the
> > > minimum that works. With 24ms I already started to have failures. So
> > > maybe just bump it up by an order of magnitude to 250ms for some
> > > safety margin?
> 
> I left the thing running for the weekend and it failed 26 out of 16057
> times with the 25ms timeout. Looks like it takes ~5 minutes to resume
> when it fails, but eventually it does come back.
> 

Just came back from a travel. Yes, the 5 minutes delay may be due to the
expiration of the HPET timer, counting from 0 to 0xffffffff for a 13M
frequencey HPET takes about 300 seconds. After resume, it seems nobody
arms it so my old patch forces to arm one event. 

Thanks,
Feng
