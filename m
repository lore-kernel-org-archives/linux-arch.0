From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [patch 05/41] cpu alloc: Percpu_counter conversion
Date: Fri, 30 May 2008 16:47:35 +1000
Message-ID: <200805301647.36198.rusty@rustcorp.com.au>
References: <20080530035620.587204923@sgi.com> <20080530040012.011711936@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:48271 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753467AbYE3Gsi (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 30 May 2008 02:48:38 -0400
In-Reply-To: <20080530040012.011711936@sgi.com>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: akpm@linux-foundation.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, Eric Dumazet <dada1@cosmosbay.com>, Peter Zijlstra <peterz@infradead.org>, Mike Travis <travis@sgi.com>

On Friday 30 May 2008 13:56:25 Christoph Lameter wrote:
> Use cpu_alloc instead of allocpercpu.

These patches seem like useless churn.

Plus, the new code is uglier than the old code :(

Rusty.
