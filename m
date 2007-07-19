Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:56417 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755653AbXGSUeR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 19 Jul 2007 16:34:17 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [patch 055/209] define new percpu interface for shared data
Date: Thu, 19 Jul 2007 13:34:14 -0700
Message-ID: <79E93560F4A5FD42BB769DAAF8BEF62A020F2B98@scsmsx411.amr.corp.intel.com>
In-Reply-To: <20070719200253.GB15186@uranus.ravnborg.org>
From: "Yu, Fenghua" <fenghua.yu@intel.com>
Sender: linux-arch-owner@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>, akpm@linux-foundation.org
Cc: torvalds@linux-foundation.org, ak@suse.de, clameter@sgi.com, linux-arch@vger.kernel.org, rusty@rustcorp.com.au, "Siddha, Suresh B" <suresh.b.siddha@intel.com>, "Luck, Tony" <tony.luck@intel.com>
List-ID: <linux-arch.vger.kernel.org>


> Why is PERCPU not suitable for arm?
Can't put an output section inside an output section.

>Ditto for i386
__per_cpu_start and __per_cpu_end are defined as relative symbols. But
__per_cpu_start and __per_cpu_end are defined as relative symbols in
PERCPU(). Using PERCPU for i386 won't work for relocated kernel.

>Ditto
Same. __per_cpu_start and __per_cpu_end are relative symbols.

>Ditto
Same. __per_cpu_start and __per_cpu_end are relative symbols. They are
different from PERCPU definition.

Overall, PERCPU() macro make code cleaner. But above definitions can not
fit into the macro.

Thanks.

-Fenghua
