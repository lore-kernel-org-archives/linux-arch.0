Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Fri, 25 Feb 2005 15:43:49 -0800
From: "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] set_pte() part 1 (was Re: [PATCH] ppc32: Wrong vaddr in
 flush_hash_one_pte())
Message-Id: <20050225154349.55427b8c.davem@davemloft.net>
In-Reply-To: <20050225132950.GA28014@linux-sh.org>
References: <1109145729.5412.213.camel@gaston>
	<20050223161138.00d8205f.davem@davemloft.net>
	<20050225132950.GA28014@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Fri, 25 Feb 2005 15:29:50 +0200
Paul Mundt <lethal@linux-sh.org> wrote:

> On Wed, Feb 23, 2005 at 04:11:38PM -0800, David S. Miller wrote:
> > I've been over this a few times this afternoon and the patch looks
> > correct.  Please test the build and boot of your platform, any build
> > failures should be trivial typos and nothing major.
> > 
> This works fine for sh and sh64 too.

Thanks for testing paul.
