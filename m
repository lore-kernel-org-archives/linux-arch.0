Return-Path: <James.Bottomley@SteelEye.com>
Received: from stat1.steeleye.com ([65.114.3.130]:25021 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S263174AbUCTAPo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 19 Mar 2004 19:15:44 -0500
Subject: Re: pci_map_single return value
From: James Bottomley <James.Bottomley@SteelEye.com>
In-Reply-To: <20040319220506.1718cc55.ak@suse.de>
References: <20031212155752.GD17683@krispykreme>
	<20031212175104.07dc8444.ak@suse.de> <20031212192131.GF17683@krispykreme>
	<20031213220444.4c526afa.davem@redhat.com>
	<20040102120121.GT28023@krispykreme> <20040102133454.22daa451.ak@suse.de>
	<20040319001448.GP28212@krispykreme> <1079715431.1732.18.camel@mulgrave>
	<20040319105549.1285ef71.davem@redhat.com>
	<1079730090.1778.1.camel@mulgrave>  <20040319220506.1718cc55.ak@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: 19 Mar 2004 19:13:33 -0500
Message-Id: <1079741620.1726.2.camel@mulgrave>
Mime-Version: 1.0
To: Andi Kleen <ak@suse.de>
Cc: davem@redhat.com, anton@samba.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Fri, 2004-03-19 at 16:05, Andi Kleen wrote:
> It is effectively disabled when you have ~3GB of memory, but when you have more
> and a 32bit only device it will be enabled for that.

Well, I suppose it's up to you to object if this error return switch
will cause an unacceptable risk of data corruption.  I'm with davem:
both the architectures I care about, voyager (no IOMMU) and parisc (huge
IOMMU space) aren't going to have a problem.

James
