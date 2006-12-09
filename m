Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:59027
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1757935AbWLIWDh (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 9 Dec 2006 17:03:37 -0500
Date: Sat, 09 Dec 2006 14:03:38 -0800 (PST)
Message-Id: <20061209.140338.115923578.davem@davemloft.net>
Subject: Re: [PATCH RFC] use of activate_mm in fs/aio.c:use_mm()?
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061208154522.a03bd90b.akpm@osdl.org>
References: <45776D54.7030409@goop.org>
	<45777002.6050009@goop.org>
	<20061208154522.a03bd90b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: akpm@osdl.org
Cc: jeremy@goop.org, zach.brown@oracle.com, pbadari@us.ibm.com, nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org, zach@vmware.com, chrisw@sous-sol.org, rusty@rustcorp.com.au, jdike@addtoit.com, torvalds@osdl.org, linux-arch@vger.kernel.org, linux-aio@kvack.org
List-ID: <linux-arch.vger.kernel.org>

From: Andrew Morton <akpm@osdl.org>
Date: Fri, 8 Dec 2006 15:45:22 -0800

> On Wed, 06 Dec 2006 17:36:02 -0800
> Jeremy Fitzhardinge <jeremy@goop.org> wrote:
> 
> > Jeremy Fitzhardinge wrote:
> > > I'm wondering if activate_mm() is the right thing to be using in
> > > use_mm(); shouldn't this be switch_mm()?
> > >
> > > On normal x86, they're synonymous, but for the Xen patches I'm adding a
> > > hook which assumes that activate_mm is only used the first time a new mm
> > > is used after creation (I have another hook for dealing with dup_mm).  I
> > > think this use of activate_mm() is the only place where it could be used
> > > a second time on an mm.
> > >
> > > From a quick look at the other architectures I think this is OK (most
> > > simply implement one in terms of the other), but some are doing some
> > > subtly different stuff between the two.
> > >
> > > Thanks,
> > >     J
> > >
> > >
> > >   
> > Er, lets try that again:
> > 
> > diff -r 455b71ed4525 fs/aio.c
> > --- a/fs/aio.c	Wed Dec 06 13:16:42 2006 -0800
> > +++ b/fs/aio.c	Wed Dec 06 17:17:43 2006 -0800
> > @@ -588,7 +588,7 @@ static void use_mm(struct mm_struct *mm)
> >  	 * Note that on UML this *requires* PF_BORROWED_MM to be set, otherwise
> >  	 * it won't work. Update it accordingly if you change it here
> >  	 */
> > -	activate_mm(active_mm, mm);
> > +	switch_mm(active_mm, mm, tsk);
> >  	task_unlock(tsk);
> >  
> >  	mmdrop(active_mm);
> 
> That to me sounds like a reasonable description of the difference between
> activate_mm() and switch_mm().  And the change appears reasonable as well.
> 
> But it is a change which the architecture maintainers would need to have a
> think about, please.

This looks absolutely correct to me.
