From: Jim Bos <jim876@xs4all.nl>
Subject: Re: S3 resume regression [1cf4f629d9d2 ("cpu/hotplug: Move online
 calls to hotplugged cpu")]
Date: Wed, 11 May 2016 17:25:37 +0200
Message-ID: <625fc476-744c-240d-28b0-e1f09712c6a3@xs4all.nl>
References: <20160511101920.GZ4329@intel.com> <57332171.8070403@linutronix.de>
 <20160511122116.GA4329@intel.com> <5733354F.6080703@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------856764C2978570C901716656"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lb1-smtp-cloud6.xs4all.net ([194.109.24.24]:38700 "EHLO
	lb1-smtp-cloud6.xs4all.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932085AbcEKPZq (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 11 May 2016 11:25:46 -0400
In-Reply-To: <5733354F.6080703@intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org, Rik van Riel <riel@redhat.com>, "Srivatsa S. Bhat" <srivatsa@mit.edu>, Peter Zijlstra <peterz@infradead.org>, Arjan van de Ven <arjan@linux.intel.com>, Rusty Russell <rusty@rustcorp.com.au>, Steven Rostedt <rostedt@goodmis.org>, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Paul Turner <pjt@google.com>, linux-kernel@vger.kernel.org, rui.zhang@intel.com, len.brown@intel.com, Linux PM <linux-pm@vger.kernel.org>

This is a multi-part message in MIME format.
--------------856764C2978570C901716656
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit

On 05/11/2016 03:36 PM, Rafael J. Wysocki wrote:
> On 5/11/2016 2:21 PM, Ville Syrjälä wrote:
>> On Wed, May 11, 2016 at 02:11:29PM +0200, Sebastian Andrzej Siewior
>> wrote:
>>> On 05/11/2016 12:19 PM, Ville Syrjälä wrote:
>>>> Hi,
>>> Hi,
>>>
>>>> I have a Lenovo Ideapad S10-3t machine here (Atom N450, 1 core, 2 HT)
>>>> which fails to resume from S3 on 4.6-rc releases. I bisected it down to
>>>>
>>>> commit 1cf4f629d9d246519a1e76c021806f2a51ddba4d
>>>> Author: Thomas Gleixner <tglx@linutronix.de>
>>>> Date:   Fri Feb 26 18:43:39 2016 +0000
>>>>
>>>>      cpu/hotplug: Move online calls to hotplugged cpu
>>>>
>>>> Unfortunately that won't revert cleanly, and neither does the merge
>>>> commit, so I was unable to see if that is the only problematic commit
>>>> in 4.6.
>>>>
>>>> Any ideas?
>>> do you have a backtrace or anything or is it just not working and you
>>> end up with a blank screen?
>> Yeah can't get anything from the machine at that point. netconsole
>> didn't help either, and no serial on this machine. And IIRC I've
>> tried ramoops on this thing in the past but unfortunately the memory
>> got cleared on reboot.
>>
> 
> Please try
> 
> # echo processors > /sys/power/pm_test
> 
> and then suspend (it should simulate a suspend, wait for approx. 5 sec
> and then resume, see
> Documentation/power/basic_pm_debugging.txt for details).  See if that
> works or if you can get any
> traces etc.
> 
> Thanks,
> Rafael
> 


Hmm, I thought I had some resume issue but ignored that, so I just tried
again.
On 4.6.0-rc1 all is fine but on 4.6.0-rc7 on resume the machine locks up
totally. No response on ping or sysrq-B, only hard reset works.

Tried this 'echo processors > /sys/power/pm_test' follow by pm-suspend

and did find a lot of ACPI errors (attached) in the log which are
definitely not present after normal boot.

This is on a Intel(R) Pentium(R) CPU G3220 @ 3.00GHz

So not sure if this is same issue but just wanted to mention it.

_
Jim


--------------856764C2978570C901716656
Content-Type: application/gzip;
 name="dmesg.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="dmesg.gz"

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
y+ttefe0m19cLs8/8HBgAfvvfgfGztcLJ/oAAA==
--------------856764C2978570C901716656--
