Return-Path: <James.Bottomley@steeleye.com>
Received: from stat1.steeleye.com ([65.114.3.130]:3552 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S264032AbUDVNqV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 22 Apr 2004 09:46:21 -0400
Subject: Re: [Patch] SMP call function cleanup
From: James Bottomley <James.Bottomley@steeleye.com>
In-Reply-To: <20040422132443.GV743@holomorphy.com>
References: <1082636511.1332.34.camel@halo>
	<20040422122818.GR743@holomorphy.com> <20040422123703.GY22027@krispykreme>
	<1082638779.1778.16.camel@mulgrave>  <20040422132443.GV743@holomorphy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: 22 Apr 2004 09:46:16 -0400
Message-Id: <1082641576.1714.36.camel@mulgrave>
Mime-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Anton Blanchard <anton@samba.org>, Jan Glauber <glauber@gmx.de>, linux-arch@vger.kernel.org, schwidefsky@de.ibm.com
List-ID: <linux-arch.vger.kernel.org>

On Thu, 2004-04-22 at 09:24, William Lee Irwin III wrote:
> Well, at the moment, anyone in need of IPI'ing > 1 cpu is IPI'ing all,
> which is not swift, so bear that in mind. Though given on_one_cpu(), I
> suppose they can do:
> 
> 	for_each_cpu_mask(cpu, foo->mask)
> 		on_one_cpu(cpu, bar, ...);
> 
> which more or less avoids IPI'ing 1024 cpus to run a function on 2 or
> whatever they were going on about, so they can likely code it that way.

But the key is 'anyone in need of'.  What I'd like is for you to
demonstrate a need of execute on cpumask before it gets added to the
API.  Murphy's law says that when given a choice people invariably make
the wrong one, so lets not introduce choice into the api unless it's
absolutely necessary.

James
