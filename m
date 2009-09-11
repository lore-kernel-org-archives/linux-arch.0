From: Roland McGrath <roland@redhat.com>
Subject: Re: [PATCH 1/2] UNREACHABLE() macro
Date: Fri, 11 Sep 2009 14:55:25 -0700 (PDT)
Message-ID: <20090911215525.12B366A98F@magilla.sf.frob.com>
References: <20090910015923.8FB628AE5F@magilla.sf.frob.com>
	<20090910020031.87DC68BF6E@magilla.sf.frob.com>
	<20090911134528.cd1782d9.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1-old.redhat.com ([66.187.233.31]:60167 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752822AbZIKV4b (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 11 Sep 2009 17:56:31 -0400
In-Reply-To: Andrew Morton's message of  Friday, 11 September 2009 13:45:28 -0700 <20090911134528.cd1782d9.akpm@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: torvalds@linux-foundation.org, jakub@redhat.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org

> That's a bit of a mouthful.  Did you consider a runtime probe with
> scripts/Kbuild.include's try-run, cc-option, etc?  

I did not see any precedent in the sources for using those to test for
features by compiling particular test sources (i.e. in autoconf style).
I just followed the model I saw.  Those methods seem sufficiently costly
to make it a little questionable to pile on too many more that get
repeated all the time by make, so I just was not opening that can of worms.

As has been mentioned:

	#if __GNUC_MINOR__ > 4

is a sufficient test for the long run.  People using Fedora gcc-4.4 will
not mind applying a trivial kernel patch to get the benefits sooner.


Thanks,
Roland
