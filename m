From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] percpu: improve generic percpu modify-return
 implementation
Date: Fri, 23 Sep 2016 17:33:51 +1000
Message-ID: <20160923173351.74a0dd0d@roar.ozlabs.ibm.com>
References: <20160921085137.862-1-npiggin@gmail.com>
        <20160921205711.4e804777@roar.ozlabs.ibm.com>
        <20160921142343.GA10734@htj.duckdns.org>
        <20160922143500.21809b98@roar.ozlabs.ibm.com>
        <20160922160749.GD1892@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169]:35378 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753233AbcIWHd6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 23 Sep 2016 03:33:58 -0400
In-Reply-To: <20160922160749.GD1892@htj.duckdns.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: Christoph Lameter <cl@linux.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

On Thu, 22 Sep 2016 12:07:49 -0400
Tejun Heo <tj@kernel.org> wrote:

> Hello,
> 
> On Thu, Sep 22, 2016 at 02:35:00PM +1000, Nicholas Piggin wrote:
> > Well thank you, how about you?  
> 
> Heh, can't complain.  Hope to see you around sometime.  It's been
> forever.

Yeah, it has been. Hopefully I'll see you around.


> > Trying a new mail client, sorry. It *seems* to be working now, how's
> > this?  
> 
> Hmm... Still encoded.

It looks to be a helpful surprise feature of claws. Any line starting with
the word "From" make it go q-p due to some mail servers treating that
differently. Sigh.

> 
> > From d0cb9052d6f4c31d24f999b7b0cecb34681eee9b Mon Sep 17 00:00:00 2001
> > From: Nicholas Piggin <npiggin@gmail.com>
> > Date: Wed, 21 Sep 2016 18:23:43 +1000
> > Subject: [PATCH] percpu: improve generic percpu modify-return implementations
> > 
> > Some architectures require an additional load to find the address of
> > percpu pointers. In some implemenatations, the C aliasing rules do not
> > allow the result of that load to be kept over the store that modifies
> > the percpu variable, which causes additional loads.
> > 
> > Work around this by finding the pointer first, then operating on that.
> > 
> > It's also possible to mark things as restrict and those kind of games,
> > but that can require larger and arch specific changes.  
> 
> QP-decoded and applied to percpu/for-4.9.
> 
> Thanks.
> 

Thanks!
