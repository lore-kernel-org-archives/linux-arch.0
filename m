From: "Luis R. Rodriguez" <mcgrof@suse.com>
Subject: Re: [RFC v2 1/7] sections.h: add sections header to collect all
 section info
Date: Fri, 19 Feb 2016 21:06:03 +0100
Message-ID: <20160219200603.GR25240@wotan.suse.de>
References: <1455889559-9428-1-git-send-email-mcgrof@kernel.org>
 <1455889559-9428-2-git-send-email-mcgrof@kernel.org>
 <20160219162329.GA24924@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:35096 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751400AbcBSUGR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 19 Feb 2016 15:06:17 -0500
Content-Disposition: inline
In-Reply-To: <20160219162329.GA24924@kroah.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org, linux-kernel@vger.kernel.org, luto@amacapital.net, boris.ostrovsky@oracle.com, rusty@rustcorp.com.au, david.vrabel@citrix.com, konrad.wilk@oracle.com, mcb30@ipxe.org, jgross@suse.com, ming.lei@canonical.com, arnd@arndb.de, linux-arch@vger.kernel.org, linux@arm.linux.org.uk, benh@kernel.crashing.org, jbaron@akamai.com, ananth@in.ibm.com, anil.s.keshavamurthy@intel.com, davem@davemloft.net, masami.hiramatsu.pt@hitachi.com, andriy.shevchenko@linux.intel.com, dwmw2@infradead.org, xen-devel@lists.xensource.com

On Fri, Feb 19, 2016 at 08:23:29AM -0800, Greg KH wrote:
> On Fri, Feb 19, 2016 at 05:45:53AM -0800, Luis R. Rodriguez wrote:
> > Linux makes extensive use of custom ELF header sections,
> > documentation for these are well scatterred. Unify this
> > documentation in a central place.
> 
> Minor questions:
> 
> > +      <para>
> > +        You should have received a copy of the GNU General Public
> > +        License along with this documentation; if not, write to the Free
> > +        Software Foundation, Inc., 59 Temple Place, Suite 330, Boston,
> > +        MA 02111-1307 USA
> > +      </para>
> 
> Unless you are willing to personally track the office moves of the FSF
> for the next 20+ years, just drop this paragraph please :)

Sure.

> > +++ b/include/linux/sections.h
> > @@ -0,0 +1,224 @@
> > +#ifndef _LINUX_SECTIONS_H
> > +#define _LINUX_SECTIONS_H
> > +/*
> > + * Linux ELF sections
> > + *
> > + * Copyright (C) 2016 Luis R. Rodriguez <mcgrof@kernel.org>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License as published by
> > + * the Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> 
> Do you really mean "any later version"?

Yes.

> > + * Due to this file being licensed under the GPL there is controversy over
> > + * whether this permits you to write a module that #includes this file
> > + * without placing your module under the GPL.  Please consult a lawyer for
> > + * advice before doing this.
> 
> Interesting wording, 

This was copied from security.h. 

> I don't think there's any "controversy" here, so I'd drop that word if at all
> possible.

Change it for something else? Any preference?

  Luis
