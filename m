Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S264903AbUIVL6z@vger.kernel.org>
Received: from holomorphy.com ([207.189.100.168]:974 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264795AbUIVL6z (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 22 Sep 2004 07:58:55 -0400
Date: Wed, 22 Sep 2004 04:58:48 -0700
From: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: sem_is_locked()
Message-ID: <20040922115848.GR9106@holomorphy.com>
References: <20040922111139.GQ9106@holomorphy.com> <20040922112652.GA27432@wotan.suse.de> <20040922123552.A2347@flint.arm.linux.org.uk> <20040922115103.GB27432@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040922115103.GB27432@wotan.suse.de>
To: Andi Kleen <ak@suse.de>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, Sep 22, 2004 at 12:35:52PM +0100, Russell King wrote:
>> Obviously, generic code should not assume that a semaphore is
>> implemented using atomic_t.

On Wed, Sep 22, 2004 at 01:51:03PM +0200, Andi Kleen wrote:
> Sure, but with that fact it's pretty easy to implement the macro
> wli wants for most architectures.

This sounds like I should just sweep them all and drop it in, as no
one is concerned much about the details. All's well, it seems.


-- wli
