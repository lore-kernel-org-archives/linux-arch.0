From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Subject: Re: S3 resume regression [1cf4f629d9d2 ("cpu/hotplug: Move online
 calls to hotplugged cpu")]
Date: Thu, 26 May 2016 21:32:07 +0300
Message-ID: <20160526183207.GX4329@intel.com>
References: <20160511101920.GZ4329@intel.com>
 <57332171.8070403@linutronix.de>
 <20160511122116.GA4329@intel.com>
 <20160511084445.00030b49@gandalf.local.home>
 <20160511133406.GC4329@intel.com>
 <20160516193910.GL4329@intel.com>
 <573BA5E2.5040506@intel.com>
 <20160518072424.GU4329@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:26290 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754787AbcEZScQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 26 May 2016 14:32:16 -0400
Content-Disposition: inline
In-Reply-To: <20160518072424.GU4329@intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org, Rik van Riel <riel@redhat.com>, "Srivatsa S. Bhat" <srivatsa@mit.edu>, Peter Zijlstra <peterz@infradead.org>, Arjan van de Ven <arjan@linux.intel.com>, Rusty Russell <rusty@rustcorp.com.au>, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Paul Turner <pjt@google.com>, linux-kernel@vger.kernel.org, rui.zhang@intel.com, len.brown@intel.com, Linux PM <linux-pm@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>

On Wed, May 18, 2016 at 10:24:24AM +0300, Ville Syrj=E4l=E4 wrote:
> On Wed, May 18, 2016 at 01:14:42AM +0200, Rafael J. Wysocki wrote:
> > On 5/16/2016 9:39 PM, Ville Syrj=E4l=E4 wrote:
> > > On Wed, May 11, 2016 at 04:34:06PM +0300, Ville Syrj=E4l=E4 wrote=
:
> > >> On Wed, May 11, 2016 at 08:44:45AM -0400, Steven Rostedt wrote:
> > >>> On Wed, 11 May 2016 15:21:16 +0300
> > >>> Ville Syrj=E4l=E4 <ville.syrjala@linux.intel.com> wrote:
> > >>>
> > >>>> Yeah can't get anything from the machine at that point. netcon=
sole
> > >>>> didn't help either, and no serial on this machine. And IIRC I'=
ve
> > >>>> tried ramoops on this thing in the past but unfortunately the =
memory
> > >>>> got cleared on reboot.
> > >>>>
> > >>> Can you look at the documentation in the kernel code at
> > >>>
> > >>> Documentation/power/basic-pm-debugging.txt And follow the proce=
dures
> > >>> for testing suspend to RAM (although it requires mostly running=
 the
> > >>> same tests as for hibernation suspending).
> > >>>
> > >>> You can also use the tool s2ram for this as well.
> > >>>
> > >>> See Documentation/power/s2ram.txt
> > >>>
> > >>> Perhaps this can give us a bit more light onto the problem.
> > >>>
> > >>> Basically the above does partial suspend and resume, and can pi=
npoint
> > >>> problem areas down to a more select location.
> > >> All the pm_test modes work fine. The only difference between the=
m was
> > >> that 'platform' required me to manually wake up the machine (hit=
ting a
> > >> key was sufficient), whereas the others woke up without help.
> > >>
> > >> pm_trace gave me
> > >> [    1.306633]   Magic number: 0:185:178
> > >> [    1.322880]   hash matches ../drivers/base/power/main.c:1070
> > >> [    1.339270] acpi device:0e: hash matches
> > >> [    1.355414]  platform: hash matches
> > >>
> > >> which is the TRACE_SUSPEND in __device_suspend_noirq(), so no he=
lp
> > >> there.
> > >>
> > >> I guess I could try to sprinkle more TRACE_RESUMEs around into s=
ome
> > >> early resume code. If anyone has good ideas where to put them it
> > >> might speed things up a bit.
> > > So I did a bunch of that and found that it gets stuck somewhere
> > > around executing the _WAK method:
> > > platform_resume_noirq
> > >   acpi_pm_finish
> > >    acpi_leave_sleep_state
> > >     acpi_hw_sleep_dispatch
> > >      acpi_hw_legacy_wake
> > >       acpi_hw_execute_sleep_method
> > >        acpi_evaluate_object
> > >         acpi_ns_evaluate
> > >          acpi_ps_execute_method
> > >           acpi_ps_parse_aml
> > >
> > > It also seesm that adding a few TRACE_RESUME()s or an msleep() ri=
ght
> > > after enable_nonboot_cpus() can avoid the hang, sometimes.
> > >
> > > I've attached the DSDT in case anyone is interested in looking at=
 it.
> > >
> >=20
> > What if you comment out the execution of _WAK (line 318 of=20
> > drivers/acpi/acpica/hwsleep.c in 4.6)?  Does that make any differen=
ce?
>=20
> Indeed it does. Tried with acpi_idle and intel_idle, and both appear =
to
> resume just fine with that hack.
>=20
> -       acpi_hw_execute_sleep_method(METHOD_PATHNAME__WAK, sleep_stat=
e);
> +       //acpi_hw_execute_sleep_method(METHOD_PATHNAME__WAK, sleep_st=
ate);
> +       printk(KERN_CRIT "skipping _WAK\n");

Continuing with my detective work a bit, I decided to hack the DSDT a
bit to see if I can narrow the it down further, and looks like I found
it on the first guess. The following change stops it from hanging.

@ -5056,7 +5056,7 @@
         If (LEqual (Arg0, 0x03))
         {
             Store (0x01, \SPNF)
-	    TRAP (0x46)
+	    //TRAP (0x46)
             P8XH (0x00, 0x03)
         }

So what does that do? Let's see:

    OperationRegion (IO_T, SystemIO, 0x0800, 0x10)
    Field (IO_T, ByteAcc, NoLock, Preserve)
    {
        Offset (0x08),=20
        TRP0,   8
    }

    OperationRegion (GNVS, SystemMemory, 0x3F5E0C7C, 0x0200)
    Field (GNVS, AnyAcc, Lock, Preserve)
    {
        OSYS,   16,=20
        SMIF,   8,
    ...

    Method (TRAP, 1, Serialized)
    {
        Store (Arg0, SMIF) /* \SMIF */
        Store (0x00, TRP0) /* \TRP0 */
        Return (SMIF) /* \SMIF */
    }

and a dump of the IOTR registers shows:

0x1e80: 0x0000fe01
0x1e84: 0x00020001
0x1e98: 0x000c0801
0x1e9c: 0x000200f0

which seems to be telling me that ports 0x800-0x80f and=20
0xfe00-0xfe03 would trigger an SMI.

So the next question is how do the idle drivers and cpu hotplug
fit into this picture. Do we need to force the second HT into
a specific C state before the SMI or something?

--=20
Ville Syrj=E4l=E4
Intel OTC
