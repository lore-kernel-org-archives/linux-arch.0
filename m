Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.clusterfs.com ([206.168.112.78]:39318 "EHLO
	mail.clusterfs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752246AbXEIMIn (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 9 May 2007 08:08:43 -0400
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17985.47561.298978.466437@gargle.gargle.HOWL>
Date: Wed, 9 May 2007 16:08:41 +0400
Subject: Re: [rfc] lock bitops
In-Reply-To: <20070508113709.GA19294@wotan.suse.de>
References: <20070508113709.GA19294@wotan.suse.de>
Sender: linux-arch-owner@vger.kernel.org
To: Nick Piggin <npiggin@suse.de>
Cc: linux-arch@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>

Nick Piggin writes:
 > Hi,

[...]

 >  
 >  /**
 > + * clear_bit_unlock - Clears a bit in memory with release
 > + * @nr: Bit to clear
 > + * @addr: Address to start counting from
 > + *
 > + * clear_bit() is atomic and may not be reordered.  It does

s/clear_bit/clear_bit_unlock/ ?

 > + * contain a memory barrier suitable for unlock type operations.
 > + */
 > +static __inline__ void
 > +clear_bit_unlock (int nr, volatile void *addr)
 > +{

Nikita.
