From: Christopher Lameter <cl@linux.com>
Subject: Re: [PATCH] fix __percpu annotation in asm-generic
Date: Fri, 29 Nov 2019 18:11:59 +0000 (UTC)
Message-ID: <alpine.DEB.2.21.1911291808530.1365@www.lameter.com>
References: <20191126200619.63348-1-luc.vanoostenryck@gmail.com> <alpine.DEB.2.21.1911271553560.16980@www.lameter.com> <20191127175350.GA52308@dennisz-mbp.dhcp.thefacebook.com> <20191127225432.ttwxm3hxtg5utfaz@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191127225432.ttwxm3hxtg5utfaz@ltop.local>
Sender: linux-kernel-owner@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Dennis Zhou <dennis@kernel.org>, Ben Dooks <ben.dooks@codethink.co.uk>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-arch.vger.kernel.org

On Wed, 27 Nov 2019, Luc Van Oostenryck wrote:

> 1) it would strip any address space, not just __percpu, so:
>    it would need to be combined with __verify_pcpu_ptr() or,
>    * a better name should be used,

typeof_cast_kernel() to express the fact that it creates a kernel pointer
and ignored the attributes??

>    * it should be defined in a generic header, any idea where?

include/linux/compiler-types.h

> 2) while I find the current solution:
> 	typeof(T) __kernel __force *ptr = ...;

It would be

   typeof_cast_kernel(&T) *xx = xxx

or so?
