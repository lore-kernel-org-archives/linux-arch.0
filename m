From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: S3 resume regression [1cf4f629d9d2 ("cpu/hotplug: Move online
 calls to hotplugged cpu")]
Date: Wed, 11 May 2016 18:21:44 +0200
Message-ID: <57335C18.6010009@linutronix.de>
References: <20160511101920.GZ4329@intel.com> <57332171.8070403@linutronix.de>
 <20160511122116.GA4329@intel.com> <5733354F.6080703@intel.com>
 <625fc476-744c-240d-28b0-e1f09712c6a3@xs4all.nl>
 <CAJZ5v0iNakYVA6bynyRakK11GbjSaGVo-41X3dWZcJ3OQngmBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:49670 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751381AbcEKQWD (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 11 May 2016 12:22:03 -0400
In-Reply-To: <CAJZ5v0iNakYVA6bynyRakK11GbjSaGVo-41X3dWZcJ3OQngmBQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Jim Bos <jim876@xs4all.nl>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org, Rik van Riel <riel@redhat.com>, "Srivatsa S. Bhat" <srivatsa@mit.edu>, Peter Zijlstra <peterz@infradead.org>, Arjan van de Ven <arjan@linux.intel.com>, Rusty Russell <rusty@rustcorp.com.au>, Steven Rostedt <rostedt@goodmis.org>, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Paul Turner <pjt@google.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>, Linux PM <linux-pm@vger.kernel.org>

On 05/11/2016 06:19 PM, Rafael J. Wysocki wrote:
> Have you tried to check if this is the same commit reported in this thread?

The commit in this thread is part of v4.6-rc1 and he is saying that rc1
is working fine.

Sebastian
