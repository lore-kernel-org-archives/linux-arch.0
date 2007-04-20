Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:39634 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030864AbXDTUOU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 20 Apr 2007 16:14:20 -0400
From: Andi Kleen <ak@suse.de>
Subject: Re: Better local_t implementation needed
Date: Fri, 20 Apr 2007 22:14:17 +0200
References: <617E1C2C70743745A92448908E030B2A015F22E3@scsmsx411.amr.corp.intel.com>
In-Reply-To: <617E1C2C70743745A92448908E030B2A015F22E3@scsmsx411.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200704202214.17774.ak@suse.de>
Sender: linux-arch-owner@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: linux-arch@vger.kernel.org, Christoph Lameter <clameter@sgi.com>
List-ID: <linux-arch.vger.kernel.org>

On Friday 20 April 2007 20:31:45 Luck, Tony wrote:
> > Using local_t for per cpu counters is nice because then
> > one can use cpu_local_add() etc. and that generates very good 
> > code at least on x86 and a few other architectures. That would
> > then allow very cheap per CPU statistics, which are useful
> > in a number of subsystems (like networking or MM code)
> 
> But be warned that aggregating the per-cpu counters can be very
> expensive on high cpu count ia64 systems.  We've had issues with
> /proc files that provide system counts that do this in a cache
> hostile way.

Can you expand? What cache hostile way?

-Andi
