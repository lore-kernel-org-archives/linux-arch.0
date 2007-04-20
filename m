Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from netops-testserver-3-out.sgi.com ([192.48.171.28]:45730 "EHLO
	relay.sgi.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753673AbXDTUic (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 20 Apr 2007 16:38:32 -0400
Date: Fri, 20 Apr 2007 13:38:31 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
Subject: RE: Better local_t implementation needed
In-Reply-To: <617E1C2C70743745A92448908E030B2A015F2392@scsmsx411.amr.corp.intel.com>
Message-ID: <Pine.LNX.4.64.0704201337580.14739@schroedinger.engr.sgi.com>
References: <617E1C2C70743745A92448908E030B2A015F2392@scsmsx411.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Andi Kleen <ak@suse.de>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Fri, 20 Apr 2007, Luck, Tony wrote:

> Look for the !defined(CONFIG_IA64) in fs/proc/proc_misc.c.
> 
> 	for (i = 0; i < NR_IRQS; i++)
> 		seq_printf(p, " %u", kstat_irqs(i));
> 
> That loop took several seconds on a big SGI box.

I guess the sum_vm_events() in mm/vmstat.c does the right thing. It goes 
by cpu and adds up all event counter of one cpu area before going to the 
next.

