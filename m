Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from arkanian.console-pimps.org ([212.110.184.194]:52326 "EHLO
	arkanian.console-pimps.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752557Ab0IMHu0 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 13 Sep 2010 03:50:26 -0400
Date: Mon, 13 Sep 2010 08:50:25 +0100
From: Matt Fleming <matt@console-pimps.org>
Subject: Re: [PATCH V3 0/6] Generalise ARM perf-events backend for oprofile
Message-ID: <20100913075025.GA14882@console-pimps.org>
References: <cover.1284357372.git.matt@console-pimps.org> <SNT125-W35B89F6AA83C8DD22E7946BA770@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SNT125-W35B89F6AA83C8DD22E7946BA770@phx.gbl>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Marc Titinger <mtittinge@hotmail.com>
Cc: robert.richter@amd.com, linux-arch@vger.kernel.org, linux@arm.linux.org.uk, linux-sh@vger.kernel.org, peterz@infradead.org, fweisbec@gmail.com, will.deacon@arm.com, acme@redhat.com, lethal@linux-sh.org, mingo@elte.hu, linux-arm-kernel@lists.infradead.org
Message-ID: <20100913075025.PO_Hv-hVllTUBctZU3kaH13JpRZicZrl3UrIxGZjyoI@z>

On Mon, Sep 13, 2010 at 09:13:32AM +0200, Marc Titinger wrote:
> 
> Hi, 
> 
> I'm just being curious : do these patches change the way those chips
> should be supported, that do not have a PMU-like IP, but implement
> PC-sampling thanks to a general purpose timer (not the system timer)
> ?

CPUs that do not have a PMU are not required to use the perf-events
oprofile backend, it is entirely optional. The pc-sampling timer in
oprofile is not affected by this series.
