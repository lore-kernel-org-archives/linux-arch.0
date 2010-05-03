Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from g4t0016.houston.hp.com ([15.201.24.19]:9766 "EHLO
	g4t0016.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759427Ab0ECPFE (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 3 May 2010 11:05:04 -0400
From: Lee Schermerhorn <lee.schermerhorn@hp.com>
Date: Mon, 03 May 2010 11:04:55 -0400
Message-ID: <20100503150455.15039.10178.sendpatchset@localhost.localdomain>
Subject: [PATCH 0/7] numa: incremental fixes to generic per cpu numa_*_id() series
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-numa@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Valdis.Kletnieks@vt.edu, Randy Dunlap <randy.dunlap@oracle.com>, Christoph Lameter <cl@linux-foundation.org>, eric.whitney@hp.com, Andrew Morton <akpm@linux-foundation.org>, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Message-ID: <20100503150455.qCmSLcYr0C6vCP1RI2zo__xuw8SeSXnburXrIaNPuuA@z>

The following 7 patches address review comments on the 'generic percpu
numa_*_id()" series currently in the -mm tree [28apr10 mmotm].

Valdis Kletnieks confirmed that this series fixes the i386 !NUMA slab
build breakage that he reported.

With these patches, I have built and tested on x86_64 and ia64 NUMA.   In
addition I built mm/slab.o for x86_64 !NUMA and an entire i386 tree with the
i386 config that Andrew sent out in response to Vlad's report re: i386 !NUMA
slab.o breakage.

It should be obvious from the 'Subject' and the patch descriptions, where
the patches go in the mmotm series.
