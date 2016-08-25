From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 0/3 v3] kbuild changes, thin archives, --gc-sections
Date: Thu, 25 Aug 2016 12:56:44 +1000
Message-ID: <20160825125644.37cf118f@roar.ozlabs.ibm.com>
References: <1472041761-14414-1-git-send-email-npiggin@gmail.com>
        <12110.1472048481@warthog.procyon.org.uk>
        <alpine.LFD.2.20.1608241114430.17623@knanqh.ubzr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.20.1608241114430.17623@knanqh.ubzr>
Sender: linux-kbuild-owner@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: David Howells <dhowells@redhat.com>, Michal Marek <mmarek@suse.com>, linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>, Segher Boessenkool <segher@kernel.crashing.org>, Alan Modra <amodra@gmail.com>
List-Id: linux-arch.vger.kernel.org

On Wed, 24 Aug 2016 11:21:33 -0400 (EDT)
Nicolas Pitre <nicolas.pitre@linaro.org> wrote:

> On Wed, 24 Aug 2016, David Howells wrote:
> 
> > Out of interest, does using LTO also fix the problem?  
> 
> With those patches in place, that would be the next thing to try.
> Reducing our reliance on 'ld -r' will greatly help promoting LTO for the
> kernel.
> 
> Personally I'd like to have the choice between LTO and -gc-sections at 
> configure time.  They both have advantages of their own.


We discussed this in previous rounds of patches, but to just
expand on Nicolas' answer with some overview:

- Thin archives are needed for linking large kernels of some ISAs.
  I believe the linker becomes constrained in where it can use
  branch stubs when linking large inputs, but haven't looked into
  the internals exactly. There are a number of other ways proposed
  to solve it, but archives are well understood by toolchain and
  look like quite an elegant solution (with other benefits such as
  build output size and helping to enable LTO).

- gc-sections patch is mainly to address some small regressions
  in binary size with the first patch, but I think the results
  make it stand on its own. It's very fast, mature, does not
  transform code, and gives surprisingly good size saving without
  much enablement work. The work that is required (e.g., to
  annotate entry points) is mostly shared with LTO if we add that
  in future, so it's not dead-end cruft.

- LTO: Nicolas has posted far more significant size improvements
  with his more advanced work with reference annotatation and LTO.
  I'm surprised there has not been more interest, but I hope if
  we get this merged, it might give him motivation to look at it
  again. Discussion seemed to die down last time with people
  saying we should look at gc-sections first. 

I see this as enabler to LTO rather than a replacement. LTO is
bigger change to build and less mature, but long term it is the
right way to go IMO. When we iron out toolchains, perhaps have
LTO option for just static elimination rather than transformations
for high speed / low optimization builds, etc., then gc-sections
would be completely supplanted could be removed. Using sections
for dce is a nice linker hack, but real LTO information seems
cleaner in the end (and of course allows more optimization).

Thanks,
Nick
