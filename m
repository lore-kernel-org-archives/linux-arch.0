Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Thu, 10 Mar 2005 14:33:14 +0000
From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: no-arch-specific-mem_map-init
Message-ID: <20050310143314.GH21986@parcelfarce.linux.theplanet.co.uk>
References: <20050310141804.GF21986@parcelfarce.linux.theplanet.co.uk> <20050309225833.6d80fc42.akpm@osdl.org> <14917.1110465046@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14917.1110465046@redhat.com>
Sender: <willy@www.linux.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: Matthew Wilcox <matthew@wil.cx>, Andrew Morton <akpm@osdl.org>, linux-arch@vger.kernel.org, Dave Hansen <haveblue@us.ibm.com>, Randolph Chung <randolph@tausq.org>
List-ID: <linux-arch.vger.kernel.org>

On Thu, Mar 10, 2005 at 02:30:46PM +0000, David Howells wrote:
> Matthew Wilcox <matthew@wil.cx> wrote:
> 
> > 
> > Something that may not be intuitively obvious to someone with i386 biases
> > is that on PA-RISC (at least in the case of CONFIG_DISCONTIGMEM=n), all
> > memory is in ZONE_DMA.  Does that help divine what the right answer is
> > for parisc?
> 
> It's probably assuming that since ZONE_DMA is zone 0, the DMA capable zone is
> at the bottom of any chunk of memory (node).

Oh, and we don't currently support any of the NUMA PA-RISC boxes, so
there's only the one node ...

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
