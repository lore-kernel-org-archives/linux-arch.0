From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [PATCH][RFC] Implement arch primitives for busywait loops
Date: Fri, 16 Sep 2016 11:30:58 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DB00FF7D8@AcuExch.aculab.com>
References: <20160916085736.7857-1-npiggin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-out4.electric.net ([192.162.216.191]:64047 "EHLO
        smtp-out4.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759174AbcIPLo2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 16 Sep 2016 07:44:28 -0400
In-Reply-To: <20160916085736.7857-1-npiggin@gmail.com>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: 'Nicholas Piggin' <npiggin@gmail.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>

From: Nicholas Piggin
> Sent: 16 September 2016 09:58
> Implementing busy wait loops with cpu_relax() in callers poses
> some difficulties for powerpc.
> 
> First, we want to put our SMT thread into a low priority mode for the
> duration of the loop, but then return to normal priority after exiting
> the loop.  Dependong on the CPU design, 'HMT_low() ; HMT_medium();' as
> cpu_relax() does may have HMT_medium take effect before HMT_low made
> any (or much) difference.
> 
> Second, it can be beneficial for some implementations to spin on the
> exit condition with a statically predicted-not-taken branch (i.e.,
> always predict the loop will exit).
> 
> This is a quick RFC with a couple of users converted to see what
> people think. I don't use a C branch with hints, because we don't want
> the compiler moving the loop body out of line, which makes it a bit
> messy unfortunately. If there's a better way to do it, I'm all ears.

I think it will still all go wrong if the conditional isn't trivial.
In particular if the condition contains || or && it is likely to
have a branch - which could invert the loop.

	David
