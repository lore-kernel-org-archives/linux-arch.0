Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S264919AbUIVLyZ@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:45988 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264915AbUIVLyZ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 22 Sep 2004 07:54:25 -0400
Date: Wed, 22 Sep 2004 13:51:03 +0200
From: Andi Kleen <ak@suse.de>
Subject: Re: sem_is_locked()
Message-ID: <20040922115103.GB27432@wotan.suse.de>
References: <20040922111139.GQ9106@holomorphy.com> <20040922112652.GA27432@wotan.suse.de> <20040922123552.A2347@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040922123552.A2347@flint.arm.linux.org.uk>
To: Andi Kleen <ak@suse.de>, William Lee Irwin III <wli@holomorphy.com>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, Sep 22, 2004 at 12:35:52PM +0100, Russell King wrote:
> On Wed, Sep 22, 2004 at 01:26:53PM +0200, Andi Kleen wrote:
> > On Wed, Sep 22, 2004 at 04:11:39AM -0700, William Lee Irwin III wrote:
> > > hch and some others (e.g. moi) trying to do vfs sweeps would very much
> > > like to have a sem_is_locked() to assist them; by any chance could arch
> > > maintainers help out with implementing this for various arches?
> > 
> > On x86-64/i386 and probably most other architectures it is just 
> > atomic_read(&sem->count) <= 0 
> 
> Obviously, generic code should not assume that a semaphore is
> implemented using atomic_t.

Sure, but with that fact it's pretty easy to implement the macro
wli wants for most architectures.

-Andi
