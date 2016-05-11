From: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: S3 resume regression [1cf4f629d9d2 ("cpu/hotplug: Move online
 calls to hotplugged cpu")]
Date: Wed, 11 May 2016 05:44:14 -0700
Message-ID: <5733291E.80001@linux.intel.com>
References: <20160511101920.GZ4329@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:33434 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752476AbcEKMoR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 11 May 2016 08:44:17 -0400
In-Reply-To: <20160511101920.GZ4329@intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch@vger.kernel.org, Rik van Riel <riel@redhat.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, "Srivatsa S. Bhat" <srivatsa@mit.edu>, Peter Zijlstra <peterz@infradead.org>, Sebastian Siewior <bigeasy@linutronix.de>, Rusty Russell <rusty@rustcorp.com.au>, Steven Rostedt <rostedt@goodmis.org>, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Paul Turner <pjt@google.com>, linux-kernel@vger.kernel.org, rui.zhang@intel.com, len.brown@intel.com

On 5/11/2016 3:19 AM, Ville Syrj=E4l=E4 wrote:

> Oh, and this was with acpi_idle. This machine already failed to
> resume from S3 with intel_idle since forever, as detailed in
> https://bugzilla.kernel.org/show_bug.cgi?id=3D107151
> but acpi_idle worked fine until now.

this is the important clue part afaics.

some of these very old Atom's had issues (bios?) with S3 if the cores w=
ere in a too-deep C state,
and at some point there was a workaround (I forgot where in the code) t=
o ban those deep
C states around S3 on those cpus. I wonder if moving things around has =
made said workaround
ineffective.....
