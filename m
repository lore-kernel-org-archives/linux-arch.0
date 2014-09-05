Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:48657 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751557AbaIEVFv (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 5 Sep 2014 17:05:51 -0400
Received: from /spool/local
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Fri, 5 Sep 2014 15:05:50 -0600
Date: Fri, 5 Sep 2014 14:05:43 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: bit fields && data tearing
Message-ID: <20140905210543.GC5001@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <54091B30.2090509@zytor.com>
 <20140905081648.GB5281@omega>
 <20140905180950.GU5001@linux.vnet.ibm.com>
 <540A05F7.1070202@hurleysoftware.com>
 <20140905190506.GV5001@linux.vnet.ibm.com>
 <8CA974F497CA064FA9926E10ABCC061F05F97E7B77@MAILSJ4.global.cadence.com>
 <540A19B8.4010907@hurleysoftware.com>
 <540A1E6C.2020005@zytor.com>
 <20140905204312.GA5001@linux.vnet.ibm.com>
 <alpine.DEB.2.10.1409052247460.5472@nanos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.10.1409052247460.5472@nanos>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Peter Hurley <peter@hurleysoftware.com>, Marc Gauthier <marc@cadence.com>, Michael Cree <mcree@orcon.net.nz>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Laight <David.Laight@ACULAB.COM>, Jakub Jelinek <jakub@redhat.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Tony Luck <tony.luck@intel.com>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Paul Mackerras <paulus@samba.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Miroslav Franc <mfranc@redhat.com>, Richard Henderson <rth@twiddle.net>, "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>
Message-ID: <20140905210543.c5fVYK_CFukvQMZYJLaFYJ91ThumIi4UNWRRlroBIcw@z>

On Fri, Sep 05, 2014 at 10:48:34PM +0200, Thomas Gleixner wrote:
> On Fri, 5 Sep 2014, Paul E. McKenney wrote:
> > On Fri, Sep 05, 2014 at 01:34:52PM -0700, H. Peter Anvin wrote:
> > > On 09/05/2014 01:14 PM, Peter Hurley wrote:
> > > > 
> > > > Here's how I read the two statements.
> > > > 
> > > > First, the commit message:
> > > > 
> > > > "It [this commit] documents that CPUs [supported by the Linux kernel]
> > > > _must provide_ atomic one-byte and two-byte naturally aligned loads and stores."
> > > > 
> > > > Second, in the body of the document:
> > > > 
> > > > "The Linux kernel no longer supports pre-EV56 Alpha CPUs, because these
> > > > older CPUs _do not provide_ atomic one-byte and two-byte loads and stores."
> > > > 
> > > 
> > > Does this apply in general or only to SMP configurations?  I guess
> > > non-SMP configurations would still have problems if interrupted in the
> > > wrong place...
> > 
> > And preemption could cause problems, too.  So I believe that it needs
> > to be universal.
> 
> Well preemption is usually caused by an interrupt, except you have a
> combined load and preempt instruction :)

Fair point!  ;-)

							Thanx, Paul

