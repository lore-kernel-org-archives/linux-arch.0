Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:40896 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753509AbYDXWCe (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 24 Apr 2008 18:02:34 -0400
Date: Thu, 24 Apr 2008 23:01:57 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [PATCH 1/11] Add generic helpers for arch IPI function calls
Message-ID: <20080424220157.GA26179@flint.arm.linux.org.uk>
References: <1208890227-24808-1-git-send-email-jens.axboe@oracle.com> <1208890227-24808-2-git-send-email-jens.axboe@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1208890227-24808-2-git-send-email-jens.axboe@oracle.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jens Axboe <jens.axboe@oracle.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, npiggin@suse.de, torvalds@linux-foundation.org, peterz@infradead.org, sam@ravnborg.org
Message-ID: <20080424220157.ZDssx5s9pkKDOZQagdtHk7IkzgIh2KLRpeRcsXiNnzM@z>

On Tue, Apr 22, 2008 at 08:50:17PM +0200, Jens Axboe wrote:
> +		data->csd.func(data->csd.info);
> +
> +		spin_lock(&data->lock);
> +		cpu_clear(cpu, data->cpumask);
> +		WARN_ON(data->refs == 0);
> +		data->refs--;
> +		refs = data->refs;

Probably a silly question, but what does data->refs do that
cpus_empty(data->cpumask) wouldn't do?  (as indeed ARM presently does.)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
