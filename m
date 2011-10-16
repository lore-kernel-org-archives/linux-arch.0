From: David Rientjes <rientjes@google.com>
Subject: Re: Please include const-sections into linux-next
Date: Sat, 15 Oct 2011 17:53:23 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1110151752060.5728@chino.kir.corp.google.com>
References: <20111013233818.GB26654@one.firstfloor.org> <1318631204.3018.101.camel@dabdike.int.hansenpartnership.com> <alpine.DEB.2.00.1110151543220.25063@chino.kir.corp.google.com> <1318722567.7271.56.camel@dabdike.int.hansenpartnership.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1318722567.7271.56.camel@dabdike.int.hansenpartnership.com>
Sender: linux-kernel-owner@vger.kernel.org
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Andi Kleen <andi@firstfloor.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Sat, 15 Oct 2011, James Bottomley wrote:

> I think it's probably a compiler bug.  gcc isn't as adept with section
> annotations as people think it is.  This tends to manifest in the
> non-x86 toolchains because we tend to be using earlier versions.
> 

It compiles fine with my cross-compiler using gcc-4.5.1.
