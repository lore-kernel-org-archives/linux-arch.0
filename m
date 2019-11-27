Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from gentwo.org ([3.19.106.255]:39434 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726514AbfK0PzU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 27 Nov 2019 10:55:20 -0500
Date: Wed, 27 Nov 2019 15:55:19 +0000 (UTC)
From: Christopher Lameter <cl@linux.com>
Subject: Re: [PATCH] fix __percpu annotation in asm-generic
In-Reply-To: <20191126200619.63348-1-luc.vanoostenryck@gmail.com>
Message-ID: <alpine.DEB.2.21.1911271553560.16980@www.lameter.com>
References: <20191126200619.63348-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Dennis Zhou <dennis@kernel.org>, Ben Dooks <ben.dooks@codethink.co.uk>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, Arnd Bergmann <arnd@arndb.de>
Message-ID: <20191127155519.NeLUQvNSWmTQDlF2vJC_O72a1EnHPB51UptWdykWMhg@z>

On Tue, 26 Nov 2019, Luc Van Oostenryck wrote:

> So, fix the declaration of the 'pcp' variable to its correct type:
> the plain (non-percpu) pointer corresponding to its address.
> Same for raw_cpu_generic_xchg(), raw_cpu_generic_cmpxchg() &
> raw_cpu_generic_cmpxchg_double().

Acked-by: Christoph Lameter <cl@linux.com>

Maybe a better fix is to come up with a typeof_strip_percu() or so
macro for all the places where this needs to be done?
