From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [RFC][PATCH] introduce ptr_diff()
Date: Thu, 19 Aug 2010 14:58:28 +0200
Message-ID: <20100819125828.GA6729@basil.fritz.box>
References: <1282217856-8625-1-git-send-email-namhyung@gmail.com>
 <87aaoiu6z6.fsf@basil.nowhere.org>
 <20100819124017.GI12892@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100819124017.GI12892@parisc-linux.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: Andi Kleen <andi@firstfloor.org>, Namhyung Kim <namhyung@gmail.com>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Thu, Aug 19, 2010 at 06:40:17AM -0600, Matthew Wilcox wrote:
> On Thu, Aug 19, 2010 at 02:23:09PM +0200, Andi Kleen wrote:
> > IMHO it would be better to simply disable the warning in sparse instead
> > of uglying the code just to work around sparse bogosity. It doesnt' seem
> > to make much sense. A subtraction followed by a shift is not expensive.
> 
> What makes you think it's a shift?  struct page isn't necessarily a
> power of two in size.  The original poster said "allyesconfig" which is
> going to add in KMEMCHECK and WANT_PAGE_DEBUG_FLAGS.  I think that makes
> it 76 bytes on x86-32, so sparse is right to warn.

These can be still implemented cheaply. Small constants generally are
The only thing that would be really expensive is division by unknown number.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only.
