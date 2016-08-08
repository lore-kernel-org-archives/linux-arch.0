From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 1/5] kbuild: allow architectures to use thin archives
 instead of ld -r
Date: Mon, 8 Aug 2016 06:46:27 +0200
Message-ID: <20160808044627.GA12527@ravnborg.org>
References: <1470399123-8455-1-git-send-email-npiggin@gmail.com>
 <1470399123-8455-2-git-send-email-npiggin@gmail.com>
 <20160806201045.GA25821@ravnborg.org>
 <20160807114946.41b682f3@canb.auug.org.au>
 <20160807144054.GA14682@ravnborg.org>
 <20160808131941.27541a33@roar.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kbuild-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160808131941.27541a33@roar.ozlabs.ibm.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@linaro.org>, Segher Boessenkool <segher@kernel.crashing.org>, Alan Modra <amodra@gmail.com>
List-Id: linux-arch.vger.kernel.org

On Mon, Aug 08, 2016 at 01:19:41PM +1000, Nicholas Piggin wrote:
> On Sun, 7 Aug 2016 16:40:54 +0200
> Sam Ravnborg <sam@ravnborg.org> wrote:
> 
> > On Sun, Aug 07, 2016 at 11:49:46AM +1000, Stephen Rothwell wrote:
> > > Hi Sam,
> > > 
> > > On Sat, 6 Aug 2016 22:10:45 +0200 Sam Ravnborg <sam@ravnborg.org> wrote:  
> > > >
> > > > Did you by any chance evalue the use of INPUT in linker files.
> > > > Stephen back then (again based on proposal from Alan Modra),
> > > > also made an implementation using INPUT.  
> > > 
> > > The problem with that idea was that (at least for some versions of
> > > binutils in use at the time) we hit a static limit to the number of
> > > object files and ld just stopped at that point. :-(  
> > 
> > The ld bug was caused by opening too many linked definitions files.
> > We can workaround this by expanding the files.
> > I gave this a quick spin - see below.
> > 
> > Note - I have no idea if using thin archived or this method is better.
> > But it seems just wrong to me that we convert to thin archives when
> > we really do not need to do so.
> > 
> > Note - this was a quick spin. It build fine here and thats it.
> 
> Is there a reason to prefer using linker scripts rather than thin
> archives? I thought the former was possibly a bit less robust, and
> the latter a smaller change for scripts and toolchain in terms
> of "almost behaving like an object file".

The only valid reason I can come up with is that it is simpler
to build a list of .o files than it is to generate a number
of thin archives.

I persuaded "linker scripts" mainly because I had the patch floating
and I was triggered by the powerpc discussions to resurface it again.

> I don't have a strong preference although do have a couple of
> (out of tree) scripts that expect objdump to work on built-in.o

You are likely not alone here.
Unless someone else comes up with any good reason lets stay with
thin archives.

	Sam
