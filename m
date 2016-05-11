From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Subject: Re: S3 resume regression [1cf4f629d9d2 ("cpu/hotplug: Move online
 calls to hotplugged cpu")]
Date: Wed, 11 May 2016 20:09:17 +0300
Message-ID: <20160511170917.GD4329@intel.com>
References: <20160511101920.GZ4329@intel.com>
 <57334F42.5030304@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <57334F42.5030304@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org, Rik van Riel <riel@redhat.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, "Srivatsa S. Bhat" <srivatsa@mit.edu>, Peter Zijlstra <peterz@infradead.org>, Sebastian Siewior <bigeasy@linutronix.de>, Rusty Russell <rusty@rustcorp.com.au>, Steven Rostedt <rostedt@goodmis.org>, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Paul Turner <pjt@google.com>, linux-kernel@vger.kernel.org, rui.zhang@intel.com, len.brown@intel.com
List-Id: linux-arch.vger.kernel.org

On Wed, May 11, 2016 at 08:26:58AM -0700, Arjan van de Ven wrote:
>=20
> > Oh, and this was with acpi_idle. This machine already failed to
> > resume from S3 with intel_idle since forever, as detailed in
> > https://bugzilla.kernel.org/show_bug.cgi?id=3D107151
> > but acpi_idle worked fine until now.
>=20
> can you disable (in sysfs) all C states other than C0/C1 and see if t=
hat makes it go away?
> that would point at the problem pretty clearly...

No help there it seems.

However, as a sanity check I also tested that trick on the parent commi=
t,
and disabling ACPI C2-C3 makes that one fail as well. Disabling just C3
is OK apparently.

--=20
Ville Syrj=E4l=E4
Intel OTC
