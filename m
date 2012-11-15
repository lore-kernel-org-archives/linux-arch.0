From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: new architectures, time_t __kernel_long_t
Date: Thu, 15 Nov 2012 14:36:22 +0000
Message-ID: <201211151436.23088.arnd@arndb.de>
References: <201211141218.02105.arnd@arndb.de> <201211150914.22835.arnd@arndb.de> <CAMe9rOpziKa6QLfjX9iXtfj_X2QAyDAV2p8NEd8Wd7yFwTrpNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:61019 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2993437Ab2KOOhB (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 15 Nov 2012 09:37:01 -0500
In-Reply-To: <CAMe9rOpziKa6QLfjX9iXtfj_X2QAyDAV2p8NEd8Wd7yFwTrpNg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H.J. Lu" <hjl.tools@gmail.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-arch@vger.kernel.org, Vineet.Gupta1@synopsys.com, linux-kernel@vger.kernel.org, James Hogan <james.hogan@imgtec.com>

On Thursday 15 November 2012, H.J. Lu wrote:
> On Thu, Nov 15, 2012 at 1:14 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Wednesday 14 November 2012, H. Peter Anvin wrote:
> >> On 11/14/2012 04:18 AM, Arnd Bergmann wrote:
> >> > Since we are in the review phase for two new architectures that we
> >> > should be merging into the mainline kernel, I think we need to
> >> > come up with a solution for making them use a proper 64-bit time_t.
> >> >
> >> > Right now, the only 32-bit user space interface we have to use 64-bit
> >> > time_t is the x32 side of x86-64, and that works by overriding all
> >> > "long" sized types to be 64 bit at the ABI level, which we don't
> >> > want for pure 32 bit architectures.
> >>
> >> Sort of.  Either way, the kernel headers aren't really x32-clean yet, so
> >> we have an opportunity to do things more cleanly as we are implementing
> >> this.
> >
> > Ah, I didn't know that. How does one build an x32 libc then?
> 
> Glibc has been providing its own types for years.
> Kernel provided types used to be wrong for ia32
> on x86-64.

What about ioctls and other calls then that actually do rely on the
kernel headers and use the __kernel_*_t types?

	Arnd
