Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ns1.suse.de ([195.135.220.2]:36187 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2993020AbXDTREF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 20 Apr 2007 13:04:05 -0400
From: Andi Kleen <ak@suse.de>
Subject: Re: Better local_t implementation needed
Date: Fri, 20 Apr 2007 19:01:39 +0200
References: <200704201256.13008.ak@suse.de> <Pine.LNX.4.64.0704200903130.20232@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0704200903130.20232@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200704201901.39437.ak@suse.de>
Sender: linux-arch-owner@vger.kernel.org
To: Christoph Lameter <clameter@sgi.com>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Friday 20 April 2007 18:10:32 Christoph Lameter wrote:

> 
> > Using local_t for per cpu counters is nice because then
> > one can use cpu_local_add() etc. and that generates very good 
> > code at least on x86 and a few other architectures. That would
> > then allow very cheap per CPU statistics, which are useful
> > in a number of subsystems (like networking or MM code)
> 
> Is the per cpu access fixed on x86? Last I checked it was not atomic.

With upcomming patches per cpu can be directly referenced using %fs/%gs
Then cpu_local_add() etc will be a single instruction that is atomic
regarding interrupts.

> Uhhh.... Yuck.
> 
> > Drawback will be larger code. 
> 
> Fix the per cpu area access instead?

That doesn't help on architectures that don't have r-m-w instructions
on memory (like all RISCSs)

-Andi
