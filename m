Return-Path: <linux-arch-owner@vger.kernel.org>
Message-Id: <1115288796.27463.233424874@webmail.messagingengine.com>
From: "Deepak" <deepakgaur@fastmail.fm>
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="ISO-8859-1"
MIME-Version: 1.0
References: <1115185972.13333.233322686@webmail.messagingengine.com>
   <1115278545.7628.180.camel@gaston>
Subject: Re: Real Time Signals In PowerPC Linux
In-Reply-To: <1115278545.7628.180.camel@gaston>
Date: Thu, 05 May 2005 19:26:36 +0900
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

hi

  Well I did "kill -l" in linux (v2.4.20) installed on a powerpc board
  and it listed only 32 signals, SIGRTMIN to SIGRTMAX were missing

Deepak 

On Thu, 05 May 2005 17:35:45 +1000, "Benjamin Herrenschmidt"
<benh@kernel.crashing.org> said:
> On Wed, 2005-05-04 at 14:52 +0900, Deepak wrote:
> > Its regarding realtime signals support in powerpc port of linux. Though
> > Real-Time signals are supported for Intel i386 port no such support is
> > available for powerpc port
> > Anyone having idea about any existing patch for real-time signals in
> > powerpc linux(linux kernel 2.4.20)
> 
> What are you talking about ? All architectures have RT signals afaik...
> 
> Ben.
> 
> 
