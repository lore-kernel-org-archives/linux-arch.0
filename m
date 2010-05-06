From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: kbuild: fixing the select problem
Date: Thu, 06 May 2010 09:17:24 -0400
Message-ID: <1273151844.23208.48.camel@mulgrave.site>
References: <1273096160.23208.35.camel@mulgrave.site>
	 <p2x10f740e81005052347x9430657fua98b8982e860bd2d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <p2x10f740e81005052347x9430657fua98b8982e860bd2d@mail.gmail.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-arch@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, Sam Ravnborg <sam@ravnborg.org>, linux-kbuild@vger.kernel.org, Randy Dunlap <randy.dunlap@oracle.com>
List-Id: linux-arch.vger.kernel.org

On Thu, 2010-05-06 at 08:47 +0200, Geert Uytterhoeven wrote:
> On Wed, May 5, 2010 at 23:49, James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> > [Sam: I know you don't maintain kbuild anymore, but since you have the
> > most experience, if you could find time to comment, I'd be grateful]
> >
> > The select problem is that the kbuild select directive will turn a
> > symbol on without reference to its dependencies.  This, in turn, means
> > that either selected symbols must select their dependencies, or that
> > people using select have to be aware of the selected symbol's dependency
> > and build those dependencies into their symbol (leading to duplication
> > and the possibility of getting the dependencies out of sync).  We use
> > select for the scsi transport classes, so we run into this problem in
> > SCSI quite a lot.
> >
> > I think the correct fix is to make a symbol that selects another symbol
> > automatically inherit all of the selected symbol's dependencies.
> 
> What if there's a good reason the selected symbol has this dependency?
> E.g. it depends on a critical feature not available? Like CONFIG_HAS_IOMEM?

I don't quite understand the question.  If a selected symbol has a
critical dependency which is config'd to N then the build usually
breaks ... that's what I'm calling the select problem.  I thought
CONFIG_HAS_IOMEM was usually selected by the architecture, though.  In
the new proposal, we wouldn't be able to generate the invalid
configuration in the first place.

James


