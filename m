Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Mon, 31 Oct 2005 17:39:55 -0800
From: Matt Mackall <mpm@selenic.com>
Subject: Re: [PATCH 1/20] inflate: lindent and manual formatting changes
Message-ID: <20051101013955.GG4367@waste.org>
References: <2.196662837@selenic.com> <17254.46523.698248.169639@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17254.46523.698248.169639@cargo.ozlabs.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, Nov 01, 2005 at 11:24:27AM +1100, Paul Mackerras wrote:
> Matt,
> 
> My concern about this series of patches is that it will make it harder
> to keep the kernel zlib in sync with the upstream zlib.

This code is very long out of sync with the existing upstream zlib in
terms of coding style and content, so I doubt my changes will make
much difference from that perspective.

As one of my eventual goals is to get us down to exactly one copy of
this in the kernel, I think it's a step forward. This set of patches
goes a long way towards that goal by making inflate support just a
couple lines for most of the kernel uses.

> Are you signing up to track the upstream zlib and apply any changes
> made there to the kernel version, for the forseeable future?

I will fix any security-relevant bugs, provided other folks don't beat
me to them.

-- 
Mathematics is the supreme nostalgia of our time.
