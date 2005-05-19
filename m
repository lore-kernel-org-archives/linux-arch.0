Return-Path: <linux-arch-owner@vger.kernel.org>
Message-Id: <1116478834.27371.234472372@webmail.messagingengine.com>
From: "Deepak" <deepakgaur@fastmail.fm>
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="ISO-8859-1"
MIME-Version: 1.0
Subject: Re: Real Time Signals In PowerPC Linux
In-Reply-To: <1115336358.7568.198.camel@gaston>
Date: Thu, 19 May 2005 14:00:34 +0900
References: <1115185972.13333.233322686@webmail.messagingengine.com>
   <1115278545.7628.180.camel@gaston>
   <1115288796.27463.233424874@webmail.messagingengine.com>
   <1115336358.7568.198.camel@gaston>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Yes It was indeed the issue of kill command version. I tried sending
SIGRTMAX to a process using kill() and sigqueue() , both of them worked
though 'kill -l' was still showing 32 signals. 

On Fri, 06 May 2005 09:39:18 +1000, "Benjamin Herrenschmidt"
<benh@kernel.crashing.org> said:
> On Thu, 2005-05-05 at 19:26 +0900, Deepak wrote:
> > hi
> > 
> >   Well I did "kill -l" in linux (v2.4.20) installed on a powerpc board
> >   and it listed only 32 signals, SIGRTMIN to SIGRTMAX were missing
> 
> Well, I don't know what's up with that kernel you are using, it works
> fine here on 2.6.12 but I'm fairly sure it worked with 2.4.20 too. Maybe
> a glibc or a kill version issue ?
> 
> Ben.
> 
> 
