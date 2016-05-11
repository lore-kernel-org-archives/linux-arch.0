From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Subject: Re: S3 resume regression [1cf4f629d9d2 ("cpu/hotplug: Move online
 calls to hotplugged cpu")]
Date: Wed, 11 May 2016 15:21:16 +0300
Message-ID: <20160511122116.GA4329@intel.com>
References: <20160511101920.GZ4329@intel.com>
 <57332171.8070403@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:39039 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751530AbcEKMgh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 11 May 2016 08:36:37 -0400
Content-Disposition: inline
In-Reply-To: <57332171.8070403@linutronix.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org, Rik van Riel <riel@redhat.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, "Srivatsa S. Bhat" <srivatsa@mit.edu>, Peter Zijlstra <peterz@infradead.org>, Arjan van de Ven <arjan@linux.intel.com>, Rusty Russell <rusty@rustcorp.com.au>, Steven Rostedt <rostedt@goodmis.org>, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Paul Turner <pjt@google.com>, linux-kernel@vger.kernel.org, rui.zhang@intel.com, len.brown@intel.com

On Wed, May 11, 2016 at 02:11:29PM +0200, Sebastian Andrzej Siewior wro=
te:
> On 05/11/2016 12:19 PM, Ville Syrj=E4l=E4 wrote:
> > Hi,
> Hi,
>=20
> > I have a Lenovo Ideapad S10-3t machine here (Atom N450, 1 core, 2 H=
T)
> > which fails to resume from S3 on 4.6-rc releases. I bisected it dow=
n to
> >=20
> > commit 1cf4f629d9d246519a1e76c021806f2a51ddba4d
> > Author: Thomas Gleixner <tglx@linutronix.de>
> > Date:   Fri Feb 26 18:43:39 2016 +0000
> >=20
> >     cpu/hotplug: Move online calls to hotplugged cpu
> >=20
> > Unfortunately that won't revert cleanly, and neither does the merge
> > commit, so I was unable to see if that is the only problematic comm=
it
> > in 4.6.
> >=20
> > Any ideas?
>=20
> do you have a backtrace or anything or is it just not working and you
> end up with a blank screen?

Yeah can't get anything from the machine at that point. netconsole
didn't help either, and no serial on this machine. And IIRC I've
tried ramoops on this thing in the past but unfortunately the memory
got cleared on reboot.

--=20
Ville Syrj=E4l=E4
Intel OTC
