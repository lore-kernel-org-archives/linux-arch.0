Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:21316 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1767177AbXDTSbs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 20 Apr 2007 14:31:48 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: Better local_t implementation needed
Date: Fri, 20 Apr 2007 11:31:45 -0700
Message-ID: <617E1C2C70743745A92448908E030B2A015F22E3@scsmsx411.amr.corp.intel.com>
In-Reply-To: <200704201256.13008.ak@suse.de>
From: "Luck, Tony" <tony.luck@intel.com>
Sender: linux-arch-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>, linux-arch@vger.kernel.org
Cc: Christoph Lameter <clameter@sgi.com>
List-ID: <linux-arch.vger.kernel.org>

> Using local_t for per cpu counters is nice because then
> one can use cpu_local_add() etc. and that generates very good 
> code at least on x86 and a few other architectures. That would
> then allow very cheap per CPU statistics, which are useful
> in a number of subsystems (like networking or MM code)

But be warned that aggregating the per-cpu counters can be very
expensive on high cpu count ia64 systems.  We've had issues with
/proc files that provide system counts that do this in a cache
hostile way.

-Tony
