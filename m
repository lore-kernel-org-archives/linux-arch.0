Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S263769AbUIVL3o@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:5001 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263743AbUIVL3o (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 22 Sep 2004 07:29:44 -0400
Date: Wed, 22 Sep 2004 13:26:53 +0200
From: Andi Kleen <ak@suse.de>
Subject: Re: sem_is_locked()
Message-ID: <20040922112652.GA27432@wotan.suse.de>
References: <20040922111139.GQ9106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040922111139.GQ9106@holomorphy.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, Sep 22, 2004 at 04:11:39AM -0700, William Lee Irwin III wrote:
> hch and some others (e.g. moi) trying to do vfs sweeps would very much
> like to have a sem_is_locked() to assist them; by any chance could arch
> maintainers help out with implementing this for various arches?

On x86-64/i386 and probably most other architectures it is just 
atomic_read(&sem->count) <= 0 

-Andi
