From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [PATCH v2] update parisc to use generic strncpy_from_user()
Date: Thu, 31 May 2012 11:11:49 +0100
Message-ID: <1338459109.3073.13.camel@dabdike.int.hansenpartnership.com>
References: <1338022099.3087.2.camel@dabdike.int.hansenpartnership.com>
	 <CADZpyiyZX8QNDzWhpJfQS4YWYh24uG37AZYEP4gW63uqCW+W_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <CADZpyiyZX8QNDzWhpJfQS4YWYh24uG37AZYEP4gW63uqCW+W_A@mail.gmail.com>
Sender: linux-parisc-owner@vger.kernel.org
To: Carlos O'Donell <carlos@systemhalted.org>
Cc: Parisc List <linux-parisc@vger.kernel.org>, linux-arch@vger.kernel.org, David Miller <davem@davemloft.net>
List-Id: linux-arch.vger.kernel.org

On Mon, 2012-05-28 at 13:57 -0400, Carlos O'Donell wrote:
> On Sat, May 26, 2012 at 4:48 AM, James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> > I'll queue this patch in our git repo.  It seems to work fine for us,
> > thanks, Dave!
> >
> > v2: use test_thread_flag() for max addr determination instead of
> > tsk->thread.task_size
> >
> 
> Doesn't this seems like wasted instructions on the hot path? I fully
> agree with you that on PA, where the stack grows up, there isn't
> anything to run into up there.
> 
> On PA the failure case is still likely going to be one where you copy
> all the way through the stack (which would appear valid to the kernel)
> and fault on the first unmapped page and return -EFAULT.
> 
> I'd rather see a compile-time constant like you originally suggested.

OK, I'll modify it just to be ~0UL.

James


