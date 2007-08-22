Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:39813 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760126AbXHVWz7 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 22 Aug 2007 18:55:59 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l7MMtq70023806
	for <linux-arch@vger.kernel.org>; Wed, 22 Aug 2007 18:55:52 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id l7MMtq9j177096
	for <linux-arch@vger.kernel.org>; Wed, 22 Aug 2007 16:55:52 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l7MMtpZD023067
	for <linux-arch@vger.kernel.org>; Wed, 22 Aug 2007 16:55:52 -0600
Subject: Re: [RFC][PATCH] introduce TASK_SIZE_OF() for all arches
From: Dave Hansen <haveblue@us.ibm.com>
In-Reply-To: <31048.1187773615@redhat.com>
References: <20070821193835.258D7DD4@kernel>  <31048.1187773615@redhat.com>
Content-Type: text/plain
Date: Wed, 22 Aug 2007 15:55:50 -0700
Message-Id: <1187823350.16177.1326.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: linux-arch@vger.kernel.org, Matt Mackall <mpm@selenic.com>
List-ID: <linux-arch.vger.kernel.org>

On Wed, 2007-08-22 at 10:06 +0100, David Howells wrote:
> Dave Hansen <haveblue@us.ibm.com> wrote:
> 
> > For the /proc/<pid>/pagemap code[1], we need to able to query how
> > much virtual address space a particular task has.
> 
> How does this relate to NOMMU conditions?

It probably doesn't make any sense to use the /proc/<pid>/pagemap
feature on NOMMU systems.  There are no pagetables to dump, and no
shared pages, right?

-- Dave

