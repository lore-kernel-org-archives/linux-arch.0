Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ns.suse.de ([195.135.220.2]:2467 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932560AbWFWMdD (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 23 Jun 2006 08:33:03 -0400
From: Andi Kleen <ak@suse.de>
Subject: Re: [patch 2.6.17] Avoid broadcasting NMI IPIs
Date: Fri, 23 Jun 2006 14:32:56 +0200
References: <8637.1151037121@kao2.melbourne.sgi.com>
In-Reply-To: <8637.1151037121@kao2.melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606231432.56071.ak@suse.de>
Sender: linux-arch-owner@vger.kernel.org
To: Keith Owens <kaos@sgi.com>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Friday 23 June 2006 06:32, Keith Owens wrote:
> On some i386/x86_64 systems, sending an NMI IPI as a broadcast will
> reset the system.  This seems to be a BIOS bug which affects machines
> where one or more cpus are not under OS control.  It occurs on HT
> systems with a version of the OS that is not compiled without HT
> support.  It also occurs when a system is booted with max_cpus=n where
> 2 <= n < cpus known to the BIOS.  The fix is to always send NMI IPI as
> a mask instead of as a broadcast.

Merged thanks.

P.S.: Linux-arch isn't really the right list to cc x86 patches too.
I'm sure the other arch maintainers couldn't care less about such x86isms.

-Andi
