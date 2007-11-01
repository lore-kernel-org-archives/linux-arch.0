Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:42880
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1752122AbXKAA1l (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 31 Oct 2007 20:27:41 -0400
Date: Wed, 31 Oct 2007 17:27:41 -0700 (PDT)
Message-Id: <20071031.172741.192929676.davem@davemloft.net>
Subject: Re: [patch 0/7] [RFC] SLUB: Improve allocpercpu to reduce per cpu
 access overhead
From: David Miller <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.64.0710311724490.25361@schroedinger.engr.sgi.com>
References: <20071101000211.970501947@sgi.com>
	<20071031.172421.228723187.davem@davemloft.net>
	<Pine.LNX.4.64.0710311724490.25361@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: clameter@sgi.com
Cc: akpm@linux-foundation.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, mathieu.desnoyers@polymtl.ca, penberg@cs.helsinki.fi
List-ID: <linux-arch.vger.kernel.org>

From: Christoph Lameter <clameter@sgi.com>
Date: Wed, 31 Oct 2007 17:26:16 -0700 (PDT)

> Do 
> 
> git pull git://git.kernel.org/pub/scm/linux/kernel/git/christoph/slab.git 
> performance
> 
> and then you should be able to apply these patches.

Thanks a lot Chrisoph.
