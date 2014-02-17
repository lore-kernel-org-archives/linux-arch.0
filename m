Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-am1lp0017.outbound.protection.outlook.com ([213.199.154.17]:30765
	"EHLO emea01-am1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751435AbaBQXZG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 17 Feb 2014 18:25:06 -0500
Message-ID: <530296CD.5050503@warwick.ac.uk>
Date: Mon, 17 Feb 2014 23:10:05 +0000
From: Alec Teal <a.teal@warwick.ac.uk>
MIME-Version: 1.0
Subject: Re: [RFC][PATCH 0/5] arch: atomic rework
References: <20140207180216.GP4250@linux.vnet.ibm.com> <1391992071.18779.99.camel@triegel.csb> <CA+55aFwTwCPMpYTL_vCgNNP0hE8s2sgB0iw-79=xoj99V0JUNA@mail.gmail.com> <1392183564.18779.2187.camel@triegel.csb> <20140212180739.GB4250@linux.vnet.ibm.com> <CA+55aFw3S82GYdtnV2nJCvBGcuZf6kXdF5b7Vp9yb21QKr49Jw@mail.gmail.com> <20140213002355.GI4250@linux.vnet.ibm.com> <1392321837.18779.3249.camel@triegel.csb> <20140214020144.GO4250@linux.vnet.ibm.com> <1392352981.18779.3800.camel@triegel.csb> <20140214172920.GQ4250@linux.vnet.ibm.com> <CA+55aFx9CbgrfK4rBVYD75y2KoWiO90dSYsAW83O-tYVLK-gkg@mail.gmail.com> <CA+55aFypfiTFwundih8QEA6ZwVGk=g5L4sabsN0932eih5knOQ@mail.gmail.com> <1392486310.18779.6447.camel@triegel.csb> <CA+55aFwTrt_6m1inNHQkk74i7uPkHNnacwHiBgioZSXieAs5Sw@mail.gmail.com> <1392666947.18779.6838.camel@triegel.csb> <CA+55aFwUnRVk6q3VZeYjWfduoHcExW=Pht6jgp=4bBSaLHNPMA@mail.gmail.com>
In-Reply-To: <CA+55aFwUnRVk6q3VZeYjWfduoHcExW=Pht6jgp=4bBSaLHNPMA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Torvald Riegel <triegel@redhat.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Will Deacon <will.deacon@arm.com>, Peter Zijlstra <peterz@infradead.org>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, David Howells <dhowells@redhat.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "mingo@kernel.org" <mingo@kernel.org>, "gcc@gcc.gnu.org" <gcc@gcc.gnu.org>
Message-ID: <20140217231005.5TDzv50XRFFPATjTAan1UKUbhYGdw3fAL80ga2jlogQ@z>

On 17/02/14 20:18, Linus Torvalds wrote:
> On Mon, Feb 17, 2014 at 11:55 AM, Torvald Riegel<triegel@redhat.com>  wrote:
>> Which example do you have in mind here?  Haven't we resolved all the
>> debated examples, or did I miss any?
> Well, Paul seems to still think that the standard possibly allows
> speculative writes or possibly value speculation in ways that break
> the hardware-guaranteed orderings.
>
> And personally, I can't read standards paperwork. It is invariably
Can't => Don't - evidently.
> written in some basically impossible-to-understand lawyeristic mode,
You mean "unambiguous" - try reading a patent (Apple have 1000s of 
trivial ones, I tried reading one once thinking "how could they have 
phrased it so this got approved", their technique was to make the reader 
want to start cutting themselves to prove they wern't numb to everything)
> and then it is read by people (compiler writers) that intentionally
> try to mis-use the words and do language-lawyering ("that depends on
> what the meaning of 'is' is"). The whole "lvalue vs rvalue expression
> vs 'what is a volatile access'" thing for C++ was/is a great example
> of that.
I'm not going to teach you what rvalues and lvalues, but! 
http://lmgtfy.com/?q=what+are+rvalues might help.
>
> So quite frankly, as a result I refuse to have anything to do with the
> process directly.
Is this goodbye?
>
>                   Linus
That aside, what is the problem? If the compiler has created code that 
that has different program states than what would be created without 
optimisation please file a bug report and/or send something to the 
mailing list USING A CIVIL TONE, there's no need for swear-words and 
profanities all the time - use them when you want to emphasise 
something. Additionally if you are always angry, start calling that 
state "normal" then reserve such words for when you are outraged.

There are so many emails from you bitching about stuff, I've lost track 
of what you're bitching about you bitch that much about it. Like this 
standards stuff above (notice I said stuff, not "crap" or "shit").

What exactly is your problem, if the compiler is doing something the 
standard does not permit, or optimising something wrongly (read: "puts 
the program in a different state than if the optimisation was not 
applied") that is REALLY serious, you are right to report it; but 
whining like a n00b on Stack-overflow when a question gets closed is not 
helping.

I tried reading back though the emails (I dismissed them previously) but 
there's just so much ranting, and rants about the standard too (I would 
trash this if I deemed the effort required to delete was less than the 
storage of the bytes the message takes up) standardised behaviour is 
VERY important.

So start again, what is the serious problem, have you got any code that 
would let me replicate it, what is your version of GCC?

Oh and lastly! Optimisations are not as casual as "oh, we could do this 
and it'd work better" unlike kernel work or any other software that is 
being improved, it is very formal (and rightfully so). I seriously 
recommend you read the first 40 pages at least of a book called 
"Compiler Design, Analysis and Transformation" it's not about the 
parsing phases or anything, but it develops a good introduction and 
later a good foundation for exploring the field further. Compilers do 
not operate on what I call "A-level logic" and to show what I mean I use 
the shovel-to-the-face of real analysis, "of course 1/x tends towards 0, 
it's not gonna be 5!!" = A-level logic. "Let epsilon > 0 be given, then 
there exists an N...." - formal proof. So when one says "the compiler 
can prove" it's not some silly thing powered by A-level logic, it is the 
implementation of something that can be proven to be correct (in the 
sense of the program states mentioned before)

So yeah, calm down and explain - no lashing out at standards bodies, 
what is the problem?

Alec
