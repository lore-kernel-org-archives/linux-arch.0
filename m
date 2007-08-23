Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:49577 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755659AbXHWJhr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 23 Aug 2007 05:37:47 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1187824547.16177.1352.camel@localhost>
References: <1187824547.16177.1352.camel@localhost> <20070821193835.258D7DD4@kernel> <31048.1187773615@redhat.com>
Subject: Re: [RFC][PATCH] introduce TASK_SIZE_OF() for all arches
Date: Thu, 23 Aug 2007 10:37:27 +0100
Message-ID: <10534.1187861847@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
To: Dave Hansen <haveblue@us.ibm.com>
Cc: dhowells@redhat.com, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Dave Hansen <haveblue@us.ibm.com> wrote:

> Were you asking about /proc/<pid>/pagemap, or about my TASK_SIZE_OF()
> macro?  

TASK_SIZE_OF().

> As far as TASK_SIZE_OF(), it still makes sense on those systems because
> they (at least m68k) still has TASK_SIZE.

Fair enough.

> Was there a particular problem you're concerned about?  I'm not very
> intimately familiar with the NOMMU code.

Since you were talking about virtual memory, I was wondering as to its
applicability for NOMMU.

David
