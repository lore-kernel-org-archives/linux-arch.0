Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:45211 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762075AbXHJJYc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 10 Aug 2007 05:24:32 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <46BB46B2.60808@redhat.com>
References: <46BB46B2.60808@redhat.com> <20070809134150.GA14890@shell.boston.redhat.com>
Subject: Re: [PATCH 6/24] make atomic_read() behave consistently on frv
Date: Fri, 10 Aug 2007 10:23:46 +0100
Message-ID: <2708.1186737826@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
To: Chris Snook <csnook@redhat.com>
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, torvalds@linux-foundation.org, netdev@vger.kernel.org, akpm@linux-foundation.org, ak@suse.de, heiko.carstens@de.ibm.com, davem@davemloft.net, schwidefsky@de.ibm.com, wensong@linux-vs.org, horms@verge.net.au, wjiang@resilience.com, cfriesen@nortel.com, zlynx@acm.org, rpjday@mindspring.com, jesper.juhl@gmail.com
List-ID: <linux-arch.vger.kernel.org>

Chris Snook <csnook@redhat.com> wrote:

> To head off the criticism, I admit this is an oversimplification, and true
> busy-waiters should be using cpu_relax(), which contains a barrier.

Why would you want to use cpu_relax()?  That's there to waste time efficiently,
isn't it?  Shouldn't you be using smp_rmb() or something like that?

David
