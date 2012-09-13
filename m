From: Greg Ungerer <gerg@snapgear.com>
Subject: Re: [RFC] status of execve() work - per-architecture patches solicited
Date: Thu, 13 Sep 2012 23:27:14 +1000
Message-ID: <5051DF32.1060506@snapgear.com>
References: <20120907182004.GE13973@ZenIV.linux.org.uk> <504DEDBB.1090404@westnet.com.au> <20120910164946.GO13973@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from dnvwsmailout1.mcafee.com ([161.69.31.173]:58750 "EHLO
	DNVWSMAILOUT1.mcafee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752299Ab2IMN2I (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 13 Sep 2012 09:28:08 -0400
In-Reply-To: <20120910164946.GO13973@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On 09/11/2012 02:49 AM, Al Viro wrote:
> BTW, the same question goes for many other embedded targets - I'm using
> qemu for arm and mips and hercules for s390; alpha, parisc, ppc32 and sparc64 -
> on actual hardware, amd64 and i386 - on kvm guests (all with debian userland);
> ia64 kinda-sorta works with ski, but it's very much imperfect...  I think
> sh (at least sh4) should be usable with qemu as well, but I hadn't set that
> up yet.  sparc32 is usable on qemu, but only with very old userland.
> Everything else...  In theory, quite a few ought to be usable if one
> bootstraps uclinux userland with qemu, but I've no idea how well does that
> work in practice.  And seeing that e.g. FRV eval boards go for several
> hundred dollars even on ebay, let alone from manufacturer, I'd rather not
> add the actual hardware to the pile here ;-/

I have managed to get qemu to run modern non-MMU ColdFire kernels.
Stock qemu-1.2 itself didn't work, but after a couple of fixes it is
now running again. It doesn't support ColdFire with MMU yet though.

Regards
Greg


------------------------------------------------------------------------
Greg Ungerer  --  Principal Engineer        EMAIL:     gerg@snapgear.com
SnapGear Group, McAfee                      PHONE:       +61 7 3435 2888
8 Gardner Close,                            FAX:         +61 7 3891 3630
Milton, QLD, 4064, Australia                WEB: http://www.SnapGear.com
