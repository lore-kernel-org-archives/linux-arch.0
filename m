From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: S3 resume regression [1cf4f629d9d2 ("cpu/hotplug: Move online
 calls to hotplugged cpu")]
Date: Wed, 18 May 2016 01:14:42 +0200
Message-ID: <573BA5E2.5040506@intel.com>
References: <20160511101920.GZ4329@intel.com> <57332171.8070403@linutronix.de>
 <20160511122116.GA4329@intel.com>
 <20160511084445.00030b49@gandalf.local.home>
 <20160511133406.GC4329@intel.com> <20160516193910.GL4329@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20160516193910.GL4329@intel.com>
Sender: linux-pm-owner@vger.kernel.org
To: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org, Rik van Riel <riel@redhat.com>, "Srivatsa S. Bhat" <srivatsa@mit.edu>, Peter Zijlstra <peterz@infradead.org>, Arjan van de Ven <arjan@linux.intel.com>, Rusty Russell <rusty@rustcorp.com.au>, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Paul Turner <pjt@google.com>, linux-kernel@vger.kernel.org, rui.zhang@intel.com, len.brown@intel.com, Linux PM <linux-pm@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On 5/16/2016 9:39 PM, Ville Syrj=E4l=E4 wrote:
> On Wed, May 11, 2016 at 04:34:06PM +0300, Ville Syrj=E4l=E4 wrote:
>> On Wed, May 11, 2016 at 08:44:45AM -0400, Steven Rostedt wrote:
>>> On Wed, 11 May 2016 15:21:16 +0300
>>> Ville Syrj=E4l=E4 <ville.syrjala@linux.intel.com> wrote:
>>>
>>>> Yeah can't get anything from the machine at that point. netconsole
>>>> didn't help either, and no serial on this machine. And IIRC I've
>>>> tried ramoops on this thing in the past but unfortunately the memo=
ry
>>>> got cleared on reboot.
>>>>
>>> Can you look at the documentation in the kernel code at
>>>
>>> Documentation/power/basic-pm-debugging.txt And follow the procedure=
s
>>> for testing suspend to RAM (although it requires mostly running the
>>> same tests as for hibernation suspending).
>>>
>>> You can also use the tool s2ram for this as well.
>>>
>>> See Documentation/power/s2ram.txt
>>>
>>> Perhaps this can give us a bit more light onto the problem.
>>>
>>> Basically the above does partial suspend and resume, and can pinpoi=
nt
>>> problem areas down to a more select location.
>> All the pm_test modes work fine. The only difference between them wa=
s
>> that 'platform' required me to manually wake up the machine (hitting=
 a
>> key was sufficient), whereas the others woke up without help.
>>
>> pm_trace gave me
>> [    1.306633]   Magic number: 0:185:178
>> [    1.322880]   hash matches ../drivers/base/power/main.c:1070
>> [    1.339270] acpi device:0e: hash matches
>> [    1.355414]  platform: hash matches
>>
>> which is the TRACE_SUSPEND in __device_suspend_noirq(), so no help
>> there.
>>
>> I guess I could try to sprinkle more TRACE_RESUMEs around into some
>> early resume code. If anyone has good ideas where to put them it
>> might speed things up a bit.
> So I did a bunch of that and found that it gets stuck somewhere
> around executing the _WAK method:
> platform_resume_noirq
>   acpi_pm_finish
>    acpi_leave_sleep_state
>     acpi_hw_sleep_dispatch
>      acpi_hw_legacy_wake
>       acpi_hw_execute_sleep_method
>        acpi_evaluate_object
>         acpi_ns_evaluate
>          acpi_ps_execute_method
>           acpi_ps_parse_aml
>
> It also seesm that adding a few TRACE_RESUME()s or an msleep() right
> after enable_nonboot_cpus() can avoid the hang, sometimes.
>
> I've attached the DSDT in case anyone is interested in looking at it.
>

What if you comment out the execution of _WAK (line 318 of=20
drivers/acpi/acpica/hwsleep.c in 4.6)?  Does that make any difference?

