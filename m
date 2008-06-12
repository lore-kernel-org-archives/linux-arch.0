From: Christoph Lameter <clameter@sgi.com>
Subject: Re: [patch 04/41] cpu ops: Core piece for generic atomic per cpu
 operations
Date: Thu, 12 Jun 2008 10:19:51 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0806121017010.30597@schroedinger.engr.sgi.com>
References: <20080530035620.587204923@sgi.com> <200806121340.29366.nickpiggin@yahoo.com.au>
 <1213263470.25502.6.camel@kitka.ibm.com> <200806122121.09835.nickpiggin@yahoo.com.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from relay1.sgi.com ([192.48.171.29]:42836 "EHLO relay.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753254AbYFLRT4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 12 Jun 2008 13:19:56 -0400
In-Reply-To: <200806122121.09835.nickpiggin@yahoo.com.au>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Martin Peschke <mp3@de.ibm.com>, Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, Eric Dumazet <dada1@cosmosbay.com>, Peter Zijlstra <peterz@infradead.org>, Mike Travis <travis@sgi.com>

Populating the per cpu areas on demand is a good thing especially for 
configurations with a large number of processors. If we really go to 
support 4k processor by default then we need to allocate the smallest 
amount of per cpu structures necessary. Maybe ACPI or so can tell us how 
many processors are possible and we only allocate those. But it would be 
best if the percpu structures are only allocated for actually active 
processors.
