Return-Path: <James.Bottomley@steeleye.com>
Received: from stat1.steeleye.com ([65.114.3.130]:64420 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262728AbUCSOQk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 19 Mar 2004 09:16:40 -0500
Subject: Re: pci_map_single return value
From: James Bottomley <James.Bottomley@steeleye.com>
In-Reply-To: <20040319013720.GQ28212@krispykreme>
References: <20031212155752.GD17683@krispykreme>
	<20031212175104.07dc8444.ak@suse.de> <20031212192131.GF17683@krispykreme>
	<20031213220444.4c526afa.davem@redhat.com>
	<20040102120121.GT28023@krispykreme> <20040102133454.22daa451.ak@suse.de>
	<20040319001448.GP28212@krispykreme>
	<20040318165550.3f5068b4.akpm@osdl.org>
	<20040319013720.GQ28212@krispykreme>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: 19 Mar 2004 09:16:19 -0500
Message-Id: <1079705779.1963.8.camel@mulgrave>
Mime-Version: 1.0
To: Anton Blanchard <anton@samba.org>
Cc: Andrew Morton <akpm@osdl.org>, ak@suse.de, davem@redhat.com, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Thu, 2004-03-18 at 20:37, Anton Blanchard wrote:
> Thats the plan. The IPR, ibmvscsi and emulex drivers already have hacks
> in them to do this in an arch specific way. None of those drivers are
> merged yet, although the IPR and ibmvscsi is close.

I already warned the ibmvscsi person about this.  I can hold it up until
it does things properly.

James
