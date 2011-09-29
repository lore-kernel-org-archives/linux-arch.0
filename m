From: Mark Salter <msalter@redhat.com>
Subject: Re: [PATCH v3 00/24] C6X: New architecture
Date: Thu, 29 Sep 2011 08:21:58 -0400
Message-ID: <1317298919.2580.92.camel@deneb.redhat.com>
References: <1317155405-26235-1-git-send-email-msalter@redhat.com>
	 <22021.1317246541@turing-police.cc.vt.edu>
	 <201109291233.24623.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46439 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754299Ab1I2MWH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 29 Sep 2011 08:22:07 -0400
In-Reply-To: <201109291233.24623.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Thu, 2011-09-29 at 12:33 +0200, Arnd Bergmann wrote:
> On Wednesday 28 September 2011, Valdis.Kletnieks@vt.edu wrote:
> >   Show Details
> >   On Tue, 27 Sep 2011 16:29:41 EDT, Mark Salter said:
> > 
> > > This architecture supports members of the Texas Instruments family
> > > of C6x single and multicore DSPs. The multicore DSPs do not support
> > > cache coherancy, so are not suitable for SMP.
> > 
> > Is there a usage model for the multicore? I know somebody had some patches for
> > "HPC dedicated compute cores" that would just basically run a userspace process
> > and that's it - would those be applicable here?
> 
> No, that's a different thing. Even with dedicated compute cores, you need
> cache coherency.

One thing that we plan to push later is an XIP model where cores can
share a
single kernel text image but run with their own copies of data. So you
end up
with something like a loosely coupled multiprocessor system with some
hardware
support for multicore communication and peripheral sharing.

--Mark
