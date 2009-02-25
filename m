From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 00/15] bitops: Change bitmap index from int to unsigned
 long
Date: Wed, 25 Feb 2009 16:46:00 +0100
Message-ID: <1235576760.4645.3535.camel@laptop>
References: <200902250441.UAA12527@hpdst41.cup.hp.com>
	 <1235544888.4645.2942.camel@laptop>
	 <20090225153757.GP16891@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760483AbZBYPqg@vger.kernel.org>
In-Reply-To: <20090225153757.GP16891@parisc-linux.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: Justin Chen <jchen@hpdst41.cup.hp.com>, linux-arch@vger.kernel.org, bjorn.helgaas@hp.com, justin.chen@hp.com, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Wed, 2009-02-25 at 08:37 -0700, Matthew Wilcox wrote:
> On Wed, Feb 25, 2009 at 07:54:48AM +0100, Peter Zijlstra wrote:
> > unsigned int wasn't large enough?
> 
> Adding one more bit only doubles the maximum size.  That buys us, what,
> another eighteen months until we have to change it again?  Unsigned long
> seems most sensible to me.  Unsigned long long probably isn't worth
> doing -- you'd have to be using one eighth of your address space on a
> single bitmap.

Are you serious? Bitmaps of length 4G-bit (512M-byte) are way past the
sanely allocatable size anyway.

The complaint was that the signed thingy resulted in out of bounds
pointers (apparently unsigned doesn't?)
