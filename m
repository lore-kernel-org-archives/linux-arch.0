From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: S3 resume regression [1cf4f629d9d2 ("cpu/hotplug: Move online
 calls to hotplugged cpu")]
Date: Wed, 11 May 2016 14:24:51 +0200
Message-ID: <57332493.5090501@linutronix.de>
References: <20160511101920.GZ4329@intel.com> <57332171.8070403@linutronix.de>
 <20160511122116.GA4329@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:48292 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751824AbcEKMZH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 11 May 2016 08:25:07 -0400
In-Reply-To: <20160511122116.GA4329@intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org, Rik van Riel <riel@redhat.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, "Srivatsa S. Bhat" <srivatsa@mit.edu>, Peter Zijlstra <peterz@infradead.org>, Arjan van de Ven <arjan@linux.intel.com>, Rusty Russell <rusty@rustcorp.com.au>, Steven Rostedt <rostedt@goodmis.org>, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Paul Turner <pjt@google.com>, linux-kernel@vger.kernel.org, rui.zhang@intel.com, len.brown@intel.com

On 05/11/2016 02:21 PM, Ville Syrj=E4l=E4 wrote:
> Yeah can't get anything from the machine at that point. netconsole
> didn't help either, and no serial on this machine. And IIRC I've
> tried ramoops on this thing in the past but unfortunately the memory
> got cleared on reboot.

efi + pstore maybe?

Sebastian
