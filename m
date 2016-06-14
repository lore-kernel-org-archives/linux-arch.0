From: chris hyser <chris.hyser@oracle.com>
Subject: RESEND: sysfs: Clarifying meaning of /sys/**/core_siblings on newer
 platforms
Date: Tue, 14 Jun 2016 12:02:53 -0400
Message-ID: <57602AAD.3000301@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:33444 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751847AbcFNQNA (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 14 Jun 2016 12:13:00 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

Hi All,

Technically, this is a broader question than just SPARC where I initially 
sent this. I'm sending this here and dropping the test patch as it was
SPARC only and this is primarily a sysfs generic platform description
question.

Before SPARC M7, the notion of core_siblings on SPARC was both those CPUs
that share a common highest level cache and the set of CPUs within a 
particular socket (share same package_id). This was also true on older x86
CPUs and perhaps most recent though my knowledge of x86 is dated.

The idea of same package_id is stated in Documentation/cputopology.txt and
programs such as lscpu have used this to find the number of sockets by
counting the number of unique core_siblings_list entries. I suspect the
reliance on that algorithm predates the ability to read package IDs directly
which is simpler and preserves the platform assigned package ID versus an
ID that is simply an incremented index based on order of discovery.

The idea that it needs to represent shared common highest level cache comes
from irqbalance, an important run-time performance enhancing daemon.

irqbalance uses the following hierarchy of locality goodness:

        - shared common core (thread_siblings)
        - shared common cache (core_siblings)
        - shared common socket (CPUs with same physical_package_id)
        - shared common node (CPUS in same node)

This layout perfectly describes the M7 and interestingly suggests that there
are one or more other architectures that have reached the point where enough
cores can be jammed into the same package that a shared high level cache is
either not desirable or not worth the real estate/effort. Said differently,
socket in the future will likely become less synonymous with shared cache and
more synonymous with node. I'm still digging to see if and what those
architectures are.

The issue is that on newer SPARC HW both definitions can no longer be true and
that choosing one versus the other will break differing sets of code. This can
be illustrated as a choice between an unmodified lscpu spitting out nonsensical
answers (although it currently can do that for different unrelated reasons) or
an unmodified irqbalance incorrectly making cache-thrashing decisions. The
number of important programs in each class is unknown, but either way some
things will have to be fixed. As I believe the whole point of large SPARC
servers is performance and the goal is to maximize linux performance, I would
argue for not breaking what I would call the performance class of programs
versus the topology description class.

Rationale:

- performance class breakage is harder to diagnose as it results in lost
performance and tracing back to root cause is incredibly difficult. Topology
description programs on the other hand spit out easily identified nonsense and
can be modified in a manner that is actually more straight forward than the
current algorithm while preserving architecturally neutral functional
correctness (i.e. not hacks/workarounds). That is clearly a generalization 
and there are probably overlaps. It is all about trade-offs.

Alternatively, new attributes could be added that represent collections of
shared caches and programs such as irqbalance identified and fixed to parse
the new hierarchy.
