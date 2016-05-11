Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:52169 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932118AbcEKP1B (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 11 May 2016 11:27:01 -0400
Subject: Re: S3 resume regression [1cf4f629d9d2 ("cpu/hotplug: Move online
 calls to hotplugged cpu")]
References: <20160511101920.GZ4329@intel.com>
From: Arjan van de Ven <arjan@linux.intel.com>
Message-ID: <57334F42.5030304@linux.intel.com>
Date: Wed, 11 May 2016 08:26:58 -0700
MIME-Version: 1.0
In-Reply-To: <20160511101920.GZ4329@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch@vger.kernel.org, Rik van Riel <riel@redhat.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, "Srivatsa S. Bhat" <srivatsa@mit.edu>, Peter Zijlstra <peterz@infradead.org>, Sebastian Siewior <bigeasy@linutronix.de>, Rusty Russell <rusty@rustcorp.com.au>, Steven Rostedt <rostedt@goodmis.org>, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Paul Turner <pjt@google.com>, linux-kernel@vger.kernel.org, rui.zhang@intel.com, len.brown@intel.com
Message-ID: <20160511152658.spozHpiqIRCsw5zGdzE25Bhpy9YjMXs6v0sKtNS2nEo@z>


> Oh, and this was with acpi_idle. This machine already failed to
> resume from S3 with intel_idle since forever, as detailed in
> https://bugzilla.kernel.org/show_bug.cgi?id=107151
> but acpi_idle worked fine until now.

can you disable (in sysfs) all C states other than C0/C1 and see if that makes it go away?
that would point at the problem pretty clearly...


