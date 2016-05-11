From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Subject: Re: S3 resume regression [1cf4f629d9d2 ("cpu/hotplug: Move online
 calls to hotplugged cpu")]
Date: Wed, 11 May 2016 15:41:45 +0300
Message-ID: <20160511124145.GB4329@intel.com>
References: <20160511101920.GZ4329@intel.com>
 <57332171.8070403@linutronix.de>
 <20160511122116.GA4329@intel.com>
 <57332493.5090501@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:44388 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751824AbcEKMlx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 11 May 2016 08:41:53 -0400
Content-Disposition: inline
In-Reply-To: <57332493.5090501@linutronix.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org, Rik van Riel <riel@redhat.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, "Srivatsa S. Bhat" <srivatsa@mit.edu>, Peter Zijlstra <peterz@infradead.org>, Arjan van de Ven <arjan@linux.intel.com>, Rusty Russell <rusty@rustcorp.com.au>, Steven Rostedt <rostedt@goodmis.org>, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Paul Turner <pjt@google.com>, linux-kernel@vger.kernel.org, rui.zhang@intel.com, len.brown@intel.com

On Wed, May 11, 2016 at 02:24:51PM +0200, Sebastian Andrzej Siewior wro=
te:
> On 05/11/2016 02:21 PM, Ville Syrj=E4l=E4 wrote:
> > Yeah can't get anything from the machine at that point. netconsole
> > didn't help either, and no serial on this machine. And IIRC I've
> > tried ramoops on this thing in the past but unfortunately the memor=
y
> > got cleared on reboot.
>=20
> efi + pstore maybe?

I think you might have the wrong decade in mind.

--=20
Ville Syrj=E4l=E4
Intel OTC
