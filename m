Return-Path: <wli@holomorphy.com>
Received: from holomorphy.com ([207.189.100.168]:45219 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264028AbUDVNYz (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 22 Apr 2004 09:24:55 -0400
Date: Thu, 22 Apr 2004 06:24:43 -0700
From: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [Patch] SMP call function cleanup
Message-ID: <20040422132443.GV743@holomorphy.com>
References: <1082636511.1332.34.camel@halo> <20040422122818.GR743@holomorphy.com> <20040422123703.GY22027@krispykreme> <1082638779.1778.16.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1082638779.1778.16.camel@mulgrave>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Anton Blanchard <anton@samba.org>, Jan Glauber <glauber@gmx.de>, linux-arch@vger.kernel.org, schwidefsky@de.ibm.com
List-ID: <linux-arch.vger.kernel.org>

On Thu, 2004-04-22 at 08:37, Anton Blanchard wrote:
>> Unless there is a need Id prefer not to. Some arches do not support IPI
>> to a cpumask, whereas they should do send to all and send to single.

On Thu, Apr 22, 2004 at 08:59:39AM -0400, James Bottomley wrote:
> This is my preference too.  Voyager is one such arch.
> If it's added, there certainly has to be some way of ensuring that the
> cpumask variant isn't used preferentially to execute on a single cpu .

Well, at the moment, anyone in need of IPI'ing > 1 cpu is IPI'ing all,
which is not swift, so bear that in mind. Though given on_one_cpu(), I
suppose they can do:

	for_each_cpu_mask(cpu, foo->mask)
		on_one_cpu(cpu, bar, ...);

which more or less avoids IPI'ing 1024 cpus to run a function on 2 or
whatever they were going on about, so they can likely code it that way.


-- wli
