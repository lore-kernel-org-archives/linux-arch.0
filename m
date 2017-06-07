From: Don Zickus <dzickus@redhat.com>
Subject: Re: [PATCH 0/4][V3] Improve watchdog config for arch watchdogs
Date: Wed, 7 Jun 2017 10:37:51 -0400
Message-ID: <20170607143751.rnaa5c4jeggptvic@redhat.com>
References: <20170530012659.16791-1-npiggin@gmail.com>
 <20170606160847.izishwer3m5jirkb@redhat.com>
 <d274b1a5-c8b3-9e3a-b45d-c63c9022be91@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d274b1a5-c8b3-9e3a-b45d-c63c9022be91@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Babu Moger <babu.moger@oracle.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Tue, Jun 06, 2017 at 02:46:48PM -0500, Babu Moger wrote:
> Hi Don, Nicholas,
> 
> 
> On 6/6/2017 11:08 AM, Don Zickus wrote:
> > (adding Babu)
> > 
> > On Tue, May 30, 2017 at 11:26:55AM +1000, Nicholas Piggin wrote:
> > > Since last time:
> > > 
> > > - Have the perf based hardlockup detector use arch_touch_nmi_watchdog()
> > >    rather than hld_touch_nmi_watchdog(). This changes direction slightly
> > >    to make the perf-based hard lockup detector an alternative that an
> > >    arch may select, rather than standalone. This better reflects how the
> > >    code works in practice).
> > > 
> > > - Hopefully fixed the Kconfig options. There's still a bit of ugliness
> > >    that will require another pass or two over interfaces and config
> > >    scheme, but the idea is to make a minimal change to get the powerpc
> > >    HLD in, which gives a reasonable starting point to improve things
> > >    further.
> > Hi Babu,
> > 
> > Does this patchset break sparc?  Specifically patch3 with all the config
> Patches applies, compiles fine and also works fine for most part. However,
> there are few issues.

Thanks for the quick turnaround!

> 
> We need to enter 'N' or 'Y'  for SOFTLOCKUP_DETECTOR.
> 
> *
> * Restart config...
> *
> *
> * Debug Lockups and Hangs
> *
> Detect Hard and Soft Lockups (LOCKUP_DETECTOR) [Y/n/?] y
>   Detect Soft Lockups (SOFTLOCKUP_DETECTOR) [N/y] (NEW)
> 
> For SPARC, softlockup is enabled by default earlier.   May be we need to
> submit another patch to enable this in
> 
> arch/sparc/configs/sparc64_defconfig.   Not  a big issue.

Hmm, I think the nmi_enable/disable stuff is wrapped into the
SOFTLOCKUP_DETECTOR code, so you might need it.  Though Nick did create a
separate interface outside of SOFTLOCKUP to something similar.  I believe
patch4 introduces nmi_reconfigure().

Not sure if the spirit of the sparc nmi_watchdog code wants SOFTLOCKUP or
not.

> 
> 
> Another issue.
> before that patch
> 
> # cat /proc/sys/kernel/watchdog
> 1
> # cat /proc/sys/kernel/nmi_watchdog
> 1
> 
> After the patch
> 
> # cat /proc/sys/kernel/watchdog
> 1
> # cat /proc/sys/kernel/nmi_watchdog
> 0

Yes, that is what I thought.  Thanks for confirming!

> 
> I think this is mostly due to change in this code below.
> 
> #ifdef CONFIG_HARDLOCKUP_DETECTOR
> unsigned long __read_mostly watchdog_enabled =
> SOFT_WATCHDOG_ENABLED|NMI_WATCHDOG_ENABLED;
> 
> Old code was like this
> 
> #if defined(CONFIG_HAVE_NMI_WATCHDOG) || defined(CONFIG_HARDLOCKUP_DETECTOR)
> unsigned long __read_mostly watchdog_enabled =
> SOFT_WATCHDOG_ENABLED|NMI_WATCHDOG_ENABLED;
> #else
> unsigned long __read_mostly watchdog_enabled = SOFT_WATCHDOG_ENABLED;
> #endif
> 
> SPARC defines CONFIG_HAVE_NMI_WATCHDOG.


I am still working with Nick to deal with these config issues.  But I am
going to keep this one in mind while we work through it.

Cheers,
Don
