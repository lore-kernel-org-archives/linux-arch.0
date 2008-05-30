From: Christoph Lameter <clameter@sgi.com>
Subject: Re: [patch 26/41] cpu alloc: Convert mib handling to cpu alloc
Date: Fri, 30 May 2008 11:01:14 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0805301101040.14564@schroedinger.engr.sgi.com>
References: <20080530035620.587204923@sgi.com> <20080530040019.799353964@sgi.com>
 <483FA30F.2050900@cosmosbay.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from netops-testserver-3-out.sgi.com ([192.48.171.28]:33116 "EHLO
	relay.sgi.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753095AbYE3SBO (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 30 May 2008 14:01:14 -0400
In-Reply-To: <483FA30F.2050900@cosmosbay.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: akpm@linux-foundation.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, Peter Zijlstra <peterz@infradead.org>, Rusty Russell <rusty@rustcorp.com.au>, Mike Travis <travis@sgi.com>

On Fri, 30 May 2008, Eric Dumazet wrote:

> We also can avoid the use of two arrays when CONFIG_HAVE_CPU_OPS
> since _CPU_INC() and __CPU_INC() are both interrupt safe.
> This would reduce size of mibs by 50% and complexity (no need to sum)

Right.
