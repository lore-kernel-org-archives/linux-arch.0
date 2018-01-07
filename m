From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 06/18] x86, barrier: stop speculation for failed
 access_ok
Date: Sat, 06 Jan 2018 20:36:54 -0500 (EST)
Message-ID: <20180106.203654.731754766847198456.davem@davemloft.net>
References: <20180106181331.mmrqwwbu2jcjj2si@ast-mbp>
        <20180106183859.1ad9ae37@alans-desktop>
        <20180106204229.GD9075@1wt.eu>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180106204229.GD9075@1wt.eu>
Sender: netdev-owner@vger.kernel.org
To: w@1wt.eu
Cc: gnomes@lxorguk.ukuu.org.uk, alexei.starovoitov@gmail.com, torvalds@linux-foundation.org, dan.j.williams@intel.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, ak@linux.intel.com, arnd@arndb.de, gregkh@linuxfoundation.org, peterz@infradead.org, netdev@vger.kernel.org, mingo@redhat.com, hpa@zytor.com, tglx@linutronix.de
List-Id: linux-arch.vger.kernel.org

From: Willy Tarreau <w@1wt.eu>
Date: Sat, 6 Jan 2018 21:42:29 +0100

> On Sat, Jan 06, 2018 at 06:38:59PM +0000, Alan Cox wrote:
>> Normally people who propose security fixes don't have to argue about the
>> fact they added 30 clocks to avoid your box being 0wned.
> 
> In fact it depends, because if a fix makes the system unusable for its
> initial purpose, this fix will simply not be deployed at all, which is
> the worst that can happen.

+1

I completely agree with Willy and Alexei.

And the scale isn't even accurate, we're talking about at least
hundreds upon hundreds of clocks, not 30, if we add an operation whose
side effect is to wait for all pending loads to complete.  So yeah
this is going to be heavily scrutinized.
