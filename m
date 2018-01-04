From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [RFC PATCH] asm/generic: introduce if_nospec and nospec_barrier
Date: Thu, 4 Jan 2018 23:21:10 +0000
Message-ID: <20180104232110.4a18b7b1@alans-desktop>
References: <20180103223827.39601-1-mark.rutland@arm.com>
        <151502463248.33513.5960736946233335087.stgit@dwillia2-desk3.amr.corp.intel.com>
        <CA+55aFzSYExr33w849=3o+2XGr9pUKpFucc5p-kKbEy20VVLPA@mail.gmail.com>
        <20180104010754.22ca6a74@alans-desktop>
        <CAPcyv4ge14OPyfoQvXHLyXwqX7cjWvm4DouUOc=WrNo1Lr9Qyw@mail.gmail.com>
        <alpine.DEB.2.20.1801040728140.2148@hadrien>
        <CAPcyv4gLcC7vsxLUCEJdEvDRf4AhgF0x1fpTEcH7AOe=kuNfoQ@mail.gmail.com>
        <20180104192648.GA10427@amd>
        <CAPcyv4g0ZEP_LuXwsf1rJGaG65UHn5sj=DMyMdCnzKD9T-vnyg@mail.gmail.com>
        <20180104224455.GA22369@amd>
        <CAPcyv4gVq=F-+8YX6ALUiL61MtOVtDzPrEo18WVsFodZ1YY20A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from www.llwyncelyn.cymru ([82.70.14.225]:48046 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751029AbeADXVi (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 4 Jan 2018 18:21:38 -0500
In-Reply-To: <CAPcyv4gVq=F-+8YX6ALUiL61MtOVtDzPrEo18WVsFodZ1YY20A@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>, Julia Lawall <julia.lawall@lip6.fr>, Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Greg KH <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Elena Reshetova <elena.reshetova@intel.com>, Alan Cox <alan@linux.intel.com>, Dan Carpenter <dan.carpenter@oracle.com>

> Right, but how far away from "val = array[attacker_controlled_index];"
> in the instruction stream do you need to look before you're
> comfortable there's no 'val' dependent reads in the speculation window
> on all possible architectures. Until we have variable annotations and
> compiler help my guess is that static analysis has an easier time
> pointing us to the first potentially bad speculative access.

On x86 the researchers are saying up to 180 or so simple instructions.
I've not seen any Intel or AMD official quoted value. It's enough that
you need to peer across functions.

Alan
