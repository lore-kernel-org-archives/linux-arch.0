Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33180 "EHLO
	mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751605AbcEKQTk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 11 May 2016 12:19:40 -0400
MIME-Version: 1.0
In-Reply-To: <625fc476-744c-240d-28b0-e1f09712c6a3@xs4all.nl>
References: <20160511101920.GZ4329@intel.com>
	<57332171.8070403@linutronix.de>
	<20160511122116.GA4329@intel.com>
	<5733354F.6080703@intel.com>
	<625fc476-744c-240d-28b0-e1f09712c6a3@xs4all.nl>
Date: Wed, 11 May 2016 18:19:37 +0200
Message-ID: <CAJZ5v0iNakYVA6bynyRakK11GbjSaGVo-41X3dWZcJ3OQngmBQ@mail.gmail.com>
Subject: Re: S3 resume regression [1cf4f629d9d2 ("cpu/hotplug: Move online
 calls to hotplugged cpu")]
From: "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jim Bos <jim876@xs4all.nl>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org, Rik van Riel <riel@redhat.com>, "Srivatsa S. Bhat" <srivatsa@mit.edu>, Peter Zijlstra <peterz@infradead.org>, Arjan van de Ven <arjan@linux.intel.com>, Rusty Russell <rusty@rustcorp.com.au>, Steven Rostedt <rostedt@goodmis.org>, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Paul Turner <pjt@google.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>, Linux PM <linux-pm@vger.kernel.org>
Message-ID: <20160511161937.fas8_Kp9GD_rjpPGccLaQidhoQ0cGgienYOVNlCqad0@z>

On Wed, May 11, 2016 at 5:25 PM, Jim Bos <jim876@xs4all.nl> wrote:
> On 05/11/2016 03:36 PM, Rafael J. Wysocki wrote:
>> On 5/11/2016 2:21 PM, Ville Syrjälä wrote:
>>> On Wed, May 11, 2016 at 02:11:29PM +0200, Sebastian Andrzej Siewior
>>> wrote:
>>>> On 05/11/2016 12:19 PM, Ville Syrjälä wrote:
>>>>> Hi,
>>>> Hi,
>>>>
>>>>> I have a Lenovo Ideapad S10-3t machine here (Atom N450, 1 core, 2 HT)
>>>>> which fails to resume from S3 on 4.6-rc releases. I bisected it down to
>>>>>
>>>>> commit 1cf4f629d9d246519a1e76c021806f2a51ddba4d
>>>>> Author: Thomas Gleixner <tglx@linutronix.de>
>>>>> Date:   Fri Feb 26 18:43:39 2016 +0000
>>>>>
>>>>>      cpu/hotplug: Move online calls to hotplugged cpu
>>>>>
>>>>> Unfortunately that won't revert cleanly, and neither does the merge
>>>>> commit, so I was unable to see if that is the only problematic commit
>>>>> in 4.6.
>>>>>
>>>>> Any ideas?
>>>> do you have a backtrace or anything or is it just not working and you
>>>> end up with a blank screen?
>>> Yeah can't get anything from the machine at that point. netconsole
>>> didn't help either, and no serial on this machine. And IIRC I've
>>> tried ramoops on this thing in the past but unfortunately the memory
>>> got cleared on reboot.
>>>
>>
>> Please try
>>
>> # echo processors > /sys/power/pm_test
>>
>> and then suspend (it should simulate a suspend, wait for approx. 5 sec
>> and then resume, see
>> Documentation/power/basic_pm_debugging.txt for details).  See if that
>> works or if you can get any
>> traces etc.
>>
>> Thanks,
>> Rafael
>>
>
>
> Hmm, I thought I had some resume issue but ignored that, so I just tried
> again.
> On 4.6.0-rc1 all is fine but on 4.6.0-rc7 on resume the machine locks up
> totally. No response on ping or sysrq-B, only hard reset works.
>
> Tried this 'echo processors > /sys/power/pm_test' follow by pm-suspend
>
> and did find a lot of ACPI errors (attached) in the log which are
> definitely not present after normal boot.
>
> This is on a Intel(R) Pentium(R) CPU G3220 @ 3.00GHz
>
> So not sure if this is same issue but just wanted to mention it.

If the problem is reproducible, you should be able to identify the
commit that broke things for you.

Have you tried to check if this is the same commit reported in this thread?
