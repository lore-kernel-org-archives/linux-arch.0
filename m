From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] kbuild: provide THIN_ARCHIVES option for all
 architectures
Date: Tue, 30 May 2017 09:13:43 +1000
Message-ID: <20170530091343.1f98b24b@roar.ozlabs.ibm.com>
References: <20170529081103.29999-1-npiggin@gmail.com>
        <CA+55aFyM8c1h7S+x95qvv84jphu9=XSXZop=gVp7xc5tf3JJMQ@mail.gmail.com>
        <CA+55aFwofV0DZhh+yGH_=ceBzFcSr_tGexuGV4Wioao096R-uQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <CA+55aFwofV0DZhh+yGH_=ceBzFcSr_tGexuGV4Wioao096R-uQ@mail.gmail.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: linux-arch.vger.kernel.org

On Mon, 29 May 2017 10:14:50 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, May 29, 2017 at 10:03 AM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > So either thin archives work or they don't. Don't make it some painful
> > drawn-out process that actually makes it harder to test rather than
> > easier.  
>
> Side note: what would make them not work? Are there known bugs in 'ar'
> wrt thin archives, versioning issues, or other issues?

We haven't run into any bugs AFAIK. It's been pretty solid.

*thin* archives does require binutils 2.19. That's nearly 10 years
old, but we advertise 2.12 minimum at the moment. We'd have make "T"
an optional argument if we turn it on unconditionally. Regular
archives shouldn't be significantly worse than ld -r though, so yeah
maybe we could do that.

powerpc required a build fix:

43c9127d94d

-override AR    := GNUTARGET=elf$(BITS)-$(GNUTARGET) $(AR)
+KBUILD_ARFLAGS += --target=elf$(BITS)-$(GNUTARGET)

So there could be a couple of small things like this.

Thanks,
Nick
