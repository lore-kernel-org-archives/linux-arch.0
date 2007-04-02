Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:52024 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933674AbXDBROX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 2 Apr 2007 13:14:23 -0400
From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 1/4] x86_64: Switch to SPARSE_VIRTUAL
Date: Mon, 2 Apr 2007 19:14:07 +0200
References: <20070401071024.23757.4113.sendpatchset@schroedinger.engr.sgi.com> <200704021744.39880.ak@suse.de> <Pine.LNX.4.64.0704020851300.30394@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0704020851300.30394@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200704021914.07541.ak@suse.de>
Sender: linux-arch-owner@vger.kernel.org
To: Christoph Lameter <clameter@sgi.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Martin Bligh <mbligh@google.com>, linux-mm@kvack.org, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
List-ID: <linux-arch.vger.kernel.org>


> No no no. For the gazillions time: All of 1-1 mapped kernel memory on 
> x86_64 needs a 2 MB page table entry. The virtual memmap uses the same. 
> There are *no* additional TLBs used.

But why do you reserve an own virtual area then if you claim to not use any
additional mappings? 

-Andi
