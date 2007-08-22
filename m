Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:32952 "EHLO
	e34.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934236AbXHVXPu (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 22 Aug 2007 19:15:50 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l7MNFmrV022842
	for <linux-arch@vger.kernel.org>; Wed, 22 Aug 2007 19:15:48 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id l7MNFm8O269040
	for <linux-arch@vger.kernel.org>; Wed, 22 Aug 2007 17:15:48 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l7MNFltF019799
	for <linux-arch@vger.kernel.org>; Wed, 22 Aug 2007 17:15:47 -0600
Subject: Re: [RFC][PATCH] introduce TASK_SIZE_OF() for all arches
From: Dave Hansen <haveblue@us.ibm.com>
In-Reply-To: <31048.1187773615@redhat.com>
References: <20070821193835.258D7DD4@kernel>  <31048.1187773615@redhat.com>
Content-Type: text/plain
Date: Wed, 22 Aug 2007 16:15:46 -0700
Message-Id: <1187824547.16177.1352.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, 2007-08-22 at 10:06 +0100, David Howells wrote:
> Dave Hansen <haveblue@us.ibm.com> wrote:
> > For the /proc/<pid>/pagemap code[1], we need to able to query how
> > much virtual address space a particular task has.
> 
> How does this relate to NOMMU conditions?

Were you asking about /proc/<pid>/pagemap, or about my TASK_SIZE_OF()
macro?  

/proc/<pid>/pagemap is completely implemented in task_mmu.c, so it
shouldn't show up on NOMMU systems.

As far as TASK_SIZE_OF(), it still makes sense on those systems because
they (at least m68k) still has TASK_SIZE.  Was there a particular
problem you're concerned about?  I'm not very intimately familiar with
the NOMMU code.

-- Dave

