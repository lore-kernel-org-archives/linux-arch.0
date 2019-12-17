From: Will Deacon <will@kernel.org>
Subject: Re: READ_ONCE() + STACKPROTECTOR_STRONG == :/ (was Re: [GIT PULL]
 Please pull powerpc/linux.git powerpc-5.5-2 tag (topic/kasan-bitops))
Date: Tue, 17 Dec 2019 17:07:19 +0000
Message-ID: <20191217170719.GA869@willie-the-truck>
References: <20191212100756.GA11317@willie-the-truck>
 <20191212104610.GW2827@hirez.programming.kicks-ass.net>
 <CAHk-=wjUBsH0BYDBv=q36482G-U7c=9bC89L_BViSciTfb8fhA@mail.gmail.com>
 <20191212180634.GA19020@willie-the-truck>
 <CAHk-=whRxB0adkz+V7SQC8Ac_rr_YfaPY8M2mFDfJP2FFBNz8A@mail.gmail.com>
 <20191212193401.GB19020@willie-the-truck>
 <CAHk-=wiMuHmWzQ7-CRQB6o+SHtA-u-Rp6VZwPcqDbjAaug80rQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHk-=wiMuHmWzQ7-CRQB6o+SHtA-u-Rp6VZwPcqDbjAaug80rQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>, dja@axtens.net, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org, Christophe Leroy <christophe.leroy@c-s.fr>, linux-arch <linux-arch@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Segher Boessenkool <segher@kernel.crashing.org>, Arnd Bergmann <arnd@arndb.de>, Christian Borntraeger <borntraeger@de.ibm.com>
List-Id: linux-arch.vger.kernel.org

On Thu, Dec 12, 2019 at 12:49:52PM -0800, Linus Torvalds wrote:
> On Thu, Dec 12, 2019 at 11:34 AM Will Deacon <will@kernel.org> wrote:
> >
> > The root of my concern in all of this, and what started me looking at it in
> > the first place, is the interaction with 'typeof()'. Inheriting 'volatile'
> > for a pointer means that local variables in macros declared using typeof()
> > suddenly start generating *hideous* code, particularly when pointless stack
> > spills get stackprotector all excited.
> 
> Yeah, removing volatile can be a bit annoying.
> 
> For the particular case of the bitops, though, it's not an issue.
> Since you know the type there, you can just cast it.
> 
> And if we had the rule that READ_ONCE() was an arithmetic type, you could do
> 
>     typeof(0+(*p)) __var;
> 
> since you might as well get the integer promotion anyway (on the
> non-volatile result).
> 
> But that doesn't work with structures or unions, of course.
> 
> I'm not entirely sure we have READ_ONCE() with a struct. I do know we
> have it with 64-bit entities on 32-bit machines, but that's ok with
> the "0+" trick.

Other than the two trivial examples Arnd and I spotted, it looks like
we're in for some fun with the page-table types such as pud_t but that
/should/ be fixable with enough effort.

However, I'm really banging my head against the compiler trying to get
your trick above to work for pointer types when the pointed-to-type is
not defined. As a very cut down example (I pulled this back out of the
preprocessor and cleaned it up a bit):


struct dentry {
	struct inode *d_inode;
};

static inline struct inode *d_inode_rcu(struct dentry *dentry)
{
	return ({
		typeof(0 + dentry->d_inode) __x = (*(volatile typeof(dentry->d_inode) *)&(dentry->d_inode));
		(typeof(dentry->d_inode))__x;
	});
}


Trying to compile this results in:

  | In function 'd_inode_rcu':
  | error: invalid use of undefined type 'struct inode'

whereas it compiles fine if you remove the '0 +' from the first typeof.

What am I missing? Perhaps the compiler wants the size information of
'struct inode' before it will contemplate the arithmetic, but if so then
I don't think we can use this trick after all. Hmm.

Will
