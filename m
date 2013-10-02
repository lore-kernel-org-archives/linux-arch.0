Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from a194-81.smtp-out.amazonses.com ([199.255.194.81]:17981 "EHLO
	a194-81.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753046Ab3JBPIR (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 2 Oct 2013 11:08:17 -0400
Date: Wed, 2 Oct 2013 15:08:16 +0000
From: Christoph Lameter <cl@linux.com>
Subject: Re: [pchecks v2 2/2] percpu: Add preemption checks to __this_cpu
 ops
In-Reply-To: <20130928084412.GC26167@gmail.com>
Message-ID: <0000014179b65a63-512751f8-346a-4621-b6d1-9abd62e781c9-000000@email.amazonses.com>
References: <20130924154159.855373283@linux.com> <0000014150a21408-2d759c49-6a9e-4553-956f-2d4b53e710f8-000000@email.amazonses.com> <20130924171029.GB10261@gmail.com> <0000014155fdd6cf-d54da8b8-2198-40ce-8831-4559971e69f0-000000@email.amazonses.com>
 <20130925181146.GA16693@gmail.com> <000001415fb34afc-79a24112-5d3f-431c-b90c-d6cfa1caf27a-000000@email.amazonses.com> <20130928084412.GC26167@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, akpm@linuxfoundation.org, linux-arch@vger.kernel.org, Steven Rostedt <srostedt@redhat.com>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <a.p.zijlstra@chello.nl>
Message-ID: <20131002150816.fr6SXt_LkKZnU2UwZACZbuyr_hFD12XdtNuXO65eqOA@z>

On Sat, 28 Sep 2013, Ingo Molnar wrote:

>
> * Christoph Lameter <cl@linux.com> wrote:
>
> > > The blind __this_cpu conversions without proper preempt debugging
> > > cannot continue without first fixing all the fallout of the missing
> > > debug checks to begin with.
> >
> > That will take some time as the feedback from the other patchset
> > suggests.
>
> That's the reason why we insisted on __this_cpu*() primitives growing
> these essential debug checks early on - which you resisted. I had to bring
> out NAKs for you to see sense and start fixing the mess already - next
> time around I'll probably have to NAK your changes earlier to prevent such
> mishaps.

I pointed out the issues that would have to be addressed when the brought
up the issue. It seemed that Steven was working on it, I fixed some of the
problems that he mentioned and then waited. Seems that nothing was
happening on the issue then. Guess it was not that important to you. That
was years ago.

