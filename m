Return-Path: <James.Bottomley@steeleye.com>
Received: from stat1.steeleye.com ([65.114.3.130]:5548 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S263118AbUCSQ5V (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 19 Mar 2004 11:57:21 -0500
Subject: Re: pci_map_single return value
From: James Bottomley <James.Bottomley@steeleye.com>
In-Reply-To: <20040319001448.GP28212@krispykreme>
References: <20031212155752.GD17683@krispykreme>
	<20031212175104.07dc8444.ak@suse.de> <20031212192131.GF17683@krispykreme>
	<20031213220444.4c526afa.davem@redhat.com>
	<20040102120121.GT28023@krispykreme> <20040102133454.22daa451.ak@suse.de>
	<20040319001448.GP28212@krispykreme>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: 19 Mar 2004 11:57:10 -0500
Message-Id: <1079715431.1732.18.camel@mulgrave>
Mime-Version: 1.0
To: Anton Blanchard <anton@samba.org>
Cc: Andi Kleen <ak@suse.de>, davem@redhat.com, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Thu, 2004-03-18 at 19:14, Anton Blanchard wrote:
> Better late than never. Andrew does this look OK to you?

Actually, there is a fundamental problem with this.  Today drivers
assume the system will panic if it runs out of mapping resources, so
very few of them actually check return values.

Unless someone is stepping up to fix *all* the drivers in the kernel,
then we need to cope with this for a while yet.

The way I'd thought of doing this was allowing drivers to advertise
compliance with the error handling API (probably via a flag in struct
device).  Those that say they handle errors, we return the error code. 
Unmodified drivers wouldn't have the flag, and thus we could still panic
for them before the system gets corrupted...

James
