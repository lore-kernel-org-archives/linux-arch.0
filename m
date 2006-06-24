Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.ocs.com.au ([202.147.117.210]:55237 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S1751224AbWFXIP7 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sat, 24 Jun 2006 04:15:59 -0400
From: Keith Owens <kaos@sgi.com>
Subject: Re: [patch 2.6.17] Avoid broadcasting NMI IPIs 
In-reply-to: Your message of "Fri, 23 Jun 2006 14:32:56 +0200."
             <200606231432.56071.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 24 Jun 2006 18:15:20 +1000
Message-ID: <23861.1151136920@ocs3.ocs.com.au>
Sender: linux-arch-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Andi Kleen (on Fri, 23 Jun 2006 14:32:56 +0200) wrote:
>On Friday 23 June 2006 06:32, Keith Owens wrote:
>> On some i386/x86_64 systems, sending an NMI IPI as a broadcast will
>> reset the system.  This seems to be a BIOS bug which affects machines
>> where one or more cpus are not under OS control.  It occurs on HT
>> systems with a version of the OS that is not compiled without HT
>> support.  It also occurs when a system is booted with max_cpus=n where
>> 2 <= n < cpus known to the BIOS.  The fix is to always send NMI IPI as
>> a mask instead of as a broadcast.
>
>Merged thanks.
>
>P.S.: Linux-arch isn't really the right list to cc x86 patches too.
>I'm sure the other arch maintainers couldn't care less about such x86isms.

These two patches were for both i386 and x86_64, not just for x86_64.

