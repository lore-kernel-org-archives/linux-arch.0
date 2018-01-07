From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 06/18] x86, barrier: stop speculation for failed
 access_ok
Date: Sun, 7 Jan 2018 19:24:18 +0000
Message-ID: <20180107192418.0f0b66a8@alans-desktop>
References: <20180106181331.mmrqwwbu2jcjj2si@ast-mbp>
        <20180106183859.1ad9ae37@alans-desktop>
        <20180106204229.GD9075@1wt.eu>
        <20180106.203654.731754766847198456.davem@davemloft.net>
        <1515345560.3075.7.camel@HansenPartnership.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from www.llwyncelyn.cymru ([82.70.14.225]:58550 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754312AbeAGTZT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 7 Jan 2018 14:25:19 -0500
In-Reply-To: <1515345560.3075.7.camel@HansenPartnership.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: David Miller <davem@davemloft.net>, w@1wt.eu, alexei.starovoitov@gmail.com, torvalds@linux-foundation.org, dan.j.williams@intel.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, ak@linux.intel.com, arnd@arndb.de, gregkh@linuxfoundation.org, peterz@infradead.org, netdev@vger.kernel.org, mingo@redhat.com, hpa@zytor.com, tglx@linutronix.de

> everyone.  I'm not saying this always happens, but it is reasonable to
> let the iterative pushback see if we can get to better code in this
> case rather than trying to cut it of with the "because *security*"
> argument.
> 

I'm not arguing otherwise - I'd just prefer most users machines are
secure while we have the discussion and while we see what other
architectural tricks people can come up with

Alan
