Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39245 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756609AbcAJTNw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 10 Jan 2016 14:13:52 -0500
Date: Sun, 10 Jan 2016 21:13:38 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 1/3] checkpatch.pl: add missing memory barriers
Message-ID: <20160110191338.GA5063@redhat.com>
References: <1452427000-4520-1-git-send-email-mst@redhat.com>
 <1452427000-4520-2-git-send-email-mst@redhat.com>
 <1452438425.7773.21.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1452438425.7773.21.camel@perches.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Joe Perches <joe@perches.com>
Cc: linux-kernel@vger.kernel.org, Andy Whitcroft <apw@canonical.com>, Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>, virtualization@lists.linux-foundation.org, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, David Miller <davem@davemloft.net>, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-metag@vger.kernel.org, linux-mips@linux-mips.org, x86@kernel.org, user-mode-linux-devel@lists.sourceforge.net, adi-buildroot-devel@lists.sourceforge.net, linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org, xen-devel@lists.xenproject.org, Ingo Molnar <mingo@kernel.org>, Tony Lindgren <tony@atomide.com>, Andrey Konovalov <andreyknvl@google.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Message-ID: <20160110191338.Mg7XwO9zk4tp3KptRVbZFeKM-FI5PdFJJI-GdW6o9JQ@z>

On Sun, Jan 10, 2016 at 07:07:05AM -0800, Joe Perches wrote:
> On Sun, 2016-01-10 at 13:56 +0200, Michael S. Tsirkin wrote:
> > SMP-only barriers were missing in checkpatch.pl
> > 
> > Refactor code slightly to make adding more variants easier.
> []
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
> > @@ -5116,7 +5116,25 @@ sub process {
> >  			}
> >  		}
> >  # check for memory barriers without a comment.
> > -		if ($line =~ /\b(mb|rmb|wmb|read_barrier_depends|smp_mb|smp_rmb|smp_wmb|smp_read_barrier_depends)\(/) {
> > +
> > +		my $barriers = qr{
> > +			mb|
> > +			rmb|
> > +			wmb|
> > +			read_barrier_depends
> > +		}x;
> > +		my $smp_barriers = qr{
> > +			store_release|
> > +			load_acquire|
> > +			store_mb|
> > +			($barriers)
> > +		}x;
> 
> If I use a variable called $smp_barriers, I'd expect
> it to actually be the smp_barriers, not to have to
> prefix it with smp_ before using it.
> 
> 		my $smp_barriers = qr{
> 			smp_store_release|
> 			smp_load_acquire|
> 			smp_store_mb|
> 			smp_read_barrier_depends
> 		}x;
> 
> or
> 
> 		my $smp_barriers = qr{
> 			smp_(?:store_release|load_acquire|store_mb|read_barrier_depends)
> 		}x;
> 

Yes but virt barriers (added in patch 3) are same things but prefixed
with virt_.  So we need the stems without smp_ prefix. If smp_barriers is
too confusing we'll just need to give them some other name.
How about:
my $smp_barrier_stems

?

> > +		my $all_barriers = qr{
> > +			$barriers|
> > +			smp_($smp_barriers)
> > +		}x;
> 
> And this shouldn't have a capture group.
> 
> 		my $all_barriers = qr{
> 			$barriers|
> 			$smp_barriers
> 		}x;		
> > +
> > +		if ($line =~ /\b($all_barriers)\s*\(/) {
> 
> This doesn't need the capture group either (?:all_barriers)
> 
> >  			if (!ctx_has_comment($first_line, $linenr))
> > {
> >  				WARN("MEMORY_BARRIER",
> >  				     "memory barrier without
> > comment\n" . $herecurr);
