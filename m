From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] fix __percpu annotation in asm-generic
Date: Wed, 27 Nov 2019 23:54:32 +0100
Message-ID: <20191127225432.ttwxm3hxtg5utfaz@ltop.local>
References: <20191126200619.63348-1-luc.vanoostenryck@gmail.com>
 <alpine.DEB.2.21.1911271553560.16980@www.lameter.com>
 <20191127175350.GA52308@dennisz-mbp.dhcp.thefacebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191127175350.GA52308@dennisz-mbp.dhcp.thefacebook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dennis Zhou <dennis@kernel.org>
Cc: Christopher Lameter <cl@linux.com>, Ben Dooks <ben.dooks@codethink.co.uk>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-arch.vger.kernel.org

On Wed, Nov 27, 2019 at 12:53:50PM -0500, Dennis Zhou wrote:
> On Wed, Nov 27, 2019 at 03:55:19PM +0000, Christopher Lameter wrote:
> > On Tue, 26 Nov 2019, Luc Van Oostenryck wrote:
> > 
> > > So, fix the declaration of the 'pcp' variable to its correct type:
> > > the plain (non-percpu) pointer corresponding to its address.
> > > Same for raw_cpu_generic_xchg(), raw_cpu_generic_cmpxchg() &
> > > raw_cpu_generic_cmpxchg_double().
> > 
> > Acked-by: Christoph Lameter <cl@linux.com>
> > 
> > Maybe a better fix is to come up with a typeof_strip_percu() or so
> > macro for all the places where this needs to be done?
> 
> I like the idea of typeof_strip_percpu(). Luc do you mind spinning v2
> with a macro for this instead?

I wouldn't mind at all (I already thought about doing something
like this several times) but:
1) it would strip any address space, not just __percpu, so:
   it would need to be combined with __verify_pcpu_ptr() or,
   * a better name should be used,
   * it should be defined in a generic header, any idea where?
   * I fear it would be abused to escape sloppy typing
     (like __force and casts are already often used).
2) while I find the current solution:
	typeof(T) __kernel __force *ptr = ...;

   quite readable and relatively easy to understand, the solution
   I have for doing it with a macro (that behaves like typeof) is,
   IMO, much much less readable and understandable:
	#define typeof_strip_percpu(T) \
		typeof(({ typeof(T) __kernel __force __fakename; __fakename; }))

	typeof_strip_perpcu(T) * ptr = ...;

So, if you insist I can do it but I would really prefer not.


Best regards,
-- Luc
