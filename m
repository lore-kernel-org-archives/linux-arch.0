Return-Path: <linux-arch-owner@vger.kernel.org>
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20050310141804.GF21986@parcelfarce.linux.theplanet.co.uk> 
References: <20050310141804.GF21986@parcelfarce.linux.theplanet.co.uk>  <20050309225833.6d80fc42.akpm@osdl.org> 
Subject: Re: no-arch-specific-mem_map-init 
Date: Thu, 10 Mar 2005 14:30:46 +0000
Message-ID: <14917.1110465046@redhat.com>
Sender: dhowells@redhat.com
To: Matthew Wilcox <matthew@wil.cx>
Cc: Andrew Morton <akpm@osdl.org>, linux-arch@vger.kernel.org, Dave Hansen <haveblue@us.ibm.com>, Randolph Chung <randolph@tausq.org>
List-ID: <linux-arch.vger.kernel.org>

Matthew Wilcox <matthew@wil.cx> wrote:

> 
> Something that may not be intuitively obvious to someone with i386 biases
> is that on PA-RISC (at least in the case of CONFIG_DISCONTIGMEM=n), all
> memory is in ZONE_DMA.  Does that help divine what the right answer is
> for parisc?

It's probably assuming that since ZONE_DMA is zone 0, the DMA capable zone is
at the bottom of any chunk of memory (node).

David
