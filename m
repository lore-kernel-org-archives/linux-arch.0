Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:39560 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752573AbXDUUYK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 21 Apr 2007 16:24:10 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: larger per cpu data
References: <200704201246.17531.ak@suse.de>
Date: Sat, 21 Apr 2007 14:23:21 -0600
In-Reply-To: <200704201246.17531.ak@suse.de> (Andi Kleen's message of "Fri, 20
	Apr 2007 12:46:17 +0200")
Message-ID: <m1fy6tiiiu.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-arch-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: tony.luck@intel.com, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Andi Kleen <ak@suse.de> writes:

> Hi,
>
> I've been looking at optimizing the network per CPU statistics and the best way
> to
> do that would be to move them back to direct per CPU data. Currently they are
> allocated separately because there used to be some trouble on x86 (and ia64?) 
> with limited per CPU areas. At least the x86 side has been fixed now. I heard
> there were some problems with ia64 have those been fixed too?
> Anybody would have a problem with increasing per CPU data in a standard kernel
> by a few KB?

Andi which areas are you looking at modifying.  I'm trying to get a feel
to see if your changes will have an effect on the network namespace work.

Eric
