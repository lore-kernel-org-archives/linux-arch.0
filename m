Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Fri, 17 Jun 2005 02:15:26 -0700
From: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: Global spinlock vs local bit spin locks
Message-ID: <20050617091526.GH3913@holomorphy.com>
References: <1118982092.5261.44.camel@npiggin-nld.site> <20050617044611.GF3913@holomorphy.com> <42B28B44.9090606@yahoo.com.au> <20050617085426.GK31127@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050617085426.GK31127@wotan.suse.de>
To: Andi Kleen <ak@suse.de>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, "David S. Miller" <davem@davemloft.net>, anton@samba.org, linux-arch@vger.kernel.org, Andrew Morton <akpm@osdl.org>, Peter Keilty <Peter.Keilty@hp.com>
List-ID: <linux-arch.vger.kernel.org>

>> As far as page flags go - I agree but I didn't want to use one up.
>> This is very localised and I don't think it is particularly worse
>> than what was there before, so I think we can get away with it for
>> the moment.

On Fri, Jun 17, 2005 at 10:54:26AM +0200, Andi Kleen wrote:
> I'm starting to think that we need different strategies on 32bit
> and 64bit here. 64bit has plenty of bits left; it is just 32bit
> that is a problem here.

Well, there are 3 bits destined to die as things stand now (2 swsusp
via sideband bitmaps and PG_reserved) so the immediate 32-bit shortage
does have a resolution in sight.


-- wli
