From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCH] fix __percpu annotation in asm-generic
Date: Mon, 23 Mar 2020 22:13:47 -0600
Message-ID: <20200324041347.GA186169@zx2c4.com>
References: <20191126200619.63348-1-luc.vanoostenryck@gmail.com>
 <alpine.DEB.2.21.1911271553560.16980@www.lameter.com>
 <20191127175350.GA52308@dennisz-mbp.dhcp.thefacebook.com>
 <20191127225432.ttwxm3hxtg5utfaz@ltop.local>
 <alpine.DEB.2.21.1911291808530.1365@www.lameter.com>
 <20191130000037.zsendu5pk7p75xqf@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from frisell.zx2c4.com ([192.95.5.64]:58047 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725784AbgCXEOC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 24 Mar 2020 00:14:02 -0400
Content-Disposition: inline
In-Reply-To: <20191130000037.zsendu5pk7p75xqf@ltop.local>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Christopher Lameter <cl@linux.com>, Dennis Zhou <dennis@kernel.org>, Ben Dooks <ben.dooks@codethink.co.uk>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, Arnd Bergmann <arnd@arndb.de>

On Sat, Nov 30, 2019 at 01:00:37AM +0100, Luc Van Oostenryck wrote:
> Note: it would be much much nicer to do all these type generic
>       macros with '__auto_type' (only supported in GCC 4.9 IIUC
>       and supported in sparse but it shouldn't be very hard to do)..

I'm curious to know if you know why we're not using __auto_type. Because
we're stuck on gcc 4.6, or is there a more subtle reason?

Jason
