Return-Path: <davem@redhat.com>
Received: from mx1.redhat.com ([66.187.233.31]:34709 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261787AbUE3G2E (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sun, 30 May 2004 02:28:04 -0400
Date: Sat, 29 May 2004 23:28:02 -0700
From: "David S. Miller" <davem@redhat.com>
Subject: Re: [RFC][PATCH] Consolidate architecture context switch locking
Message-Id: <20040529232802.24a367c7.davem@redhat.com>
In-Reply-To: <40B94D79.8090903@yahoo.com.au>
References: <40B94D79.8090903@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-arch@vger.kernel.org, mingo@redhat.com
List-ID: <linux-arch.vger.kernel.org>

On Sun, 30 May 2004 12:56:57 +1000
Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> Those that do need to define TIF_RUNNING, which I haven't done
> in the patch.

How come we can't use a spinlock like the existing instances
did?  A spinlock should be cheaper than a SMP atomic bitop
on at least some such platforms.  It is on sparc at least.
