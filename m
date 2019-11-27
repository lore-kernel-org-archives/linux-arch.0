Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40059 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbfK0Rxx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 27 Nov 2019 12:53:53 -0500
Date: Wed, 27 Nov 2019 12:53:50 -0500
From: Dennis Zhou <dennis@kernel.org>
Subject: Re: [PATCH] fix __percpu annotation in asm-generic
Message-ID: <20191127175350.GA52308@dennisz-mbp.dhcp.thefacebook.com>
References: <20191126200619.63348-1-luc.vanoostenryck@gmail.com>
 <alpine.DEB.2.21.1911271553560.16980@www.lameter.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1911271553560.16980@www.lameter.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christopher Lameter <cl@linux.com>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Dennis Zhou <dennis@kernel.org>, Ben Dooks <ben.dooks@codethink.co.uk>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, Arnd Bergmann <arnd@arndb.de>
Message-ID: <20191127175350.zUuGCaqCCHkpbkIdh-7RMNkxRNISqOm3EG3s8-i07bA@z>

On Wed, Nov 27, 2019 at 03:55:19PM +0000, Christopher Lameter wrote:
> On Tue, 26 Nov 2019, Luc Van Oostenryck wrote:
> 
> > So, fix the declaration of the 'pcp' variable to its correct type:
> > the plain (non-percpu) pointer corresponding to its address.
> > Same for raw_cpu_generic_xchg(), raw_cpu_generic_cmpxchg() &
> > raw_cpu_generic_cmpxchg_double().
> 
> Acked-by: Christoph Lameter <cl@linux.com>
> 
> Maybe a better fix is to come up with a typeof_strip_percu() or so
> macro for all the places where this needs to be done?

I like the idea of typeof_strip_percpu(). Luc do you mind spinning v2
with a macro for this instead?

Thanks,
Dennis
