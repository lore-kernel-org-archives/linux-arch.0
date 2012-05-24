From: Paul Mackerras <paulus@samba.org>
Subject: Re: Arch maintainers Ahoy!
Date: Thu, 24 May 2012 15:25:45 +1000
Message-ID: <20120524052545.GB9492@drongo>
References: <CA+55aFy78h5z1fnW+TovTQ4wUBauUW4i7=Z583tbQVMhsWvTAQ@mail.gmail.com>
 <20120523.163644.875474822428763332.davem@davemloft.net>
 <CA+55aFx1HNC5rd5dzuKpNiHKWvkhoc=-y6hsAW-L_X7sz5Taog@mail.gmail.com>
 <20120523.221150.620846999543569983.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:53854 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751125Ab2EXFZ4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 24 May 2012 01:25:56 -0400
Content-Disposition: inline
In-Reply-To: <20120523.221150.620846999543569983.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: torvalds@linux-foundation.org, James.Bottomley@hansenpartnership.com, geert@linux-m68k.org, linux-arch@vger.kernel.org

On Wed, May 23, 2012 at 10:11:50PM -0400, David Miller wrote:

> Ok, now confirmed, the following patch generates the best code I've
> been able to get out of GCC thus far, and it's tested too.
> 
> Therefore, I'll push this out to my sparc tree.
> 
> Next, I'll try to add the abstractions et al. necessary to put this
> under the top-level lib/ so others can use it too.

Sounds good, thanks for doing this.  On PowerPC we have the "count
leading zeroes" instructions we could use to find the position of the
leftmost zero byte, so if you can conveniently make the find_zero()
function overridable, that would be good.

Paul.
