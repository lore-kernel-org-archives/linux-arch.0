Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:44293 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753930AbXDMAIW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 12 Apr 2007 20:08:22 -0400
Subject: RE: +
	expose-range-checking-functions-from-arch-specific.patchadded to -mm tree
From: Rusty Russell <rusty@rustcorp.com.au>
In-Reply-To: <617E1C2C70743745A92448908E030B2A0157430D@scsmsx411.amr.corp.intel.com>
References: <617E1C2C70743745A92448908E030B2A0157430D@scsmsx411.amr.corp.intel.com>
Content-Type: text/plain
Date: Fri, 13 Apr 2007 10:08:03 +1000
Message-Id: <1176422883.14322.166.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Howells <dhowells@redhat.com>, linux-arch@vger.kernel.org, randy.dunlap@oracle.com
List-ID: <linux-arch.vger.kernel.org>

On Thu, 2007-04-12 at 09:05 -0700, Luck, Tony wrote:
> > Actually, I think it's brilliantly documented.  Defining base as the
> > first valid value and limit as the first invalid value makes it pretty
> > clear, IMHO.
> 
> "first invalid value" is hard to express if the range you
> want to check includes the largest value for the type
> you are using.  Either "limit" needs to be the largest
> allowable value, or you should stick to "base,len".

Hi Tony!

	Sure.  But to be pedantic, that's not a question of documentation: the
documentation made it pretty clear that this expression was not
possible.

Nonetheless, I agree that base+len has merit over start & end.

Cheers,
Rusty.


