From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] fix __percpu annotation in asm-generic
Date: Tue, 24 Mar 2020 07:44:52 +0100
Message-ID: <20200324064452.zsnpcvihgeyegtmu@ltop.local>
References: <20191126200619.63348-1-luc.vanoostenryck@gmail.com>
 <alpine.DEB.2.21.1911271553560.16980@www.lameter.com>
 <20191127175350.GA52308@dennisz-mbp.dhcp.thefacebook.com>
 <20191127225432.ttwxm3hxtg5utfaz@ltop.local>
 <alpine.DEB.2.21.1911291808530.1365@www.lameter.com>
 <20191130000037.zsendu5pk7p75xqf@ltop.local>
 <20200324041347.GA186169@zx2c4.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46560 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbgCXGo4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 24 Mar 2020 02:44:56 -0400
Content-Disposition: inline
In-Reply-To: <20200324041347.GA186169@zx2c4.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Christopher Lameter <cl@linux.com>, Dennis Zhou <dennis@kernel.org>, Ben Dooks <ben.dooks@codethink.co.uk>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, Arnd Bergmann <arnd@arndb.de>

On Mon, Mar 23, 2020 at 10:13:47PM -0600, Jason A. Donenfeld wrote:
> On Sat, Nov 30, 2019 at 01:00:37AM +0100, Luc Van Oostenryck wrote:
> > Note: it would be much much nicer to do all these type generic
> >       macros with '__auto_type' (only supported in GCC 4.9 IIUC
> >       and supported in sparse but it shouldn't be very hard to do)..
> 
> I'm curious to know if you know why we're not using __auto_type. Because
> we're stuck on gcc 4.6, or is there a more subtle reason?

I suppose. I don't remember having ever seen a discussion on the
subject (other than a simple remark like "it would be simpler
with __auto_type").

Mainline Sparse doesn't support it but I've a pending series for it
that seems to work well. 

-- Luc
