Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:41636 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754607AbXIINBk (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 9 Sep 2007 09:01:40 -0400
Date: Sun, 9 Sep 2007 07:01:39 -0600
From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [patch 4/5] Use extended crashkernel command line on IA64
Message-ID: <20070909130139.GF6809@parisc-linux.org>
References: <20070909083914.065380136@strauss.suse.de> <20070909083915.165288618@strauss.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070909083915.165288618@strauss.suse.de>
Sender: linux-arch-owner@vger.kernel.org
To: Bernhard Walle <bwalle@suse.de>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-ia64@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Sun, Sep 09, 2007 at 10:39:18AM +0200, Bernhard Walle wrote:
> Because the total amount of System RAM must be known when calling this
> function, efi_memmap_init() is modified to return its comulated 

accumulated?

> total_memory variable in a pointer value. IMO that's better than making the
> variable global.

Why not make efi_memmap_init() return total_memory instead of void?

-- 
Intel are signing my paycheques ... these opinions are still mine
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
