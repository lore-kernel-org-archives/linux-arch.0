Return-Path: <akpm@osdl.org>
Received: from fw.osdl.org ([65.172.181.6]:17645 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261646AbUCSAz4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 18 Mar 2004 19:55:56 -0500
Date: Thu, 18 Mar 2004 16:55:50 -0800
From: Andrew Morton <akpm@osdl.org>
Subject: Re: pci_map_single return value
Message-Id: <20040318165550.3f5068b4.akpm@osdl.org>
In-Reply-To: <20040319001448.GP28212@krispykreme>
References: <20031212155752.GD17683@krispykreme>
	<20031212175104.07dc8444.ak@suse.de>
	<20031212192131.GF17683@krispykreme>
	<20031213220444.4c526afa.davem@redhat.com>
	<20040102120121.GT28023@krispykreme>
	<20040102133454.22daa451.ak@suse.de>
	<20040319001448.GP28212@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Anton Blanchard <anton@samba.org>
Cc: ak@suse.de, davem@redhat.com, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Anton Blanchard <anton@samba.org> wrote:
>
> > Another addition here:
>  > 
>  > Please note that the sg cannot be mapped again if it has been mapped once.
>  > The mapping process is allowed to destroy information in the sg.
>  > 
>  > [some drivers do this currently and it causes problems]
>  > 
>  > > +As with the other mapping interfaces, dma_map_sg can fail. When it
>  > > +does, 0 is returned and a driver should take appropriate action.
>  > 
>  > Please make this stronger. A block driver should definitely abort the
>  > request, otherwise you can kiss your super block good-bye.
> 
>  Better late than never. Andrew does this look OK to you?

Spose so.  Does this mean driver patches are on the way?
