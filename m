From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] percpu: improve generic percpu modify-return
 implementation
Date: Wed, 21 Sep 2016 10:23:43 -0400
Message-ID: <20160921142343.GA10734@htj.duckdns.org>
References: <20160921085137.862-1-npiggin@gmail.com>
 <20160921205711.4e804777@roar.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160921205711.4e804777@roar.ozlabs.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Christoph Lameter <cl@linux.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: linux-arch.vger.kernel.org

Hello, Nick.

How have you been? :)

On Wed, Sep 21, 2016 at 08:57:11PM +1000, Nicholas Piggin wrote:
> On Wed, 21 Sep 2016 18:51:37 +1000
> Nicholas Piggin <npiggin@gmail.com> wrote:
> 
> > Some architectures require an additional load to find the address of
> > percpu pointers. In some implemenatations, the C aliasing rules do not
> > allow the result of that load to be kept over the store that modifies
> > the percpu variable, which causes additional loads.
> 
> Sorry I picked up an old patch here. This one should be better.
> 
> From d0cb9052d6f4c31d24f999b7b0cecb34681eee9b Mon Sep 17 00:00:00 2001
> From: Nicholas Piggin <npiggin@gmail.com>
> Date: Wed, 21 Sep 2016 18:23:43 +1000
> Subject: [PATCH] percpu: improve generic percpu modify-return implementations
> 
> Some architectures require an additional load to find the address of
> percpu pointers. In some implemenatations, the C aliasing rules do not
> allow the result of that load to be kept over the store that modifies
> the percpu variable, which causes additional loads.
> 
> Work around this by finding the pointer first, then operating on that.
> 
> It's also possible to mark things as restrict and those kind of games,
> but that can require larger and arch specific changes.
> 
> On powerpc, __this_cpu_inc_return compiles to:
> 
>         ld 10,48(13)
>         ldx 9,3,10
>         addi 9,9,1
>         stdx 9,3,10
>         ld 9,48(13)
>         ldx 3,9,3
> 
> With this patch it compiles to:
> 
>         ld 10,48(13)
>         ldx 9,3,10
>         addi 9,9,1
>         stdx 9,3,10
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Patch looks good to me but seems QP encoded.  Can you please resend?

Thanks and it's great to see you again!

-- 
tejun
