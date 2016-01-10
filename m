Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay0025.hostedemail.com ([216.40.44.25]:41511 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756833AbcAJPIp (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sun, 10 Jan 2016 10:08:45 -0500
Message-ID: <1452438519.7773.23.camel@perches.com>
Subject: Re: [PATCH v2 2/3] checkpatch: check for __smp outside barrier.h
From: Joe Perches <joe@perches.com>
Date: Sun, 10 Jan 2016 07:08:39 -0800
In-Reply-To: <1452427000-4520-3-git-send-email-mst@redhat.com>
References: <1452427000-4520-1-git-send-email-mst@redhat.com>
	 <1452427000-4520-3-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: Andy Whitcroft <apw@canonical.com>, Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>, virtualization@lists.linux-foundation.org, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, David Miller <davem@davemloft.net>, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-metag@vger.kernel.org, linux-mips@linux-mips.org, x86@kernel.org, user-mode-linux-devel@lists.sourceforge.net, adi-buildroot-devel@lists.sourceforge.net, linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org, xen-devel@lists.xenproject.org, Ingo Molnar <mingo@kernel.org>, Tony Lindgren <tony@atomide.com>, Andrey Konovalov <andreyknvl@google.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Message-ID: <20160110150839.xryVAxlcS9vMQNIxorlfZ3To-J4xGmnyawFz0x5iElM@z>

On Sun, 2016-01-10 at 13:57 +0200, Michael S. Tsirkin wrote:
> Introduction of __smp barriers cleans up a bunch of duplicate code, but
> it gives people an additional handle onto a "new" set of barriers - just
> because they're prefixed with __* unfortunately doesn't stop anyone from
> using it (as happened with other arch stuff before.)
> 
> Add a checkpatch test so it will trigger a warning.
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -5141,6 +5141,16 @@ sub process {
>  			}
>  		}
>  
> +		my $underscore_smp_barriers = qr{__smp_($smp_barriers)}x;

another unnecessary capture group

> +
> +		if ($realfile !~ m@^include/asm-generic/@ &&
> +		    $realfile !~ m@/barrier\.h$@ &&
> +		    $line =~ m/\b($underscore_smp_barriers)\s*\(/ &&
> +		    $line !~ m/^.\s*\#\s*define\s+($underscore_smp_barriers)\s*\(/) {
> +			WARN("MEMORY_BARRIER",
> +			     "__smp memory barriers shouldn't be used outside barrier.h and asm-generic\n" . $herecurr);
> +		}
> +
>  # check for waitqueue_active without a comment.
>  		if ($line =~ /\bwaitqueue_active\s*\(/) {
>  			if (!ctx_has_comment($first_line, $linenr)) {

