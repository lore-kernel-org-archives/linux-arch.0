From: William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: Re: [RESEND PATCH v4 3/8] gpio: 104-dio-48e: Utilize
 for_each_set_clump macro
Date: Wed, 17 Oct 2018 10:54:02 +0900
Message-ID: <20181017015402.GA3307@icarus>
References: <cover.1538441919.git.vilhelm.gray@gmail.com>
 <5906381114b14d5b0359510a1d23accbd239eaa5.1538441919.git.vilhelm.gray@gmail.com>
 <822be05b-092b-41c2-3c31-8981acd5cb9e@rasmusvillemoes.dk>
 <20181014041933.GA7335@icarus>
 <afbe5c62-f003-ca92-d185-8e6e9340c75d@rasmusvillemoes.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <afbe5c62-f003-ca92-d185-8e6e9340c75d@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: linus.walleij@linaro.org, akpm@linux-foundation.org, linux-gpio@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com
List-Id: linux-arch.vger.kernel.org

On Mon, Oct 15, 2018 at 01:59:33PM +0200, Rasmus Villemoes wrote:
> On 2018-10-14 06:19, William Breathitt Gray wrote:
> 
> > a bit value of 0 in the
> > bits array does not necessarily mean the input was not requested, but
> > may instead mean that the value at the input is 0;
> 
> sure enough, but...
> 
> > therefore, the caller
> > must keep track of the requested inputs rather than try to deduce them
> > from the values in the bits array.
> 
> ...I don't agree that this logically follows. A caller might reasonably
> expect not to find any bits set in positions other than those in mask. A
> simple example would be caller that just tried to ask "are any of
> _these_ inputs set"; it would be reasonable to implement that using
> bitmap_empty() on the returned bitset, without first having to mask by
> the mask he passed in.
> 
> Rasmus

I see your point. It would be good to keep the behavior consistent with
what would be expected by the user -- and adding an additional AND
operation at the end to mask away the unrequested bits should not really
affect the performance to a discernible degree -- so I'll submit a
patchset implementing the mask for these drivers some time this weekend.

William Breathitt Gray
