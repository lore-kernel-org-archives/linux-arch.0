Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 21 Jun 2005 15:17:55 +0100
From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: sparsemem patches in -mm
Message-ID: <20050621141755.GX11655@parcelfarce.linux.theplanet.co.uk>
References: <20050621021352.46fc3b81.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050621021352.46fc3b81.akpm@osdl.org>
Sender: <willy@www.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-arch@vger.kernel.org, Andy Whitcroft <apw@shadowen.org>, Dave Hansen <haveblue@us.ibm.com>, Matt Tolentino <matthew.e.tolentino@intel.com>, Bob Picco <bob.picco@hp.com>
List-ID: <linux-arch.vger.kernel.org>

On Tue, Jun 21, 2005 at 02:13:52AM -0700, Andrew Morton wrote:
> 
> Could I ask the arch maintainers to review the `sparsemem' patches from -mm,
> please, if you haven't done so...
> 
> They're all in http://www.zip.com.au/~akpm/linux/patches/stuff/sparsemem/

Pretty confusing.  All kinds of options added, removed, modified, put
back ...  let's merge it, then see how it looks.  Maybe we'll switch
parisc from discontigmem to sparsemem.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
