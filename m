Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268907AbUIHH1z@vger.kernel.org>
Received: from omx1-ext.sgi.com ([192.48.179.11]:2739 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S268904AbUIHH1z (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 8 Sep 2004 03:27:55 -0400
Date: Wed, 8 Sep 2004 00:26:50 -0700
From: Paul Jackson <pj@sgi.com>
Subject: Re: [PATCH] Fix argument checking in sched_setaffinity
Message-Id: <20040908002650.69b88ac1.pj@sgi.com>
In-Reply-To: <20040908065858.GF27886@wotan.suse.de>
References: <Pine.LNX.4.58.0409042055460.2331@ppc970.osdl.org>
	<20040904211749.3f713a8a.pj@sgi.com>
	<20040904215205.0a067ab8.pj@sgi.com>
	<20040906182330.GA79122@muc.de>
	<Pine.LNX.4.58.0409061147220.28608@ppc970.osdl.org>
	<20040906141142.663941fb.pj@sgi.com>
	<Pine.LNX.4.58.0409070736100.2299@ppc970.osdl.org>
	<20040907144936.GD20981@wotan.suse.de>
	<20040907214408.GB27284@linux-mips.org>
	<20040907155530.5008c02c.pj@sgi.com>
	<20040908065858.GF27886@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Andi Kleen <ak@suse.de>
Cc: ralf@linux-mips.org, torvalds@osdl.org, ak@muc.de, akpm@osdl.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

> The only behaviour change is for cases that would
> previously have returned -EINVAL.

That's a change.  It has non-zero risk of breaking (or exposing an
existing, implicit breakage in) some user code, especially given that
user code has been encouraged to write loops testing for -EINVAL in
order to probe the mask size.  I didn't see enough benefit from any
of the variants of the last week to compensate for this risk.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
