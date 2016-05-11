From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: S3 resume regression [1cf4f629d9d2 ("cpu/hotplug: Move online
 calls to hotplugged cpu")]
Date: Wed, 11 May 2016 08:44:45 -0400
Message-ID: <20160511084445.00030b49@gandalf.local.home>
References: <20160511101920.GZ4329@intel.com>
	<57332171.8070403@linutronix.de>
	<20160511122116.GA4329@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay0095.hostedemail.com ([216.40.44.95]:37596 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751611AbcEKMou convert rfc822-to-8bit
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 11 May 2016 08:44:50 -0400
In-Reply-To: <20160511122116.GA4329@intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ville =?UTF-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org, Rik van Riel <riel@redhat.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, "Srivatsa S. Bhat" <srivatsa@mit.edu>, Peter Zijlstra <peterz@infradead.org>, Arjan van de Ven <arjan@linux.intel.com>, Rusty Russell <rusty@rustcorp.com.au>, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Paul Turner <pjt@google.com>, linux-kernel@vger.kernel.org, rui.zhang@intel.com, len.brown@intel.com

On Wed, 11 May 2016 15:21:16 +0300
Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com> wrote:

> Yeah can't get anything from the machine at that point. netconsole
> didn't help either, and no serial on this machine. And IIRC I've
> tried ramoops on this thing in the past but unfortunately the memory
> got cleared on reboot.
>=20

Can you look at the documentation in the kernel code at

Documentation/power/basic-pm-debugging.txt And follow the procedures
for testing suspend to RAM (although it requires mostly running the
same tests as for hibernation suspending).

You can also use the tool s2ram for this as well.

See Documentation/power/s2ram.txt

Perhaps this can give us a bit more light onto the problem.

Basically the above does partial suspend and resume, and can pinpoint
problem areas down to a more select location.


Thanks!

-- Steve
