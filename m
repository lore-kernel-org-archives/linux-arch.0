Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:5605 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964839AbWCHAeF
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 7 Mar 2006 19:34:05 -0500
Subject: Re: [PATCH] Document Linux's memory barriers
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <200603071257.24234.ak@suse.de>
References: <200603071134.52962.ak@suse.de>
	 <7621.1141756240@warthog.cambridge.redhat.com>
	 <1141759408.2617.9.camel@serpentine.pathscale.com>
	 <200603071257.24234.ak@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 08 Mar 2006 00:35:16 +0000
Message-Id: <1141778116.2455.23.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: Bryan O'Sullivan <bos@serpentine.com>, David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org, mingo@redhat.com, linux-arch@vger.kernel.org, linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Maw, 2006-03-07 at 12:57 +0100, Andi Kleen wrote:
> > They don't, but according to Documentation/DocBook/deviceiobook.tmpl
> > they are performed by the compiler in the order specified.
> 
> I don't think that's correct. Probably the documentation should
> be fixed.

It would be wiser to ensure they are performed in the order specified.
As far as I can see this is currently true due to the volatile cast and
most drivers rely on this property so the brown and sticky will impact
the rotating air impeller pretty fast if it isnt.

