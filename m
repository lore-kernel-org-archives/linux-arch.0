Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S264648AbUIVLf6@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:4112 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263769AbUIVLf5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 22 Sep 2004 07:35:57 -0400
Date: Wed, 22 Sep 2004 12:35:52 +0100
From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: sem_is_locked()
Message-ID: <20040922123552.A2347@flint.arm.linux.org.uk>
References: <20040922111139.GQ9106@holomorphy.com> <20040922112652.GA27432@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040922112652.GA27432@wotan.suse.de>; from ak@suse.de on Wed, Sep 22, 2004 at 01:26:53PM +0200
Sender: Russell King <rmk@arm.linux.org.uk>
To: Andi Kleen <ak@suse.de>
Cc: William Lee Irwin III <wli@holomorphy.com>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, Sep 22, 2004 at 01:26:53PM +0200, Andi Kleen wrote:
> On Wed, Sep 22, 2004 at 04:11:39AM -0700, William Lee Irwin III wrote:
> > hch and some others (e.g. moi) trying to do vfs sweeps would very much
> > like to have a sem_is_locked() to assist them; by any chance could arch
> > maintainers help out with implementing this for various arches?
> 
> On x86-64/i386 and probably most other architectures it is just 
> atomic_read(&sem->count) <= 0 

Obviously, generic code should not assume that a semaphore is
implemented using atomic_t.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
