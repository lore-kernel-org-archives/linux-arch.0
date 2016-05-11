From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: S3 resume regression [1cf4f629d9d2 ("cpu/hotplug: Move online
 calls to hotplugged cpu")]
Date: Wed, 11 May 2016 14:11:29 +0200
Message-ID: <57332171.8070403@linutronix.de>
References: <20160511101920.GZ4329@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:48187 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751271AbcEKMLv (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 11 May 2016 08:11:51 -0400
In-Reply-To: <20160511101920.GZ4329@intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch@vger.kernel.org, Rik van Riel <riel@redhat.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, "Srivatsa S. Bhat" <srivatsa@mit.edu>, Peter Zijlstra <peterz@infradead.org>, Arjan van de Ven <arjan@linux.intel.com>, Rusty Russell <rusty@rustcorp.com.au>, Steven Rostedt <rostedt@goodmis.org>, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Paul Turner <pjt@google.com>, linux-kernel@vger.kernel.org, rui.zhang@intel.com, len.brown@intel.com

On 05/11/2016 12:19 PM, Ville Syrj=E4l=E4 wrote:
> Hi,
Hi,

> I have a Lenovo Ideapad S10-3t machine here (Atom N450, 1 core, 2 HT)
> which fails to resume from S3 on 4.6-rc releases. I bisected it down =
to
>=20
> commit 1cf4f629d9d246519a1e76c021806f2a51ddba4d
> Author: Thomas Gleixner <tglx@linutronix.de>
> Date:   Fri Feb 26 18:43:39 2016 +0000
>=20
>     cpu/hotplug: Move online calls to hotplugged cpu
>=20
> Unfortunately that won't revert cleanly, and neither does the merge
> commit, so I was unable to see if that is the only problematic commit
> in 4.6.
>=20
> Any ideas?

do you have a backtrace or anything or is it just not working and you
end up with a blank screen?

Sebastian
