Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34442 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbfLCDBM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 2 Dec 2019 22:01:12 -0500
Date: Tue, 3 Dec 2019 04:01:08 +0100
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] fix __percpu annotation in asm-generic
Message-ID: <20191203030108.ch7n6yoqgsco2alj@ltop.local>
References: <20191126200619.63348-1-luc.vanoostenryck@gmail.com>
 <alpine.DEB.2.21.1911271553560.16980@www.lameter.com>
 <20191127175350.GA52308@dennisz-mbp.dhcp.thefacebook.com>
 <20191127225432.ttwxm3hxtg5utfaz@ltop.local>
 <alpine.DEB.2.21.1911291808530.1365@www.lameter.com>
 <20191130000037.zsendu5pk7p75xqf@ltop.local>
 <20191202190718.GA18019@dennisz-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191202190718.GA18019@dennisz-mbp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dennis Zhou <dennis@kernel.org>
Cc: Christopher Lameter <cl@linux.com>, Ben Dooks <ben.dooks@codethink.co.uk>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, Arnd Bergmann <arnd@arndb.de>
Message-ID: <20191203030108.yYFfJDvXV7qYSCGJgyUkhwXpcsPy4fh44_zBYmHiL08@z>

On Mon, Dec 02, 2019 at 02:07:18PM -0500, Dennis Zhou wrote:
> On Sat, Nov 30, 2019 at 01:00:37AM +0100, Luc Van Oostenryck wrote:
> > On Fri, Nov 29, 2019 at 06:11:59PM +0000, Christopher Lameter wrote:
> > > On Wed, 27 Nov 2019, Luc Van Oostenryck wrote:
> > > 
> > > > 1) it would strip any address space, not just __percpu, so:
> > > >    it would need to be combined with __verify_pcpu_ptr() or,
> > > >    * a better name should be used,
> > > 
> > > typeof_cast_kernel() to express the fact that it creates a kernel pointer
> > > and ignored the attributes??
> > 
> > typeof_strip_address_space() would, I think, express this better. 
> > It's not obvious at all to me that 'kernel' in 'typeof_cast_kernel()'
> > relates to the (default) kernel address space.
> > Maybe it's just me. I don't know.
> > 
> 
> I think typeof_cast_kernel() or typeof_force_kernel() are reasonable
> names. I kind of like the idea of cast/force over strip because we're
> really still moving address spaces even if it is moving it back.

Well, 'typeof_cast_kernel()' somehow conveys the idea but sounds
a bit weird as the macro doesn't contain a cast (expression).

> Thanks for debugging this. I'm still inclined to have a macro for either
> cast/force. I do agree it could be misused, but it's no different doing
> it in a macro than by just adding __force __kernel.

I'm glad to help making the kernel type-clean (with the goal of
catching more bugs earlier) but I admit that I absolutely detest
these layers of ugly macros. 

I'm working on a nicer implementation but it's not yet ready.

Best regards,
-- Luc
