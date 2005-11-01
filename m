Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 1 Nov 2005 10:28:16 -0800
From: Matt Mackall <mpm@selenic.com>
Subject: Oops! Forgot [PATCH 0/20] inflate cleanups
Message-ID: <20051101182816.GA8126@waste.org>
References: <2.196662837@selenic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2.196662837@selenic.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

[Just realized that my 0/20 description didn't go out, so here it is.
I'll wait a bit more before respinning the set with feedback.]

This is a refactored version of the lib/inflate.c I posted about a
year ago. It has a few end goals:

- clean up some really ugly code
- clean up atrocities like '#include "../../../lib/inflate.c"'
- drop a ton of cut and paste code from the kernel boot
- move towards making the boot decompressor pluggable
- move towards unifying the multiple inflate implementations
- save space

This touches 11 architectures, which makes things slightly
interesting. Rather than break the patches out by arch, I've gone the
route of making a number of small incremental changes that sweep
across the tree. Patches that touch the per-arch code are marked
"(arch)".

I've been primarily testing this on x86, but various versions of this
code have gotten testing on a variety of architectures as part of my
linux-tiny tree.

-- 
Mathematics is the supreme nostalgia of our time.
