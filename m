Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:57796 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760382AbXGMX2c (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 13 Jul 2007 19:28:32 -0400
Date: Sat, 14 Jul 2007 08:27:36 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: [PATCH 0/7] Sparsemem Virtual Memmap V5
Message-Id: <20070714082736.10af5f13.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <Pine.LNX.4.64.0707131553120.26572@schroedinger.engr.sgi.com>
References: <617E1C2C70743745A92448908E030B2A01EA65B9@scsmsx411.amr.corp.intel.com>
	<Pine.LNX.4.64.0707131553120.26572@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Christoph Lameter <clameter@sgi.com>
Cc: tony.luck@intel.com, akpm@linux-foundation.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, apw@shadowen.org, npiggin@suse.de, mel@csn.ul.ie
List-ID: <linux-arch.vger.kernel.org>

On Fri, 13 Jul 2007 15:54:25 -0700 (PDT)
Christoph Lameter <clameter@sgi.com> wrote:

> On Fri, 13 Jul 2007, Luck, Tony wrote:
> 
> > > How many tests were done and on what platform?
> > 
> > Andy's part 0/7 post starts off with the performance numbers.  He
> > didn't say which ia64 platform was used for the tests.
> > 
> > Looking my logs for the last few kernel builds (some built on a
> > tiger_defconfig kernel which uses CONFIG_VIRTUAL_MEM_MAP=y, and
> > some with the new CONFIG_SPARSEMEM_VMEMMAP) I'd have a tough time
> > saying whether there was a regression or not).
> 
> I'd be very surprised if there is any difference because the IA64 code for 
> virtual memmap is the source of ideas and implementation for SPARSE_VIRTUAL.
> 
Maybe pfn_valid() implementation is different from ?

Thanks,
-Kame
