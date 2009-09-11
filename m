From: Kyle McMartin <kyle@mcmartin.ca>
Subject: Re: [PATCH 1/2] UNREACHABLE() macro
Date: Fri, 11 Sep 2009 16:59:15 -0400
Message-ID: <20090911205915.GA19494@bombadil.infradead.org>
References: <20090910015923.8FB628AE5F@magilla.sf.frob.com> <20090910020031.87DC68BF6E@magilla.sf.frob.com> <20090911134528.cd1782d9.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755876AbZIKU7W@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20090911134528.cd1782d9.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Roland McGrath <roland@redhat.com>, torvalds@linux-foundation.org, jakub@redhat.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org
List-Id: linux-arch.vger.kernel.org

On Fri, Sep 11, 2009 at 01:45:28PM -0700, Andrew Morton wrote:
> On Wed,  9 Sep 2009 19:00:31 -0700 (PDT)
> Roland McGrath <roland@redhat.com> wrote:
> 
> > +/*
> > + * __builtin_unreachable is available in GCC 4.5+ and
> > + * also in Fedora/Red Hat GCC 4.4.1-10+.
> > + */
> > +#if (__GNUC_MINOR__ > 4					\
> > +     || (__GNUC_MINOR__ == 4				\
> > +	 && defined __GNUC_RH_RELEASE__			\
> > +	 && (__GNUC_PATCHLEVEL__ > 1			\
> > +	     || (__GNUC_PATCHLEVEL__ == 1		\
> > +		 && __GNUC_RH_RELEASE__ >= 10))))
> > +#define UNREACHABLE()		__builtin_unreachable()
> > +#endif
> 
> That's a bit of a mouthful.  Did you consider a runtime probe with
> scripts/Kbuild.include's try-run, cc-option, etc?  

If the crap for determining if it's a RH gcc is removed, then it becomes
really straightforward... Should probably just do that and then apply a
patch to Fedora if it's so damned important it can't just wait for the
next GCC release.

regards, Kyle
