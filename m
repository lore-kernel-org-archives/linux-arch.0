Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.suse.de ([195.135.220.2]:17089 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932988AbWFXImO (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sat, 24 Jun 2006 04:42:14 -0400
From: Andi Kleen <ak@suse.de>
Subject: Re: [patch 2.6.17] Avoid broadcasting NMI IPIs
Date: Sat, 24 Jun 2006 10:36:53 +0200
References: <23861.1151136920@ocs3.ocs.com.au>
In-Reply-To: <23861.1151136920@ocs3.ocs.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606241036.53597.ak@suse.de>
Sender: linux-arch-owner@vger.kernel.org
To: Keith Owens <kaos@sgi.com>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Saturday 24 June 2006 10:15, Keith Owens wrote:
> Andi Kleen (on Fri, 23 Jun 2006 14:32:56 +0200) wrote:
> >On Friday 23 June 2006 06:32, Keith Owens wrote:
> >> On some i386/x86_64 systems, sending an NMI IPI as a broadcast will
> >> reset the system.  This seems to be a BIOS bug which affects machines
> >> where one or more cpus are not under OS control.  It occurs on HT
> >> systems with a version of the OS that is not compiled without HT
> >> support.  It also occurs when a system is booted with max_cpus=n where
> >> 2 <= n < cpus known to the BIOS.  The fix is to always send NMI IPI as
> >> a mask instead of as a broadcast.
> >
> >Merged thanks.
> >
> >P.S.: Linux-arch isn't really the right list to cc x86 patches too.
> >I'm sure the other arch maintainers couldn't care less about such x86isms.
>
> These two patches were for both i386 and x86_64, not just for x86_64.

It's still not the right list for that. linux-arch is just to broadcast stuff
interesting to all architecture maintainers, not some kind of x86 list.

BTW  they didn't compile without fixes on x86-64-UP nor
i386-SMP. Please compile test patches better next time. 

-Andi
