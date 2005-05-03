Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 3 May 2005 13:11:26 +1000
From: Anton Blanchard <anton@samba.org>
Subject: Re: iomap interface issue
Message-ID: <20050503031126.GF12682@krispykreme>
References: <20050503004756.GB12682@krispykreme> <20050502192617.7698f052.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050502192617.7698f052.davem@davemloft.net>
To: "David S. Miller" <davem@davemloft.net>
Cc: torvalds@osdl.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


> If anything, a pointer to the resource would be more appropriate.

Perhaps, although that would mean pci_iomap takes a BAR and pci_iounmap
takes a resource.

Anton
