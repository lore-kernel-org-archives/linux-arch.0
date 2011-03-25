From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: Link breakage on all architectures which implement their own
 show_mem
Date: Fri, 25 Mar 2011 09:11:18 -0500
Message-ID: <1301062279.4073.1.camel@mulgrave.site>
References: <1300898506.15899.24.camel@mulgrave.site>
	 <1301050500.2402.487.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:37996 "EHLO
	bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752474Ab1CYOLY (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 25 Mar 2011 10:11:24 -0400
In-Reply-To: <1301050500.2402.487.camel@pasglop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: David Rientjes <rientjes@google.com>, linux-arch@vger.kernel.org

On Fri, 2011-03-25 at 21:55 +1100, Benjamin Herrenschmidt wrote:
> On Wed, 2011-03-23 at 11:41 -0500, James Bottomley wrote:
> >     oom: suppress nodes that are not allowed from meminfo on oom kill
> > 
> > Is the cause.  What it does is introduce a new __show_mem() which is
> > required by files in mm/, so the object containing it: show_mem.o gets
> > pulled in all the time in the link and that gives every architecture
> > that implements their own show_mem() a link failure because of the
> > double definition.  Library linking works at the file level, not at
> > the
> > function level.  To work, you have to put these functions in separate 
> 
> Can't this be fixed by making show_mem() weak ? Or am I missing
> something ?

Yes, I think so; there are multiple ways of solving this ... part of the
point I was making was that there's little point having something in
lib.a if it always gets linked (which this will because of the multiple
callsites for __show_mem())

James
