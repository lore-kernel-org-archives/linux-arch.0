From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH 1/2] UNREACHABLE() macro
Date: Sat, 12 Sep 2009 07:30:38 +0200
Message-ID: <20090912073038.01eecacf@infradead.org>
References: <20090910015923.8FB628AE5F@magilla.sf.frob.com>
	<20090910020031.87DC68BF6E@magilla.sf.frob.com>
	<20090911134528.cd1782d9.akpm@linux-foundation.org>
	<20090911215525.12B366A98F@magilla.sf.frob.com>
	<20090912054906.22b05848@infradead.org>
	<4AAB26FE.7010309@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753646AbZILF1Z@vger.kernel.org>
In-Reply-To: <4AAB26FE.7010309@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Peter Anvin" <hpa@kernel.org>
Cc: Roland McGrath <roland@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, torvalds@linux-foundation.org, jakub@redhat.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org
List-Id: linux-arch.vger.kernel.org

On Fri, 11 Sep 2009 21:43:42 -0700
"H. Peter Anvin" <hpa@kernel.org> wrote:

> On 09/11/2009 08:49 PM, Arjan van de Ven wrote:
> > On Fri, 11 Sep 2009 14:55:25 -0700 (PDT)
> > Roland McGrath <roland@redhat.com> wrote:
> > 
> >>> That's a bit of a mouthful.  Did you consider a runtime probe with
> >>> scripts/Kbuild.include's try-run, cc-option, etc?  
> >>
> >> I did not see any precedent in the sources for using those to test
> >> for features by compiling particular test sources (i.e. in autoconf
> > 
> > look at the stackprotector flags.. they work this way already.
> > It gets done once per kernel build...
> > 
> 
> That works for flags, but not for the presence of builtin functions.
> You can't even just try compiling something, since it will turn into
> an ordinary function if not present... not obvious until link.

"-DGG_HAS_UNREACHABLE" is a compiler flag ;-)
and the shell script can just do a "nm" on the resulting .o file to
detect if it turned into a function call... entirely possible.


-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
