From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH -v2 2/2] genericirq: change ack/mask in irq_chip to take
 irq_desc instead of irq
Date: Wed, 3 Mar 2010 11:26:13 +0100 (CET)
Message-ID: <alpine.LFD.2.00.1003031120510.4245@localhost.localdomain>
References: <1266029390-30907-1-git-send-email-yinghai@kernel.org> <m1zl3dre9e.fsf@fess.ebiederm.org> <4B7676BB.8030608@kernel.org> <m1ljexpcjp.fsf@fess.ebiederm.org> <4B772A54.1000000@kernel.org> <m16360ohi2.fsf@fess.ebiederm.org> <4B773CEB.9010609@kernel.org>
 <m1sk94mzg0.fsf@fess.ebiederm.org> <4B7CA9A1.3020806@kernel.org> <4B7CAADD.2060000@kernel.org> <m1mxz6v4pm.fsf@fess.ebiederm.org> <4B83781B.20307@kernel.org> <4B837930.2050907@kernel.org> <m1ljei5n9q.fsf@fess.ebiederm.org> <alpine.LFD.2.00.1003021522340.4245@localhost.localdomain>
 <4B8E22A9.8010807@kernel.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4B8E22A9.8010807@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Rusty Russell <rusty@rustcorp.com.au>, Suresh Siddha <suresh.b.siddha@intel.com>, LKML <linux-kernel@vger.kernel.org>, Jeremy Fitzhardinge <jeremy@goop.org>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Wed, 3 Mar 2010, Yinghai Lu wrote:
> > 
> > The right way to do that is 
> > 
> >   1) add new function pointers, which take irq_desc as their argument
> > 
> >   2) make the generic code use them when the old function pointer is
> >      NULL
> > 
> >   3) convert the irq_chip implementations one by one with separate
> >      patches
> > 
> >   4) Remove the old function pointers and switch the generic code
> >      fully over to use the new ones
> > 
> > Yes, it's more work, but it's less error prone and easier to review,
> > as the maintainers just have to look at the patch which affects their
> > particular area.
> 
> good. please check if you are happy with this version.

It's better, but again please provide separate patches for:

     1) the new function pointers

     2) kernel/irq/* making use of them

     3) separate patches for each irq_chip conversion. If several
        chips share the same mask/unmask/etc. functions, then one
        patch for converting those related ones is fine.

Thanks,

	tglx
