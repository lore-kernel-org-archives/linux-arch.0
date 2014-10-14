Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:41062 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932276AbaJNMim (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 14 Oct 2014 08:38:42 -0400
Received: by mail-wg0-f44.google.com with SMTP id y10so10809516wgg.27
        for <linux-arch@vger.kernel.org>; Tue, 14 Oct 2014 05:38:40 -0700 (PDT)
Date: Tue, 14 Oct 2014 13:38:34 +0100
From: Steve Capper <steve.capper@linaro.org>
Subject: Re: [PATCH V4 1/6] mm: Introduce a general RCU get_user_pages_fast.
Message-ID: <20141014123834.GA1110@linaro.org>
References: <87d29w1rf7.fsf@linux.vnet.ibm.com>
 <20141013.012146.992477977260812742.davem@davemloft.net>
 <20141013114428.GA28113@linaro.org>
 <20141013.120618.1470323732942174784.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141013.120618.1470323732942174784.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: aneesh.kumar@linux.vnet.ibm.com, aarcange@redhat.com, linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, linux@arm.linux.org.uk, linux-arch@vger.kernel.org, linux-mm@kvack.org, will.deacon@arm.com, gary.robertson@linaro.org, christoffer.dall@linaro.org, peterz@infradead.org, anders.roxell@linaro.org, akpm@linux-foundation.org, dann.frazier@canonical.com, mark.rutland@arm.com, mgorman@suse.de, hughd@google.com
Message-ID: <20141014123834.-QJWjFLfQaS2ecehA173oQmwxI-RJpUrdNg8D9WScZk@z>

On Mon, Oct 13, 2014 at 12:06:18PM -0400, David Miller wrote:
> From: Steve Capper <steve.capper@linaro.org>
> Date: Mon, 13 Oct 2014 12:44:28 +0100
> 
> > Also, as a heads up for Sparc. I don't see any definition of
> > __get_user_pages_fast. Does this mean that a futex on THP tail page
> > can cause an infinite loop?
> 
> I have no idea, I didn't realize this was required to be implemented.

In get_futex_key, a call is made to __get_user_pages_fast to handle the
case where a THP tail page needs to be pinned for the futex. There is a
stock implementation of __get_user_pages_fast, but this is just an
empty function that returns 0. Unfortunately this will provoke a goto
to "again:" and end up in an infinite loop. The process will appear
to hang with a high system cpu usage.
