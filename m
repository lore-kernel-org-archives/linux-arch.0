From: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: S3 resume regression [1cf4f629d9d2 ("cpu/hotplug: Move online
 calls to hotplugged cpu")]
Date: Wed, 11 May 2016 08:26:58 -0700
Message-ID: <57334F42.5030304@linux.intel.com>
References: <20160511101920.GZ4329@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160511101920.GZ4329@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch@vger.kernel.org, Rik van Riel <riel@redhat.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, "Srivatsa S. Bhat" <srivatsa@mit.edu>, Peter Zijlstra <peterz@infradead.org>, Sebastian Siewior <bigeasy@linutronix.de>, Rusty Russell <rusty@rustcorp.com.au>, Steven Rostedt <rostedt@goodmis.org>, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Paul Turner <pjt@google.com>, linux-kernel@vger.kernel.org, rui.zhang@intel.com, len.brown@intel.com
List-Id: linux-arch.vger.kernel.org


> Oh, and this was with acpi_idle. This machine already failed to
> resume from S3 with intel_idle since forever, as detailed in
> https://bugzilla.kernel.org/show_bug.cgi?id=107151
> but acpi_idle worked fine until now.

can you disable (in sysfs) all C states other than C0/C1 and see if that makes it go away?
that would point at the problem pretty clearly...
