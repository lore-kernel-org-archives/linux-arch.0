Return-Path: <linux-arch-owner@vger.kernel.org>
Subject: Re: Real Time Signals In PowerPC Linux
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1115288796.27463.233424874@webmail.messagingengine.com>
References: <1115185972.13333.233322686@webmail.messagingengine.com>
	 <1115278545.7628.180.camel@gaston>
	 <1115288796.27463.233424874@webmail.messagingengine.com>
Content-Type: text/plain
Date: Fri, 06 May 2005 09:39:18 +1000
Message-Id: <1115336358.7568.198.camel@gaston>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: Deepak <deepakgaur@fastmail.fm>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Thu, 2005-05-05 at 19:26 +0900, Deepak wrote:
> hi
> 
>   Well I did "kill -l" in linux (v2.4.20) installed on a powerpc board
>   and it listed only 32 signals, SIGRTMIN to SIGRTMAX were missing

Well, I don't know what's up with that kernel you are using, it works
fine here on 2.6.12 but I'm fairly sure it worked with 2.4.20 too. Maybe
a glibc or a kill version issue ?

Ben.
