Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:32183 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751492AbWCGSbI (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 7 Mar 2006 13:31:08 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <200603071134.52962.ak@suse.de> 
References: <200603071134.52962.ak@suse.de>  <31492.1141753245@warthog.cambridge.redhat.com> 
Subject: Re: [PATCH] Document Linux's memory barriers 
Date: Tue, 07 Mar 2006 18:30:40 +0000
Message-ID: <7621.1141756240@warthog.cambridge.redhat.com>
Sender: linux-arch-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org, mingo@redhat.com, linux-arch@vger.kernel.org, linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Andi Kleen <ak@suse.de> wrote:

> Actually gcc is free to reorder it 
> (often it will not when it cannot prove that they don't alias, but sometimes
> it can)

Yeah... I have mentioned the fact that compilers can reorder too, but
obviously not enough.

> You're not supposed to do it this way anyways. The official way to access
> MMIO space is using read/write[bwlq]

True, I suppose. I should make it clear that these accessor functions imply
memory barriers, if indeed they do, and that you should use them rather than
accessing I/O registers directly (at least, outside the arch you should).

David
