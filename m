From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: 64-syscall args on 32-bit vs syscall()
Date: Thu, 18 Mar 2010 09:58:40 +1100
Message-ID: <1268866720.2335.204.camel@pasglop>
References: <20100315134449.GB1653@linux-mips.org>
	 <4B9E4EB1.9010800@zytor.com>	<4B9E59B7.6060405@redhat.com>
	 <20100315.120004.209998642.davem@davemloft.net>
	 <4B9E8D67.8040209@zytor.com>  <1268685311.2335.38.camel@pasglop>
	 <1268776570.19726.98.camel@spokane1.rchland.ibm.com>
	 <1268785874.2335.137.camel@pasglop>  <4BA06E1B.2040706@redhat.com>
	 <1268816179.2335.187.camel@pasglop>  <4BA11FD2.2090104@zytor.com>
	 <1268858134.2335.198.camel@pasglop>  <4BA1412C.6070008@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4BA1412C.6070008@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ulrich Drepper <drepper@redhat.com>, munroesj@us.ibm.com, David Miller <davem@davemloft.net>, ralf@linux-mips.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@teksavvy.com, torvalds@linux-foundation.org
List-Id: linux-arch.vger.kernel.org

On Wed, 2010-03-17 at 13:53 -0700, H. Peter Anvin wrote:
> > Yeah, whatever, I don't mind what technique you use for the
> versionning,
> > ultimately, if the approach works, we can look at those details :-)
> We
> > -do- need the macro to strip the dummy argument though, unless we
> use
> > a slightly different technique which is to make the __sysno argument
> > itself 64-bit, which works as well I believe.
> >
> 
> It seems cleaner to do it that way (with a 64-bit sysno arg.) 

Right. Now if we can get Ulrich to actually put 2 and 2 together and
admit that it actually works without breaking anything existing (at
least for my arch but I wouldn't be surprised if that was the case for
others), I would be even happier :-)

Steve, any chance you can cook up a glibc patch to test with ? Maybe
making it powerpc specific for now ?

Cheers,
Ben.
