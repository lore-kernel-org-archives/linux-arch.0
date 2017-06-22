Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from www.llwyncelyn.cymru ([82.70.14.225]:58250 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751193AbdFVUhO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 22 Jun 2017 16:37:14 -0400
Date: Thu, 22 Jun 2017 21:36:55 +0100
From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 3/7] asm-generic/io.h: make ioread64 and iowrite64
 universally available
Message-ID: <20170622213655.07dffac2@alans-desktop>
In-Reply-To: <e856de0b-e9a3-8228-7a73-4daa38cb4479@deltatee.com>
References: <20170622164817.25515-1-logang@deltatee.com>
        <20170622164817.25515-4-logang@deltatee.com>
        <20170622211431.14270378@alans-desktop>
        <e856de0b-e9a3-8228-7a73-4daa38cb4479@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-ntb@googlegroups.com, linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org, dri-devel@lists.freedesktop.org, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Stephen Bates <sbates@raithlin.com>
Message-ID: <20170622203655.B_JlhMS_8RjWUwIybgydtzCbkSQgZnacGJVN96s5usY@z>

On Thu, 22 Jun 2017 14:24:58 -0600
Logan Gunthorpe <logang@deltatee.com> wrote:

> On 6/22/2017 2:14 PM, Alan Cox wrote:
> > If a platform doesn't support 64bit I/O operations from the CPU then you
> > either need to use some kind of platform/architecture specific interface
> > if present or accept you don't have one.  
> 
> Yes, I understand that.
> 
> The thing is that every user that's currently using it right now is 
> patching in their own version that splits it on non-64bit systems.
> 
> > It's not safe to split it. Possibly for some use cases you could add an
> > ioread64_maysplit()  
> 
> I'm open to doing something like that.

I think that makes sense for the platforms with that problem. I'm not
sure there are many that can't do it for mmio at least. 486SX can't do it
and I guess some ARM32 but I think almost everyone else can including
most 32bit x86.

What's more of a problem is a lot of platforms can do 64bit MMIO via
ioread/write64 but not 64bit port I/O, and it's not clear how you
represent that via an ioread/write API that abstracts it away.

Alan
