Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:42644 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932241AbWCGVY0 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 7 Mar 2006 16:24:26 -0500
From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] Document Linux's memory barriers
Date: Tue, 7 Mar 2006 22:24:09 +0100
References: <200603071134.52962.ak@suse.de> <200603071257.24234.ak@suse.de> <1141766085.5255.12.camel@serpentine.pathscale.com>
In-Reply-To: <1141766085.5255.12.camel@serpentine.pathscale.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603072224.09976.ak@suse.de>
Sender: linux-arch-owner@vger.kernel.org
To: Bryan O'Sullivan <bos@serpentine.com>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org, mingo@redhat.com, linux-arch@vger.kernel.org, linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tuesday 07 March 2006 22:14, Bryan O'Sullivan wrote:
> On Tue, 2006-03-07 at 12:57 +0100, Andi Kleen wrote:
> > > > True, I suppose. I should make it clear that these accessor functions
> > > > imply memory barriers, if indeed they do,
> > >
> > > They don't, but according to Documentation/DocBook/deviceiobook.tmpl
> > > they are performed by the compiler in the order specified.
> >
> > I don't think that's correct. Probably the documentation should
> > be fixed.
>
> That's why I hedged my words with "according to ..." :-)
>
> But on most arches those accesses do indeed seem to happen in-order.  On
> i386 and x86_64, it's a natural consequence of program store ordering.

Not true for reads on x86.

-Andi
