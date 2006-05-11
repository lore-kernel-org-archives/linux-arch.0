Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from CPE-144-136-172-108.sa.bigpond.net.au ([144.136.172.108]:7984
	"EHLO grove.modra.org") by vger.kernel.org with ESMTP
	id S965101AbWEKBEk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 10 May 2006 21:04:40 -0400
Date: Thu, 11 May 2006 10:34:38 +0930
From: Alan Modra <amodra@bigpond.net.au>
Subject: Re: [RFC/PATCH] Make powerpc64 use __thread for per-cpu variables
Message-ID: <20060511010438.GE24458@bubble.grove.modra.org>
References: <17505.26159.807484.477212@cargo.ozlabs.ibm.com> <20060510154702.GA28938@twiddle.net> <20060510.124003.04457042.davem@davemloft.net> <17506.21908.857189.645889@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17506.21908.857189.645889@cargo.ozlabs.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
Cc: "David S. Miller" <davem@davemloft.net>, linux-arch@vger.kernel.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, rth@twiddle.net
List-ID: <linux-arch.vger.kernel.org>

On Thu, May 11, 2006 at 07:05:24AM +1000, Paul Mackerras wrote:
> No, Richard has a point, it's not the value that is the concern, it's
> the address, which gcc could assume is still valid after a barrier.
> Drat.

That may never happen, at least with a compiler that knows how to
optimise away the addi.  You're using -mtls-size=16 so all your accesses
should look like

	lwz rn,per_cpu_var@tprel(13)

gcc shouldn't think there is any reason to cache the address.

-- 
Alan Modra
IBM OzLabs - Linux Technology Centre
