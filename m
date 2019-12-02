Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39999 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727580AbfLBTHW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 2 Dec 2019 14:07:22 -0500
Date: Mon, 2 Dec 2019 14:07:18 -0500
From: Dennis Zhou <dennis@kernel.org>
Subject: Re: [PATCH] fix __percpu annotation in asm-generic
Message-ID: <20191202190718.GA18019@dennisz-mbp>
References: <20191126200619.63348-1-luc.vanoostenryck@gmail.com>
 <alpine.DEB.2.21.1911271553560.16980@www.lameter.com>
 <20191127175350.GA52308@dennisz-mbp.dhcp.thefacebook.com>
 <20191127225432.ttwxm3hxtg5utfaz@ltop.local>
 <alpine.DEB.2.21.1911291808530.1365@www.lameter.com>
 <20191130000037.zsendu5pk7p75xqf@ltop.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191130000037.zsendu5pk7p75xqf@ltop.local>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Christopher Lameter <cl@linux.com>, Dennis Zhou <dennis@kernel.org>, Ben Dooks <ben.dooks@codethink.co.uk>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, Arnd Bergmann <arnd@arndb.de>
Message-ID: <20191202190718.j7A7A7Qeu14deZJLcH5b22GMxd5gTFQ71CyTQ00qgkI@z>

On Sat, Nov 30, 2019 at 01:00:37AM +0100, Luc Van Oostenryck wrote:
> On Fri, Nov 29, 2019 at 06:11:59PM +0000, Christopher Lameter wrote:
> > On Wed, 27 Nov 2019, Luc Van Oostenryck wrote:
> > 
> > > 1) it would strip any address space, not just __percpu, so:
> > >    it would need to be combined with __verify_pcpu_ptr() or,
> > >    * a better name should be used,
> > 
> > typeof_cast_kernel() to express the fact that it creates a kernel pointer
> > and ignored the attributes??
> 
> typeof_strip_address_space() would, I think, express this better. 
> It's not obvious at all to me that 'kernel' in 'typeof_cast_kernel()'
> relates to the (default) kernel address space.
> Maybe it's just me. I don't know.
> 

I think typeof_cast_kernel() or typeof_force_kernel() are reasonable
names. I kind of like the idea of cast/force over strip because we're
really still moving address spaces even if it is moving it back.

> > >    * it should be defined in a generic header, any idea where?
> > 
> > include/linux/compiler-types.h
> 
> Yes, OK.
> 
> > > 2) while I find the current solution:
> > > 	typeof(T) __kernel __force *ptr = ...;
> > 
> > It would be
> > 
> >    typeof_cast_kernel(&T) *xx = xxx
> > 
> > or so?
> 
> No, it would not. __percpu, and more generally, the address space
> is a property of the object, not of its address.

Maybe for other address spaces that's true, but for percpu, __percpu is
a property of the address. An object can be referenced both from a
percpu address (via accessors) and the kernel address which is the
actual object.

> For example, let's say T is a __percpu object:
> 	int __percpu obj;

This can't exist. __percpu denotes address space not object.

> then '&T' is just a 'normal'/__kernel pointer to it:
> 	int __percpu *;
> There is nothing to strip (it would be if the __percpu
> would be 'on the other side of the *': int * __percpu).
> It's exactly the same as with 'const': a 'const char *'
> is not const, only a pointer to const.
> 
> The situation with raw_cpu_generic_add_return() is:
> - pcp is a lvalue of of a __percpu object of type T, so:
> 	typeof(pcp)  := T __percpu
> - pcp's address is given to raw_cpu_ptr(), so
> 	typeof(&pcp) := T __percpu *
> - raw_cpu_ptr() return the corresponding __kernel pointer
>   (adjusted for the current percu offset), so:
> 	typeof(raw_cpu_ptr(&pcp)) := T *
> - so, the macro needs to declare a variable __p of type T*
>   hence:
> 	typeof(pcp) __kernel __force *__p;
>   or, with this new macro:
> 	typeof_cast_kernel(pcp) *__p;
> 
> Maybe a better solution would be to directly play at pointer
> level and thus have something like this:
> 	typeof_<some good name>(&pcp) __p = raw_cpu_ptr(&pcp);
> or even:
> 	__kernel_pointer(&pcp) __p = raw_cpu_ptr(&pcp);
> I dunno.
> 
> Note: at implementation level, it complicates things slightly
>       to want this 'strip_percpu' macro to behaves like typeof()
>       because it means that it can take in argument either an
>       expression or a type. And if it's a type, you can't do a
>       simple cast on it, you need to declare an intermediate
>       variable, hence the horrible:
> 	  typeof(({ typeof(T) __kernel __force __fakename; __fakename; }))
> 
> Note: it would be much much nicer to do all these type generic
>       macros with '__auto_type' (only supported in GCC 4.9 IIUC
>       and supported in sparse but it shouldn't be very hard to do)..
> 
> 
> -- Luc

Thanks for debugging this. I'm still inclined to have a macro for either
cast/force. I do agree it could be misused, but it's no different doing
it in a macro than by just adding __force __kernel.

Thanks,
Dennis
