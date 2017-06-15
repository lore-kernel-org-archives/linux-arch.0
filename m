Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36051 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750749AbdFOP7N (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 15 Jun 2017 11:59:13 -0400
Date: Fri, 16 Jun 2017 01:59:00 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 3/4] watchdog: Split up config options
Message-ID: <20170616015900.0d133913@roar.ozlabs.ibm.com>
In-Reply-To: <20170615155122.exwji7lkurfjvmzn@redhat.com>
References: <20170603161005.279fe0ef@roar.ozlabs.ibm.com>
        <20170606164958.lkwy7t7xzdpxg4mp@redhat.com>
        <20170607135026.1a6129a8@roar.ozlabs.ibm.com>
        <20170608160502.uzp7vmr7s4fj6hjm@redhat.com>
        <20170612180739.1aa4b123@roar.ozlabs.ibm.com>
        <20170612204156.ov7ka2765t4gdakl@redhat.com>
        <20170614021118.4bbfd00f@roar.ozlabs.ibm.com>
        <20170614140937.qrkajknqxldwdkv2@redhat.com>
        <fc41c166-7db1-79d2-da01-cbcb412952c9@oracle.com>
        <20170615130401.033a39dd@roar.ozlabs.ibm.com>
        <20170615155122.exwji7lkurfjvmzn@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Don Zickus <dzickus@redhat.com>
Cc: Babu Moger <babu.moger@oracle.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20170615155900.V2Q_xFbAnolDkpPeB8kT10eV73Les1aQUGSlINL_VMc@z>

On Thu, 15 Jun 2017 11:51:22 -0400
Don Zickus <dzickus@redhat.com> wrote:

> On Thu, Jun 15, 2017 at 01:04:01PM +1000, Nicholas Piggin wrote:
> > > +#ifdef CONFIG_HARDLOCKUP_DETECTOR
> > >   /* boot commands */
> > >   /*
> > >    * Should we panic when a soft-lockup or hard-lockup occurs:
> > > @@ -69,9 +73,6 @@ static int __init hardlockup_panic_setup(char *str)
> > >          return 1;
> > >   }
> > >   __setup("nmi_watchdog=", hardlockup_panic_setup);
> > > -
> > > -#else
> > > -unsigned long __read_mostly watchdog_enabled = SOFT_WATCHDOG_ENABLED;
> > >   #endif
> > > 
> > >   #ifdef CONFIG_SOFTLOCKUP_DETECTOR  
> > 
> > Hmm, I guess I missed this because sparc parses nmi_watchdog=, but it
> > also relies on the watchdog_enabled value.
> > 
> > I guess I can fold your incremental patch in. I hope we could get
> > sparc quickly to adopt the complate HAVE_HARDLOCKUP_DETECTOR_ARCH soon
> > afterwards though, so we only have 2 cases -- complete hardlockup
> > detector, or the very bare minimum NMI_WATCHDOG.  
> 
> Hi Nick,
> 
> I agree.  Let's move forward with this temp fix just to get things in the
> kernel for initial testing.  Then follow up with a cleanup patch.  The idea
> is we can always revert the cleanup patch if things still don't quite work.
> 
> Thoughts?

Hi Don,

Yeah that sounds good to me. Would you like me to re-test things
and resend the series?

Thanks,
Nick
