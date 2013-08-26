From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [guv 04/16] core: Convert __get_cpu_var uses
Date: Mon, 26 Aug 2013 11:31:34 -0400
Message-ID: <20130826113134.5306379d@gandalf.local.home>
References: <20130823190135.726207430@linux.com>
	<00000140ac8e2bdd-f0151a00-88ca-4d0b-adbc-007c514b6856-000000@email.amazonses.com>
	<20130826141849.GA6276@home.goodmis.org>
	<00000140bb35f38a-99d5d8ab-6672-42e8-9e91-55cb231c693d-000000@email.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <00000140bb35f38a-99d5d8ab-6672-42e8-9e91-55cb231c693d-000000@email.amazonses.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Lameter <cl@linux.com>
Cc: Tejun Heo <tj@kernel.org>, akpm@linuxfoundation.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Mon, 26 Aug 2013 15:20:09 +0000
Christoph Lameter <cl@linux.com> wrote:

> On Mon, 26 Aug 2013, Steven Rostedt wrote:
> 
> > As Tejun said, each commit needs its own change log. Never expect a
> > change lgo from another commit to be read for changes in this commit.
> 
> I can copy the intro into each of the patches?

That probably would be fine.


> >
> > This patch needs to be broken up per subsystem. Or are you just looking
> > for acks from all the maintainers here and you'll pull it in. If that's
> > the case, you should have Cc'd each of the maintainers of the files that
> > this touches.
> 
> I did a breakout by arch, then core and drivers. How fine grained do you
> want them? This touches a significant portion of the kernel source.
> There could be quite a number of maintainers involved.

If you plan on sending the patch, then just get an ack for each of the
maintainers that this code touches. At least Cc them. Yeah, there are a
significant number of maintainers but not that many that it will cause
the email to be bounced from LKML for too many Cc's.

An Acked-by from David Miller will cover all of net/ subsystem. Maybe
make that a separate patch?

I can do the tracing patches.

Thomas Gleixner can ack all the timing changes.

Peter Zijlstra and Ingo Molnar can do the rest of the kernel/ changes.

I assume that Andrew Morton can take care of the mm/ changes and
perhaps even the radix tree changes.

-- Steve
