Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:56747 "EHLO mga02.intel.com")
	by vger.kernel.org with ESMTP id S1750993AbWIMP7Z (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 13 Sep 2006 11:59:25 -0400
Date: Wed, 13 Sep 2006 08:57:34 -0700
From: "Luck, Tony" <tony.luck@intel.com>
Subject: Re: [PATCH 4/6] Implement a general log2 facility in the kernel
Message-ID: <20060913155734.GA6355@intel.com>
References: <20060913130253.32022.69230.stgit@warthog.cambridge.redhat.com> <20060913130300.32022.69743.stgit@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060913130300.32022.69743.stgit@warthog.cambridge.redhat.com>
Sender: linux-arch-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, Sep 13, 2006 at 02:03:00PM +0100, David Howells wrote:
> From: David Howells <dhowells@redhat.com>
> 
> This facility provides three entry points:
> 
> 	log2()		Log base 2 of u32
> 	ll_log2()	Log base 2 of u64
> 	long_log2()	Log base 2 of unsigned long

The names are rather counter-intuitive. "ll" sounds like "long long", so
why does it opearte on *unsigned* 64-bit?  Ditto for "long_log2()".
Perhaps they should be log2_u32(), log2_u64(), etc.

Even better if someone can come up with the right pre-processor magic
using sizeof/typeof so that you could just use "log2(any type)"


-Tony
