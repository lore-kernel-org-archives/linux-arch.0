Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:44397 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752801AbXDUUq1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 21 Apr 2007 16:46:27 -0400
From: Andi Kleen <ak@suse.de>
Subject: Re: larger per cpu data
Date: Sat, 21 Apr 2007 22:46:23 +0200
References: <200704201246.17531.ak@suse.de> <m1fy6tiiiu.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1fy6tiiiu.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200704212246.23397.ak@suse.de>
Sender: linux-arch-owner@vger.kernel.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: tony.luck@intel.com, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Saturday 21 April 2007 22:23:21 Eric W. Biederman wrote:
> Andi Kleen <ak@suse.de> writes:
> 
> > Hi,
> >
> > I've been looking at optimizing the network per CPU statistics and the best way
> > to
> > do that would be to move them back to direct per CPU data. Currently they are
> > allocated separately because there used to be some trouble on x86 (and ia64?) 
> > with limited per CPU areas. At least the x86 side has been fixed now. I heard
> > there were some problems with ia64 have those been fixed too?
> > Anybody would have a problem with increasing per CPU data in a standard kernel
> > by a few KB?
> 
> Andi which areas are you looking at modifying.  I'm trying to get a feel
> to see if your changes will have an effect on the network namespace work.


Just the internal implementation of the statistics. Not very many changes
outside those include files

-Andi
