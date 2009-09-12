From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH 1/2] UNREACHABLE() macro
Date: Sat, 12 Sep 2009 05:49:06 +0200
Message-ID: <20090912054906.22b05848@infradead.org>
References: <20090910015923.8FB628AE5F@magilla.sf.frob.com>
	<20090910020031.87DC68BF6E@magilla.sf.frob.com>
	<20090911134528.cd1782d9.akpm@linux-foundation.org>
	<20090911215525.12B366A98F@magilla.sf.frob.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:55171 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753018AbZILDpe (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 11 Sep 2009 23:45:34 -0400
In-Reply-To: <20090911215525.12B366A98F@magilla.sf.frob.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Roland McGrath <roland@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, torvalds@linux-foundation.org, jakub@redhat.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org

On Fri, 11 Sep 2009 14:55:25 -0700 (PDT)
Roland McGrath <roland@redhat.com> wrote:

> > That's a bit of a mouthful.  Did you consider a runtime probe with
> > scripts/Kbuild.include's try-run, cc-option, etc?  
> 
> I did not see any precedent in the sources for using those to test for
> features by compiling particular test sources (i.e. in autoconf

look at the stackprotector flags.. they work this way already.
It gets done once per kernel build...


-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
