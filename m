Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:8615 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932506AbWCHTFu (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 8 Mar 2006 14:05:50 -0500
From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] Document Linux's memory barriers [try #2]
Date: Wed, 8 Mar 2006 12:38:38 +0100
References: <20060308184500.GA17716@devserv.devel.redhat.com> <11922.1141842907@warthog.cambridge.redhat.com> <14067.1141844393@warthog.cambridge.redhat.com>
In-Reply-To: <14067.1141844393@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200603081238.39372.ak@suse.de>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: Alan Cox <alan@redhat.com>, torvalds@osdl.org, akpm@osdl.org, mingo@redhat.com, linux-arch@vger.kernel.org, linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Wednesday 08 March 2006 19:59, David Howells wrote:
> Alan Cox <alan@redhat.com> wrote:
> 
> > then on some NUMA infrastructures the order may not be as you expect.
> 
> Oh, yuck!
> 
> Okay... does NUMA guarantee the same for ordinary memory accesses inside the
> critical section?


If you use barriers the ordering should be the same on cc/NUMA vs SMP.
Otherwise it wouldn't be "cc" 

But it might be quite unfair.

-Andi

