Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:39684 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S965089AbWIQUs4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 17 Sep 2006 16:48:56 -0400
Message-ID: <450DB4AB.2040105@linux.intel.com>
Date: Sun, 17 Sep 2006 22:48:43 +0200
From: Arjan van de Ven <arjan@linux.intel.com>
MIME-Version: 1.0
Subject: Re: [patch 1/1] make PROT_WRITE imply PROT_READ
References: <200609150139.k8F1dl7Y014791@shell0.pdx.osdl.net> <20060917202408.GA10031@tuatara.stupidest.org>
In-Reply-To: <20060917202408.GA10031@tuatara.stupidest.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Chris Wedgwood <cw@f00f.org>
Cc: akpm@osdl.org, linux-arch@vger.kernel.org, jbaron@redhat.com, ak@muc.de, alan@lxorguk.ukuu.org.uk, benh@kernel.crashing.org, geert@linux-m68k.org, hugh@veritas.com, kkojima@rr.iij4u.or.jp, lethal@linux-sh.org, paulus@samba.org, rmk@arm.linux.org.uk, spyro@f2s.com, tony.luck@intel.com, zippel@linux-m68k.org
List-ID: <linux-arch.vger.kernel.org>

Chris Wedgwood wrote:
> On Thu, Sep 14, 2006 at 06:39:47PM -0700, akpm@osdl.org wrote:
> 
>> Make PROT_WRITE imply PROT_READ for a number of architectures which
>> don't support write only in hardware.
> 
> Why don't we WARN where PROT_WRITE is used w/o PROT_READ?  Do
> non-trivial or non-contrived applications really use PROT_WRITE and
> assume reads are OK?
> 
> It seems once we do this there will be little or no chance of ever
> doing write-only mappings should we want to in the future using this
> mechanism.
> 
> We could just update the definition of PROT_WRITE in the userspace
> headers...

btw PROT_WRITE does make sense in principle for MMIO mappings, especially
uncachable ones. Not per se on native hardware, but in the hardware enabled
virtualization (Intel VT or AMD-V) case this suddenly becomes very easily
enforcable and probably even worth enforcing (since in that case the hypervisor
traps on each access to the memory and simulates the instruction anyway;
only writes means it's a lot simpler in terms of IOMMU and cache coherency etc
etc)
