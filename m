From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Subject: Re: S3 resume regression [1cf4f629d9d2 ("cpu/hotplug: Move online
 calls to hotplugged cpu")]
Date: Tue, 9 Aug 2016 20:20:57 +0300
Message-ID: <20160809172057.GZ4329@intel.com>
References: <20160511084445.00030b49@gandalf.local.home>
 <20160511133406.GC4329@intel.com>
 <20160516193910.GL4329@intel.com>
 <573BA5E2.5040506@intel.com>
 <20160518072424.GU4329@intel.com>
 <20160526183207.GX4329@intel.com>
 <CAJZ5v0in8YwMBgLd6=KgGVc-f2yVvutOJG_u05OKLK7_EzN0yQ@mail.gmail.com>
 <20160531072650.GP4329@intel.com>
 <20160713145425.GB4329@intel.com>
 <CA++bM2sLMDLdeyLd_gpknTj+Y5xMk261SvivU5YxTnL0jRZovA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA++bM2sLMDLdeyLd_gpknTj+Y5xMk261SvivU5YxTnL0jRZovA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Feng Tang <feng.79.tang@gmail.com>
Cc: feng.tang@intel.com, "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Steven Rostedt <rostedt@goodmis.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org, Rik van Riel <riel@redhat.com>, "Srivatsa S. Bhat" <srivatsa@mit.edu>, Peter Zijlstra <peterz@infradead.org>, Arjan van de Ven <arjan@linux.intel.com>, Rusty Russell <rusty@rustcorp.com.au>, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Paul Turner <pjt@google.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>, Linux PM <linux-pm@vger.kernel.org>, Linux ACPI <linux-acpi@vger.ke>
List-Id: linux-arch.vger.kernel.org

On Thu, Jul 14, 2016 at 04:29:42PM +0800, Feng Tang wrote:
> if you only want it to work, you can try an old patch
> https://bugzilla.kernel.org/attachment.cgi?id=76071 from a similar bug
> https://bugzilla.kernel.org/show_bug.cgi?id=41932
> 
> Alistair Buxton confirmed it work for 3.18 at least
> https://bugzilla.kernel.org/show_bug.cgi?id=107151#c16

That patch is a bit too ripe by now. Would need a fresh squeezed one.

> 
> Thanks,
> Feng
> 
> On Wed, Jul 13, 2016 at 10:54 PM, Ville Syrjälä
> <ville.syrjala@linux.intel.com> wrote:
> > On Tue, May 31, 2016 at 10:26:50AM +0300, Ville Syrjälä wrote:
> >> On Mon, May 30, 2016 at 10:43:51PM +0200, Rafael J. Wysocki wrote:
> >> > On Thu, May 26, 2016 at 8:32 PM, Ville Syrjälä
> >> > <ville.syrjala@linux.intel.com> wrote:
> >> > > On Wed, May 18, 2016 at 10:24:24AM +0300, Ville Syrjälä wrote:
> >> > >> On Wed, May 18, 2016 at 01:14:42AM +0200, Rafael J. Wysocki wrote:
> >> > >> > On 5/16/2016 9:39 PM, Ville Syrjälä wrote:
> >> > >> > > On Wed, May 11, 2016 at 04:34:06PM +0300, Ville Syrjälä wrote:
> >> > >> > >> On Wed, May 11, 2016 at 08:44:45AM -0400, Steven Rostedt wrote:
> >> > >> > >>> On Wed, 11 May 2016 15:21:16 +0300
> >> > >> > >>> Ville Syrjälä <ville.syrjala@linux.intel.com> wrote:
> >> > >> > >>>
> >> > >> > >>>> Yeah can't get anything from the machine at that point. netconsole
> >> > >> > >>>> didn't help either, and no serial on this machine. And IIRC I've
> >> > >> > >>>> tried ramoops on this thing in the past but unfortunately the memory
> >> > >> > >>>> got cleared on reboot.
> >> > >> > >>>>
> >> > >> > >>> Can you look at the documentation in the kernel code at
> >> > >> > >>>
> >> > >> > >>> Documentation/power/basic-pm-debugging.txt And follow the procedures
> >> > >> > >>> for testing suspend to RAM (although it requires mostly running the
> >> > >> > >>> same tests as for hibernation suspending).
> >> > >> > >>>
> >> > >> > >>> You can also use the tool s2ram for this as well.
> >> > >> > >>>
> >> > >> > >>> See Documentation/power/s2ram.txt
> >> > >> > >>>
> >> > >> > >>> Perhaps this can give us a bit more light onto the problem.
> >> > >> > >>>
> >> > >> > >>> Basically the above does partial suspend and resume, and can pinpoint
> >> > >> > >>> problem areas down to a more select location.
> >> > >> > >> All the pm_test modes work fine. The only difference between them was
> >> > >> > >> that 'platform' required me to manually wake up the machine (hitting a
> >> > >> > >> key was sufficient), whereas the others woke up without help.
> >> > >> > >>
> >> > >> > >> pm_trace gave me
> >> > >> > >> [    1.306633]   Magic number: 0:185:178
> >> > >> > >> [    1.322880]   hash matches ../drivers/base/power/main.c:1070
> >> > >> > >> [    1.339270] acpi device:0e: hash matches
> >> > >> > >> [    1.355414]  platform: hash matches
> >> > >> > >>
> >> > >> > >> which is the TRACE_SUSPEND in __device_suspend_noirq(), so no help
> >> > >> > >> there.
> >> > >> > >>
> >> > >> > >> I guess I could try to sprinkle more TRACE_RESUMEs around into some
> >> > >> > >> early resume code. If anyone has good ideas where to put them it
> >> > >> > >> might speed things up a bit.
> >> > >> > > So I did a bunch of that and found that it gets stuck somewhere
> >> > >> > > around executing the _WAK method:
> >> > >> > > platform_resume_noirq
> >> > >> > >   acpi_pm_finish
> >> > >> > >    acpi_leave_sleep_state
> >> > >> > >     acpi_hw_sleep_dispatch
> >> > >> > >      acpi_hw_legacy_wake
> >> > >> > >       acpi_hw_execute_sleep_method
> >> > >> > >        acpi_evaluate_object
> >> > >> > >         acpi_ns_evaluate
> >> > >> > >          acpi_ps_execute_method
> >> > >> > >           acpi_ps_parse_aml
> >> > >> > >
> >> > >> > > It also seesm that adding a few TRACE_RESUME()s or an msleep() right
> >> > >> > > after enable_nonboot_cpus() can avoid the hang, sometimes.
> >> > >> > >
> >> > >> > > I've attached the DSDT in case anyone is interested in looking at it.
> >> > >> > >
> >> > >> >
> >> > >> > What if you comment out the execution of _WAK (line 318 of
> >> > >> > drivers/acpi/acpica/hwsleep.c in 4.6)?  Does that make any difference?
> >> > >>
> >> > >> Indeed it does. Tried with acpi_idle and intel_idle, and both appear to
> >> > >> resume just fine with that hack.
> >> > >>
> >> > >> -       acpi_hw_execute_sleep_method(METHOD_PATHNAME__WAK, sleep_state);
> >> > >> +       //acpi_hw_execute_sleep_method(METHOD_PATHNAME__WAK, sleep_state);
> >> > >> +       printk(KERN_CRIT "skipping _WAK\n");
> >> > >
> >> > > Continuing with my detective work a bit, I decided to hack the DSDT a
> >> > > bit to see if I can narrow the it down further, and looks like I found
> >> > > it on the first guess. The following change stops it from hanging.
> >> > >
> >> > > @ -5056,7 +5056,7 @@
> >> > >          If (LEqual (Arg0, 0x03))
> >> > >          {
> >> > >              Store (0x01, \SPNF)
> >> > > -           TRAP (0x46)
> >> > > +           //TRAP (0x46)
> >> > >              P8XH (0x00, 0x03)
> >> > >          }
> >> > >
> >> > > So what does that do? Let's see:
> >> > >
> >> > >     OperationRegion (IO_T, SystemIO, 0x0800, 0x10)
> >> > >     Field (IO_T, ByteAcc, NoLock, Preserve)
> >> > >     {
> >> > >         Offset (0x08),
> >> > >         TRP0,   8
> >> > >     }
> >> > >
> >> > >     OperationRegion (GNVS, SystemMemory, 0x3F5E0C7C, 0x0200)
> >> > >     Field (GNVS, AnyAcc, Lock, Preserve)
> >> > >     {
> >> > >         OSYS,   16,
> >> > >         SMIF,   8,
> >> > >     ...
> >> > >
> >> > >     Method (TRAP, 1, Serialized)
> >> > >     {
> >> > >         Store (Arg0, SMIF) /* \SMIF */
> >> > >         Store (0x00, TRP0) /* \TRP0 */
> >> > >         Return (SMIF) /* \SMIF */
> >> > >     }
> >> > >
> >> > > and a dump of the IOTR registers shows:
> >> > >
> >> > > 0x1e80: 0x0000fe01
> >> > > 0x1e84: 0x00020001
> >> > > 0x1e98: 0x000c0801
> >> > > 0x1e9c: 0x000200f0
> >> > >
> >> > > which seems to be telling me that ports 0x800-0x80f and
> >> > > 0xfe00-0xfe03 would trigger an SMI.
> >> >
> >> > Well, the name of the method kind of suggests that it triggers an SMM trap. :-)
> >>
> >> Which is why I wanted confirm that by looking at the IOTR regs ;)
> >>
> >> >
> >> > > So the next question is how do the idle drivers and cpu hotplug
> >> > > fit into this picture. Do we need to force the second HT into
> >> > > a specific C state before the SMI or something?
> >> >
> >> > Or you can ask why exactly someone put that SMM trap into _WAK.
> >> >
> >> > Apparently, it was regarded as necessary or no one would have
> >> > bothered.  The only reason I can see why it might be regarded as
> >> > necessary was that Windows did something Linux doesn't do on that
> >> > platform, or, which to me is far more interesting, that Windows didn't
> >> > do something actually done by Linux.
> >> >
> >> > My theory would be that Windows didn't reinitialize the second HT
> >> > properly during resume and the trap was added to let SMM do that.  If
> >> > that's the case, the trap may trigger by the time the second HT
> >> > already executes code in Linux and then it will mess up with it and
> >> > crash.
> >> >
> >> > Now, what do idles states have to do with that?  IIRC, Windows puts
> >> > nonboot CPUs into idle states before suspend, so the SMM code
> >> > triggered by the trap may make assumptions about the CPU being in such
> >> > a state or similar.
> >>
> >> BTW I also tried to move the enable_nonboot_cpus() after _WAK, and I
> >> tried to boot with nosmp, but neither trick helped. If someone could
> >> throw some patches my way to force things into a specific state
> >> before suspend/_WAK I'd be happy to test them out.
> >
> > Ping. Anyone have any ideas what to try here? Would be nice to get this
> > machine working again...
> >
> > --
> > Ville Syrjälä
> > Intel OTC
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Ville Syrjälä
Intel OTC
