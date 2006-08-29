Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ns1.suse.de ([195.135.220.2]:3756 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965253AbWH2Sdg (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 29 Aug 2006 14:33:36 -0400
From: Andi Kleen <ak@suse.de>
Subject: Re: Why Semaphore Hardware-Dependent?
Date: Tue, 29 Aug 2006 20:33:25 +0200
References: <200608292018.01602.ak@suse.de> <Pine.LNX.4.64.0608291033380.19174@schroedinger.engr.sgi.com> <809.1156876259@warthog.cambridge.redhat.com>
In-Reply-To: <809.1156876259@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608292033.25194.ak@suse.de>
Sender: linux-arch-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: Christoph Lameter <clameter@sgi.com>, Nick Piggin <nickpiggin@yahoo.com.au>, Arjan van de Ven <arjan@infradead.org>, Dong Feng <middle.fengdong@gmail.com>, Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tuesday 29 August 2006 20:30, David Howells wrote:
> Andi Kleen <ak@suse.de> wrote:
> 
> > BTW maybe it would be a good idea to switch the wait list to a hlist,
> > then the last user in the queue wouldn't need to 
> > touch the cache line of the head. Or maybe even a single linked
> > list then some more cache bounces might be avoidable.
> 
> You need a list_head to get O(1) push at one end and O(1) pop at the other.

The poper should know its node address already because it's on its own stack.

> In addition a singly-linked list makes interruptible ops non-O(1) also.

When they are interrupted I guess? Hardly a problem to make that slower.

-Andi

