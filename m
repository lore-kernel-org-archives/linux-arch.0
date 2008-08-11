From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [RFC 1/3] add support for exporting symbols from .S files
Date: Mon, 11 Aug 2008 15:56:11 +0100
Message-ID: <1218466571.2977.6.camel@pmac.infradead.org>
References: <200808111606.44103.arnd@arndb.de>
	 <200808111618.08206.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754464AbYHKO43@vger.kernel.org>
In-Reply-To: <200808111618.08206.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>, Al Viro <viro@zeniv.linux.org.uk>, Rusty Russell <rusty@rustcorp.com.au>, linuxppc-dev@ozlabs.org
List-Id: linux-arch.vger.kernel.org

On Mon, 2008-08-11 at 16:18 +0200, Arnd Bergmann wrote:
> This makes it possible to export symbols from assembly files, instead
> of having to export them through an extra ksyms.c file.
> 
> I found this nicer to implement using a gas macro than a cpp macro.

Yeah, gas macros can be much nicer. This looks good to me; I don't see
and reason why it can't be used across all architectures, off-hand.

-- 
David Woodhouse                            Open Source Technology Centre
David.Woodhouse@intel.com                              Intel Corporation
