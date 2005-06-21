Return-Path: <linux-arch-owner@vger.kernel.org>
Message-ID: <42B83771.1050304@shadowen.org>
Date: Tue, 21 Jun 2005 16:51:13 +0100
From: Andy Whitcroft <apw@shadowen.org>
MIME-Version: 1.0
Subject: Re: sparsemem patches in -mm
References: <20050621021352.46fc3b81.akpm@osdl.org> <20050621141755.GX11655@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20050621141755.GX11655@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Matthew Wilcox <matthew@wil.cx>
Cc: Andrew Morton <akpm@osdl.org>, linux-arch@vger.kernel.org, Dave Hansen <haveblue@us.ibm.com>, Matt Tolentino <matthew.e.tolentino@intel.com>, Bob Picco <bob.picco@hp.com>
List-ID: <linux-arch.vger.kernel.org>

Matthew Wilcox wrote:
> On Tue, Jun 21, 2005 at 02:13:52AM -0700, Andrew Morton wrote:
> 
>>Could I ask the arch maintainers to review the `sparsemem' patches from -mm,
>>please, if you haven't done so...
>>
>>They're all in http://www.zip.com.au/~akpm/linux/patches/stuff/sparsemem/
> 
> 
> Pretty confusing.  All kinds of options added, removed, modified, put
> back ...  let's merge it, then see how it looks.  Maybe we'll switch
> parisc from discontigmem to sparsemem.

Would it make sense for me to take the current pile of patches in -mm
and merge the fixes into the appropriate main patches to make a
consolidated patch set?  If we want to do that I am happy to put the
effort in.

-apw
