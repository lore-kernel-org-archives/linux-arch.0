Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Sun, 29 May 2005 02:42:46 -0700
From: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: Lots of possible arch breakage in cpu_idle!!
Message-ID: <20050529094246.GM2057@holomorphy.com>
References: <4299523F.90502@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4299523F.90502@yahoo.com.au>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-arch@vger.kernel.org, Andrew Morton <akpm@osdl.org>
List-ID: <linux-arch.vger.kernel.org>

On Sun, May 29, 2005 at 03:25:19PM +1000, Nick Piggin wrote:
> Your cpu_idle routines need to obey the following rules:

The cpu_idle() routines you suggest return, which is "unexpected"
(AFAICT even on i386). Mind explaining how is this supposed to work?


-- wli
