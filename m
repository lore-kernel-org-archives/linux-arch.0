Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from netops-testserver-3-out.sgi.com ([192.48.171.28]:41398 "EHLO
	relay.sgi.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752988AbXKAAbO (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 31 Oct 2007 20:31:14 -0400
Date: Wed, 31 Oct 2007 17:31:12 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
Subject: Re: [patch 0/7] [RFC] SLUB: Improve allocpercpu to reduce per cpu
 access overhead
In-Reply-To: <20071031.172741.192929676.davem@davemloft.net>
Message-ID: <Pine.LNX.4.64.0710311730280.25414@schroedinger.engr.sgi.com>
References: <20071101000211.970501947@sgi.com> <20071031.172421.228723187.davem@davemloft.net>
 <Pine.LNX.4.64.0710311724490.25361@schroedinger.engr.sgi.com>
 <20071031.172741.192929676.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: akpm@linux-foundation.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, mathieu.desnoyers@polymtl.ca, penberg@cs.helsinki.fi
List-ID: <linux-arch.vger.kernel.org>

On Wed, 31 Oct 2007, David Miller wrote:

> > git pull git://git.kernel.org/pub/scm/linux/kernel/git/christoph/slab.git 
> > performance
> > 
> > and then you should be able to apply these patches.
> 
> Thanks a lot Chrisoph.

Others may have the same issue.

git pull git://git.kernel.org/pub/scm/linux/kernel/git/christoph/slab.git allocpercpu

should get you the whole thing.

