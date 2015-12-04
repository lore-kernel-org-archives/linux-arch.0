Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from www.sr71.net ([198.145.64.142]:47221 "EHLO blackbird.sr71.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750962AbbLDXio (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 4 Dec 2015 18:38:44 -0500
Subject: Re: [PATCH 00/34] x86: Memory Protection Keys (v5)
References: <20151204011424.8A36E365@viggo.jf.intel.com>
 <CALCETrXwVb99hAvqR2o54aPwtpr8oubROtiRt45SiYRfUTAxCw@mail.gmail.com>
From: Dave Hansen <dave@sr71.net>
Message-ID: <56622401.20001@sr71.net>
Date: Fri, 4 Dec 2015 15:38:41 -0800
MIME-Version: 1.0
In-Reply-To: <CALCETrXwVb99hAvqR2o54aPwtpr8oubROtiRt45SiYRfUTAxCw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@amacapital.net>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, X86 ML <x86@kernel.org>, Linux API <linux-api@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Andrea Arcangeli <aarcange@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Message-ID: <20151204233841.H7ZHMSCIYjJUvPswiIr-A-2G2Dv3-DYmlkir2LYNWB0@z>

On 12/04/2015 03:31 PM, Andy Lutomirski wrote:
> On Thu, Dec 3, 2015 at 5:14 PM, Dave Hansen <dave@sr71.net> wrote:
>> Memory Protection Keys for User pages is a CPU feature which will
>> first appear on Skylake Servers, but will also be supported on
>> future non-server parts.  It provides a mechanism for enforcing
>> page-based protections, but without requiring modification of the
>> page tables when an application changes protection domains.  See
>> the Documentation/ patch for more details.
> 
> What, if anything, happened to the signal handling parts?

Patches 12 and 13 contain most of it:

	x86, pkeys: fill in pkey field in siginfo
	signals, pkeys: notify userspace about protection key faults	

I decided to just not try to preserve the pkey_get/set() semantics
across entering and returning from signals, fwiw.

> Also, do you have a git tree for this somewhere?  I can't actually
> enable it (my laptop, while very shiny, is not a Skylake server), but
> I can poke around a bit.

http://git.kernel.org/cgit/linux/kernel/git/daveh/x86-pkeys.git/

Thanks for taking a look!
