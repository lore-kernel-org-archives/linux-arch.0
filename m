Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:59214 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752342AbZF3TPg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 30 Jun 2009 15:15:36 -0400
Date: Tue, 30 Jun 2009 21:15:17 +0200
From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCHSET] percpu: generalize first chunk allocators and
	improve lpage NUMA support
Message-ID: <20090630191517.GB20567@elte.hu>
References: <1245850216-31653-1-git-send-email-tj@kernel.org> <20090624165508.30b88343.akpm@linux-foundation.org> <alpine.DEB.1.10.0906291920100.32637@gentwo.org> <20090629163937.94c8cedd.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090629163937.94c8cedd.akpm@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Lameter <cl@linux-foundation.org>, tj@kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org, andi@firstfloor.org, hpa@zytor.com, tglx@linutronix.de


* Andrew Morton <akpm@linux-foundation.org> wrote:

> On Mon, 29 Jun 2009 19:20:53 -0400 (EDT)
> Christoph Lameter <cl@linux-foundation.org> wrote:
> 
> > On Wed, 24 Jun 2009, Andrew Morton wrote:
> > 
> > > I assume from the tremendous number of 
> > > for_each_possible_cpu()s that CPU hotplug awareness won't be 
> > > happening.
> > 
> > Per cpu areas are allocated for all possible processors. No need 
> > to handle offlining and onlining them.
> 
> Well yes.  My point is that this is a bug-not-a-feature ;)

Yeah, it's a bug for something like a virtual environment which 
boots generic kernels that might have 64 possible CPUs (on a true 
64-way system), but which will have fewer in practice.

It's pretty basic stuff: the on-demand allocation of percpu 
resources.

	Ingo
