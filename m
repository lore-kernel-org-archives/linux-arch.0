From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 23/31] arch,s390: Convert smp_mb__*
Date: Wed, 19 Mar 2014 14:50:47 +0100
Message-ID: <20140319135047.GG4223@osiris>
References: <20140319064729.660482086@infradead.org>
 <20140319065205.008359711@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e06smtp13.uk.ibm.com ([195.75.94.109]:58389 "EHLO
	e06smtp13.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933957AbaCSNux (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 19 Mar 2014 09:50:53 -0400
Received: from /spool/local
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
	Wed, 19 Mar 2014 13:50:51 -0000
Content-Disposition: inline
In-Reply-To: <20140319065205.008359711@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, mingo@kernel.org, will.deacon@arm.com, paulmck@linux.vnet.ibm.com

On Wed, Mar 19, 2014 at 07:47:52AM +0100, Peter Zijlstra wrote:
> As per the existing implementation; implement the new one using
> smp_mb().
> 
> AFAICT the s390 compare-and-swap does imply a barrier, however there
> are some immediate ops that seem to be singly-copy atomic and do not
> imply a barrier. One such is the "ni" op (which would be
> and-immediate) which is used for the constant clear_bit
> implementation. Therefore s390 needs full barriers for the
> {before,after} atomic ops.

That is correct... and made me look again into the recent bitops and
atomic changes I made.
Looks like I missed to add some mandatory memory barriers. Oh well.
