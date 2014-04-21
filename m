From: Ley Foon Tan <lftan@altera.com>
Subject: Re: [PATCH 01/28] nios2: Build infrastructure
Date: Mon, 21 Apr 2014 13:02:00 +0800
Message-ID: <1398056520.7753.10.camel@leyfoon-vm>
References: <1397824031-4892-1-git-send-email-lftan@altera.com>
	 <1397824031-4892-2-git-send-email-lftan@altera.com>
	 <1397848572.4750.4.camel@x220>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1397848572.4750.4.camel@x220>
Sender: linux-doc-owner@vger.kernel.org
To: Paul Bolle <pebolle@tiscali.nl>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, lftan.linux@gmail.com, cltang@codesourcery.com
List-Id: linux-arch.vger.kernel.org

On Jum, 2014-04-18 at 21:16 +0200, Paul Bolle wrote:
> On Fri, 2014-04-18 at 20:26 +0800, Ley Foon Tan wrote:
> > diff --git a/arch/nios2/Kconfig b/arch/nios2/Kconfig
> >[...]
> > +config GENERIC_FIND_NEXT_BIT
> > +	def_bool y
> 
> This one is not needed, see commit 63e424c84429 ("arch: remove
> CONFIG_GENERIC_FIND_{NEXT_BIT,BIT_LE,LAST_BIT}").
Okay, will remove this CONFIG.

> 
> > +config NO_IOPORT
> > +	def_bool y
> 
> Did you mean NO_IOPORT_MAP?
Yes, will change it to NO_IOPORT_MAP

Thanks.

Regards
Ley Foon
