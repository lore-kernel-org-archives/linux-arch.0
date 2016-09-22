From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] percpu: improve generic percpu modify-return
 implementation
Date: Thu, 22 Sep 2016 12:07:49 -0400
Message-ID: <20160922160749.GD1892@htj.duckdns.org>
References: <20160921085137.862-1-npiggin@gmail.com>
 <20160921205711.4e804777@roar.ozlabs.ibm.com>
 <20160921142343.GA10734@htj.duckdns.org>
 <20160922143500.21809b98@roar.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160922143500.21809b98@roar.ozlabs.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Christoph Lameter <cl@linux.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: linux-arch.vger.kernel.org

Hello,

On Thu, Sep 22, 2016 at 02:35:00PM +1000, Nicholas Piggin wrote:
> Well thank you, how about you?

Heh, can't complain.  Hope to see you around sometime.  It's been
forever.

> Trying a new mail client, sorry. It *seems* to be working now, how's
> this?

Hmm... Still encoded.

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

QP-decoded and applied to percpu/for-4.9.

Thanks.

-- 
tejun
