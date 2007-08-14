Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from netops-testserver-4-out.sgi.com ([192.48.171.29]:39455 "EHLO
	relay.sgi.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932317AbXHNWpa (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 14 Aug 2007 18:45:30 -0400
Date: Tue, 14 Aug 2007 15:45:28 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
Subject: Re: [PATCH 1/23] document preferred use of volatile with atomic_t
In-Reply-To: <20070813110415.GA24018@shell.boston.redhat.com>
Message-ID: <Pine.LNX.4.64.0708141544001.401@schroedinger.engr.sgi.com>
References: <46C03885.7000109@redhat.com> <20070813110415.GA24018@shell.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
To: Chris Snook <csnook@redhat.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, akpm@linux-foundation.org, paulmck@linux.vnet.ibm.com, Segher Boessenkool <segher@kernel.crashing.org>, "Luck, Tony" <tony.luck@intel.com>, Chris Friesen <cfriesen@nortel.com>, "Robert P. J. Day" <rpjday@mindspring.com>
List-ID: <linux-arch.vger.kernel.org>

On Mon, 13 Aug 2007, Chris Snook wrote:

> @@ -38,7 +45,7 @@
>  
>  Next, we have:
>  
> -	#define atomic_read(v)	((v)->counter)
> +	#define atomic_read(v)	(*(volatile int *)&(v)->counter)
>  
>  which simply reads the current value of the counter.

volatile means that there is some vague notion of "read it now". But that 
really does not exist. Instead we control visibility via barriers 
(smp_wmb, smp_rmb). Would it not be best to not have volatile at all in 
atomic operations and let the barriers do the work?

