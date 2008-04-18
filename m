From: Kyle McMartin <kyle@mcmartin.ca>
Subject: Re: [PATCH 1/2] Add thread_info_cache_init() to all archs
Date: Fri, 18 Apr 2008 00:21:19 -0400
Message-ID: <20080418042119.GB16276@phobos.i.cabal.ca>
References: <20080410032354.90CB1DDF0F@ozlabs.org> <20080413171953.bde5e9ac.akpm@linux-foundation.org> <1208133506.6958.82.camel@pasglop> <20080413191338.9776ebd0.akpm@linux-foundation.org> <1208491086.6958.381.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754267AbYDREVa@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1208491086.6958.381.camel@pasglop>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Herrenschmidt <benh@ozlabs.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org, takata@linux-m32r.org, linux-m32r@ml.linux-m32r.org, Linux-Arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Fri, Apr 18, 2008 at 01:58:06PM +1000, Benjamin Herrenschmidt wrote:
> Well, looking there, I saw we already used weak symbols for that so what
> about the patch below ? If you're ok, I'll re-send with appropriate sob
> & adapted powerpc part.
> 

This is definitely the cleanest way to do this from my pov. Although I'm
slightly concerned about the proliferation of weak symbols, I'm much
more concerned with adding more include-order-dependent arch overrides. :)

speaking with the parisc dunce-cap on,
	Kyle
