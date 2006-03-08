Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:19074
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932534AbWCHWYB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 8 Mar 2006 17:24:01 -0500
Date: Wed, 08 Mar 2006 14:24:01 -0800 (PST)
Message-Id: <20060308.142401.72886733.davem@davemloft.net>
Subject: Re: [PATCH] Document Linux's memory barriers
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <17423.21837.304330.623519@cargo.ozlabs.ibm.com>
References: <9551.1141762147@warthog.cambridge.redhat.com>
	<200603080925.19425.duncan.sands@math.u-psud.fr>
	<17423.21837.304330.623519@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: paulus@samba.org
Cc: duncan.sands@math.u-psud.fr, dhowells@redhat.com, akpm@osdl.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@osdl.org, mingo@redhat.com, linuxppc64-dev@ozlabs.org, alan@lxorguk.ukuu.org.uk
List-ID: <linux-arch.vger.kernel.org>

From: Paul Mackerras <paulus@samba.org>
Date: Thu, 9 Mar 2006 09:06:05 +1100

> I'd be interested to know what the C standard says about whether the
> compiler can reorder writes that may be visible to a signal handler.
> An interrupt handler in the kernel is logically equivalent to a signal
> handler in normal C code.
> 
> Surely there are some C language lawyers on one of the lists that this
> thread is going to?

Just like for setjmp() I think you have to mark such things
as volatile.
