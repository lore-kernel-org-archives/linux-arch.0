Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from slow1-d.mail.gandi.net ([217.70.178.86]:42915 "EHLO
	slow1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751202AbcGYOEX (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 25 Jul 2016 10:04:23 -0400
Subject: Re: [RFC v3 00/13] linux: generalize sections, ranges and linker
 tables
References: <1469222687-1600-1-git-send-email-mcgrof@kernel.org>
 <20160725223229.7de71264e9e6ec8d635ee785@kernel.org>
From: Richard Fontana <fontana@sharpeleven.org>
Message-ID: <f0947242-a917-d036-694d-5f01f5e77d01@sharpeleven.org>
Date: Mon, 25 Jul 2016 09:55:32 -0400
MIME-Version: 1.0
In-Reply-To: <20160725223229.7de71264e9e6ec8d635ee785@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>, "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, linux@arm.linux.org.uk, masami.hiramatsu.pt@hitachi.com, jbaron@akamai.com, heiko.carstens@de.ibm.com, ananth@linux.vnet.ibm.com, anil.s.keshavamurthy@intel.com, davem@davemloft.net, realmz6@gmail.com, x86@kernel.org, luto@amacapital.net, keescook@chromium.org, torvalds@linux-foundation.org, gregkh@linuxfoundation.org, rusty@rustcorp.com.au, gnomes@lxorguk.ukuu.org.uk, alan@linux.intel.com, dwmw2@infradead.org, arnd@arndb.de, ming.lei@canonical.com, linux-arch@vger.kernel.org, benh@kernel.crashing.org, ananth@in.ibm.com, pebolle@tiscali.nl, ciaran.farrell@suse.com, christopher.denicolo@suse.com, david.vrabel@citrix.com, konrad.wilk@oracle.com, mcb30@ipxe.org, jgross@suse.com, andrew.cooper3@citrix.com, andriy.shevchenko@linux.intel.com, paul.gortmaker@windriver.com, xen-devel@lists.xensource.com, ak@linux.intel.com, pali.rohar@gmail.com, dvhart@infradead.org, platform-driver-x86@vger.kernel.org, mmarek@suse.com, linux@rasmusvillemoes.dk, jkosina@suse.cz, korea.drzix@gmail.com, linux-kbuild@vger.kernel.org, tony.luck@intel.com, akpm@linux-foundation.org, linux-ia64@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, catalin.marinas@arm.com, will.deacon@arm.com, rostedt@goodmis.org, jpoimboe@redhat.com
Message-ID: <20160725135532.IFiGH9HR0qJapIApGTNQGWPnSQ068lemQJH4XgjVf0Q@z>

On 07/25/2016 09:32 AM, Masami Hiramatsu wrote:

> I'm not a lawyer, so I don't know really it is compatible with GPLv2,
> and if it is, I'm not sure the reason why we need another license.
> AFAICS the license terms, most of parts looks reasonable. I just concern
> clause 8, after fifteen years, is that still GPLv2 compatible?
> (I'd like see FAQ about this license...)

Yes, after fifteen years the restrictions in the license that make it
copyleft rather than permissive disappear, and the license is
transformed into a simple, essentially unconditional, permissive open
source license.

Richard


