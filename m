Return-Path: <davem@redhat.com>
Received: from mx1.redhat.com ([66.187.233.31]:24760 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263345AbUCSAlt (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 18 Mar 2004 19:41:49 -0500
Date: Thu, 18 Mar 2004 16:41:43 -0800
From: "David S. Miller" <davem@redhat.com>
Subject: Re: pci_map_single return value
Message-Id: <20040318164143.2cc398b3.davem@redhat.com>
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
Cc: ak@suse.de, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Fri, 19 Mar 2004 11:14:48 +1100
Anton Blanchard <anton@samba.org> wrote:

> Better late than never. Andrew does this look OK to you?
 ...
> Introduce dma_error() and pci_dma_error() which is used to detect
> failures in pci_map_single.

This looks fine to me.

We really need to backport the dma sync stuff and this (once integrated
to 2.6.x) into 2.4.x, probably when 2.4.27-pre1 opens up.
