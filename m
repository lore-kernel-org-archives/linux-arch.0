From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Subject: Re: S3 resume regression [1cf4f629d9d2 ("cpu/hotplug: Move online
 calls to hotplugged cpu")]
Date: Wed, 11 May 2016 16:34:06 +0300
Message-ID: <20160511133406.GC4329@intel.com>
References: <20160511101920.GZ4329@intel.com>
 <57332171.8070403@linutronix.de>
 <20160511122116.GA4329@intel.com>
 <20160511084445.00030b49@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:47994 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932743AbcEKNzT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 11 May 2016 09:55:19 -0400
Content-Disposition: inline
In-Reply-To: <20160511084445.00030b49@gandalf.local.home>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org, Rik van Riel <riel@redhat.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, "Srivatsa S. Bhat" <srivatsa@mit.edu>, Peter Zijlstra <peterz@infradead.org>, Arjan van de Ven <arjan@linux.intel.com>, Rusty Russell <rusty@rustcorp.com.au>, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Paul Turner <pjt@google.com>, linux-kernel@vger.kernel.org, rui.zhang@intel.com, len.brown@intel.com

On Wed, May 11, 2016 at 08:44:45AM -0400, Steven Rostedt wrote:
> On Wed, 11 May 2016 15:21:16 +0300
> Ville Syrj=E4l=E4 <ville.syrjala@linux.intel.com> wrote:
>=20
> > Yeah can't get anything from the machine at that point. netconsole
> > didn't help either, and no serial on this machine. And IIRC I've
> > tried ramoops on this thing in the past but unfortunately the memor=
y
> > got cleared on reboot.
> >=20
>=20
> Can you look at the documentation in the kernel code at
>=20
> Documentation/power/basic-pm-debugging.txt And follow the procedures
> for testing suspend to RAM (although it requires mostly running the
> same tests as for hibernation suspending).
>=20
> You can also use the tool s2ram for this as well.
>=20
> See Documentation/power/s2ram.txt
>=20
> Perhaps this can give us a bit more light onto the problem.
>=20
> Basically the above does partial suspend and resume, and can pinpoint
> problem areas down to a more select location.

All the pm_test modes work fine. The only difference between them was
that 'platform' required me to manually wake up the machine (hitting a
key was sufficient), whereas the others woke up without help.

pm_trace gave me
[    1.306633]   Magic number: 0:185:178
[    1.322880]   hash matches ../drivers/base/power/main.c:1070
[    1.339270] acpi device:0e: hash matches
[    1.355414]  platform: hash matches

which is the TRACE_SUSPEND in __device_suspend_noirq(), so no help
there.

I guess I could try to sprinkle more TRACE_RESUMEs around into some
early resume code. If anyone has good ideas where to put them it
might speed things up a bit.

--=20
Ville Syrj=E4l=E4
Intel OTC
