Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from www.llwyncelyn.cymru ([82.70.14.225]:47990 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751029AbeADXMQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 4 Jan 2018 18:12:16 -0500
Date: Thu, 4 Jan 2018 23:11:37 +0000
From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [RFC PATCH] asm/generic: introduce if_nospec and nospec_barrier
Message-ID: <20180104231137.0c09a674@alans-desktop>
In-Reply-To: <CA+55aFxNqWQcMQmpbsRhhfb7M8ch30627AkEsswaNk-=MvZo5w@mail.gmail.com>
References: <20180103223827.39601-1-mark.rutland@arm.com>
        <151502463248.33513.5960736946233335087.stgit@dwillia2-desk3.amr.corp.intel.com>
        <CA+55aFzSYExr33w849=3o+2XGr9pUKpFucc5p-kKbEy20VVLPA@mail.gmail.com>
        <20180104010754.22ca6a74@alans-desktop>
        <CAPcyv4ge14OPyfoQvXHLyXwqX7cjWvm4DouUOc=WrNo1Lr9Qyw@mail.gmail.com>
        <alpine.DEB.2.20.1801040728140.2148@hadrien>
        <CAPcyv4gLcC7vsxLUCEJdEvDRf4AhgF0x1fpTEcH7AOe=kuNfoQ@mail.gmail.com>
        <20180104192648.GA10427@amd>
        <CAPcyv4g0ZEP_LuXwsf1rJGaG65UHn5sj=DMyMdCnzKD9T-vnyg@mail.gmail.com>
        <CA+55aFwRh++2cyfi1ZXnWCwGv=kuSjft-RcSCDW89T5g=0RB2Q@mail.gmail.com>
        <20180104225515.13a40f0f@alans-desktop>
        <CA+55aFxNqWQcMQmpbsRhhfb7M8ch30627AkEsswaNk-=MvZo5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dan Williams <dan.j.williams@intel.com>, Pavel Machek <pavel@ucw.cz>, Julia Lawall <julia.lawall@lip6.fr>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Greg KH <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Elena Reshetova <elena.reshetova@intel.com>, Alan Cox <alan@linux.intel.com>, Dan Carpenter <dan.carpenter@oracle.com>
Message-ID: <20180104231137.fBH1S_bK_yunYQnmFO5C7p4Rl_sy9Abey2RcUfyySpE@z>

> It's also possible that x86 'lfence' really is so fast that it doesn't
> make sense to try to do this.

If you've got a lot going on it's not 1 cycle.

Alan
