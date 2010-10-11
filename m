Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from canuck.infradead.org ([134.117.69.58]:56758 "EHLO
	canuck.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751114Ab0JKLPl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 11 Oct 2010 07:15:41 -0400
Subject: Re: [PATCH 2/7] perf: New helper function for pmu name
From: Peter Zijlstra <peterz@infradead.org>
In-Reply-To: <20101011091809.GQ13563@erda.amd.com>
References: <cover.1286584677.git.matt@console-pimps.org>
	 <a72a7968f5e3f64a26875457a7451b34f896f5ae.1286584677.git.matt@console-pimps.org>
	 <20101011091809.GQ13563@erda.amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Date: Mon, 11 Oct 2010 11:31:39 +0200
Message-ID: <1286789499.2336.206.camel@twins>
Mime-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Robert Richter <robert.richter@amd.com>
Cc: Matt Fleming <matt@console-pimps.org>, Will Deacon <will.deacon@arm.com>, Paul Mundt <lethal@linux-sh.org>, Russell King <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, Frederic Weisbecker <fweisbec@gmail.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Deng-Cheng Zhu <dengcheng.zhu@gmail.com>, Grant Likely <grant.likely@secretlab.ca>
Message-ID: <20101011093139.eVLI5N9RJ-N6JHwMyEKW2YkS8V_M4sKYGp-yOGsMH1A@z>

On Mon, 2010-10-11 at 11:18 +0200, Robert Richter wrote:
> On 08.10.10 20:46:17, Matt Fleming wrote:
> > Introduce perf_pmu_name() helper function that returns the name of the
> > pmu. This gives us a generic way to get the name of a pmu regardless of
> > how an architecture identifies it internally.
> > 
> > Signed-off-by: Matt Fleming <matt@console-pimps.org>
> 
> Peter, I need your ack here.

Sure,

Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>


