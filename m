From: Christopher Lameter <cl@linux.com>
Subject: Re: [PATCH] fix __percpu annotation in asm-generic
Date: Wed, 27 Nov 2019 15:55:19 +0000 (UTC)
Message-ID: <alpine.DEB.2.21.1911271553560.16980@www.lameter.com>
References: <20191126200619.63348-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191126200619.63348-1-luc.vanoostenryck@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Dennis Zhou <dennis@kernel.org>, Ben Dooks <ben.dooks@codethink.co.uk>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-arch.vger.kernel.org

On Tue, 26 Nov 2019, Luc Van Oostenryck wrote:

> So, fix the declaration of the 'pcp' variable to its correct type:
> the plain (non-percpu) pointer corresponding to its address.
> Same for raw_cpu_generic_xchg(), raw_cpu_generic_cmpxchg() &
> raw_cpu_generic_cmpxchg_double().

Acked-by: Christoph Lameter <cl@linux.com>

Maybe a better fix is to come up with a typeof_strip_percu() or so
macro for all the places where this needs to be done?
