Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from kanga.kvack.org ([66.96.29.28]:31979 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S965139AbWH2TK3 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 29 Aug 2006 15:10:29 -0400
Date: Tue, 29 Aug 2006 15:10:15 -0400
From: Benjamin LaHaise <bcrl@kvack.org>
Subject: Re: Why Semaphore Hardware-Dependent?
Message-ID: <20060829191015.GL18092@kvack.org>
References: <44F395DE.10804@yahoo.com.au> <1156750249.3034.155.camel@laptopd505.fenrus.org> <11861.1156845927@warthog.cambridge.redhat.com> <200608291256.54665.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608291256.54665.ak@suse.de>
Sender: linux-arch-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: David Howells <dhowells@redhat.com>, Nick Piggin <nickpiggin@yahoo.com.au>, Arjan van de Ven <arjan@infradead.org>, Dong Feng <middle.fengdong@gmail.com>, Paul Mackerras <paulus@samba.org>, Christoph Lameter <clameter@sgi.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, Aug 29, 2006 at 12:56:54PM +0200, Andi Kleen wrote:
> We've completely given up these kinds of micro optimization for spinlocks,
> which are 1000x as critical as rwsems.  And nobody was able to benchmark
> a difference.

That is false.  It shows up on things like netperf on the P4, or the AF_UNIX 
component of lmbench.

		-ben
-- 
"Time is of no importance, Mr. President, only life is important."
Don't Email: <dont@kvack.org>.
